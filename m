Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E32C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlmC-0003Uu-Hf; Sun, 16 Feb 2025 16:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllz-0003G8-VJ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlly-0007wb-7B
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4395dddb07dso39108685e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739711; x=1740344511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGBjSRjjs0GVgebNeH/me8dl0WzvlQD2wvlUH4yfoyo=;
 b=CpvqOj058UEylZPXKNkKotvRYyF4ZllA8P9DwtX3gyrvM92UJr4DqwSFofV/na29mI
 yY6Fg1WThiSGTSkiwl2J5ILTyPYV0aL04hdH0EoDshV6maQWr7QP5DGKaLH1EsCYqenH
 kmRQWxgHtdXevzna5CEWUbI7/GS5XYIClXEA+bjZo6seM+oCReQdccDoG5j4HuSlV0h5
 tW0axBW7SpWkGKQ+HcKIX10H6/0YxHNVLZGeOePVAtAojvEzb2wKfEjBa/q1wK8sYbsi
 YW6qqIGzppu7KRlxVqOnFRkikfd2N8eWGzlghCW2aiI6rZN+wvupi5Y6i6Oz9B7sxbZq
 bYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739711; x=1740344511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGBjSRjjs0GVgebNeH/me8dl0WzvlQD2wvlUH4yfoyo=;
 b=XGP+jIazLm9FX6eGZ93Fw3tVgZ7yxpkyLbT/i2nMjZ7BgkKnSCGl/0pyOQ6QCmv8/h
 6J7nIWRUejUj8Z/rDm0iP0qNZCce9sHXYPn4WoIGNUuNua8aX+oCDU0ajJ08lamDHYVy
 F92A7DpVYOJP9RKkDB3GCqp9cyfed4JJh8ZzVK17ZfXblSLGpqvkLN2PDInVN7eiZEjk
 AuKMmlHhTTHkrS7NoINnLQo2pux3FJeZEHfucmYQL6G52ThJOdYCmaVsYihqjARUdU7w
 ykPzHEBlwhZJYKQn+KIAuSte/zkj1je2DwpfjQfLEPGb+jn9IksvRP9BG7XK/qin0yhk
 osbQ==
X-Gm-Message-State: AOJu0YysLPrivJLsQLwTmhwwB3Y1RfH07giLnerSrZIcozcwoHUYUUO4
 nPzDeThBKYXTIjNlqfrIGqEaBc+ohMI+qS8WEjR3fXAP1YgHETYNNOGkYhCn+6RZMR3wYXieD5z
 iW5w=
X-Gm-Gg: ASbGncvcTY1zFPdsNzkOzLJuuWpDeSHCqq/J0rjiUlyIyZjcuh3WBt9/n298a4GyKBB
 v9CQzB082Bull/v6T/j8ugLamZLRO1rs6aRI+q0lsal5BLG/f8FwPWIUGpzFrMsoC8OTZYaVw6m
 R2ecyHP14DDBG+9wtS9gXg0d7pcIvAnD8aTogpbn5kyJOpZIR1yWAAmCsecOocqnB1PUQfskEoB
 sUxuzJ7x1nwhdcYqnqMGmtiWnMESOaP4/S4/KQ7Pnu5JK1JT9GukUbCKWGPeYQkiBUMPiB5dB6v
 1rLisEWW/FxI2aq/2la4aFRqSpKbGCKzPRNwYZQ3rUNiACk0+6etfOKCLm3Ekgqk0XSEMPg=
X-Google-Smtp-Source: AGHT+IGkdTnA2e3/AFe67Pf4Uq80vrTsPEEkcbO9yKSxPtcBZUwRWCXDxDkoreyWpakWT2jbcnoZRw==
X-Received: by 2002:a05:600c:1e23:b0:439:8346:506b with SMTP id
 5b1f17b1804b1-4398346535emr12923435e9.19.1739739711465; 
 Sun, 16 Feb 2025 13:01:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43984924201sm10830115e9.6.2025.02.16.13.01.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/39] hw/mips: Mark Loonson3 Virt machine devices as
 little-endian
Date: Sun, 16 Feb 2025 22:01:01 +0100
Message-ID: <20250216210103.70235-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
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

The Loonson3 Virt machine is only built as little-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250212113938.38692-4-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 831fddb1bd7..db1cc513147 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -144,7 +144,7 @@ static void loongson3_pm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps loongson3_pm_ops = {
     .read  = loongson3_pm_read,
     .write = loongson3_pm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1
@@ -560,7 +560,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
                    qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
-                   DEVICE_NATIVE_ENDIAN);
+                   DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
                          qdev_get_gpio_in(liointc, RTC_IRQ));
-- 
2.47.1


