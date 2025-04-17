Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBA1C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z85-00073d-57; Thu, 17 Apr 2025 19:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z83-0006zn-T6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z82-0003uI-27
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so6976875e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934324; x=1745539124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BisZb8cnL3Qhu4Zao2XQnv9XLrWqIWO9ZQzoyvXQRoc=;
 b=lH7Hs1+FoFYAUi8RHv3bSg/9yng2VfplsQQ2jPxN2rRVm83H6sbMY6cogNXrV0VLxY
 Ad6NB6vTc4zBH/D9GMdus7048UGjG4NExofgjknZmiC43Sj4ikZ/z5Il5J9RdZuzUL2g
 T+mzpBaLrBCOn+OYd1oUszIZ67ssdw4ng/AN7Whr5BmUxY6+8d2z2HjB8AwVeTdJroGu
 1RJzhpuZN7W7DQI8w7EJHin3OiNgNLk8eQm8t32IsVHWVpsRJA9wUapOIH/wnYoZWIv2
 yhhjmwg1gYiXbmHDPf5cpQ9Bm3Lwk79WYCfd9AX43y2kEGXun6nnm7feBC4Ct9LLb2N7
 Nnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934324; x=1745539124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BisZb8cnL3Qhu4Zao2XQnv9XLrWqIWO9ZQzoyvXQRoc=;
 b=Bbks1+hwOnt/OYXs5go4FZea9eRSpAN3cKCztAI6V/R9zJ6Klrm35UJKsQTWMtZJkW
 uYcAJKxbGyyuhCNwI7vfEuX/ufOeQBkCLO+YDGTb8LE05o4SdgeJ8XcH3vio+G33M/IN
 CIO+NK/wn5jBAFPw1cE/w0SzSP01XDp0laoy3wbFaDmva6lymhvYcdjWGeOk/M2E9ZeF
 92tPyQ8dPbou+5+ng5ANaCvFiOyv4pW4Ewa3YLeLi4jwlr/owpuu0Zi/NOxNtIDkb3H0
 rNp1LPEznJFPEo1yBHmkWk57t4vgj3+DX8vBojVdjKUaHM6p/I6rDDoZZvvKKWYI3dhD
 p6Sw==
X-Gm-Message-State: AOJu0YyaEoMk+4cKqln/wdggYvZqkVU5jgXRutxqy0gB+zEOowB3J4VC
 hJJCjGBFOYSTHmMBD+dsxIgKauVzfSjkOPp9IUCQ+fRB6gmoaa9VYIy9Gz5FGMxFGQA5s2EJokr
 g
X-Gm-Gg: ASbGncuCVBDyZgJUMIQti3rhes7IunGS/x7ehiaSOMB2K9yNvaMSgkRzGms8+HkgTgC
 pF+3aOw3/uCcLAS3iB3wXe4Zzxcsjo3ZyLC0fAuAGnQKZ1E+gln+/yWAnJ1GV9cs9Se6WzW4xvJ
 CEOoagavvTrN/SfqqLMCIsfqMNuEntvJjoU26Shbi6cUfkRdkd578/nvzqY3xJEHr6zlZljCR3/
 L76W+dhkY6sQmotSErTRs1Ja8zWhoPqxOXZaX08caKnXmG2zbBDDjry4NmO7k9tOjRLJffMxUTV
 TlD8NMNoYXRLkSc0ngshOmHuTec1/BwaTXCTwP+C/riUO6rgPj5s6nE2ut5ze5UWPLRdeYe+ZAv
 8rm+nO7/Z/9iHLTsL/sFz
X-Google-Smtp-Source: AGHT+IEqqA/+uhtD+GYHQlqkz2bQ4WpgqqL0oVRkPJhIfadBIl9HW6H1odSRzX38ma6fd5oCkz42tQ==
X-Received: by 2002:a05:600c:1e10:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-4406ab95a4bmr6529345e9.14.1744934324153; 
 Thu, 17 Apr 2025 16:58:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5d712esm910885e9.36.2025.04.17.16.58.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:42 -0700 (PDT)
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
Subject: [PATCH 05/11] hw/arm/imx: Define machines as generic QOM types
Date: Fri, 18 Apr 2025 01:58:08 +0200
Message-ID: <20250417235814.98677-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/arm/imx25_pdk.c     | 14 ++++++++++++--
 hw/arm/imx8mp-evk.c    | 15 +++++++++++++--
 hw/arm/mcimx6ul-evk.c  | 15 +++++++++++++--
 hw/arm/mcimx7d-sabre.c | 15 +++++++++++++--
 hw/arm/sabrelite.c     | 14 ++++++++++++--
 5 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index e95ea5e4e18..a90def7f1a2 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -141,8 +141,10 @@ static void imx25_pdk_init(MachineState *machine)
     }
 }
 
-static void imx25_pdk_machine_init(MachineClass *mc)
+static void imx25_pdk_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM i.MX25 PDK board (ARM926)";
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
@@ -150,4 +152,12 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
+static const TypeInfo imx25_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("imx25-pdk"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = imx25_pdk_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(imx25_machine_types)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 967258e6484..c7d87d99230 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -64,11 +64,22 @@ static void imx8mp_evk_init(MachineState *machine)
     }
 }
 
-static void imx8mp_evk_machine_init(MachineClass *mc)
+static void imx8mp_evk_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
     mc->default_ram_id = "imx8mp-evk.ram";
 }
-DEFINE_MACHINE("imx8mp-evk", imx8mp_evk_machine_init)
+
+static const TypeInfo imx8_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = imx8mp_evk_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(imx8_machine_types)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 86982cb0772..d947836d2be 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -68,12 +68,23 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 }
 
-static void mcimx6ul_evk_machine_init(MachineClass *mc)
+static void mcimx6ul_evk_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+
+static const TypeInfo imx6_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("mcimx6ul-evk"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = mcimx6ul_evk_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(imx6_machine_types)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 33119610113..f5dc9c211dd 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -68,12 +68,23 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 }
 
-static void mcimx7d_sabre_machine_init(MachineClass *mc)
+static void mcimx7d_sabre_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+
+static const TypeInfo imx7_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("mcimx7d-sabre"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = mcimx7d_sabre_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(imx7_machine_types)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index df60d47c6fd..ea59ba301e7 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -103,8 +103,10 @@ static void sabrelite_init(MachineState *machine)
     }
 }
 
-static void sabrelite_machine_init(MachineClass *mc)
+static void sabrelite_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
@@ -113,4 +115,12 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
+static const TypeInfo sabrelite_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("sabrelite"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = sabrelite_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(sabrelite_machine_types)
-- 
2.47.1


