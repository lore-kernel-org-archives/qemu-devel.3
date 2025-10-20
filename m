Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5FFCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAuPC-0004mJ-RI; Mon, 20 Oct 2025 14:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vAuP9-0004m8-Jg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:14:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vAuP3-0005ys-Dk
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:14:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso48965145e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1760984079; x=1761588879;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26GFMwjjyHhVWRU7X1Aq1GWsGve1b+EPAYvNEQdTRPg=;
 b=bv7ze2jtpqMUCbfkiAW30UlOunPMVClz9KjLMr3AdvCqy3+5BePVHzUv+mX0CicQ88
 Ge4d5s3NNAEEBCWoOvKUBI4lqSgxMLYrqbR5ltPqd+hdV76dFu+4QaNzCOXhl+XnTWvT
 S1+XQzHjj44aC/mPjWBcb4OGGFF3lR4lHw6SlDDK3xJd63GtYK8ekfUK4581N6ftieLT
 AKNtbcjf2nNLP3vTmLyfXzcgC6BhXhjSHP1a0f2tGnJxkIESd4zjkoD3nccy9DsJvfyW
 9q9LsnAHl5ODtLKaHs/ztqu+C2k/OWCls6w/47vGRAZy5VsGi3PuG0/Vc4p0/s2XH6e6
 U7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760984079; x=1761588879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26GFMwjjyHhVWRU7X1Aq1GWsGve1b+EPAYvNEQdTRPg=;
 b=umvVqH3E7u848nW1u+9p4Ggy0lDaMnZUlQ/NgY9VRH/FUDK+2AYJ2+GTGOcH9y/KAG
 XYr8i5/VH5lKZFZost9JLJdLUZVmQw93KGpDT1UeJ9qoOONeebTy0WBsES3deef6Gr95
 VoZPjaT2NXcOeyEi0nIl1lDtAUXijUb/K/q4ySzxxs0kfWm75XgUM7w76QNqZCHpGvoN
 fi7a8X4oUzd+IY9+al15JGQYAzLxidM2Skyz04WslAEMydaC2ThGmCcALWBp19roTL/i
 TI8T/YOYQqYGNnUUdZwmP7vxnGp1eCYknLXNu/DYKtV1rleaiqXX1YJTq6p1ZuIiuHpw
 wj5w==
X-Gm-Message-State: AOJu0Yy8D+2DxlZiKnb0/RzSPEeM/UPdsbdGV9wB1w5tRIjFuiXXxEIR
 wvRV+7dUK+gZTRfaQAk5GQdbMEiu5BzOWeYc5RVarR7cxDWmu6vON/qE0WFuaaUEetA3tDNDQfJ
 MtwGbxkU=
X-Gm-Gg: ASbGncuqc04PffRXjZPyUTvEArcZg0bgi76i8zV7LIDm2qShqV1MVrrhGu0QkzrwNsj
 LJOI9zG/Ye0WTTYSp3UIo6+e8TmlWD1ti5fSYgIdZcSHLTv6Kr4v4oguEFR4+E+5FPc4nnp7pmR
 HKXZ/cyoetC4r6KRf5pjtMFgW1K5dsIbYeNWTIiaKLpmOtiLwFfKLAdUWeirnVcZ3iQ/a/tMoDj
 sl+kf+r5lWwduqSqOHFhlXyvW1qAP7Byhn/HAMXBd868hi2m7QDh47IFCZIcaPMIoziy/sutSUQ
 yfdxDb8S7Y9aRPuiyx7MuKD3H2V4fOQT7yUsk+X4eudycIwQjtvBwuHXbYXKjHoTTC1uhRfbh4J
 JBBjkfErePtNBMc63GEX/rVnkqHmZ8urhUgvOd5Fm83DCVilLCvoeNeyP450OyhzdmHSV0C7m1/
 n0pCxy/w99BRLiaY8=
X-Google-Smtp-Source: AGHT+IFyO0EXbjfRWK8A3lCmX3kyzr+5nw5VKAC1BS1ZsW+YClM8DQEBkcSjOokkH2dBLwOdzTnXbw==
X-Received: by 2002:a05:600d:60a5:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-47117872658mr122644385e9.2.1760984078055; 
 Mon, 20 Oct 2025 11:14:38 -0700 (PDT)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fa8sm16731063f8f.38.2025.10.20.11.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 11:14:37 -0700 (PDT)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
Subject: [PATCH v1 1/1] hw/riscv: adding support for NeoRV32 RiscV MCU
Date: Mon, 20 Oct 2025 21:14:35 +0300
Message-Id: <20251020181435.8242-2-michael@videogpu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251020181435.8242-1-michael@videogpu.com>
References: <20251020181435.8242-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::336;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Michael <michael@videogpu.com>

1) Initial support for Neorv32 soft-core MCU
2) IMEM, DMEM memory regions, bootloader ROM
3) Basic support for UART0 (no interrupts yet)
4) Basic support for SPI
5) Added SPI flash memory for loading firmware following  bootloader
6) Based on Neorv32 RTL implementation repo
   https://github.com/stnolting/neorv32
   commit id 7d0ef6b2

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 .gitignore                                  |   1 +
 configs/devices/riscv32-softmmu/default.mak |   1 +
 docs/system/riscv/neorv32.rst               | 110 +++++
 hw/char/Kconfig                             |   3 +
 hw/char/meson.build                         |   1 +
 hw/char/neorv32_uart.c                      | 311 ++++++++++++
 hw/misc/Kconfig                             |   2 +
 hw/misc/meson.build                         |   1 +
 hw/misc/neorv32_sysinfo.c                   | 183 +++++++
 hw/misc/neorv32_sysinfo.h                   |  79 +++
 hw/misc/neorv32_sysinfo_rtl.h               | 134 ++++++
 hw/riscv/Kconfig                            |   8 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/neorv32.c                          | 219 +++++++++
 hw/ssi/Kconfig                              |   4 +
 hw/ssi/meson.build                          |   1 +
 hw/ssi/neorv32_spi.c                        | 504 ++++++++++++++++++++
 include/hw/char/neorv32_uart.h              |  68 +++
 include/hw/riscv/neorv32.h                  |  60 +++
 include/hw/ssi/neorv32_spi.h                |  70 +++
 target/riscv/cpu-qom.h                      |   2 +
 target/riscv/cpu.c                          |  18 +
 target/riscv/cpu.h                          |   3 +
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/cpu_cfg_fields.h.inc           |   1 +
 target/riscv/cpu_vendorid.h                 |   2 +
 target/riscv/meson.build                    |   1 +
 target/riscv/neorv32_csr.c                  |  54 +++
 28 files changed, 1843 insertions(+)
 create mode 100644 docs/system/riscv/neorv32.rst
 create mode 100644 hw/char/neorv32_uart.c
 create mode 100644 hw/misc/neorv32_sysinfo.c
 create mode 100644 hw/misc/neorv32_sysinfo.h
 create mode 100644 hw/misc/neorv32_sysinfo_rtl.h
 create mode 100644 hw/riscv/neorv32.c
 create mode 100644 hw/ssi/neorv32_spi.c
 create mode 100644 include/hw/char/neorv32_uart.h
 create mode 100644 include/hw/riscv/neorv32.h
 create mode 100644 include/hw/ssi/neorv32_spi.h
 create mode 100644 target/riscv/neorv32_csr.c

diff --git a/.gitignore b/.gitignore
index 61fa39967b..b53806de50 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 .clang-format
 .gdb_history
 cscope.*
+phases.hold
 tags
 TAGS
 GPATH
diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
index c2cd86ce05..4fdc94ab48 100644
--- a/configs/devices/riscv32-softmmu/default.mak
+++ b/configs/devices/riscv32-softmmu/default.mak
@@ -10,3 +10,4 @@
 # CONFIG_SIFIVE_U=n
 # CONFIG_RISCV_VIRT=n
 # CONFIG_OPENTITAN=n
