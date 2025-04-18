Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7016BC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pXr-00034T-Ak; Fri, 18 Apr 2025 13:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXO-0002eD-Sz
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXM-0008N6-Ft
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a823036so12099015e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997398; x=1745602198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4RFN5FOuVixNxaWmi5JCm+O9iaME+14SHqI7R4pYTo=;
 b=oBKZ+WkbpfQlkMzHTTM7PJsjKgekCX/s6JaISH9EIniCPCs/AFfUmt8MNcde93O5+1
 TZLtXT7N1wfB3wvl9K5Dg4xEvHvwQAanpV9Va9DOkRnTPT9eNxwzpJFSiO1AEgJAnPfb
 d0jM80JXTm8L3Ulhcow3W2qq79VclyoNHzHqSkZn45N1RkfuzvQ3Q9TVBSmiND9YK8lq
 3jcpA2ZCcnWZSBdhqVbgqiF68rAEJBYSrApm5+JLZYenfbWbG3/CCksYHp3jVm/5pUom
 ZGggRbxVDBPFthU5k+laXJpzm8N4bVBG0WtAaxpB3fKC/j4LOFq07gso7OEw3Os/TRjP
 QrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997398; x=1745602198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4RFN5FOuVixNxaWmi5JCm+O9iaME+14SHqI7R4pYTo=;
 b=M5pdWuIRNDOL1k+6vrBKTSsIgXIJLXq0pz+q1DYAm6Q854plm8eRZfjTvfbQ4s1GNZ
 UTgUEKD+OtBK4SR829OkR/n7n9+QiqLyBDUq4ihi/irBp/zHy166f1dDD3ERCcMJWQx+
 QkXxRhcQA1G0k39Fn55JwzIrVq9p/i+/b7Z1wEmC+u0anq7TQs8vw1oxd60WiZWSjpkG
 KFWP9coQYfOkAUnbJwHTAdOk9L8eTSLRTyHHX9mirsy0hFtv0ywQDJaYliRVG9M9TeC4
 Idi5RwhGOohOG3CYhVWbhmRey2DouiWVOObLHZcNvatoXs7qN7pEKz1ICVnqHiYgKMqg
 0zQQ==
X-Gm-Message-State: AOJu0YzTPDlJnkIsjqRT07pYwMyGu9CPPF6iDUthBElWpoCuc6meTmix
 f9WRKy1cigyN23ML9u43dvbHUYCsHFH5aItvk+dnzSkWfVAxK8h/8ya2rDGpthvbNhOEOYYrfIz
 6
X-Gm-Gg: ASbGncvNRcJiWbz4WXQciymSd9akzSM8NG4Enzt7+bd1bKdOEk5LiaZ82ua+yyJCXm1
 AogKFPl+KWq2pW/ohqPf5SMpHpluO7HnFYELf/MhOO7L9u8wEVXYVuA/VfwJFn2Ggj6LefDhJX5
 nrE/VmrjEkI9n45epHOjAsf2O+BxfDEAdrhYxv2p8K7AqdJwpJCnVbq3gpaGn+jRX37+CUB4KP2
 dE/snILZLhSC06T1Cj2T9Ym1QVd0K8GdP1xuB2L7FXf7BxZ78Ms5R3fjpAHUFgE5g/nzBLe0QU1
 bVxCfT3QPx5rHS4/8FwYpiN9SatjwIK1F+CAr1y8jwLqt/0u6+LrmtxzruiCgS2QbYzKOGuMHN0
 uWde9QdPBzPE1cJA=
X-Google-Smtp-Source: AGHT+IGUSbbKEiE5T02wHag3PBJapDZ7vaiFk5QR8tV+RALR/Teja0GVRdeFtU13cgaaG2hGgH8dwQ==
X-Received: by 2002:a05:600c:8716:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-4406abb420dmr33057635e9.19.1744997397810; 
 Fri, 18 Apr 2025 10:29:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acc82sm29739315e9.11.2025.04.18.10.29.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 10/14] hw/arm/raspi: Build objects once
Date: Fri, 18 Apr 2025 19:29:04 +0200
Message-ID: <20250418172908.25147-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 hw/arm/bcm2836.c   | 4 ----
 hw/arm/raspi.c     | 4 ----
 hw/arm/meson.build | 8 ++++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index f60489983ba..454ea2208d7 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -196,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -209,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -220,12 +218,10 @@ static const TypeInfo bcm283x_types[] = {
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
index 69cccdbb6b1..641e231db61 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -368,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -388,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -418,7 +416,6 @@ static const TypeInfo raspi_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
@@ -435,7 +432,6 @@ static const TypeInfo raspi_machine_types[] = {
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


