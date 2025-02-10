Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D84BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thace-00078N-OW; Mon, 10 Feb 2025 15:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacV-00073w-PM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:07 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacT-0003et-Hw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:07 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd9b3419cso1030189f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220183; x=1739824983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAVRicxK4K9Kq8EWK86Z7wtR9JdvR1JNSPA3JXMRgOI=;
 b=F/Nt/ZuzvgAKz4rXFSfgjUThduJ9ealiSuIvcZwCC6mAzVFbhcuVpBnMmcTr+u/Qob
 Y9Cb8I8GwWJyYY8xGIvuiqs4tcOuZckvocrzwNb6Owxrau7HS0XVgoOO09EGjyvu148J
 pKWUKjxjovdS01+saGIimWAz6RUCgoisY8th7HsYPx915lekFSikHYeuWuN7jycYzLFq
 2G/DEnMzZzLEGxcBYxOShAmup2ASc3S+kT1ct337NBzDEpAVT5FFeO2tTLCW/Q7hsknJ
 PrCXqMgZBLRSxfwVO/BBm0aIr/KM3APL4tne4u/EI7b9gOm3gcpnCRr0rsbJLDLknDmO
 eV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220183; x=1739824983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAVRicxK4K9Kq8EWK86Z7wtR9JdvR1JNSPA3JXMRgOI=;
 b=HZkboRn889RWMUTFFGVlMoLMigjfZSu5jifcyV7GeAr+oDWGJucuUW5MnD2jWRB45S
 ADigz/LoA6+2L4rbq95FFGOPEyC3JLKd9f+ZvYjulbHp1dHqzwDViLwXFxH+cEiY00ak
 iSz9U39sr+MH1SSAa3qexKqntQL5wgUIKJzhC1bStCFnaC9F3Tg0RduIUhmrXoGsJRd+
 G9b2OmegEmwvsTzuhuttfHtINdMSWWAPRw3EQPkrORyJAT/ldmCKa83A5uQiWB3Gf66a
 KYDd+J/SJlnG4+0hifMOrTrvJmRrgvxeSVgOu+FdFfHkKBcstEiJdS9smK2G13aLlkIN
 qV3A==
X-Gm-Message-State: AOJu0Yzk1iGT4yslN1meWLLwC8tl0dD2YyJQ30uZWp+v67xwGIBhw1YZ
 PCSfc0r4crXsdHk1WRUdmpci3YINjgT41zb7O5UWivpcAdL48btpi0X0ihueZXt4YVWXHF4VLdE
 sZH4=
X-Gm-Gg: ASbGncuIcQ1b3KlZNZVdI1VdocD1tO1N8SsrUb/tW3F913UxGHuf3IYNIDJN3oL6DXU
 GzKjyU4xL4N6S0jngmaVxwgucKeRLBjbxE2LqO19tXSzkeyVVMGJf1COtgPnZodkpmAc5iDCIj4
 o0gb1URcQ5eg2Ul87WsvmlVBW53ppLsshWDJ6n37SivKkQz7oiYALVwacSuPka1VrZ/R8L0CFDi
 mx1w0I9XmFT7GFM8i4deiMQ4Y1IVUP9OxolHVSWNK3yiQf/nn5sqUvbCQXVP1NXKKge30Xm98K2
 Xni+I8vVvKVlUGxOY/AzjScL8qrLTVe6bqPKMZHp0KvRuNnZoCOmqsQDEDFpSWSNVQ==
X-Google-Smtp-Source: AGHT+IEi/cecoR//pPrgCGJzlNCbVXKKhzz2o29C7A6Z6aoYlWdD5x6B4ZEuM3gFSS1vmq8ZMYSwEA==
X-Received: by 2002:a05:6000:1846:b0:38d:e34f:6aa4 with SMTP id
 ffacd0b85a97d-38de41c3ce0mr937828f8f.47.1739220182937; 
 Mon, 10 Feb 2025 12:43:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11200sm189069465e9.38.2025.02.10.12.43.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 11/32] hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
Date: Mon, 10 Feb 2025 21:41:43 +0100
Message-ID: <20250210204204.54407-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250125181343.59151-3-philmd@linaro.org>
---
 hw/core/sysbus.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index f713bbfe04f..075c7dfd69b 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
@@ -80,13 +79,6 @@ static void system_bus_class_init(ObjectClass *klass, void *data)
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
 }
 
-static const TypeInfo system_bus_info = {
-    .name = TYPE_SYSTEM_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(BusState),
-    .class_init = system_bus_class_init,
-};
-
 /* Check whether an IRQ source exists */
 bool sysbus_has_irq(SysBusDevice *dev, int n)
 {
@@ -306,15 +298,6 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
     k->user_creatable = false;
 }
 
-static const TypeInfo sysbus_device_type_info = {
-    .name = TYPE_SYS_BUS_DEVICE,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(SysBusDevice),
-    .abstract = true,
-    .class_size = sizeof(SysBusDeviceClass),
-    .class_init = sysbus_device_class_init,
-};
-
 static BusState *main_system_bus;
 
 static void main_system_bus_create(void)
@@ -337,10 +320,21 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
-static void sysbus_register_types(void)
-{
-    type_register_static(&system_bus_info);
-    type_register_static(&sysbus_device_type_info);
-}
+static const TypeInfo sysbus_types[] = {
+    {
+        .name           = TYPE_SYSTEM_BUS,
+        .parent         = TYPE_BUS,
+        .instance_size  = sizeof(BusState),
+        .class_init     = system_bus_class_init,
+    },
+    {
+        .name           = TYPE_SYS_BUS_DEVICE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(SysBusDevice),
+        .abstract       = true,
+        .class_size     = sizeof(SysBusDeviceClass),
+        .class_init     = sysbus_device_class_init,
+    },
+};
 
-type_init(sysbus_register_types)
+DEFINE_TYPES(sysbus_types)
-- 
2.47.1


