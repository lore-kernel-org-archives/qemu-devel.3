Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD668C021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC0M-0004DM-OU; Wed, 12 Feb 2025 07:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBze-0003XI-Pa
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBza-0000RI-2V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dd011ff8bso4002439f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 04:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739363837; x=1739968637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bl4sjYgd+6H7eHNUlupuE7g4cuSiaY2xksyCAoSPYXk=;
 b=NtX/E9KAs0RYGsnGrV82wwSYBvrf7bKAa650zTx8/anJioq0SSFctH7FQSI+0gz6UH
 5yxUYAgh+AT8exCgFePR0xSkqs5iIXoNzZ3WHsZkxEmuL5lcC1TP0WM0tkvrKRKA1axV
 BcGUFD5jXD4/wE8wdSETYxREwyCoj7L65h2keXfiiHx3UhtaZvq5En6xGpWRJa37sxkf
 UWpgaUQW+n2qC0xj+owPkPvIOvS16nyzFg8nTe8g3zxGj8zKPxRk/0+j/OqTI1Nx1adO
 fMA8YGNcAdlI+xDzvkt8GY0Z+wESTS3pqfZRUPs7iN+yQDXKCMTKNpMIWxoVMD/Gyu1d
 kKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739363837; x=1739968637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bl4sjYgd+6H7eHNUlupuE7g4cuSiaY2xksyCAoSPYXk=;
 b=KYSecj44zTQ65GhCeTolnbNFg/YAo9TTRTRFafTLJXP7b8sLqipdJy/2j95XqzNGhS
 /YqPC0gFZqVEc6qryVmlXeAroi+siW3tsK9YbNapU/pPBCjUX8uti7orXRvKLGsN9d3B
 m7jUGSrisW1D3+alcMrPdut5pRDCq4Z4e3jThPgoRn8FFdZuX8QUpg8UfDl8eIt6CbD3
 QHvj24sKjPvvDYzZRbhYGgjpH+mT9OUrJzLsUy2cEdwb4P9viuA9zt4C9CpxJd8n9a5y
 bt95gBuLBtnUNyHvb8BCkO/ivu4g9Ykfvf4VHl7dqTnaZRh4oTmOSiv/eXdd+4dWsoRT
 lg+g==
X-Gm-Message-State: AOJu0YwnNdCuuBz9ApbW+ErUkIp9P41hSXYsrJppB2RMGE0gJ+ysCoZU
 Nc8iSx8RWQFWjXlM6vdQmmZ0GAVc2ggDuMSg8vPac97lrHbtn4tzZ8CJE2QIOqt2WRE0VWSlIRs
 zejc=
X-Gm-Gg: ASbGncvAoMEO2bmCjLO1W9KZVr1InCOSr5vNjYvJV4k4PFIgVZ7fMBGOPNVFbzDzZWA
 YsL2qyN5qeJXgf2Zkcix90p1QmalHX7TOatrHo9ZhWMUGYBUsXBD4rHw+3StQP5uhD3FknkM48i
 BjIa2B51dGu8AzPnyc2xikV0+2pnPCp9fm/84QmytPDS5bW2FX6X1fUfaACau/V184/pah1n/un
 60dew7x7zlQrWOUn100jv0q6UDPQCGOJ9kQ9B+Wyu1Mh2d7QTbF79WkODwIHjcDRzr9v7JUja6l
 ynNfYpV9E8FODcYKvOVntpewTraAFfY0Patsgf0DjDbNXXRJ6rYjpWuOs1PL59siUg==
X-Google-Smtp-Source: AGHT+IFR/O1HEHK8VDX81U9oYQtNNBF24ESF1YjBMBGGRSO3+u6YpMi0vGBb+zkZL2IXTvHLC7CFmg==
X-Received: by 2002:a5d:59ab:0:b0:38d:d8b2:ceef with SMTP id
 ffacd0b85a97d-38dea2709b9mr2593018f8f.13.1739363836237; 
 Wed, 12 Feb 2025 04:37:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2750829sm12277708f8f.7.2025.02.12.04.37.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 04:37:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 03/10] hw/net/xilinx_ethlite: Make device endianness
 configurable
Date: Wed, 12 Feb 2025 13:36:52 +0100
Message-ID: <20250212123659.52764-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212123659.52764-1-philmd@linaro.org>
References: <20250212123659.52764-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 hw/net/xilinx_ethlite.c                  | 29 +++++++++++++++++++-----
 hw/riscv/microblaze-v-generic.c          |  1 +
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 15cabe11777..d419dc49a25 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -123,6 +123,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     dev = qdev_new("xlnx.xps-ethernetlite");
+    qdev_prop_set_enum(dev, "endianness", endianness);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 14bf2b2e17a..15d9b95aa80 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -34,6 +34,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/misc/unimp.h"
 #include "net/net.h"
 #include "trace.h"
@@ -85,6 +86,7 @@ struct XlnxXpsEthLite
 {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion container;
     qemu_irq irq;
     NICState *nic;
@@ -183,10 +185,10 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
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
@@ -195,6 +197,9 @@ static const MemoryRegionOps eth_porttx_ops = {
             .min_access_size = 4,
             .max_access_size = 4,
         },
+    },
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
@@ -232,10 +237,10 @@ static void port_rx_write(void *opaque, hwaddr addr, uint64_t value,
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
@@ -244,6 +249,9 @@ static const MemoryRegionOps eth_portrx_ops = {
             .min_access_size = 4,
             .max_access_size = 4,
         },
+    },
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static bool eth_can_rx(NetClientState *nc)
@@ -300,6 +308,14 @@ static NetClientInfo net_xilinx_ethlite_info = {
 static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
+    unsigned ops_index;
+
+    if (s->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_ETHLITE " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+    ops_index = s->model_endianness == ENDIAN_MODE_BIG ? 1 : 0;
 
     memory_region_init(&s->container, OBJECT(dev),
                        "xlnx.xps-ethernetlite", 0x2000);
@@ -328,7 +344,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                                BUFSZ_MAX, &error_abort);
         memory_region_add_subregion(&s->container, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
-                              &eth_porttx_ops, s,
+                              &eth_porttx_ops[ops_index], s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
                               4 * TX_MAX);
         memory_region_add_subregion(&s->container, i ? A_TX_BASE1 : A_TX_BASE0,
@@ -340,7 +356,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->container, 0x1000 + 0x0800 * i,
                                     &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
-                              &eth_portrx_ops, s,
+                              &eth_portrx_ops[ops_index], s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
                               4 * RX_MAX);
         memory_region_add_subregion(&s->container, i ? A_RX_BASE1 : A_RX_BASE0,
@@ -363,6 +379,7 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static const Property xilinx_ethlite_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XlnxXpsEthLite, model_endianness),
     DEFINE_PROP_UINT32("tx-ping-pong", XlnxXpsEthLite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", XlnxXpsEthLite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(XlnxXpsEthLite, conf),
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index ebdd461ae98..a21fdfbe6db 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -120,6 +120,7 @@ static void mb_v_generic_init(MachineState *machine)
 
     /* Emaclite */
     dev = qdev_new("xlnx.xps-ethernetlite");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
-- 
2.47.1


