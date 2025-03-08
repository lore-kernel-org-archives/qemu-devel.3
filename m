Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46122C28B30
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzSJ-0007Y7-KY; Sat, 08 Mar 2025 14:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzS7-0007Eu-8D
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzS4-0003c9-PJ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:14 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so2211511f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460591; x=1742065391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY3LDQvhSY1UJUDBZWJ0oLgNLpHwNcu9pDPeUp1WnOo=;
 b=oeSFy2Fd+bD3R37B8XWknkiECzVgqFAyhtqwpw0+c0hdMb5HSVUxbE12GJ8Am23UET
 AIame9iC9BnK0fPwiNE6i84nY+hiQ2LUXJdwQYUBGyhQbrqiJ7WWKJ8lN4Riws4l0cNe
 UCYWmeDOjrEVhBtaUp2MkHLiDgRLtJXLTIW1Y5ZvEx8DojVxaHkXpd+kSDSUqfOI3hx5
 30o7j6uIx8fYkWAw4bIzW79aRk4vhMxA+el/9/PSd0UFMow0zYogIUq8RvUycxtl/w+Y
 zdbGmeJHIZdM+ePyy2mgZFVcPQwN8yKYLk7tJQS0vHjY4iAC+jjTfbIoWb6Am+kVkBz+
 885Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460591; x=1742065391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EY3LDQvhSY1UJUDBZWJ0oLgNLpHwNcu9pDPeUp1WnOo=;
 b=DAT0RY5rkxRINwinWOMTmRwTSDCF0L8NdtPTTYyg/3QyWo2k9nRCD+qmUPaZAMdy5/
 HhLOoUa+vDcNCc+u6uXz1LmO+WOwm4OKNkpXMkT3hHNew8INe0ss8KISDQgi2WbJo5TQ
 SGMs9DoydlLAavIigYwhjJYR5jTuofHSzzP6tgMkNHzLWxbroavKLcQcu7/VB35ebZmW
 S+NQ9BpJKmy/GDioJtQIDe2d6KP3q2l5cQMXJoZ1w9r6Veu9LVr8CFh6rBiFAk/I2BsY
 jS0gQKymA9GMSZXqvvyPjj5+lD+4j/tlTrNzIZx8680ohuTmEfHd9sj6BvveBok6g/U0
 EGjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq6zGPHuSGXHKGJnPtQ5yqIOfY4j5zKXJPgCMk1dDqflU51Cl+SbYkYP5kZCipU/SLhaLf1YAek38M@nongnu.org
X-Gm-Message-State: AOJu0YzZS/uzhGccJPyjg+9/8dApU4aCEThX4XT3MOKoUsOzNWtcQ3cj
 ZSonV198BKiqHt1FMUrccRwBkVcPI82Iel/yNRgab8fzXq/Anzr0IKFzVyOHY+P0IO1fnQRVHeO
 Ls2U=
X-Gm-Gg: ASbGncvKS2clmh/fA7/QyLUQrrpp6AMefBI1I/JX+ZU3OYI9HkGiJPUAGeYMyxviqCN
 BNhOWiIMWcseY/1wRHr4e78f42Ue32z2lxtIYwP1nCZQ5gF3SwYEA6mmf57C+mSepZmLU/rzc4D
 yiV0228ufREHK2yALkFHDpFnN8D9kdG3z9ZU621nLcKuZ1jq43x9TOKIvdovKpcWsMBT0bzAEAF
 kqkFWpLl5sCUI9UU+cjl0suGfCLwcLGAgc3VBbL42A+hDpJ7En2S2SVdRQu1Ip6nx+eMSTG7b9L
 K15vyu5fbf9h58ePVw6bx6nmorIR880H0JR5zRCE2yVQi+HNYfUK/vuMAqX0goE+gEjIrEhkDU1
 VboHWRimrCdt1gMR8ETw=
X-Google-Smtp-Source: AGHT+IEMrmrUgx9XJbSSQoo/RjYcCK25PQsxPRHfM22ATrGgIMYkro+mmELSNksYZdl3Rvxpu4PaFQ==
X-Received: by 2002:a05:6000:4109:b0:390:f4c7:ea20 with SMTP id
 ffacd0b85a97d-39132d6b7f1mr3969482f8f.24.1741460591053; 
 Sat, 08 Mar 2025 11:03:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c56esm127609315e9.8.2025.03.08.11.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:03:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/12] hw/sd/sdhci: Unify default MemoryRegionOps
Date: Sat,  8 Mar 2025 20:02:26 +0100
Message-ID: <20250308190230.7508-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Note, sdhci_mmio_le_ops[] was missing .impl.access_size = 4.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d115e88c4b9..15e6976220f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1372,30 +1372,22 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                        value >> shift, value >> shift);
 }
 
-static const MemoryRegionOps sdhci_mmio_le_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
+static const MemoryRegionOps sdhci_mmio_ops[2] = {
+    [0 ... 1] = {
+        .read = sdhci_read,
+        .write = sdhci_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = false
+        },
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps sdhci_mmio_be_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
-    },
-    .endianness = DEVICE_BIG_ENDIAN,
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
@@ -1443,8 +1435,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     ERRP_GUARD();
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
 
-    s->io_ops = sc->io_ops ?: (s->endianness == DEVICE_BIG_ENDIAN ?
-                               &sdhci_mmio_be_ops : &sdhci_mmio_le_ops);
+    s->io_ops = sc->io_ops ?: &sdhci_mmio_ops[s->endianness == DEVICE_BIG_ENDIAN];
     if (s->io_ops->endianness != s->endianness) {
         error_setg(errp, "Invalid endianness for SD controller");
         return;
-- 
2.47.1


