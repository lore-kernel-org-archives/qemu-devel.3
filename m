Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18692C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7ib-0003HL-CX; Thu, 19 Jun 2025 01:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r2-0006r4-58
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:04 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r0-00065C-AR
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:03 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86d0bd7ebb5so4819839f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287961; x=1750892761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5uB+PMcq729M/d0Xq5PyNGVe7AuOqs5CggiPdWCmOo=;
 b=TWmT5wx07LoeBLABKoNU7PyyZWUIUFRtGcH7oo5C7PRrcHCSMlrBkf0L/GNn/RpJ4r
 CnZLV6WNgg0PS1i7edyeU8MV0EetWxkARCEmOv+QQzOn1fXlhqhcu8s5TCKkkkP0MX6/
 a81QIZTRMCehbNgSa2TGCOnrt6vjeQ7MqsetdorCmma7NRpbZpuQrfgM/vgyTvKlI34X
 Mk853M70mwYCELN7DvgHk3/mi5w6hDI3mxwqcIdta4T9JEc5xlqJ1+0QK0HawrsE9U5s
 as8rg+TDgPMbOJmpyHsblOjkG2+2xB+L4fZliwafbKMu+kIXllDZPCCxLWUCI6WJgAMh
 SV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287961; x=1750892761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5uB+PMcq729M/d0Xq5PyNGVe7AuOqs5CggiPdWCmOo=;
 b=NP1MJtMg694M/EYJ0jpU5qpIZRzoC1IWij/eyw2X1M60KbFOhGjnaroCNejhIFYRki
 EP2FyGC38Vx44K/UBIkAmT6k7j0dFmntH4s2hBq+QzWmOC3U6VQQR+bvCaz4DEMBKAvv
 lUmKa7ah8tAEQTJVcbUSSrJMB7mdV7V81VeS45lfhVo3kzGQyJiG4/z5yucpnWRHLVuh
 FPydSYuL2qqW0004gAEvQopWKnlnc7dfhV5nImtbHCJw+Tc6RVbBrk35rvnNyYnTfXRM
 EPNwgWoigio0DF7Xz4Y7mcUaablJIFz4L1DFTT9XTQcoR8rtMXAi6K9c8pLZG3Q30W46
 pSGA==
X-Gm-Message-State: AOJu0Yx0mkJZy2TZPW4dh+3/rZsxxzaJakkTQ8+RAdQ5gYLZZN/+Xc3m
 7PeSBSbH+6QwCfp7g/TCq2m/U70DEy3fDhO5QHT07I1DwNIiBGyl5k3c02e2+bXs30g=
X-Gm-Gg: ASbGncsUKTT6pb4koZO//lxzxDvYIqfC0PRBk0dqHPAhWSlaB9IpbiAyTmafXpMY4Bi
 F34gVXwvlmcl5q1oHxsaOVItGxDMLMY2p56/rzjI81Qt4jYgx7kFqcH6Gx2MS6yeENQzk2fn9xV
 o9yynuffztWJx+qlHixUjS4MiRdozEXAzrcGLnx785FB9xgUP/NbDjF9zqQUpGJHA5HeKL49lkq
 v8LyKG54Ip+yJwitejREshUe6hygs3iodWiG+1yhJBnBODtyMwv95ymnQ/xmYmTRxOcMjuQGhW9
 cIMS+pG0+0jihDmI71kwlIr+mVk2AAtTCVOkWOXJV7ZeevrCgEWrWziqHc9893V/9l7hLa5DYzi
 Rs8+7BclYxNHfhpA=
X-Google-Smtp-Source: AGHT+IG6FlNhDwbItk3VBcAthiP4/CXxMSSzvIfk2cnA53I4npHwtNmhBOx55OH5i2dEZPES5nFbxQ==
X-Received: by 2002:a05:6602:487:b0:86d:9ec4:effe with SMTP id
 ca18e2360f4ac-875ded5d898mr2242492539f.8.1750287960848; 
 Wed, 18 Jun 2025 16:06:00 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:00 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 03/11] MAX78000: Add ICC to SOC
Date: Wed, 18 Jun 2025 19:05:41 -0400
Message-Id: <20250618230549.3351152-4-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=jackson88044@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:41 -0400
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

This commit adds the instruction cache controller
to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/max78000_soc.c         | 19 +++++++++++++++----
 include/hw/arm/max78000_soc.h |  6 ++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 9676ada6a2..8d8d2dce61 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -17,12 +17,19 @@
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
+        object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -30,8 +37,9 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *dev, *armv7m;
     Error *err = NULL;
+    int i;
 
     if (!clock_has_source(s->sysclk)) {
         error_setg(errp, "sysclk clock must be wired up by the board code");
@@ -74,6 +82,12 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
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
@@ -107,9 +121,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("standardDMA",          0x40028000, 0x1000);
     create_unimplemented_device("flashController0",     0x40029000, 0x400);
 
-    create_unimplemented_device("icc0",                 0x4002a000, 0x800);
-    create_unimplemented_device("icc1",                 0x4002a800, 0x800);
-
     create_unimplemented_device("adc",                  0x40034000, 0x1000);
     create_unimplemented_device("pulseTrainEngine",     0x4003c000, 0xa0);
     create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 97bf4099c9..27b506d6ee 100644
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
 
-- 
2.34.1


