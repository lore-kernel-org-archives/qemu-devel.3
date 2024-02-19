Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A3AC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4k-0005zP-Mw; Mon, 19 Feb 2024 03:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4d-0005GG-Tr; Mon, 19 Feb 2024 03:32:28 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4b-0002bC-Bb; Mon, 19 Feb 2024 03:32:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d7881b1843so34373595ad.3; 
 Mon, 19 Feb 2024 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331542; x=1708936342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+oPM12tWxnBSsHCiXIjAZTIQlwfOLUqo3EB/1FOic8=;
 b=gwLOMGttlaLBq0vtTblyUkhf16fM1wo32bM0wJyD4cJVtjFipWqpulC344vI2h/rH6
 0k8rweCnm+OtKq1GN9m4qJmBaerKRSOxNvPUz8175dVPIMRsvmjWureQ5Q6WKT03HwHK
 8+HpUnLm6Y1Rx2ARBzMObCTYu7HMeP6raBW1Snd2chWbRXfKBCV4Byga4Mdq8EsFCvjq
 iDbBg/4E1nYNdTrQJEtU1GHy5kqAXv/v2ofV9FBWoymBmc2ri34ujO1HT9mJin6EubaX
 8V5Wx5/uPb/ON/kGL8R3RTVWliP8qiOnY0zO8diVnwE6D8VVnjOTO6p39MDeOJWHEG6h
 0P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331542; x=1708936342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+oPM12tWxnBSsHCiXIjAZTIQlwfOLUqo3EB/1FOic8=;
 b=p26C8fiCLqlhczetJfH5XNIyYDn0tFxltwuhpxsypY+xZOpT1YAT94lbxgxVRatTuW
 DHsxild0ERONN9xTXD83M3NMOBOpY9WZ9wTdo2CPjZpF4OXhkVsoTLy6RzbA7+usRXsW
 wMsy3ieE9vG37DSFe4jjnRGquDkhCEwlLxlUtiVW7O3Vsw0G483CSOttpS3EacLZ7UUr
 KhMXoKJTUmvSmGVfPuu6mxyxW+s0XiWRwglIhR175xla9vIo3Lm8R97z+uTdDciuD889
 gBgwEHUo6RxRFvXc8r4+OhpO3+gsR9KOXLsh+tjcKv0DJz2CQlRJXBJ2drl5P1EKY7Fd
 /Dcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsSNytBfkfE5mLcj4NRjiAWmvUp108MnHsBF7uXfEIC6NaEv4r2nFJINCzemo/xddiClsAqmU/2tUkiaL/Oe+EzuIr
X-Gm-Message-State: AOJu0YxO5QHoeeSGvhU00ukFLk6VNXo75QY6l6N81K7ksn7GUvQ4Qabn
 q0GWwPIrMUIdJvQHh8cJhVBYfdVthrFL98cjQfMKplPjXTVZmviL+92AbDDa
X-Google-Smtp-Source: AGHT+IHtMFpq7J+9zoj3G+qCM7YMgwPa/oiui7up7R3xCwnOzZcZNYM0kCZUEU0Psjc0EBq+RvPwfQ==
X-Received: by 2002:a17:902:db0e:b0:1d9:b9da:ea8f with SMTP id
 m14-20020a170902db0e00b001d9b9daea8fmr16268246plx.2.1708331542105; 
 Mon, 19 Feb 2024 00:32:22 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 32/49] hw/ppc: Add pnv nest pervasive common chiplet model
Date: Mon, 19 Feb 2024 18:29:21 +1000
Message-ID: <20240219082938.238302-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

A POWER10 chip is divided into logical units called chiplets. Chiplets
are broadly divided into "core chiplets" (with the processor cores) and
"nest chiplets" (with everything else). Each chiplet has an attachment
to the pervasive bus (PIB) and with chiplet-specific registers. All nest
chiplets have a common basic set of registers and This model will provide
the registers functionality for common registers of nest chiplet (Pervasive
Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)

This commit implement the read/write functions of chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build                  |   1 +
 hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
 include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
 include/hw/ppc/pnv_xscom.h          |   3 +
 4 files changed, 244 insertions(+)
 create mode 100644 hw/ppc/pnv_nest_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 30bd2aaccf..e46c9bcd7b 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -53,6 +53,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_nest_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
