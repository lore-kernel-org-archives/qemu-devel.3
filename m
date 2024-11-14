Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9345DD65C6C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXbB-0001st-Ft; Thu, 14 Nov 2024 06:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXbA-0001sJ-4B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXb8-0006ur-MT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEnuSJJwnSYvq13EUwUUzChCx6Rs/tEt/YqloQWCWkE=;
 b=QNT13d11myWOpVYz2yMvKAsGr2SHNhicHbqHYieZXXP0SLcCZJNJd/cI9H62JmqTINnHvl
 tvtdsjAtclA8zrpkWE7wUlKc7iMsVf1aiUh6bsO/5U54PkgBpuoV4LVQ+gWJA87VBmUALL
 Pg1iT5eZTsESNcBUgG6BpXUaBZzOShA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-AILLszaENLWaMdgd0i15vQ-1; Thu,
 14 Nov 2024 06:01:09 -0500
X-MC-Unique: AILLszaENLWaMdgd0i15vQ-1
X-Mimecast-MFC-AGG-ID: AILLszaENLWaMdgd0i15vQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE7181955F35; Thu, 14 Nov 2024 11:01:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A3861956054; Thu, 14 Nov 2024 11:01:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C11D318009B5; Thu, 14 Nov 2024 12:01:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 3/5] x86/loader: read complete kernel
Date: Thu, 14 Nov 2024 12:00:59 +0100
Message-ID: <20241114110101.44322-4-kraxel@redhat.com>
In-Reply-To: <20241114110101.44322-1-kraxel@redhat.com>
References: <20241114110101.44322-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Load the complete kernel (including setup) into memory.  Excluding the
setup is handled later when adding the FW_CFG_KERNEL_SIZE and
FW_CFG_KERNEL_DATA entries.

This is a preparation for the next patch which adds a new fw_cfg file
containing the complete, unpatched kernel.  No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240905141211.1253307-4-kraxel@redhat.com>
---
 hw/i386/x86-common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index ee047308331a..d99bef983e37 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -893,7 +893,6 @@ void x86_load_linux(X86MachineState *x86ms,
         fprintf(stderr, "qemu: invalid kernel header\n");
         exit(1);
     }
-    kernel_size -= setup_size;
 
     setup  = g_malloc(setup_size);
     kernel = g_malloc(kernel_size);
@@ -902,6 +901,7 @@ void x86_load_linux(X86MachineState *x86ms,
         fprintf(stderr, "fread() failed\n");
         exit(1);
     }
+    fseek(f, 0, SEEK_SET);
     if (fread(kernel, 1, kernel_size, f) != kernel_size) {
         fprintf(stderr, "fread() failed\n");
         exit(1);
@@ -948,10 +948,11 @@ void x86_load_linux(X86MachineState *x86ms,
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
-    sev_load_ctx.kernel_data = (char *)kernel;
-    sev_load_ctx.kernel_size = kernel_size;
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size - setup_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA,
+                     kernel + setup_size, kernel_size - setup_size);
+    sev_load_ctx.kernel_data = (char *)kernel + setup_size;
+    sev_load_ctx.kernel_size = kernel_size - setup_size;
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
     fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
-- 
2.47.0


