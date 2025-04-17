Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE759C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z8r-0007jM-RS; Thu, 17 Apr 2025 19:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8b-0007Wu-GB
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8Y-00043y-Hj
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so9672565e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934356; x=1745539156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYqZLGf8zmbZFL30Ike2RIyikST1A7pLxDDWpbB2TD0=;
 b=SaKp7EjgfIqzFtkuNxD4GGT/ezwJwqluK5E621OGUovQ9fmgQH3YHb6U2kP3VEgp37
 O+MibXr86Dw0cUU6oTZfobPECTsVTm8OftyhJCvqBRgQyv26DVCs59NGYd/fkRczWtR1
 qCGajpb6y2+bedcxWTMda73UuvVPSvCxPMn5Inl69QKXwup8h1DGvHxuHgdoY6uUC+tH
 otc4LNxdm56xrBsUPu2F5yKd2u4C3/uQAQUEpaZMMtvNT6e12vOL4Q7PVs4lkdCWpEkM
 mZz6UUXrZGehZvgA1RMKZPBoFZieqTpfKH4WxIzoy2krBJY+eRyN51PdWZOUu8bjiOzu
 LyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934356; x=1745539156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYqZLGf8zmbZFL30Ike2RIyikST1A7pLxDDWpbB2TD0=;
 b=MFeCOemOxcrOCVAoEoxmm5ZpiwrDhpYBWp+C2d+3wxvzrQv21/nhV4ZZ3Scc4YQBZg
 tc+Sfq1zXT9yKlPRjhMmqysoL7Dnk9H9imsRByZOFza84+pyTE/xo9IrQjefkqzOYJfG
 OuhcveiwkFCOTL3w7TOJVmxSlT3fbGY3aef4rR9JpJ8lEuLMFyDHEvPkUFl1l1zqMAwy
 UrkE1XMdBtXjv1lKEsemnve9+dx/Ob73C3EJjOED13msVzdmRSfa7xtYVOwn7nGlPg3X
 YYlOn5hLlxTvBv67+MPbfB+P5HucMzbZUPeHhvVS0p/mH/aEVHfmr5TkSEwVd6zsWHte
 VaPQ==
X-Gm-Message-State: AOJu0YwTz1xje2i56NkEegsWaedWsfS87JQHOzxe+1qiTqojI8EftiXT
 tB0K3pybypj3fwes4SD6vUh+seRaLb4yW+LkDZTzj5SCPVB7yh5ODFWErVZTDPB7/ewXugOF6sn
 G
X-Gm-Gg: ASbGncvvBfvy8y/lJxovftQ9vWVi/8l++lFYcjqkH49YWzqdE3xlckR1EfTBNQfeJyj
 BU268GF7FvsIHDVfdKAUbFKig7tKbyWuuoxRKIXwSmudjxvljtsSJLEKQL6PfwPVPxU7V7vsGJK
 G2Sdibr28l0xqyZUo19Kn98PhyRGhhk9fDSsZsKrx4eCxl2yJUL/ToHjHuhmyNW9wWEAo95sUNz
 gnNoE//icjmtWtZVLMAveo4uj1HT5BwnW4RPCIyJZNeKvjqe/w0TvKFpjbwC7HStHVKPi7+zSkS
 iFUo6xQGJUIW18kK5bMBckv66+E5w9//CS/FvDptO6fgThqYaJFUijuvgFUM+PnGNN9RewVu5GR
 p40whffGZc+f0MBNPyP0c
X-Google-Smtp-Source: AGHT+IGJABW0k2ibqMWO8ATcPJ9WqgOvVCj4YT/TVrnnqufMHLDDeO47A8u6MkWDWebqXbUjFD8LsA==
X-Received: by 2002:a05:600c:3107:b0:43d:24d:bbe2 with SMTP id
 5b1f17b1804b1-4406ac1ff5bmr3586335e9.28.1744934356424; 
 Thu, 17 Apr 2025 16:59:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6dfe4esm808665e9.33.2025.04.17.16.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:59:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 11/11] hw/arm/stm32: Define machines as generic QOM types
Date: Fri, 18 Apr 2025 01:58:14 +0200
Message-ID: <20250417235814.98677-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/netduino2.c         | 13 +++++++++++--
 hw/arm/netduinoplus2.c     | 13 +++++++++++--
 hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
 hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index df793c77fe1..52c30055d44 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -52,12 +52,13 @@ static void netduino2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduino2_machine_init(MachineClass *mc)
+static void netduino2_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Netduino 2 Machine (Cortex-M3)";
     mc->init = netduino2_init;
@@ -65,4 +66,12 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init)
+static const TypeInfo netduino_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("netduino2"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = netduino2_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(netduino_machine_types)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 81b6334cf72..2735d3a0e2b 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -53,16 +53,25 @@ static void netduinoplus2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduinoplus2_machine_init(MachineClass *mc)
+static void netduinoplus2_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
+static const TypeInfo netduino_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("netduinoplus2"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = netduinoplus2_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(netduino_machine_types)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 1f15620f9fd..795218c93cf 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -56,12 +56,13 @@ static void olimex_stm32_h405_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void olimex_stm32_h405_machine_init(MachineClass *mc)
+static void olimex_stm32_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
@@ -71,4 +72,12 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+static const TypeInfo olimex_stm32_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("olimex-stm32-h405"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = olimex_stm32_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(olimex_stm32_machine_types)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index e6c1f5b8d7d..3a9728ca719 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -56,16 +56,25 @@ static void stm32vldiscovery_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void stm32vldiscovery_machine_init(MachineClass *mc)
+static void stm32vldiscovery_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
+static const TypeInfo stm32vldiscovery_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("stm32vldiscovery"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = stm32vldiscovery_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(stm32vldiscovery_machine_types)
-- 
2.47.1


