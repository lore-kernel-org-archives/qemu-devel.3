Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6N-0001o7-55; Mon, 14 Jul 2025 20:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6L-0001id-GH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:53 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6J-00083t-7B
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:53 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so41848386d6.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537650; x=1753142450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Px7t8brrBviy8Oywd6W4qdgyY63BPA8hyi3wDsiNDks=;
 b=anczbVXRvRUyxY/Xn8ITSirWvEOaJs8LmG7m9IiSDUbwxONJGBXZKUjiQVqJCN4FhP
 7PGvUzJY7AlNEA5tQwvns5yrab25SCgMmBwZkbxsjUWs9RR3Tim/SeUjlrqFS3/5rVob
 tkXEqEBNNqNvnNEje9Ljep1xIq7bpC0nfCUR6bb0b/UKDJX/g3PBEPNEFdeQ7Cfp8E82
 fG8kWwKHBFl02kaYNUKHGq3K9IfSuSBE+01xuHlY+Ot0HkMC1U+TYNEYFAbeW5HwdPaa
 ev3mF47hSy+Sev1zqy5uEieaAEFTJClbKTq+qYIlhm9DqlF8jsEYGb2OzF5Wn5wRqGlx
 N51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537650; x=1753142450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Px7t8brrBviy8Oywd6W4qdgyY63BPA8hyi3wDsiNDks=;
 b=SonO8K9sCzoBrur3f4Kiyu57JXHBMkS/kj3xyb2rs5haSgO+YvSRTeObSJok4IEUpe
 EgdVmORcnO2cyZggC71Is7UDHtpldz+8ufBpPvvxE7J24Y3oN3lc2f1YdIBUjf8moPoD
 FqWjNs99TcEFbmVWfQlnwsr7JOj97s8dJZ3AVFdhYvNa9cyak6A3ce+KoOk+DiwC1KSp
 mKl9INV6U3BnkYDG/QDkdLVP9Bu4NlS5zHZLRaUbwF5OgKFwiffmk1cx51ckQAKtcfbn
 8MqniPKghBSE1OBotmu90UiCsbCuE2wMc/d2deCv1GrxiZJL4VjUGIh+3Udk1Fj/ib1X
 sefQ==
X-Gm-Message-State: AOJu0Yx356hKLAFf3JTOeOLCAqvmHfYQWlbrXjPUSrz0Kp/tF89K8GfZ
 dkVCOGuNZCP1biLefQ423eN+W9NpBg10S2ZC5MR4FoCnS5d0AWxVcZfUMnrR/w==
X-Gm-Gg: ASbGncuJwE51KZd2TmFVKnWqt8uBJrN+R6t91fFspuaqdvoma9q9D+SoKj1eFGsqlNo
 2WD6ou/U3+9oZOw403sEuO5VBjT3d0iqz3tkNl7pTHOvKKtfdNLNAbAf4A4zp7gpUcdm9EF233T
 dstILpQ9n8bnztNgdrBZh4dc6hdaGFbgOpIz9eO51J5NB7sIocEVSg5/qaCcR/rxFWmLWNEyLhM
 67VCKo6cusNcQgAwz9IKxeZaawJk6HivgMrR7yHLbhA95n0GrPJcYdZx5x+QULc71W5/61UEDQg
 HWc6ZqyCz5QI+5EHiQvVKoDq+W/WXPL8TEoOpWGjNMGlZTljyA45dyFoq9ZHgYXTmipb1P5FuSk
 yITzUFJ0rEoWubSFeKw03iem8/nhmuj6rjOZ4zgjtVaSS400=
X-Google-Smtp-Source: AGHT+IGuNHudgEbfsicZ7DH/EklYTSenc2Bqy8L4yzgJmanPHN600VhuYmPw5T3UeByMVazLjavu+A==
X-Received: by 2002:a05:6214:2c08:b0:704:9077:e0c8 with SMTP id
 6a1803df08f44-704a4083edemr296398736d6.3.1752537649669; 
 Mon, 14 Jul 2025 17:00:49 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:49 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 03/11] MAX78000: Add ICC to SOC
Date: Mon, 14 Jul 2025 20:00:37 -0400
Message-Id: <20250715000045.57332-4-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf34.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


