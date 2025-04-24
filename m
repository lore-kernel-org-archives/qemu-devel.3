Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E207C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xX-0004sX-QW; Thu, 24 Apr 2025 18:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xV-0004k3-R5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xT-00010U-Vz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so10705375e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533333; x=1746138133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBgCa6Sdg3OuqGwUu8T27tbAQFisBNWEy54fnvDVB+g=;
 b=qAt46Ltd5wYPGiK8kgB/2CWJCM7W4W2eChmK8OoSp/u4+vK7XLlR/m2pOxwg1xOCQ9
 NmYqp7ADCVqkyyXbRefSiakImpvtLVo3trhODwKp1haL9tRTXau2Z5F62WRLlwqze/d3
 IcpXGcZXRV4mnHfla8sHVivEjYca7PhaYenwQXH5MS/JY0+V1P83kB2flLvMFDXl9kdn
 zFfhLYenELI30oo0vIHD3I1cz794FZJKHWoNIYyOwohOkeK35S4kiinWnx/UZvj011gD
 yEzwN0n2g8feQixSjfzF6Z7YjHeav1yd4uYjke+tjysJ1wMDkZYj1dOWvYySgjRBL2lI
 0u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533333; x=1746138133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBgCa6Sdg3OuqGwUu8T27tbAQFisBNWEy54fnvDVB+g=;
 b=t3WUYmbUrjTA+j0moBOkokFEyixgR0EFVIt1P+KCFPpr8gwYRFr8YoLQZpHY0rShf7
 024CdEOX4YQ1fJAnnWPk6VKUeSR0J6N79iWKvLy5e+ioVFn8y7U29EWWcbwmaT4sCEBS
 h2Y/qjr5fMKR6Nmb6ktuu4l0Y0ra+0L9zAdNjOFbRmo5cz2xpWm4fkHSB6g6avHbpBlB
 zfQyNawcSpkuBqy/BiEofZwecIu4hgmr0O9xwq3N/5zcw/Ca68Ew5sxuqHtLLgeq9VuO
 PANPEYHxuW14YIroFjZ4bxtO5njxSvTT2Xmn6+UC8NDHEI4RTTIEsqT7A35grMtS/gFp
 njkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA/H1JZfEbUw8/JsdonhbOahC/ar3hMbrr2etiUnYtKiCeWYiUCmg+i55/Pt7EYvhGoQVtZFTlbWCj@nongnu.org
X-Gm-Message-State: AOJu0Yz72YlMu+/Zq27vIfndIpn7b/PBnGngmDIhPtix/7GgTFf+U+ha
 21cpJhJyad25OVXmZPQmtsvxJguCHRHOUsaAi1nev2c54PNnQJaOJ0gSJbP7QprxCmxsRXgVKne
 6
X-Gm-Gg: ASbGnctHJLAGRssugo+lp2rU4IkgaMj3oCz+dbKocu+GPMpOPYG5qiyYnN5P1wm2oSl
 iABtwjlM0x6EDp59BkEL/SRKg12vMbEJ1PVijx8gLJh3csOOscWLjsSiL8wE5j5WoO3ekxObGse
 AjhdH8QfvHxK6cB0TidBvwaYXURgz3jcQzSb0iMgmOzuyla3d7yUtUvizELqESQsbg4UM3jE4lB
 4R3dM4p3TAEcc7nTwPRlcalh7ANDIzt3X3ZXYG1C/T6s84DwzO+YWc+2Ti/x726dodVCM9bNlkS
 1lioVgz/yZdVgQJ4miQ615X7+hJY7EbsHwu+p+QneoyKbr10NPM2/o+eYNhUE5+7cInT13zLpCj
 gJvIY1u1Vi2iz+1g=
X-Google-Smtp-Source: AGHT+IGq2zZAfVrT2tiQeDNEqhH6uUKntAlEB26z8Ax3zoz/R3xxQMvCnGN49DYgozjbDzMuKOP6iw==
X-Received: by 2002:a05:600c:91a:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-4409c4938ebmr30460355e9.9.1745533333026; 
 Thu, 24 Apr 2025 15:22:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53874a9sm3029345e9.34.2025.04.24.15.22.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 12/21] hw/arm/aspeed: Build objects once
Date: Fri, 25 Apr 2025 00:21:03 +0200
Message-ID: <20250424222112.36194-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
remove the TARGET_AARCH64 #ifdef'ry and compile the
aspeed.c file once, moving it from arm_ss[] source set
to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/aspeed.c    | 6 ------
 hw/arm/meson.build | 4 ++--
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 06a49343d4a..0a5b603bc97 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -180,13 +180,11 @@ struct AspeedMachineState {
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
@@ -1675,7 +1673,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1727,7 +1724,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
-#endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      const void *data)
@@ -1870,7 +1866,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
         .interfaces     = arm_aarch64_machine_interfaces,
-#ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
@@ -1881,7 +1876,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
         .interfaces    = aarch64_machine_interfaces,
-#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 09b1cfe5b57..f76e7fb229f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,15 +39,15 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
+  'aspeed_ast27x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.47.1