+# CONFIG_NEORV32=n
diff --git a/docs/system/riscv/neorv32.rst b/docs/system/riscv/neorv32.rst
new file mode 100644
index 0000000000..7f9048a7ad
--- /dev/null
+++ b/docs/system/riscv/neorv32.rst
@@ -0,0 +1,110 @@
+
+NEORV32 Soft SoC (``neorv32``)
+==============================
+
+The ``neorv32`` machine models a minimal NEORV32-based SoC sufficient to
+exercise the stock NEORV32 bootloader and run example applications from an
+emulated SPI NOR flash. It exposes a UART for console I/O and an MTD-backed
+SPI flash device that can be populated with user binaries.
+
+Neorv32 full repo:
+https://github.com/stnolting/neorv32
+
+Current QEMU implementation base on commit 7d0ef6b2 in Neorv32 repo.
+
+Supported devices
+-----------------
+
+The ``neorv32`` machine provides the core peripherals needed by the
+bootloader and examples:
+
+* UART for console (mapped to the QEMU stdio when ``-nographic`` or
+  ``-serial stdio`` is used).
+* SPI controller connected to an emulated SPI NOR flash (exposed to the
+  guest via QEMU's ``if=mtd`` backend).
+* Basic timer/CLINT-like facilities required by the example software.
+
+(Exact register maps and optional peripherals depend on the QEMU version and
+the specific patch series you are using.)
+
+
+QEMU build configuration:
+------------------------
+/path/to/qemu/configure \
+  --python=/usr/local/bin/python3.12 \
+  --target-list=riscv32-softmmu \
+  --enable-fdt \
+  --enable-debug \
+  --disable-vnc \
+  --disable-gtk
+
+Boot options
+------------
+
+Typical usage is to boot the NEORV32 bootloader as the QEMU ``-bios`` image,
+and to provide a raw SPI flash image via an MTD drive. The bootloader will
+then jump to the application image placed at the configured flash offset.
+
+Preparing the SPI flash with a “Hello World” example
+----------------------------------------------------
+
+1. Create a 64 MiB flash image (filled with zeros)::
+
+   $ dd if=/dev/zero of=$HOME/flash_contents.bin bs=1 count=$((0x04000000))
+
+2. Place your application binary at the **4 MiB** offset inside the flash.
+   Replace ``/path/to/neorv32_exe.bin`` with the path to your compiled
+   example application (e.g., the NEORV32 ``hello_world`` example)::
+
+   $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \
+        bs=1 seek=$((0x00400000)) conv=notrunc
+
+Running the “Hello World” example
+---------------------------------
+
+Run QEMU with the NEORV32 bootloader as ``-bios`` and attach the prepared
+flash image via the MTD interface. Replace the placeholder paths with your
+local paths::
+
+  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
+      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
+      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw
+
+Notes:
+
+* ``-nographic`` routes the UART to your terminal (Ctrl-A X to quit when
+  using the QEMU monitor hotkeys; or just close the terminal).
+* The bootloader starts first and will transfer control to your application
+  located at the 4 MiB offset of the flash image.
+* If you prefer, you can use ``-serial stdio`` instead of ``-nographic``.
+
+Machine-specific options
+------------------------
+
+Unless otherwise noted by the patch series, there are no special board
+options beyond the standard QEMU options shown above. Commonly useful
+generic options include:
+
+* ``-s -S`` to open a GDB stub on TCP port 1234 and start paused, so you can
+  debug both QEMU and the guest.
+* ``-d guest_errors,unimp`` (or other trace flags) for additional logging.
+
+Example: debugging with GDB::
+
+  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
+      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
+      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw \
+      -s -S
+
+  # In another shell:
+  $ riscv32-unknown-elf-gdb /path/to/neorv32/bootloader/main.elf
+  (gdb) target remote :1234
+
+
+Known limitations
+-----------------
+
+This is a functional model intended for software bring-up and testing of
+example programs. It may not model all timing details or every optional
+peripheral available in a specific NEORV32 SoC configuration.
+
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..1fd39c2b30 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config NEORV32_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index a9e1dc26c0..2f5bf827a7 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
+system_ss.add(when: 'CONFIG_NEORV32_UART', if_true: files('neorv32_uart.c'))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
new file mode 100644
index 0000000000..b54ab54d6a
--- /dev/null
+++ b/hw/char/neorv32_uart.c
@@ -0,0 +1,311 @@
+/*
+ * Neorv32-specific UART.
+ *
+ * Copyright (c) 2025 Michael Levit
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/irq.h"
+#include "hw/char/neorv32_uart.h"
+#include "hw/qdev-properties-system.h"
+
+typedef volatile struct __attribute__((packed,aligned(4))) {
+  uint32_t CTRL;  /**< offset 0: control register (#NEORV32_UART_CTRL_enum) */
+  uint32_t DATA;  /**< offset 4: data register  (#NEORV32_UART_DATA_enum) */
+} neorv32_uart_t;
+
+#define NEORV32_UART_IO_REGION_SIZE  (32)
+
+static Property neorv32_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
+};
+
+enum {
+    NEORV32_UART_CTRL = 0,  /**< offset 0: control register */
+    NEORV32_UART_DATA = 4  /**< offset 4: data register  */
+};
+
+/** UART control register bits */
+enum NEORV32_UART_CTRL_enum {
+  UART_CTRL_EN            =  0, /**< UART control register(0)  (r/w): UART global enable */
+  UART_CTRL_SIM_MODE      =  1, /**< UART control register(1)  (r/w): Simulation output override enable */
+  UART_CTRL_HWFC_EN       =  2, /**< UART control register(2)  (r/w): Enable RTS/CTS hardware flow-control */
+  UART_CTRL_PRSC_LSB      =  3, /**< UART control register(3)  (r/w): clock prescaler select, bit 0 (LSB) */
+  UART_CTRL_PRSC_MSB      =  5, /**< UART control register(5)  (r/w): clock prescaler select, bit 2 (MSB) */
+  UART_CTRL_BAUD_LSB      =  6, /**< UART control register(6)  (r/w): BAUD rate divisor, bit 0 (LSB) */
+  UART_CTRL_BAUD_MSB      = 15, /**< UART control register(15) (r/w): BAUD rate divisor, bit 9 (MSB) */
+  UART_CTRL_RX_NEMPTY     = 16, /**< UART control register(16) (r/-): RX FIFO not empty */
+  UART_CTRL_RX_FULL       = 17, /**< UART control register(17) (r/-): RX FIFO full */
+  UART_CTRL_TX_EMPTY      = 18, /**< UART control register(18) (r/-): TX FIFO empty */
+  UART_CTRL_TX_NFULL      = 19, /**< UART control register(19) (r/-): TX FIFO not full */
+  UART_CTRL_IRQ_RX_NEMPTY = 20, /**< UART control register(20) (r/w): Fire IRQ if RX FIFO not empty */
+  UART_CTRL_IRQ_RX_FULL   = 21, /**< UART control register(21) (r/w): Fire IRQ if RX FIFO full */
+  UART_CTRL_IRQ_TX_EMPTY  = 22, /**< UART control register(22) (r/w): Fire IRQ if TX FIFO empty */
+  UART_CTRL_IRQ_TX_NFULL  = 23, /**< UART control register(23) (r/w): Fire IRQ if TX FIFO not full */
+
+  UART_CTRL_RX_OVER       = 30, /**< UART control register(30) (r/-): RX FIFO overflow */
+  UART_CTRL_TX_BUSY       = 31  /**< UART control register(31) (r/-): Transmitter busy or TX FIFO not empty */
+};
+
+/**  bits */
+enum NEORV32_UART_DATA_enum {
+  UART_DATA_RTX_LSB          =  0, /**< (r/w): UART rx/tx data, LSB */
+  UART_DATA_RTX_MSB          =  7, /**< (r/w): UART rx/tx data, MSB */
+
+  UART_DATA_RX_FIFO_SIZE_LSB =  8, /**< (r/-): log2(RX FIFO size), LSB */
+  UART_DATA_RX_FIFO_SIZE_MSB = 11, /**< (r/-): log2(RX FIFO size), MSB */
+
+  UART_DATA_TX_FIFO_SIZE_LSB = 12, /**< (r/-): log2(RX FIFO size), LSB */
+  UART_DATA_TX_FIFO_SIZE_MSB = 15, /**< (r/-): log2(RX FIFO size), MSB */
+};
+/**@}*/
+
+static void neorv32_uart_update_irq(Neorv32UARTState *s)
+{
+    int cond = 0;
+    if ((s->ie & NEORV32_UART_IE_TXWM) ||
+        ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
+        cond = 1;
+    }
+    if (cond) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint64_t
+neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    Neorv32UARTState *s = opaque;
+    unsigned char r;
+
+    switch (addr) {
+        case NEORV32_UART_CTRL:
+			if (s->rx_fifo_len) {
+				s->CTRL |= (1 << UART_CTRL_RX_NEMPTY); /* set data available */
+			} else {
+				s->CTRL &= ~(1 << UART_CTRL_RX_NEMPTY); /* clear data available */
+			}
+			//TODO: assuming here TX is always avalable, fix it.
+			s->CTRL |= (1 << UART_CTRL_TX_NFULL); /* set TX not full */
+
+        	return s->CTRL;
+
+        case NEORV32_UART_DATA:
+            if (s->rx_fifo_len) {
+                r = s->rx_fifo[0];
+                memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
+                s->rx_fifo_len--;
+                qemu_chr_fe_accept_input(&s->chr);
+                s->DATA = r;
+
+                neorv32_uart_update_irq(s); /* TODO: check if need to call */
+                return r;
+            }
+        }
+
+
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=0x%x\n",
+                  __func__, (int)addr);
+    return 0;
+}
+
+
+
+static void
+neorv32_uart_write(void *opaque, hwaddr addr,
+                  uint64_t val64, unsigned int size)
+{
+
+    Neorv32UARTState *s = opaque;
+    uint32_t value = val64;
+    unsigned char ch = value;
+
+    /* TODO: check if need to update data and control bits */
+    switch (addr) {
+        case NEORV32_UART_CTRL:
+            s->CTRL = value;
+            /* TODO: check if need to call, depending on IRQ flags */
+            /* neorv32_uart_update_irq(s); */
+            return;
+        case NEORV32_UART_DATA:
+            s->DATA = value;
+            qemu_chr_fe_write(&s->chr, &ch, 1);
+            /* neorv32_uart_update_irq(s); TODO: check if need to call */
+            return;
+        }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                  __func__, (int)addr, (int)value);
+}
+
+static const MemoryRegionOps neorv32_uart_ops = {
+    .read  = neorv32_uart_read,
+    .write = neorv32_uart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static void neorv32_uart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    Neorv32UARTState *s = NEORV32_UART(obj);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
+                          TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+
+static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    Neorv32UARTState *s = opaque;
+
+    /* Got a byte.  */
+    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
+        printf("WARNING: UART dropped char.\n");
+        return;
+    }
+    s->rx_fifo[s->rx_fifo_len++] = *buf;
+
+    neorv32_uart_update_irq(s);
+}
+
+static int neorv32_uart_can_rx(void *opaque)
+{
+    Neorv32UARTState *s = opaque;
+
+    return s->rx_fifo_len < sizeof(s->rx_fifo);
+}
+
+static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
+{
+}
+
+static int  neorv32_uart_be_change(void *opaque)
+{
+    Neorv32UARTState *s = opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
+                             neorv32_uart_event, neorv32_uart_be_change, s,
+                             NULL, true);
+
+    return 0;
+}
+
+static void neorv32_uart_realize(DeviceState *dev, Error **errp)
+{
+    Neorv32UARTState *s = NEORV32_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
+                            neorv32_uart_event, neorv32_uart_be_change, s,
+                             NULL, true);
+
+}
+
+static const VMStateDescription vmstate_neorv32_uart = {
+    .name = TYPE_NEORV32_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(rx_fifo,
+                            Neorv32UARTState,
+                            NEORV32_UART_RX_FIFO_SIZE),
+        VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
+        VMSTATE_UINT32(ie, Neorv32UARTState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void neorv32_uart_reset_enter(Object *obj, ResetType type)
+{
+    Neorv32UARTState *s = NEORV32_UART(obj);
+    s->rx_fifo_len = 0;
+    s->ie = 0;
+}
+
+static void neorv32_uart_reset_hold(Object *obj, ResetType type)
+{
+    Neorv32UARTState *s = NEORV32_UART(obj);
+    qemu_irq_lower(s->irq);
+}
+
+static void neorv32_uart_class_init(ObjectClass *oc,const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    dc->realize = neorv32_uart_realize;
+    dc->vmsd = &vmstate_neorv32_uart;
+    rc->phases.enter = neorv32_uart_reset_enter;
+    rc->phases.hold  = neorv32_uart_reset_hold;
+    device_class_set_props(dc, neorv32_uart_properties);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo neorv32_uart_info = {
+    .name          = TYPE_NEORV32_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Neorv32UARTState),
+    .instance_init = neorv32_uart_init,
+    .class_init    = neorv32_uart_class_init,
+};
+
+static void neorv32_uart_register_types(void)
+{
+    type_register_static(&neorv32_uart_info);
+}
+
+type_init(neorv32_uart_register_types)
+/*
+ * Create UART device.
+ */
+Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,
+                                      hwaddr base,
+                                      Chardev *chr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+    bool succed= false;
+
+    dev = qdev_new("riscv.neorv32.uart");
+
+    qdev_prop_set_chr(dev, "chardev", chr);
+    s = SYS_BUS_DEVICE(dev);
+    succed = sysbus_realize_and_unref(s, &error_fatal);
+
+    if (succed) {
+        memory_region_add_subregion(address_space, base,
+                                    sysbus_mmio_get_region(s, 0));
+        return NEORV32_UART(dev);
+    } else {
+        return NULL;
+    }
+} //neorv32_uart_create
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..3de644a9e0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -235,4 +235,6 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config NEORV32_SYSINFO_QEMU
+    bool
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..4ea46ec2d1 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+system_ss.add(when: 'CONFIG_NEORV32_SYSINFO_QEMU', if_true: files('neorv32_sysinfo.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/neorv32_sysinfo.c b/hw/misc/neorv32_sysinfo.c
new file mode 100644
index 0000000000..09378b17a9
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo.c
@@ -0,0 +1,183 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "system/address-spaces.h"
+#include "neorv32_sysinfo.h" /* QEMU related */
+#include "neorv32_sysinfo_rtl.h" /* RTL related */
+
+
+/* Register addresses (offsets) */
+enum {
+	REG_SYSINFO_CLK    = 0x00,
+	REG_SYSINFO_MISC   = 0x04,
+	REG_SYSINFO_SOC    = 0x08,
+	REG_SYSINFO_CACHE  = 0x0C,
+};
+
+
+typedef struct Neorv32SysInfoState {
+    MemoryRegion mmio;
+    uint32_t clk_hz;   /* rw */
+    uint32_t misc;     /* ro */
+    uint32_t soc;      /* ro */
+    uint32_t cache;    /* ro */
+} Neorv32SysInfoState;
+
+
+/* Safe integer log2: assumes power-of-two sizes; returns 0 if size is 0 */
+static unsigned int neorv32_log2u(uint32_t x)
+{
+    if (x == 0U) {
+        return 0U;
+    }
+    unsigned int r = 0U;
+    while ((x >>= 1U) != 0U) {
+        r++;
+    }
+    return r;
+}
+
+/* Compose MISC register per the firmware header */
+static uint32_t neorv32_sysinfo_build_misc(void)
+{
+    const uint32_t imem_log2  = neorv32_log2u(SYSINFO_IMEM_SIZE) & 0xFFU;  /* [7:0]  */
+    const uint32_t dmem_log2  = neorv32_log2u(SYSINFO_DMEM_SIZE) & 0xFFU;  /* [15:8] */
+    const uint32_t harts      = (SYSINFO_NUM_HARTS & 0x0FU);               /* [19:16] */
+    const uint32_t bootmode   = (SYSINFO_BOOTMODE_ID & 0x03U);             /* [21:20] */
+    const uint32_t intbus_to  = (SYSINFO_INTBUS_TO_LOG2 & 0x1FU);          /* [26:22] */
+    const uint32_t extbus_to  = (SYSINFO_EXTBUS_TO_LOG2 & 0x1FU);          /* [31:27] */
+
+    uint32_t v = 0U;
+    v |= (imem_log2 << 0);
+    v |= (dmem_log2 << 8);
+    v |= (harts     << 16);
+    v |= (bootmode  << 20);
+    v |= (intbus_to << 22);
+    v |= (extbus_to << 27);
+    return v;
+}
+
+/* Compose CACHE register per the firmware header */
+static uint32_t neorv32_sysinfo_build_cache(void)
+{
+    uint32_t v = 0U;
+    v |= ((ICACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 0);
+    v |= ((ICACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 4);
+    v |= ((DCACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 8);
+    v |= ((DCACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 12);
+    v |= ((ICACHE_BURSTS_EN ? 1U : 0U) << 16);
+    v |= ((DCACHE_BURSTS_EN ? 1U : 0U) << 24);
+    return v;
+}
+
+static uint64_t neorv32_sysinfo_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Neorv32SysInfoState *s = opaque;
+    uint32_t val = 0U;
+
+    switch (addr) {
+    case REG_SYSINFO_CLK:
+        val = s->clk_hz;
+        break;
+    case REG_SYSINFO_MISC:
+        val = s->misc;
+        break;
+    case REG_SYSINFO_SOC:
+        val = s->soc;
+        break;
+    case REG_SYSINFO_CACHE:
+        val = s->cache;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid read addr=0x%" HWADDR_PRIx " size=%u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    /* Enforce access size semantics (1/2/4 ok); we just return the low bytes */
+    switch (size) {
+    case 4: return val;
+    case 2: return (uint16_t)val;
+    case 1: return (uint8_t)val;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid read size=%u at addr=0x%" HWADDR_PRIx "\n",
+                      __func__, size, addr);
+        return 0;
+    }
+}
+
+static void neorv32_sysinfo_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
+{
+    Neorv32SysInfoState *s = opaque;
+
+    /* Only CLK is writable; others are read-only */
+    if (addr == REG_SYSINFO_CLK) {
+        /* Accept 1/2/4 byte writes; update the corresponding bytes of clk_hz */
+        uint32_t old = s->clk_hz;
+        uint32_t val = old;
+
+        switch (size) {
+        case 4:
+            val = (uint32_t)data;
+            break;
+        case 2: {
+            uint16_t part = (uint16_t)data;
+            /* Little-endian halfword at offset (0 or 2) */
+            if ((addr & 0x3) == 0x0) {
+                val = (old & 0xFFFF0000U) | part;
+            } else if ((addr & 0x3) == 0x2) {
+                val = (old & 0x0000FFFFU) | ((uint32_t)part << 16);
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: misaligned 16-bit write at 0x%" HWADDR_PRIx "\n",
+                              __func__, addr);
+                return;
+            }
+            break;
+        }
+        case 1: {
+            uint8_t part = (uint8_t)data;
+            uint32_t shift = (addr & 0x3) * 8U;
+            val = (old & ~(0xFFU << shift)) | ((uint32_t)part << shift);
+            break;
+        }
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid write size=%u at addr=0x%" HWADDR_PRIx "\n",
+                          __func__, size, addr);
+            return;
+        }
+
+        s->clk_hz = val;
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to read-only addr=0x%" HWADDR_PRIx " val=0x%" PRIx64 " size=%u\n",
+                  __func__, addr, data, size);
+}
+
+static const MemoryRegionOps neorv32_sysinfo_ops = {
+    .read = neorv32_sysinfo_read,
+    .write = neorv32_sysinfo_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base)
+{
+    Neorv32SysInfoState *s = g_new0(Neorv32SysInfoState, 1);
+
+    s->clk_hz = SYSINFO_CLK_HZ_DEFAULT;
+    s->misc   = neorv32_sysinfo_build_misc();
+    s->soc    = SYSINFO_SOC_VAL;
+    s->cache  = neorv32_sysinfo_build_cache();
+
+    memory_region_init_io(&s->mmio, NULL, &neorv32_sysinfo_ops,
+                          s, "neorv32.sysinfo", 16 /* 4 regs x 4 bytes */);
+
+    memory_region_add_subregion(address_space, base, &s->mmio);
+}
diff --git a/hw/misc/neorv32_sysinfo.h b/hw/misc/neorv32_sysinfo.h
new file mode 100644
index 0000000000..c0ac7d87e4
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo.h
@@ -0,0 +1,79 @@
+#ifndef HW_NEORV32_SYSINFO_H
+#define HW_NEORV32_SYSINFO_H
+
+#include "system/memory.h"
+
+
+/* Internal memory sizes (bytes) */
+#define SYSINFO_IMEM_SIZE        0x00008000U  /* 32 KiB IMEM */
+#define SYSINFO_DMEM_SIZE        0x00008000U  /* 32 KiB DMEM */
+
+/* Number of harts (physical cores) */
+#define SYSINFO_NUM_HARTS        1U
+
+/* Boot mode (matches RTL BOOT_MODE_SELECT encoding used in your firmware) */
+#define SYSINFO_BOOTMODE_ID      0U           /* 0..3 */
+
+/* Bus timeout encodings: value is log2(cycles); 0 means "no timeout" per your helper */
+#define SYSINFO_INTBUS_TO_LOG2   0U           /* 0 => returns 0 */
+#define SYSINFO_EXTBUS_TO_LOG2   0U           /* 0 => returns 0 */
+
+/* Clock (Hz): writable at runtime via SYSINFO.CLK */
+#define SYSINFO_CLK_HZ_DEFAULT   100000000U   /* 100 MHz */
+
+/* Cache topology encodings (log2 values ) */
+#define ICACHE_BLOCK_SIZE_LOG2   0U           /* bits [3:0] */
+#define ICACHE_NUM_BLOCKS_LOG2   0U           /* bits [7:4] */
+#define DCACHE_BLOCK_SIZE_LOG2   0U           /* bits [11:8] */
+#define DCACHE_NUM_BLOCKS_LOG2   0U           /* bits [15:12] */
+#define ICACHE_BURSTS_EN         0U           /* bit 16 */
+#define DCACHE_BURSTS_EN         0U           /* bit 24 */
+
+/* Feature bitmap for SOC register. */
+#define SYSINFO_SOC_ENABLE(x)    (1U << (x))
+
+// Enable Bootloader, IMEM, DMEM, UART and SPI
+#define SYSINFO_SOC_VAL \
+    ( SYSINFO_SOC_ENABLE(SYSINFO_SOC_BOOTLOADER) | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IMEM)       | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_DMEM)       | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_UART0)   | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_SPI) )
+
+/* --------------------------------------------------------------------------------------
+ * Address map
+ * ------------------------------------------------------------------------------------*/
+#define NEORV32_BOOTLOADER_BASE_ADDRESS (0xFFE00000U)
+#define NEORV32_IO_BASE_ADDRESS         (0xFFE00000U)
+
+#define NEORV32_IMEM_BASE               (0x00000000U)
+#define NEORV32_DMEM_BASE               (0x80000000U)
+
+/* IO base addresses */
+#define NEORV32_TWD_BASE     (0xFFEA0000U)
+#define NEORV32_CFS_BASE     (0xFFEB0000U)
+#define NEORV32_SLINK_BASE   (0xFFEC0000U)
+#define NEORV32_DMA_BASE     (0xFFED0000U)
+#define NEORV32_CRC_BASE     (0xFFEE0000U)
+#define NEORV32_XIP_BASE     (0xFFEF0000U)
+#define NEORV32_PWM_BASE     (0xFFF00000U)
+#define NEORV32_GPTMR_BASE   (0xFFF10000U)
+#define NEORV32_ONEWIRE_BASE (0xFFF20000U)
+#define NEORV32_XIRQ_BASE    (0xFFF30000U)
+#define NEORV32_MTIME_BASE   (0xFFF40000U)
+#define NEORV32_UART0_BASE   (0xFFF50000U)
+#define NEORV32_UART1_BASE   (0xFFF60000U)
+#define NEORV32_SDI_BASE     (0xFFF70000U)
+#define NEORV32_SPI_BASE     (0xFFF80000U)
+#define NEORV32_TWI_BASE     (0xFFF90000U)
+#define NEORV32_TRNG_BASE    (0xFFFA0000U)
+#define NEORV32_WDT_BASE     (0xFFFB0000U)
+#define NEORV32_GPIO_BASE    (0xFFFC0000U)
+#define NEORV32_NEOLED_BASE  (0xFFFD0000U)
+#define NEORV32_SYSINFO_BASE (0xFFFE0000U)
+#define NEORV32_DM_BASE      (0xFFFF0000U)
+
+/* MMIO creator */
+void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base);
+
+#endif //HW_NEORV32_SYSINFO_H
diff --git a/hw/misc/neorv32_sysinfo_rtl.h b/hw/misc/neorv32_sysinfo_rtl.h
new file mode 100644
index 0000000000..594e251c5b
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo_rtl.h
@@ -0,0 +1,134 @@
+// #################################################################################################
+// # << NEORV32: neorv32_sysinfo.h - System Information Memory (SYSINFO) HW Driver >>              #
+// # ********************************************************************************************* #
+// # BSD 3-Clause License                                                                          #
+// #                                                                                               #
+// # Copyright (c) 2023, Stephan Nolting. All rights reserved.                                     #
+// #                                                                                               #
+// # Redistribution and use in source and binary forms, with or without modification, are          #
+// # permitted provided that the following conditions are met:                                     #
+// #                                                                                               #
+// # 1. Redistributions of source code must retain the above copyright notice, this list of        #
+// #    conditions and the following disclaimer.                                                   #
+// #                                                                                               #
+// # 2. Redistributions in binary form must reproduce the above copyright notice, this list of     #
+// #    conditions and the following disclaimer in the documentation and/or other materials        #
+// #    provided with the distribution.                                                            #
+// #                                                                                               #
+// # 3. Neither the name of the copyright holder nor the names of its contributors may be used to  #
+// #    endorse or promote products derived from this software without specific prior written      #
+// #    permission.                                                                                #
+// #                                                                                               #
+// # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS   #
+// # OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF               #
+// # MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE    #
+// # COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     #
+// # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE #
+// # GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED    #
+// # AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     #
+// # NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED  #
+// # OF THE POSSIBILITY OF SUCH DAMAGE.                                                            #
+// # ********************************************************************************************* #
+// # The NEORV32 Processor - https://github.com/stnolting/neorv32              (c) Stephan Nolting #
+// #################################################################################################
+
+
+/**********************************************************************//**
+ * @file neorv32_cfs.h
+ * @brief System Configuration Information Memory (SYSINFO) HW driver header file.
+ **************************************************************************/
+
+#ifndef neorv32_sysinfo_h
+#define neorv32_sysinfo_h
+
+/**********************************************************************//**
+ * @name IO Device: System Configuration Information Memory (SYSINFO)
+ **************************************************************************/
+/**@{*/
+/** SYSINFO module prototype - whole module is read-only */
+typedef volatile struct __attribute__((packed,aligned(4))) {
+        uint32_t CLK;   /**< offset 0:  Clock speed in Hz */
+  const uint32_t MISC;  /**< offset 4:  Miscellaneous system configurations (#NEORV32_SYSINFO_MISC_enum) */
+  const uint32_t SOC;   /**< offset 8:  SoC features (#NEORV32_SYSINFO_SOC_enum) */
+  const uint32_t CACHE; /**< offset 12: Cache configuration (#NEORV32_SYSINFO_CACHE_enum) */
+} neorv32_sysinfo_t;
+
+/** SYSINFO module hardware access (#neorv32_sysinfo_t) */
+#define NEORV32_SYSINFO ((neorv32_sysinfo_t*) (NEORV32_SYSINFO_BASE))
+
+/** NEORV32_SYSINFO.MISC (r/-): Miscellaneous system configurations */
+enum NEORV32_SYSINFO_MISC_enum {
+  SYSINFO_MISC_IMEM_LSB =  0, /**< SYSINFO_MISC  (0) (r/-): log2(internal IMEM size in bytes) (via IMEM_SIZE generic), LSB */
+  SYSINFO_MISC_IMEM_MBS =  7, /**< SYSINFO_MISC  (7) (r/-): log2(internal IMEM size in bytes) (via IMEM_SIZE generic), MSB */
+
+  SYSINFO_MISC_DMEM_LSB =  8, /**< SYSINFO_MISC  (8) (r/-): log2(internal DMEM size in bytes) (via DMEM_SIZE generic), LSB */
+  SYSINFO_MISC_DMEM_MSB = 15, /**< SYSINFO_MISC (15) (r/-): log2(internal DMEM size in bytes) (via DMEM_SIZE generic), MSB */
+
+  SYSINFO_MISC_HART_LSB = 16, /**< SYSINFO_MISC (16) (r/-): number of physical CPU cores ("harts"), LSB */
+  SYSINFO_MISC_HART_MSB = 19, /**< SYSINFO_MISC (19) (r/-): number of physical CPU cores ("harts"), MSB */
+
+  SYSINFO_MISC_BOOT_LSB = 20, /**< SYSINFO_MISC (20) (r/-): boot mode configuration (via BOOT_MODE_SELECT generic), LSB */
+  SYSINFO_MISC_BOOT_MSB = 21, /**< SYSINFO_MISC (21) (r/-): boot mode configuration (via BOOT_MODE_SELECT generic), MSB */
+
+  SYSINFO_MISC_ITMO_LSB = 22, /**< SYSINFO_MISC (22) (r/-): log2(internal bus timeout cycles), LSB */
+  SYSINFO_MISC_ITMO_MSB = 26, /**< SYSINFO_MISC (26) (r/-): log2(internal bus timeout cycles), MSB */
+
+  SYSINFO_MISC_ETMO_LSB = 27, /**< SYSINFO_MISC (27) (r/-): log2(external bus timeout cycles), LSB */
+  SYSINFO_MISC_ETMO_MSB = 31  /**< SYSINFO_MISC (31) (r/-): log2(external bus timeout cycles), MSB */
+};
+
+/** NEORV32_SYSINFO.SOC (r/-): Implemented processor devices/features */
+enum NEORV32_SYSINFO_SOC_enum {
+  SYSINFO_SOC_BOOTLOADER =  0, /**< SYSINFO_SOC  (0) (r/-): Bootloader implemented when 1 (via BOOT_MODE_SELECT generic) */
+  SYSINFO_SOC_XBUS       =  1, /**< SYSINFO_SOC  (1) (r/-): External bus interface implemented when 1 (via XBUS_EN generic) */
+  SYSINFO_SOC_IMEM       =  2, /**< SYSINFO_SOC  (2) (r/-): Processor-internal instruction memory implemented when 1 (via IMEM_EN generic) */
+  SYSINFO_SOC_DMEM       =  3, /**< SYSINFO_SOC  (3) (r/-): Processor-internal data memory implemented when 1 (via DMEM_EN generic) */
+  SYSINFO_SOC_OCD        =  4, /**< SYSINFO_SOC  (4) (r/-): On-chip debugger implemented when 1 (via OCD_EN generic) */
+  SYSINFO_SOC_ICACHE     =  5, /**< SYSINFO_SOC  (5) (r/-): Processor-internal instruction cache implemented when 1 (via ICACHE_EN generic) */
+  SYSINFO_SOC_DCACHE     =  6, /**< SYSINFO_SOC  (6) (r/-): Processor-internal instruction cache implemented when 1 (via DCACHE_EN generic) */
+//SYSINFO_SOC_reserved   =  7, /**< SYSINFO_SOC  (7) (r/-): reserved */
+//SYSINFO_SOC_reserved   =  8, /**< SYSINFO_SOC  (8) (r/-): reserved */
+//SYSINFO_SOC_reserved   =  9, /**< SYSINFO_SOC  (9) (r/-): reserved */
+//SYSINFO_SOC_reserved   = 10, /**< SYSINFO_SOC (10) (r/-): reserved */
+  SYSINFO_SOC_OCD_AUTH   = 11, /**< SYSINFO_SOC (11) (r/-): On-chip debugger authentication implemented when 1 (via OCD_AUTHENTICATION generic) */
+  SYSINFO_SOC_IMEM_ROM   = 12, /**< SYSINFO_SOC (12) (r/-): Processor-internal instruction memory implemented as pre-initialized ROM when 1 (via BOOT_MODE_SELECT generic) */
+  SYSINFO_SOC_IO_TWD     = 13, /**< SYSINFO_SOC (13) (r/-): Two-wire device implemented when 1 (via IO_TWD_EN generic) */
+  SYSINFO_SOC_IO_DMA     = 14, /**< SYSINFO_SOC (14) (r/-): Direct memory access controller implemented when 1 (via IO_DMA_EN generic) */
+  SYSINFO_SOC_IO_GPIO    = 15, /**< SYSINFO_SOC (15) (r/-): General purpose input/output port unit implemented when 1 (via IO_GPIO_EN generic) */
+  SYSINFO_SOC_IO_CLINT   = 16, /**< SYSINFO_SOC (16) (r/-): Core local interruptor implemented when 1 (via IO_CLINT_EN generic) */
+  SYSINFO_SOC_IO_UART0   = 17, /**< SYSINFO_SOC (17) (r/-): Primary universal asynchronous receiver/transmitter 0 implemented when 1 (via IO_UART0_EN generic) */
+  SYSINFO_SOC_IO_SPI     = 18, /**< SYSINFO_SOC (18) (r/-): Serial peripheral interface implemented when 1 (via IO_SPI_EN generic) */
+  SYSINFO_SOC_IO_TWI     = 19, /**< SYSINFO_SOC (19) (r/-): Two-wire interface implemented when 1 (via IO_TWI_EN generic) */
+  SYSINFO_SOC_IO_PWM     = 20, /**< SYSINFO_SOC (20) (r/-): Pulse-width modulation unit implemented when 1 (via IO_PWM_EN generic) */
+  SYSINFO_SOC_IO_WDT     = 21, /**< SYSINFO_SOC (21) (r/-): Watchdog timer implemented when 1 (via IO_WDT_EN generic) */
+  SYSINFO_SOC_IO_CFS     = 22, /**< SYSINFO_SOC (22) (r/-): Custom functions subsystem implemented when 1 (via IO_CFS_EN generic) */
+  SYSINFO_SOC_IO_TRNG    = 23, /**< SYSINFO_SOC (23) (r/-): True random number generator implemented when 1 (via IO_TRNG_EN generic) */
+  SYSINFO_SOC_IO_SDI     = 24, /**< SYSINFO_SOC (24) (r/-): Serial data interface implemented when 1 (via IO_SDI_EN generic) */
+  SYSINFO_SOC_IO_UART1   = 25, /**< SYSINFO_SOC (25) (r/-): Secondary universal asynchronous receiver/transmitter 1 implemented when 1 (via IO_UART1_EN generic) */
+  SYSINFO_SOC_IO_NEOLED  = 26, /**< SYSINFO_SOC (26) (r/-): NeoPixel-compatible smart LED interface implemented when 1 (via IO_NEOLED_EN generic) */
+  SYSINFO_SOC_IO_TRACER  = 27, /**< SYSINFO_SOC (10) (r/-): Execution tracer implemented when 1 (via IO_TRACER_EN generic) */
+  SYSINFO_SOC_IO_GPTMR   = 28, /**< SYSINFO_SOC (28) (r/-): General purpose timer implemented when 1 (via IO_GPTMR_EN generic) */
+  SYSINFO_SOC_IO_SLINK   = 29, /**< SYSINFO_SOC (29) (r/-): Stream link interface implemented when 1 (via IO_SLINK_EN generic) */
+  SYSINFO_SOC_IO_ONEWIRE = 30  /**< SYSINFO_SOC (30) (r/-): 1-wire interface controller implemented when 1 (via IO_ONEWIRE_EN generic) */
+//SYSINFO_SOC_reserved   = 31  /**< SYSINFO_SOC (31) (r/-): reserved */
+};
+
+/** NEORV32_SYSINFO.CACHE (r/-): Cache configuration */
+ enum NEORV32_SYSINFO_CACHE_enum {
+  SYSINFO_CACHE_INST_BLOCK_SIZE_0 =  0, /**< SYSINFO_CACHE  (0) (r/-): i-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) */
+  SYSINFO_CACHE_INST_BLOCK_SIZE_3 =  3, /**< SYSINFO_CACHE  (3) (r/-): i-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) */
+  SYSINFO_CACHE_INST_NUM_BLOCKS_0 =  4, /**< SYSINFO_CACHE  (4) (r/-): i-cache: log2(Number of cache blocks), bit 0 (via ICACHE_NUM_BLOCKS generic) */
+  SYSINFO_CACHE_INST_NUM_BLOCKS_3 =  7, /**< SYSINFO_CACHE  (7) (r/-): i-cache: log2(Number of cache blocks), bit 3 (via ICACHE_NUM_BLOCKS generic) */
+
+  SYSINFO_CACHE_DATA_BLOCK_SIZE_0 =  8, /**< SYSINFO_CACHE  (8) (r/-): d-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) */
+  SYSINFO_CACHE_DATA_BLOCK_SIZE_3 = 11, /**< SYSINFO_CACHE (11) (r/-): d-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) */
+  SYSINFO_CACHE_DATA_NUM_BLOCKS_0 = 12, /**< SYSINFO_CACHE (12) (r/-): d-cache: log2(Number of cache blocks), bit 0 (via DCACHE_NUM_BLOCKS generic) */
+  SYSINFO_CACHE_DATA_NUM_BLOCKS_3 = 15, /**< SYSINFO_CACHE (15) (r/-): d-cache: log2(Number of cache blocks), bit 3 (via DCACHE_NUM_BLOCKS generic) */
+
+  SYSINFO_CACHE_INST_BURSTS_EN    = 16, /**< SYSINFO_CACHE (16) (r/-): i-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generic) */
+  SYSINFO_CACHE_DATA_BURSTS_EN    = 24  /**< SYSINFO_CACHE (14) (r/-): d-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generic) */
+};
+/**@}*/
+
+
+#endif // neorv32_sysinfo_h
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..976acd2a1b 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,11 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config NEORV32
+    bool
+    default y
+    depends on RISCV32
+    select NEORV32_UART
+    select NEORV32_SPI
+    select NEORV32_SYSINFO_QEMU
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..b8788e2035 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
+riscv_ss.add(when: 'CONFIG_NEORV32', if_true: files('neorv32.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/neorv32.c b/hw/riscv/neorv32.c
new file mode 100644
index 0000000000..87e35a9b0d
--- /dev/null
+++ b/hw/riscv/neorv32.c
@@ -0,0 +1,219 @@
+/*
+ * QEMU RISC-V Board Compatible with Neorv32 IP
+ *
+ * Provides a board compatible with the Neorv32 IP:
+ *
+ * 0) SYSINFO
+ * 1) IMEM
+ * 2) DMEM
+ * 3) UART
+ * 4) SPI
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/misc/unimp.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/boot.h"
+#include "hw/intc/riscv_aclint.h"
+#include "chardev/char.h"
+#include "system/system.h"
+#include "hw/ssi/ssi.h"    /* For ssi_realize_and_unref() */
+
+#include "hw/riscv/neorv32.h"
+#include "hw/misc/neorv32_sysinfo.h"
+#include "hw/char/neorv32_uart.h"
+#include "hw/ssi/neorv32_spi.h"
+
+static const MemMapEntry neorv32_memmap[] = {
+
+    [NEORV32_IMEM]           = { NEORV32_IMEM_BASE,               SYSINFO_IMEM_SIZE},
+    [NEORV32_BOOTLOADER_ROM] = { NEORV32_BOOTLOADER_BASE_ADDRESS, 0x2000},     /* 8K  ROM for bootloader */
+    [NEORV32_DMEM]           = { NEORV32_DMEM_BASE,               SYSINFO_DMEM_SIZE},
+    [NEORV32_SYSINFO]        = { NEORV32_SYSINFO_BASE,            0x100},
+    [NEORV32_UART0]          = { NEORV32_UART0_BASE,              0x100},
+	[NEORV32_SPI0]           = { NEORV32_SPI_BASE,                0x100},
+};
+
+static void neorv32_machine_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MemMapEntry *memmap = neorv32_memmap;
+
+    Neorv32State *s = NEORV32_MACHINE(machine);
+    MemoryRegion *sys_mem = get_system_memory();
+    int i;
+    RISCVBootInfo boot_info;
+    hwaddr start_addr = memmap[NEORV32_BOOTLOADER_ROM].base;
+
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_NEORV32_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Data Tightly Integrated Memory */
+    memory_region_add_subregion(sys_mem,
+        memmap[NEORV32_DMEM].base, machine->ram);
+
+    /* Instruction Memory (IMEM) */
+	memory_region_init_ram(&s->soc.imem_region, OBJECT(&s->soc), "riscv.neorv32.imem",
+						 memmap[NEORV32_IMEM].size, &error_fatal);
+	memory_region_add_subregion(sys_mem, memmap[NEORV32_IMEM].base, &s->soc.imem_region);
+
+    /* Mask ROM reset vector */
+    uint32_t reset_vec[4];
+
+    reset_vec[1] = 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
+    reset_vec[2] = 0x00028067;      /* 0x1008: jr      t0 */
+    reset_vec[0] = reset_vec[3] = 0;
+
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+
+    /* Neorv32 bootloader */
+    if (machine->firmware) {
+        riscv_find_and_load_firmware(machine, machine->firmware,
+        		                     &start_addr, NULL);
+    }
+
+    /* Neorv32 example applications */
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+    if (machine->kernel_filename) {
+        riscv_load_kernel(machine, &boot_info,
+                          memmap[NEORV32_IMEM].base,
+                          false, NULL);
+    }
+}
+
+static void neorv32_machine_instance_init(Object *obj)
+{
+
+    /* Placeholder for now */
+    /* Neorv32State *s = NEORV32_MACHINE(obj); */
+}
+
+static void neorv32_machine_class_init(ObjectClass *oc,const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V SOC compatible with Neorv32 SDK";
+    mc->init = neorv32_machine_init;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = NEORV32_CPU;
+    mc->default_ram_id = "riscv.neorv32.dmem";
+    mc->default_ram_size = neorv32_memmap[NEORV32_DMEM].size;
+
+}
+
+static const TypeInfo neorv32_machine_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("neorv32"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = neorv32_machine_class_init,
+    .instance_init = neorv32_machine_instance_init,
+    .instance_size = sizeof(Neorv32State),
+};
+
+static void neorv32_machine_init_register_types(void)
+{
+    type_register_static(&neorv32_machine_typeinfo);
+}
+
+type_init(neorv32_machine_init_register_types)
+
+static void neorv32_soc_init(Object *obj)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    Neorv32SoCState *s = RISCV_NEORV32_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
+                            &error_abort);
+
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", NEORV32_BOOTLOADER_BASE_ADDRESS, &error_abort);
+
+}
+
+static void neorv32_soc_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const MemMapEntry *memmap = neorv32_memmap;
+    Neorv32SoCState *s = RISCV_NEORV32_SOC(dev);
+    MemoryRegion *sys_mem = get_system_memory();
+
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    /* Bootloader ROM */
+    memory_region_init_rom(&s->bootloader_rom, OBJECT(dev), "riscv.bootloader.rom",
+                           memmap[NEORV32_BOOTLOADER_ROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem,
+        memmap[NEORV32_BOOTLOADER_ROM].base, &s->bootloader_rom);
+
+
+    /* Sysinfo ROM */
+    neorv32_sysinfo_create(sys_mem, memmap[NEORV32_SYSINFO].base);
+
+    /* Uart0 */
+    neorv32_uart_create(sys_mem, memmap[NEORV32_UART0].base,serial_hd(0));
+
+    /* SPI controller */
+	NEORV32SPIState *spi = neorv32_spi_create(sys_mem, memmap[NEORV32_SPI0].base);
+
+	if (!spi) {
+		error_setg(errp, "SPI is not created");
+		return;
+	}
+}
+
+static void neorv32_soc_class_init(ObjectClass *oc,const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    dc->realize = neorv32_soc_realize;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo neorv32_soc_type_info = {
+    .name = TYPE_RISCV_NEORV32_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(Neorv32SoCState),
+    .instance_init = neorv32_soc_init,
+    .class_init = neorv32_soc_class_init,
+};
+
+static void neorv32_soc_register_types(void)
+{
+    type_register_static(&neorv32_soc_type_info);
+}
+
+type_init(neorv32_soc_register_types)
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..5b1a03f3c4 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config NEORV32_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..5139cc1ca0 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_NEORV32_SPI', if_true: files('neorv32_spi.c'))
diff --git a/hw/ssi/neorv32_spi.c b/hw/ssi/neorv32_spi.c
new file mode 100644
index 0000000000..43fb822f1a
--- /dev/null
+++ b/hw/ssi/neorv32_spi.c
@@ -0,0 +1,504 @@
+/*
+ * QEMU implementation of the Neorv32 SPI block.
+ *
+ * Copyright (c) 2025 Michael Levit.
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+/*
+ * QEMU model of a NEORV32 SPI Controller
+ *
+ * This example is inspired by the SiFive SPI controller implementation shown
+ * previously and adapted to the NEORV32 SPI register interface and semantics.
+ *
+ * IMPORTANT:
+ * This code is an illustrative example. Adjust register addresses, IRQ logic,
+ * FIFO sizes, and chip select configurations according to actual NEORV32 SPI
+ * specifications. The following is based on the given register bits and a
+ * presumed memory map. Check the official NEORV32 documentation for the
+ * correct register definitions, addressing scheme, and functionality.
+ *
+ * The code simulates:
+ *  - A single SPI control register (CTRL) and a data register (DATA).
+ *  - TX and RX FIFOs for SPI transfers.
+ *  - Basic SPI master logic (no advanced timing or prescaler logic shown).
+ *  - Chip select lines and interrupts based on FIFO status.
+ *
+ * This code will:
+ *   - Create a QEMU device "neorv32-spi"
+ *   - Map it to a 0x1000 address space region
+ *   - Provide a simple SPI master interface using QEMU’s ssi bus
+ *   - Allow reading/writing CTRL and DATA registers
+ *   - Simulate FIFO behavior and trigger IRQ lines
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qemu/fifo8.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace/trace-root.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/ssi/neorv32_spi.h"
+#include "system/blockdev.h"
+
+
+
+/** SPI control register bits */
+enum NEORV32_SPI_CTRL_enum {
+  SPI_CTRL_EN           =  0, /**< SPI control register(0)  (r/w): SPI unit enable */
+  SPI_CTRL_CPHA         =  1, /**< SPI control register(1)  (r/w): Clock phase */
+  SPI_CTRL_CPOL         =  2, /**< SPI control register(2)  (r/w): Clock polarity */
+  SPI_CTRL_PRSC0        =  3, /**< SPI control register(3)  (r/w): Clock prescaler select bit 0 */
+  SPI_CTRL_PRSC1        =  4, /**< SPI control register(4)  (r/w): Clock prescaler select bit 1 */
+  SPI_CTRL_PRSC2        =  5, /**< SPI control register(5)  (r/w): Clock prescaler select bit 2 */
+  SPI_CTRL_CDIV0        =  6, /**< SPI control register(6)  (r/w): Clock divider bit 0 */
+  SPI_CTRL_CDIV1        =  7, /**< SPI control register(7)  (r/w): Clock divider bit 1 */
+  SPI_CTRL_CDIV2        =  8, /**< SPI control register(8)  (r/w): Clock divider bit 2 */
+  SPI_CTRL_CDIV3        =  9, /**< SPI control register(9)  (r/w): Clock divider bit 3 */
+
+  SPI_CTRL_RX_AVAIL     = 16, /**< SPI control register(16) (r/-): RX FIFO data available (RX FIFO not empty) */
+  SPI_CTRL_TX_EMPTY     = 17, /**< SPI control register(17) (r/-): TX FIFO empty */
+  SPI_CTRL_TX_FULL      = 18, /**< SPI control register(18) (r/-): TX FIFO full */
+
+  SPI_CTRL_FIFO_LSB     = 24, /**< SPI control register(24) (r/-): log2(FIFO size), LSB */
+  SPI_CTRL_FIFO_MSB     = 27, /**< SPI control register(27) (r/-): log2(FIFO size), MSB */
+
+  SPI_CS_ACTIVE         = 30, /**< SPI control register(30) (r/-): At least one CS line is active when set */
+  SPI_CTRL_BUSY         = 31  /**< SPI control register(31) (r/-): serial PHY busy or TX FIFO not empty yet */
+};
+
+//TODO:
+//Implement NEORV32_SPI_DATA_enum
+/** SPI data register bits */
+enum NEORV32_SPI_DATA_enum {
+  SPI_DATA_LSB  =  0, /**< SPI data register(0)  (r/w): Data byte LSB */
+  SPI_DATA_CSEN =  3, /**< SPI data register(3)  (-/w): Chip select enable (command-mode) */
+  SPI_DATA_MSB  =  7, /**< SPI data register(7)  (r/w): Data byte MSB */
+  SPI_DATA_CMD  = 31  /**< SPI data register(31) (-/w): 1=command, 0=data */
+};
+
+/* Register offsets */
+#define NEORV32_SPI_CTRL  0x00
+#define NEORV32_SPI_DATA  0x04
+#define NEORV32_SPI_MMIO_SIZE   0x8  // ctrl + data (8 bytes total)
+/* Various constants */
+#define NEORV32_SPI_MAX_CS_LINES  7
+#define NEORV32_SPI_FIFO_CAPACITY 8
+
+/* Utility functions to get/set bits in ctrl register */
+static inline bool get_ctrl_bit(NEORV32SPIState *s, int bit)
+{
+    return (s->ctrl & (1 << bit)) != 0;
+}
+
+static inline void set_ctrl_bit(NEORV32SPIState *s, int bit, bool val)
+{
+    if (val) {
+        s->ctrl |= (1 << bit);
+    } else {
+        s->ctrl &= ~(1 << bit);
+    }
+}
+
+static inline bool get_data_bit(uint32_t v, int bit)
+{
+    return (v >> bit) & 1;
+}
+
+/* Update read-only status bits in CTRL register */
+static void neorv32_spi_update_status(NEORV32SPIState *s)
+{
+    /* RX_AVAIL: set if RX FIFO not empty */
+    set_ctrl_bit(s, SPI_CTRL_RX_AVAIL, !fifo8_is_empty(&s->rx_fifo));
+
+    /* TX_EMPTY: set if TX FIFO empty */
+    set_ctrl_bit(s, SPI_CTRL_TX_EMPTY, fifo8_is_empty(&s->tx_fifo));
+
+    /* TX_FULL: set if TX FIFO full */
+    set_ctrl_bit(s, SPI_CTRL_TX_FULL, fifo8_is_full(&s->tx_fifo));
+
+
+    /* BUSY: We'll consider SPI busy if TX FIFO is not empty or currently shifting data.
+     * For simplicity, if TX is not empty we say busy.
+     */
+    bool busy = !fifo8_is_empty(&s->tx_fifo);
+    set_ctrl_bit(s, SPI_CTRL_BUSY, busy);
+
+    /* Update CS status */
+    if (s->cmd_cs_active) {
+        s->ctrl |= (1u << SPI_CS_ACTIVE);
+    } else {
+        s->ctrl &= ~(1u << SPI_CS_ACTIVE);
+    }
+
+}
+
+/* Update chip select lines based on command-mode CS (active-low on the wire) */
+static void neorv32_spi_update_cs(NEORV32SPIState *s)
+{
+	/* Check that input valid */
+	if (!s->cs_lines || s->num_cs <= 0) {
+        return;
+    }
+
+    /* Deassert all CS lines (inactive = high) */
+    for (int i = 0; i < s->num_cs; i++) {
+        qemu_set_irq(s->cs_lines[i], 1);
+    }
+
+    /* If DATA command says CS active, assert selected line (low = active) */
+    if (s->cmd_cs_active) {
+        int cs_idx = s->current_cs;
+        if (cs_idx < 0 || cs_idx >= s->num_cs) {
+            /* Out of range: keep all deasserted, but warn once per event */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: CS index %d out of range (num_cs=%d)\n",
+                          __func__, cs_idx, s->num_cs);
+            return;
+        }
+        /* Active-low when enabled */
+        qemu_set_irq(s->cs_lines[cs_idx], 0);
+    }
+
+}
+
+/* Update IRQ based on conditions */
+static void neorv32_spi_update_irq(NEORV32SPIState *s)
+{
+    /* Conditions for IRQ:
+     * IRQ if RX data available and IRQ_RX_AVAIL is set:
+     *    if (!RX FIFO empty && SPI_CTRL_IRQ_RX_AVAIL set)
+     *
+     * IRQ if TX empty and IRQ_TX_EMPTY is set:
+     *    if (TX empty && SPI_CTRL_IRQ_TX_EMPTY set)
+     *
+     * IRQ if TX < half full and IRQ_TX_HALF is set:
+     *    if (TX < half full && SPI_CTRL_IRQ_TX_HALF set)
+     */
+
+    bool rx_irq = !fifo8_is_empty(&s->rx_fifo);
+    bool tx_empty_irq = fifo8_is_empty(&s->tx_fifo);
+    int used = fifo8_num_used(&s->tx_fifo);
+    bool tx_half_irq = (used < (s->fifo_capacity / 2));
+
+    bool irq_level = rx_irq || tx_empty_irq || tx_half_irq;
+    qemu_set_irq(s->irq, irq_level ? 1 : 0);
+}
+
+/* Flush the TX FIFO to the SPI bus:
+ * For each byte in TX FIFO, send it out via ssi_transfer.
+ * If direction is not explicitly given, we assume:
+ *   - On write to DATA, we push to TX FIFO and then transfer out.
+ *   - On receiving data back from ssi_transfer, we push it into RX FIFO
+ *     if SPI is enabled.
+ */
+static void neorv32_spi_flush_txfifo(NEORV32SPIState *s)
+{
+    if (!get_ctrl_bit(s, SPI_CTRL_EN)) {
+        /* SPI not enabled, do nothing */
+        return;
+    }
+
+    while (!fifo8_is_empty(&s->tx_fifo)) {
+        uint8_t tx = fifo8_pop(&s->tx_fifo);
+        uint8_t rx = ssi_transfer(s->bus, tx);
+
+        /* Push received byte into RX FIFO if not full */
+        if (!fifo8_is_full(&s->rx_fifo)) {
+            fifo8_push(&s->rx_fifo, rx);
+        }
+    }
+}
+
+/* Reset the device state */
+static void neorv32_spi_reset(DeviceState *d)
+{
+    NEORV32SPIState *s = NEORV32_SPI(d);
+
+    s->ctrl = 0;
+    s->data = 0;
+
+    /* Reset FIFOs */
+    fifo8_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_cs(s);
+    neorv32_spi_update_irq(s);
+}
+
+/* MMIO read handler */
+static uint64_t neorv32_spi_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    NEORV32SPIState *s = opaque;
+    uint32_t r = 0;
+
+    switch (addr) {
+    case NEORV32_SPI_CTRL:
+        /* Return the current CTRL register value (including status bits) */
+        neorv32_spi_update_status(s);
+        r = s->ctrl;
+        break;
+
+    case NEORV32_SPI_DATA:
+        /* If RX FIFO is empty, return some default, else pop from RX FIFO */
+        if (fifo8_is_empty(&s->rx_fifo)) {
+            /* No data available, could return 0xFFFFFFFF or 0x00000000 as "no data" */
+            r = 0x00000000;
+        } else {
+            r = fifo8_pop(&s->rx_fifo);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read at address 0x%"
+                       HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_irq(s);
+
+    return r;
+}
+
+/* MMIO write handler */
+static void neorv32_spi_write(void *opaque, hwaddr addr,
+                              uint64_t val64, unsigned int size)
+{
+    NEORV32SPIState *s = opaque;
+    uint32_t value = val64;
+
+    switch (addr) {
+    case NEORV32_SPI_CTRL: {
+
+        /* Writing control register:
+         * Some bits are read-only (e.g., status bits).
+         * We should mask them out or ignore writes to them.
+         * For simplicity, we overwrite ctrl except for RO bits.
+         */
+
+        /* Save old RO bits: RX_AVAIL, TX_EMPTY, TX_NHALF, TX_FULL, BUSY and FIFO size bits */
+        uint32_t ro_mask = ((1 << SPI_CTRL_BUSY)      |
+                            (1 << SPI_CTRL_TX_EMPTY)  |
+                            (1 << SPI_CTRL_TX_FULL)   |
+                            (1 << SPI_CTRL_RX_AVAIL));
+
+        /* FIFO size bits might be hardwired read-only. Assume we do not change them:
+         * FIFO size: bits [SPI_CTRL_FIFO_LSB..SPI_CTRL_FIFO_MSB], here assume read-only.
+         */
+        uint32_t fifo_size_mask = 0;
+        for (int b = SPI_CTRL_FIFO_LSB; b <= SPI_CTRL_FIFO_MSB; b++) {
+            fifo_size_mask |= (1 << b);
+        }
+        ro_mask |= fifo_size_mask;
+
+        uint32_t ro_bits = s->ctrl & ro_mask;
+        s->ctrl = (value & ~ro_mask) | ro_bits;
+
+        neorv32_spi_update_cs(s);
+        break;
+    } //NEORV32_SPI_CTRL
+
+    case NEORV32_SPI_DATA:
+	{
+		/* If CMD=1, this write is a command, not payload */
+		const bool is_cmd = get_data_bit(value, SPI_DATA_CMD);
+
+		if (is_cmd) {
+	        /*   DATA command format:
+	         *   bit 31: CMD = 1
+	         *   bit  3: CSEN (1=assert CS, 0=deassert All)
+	         *   bits [2:0]: CS index (0..7) when asserting
+	         */
+	        const bool csen = get_data_bit(value, SPI_DATA_CSEN);
+	        const int  cs_index = (int)(value & 0x7);
+
+	        if (csen) {
+	            /* Select and assert a single CS */
+	            s->current_cs    = cs_index;  /* range checking in update_cs() */
+	            s->cmd_cs_active = true;
+	        } else {
+	            /* Deassert all CS lines */
+	            s->cmd_cs_active = false;
+	        }
+
+			/* Drive the wires */
+			neorv32_spi_update_cs(s);
+			/* Update status (SPI_CS_ACTIVE is read-only status bit) */
+			neorv32_spi_update_status(s);
+			neorv32_spi_update_irq(s);
+			break; /* no FIFO push on command */
+		}
+
+		/* Writing DATA puts a byte into TX FIFO if not full */
+		if (!fifo8_is_full(&s->tx_fifo)) {
+			uint8_t tx_byte = (uint8_t)value;
+
+			fifo8_push(&s->tx_fifo, tx_byte);
+			/* After pushing data, flush TX to SPI bus */
+			neorv32_spi_flush_txfifo(s);
+		} else {
+			qemu_log_mask(LOG_GUEST_ERROR, "%s: TX FIFO full, cannot write 0x%x\n",
+						  __func__, value);
+		}
+		break;
+	} //NEORV32_SPI_DATA
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write at address 0x%"
+                      HWADDR_PRIx " value=0x%x\n", __func__, addr, value);
+        break;
+
+    } //switch (addr)
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_irq(s);
+} //neorv32_spi_write
+
+static const MemoryRegionOps neorv32_spi_ops = {
+    .read = neorv32_spi_read,
+    .write = neorv32_spi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void neorv32_spi_init(Object *obj)
+{
+    NEORV32SPIState *s = NEORV32_SPI(obj);
+    s->ctrl          = 0;
+    s->data          = 0;
+    s->fifo_capacity = NEORV32_SPI_FIFO_CAPACITY;
+    s->num_cs        = NEORV32_SPI_MAX_CS_LINES; /* Default to 1 CS line */
+    s->cmd_cs_active = false;
+    s->current_cs    = 0; /* Use CS0 by default */
+}
+
+/* Realize the device */
+static void neorv32_spi_realize(DeviceState *dev, Error **errp)
+{
+    NEORV32SPIState *s = NEORV32_SPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Create the SSI master bus */
+	s->bus = ssi_create_bus(dev, "neorv32-spi-bus");
+
+	/* 1) IRQ inputs: first the main IRQ, then each CS line */
+	sysbus_init_irq(sbd, &s->irq);
+	s->cs_lines = g_new0(qemu_irq, s->num_cs);
+	for (int i = 0; i < s->num_cs; i++) {
+		sysbus_init_irq(sbd, &s->cs_lines[i]);
+		qemu_set_irq(s->cs_lines[i], 1);  /* deassert CS (high) */
+	}
+
+	/* 2) Now map the MMIO region */
+	memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_spi_ops, s,
+						  TYPE_NEORV32_SPI, NEORV32_SPI_MMIO_SIZE);
+	sysbus_init_mmio(sbd, &s->mmio);
+
+
+    /* Initialize FIFOs */
+    fifo8_create(&s->tx_fifo, s->fifo_capacity);
+    fifo8_create(&s->rx_fifo, s->fifo_capacity);
+
+    /* Set FIFO size bits (log2 of FIFO size = 3 for capacity=8) */
+    /* FIFO size bits: from SPI_CTRL_FIFO_LSB to SPI_CTRL_FIFO_MSB
+     * We'll store a value of 3 (log2(8)=3)
+     */
+    int fifo_size_log2 = 3;
+    for (int b = SPI_CTRL_FIFO_LSB; b <= SPI_CTRL_FIFO_MSB; b++) {
+        int shift = b - SPI_CTRL_FIFO_LSB;
+        if (fifo_size_log2 & (1 << shift)) {
+            s->ctrl |= (1 << b);
+        } else {
+            s->ctrl &= ~(1 << b);
+        }
+    }
+}
+
+/* Device properties can be added if needed. For now, none. */
+static Property neorv32_spi_properties[] = {
+	DEFINE_PROP_UINT32("num-cs", NEORV32SPIState, num_cs, 1),
+};
+
+static void neorv32_spi_class_init(ObjectClass *klass,const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, neorv32_spi_properties);
+    device_class_set_legacy_reset(dc, neorv32_spi_reset);
+    dc->realize = neorv32_spi_realize;
+}
+
+static const TypeInfo neorv32_spi_type_info = {
+    .name           = TYPE_NEORV32_SPI,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(NEORV32SPIState),
+    .instance_init  = neorv32_spi_init,
+    .class_init     = neorv32_spi_class_init,
+};
+
+static void neorv32_spi_register_types(void)
+{
+    type_register_static(&neorv32_spi_type_info);
+}
+
+type_init(neorv32_spi_register_types)
+
+
+
+NEORV32SPIState *neorv32_spi_create(MemoryRegion *sys_mem, hwaddr base_addr)
+{
+    /* Allocate and initialize the SPI state object */
+    NEORV32SPIState *s = g_new0(NEORV32SPIState, 1);
+    object_initialize(&s->parent_obj, sizeof(*s), TYPE_NEORV32_SPI);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&s->parent_obj);
+
+    /* Realize the SPI controller (sets up mmio, irq, SSI bus, cs_lines) */
+    sysbus_realize_and_unref(sbd, &error_fatal);
+
+    /* Map the MMIO region into the system address space */
+    sysbus_mmio_map(sbd, 0, base_addr);
+
+    /* Attach an SPI flash to SPI0 if a drive image is provided */
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        /* Create the flash device and bind the MTD backend */
+        DeviceState *flash = qdev_new("n25q512a11");
+        qdev_prop_set_drive_err(flash, "drive",
+                                blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+
+        /* Realize flash on the same SSI bus created during controller realize */
+        qdev_realize_and_unref(flash, BUS(s->bus), &error_fatal);
+
+        /* Retrieve and wire the flash's CS input line to CS0 output */
+        qemu_irq flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+        sysbus_connect_irq(sbd, 1, flash_cs);
+    }
+
+    return s;
+}
+
diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_uart.h
new file mode 100644
index 0000000000..3651d4741f
--- /dev/null
+++ b/include/hw/char/neorv32_uart.h
@@ -0,0 +1,68 @@
+/*
+ * Neorv32-specific UART.
+ *
+ * Copyright (c) 2025 Michael Levit
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_NEORV32_UART_H
+#define HW_NEORV32_UART_H
+
+#include "chardev/char-fe.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_NEORV32_UART "riscv.neorv32.uart"
+OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
+
+#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8 /**256 < UART data register(8)  (r/-): log2(RX FIFO size), LSB */
+#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11 /** 2048 < UART data register(11) (r/-): log2(RX FIFO size), MSB */
+
+#define NEORV32_UART_RX_FIFO_SIZE  32 //in HW it is  2048 + 256 = _MSB + _LSB
+
+enum {
+	NEORV32_UART_IE_TXWM       = 1, /* Transmit watermark interrupt enable */
+	NEORV32_UART_IE_RXWM       = 2  /* Receive watermark interrupt enable */
+};
+
+enum {
+	NEORV32_UART_IP_TXWM       = 1, /* Transmit watermark interrupt pending */
+	NEORV32_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
+};
+
+
+
+struct Neorv32UARTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    qemu_irq irq;
+    MemoryRegion mmio;
+    CharBackend chr;
+    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
+    uint8_t rx_fifo_len;
+    uint32_t ie; //interrupt enable
+    uint32_t CTRL;
+    uint32_t DATA;
+};
+
+Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
+    Chardev *chr);
+
+#endif //HW_NEORV32_UART_H
diff --git a/include/hw/riscv/neorv32.h b/include/hw/riscv/neorv32.h
new file mode 100644
index 0000000000..46c7f6767e
--- /dev/null
+++ b/include/hw/riscv/neorv32.h
@@ -0,0 +1,60 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HW_NEORV32_H
+#define HW_NEORV32_H
+
+#include "hw/riscv/riscv_hart.h"
+#include "hw/boards.h"
+
+#if defined(TARGET_RISCV32)
+#define NEORV32_CPU TYPE_RISCV_CPU_NEORV32
+#endif
+
+#define TYPE_RISCV_NEORV32_SOC "riscv.neorv32.soc"
+#define RISCV_NEORV32_SOC(obj) \
+    OBJECT_CHECK(Neorv32SoCState, (obj), TYPE_RISCV_NEORV32_SOC)
+
+typedef struct Neorv32SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    DeviceState *plic;
+    MemoryRegion imem_region;
+    MemoryRegion bootloader_rom;
+} Neorv32SoCState;
+
+typedef struct Neorv32State {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    Neorv32SoCState soc;
+} Neorv32State;
+
+#define TYPE_NEORV32_MACHINE MACHINE_TYPE_NAME("neorv32")
+#define NEORV32_MACHINE(obj) \
+    OBJECT_CHECK(Neorv32State, (obj), TYPE_NEORV32_MACHINE)
+
+enum {
+	NEORV32_IMEM,
+	NEORV32_BOOTLOADER_ROM,
+	NEORV32_DMEM,
+	NEORV32_SYSINFO,
+	NEORV32_UART0,
+	NEORV32_SPI0,
+};
+
+#endif //HW_NEORV32_H
diff --git a/include/hw/ssi/neorv32_spi.h b/include/hw/ssi/neorv32_spi.h
new file mode 100644
index 0000000000..525bacf2d3
--- /dev/null
+++ b/include/hw/ssi/neorv32_spi.h
@@ -0,0 +1,70 @@
+/*
+ * QEMU implementation of the Neorv32 SPI block.
+ *
+ * Copyright (c) 2025 Michael Levit.
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef NEORV32_SPI_H
+#define NEORV32_SPI_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+
+#define TYPE_NEORV32_SPI "neorv32.spi"
+#define NEORV32_SPI(obj) OBJECT_CHECK(NEORV32SPIState, (obj), TYPE_NEORV32_SPI)
+
+typedef struct  NEORV32SPIState {
+    SysBusDevice parent_obj;
+
+    /* Memory-mapped registers */
+    MemoryRegion mmio;
+
+    /* IRQ line */
+    qemu_irq irq;
+
+    /* SPI bus (master) */
+    SSIBus *bus;
+
+    /* Chip selects (assume up to 3 CS lines) */
+    qemu_irq *cs_lines;
+    uint32_t num_cs;
+
+    /* Registers:
+     * Assume:
+     * 0x00: CTRL (r/w)
+     * 0x04: DATA (r/w)
+     */
+    uint32_t ctrl;
+    uint32_t data;
+
+    /* FIFOs */
+    Fifo8 tx_fifo;
+    Fifo8 rx_fifo;
+
+    /* FIFO capacity */
+    int fifo_capacity;
+    /* Track CS state driven by command writes */
+    bool cmd_cs_active;  /* true = CS asserted (active-low on wire) */
+    int  current_cs;     /* which CS line is active; default 0 for now */
+} NEORV32SPIState;
+
+
+
+NEORV32SPIState *neorv32_spi_create(MemoryRegion *sys_mem, hwaddr base_addr);
+
+#endif /* NEORV32_SPI_H */
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..a39bf853cc 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,8 @@
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
+#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
+
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a877018ab0..b018b5c49a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
+    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa), 
 
     { },
 };
