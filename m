Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE8CD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsgC-0002n3-B7; Wed, 04 Sep 2024 12:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfp-0001KE-MA; Wed, 04 Sep 2024 12:16:02 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfh-0002HI-Ac; Wed, 04 Sep 2024 12:15:56 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f43de7ad5eso84654511fa.1; 
 Wed, 04 Sep 2024 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466550; x=1726071350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je23wvBBopidSll9UpAaH5rZwvVBAj7ARc0Pm2/k3kk=;
 b=EaSZCcob7qJt9qOgcLnSE7h7yhWjnHcF8Jq2AyaqIVRNxQIGSBkNi36U0N45oKyIb0
 0bN6+GNKdL6K+10Ax8tbmyPoI53mBaUKUQ5eQW0S+3ewYF9NOKNAdsfdDNQgWcq0i57d
 uH6cuP50laH6kyELlEDOyuiYB0ESAQlIPmT0y3M7dFCGpcqZrZWsV4bVNbIP0T5yXUq7
 VNp0fNKcaXAmMUtNUDy7IOM09Jh9YNDFxPzCLBVieBEIxkTjzzgCj8l5YS+2WbpZzl/D
 9/HPi7+ocm1COP9i+0Dqt4xYZ6/S9IsbpzSeeE4keaX8ZWT/3XkmOMXo4sBIMDpqfz15
 fFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466550; x=1726071350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Je23wvBBopidSll9UpAaH5rZwvVBAj7ARc0Pm2/k3kk=;
 b=J6b5Wyi18pNqHcVp7t2kKpTnRQP4KhrJaSWzbHNvIAL8nuXJDuGNtI1c9KdY6f4jyD
 EfDX154U9Trr9uk1PymD0Kib19iIdRPkKLosBGELhFPPkP/hfUHWaSavEPNKuTyXZvyy
 6kD4xs1dzhrrA2gfrMv+Ji3RQqjb7wL4Ysh/Q3PwrCtSkpdrHbW7bqdR3DK9cVk5fStp
 EnB/8o8/BdtmSQ8I1sQ4Z6UwqUmYQnus2DmT4tg2lPe3GGT4inIagcKQ3tqSIfET//Zy
 xU3wy5CbGk+AgwmjtGB47PT/Ul583Uf5ydB16oWbq+uDesKsSKacke4E1qB77uW73Z6g
 jgbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxOubxW//VAN9QJFCf78QipKiXZnIFm7LYHWyFBq7+meRQ0RUpiKbxeRhjZ0t/JtAXQEcBvWKv4w==@nongnu.org
X-Gm-Message-State: AOJu0YxNC04sc2+/kGF/jPIf3n/FuNZ24ZUu2fdZhTlH8FCIwWgybsnr
 JhojKNAYqj4M0IzS0lFtTfP9ljQjCImEPGsJz+cehKuKXsawp7IV66kyAJgl
X-Google-Smtp-Source: AGHT+IFDpz1IZD0Qtgo2lbwg04ZmmoJdx9qSrR477CRxTjdjnUIVorw3NCNELME4Ae86vdZ9W6Lr1A==
X-Received: by 2002:a05:6512:3da9:b0:530:ae4a:58d0 with SMTP id
 2adb3069b0e04-53546af3605mr12601930e87.8.1725466549784; 
 Wed, 04 Sep 2024 09:15:49 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-535407ac380sm2378135e87.83.2024.09.04.09.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 06/12] hw/arm: xenpvh: Move stubbed functions to xen-stubs.c
Date: Wed,  4 Sep 2024 18:15:30 +0200
Message-ID: <20240904161537.664189-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x233.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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


