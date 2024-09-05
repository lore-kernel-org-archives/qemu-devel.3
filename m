Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5144CD5BC7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 14:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDE1-0001Yg-Qm; Thu, 05 Sep 2024 10:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1smDDz-0001TY-Pc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1smDDy-0007eP-9E
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725545557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtgoVbdYBgYFXpCyU3VNs2GY7VUCeJ9Aryx8/Wd/8dQ=;
 b=R3FjhL6xFaaR+jDiQVkaqwzf6PtxsB5qygWlW76xf84jLA1pnV7ph/kC3TsBpCITHlgXmQ
 6eueJCMcoS+4QpzdBauySMg+jy0BsBF2/58ncVWRQ91CHM8lxNU5F7PEtV50oLDL7yNIKd
 1kgI2jLDxrbeIdkNhbQ7dtieMHV/w3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-3e2exMygNzmUVGapDRbwdw-1; Thu,
 05 Sep 2024 10:12:36 -0400
X-MC-Unique: 3e2exMygNzmUVGapDRbwdw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F5ED1893D3D; Thu,  5 Sep 2024 14:12:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 464B8300023D; Thu,  5 Sep 2024 14:12:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7AD091801023; Thu,  5 Sep 2024 16:12:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/5] x86/loader: read complete kernel
Date: Thu,  5 Sep 2024 16:12:08 +0200
Message-ID: <20240905141211.1253307-4-kraxel@redhat.com>
In-Reply-To: <20240905141211.1253307-1-kraxel@redhat.com>
References: <20240905141211.1253307-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 hw/i386/x86-common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b52903c47fec..82137e053ae0 100644
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
2.46.0


