Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC55CD043A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05W-0005AC-JI; Tue, 06 Jan 2026 00:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05K-0004zT-Q0
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05E-0001sK-VM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:25 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a137692691so7345595ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679099; x=1768283899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSbF+s6yzcs087EBgGn3FHKqG++DkiGOuINAlqNMg8w=;
 b=lIRpAkB+1nm9iwgfHpmgytNcfjsJGbcsv4OPFX7b43JrKiJbqLnw2kpQJ8np+J18Hs
 2RuHUIH+AiTflYCurSbUPmbOiDXPa6LPy5zR9gfv248nF5WGrtRxn0lkMBlNvDZikbEA
 0cnbRHRY6YEXqOCNfdILGMyuK7Xc+9fc5MfHSy1ydq10xAwu6T6iwJlRX1vu3ZKE0acB
 NET5fXB38sgxRKrDAd8wdmqneH6pR4AuYyDgjCxwwCTNTEf28t5c2H4fKw4b/BNOxmOf
 hwraOnquVhF1fBb40u1/h4ERSs9GIpWj++AmSlGgn6D6SB8/GuaWgXO/ri+REhAreVqh
 MtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679099; x=1768283899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSbF+s6yzcs087EBgGn3FHKqG++DkiGOuINAlqNMg8w=;
 b=DTucXStoeExwRdNz0PH1Hg95S7qCSt6LSpT0yW4dr/J/WeCBf9fzWjr1rRHOASXaRC
 dzk+Xhfy2GEMAphKuGyFDqoX2BnpeWvIRCcUr9xDRmAAoMHCPC1yCOeT2R5Ibj22ETh8
 rAjAwgjcYfr+y+G8HMXs0H7oDutp0sk2QAkwwiKc84BBLhKGvKMbbDyvpf+YJdCgYkhB
 M9c2M5e4az5EYH9r0v5ZwblfqSjKOh+DFDhB1wZ2fZcx6BXf7jW+LIf0G8cbBXA7pl/2
 XvSHpcQqA+ERfaLwm8g4NRLF4YuUriBD5T0NLYjYgNLpNHRMUkHGwOXOXJ1fWWFOXlpC
 rsHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRcwrFxel+rAtfnRC9zl+mdAh8OrquP2K7qreTM1BuEn6zBEecmGuUS7GXn0OyxJLAG/QDJtkOh5T5@nongnu.org
X-Gm-Message-State: AOJu0Yy0lLyzxNmyrYJzH2M3WFmGkO0kzLZKaCBcO+X/19oxsH33yJhy
 As3uXG59c2z2W6E5ZinkaeiH+yA4Fi6FxIJ5cIrcKDHOFY0Mxfj1na9l
X-Gm-Gg: AY/fxX5UywBGNwasM97Xpc+RfTPcpl9ws+HLvQiHDES5v9hPhNJuZQkDEmz9zNyTrzx
 /NHCSt7ZLMmcff/ErN4W/L4JIEjfZx600JLLaH4EZYTTrB88iOwmmohon6E6wA1zcSouhAc7sCK
 cug5f4RLKgVOV7Dzmh64XD5ESr+0N7WES+kaqFwFE+VuR3uDl7BLSseJwExyq3GRLHVUdqJTW6u
 Fmyj5c4BAU990a3fUXz0rVTX0TWZy5WO4TLUqdwC0YkhJjIyOyE/sk80TzqV3G21Mve6nkRhDwf
 wcnYYaFx+TvFY84A7BjtlRSsZaDxLrfX5OkxYo1kW+AzOY9DpljLwhNGJY8d0fXIhA+ieMhxtoK
 76qxAkBl3Ae7U0pRYBBmDd7eZuP6YJY715saJyHOEFFFW4wVBLVhu/0oZ0m28YkkMgkNWywkrRj
 G2tvWLKRAVLlzbdvnsWV/k
X-Google-Smtp-Source: AGHT+IF4qodopjk6PFw5rbJ202506nx8aKjEYl7HLpopqcoxS3dWOgxDdOCnEV/dpxWqtD2Cy8KuTw==
X-Received: by 2002:a17:903:1cc:b0:2a1:325b:2cba with SMTP id
 d9443c01a7336-2a3e2e1e6b0mr19757855ad.53.1767679099079; 
 Mon, 05 Jan 2026 21:58:19 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:18 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Chris Rauer <crauer@google.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH 11/16] hw/i2c: Add designware i2c controller
