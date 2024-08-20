Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8AC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPt3-0002k1-EY; Tue, 20 Aug 2024 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsB-0001ww-5c; Tue, 20 Aug 2024 10:30:20 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs6-0001qC-8r; Tue, 20 Aug 2024 10:30:09 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-533461323cdso283494e87.2; 
 Tue, 20 Aug 2024 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164204; x=1724769004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0gf4AWHulAzAV2HaIyUy+fKTdCex9KA7D9+c05rick=;
 b=M7WowS3MnVBCfM6v6IWDdvCIIr6XyCSdy2O0oRGkh8tzqHwFkWNQVm0dJbCV0eo4HD
 SavMRGtguiNw/vL6HrepICG9UHj0fMcMr0lDX6/hoekc0pxtefigfikGobbjWvpai7jd
 fWhXnZ+mDH36Tw9drha2Z8amSvU3dwuTThPGzdG65Jl1q0cEVv78UBFSzDHKzAHHaFDQ
 +akjsZUSgEzD0N7HpUA4zFDtqo3Jae+hLA16cvkg/5Xjk2/mG4Ktya92kkIVEVUK5oAO
 vi8YAhtF9nDnLUq+7im0epqbmas8qGmTzdBt1aMcFpxOurQqPGbGyjSbYYXHL8/kDhsx
 qj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164204; x=1724769004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0gf4AWHulAzAV2HaIyUy+fKTdCex9KA7D9+c05rick=;
 b=VTk8jJiYmD5p2LvVsOkDeBZuuyn5ENINsptrJ1872pTC3EsCbxYoC6l+H8W43ywCUi
 3EyzaM7K2j5P47Hm1uS+1TWqa3Tr2Cey1IjCnuFk2d6jiWGsV/3ggUW1zsNBZ2jP8Vzm
 ljl671m/hxKG6mJS2/i78jq7ELTmQ+tsjwXE+zvk8qS3kKDt6aFHkMBpGMgziP8vx3Mq
 WvHC1wEps4DxKUY5CuupfmEf5wiwfHi3cxeHaw5RTw0wuCVZTbvAcxB0L6v9fcCOJXNc
 mbjYU0n1Xiv6shiLT21CKT4swBECmD1mcz1zo9qUp5ywV03qlqnKl8P8OwYZbRW8Oije
 qHvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQVLj8CW3Bdu9SIXosXURImAoJfLV2/QlaBOnW4p5FB8HH6Hlk/rlgvqNzweYcvxjT+YNJUchenw==@nongnu.org
X-Gm-Message-State: AOJu0Ywo73DRF2hEG+x6y8DS5b4f8xjmcFQ8hN4DAWZJWvRTx5NlMuQe
 IapgrIyQ0w5UripK3FDxj31iS5aZj0obc72bz6pj4ocRS9nAUnrVLewKIv2O
X-Google-Smtp-Source: AGHT+IES1gNwxhhoBVLe4AixtVypdxMBk0O0dKwZ1tDvA9tVYLXBSnaAgHk6+BIt+ttxuzPWUzelPw==
X-Received: by 2002:a05:6512:2c98:b0:533:4191:fa47 with SMTP id
 2adb3069b0e04-5334191fc44mr1624238e87.47.1724164203068; 
 Tue, 20 Aug 2024 07:30:03 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d424725sm1790433e87.249.2024.08.20.07.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 06/12] hw/arm: xenpvh: Move stubbed functions to xen-stubs.c
Date: Tue, 20 Aug 2024 16:29:43 +0200
Message-ID: <20240820142949.533381-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/meson.build |  5 ++++-
 hw/arm/xen-stubs.c | 32 ++++++++++++++++++++++++++++++++
 hw/arm/xen_arm.c   | 20 --------------------
 3 files changed, 36 insertions(+), 21 deletions(-)
 create mode 100644 hw/arm/xen-stubs.c

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0c07ab522f..074612b40c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,7 +59,10 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_XEN', if_true: files(
+  'xen-stubs.c',
+  'xen_arm.c',
+))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
new file mode 100644
index 0000000000..4ac6a56a96
--- /dev/null
+++ b/hw/arm/xen-stubs.c
@@ -0,0 +1,32 @@
+/*
+ * Stubs for unimplemented Xen functions for ARM.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/qapi-commands-migration.h"
+#include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "hw/xen/xen-hvm-common.h"
+#include "hw/xen/arch_hvm.h"
+
+void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
+{
+    hw_error("Invalid ioreq type 0x%x\n", req->type);
+    return;
+}
+
+void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
+                         bool add)
+{
+}
+
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+}
+
+void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
+{
+}
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 16b3f00992..f0868e7be5 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -115,26 +115,6 @@ static void xen_init_ram(MachineState *machine)
     memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-{
-    hw_error("Invalid ioreq type 0x%x\n", req->type);
-
-    return;
-}
-
-void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
-                         bool add)
-{
-}
-
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-}
-
-void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
-{
-}
-
 #ifdef CONFIG_TPM
 static void xen_enable_tpm(XenArmState *xam)
 {
-- 
2.43.0


