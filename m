Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E381ECDC19A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6so-0004ob-FW; Tue, 06 Jan 2026 08:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6sn-0004ks-E3; Tue, 06 Jan 2026 08:13:57 -0500
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6sj-0005ku-EK; Tue, 06 Jan 2026 08:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vk
 K7IiJfTBekrZSZR0sK1tRWT94JkY3JpRh8epNlpxg=; b=Zd3aemERfFPpItGj7a
 2CvnakgH2m38By9lktIVRUjfg/fTAtvUKcB2cdsqN1aPSgIQkPIvKdYaA2CP3zss
 biHJei703DTE1FwGJ5hAVqLQ3/AAisZa+srzAwW8fbu4gV85NPIsrPqLjLPcJLZJ
 owawBe/K0KETbleBnYb354ifE=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wDnT4lVCl1p0+SgFA--.17566S3; 
 Tue, 06 Jan 2026 21:13:06 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: cminyard@mvista.com, peter.maydell@linaro.org, philmd@linaro.org,
 ani@anisinha.ca, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH 1/2] hw/i2c/dw: Add DesignWare I2C controller emulator
Date: Tue,  6 Jan 2026 21:12:52 +0800
Message-ID: <20260106131253.16192-2-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106131253.16192-1-AlanoSong@163.com>
References: <20260106131253.16192-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnT4lVCl1p0+SgFA--.17566S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfXF1xZw4fWr4kGry3CFyrtFb_yoW8uw4fCo
 W0gw4Fqr18t34xCr40kw12qr18Cr15GF4Uta1Yvw4qg393Zw1DWF45K39xuFWIgrW5XrZ7
 Xwnayr93GF4ak3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRkwIDUUUUU
X-Originating-IP: [240e:36a:147b:2000:594:6424:e3:c901]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC1ARNYWldCmTotAAA36
Received-SPF: pass client-ip=117.135.210.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add DesignWare I2C controller according to DesignWare
I2C databook v2.01a.
Confirmed the model with i2c-tools under v6.18
linux driver.

The slave mode is not implemented, cause this feature
is usually not used.

The 10 bit slave address is not implemented, cause
this feature is usually not used, and not supported
by qemu I2C core bus currently.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/i2c/Kconfig          |   4 +
 hw/i2c/dw_i2c.c         | 517 ++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build      |   1 +
 hw/i2c/trace-events     |   4 +
 include/hw/i2c/dw_i2c.h | 151 ++++++++++++
 5 files changed, 677 insertions(+)
 create mode 100644 hw/i2c/dw_i2c.c
 create mode 100644 include/hw/i2c/dw_i2c.h

diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 596a7a3165..6bb20d45de 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -30,6 +30,10 @@ config IMX_I2C
     bool
     select I2C
 
+config DW_I2C
+    bool
+    select I2C
+
 config MPC_I2C
     bool
     select I2C
