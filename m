Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0484DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDtk-0004Nr-2l; Fri, 11 Jul 2025 09:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDte-0004MH-P1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtc-0002wT-EX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4537deebb01so11863515e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240875; x=1752845675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DcshZRdHA+R2F5c57grtYhzclejkjBGcvQNzRFYXK7E=;
 b=n6+C4eqaEDaHZHSCHXFp0IO3+isVBteTQlrRaEPhnkbWAB2U+BY8hyS3UKnMHKWNxf
 gEUlVxjds/lGubBMeRIe4pnZKzsKNjvLyBzm3JazzeomOUFxam8dwkObacW0JQeO46oi
 XrMJVwyoT0s+uFVHErZur9gbEFilojOn17gcoJuJGpaqtRFp5+58TjOj4cdOKVx6ga28
 /aFchE/umJnXYbW53xRDp4teBlUC3FiG+ZbxtxIefcgjQTNHlW/fP+A/g8JvgMcxT1Zj
 3PBbxzaKGG6TVWf06KGnklM2SyQ+RB5tcGkdlrLoB/GV6ccNviIm+/C11Uh/dzBGjEk5
 JZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240875; x=1752845675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcshZRdHA+R2F5c57grtYhzclejkjBGcvQNzRFYXK7E=;
 b=IrOTga+g9gHQqiN5gY39ddk9hVrvyHgHMMCuuG3XqRcExOovucgMR/u0qfitHzX8V+
 qfksxVGJ9nVjG4U+xyeqY/cG4OllIuDJQMV2JhR4jkNQW7l6KpczmnFD9u6kjwS502re
 nogn3/lXn1vDZgzoSDqCUZ9tlMjDBl6FZaVKepn096pPOS7gjI8JGqiAWPL/WC54LLuf
 DulTEHZBCY7TS8YIMLAg6dsjr0errqCC6oI4q8rkZBBHTgqOuc8yokaiS/Qa2Zz5P8jN
 /B4rgSALv8DsUstZAiq88BcCzr86lUPVYeSqGb5dL7LfLarBbXqA01e1cevPl3aHZGhb
 eZqQ==
X-Gm-Message-State: AOJu0YzosxO9go9gIdbJFYfECu5JuSGQP3uE52OcTq8LOHs99kz8Qhxt
 5TDdJL7eWGxdayVEo3P2sIKROrXokVgqcL1s81j/nTM6q8S3v+uwQXkwOsipxZBUlY48EX4oyyf
 YGw8B
X-Gm-Gg: ASbGncvtQ8R57ueuzHc7vNbOqYMHhmEkLZDCClXcZIrSFCOfDC9EGf2EejQ4sSrCqyT
 0Jksbj+zFwcPdHkCpTTQZQVmmB8FGVacvWZ43hORbBU4ZcJvXU0GIjzgqa8bTlsk+E8/TCMeUK9
 NU1gy9jFELIc5TV82/YyJ4FisQtjxRcUiLgmkiBfFd9msR98gyG/e6YA4fV/EAdWJt0qk8sAE81
 D453HzC33u9mz0WxXfMvb9arcWuXI9YbxR51oc4dnUmz3Ri3UnT0ZHZF8NHrj5amSRmUwMxOepC
 +atdvmLFdDT2G+Ircr9f/dapJZEnXVfzecyS/fx1Fmv4WWwYkrNoBqscYOP9xABQryySupuWV29
 ad/038rehejCURKwtymED4Y2llIMx
X-Google-Smtp-Source: AGHT+IG2c7UofLpeu7O5NPvj24unMbofNRJiU5V4VLQNPyTbQhLSBXm70qAlLlSte+9ytav8JDiHNQ==
X-Received: by 2002:a05:600c:3d89:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-455f30bfc7dmr11257655e9.0.1752240874865; 
 Fri, 11 Jul 2025 06:34:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] MAX78000: Add ICC to SOC
Date: Fri, 11 Jul 2025 14:33:56 +0100
Message-ID: <20250711133429.1423030-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit adds the instruction cache controller
to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <petermaydell@linaro.org>
Message-id: 20250704223239.248781-4-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/max78000_soc.h |  6 ++++++
 hw/arm/max78000_soc.c         | 20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 97bf4099c99..27b506d6eeb 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_icc.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -21,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 #define SRAM_BASE_ADDRESS 0x20000000
 #define SRAM_SIZE (128 * 1024)
 
+/* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
+#define MAX78000_NUM_ICC 2
+
 struct MAX78000State {
     SysBusDevice parent_obj;
 
@@ -29,6 +33,8 @@ struct MAX78000State {
     MemoryRegion sram;
     MemoryRegion flash;
 
+    Max78000IccState icc[MAX78000_NUM_ICC];
+
     Clock *sysclk;
 };
 
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 9676ada6a27..0c83b08eca0 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -17,12 +17,20 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
+static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+
 static void max78000_soc_initfn(Object *obj)
 {
     MAX78000State *s = MAX78000_SOC(obj);
+    int i;
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    for (i = 0; i < MAX78000_NUM_ICC; i++) {
+        g_autofree char *name = g_strdup_printf("icc%d", i);
+        object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -30,8 +38,9 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *dev, *armv7m;
     Error *err = NULL;
+    int i;
 
     if (!clock_has_source(s->sysclk)) {
         error_setg(errp, "sysclk clock must be wired up by the board code");
@@ -74,6 +83,12 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    for (i = 0; i < MAX78000_NUM_ICC; i++) {
+        dev = DEVICE(&(s->icc[i]));
+        sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
+    }
+
     create_unimplemented_device("globalControl",        0x40000000, 0x400);
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
@@ -107,9 +122,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("standardDMA",          0x40028000, 0x1000);
     create_unimplemented_device("flashController0",     0x40029000, 0x400);
 
-    create_unimplemented_device("icc0",                 0x4002a000, 0x800);
-    create_unimplemented_device("icc1",                 0x4002a800, 0x800);
-
     create_unimplemented_device("adc",                  0x40034000, 0x1000);
     create_unimplemented_device("pulseTrainEngine",     0x4003c000, 0xa0);
     create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
-- 
2.43.0


