Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B3C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 23:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z8a-0007TC-4u; Thu, 17 Apr 2025 19:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8V-0007Me-BA
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8T-00042o-2V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso10390545e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934351; x=1745539151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6spRcSY1vluyMm8JkI6J8jm+JdzV06eHRFB0YKd4AUg=;
 b=d33UQDQU0v1l+Saya3wMYH1Mlf6YsXqvVdHFI6Ls3w6OGSM1c+JA4nckl0r7vx/jn4
 Df0kAQg7oQKop89NoYXVGY50XQEIoQnKHWzW1ap7E4LPhqAeWTRhOrgQrX0m7xFX4ZFO
 hf1tKrltAX/Nk8Kd8eS39HBRBvXeBv7ADXjEyDfCKFvPIa1apUiUlNAA3d9cNicwVlyT
 qY+3sXakWOEvZtS4rYnJxfbdKQt3lPfxCbILcrEX7MYNyV2IaKXvOu+RtOxrUgIBf5gM
 k1oboIZjsRWaN/8ZyXprW5gBHIoDoBzMTKSvpyYLbUhP9ZhtzDiU8+NAgGnAAxwAMPzk
 joVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934351; x=1745539151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6spRcSY1vluyMm8JkI6J8jm+JdzV06eHRFB0YKd4AUg=;
 b=cW2WCDNioZq7lDW61jVhdZrbr1NQlZV9ed+6dkauHExMzoyKNxMZrMRr4vIVubfaqd
 Ch+mn4qo0pRCchu+6/7ECOBA0WEyZydzxMXkin2qW5+kFEguYauhjmXF9hNFpIHdZcUA
 hrpqA/jLYGfgJdx4ult98wEEanACiiWDHJ/nHdtCKvpbhE8XPikGH/rdlrUxmGJp0hVk
 Fs1upuqiy62xFg1aJSGe1/j4LKGR1UpJVb4ZnEu8jYAwkC2pL5CvC5AyA0uqYrT6R0Wj
 hThT3MVEMq49jHxdFw2/O3AUCCv9Q5cNuHZxLFMDuS8Abk9yncJaJ7jlKknvFve8wSm+
 XCqg==
X-Gm-Message-State: AOJu0YzDiUCkIIO2JnCKlzZGCIZtitPH5VsWi8TrPpuXtQfg3KiQnWo2
 ADFRE76lZCTtfOXFT/pn4aIQ8lQLkGIjORy+SXerIB+WuFYK7qxyNBj4Dbf9b5lx2J7R9SJzk6f
 2
X-Gm-Gg: ASbGnctHL/UYgZNYLyw3PE5/DBgbHQYr7Uk7scyGrPMHQ8hDj8YvGhyVrB5dBzLZJ4U
 5zo36bD1oM1SyvDbSQlLmANKcQ5TKzNwr8cr7e265/YpozMSToHVN1Vn4aWCtY+MGtML+o/TW+T
 l1bhjFqw5lWSpzR8r48H/ydvR2LyamWr2/HNJX80JSVcP9uSITl2RsfhMETf6zzfWpv7Ka4U77a
 7i/yTRGE+xbH9+E4JPj2mpGCqoVUo5qPJbZiAo6Q08NF0JtA6Fyvqmn+OKZi0UxE2nSHnWKe5yj
 PSf/WdX5Pn1YD3BZdfP5crpyqW0xu0Ns/yxZwJfjcfbGnPkz3eHpjQDmzKz7jfMvhY+l2zgv++f
 QdQ6ffcd/11NiRpivzTIG
X-Google-Smtp-Source: AGHT+IGJeRSpkTsSNEDUftBbkBg4fMh73cBtzlZDtJDGc8SWPjwMCT5TM8xa4tl4Jz3a4gv0QwhstA==
X-Received: by 2002:a05:600c:4688:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-4406ab7fa86mr4705495e9.7.1744934351390; 
 Thu, 17 Apr 2025 16:59:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493145sm1047120f8f.71.2025.04.17.16.59.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:59:10 -0700 (PDT)
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
Subject: [PATCH 10/11] hw/arm/orangepi: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:13 +0200
Message-ID: <20250417235814.98677-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 hw/arm/orangepi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index e0956880d11..6821033bfd7 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -103,12 +103,13 @@ static void orangepi_init(MachineState *machine)
     arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
 }
 
-static void orangepi_machine_init(MachineClass *mc)
+static void orangepi_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Orange Pi PC (Cortex-A7)";
     mc->init = orangepi_init;
@@ -124,4 +125,12 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
+static const TypeInfo orangepi_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("orangepi-pc"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = orangepi_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(orangepi_machine_types)
-- 
2.47.1


