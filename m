Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B5AC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjF-0006sd-VB; Fri, 04 Jul 2025 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjE-0006ql-FG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:36 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjC-0000Ni-H3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:36 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-702cbfe860cso5350426d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648253; x=1752253053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ/Zby+eacUDa8XDihxuZYk4Zbf/Jyg+dd5JmP2oM1A=;
 b=T5VGyXGu7mjK8sRWqw0i/nhQ+UQHhxd00jbFkYnRUhN7UpfxG/kUPSBMsYpUK/xXOL
 KNZNcaFhH2J17NnSY1e/Jhbb7I5u6b1GyFaAfCZCmxL+punFg9cVX8cR/VLaASf8Q9Qm
 nBq1AMNv0IXbalPsJmWrAMXCmekqbyp6dznHb2YIdQfbJ3xYo6Ihv4Dy3o6Z1ubWGGSE
 GIO/h6hZA97qLvgLtQIq4soQcA0mCtyFm4Rq9jnra3YKv7Y3MWI7qj+uLNHF+DppwDZE
 mhssbx5GeDJ/PGHOpHXqml5thiTe2HHnhn8/3DXUkOozNTFEgd01uoViaW8XqEEQuQCw
 flZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648253; x=1752253053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ/Zby+eacUDa8XDihxuZYk4Zbf/Jyg+dd5JmP2oM1A=;
 b=p/6I5zERVTm8ylWTBs7c/xkj8xn38WAj39FCZ3fjEHG1XTKq7xZJBrA4LvGOEOTwcN
 aqMhV8BwQomq+m1EvOS8sk4UhwlwORrSiSZaLuCNVWGPKaXPKnwu5aJszUvnoaoTCU+D
 aDxc9q1Xj4n5qm9E4GRuXv386DWYGLAxKWtJigxCRJrBjn4TPFRyJYdVO3GCwKAYk1U9
 0owpT8XND0puNKv3hGq64uwMadIwBbyLWjeoTa1ue1QTiR9U8g9UM7uy2qYffWxMtbrr
 mgEcMmK8pg4yDczblUy9Y5OOnMHKyCVEPF2ri5RIis5CiWB+N+dzGSKgax6YEFAnwJZz
 xRAQ==
X-Gm-Message-State: AOJu0YyiXdB3hjz9X1SVrKGarhjIlYusC414yGCOKKepJYQH/VNYtO/P
 HHBxOd4RoG4tLxUdoTltSir9vjdK8w1N7SKRoO59HWVsuRdRy9nQlU/zke+LiQ==
X-Gm-Gg: ASbGnct83ubXEoRtTyRAXpP+ptVSUpwMX0P/TjE6OYB7vMJp1xtsIux+tu4kuU78aiO
 +5YVWM9R78JsURC8QDNNkQ/MwidlO6gfnc+myiDsjCELHZwe35TtbPTaAdcKEn0ET5fcqpflDrl
 N/DDkoR134vwT7eST1uLFmrQl9kc5e9oyE8zYzCPEwfqO4lSgAJN0T80DgQf8MbSwh54wIupcuO
 6DKj/vskMDl1VM63zvwkq2n9EaB10aRpw36IradWHOOn9WHR/MCZ3b3sDwxrzdh3c/z1jq0W+tV
 QkkJPNjgtzG6GrCl1k56AkynGJ4IO3/uBzKaptBLSNz09W5/RsRihv+/Y2vVTe/E4RxDv98a+qM
 +sVdm
X-Google-Smtp-Source: AGHT+IEdbwUXUDQiyi7JQBc4yZnYusS1vYafHkPVee5n0U2d/WYd3rrq8vpe0JhjWeiEk+pNy9yBrg==
X-Received: by 2002:a05:6214:5006:b0:6f8:e66b:578e with SMTP id
 6a1803df08f44-702c6d93412mr44263546d6.32.1751648253140; 
 Fri, 04 Jul 2025 09:57:33 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:32 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 03/11] MAX78000: Add ICC to SOC
Date: Fri,  4 Jul 2025 12:57:21 -0400
Message-Id: <20250704165729.208381-4-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf35.google.com
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


