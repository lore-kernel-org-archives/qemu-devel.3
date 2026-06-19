Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEBBCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRBX-0000YO-93; Fri, 19 Jun 2026 00:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRBF-0000Fq-3K
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRB6-0005bA-5u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8423610ec93so1495803b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844594; x=1782449394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAzl79A3Nhe9qMQyZNybzkrJO1jJm3ohmSHmw3yH9f4=;
 b=joaIP20JaXtjTsQFEDbrsSNSUxhKMhIaKFQGOVW2WTV3QphmV8QxqDvvmFmvIyPpMC
 4dLD3WJrUPSYtSGi3kGlxXRHnGetAlYlcIfe4Uur742jSipHIH6dlKz8sRRBCIxT6q24
 ZgJk0pXVB1z8sseHz3vGu6B31gRRN8G4RCCahQahr7tnhHHAvAfl4Zmj9EXSwUBlaD3M
 Pv5zt3MPD+5hXVsgmVCbaRgTbY1TP3ZG2JTPu07ckGYZ500EqdHAf/tyH9p9pqxIhO8/
 mcD7XqgAEKVpLf080S8whiw2567tTE0OSogwTsv6gS+IeOzZBXx5iXg76jTg3ak4kt3R
 m9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844594; x=1782449394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAzl79A3Nhe9qMQyZNybzkrJO1jJm3ohmSHmw3yH9f4=;
 b=EOd3DndENQKodtjwTH2qe1MIzOLCbXzZHNh/TF6/I7NHWOa2abVX/pWUG4c2LaVKhm
 yzor1UC4h9KITrJMkfq0V1uWqC1qz4zgBfrmRGGigNVO91/oTZP9wuBzWnpVLweelGyr
 nySVB5bemt2Jp5y3kH9LfGKV7hzgx4C5jh4PGNtOCTJjh3U+kRwpCD4BZdQQLRLbXHzJ
 4/am56bvGwO3dv4ri70lTpnj9UpKgyqTWwMnYbbVoDOP1iJUrDrtfpmSAAO+RLpUSPY1
 z91ngDcXTB5ALoeYVx8rhIrf7nTzvF8xNmYVE4E/3qQHwSJuNLlG4nHvJBHPrxhz4XBx
 qbVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qhSZVGqqGL+wHe7PA6goT1YeVhciupPmJT3PjijWi5JLgLV2vg5I4KF6yI1fk3bQsY/if4U9XLFnu@nongnu.org
X-Gm-Message-State: AOJu0YxyAn2elwZc6UqcSFO1AkTz5qwdcUHDg1kCdytfOk5JTGFF19MP
 E1Wc0MNXstctCg4JF4sbNVxJ9JQZfz9pPntlyCmp9AVLeUtlsly64bcp
X-Gm-Gg: AfdE7cmcE1WHS0hP+TalxFUz43Zyy8mt7okT6yHWkBaIeqvnXh6Y4OuTv7t3LBtqSOF
 OoHjKrBdgQcLVkd+w4zFdcRRFWl6eZ90L4ILwhCC0M/+3790a83Xd3Hg7sSErqnUClGwDDz2tmS
 hkp8eFz6IA8Ndjggz4+1zwf/X/MStg8ad1zVN35e2CLfjotfXSXed2DlwXetmCgeOgUog8mrSzt
 J29l2XMtUoZ8oTrnGPPjt8TfjP+jL+Z+NuDhUU5cKE3mSAm4bf+mtyYACw3DMkmLgdq9ft+aUWJ
 j/W++XJtGwFGYayH9s1oCmxQvSOm/9DFN6xBnxFGhiEXVd5lT5B/5JZDpFF1QsM/P55Fj5iDM8h
 2k5WRleim+R0HcXiK0bqxjsUixfRM5QDgLzlv6zZCRWJyItad8Zq5zqI8H9tkOKCA6sfjU1CXNj
 CeRfqPFSMbZpet3t5jR8P8NtVoPDiOdJ7I5D71cT07GmffWfB8DOZNA7rpD+Mma+yNItQb6w2Ft
 rTHPjfNIIOqDxTnWe41xam+TjpCR3NfIcS3U6kg5g==
X-Received: by 2002:a05:6a00:3d4c:b0:82f:6e9:d1c3 with SMTP id
 d2e1a72fcca58-8455087b229mr2140698b3a.29.1781844593980; 
 Thu, 18 Jun 2026 21:49:53 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:49:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Chris Rauer <crauer@google.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alano Song <alanosong@163.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>, Nick Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Alano Song <AlanoSong@163.com>
Subject: [PATCH v9 10/12] hw/i2c: Add DesignWare I2C Controller
Date: Fri, 19 Jun 2026 14:18:34 +0930
Message-ID: <20260619044838.1054677-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

From: Chris Rauer <crauer@google.com>

Add a model for the Synopsys DesignWare Advanced I2C/SMBus Controller
with sufficient functionality to be used by the Linux Designware I2C
platform driver.

