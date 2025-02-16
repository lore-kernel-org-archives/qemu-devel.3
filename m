Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0069BC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllp-0002zt-AJ; Sun, 16 Feb 2025 16:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllV-0002xr-He
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllR-0007uR-Se
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f3913569fso532506f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739680; x=1740344480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wrm+gmtrLNVt14xuZM8s4Q4nLZI3fouuzjwm1bbZKOw=;
 b=JYPxXBziNvH2WB3W1tVnmXQ0m0lrULhxA0UruLvJPdIYJEm9usg5AB1cBQg6gIwdRM
 rIWj5au+GgegiypBTWrLODq1LA0os65NxaOcV7vCtml5gwEB1oVEvZfDWtOkr/AQEZD2
 iIQNUxhqEH5Tb4JnjwSylgQyU1lGzeK2ATwwzvHj/3vON1/FjL3REAZ4onPRGG88SXfD
 1ysYGp6fWufZ7wJwJ4FsAMTB2PU0dkYpNRxPVcQw9f3c9Tx2IcfH/wdGsWB68ca7hRM6
 e3Lryapgg14Zqu7QoHwHz64BjVSJFMZFK4Tdw27LgzxCLCZ28VxMFa1PWBmn0lSGTEmt
 7Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739680; x=1740344480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wrm+gmtrLNVt14xuZM8s4Q4nLZI3fouuzjwm1bbZKOw=;
 b=BgxgjnQ7ZE57t/W0Lj+h+WBm7qjQZtSsLxG/Vw9dkuJeaAhmasGxAo2t5FrlNiRBXl
 9Kki9uDRN+ufoMaaYT85tEIu53nENhOiagLUDpclbHyLu16yUyYu04AtZco1UiQwtE1/
 msnZ3THnFagt9NFsKz/tP/lI3HAD8g+mfWLVSZgWWYF6Z9WDT/MLz7EYyZg/1HycbgqW
 L/YrsDoWakvxbNjatF1vY4f8AqmngUgMYXLkHbKyz2anvA3lxJbaV/Am127UP613kSKi
 O20zzkPiM0PAhhbLf077/02YpPV6Up64G936/qOrC2M9oKr6ee/uVoUtXBotak4i+l+8
 Z0pg==
X-Gm-Message-State: AOJu0YyFqVWmg/LmeV8hFpSYGQiSkKssxU2TaWY+gkC1SAOAF57cdbX2
 QDZg01TbY8DgT4Ted7kPpzl8D17k5Y/t/94T05+fQOFhzKJVqmQsH0OoLsy80HDdqoEOK6myGC8
 ISAw=
X-Gm-Gg: ASbGncsJ+6f9ORB/NbzAA9UB+VI6ORtgH3JjN8fOcTXs8wBghk9+EKgzJMxOXay963S
 E4gRjOtrzDFiUZNymayKqPTWd/34DCwTIt8LJOqXNT5v2eCBGft7rulHQBdvGjcGGOU8Jw1Wuvv
 jsMADZNVMD1YeLSDj0wV8SDREotZrQn/2e2+0Tn7oLsPs/n0zG8OgY4x1c1BXFFhP+90NuWoToH
 qzQIPd1WcPqaU6cEoXDSdEPhPByDGJxx5/wrCRmOF9Zlm3N5l+SXDqRjd5S64OvNf5l9GHNIyfH
 Il8X1ObKpPZp4sBb/jnZEQroXMSnqvDuaXxvbArRmEoLmtWWFH4X3aZLKgZfJKiKk/M2Hhg=
X-Google-Smtp-Source: AGHT+IG7+0Oki6le4Kn5O4crW2h5sqRGcPRPkp9la9xIzaRyskUekP5FGnckvnPtsV7cnclN/qlpNA==
X-Received: by 2002:a5d:59c8:0:b0:38e:dcd1:3366 with SMTP id
 ffacd0b85a97d-38f24d74705mr14170000f8f.20.1739739679799; 
 Sun, 16 Feb 2025 13:01:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398872fa85sm312805e9.28.2025.02.16.13.01.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/39] hw/net/xilinx_ethlite: Make device endianness
 configurable
Date: Sun, 16 Feb 2025 22:00:55 +0100
Message-ID: <20250216210103.70235-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.

Add the "endianness" property to select the device endianness.
This property is unspecified by default, and machines need to
set it explicitly.

Set the proper endianness for each machine using the device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250213122217.62654-4-philmd@linaro.org>
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


