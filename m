Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z8M-0007D5-8i; Thu, 17 Apr 2025 19:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8K-0007BZ-Ef
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8I-0003zM-4d
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so981902f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934340; x=1745539140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1BCsGCYDAReQc5VOE8gGZJI4mqG04gHq5Y6jpZDaC4=;
 b=uRC+/DsV7tbpXnAKDE2x41GqefzqPl4ARvYG4g/7xzZDWQij1hV90ryYOlOnnrQEAD
 j398wwUwcVMtjEkhsHSFZBj7sfAl6uqr2/3+TreWxjnlYzCn/+pOjzRzwjSkg8KWjdML
 8RgcSj3IvnmgcjQ+Xh4wXTVvspykrIpl1Pob1LEPPmnjBU2+6K7j/Ci74+PPM0ETP/XP
 SqDCDyvpNWVfQPJj9tDIRYejHoxyHzLuMkbrdV8EI5zvAHP7QWeAj0xp42Yn0APEJW9T
 d875Qi5CSq8RDjRb78o6BYn354d94F/RBN8ACF3jbPAl74FQWo78iM/oBkSGHnTTuBGr
 hdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934340; x=1745539140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1BCsGCYDAReQc5VOE8gGZJI4mqG04gHq5Y6jpZDaC4=;
 b=pEzkwojPuggxF3FWoG7cpRfVill2YhxgxruJgUtXX/M2Aml+yJ1tCoj4+EAbfnBEAA
 w0tTxtsd+suUerkO/oLUy3O4Ne60tVP0G/nKz59KKnr8lEQqRMF2W19oBxBnLvTSCn0o
 AlGnjE7Ay5WJ/KSTe/yDnYentJxcRNanXJ8I2Z8rraYJc7CMRuPE9tzu4tUzY67HO3ZY
 gkdcHrhs+1qzI38vjx29LQEGN5M7YbERvqbMxtEgZHHkHwTIH0thQ0CFobzEHVnM33QP
 nJqZXwa6MK3OT6eDKIZ4SEIao/I6CmGDlhTV+9+D4ykzhcAMg0JE7RwxgKLZW63FDwVQ
 mINQ==
X-Gm-Message-State: AOJu0YxVG3A0szVGYSRFsgULAKtioo5cVoVMbIBSLvpXe2Z9KUPmBCqb
 DXrWbRHyw98x7TjT2kKYzrLdK9BWboeHKeIehmAKpjxd7PFVvBYFFM4JKw9r0xzhClpFkbVa47b
 U
X-Gm-Gg: ASbGnctdzg4rHjuB9UY9nODit+H55Z7gbQJNfkAlo4mMJWpUi2oVs+mFWLGaOorEIwB
 VUTSL8S/z05ZC6qgeSbFXZL14OrlyBu/60PUiT2ASwW5KjbCydqnlIEKpo6/YVu2Yv9JroxT985
 9WUG0wM5SEh5CxHs/u8yMoen2PTCqrrbzd6af9yGzXGqFbvSJPGXHgV8v6gwDKfRaELX3zWLQrX
 2cb8Ii9n8cRQFHPkuA26y8EnpYOy4Jsrkfv74ZENPypz5k1gFGABEmMJpZ12U+EhnLjZAbKWWe+
 Mo2Gq3NekNc7iqBx9Xjdys7JaU1cQ3Y8woe2NWYfnWWuUzJpvgjFeTe6fJstClfnReeNGxn6SPZ
 1ksyrNFCAe2N2w/f7SYZRN1t/I4wucLA=
X-Google-Smtp-Source: AGHT+IEDpTMUX0uRQZSemp7qi19GY7B28O8lb3sq7waZh3jz3/xEgNL/nlTlZyOckM/lmaBr/nEviQ==
X-Received: by 2002:a05:6000:1ac9:b0:391:253b:405d with SMTP id
 ffacd0b85a97d-39efbac60femr501344f8f.41.1744934340449; 
 Thu, 17 Apr 2025 16:59:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa49312fsm1045843f8f.70.2025.04.17.16.58.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:59 -0700 (PDT)
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
Subject: [PATCH 08/11] hw/arm/msf2: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:11 +0200
Message-ID: <20250417235814.98677-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 hw/arm/msf2-som.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 29c76c68605..6ce47eaa27a 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -96,16 +96,25 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                        0, soc->envm_size);
 }
 
-static void emcraft_sf2_machine_init(MachineClass *mc)
+static void emcraft_sf2_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
+static const TypeInfo msf2_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("emcraft-sf2"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = emcraft_sf2_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(msf2_machine_types)
-- 
2.47.1


