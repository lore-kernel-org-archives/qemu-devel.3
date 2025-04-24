Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6147C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xd-0005JN-NT; Thu, 24 Apr 2025 18:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xb-0005Af-Io
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xX-00011B-9J
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso13980735e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533338; x=1746138138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cvT4iZQJQCESSbEgJmX7EXLabcaD7dXaS6FUwLzTDo=;
 b=jehek7R6oHU/52CJKZ9Tbap7/CpDF2NUmtVpV+L4Xe2vIG6YJgkg1Yty5s0o5QBMSx
 TCoCVvcMcldReAognKPUldIdJ66tP088swNNirfIZHEdD20/82xQssmiPMQAvojruA1N
 3tbSVdihFXtvlgUVkeqjW0BJgfR6bsvH7ZzeKpWi0yOJXMTQtQsOZl8TVz6ziH6LHiUF
 Ko1Mwu6Urjp1Fyq5aSv5z06t8tUt1shdcwFtgTj8oqpsXrnZoJOZW8rISYh2cT0SMcqI
 G8YVbvb33GrW3bpXs/fDodCQTEBMw8XhYOMNYi9orE9aECESiMOMTTSRHUYiMmS9Eea+
 2xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533338; x=1746138138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cvT4iZQJQCESSbEgJmX7EXLabcaD7dXaS6FUwLzTDo=;
 b=V2+B4KaMhLOX8sWkiH1mvw3jS6BQzaNGE1PFuGsIR+SimlXn9kRRZGpaxZdvsqkZSU
 8NZ5ASjMqpq7QFucHnnf0FPnLameQyl3aib6ZKOkFL4bXmX2JOKRIz7F33HIkl76OpUf
 zUmQJ+bzsDIOaMyuVYqyBVrFEmUsVnXPtOBNaPpguMwaVpilu+Of/uNr9YdvBlha/w99
 ew8tAdBXGuwkHJXrhhiRB3F4eFc6QTDFZUsuvB6gSUbY3HHII0MiaCdMpsg4XM6IRJ95
 lu34z0kVo3Mm/MiGgBRhlCfnD+n8/d++ZJxNRTCP86dQcumDyCIfFg2XM3TTKyN5lJBE
 ivfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWZQYqY3Mxmginlt7s4pN1PMOHrbpcNH/LERQBHmE4VSs8aOKA2axNh+PrtjiGM3CtR8aINlJa5bSn@nongnu.org
X-Gm-Message-State: AOJu0YxVMTSBr1AcLOkwc4IG6UEL/CdAKzBRHf9zzaa+vyKZJEr7bhmD
 zSn+thepUUSLPpkGivpfxNaJy/cGk2UeDd32deEZiNq5wCuP1WpdK5X7lwhT+0w=
X-Gm-Gg: ASbGncsHEgx+jlmoP2znDiDvDIfYNNtRuhl33kKA7hkDdizVIuwrpMY4wzMtdDowBBe
 cG4lCriEVu78vYT21LBG/+0T3KVy5vdjSUZKX9qNp/5si9JSVvwORbB/4rd1N4LQ5/jSeJePmHY
 GCtZQ740jvqroXglt6aVJW+fefoc4k6k2yPIIF+R/sX4TAkeStG6yfi3k/9myGwPbHAqjfsqtN4
 B/Ab49yL/CKdxj0Oo1WwXXDkr5MXpXuIL154HAk09qPegxs9OO7clD5xXsGBeX4ZQm/XEmRSwJz
 iTLqBjWwQcNRrOhNbTPXLttyBzAjLw82Wi/urc2wf6McdXEaP9o9rDZ0/cl4JCku/Ul3dSfk25G
 xD+W76MvX00wqoVo=
X-Google-Smtp-Source: AGHT+IHCmd2IcfuyOLU3Z/BL/zajGvpne+ADXfYlxQCDaBEQlnSK2WvUOofLmINPJ1cwolj9PdmSEg==
X-Received: by 2002:a05:600c:500d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-440a30eff31mr12654265e9.2.1745533337602; 
 Thu, 24 Apr 2025 15:22:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4641csm461121f8f.80.2025.04.24.15.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 13/21] hw/arm/raspi: Build objects once
Date: Fri, 25 Apr 2025 00:21:04 +0200
Message-ID: <20250424222112.36194-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Now than Raspi machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
remove the TARGET_AARCH64 #ifdef'ry and compile the
aspeed.c file once, moving it from arm_ss[] source set
to arm_common_ss[]. Note, we expose the TYPE_BCM2837
type to qemu-system-arm, but it is not user-creatable,
so not an issue.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/bcm2836.c   | 4 ----
 hw/arm/raspi.c     | 4 ----
 hw/arm/meson.build | 8 ++++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index cd61ba15054..aaaff05624c 100644
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
index 2a6b6aac0a6..d7d2920ad75 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -368,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -388,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -406,7 +404,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
         .interfaces     = arm_aarch64_machine_interfaces,
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
@@ -417,7 +414,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
         .interfaces     = arm_aarch64_machine_interfaces,
-#endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f76e7fb229f..f52034ff6a2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,8 +27,12 @@ arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
-arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2836.c',
+  'bcm2838.c',
+  'raspi.c',
+  'raspi4b.c',
+))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.47.1