new file mode 100644
index 0000000000..77476753a4
--- /dev/null
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -0,0 +1,208 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+/*
+ * Status, configuration, and control units in POWER chips is provided
+ * by the pervasive subsystem, which connects registers to the SCOM bus,
+ * which can be programmed by processor cores, other units on the chip,
+ * BMCs, or other POWER chips.
+ *
+ * A POWER10 chip is divided into logical units called chiplets. Chiplets
+ * are broadly divided into "core chiplets" (with the processor cores) and
+ * "nest chiplets" (with everything else). Each chiplet has an attachment
+ * to the pervasive bus (PIB) and with chiplet-specific registers.
+ * All nest chiplets have a common basic set of registers.
+ *
+ * This model will provide the registers functionality for common registers of
+ * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
+ *
+ * Currently this model provide the read/write functionality of chiplet control
+ * scom registers.
+ */
+
+#define CPLT_CONF0               0x08
+#define CPLT_CONF0_OR            0x18
+#define CPLT_CONF0_CLEAR         0x28
+#define CPLT_CONF1               0x09
+#define CPLT_CONF1_OR            0x19
+#define CPLT_CONF1_CLEAR         0x29
+#define CPLT_STAT0               0x100
+#define CPLT_MASK0               0x101
+#define CPLT_PROTECT_MODE        0x3FE
+#define CPLT_ATOMIC_CLOCK        0x3FF
+
+static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            return nest_pervasive->control_regs.cplt_ctrl[i];
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%" PRIx32 "\n",
+                                           __func__, reg);
+            return val;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        val = nest_pervasive->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
+        break;
+    case CPLT_CONF1:
+        val = nest_pervasive->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
+        break;
+    case CPLT_STAT0:
+        val = nest_pervasive->control_regs.cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = nest_pervasive->control_regs.cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = nest_pervasive->control_regs.ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = nest_pervasive->control_regs.ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%" PRIx32 "\n", __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            nest_pervasive->control_regs.cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        nest_pervasive->control_regs.cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        nest_pervasive->control_regs.cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        nest_pervasive->control_regs.cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        nest_pervasive->control_regs.cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        nest_pervasive->control_regs.cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        nest_pervasive->control_regs.cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        nest_pervasive->control_regs.ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        nest_pervasive->control_regs.ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                                 "write at 0x%" PRIx32 "\n",
+                                 __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nest_pervasive_control_xscom_ops = {
+    .read = pnv_chiplet_ctrl_read,
+    .write = pnv_chiplet_ctrl_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(dev);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
+                          OBJECT(nest_pervasive),
+                          &pnv_nest_pervasive_control_xscom_ops,
+                          nest_pervasive, "pervasive-control",
+                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
+}
+
+static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV nest pervasive chiplet";
+    dc->realize = pnv_nest_pervasive_realize;
+}
+
+static const TypeInfo pnv_nest_pervasive_info = {
+    .name          = TYPE_PNV_NEST_CHIPLET_PERVASIVE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNestChipletPervasive),
+    .class_init    = pnv_nest_pervasive_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nest_pervasive_register_types(void)
+{
+    type_register_static(&pnv_nest_pervasive_info);
+}
+
+type_init(pnv_nest_pervasive_register_types);
diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
new file mode 100644
index 0000000000..73cacf3823
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_pervasive.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+#define PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+
+#define TYPE_PNV_NEST_CHIPLET_PERVASIVE "pnv-nest-chiplet-pervasive"
+#define PNV_NEST_CHIPLET_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_CHIPLET_PERVASIVE)
+
+typedef struct PnvPervasiveCtrlRegs {
+#define PNV_CPLT_CTRL_SIZE 6
+    uint64_t cplt_ctrl[PNV_CPLT_CTRL_SIZE];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} PnvPervasiveCtrlRegs;
+
+typedef struct PnvNestChipletPervasive {
+    DeviceState             parent;
+    MemoryRegion            xscom_ctrl_regs_mr;
+    PnvPervasiveCtrlRegs    control_regs;
+} PnvNestChipletPervasive;
+
+#endif /*PPC_PNV_NEST_CHIPLET_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..3e15706dec 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
+#define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
-- 
2.42.0


