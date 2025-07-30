Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C14C87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7gS-0007MC-V4; Wed, 30 Jul 2025 10:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh663-0005ce-G3
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh660-0006tb-5K
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753879186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Y2ZCOhZ6YDQ0sgMGEW3nvxIQlwrgOR5ACfG/ksuE6E=;
 b=Ty7ACKsbcUQibbgiqDyzs7i6XsTKCKa2hwtS3VH3OdcntDGNXMebZelNo/5Z1iOJHNTj/I
 cRHDzHCajmBVd7faQ1zJ4Irb/YImsxvEHH4A8i8ZFoven1nzHr+R6iftYBsh5V20JQsrMA
 Qrn2DtT1RAV7UtgqhpNFp0L+QZ8eN3A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-24L8v2TbMMCZqtIdqbSKKg-1; Wed,
 30 Jul 2025 08:39:43 -0400
X-MC-Unique: 24L8v2TbMMCZqtIdqbSKKg-1
X-Mimecast-MFC-AGG-ID: 24L8v2TbMMCZqtIdqbSKKg_1753879182
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25908180045B; Wed, 30 Jul 2025 12:39:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E4B630001B1; Wed, 30 Jul 2025 12:39:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 1/6] memory: reintroduce BQL-free fine-grained PIO/MMIO
Date: Wed, 30 Jul 2025 14:39:29 +0200
Message-ID: <20250730123934.1787379-2-imammedo@redhat.com>
In-Reply-To: <20250730123934.1787379-1-imammedo@redhat.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch brings back Jan's idea [1] of BQL-free IO access

This will let us make access to ACPI PM/HPET timers cheaper,
and prevent BQL contention in case of workload that heavily
uses the timers with a lot of vCPUs.

1) 196ea13104f (memory: Add global-locking property to memory regions)
   ... de7ea885c539 (kvm: Switch to unlocked MMIO)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/system/memory.h | 10 ++++++++++
 system/memory.c         |  6 ++++++
 system/physmem.c        |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed126..d04366c994 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -833,6 +833,7 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
+    bool lockless_io;
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
@@ -2341,6 +2342,15 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
+/**
+ * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
+ *
+ * Enable BQL-free access for devices with fine-grained locking.
+ *
+ * @mr: the memory region to be updated.
+ */
+void memory_region_enable_lockless_io(MemoryRegion *mr);
+
 /**
  * memory_region_add_eventfd: Request an eventfd to be triggered when a word
  *                            is written to a location.
diff --git a/system/memory.c b/system/memory.c
index 5646547940..9a5a262112 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2546,6 +2546,12 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
+void memory_region_enable_lockless_io(MemoryRegion *mr)
+{
+    mr->lockless_io = true;
+    mr->disable_reentrancy_guard = true;
+}
+
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
diff --git a/system/physmem.c b/system/physmem.c
index 130c148ffb..107871e2b3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2909,7 +2909,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
 {
     bool release_lock = false;
 
-    if (!bql_locked()) {
+    if (!bql_locked() && !mr->lockless_io) {
         bql_lock();
         release_lock = true;
     }
-- 
2.47.1


