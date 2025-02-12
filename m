Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24948C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB6H-0002Qz-S3; Wed, 12 Feb 2025 06:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB6A-0002OI-C6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB62-0000o2-Pn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43944181e68so35920415e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360400; x=1739965200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSBsnGlk959thSozzz+sJPLc7aQCOLFJmGFeqcx443k=;
 b=hpcMi23suxG4FrX4wOWXSuiP8ZVnC4NZTDaGGOlBGfcvbfyP+43EWwUhpPZ7DCiNoN
 3bNRMUxhCDHKN0t0kpBc9kGFGAjvEV3mJ1v4pZMP9bs8ASkFzeEMXWMGEVZ6pJ3a/Fjq
 tJMdaSDwsTuujvvRz8cgoHFnC67rIruEI7IMJEgbazrWzGncGmpTRCmqCnZlESB87Wtv
 BOefD+rCEhSu61B+34KyVwSPTOsm5eoIHamuLfJavVBuvFkLwA2SdGeVjFoEX8agJrHS
 zXSHGgTX09c89mL7cUzy/nYc0w2FW2e9Wm+RgGwksMjk1AZchxp7WwJDZ/ZGeG4e+UVw
 fb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360400; x=1739965200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSBsnGlk959thSozzz+sJPLc7aQCOLFJmGFeqcx443k=;
 b=KJqW7Lh6oTNz2iFz0FuCUQYN72KKjh7ROdKHjQ4g1gfMMWKXzT1KfrRxMfZO/Yb1/B
 MEBbxRprkmST/LKW0km26O1ugBmSN28yixKrwIJuPwDrtuGDkVd6BG31w4o1bCiiK4h6
 dBL2UoE4Po2wi0hDgYB5+a5GGmsXcguw9BU9h9map3RwbamusKO16aZMfxpQb2TZa5RI
 +osGPJ2V9bzPVTb8/LuLNMtCAG0cvXKK89EnpkMt20EoDZwUSbzMqQN7gEu+xHN8eXpQ
 Nd0EiLE12p/hs0+cDUZSkc9msVCF9RCX0+QumbJOdXnhv7uqUPY05msWDdOlEZ4CkfVK
 Bt6g==
X-Gm-Message-State: AOJu0YzfG9NP/MNp8f6aNGtAIVec21BOX9vcjLfnIu+HJzU1pNKbr5Tk
 zyhJYVG7mC1d3OnW2rRVwNfH4/Ltzjy0xtEXcz+OP9vPDE4NI1pLVIW1C2958rQJetLa2t4G5lx
 n1Ww=
X-Gm-Gg: ASbGncu2seWs5mOMYylnnuCrmSxXOWJoyv+cpqp3AUpNRXzI3UfnCFu7/z1Ag4/oQWW
 Br46qzueViIofplAWbhrrv/jlaZyUmVwaZ7PW9DiKjzgYgmqXEtSeTylMcoPDoYHzYIUHdYq+WY
 egC0IfK3QXloWxvO6C0vZsvx+MOrIgAcLjyYlNt/rMfO/H83lWcD9QEiwgSwBhcdmcxVzEEFZXG
 an5E/PNF8YOu+V/hCWbPX8CWSvpObyYKtxnIJVd9t+haKzIKoBAtOBprRLV1pQMIoVoMO+Di98r
 avlSk3TpzQGZVgJio62fgxrjTThWiFVKQ0X7F5sUI3L51sDuRPj2lMcpipeP4/U30g==
X-Google-Smtp-Source: AGHT+IGtM6h/jW6vPgEWooqgGeyUtaQ3MNIZFdIcYv7WXUAR4zjXC0qmZWyeJ224AFj4EQBImho71w==
X-Received: by 2002:a05:600c:46ce:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-439581cb901mr28046955e9.29.1739360399833; 
 Wed, 12 Feb 2025 03:39:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf416619sm13810127f8f.38.2025.02.12.03.39.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:39:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 4/5] hw/pci-host: Mark versatile regions as little-endian
Date: Wed, 12 Feb 2025 12:39:37 +0100
Message-ID: <20250212113938.38692-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
References: <20250212113938.38692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

This device is only used by the ARM targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/versatile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index c3fbf4cbf94..33a8ceb3b54 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -246,7 +246,7 @@ static uint64_t pci_vpb_reg_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_reg_ops = {
     .read = pci_vpb_reg_read,
     .write = pci_vpb_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -312,7 +312,7 @@ static uint64_t pci_vpb_config_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_config_ops = {
     .read = pci_vpb_config_read,
     .write = pci_vpb_config_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
-- 
2.47.1


