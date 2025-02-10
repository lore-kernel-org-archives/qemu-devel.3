Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAEAC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thabv-00066T-Ha; Mon, 10 Feb 2025 15:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabr-000660-3G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:28 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabo-0003ZQ-JW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dc9f3cc80so1276406f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220143; x=1739824943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uvodWMt7tm/cs4k5p9ZUh0gPCmIyYRQU06Edyq2zpE=;
 b=V0ch59R+znvE7KKoR4R9eS4f4bF4cELJK2oO75reeoz3FVI8+qDH7VfPkDK6qbm2mh
 NOxF5y5lNF638DUUctfC8rHxXrdwnEFGmx021qtX1NmjBUiGzv1pygJ3L1sfk6lsiWS3
 X6Tw4p0dDBxXn27kIuZBPQLfGonCzEGPrLT7iPueVys+QZmk8uLR1aGt4SUnT4C69Yx+
 cjwD1APzt758Ppo/hxklh+Rrn9ftkmUIJoKpma1pJLkOw1IowWPl4UtE1G6o6U2HNnS7
 x3xp92ud3d3x9EKbolCfozdZld7nHjf7ZZZJR5CZdtuPWhej2axJVFe68AhgkUQEzAeo
 CJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220143; x=1739824943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uvodWMt7tm/cs4k5p9ZUh0gPCmIyYRQU06Edyq2zpE=;
 b=kk8WuaitmNCzkaAMtFn7OJ3Z+bM0YO3tnkxiQiC04CgL8KlhtVBoRlhF9s5wO335da
 VNHTBUkKJ3gyqllth/KQNQ+QfVBi2IHVhCLTERea7Dj2a3ENaHH59shwwuxlrqX1FrfC
 RLjWPOhjpCQK+ltdLL56Y07g1ZUqXoCdDvAuNJ4uEE04VhODVgGceZiBMnt7NJD4j2OJ
 6hB1h2duoNCh4daz3hEoBBestMUlTl7lczbNrvypc5wvK8G/kdYqDOCPt0UR9eHvj61P
 1r9G/1KQwAXbzX8rM5HL0KR+XiGKnSB5wBeuP5YanOdHw84y3YMUHUVOxW108ZCGyrHV
 53gg==
X-Gm-Message-State: AOJu0YweG/C5VwpviUmx3tvGx8W0+uO9WlANucFcKscCTIFDy/W0hwtC
 Ohrj3TiZGwAvq6EMQGu9ChQ6xxDLrN2GNE363hNia5x4lYC6PyFlGljfxp0WVCZ5fMQQvmTu4Zt
 nrUk=
X-Gm-Gg: ASbGncvjAVu9eQx315s/qIsEgtG43Gwg7ic1bwHDQkj4uywe8wOp7TOpJPfk2jYzHdX
 OVJbiameEv0vmoXQ5BEJlg+BO78Pvk71W0M9yEnJr98ldoAL+eUJ4O1jXoTf9BXsiVxD6VM0rnD
 LC2hbun62ga0gFzFbgC8ArMs/Ni+IgGVElSUUbs4BLJi6ogk408nT9fMafKnOctT1FXHxsxWqrk
 OXzvqVyiirEJElJx2wzX0Su46Jb7ITCztXGw47SxG3jlTqpKr3uYxcuIgwgjYcm6Tl1sp5AlwLC
 k4TYKKW8TN1b5zzOAn/GVKRS6p9JH+Wnq4zA4RpS8OCXnwD6/is1U9C2WXXdGo1lDg==
X-Google-Smtp-Source: AGHT+IGSaWfAIZL8Tz/rzTp0zFBuBzJXGTfhn0sdJDCR5PY7AHozIqzOd28dXPkorIKC6r/zKcO+6Q==
X-Received: by 2002:a05:6000:1865:b0:38d:bf57:f371 with SMTP id
 ffacd0b85a97d-38dc9373270mr12790122f8f.48.1739220142595; 
 Mon, 10 Feb 2025 12:42:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dca0b4237sm10422249f8f.85.2025.02.10.12.42.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/32] hw/net/xilinx_ethlite: Make device endianness
 configurable
Date: Mon, 10 Feb 2025 21:41:35 +0100
Message-ID: <20250210204204.54407-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250206131052.30207-3-philmd@linaro.org>
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