Date: Tue,  6 Jan 2026 16:26:51 +1030
Message-ID: <20260106055658.209029-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Chris Rauer <crauer@google.com>

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Chris Rauer <crauer@google.com>
Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
[jms: rebase and minor build fixes for class_init and reset callback]
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                     |   6 +
 include/hw/i2c/designware_i2c.h | 101 ++++
 hw/i2c/designware_i2c.c         | 813 ++++++++++++++++++++++++++++++++
 hw/i2c/Kconfig                  |   4 +
 hw/i2c/meson.build              |   1 +
 5 files changed, 925 insertions(+)
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 hw/i2c/designware_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ece904fedccb..405731900318 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2675,6 +2675,12 @@ S: Orphaned
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
+DesignWare I2C
+M: Chris Rauer <crauer@google.com>
+S: Maintained
+F: hw/i2c/designware_i2c.c
+F: include/hw/i2c/designware_i2c.h
+
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
new file mode 100644
index 000000000000..b44e6e22d65c
--- /dev/null
+++ b/include/hw/i2c/designware_i2c.h
@@ -0,0 +1,101 @@
+/*
+ * DesignWare I2C Module.
+ *
+ * Copyright 2021 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef DESIGNWARE_I2C_H
+#define DESIGNWARE_I2C_H
+
+#include "hw/i2c/i2c.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+
+/* Size of the FIFO buffers. */
+#define DESIGNWARE_I2C_RX_FIFO_SIZE 16
+#define DESIGNWARE_I2C_TX_FIFO_SIZE 16
+
+typedef enum DesignWareI2CStatus {
+    DW_I2C_STATUS_IDLE,
+    DW_I2C_STATUS_SENDING_ADDRESS,
+    DW_I2C_STATUS_SENDING,
+    DW_I2C_STATUS_RECEIVING,
+} DesignWareI2CStatus;
+
+/*
+ * struct DesignWareI2CState - DesignWare I2C device state.
+ * @bus: The underlying I2C Bus
+ * @irq: GIC interrupt line to fire on events
+ * @ic_con: : I2C control register
+ * @ic_tar: I2C target address register
+ * @ic_sar: I2C slave address register
+ * @ic_ss_scl_hcnt: Standard speed i2c clock scl high count register
+ * @ic_ss_scl_lcnt: Standard speed i2c clock scl low count register
+ * @ic_fs_scl_hcnt: Fast mode or fast mode plus i2c clock scl high count
+ *                  register
+ * @ic_fs_scl_lcnt:Fast mode or fast mode plus i2c clock scl low count
+ *                  register
+ * @ic_intr_mask: I2C Interrupt Mask Register
+ * @ic_raw_intr_stat: I2C raw interrupt status register
+ * @ic_rx_tl: I2C receive FIFO threshold register
+ * @ic_tx_tl: I2C transmit FIFO threshold register
+ * @ic_enable: I2C enable register
+ * @ic_status: I2C status register
+ * @ic_txflr: I2C transmit fifo level register
+ * @ic_rxflr: I2C receive fifo level register
+ * @ic_sda_hold: I2C SDA hold time length register
+ * @ic_tx_abrt_source: The I2C transmit abort source register
+ * @ic_sda_setup: I2C SDA setup register
+ * @ic_enable_status: I2C enable status register
+ * @ic_fs_spklen: I2C SS, FS or FM+ spike suppression limit
+ * @ic_comp_param_1: Component parameter register
+ * @ic_comp_version: I2C component version register
+ * @ic_comp_type: I2C component type register
+ * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
+ * @rx_cur: The current position of rx_fifo.
+ * @status: The current status of the SMBus.
+ */
+typedef struct DesignWareI2CState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    I2CBus      *bus;
+    qemu_irq     irq;
+
+    uint32_t ic_con;
+    uint32_t ic_tar;
+    uint32_t ic_sar;
+    uint32_t ic_ss_scl_hcnt;
+    uint32_t ic_ss_scl_lcnt;
+    uint32_t ic_fs_scl_hcnt;
+    uint32_t ic_fs_scl_lcnt;
+    uint32_t ic_intr_mask;
+    uint32_t ic_raw_intr_stat;
+    uint32_t ic_rx_tl;
+    uint32_t ic_tx_tl;
+    uint32_t ic_enable;
+    uint32_t ic_status;
+    uint32_t ic_txflr;
+    uint32_t ic_rxflr;
+    uint32_t ic_sda_hold;
+    uint32_t ic_tx_abrt_source;
+    uint32_t ic_sda_setup;
+    uint32_t ic_enable_status;
+    uint32_t ic_fs_spklen;
+    uint32_t ic_comp_param_1;
+    uint32_t ic_comp_version;
+    uint32_t ic_comp_type;
+
+    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
+    uint8_t      rx_cur;
+
+    DesignWareI2CStatus status;
+} DesignWareI2CState;
+
+#define TYPE_DESIGNWARE_I2C "designware-i2c"
+#define DESIGNWARE_I2C(obj) OBJECT_CHECK(DesignWareI2CState, (obj), \
+                                        TYPE_DESIGNWARE_I2C)
+
+#endif /* DESIGNWARE_I2C_H */
diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
new file mode 100644
index 000000000000..2e808f61f050
--- /dev/null
+++ b/hw/i2c/designware_i2c.c
@@ -0,0 +1,813 @@
+/*
+ * DesignWare I2C Module.
+ *
+ * Copyright 2021 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/i2c/designware_i2c.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+enum DesignWareI2CRegister {
+    DW_IC_CON                   = 0x00,
+    DW_IC_TAR                   = 0x04,
+    DW_IC_SAR                   = 0x08,
+    DW_IC_DATA_CMD              = 0x10,
+    DW_IC_SS_SCL_HCNT           = 0x14,
+    DW_IC_SS_SCL_LCNT           = 0x18,
+    DW_IC_FS_SCL_HCNT           = 0x1c,
+    DW_IC_FS_SCL_LCNT           = 0x20,
+    DW_IC_INTR_STAT             = 0x2c,
+    DW_IC_INTR_MASK             = 0x30,
+    DW_IC_RAW_INTR_STAT         = 0x34,
+    DW_IC_RX_TL                 = 0x38,
+    DW_IC_TX_TL                 = 0x3c,
+    DW_IC_CLR_INTR              = 0x40,
+    DW_IC_CLR_RX_UNDER          = 0x44,
+    DW_IC_CLR_RX_OVER           = 0x48,
+    DW_IC_CLR_TX_OVER           = 0x4c,
+    DW_IC_CLR_RD_REQ            = 0x50,
+    DW_IC_CLR_TX_ABRT           = 0x54,
+    DW_IC_CLR_RX_DONE           = 0x58,
+    DW_IC_CLR_ACTIVITY          = 0x5c,
+    DW_IC_CLR_STOP_DET          = 0x60,
+    DW_IC_CLR_START_DET         = 0x64,
+    DW_IC_CLR_GEN_CALL          = 0x68,
+    DW_IC_ENABLE                = 0x6c,
+    DW_IC_STATUS                = 0x70,
+    DW_IC_TXFLR                 = 0x74,
+    DW_IC_RXFLR                 = 0x78,
+    DW_IC_SDA_HOLD              = 0x7c,
+    DW_IC_TX_ABRT_SOURCE        = 0x80,
+    DW_IC_SLV_DATA_NACK_ONLY    = 0x84,
+    DW_IC_DMA_CR                = 0x88,
+    DW_IC_DMA_TDLR              = 0x8c,
+    DW_IC_DMA_RDLR              = 0x90,
+    DW_IC_SDA_SETUP             = 0x94,
+    DW_IC_ACK_GENERAL_CALL      = 0x98,
+    DW_IC_ENABLE_STATUS         = 0x9c,
+    DW_IC_FS_SPKLEN             = 0xa0,
+    DW_IC_CLR_RESTART_DET       = 0xa8,
+    DW_IC_COMP_PARAM_1          = 0xf4,
+    DW_IC_COMP_VERSION          = 0xf8,
+    DW_IC_COMP_TYPE             = 0xfc,
+};
+
+/* DW_IC_CON fields */
+#define DW_IC_CON_STOP_DET_IF_MASTER_ACTIV  BIT(10)
+#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9)
+#define DW_IC_CON_TX_EMPTY_CTRL             BIT(8)
+#define DW_IC_CON_STOP_IF_ADDRESSED         BIT(7)
+#define DW_IC_CON_SLAVE_DISABLE             BIT(6)
+#define DW_IC_CON_IC_RESTART_EN             BIT(5)
+#define DW_IC_CON_10BITADDR_MASTER          BIT(4)
+#define DW_IC_CON_10BITADDR_SLAVE           BIT(3)
+#define DW_IC_CON_SPEED(rv)                 extract32((rv), 1, 2)
+#define DW_IC_CON_MASTER_MODE               BIT(0)
+
+/* DW_IC_TAR fields */
+#define DW_IC_TAR_IC_10BITADDR_MASTER  BIT(12)
+#define DW_IC_TAR_SPECIAL              BIT(11)
+#define DW_IC_TAR_GC_OR_START          BIT(10)
+#define DW_IC_TAR_ADDRESS(rv)          extract32((rv), 0, 10)
+
+/* DW_IC_DATA_CMD fields */
+#define DW_IC_DATA_CMD_RESTART  BIT(10)
+#define DW_IC_DATA_CMD_STOP     BIT(9)
+#define DW_IC_DATA_CMD_CMD      BIT(8)
+#define DW_IC_DATA_CMD_DAT(rv)  extract32((rv), 0, 8)
+
+/* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
+#define DW_IC_INTR_RESTART_DET  BIT(12)
+#define DW_IC_INTR_GEN_CALL     BIT(11)
+#define DW_IC_INTR_START_DET    BIT(10)
+#define DW_IC_INTR_STOP_DET     BIT(9)
+#define DW_IC_INTR_ACTIVITY     BIT(8)
+#define DW_IC_INTR_RX_DONE      BIT(7)
+#define DW_IC_INTR_TX_ABRT      BIT(6)
+#define DW_IC_INTR_RD_REQ       BIT(5)
+#define DW_IC_INTR_TX_EMPTY     BIT(4) /* Hardware clear only. */
+#define DW_IC_INTR_TX_OVER      BIT(3)
+#define DW_IC_INTR_RX_FULL      BIT(2) /* Hardware clear only. */
+#define DW_IC_INTR_RX_OVER      BIT(1)
+#define DW_IC_INTR_RX_UNDER     BIT(0)
+
+/* DW_IC_ENABLE fields */
+#define DW_IC_ENABLE_TX_CMD_BLOCK  BIT(2)
+#define DW_IC_ENABLE_ABORT         BIT(1)
+#define DW_IC_ENABLE_ENABLE        BIT(0)
+
+/* DW_IC_STATUS fields */
+#define DW_IC_STATUS_SLV_ACTIVITY  BIT(6)
+#define DW_IC_STATUS_MST_ACTIVITY  BIT(5)
+#define DW_IC_STATUS_RFF           BIT(4)
+#define DW_IC_STATUS_RFNE          BIT(3)
+#define DW_IC_STATUS_TFE           BIT(2)
+#define DW_IC_STATUS_TFNF          BIT(1)
+#define DW_IC_STATUS_ACTIVITY      BIT(0)
+
+/* DW_IC_TX_ABRT_SOURCE fields */
+#define DW_IC_TX_TX_FLUSH_CNT          extract32((rv), 23, 9)
+#define DW_IC_TX_ABRT_USER_ABRT        BIT(16)
+#define DW_IC_TX_ABRT_SLVRD_INTX       BIT(15)
+#define DW_IC_TX_ABRT_SLV_ARBLOST      BIT(14)
+#define DW_IC_TX_ABRT_SLVFLUSH_TXFIFO  BIT(13)
+#define DW_IC_TX_ARB_LOST              BIT(12)
+#define DW_IC_TX_ABRT_MASTER_DIS       BIT(11)
+#define DW_IC_TX_ABRT_10B_RD_NORSTRT   BIT(10)
+#define DW_IC_TX_ABRT_SBYTE_NORSTRT    BIT(9)
+#define DW_IC_TX_ABRT_HS_NORSTRT       BIT(8)
+#define DW_IC_TX_ABRT_SBYTE_ACKDET     BIT(7)
+#define DW_IC_TX_ABRT_HS_ACKDET        BIT(6)
+#define DW_IC_TX_ABRT_GCALL_READ       BIT(5)
+#define DW_IC_TX_ABRT_GCALL_NOACK      BIT(4)
+#define DW_IC_TX_ABRT_TXDATA_NOACK     BIT(3)
+#define DW_IC_TX_ABRT_10ADDR2_NOACK    BIT(2)
+#define DW_IC_TX_ABRT_10ADDR1_NOACK    BIT(1)
+#define DW_IC_TX_ABRT_7B_ADDR_NOACK    BIT(0)
+
+
+/* IC_ENABLE_STATUS fields */
+#define DW_IC_ENABLE_STATUS_SLV_RX_DATA_LOST         BIT(2)
+#define DW_IC_ENABLE_STATUS_SLV_DISABLED_WHILE_BUSY  BIT(1)
+#define DW_IC_ENABLE_STATUS_IC_EN                    BIT(0)
+
+/* Masks for writable registers. */
+#define DW_IC_CON_MASK          0x000003ff
+#define DW_IC_TAR_MASK          0x00000fff
+#define DW_IC_SAR_MASK          0x000003ff
+#define DW_IC_SS_SCL_HCNT_MASK  0x0000ffff
+#define DW_IC_SS_SCL_LCNT_MASK  0x0000ffff
+#define DW_IC_FS_SCL_HCNT_MASK  0x0000ffff
+#define DW_IC_FS_SCL_LCNT_MASK  0x0000ffff
+#define DW_IC_INTR_MASK_MASK    0x00001fff
+#define DW_IC_ENABLE_MASK       0x00000007
+#define DW_IC_SDA_HOLD_MASK     0x00ffffff
+#define DW_IC_SDA_SETUP_MASK    0x000000ff
+#define DW_IC_FS_SPKLEN_MASK    0x000000ff
+
+/* Reset values */
+#define DW_IC_CON_INIT_VAL          0x7d
+#define DW_IC_TAR_INIT_VAL          0x1055
+#define DW_IC_SAR_INIT_VAL          0x55
+#define DW_IC_SS_SCL_HCNT_INIT_VAL  0x190
+#define DW_IC_SS_SCL_LCNT_INIT_VAL  0x1d6
+#define DW_IC_FS_SCL_HCNT_INIT_VAL  0x3c
+#define DW_IC_FS_SCL_LCNT_INIT_VAL  0x82
+#define DW_IC_INTR_MASK_INIT_VAL    0x8ff
+#define DW_IC_STATUS_INIT_VAL       0x6
+#define DW_IC_SDA_HOLD_INIT_VAL     0x1
+#define DW_IC_SDA_SETUP_INIT_VAL    0x64
+#define DW_IC_FS_SPKLEN_INIT_VAL    0x2
+
+#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
+#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disabled. */
+#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
+#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
+#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
+#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
+#define DW_IC_COMP_PARAM_1_INIT_VAL             \
+    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
+    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
+    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
+    DW_IC_COMP_PARAM_1_INTR_IO | \
+    DW_IC_COMP_PARAM_1_HAS_DMA | \
+    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
+    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
+    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
+#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
+#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
+
+static void dw_i2c_update_irq(DesignWareI2CState *s)
+{
+    int level;
+    uint32_t intr = s->ic_raw_intr_stat & s->ic_intr_mask;
+
+    level = !!((intr & DW_IC_INTR_RX_UNDER) |
+        (intr & DW_IC_INTR_RX_OVER) |
+        (intr & DW_IC_INTR_RX_FULL) |
+        (intr & DW_IC_INTR_TX_OVER) |
+        (intr & DW_IC_INTR_TX_EMPTY) |
+        (intr & DW_IC_INTR_RD_REQ) |
+        (intr & DW_IC_INTR_TX_ABRT) |
+        (intr & DW_IC_INTR_RX_DONE) |
+        (intr & DW_IC_INTR_ACTIVITY) |
+        (intr & DW_IC_INTR_STOP_DET) |
+        (intr & DW_IC_INTR_START_DET) |
+        (intr & DW_IC_INTR_GEN_CALL) |
+        (intr & DW_IC_INTR_RESTART_DET)
+        );
+    qemu_set_irq(s->irq, level);
+}
+
+static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
+{
+    uint32_t value = s->rx_fifo[s->rx_cur];
+
+    if (s->status != DW_I2C_STATUS_RECEIVING) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Attempted to read from RX fifo when not in receive "
+                      "state.\n", DEVICE(s)->canonical_path);
+        if (s->status != DW_I2C_STATUS_IDLE) {
+            s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+            dw_i2c_update_irq(s);
+        }
+        return 0;
+    }
+
+    s->rx_cur = (s->rx_cur + 1) % DESIGNWARE_I2C_RX_FIFO_SIZE;
+
+    if (s->ic_rxflr > 0) {
+        s->ic_rxflr--;
+    } else {
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+        dw_i2c_update_irq(s);
+        return 0;
+    }
+
+    if (s->ic_rxflr <= s->ic_rx_tl) {
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_FULL;
+        dw_i2c_update_irq(s);
+    }
+
+    return value;
+}
+
+static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = 0;
+
+    DesignWareI2CState *s = opaque;
+
+    switch (offset) {
+    case DW_IC_CON:
+        value = s->ic_con;
+        break;
+    case DW_IC_TAR:
+        value = s->ic_tar;
+        break;
+    case DW_IC_SAR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_sar\n",
+                      DEVICE(s)->canonical_path);
+        value = s->ic_sar;
+        break;
+    case DW_IC_DATA_CMD:
+        value = dw_i2c_read_ic_data_cmd(s);
+        break;
+    case DW_IC_SS_SCL_HCNT:
+        value = s->ic_ss_scl_hcnt;
+        break;
+    case DW_IC_SS_SCL_LCNT:
+        value = s->ic_ss_scl_lcnt;
+        break;
+    case DW_IC_FS_SCL_HCNT:
+        value = s->ic_fs_scl_hcnt;
+        break;
+    case DW_IC_FS_SCL_LCNT:
+        value = s->ic_fs_scl_lcnt;
+        break;
+    case DW_IC_INTR_STAT:
+        value = s->ic_raw_intr_stat & s->ic_intr_mask;
+        break;
+    case DW_IC_INTR_MASK:
+        value = s->ic_intr_mask;
+        break;
+    case DW_IC_RAW_INTR_STAT:
+        value = s->ic_raw_intr_stat;
+        break;
+    case DW_IC_RX_TL:
+        value = s->ic_rx_tl;
+        break;
+    case DW_IC_TX_TL:
+        value = s->ic_tx_tl;
+        break;
+    case DW_IC_CLR_INTR:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_GEN_CALL |
+            DW_IC_INTR_RESTART_DET |
+            DW_IC_INTR_START_DET |
+            DW_IC_INTR_STOP_DET |
+            DW_IC_INTR_ACTIVITY |
+            DW_IC_INTR_RX_DONE |
+            DW_IC_INTR_TX_ABRT |
+            DW_IC_INTR_RD_REQ |
+            DW_IC_INTR_TX_OVER |
+            DW_IC_INTR_RX_OVER |
+            DW_IC_INTR_RX_UNDER);
+        s->ic_tx_abrt_source = 0;
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_RX_UNDER:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_RX_UNDER);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_RX_OVER:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_RX_OVER);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_TX_OVER:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_TX_OVER);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_RD_REQ:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_RD_REQ);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_TX_ABRT:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_TX_ABRT);
+        s->ic_tx_abrt_source = 0;
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_RX_DONE:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_RX_DONE);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_ACTIVITY:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_ACTIVITY);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_STOP_DET:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_STOP_DET);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_START_DET:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_START_DET);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_CLR_GEN_CALL:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_GEN_CALL);
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_ENABLE:
+        value = s->ic_enable;
+        break;
+    case DW_IC_STATUS:
+        value = s->ic_status;
+        break;
+    case DW_IC_TXFLR:
+        value = s->ic_txflr;
+        break;
+    case DW_IC_RXFLR:
+        value = s->ic_rxflr;
+        break;
+    case DW_IC_SDA_HOLD:
+        value = s->ic_sda_hold;
+        break;
+    case DW_IC_TX_ABRT_SOURCE:
+        value = s->ic_tx_abrt_source;
+        break;
+    case DW_IC_SLV_DATA_NACK_ONLY:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unsupported read - ic_slv_data_nack_only\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_CR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_cr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_TDLR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_tdlr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_RDLR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_rdlr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_SDA_SETUP:
+        value = s->ic_sda_setup;
+        break;
+    case DW_IC_ACK_GENERAL_CALL:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_ack_general_call\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_ENABLE_STATUS:
+        value = s->ic_enable_status;
+        break;
+    case DW_IC_FS_SPKLEN:
+        value = s->ic_fs_spklen;
+        break;
+    case DW_IC_CLR_RESTART_DET:
+        s->ic_raw_intr_stat &= ~(DW_IC_INTR_RESTART_DET);
+        break;
+    case DW_IC_COMP_PARAM_1:
+        value = s->ic_comp_param_1;
+        break;
+    case DW_IC_COMP_VERSION:
+        value = s->ic_comp_version;
+        break;
+    case DW_IC_COMP_TYPE:
+        value = s->ic_comp_type;
+        break;
+
+    /* This register is invalid at this point. */
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+
+    return value;
+}
+
+static void dw_i2c_write_ic_con(DesignWareI2CState *s, uint32_t value)
+{
+    if (value & DW_IC_CON_RX_FIFO_FULL_HLD_CTRL) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unsupported ic_con flag - RX_FIFO_FULL_HLD_CTRL\n",
+                      DEVICE(s)->canonical_path);
+    }
+
+    if (!(s->ic_enable & DW_IC_ENABLE_ENABLE)) {
+        s->ic_con = value & DW_IC_CON_MASK;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_con %d when ic_enable[0]==1\n",
+                      DEVICE(s)->canonical_path, value);
+    }
+}
+
+static void dw_i2c_reset_to_idle(DesignWareI2CState *s)
+{
+        s->ic_enable_status &= ~DW_IC_ENABLE_STATUS_IC_EN;
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_TX_EMPTY;
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_FULL;
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_OVER;
+        s->ic_rxflr = 0;
+        s->ic_status &= ~DW_IC_STATUS_ACTIVITY;
+        s->status = DW_I2C_STATUS_IDLE;
+        dw_i2c_update_irq(s);
+}
+
+static void dw_ic_tx_abort(DesignWareI2CState *s, uint32_t src)
+{
+    s->ic_tx_abrt_source |= src;
+    s->ic_raw_intr_stat |= DW_IC_INTR_TX_ABRT;
+    dw_i2c_reset_to_idle(s);
+    dw_i2c_update_irq(s);
+}
+
+static void dw_i2c_write_ic_data_cmd(DesignWareI2CState *s, uint32_t value)
+{
+    int recv = !!(value & DW_IC_DATA_CMD_CMD);
+
+    if (s->status == DW_I2C_STATUS_IDLE ||
+        s->ic_raw_intr_stat & DW_IC_INTR_TX_ABRT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Attempted to write to TX fifo when it is held in "
+                      "reset.\n", DEVICE(s)->canonical_path);
+        return;
+    }
+
+    /* Send the address if it hasn't been sent yet. */
+    if (s->status == DW_I2C_STATUS_SENDING_ADDRESS) {
+        int rv = i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_tar), recv);
+        if (rv) {
+            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
+            return;
+        }
+        s->status = recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SENDING;
+    }
+
+    /* Send data */
+    if (!recv) {
+        int rv = i2c_send(s->bus, DW_IC_DATA_CMD_DAT(value));
+        if (rv) {
+            i2c_end_transfer(s->bus);
+            dw_ic_tx_abort(s, DW_IC_TX_ABRT_TXDATA_NOACK);
+            return;
+        }
+        dw_i2c_update_irq(s);
+    }
+
+    /* Restart command */
+    if (value & DW_IC_DATA_CMD_RESTART && s->ic_con & DW_IC_CON_IC_RESTART_EN) {
+        s->ic_raw_intr_stat |= DW_IC_INTR_RESTART_DET |
+                               DW_IC_INTR_START_DET |
+                               DW_IC_INTR_ACTIVITY;
+        s->ic_status |= DW_IC_STATUS_ACTIVITY;
+        dw_i2c_update_irq(s);
+
+        if (i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_tar), recv)) {
+            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
+            return;
+        }
+
+        s->status = recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SENDING;
+    }
+
+    /* Receive data */
+    if (recv) {
+        uint8_t pos = (s->rx_cur + s->ic_rxflr) % DESIGNWARE_I2C_RX_FIFO_SIZE;
+
+        if (s->ic_rxflr < DESIGNWARE_I2C_RX_FIFO_SIZE) {
+            s->rx_fifo[pos] = i2c_recv(s->bus);
+            s->ic_rxflr++;
+        } else {
+            s->ic_raw_intr_stat |= DW_IC_INTR_RX_OVER;
+            dw_i2c_update_irq(s);
+        }
+
+        if (s->ic_rxflr > s->ic_rx_tl) {
+            s->ic_raw_intr_stat |= DW_IC_INTR_RX_FULL;
+            dw_i2c_update_irq(s);
+        }
+        if (value & DW_IC_DATA_CMD_STOP) {
+            i2c_nack(s->bus);
+        }
+    }
+
+    /* Stop command */
+    if (value & DW_IC_DATA_CMD_STOP) {
+        s->ic_raw_intr_stat |= DW_IC_INTR_STOP_DET;
+        s->ic_status &= ~DW_IC_STATUS_ACTIVITY;
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_TX_EMPTY;
+        i2c_end_transfer(s->bus);
+        dw_i2c_update_irq(s);
+    }
+}
+
+static void dw_i2c_write_ic_enable(DesignWareI2CState *s, uint32_t value)
+{
+    if (value & DW_IC_ENABLE_ENABLE && !(s->ic_con & DW_IC_CON_SLAVE_DISABLE)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Designware I2C slave mode is not supported.\n",
+                      DEVICE(s)->canonical_path);
+        return;
+    }
+
+    s->ic_enable = value & DW_IC_ENABLE_MASK;
+
+    if (value & DW_IC_ENABLE_ABORT || value & DW_IC_ENABLE_TX_CMD_BLOCK) {
+        dw_ic_tx_abort(s, DW_IC_TX_ABRT_USER_ABRT);
+        return;
+    }
+
+    if (value & DW_IC_ENABLE_ENABLE) {
+        s->ic_enable_status |= DW_IC_ENABLE_STATUS_IC_EN;
+        s->ic_status |= DW_IC_STATUS_ACTIVITY;
+        s->ic_raw_intr_stat |= DW_IC_INTR_ACTIVITY |
+                               DW_IC_INTR_START_DET |
+                               DW_IC_INTR_TX_EMPTY;
+        s->status = DW_I2C_STATUS_SENDING_ADDRESS;
+        dw_i2c_update_irq(s);
+    } else if ((value & DW_IC_ENABLE_ENABLE) == 0) {
+        dw_i2c_reset_to_idle(s);
+    }
+
+}
+
+static void dw_i2c_write_ic_rx_tl(DesignWareI2CState *s, uint32_t value)
+{
+    /* Note that a value of 0 for ic_rx_tl indicates a threashold of 1. */
+    if (value > DESIGNWARE_I2C_RX_FIFO_SIZE - 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_rx_tl %d\n",
+                      DEVICE(s)->canonical_path, value);
+        s->ic_rx_tl = DESIGNWARE_I2C_RX_FIFO_SIZE - 1;
+    } else {
+        s->ic_rx_tl = value;
+    }
+
+    if (s->ic_rxflr > s->ic_rx_tl && s->ic_enable & DW_IC_ENABLE_ENABLE) {
+        s->ic_raw_intr_stat |= DW_IC_INTR_RX_FULL;
+    } else {
+        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_FULL;
+    }
+    dw_i2c_update_irq(s);
+}
+
+static void dw_i2c_write_ic_tx_tl(DesignWareI2CState *s, uint32_t value)
+{
+    /*
+     * Note that a value of 0 for ic_tx_tl indicates a threashold of 1.
+     * However, the tx threshold is not used in the model because commands are
+     * always sent out as soon as they are written.
+     */
+    if (value > DESIGNWARE_I2C_TX_FIFO_SIZE - 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_tx_tl %d\n",
+                      DEVICE(s)->canonical_path, value);
+        s->ic_tx_tl = DESIGNWARE_I2C_TX_FIFO_SIZE - 1;
+    } else {
+        s->ic_tx_tl = value;
+    }
+}
+
+static void dw_i2c_write(void *opaque, hwaddr offset, uint64_t value,
+                              unsigned size)
+{
+    DesignWareI2CState *s = opaque;
+
+    /* The order of the registers are their order in memory. */
+    switch (offset) {
+    case DW_IC_CON:
+        dw_i2c_write_ic_con(s, value);
+        break;
+    case DW_IC_TAR:
+        s->ic_tar = value & DW_IC_TAR_MASK;
+        break;
+    case DW_IC_SAR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
+                      DEVICE(s)->canonical_path);
+        s->ic_sar = value & DW_IC_SAR_MASK;
+        break;
+    case DW_IC_DATA_CMD:
+        dw_i2c_write_ic_data_cmd(s, value);
+        break;
+    case DW_IC_SS_SCL_HCNT:
+        s->ic_ss_scl_hcnt = value & DW_IC_SS_SCL_HCNT_MASK;
+        break;
+    case DW_IC_SS_SCL_LCNT:
+        s->ic_ss_scl_lcnt = value & DW_IC_SS_SCL_LCNT_MASK;
+        break;
+    case DW_IC_FS_SCL_HCNT:
+        s->ic_fs_scl_hcnt = value & DW_IC_FS_SCL_HCNT_MASK;
+        break;
+    case DW_IC_FS_SCL_LCNT:
+        s->ic_fs_scl_lcnt = value & DW_IC_FS_SCL_LCNT_MASK;
+        break;
+    case DW_IC_INTR_MASK:
+        s->ic_intr_mask = value & DW_IC_INTR_MASK_MASK;
+        dw_i2c_update_irq(s);
+        break;
+    case DW_IC_RX_TL:
+        dw_i2c_write_ic_rx_tl(s, value);
+        break;
+    case DW_IC_TX_TL:
+        dw_i2c_write_ic_tx_tl(s, value);
+        break;
+    case DW_IC_ENABLE:
+        dw_i2c_write_ic_enable(s, value);
+        break;
+    case DW_IC_SDA_HOLD:
+        s->ic_sda_hold = value & DW_IC_SDA_HOLD_MASK;
+        break;
+    case DW_IC_SLV_DATA_NACK_ONLY:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unsupported write - ic_slv_data_nack_only\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_CR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_cr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_TDLR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_tdlr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_DMA_RDLR:
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_rdlr\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_SDA_SETUP:
+        s->ic_sda_setup = value & DW_IC_SDA_SETUP_MASK;
+        break;
+    case DW_IC_ACK_GENERAL_CALL:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unsupported write - ic_ack_general_call\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case DW_IC_FS_SPKLEN:
+        s->ic_fs_spklen = value & DW_IC_FS_SPKLEN_MASK;
+        break;
+
+    /* This register is invalid at this point. */
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset or readonly register 0x%"
+                      HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps designware_i2c_ops = {
+    .read = dw_i2c_read,
+    .write = dw_i2c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void designware_i2c_enter_reset(Object *obj, ResetType type)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+
+    s->ic_con = DW_IC_CON_INIT_VAL;
+    s->ic_tar = DW_IC_TAR_INIT_VAL;
+    s->ic_sar = DW_IC_SAR_INIT_VAL;
+    s->ic_ss_scl_hcnt = DW_IC_SS_SCL_HCNT_INIT_VAL;
+    s->ic_ss_scl_lcnt = DW_IC_SS_SCL_LCNT_INIT_VAL;
+    s->ic_fs_scl_hcnt = DW_IC_FS_SCL_HCNT_INIT_VAL;
+    s->ic_fs_scl_lcnt = DW_IC_FS_SCL_LCNT_INIT_VAL;
+    s->ic_intr_mask = DW_IC_INTR_MASK_INIT_VAL;
+    s->ic_raw_intr_stat = 0;
+    s->ic_rx_tl = 0;
+    s->ic_tx_tl = 0;
+    s->ic_enable = 0;
+    s->ic_status = DW_IC_STATUS_INIT_VAL;
+    s->ic_txflr = 0;
+    s->ic_rxflr = 0;
+    s->ic_sda_hold = DW_IC_SDA_HOLD_INIT_VAL;
+    s->ic_tx_abrt_source = 0;
+    s->ic_sda_setup = DW_IC_SDA_SETUP_INIT_VAL;
+    s->ic_enable_status = 0;
+    s->ic_fs_spklen = DW_IC_FS_SPKLEN_INIT_VAL;
+    s->ic_comp_param_1 = DW_IC_COMP_PARAM_1_INIT_VAL;
+    s->ic_comp_version = DW_IC_COMP_VERSION_INIT_VAL;
+    s->ic_comp_type = DW_IC_COMP_TYPE_INIT_VAL;
+
+    s->rx_cur = 0;
+    s->status = DW_I2C_STATUS_IDLE;
+}
+
+static void designware_i2c_hold_reset(Object *obj, ResetType type)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+
+    qemu_irq_lower(s->irq);
+}
+
+static const VMStateDescription vmstate_designware_i2c = {
+    .name = TYPE_DESIGNWARE_I2C,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ic_con, DesignWareI2CState),
+        VMSTATE_UINT32(ic_tar, DesignWareI2CState),
+        VMSTATE_UINT32(ic_sar, DesignWareI2CState),
+        VMSTATE_UINT32(ic_ss_scl_hcnt, DesignWareI2CState),
+        VMSTATE_UINT32(ic_ss_scl_lcnt, DesignWareI2CState),
+        VMSTATE_UINT32(ic_fs_scl_hcnt, DesignWareI2CState),
+        VMSTATE_UINT32(ic_fs_scl_lcnt, DesignWareI2CState),
+        VMSTATE_UINT32(ic_intr_mask, DesignWareI2CState),
+        VMSTATE_UINT32(ic_raw_intr_stat, DesignWareI2CState),
+        VMSTATE_UINT32(ic_rx_tl, DesignWareI2CState),
+        VMSTATE_UINT32(ic_tx_tl, DesignWareI2CState),
+        VMSTATE_UINT32(ic_enable, DesignWareI2CState),
+        VMSTATE_UINT32(ic_status, DesignWareI2CState),
+        VMSTATE_UINT32(ic_txflr, DesignWareI2CState),
+        VMSTATE_UINT32(ic_rxflr, DesignWareI2CState),
+        VMSTATE_UINT32(ic_sda_hold, DesignWareI2CState),
+        VMSTATE_UINT32(ic_tx_abrt_source, DesignWareI2CState),
+        VMSTATE_UINT32(ic_sda_setup, DesignWareI2CState),
+        VMSTATE_UINT32(ic_enable_status, DesignWareI2CState),
+        VMSTATE_UINT32(ic_fs_spklen, DesignWareI2CState),
+        VMSTATE_UINT32(ic_comp_param_1, DesignWareI2CState),
+        VMSTATE_UINT32(ic_comp_version, DesignWareI2CState),
+        VMSTATE_UINT32(ic_comp_type, DesignWareI2CState),
+        VMSTATE_UINT32(status, DesignWareI2CState),
+        VMSTATE_UINT8_ARRAY(rx_fifo, DesignWareI2CState,
+                        DESIGNWARE_I2C_RX_FIFO_SIZE),
+        VMSTATE_UINT8(rx_cur, DesignWareI2CState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void designware_i2c_smbus_init(Object *obj)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
+                          "regs", 4 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    s->bus = i2c_init_bus(DEVICE(s), "i2c-bus");
+}
+
+static void designware_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Designware I2C";
+    dc->vmsd = &vmstate_designware_i2c;
+    rc->phases.enter = designware_i2c_enter_reset;
+    rc->phases.hold = designware_i2c_hold_reset;
+}
+
+static const TypeInfo designware_i2c_types[] = {
+    {
+        .name = TYPE_DESIGNWARE_I2C,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(DesignWareI2CState),
+        .class_init = designware_i2c_class_init,
+        .instance_init = designware_i2c_smbus_init,
+    },
+};
+DEFINE_TYPES(designware_i2c_types);
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 596a7a3165ad..d3f394edeb9c 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -18,6 +18,10 @@ config ARM_SBCON_I2C
     bool
     select BITBANG_I2C
 
+config DESIGNWARE_I2C
+    bool
+    select I2C
+
 config ACPI_SMBUS
     bool
     select SMBUS
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb596c..88aea35662dd 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -11,6 +11,7 @@ i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
 i2c_ss.add(when: 'CONFIG_ALLWINNER_I2C', if_true: files('allwinner-i2c.c'))
 i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
 i2c_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_smbus.c'))
+i2c_ss.add(when: 'CONFIG_DESIGNWARE_I2C', if_true: files('designware_i2c.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c'))
 i2c_ss.add(when: 'CONFIG_ARM_SBCON_I2C', if_true: files('arm_sbcon_i2c.c'))
 i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
-- 
2.47.3


