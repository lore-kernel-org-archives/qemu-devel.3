Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BF5C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6T-0002If-L6; Mon, 14 Jul 2025 20:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6Q-00023A-SW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:58 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6P-00087I-9a
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:58 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6faf66905baso62426016d6.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537656; x=1753142456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hotAB/ED0EAxC4E6VxD2YUk0GGx5OkOJzrkHwOKZueo=;
 b=ePv55WvqOlwVp6fQonDn2rpIEss4Oyv8gO4OubiIEW5kZ2ynI/HtpEbUR50s2g4XxN
 UED4k95OxYA2Gc3xubSoBFiHIKqWHZILE1Wuvv/FCgxPQYAqWzHhE/oMFL6o+riz0EE7
 RA8ge32e9jXoUN/3bsUhcjKreSissPSi9QAUgBTM5E+NDkx9H5hxUa3USLqMMK3ROfoq
 7mgdNI2+5aMAx0oYoBt9xlOZdo/AJtyKVznm8Nj29v5P0tWO01HPUwNzFHG2HdpN8HJU
 ydk/Ybu24PaTwsqCpJtbkIHLzLYRzpMliDuQOKR1LVMBJtV9DQwwkEswW7FuQbiO9ZR9
 lBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537656; x=1753142456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hotAB/ED0EAxC4E6VxD2YUk0GGx5OkOJzrkHwOKZueo=;
 b=TNgy6kdmO7pBFAJL61Aki+ZdBIPR0CahFFvQEaRvPKhzjoTPAdLEWqeZZoUWxnfnK2
 acDAfaK5SREiJH/uY6gvKLJD09cuJvi4R9elh37nC3uJEnwMIrl8m1/WiFiACNLquqhn
 L+kgM0xDYt8W6sv8b4QWr+bueMoxMI8H2eJ0cjOtqTNLRo4uQ3Du8ApjfrbMpA9W0ov0
 V8nqXSW9D6cuZbVfHuOouhHNZAqZuya/1bnCoZkNvE6wmrftABkLRrdooD5edP7KuWEM
 Tim718mz5mVs5xCJDkdptOZDGg10ZU7pQ9UQ02bQl9W9VpQP3d8hLCo19MvFt+H95ncH
 Fq0g==
X-Gm-Message-State: AOJu0YwfolZto/k+7FTcU+Kbu7QSBDkWIy7cEg4uRpGYllckzN4vHdfe
 q+tyQHnb2RQpTgTpet4znMx+VIzeH783wy8y4UeQ47VwB/2oyd/pEv9xa+RGTQ==
X-Gm-Gg: ASbGncuvjfIAjPUo/LCPj0PDrTKZLcpLWdxZ45OjG6MrrBJmUMg/hrLZPspzcV2JFSo
 f4T68BuVTBGpb+a1xbQYDiKrAxgetkMo9MIrhBYUabBAjtwPEtevOpnRKzVecb9e63a6OL0Zqw3
 My2SDpD1t96rTrvRgZm6rV6d8qTGYTWrvouNW5hAIm12koAIX26/18reKyA+CqOcf2MKQtwP749
 Q+r59dWXYgXeNZNN85a+WbU7hDBE0NrMjsHVOHRM/j5OZv9A5WG7sRcpHgFG3hknSUCNPhaZhmW
 Ho4u83N0NJqF8eUPGvZMSw/CE78QQeqrJLuP2YBnJePcgPko80OXPc6ZOIKQMfFmDlN4j4GFz5+
 AJ+UAOrx0XbYNcSSV2kv+Y2gp6EAIjR4ZCAyhW780F7TZYEY=
X-Google-Smtp-Source: AGHT+IHIdCeUxp5Yk1g+2YVCVYE6QZWc4o7KO8OvObEGiFpgUrh+blnlSJ4P7K2o38CkJ94AMyPIVA==
X-Received: by 2002:ad4:5ce8:0:b0:6fa:fc96:d10a with SMTP id
 6a1803df08f44-704a421daa7mr315938426d6.27.1752537655441; 
 Mon, 14 Jul 2025 17:00:55 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:55 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 11/11] MAX78000: Add AES to SOC
Date: Mon, 14 Jul 2025 20:00:45 -0400
Message-Id: <20250715000045.57332-12-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2e.google.com
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

This commit adds AES to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 12 +++++++++---
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 3f2069fb03..7f1856f5ba 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -45,6 +45,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
 
+    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -133,6 +135,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
     object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
 
+    dev = DEVICE(&s->aes);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
+
+    object_property_set_link(OBJECT(gcrdev), "aes", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -148,9 +157,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("powerSequencer",       0x40006800, 0x400);
     create_unimplemented_device("miscControl",          0x40006c00, 0x400);
 
-    create_unimplemented_device("aes",                  0x40007400, 0x400);
-    create_unimplemented_device("aesKey",               0x40007800, 0x400);
-
     create_unimplemented_device("gpio0",                0x40008000, 0x1000);
     create_unimplemented_device("gpio1",                0x40009000, 0x1000);
 
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 528598cfcb..a203079ee9 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_aes.h"
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
@@ -41,6 +42,7 @@ struct MAX78000State {
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
     Max78000TrngState trng;
+    Max78000AesState aes;
 
     Clock *sysclk;
 };
-- 
2.34.1


