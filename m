Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933EACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCHDR-00020q-SV; Thu, 01 Oct 2026 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xCHD5-0001xl-ME
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:52:31 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xCHD1-0000Pz-Mo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:52:31 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-6729ca45e37so6972173d50.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790862746; x=1791467546; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pi2W8Ti6aOPiL474zuOsqBmJ4iLM0vauNF3RPl53rjk=;
 b=LKamEE9xlTw+RAxFBT6IxVcJhlC0liRFupD5b/86uoZ4epKyiZ4qTn3k94c2UuuoaR
 V6pxnb5kXrD7wQ/bXApXS1AOfX0X3RfRd4Ul7icXjBpDzOggTVVPcSzNLc0zc32QYNko
 A7asste/duDg1dS7FaCYMotWFWsS7orxsUfdUMsx2RsJd42j+NhBiQw7PsSQrvKDihBy
 tyr6CIW0qOdKAccatGEO7uYlWCtwTzs2tU2F0xnJL+VEbhXetHOhdFJkXTi4SUrJtTIB
 itj4R4ftjCDd7NV+7HT4HOctZYKz00YB+o2D48hRLltVqCI9jjZI0etVn9uh5o0r6ep1
 vr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790862746; x=1791467546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pi2W8Ti6aOPiL474zuOsqBmJ4iLM0vauNF3RPl53rjk=;
 b=QDJtw5+VUoDqhAmN7O0k8RBXTlhLJv1PtTmR4Vot2Lw9nf6GtD+iFb8C/7B5Huqtiv
 WYV6oznMYuJI/s+cBlkjD1t569MnuSrQKVu38vaOTGgGszIQDzqufG9ef6kkkB+ysyAT
 UtmDRfS8GAL/ADKIYhPhrnLzmltSU24FnCp5ihpSx9nxB4qvMz0TrSliwlkGaHj7K2kP
 WSmXcbJyujEbLwTV7c0rF3lPbHSDNjLnwqwG1edRYhQC4vmbAzAAsFphQ1RSTXrt7Hqy
 T1C0cHXBhjHluKnsjM5hI6krtvWkiq13b6k2HFOG3SchYKg5oi9NT0slHxvB9bnqWMS9
 G7gg==
X-Gm-Message-State: AFq9FYLz13udd7Yjdfs9j8DvJfj8b8YQWIqWxQQtTdAnX7Cs22flLLnU
 oAQapbf3dXsd5W12gyAWo2mpyyImilIDcUBXLI9yzMkmFjzzuRZ94JWQrL6qrVanu0Q=
X-Gm-Gg: AYBFou3wvnbNnXIV+DMi95aEpKHYtc2qW2/Z+FgvwGJL5eblqcY2TcUoUdoIotIS6vo
 YtFfwaKjAhJUmUbAQMF9cIKZwlnpE7oQm9P8l3qWq7R4ccIbZHIgn0ftccdlNVOOjuzKSwTTEIV
 QIDd6iTp6TMwAiUk2hsIg7uE/j/WcvjzAvi/Sd+GY9zDqtvBVW9zxUq2XIIWYxQXXZyknJQMU5k
 O3+Sa/bK+vdyT/rqMhd4Di5yLdFiiJs9xY5OkSCBWMtGwvwxUxtKwF+kBAmcstoVd6QeIM1W1JS
 keiohhjQJY2hSvK99f9Cz5PWDe4mVPp9SGKI2RIgnOJ5pZHVJN3ohIzTiNU6Ej6ftrnc48JSZAK
 QWhhYHPsm0pSNyB9Ibc3UAXujJN7xgJzDzOxLDDOZPfpTDR9Lo5QXzbhUe0/FKqsmN0OEoRWjn1
 GzQ9YAk6y60jBfR+DZcE5IL+ogOCjlgu6Rsfeo+GNuEBuA1ZuJALZmGNnibNjG0VbHNNLM0Fog+
 3PHMTxUMl9XjtGboJ/tEoI6CCm3Z7mvoeofx3xMKbhTCBWt
X-Received: by 2002:a53:d005:0:b0:674:9cc:4127 with SMTP id
 956f58d0204a3-676834f698bmr1488143d50.140.1790862746190; 
 Thu, 01 Oct 2026 06:52:26 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8acdac9e4d6sm10587707b3.11.2026.10.01.06.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 06:52:25 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 01 Oct 2026 08:52:08 -0500
