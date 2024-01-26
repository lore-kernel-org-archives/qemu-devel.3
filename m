Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD2C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMKZ-00052j-QR; Fri, 26 Jan 2024 08:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMKM-0004Lw-Re; Fri, 26 Jan 2024 08:33:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMKJ-00080i-D1; Fri, 26 Jan 2024 08:33:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLzCZ36FHz4wxx;
 Sat, 27 Jan 2024 00:32:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLzCX31X4z4wny;
 Sat, 27 Jan 2024 00:32:56 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 14/17] hw/arm: Hook up FSI module in AST2600
Date: Fri, 26 Jan 2024 14:32:13 +0100
Message-ID: <20240126133217.996306-15-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133217.996306-1-clg@kaod.org>
References: <20240126133217.996306-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Ninad Palsule <ninad@linux.ibm.com>

This patchset introduces IBM's Flexible Service Interface(FSI).

Time for some fun with inter-processor buses. FSI allows a service
processor access to the internal buses of a host POWER processor to
perform configuration or debugging.

FSI has long existed in POWER processes and so comes with some baggage,
including how it has been integrated into the ASPEED SoC.

Working backwards from the POWER processor, the fundamental pieces of
interest for the implementation are:

1. The Common FRU Access Macro (CFAM), an address space containing
   various "engines" that drive accesses on buses internal and external
   to the POWER chip. Examples include the SBEFIFO and I2C masters. The
   engines hang off of an internal Local Bus (LBUS) which is described
   by the CFAM configuration block.

2. The FSI slave: The slave is the terminal point of the FSI bus for
   FSI symbols addressed to it. Slaves can be cascaded off of one
   another. The slave's configuration registers appear in address space
   of the CFAM to which it is attached.

3. The FSI master: A controller in the platform service processor (e.g.
   BMC) driving CFAM engine accesses into the POWER chip. At the
   hardware level FSI is a bit-based protocol supporting synchronous and
   DMA-driven accesses of engines in a CFAM.

4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
   POWER processors. This now makes an appearance in the ASPEED SoC due
   to tight integration of the FSI master IP with the OPB, mainly the
   existence of an MMIO-mapping of the CFAM address straight onto a
   sub-region of the OPB address space.

5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in
   the AST2600. Hardware limitations prevent the OPB from being directly
   mapped into APB, so all accesses are indirect through the bridge.

The implementation appears as following in the qemu device tree:

    (qemu) info qtree
    bus: main-system-bus
      type System
      ...
      dev: aspeed.apb2opb, id ""
        gpio-out "sysbus-irq" 1
        mmio 000000001e79b000/0000000000001000
        bus: opb.1
          type opb
          dev: fsi.master, id ""
            bus: fsi.bus.1
              type fsi.bus
              dev: cfam.config, id ""
              dev: cfam, id ""
                bus: fsi.lbus.1
                  type lbus
                  dev: scratchpad, id ""
                    address = 0 (0x0)
        bus: opb.0
          type opb
          dev: fsi.master, id ""
            bus: fsi.bus.0
              type fsi.bus
              dev: cfam.config, id ""
              dev: cfam, id ""
                bus: fsi.lbus.0
                  type lbus
                  dev: scratchpad, id ""
                    address = 0 (0x0)

The LBUS is modelled to maintain the qdev bus hierarchy and to take
advantage of the object model to automatically generate the CFAM
configuration block. The configuration block presents engines in the
order they are attached to the CFAM's LBUS. Engine implementations
should subclass the LBusDevice and set the 'config' member of
LBusDeviceClass to match the engine's type.

CFAM designs offer a lot of flexibility, for instance it is possible for
a CFAM to be simultaneously driven from multiple FSI links. The modeling
is not so complete; it's assumed that each CFAM is attached to a single
FSI slave (as a consequence the CFAM subclasses the FSI slave).

As for FSI, its symbols and wire-protocol are not modelled at all. This
is not necessary to get FSI off the ground thanks to the mapping of the
CFAM address space onto the OPB address space - the models follow this
directly and map the CFAM memory region into the OPB's memory region.
Future work includes supporting more advanced accesses that drive the
FSI master directly rather than indirectly via the CFAM mapping, which
will require implementing the FSI state machine and methods for each of
the FSI symbols on the slave. Further down the track we can also look at
supporting the bitbanged SoftFSI drivers in Linux by extending the FSI
slave model to resolve sequences of GPIO IRQs into FSI symbols, and
calling the associated symbol method on the slave to map the access onto
the CFAM.

Testing:
    Tested by reading cfam config address 0 on rainier machine type.

    root@p10bmc:~# pdbg -a getcfam 0x0
    p0: 0x0 = 0xc0022d15

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  4 ++++
 hw/arm/aspeed_ast2600.c     | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 0db5a41e7170..9d0af84a8cff 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -36,6 +36,7 @@
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/unimp.h"
 #include "hw/misc/aspeed_peci.h"
+#include "hw/fsi/aspeed_apb2opb.h"
 #include "hw/char/serial.h"
 
 #define ASPEED_SPIS_NUM  2
@@ -90,6 +91,7 @@ struct AspeedSoCState {
     UnimplementedDeviceState udc;
     UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
+    AspeedAPB2OPBState fsi[2];
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -216,6 +218,8 @@ enum {
     ASPEED_DEV_SGPIOM,
     ASPEED_DEV_JTAG0,
     ASPEED_DEV_JTAG1,
+    ASPEED_DEV_FSI1,
+    ASPEED_DEV_FSI2,
 };
 
 #define ASPEED_SOC_SPI_BOOT_ADDR 0x0
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 24541b5284d4..bc7f0bad8312 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -75,6 +75,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_UART12]    = 0x1E790600,
     [ASPEED_DEV_UART13]    = 0x1E790700,
     [ASPEED_DEV_VUART]     = 0x1E787000,
+    [ASPEED_DEV_FSI1]      = 0x1E79B000,
+    [ASPEED_DEV_FSI2]      = 0x1E79B100,
     [ASPEED_DEV_I3C]       = 0x1E7A0000,
     [ASPEED_DEV_SDRAM]     = 0x80000000,
 };
@@ -132,6 +134,8 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_ETH4]      = 33,
     [ASPEED_DEV_KCS]       = 138,   /* 138 -> 142 */
     [ASPEED_DEV_DP]        = 62,
+    [ASPEED_DEV_FSI1]      = 100,
+    [ASPEED_DEV_FSI2]      = 101,
     [ASPEED_DEV_I3C]       = 102,   /* 102 -> 107 */
 };
 
@@ -265,6 +269,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_initialize_child(obj, "emmc-boot-controller",
                             &s->emmc_boot_controller,
                             TYPE_UNIMPLEMENTED_DEVICE);
+
+    for (i = 0; i < ASPEED_FSI_NUM; i++) {
+        object_initialize_child(obj, "fsi[*]", &s->fsi[i], TYPE_ASPEED_APB2OPB);
+    }
 }
 
 /*
@@ -624,6 +632,17 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         return;
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV_SBC]);
+
+    /* FSI */
+    for (i = 0; i < ASPEED_FSI_NUM; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fsi[i]), 0,
+                        sc->memmap[ASPEED_DEV_FSI1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
+    }
 }
 
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
-- 
2.43.0


