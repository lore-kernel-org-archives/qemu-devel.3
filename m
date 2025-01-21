Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A88BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIzS-0002SV-0K; Tue, 21 Jan 2025 13:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIzL-0002Rw-Hb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:28:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIzI-0001YP-DN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:28:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so66442915e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737484110; x=1738088910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ULfM9b6l8q4oeWzhXzTIGWvB5mpmQqM22IqQpo1/0fQ=;
 b=Jhnxnbqsxj45eVm/39LeN+E+e9ciSQS4DPGiPUhrEuJKlDx3eu0RpwrJyVskV2qW08
 I6uimuLtvBhSj4NC19XDMTglNkNszEUqNaDqinCnYHrMHJXCrq3alzg97iMgeZjLa32Q
 NAJaAc0wjxeyzvNdkFMmAf3jwm3JSTQIBbURZtRqHcTUgBlDJjStrspFeGuDLz6NafY0
 IyH7qXti275Z0WBZSpSdY9BXRw89SrJnkRmyp8LZ3qROcrBf12FszVz/Coto/GYxP0f7
 QnqBLQwj3K57s0QVetMVZiTLP0/jfNRzZaLDADY/qBATp/qJBTqKEsIwyyMdd2lNQ5/P
 39ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737484110; x=1738088910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ULfM9b6l8q4oeWzhXzTIGWvB5mpmQqM22IqQpo1/0fQ=;
 b=bp7d052XDvJ+M0nqwjxboM29HMqqAWQFFlqczkeOxcRq6WdqmLI6MibA7XtxLms0if
 j+IoMjIomW/zIciFuzMxnBWSIIONvTCbPdePGB5Ya19Ciy7Q/dMJovx+ZbsTDPbK4EZG
 D+6xC9taa4hIQefdc9ybOay6Bocwy9YEf93SMNi6NUlGOBx8RrtmrtWizHGoOjPFXrh7
 p3v0VLshEi5Te+rtSXoTHsXFNkvGZFsMKdoq76YR9DPXLI+RTumkdPGWm2jjq3yvSfoE
 AHU1ua1as372tEzpuwwFDBpeeXJ7ORy5PAsFVN4nM6DA7h9FXK6jW/kppsWn4MEDNl96
 ZCUQ==
X-Gm-Message-State: AOJu0Yyk4xQwAq252N7+fcOQwa+UyMhYv0MZYvZMsiZe+fQ2FdsFKAn/
 a/k1dnFCDxZ3BwsxfUEoRmBvtyz2PZRLdKAkQSt8mi1j4iZ3Qj5ZS+umg0Szjmti6iooJUcJCSg
 33P4=
X-Gm-Gg: ASbGncvTPlU8o0J/uR48CS7Ggs6ANL6WPkGRmG5LPEaZhIEkBEmApDhnEcB5hpgZhKJ
 YJfZTn7Z1RGfz6CslVbttjeiUlGPn1xOlWbjtOYRBwtev0Kcqr1eLpo7YLcZttT4clX6GX6lc0c
 N5FHAu4vSeEfA8CG0xuKwagwQt4uG3Bq3W13xKXENJMY7SxU7n+fb2Qgx/MTDLIugcFMEkzvMor
 pl7xXe5X4SrWnLR+P7Z2NFT8qx6Tg1FPF+bnKgmmNUlMA++MzYtWdanpwwoLIAcfZYh22YhW717
 I+Jaz2mMzLveJILkqe7ih6rcs638DbUueaHERW1glwwl
X-Google-Smtp-Source: AGHT+IF2Qa2qK8s8Y+UCKtiJhau1PG+A2sBQ7kSaYSkfFP5KXukECsZ1ynUy5CWuypfgQn6+rpf+sA==
X-Received: by 2002:a05:600c:3542:b0:434:fec5:4ed1 with SMTP id
 5b1f17b1804b1-43891453027mr153614025e9.26.1737484109806; 
 Tue, 21 Jan 2025 10:28:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f7e9sm191996725e9.23.2025.01.21.10.28.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 10:28:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/char/pci-multi: Convert legacy qemu_allocate_irqs to
 qemu_init_irq
Date: Tue, 21 Jan 2025 19:28:28 +0100
Message-ID: <20250121182828.45088-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

There are a fixed number of PCI IRQs, known beforehand.
Allocate them within PCIMultiSerialState, and initialize
using qemu_init_irq(), allowing to remove the legacy
qemu_allocate_irqs() and qemu_free_irqs() calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250121155526.29982-2-philmd@linaro.org>
          "hw/irq: Introduce qemu_init_irqs() helper"
---
 hw/char/serial-pci-multi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 7578e863cfe..718ae251317 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -45,7 +45,7 @@ typedef struct PCIMultiSerialState {
     char         *name[PCI_SERIAL_MAX_PORTS];
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
-    qemu_irq     *irqs;
+    IRQState     irqs[PCI_SERIAL_MAX_PORTS];
     uint8_t      prog_if;
 } PCIMultiSerialState;
 
@@ -61,7 +61,6 @@ static void multi_serial_pci_exit(PCIDevice *dev)
         memory_region_del_subregion(&pci->iobar, &s->io);
         g_free(pci->name[i]);
     }
-    qemu_free_irqs(pci->irqs, pci->ports);
 }
 
 static void multi_serial_irq_mux(void *opaque, int n, int level)
@@ -102,7 +101,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
     memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nports);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
-    pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, nports);
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
@@ -110,7 +108,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
             multi_serial_pci_exit(dev);
             return;
         }
-        s->irq = pci->irqs[i];
+        s->irq = &pci->irqs[i];
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
         memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
                               pci->name[i], 8);
@@ -183,6 +181,7 @@ static void multi_serial_init(Object *o)
     size_t i, nports = multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(dev));
 
     for (i = 0; i < nports; i++) {
+        qemu_init_irq(&pms->irqs[i], multi_serial_irq_mux, pms, i);
         object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
     }
 }
-- 
2.47.1


