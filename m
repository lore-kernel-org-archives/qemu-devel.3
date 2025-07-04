Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D22C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoy2-0001mu-SP; Fri, 04 Jul 2025 18:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gJ-Mn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxa-00078c-PH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:51 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7d44c6774e7so81436485a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668363; x=1752273163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1y6CZ81l1nwOGYh0zdjwyLoHLYvfJVoT2Wfc1f9lod0=;
 b=eShQutOUIrAQqD6FNmUTlYD1FQjFHC7nvvnBoA8AiC2OUtP+Pdb787zV1AFSiIZbUV
 OU/Gs19HI8DpvG1acrwKaIX70l3YRLvCHTlwdIPvuFDvqTZ4ur5Y5e5Ks9ii1t9xVK7f
 5KCWP6sMEW0XIVuYEVaQ2q9+K0NMd+cB8U8sJyBJej3Kmhz6ZpqKRyr3EVuEQY7U0OPl
 v7Za8iJFUE1MRX2C+rk4wClm+ENzFV6PK8gugZss9KdQR0j9AaHGTz3T/UnaL3qf3olN
 WBplZzCBQzIL6hP5ikz5zUsX/PExVh8UacqE9jYXnNCTzTk89OngfHDAd0GH+ZY6QPdS
 SZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668363; x=1752273163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1y6CZ81l1nwOGYh0zdjwyLoHLYvfJVoT2Wfc1f9lod0=;
 b=UmStRIhR/+ghMv1yaJ7LL7AnRV7wNhKWKuVZqIMDfjR/0X6pwP418hOAmJcFABF+th
 nfBlkrlNqpSrATkRrZQ5nRG/r5rpP93Wep+N1FNcGK5np6UA/h7IlkRmqkdPeNdpkHQK
 0da8GTzXmn/UxRbvctf6zxWunmXKMf+qHL3/L7RvK3keTIPhfGpXReZ1BQFSBmN4HWol
 sgxr+qYx8woRnZGWry2UN66R3zauP22qjCUhXxCrx+Y8GYmxViOTH73Sl/WybQ/RP/Py
 FZlw2KfvIKl+6e0wrISxRr0lMWoXV28wYrihMqr5MKRsDJsqsMFvgWtHy30j1hprSLXj
 FJig==
X-Gm-Message-State: AOJu0Yz6KIvvQBVjFXTjtwEe45YXSMUdqNM9MMRyZxPX1RRX71PgP2d5
 i7TC+QZIbiEZqsTUYTu93ddrQUQrafUb5p782LrZT1FvzMJExAtKms2Gz0gPCg==
X-Gm-Gg: ASbGncs1kVIFR3o2O1DRlbyjru/pblyPYlULUNC2SE8nVwA6Kkts306qBkilvKtrbvQ
 JLArh3YQih4IZBBfiGkkkvUlq8ujtVLTVubCN+IggQ20oD1Vn7DUHNBlSytQOSuRelpeaBV90bb
 WLNYKddc+uDMSTNmMQJdwA8Gbienpik9x91EGm/6SKcd6Xd/s9aRhKo+R4rAurR6ewW4w8Q+oNJ
 grGFEhNqHpeZ4dxrjcjCL1xvN98opP2+ZOkCLbXMsZt668XD51VJuP+BIwA6t0NIPXaVrgqm3lO
 J3TDuBFwkJ8gHbs6ftOJC7wNGG5uyLVOOGv+7A8wgbxO6ElZbIDqEazyJ1T++6Z38eJMUmVKi2B
 f/XUcdA==
X-Google-Smtp-Source: AGHT+IHpxdb/IW38MlTr7UMizk/BxFiKP0rILCl8tSJ9LSH95qpHJwxtiCf8VHYjhzl+SrRRDA8M1A==
X-Received: by 2002:a05:620a:5bc6:b0:7d4:6648:cc with SMTP id
 af79cd13be357-7d5df194af4mr450276285a.57.1751668362991; 
 Fri, 04 Jul 2025 15:32:42 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:42 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Peter Maydell <petermaydell@linaro.org>
Subject: [PATCH v4 03/11] MAX78000: Add ICC to SOC
Date: Fri,  4 Jul 2025 18:32:31 -0400
Message-Id: <20250704223239.248781-4-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit adds the instruction cache controller
to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <petermaydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 20 ++++++++++++++++----
 include/hw/arm/max78000_soc.h |  6 ++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 9676ada6a2..0c83b08eca 100644
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


