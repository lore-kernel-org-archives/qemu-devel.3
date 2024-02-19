Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C854C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4g-0005Vb-Ia; Mon, 19 Feb 2024 03:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4Z-00058B-JL; Mon, 19 Feb 2024 03:32:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4V-0002Zb-S7; Mon, 19 Feb 2024 03:32:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dba177c596so20072345ad.0; 
 Mon, 19 Feb 2024 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331538; x=1708936338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDtxMjiSnz7ZqFjGZjmvX6Rg6O7c/2qsnFTyWnV0Muc=;
 b=AYIbb5u4eEDkJbB/CSPDH/nW/0rSQ1rAB+sBF/nzhHP3N06lvesirHwtmKsCxKEwwe
 8zSOK7AQGzjoC1Ti4ZzGYGFuJqhxfXEFdV8tvUba9NVWH8OV5STECBO+pmMUQwvyfp+R
 G23pVUKJQWs7i+fF6CKUvhUUOccIs2Br05GHe7oXvns40i/qqU6Jb0PjHAR0aoZbSMhs
 Z6CEgvmRyHDU9/3TbEPcm87/+qfsscrbEpfP/kuOGbbXmtCDt+vp50R4ZuerZ9dyKqfZ
 sJ/MktD0JTUMeCFDv43hB8/QkZR9zD8wJeNBuFlLa01+AFk7lah83KKBPDeZX4un6Yf1
 Ty5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331538; x=1708936338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDtxMjiSnz7ZqFjGZjmvX6Rg6O7c/2qsnFTyWnV0Muc=;
 b=X/XY7G0yLCEt7mMc8hVJCE1wFKiiFsBBftvSazvZ0nnMjAn59NQsaH1GgZ/gmnLHKe
 FQPeRVjCDYmen525SUKNSIVid4VyHNnRr0jFNSxxg1vLsA0XPTWLFlFpARhaRtZ9ZIkT
 cigaCFR/HtLRVxavc4uRvpmYBFB97vMzdG7e39BbEJGefCXHvRWKOrS2lHtuUR/ZVuS/
 GYpBSq95mHfikGDVvh/ENYCxwmUau7CW8+leswCiRqTyooDTRsj3fktD+X+Dbg9ftaQa
 xGjtQR5DWNoPsfmGFePIzXcJWjD+lNtAI3aU/or51x2GHJ7gVdG7jHwsPY74uII3Rt9T
 r0vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1nMPNZFo/NQogMroI1qk2fjn5rIvQlsz2/rvo+Z5cJvPnoVdCYGE1iXi4xUfrBzmUpEvaxKzPPdcqZp17I/XlAmOb
X-Gm-Message-State: AOJu0Yw2aDizZt0K1114LGor5maOEfYU8zxak+17p52jSrp38KnBShQs
 hGdQ1Q7czNtx1ML89CkLoC2LrN6OoHH+H1gnCMXXSee9ON6Ov2jMUp7vmmfm
X-Google-Smtp-Source: AGHT+IFhTZ5CQoXzeP24kOaT/SYjGDOlWuTYVKBkC0huTd13QAqTe+ICJOow3jWey5MnoW9hiRs+Uw==
X-Received: by 2002:a17:902:e743:b0:1db:e74b:5bb4 with SMTP id
 p3-20020a170902e74300b001dbe74b5bb4mr4450763plf.14.1708331537779; 
 Mon, 19 Feb 2024 00:32:17 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 31/49] ppc/pnv: Test pnv i2c master and connected devices
Date: Mon, 19 Feb 2024 18:29:20 +1000
Message-ID: <20240219082938.238302-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Tests the following for both P9 and P10:
  - I2C master POR status
  - I2C master status after immediate reset

Tests the following for powernv10-ranier only:
  - Config pca9552 hotplug device pins as inputs then
    Read the INPUT0/1 registers to verify all pins are high
  - Connected GPIO pin tests of P10 PCA9552 device.  Tests
    output of pins 0-4 affect input of pins 5-9 respectively.
  - PCA9554 GPIO pins test.  Tests input and ouput functionality.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_i2c.c                | 131 +--------
 include/hw/i2c/pnv_i2c_regs.h   | 143 ++++++++++
 tests/qtest/meson.build         |   1 +
 tests/qtest/pnv-host-i2c-test.c | 491 ++++++++++++++++++++++++++++++++
 tests/qtest/pnv-xscom-test.c    |  61 +---
 tests/qtest/pnv-xscom.h         |  80 ++++++
 6 files changed, 717 insertions(+), 190 deletions(-)
 create mode 100644 include/hw/i2c/pnv_i2c_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c
 create mode 100644 tests/qtest/pnv-xscom.h

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 774946d6b2..4581cc5e5d 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -22,136 +22,7 @@
 
 #include <libfdt.h>
 
