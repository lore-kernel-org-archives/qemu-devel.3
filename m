Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFF1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeWW-0004Vz-5J; Tue, 28 Oct 2025 03:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeW0-0003sd-Te
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeVw-0007hd-8p
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so16819405e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637984; x=1762242784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfxMyfRhymW2+pro7iyHUD4s7/sami6rn5TnQpiWkU4=;
 b=fD/RVtOG45T3u6jIYbGyORwGJCytYLHX3cjA2T3B9FA3CX3s/3cQfRJ9JX/OHwia9F
 8WuFvotSeh5olj8mC4m04iR4uJp7Np2+3ul6yZXdFGkwycFsqOmA3xP89QdNTLtxN7yt
 BbUrkouHIjkTst1sh+neKQBwiGJzM34baAufKPLwJGP3adBiZN6RP7HJYdjQ1CbpJ6vy
 UZEftxaFXFar6fLSkXNZBz9gJOMq5TtMB06gcyaF7GZW59v8kwACWmbsDBB+PTXvZUT0
 8/YdsLpJmGQDccA9cpQaKetZRaFrUD87faCAH3HO5q+ibsQeEP98QU2UJ+YMyoEBhxlV
 mmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637984; x=1762242784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfxMyfRhymW2+pro7iyHUD4s7/sami6rn5TnQpiWkU4=;
 b=FwiI66UveQVY0Bl1/wB+gcGnidahFJJvWCgMaOVzLRNaW7hheQx6QSPMq0NfRgFmKJ
 MKdxAHvLpBIORv/FYLa+x+KBir3sTcfXVM5Skb+TJ93VobDCJRLOAM7d3wJK6e5TsHLU
 6dJ+T8MtO0TCwvD99EjbwvyKViuI/lFGnNcBIBe94tTsBK/qlOi8uh06qQIScCWCt9Lb
 dwcfMoEesZR5D7GLpwkeDmf5TPWdd+0zCpNBqRMSMQinQ6q49p9yr/kFieipNOEI4VfS
 OB9PD5IiR1rMLHiR0WI3/NfIAwG+SI+OS7MPdQEjmplNP7/WPMGoRUpqNUPP1Sm+IVFw
 /pNw==
X-Gm-Message-State: AOJu0YymiLGD0RFPqwVkeXSMXNLtGACdlSI0F7i6WZhzLr6dk9wzK+Dy
 EJUSoIPLD9BaPLA1JeVVgVWlEjLYiF6P5GHVIE0t7HdtsLzMqCrVLPlbOxMrap2ImEPyWRg4rQP
 WkggZrJs=
X-Gm-Gg: ASbGncs//30eBv1FOnvBhO+qQLVo562VGaUDhHYwFzYqiuNlYPkZ2LV8A+gofRGK34r
 +I1Z2G2oCv+iaWNHCBdkgF8WY0XCoOYRSkYQ6OyKlRtoVTDs2vRW/JGzFAnTHPACVaOO88x6n+P
 bksh2JGAy0ZG827CuqMOM2gMSr+/k0rDqFNBKAZXXJ2HIknJiABByQr0EgO7bX6Gp2UFXzZA3Fo
 GIc7z5l/Hr2YwHo15w6PQB4pQN53X4zdr88GkzbtvrLwo5pgFbaffqCLLv9IWhSwuDodx2IfU4B
 PfOGvYb3mn54WJDMeIQRD4av8TuU05KsS64RZTNJzV173JZqQtAoUWRq71l12+JDlq8iDYK88b3
 nAIgP2iQycdPCq2Tr1QiQehbvLwN9ROX074WShSZBjSwjuhLdc/2Fv51B1QDWPCHX799K9m/+9E
 6eRd+hFRvwyjVzmwDPbT0ZZUUmlmjhHxn2nkd6mV4P6aLctSutzcwylGg=
X-Google-Smtp-Source: AGHT+IFOB9T73BS/pQsKvdAVhHtUvlr9uw/r/iy2bUvEswUU4YRBRFEkGo2+RBVOb8eySagDT8pGkQ==
X-Received: by 2002:a05:600c:34c8:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-47717e4df73mr17623005e9.21.1761637984432; 
 Tue, 28 Oct 2025 00:53:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de4a1sm18811924f8f.37.2025.10.28.00.53.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:53:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 11/23] hw/sysbus: Have various helpers take a const
 SysBusDevice argument
Date: Tue, 28 Oct 2025 08:48:47 +0100
Message-ID: <20251028074901.22062-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

These getters don't update any SysBusDevice internal fields,
make the argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20251024190416.8803-3-philmd@linaro.org>
---
 include/hw/sysbus.h | 10 +++++-----
 hw/core/sysbus.c    | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 18fde8a7b48..69eb62e29c8 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -70,17 +70,17 @@ struct SysBusDevice {
 typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
 
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
-MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
+MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n);
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
 void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
 
 
-bool sysbus_has_irq(SysBusDevice *dev, int n);
-bool sysbus_has_mmio(SysBusDevice *dev, unsigned int n);
+bool sysbus_has_irq(const SysBusDevice *dev, int n);
+bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n);
 void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
-bool sysbus_is_irq_connected(SysBusDevice *dev, int n);
-qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
+bool sysbus_is_irq_connected(const SysBusDevice *dev, int n);
+qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 int sysbus_mmio_map_name(SysBusDevice *dev, const char*name, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ec69e877a2c..ae447c1196a 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -80,7 +80,7 @@ static void system_bus_class_init(ObjectClass *klass, const void *data)
 }
 
 /* Check whether an IRQ source exists */
-bool sysbus_has_irq(SysBusDevice *dev, int n)
+bool sysbus_has_irq(const SysBusDevice *dev, int n)
 {
     char *prop = g_strdup_printf("%s[%d]", SYSBUS_DEVICE_GPIO_IRQ, n);
     ObjectProperty *r;
@@ -91,12 +91,12 @@ bool sysbus_has_irq(SysBusDevice *dev, int n)
     return (r != NULL);
 }
 
-bool sysbus_is_irq_connected(SysBusDevice *dev, int n)
+bool sysbus_is_irq_connected(const SysBusDevice *dev, int n)
 {
     return !!sysbus_get_connected_irq(dev, n);
 }
 
-qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n)
+qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n)
 {
     DeviceState *d = DEVICE(dev);
     return qdev_get_gpio_out_connector(d, SYSBUS_DEVICE_GPIO_IRQ, n);
@@ -114,7 +114,7 @@ void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq)
 }
 
 /* Check whether an MMIO region exists */
-bool sysbus_has_mmio(SysBusDevice *dev, unsigned int n)
+bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n)
 {
     return (n < dev->num_mmio);
 }
@@ -190,7 +190,7 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
     dev->mmio[n].memory = memory;
 }
 
-MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n)
+MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n)
 {
     assert(n >= 0 && n < QDEV_MAX_MMIO);
     return dev->mmio[n].memory;
-- 
2.51.0


