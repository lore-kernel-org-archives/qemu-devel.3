Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C840C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnb-00073Q-TE; Tue, 23 Apr 2024 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnK-0005EF-5s
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnI-0000Lc-Ii
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGxoc9UBlEX5vxrnNvzneNQA59yDpCbjGcbofiTijjc=;
 b=VHoeh1q+qGKtVymnyL1HUffN2Y9AZz7XGvb5aHRxQYQo6s0HkwTBNE+FrfQSZ0REkhnnGu
 /E4ZTol24FBjs728I6O47YxyYaddOG4ojnLwUETaaXGZKuvMrwqXxcDUpzJh856Pc8jx0j
 FjM8peOylp1wCRlY3s/98RYwuQW/uBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-x9sx4szIP0mVhqEkvNtXBg-1; Tue,
 23 Apr 2024 11:10:50 -0400
X-MC-Unique: x9sx4szIP0mVhqEkvNtXBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB0F53C3D0CD;
 Tue, 23 Apr 2024 15:10:49 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07D762026D0A;
 Tue, 23 Apr 2024 15:10:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 57/63] kvm/tdx: Ignore memory conversion to shared of
 unassigned region
Date: Tue, 23 Apr 2024 17:09:45 +0200
Message-ID: <20240423150951.41600-58-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX requires vMMIO region to be shared.  For KVM, MMIO region is the region
which kvm memslot isn't assigned to (except in-kernel emulation).
qemu has the memory region for vMMIO at each device level.

While OVMF issues MapGPA(to-shared) conservatively on 32bit PCI MMIO
region, qemu doesn't find corresponding vMMIO region because it's before
PCI device allocation and memory_region_find() finds the device region, not
PCI bus region.  It's safe to ignore MapGPA(to-shared) because when guest
accesses those region they use GPA with shared bit set for vMMIO.  Ignore
memory conversion request of non-assigned region to shared and return
success.  Otherwise OVMF is confused and panics there.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240229063726.610065-35-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0911154bf8e..d7281b93f3b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2923,6 +2923,18 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     section = memory_region_find(get_system_memory(), start, size);
     mr = section.mr;
     if (!mr) {
+        /*
+         * Ignore converting non-assigned region to shared.
+         *
+         * TDX requires vMMIO region to be shared to inject #VE to guest.
+         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO region,
+         * and vIO-APIC 0xFEC00000 4K page.
+         * OVMF assigns 32bit PCI MMIO region to
+         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
+         */
+        if (!to_private) {
+            return 0;
+        }
         return -1;
     }
 
-- 
2.44.0



