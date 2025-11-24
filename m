Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9478CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTHf-0005ie-Et; Mon, 24 Nov 2025 04:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTF9-0004YQ-VN
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTF8-0001ej-HG
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so2728337f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977941; x=1764582741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHirYCS7o5fHFAEDDvU/4jz9vrUedalvStdmBVvHfE0=;
 b=N4ZSy7bxC5/KnhX1kgJXTBg5/ovm478squkQbWy+057wyzJVBWQdVOXSnr6OHazU/f
 L2Kua4JjNauAgOyZGCN12ek6KQkzLbKeAllxTnSRbG57oRwwqmB3yI1mq4b2LqvwECRk
 ao+SAYNhBeEOCwlaJpvlMXY7yctzjOy3iM3wMHepIioA3NplIAhVxHRwJCaJTWeCku6Z
 7MWeh8+dW3oyc30Ss+OjI9yH40C26KHNMcH3LEMBwdmL/2wPerpJNupJrQ86my+AWJfZ
 479ajly3F1etN17K21WcR52/jCaY5GchSX4QARg/gtUcYNyzE9V60AnZLx6ZMJ3/7eg5
 opDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977941; x=1764582741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iHirYCS7o5fHFAEDDvU/4jz9vrUedalvStdmBVvHfE0=;
 b=VMZSLDxJ3Yd4A3c1X2VPpIMc3yU/23Lilsymugbi74mMn2/i1HeHWjdeMuz3IlnPiY
 Sg5w3oysGyj5zegNF3LKMcgCIfXv2EITYTUNKftVv4WA++dLZb1PlN5cLabolprdSaze
 kvhSA572gD+ROXHXCYlbhkb6PeArcgK6BPIirjWxW6Ik0byBNDXODJ4c/92m22/N97hq
 L+zZKwhD17QmvaSsLyFhnMZFX/AZwlmGi1PT5feFpZlOxZ20iophw5MV6gNnrL6qB5Hz
 Sr8JYcOa3xhkcbG6znM3Y0RRANkoTY/gMMNbQCBwcKbs0myP3qKszS4Nw7loxVkX1zr8
 mACA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7XgQXusVryinqNmIHP4g7wodHr1RlO/1zIb16tt2ZI9/6GpGvXiKsWdPjCa7s3D0oNcDaAHXhsdVO@nongnu.org
X-Gm-Message-State: AOJu0Yxmmsdv+AAqxt0eS87cTPlSfpqMTj2yh2uR8L+1jMjRcNSehlUS
 keynRnWDSQhVgVeITGQQGp7e2mw+VIPDX4fEIV/tvg0mt9+FMSM9Lyw81jfRxDgsIUY=
X-Gm-Gg: ASbGncsfbT+eAhBp7snNcabwrEOgYJ6MM/N7C3GIdXUo7xAJ75xtN1TOJGfag1Wr9XN
 z4JUwkyNhkvQKuUIl6fn4IHdTqHbSYAY+pZPMLC04RLQWfQie+btIQvhmoW7aiEux9zTnK0czbD
 nlVW6aWK8qqzUz4+9U2Gbr2x5g+1p39OrKI8OUb6/v8l+BcwyGFVuidTeGypQQMj2lOEAUyd+eQ
 il7ziALVKzrQs6NCruyImnB8mZqM1jdk9ydEHKZRwZ4QDZ3aY2EEIRqfrJDSUqhV3OYN/ezsSQK
 Alk1/T/gKAqkbqj2RUkJCzvNSUhxazlp06ZAMgKtlc5iXh6Sad8chyPLFUl9G2t2ch+fb8wYbj8
 ZFvN4dE6j33lfTGSnJ9INxBWemDhUosNSoXnYQNk5yrGPFmDgydEwGr238pxHS8unS17UUBQexB
 RiJ0AFKS2swdQP7EsXtq8JwQKO7BjgiHoDOTkrq/dLqHr2AvoJ1MiBQWPJ1xPE
X-Google-Smtp-Source: AGHT+IE8lAGpWs5r47u9tfQ09QCiQp+hvwbk1sFYcYvTR9hupnHVS7a+9ruBHkNWTl1whd+N3savNw==
X-Received: by 2002:a05:6000:310f:b0:429:bce4:20bf with SMTP id
 ffacd0b85a97d-42cc1d194fdmr10445600f8f.55.1763977940737; 
 Mon, 24 Nov 2025 01:52:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm27731794f8f.18.2025.11.24.01.52.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 10/13] hw/sh4/r2d: Use EXT_CS_BASE() macro for
 display controller
Date: Mon, 24 Nov 2025 10:51:05 +0100
Message-ID: <20251124095109.66091-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 2229cc6fe66..75878abe946 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -254,6 +254,7 @@ static void r2d_init(MachineState *machine)
     r2d_fpga_t *fpga;
     const hwaddr flash_base = EXT_CS_BASE(0);
     const hwaddr fpga_base = EXT_CS_BASE(1);
+    const hwaddr sm501_base = EXT_CS_BASE(4);
     hwaddr sdram_base;
     uint64_t sdram_size = machine->ram_size;
 
@@ -295,11 +296,11 @@ static void r2d_init(MachineState *machine)
     dev = qdev_new("sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
-    qdev_prop_set_uint64(dev, "dma-offset", 0x10000000);
+    qdev_prop_set_uint64(dev, "dma-offset", sm501_base);
     qdev_prop_set_chr(dev, "chardev", serial_hd(2));
     sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, 0x10000000);
-    sysbus_mmio_map(busdev, 1, 0x13e00000);
+    sysbus_mmio_map(busdev, 0, sm501_base);
+    sysbus_mmio_map(busdev, 1, sm501_base + 0x3e00000);
     sysbus_connect_irq(busdev, 0, &fpga->irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
-- 
2.51.0


