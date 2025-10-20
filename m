Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB4CCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy8n-0005Lp-OQ; Mon, 20 Oct 2025 18:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8j-0005Im-Bz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8f-0006VO-6p
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so26395225e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998430; x=1761603230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmAHkKRpKe+N+FLuo6CnpsGLNli5rNouqryFJwonxGY=;
 b=nxg4Zkuh97takp8ZeBL9nVemGzlPqJDI9YASXZNUKIBSQAOEEw8X2FjeD+Zlo10Gsi
 +56fdEALCP9ST+rNFhInTbCCoR0/pzKRuKLgdfCobeNpgJ4p20wJfskqffZXkjfYxRoa
 82Xj5KrVE9DsyJ5iVpWcQCggUkycV9EHBlK5D/izsujoD3ciKBf9XJUGSd2j2qzUnncs
 kkitfSge6koLnaJ0aAkEFl84FWZ0yK5zNp7Vf4v+jUT/aGePJDm23rjIgLhSFILBLtkw
 ewiyxxSRBBUAYHPIyWsktqxjGnAfM0iiXmctovBxudWRQlWs3QHg0NzqurMCWy3aBdJp
 liWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998430; x=1761603230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmAHkKRpKe+N+FLuo6CnpsGLNli5rNouqryFJwonxGY=;
 b=fuzudAmI2dO6Q8dBXbss0qSHeLNFrJoY5YZ8YnUyxxTVt4brudw78SRWee+7oIvaEY
 2Z5L8hped8jkSDsjxVH98mdM0qeSzGf5tli7fWwGTg9EDdozLRm1dlJiKwL5RdASavZA
 d89CabzOFQLafvEpphaoe1urSHJd8vTMjzOwqbmwN8i4tW0ZtDmonNTQ/dc4l3bv6Ya+
 y5c2YVAwGQMxepl5UkudEiFJ3+28QUHvncCISW9o8qebdRSbPIeqWEwWjrzrGeIAWVWD
 T4F3vlT08Otbph0XeGS2fwRYmn+B9xR3EhGY6OvOQHwfF+YXYiggXaSGf1luTEngQYN3
 D0jw==
X-Gm-Message-State: AOJu0Yygd6sNaIEVoAZVjD315ShyoEDQodAsjsnmwpijMSeB5I7hfpvL
 QpuaeeQamK2XMTryzc+dR8ItlJWQgDX6VrEoU+Uh2IArk/NpTwgkssu92oHkjNmyxwQcp8SBf6i
 NDmZ2eYI=
X-Gm-Gg: ASbGncuH9DS07yLrrp/VEpR4FzW5F+wizuHtswbYw7KMrjv5Nf4uTdqiq1Lm83M88jW
 1FdGzadraPH2M9tA9N/vgfVF6YB6eyuyvDrFtODBgAUCQ4XpLLMFawgc1Hu3IS3LZFnKeHkIOGV
 mmFh2I8hCkVFBfXVPeqqh1mwNrE7VFjwUrgioF+aZF4e0BbW1Cjy5w560sZ6azNYJgQ1iJpRPmZ
 JR3pa8FGko2HBZoF+pcNKy9wBhF/j20VFDbm1b5yTBn3NahxA1ueKoysvp2exx8SdmdFOeuMcp6
 afrBdUoPO6s1EgGgiyEp5ExDG03XXj9aV6i+zFsxoq0AnCHOfN/xua3jX+wdYvReA+ficpq//z8
 EVWbtWUu4jqLDW2RI80fBxOheAo/6rvWtAwwJT9mTfdVeCgWBxStEHOY5RVHJPqnosN60cZ49g7
 A3/+h+VvKZqCr7up3OQviHKGYRDSvPCljC1Q+cOClptYxmvYeKMg==
X-Google-Smtp-Source: AGHT+IFuaULPbuETV1FMmN10syysRKvDy3vJkroLpk5zDOa+1hPU2mx5U6AoZE9Y4Vl6eS/bpfKm8A==
X-Received: by 2002:a05:6000:4287:b0:425:7c32:d969 with SMTP id
 ffacd0b85a97d-42704d145admr10331749f8f.5.1760998429944; 
 Mon, 20 Oct 2025 15:13:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b97f8sm17020178f8f.36.2025.10.20.15.13.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 13/30] hw/arm/raspi: Build objects once
Date: Tue, 21 Oct 2025 00:13:18 +0200
Message-ID: <20251020221336.66479-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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
and TYPE_BCM2838 types to qemu-system-arm, but they are
not user-creatable, so not an issue.

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
index ff5d4368e42..bc9e2b4b361 100644
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
         .interfaces     = aarch64_machine_interfaces,
-#endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 98783bbbdeb..a12d690ce74 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -28,8 +28,12 @@ arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c'
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
2.51.0


