Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B075C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pXq-00030u-NR; Fri, 18 Apr 2025 13:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXK-0002Yp-Sb
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXI-0008Me-PX
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso1239558f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997392; x=1745602192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPk7GJ/Q7Awhqe4M7LOu5PgmoZQozcGdMhSTLUXghio=;
 b=FQEKWm2/i4jFmH6dCRbosGSZ/9gJr7+77epChlljo+9qO2DuXub71HSsfurYOcy9qW
 gzb7jTbaUQN5uW4PHCzI7pMacsUFVplV/NCcVMp6mMi/Z56NpHoGYpw8W/tUIi4gBLUt
 8+GjtwpMVrVdO54WK//MqGilLsNdaW7JdO2u+sccKiRWk9qKeGzfbE1iTVzuUAmi+vFL
 /pQij2ovUEEKR1JB6GEMiTlUnk8uNKIpGfJEcUpKEng6mrTmTv85Upm2TWP0YixCYZI0
 iA5jzhNgDElD8GOe2Y5RFcn8lwpUnZD8KB5j2nnQFRG3kwbAWI89y4AC6uOWZgEiRy7I
 YDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997392; x=1745602192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPk7GJ/Q7Awhqe4M7LOu5PgmoZQozcGdMhSTLUXghio=;
 b=Hw8/6KM6PaUdT9yVzvBUMFUY56+tEYQ359FKbeoiW9PJK1BrZvjXFw2yWDQFfV706m
 raggJK8CE0TtUAJnYdVC0r9gXZaTbkTMP4J4CmLTMSkUjvG2RtELaCSQ5KT5Z4r4oM4M
 sHnS4zEoxO0bQneKJkfpMpXRdRwyA/9JG2tg5691zKnSGUj+pto2WvgES8M+yKhoIuFn
 fI+qvTvHAZE+3Vk09CwGP6KlO+waSxVA5vNGSThSeUtXYDynm1fbk5QZmt0RBkZR2+A+
 Ee7Mqj1TUkcsInsdy4G9vncgUWeu4TFvgeFtNjD+pcxaMvAFtpmXneMFY7aToeUQLXYr
 bNSg==
X-Gm-Message-State: AOJu0YwJK1q1pKxpD+wtVCzxZXoAdK2TFwQHy2lUNpq4WtEBEG5O+0Qe
 /VWuj7DDyzrKoYmQixbh+su/xGeqOOh3lMOoCjBApLKA03JYF/BRJoK3ulI7TEMP0mebguHl6cO
 U
X-Gm-Gg: ASbGncsWV1O1v+JAXiBwbnrGGYgFlXfJFNRYGYT/wW8V9SiQ8WtauTbS9zD5ykEtJx+
 WPcwGDpRat3PAV8mxRiA5hjzmgfZ+NaTwN3CaMK6UEw6ao4ZtQ9ISXR1zzX5/QmDosmXWm+974i
 Z51kWdqe/Dricjp5DfkrBOFuRZQ3NIb/OQoxQBqJ13hMw63WzbY+/+IEnM5eXCm78SpmmqcWA3o
 s3dJYWnVsb5iohiXLfsXKCBX+Q3p5J/PPk+zvqYVh1svVx57fkjyiX3AHYYYwecAdGuRxggHZSv
 O4ypZkxD+atz4E7UznHSdaZBDufiyL5BRAr5JBBrcWnFvH1HQvlIoRRAavAE/sO6NQRpj3kLNg9
 kkNqOPx+IEBMvGuhJhrxZ3EL72w==
X-Google-Smtp-Source: AGHT+IEnz2ix5T5HpC4Uk7cqc2VvbwsTi7enOyyT/yujf4gXnBz8Q0zgdCjz1CcglYh9dUSBvvU3UQ==
X-Received: by 2002:a05:6000:1887:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39efba5eae1mr2679309f8f.27.1744997392062; 
 Fri, 18 Apr 2025 10:29:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e034csm29164575e9.39.2025.04.18.10.29.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 09/14] hw/arm/aspeed: Build objects once
Date: Fri, 18 Apr 2025 19:29:03 +0200
Message-ID: <20250418172908.25147-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
 hw/arm/aspeed.c    | 6 ------
 hw/arm/meson.build | 4 ++--
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ce4d49a9f59..6de61505a09 100644
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
@@ -1664,7 +1662,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1714,7 +1711,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
-#endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      void *data)
@@ -1937,7 +1933,6 @@ static const TypeInfo aspeed_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
-#ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
@@ -1954,7 +1949,6 @@ static const TypeInfo aspeed_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
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


