Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3473FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTY5-0003BJ-BV; Thu, 04 Jul 2024 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTY1-00039Z-PS; Thu, 04 Jul 2024 16:59:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTY0-0000o4-58; Thu, 04 Jul 2024 16:59:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77b51631adso111483066b.3; 
 Thu, 04 Jul 2024 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720126758; x=1720731558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1w/eX2oNbEsnlwhGjCo1wYurYBqtnWpvreS8acswyfA=;
 b=KuysVReyHLL3zEUeueXUQ+GD9VQu7qYqOEJvkCmnYej39Sx1E05OgEHNK0Kl71I3qD
 0VNgI4JF/RH75zHvy42osT94S6nAgbDCo4tLopszFXC23tuJwKXqUopoHoMzRLlzwRtt
 G7j61dL8aRNZFes57wmCAmcG4SFjQUb5hnIYMkgb2rVNshxow9q62JAccNpQHk7a3fvw
 IHKz69QOnr4jmqmeWHxmjFDNUsN+NSnheM7HezfboOwCjy9nBlULQWvsEo8AnVpNXocv
 lLRrpeiZjE4bD/yBMeV+1uPQtw5a+zjXBAEaZJOPtJGQ/JYrBhkFOvYZgZ01io/W5nLH
 gHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720126758; x=1720731558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1w/eX2oNbEsnlwhGjCo1wYurYBqtnWpvreS8acswyfA=;
 b=iYUEwWRsG9kELxamI8W9Q3lFstEnpL2E7RCHbrGQWmU/2kzacBNRUHJKKRMjqVGaVW
 g4zsg0lvCJIPfJVLlgR26Kgj7s9VObVyEl8MyWb00AQ4355HyNlVC6xcZoyFLrLWZiWH
 B+ywxeK5HTTNr21NGz1Q83k+bng1Mpjqq6rUERf94UqOwqvYYAo73fHg4UTrRysJxBM4
 +JlKgn1t6K41Zb2kebfY/FYzrSWyD06tenbjeJX/nEcvoSVYwxu5vLYVCxId60OAljNb
 OF0z7N1eeKHhvL6dgSncA04oagwAOmTeYrnuElz1GFKu+jxTmmokAPnHH78FDyzQzxnE
 1OaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNTnK2tJfObhhd9nBPK6uiKNLMJgu+nHIUNcD4mdVf1D4X8Q1WWy8H3I6jFBP0+iT5dkkJFsEjYVVtMkLYJpX7EVrp
X-Gm-Message-State: AOJu0Yz5u/ddCV9+1woOWNQMcREA/llGQ4GGE2G82poUW8xGI45msgMI
 QzZcN/U+tlCjn6CpM8r48zZWJRxcQuU/lNNCWsgTWdZ+El/ybi9WM+oc7Q==
X-Google-Smtp-Source: AGHT+IEIA/cUvUMeS9h1q277YSoEDw1tbuUH2VwVfw/0l7um7wk/ZvhqX9m1JZafxhCRhqE3hRw1iQ==
X-Received: by 2002:a17:907:3342:b0:a72:840d:9ef3 with SMTP id
 a640c23a62f3a-a77ba711881mr171572166b.48.1720126757653; 
 Thu, 04 Jul 2024 13:59:17 -0700 (PDT)
Received: from archlinux.. (dynamic-077-188-087-180.77.188.pool.telefonica.de.
 [77.188.87.180]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7400456582sm526153866b.153.2024.07.04.13.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 13:59:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/3] hw/isa/piix: Resolve intermediate IRQ forwarder
Date: Thu,  4 Jul 2024 22:58:54 +0200
Message-ID: <20240704205854.18537-4-shentey@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704205854.18537-1-shentey@gmail.com>
References: <20240704205854.18537-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When @cpu_intr is populated before pixx4's realize(), it can be directly passed
to i8259_init(), avoiding the need for the intermediate piix_request_i8259_irq()
handler. The result is less code and runtime overhead, and a fixed memory leak
caused by qemu_allocate_irqs().

Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/piix.c   | 13 ++-----------
 hw/mips/malta.c |  4 +---
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2d30711b17..e070628f25 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -81,12 +81,6 @@ static void piix_set_pci_irq(void *opaque, int pirq, int level)
     piix_set_pci_irq_level(s, pirq, level);
 }
 
-static void piix_request_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIXState *s = opaque;
-    qemu_set_irq(s->cpu_intr, level);
-}
-
 static PCIINTxRoute piix_route_intx_pin_to_irq(void *opaque, int pin)
 {
     PCIDevice *pci_dev = opaque;
@@ -315,9 +309,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* PIC */
     if (d->has_pic) {
-        qemu_irq *i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, d,
-                                                     1);
-        qemu_irq *i8259 = i8259_init(isa_bus, *i8259_out_irq);
+        qemu_irq *i8259 = i8259_init(isa_bus, d->cpu_intr);
         size_t i;
 
         for (i = 0; i < ISA_NUM_IRQS; i++) {
@@ -325,8 +317,6 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
         }
 
         g_free(i8259);
-
-        qdev_init_gpio_out_named(DEVICE(dev), &d->cpu_intr, "intr", 1);
     }
 
     isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
@@ -402,6 +392,7 @@ static void pci_piix_init(Object *obj)
 {
     PIIXState *d = PIIX_PCI_DEVICE(obj);
 
+    qdev_init_gpio_out_named(DEVICE(obj), &d->cpu_intr, "intr", 1);
     qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
                              ISA_NUM_IRQS);
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 664a2ae0a9..50823bd5fb 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1238,15 +1238,13 @@ void mips_malta_init(MachineState *machine)
     /* Southbridge */
     piix4 = pci_new_multifunction(PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
     qdev_prop_set_uint32(DEVICE(piix4), "smb_io_base", 0x1100);
+    qdev_connect_gpio_out_named(DEVICE(piix4), "intr", 0, i8259_irq);
     pci_realize_and_unref(piix4, pci_bus, &error_fatal);
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix4), "isa.0"));
 
     dev = DEVICE(object_resolve_path_component(OBJECT(piix4), "ide"));
     pci_ide_create_devs(PCI_DEVICE(dev));
 
-    /* Interrupt controller */
-    qdev_connect_gpio_out_named(DEVICE(piix4), "intr", 0, i8259_irq);
-
     /* generate SPD EEPROM data */
     dev = DEVICE(object_resolve_path_component(OBJECT(piix4), "pm"));
     smbus = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
-- 
2.45.2