-/* I2C FIFO register */
-#define I2C_FIFO_REG                    0x4
-#define I2C_FIFO                        PPC_BITMASK(0, 7)
-
-/* I2C command register */
-#define I2C_CMD_REG                     0x5
-#define I2C_CMD_WITH_START              PPC_BIT(0)
-#define I2C_CMD_WITH_ADDR               PPC_BIT(1)
-#define I2C_CMD_READ_CONT               PPC_BIT(2)
-#define I2C_CMD_WITH_STOP               PPC_BIT(3)
-#define I2C_CMD_INTR_STEERING           PPC_BITMASK(6, 7) /* P9 */
-#define   I2C_CMD_INTR_STEER_HOST       1
-#define   I2C_CMD_INTR_STEER_OCC        2
-#define I2C_CMD_DEV_ADDR                PPC_BITMASK(8, 14)
-#define I2C_CMD_READ_NOT_WRITE          PPC_BIT(15)
-#define I2C_CMD_LEN_BYTES               PPC_BITMASK(16, 31)
-#define I2C_MAX_TFR_LEN                 0xfff0ull
-
-/* I2C mode register */
-#define I2C_MODE_REG                    0x6
-#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
-#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
-#define I2C_MODE_ENHANCED               PPC_BIT(28)
-#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
-#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
-#define I2C_MODE_WRAP                   PPC_BIT(31)
-
-/* I2C watermark register */
-#define I2C_WATERMARK_REG               0x7
-#define I2C_WATERMARK_HIGH              PPC_BITMASK(16, 19)
-#define I2C_WATERMARK_LOW               PPC_BITMASK(24, 27)
-
-/*
- * I2C interrupt mask and condition registers
- *
- * NB: The function of 0x9 and 0xa changes depending on whether you're reading
- *     or writing to them. When read they return the interrupt condition bits
- *     and on writes they update the interrupt mask register.
- *
- *  The bit definitions are the same for all the interrupt registers.
- */
-#define I2C_INTR_MASK_REG               0x8
-
-#define I2C_INTR_RAW_COND_REG           0x9 /* read */
-#define I2C_INTR_MASK_OR_REG            0x9 /* write*/
-
-#define I2C_INTR_COND_REG               0xa /* read */
-#define I2C_INTR_MASK_AND_REG           0xa /* write */
-
-#define I2C_INTR_ALL                    PPC_BITMASK(16, 31)
-#define I2C_INTR_INVALID_CMD            PPC_BIT(16)
-#define I2C_INTR_LBUS_PARITY_ERR        PPC_BIT(17)
-#define I2C_INTR_BKEND_OVERRUN_ERR      PPC_BIT(18)
-#define I2C_INTR_BKEND_ACCESS_ERR       PPC_BIT(19)
-#define I2C_INTR_ARBT_LOST_ERR          PPC_BIT(20)
-#define I2C_INTR_NACK_RCVD_ERR          PPC_BIT(21)
-#define I2C_INTR_DATA_REQ               PPC_BIT(22)
-#define I2C_INTR_CMD_COMP               PPC_BIT(23)
-#define I2C_INTR_STOP_ERR               PPC_BIT(24)
-#define I2C_INTR_I2C_BUSY               PPC_BIT(25)
-#define I2C_INTR_NOT_I2C_BUSY           PPC_BIT(26)
-#define I2C_INTR_SCL_EQ_1               PPC_BIT(28)
-#define I2C_INTR_SCL_EQ_0               PPC_BIT(29)
-#define I2C_INTR_SDA_EQ_1               PPC_BIT(30)
-#define I2C_INTR_SDA_EQ_0               PPC_BIT(31)
-
-/* I2C status register */
-#define I2C_RESET_I2C_REG               0xb /* write */
-#define I2C_RESET_ERRORS                0xc
-#define I2C_STAT_REG                    0xb /* read */
-#define I2C_STAT_INVALID_CMD            PPC_BIT(0)
-#define I2C_STAT_LBUS_PARITY_ERR        PPC_BIT(1)
-#define I2C_STAT_BKEND_OVERRUN_ERR      PPC_BIT(2)
-#define I2C_STAT_BKEND_ACCESS_ERR       PPC_BIT(3)
-#define I2C_STAT_ARBT_LOST_ERR          PPC_BIT(4)
-#define I2C_STAT_NACK_RCVD_ERR          PPC_BIT(5)
-#define I2C_STAT_DATA_REQ               PPC_BIT(6)
-#define I2C_STAT_CMD_COMP               PPC_BIT(7)
-#define I2C_STAT_STOP_ERR               PPC_BIT(8)
-#define I2C_STAT_UPPER_THRS             PPC_BITMASK(9, 15)
-#define I2C_STAT_ANY_I2C_INTR           PPC_BIT(16)
-#define I2C_STAT_PORT_HISTORY_BUSY      PPC_BIT(19)
-#define I2C_STAT_SCL_INPUT_LEVEL        PPC_BIT(20)
-#define I2C_STAT_SDA_INPUT_LEVEL        PPC_BIT(21)
-#define I2C_STAT_PORT_BUSY              PPC_BIT(22)
-#define I2C_STAT_INTERFACE_BUSY         PPC_BIT(23)
-#define I2C_STAT_FIFO_ENTRY_COUNT       PPC_BITMASK(24, 31)
-
-#define I2C_STAT_ANY_ERR (I2C_STAT_INVALID_CMD | I2C_STAT_LBUS_PARITY_ERR | \
-                          I2C_STAT_BKEND_OVERRUN_ERR | \
-                          I2C_STAT_BKEND_ACCESS_ERR | I2C_STAT_ARBT_LOST_ERR | \
-                          I2C_STAT_NACK_RCVD_ERR | I2C_STAT_STOP_ERR)
-
-
-#define I2C_INTR_ACTIVE \
-        ((I2C_STAT_ANY_ERR >> 16) | I2C_INTR_CMD_COMP | I2C_INTR_DATA_REQ)
-
-/* Pseudo-status used for timeouts */
-#define I2C_STAT_PSEUDO_TIMEOUT         PPC_BIT(63)
-
-/* I2C extended status register */
-#define I2C_EXTD_STAT_REG               0xc
-#define I2C_EXTD_STAT_FIFO_SIZE         PPC_BITMASK(0, 7)
-#define I2C_EXTD_STAT_MSM_CURSTATE      PPC_BITMASK(11, 15)
-#define I2C_EXTD_STAT_SCL_IN_SYNC       PPC_BIT(16)
-#define I2C_EXTD_STAT_SDA_IN_SYNC       PPC_BIT(17)
-#define I2C_EXTD_STAT_S_SCL             PPC_BIT(18)
-#define I2C_EXTD_STAT_S_SDA             PPC_BIT(19)
-#define I2C_EXTD_STAT_M_SCL             PPC_BIT(20)
-#define I2C_EXTD_STAT_M_SDA             PPC_BIT(21)
-#define I2C_EXTD_STAT_HIGH_WATER        PPC_BIT(22)
-#define I2C_EXTD_STAT_LOW_WATER         PPC_BIT(23)
-#define I2C_EXTD_STAT_I2C_BUSY          PPC_BIT(24)
-#define I2C_EXTD_STAT_SELF_BUSY         PPC_BIT(25)
-#define I2C_EXTD_STAT_I2C_VERSION       PPC_BITMASK(27, 31)
-
-/* I2C residual front end/back end length */
-#define I2C_RESIDUAL_LEN_REG            0xd
-#define I2C_RESIDUAL_FRONT_END          PPC_BITMASK(0, 15)
-#define I2C_RESIDUAL_BACK_END           PPC_BITMASK(16, 31)
-
-/* Port busy register */
-#define I2C_PORT_BUSY_REG               0xe
-#define I2C_SET_S_SCL_REG               0xd
-#define I2C_RESET_S_SCL_REG             0xf
-#define I2C_SET_S_SDA_REG               0x10
-#define I2C_RESET_S_SDA_REG             0x11
-
-#define PNV_I2C_FIFO_SIZE 8
-#define PNV_I2C_MAX_BUSSES 64
+#include "hw/i2c/pnv_i2c_regs.h"
 
 static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
 {
diff --git a/include/hw/i2c/pnv_i2c_regs.h b/include/hw/i2c/pnv_i2c_regs.h
new file mode 100644
index 0000000000..85e96ff480
--- /dev/null
+++ b/include/hw/i2c/pnv_i2c_regs.h
@@ -0,0 +1,143 @@
+/*
+ * PowerNV I2C Controller Register Definitions
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_I2C_REGS_H
+#define PNV_I2C_REGS_H
+
+/* I2C FIFO register */
+#define I2C_FIFO_REG                    0x4
+#define I2C_FIFO                        PPC_BITMASK(0, 7)
+
+/* I2C command register */
+#define I2C_CMD_REG                     0x5
+#define I2C_CMD_WITH_START              PPC_BIT(0)
+#define I2C_CMD_WITH_ADDR               PPC_BIT(1)
+#define I2C_CMD_READ_CONT               PPC_BIT(2)
+#define I2C_CMD_WITH_STOP               PPC_BIT(3)
+#define I2C_CMD_INTR_STEERING           PPC_BITMASK(6, 7) /* P9 */
+#define   I2C_CMD_INTR_STEER_HOST       1
+#define   I2C_CMD_INTR_STEER_OCC        2
+#define I2C_CMD_DEV_ADDR                PPC_BITMASK(8, 14)
+#define I2C_CMD_READ_NOT_WRITE          PPC_BIT(15)
+#define I2C_CMD_LEN_BYTES               PPC_BITMASK(16, 31)
+#define I2C_MAX_TFR_LEN                 0xfff0ull
+
+/* I2C mode register */
+#define I2C_MODE_REG                    0x6
+#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
+#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
+#define I2C_MODE_ENHANCED               PPC_BIT(28)
+#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
+#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
+#define I2C_MODE_WRAP                   PPC_BIT(31)
+
+/* I2C watermark register */
+#define I2C_WATERMARK_REG               0x7
+#define I2C_WATERMARK_HIGH              PPC_BITMASK(16, 19)
+#define I2C_WATERMARK_LOW               PPC_BITMASK(24, 27)
+
+/*
+ * I2C interrupt mask and condition registers
+ *
+ * NB: The function of 0x9 and 0xa changes depending on whether you're reading
+ *     or writing to them. When read they return the interrupt condition bits
+ *     and on writes they update the interrupt mask register.
+ *
+ *  The bit definitions are the same for all the interrupt registers.
+ */
+#define I2C_INTR_MASK_REG               0x8
+
+#define I2C_INTR_RAW_COND_REG           0x9 /* read */
+#define I2C_INTR_MASK_OR_REG            0x9 /* write*/
+
+#define I2C_INTR_COND_REG               0xa /* read */
+#define I2C_INTR_MASK_AND_REG           0xa /* write */
+
+#define I2C_INTR_ALL                    PPC_BITMASK(16, 31)
+#define I2C_INTR_INVALID_CMD            PPC_BIT(16)
+#define I2C_INTR_LBUS_PARITY_ERR        PPC_BIT(17)
+#define I2C_INTR_BKEND_OVERRUN_ERR      PPC_BIT(18)
+#define I2C_INTR_BKEND_ACCESS_ERR       PPC_BIT(19)
+#define I2C_INTR_ARBT_LOST_ERR          PPC_BIT(20)
+#define I2C_INTR_NACK_RCVD_ERR          PPC_BIT(21)
+#define I2C_INTR_DATA_REQ               PPC_BIT(22)
+#define I2C_INTR_CMD_COMP               PPC_BIT(23)
+#define I2C_INTR_STOP_ERR               PPC_BIT(24)
+#define I2C_INTR_I2C_BUSY               PPC_BIT(25)
+#define I2C_INTR_NOT_I2C_BUSY           PPC_BIT(26)
+#define I2C_INTR_SCL_EQ_1               PPC_BIT(28)
+#define I2C_INTR_SCL_EQ_0               PPC_BIT(29)
+#define I2C_INTR_SDA_EQ_1               PPC_BIT(30)
+#define I2C_INTR_SDA_EQ_0               PPC_BIT(31)
+
+/* I2C status register */
+#define I2C_RESET_I2C_REG               0xb /* write */
+#define I2C_RESET_ERRORS                0xc
+#define I2C_STAT_REG                    0xb /* read */
+#define I2C_STAT_INVALID_CMD            PPC_BIT(0)
+#define I2C_STAT_LBUS_PARITY_ERR        PPC_BIT(1)
+#define I2C_STAT_BKEND_OVERRUN_ERR      PPC_BIT(2)
+#define I2C_STAT_BKEND_ACCESS_ERR       PPC_BIT(3)
+#define I2C_STAT_ARBT_LOST_ERR          PPC_BIT(4)
+#define I2C_STAT_NACK_RCVD_ERR          PPC_BIT(5)
+#define I2C_STAT_DATA_REQ               PPC_BIT(6)
+#define I2C_STAT_CMD_COMP               PPC_BIT(7)
+#define I2C_STAT_STOP_ERR               PPC_BIT(8)
+#define I2C_STAT_UPPER_THRS             PPC_BITMASK(9, 15)
+#define I2C_STAT_ANY_I2C_INTR           PPC_BIT(16)
+#define I2C_STAT_PORT_HISTORY_BUSY      PPC_BIT(19)
+#define I2C_STAT_SCL_INPUT_LEVEL        PPC_BIT(20)
+#define I2C_STAT_SDA_INPUT_LEVEL        PPC_BIT(21)
+#define I2C_STAT_PORT_BUSY              PPC_BIT(22)
+#define I2C_STAT_INTERFACE_BUSY         PPC_BIT(23)
+#define I2C_STAT_FIFO_ENTRY_COUNT       PPC_BITMASK(24, 31)
+
+#define I2C_STAT_ANY_ERR (I2C_STAT_INVALID_CMD | I2C_STAT_LBUS_PARITY_ERR | \
+                          I2C_STAT_BKEND_OVERRUN_ERR | \
+                          I2C_STAT_BKEND_ACCESS_ERR | I2C_STAT_ARBT_LOST_ERR | \
+                          I2C_STAT_NACK_RCVD_ERR | I2C_STAT_STOP_ERR)
+
+
+#define I2C_INTR_ACTIVE \
+        ((I2C_STAT_ANY_ERR >> 16) | I2C_INTR_CMD_COMP | I2C_INTR_DATA_REQ)
+
+/* Pseudo-status used for timeouts */
+#define I2C_STAT_PSEUDO_TIMEOUT         PPC_BIT(63)
+
+/* I2C extended status register */
+#define I2C_EXTD_STAT_REG               0xc
+#define I2C_EXTD_STAT_FIFO_SIZE         PPC_BITMASK(0, 7)
+#define I2C_EXTD_STAT_MSM_CURSTATE      PPC_BITMASK(11, 15)
+#define I2C_EXTD_STAT_SCL_IN_SYNC       PPC_BIT(16)
+#define I2C_EXTD_STAT_SDA_IN_SYNC       PPC_BIT(17)
+#define I2C_EXTD_STAT_S_SCL             PPC_BIT(18)
+#define I2C_EXTD_STAT_S_SDA             PPC_BIT(19)
+#define I2C_EXTD_STAT_M_SCL             PPC_BIT(20)
+#define I2C_EXTD_STAT_M_SDA             PPC_BIT(21)
+#define I2C_EXTD_STAT_HIGH_WATER        PPC_BIT(22)
+#define I2C_EXTD_STAT_LOW_WATER         PPC_BIT(23)
+#define I2C_EXTD_STAT_I2C_BUSY          PPC_BIT(24)
+#define I2C_EXTD_STAT_SELF_BUSY         PPC_BIT(25)
+#define I2C_EXTD_STAT_I2C_VERSION       PPC_BITMASK(27, 31)
+
+/* I2C residual front end/back end length */
+#define I2C_RESIDUAL_LEN_REG            0xd
+#define I2C_RESIDUAL_FRONT_END          PPC_BITMASK(0, 15)
+#define I2C_RESIDUAL_BACK_END           PPC_BITMASK(16, 31)
+
+/* Port busy register */
+#define I2C_PORT_BUSY_REG               0xe
+#define I2C_SET_S_SCL_REG               0xd
+#define I2C_RESET_S_SCL_REG             0xf
+#define I2C_SET_S_SDA_REG               0x10
+#define I2C_RESET_S_SDA_REG             0x11
+
+#define PNV_I2C_FIFO_SIZE 8
+#define PNV_I2C_MAX_BUSSES 64
+
+#endif /* PNV_I2C_REGS_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b89e8634b..93e0bdf09e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -167,6 +167,7 @@ qtests_ppc64 = \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
new file mode 100644
index 0000000000..c635177252
--- /dev/null
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -0,0 +1,491 @@
+/*
+ * QTest testcase for PowerNV 10 Host I2C Communications
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/pca9554_regs.h"
+#include "hw/misc/pca9552_regs.h"
+#include "pnv-xscom.h"
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000 >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
+                                 PPC_BIT32(bs))
+
+#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
+#define SETFIELD(m, v, val) \
+        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+
+#define PNV10_XSCOM_I2CM_BASE   0xa0000
+#define PNV10_XSCOM_I2CM_SIZE   0x1000
+
+#include "hw/i2c/pnv_i2c_regs.h"
+
+typedef struct {
+    QTestState    *qts;
+    const PnvChip *chip;
+    int           engine;
+} PnvI2cCtlr;
+
+typedef struct {
+    PnvI2cCtlr  *ctlr;
+    int         port;
+    uint8_t     addr;
+} PnvI2cDev;
+
+
+static uint64_t pnv_i2c_xscom_addr(PnvI2cCtlr *ctlr, uint32_t reg)
+{
+    return pnv_xscom_addr(ctlr->chip, PNV10_XSCOM_I2CM_BASE +
+                          (PNV10_XSCOM_I2CM_SIZE * ctlr->engine) + reg);
+}
+
+static uint64_t pnv_i2c_xscom_read(PnvI2cCtlr *ctlr, uint32_t reg)
+{
+    return qtest_readq(ctlr->qts, pnv_i2c_xscom_addr(ctlr, reg));
+}
+
+static void pnv_i2c_xscom_write(PnvI2cCtlr *ctlr, uint32_t reg, uint64_t val)
+{
+    qtest_writeq(ctlr->qts, pnv_i2c_xscom_addr(ctlr, reg), val);
+}
+
+/* Write len bytes from buf to i2c device with given addr and port */
+static void pnv_i2c_send(PnvI2cDev *dev, const uint8_t *buf, uint16_t len)
+{
+    int byte_num;
+    uint64_t reg64;
+
+    /* select requested port */
+    reg64 = SETFIELD(I2C_MODE_BIT_RATE_DIV, 0ull, 0x2be);
+    reg64 = SETFIELD(I2C_MODE_PORT_NUM, reg64, dev->port);
+    pnv_i2c_xscom_write(dev->ctlr, I2C_MODE_REG, reg64);
+
+    /* check status for cmd complete and bus idle */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_EXTD_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_EXTD_STAT_I2C_BUSY, ==, 0);
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & (I2C_STAT_ANY_ERR | I2C_STAT_CMD_COMP), ==,
+                    I2C_STAT_CMD_COMP);
+
+    /* Send start, with stop, with address and len bytes of data */
+    reg64 = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR | I2C_CMD_WITH_STOP;
+    reg64 = SETFIELD(I2C_CMD_DEV_ADDR, reg64, dev->addr);
+    reg64 = SETFIELD(I2C_CMD_LEN_BYTES, reg64, len);
+    pnv_i2c_xscom_write(dev->ctlr, I2C_CMD_REG, reg64);
+
+    /* check status for errors */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_STAT_ANY_ERR, ==, 0);
+
+    /* write data bytes to fifo register */
+    for (byte_num = 0; byte_num < len; byte_num++) {
+        reg64 = SETFIELD(I2C_FIFO, 0ull, buf[byte_num]);
+        pnv_i2c_xscom_write(dev->ctlr, I2C_FIFO_REG, reg64);
+    }
+
+    /* check status for cmd complete and bus idle */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_EXTD_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_EXTD_STAT_I2C_BUSY, ==, 0);
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & (I2C_STAT_ANY_ERR | I2C_STAT_CMD_COMP), ==,
+                    I2C_STAT_CMD_COMP);
+}
+
+/* Recieve len bytes into buf from i2c device with given addr and port */
+static void pnv_i2c_recv(PnvI2cDev *dev, uint8_t *buf, uint16_t len)
+{
+    int byte_num;
+    uint64_t reg64;
+
+    /* select requested port */
+    reg64 = SETFIELD(I2C_MODE_BIT_RATE_DIV, 0ull, 0x2be);
+    reg64 = SETFIELD(I2C_MODE_PORT_NUM, reg64, dev->port);
+    pnv_i2c_xscom_write(dev->ctlr, I2C_MODE_REG, reg64);
+
+    /* check status for cmd complete and bus idle */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_EXTD_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_EXTD_STAT_I2C_BUSY, ==, 0);
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & (I2C_STAT_ANY_ERR | I2C_STAT_CMD_COMP), ==,
+                    I2C_STAT_CMD_COMP);
+
+    /* Send start, with stop, with address and len bytes of data */
+    reg64 = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR |
+            I2C_CMD_WITH_STOP | I2C_CMD_READ_NOT_WRITE;
+    reg64 = SETFIELD(I2C_CMD_DEV_ADDR, reg64, dev->addr);
+    reg64 = SETFIELD(I2C_CMD_LEN_BYTES, reg64, len);
+    pnv_i2c_xscom_write(dev->ctlr, I2C_CMD_REG, reg64);
+
+    /* check status for errors */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_STAT_ANY_ERR, ==, 0);
+
+    /* Read data bytes from fifo register */
+    for (byte_num = 0; byte_num < len; byte_num++) {
+        reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_FIFO_REG);
+        buf[byte_num] = GETFIELD(I2C_FIFO, reg64);
+    }
+
+    /* check status for cmd complete and bus idle */
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_EXTD_STAT_REG);
+    g_assert_cmphex(reg64 & I2C_EXTD_STAT_I2C_BUSY, ==, 0);
+    reg64 = pnv_i2c_xscom_read(dev->ctlr, I2C_STAT_REG);
+    g_assert_cmphex(reg64 & (I2C_STAT_ANY_ERR | I2C_STAT_CMD_COMP), ==,
+                    I2C_STAT_CMD_COMP);
+}
+
+static void pnv_i2c_pca9554_default_cfg(PnvI2cDev *dev)
+{
+    uint8_t buf[2];
+
+    /* input register bits are not inverted */
+    buf[0] = PCA9554_POLARITY;
+    buf[1] = 0;
+    pnv_i2c_send(dev, buf, 2);
+
+    /* All pins are inputs */
+    buf[0] = PCA9554_CONFIG;
+    buf[1] = 0xff;
+    pnv_i2c_send(dev, buf, 2);
+
+    /* Output value for when pins are outputs */
+    buf[0] = PCA9554_OUTPUT;
+    buf[1] = 0xff;
+    pnv_i2c_send(dev, buf, 2);
+}
+
+static void pnv_i2c_pca9554_set_pin(PnvI2cDev *dev, int pin, bool high)
+{
+    uint8_t send_buf[2];
+    uint8_t recv_buf[2];
+    uint8_t mask = 0x1 << pin;
+    uint8_t new_value = ((high) ? 1 : 0) << pin;
+
+    /* read current OUTPUT value */
+    send_buf[0] = PCA9554_OUTPUT;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+
+    /* write new OUTPUT value */
+    send_buf[1] = (recv_buf[0] & ~mask) | new_value;
+    pnv_i2c_send(dev, send_buf, 2);
+
+    /* Update config bit for output */
+    send_buf[0] = PCA9554_CONFIG;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+    send_buf[1] = recv_buf[0] & ~mask;
+    pnv_i2c_send(dev, send_buf, 2);
+}
+
+static uint8_t pnv_i2c_pca9554_read_pins(PnvI2cDev *dev)
+{
+    uint8_t send_buf[1];
+    uint8_t recv_buf[1];
+    uint8_t inputs;
+    send_buf[0] = PCA9554_INPUT;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+    inputs = recv_buf[0];
+    return inputs;
+}
+
+static void pnv_i2c_pca9554_flip_polarity(PnvI2cDev *dev)
+{
+    uint8_t recv_buf[1];
+    uint8_t send_buf[2];
+
+    send_buf[0] = PCA9554_POLARITY;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+    send_buf[1] = recv_buf[0] ^ 0xff;
+    pnv_i2c_send(dev, send_buf, 2);
+}
+
+static void pnv_i2c_pca9554_default_inputs(PnvI2cDev *dev)
+{
+    uint8_t pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0xff);
+}
+
+/* Check that setting pin values and polarity changes inputs as expected */
+static void pnv_i2c_pca554_set_pins(PnvI2cDev *dev)
+{
+    uint8_t pin_values;
+    pnv_i2c_pca9554_set_pin(dev, 0, 0);
+    pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0xfe);
+    pnv_i2c_pca9554_flip_polarity(dev);
+    pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0x01);
+    pnv_i2c_pca9554_set_pin(dev, 2, 0);
+    pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0x05);
+    pnv_i2c_pca9554_flip_polarity(dev);
+    pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0xfa);
+    pnv_i2c_pca9554_default_cfg(dev);
+    pin_values = pnv_i2c_pca9554_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0xff);
+}
+
+static void pnv_i2c_pca9552_default_cfg(PnvI2cDev *dev)
+{
+    uint8_t buf[2];
+    /* configure pwm/psc regs */
+    buf[0] = PCA9552_PSC0;
+    buf[1] = 0xff;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_PWM0;
+    buf[1] = 0x80;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_PSC1;
+    buf[1] = 0xff;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_PWM1;
+    buf[1] = 0x80;
+    pnv_i2c_send(dev, buf, 2);
+
+    /* configure all pins as inputs */
+    buf[0] = PCA9552_LS0;
+    buf[1] = 0x55;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_LS1;
+    buf[1] = 0x55;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_LS2;
+    buf[1] = 0x55;
+    pnv_i2c_send(dev, buf, 2);
+    buf[0] = PCA9552_LS3;
+    buf[1] = 0x55;
+    pnv_i2c_send(dev, buf, 2);
+}
+
+static void pnv_i2c_pca9552_set_pin(PnvI2cDev *dev, int pin, bool high)
+{
+    uint8_t send_buf[2];
+    uint8_t recv_buf[2];
+    uint8_t reg = PCA9552_LS0 + (pin / 4);
+    uint8_t shift = (pin % 4) * 2;
+    uint8_t mask = ~(0x3 << shift);
+    uint8_t new_value = ((high) ? 1 : 0) << shift;
+
+    /* read current LSx value */
+    send_buf[0] = reg;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+
+    /* write new value to LSx */
+    send_buf[1] = (recv_buf[0] & mask) | new_value;
+    pnv_i2c_send(dev, send_buf, 2);
+}
+
+static uint16_t pnv_i2c_pca9552_read_pins(PnvI2cDev *dev)
+{
+    uint8_t send_buf[2];
+    uint8_t recv_buf[2];
+    uint16_t inputs;
+    send_buf[0] = PCA9552_INPUT0;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+    inputs = recv_buf[0];
+    send_buf[0] = PCA9552_INPUT1;
+    pnv_i2c_send(dev, send_buf, 1);
+    pnv_i2c_recv(dev, recv_buf, 1);
+    inputs |= recv_buf[0] << 8;
+    return inputs;
+}
+
+static void pnv_i2c_pca9552_default_inputs(PnvI2cDev *dev)
+{
+    uint16_t pin_values = pnv_i2c_pca9552_read_pins(dev);
+    g_assert_cmphex(pin_values, ==, 0xffff);
+}
+
+/*
+ * Set pins 0-4 one at a time and verify that pins 5-9 are
+ * set to the same value
+ */
+static void pnv_i2c_pca552_set_pins(PnvI2cDev *dev)
+{
+    uint16_t pin_values;
+
+    /* set pin 0 low */
+    pnv_i2c_pca9552_set_pin(dev, 0, 0);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* pins 0 and 5 should be low */
+    g_assert_cmphex(pin_values, ==, 0xffde);
+
+    /* set pin 1 low */
+    pnv_i2c_pca9552_set_pin(dev, 1, 0);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* pins 0, 1, 5 and 6 should be low */
+    g_assert_cmphex(pin_values, ==, 0xff9c);
+
+    /* set pin 2 low */
+    pnv_i2c_pca9552_set_pin(dev, 2, 0);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* pins 0, 1, 2, 5, 6 and 7 should be low */
+    g_assert_cmphex(pin_values, ==, 0xff18);
+
+    /* set pin 3 low */
+    pnv_i2c_pca9552_set_pin(dev, 3, 0);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* pins 0, 1, 2, 3, 5, 6, 7 and 8 should be low */
+    g_assert_cmphex(pin_values, ==, 0xfe10);
+
+    /* set pin 4 low */
+    pnv_i2c_pca9552_set_pin(dev, 4, 0);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* pins 0, 1, 2, 3, 5, 6, 7, 8 and 9 should be low */
+    g_assert_cmphex(pin_values, ==, 0xfc00);
+
+    /* reset all pins to the high state */
+    pnv_i2c_pca9552_default_cfg(dev);
+    pin_values = pnv_i2c_pca9552_read_pins(dev);
+
+    /* verify all pins went back to the high state */
+    g_assert_cmphex(pin_values, ==, 0xffff);
+}
+
+static void reset_engine(PnvI2cCtlr *ctlr)
+{
+    pnv_i2c_xscom_write(ctlr, I2C_RESET_I2C_REG, 0);
+}
+
+static void check_i2cm_por_regs(QTestState *qts, const PnvChip *chip)
+{
+    int engine;
+    for (engine = 0; engine < chip->num_i2c; engine++) {
+        PnvI2cCtlr ctlr;
+        ctlr.qts = qts;
+        ctlr.chip = chip;
+        ctlr.engine = engine;
+
+        /* Check version in Extended Status Register */
+        uint64_t value = pnv_i2c_xscom_read(&ctlr, I2C_EXTD_STAT_REG);
+        g_assert_cmphex(value & I2C_EXTD_STAT_I2C_VERSION, ==, 0x1700000000);
+
+        /* Check for command complete and bus idle in Status Register */
+        value = pnv_i2c_xscom_read(&ctlr, I2C_STAT_REG);
+        g_assert_cmphex(value & (I2C_STAT_ANY_ERR | I2C_STAT_CMD_COMP),
+                        ==,
+                        I2C_STAT_CMD_COMP);
+    }
+}
+
+static void reset_all(QTestState *qts, const PnvChip *chip)
+{
+    int engine;
+    for (engine = 0; engine < chip->num_i2c; engine++) {
+        PnvI2cCtlr ctlr;
+        ctlr.qts = qts;
+        ctlr.chip = chip;
+        ctlr.engine = engine;
+        reset_engine(&ctlr);
+        pnv_i2c_xscom_write(&ctlr, I2C_MODE_REG, 0x02be040000000000);
+    }
+}
+
+static void test_host_i2c(const void *data)
+{
+    const PnvChip *chip = data;
+    QTestState *qts;
+    const char *machine = "powernv8";
+    PnvI2cCtlr ctlr;
+    PnvI2cDev pca9552;
+    PnvI2cDev pca9554;
+
+    if (chip->chip_type == PNV_CHIP_POWER9) {
+        machine = "powernv9";
+    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10-rainier";
+    }
+
+    qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
+                      "-nodefaults -serial mon:stdio -S "
+                      "-d guest_errors",
+                      machine, SMT, SMT);
+
+    /* Check the I2C master status registers after POR */
+    check_i2cm_por_regs(qts, chip);
+
+    /* Now do a forced "immediate" reset on all engines */
+    reset_all(qts, chip);
+
+    /* Check that the status values are still good */
+    check_i2cm_por_regs(qts, chip);
+
+    /* P9 doesn't have any i2c devices attached at this time */
+    if (chip->chip_type != PNV_CHIP_POWER10) {
+        qtest_quit(qts);
+        return;
+    }
+
+    /* Initialize for a P10 pca9552 hotplug device */
+    ctlr.qts = qts;
+    ctlr.chip = chip;
+    ctlr.engine = 2;
+    pca9552.ctlr = &ctlr;
+    pca9552.port = 1;
+    pca9552.addr = 0x63;
+
+    /* Set all pca9552 pins as inputs */
+    pnv_i2c_pca9552_default_cfg(&pca9552);
+
+    /* Check that all pins of the pca9552 are high */
+    pnv_i2c_pca9552_default_inputs(&pca9552);
+
+    /* perform individual pin tests */
+    pnv_i2c_pca552_set_pins(&pca9552);
+
+    /* Initialize for a P10 pca9554 CableCard Presence detection device */
+    pca9554.ctlr = &ctlr;
+    pca9554.port = 1;
+    pca9554.addr = 0x25;
+
+    /* Set all pca9554 pins as inputs */
+    pnv_i2c_pca9554_default_cfg(&pca9554);
+
+    /* Check that all pins of the pca9554 are high */
+    pnv_i2c_pca9554_default_inputs(&pca9554);
+
+    /* perform individual pin tests */
+    pnv_i2c_pca554_set_pins(&pca9554);
+
+    qtest_quit(qts);
+}
+
+static void add_test(const char *name, void (*test)(const void *data))
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
+                                      pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test);
+        g_free(tname);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    add_test("host-i2c", test_host_i2c);
+    return g_test_run();
+}
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index 8a5ac11037..c814c0f4f5 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -10,66 +10,7 @@
 
 #include "libqtest.h"
 
-typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
-    PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
-    PNV_CHIP_POWER9,      /* AKA Nimbus */
-    PNV_CHIP_POWER10,
-} PnvChipType;
-
-typedef struct PnvChip {
-    PnvChipType chip_type;
-    const char *cpu_model;
-    uint64_t    xscom_base;
-    uint64_t    cfam_id;
-    uint32_t    first_core;
-} PnvChip;
-
-static const PnvChip pnv_chips[] = {
-    {
-        .chip_type  = PNV_CHIP_POWER8,
-        .cpu_model  = "POWER8",
-        .xscom_base = 0x0003fc0000000000ull,
-        .cfam_id    = 0x220ea04980000000ull,
-        .first_core = 0x1,
-    }, {
-        .chip_type  = PNV_CHIP_POWER8NVL,
-        .cpu_model  = "POWER8NVL",
-        .xscom_base = 0x0003fc0000000000ull,
-        .cfam_id    = 0x120d304980000000ull,
-        .first_core = 0x1,
-    },
-    {
-        .chip_type  = PNV_CHIP_POWER9,
-        .cpu_model  = "POWER9",
-        .xscom_base = 0x000603fc00000000ull,
-        .cfam_id    = 0x220d104900008000ull,
-        .first_core = 0x0,
-    },
-    {
-        .chip_type  = PNV_CHIP_POWER10,
-        .cpu_model  = "POWER10",
-        .xscom_base = 0x000603fc00000000ull,
-        .cfam_id    = 0x120da04900008000ull,
-        .first_core = 0x0,
-    },
-};
-
-static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
-{
-    uint64_t addr = chip->xscom_base;
-
-    if (chip->chip_type == PNV_CHIP_POWER10) {
-        addr |= ((uint64_t) pcba << 3);
-    } else if (chip->chip_type == PNV_CHIP_POWER9) {
-        addr |= ((uint64_t) pcba << 3);
-    } else {
-        addr |= (((uint64_t) pcba << 4) & ~0xffull) |
-            (((uint64_t) pcba << 3) & 0x78);
-    }
-    return addr;
-}
+#include "pnv-xscom.h"
 
 static uint64_t pnv_xscom_read(QTestState *qts, const PnvChip *chip,
                                uint32_t pcba)
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
new file mode 100644
index 0000000000..6f62941744
--- /dev/null
+++ b/tests/qtest/pnv-xscom.h
@@ -0,0 +1,80 @@
+/*
+ * PowerNV XSCOM Bus
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_XSCOM_H
+#define PNV_XSCOM_H
+
+#define SMT                     4 /* some tests will break if less than 4 */
+
+typedef enum PnvChipType {
+    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
+    PNV_CHIP_POWER8,      /* AKA Venice */
+    PNV_CHIP_POWER8NVL,   /* AKA Naples */
+    PNV_CHIP_POWER9,      /* AKA Nimbus */
+    PNV_CHIP_POWER10,
+} PnvChipType;
+
+typedef struct PnvChip {
+    PnvChipType chip_type;
+    const char *cpu_model;
+    uint64_t    xscom_base;
+    uint64_t    cfam_id;
+    uint32_t    first_core;
+    uint32_t    num_i2c;
+} PnvChip;
+
+static const PnvChip pnv_chips[] = {
+    {
+        .chip_type  = PNV_CHIP_POWER8,
+        .cpu_model  = "POWER8",
+        .xscom_base = 0x0003fc0000000000ull,
+        .cfam_id    = 0x220ea04980000000ull,
+        .first_core = 0x1,
+        .num_i2c    = 0,
+    }, {
+        .chip_type  = PNV_CHIP_POWER8NVL,
+        .cpu_model  = "POWER8NVL",
+        .xscom_base = 0x0003fc0000000000ull,
+        .cfam_id    = 0x120d304980000000ull,
+        .first_core = 0x1,
+        .num_i2c    = 0,
+    },
+    {
+        .chip_type  = PNV_CHIP_POWER9,
+        .cpu_model  = "POWER9",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x220d104900008000ull,
+        .first_core = 0x0,
+        .num_i2c    = 4,
+    },
+    {
+        .chip_type  = PNV_CHIP_POWER10,
+        .cpu_model  = "POWER10",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x120da04900008000ull,
+        .first_core = 0x0,
+        .num_i2c    = 4,
+    },
+};
+
+static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
+{
+    uint64_t addr = chip->xscom_base;
+
+    if (chip->chip_type == PNV_CHIP_POWER10) {
+        addr |= ((uint64_t) pcba << 3);
+    } else if (chip->chip_type == PNV_CHIP_POWER9) {
+        addr |= ((uint64_t) pcba << 3);
+    } else {
+        addr |= (((uint64_t) pcba << 4) & ~0xffull) |
+            (((uint64_t) pcba << 3) & 0x78);
+    }
+    return addr;
+}
+
+#endif /* PNV_XSCOM_H */
-- 
2.42.0


