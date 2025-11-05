Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1783CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGibW-00048p-Gp; Wed, 05 Nov 2025 13:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib4-0003zY-QB
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib0-0003CB-RB
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775a52e045so376885e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 10:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762368661; x=1762973461;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BHzlRkBUYh2EjQ2JUIqKE4S0PnVMUwsZ8qt/uPZSfU=;
 b=XmT6qMDahnu8Q6JwaeScbMkTYwtSoC1JUzo8bciC+Q8s+9f+gBG/d1agXsnyTqGSjX
 +fzH34jfZiCn2GokWuhaQi50F0sZ0852ouyCNLp2GQNQ2TZWmGYixrVoLRFbfJ9tOUtE
 EtsP/nfDQwrKJ3EKc14/8Cab2gCWVdiUhMP4RfAbDLb8BUmV3i1S35ZlkNc9sPVZzHhh
 FlZxg25IsCtzELV1hVfq0PjU+flRpZooCny/nFQYDWzqBYii/ir981XoW6dl9bSTbMt5
 HTp2Rkc/GPV26AKaEH6WZ33U0MT3xk+rJjtjNVvDqW5ocb+gwHStfewibAUYr0HPZxx3
 QmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762368661; x=1762973461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BHzlRkBUYh2EjQ2JUIqKE4S0PnVMUwsZ8qt/uPZSfU=;
 b=I7LjKtblz/QUTQVJMcBb7q3r+rAYglufR3KLklC//Li3NKOykqQZRN46FK8Uy/mJCu
 vusVLPzk0t0lScqkqoYAbtiTyoDNEqeOyyTmscJ2vgVzXIIXyEhqwAXdmYKf5U0OTzrr
 HNp4od6bIdaxvq4JIdlzG4Xv4mTjsHEUv4BskMpI75C7AS8LOoKZYLWEV/U36D6hCM5s
 BexgxV9/zAKxVw2hX0ZTvH7JiP/4HLxE/dW8m+WgRg9ZBvkzHevI+v1RD9mmDtqTntxJ
 W68jXLjaUvDRkSR8ePNeF0oIpjUrLLpPQJLAfS5ny5Gz9rrJwLsJZ69PQG6Xxyt8wcvT
 xssQ==
X-Gm-Message-State: AOJu0YxlyGQsCT9Md1gLcoXExj9dU0ElnEcbZBJFoyCLYc11mRmp9agJ
 BatdrlUn8MyYmT7n83PWMgUt7WUqVxaH8W3ZFh08z3zLj0ePjiz96mUr73jpf8a+7IUZT74ncyB
 bnbD5F5Q=
X-Gm-Gg: ASbGncuoKsU15KpzYteT0pkmrU1Oiku11ae2dqbeomGH8OG8RnYF0Y7vDL7eFFQzTGE
 VzGJjcGuk4s4J52pAl5mWk7e73T9V3IeDmXsoZYlIEnFC0pRuhrI7UlB9jFRwvE6WxPIHIOFtSa
 LmqeNkahB1xs9iy+gVMzg/Wtlh1IHhMHxalWniDeM9WwQmzFxW6jUZPbIRzTYHNB/ULCjelgxrT
 GA2otyNEt7m3Anz1OsO3ymNhlbS4g0MxpHr/nk/svKw1eydQ6dS03zicj9JqMwpK3mA6zlHhs7L
 fC9rflrNriX1A0DyGtjtT3mXgP332r5JaHuJ6dZ2xBTS8hVVzT5jnN7PofiTyiTQyW5vg09jMh0
 8nUz09Rl+gJGeC0HyufAwpYJJjr5pzFLO1P8nT6CDUtEp7ehjR9FqYVHm0Z/YNRpHSQD9dl8Jfj
 Pm4srOEeU2Na5N4Ec=
X-Google-Smtp-Source: AGHT+IGWMsr/Fllml8pRNdOg083d7fdM/SpV6egSwCWWHV6eOq1/B+gOkK386GXBafAZjHffK7VnsA==
X-Received: by 2002:a05:6000:2408:b0:429:ca3c:b802 with SMTP id
 ffacd0b85a97d-429e3309404mr4195497f8f.44.1762368660530; 
 Wed, 05 Nov 2025 10:51:00 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a354sm270622f8f.20.2025.11.05.10.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:51:00 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v3 2/5] hw/misc: add NEORV32 SYSINFO block (CLK/MISC/SOC/CACHE)
