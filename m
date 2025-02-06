Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C29C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08m-00076k-RM; Thu, 06 Feb 2025 06:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08X-00071Q-UD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:43 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08W-0000pl-2F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:37 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so4928665e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841614; x=1739446414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMtXKyt7uU3QP4JcjRIhfj9cVUwd73AKtJN/LO4r3Xo=;
 b=HPhrRp/atp1+PTO10tQDwvc5fBMhgb3zlsXitf37XV+mzZIvvTqjYMno4SRnzJ+kpM
 TPNV/ECknjBH1YHQFtOn2tgltClxoIZbtIampzOsAaAVdpjpDWI4FWjOcc6WuoswCQWH
 m9cdnOm7+I6kcgZPnMqVuYyx6uobcANYsZT5NGpoDp6Cuu034QIcjXnSU644c5Lms9M1
 sjl2M+LHadNSWD7F4kxgo7E2a4OL0kM4UoG3qZKuhHoAHycoaFBU/Gzl918E/mvytr2o
 xdcDy4GL3PErm5diAhG1Hs0YYpEaWmJSlwOmi4TthfEuk7bxqb7Pqs0O7LF7V3OVZxmW
 uT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841614; x=1739446414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMtXKyt7uU3QP4JcjRIhfj9cVUwd73AKtJN/LO4r3Xo=;
 b=eAL7TWhSTNRZFQ65E0C0e7VpnZ3mQ6CRsECiM7mTWEU9oAN3PZTnqIlwYRsCPNO6t7
 5Vvw0KWlaPtQBqPUQJyxVIxbN3/GThmMLRNhYdBkKgnn7JDYiBRMRv5WKgXsXOqlGopt
 UWusKEE2HUnIH+vx9BfDUrAP3UqBV3qoviL17lOV83GJ+J1cx4xtKkXij2of2D7oWUoq
 jrvUyz5eRTKOFf02wJbrdMvjmXs6VwVFCTFEHeM0ySmIep/KLivJKnmLWSMs8c0sZ+/T
 013QhovL1eXegAXxNXDPgcOUwxboVCnoyNn5LTKoLdvvEI0gVwKNGrbXdeVJ6gKNAXL4
 5d2w==
X-Gm-Message-State: AOJu0YyG10Qwuk8PamFWuCbg4cZgoMZhjXI72OYuWgYeYJjPnNXQMF9V
 QEacukV3VeYFk3ZGQdHOffFlHxTsxsUhDnkKzxpoKgMkV1qsKVkYnaE+GT5KOKaopVTR4csXNde
 udf8=
X-Gm-Gg: ASbGncuK8UKC9RsUhzD40PWuVJ2FWugGjyc29yV/ZGbga+UHMLoU9oerCNC4qktDufv
 xnDgyW1745rmbbjtfASkewMALAZeDlvUIi4IC+59n8tumftQNvs95YNNR6DUFx905EPWwR+Ygmn
 IvipH+2D3aZIH3LOgk9RObFyjEE4dMqcx4iAdWuzXP+Ktv7hkLf58UHEla9bObvH/TcOSlUS6rw
 1jnT6Zh6s7ppYBHRXscpfUMbxeuwFsVZggeNAsOQdPc0mbLororNfsYXgsoPPwt+wrXzHrVqFlm
 iAO2cK5xBYecduhGgxyjiH4funwheyQVWOqQS4q00DDIkdLexVqqe9a+7tKyHbk6lA==
X-Google-Smtp-Source: AGHT+IEEHX8pKDHg71LhEoPviGa/F6tgCv1X0fd/1Xz9W8WOKY0pZVZP+aYOolcmcU/hfoL72X4/og==
X-Received: by 2002:a05:600c:14b:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-4390e38afe7mr58231285e9.14.1738841613584; 
 Thu, 06 Feb 2025 03:33:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d7c7sm51664645e9.14.2025.02.06.03.33.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 02/16] hw/net/xilinx_ethlite: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 12:33:07 +0100
Message-ID: <20250206113321.94906-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
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


