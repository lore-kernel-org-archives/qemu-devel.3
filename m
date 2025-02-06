Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2769AC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1ew-00050E-9p; Thu, 06 Feb 2025 08:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1eu-0004zg-Nv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1es-00081R-BJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso5561945e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847464; x=1739452264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMtXKyt7uU3QP4JcjRIhfj9cVUwd73AKtJN/LO4r3Xo=;
 b=YnOfVrhjS2NJiEJ97Uj/yCRBXFRu5wdQ7kHC5/8cXPFI9bSWMxz+wF5AUephpLaeDS
 ym1TzdINnmoFCRt2Z/fr8HJZx61/odvriex/7IYdPIvZ11i7t/u78/7ZODOei5CGsV3U
 sdIJcy5qsKCZFaEHOxEb1KZeTyrWkguaghPovpYtMEA1dFaO9ZcNTx9JH3CRVKiSIM9k
 fwYY2UR553gRmkQdd1hokx9vswWcsx9j3OMwj0NjOqHpzV89Rko4AhGDYEpWXf32T16y
 0CpU5Txa+zA+Pfv7r5DAAOKJojkb012rWIGcdKfz8hGk6OyYXYK9YNstKVr0nc4pFy+1
 PcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847464; x=1739452264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMtXKyt7uU3QP4JcjRIhfj9cVUwd73AKtJN/LO4r3Xo=;
 b=LzZe5rvFxRUq+FCT9tDAmP8sgceKUvUqEp6OlyTfgTOb5ctMREIrkp+oRwsqXL6QIX
 Bk2YEEr4bkvqLOtP51wfoIisQazzRCT1eFwOWQ3M1k9osLzqGjpZHIYf1FNmJleERkTP
 NkyQKP3Gwvnko5iZrfG6w7+hX3L/yFoWmTTOvc/oyivSV6psZAhT3/v3KnrN5XYjLrGZ
 +8CLmzBxNObkRniimy7rDlNBg9gfBcNSzAjm5hZOAFra8d92BwuwIYcbglchyLJr/S7K
 6VCaeB6JEKEvDHahekFV7ktHgMxtBewYT4tuQk6O/z7El7OXEllGrfwnwaJoAzOx2dGr
 PQsg==
X-Gm-Message-State: AOJu0Yy7b0AV04owYRHdPeL/7RUot9yTXPN5SpOmnnemXD91GYLxNHAq
 CDeOsJ3TWRMIH8niwYKNVPCXFhQThg6GdWzPjqqVoyNlf8HNIT6tRERZJ5KJPjKhvRJutZLh1JW
 bIDg=
X-Gm-Gg: ASbGncv94gUEjxRMoz4JkRx8aWHcMxACxutI8H/mS8lJhcBEHeAkdZsE4T6KlICpfOe
 LoUxtBKNF5XyGFpbEznAMZr63S0uSomFO/qbqxNCGUUVswjtNtt+D7jZRp4elwxYD6fjPFEjJwr
 YUNxClsEk6nn8c3NcCvP1LGpVhCGqWBse3sKUPmi3oClwBVHHVeNz9UCKvgGBzaZmYKqQdIV6xD
 6b39JzmZjqDGdTvcmyjMf92ujz33LN3J/ivFkYreZvQ4ki+qP9bmkzgbtzz2DIjQ2yntnpEmS5s
 V3L50CZu28simP9R1rRH25MBSq6ZfaoApD7g8HUUTased2USDGQ0Rogcfe6xehLy6A==
X-Google-Smtp-Source: AGHT+IGp2+aYH7JgaP3njyaUthU3yFHyUSPH6xCZZWSuBkq8eu9aTuAFfAdmIhb1zhkD/q+lriIM5A==
X-Received: by 2002:a05:600c:45d2:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-4390d4360cbmr70444175e9.11.1738847464446; 
 Thu, 06 Feb 2025 05:11:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd2esm1689324f8f.73.2025.02.06.05.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/16] hw/net/xilinx_ethlite: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 14:10:38 +0100
Message-ID: <20250206131052.30207-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 0506497ad0a..fbf52ba8f2f 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -121,6 +121,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     dev = qdev_new("xlnx.xps-ethernetlite");
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 14bf2b2e17a..103e53831a7 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -90,6 +90,7 @@ struct XlnxXpsEthLite
     NICState *nic;
     NICConf conf;
 
+    bool little_endian_model;
     uint32_t c_tx_pingpong;
     uint32_t c_rx_pingpong;
     unsigned int port_index; /* dual port RAM index */
@@ -183,10 +184,10 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
-static const MemoryRegionOps eth_porttx_ops = {
+static const MemoryRegionOps eth_porttx_ops[2] = {
+    [0 ... 1] = {
         .read = port_tx_read,
         .write = port_tx_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
         .impl = {
             .min_access_size = 4,
             .max_access_size = 4,
@@ -195,6 +196,9 @@ static const MemoryRegionOps eth_porttx_ops = {
             .min_access_size = 4,
             .max_access_size = 4,
         },
+    },
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
@@ -232,10 +236,10 @@ static void port_rx_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
-static const MemoryRegionOps eth_portrx_ops = {
+static const MemoryRegionOps eth_portrx_ops[2] = {
+    [0 ... 1] = {
         .read = port_rx_read,
         .write = port_rx_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
         .impl = {
             .min_access_size = 4,
             .max_access_size = 4,
@@ -244,6 +248,9 @@ static const MemoryRegionOps eth_portrx_ops = {
             .min_access_size = 4,
             .max_access_size = 4,
         },
+    },
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static bool eth_can_rx(NetClientState *nc)
@@ -328,7 +335,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                                BUFSZ_MAX, &error_abort);
         memory_region_add_subregion(&s->container, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
-                              &eth_porttx_ops, s,
+                              &eth_porttx_ops[s->little_endian_model], s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
                               4 * TX_MAX);
         memory_region_add_subregion(&s->container, i ? A_TX_BASE1 : A_TX_BASE0,
@@ -340,7 +347,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->container, 0x1000 + 0x0800 * i,
                                     &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
-                              &eth_portrx_ops, s,
+                              &eth_portrx_ops[s->little_endian_model], s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
                               4 * RX_MAX);
         memory_region_add_subregion(&s->container, i ? A_RX_BASE1 : A_RX_BASE0,
@@ -363,6 +370,7 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static const Property xilinx_ethlite_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XlnxXpsEthLite, little_endian_model, true),
     DEFINE_PROP_UINT32("tx-ping-pong", XlnxXpsEthLite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", XlnxXpsEthLite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(XlnxXpsEthLite, conf),
-- 
2.47.1


