Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA60C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyE0-0008VD-QB; Fri, 31 Jan 2025 16:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDy-0008Es-2v
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDw-0007tR-DX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso17493785e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357606; x=1738962406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DA1wMZ2yl5z/7wIXRmmiIP3J469q4sqq1JVgdMv1DSg=;
 b=OzPp04JwPKsP48lZcOEtww9TcxmeWQSEjbroAKPougDQstq/WpKbK788B6UVCnZEVc
 WBCQHUv5ZTkgBC4g4W2P3/LNGtv+LeoqNo9KgWydIHlc/MxFEJlT/2+P50p6/cBpnl5g
 ek0LeZpCPy89NFew8kdDF6A+gxbblr8Qz+O0h4tZRjG7PfvW6UsFjHJgcvJlnBggnmtz
 gi5vdoFbRKgFdKtVGIzXWbEX9kAVzZzzFFObaW6rpggVDjUgRNL7H/aChOfz2NpV3/Tz
 RVRluIaea7x0fMWXbJtd+V3BK08v7IUYyXo2zUXZwbSu8rFtvRokwHbn0wkBo6DFNSSG
 J/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357606; x=1738962406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA1wMZ2yl5z/7wIXRmmiIP3J469q4sqq1JVgdMv1DSg=;
 b=X0nWzolatLk2hs6Zr4pIQj0eGnDgOm0pueiuMBtoKuxp6yemIAW5BFZlBm1w7ds/2Z
 XOGXqPLXSEkAg8HjObbTjLMsTSumdpRtfeK5S4tl7XIPdSCtcJCt5XQryi6ciVKgHlqj
 akO/s49kNYFWexXmOW4IGRNkxFWhpfBcrUheUiMgImhM+6Xl6unRjZpdYX00toZBBbMP
 2p3jqKKuvxaSOqlxREhWp6coNi72TRVL7ziriAIs7R3MhtDK18QJ7ijuLI9H2FJfHwtn
 4xWKRz8zdeDclp61nWNaBquPa7YmcuhJ18e31dCEgFs08CMvL08/2OixgGwHf4ivdnnG
 uOIw==
X-Gm-Message-State: AOJu0YzPByPbf95xKG2xiCc54rC1TfhkTRC2Z15f8muBHqYdTDcOjXjz
 dGMa7vOe6UcAIx89EevzZ8O9tvUewSVuwdbBTN077VTl/3MnF0nLogPoAEc//kY+er48sRtqfbI
 hYWQ=
X-Gm-Gg: ASbGncuET6JvdpEMsZzZaljzKJQSozFRhmrwKggRb+nY6ZsLAtXCwKOeYLk7aignH3l
 ngeSNntBi5xvsz9lhQGBmxnMdImQvrTXuiE5C45oXRqRYKHQXVA4PsugtDYBJegd3QrIde+3tAB
 vrKwlp9T/COUxnMc0G8bnTKqN6YWlL1vKIfKO1Qyde6LmWRRFCkQjSoHGxnOfXrfgbQ/Siw4NUm
 KtbuSXgbNObfXAmeg5w0OBgzyvKiOejXuusHpVj/qveidocCuVBjbmj6oSbGcg/APEXjWYUMa7g
 VLPWdtlUDsDGbzulLXx587tZF7wyJhUH3X6ZHjJzo/hybO3Jwsh2wiHuWpm7J2e7nQ==
X-Google-Smtp-Source: AGHT+IEv20jLlcFdxroJHAWxWd4IY4fYv5ROQUbeBab/15PIAzNgQxvqhbQl4l2IRDhMl01oaocC4g==
X-Received: by 2002:a05:600c:524a:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-438dc40ffdamr105809035e9.22.1738357606421; 
 Fri, 31 Jan 2025 13:06:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6dfb5sm103980675e9.31.2025.01.31.13.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/36] hw/char/pci-multi: Convert legacy qemu_allocate_irqs to
 qemu_init_irq
Date: Fri, 31 Jan 2025 22:05:00 +0100
Message-ID: <20250131210520.85874-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121182828.45088-1-philmd@linaro.org>
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


