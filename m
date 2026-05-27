Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A199DCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYb-0004jL-Sk; Wed, 27 May 2026 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYZ-0004WQ-FB
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYX-0000yg-CH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5925960f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877928; x=1780482728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uz68UNFgHkIaQwTnrD8tL+17ttgq41ToDfNqGD1o+U0=;
 b=FA0/0q2or1EQOrAjC62w5pmjrC3iugQJNCuixvbCDWRT7aupFRNFb7gpwWY+Jz4QKG
 G/95+HHAZNFWvzMKSTF35S0VwKFVqbVXaelamHBydLlTc1j19px/X1xN/jAw1l1wdWUd
 gK3RDJuG7DoaFm9vBaSLR8duwlB7eC9tuWkTwNdIQESIDLUdYVVBg/bXBCGDf/J+8TXN
 SwrFlZDrw2rZrm69xs5ol2m59M1hhArj2nZat/f4qe7fxlUF5rocTDJan6mDRxPMYoAt
 cE30CB0fHs2SjEQkheHrx4PnmG+00cS9dTNZVvkKGWTEdYuXWFanx1vr4+RmP97u7vhP
 HxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877928; x=1780482728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uz68UNFgHkIaQwTnrD8tL+17ttgq41ToDfNqGD1o+U0=;
 b=TTnJWe39oU788UwIUf83/azrKCDOkK7omUnAIgUc32XcGPkAQ1/Xdlrn4YMqQIfvyH
 4nMJOQGZdKksvFgGEktIErPlSo4eKCfyx0hA3Oxjj0gp6JSAl+HKxFD5/78WAAY3rdJ5
 W3DZI6fHNq/AuyaEYTU8SOdorqLzOYLoOVVeqZIPTUJjjSctWHXjV+hLAJ3XHaLAPoZ9
 um7DjdJFYayImnWWhUbbC4eIkss+gpKm/2Cuq3esK/DaC7lVVbqaupv+VPTo52APd0El
 VcvAOVLz8RNapMOYV1EjfpdDe6l0ZP2JQsMPiAPGSPLHSfYvNNv+fKQCjjI8N+hIuzZI
 hFWA==
X-Gm-Message-State: AOJu0YwiYLJbOfbBIpdvGo1pYd/IQuc+R3eNv2XUB2/bU6SOyoY7SiAd
 F4N2ef/2aW5sbr3WX8RBTYg8Q4/fSIRxu5D1/7E+KzxAwbuvvBnDX/i5SC4yqBP9bspKwrjneUg
 ckZPiAdElLQ==
X-Gm-Gg: Acq92OGxNoMYP+ELYCexwWrea/iA0LFgMSRn2wU5Rh+ZWj2rbsWrv/1vq01mVR5OHXs
 obIj+f3eEa2WFw2Ph/jd4manFRHQgVsI79bOpPBJgwe6UEVZ4XGM51+zuIuSOP8uXmvSTg2oth2
 1ZtyJnkpdltSl1duReYGQGdSTnBUjM3ipF4kYV2Qpl42yi6tWZ0CCm+vQk9XBbhdQVZ9X3fYTY2
 X73rNh/c6GqY/7Gm2N7mM9SD2v/OVfw6y1Q1dhrWAopE8o4NVzGfBprYrIaRIkuP506qXVaDk8Y
 ZMCtG/cbXONoP5ZNbSilmj8q0q8c/fQNK8icJcWGSV/KlE7nrfhw5BWngwLA7fIX6lFy1blC4qZ
 iOMjwViScsPrxjCyP16Zc1X8IDGv+pjkppBmL/ihuHbS3cvYhiH/gAIkYNCFSGehpGxhgfO6kos
 yINTmJUtrGn0RdPO8T5LST8ic0XW7Fk6+nMsfC6Ql73a0YOSeZYT5bykPRyHcAxpoPwg==
X-Received: by 2002:a05:6000:26cf:b0:448:7049:a6c9 with SMTP id
 ffacd0b85a97d-45eb3688808mr36796162f8f.5.1779877927622; 
 Wed, 27 May 2026 03:32:07 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm5029551f8f.0.2026.05.27.03.32.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] hw/arm/raspi: Build objects once
Date: Wed, 27 May 2026 12:30:17 +0200
Message-ID: <20260527103037.4461-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now than Raspi machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
remove the TARGET_AARCH64 #ifdef'ry and compile the
aspeed.c file once, moving it from arm_ss[] source set
to arm_common_ss[]. Note, we expose the TYPE_BCM2837
and TYPE_BCM2838 types to qemu-system-arm, but they are
not user-creatable, so not an issue.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-3-philmd@linaro.org>
---
 hw/arm/bcm2836.c   | 4 ----
 hw/arm/raspi.c     | 4 ----
 hw/arm/meson.build | 8 ++++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 03825e69d06..f4ecea908bd 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -195,7 +195,6 @@ static void bcm2836_class_init(ObjectClass *oc, const void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -208,7 +207,6 @@ static void bcm2837_class_init(ObjectClass *oc, const void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -219,12 +217,10 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2837_class_init,
-#endif
     }, {
         .name           = TYPE_BCM283X,
         .parent         = TYPE_BCM283X_BASE,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 00e4a10466a..3f99e87428c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -367,7 +367,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -387,7 +386,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -405,7 +403,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
         .interfaces     = arm_machine_interfaces,
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
@@ -416,7 +413,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
         .interfaces     = aarch64_machine_interfaces,
-#endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68d204bb4eb..f149ed68d09 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,8 +27,12 @@ arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c'
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_common_ss.add(when: 'CONFIG_MAX78000_SOC', if_true: files('max78000_soc.c'))
-arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2836.c',
+  'bcm2838.c',
+  'raspi.c',
+  'raspi4b.c'
+))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.53.0


