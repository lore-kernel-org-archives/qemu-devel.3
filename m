Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64EBC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USd-0004j5-Ga; Thu, 03 Apr 2025 19:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USb-0004hL-LF
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USZ-0002Um-RO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so1230499f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724738; x=1744329538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbGR6HcarXZRF0Z/seWcmwBS3azqrrXZgIvCxgRC+K8=;
 b=ulhtnlz5B+hUUHUvKkFZYMIMGunjXE5R1bd7V69YEKgw+H0yCrl48XvEzM7sas0vjc
 CCvhi6AtY6hSnblRWMpOTeShEzylGrvioQoxL8CSBIUPjOXUewsfNIvl0rQ9ZEyZ7w2O
 vS6IsUuhsKiWjUS68nktC3bPRMDPlkUAbnM34DXcQcZ0nBB+eX5iF5nCeI2z4XSaLhCr
 bj5ah+iuXtgAvDlX8qsVpRbPvrod3tx2v8yQJirZ6FxtoxGuEicYr6YkEfU17fO2nNkc
 Q5Gy9p6n5yDYutkW51bG5EL3I2fOlAhaLgvOfTV9KpzSgzD5g1OSkD4jKnmgGD8YPMEO
 BTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724738; x=1744329538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbGR6HcarXZRF0Z/seWcmwBS3azqrrXZgIvCxgRC+K8=;
 b=Zil7Q9fP8a6+s+TlygBSJczVd537SjciS4cJGHZzveW1KAn8kPmi57maHaNQve7jD6
 1lKwhaeNLlWbsgLLkmzoAKQpl3gC/zcYmOU010G4WQ5neV0AH9qpowOp6TuGNl4UXhwQ
 oLUQf45UkAkkVrlF5R0iCjmwizA3p6I5e5JFtns2TH4hE8T0+RIjJxGrOv5o6t/rM3Jw
 KtymKJzT54juVEhyfSgU3bAGox8QeFCtEXt5XUXcY2gySpibVM+cfATPIUqDjcZX9ksN
 26nYQxsLpBn8Hw8hJQPXLJk9z0wkr1CGjXSNCw1pEdkaGsyT/IaC9dAxrZ8Zx0b0Z2BW
 +TaA==
X-Gm-Message-State: AOJu0YwSfA+g8+KMio5FWH4o6TAmCkBCRrcgmp8q92ngUY901n24JOB6
 EdnrAYzYfa9mPMpR7q2w9ywITBxXM5RCE7L+uHJcsc3Mrcs4pDSvXkLeh+ecrPhauB95MRWPPyl
 a
X-Gm-Gg: ASbGncuGXf42QIC3P12rmZGs/5xE0TFodD3xuKNOfro9VDJVGTol2m+mxyGSjwVEKS3
 xamg2hLh7HkiMrRzddprrZ4obFX3heJyIuKmVXSG46lEBlEVdUWou47Q6iqi5cD01oJP8SsKeWY
 th1H6me0BDGvrir732tGtHK75e7sCQWFYc8RdHtCCYm+JtpMinoG1usq0QfMi8yWAcW0PDK6DJI
 vLRsCnSQEgEAuh9Jyq1rYyOfbsFuA6I2jyyyrhLgmm0OMMLGzfnyc2HfsQEcf5yRKWqXTjsqyS+
 skk2rOnTr7W68T+u7K+iMqOZnke16Ef676A/Rjw8RaFEeOJdmq58LP1rN1PcFu9cPklSZ71doMK
 EhaggOqOD0NUgTZJXBjo=
X-Google-Smtp-Source: AGHT+IFL45YPDGoMNvraZBwQTgptHO1WOGmB2si4AjCL21K1t862Wxp9ToUiQ2nBLW7aKP1g2JM4jA==
X-Received: by 2002:a05:6000:1a87:b0:398:fd9b:b935 with SMTP id
 ffacd0b85a97d-39d1475794amr493496f8f.53.1743724737999; 
 Thu, 03 Apr 2025 16:58:57 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226bbfsm3029928f8f.90.2025.04.03.16.58.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 05/39] hw/arm/aspeed: Filter machine types for
 binary
Date: Fri,  4 Apr 2025 01:57:47 +0200
Message-ID: <20250403235821.9909-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 82f42582fa3..245f961a868 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -179,13 +179,11 @@ struct AspeedMachineState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
-#ifdef TARGET_AARCH64
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
 #define AST2700_EVB_HW_STRAP1 0x00000800
 /* SCUIO HW Strap1 */
 #define AST2700_EVB_HW_STRAP2 0x00000700
-#endif
 
 /* Rainier hardware value: (QEMU prototype) */
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
@@ -1663,7 +1661,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1713,7 +1710,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
-#endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      void *data)
@@ -1760,92 +1756,112 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fp5280g2_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-#ifdef TARGET_AARCH64
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        }, {
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
+    }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-#endif
+        .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.47.1