This IP is used in the Tenstorrent Atlantis RISC-V SoC and will be
added to the QEMU tt-atlantis machine.

[npiggin: changelog, code cleanups and fixes as-per below link]

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Chris Rauer <crauer@google.com>
Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
[jms: rebase and minor build fixes for class_init and reset callback]
Link: https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Alano Song <AlanoSong@163.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                     |   8 +
 include/hw/i2c/designware_i2c.h |  56 +++
 hw/i2c/designware_i2c.c         | 745 ++++++++++++++++++++++++++++++++
 hw/i2c/Kconfig                  |   5 +
 hw/i2c/meson.build              |   1 +
 5 files changed, 815 insertions(+)
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 hw/i2c/designware_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb17511b5725..b7887035fda5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2748,6 +2748,14 @@ S: Orphan
 F: hw/gpio/pcf8574.c
 F: include/hw/gpio/pcf8574.h
 
+DesignWare I2C
+M: Chris Rauer <crauer@google.com>
+R: Alano Song <alanosong@163.com>
+R: Joel Stanley <joel@jms.id.au>
+S: Maintained
+F: hw/i2c/designware_i2c.c
+F: include/hw/i2c/designware_i2c.h
+
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
new file mode 100644
index 000000000000..4d5ff5d973d8
--- /dev/null
+++ b/include/hw/i2c/designware_i2c.h
@@ -0,0 +1,56 @@
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
+#include "qemu/fifo8.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/irq.h"
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define DESIGNWARE_I2C_R_MAX (0x100 / 4)
+
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
+#define TYPE_DESIGNWARE_I2C "designware-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(DesignWareI2CState, DESIGNWARE_I2C)
+
+/*
+ * struct DesignWareI2CState - DesignWare I2C device state.
+ * @bus: The underlying I2C Bus
+ * @irq: Interrupt line fired on transaction events.
+ * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
+ */
+struct DesignWareI2CState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    I2CBus      *bus;
+    qemu_irq     irq;
+
+    uint32_t regs[DESIGNWARE_I2C_R_MAX];
+    RegisterInfo regs_info[DESIGNWARE_I2C_R_MAX];
+
+    /* fifo8_num_used(rx_fifo) should always equal DW_IC_RXFLR */
+    Fifo8    rx_fifo;
+
+    DesignWareI2CStatus status;
+};
+
+#endif /* DESIGNWARE_I2C_H */
diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
new file mode 100644
index 000000000000..daa9714cb7b2
--- /dev/null
+++ b/hw/i2c/designware_i2c.c
@@ -0,0 +1,745 @@
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
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#ifndef DESIGNWARE_I2C_ERR_DEBUG
+#define DESIGNWARE_I2C_ERR_DEBUG 0
+#endif
+
+REG32(DW_IC_CON,                0x00) /* I2C control */
+    FIELD(DW_IC_CON, STOP_DET_IF_MASTER_ACTIV, 10, 1)
+    FIELD(DW_IC_CON, RX_FIFO_FULL_HLD_CTRL,     9, 1)
+    FIELD(DW_IC_CON, TX_EMPTY_CTRL,             8, 1)
+    FIELD(DW_IC_CON, STOP_IF_ADDRESSED,         7, 1)
+    FIELD(DW_IC_CON, SLAVE_DISABLE,             6, 1)
+    FIELD(DW_IC_CON, IC_RESTART_EN,             5, 1)
+    FIELD(DW_IC_CON, 10BITADDR_MASTER,          4, 1)
+    FIELD(DW_IC_CON, 10BITADDR_SLAVE,           3, 1)
+    FIELD(DW_IC_CON, SPEED,                     1, 2)
+    FIELD(DW_IC_CON, MASTER_MODE,               0, 1)
+REG32(DW_IC_TAR,                0x04) /* I2C target address */
+    FIELD(DW_IC_TAR, IC_10BITADDR_MASTER, 12,  1)
+    FIELD(DW_IC_TAR, SPECIAL,             11,  1)
+    FIELD(DW_IC_TAR, GC_OR_START,         10,  1)
+    FIELD(DW_IC_TAR, ADDRESS,              0, 10)
+REG32(DW_IC_SAR,                0x08) /* I2C slave address */
+REG32(DW_IC_DATA_CMD,           0x10)
+    FIELD(DW_IC_DATA_CMD, RESTART, 10, 1)
+    FIELD(DW_IC_DATA_CMD, STOP,     9, 1)
+    FIELD(DW_IC_DATA_CMD, CMD,      8, 1)
+    FIELD(DW_IC_DATA_CMD, DAT,      0, 8)
+REG32(DW_IC_SS_SCL_HCNT,        0x14) /* Standard speed i2c clock scl high count */
+REG32(DW_IC_SS_SCL_LCNT,        0x18) /* Standard speed i2c clock scl low count */
+REG32(DW_IC_FS_SCL_HCNT,        0x1c) /* Fast or fast plus i2c clock scl high count */
+REG32(DW_IC_FS_SCL_LCNT,        0x20) /* Fast or fast plus i2c clock scl low count */
+REG32(DW_IC_INTR_STAT,          0x2c)
+REG32(DW_IC_INTR_MASK,          0x30) /* I2C Interrupt Mask */
+REG32(DW_IC_RAW_INTR_STAT,      0x34) /* I2C raw interrupt status */
+    /* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
+    SHARED_FIELD(DW_IC_INTR_RESTART_DET, 12, 1)
+    SHARED_FIELD(DW_IC_INTR_GEN_CALL,    11, 1)
+    SHARED_FIELD(DW_IC_INTR_START_DET,   10, 1)
+    SHARED_FIELD(DW_IC_INTR_STOP_DET,    9, 1)
+    SHARED_FIELD(DW_IC_INTR_ACTIVITY,    8, 1)
+    SHARED_FIELD(DW_IC_INTR_RX_DONE,     7, 1)
+    SHARED_FIELD(DW_IC_INTR_TX_ABRT,     6, 1)
+    SHARED_FIELD(DW_IC_INTR_RD_REQ,      5, 1)
+    SHARED_FIELD(DW_IC_INTR_TX_EMPTY,    4, 1) /* Hardware clear only. */
+    SHARED_FIELD(DW_IC_INTR_TX_OVER,     3, 1)
+    SHARED_FIELD(DW_IC_INTR_RX_FULL,     2, 1) /* Hardware clear only. */
+    SHARED_FIELD(DW_IC_INTR_RX_OVER,     1, 1)
+    SHARED_FIELD(DW_IC_INTR_RX_UNDER,    0, 1)
+
+#define DW_IC_INTR_ANY_MASK                \
+            (DW_IC_INTR_RESTART_DET_MASK | \
+             DW_IC_INTR_GEN_CALL_MASK    | \
+             DW_IC_INTR_START_DET_MASK   | \
+             DW_IC_INTR_STOP_DET_MASK    | \
+             DW_IC_INTR_ACTIVITY_MASK    | \
+             DW_IC_INTR_RX_DONE_MASK     | \
+             DW_IC_INTR_TX_ABRT_MASK     | \
+             DW_IC_INTR_RD_REQ_MASK      | \
+             DW_IC_INTR_TX_EMPTY_MASK    | \
+             DW_IC_INTR_TX_OVER_MASK     | \
+             DW_IC_INTR_RX_FULL_MASK     | \
+             DW_IC_INTR_RX_OVER_MASK     | \
+             DW_IC_INTR_RX_UNDER_MASK)
+
+#define DW_IC_INTR_ANY_SW_CLEAR_MASK       \
+            (DW_IC_INTR_ANY_MASK         & \
+            ~(DW_IC_INTR_TX_EMPTY_MASK   | \
+              DW_IC_INTR_RX_FULL_MASK))
+
+REG32(DW_IC_RX_TL,              0x38) /* I2C receive FIFO threshold */
+REG32(DW_IC_TX_TL,              0x3c) /* I2C transmit FIFO threshold */
+REG32(DW_IC_CLR_INTR,           0x40)
+REG32(DW_IC_CLR_RX_UNDER,       0x44)
+REG32(DW_IC_CLR_RX_OVER,        0x48)
+REG32(DW_IC_CLR_TX_OVER,        0x4c)
+REG32(DW_IC_CLR_RD_REQ,         0x50)
+REG32(DW_IC_CLR_TX_ABRT,        0x54)
+REG32(DW_IC_CLR_RX_DONE,        0x58)
+REG32(DW_IC_CLR_ACTIVITY,       0x5c)
+REG32(DW_IC_CLR_STOP_DET,       0x60)
+REG32(DW_IC_CLR_START_DET,      0x64)
+REG32(DW_IC_CLR_GEN_CALL,       0x68)
+REG32(DW_IC_ENABLE,             0x6c) /* I2C enable */
+    FIELD(DW_IC_ENABLE, TX_CMD_BLOCK, 2, 1)
+    FIELD(DW_IC_ENABLE, ABORT,        1, 1)
+    FIELD(DW_IC_ENABLE, ENABLE,       0, 1)
+REG32(DW_IC_STATUS,             0x70) /* I2C status */
+    FIELD(DW_IC_STATUS, SLV_ACTIVITY, 6, 1)
+    FIELD(DW_IC_STATUS, MST_ACTIVITY, 5, 1)
+    FIELD(DW_IC_STATUS, RFF,          4, 1)
+    FIELD(DW_IC_STATUS, RFNE,         3, 1)
+    FIELD(DW_IC_STATUS, TFE,          2, 1)
+    FIELD(DW_IC_STATUS, TFNF,         1, 1)
+    FIELD(DW_IC_STATUS, ACTIVITY,     0, 1)
+REG32(DW_IC_TXFLR,              0x74) /* I2C transmit fifo level */
+REG32(DW_IC_RXFLR,              0x78) /* I2C receive fifo level */
+REG32(DW_IC_SDA_HOLD,           0x7c) /* I2C SDA hold time length */
+REG32(DW_IC_TX_ABRT_SOURCE,     0x80) /* The I2C transmit abort source */
+    FIELD(DW_IC_TX_ABRT_SOURCE, USER_ABRT,       16, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, SLVRD_INTX,      15, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, SLV_ARBLOST,     14, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, SLVFLUSH_TXFIFO, 13, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, ARB_LOST,        12, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, MASTER_DIS,      11, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, 10B_RD_NORSTRT,  10, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, SBYTE_NORSTRT,   9, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, HS_NORSTRT,      8, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, SBYTE_ACKDET,    7, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, HS_ACKDET,       6, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, GCALL_READ,      5, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, GCALL_NOACK,     4, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, TXDATA_NOACK,    3, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, 10ADDR2_NOACK,   2, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, 10ADDR1_NOACK,   1, 1)
+    FIELD(DW_IC_TX_ABRT_SOURCE, 7B_ADDR_NOACK,   0, 1)
+REG32(DW_IC_SLV_DATA_NACK_ONLY, 0x84)
+REG32(DW_IC_DMA_CR,             0x88)
+REG32(DW_IC_DMA_TDLR,           0x8c)
+REG32(DW_IC_DMA_RDLR,           0x90)
+REG32(DW_IC_SDA_SETUP,          0x94) /* I2C SDA setup */
+REG32(DW_IC_ACK_GENERAL_CALL,   0x98)
+REG32(DW_IC_ENABLE_STATUS,      0x9c) /* I2C enable status */
+    FIELD(DW_IC_ENABLE_STATUS, SLV_RX_DATA_LOST,        2, 1)
+    FIELD(DW_IC_ENABLE_STATUS, SLV_DISABLED_WHILE_BUSY, 1, 1)
+    FIELD(DW_IC_ENABLE_STATUS, IC_EN,                   0, 1)
+REG32(DW_IC_FS_SPKLEN,          0xa0) /* I2C SS, FS or FM+ spike suppression limit */
+REG32(DW_IC_CLR_RESTART_DET,    0xa8)
+REG32(DW_IC_SMBUS_INTR_MASK,    0xcc) /* SMBus Interrupt Mask */
+REG32(DW_IC_COMP_PARAM_1,       0xf4) /* Component parameter */
+    FIELD(DW_IC_COMP_PARAM_1, TX_FIFO_SIZE,       16, 8)
+    FIELD(DW_IC_COMP_PARAM_1, RX_FIFO_SIZE,        8, 8)
+    FIELD(DW_IC_COMP_PARAM_1, HAS_ENCODED_PARAMS,  7, 1)
+    FIELD(DW_IC_COMP_PARAM_1, HAS_DMA,             6, 1)
+    FIELD(DW_IC_COMP_PARAM_1, INTR_IO,             5, 1)
+    FIELD(DW_IC_COMP_PARAM_1, HC_COUNT_VAL,        4, 1)
+    FIELD(DW_IC_COMP_PARAM_1, HIGH_SPEED_MODE,     2, 2)
+    FIELD(DW_IC_COMP_PARAM_1, APB_DATA_WIDTH_32,   0, 2)
+REG32(DW_IC_COMP_VERSION,       0xf8) /* I2C component version */
+REG32(DW_IC_COMP_TYPE,          0xfc) /* I2C component type */
+
+static void dw_i2c_update_irq(DesignWareI2CState *s)
+{
+    uint32_t intr = s->regs[R_DW_IC_RAW_INTR_STAT] & s->regs[R_DW_IC_INTR_MASK];
+
+    qemu_set_irq(s->irq, !!(intr & DW_IC_INTR_ANY_MASK));
+}
+
+static uint64_t dw_ic_data_cmd_reg_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    g_assert(value == 0);
+
+    if (s->status != DW_I2C_STATUS_RECEIVING) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Attempted to read from RX fifo when not in receive "
+                      "state.\n", DEVICE(s)->canonical_path);
+        if (s->status != DW_I2C_STATUS_IDLE) {
+            SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT,
+                                    DW_IC_INTR_RX_UNDER, 1);
+            dw_i2c_update_irq(s);
+        }
+        return 0;
+    }
+
+    g_assert(s->regs[R_DW_IC_RXFLR] == fifo8_num_used(&s->rx_fifo));
+
+    if (fifo8_is_empty(&s->rx_fifo)) {
+        SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT, DW_IC_INTR_RX_UNDER, 1);
+        dw_i2c_update_irq(s);
+        return 0;
+    }
+
+    s->regs[R_DW_IC_RXFLR]--;
+    if (s->regs[R_DW_IC_RXFLR] <= s->regs[R_DW_IC_RX_TL]) {
+        SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT, DW_IC_INTR_RX_FULL, 0);
+        dw_i2c_update_irq(s);
+    }
+
+    return fifo8_pop(&s->rx_fifo);
+}
+
+static uint64_t dw_ic_clr_intr_reg_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    g_assert(value == 0);
+
+    switch (reg->access->addr) {
+    case A_DW_IC_CLR_INTR:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_ANY_SW_CLEAR_MASK;
+        break;
+    case A_DW_IC_CLR_RX_UNDER:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_UNDER_MASK;
+        break;
+    case A_DW_IC_CLR_RX_OVER:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_OVER_MASK;
+        break;
+    case A_DW_IC_CLR_TX_OVER:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_TX_OVER_MASK;
+        break;
+    case A_DW_IC_CLR_RD_REQ:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RD_REQ_MASK;
+        break;
+    case A_DW_IC_CLR_TX_ABRT:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_TX_ABRT_MASK;
+        break;
+    case A_DW_IC_CLR_RX_DONE:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_DONE_MASK;
+        break;
+    case A_DW_IC_CLR_ACTIVITY:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_ACTIVITY_MASK;
+        break;
+    case A_DW_IC_CLR_STOP_DET:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_STOP_DET_MASK;
+        break;
+    case A_DW_IC_CLR_START_DET:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_START_DET_MASK;
+        break;
+    case A_DW_IC_CLR_GEN_CALL:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_GEN_CALL_MASK;
+        break;
+    case A_DW_IC_CLR_RESTART_DET:
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RESTART_DET_MASK;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    dw_i2c_update_irq(s);
+
+    return 0;
+}
+
+static uint64_t dw_ic_intr_stat_reg_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    g_assert(value == 0);
+
+    return s->regs[R_DW_IC_RAW_INTR_STAT] & s->regs[R_DW_IC_INTR_MASK];
+}
+
+static uint64_t dw_ic_unsupported_reg_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: unsupported read - %s\n",
+                  DEVICE(s)->canonical_path, reg->access->name);
+
+    return 0;
+}
+
+static uint64_t dw_ic_unsupported_reg_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: unsupported write - %s\n",
+                  DEVICE(s)->canonical_path, reg->access->name);
+
+    return 0;
+}
+
+static uint64_t dw_ic_con_reg_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    if (s->regs[R_DW_IC_ENABLE] & R_DW_IC_ENABLE_ENABLE_MASK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_con %d when ic_enable[0]==1\n",
+                      DEVICE(s)->canonical_path, (int)value);
+        return s->regs[R_DW_IC_CON]; /* keep old value */
+    }
+
+    return value;
+}
+
+static void dw_i2c_reset_to_idle(DesignWareI2CState *s)
+{
+    s->regs[R_DW_IC_ENABLE_STATUS] &= ~R_DW_IC_ENABLE_STATUS_IC_EN_MASK;
+    s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_TX_EMPTY_MASK;
+    s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_FULL_MASK;
+    s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_UNDER_MASK;
+    s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_OVER_MASK;
+    s->regs[R_DW_IC_RXFLR] = 0;
+    fifo8_reset(&s->rx_fifo);
+    s->regs[R_DW_IC_STATUS] &= ~R_DW_IC_STATUS_ACTIVITY_MASK;
+    s->status = DW_I2C_STATUS_IDLE;
+    dw_i2c_update_irq(s);
+}
+
+static void dw_ic_tx_abort(DesignWareI2CState *s, uint32_t src)
+{
+    s->regs[R_DW_IC_TX_ABRT_SOURCE] |= src;
+    s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_TX_ABRT_MASK;
+    dw_i2c_reset_to_idle(s);
+    dw_i2c_update_irq(s);
+}
+
+static void dw_ic_data_cmd_reg_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+    int recv = !!(value & R_DW_IC_DATA_CMD_CMD_MASK);
+
+    s->regs[R_DW_IC_DATA_CMD] = 0; /* Register has no storage */
+
+    if (!(s->regs[R_DW_IC_ENABLE] & R_DW_IC_ENABLE_ENABLE_MASK)) {
+        /*
+         * Controller is not enabled. The register_reset() path also lands
+         * here with value == 0, so silently ignore rather than reporting
+         * a spurious guest error.
+         */
+        return;
+    }
+
+    if (s->status == DW_I2C_STATUS_IDLE ||
+        s->regs[R_DW_IC_RAW_INTR_STAT] & DW_IC_INTR_TX_ABRT_MASK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Attempted to write to TX fifo when it is held in "
+                      "reset\n", DEVICE(s)->canonical_path);
+        return;
+    }
+
+    /* Send the address if it hasn't been sent yet. */
+    if (s->status == DW_I2C_STATUS_SENDING_ADDRESS) {
+        int rv = i2c_start_transfer(s->bus,
+                     ARRAY_FIELD_EX32(s->regs, DW_IC_TAR, ADDRESS), recv);
+        if (rv) {
+            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_7B_ADDR_NOACK_MASK);
+            return;
+        }
+        s->status = recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SENDING;
+    }
+
+    /* Send data */
+    if (!recv) {
+        int rv = i2c_send(s->bus, FIELD_EX32(value, DW_IC_DATA_CMD, DAT));
+        if (rv) {
+            i2c_end_transfer(s->bus);
+            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_TXDATA_NOACK_MASK);
+            return;
+        }
+        dw_i2c_update_irq(s);
+    }
+
+    /* Restart command */
+    if (value & R_DW_IC_DATA_CMD_RESTART_MASK &&
+            s->regs[R_DW_IC_CON] & R_DW_IC_CON_IC_RESTART_EN_MASK) {
+        s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_RESTART_DET_MASK |
+                                          DW_IC_INTR_START_DET_MASK |
+                                          DW_IC_INTR_ACTIVITY_MASK;
+        s->regs[R_DW_IC_STATUS] |= R_DW_IC_STATUS_ACTIVITY_MASK;
+        dw_i2c_update_irq(s);
+
+        if (i2c_start_transfer(s->bus,
+                    ARRAY_FIELD_EX32(s->regs, DW_IC_TAR, ADDRESS), recv)) {
+            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_7B_ADDR_NOACK_MASK);
+            return;
+        }
+
+        s->status = recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SENDING;
+    }
+
+    /* Receive data */
+    if (recv) {
+        g_assert(s->regs[R_DW_IC_RXFLR] == fifo8_num_used(&s->rx_fifo));
+
+        if (!fifo8_is_full(&s->rx_fifo)) {
+            fifo8_push(&s->rx_fifo, i2c_recv(s->bus));
+            s->regs[R_DW_IC_RXFLR]++;
+        } else {
+            s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_RX_OVER_MASK;
+            dw_i2c_update_irq(s);
+        }
+
+        if (s->regs[R_DW_IC_RXFLR] > s->regs[R_DW_IC_RX_TL]) {
+            s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_RX_FULL_MASK;
+            dw_i2c_update_irq(s);
+        }
+        if (value & R_DW_IC_DATA_CMD_STOP_MASK) {
+            i2c_nack(s->bus);
+        }
+    }
+
+    /* Stop command */
+    if (value & R_DW_IC_DATA_CMD_STOP_MASK) {
+        s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_STOP_DET_MASK;
+        s->regs[R_DW_IC_STATUS] &= ~R_DW_IC_STATUS_ACTIVITY_MASK;
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_TX_EMPTY_MASK;
+        i2c_end_transfer(s->bus);
+        dw_i2c_update_irq(s);
+    }
+}
+
+static void dw_ic_intr_mask_reg_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    dw_i2c_update_irq(s);
+}
+
+static uint64_t dw_ic_enable_reg_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    if (value & R_DW_IC_ENABLE_ENABLE_MASK &&
+            !(s->regs[R_DW_IC_CON] & R_DW_IC_CON_SLAVE_DISABLE_MASK)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Designware I2C slave mode is not supported.\n",
+                      DEVICE(s)->canonical_path);
+        return s->regs[R_DW_IC_ENABLE]; /* keep old value */
+    }
+
+    return value;
+}
+
+static void dw_ic_enable_reg_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    s->regs[R_DW_IC_ENABLE] = value & R_DW_IC_ENABLE_ENABLE_MASK;
+
+    if (value & R_DW_IC_ENABLE_ABORT_MASK || value & R_DW_IC_ENABLE_TX_CMD_BLOCK_MASK) {
+        dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_USER_ABRT_MASK);
+        return;
+    }
+
+    if (value & R_DW_IC_ENABLE_ENABLE_MASK) {
+        s->regs[R_DW_IC_ENABLE_STATUS] |= R_DW_IC_ENABLE_STATUS_IC_EN_MASK;
+        s->regs[R_DW_IC_STATUS] |= R_DW_IC_STATUS_ACTIVITY_MASK;
+        s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_ACTIVITY_MASK |
+                                          DW_IC_INTR_START_DET_MASK |
+                                          DW_IC_INTR_TX_EMPTY_MASK;
+        s->status = DW_I2C_STATUS_SENDING_ADDRESS;
+        dw_i2c_update_irq(s);
+    } else if ((value & R_DW_IC_ENABLE_ENABLE_MASK) == 0) {
+        dw_i2c_reset_to_idle(s);
+    }
+}
+
+static uint64_t dw_ic_rx_tl_reg_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    /* Note that a value of 0 for ic_rx_tl indicates a threshold of 1. */
+    if (value > DESIGNWARE_I2C_RX_FIFO_SIZE - 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_rx_tl %d\n",
+                      DEVICE(s)->canonical_path, (int)value);
+        return DESIGNWARE_I2C_RX_FIFO_SIZE - 1;
+    }
+
+    return value;
+}
+
+static void dw_ic_rx_tl_reg_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    if (s->regs[R_DW_IC_RXFLR] > s->regs[R_DW_IC_RX_TL] &&
+            s->regs[R_DW_IC_ENABLE] & R_DW_IC_ENABLE_ENABLE_MASK) {
+        s->regs[R_DW_IC_RAW_INTR_STAT] |= DW_IC_INTR_RX_FULL_MASK;
+    } else {
+        s->regs[R_DW_IC_RAW_INTR_STAT] &= ~DW_IC_INTR_RX_FULL_MASK;
+    }
+    dw_i2c_update_irq(s);
+}
+
+static uint64_t dw_ic_tx_tl_reg_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(reg->opaque);
+
+    /*
+     * Note that a value of 0 for ic_tx_tl indicates a threshold of 1.
+     * However, the tx threshold is not used in the model because commands are
+     * always sent out as soon as they are written.
+     */
+    if (value > DESIGNWARE_I2C_TX_FIFO_SIZE - 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid setting to ic_tx_tl %d\n",
+                      DEVICE(s)->canonical_path, (int)value);
+        return DESIGNWARE_I2C_TX_FIFO_SIZE - 1;
+    }
+
+    return value;
+}
+
+static const RegisterAccessInfo designware_i2c_regs_info[] = {
+    {   .name  = "DW_IC_CON", .addr = A_DW_IC_CON,
+        .reset =       0x7d,
+        .unimp = 0xfffffc00,
+        .pre_write = dw_ic_con_reg_pre_write,
+    },{ .name  = "DW_IC_TAR", .addr = A_DW_IC_TAR,
+        .reset =     0x1055,
+        .unimp = 0xfffff000,
+    },{ .name  = "DW_IC_SAR", .addr = A_DW_IC_SAR,
+        .reset =       0x55,
+        .unimp = 0xfffffc00,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_DATA_CMD", .addr = A_DW_IC_DATA_CMD,
+        .post_read = dw_ic_data_cmd_reg_post_read,
+        .post_write = dw_ic_data_cmd_reg_post_write,
+    },{ .name  = "DW_IC_SS_SCL_HCNT", .addr = A_DW_IC_SS_SCL_HCNT,
+        .reset =      0x190,
+        .unimp = 0xffff0000,
+    },{ .name  = "DW_IC_SS_SCL_LCNT", .addr = A_DW_IC_SS_SCL_LCNT,
+        .reset =      0x1d6,
+        .unimp = 0xffff0000,
+    },{ .name  = "DW_IC_FS_SCL_HCNT", .addr = A_DW_IC_FS_SCL_HCNT,
+        .reset =       0x3c,
+        .unimp = 0xffff0000,
+    },{ .name  = "DW_IC_FS_SCL_LCNT", .addr = A_DW_IC_FS_SCL_LCNT,
+        .reset =       0x82,
+        .unimp = 0xffff0000,
+    },{ .name  = "DW_IC_INTR_STAT", .addr = A_DW_IC_INTR_STAT,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_intr_stat_reg_post_read,
+    },{ .name  = "DW_IC_INTR_MASK", .addr = A_DW_IC_INTR_MASK,
+        .reset =      0x8ff,
+        .unimp = 0xffff8000,
+        .post_write = dw_ic_intr_mask_reg_post_write,
+    },{ .name  = "DW_IC_RAW_INTR_STAT", .addr = A_DW_IC_RAW_INTR_STAT,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_RX_TL", .addr = A_DW_IC_RX_TL,
+        .pre_write = dw_ic_rx_tl_reg_pre_write,
+        .post_write = dw_ic_rx_tl_reg_post_write,
+    },{ .name  = "DW_IC_TX_TL", .addr = A_DW_IC_TX_TL,
+        .pre_write = dw_ic_tx_tl_reg_pre_write,
+    },{ .name  = "DW_IC_CLR_INTR", .addr = A_DW_IC_CLR_INTR,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_RX_UNDER", .addr = A_DW_IC_CLR_RX_UNDER,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_RX_OVER", .addr = A_DW_IC_CLR_RX_OVER,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_TX_OVER", .addr = A_DW_IC_CLR_TX_OVER,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_RD_REQ", .addr = A_DW_IC_CLR_RD_REQ,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_TX_ABRT", .addr = A_DW_IC_CLR_TX_ABRT,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_RX_DONE", .addr = A_DW_IC_CLR_RX_DONE,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_ACTIVITY", .addr = A_DW_IC_CLR_ACTIVITY,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_STOP_DET", .addr = A_DW_IC_CLR_STOP_DET,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_START_DET", .addr = A_DW_IC_CLR_START_DET,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_CLR_GEN_CALL", .addr = A_DW_IC_CLR_GEN_CALL,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_ENABLE", .addr = A_DW_IC_ENABLE,
+        .unimp = 0xfffffff8,
+        .pre_write = dw_ic_enable_reg_pre_write,
+        .post_write = dw_ic_enable_reg_post_write,
+    },{ .name  = "DW_IC_STATUS", .addr = A_DW_IC_STATUS,
+        .reset =        0x6,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_TXFLR", .addr = A_DW_IC_TXFLR,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_RXFLR", .addr = A_DW_IC_RXFLR,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_SDA_HOLD", .addr = A_DW_IC_SDA_HOLD,
+        .reset =        0x1,
+        .unimp = 0xff000000,
+    },{ .name  = "DW_IC_TX_ABRT_SOURCE", .addr = A_DW_IC_TX_ABRT_SOURCE,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_SLV_DATA_NACK_ONLY", .addr = A_DW_IC_SLV_DATA_NACK_ONLY,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_DMA_CR", .addr = A_DW_IC_DMA_CR,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_DMA_TDLR", .addr = A_DW_IC_DMA_TDLR,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_DMA_RDLR", .addr = A_DW_IC_DMA_RDLR,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_SDA_SETUP", .addr = A_DW_IC_SDA_SETUP,
+        .reset =       0x64,
+        .unimp = 0xffffff00,
+    },{ .name  = "DW_IC_ACK_GENERAL_CALL", .addr = A_DW_IC_ACK_GENERAL_CALL,
+        .post_read = dw_ic_unsupported_reg_post_read,
+        .pre_write = dw_ic_unsupported_reg_pre_write,
+    },{ .name  = "DW_IC_ENABLE_STATUS", .addr = A_DW_IC_ENABLE_STATUS,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_FS_SPKLEN", .addr = A_DW_IC_FS_SPKLEN,
+        .reset =        0x2,
+        .ro    = 0xffffff00,
+    },{ .name  = "DW_IC_CLR_RESTART_DET", .addr = A_DW_IC_CLR_RESTART_DET,
+        .ro    = 0xffffffff,
+        .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_SMBUS_INTR_MASK", .addr = A_DW_IC_SMBUS_INTR_MASK,
+        /* No SMBus interrupts are implemented, Linux updates the mask */
+        .reset =      0x7ff,
+        .unimp = 0xfffff800,
+    },{ .name  = "DW_IC_COMP_PARAM_1", .addr = A_DW_IC_COMP_PARAM_1,
+        .reset = /* HAS_DMA and HC_COUNT_VAL are disabled */
+            ((2 << R_DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32_SHIFT) |
+             R_DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE_MASK           |
+             R_DW_IC_COMP_PARAM_1_INTR_IO_MASK                   |
+             R_DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS_MASK        |
+             ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1)
+                  << R_DW_IC_COMP_PARAM_1_RX_FIFO_SIZE_SHIFT)    |
+             ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1)
+                  << R_DW_IC_COMP_PARAM_1_TX_FIFO_SIZE_SHIFT)),
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_COMP_VERSION", .addr = A_DW_IC_COMP_VERSION,
+        .reset = 0x3132302a,
+        .ro    = 0xffffffff,
+    },{ .name  = "DW_IC_COMP_TYPE", .addr = A_DW_IC_COMP_TYPE,
+        .reset = 0x44570140,
+        .ro    = 0xffffffff,
+    }
+};
+
+static const MemoryRegionOps designware_i2c_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
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
+    unsigned int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+
+    fifo8_reset(&s->rx_fifo);
+
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
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, DesignWareI2CState, DESIGNWARE_I2C_R_MAX),
+        VMSTATE_FIFO8(rx_fifo, DesignWareI2CState),
+        VMSTATE_UINT32(status, DesignWareI2CState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void designware_i2c_instance_init(Object *obj)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    fifo8_create(&s->rx_fifo, DESIGNWARE_I2C_RX_FIFO_SIZE);
+
+    s->bus = i2c_init_bus(DEVICE(s), "i2c-bus");
+
+    memory_region_init(&s->iomem, obj, TYPE_DESIGNWARE_I2C, 4 * KiB);
+    reg_array = register_init_block32(DEVICE(obj), designware_i2c_regs_info,
+                                      ARRAY_SIZE(designware_i2c_regs_info),
+                                      s->regs_info, s->regs,
+                                      &designware_i2c_ops,
+                                      DESIGNWARE_I2C_ERR_DEBUG,
+                                      DESIGNWARE_I2C_R_MAX * 4);
+    memory_region_add_subregion(&s->iomem, 0, &reg_array->mem);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void designware_i2c_finalize(Object *obj)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+
+    fifo8_destroy(&s->rx_fifo);
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
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo designware_i2c_types[] = {
+    {
+        .name = TYPE_DESIGNWARE_I2C,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(DesignWareI2CState),
+        .class_init = designware_i2c_class_init,
+        .instance_init = designware_i2c_instance_init,
+        .instance_finalize = designware_i2c_finalize,
+    },
+};
+DEFINE_TYPES(designware_i2c_types);
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 596a7a3165ad..0766130b5963 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -18,6 +18,11 @@ config ARM_SBCON_I2C
     bool
     select BITBANG_I2C
 
+config DESIGNWARE_I2C
+    bool
+    select REGISTER
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


