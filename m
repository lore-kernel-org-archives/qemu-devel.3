Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE35C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2s-0002A6-60; Thu, 15 Feb 2024 13:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2b-0001nM-Ha
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:59 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2U-0002MH-K5
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:57 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so1614582a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020048; x=1708624848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ubSQX0s8XFIX39hOsqAJ21CHgufQEziwezWtT3SVxQ=;
 b=NdyP/VV2u7egJYv8FmmbmbmB/X2HN2b4XDxhpCaag+Ng0hsxouIBLxagswdFXToxou
 8lkDyt0/VDgzfC2EaUSj0pflzkirbaBG+9HHiP5gtyPvZMdZtuLA62TvR0HidW0/o1CT
 gEbL7IggrmXab2/mEN7sj6QEx/D8sHOcmRNwnq6SzfxGLOOL9BtTQJdZt5V9PNpD+VCA
 OkmrgyDqjtFwKiUgjHeuvnyuvy99wfl+JWA2UJ3negeU6PywE8pxlJDZUMPisVDs8klI
 +3PcH9PrHJNluQgUeJ31IuJgWAJJ/kOauU1m+WRvSpRZPbTOmtqVvIdOkULTwRYz3AeK
 3ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020048; x=1708624848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ubSQX0s8XFIX39hOsqAJ21CHgufQEziwezWtT3SVxQ=;
 b=jGmr4hDf8BYgAVUeXgrGNVY6KUsyaRJ2908Lv86dt96vxlpNRk5GTAgjLGfpPn7GpD
 OqHXgKd3negThsf+3FaKiiNRbc4QBomSj469NeiSSZ1DbuWXDo4TPSOpthUIDRxwFs2i
 DXHRFiQdUQ5vFjGw2O9eFMYAZPhamDstcPUE97n5lauxuIYaC3YYVhqvEk3V20Ce7RBy
 Wo8s1OqHObQs7ONhTq4On7rfkmMFtOfgZlzuHDjgjb6Ox5UDvRQQi8WdAawltzeFjZ7Y
 wEJ5Q6tpp0U+q1TTurtna/E1hJicU+Z7yUO4eHyk/ZFaxLVfQrbBAwwCE/CuKEXieZQl
 MD6w==
X-Gm-Message-State: AOJu0YweE+IPV6UlwQl6SCQjPer/0GE9q4Z0JpzrzB/Ns180xc2sci83
 kSg0Vt3W7Ak9Qc8uSM3a7atg5vY7RUPfSOKRNfxjCc8c4WzU8LzJQfhMJCYIyGrvFsiHevBwsfN
 G2aU=
X-Google-Smtp-Source: AGHT+IGJbaHQZ1eeAOaIiG/S1WoGru5XoFqTkRGsl13ISfMES8bQ2V27fYMKtcfrPg6Pt1oI6wpyiQ==
X-Received: by 2002:aa7:d38e:0:b0:562:f25:b125 with SMTP id
 x14-20020aa7d38e000000b005620f25b125mr1825343edq.36.1708020048674; 
 Thu, 15 Feb 2024 10:00:48 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 fg8-20020a056402548800b00562ee409ea0sm740914edb.62.2024.02.15.10.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 26/56] hw/dma: Pass parent object to i8257_dma_init()
Date: Thu, 15 Feb 2024 18:57:20 +0100
Message-ID: <20240215175752.82828-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Set I8257 instances parent (migration isn't affected).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213114426.87836-1-philmd@linaro.org>
---
 include/hw/dma/i8257.h | 2 +-
 hw/dma/i82374.c        | 2 +-
 hw/dma/i8257.c         | 4 +++-
 hw/i386/pc_piix.c      | 2 +-
 hw/isa/lpc_ich9.c      | 2 +-
 hw/isa/piix.c          | 2 +-
 hw/isa/vt82c686.c      | 2 +-
 hw/mips/jazz.c         | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index f652345d65..4342e4a91e 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -45,6 +45,6 @@ struct I8257State {
     PortioList portio_pageh;
 };
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable);
+void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable);
 
 #endif
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index f6ddfc51c5..e72aa2e1ce 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -129,7 +129,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "DMA already initialized on ISA bus");
         return;
     }
-    i8257_dma_init(isa_bus, true);
+    i8257_dma_init(OBJECT(dev), isa_bus, true);
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index de1d5b110c..24a54ca272 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -632,12 +632,13 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable)
+void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable)
 {
     ISADevice *isa1, *isa2;
     DeviceState *d;
 
     isa1 = isa_new(TYPE_I8257);
+    object_property_add_child(parent, "dma[*]", OBJECT(isa1));
     d = DEVICE(isa1);
     qdev_prop_set_int32(d, "base", 0x00);
     qdev_prop_set_int32(d, "page-base", 0x80);
@@ -646,6 +647,7 @@ void i8257_dma_init(ISABus *bus, bool high_page_enable)
     isa_realize_and_unref(isa1, bus, &error_fatal);
 
     isa2 = isa_new(TYPE_I8257);
+    object_property_add_child(parent, "dma[*]", OBJECT(isa2));
     d = DEVICE(isa2);
     qdev_prop_set_int32(d, "base", 0xc0);
     qdev_prop_set_int32(d, "page-base", 0x88);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 70d12bb1b5..999b7b806c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -310,7 +310,7 @@ static void pc_init1(MachineState *machine,
         qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
         isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
 
-        i8257_dma_init(isa_bus, 0);
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
         idebus[0] = NULL;
         idebus[1] = NULL;
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3924eec483..70c6e8a093 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -739,7 +739,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
 
     isa_bus_register_input_irqs(isa_bus, lpc->gsi);
 
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(d), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&lpc->rtc), "base_year", 2000);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 344bf32e54..2d30711b17 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -336,7 +336,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
         i8254_pit_init(isa_bus, 0x40, 0, NULL);
     }
 
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(dev), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&d->rtc), "base_year", 2000);
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 0c504de36e..aa91942745 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -731,7 +731,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(d), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 5bf3e328db..1bc17e69d3 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -289,7 +289,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_register_input_irqs(isa_bus, i8259);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
-- 
2.41.0


