Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9202CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zxm-0002dd-J0; Thu, 17 Apr 2025 20:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zxb-0002P5-LY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:52:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxZ-00069L-Np
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:52:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so9837085e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937519; x=1745542319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rc46lD7Ko7XfwPKQsqzz7EgBw+3K3PZcRoY06dDD1t0=;
 b=S6H7MOy1K3zDU1lbjzvXeFBpKwcx3AjGw4IcS100NmOWQnsMw3jePhoe6IWibIfytj
 07q9YDVS0b79m6qQ1uyCmUY9MXS6NHs40Whk9LWKrscZauqadftO1YwxOIPKcsFOYlpO
 QGihTk6CRDIIqcG+j8jC4RUc7Ye0rPoSrN4fc8OcyhGqdjSlVQTlsZiNfb6SQRumBJpJ
 o+q8xV2aYcTJXJNOciGcZROeOF2PNngmRbEQ8Cx/nCULv3XnhQCpz31lQG9b026UGMql
 4BWmzfEp2ebhd8iBzLs+iNSpGeZPZqmwoMrZXVDXVDQLTQXexVLmdnlkkMQ3TQc6Aj8O
 9KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937519; x=1745542319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rc46lD7Ko7XfwPKQsqzz7EgBw+3K3PZcRoY06dDD1t0=;
 b=mm/tKw7mg2h85+1adK/4Cy4OahdhYQJyTUen0SxidZa5gytAUc3QRSACUjnMol0zux
 CB8ym2Rf+myojMdK47yUePgaWyV2u9RMwpA2RON13XC+JvhzF/e4HQEol7OuuvbZQQ9G
 PJFeMOhUFZW/erGMP094btEx0Ux7sdoL7zkkb5vqA1ywXwiufAthnmWHKFE8Rd7FucXE
 eXymW44Rvcnzo6982cNGBaDLrNemKhp2A6OKsYqSjEPaIqnd1VlPwg1F2c6PEt9SjoTn
 k3W/Ct/uqvgnvc/kjiWvLyafHrpogm5IYMzdSxocE4Fdg5RxuhuNZ6wzqu/dLkACL6h7
 caAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW/djwf8VUnXXZovIa+Q/+8X8rzeN4ezo0m/VetLaH3k23sMCvPCjRus3MxuE65AKy3DiizndXMjpy@nongnu.org
X-Gm-Message-State: AOJu0YzU8qSkNKCffXnvdisjMMWAEqXEtcfsbq70Eu31sXbpS8clhfD3
 8H99tn4oPr8nrmJIv6U2OnReZnOSF7awWRhl/ivzVw4f8+HSn6GvIbViuIwYepk=
X-Gm-Gg: ASbGncvcLa4TyI+KJduqSjyKnkaL5cu2q0XNijq+qGmAGK3ZlLT+4n7qdCkm9/vW+a6
 kpO0rkCe6qgYu3YhYVV7oQKI3baNqp4zNbMD+f2ET6JdHv5g5qSErioiogSDNbOeicaj569mS2b
 V9h4B9z9tHRoH+dFmpbTWNXkor/2Bh3wgYY6vfp22X4VS1POdw4WIT8b+fK5DBZZRlS72mXX5xb
 N+ByNaLFTiZ6l8iNTwaM9hCsYbmu8xNu9BQhSS2Y1eEnMo8YCqJ0Of171I+WjMVUvgPvaZM6Wr9
 +dNIXMzRWUgfH1Ltn0T3+kBLii8HScBWJ8dZUeYb4NFRcB2njHSd8CPjdx70hjm/Oh31Wp1uwIh
 Wfi5L2H4C8w7D/KfFAHk2
X-Google-Smtp-Source: AGHT+IGuVnDN9W10lwGQgK434ZVDA0zrGtmi8qZ+dh2N8VXoW10w4Eryi3bYUzD4Vji5HWFr94a4jw==
X-Received: by 2002:a5d:6da1:0:b0:39a:ca0c:fc90 with SMTP id
 ffacd0b85a97d-39efba3c6e4mr609303f8f.14.1744937519048; 
 Thu, 17 Apr 2025 17:51:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6dfe4esm1984585e9.33.2025.04.17.17.51.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 11/11] hw/arm/raspi: Build objects once
Date: Fri, 18 Apr 2025 02:50:59 +0200
Message-ID: <20250418005059.4436-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/arm/bcm2836.c   | 4 ----
 hw/arm/raspi.c     | 4 ----
 hw/arm/meson.build | 8 ++++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 95e16806fa1..7dd81e8e0f9 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -195,7 +195,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -208,7 +207,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
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
index 8a2da650087..980e4a14793 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -367,7 +367,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -387,7 +386,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -417,7 +415,6 @@ static const TypeInfo raspi_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
@@ -434,7 +431,6 @@ static const TypeInfo raspi_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
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