diff --git a/hw/i2c/dw_i2c.c b/hw/i2c/dw_i2c.c
new file mode 100644
index 0000000000..a5a31ec78c
--- /dev/null
+++ b/hw/i2c/dw_i2c.c
@@ -0,0 +1,517 @@
+/*
+ *  DesignWare I2C Bus Serial Interface Emulation
+ *
+ *  Copyright (C) 2026 Alano Song <AlanoSong@163.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/dw_i2c.h"
+#include "hw/core/irq.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+static const char *dw_i2c_get_regname(uint64_t offset)
+{
+    switch (offset) {
+    case DW_IC_CON: return "CON";
+    case DW_IC_TAR: return "TAR";
+    case DW_IC_SAR: return "SAR";
+    case DW_IC_DATA_CMD: return "DATA_CMD";
+    case DW_IC_SS_SCL_HCNT: return "SS_SCL_HCNT";
+    case DW_IC_SS_SCL_LCNT: return "SS_SCL_LCNT";
+    case DW_IC_FS_SCL_HCNT: return "FS_SCL_HCNT";
+    case DW_IC_FS_SCL_LCNT: return "FS_SCL_LCNT";
+    case DW_IC_INTR_STAT: return "INTR_STAT";
+    case DW_IC_INTR_MASK: return "INTR_MASK";
+    case DW_IC_RAW_INTR_STAT: return "RAW_INTR_STAT";
+    case DW_IC_RX_TL: return "RX_TL";
+    case DW_IC_TX_TL: return "TX_TL";
+    case DW_IC_CLR_INTR: return "CLR_INTR";
+    case DW_IC_CLR_RX_UNDER: return "CLR_RX_UNDER";
+    case DW_IC_CLR_RX_OVER: return "CLR_RX_OVER";
+    case DW_IC_CLR_TX_OVER: return "CLR_TX_OVER";
+    case DW_IC_CLR_RD_REQ: return "CLR_RD_REQ";
+    case DW_IC_CLR_TX_ABRT: return "CLR_TX_ABRT";
+    case DW_IC_CLR_RX_DONE: return "CLR_RX_DONE";
+    case DW_IC_CLR_ACTIVITY: return "CLR_ACTIVITY";
+    case DW_IC_CLR_STOP_DET: return "CLR_STOP_DET";
+    case DW_IC_CLR_START_DET: return "CLR_START_DET";
+    case DW_IC_CLR_GEN_CALL: return "CLR_GEN_CALL";
+    case DW_IC_ENABLE: return "ENABLE";
+    case DW_IC_STATUS: return "STATUS";
+    case DW_IC_TXFLR: return "TXFLR";
+    case DW_IC_RXFLR: return "RXFLR";
+    case DW_IC_SDA_HOLD: return "SDA_HOLD";
+    case DW_IC_TX_ABRT_SOURCE: return "TX_ABRT_SOURCE";
+    case DW_IC_ENABLE_STATUS: return "ENABLE_STATUS";
+    case DW_IC_COMP_PARAM_1: return "COMP_PARAM_1";
+    case DW_IC_COMP_VERSION: return "COMP_VERSION";
+    case DW_IC_COMP_TYPE: return "COMP_TYPE";
+    default: return "[?]";
+    }
+}
+
+/*
+ * If we change reg_raw_intr_stat or reg_intr_mask,
+ * must call this function to update reg_intr_stat and irq line.
+ */
+static void dw_i2c_update_intr(DWI2CState *s)
+{
+    s->reg_intr_stat = s->reg_raw_intr_stat & s->reg_intr_mask;
+    if (s->reg_intr_stat) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void dw_i2c_try_clear_intr(DWI2CState *s)
+{
+    if (!s->reg_intr_stat) {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint32_t dw_i2c_read_data_cmd(DWI2CState *s)
+{
+    uint32_t byte = 0;
+
+    if (fifo8_is_empty(&s->rx_fifo)) {
+        s->reg_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
+        dw_i2c_update_intr(s);
+    } else {
+        byte = fifo8_pop(&s->rx_fifo);
+
+        /*
+         * Driver may set reg_rx_tl as 0,
+         * so we also need to check if rx_fifo is empty here.
+         */
+        if (fifo8_num_used(&s->rx_fifo) < s->reg_rx_tl ||
+            fifo8_is_empty(&s->rx_fifo)) {
+            s->reg_raw_intr_stat &= ~DW_IC_INTR_RX_FULL;
+            dw_i2c_update_intr(s);
+        }
+    }
+
+    return byte;
+}
+
+static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    DWI2CState *s = DW_I2C(opaque);
+    uint32_t val = 0;
+
+    switch (offset) {
+    case DW_IC_CON:
+        val = s->reg_con;
+        break;
+    case DW_IC_TAR:
+        val = s->reg_tar;
+        break;
+    case DW_IC_SAR:
+        qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented\n",
+                      TYPE_DW_I2C, __func__);
+        break;
+    case DW_IC_DATA_CMD:
+        val = dw_i2c_read_data_cmd(s);
+        break;
+    case DW_IC_INTR_STAT:
+        val = s->reg_intr_stat;
+        break;
+    case DW_IC_INTR_MASK:
+        val = s->reg_intr_mask;
+        break;
+    case DW_IC_RAW_INTR_STAT:
+        val = s->reg_raw_intr_stat;
+        break;
+    case DW_IC_RX_TL:
+        val = s->reg_rx_tl;
+        break;
+    case DW_IC_TX_TL:
+        val = s->reg_tx_tl;
+        break;
+    case DW_IC_CLR_INTR:
+        s->reg_intr_stat = 0;
+        s->reg_tx_abrt_source = 0;
+        dw_i2c_try_clear_intr(s);
+        break;
+    case DW_IC_CLR_RX_UNDER:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_RX_OVER:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_RX_OVER;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_TX_OVER:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_TX_OVER;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_RD_REQ:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_RD_REQ;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_TX_ABRT:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_TX_ABRT;
+        s->reg_tx_abrt_source = 0;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_RX_DONE:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_RX_DONE;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_ACTIVITY:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_ACTIVITY;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_STOP_DET:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_STOP_DET;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_CLR_START_DET:
+        s->reg_raw_intr_stat &= ~DW_IC_INTR_START_DET;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_ENABLE:
+        val = s->reg_enable;
+        break;
+    case DW_IC_STATUS:
+        val = s->reg_status;
+        break;
+    case DW_IC_TXFLR:
+        val = s->reg_txflr;
+        break;
+    case DW_IC_RXFLR:
+        s->reg_rxflr = fifo8_num_used(&s->rx_fifo);
+        val = s->reg_rxflr;
+        break;
+    case DW_IC_SDA_HOLD:
+        val = s->reg_sda_hold;
+        break;
+    case DW_IC_TX_ABRT_SOURCE:
+        val = s->reg_tx_abrt_source;
+        break;
+    case DW_IC_ENABLE_STATUS:
+        val = s->reg_enable_status;
+        break;
+    case DW_IC_COMP_PARAM_1:
+        val = s->reg_comp_param_1;
+        break;
+    case DW_IC_COMP_VERSION:
+        val = s->reg_comp_param_ver;
+        break;
+    case DW_IC_COMP_TYPE:
+        val = s->reg_comp_type_num;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad read addr at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_DW_I2C, __func__, offset);
+        break;
+    }
+
+    trace_dw_i2c_read(DEVICE(s)->canonical_path, dw_i2c_get_regname(offset),
+                      offset, val);
+
+    return (uint64_t)val;
+}
+
+static void dw_i2c_write_con(DWI2CState *s, uint32_t val)
+{
+    if (!(s->reg_enable & DW_IC_ENABLE_ENABLE)) {
+        s->reg_con = val;
+    }
+}
+
+static void dw_i2c_write_tar(DWI2CState *s, uint32_t val)
+{
+    /* 10 bit address mode not support in current I2C bus core */
+    if (val & DW_IC_TAR_10BITADDR_MASTER) {
+        qemu_log_mask(LOG_UNIMP, "[%s]%s: 10 bit addr not implemented\n",
+                      TYPE_DW_I2C, __func__);
+        return;
+    }
+
+    if (!(s->reg_enable & DW_IC_ENABLE_ENABLE)) {
+        /*
+         * DesignWare I2C controller uses r/w bit in DW_IC_DATA_CMD
+         * to indicate r/w operation, so linux driver will not set
+         * the r/w bit in DW_IC_TAR, this value is the final slave
+         * address on the I2C bus.
+         */
+        s->reg_tar = val;
+        s->addr_mask = 0x7f;
+    }
+}
+
+static void dw_i2c_write_data_cmd(DWI2CState *s, uint32_t val)
+{
+    bool no_ack = false;
+    uint8_t byte = val & DW_IC_DATA_CMD_DAT_MASK;
+
+    if (!(s->reg_enable & DW_IC_ENABLE_ENABLE)) {
+        return;
+    }
+
+    if (!s->bus_active) {
+        if (i2c_start_transfer(s->bus, (s->reg_tar & s->addr_mask),
+                               val & DW_IC_DATA_CMD_READ)) {
+            no_ack = true;
+        } else {
+            s->bus_active = true;
+        }
+    }
+
+    if (s->bus_active) {
+        if (val & DW_IC_DATA_CMD_READ) {
+            byte = i2c_recv(s->bus);
+
+            if (fifo8_is_full(&s->rx_fifo)) {
+                s->reg_raw_intr_stat |= DW_IC_INTR_RX_OVER;
+            } else {
+                fifo8_push(&s->rx_fifo, byte);
+
+                if (fifo8_num_used(&s->rx_fifo) >= s->reg_rx_tl) {
+                    s->reg_raw_intr_stat |= DW_IC_INTR_RX_FULL;
+                }
+            }
+        } else {
+            if (i2c_send(s->bus, byte)) {
+                no_ack = true;
+            } else {
+                s->reg_raw_intr_stat |= DW_IC_INTR_TX_EMPTY;
+            }
+        }
+    }
+
+    if (no_ack) {
+        i2c_end_transfer(s->bus);
+        s->bus_active = false;
+        s->reg_raw_intr_stat |= DW_IC_INTR_TX_ABRT;
+        s->reg_tx_abrt_source |= DW_IC_TX_ABRT_7B_ADDR_NOACK;
+    }
+
+    if (val & DW_IC_DATA_CMD_STOP) {
+        i2c_end_transfer(s->bus);
+        s->bus_active = false;
+
+        if (val & DW_IC_DATA_CMD_READ) {
+            s->reg_raw_intr_stat |= DW_IC_INTR_RX_DONE;
+        }
+
+        s->reg_raw_intr_stat |= DW_IC_INTR_STOP_DET;
+    }
+
+    dw_i2c_update_intr(s);
+}
+
+static void dw_i2c_write_enable(DWI2CState *s, uint32_t val)
+{
+    s->reg_enable = val;
+
+    if (s->reg_enable & DW_IC_ENABLE_ENABLE) {
+        if (i2c_scan_bus(s->bus, (s->reg_tar & s->addr_mask), 0,
+                         &s->bus->current_devs)) {
+            s->reg_raw_intr_stat |= DW_IC_INTR_START_DET | DW_IC_INTR_TX_EMPTY |
+                                    DW_IC_INTR_ACTIVITY;
+            s->reg_status |= DW_IC_STATUS_ACTIVITY;
+        } else {
+            s->reg_raw_intr_stat |= DW_IC_INTR_TX_ABRT;
+            s->reg_status &= ~DW_IC_STATUS_ACTIVITY;
+            s->reg_tx_abrt_source |= DW_IC_TX_ABRT_7B_ADDR_NOACK;
+        }
+
+        s->reg_enable_status |= DW_IC_ENABLE_STATUS_EN;
+    } else {
+        i2c_end_transfer(s->bus);
+        fifo8_reset(&s->rx_fifo);
+
+        s->addr_mask = 0;
+        s->bus_active = false;
+        s->reg_status = 0;
+        s->reg_enable_status = 0;
+        s->reg_raw_intr_stat  = 0;
+    }
+
+    dw_i2c_update_intr(s);
+}
+
+static void dw_i2c_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    DWI2CState *s = DW_I2C(opaque);
+    uint32_t val = value & 0xffffffff;
+
+    trace_dw_i2c_write(DEVICE(s)->canonical_path, dw_i2c_get_regname(offset),
+                       offset, val);
+
+    switch (offset) {
+    case DW_IC_CON:
+        dw_i2c_write_con(s, val);
+        break;
+    case DW_IC_TAR:
+        dw_i2c_write_tar(s, val);
+        break;
+    case DW_IC_SAR:
+        qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented\n",
+                      TYPE_DW_I2C, __func__);
+        break;
+    case DW_IC_DATA_CMD:
+        dw_i2c_write_data_cmd(s, val);
+        break;
+    case DW_IC_SS_SCL_HCNT:
+        s->reg_ss_scl_hcnt = val;
+        break;
+    case DW_IC_SS_SCL_LCNT:
+        s->reg_ss_scl_lcnt = val;
+        break;
+    case DW_IC_FS_SCL_HCNT:
+        s->reg_fs_scl_hcnt = val;
+        break;
+    case DW_IC_FS_SCL_LCNT:
+        s->reg_fs_scl_lcnt = val;
+        break;
+    case DW_IC_INTR_MASK:
+        s->reg_intr_mask = val;
+        dw_i2c_update_intr(s);
+        break;
+    case DW_IC_RX_TL:
+        s->reg_rx_tl = val;
+        break;
+    case DW_IC_TX_TL:
+        s->reg_tx_tl = val;
+        break;
+    case DW_IC_SDA_HOLD:
+        s->reg_sda_hold = val;
+        break;
+    case DW_IC_ENABLE:
+        dw_i2c_write_enable(s, val);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad write addr at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_DW_I2C, __func__, offset);
+        break;
+    }
+}
+
+static void dw_i2c_reset(DeviceState *dev)
+{
+    DWI2CState *s = DW_I2C(dev);
+    s->bus_active = false;
+    s->addr_mask = 0;
+    fifo8_reset(&s->rx_fifo);
+
+    s->reg_con = 0;
+    s->reg_tar = 0;
+    s->reg_ss_scl_hcnt = 0;
+    s->reg_ss_scl_lcnt = 0;
+    s->reg_fs_scl_hcnt = 0;
+    s->reg_fs_scl_lcnt = 0;
+    s->reg_intr_stat = 0;
+    s->reg_intr_mask = 0;
+    s->reg_raw_intr_stat = 0;
+    s->reg_rx_tl = 0;
+    s->reg_tx_tl = 0;
+    s->reg_enable = 0;
+    s->reg_status = 0;
+    s->reg_txflr = 0;
+    s->reg_rxflr = 0;
+    s->reg_tx_abrt_source = 0;
+    s->reg_enable_status = 0;
+    s->reg_comp_param_1 = DW_IC_COMP_PARAM_1_VALUE;
+    s->reg_comp_param_ver = DW_IC_SDA_HOLD_MIN_VERS;
+    s->reg_comp_type_num = DW_IC_COMP_TYPE_VALUE;
+}
+
+static const MemoryRegionOps dw_i2c_ops = {
+    .read = dw_i2c_read,
+    .write = dw_i2c_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription dw_i2c_vmstate = {
+    .name = TYPE_DW_I2C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FIFO8(rx_fifo, DWI2CState),
+        VMSTATE_BOOL(bus_active, DWI2CState),
+        VMSTATE_UINT32(addr_mask, DWI2CState),
+        VMSTATE_UINT32(reg_con, DWI2CState),
+        VMSTATE_UINT32(reg_tar, DWI2CState),
+        VMSTATE_UINT32(reg_ss_scl_hcnt, DWI2CState),
+        VMSTATE_UINT32(reg_ss_scl_lcnt, DWI2CState),
+        VMSTATE_UINT32(reg_fs_scl_hcnt, DWI2CState),
+        VMSTATE_UINT32(reg_fs_scl_lcnt, DWI2CState),
+        VMSTATE_UINT32(reg_intr_stat, DWI2CState),
+        VMSTATE_UINT32(reg_intr_mask, DWI2CState),
+        VMSTATE_UINT32(reg_raw_intr_stat, DWI2CState),
+        VMSTATE_UINT32(reg_rx_tl, DWI2CState),
+        VMSTATE_UINT32(reg_tx_tl, DWI2CState),
+        VMSTATE_UINT32(reg_sda_hold, DWI2CState),
+        VMSTATE_UINT32(reg_enable, DWI2CState),
+        VMSTATE_UINT32(reg_status, DWI2CState),
+        VMSTATE_UINT32(reg_txflr, DWI2CState),
+        VMSTATE_UINT32(reg_rxflr, DWI2CState),
+        VMSTATE_UINT32(reg_tx_abrt_source, DWI2CState),
+        VMSTATE_UINT32(reg_enable_status, DWI2CState),
+        VMSTATE_UINT32(reg_comp_param_1, DWI2CState),
+        VMSTATE_UINT32(reg_comp_param_ver, DWI2CState),
+        VMSTATE_UINT32(reg_comp_type_num, DWI2CState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dw_i2c_realize(DeviceState *dev, Error **errp)
+{
+    DWI2CState *s = DW_I2C(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &dw_i2c_ops, s,
+                          TYPE_DW_I2C, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    s->bus = i2c_init_bus(dev, NULL);
+    fifo8_create(&s->rx_fifo, DW_I2C_RX_FIFO_DEPTH);
+}
+
+static void dw_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &dw_i2c_vmstate;
+    device_class_set_legacy_reset(dc, dw_i2c_reset);
+    dc->realize = dw_i2c_realize;
+    dc->desc = "DesignWare I2C controller";
+}
+
+static const TypeInfo dw_i2c_type_info = {
+    .name = TYPE_DW_I2C,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DWI2CState),
+    .class_init = dw_i2c_class_init,
+};
+
+static void dw_i2c_register_types(void)
+{
+    type_register_static(&dw_i2c_type_info);
+}
+
+type_init(dw_i2c_register_types)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..fb92df0b69 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -7,6 +7,7 @@ i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
 i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
 i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
 i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
+i2c_ss.add(when: 'CONFIG_DW_I2C', if_true: files('dw_i2c.c'))
 i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
 i2c_ss.add(when: 'CONFIG_ALLWINNER_I2C', if_true: files('allwinner-i2c.c'))
 i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 1ad0e95c0e..5f65755a4e 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -61,3 +61,7 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
 
 imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
 imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
+
+# dw_i2c.c
+dw_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
+dw_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
diff --git a/include/hw/i2c/dw_i2c.h b/include/hw/i2c/dw_i2c.h
new file mode 100644
index 0000000000..512c749f21
--- /dev/null
+++ b/include/hw/i2c/dw_i2c.h
@@ -0,0 +1,151 @@
+/*
+ *  DesignWare I2C Bus Serial Interface Emulation
+ *
+ *  Copyright (C) 2026 Alano Song <AlanoSong@163.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef DW_I2C_H
+#define DW_I2C_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+
+#define TYPE_DW_I2C "dw.i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(DWI2CState, DW_I2C)
+
+#define DW_I2C_TX_FIFO_DEPTH        16
+#define DW_I2C_RX_FIFO_DEPTH        16
+
+#define DW_IC_CON                   0x00
+#define DW_IC_TAR                   0x04
+#define DW_IC_SAR                   0x08
+#define DW_IC_DATA_CMD              0x10
+#define DW_IC_SS_SCL_HCNT           0x14
+#define DW_IC_SS_SCL_LCNT           0x18
+#define DW_IC_FS_SCL_HCNT           0x1c
+#define DW_IC_FS_SCL_LCNT           0x20
+#define DW_IC_INTR_STAT             0x2c
+#define DW_IC_INTR_MASK             0x30
+#define DW_IC_RAW_INTR_STAT         0x34
+#define DW_IC_RX_TL                 0x38
+#define DW_IC_TX_TL                 0x3c
+#define DW_IC_CLR_INTR              0x40
+#define DW_IC_CLR_RX_UNDER          0x44
+#define DW_IC_CLR_RX_OVER           0x48
+#define DW_IC_CLR_TX_OVER           0x4c
+#define DW_IC_CLR_RD_REQ            0x50
+#define DW_IC_CLR_TX_ABRT           0x54
+#define DW_IC_CLR_RX_DONE           0x58
+#define DW_IC_CLR_ACTIVITY          0x5c
+#define DW_IC_CLR_STOP_DET          0x60
+#define DW_IC_CLR_START_DET         0x64
+#define DW_IC_CLR_GEN_CALL          0x68
+#define DW_IC_ENABLE                0x6c
+#define DW_IC_STATUS                0x70
+#define DW_IC_TXFLR                 0x74
+#define DW_IC_RXFLR                 0x78
+#define DW_IC_SDA_HOLD              0x7c
+#define DW_IC_TX_ABRT_SOURCE        0x80
+#define DW_IC_ENABLE_STATUS         0x9c
+#define DW_IC_COMP_PARAM_1          0xf4
+#define DW_IC_COMP_VERSION          0xf8
+#define DW_IC_COMP_TYPE             0xfc
+
+#define DW_IC_CON_MASTER            BIT(0)
+#define DW_IC_CON_SPEED_STANDARD    (0x1 << 1)
+#define DW_IC_CON_SPEED_FAST        (0x2 << 1)
+#define DW_IC_CON_SPEED_HIGH        (0x3 << 1)
+#define DW_IC_CON_RESTART_EN        BIT(5)
+
+#define DW_IC_TAR_10BITADDR_MASTER  BIT(12)
+
+#define DW_IC_DATA_CMD_DAT_MASK     0xff
+#define DW_IC_DATA_CMD_READ         BIT(8)
+#define DW_IC_DATA_CMD_STOP         BIT(9)
+#define DW_IC_DATA_CMD_RESTART      BIT(10)
+
+#define DW_IC_INTR_RX_UNDER         BIT(0)
+#define DW_IC_INTR_RX_OVER          BIT(1)
+#define DW_IC_INTR_RX_FULL          BIT(2)
+#define DW_IC_INTR_TX_OVER          BIT(3)
+#define DW_IC_INTR_TX_EMPTY         BIT(4)
+#define DW_IC_INTR_RD_REQ           BIT(5)
+#define DW_IC_INTR_TX_ABRT          BIT(6)
+#define DW_IC_INTR_RX_DONE          BIT(7)
+#define DW_IC_INTR_ACTIVITY         BIT(8)
+#define DW_IC_INTR_STOP_DET         BIT(9)
+#define DW_IC_INTR_START_DET        BIT(10)
+
+#define DW_IC_ENABLE_ENABLE         BIT(0)
+#define DW_IC_ENABLE_ABORT          BIT(1)
+
+#define DW_IC_STATUS_ACTIVITY           BIT(0)
+#define DW_IC_STATUS_TFNF               BIT(1)
+#define DW_IC_STATUS_TFE                BIT(2)
+#define DW_IC_STATUS_RFNE               BIT(3)
+#define DW_IC_STATUS_RFF                BIT(4)
+#define DW_IC_STATUS_MASTER_ACTIVITY    BIT(5)
+
+#define DW_IC_TX_ABRT_7B_ADDR_NOACK     BIT(0)
+
+#define DW_IC_ENABLE_STATUS_EN          BIT(0)
+
+#define DW_IC_COMP_PARAM_1_SPEED_MODE_FAST (0x2 << 2)
+#define DW_IC_COMP_PARAM_1_VALUE (((DW_I2C_TX_FIFO_DEPTH  - 1) & 0xff) << 16 | \
+                                  ((DW_I2C_RX_FIFO_DEPTH - 1) & 0xff) << 8 | \
+                                  DW_IC_COMP_PARAM_1_SPEED_MODE_FAST)
+#define DW_IC_SDA_HOLD_MIN_VERS 0x3131312a /* "111*" == v1.11* */
+#define DW_IC_COMP_TYPE_VALUE   0x44570140 /* "DW" + 0x0140 */
+
+typedef struct DWI2CState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+    I2CBus *bus;
+
+    bool bus_active;
+    Fifo8 rx_fifo;
+    uint32_t addr_mask;
+
+    uint32_t reg_con;
+    uint32_t reg_tar;
+    uint32_t reg_ss_scl_hcnt;
+    uint32_t reg_ss_scl_lcnt;
+    uint32_t reg_fs_scl_hcnt;
+    uint32_t reg_fs_scl_lcnt;
+    uint32_t reg_intr_stat;
+    uint32_t reg_intr_mask;
+    uint32_t reg_raw_intr_stat;
+    uint32_t reg_rx_tl;
+    uint32_t reg_tx_tl;
+    uint32_t reg_sda_hold;
+    uint32_t reg_enable;
+    uint32_t reg_status;
+    uint32_t reg_txflr;
+    uint32_t reg_rxflr;
+    uint32_t reg_tx_abrt_source;
+    uint32_t reg_enable_status;
+    uint32_t reg_comp_param_1;
+    uint32_t reg_comp_param_ver;
+    uint32_t reg_comp_type_num;
+} DWI2CState;
+
+#endif /* DW_I2C_H */
-- 
2.43.0