Subject: [PATCH v4 1/3] hw/misc: Add Tenstorrent Atlantis PRCM model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-atlantis_prcm-v4-1-95d33c470eeb@oss.tenstorrent.com>
References: <20261001-atlantis_prcm-v4-0-95d33c470eeb@oss.tenstorrent.com>
In-Reply-To: <20261001-atlantis_prcm-v4-0-95d33c470eeb@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This device present in Tenstorrent Atlantis has registers that control
clocks, reset and other misc functionality in the SoC. This commit adds
models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.

Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 MAINTAINERS                        |   2 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   4 +
 hw/misc/tt_atlantis_prcm.c         | 428 +++++++++++++++++++++++++++++++++++++
 include/hw/misc/tt_atlantis_prcm.h |  51 +++++
 5 files changed, 486 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f524d90523..b6cc077602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1830,7 +1830,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/tt_*.rst
+F: hw/misc/tt_*.c
 F: hw/riscv/tt_*.c
+F: include/hw/misc/tt_*.h
 F: include/hw/riscv/tt_*.h
 F: tests/functional/riscv64/test_tt_*.py
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda..11b9593e03 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -39,6 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
+system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_prcm.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0b8be3d0f2..8b80b71107 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -452,3 +452,7 @@ launch_update_write(void) ""
 vmlaunch_reset_enter(void) ""
 vm_launchupdate_finalize(void) ""
 restore_host_x86_igvm(void) ""
