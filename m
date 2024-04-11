Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35795CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rur3I-0006mU-O3; Thu, 11 Apr 2024 05:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3G-0006m4-Sh
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3E-000386-H5
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712828939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8b5kGLksPzZ5zp872Mk9p0VK84K7bFa5FygfV1RWVdM=;
 b=QRjDYhEPcoccERvHsvIjmOvr+htRBaTuG4Bp+Ke9Zv8jC+TpjvgvoFSOEZCYNKz3B6d6I+
 hDrxjCl99/LZf7VRAdD98ovIjUYPL/cPxJ5M0P8KqrQH14m+H2PeF0Pf1FW/8GLKwQ4YpC
 d8eAWmN1z4X2llZLmqDrdRtptka7kio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-WU8KJP4CMbeJCD1WQ3emYQ-1; Thu, 11 Apr 2024 05:48:55 -0400
X-MC-Unique: WU8KJP4CMbeJCD1WQ3emYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 853681808EF6;
 Thu, 11 Apr 2024 09:48:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A44E492BC6;
 Thu, 11 Apr 2024 09:48:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7BBDB18009DB; Thu, 11 Apr 2024 11:48:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/5] x86/loader: expose unpatched kernel
Date: Thu, 11 Apr 2024 11:48:28 +0200
Message-ID: <20240411094830.1337658-5-kraxel@redhat.com>
In-Reply-To: <20240411094830.1337658-1-kraxel@redhat.com>
References: <20240411094830.1337658-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
the setup header patches.  Intended use is booting in UEFI with secure
boot enabled, where the setup header patching breaks secure boot
verification.

Needs OVMF changes too to be actually useful.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6f75948b3021..6724e408e576 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1125,6 +1125,9 @@ void x86_load_linux(X86MachineState *x86ms,
     sev_load_ctx.setup_data = (char *)setup;
     sev_load_ctx.setup_size = setup_size;
 
+    /* kernel without setup header patches */
+    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
+
     if (sev_enabled()) {
         sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
     }
-- 
2.44.0


