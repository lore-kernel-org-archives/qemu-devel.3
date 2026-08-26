Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88E4C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLlK-0005FL-LD; Wed, 26 Aug 2026 18:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLlJ-0005F2-TX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:25 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLlI-0004oA-Bu
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:25 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso1080494a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781983; x=1788386783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZgJzq+XsYOvtH3xWP7INoFWVb96qT7YPWqEHVflcXbM=;
 b=IXlhBAlKjYDFg+8NvJP0Nizz1/oKPIFk2UMzUz8fx48QXCLjNa9Snoqg2EDSB30hH9
 yKyhjVDagOMfsK200LdeGrODXgAcP12COyD2Zllv17HK/96CcoXUXkcdFQJsh6xLfjrw
 KvM2gWqLIUM91XQLBYuJrM2lEXeMa6nfTIH4BTDFpa3zKWMOjcyn+YqrKX0bPEPR68Q4
 e9Qp7YZOX2xh0nE7OesOjs5sQHmRzqzpRlSgt8uNQlt2RBZB6K4H4JZA4w4Ik51tAOfz
 64NFUqmorPDgjZmI++khiUCsBcEmRuvB5L1VOjYEk8HELIuj5epaM02Q8NfIsS4lnj+Z
 yknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781983; x=1788386783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZgJzq+XsYOvtH3xWP7INoFWVb96qT7YPWqEHVflcXbM=;
 b=nBMZ4zd+h6uwRsUv6yf0sbIBiCSWJNSX7bhtIT16/ansKM6khpZB6hxPD9nkJPEN1B
 mqQlqOdQXyZrlYymGfaG2sQVi5ZT1i9+XtnxTMYnL5kH7NG0o3kCS5O84P6eLlvECeap
 hfvsgxdY7c2Q7BjvyBgdVXwlVVSPUL/+8/LyU/v8eB4HqfKoK4pzterLQbbab832/pGP
 3309XPpCVqE38BaVszr/acPmRVW8wQ2Mk9h7GSlvM/XGVdyf5Snc2kdxcMxb1S7rNawJ
 wslDVbH3gPfHgePSBng6Ud3QBd5uA1oj+WtoYMfHdVmhXiyermh8mHhOJ6r7Cy17M3wC
 YJUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoELGnBBSMo1LMp/5K8XgrFaX8FCyeNP7wb+Ga+177LenWGiyzzF6IjuK32j1IKcLzxXMECaRRxgOkX@nongnu.org
X-Gm-Message-State: AFuF++mcT9ONzzZgfIgx4079E3B6Hp3oWyU8KVsXIboW2RqPwMUmDYWM
 UtJH9+ZOvPmXy/j2WwziwkVnmkMxtN3CGyre5ttk/Gbs8hVC/QGD9OnF
X-Gm-Gg: AR+sD1168/cvI9fAfsaj3AFOeLp2Zy5OwSUwMI67+Jr9/ZKiwSMI6eO0darm+ISfEeI
 SXl4f9lYnJTwgGIm8CD5Ce/HZnsluypdhhsnJ74y7OYA4c/dYs4dzLnvvDW99obAvjTa6QADvRc
 FfKmE8v/GZZ+a59Pz0tLu67vz0Mn8cSBrT7WQzos0smXCfILFiIZSmqQiVuojE3L+mIJw9DmsQj
 yUdrPUPInZ8d8e8ROVHoyM1c8i51yWBsHopkE8JU55aZWDLK/FgwAl9uCH261oWXrChWb1X0x8G
 QwMnEGw563TV/bjNeSle4utUpfrCy5LlN0RAv25OGgTKWGZEqVSV+UJcw0Ed6KZmU2zD0DspT5z
 NeprSxHFUUDln3V/dZIJ1S4sRsesSG24E0vn2QMfOqpPH1WsMbdCsxHf5DwNWWjNm2Wj0eG2jnj
 wP/o9frFuE8gQZanTTceVlaMl7gXTA/dd4gKcOhA+LOY6H/NfoDlkb+TFPwgKbvQ95NnK/KraOJ
 y0GXHbZCznW8dGpnz5R4874OkZsngVdS2zNtLg0Zs0AvGVjU9zwy4XG7rLfKZ2qDh9N6pVQ1gZV
 fpAuoiEy79kkj/uVw+W/
X-Received: by 2002:a17:90b:530c:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-3966d443d6bmr19042432a91.13.1787781983027; 
 Wed, 26 Aug 2026 15:06:23 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:06:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 07/16] hw/riscv/atlantis: Make UART unimp region a SoC device
Date: Thu, 27 Aug 2026 07:35:17 +0930
Message-ID: <20260826220528.54516-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826220528.54516-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make the unimplemented region covering the remainder of the console
UART's register space a SoC child device, mapped using a helper. This
makes it easier to map it into the SoC's memory container along with
the other devices in the future.

While here, rename the region from uart0 to uart1. The uart0 name was
a leftover from an earlier revision that used a different device for
the console.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  2 ++
 hw/riscv/tt_atlantis.c         | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 7f7d4a5a5905..c9308aa57017 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,6 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/misc/unimp.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -31,6 +32,7 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
+    UnimplementedDeviceState uart1;
 
     int fdt_size;
 };
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 3f183db5c302..acfd0d31b368 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -409,6 +409,17 @@ static void load_fdt(TTAtlantisState *s)
     create_fdt_memory(s);
 }
 
+static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
+                                   const char *name, hwaddr addr, uint64_t size)
+{
+    qdev_prop_set_string(DEVICE(dev), "name", name);
+    qdev_prop_set_uint64(DEVICE(dev), "size", size);
+    sysbus_realize(dev, &error_abort);
+
+    memory_region_add_subregion_overlap(memory, addr,
+                                        sysbus_mmio_get_region(dev, 0), -1000);
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -560,9 +571,11 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    create_unimplemented_device("tt-atlantis.uart0",
-                                s->memmap[TT_ATL_UART1].base,
-                                s->memmap[TT_ATL_UART1].size);
+    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
+                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
+                           s->memmap[TT_ATL_UART1].size);
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-- 
2.47.3