+
+# tt_atlantis_prcm.c
+tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
+tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
new file mode 100644
index 0000000000..31caca08fc
--- /dev/null
+++ b/hw/misc/tt_atlantis_prcm.c
@@ -0,0 +1,428 @@
+/*
+ * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Tenstorrent
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/misc/tt_atlantis_prcm.h"
+#include "trace.h"
+
+#define TO_REG(offset) ((offset) >> 2)
+
+#define PLL_LOCK_BIT        31
+#define PLL_FBDIV_LSB       14
+#define PLL_POSTDIV2_LSB    11
+#define PLL_POSTDIV1_LSB    8
+#define PLL_REFDIV_LSB      2
+#define PLL_BYPASS_BIT      1
+
+#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV, LOCK)         \
+  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB) |                         \
+   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB) |           \
+   (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
+
+#define RCPU_PLL_RCPU_CFG   TO_REG(0x000)
+#define RCPU_PLL_NOCC_CFG   TO_REG(0x004)
+#define RCPU_NOCC_CLK_CFG   TO_REG(0x008)
+#define RCPU_RCPU_DIV_CFG   TO_REG(0x00c)
+#define RCPU_RCPU_BLK_CG    TO_REG(0x014)
+#define RCPU_LSIO_BLK_CG    TO_REG(0x018)
+#define RCPU_RCPU_BLK_RST   TO_REG(0x01c)
+#define RCPU_LSIO_BLK_RST   TO_REG(0x020)
+#define RCPU_PLL_RCPU_EN    TO_REG(0x11c)
+#define RCPU_PLL_NOCC_EN    TO_REG(0x120)
+#define RCPU_PLL_MM_EN      TO_REG(0x124)
+#define RCPU_PLL1_MM_EN     TO_REG(0x128)
+#define RCPU_PLL_HSIO_EN    TO_REG(0x12c)
+#define RCPU_PLL_PCIE_EN    TO_REG(0x138)
+#define RCPU_PLL_I2S_EN     TO_REG(0x13c)
+#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
+#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
+#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
+#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
+#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
+#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
+#define RCPU_BUS_CFG        TO_REG(0x1fc)
+#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)
+
+#define HSIO_HSIO_DIV_CFG       TO_REG(0x00)
+#define HSIO_HSIO_DIV_CFG1      TO_REG(0x04)
+#define HSIO_HSIO_BLK_CG        TO_REG(0x08)
+#define HSIO_HSIO_BLK_RST       TO_REG(0x0c)
+#define HSIO_HSIO_GMAC_DIV_CFG  TO_REG(0x10)
+
+#define PCIE_SUBS_RST_CTL   TO_REG(0x0)
+#define PCIE_SUBS_CG_CTL    TO_REG(0x4)
+#define PCIE_SUBS_CK_CTL    TO_REG(0x8)
+
+#define MM_MM_CLK_GATE_CFG  TO_REG(0x008)
+#define MM_MM_CLK_DIV_CFG   TO_REG(0x00c)
+#define MM_MM_CLK_SEL_CFG   TO_REG(0x010)
+#define MM_MM_RSTN          TO_REG(0x014)
+#define MM_MM_CLK_DIV_CFG1  TO_REG(0x130)
+
+#define DDRC_STAT           TO_REG(0x10014)
+#define DDRC_DFISTAT        TO_REG(0x10514)
+#define DDRC_SWSTAT         TO_REG(0x10c84)
+
+#define PLL_EN              BIT(0)
+#define RCPU_PLL_BUS_CG_EN  BIT(7)
+#define HSIO_PLL_BUS_CG_EN  BIT(3)
+#define PCIE_PLL_BUS_CG_EN  BIT(1)
+#define NOCC_PLL_BUS_CG_EN  BIT(0)
+
+#define RCPU_BOOT_MODE_UART      (0x0 << 4)
+#define RCPU_BOOT_MODE_NOR       (0x1 << 4)
+#define RCPU_BOOT_MODE_SD        (0x2 << 4)
+
+#define RCPU_DOMAIN_SIZE   0x10000
+#define HSIO_DOMAIN_SIZE   0x510
+#define PCIE_DOMAIN_SIZE   0x100
+#define MM_DOMAIN_SIZE     0x1000
+#define DDRC0_DOMAIN_SIZE  0x101000
+#define DDRC1_DOMAIN_SIZE  0x101000
+
+static uint64_t tt_atlantis_prcm_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
+    uint32_t data;
+
+    if (offset >= c->regs_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+    data = s->regs[TO_REG(offset)];
+
+    trace_tt_atlantis_prcm_read(c->domain, offset, data);
+    return data;
+}
+
+static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
+                                   uint64_t data, unsigned size)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
+
+    if (offset >= c->regs_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    trace_tt_atlantis_prcm_write(c->domain, offset, data);
+
+    s->regs[TO_REG(offset)] = data;
+}
+
+static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
+                                        uint64_t data, unsigned size)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
+    uint32_t pll_reg_offset;
+
+    tt_atlantis_prcm_write(opaque, offset, data, size);
+
+    switch (TO_REG(offset)) {
+    case RCPU_PLL_RCPU_EN:
+        pll_reg_offset = RCPU_PLL_RCPU_CFG;
+        break;
+    case RCPU_PLL_NOCC_EN:
+        pll_reg_offset = RCPU_PLL_NOCC_CFG;
+        break;
+    case RCPU_PLL_HSIO_EN:
+        pll_reg_offset = RCPU_PLL_HSIO_CFG;
+        break;
+    case RCPU_PLL_PCIE_EN:
+        pll_reg_offset = RCPU_PLL_PCIE_CFG;
+        break;
+    case RCPU_PLL_MM_EN:
+        pll_reg_offset = RCPU_PLL_MM_CFG;
+        break;
+    case RCPU_PLL1_MM_EN:
+        pll_reg_offset = RCPU_PLL1_MM_CFG;
+        break;
+    case RCPU_PLL_I2S_EN:
+        pll_reg_offset = RCPU_PLL_I2S_CFG;
+        break;
+    default:
+        return;
+    }
+
+    if (data & PLL_EN) {
+        s->regs[pll_reg_offset] |= BIT(PLL_LOCK_BIT);
+    } else {
+        s->regs[pll_reg_offset] &= ~BIT(PLL_LOCK_BIT);
+    }
+}
+
+static const MemoryRegionOps tt_atlantis_prcm_ops = {
+    .read = tt_atlantis_prcm_read,
+    .write = tt_atlantis_prcm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops = {
+    .read = tt_atlantis_prcm_read,
+    .write = tt_atlantis_prcm_rcpu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
+
+    assert(c->domain < TT_ATLANTIS_PRCM_DOMAIN_COUNT);
+
+    s->regs = g_new0(uint32_t, TO_REG(c->regs_size));
+
+    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
+                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void tt_atlantis_prcm_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
+
+    memset(s->regs, 0, c->regs_size);
+}
+
+static void tt_atlantis_prcm_rcpu_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    tt_atlantis_prcm_reset_hold(obj, type);
+
+    /* Reset values come from Datasheet */
+    s->regs[RCPU_PLL_RCPU_CFG] = PLL_RESET_VAL(1, 0, 4, 0, 100, 1);
+    s->regs[RCPU_PLL_NOCC_CFG] = PLL_RESET_VAL(0, 2, 2, 2, 267, 1);
+    s->regs[RCPU_NOCC_CLK_CFG] = (0x25f31 << 1) | BIT(0);
+    s->regs[RCPU_RCPU_DIV_CFG] = (0xb8c2 << 1);
+    s->regs[RCPU_RCPU_BLK_CG] = 0;
+    s->regs[RCPU_LSIO_BLK_CG] = 0;
+    s->regs[RCPU_RCPU_BLK_RST] = 0xffffffff;
+    s->regs[RCPU_LSIO_BLK_RST] = 0xffffffff;
+    s->regs[RCPU_PLL_RCPU_EN] = PLL_EN;
+    s->regs[RCPU_PLL_NOCC_EN] = PLL_EN;
+    s->regs[RCPU_PLL_HSIO_EN] = 0;
+    s->regs[RCPU_PLL_MM_EN] = 0;
+    s->regs[RCPU_PLL1_MM_EN] = 0;
+    s->regs[RCPU_PLL_I2S_EN] = 0;
+    s->regs[RCPU_PLL_PCIE_EN] = 0;
+    s->regs[RCPU_PLL_HSIO_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 0);
+    s->regs[RCPU_PLL_PCIE_CFG] = PLL_RESET_VAL(0, 2, 3, 1, 250, 0);
+    s->regs[RCPU_BOOT_MODE_CFG] = RCPU_BOOT_MODE_SD;
+    s->regs[RCPU_PLL_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
+    s->regs[RCPU_PLL1_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
+    s->regs[RCPU_PLL_I2S_CFG] = PLL_RESET_VAL(0, 1, 6, 6, 33, 0);
+    s->regs[RCPU_I2S_DIV_CFG] = 0xde69ad31;
+    s->regs[RCPU_BUS_CFG] = NOCC_PLL_BUS_CG_EN | HSIO_PLL_BUS_CG_EN;
+}
+
+static void tt_atlantis_prcm_ddrc_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    tt_atlantis_prcm_reset_hold(obj, type);
+
+    /* Reset values come from Datasheet */
+    s->regs[DDRC_STAT] = 0x1;
+    s->regs[DDRC_DFISTAT] = 0x1;
+    s->regs[DDRC_SWSTAT] = 0x1;
+}
+
+static void tt_atlantis_prcm_hsio_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    tt_atlantis_prcm_reset_hold(obj, type);
+
+    /* Reset values come from Datasheet */
+    s->regs[HSIO_HSIO_DIV_CFG] = 0x20821731;
+    s->regs[HSIO_HSIO_DIV_CFG1] = 0x8;
+    s->regs[HSIO_HSIO_BLK_CG] = 0;
+    s->regs[HSIO_HSIO_BLK_RST] = 0;
+    s->regs[HSIO_HSIO_GMAC_DIV_CFG] = 0;
+}
+
+static void tt_atlantis_prcm_pcie_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    tt_atlantis_prcm_reset_hold(obj, type);
+
+    /* Reset values come from Datasheet */
+    s->regs[PCIE_SUBS_RST_CTL] = 0;
+    s->regs[PCIE_SUBS_CG_CTL] = 0;
+    s->regs[PCIE_SUBS_CK_CTL] = 0x44908;
+}
+
+static void tt_atlantis_prcm_mm_reset_hold(Object *obj, ResetType type)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
+    tt_atlantis_prcm_reset_hold(obj, type);
+
+    /* Reset values come from Datasheet */
+    s->regs[MM_MM_CLK_GATE_CFG] = 0;
+    s->regs[MM_MM_CLK_DIV_CFG] = 0xddc8312;
+    s->regs[MM_MM_CLK_SEL_CFG] = 0;
+    s->regs[MM_MM_RSTN] = 0;
+    s->regs[MM_MM_CLK_DIV_CFG1] = 0x333;
+}
+
+static void tt_atlantis_prcm_unrealize(DeviceState *dev)
+{
+    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
+
+    g_free(s->regs);
+}
+
+static void tt_atlantis_prcm_class_init(ObjectClass *klass,
+                                        const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->realize = tt_atlantis_prcm_realize;
+    dc->unrealize = tt_atlantis_prcm_unrealize;
+    dc->desc = "Tenstorrent Atlantis PRCM Controller";
+    rc->phases.hold = tt_atlantis_prcm_reset_hold;
+    c->ops = &tt_atlantis_prcm_ops;
+}
+
+static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis RCPU PRCM Controller";
+    rc->phases.hold = tt_atlantis_prcm_rcpu_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_RCPU;
+    c->regs_size = RCPU_DOMAIN_SIZE;
+    c->ops = &tt_atlantis_prcm_rcpu_ops;
+}
+
+static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis HSIO PRCM Controller";
+    rc->phases.hold = tt_atlantis_prcm_hsio_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_HSIO;
+    c->regs_size = HSIO_DOMAIN_SIZE;
+}
+
+static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis PCIE PRCM Controller";
+    rc->phases.hold = tt_atlantis_prcm_pcie_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_PCIE;
+    c->regs_size = PCIE_DOMAIN_SIZE;
+}
+
+static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
+                                           const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis MM PRCM Controller";
+    rc->phases.hold = tt_atlantis_prcm_mm_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_MM;
+    c->regs_size = MM_DOMAIN_SIZE;
+}
+
+static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 0 PRCM";
+    rc->phases.hold = tt_atlantis_prcm_ddrc_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_DDRC0;
+    c->regs_size = DDRC0_DOMAIN_SIZE;
+}
+
+static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
+
+    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 1 PRCM";
+    rc->phases.hold = tt_atlantis_prcm_ddrc_reset_hold;
+    c->domain = TT_ATLANTIS_PRCM_DOMAIN_DDRC1;
+    c->regs_size = DDRC1_DOMAIN_SIZE;
+}
+
+static const TypeInfo tt_atlantis_prcm_types[] = {
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(TTAtlantisPRCMState),
+        .class_init = tt_atlantis_prcm_class_init,
+        .class_size = sizeof(TTAtlantisPRCMClass),
+        .abstract = true,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_RCPU,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_rcpu_class_init,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_HSIO,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_hsio_class_init,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_PCIE,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_pcie_class_init,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_MM,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_mm_class_init,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_DDRC0,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_ddrc0_class_init,
+    },
+    {
+        .name = TYPE_TT_ATLANTIS_PRCM_DDRC1,
+        .parent = TYPE_TT_ATLANTIS_PRCM,
+        .class_init = tt_atlantis_prcm_ddrc1_class_init,
+    },
+};
+
+DEFINE_TYPES(tt_atlantis_prcm_types);
diff --git a/include/hw/misc/tt_atlantis_prcm.h b/include/hw/misc/tt_atlantis_prcm.h
new file mode 100644
index 0000000000..4b72618346
--- /dev/null
+++ b/include/hw/misc/tt_atlantis_prcm.h
@@ -0,0 +1,51 @@
+/*
+ * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Tenstorrent
+ */
+
+#ifndef TT_ATLANTIS_PRCM_H
+#define TT_ATLANTIS_PRCM_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_TT_ATLANTIS_PRCM "tt.atlantis.prcm"
+#define TYPE_TT_ATLANTIS_PRCM_RCPU "tt.atlantis.prcm.rcpu"
+#define TYPE_TT_ATLANTIS_PRCM_HSIO "tt.atlantis.prcm.hsio"
+#define TYPE_TT_ATLANTIS_PRCM_PCIE "tt.atlantis.prcm.pcie"
+#define TYPE_TT_ATLANTIS_PRCM_MM "tt.atlantis.prcm.mm"
+#define TYPE_TT_ATLANTIS_PRCM_DDRC0 "tt.atlantis.prcm.ddrc0"
+#define TYPE_TT_ATLANTIS_PRCM_DDRC1 "tt.atlantis.prcm.ddrc1"
+OBJECT_DECLARE_TYPE(TTAtlantisPRCMState, TTAtlantisPRCMClass,
+                    TT_ATLANTIS_PRCM);
+
+
+enum {
+    TT_ATLANTIS_PRCM_DOMAIN_RCPU = 0,
+    TT_ATLANTIS_PRCM_DOMAIN_HSIO = 1,
+    TT_ATLANTIS_PRCM_DOMAIN_PCIE = 2,
+    TT_ATLANTIS_PRCM_DOMAIN_MM = 3,
+    TT_ATLANTIS_PRCM_DOMAIN_DDRC0 = 4,
+    TT_ATLANTIS_PRCM_DOMAIN_DDRC1 = 5,
+    TT_ATLANTIS_PRCM_DOMAIN_COUNT = 6
+};
+
+struct TTAtlantisPRCMState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+
+    uint32_t *regs;
+};
+
+struct TTAtlantisPRCMClass {
+    SysBusDeviceClass parent_class;
+
+    uint32_t domain;
+    uint32_t regs_size;
+    const MemoryRegionOps *ops;
+};
+
+#endif

-- 
2.43.0