@@ -1365,6 +1366,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+	MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
 
     { },
 };
@@ -2993,6 +2995,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3036,6 +3039,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
+	DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
+		.misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 16,
+		.cfg.mvendorid = NEORV32_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = neorv32_csr_list
+#endif
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c13012442..af0779d52f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -984,5 +984,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
+/* Implemented in neorv32_csr.c */
+extern const RISCVCSR neorv32_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..9ad38506e4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -64,5 +64,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+MATERIALISE_EXT_PREDICATE(xneorv32xisa)
 
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..530e7bd59c 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xneorv32xisa)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..66a8f30b81 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -7,4 +7,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define NEORV32_VENDOR_ID       0xF0000001
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..44e706ad3f 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -40,6 +40,7 @@ riscv_system_ss.add(files(
   'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
+  'neorv32_csr.c',
 ))
 
 subdir('tcg')
diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
new file mode 100644
index 0000000000..0cb8663436
--- /dev/null
+++ b/target/riscv/neorv32_csr.c
@@ -0,0 +1,54 @@
+/*
+ * Neorv32-specific CSR.
+ *
+ * Copyright (c) 2025 Michael Levit
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+#define    CSR_MXISA    (0xfc0)
+
+static RISCVException smode(CPURISCVState *env, int csrno)
+{
+	return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+	/* We don't support any extension for now on QEMU */
+    *val = 0x00;
+    return RISCV_EXCP_NONE;
+}
+
+static bool test_neorv32_mvendorid(RISCVCPU *cpu)
+{
+    return cpu->cfg.mvendorid == NEORV32_VENDOR_ID;
+}
+
+const RISCVCSR neorv32_csr_list[] = {
+    {
+        .csrno = CSR_MXISA,
+        .insertion_test = test_neorv32_mvendorid,
+        .csr_ops = { "neorv32.xisa", smode, read_neorv32_xisa }
+    },
+    { }
+};
+
-- 
2.20.1


