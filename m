Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571DEC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEy-00021W-4a; Tue, 05 Mar 2024 08:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDx-0000x2-8U
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDp-0005xv-Qw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d509ab80eso374434f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646764; x=1710251564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVTp8B0By/XCvljzAaX1UWqxflzJT37GS6jVUdEA9Gw=;
 b=G9EfxxhXb5qWrhLoWn7ZE9ovTfX6ezQG75EHUNMeRP4BahBvt3T5mipTkV37YtwTwa
 m/I2OlUsINIo4mzSfQ8HjfbB+QywQqN21rHAhIJaR+EsvT8Nvh/HPH7OsbPOhluE0DnG
 R2wi7pIh5JziBFrFYsl6v6fVSnwdiTWRPbCZ5W/IqDjQ78LtD4W9fQM+2q1RbVXIbxPk
 +x7ryHtjEyKFVsKvk7c3eXM2irFZYjHeJox71tqRRcIjwerbtafd+wMxSL9hf3yU7X86
 FIK9o1efFzl7oEg/kGHR05bwK92FZHFe2g4g5i6gFHGfXRAuYkLVh8Ndg2aCAn4dv+9d
 sMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646764; x=1710251564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVTp8B0By/XCvljzAaX1UWqxflzJT37GS6jVUdEA9Gw=;
 b=LJXPj/V9JSVH21qY4ZpuYQuvfHcz+mfmr91mImjQD45H19SFqc62+JPrcDQXIwzk+n
 Nvpc+novlAS/0380hMBuFQgR/P74WaLeiLAfg9heiITWwIcHR8Vdo4BFKFdHvh0VQ7ct
 OLki74ZpJ9nMP+enNTpRtzXdeSmSquydXFOcVEG8LNYfs71DVLasWj7DS5OQfgZhahTR
 GH+z/lOkfdQfIuz3HP+WX34DU3iEirp8+hKuzRj5nJUcIynBlJhThPn04lAMo5HAOb7m
 8gxzboETNS6bD/imHmCVTA3mWU5rxWJnVqKcQy5TrOJWFTn/m2eNlRrEowcA5Rv4t4Aq
 917g==
X-Gm-Message-State: AOJu0YzqvTAN22RTp4VNGujnywgfFoFAO51+GXQMkMns9XM+4SPO2am2
 G06st48u+4C3JBO09y6e7OamkyivhuzZ8/2vgEHPS+PYT+a6gK6yhGHiI8fZ/a+EuQEGMxp5c8X
 f
X-Google-Smtp-Source: AGHT+IFT0gcBOVZIIdD3Sptm6aZQ+DLOPgb1h1fx53GZFmbsvvflAd5Y9kOzYKOtRub1G09J+rhL+g==
X-Received: by 2002:adf:9cc8:0:b0:33e:2155:6da4 with SMTP id
 h8-20020adf9cc8000000b0033e21556da4mr8901603wre.55.1709646764279; 
 Tue, 05 Mar 2024 05:52:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] hw/arm/stm32l4x5_soc.c: Use the RCC Sysclk
Date: Tue,  5 Mar 2024 13:52:28 +0000
Message-Id: <20240305135237.3111642-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Now that we can generate reliable clock frequencies from the RCC, remove
the hacky definition of the sysclk in the b_l475e_iot01a initialisation
code and use the correct RCC clock.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240303140643.81957-8-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32l4x5_soc.h |  3 ---
 hw/arm/b-l475e-iot01a.c        | 10 +---------
 hw/arm/stm32l4x5_soc.c         | 33 ++++-----------------------------
 3 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index 0b4f97e240e..af67b089efc 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -54,9 +54,6 @@ struct Stm32l4x5SocState {
     MemoryRegion sram2;
     MemoryRegion flash;
     MemoryRegion flash_alias;
-
-    Clock *sysclk;
-    Clock *refclk;
 };
 
 struct Stm32l4x5SocClass {
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 6ecde2db15c..d862aa43fc3 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -26,27 +26,19 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/arm/boot.h"
 
-/* Main SYSCLK frequency in Hz (80MHz) */
-#define MAIN_SYSCLK_FREQ_HZ 80000000ULL
+/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
 
 static void b_l475e_iot01a_init(MachineState *machine)
 {
     const Stm32l4x5SocClass *sc;
     DeviceState *dev;
-    Clock *sysclk;
-
-    /* This clock doesn't need migration because it is fixed-frequency */
-    sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, MAIN_SYSCLK_FREQ_HZ);
 
     dev = qdev_new(TYPE_STM32L4X5XG_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
-    qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sc = STM32L4X5_SOC_GET_CLASS(dev);
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index cb147050091..bf9926057be 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -110,9 +110,6 @@ static void stm32l4x5_soc_initfn(Object *obj)
     }
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
-
-    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
 
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -124,30 +121,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     DeviceState *armv7m;
     SysBusDevice *busdev;
 
-    /*
-     * We use s->refclk internally and only define it with qdev_init_clock_in()
-     * so it is correctly parented and not leaked on an init/deinit; it is not
-     * intended as an externally exposed clock.
-     */
-    if (clock_has_source(s->refclk)) {
-        error_setg(errp, "refclk clock must not be wired up by the board code");
-        return;
-    }
-
-    if (!clock_has_source(s->sysclk)) {
-        error_setg(errp, "sysclk clock must be wired up by the board code");
-        return;
-    }
-
-    /*
-     * TODO: ideally we should model the SoC RCC and its ability to
-     * change the sysclk frequency and define different sysclk sources.
-     */
-
-    /* The refclk always runs at frequency HCLK / 8 */
-    clock_set_mul_div(s->refclk, 8, 1);
-    clock_set_source(s->refclk, s->sysclk);
-
     if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
                                 sc->flash_size, errp)) {
         return;
@@ -177,8 +150,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_uint32(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
-    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    qdev_connect_clock_in(armv7m, "cpuclk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-fclk-out"));
+    qdev_connect_clock_in(armv7m, "refclk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-refclk-out"));
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(system_memory), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
-- 
2.34.1