Date: Wed,  5 Nov 2025 20:50:53 +0200
Message-ID: <20251105185056.23565-3-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105185056.23565-1-michael@videogpu.com>
References: <20251105185056.23565-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::332;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a minimal SYSINFO MMIO device compatible with NEORV32 SDK expectations:
CLK (rw), MISC/SOC/CACHE (ro) composed from constants. Includes Kconfig/meson.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 hw/misc/Kconfig               |   2 +
 hw/misc/meson.build           |   1 +
 hw/misc/neorv32_sysinfo.c     | 201 ++++++++++++++++++++++++++++
 hw/misc/neorv32_sysinfo.h     |  88 +++++++++++++
 hw/misc/neorv32_sysinfo_rtl.h | 239 ++++++++++++++++++++++++++++++++++
 5 files changed, 531 insertions(+)
 create mode 100644 hw/misc/neorv32_sysinfo.c
 create mode 100644 hw/misc/neorv32_sysinfo.h
 create mode 100644 hw/misc/neorv32_sysinfo_rtl.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..dba77acb63 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -240,4 +240,6 @@ config IOSB
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
index 0000000000..e64a003120
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo.c
@@ -0,0 +1,201 @@
+/*
+ * Neorv32 SysInfo
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
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
+    REG_SYSINFO_CLK    = 0x00,
+    REG_SYSINFO_MISC   = 0x04,
+    REG_SYSINFO_SOC    = 0x08,
+    REG_SYSINFO_CACHE  = 0x0C,
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
+    const uint32_t imem_log2  =
+        neorv32_log2u(SYSINFO_IMEM_SIZE) & 0xFFU;  /* Bits [7:0]  */
+    const uint32_t dmem_log2  =
+        neorv32_log2u(SYSINFO_DMEM_SIZE) & 0xFFU;  /* Bits [15:8] */
+    const uint32_t harts      =
+        (SYSINFO_NUM_HARTS & 0x0FU);               /* Bits [19:16] */
+    const uint32_t bootmode   =
+        (SYSINFO_BOOTMODE_ID & 0x03U);             /* Bits [21:20] */
+    const uint32_t intbus_to  =
+        (SYSINFO_INTBUS_TO_LOG2 & 0x1FU);          /* Bits [26:22] */
+    const uint32_t extbus_to  =
+        (SYSINFO_EXTBUS_TO_LOG2 & 0x1FU);          /* Bits [31:27] */
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
+static void neorv32_sysinfo_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
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
+                              "%s: misaligned 16-bit write at 0x%"
+                              HWADDR_PRIx "\n",
+                              __func__, addr);
+
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
+                          "%s: invalid write size=%u at addr=0x%"
+                          HWADDR_PRIx "\n",
+                          __func__, size, addr);
+            return;
+        }
+
+        s->clk_hz = val;
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to read-only addr=0x%" HWADDR_PRIx " val=0x%"
+                  PRIx64 " size=%u\n",
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
index 0000000000..71e6a3a5d1
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo.h
@@ -0,0 +1,88 @@
+/*
+ * Neorv32 SysInfo
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
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
+/* Bus timeout encodings: value is log2(cycles); 0 means "no timeout" */
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
+/* Enable Bootloader, IMEM, DMEM, UART and SPI */
+#define SYSINFO_SOC_VAL \
+     (SYSINFO_SOC_ENABLE(SYSINFO_SOC_BOOTLOADER) | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IMEM)       | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_DMEM)       | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_UART0)   | \
+      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_SPI))
+
+/*
+ * -------------------------------------------------------------------------
+ * Address map
+ * -------------------------------------------------------------------------
+ */
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
+#endif /* HW_NEORV32_SYSINFO_H */
diff --git a/hw/misc/neorv32_sysinfo_rtl.h b/hw/misc/neorv32_sysinfo_rtl.h
new file mode 100644
index 0000000000..524400438b
--- /dev/null
+++ b/hw/misc/neorv32_sysinfo_rtl.h
@@ -0,0 +1,239 @@
+/*
+ * NEORV32 RTL specific definitions.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * NEORV32: neorv32_sysinfo.h - System Information Memory (SYSINFO) HW driver.
+ *
+ * BSD 3-Clause License.
+ *
+ * Copyright (c) 2023, Stephan Nolting.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright notice,
+ *    this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * 3. Neither the name of the copyright holder nor the names of its
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * The NEORV32 Processor: https://github.com/stnolting/neorv32
+ */
+
+#ifndef NEORV32_SYSINFO_RTL_H
+#define NEORV32_SYSINFO_RTL_H
+
+/*
+ * IO Device: System Configuration Information Memory (SYSINFO).
+ */
+
+typedef struct __attribute__((packed, aligned(4))) {
+    uint32_t CLK;         /* Offset 0: Clock speed in Hz. */
+    const uint32_t MISC;  /*
+                           * Offset 4: Misc system configuration bits.
+                           * See enum NEORV32_SYSINFO_MISC_enum.
+                           */
+    const uint32_t SOC;   /*
+                           * Offset 8: Implemented SoC features.
+                           * See enum NEORV32_SYSINFO_SOC_enum.
+                           */
+    const uint32_t CACHE; /*
+                           * Offset 12: Cache configuration.
+                           * See enum NEORV32_SYSINFO_CACHE_enum.
+                           */
+} neorv32_sysinfo_t;
+
+/* SYSINFO module hardware access. */
+#define NEORV32_SYSINFO ((neorv32_sysinfo_t *)(NEORV32_SYSINFO_BASE))
+
+/*
+ * NEORV32_SYSINFO.MISC (r/-): Miscellaneous system configurations.
+ */
+enum NEORV32_SYSINFO_MISC_enum {
+    /* log2(internal IMEM size in bytes) (via IMEM_SIZE generic). */
+    SYSINFO_MISC_IMEM_LSB = 0,   /* LSB. */
+    SYSINFO_MISC_IMEM_MSB = 7,   /* MSB. */
+
+    /* log2(internal DMEM size in bytes) (via DMEM_SIZE generic). */
+    SYSINFO_MISC_DMEM_LSB = 8,   /* LSB. */
+    SYSINFO_MISC_DMEM_MSB = 15,  /* MSB. */
+
+    /* Number of physical CPU cores ("harts"). */
+    SYSINFO_MISC_HART_LSB = 16,  /* LSB. */
+    SYSINFO_MISC_HART_MSB = 19,  /* MSB. */
+
+    /* Boot mode configuration (via BOOT_MODE_SELECT generic). */
+    SYSINFO_MISC_BOOT_LSB = 20,  /* LSB. */
+    SYSINFO_MISC_BOOT_MSB = 21,  /* MSB. */
+
+    /* log2(internal bus timeout cycles). */
+    SYSINFO_MISC_ITMO_LSB = 22,  /* LSB. */
+    SYSINFO_MISC_ITMO_MSB = 26,  /* MSB. */
+
+    /* log2(external bus timeout cycles). */
+    SYSINFO_MISC_ETMO_LSB = 27,  /* LSB. */
+    SYSINFO_MISC_ETMO_MSB = 31   /* MSB. */
+};
+
+/*
+ * NEORV32_SYSINFO.SOC (r/-): Implemented processor devices/features.
+ */
+enum NEORV32_SYSINFO_SOC_enum {
+    /* Bootloader implemented when 1 (via BOOT_MODE_SELECT). */
+    SYSINFO_SOC_BOOTLOADER = 0,
+
+    /* External bus interface implemented when 1 (via XBUS_EN). */
+    SYSINFO_SOC_XBUS = 1,
+
+    /* Instruction memory implemented when 1 (via IMEM_EN). */
+    SYSINFO_SOC_IMEM = 2,
+
+    /* Data memory implemented when 1 (via DMEM_EN). */
+    SYSINFO_SOC_DMEM = 3,
+
+    /* On-chip debugger implemented when 1 (via OCD_EN). */
+    SYSINFO_SOC_OCD = 4,
+
+    /* Instruction cache implemented when 1 (via ICACHE_EN). */
+    SYSINFO_SOC_ICACHE = 5,
+
+    /* Data cache implemented when 1 (via DCACHE_EN). */
+    SYSINFO_SOC_DCACHE = 6,
+
+    /* Reserved. */
+    /* SYSINFO_SOC_reserved = 7, */
+
+    /* Reserved. */
+    /* SYSINFO_SOC_reserved = 8, */
+
+    /* Reserved. */
+    /* SYSINFO_SOC_reserved = 9, */
+
+    /* Reserved. */
+    /* SYSINFO_SOC_reserved = 10, */
+
+    /* On-chip debugger authentication when 1 (via OCD_AUTHENTICATION). */
+    SYSINFO_SOC_OCD_AUTH = 11,
+
+    /*
+     * Instruction memory as pre-initialized ROM when 1
+     * (via BOOT_MODE_SELECT).
+     */
+    SYSINFO_SOC_IMEM_ROM = 12,
+
+    /* Two-wire device implemented when 1 (via IO_TWD_EN). */
+    SYSINFO_SOC_IO_TWD = 13,
+
+    /* Direct memory access controller when 1 (via IO_DMA_EN). */
+    SYSINFO_SOC_IO_DMA = 14,
+
+    /* General purpose I/O port when 1 (via IO_GPIO_EN). */
+    SYSINFO_SOC_IO_GPIO = 15,
+
+    /* Core local interruptor when 1 (via IO_CLINT_EN). */
+    SYSINFO_SOC_IO_CLINT = 16,
+
+    /* UART0 when 1 (via IO_UART0_EN). */
+    SYSINFO_SOC_IO_UART0 = 17,
+
+    /* SPI when 1 (via IO_SPI_EN). */
+    SYSINFO_SOC_IO_SPI = 18,
+
+    /* TWI when 1 (via IO_TWI_EN). */
+    SYSINFO_SOC_IO_TWI = 19,
+
+    /* PWM unit when 1 (via IO_PWM_EN). */
+    SYSINFO_SOC_IO_PWM = 20,
+
+    /* Watchdog timer when 1 (via IO_WDT_EN). */
+    SYSINFO_SOC_IO_WDT = 21,
+
+    /* Custom functions subsystem when 1 (via IO_CFS_EN). */
+    SYSINFO_SOC_IO_CFS = 22,
+
+    /* True random number generator when 1 (via IO_TRNG_EN). */
+    SYSINFO_SOC_IO_TRNG = 23,
+
+    /* Serial data interface when 1 (via IO_SDI_EN). */
+    SYSINFO_SOC_IO_SDI = 24,
+
+    /* UART1 when 1 (via IO_UART1_EN). */
+    SYSINFO_SOC_IO_UART1 = 25,
+
+    /* NeoPixel-compatible smart LED IF when 1 (via IO_NEOLED_EN). */
+    SYSINFO_SOC_IO_NEOLED = 26,
+
+    /* Execution tracer when 1 (via IO_TRACER_EN). */
+    SYSINFO_SOC_IO_TRACER = 27,
+
+    /* General purpose timer when 1 (via IO_GPTMR_EN). */
+    SYSINFO_SOC_IO_GPTMR = 28,
+
+    /* Stream link interface when 1 (via IO_SLINK_EN). */
+    SYSINFO_SOC_IO_SLINK = 29,
+
+    /* 1-wire interface controller when 1 (via IO_ONEWIRE_EN). */
+    SYSINFO_SOC_IO_ONEWIRE = 30
+
+    /* Reserved. */
+    /* SYSINFO_SOC_reserved = 31 */
+};
+
+/*
+ * NEORV32_SYSINFO.CACHE (r/-): Cache configuration.
+ */
+enum NEORV32_SYSINFO_CACHE_enum {
+    /* I-cache: log2(block size in bytes), bit 0 (via CACHE_BLOCK_SIZE). */
+    SYSINFO_CACHE_INST_BLOCK_SIZE_0 = 0,
+
+    /* I-cache: log2(block size in bytes), bit 3 (via CACHE_BLOCK_SIZE). */
+    SYSINFO_CACHE_INST_BLOCK_SIZE_3 = 3,
+
+    /* I-cache: log2(number of cache blocks), bit 0 (via ICACHE_NUM_BLOCKS). */
+    SYSINFO_CACHE_INST_NUM_BLOCKS_0 = 4,
+
+    /* I-cache: log2(number of cache blocks), bit 3 (via ICACHE_NUM_BLOCKS). */
+    SYSINFO_CACHE_INST_NUM_BLOCKS_3 = 7,
+
+    /* D-cache: log2(block size in bytes), bit 0 (via CACHE_BLOCK_SIZE). */
+    SYSINFO_CACHE_DATA_BLOCK_SIZE_0 = 8,
+
+    /* D-cache: log2(block size in bytes), bit 3 (via CACHE_BLOCK_SIZE). */
+    SYSINFO_CACHE_DATA_BLOCK_SIZE_3 = 11,
+
+    /* D-cache: log2(number of cache blocks), bit 0 (via DCACHE_NUM_BLOCKS). */
+    SYSINFO_CACHE_DATA_NUM_BLOCKS_0 = 12,
+
+    /* D-cache: log2(number of cache blocks), bit 3 (via DCACHE_NUM_BLOCKS). */
+    SYSINFO_CACHE_DATA_NUM_BLOCKS_3 = 15,
+
+    /* I-cache: issue burst transfers on update (via CACHE_BURSTS_EN). */
+    SYSINFO_CACHE_INST_BURSTS_EN = 16,
+
+    /* D-cache: issue burst transfers on update (via CACHE_BURSTS_EN). */
+    SYSINFO_CACHE_DATA_BURSTS_EN = 24
+};
+
+#endif /* NEORV32_SYSINFO_RTL_H */
-- 
2.51.1


