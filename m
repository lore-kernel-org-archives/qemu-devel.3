Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6CECCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCN8d-0003MO-58; Fri, 24 Oct 2025 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCN8a-0003Gv-P6
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:07:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCN8L-0005Wo-2A
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:07:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so1875205e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761332844; x=1761937644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xe5v3lt1asWPn9kptHJk/kzV1sk/igz/mIMd9PS7E3M=;
 b=PkS+equjvbNLag/r/tIkF0Y5PkVhDqRx7rXFx9KHSOJeap5Yo+xoNh1hAi4WL7HTkG
 1Y/hgfpvIVl1pw4ytkVbjG4CMtHfgMmdV/RiPiiEt0SiPP5GadAYNaqkjf4Z36kKudqh
 uckBe3dm9DCjTVHb+7h8A4rpWdtblXxU0vMgy6DjV7W8MLFHKZlj8l/d3KRAsTO6q/BH
 zeUehWFaR3lBg8iN19DlG4dGh5EKBVjkRKaBfxsLpYZ64VqyBMwbGRltqx6yQtXOotoF
 n8rDvrK6FXBiw/T5j3xhGR/s0OmtiF1T2YtcCoBYDpK7JGmY2BdWPfca+QXTPls2byhy
 2+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761332844; x=1761937644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xe5v3lt1asWPn9kptHJk/kzV1sk/igz/mIMd9PS7E3M=;
 b=GN6d78DirHkQrxYhy7Ub5/ZqI4z0xrgbvcPJb2HL3mdRFQp6fOL5ypXbD2V0WYDGkN
 ZyC0oWHZxtG7czUCDr7Gdz+WcIdb/RT26yz9wEMQbELBhy1Mlh727luJmr/vL6MjnBaD
 FqGoHeTHhdxjh6jWC1O1rOk9DxsEqGsE1buVTVHn+3YRmz9pMEyMLNsVIfTWCkRbTPBq
 mRa6OntVSyqNh5bNAs/zuqC8epU+HKZNlQhUs+rCd0hTg+Nq9RtYb+K3AB6uH+aHAKqJ
 SMisWNp+wqqaqVoJQLI0L89XZ1zexld13vmdPycJMJIK+daWsW18aSAkPcZoaF+KLJkS
 0ubA==
X-Gm-Message-State: AOJu0YxWenRj5CnTOd30kMh3sk3D2l0WmP0QAwZiCszVVv+klI77G72D
 InI268A4l6B/f0K8o+MoY+y+yHbnb5JDrLnXukpHtPCsChlLaHPx9ABehunewyMLCu0ODtQHoNl
 BUWdZymg=
X-Gm-Gg: ASbGncudW3btHmP/HCxh43isQJm+aBrj2yaFfTsbvlYyTCvuSwn1PQxh92/LlUHgsKT
 AV31oZY1gg5f3BIJwPSiGhACqf21RWZmsJNaP5R3mr5t880jqqt/6lwVhwzKgG/IMm+vTz3q7yo
 QCH42nEMoD0weY4o9V57wqGKdcno82BCYhXSe9uiLUOqkzrGleCPmg8hhVQLxCmV1+2E2xs9tY9
 XjrCo7c7tTTX3cIdUYoL3GhBFBGylWoTwWPPmvfBIno/8wnPHyCt1N1e8qud2S/34trtmX2KKoX
 TNGM2LoDXfzBWchUIZ9EnJQMck2qln9ZRyQU/sy58QGHs0C5DZlnuLZsxaWYqNCgqz5xJ8zk4/V
 xqjk7Bp9j80/VzB0gfVNBt2L6x8Ar3PjFYMxWlU9o86DrhoSsuluRimoU24zJK6MGIIbKXFCwhD
 9FmJMvpuu5b/YCo84XKD8yuaN14FKW1DcNTAsnskNhUeSk1WuJBMjw6sKvHHQU
X-Google-Smtp-Source: AGHT+IHHL42jq+kWv7bwkbCqhqJl6wI5+ZAIN94rhWy0oYxeiCcmfQP/ob7ihjyIdvV26ky8WlaCOg==
X-Received: by 2002:a05:600c:3488:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-4711786c586mr210976455e9.1.1761332843600; 
 Fri, 24 Oct 2025 12:07:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428f709sm165005335e9.8.2025.10.24.12.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 02/27] hw/sysbus: Have various helpers take a const
 SysBusDevice argument
Date: Fri, 24 Oct 2025 21:03:49 +0200
Message-ID: <20251024190416.8803-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


