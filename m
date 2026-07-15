Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BDBC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2bA-0006xY-Le; Wed, 15 Jul 2026 12:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tN-00008y-Bh; Wed, 15 Jul 2026 11:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tJ-0004ju-4v; Wed, 15 Jul 2026 11:51:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBmUU2698744; Wed, 15 Jul 2026 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q6GIqnns05CYELMS4
 SLCWZI023vXRpxpuUFYJgxlNDU=; b=q9MZwjsuK5OSvNu+u2RMABT0eoH5gdQfZ
 kVdJ7vOHGTOJWUU6b+EjxoVAgoxC3EIFOD0DkyteJBjfCEI+MolSIqHtjYEXdY6m
 3+J/9a5ZwD1x4T0ER20SMG9HW2nLCMNxXHlzioAsao8pi1HQmmjWgO31DoqOErdg
 QMXbnx93sHft4a68fBvLv84QuOcurTOIp8i9Cyl+nZiosWjn5JOENgUmPR0yuNfV
 w0IVaCIC3MlZt3fCs4Uy4cS1NjRtwUJAEQ6viuznApCPk4d28ooUbSJprkcrT7Gu
 APdblGVxsLoCMVUfxY0AMfCyPfWBPxRFr+J3Lx27vE4N1SP/67yxw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33cwsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFYanK008961;
 Wed, 15 Jul 2026 15:50:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhgnfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FFokm315139506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 15:50:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F18558055;
 Wed, 15 Jul 2026 15:50:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3435A58066;
 Wed, 15 Jul 2026 15:50:45 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.53.88])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 15:50:45 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] fsi/cfam: Add CFAM-S model for AST2700
Date: Wed, 15 Jul 2026 10:50:33 -0500
Message-ID: <20260715155037.2237011-3-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715155037.2237011-1-mikail.sadic@ibm.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX6qqtmZP2wHNR
 IxIkrGmXekyUznTjQq4DhMIQ2dARajIUWadpfunksXajSzd4OosDDJOdnaFr5Ew4bYpOfsK3PUj
 TkXbdT8tXoOfEDpVpvSi+9Qar7oGDno=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a57ac59 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=hlc7J7oksK3d7pNsUkIA:9
X-Proofpoint-GUID: jYDlXFIhEnyphWwK9SosX3REwzAyQKCf
X-Proofpoint-ORIG-GUID: hX-mOLle1lFkmcwKIKfQ-A85PMrcqAZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX7/cx9JpQE8Ja
 sVTdUCTZub0mNXwtJbO/e25h17R5qx5FneD/tVhZNQzzFdKQ2ytULUWtbg0xBxEM669Z3LwY4zN
 yjjSFshIKDC+Yj8apX/DrAp+7jvHbxOwyzH/fg4wfrhv7xD4eFe50wgksVLfx1Mvdeo0ghxYu2N
 2hP8VBYNhC7OBi8nZ98RpqOMiCsNEO6vpuuD5AZn+rrzOlWKec7ZMxaOqFUZ94DJCv4D9mOmYU/
 i708Y7ntlcc8dTI4JFq+kHCWjjS4RvKWK0NSv65DDUGFsexG4l8mZQtTed7xUhu+UPw+V6aOUD+
 NItQVxpvOtx9hHP7DWYRdiB+ai9GOvmvaFyfGVGzkBF/uRaIe0z8qjCSFpR5beqdTeulUFztLSr
 II8GjYyQ5Fc20NqQCSEGWDa7EIMZ+KL4MFb2Gl9GxkzbIDCuFTD6JSY+8OqjL1NfVdVG2qpM3X3
 Y1m/vapFJ0fln8CVZUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 12:36:14 -0400
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

Introduce TYPE_FSI_CFAM_S as a dedicated QOM type that presents the
config table and mailbox scratch registers expected by the new Linux
FSI responder framework. FSIMasterState gains a cfam_s field.
fsi_master_realize() instantiates both cfam (at offset 0) and cfam-s
(at offset 2 MiB) into the OPB-to-FSI aperture. aspeed_ast27x0.c wires
up both fsi[0] and fsi[1] APB-to-OPB bridges for the AST2700 SoC.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 docs/specs/fsi.rst          |  58 +++++++++++++++
 include/hw/fsi/cfam-s.h     |  26 +++++++
 include/hw/fsi/fsi-master.h |   2 +
 hw/arm/aspeed_ast27x0.c     |  18 +++++
 hw/fsi/cfam-s.c             | 145 ++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi-master.c         |  10 ++-
 hw/fsi/meson.build          |   2 +-
 7 files changed, 258 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 hw/fsi/cfam-s.c

diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
index f7d86d3e37..a8896b67ef 100644
--- a/docs/specs/fsi.rst
+++ b/docs/specs/fsi.rst
@@ -120,3 +120,61 @@ from the BMC. (see the `pdbg source repository`_ for more details)
 
 .. _pdbg source repository:
    https://github.com/open-power/pdbg
+
+CFAM-S model (AST2700)
+----------------------
+
+The AST2700 uses a CFAM variant known as the CFAM-S, required by the new
+Linux FSI responder framework. A dedicated QOM type, ``TYPE_FSI_CFAM_S``
+(``"cfam-s"``), implements this alongside the existing ``TYPE_FSI_CFAM``
+(``"cfam"``) used by the AST2600 machines.
+
+``FSIMasterState`` realizes both ``cfam`` and ``cfam-s``. The regular
+``cfam`` is mapped at offset 0 into the OPB-to-FSI aperture; ``cfam-s`` is
+mapped at offset 2 MiB. The DTS overrides ``fsim0`` with
+``compatible = "aspeed,ast2600-fsi-master"`` and ``reg = <0x21800000>``,
+pointing the kernel FSI driver at the QEMU APB-to-OPB bridge, which routes
+through the FSI master's OPB-to-FSI window to reach the CFAM-S.
+
+The CFAM-S model presents an 8 MiB region and folds the SID bits ``[22:21]``
+so both the SID_BREAK enumeration view (``0x600000``) and the runtime view
+(``0x000000``) address the same register space. The config table at folded
+offset ``0x000`` contains three CRC4-valid words: a chip_id word with
+``MAJOR=9`` (selecting the ``cfam_s`` kernel driver), a responder engine
+entry (``TYPE=0x3``), and a mailbox v1 engine entry (``TYPE=0x14``) at
+engine address ``0x800``.
+
+The responder registers at folded offset ``0x400`` implement ``SMODE``,
+``SSTAT``, ``SRES``, ``SSISM``, and ``SLBUS`` with store-on-write semantics.
+The mailbox scratch registers at folded offset ``0x8e0`` are five stateful
+32-bit registers served to the ``ibm,mbox-cfam-s`` kernel driver, which
+creates ``/dev/fsi/mbox0``.
+
+The following commands start the ``huygens-bmc`` machine with the built-in
+CFAM-S model. There are no model specific arguments. Please check this
+document to learn more about Aspeed ``huygens-bmc`` machine:
+(:doc:`../../system/arm/aspeed`)
+
+.. code-block:: console
+
+  qemu-system-aarch64 -M huygens-bmc \
+    -drive file=image-bmc,if=mtd,format=raw \
+    -drive file=ufs.img,if=none,format=raw \
+    -nographic
+
+The CFAM-S appears as follows in the QEMU device tree:
+
+.. code-block:: console
+
+  (qemu) info qtree
+  bus: main-system-bus
+    type System
+    ...
+    dev: aspeed.apb2opb, id ""
+      mmio 0000000021800000/0000000000001000
+      bus: opb.0
+        type opb
+        dev: fsi.master, id ""
+          bus: fsi.bus.0
+            type fsi.bus
+            dev: cfam-s, id ""
diff --git a/include/hw/fsi/cfam-s.h b/include/hw/fsi/cfam-s.h
new file mode 100644
index 0000000000..3793b01471
--- /dev/null
+++ b/include/hw/fsi/cfam-s.h
@@ -0,0 +1,26 @@
+/*
+ * IBM Common FRU Access Macro - S variant (CFAM-S)
+ *
+ * Copyright (C) 2026 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FSI_CFAM_S_H
+#define FSI_CFAM_S_H
+
+#include "system/memory.h"
+#include "hw/fsi/fsi.h"
+
+#define TYPE_FSI_CFAM_S "cfam-s"
+#define FSI_CFAM_S(obj) OBJECT_CHECK(FSICFAMSState, (obj), TYPE_FSI_CFAM_S)
+
+#define CFAM_S_MBOX_SCRATCH_NUM 5
+
+typedef struct FSICFAMSState {
+    FSISlaveState parent;
+
+    MemoryRegion mr;
+    uint32_t mbox_scratch[CFAM_S_MBOX_SCRATCH_NUM];
+} FSICFAMSState;
+
+#endif /* FSI_CFAM_S_H */
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index 60ddaa994f..6a2782fdf2 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -11,6 +11,7 @@
 #include "hw/core/qdev.h"
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/cfam.h"
+#include "hw/fsi/cfam-s.h"
 
 #define TYPE_FSI_MASTER "fsi.master"
 OBJECT_DECLARE_SIMPLE_TYPE(FSIMasterState, FSI_MASTER)
@@ -26,6 +27,7 @@ typedef struct FSIMasterState {
 
     uint32_t regs[FSI_MASTER_NR_REGS];
     FSICFAMState cfam;
+    FSICFAMSState cfam_s;
 } FSIMasterState;
 
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dddd7d2106..b908d7d4ff 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
+#include "hw/fsi/aspeed_apb2opb.h"
 #include "net/net.h"
 #include "system/qtest.h"
 #include "system/system.h"
@@ -98,6 +99,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
+    [ASPEED_DEV_FSI1]      =  0x21800000,
+    [ASPEED_DEV_FSI2]      =  0x23800000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
@@ -559,6 +562,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
                              sc->silicon_rev);
     }
 
+    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
+        object_initialize_child(obj, "fsi[*]", &s->fsi[i],
+                                TYPE_ASPEED_APB2OPB);
+    }
+
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem", &s->iomem,
@@ -1132,6 +1140,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* FSI / OPB */
+    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
+                        sc->memmap[ASPEED_DEV_FSI1 + i]);
+    }
+
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
diff --git a/hw/fsi/cfam-s.c b/hw/fsi/cfam-s.c
new file mode 100644
index 0000000000..bf000d1879
--- /dev/null
+++ b/hw/fsi/cfam-s.c
@@ -0,0 +1,145 @@
+/*
+ * IBM Common FRU Access Macro - S variant (CFAM-S)
+ *
+ * Copyright (C) 2026 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/fsi/cfam-s.h"
+#include "hw/fsi/fsi.h"
+
+/* bits [22:21] are the slave ID, low 21 bits address registers within it */
+#define CFAM_SID_MASK       0x1fffff
+#define CFAM_WINDOW_SIZE    0x800000 /* 8 MiB per slave, covers SID 0..3 */
+
+#define CFAM_RESPONDER_BASE 0x400 /* == FSI_RESPONDER_PAGE_SIZE */
+
+/* Config-table word fields (see Linux fsi-master.h) */
+#define CFAM_CONF_NEXT          (1u << 31)
+#define CFAM_CONF_SLOTS(n)      (((n) & 0xff) << 16)
+#define CFAM_CONF_VERSION(v)    (((v) & 0xf) << 12)
+#define CFAM_CONF_TYPE(t)       (((t) & 0xff) << 4)
+#define CFAM_CHIP_ID_MAJOR(m)   (((m) & 0xf) << 8)
+
+/* Engine IDs (include/linux/fsi.h) */
+#define FSI_ENGINE_ID_RESPONDER     0x3
+#define FSI_ENGINE_ID_MBOXV1        0x14
+#define FSI_CHIP_ID_MAJOR_CFAM_S    0x9 /* major == 9 -> CFAM-S */
+
+/* Engine layout: 0x000 config table, 0x400 responder, 0x800 mbox */
+#define CFAM_MBOX_BASE          0x800
+#define CFAM_MBOX_SCRATCH_OFF   0xe0
+#define CFAM_MBOX_SCRATCH_BASE  (CFAM_MBOX_BASE + CFAM_MBOX_SCRATCH_OFF)
+
+static uint8_t cfam_s_crc4(uint8_t c, uint64_t x, int bits)
+{
+    static const uint8_t tab[16] = {
+        0x0, 0x7, 0xe, 0x9, 0xb, 0xc, 0x5, 0x2,
+        0x1, 0x6, 0xf, 0x8, 0xa, 0xd, 0x4, 0x3,
+    };
+    int i;
+
+    x &= (1ull << bits) - 1;
+    bits = (bits + 3) & ~0x3;
+    for (i = bits - 4; i >= 0; i -= 4) {
+        c = tab[c ^ ((x >> i) & 0xf)];
+    }
+    return c;
+}
+
+static uint32_t cfam_s_cfg_word(uint32_t fields)
+{
+    return fields | cfam_s_crc4(0, fields >> 4, 28);
+}
+
+static uint64_t fsi_cfam_s_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSICFAMSState *cfam = FSI_CFAM_S(opaque);
+    uint32_t off = (uint32_t)addr & CFAM_SID_MASK;
+    uint32_t val = 0;
+
+    if (off < CFAM_RESPONDER_BASE) {
+        switch (off) {
+        case 0x00:
+            /* chip-id: NEXT set, MAJOR=9 (CFAM-S) */
+            val = cfam_s_cfg_word(CFAM_CONF_NEXT |
+                                  CFAM_CHIP_ID_MAJOR(FSI_CHIP_ID_MAJOR_CFAM_S));
+            break;
+        case 0x04:
+            /* responder engine entry */
+            val = cfam_s_cfg_word(CFAM_CONF_NEXT | CFAM_CONF_SLOTS(1) |
+                                  CFAM_CONF_VERSION(1) |
+                                  CFAM_CONF_TYPE(FSI_ENGINE_ID_RESPONDER));
+            break;
+        case 0x08:
+            /* mailbox engine entry, last (NEXT clear) */
+            val = cfam_s_cfg_word(CFAM_CONF_SLOTS(1) | CFAM_CONF_VERSION(1) |
+                                  CFAM_CONF_TYPE(FSI_ENGINE_ID_MBOXV1));
+            break;
+        default:
+            break;
+        }
+    } else if (off >= CFAM_MBOX_SCRATCH_BASE &&
+               off < CFAM_MBOX_SCRATCH_BASE + CFAM_S_MBOX_SCRATCH_NUM * 4) {
+        val = cfam->mbox_scratch[(off - CFAM_MBOX_SCRATCH_BASE) / 4];
+    }
+
+    trace_fsi_cfam_config_read(addr, size);
+    return val;
+}
+
+static void fsi_cfam_s_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    FSICFAMSState *cfam = FSI_CFAM_S(opaque);
+    uint32_t off = (uint32_t)addr & CFAM_SID_MASK;
+
+    if (off >= CFAM_MBOX_SCRATCH_BASE &&
+        off < CFAM_MBOX_SCRATCH_BASE + CFAM_S_MBOX_SCRATCH_NUM * 4) {
+        cfam->mbox_scratch[(off - CFAM_MBOX_SCRATCH_BASE) / 4] = (uint32_t)data;
+    }
+    trace_fsi_cfam_config_write(addr, size, data);
+}
+
+static const MemoryRegionOps cfam_s_ops = {
+    .read = fsi_cfam_s_read,
+    .write = fsi_cfam_s_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+};
+
+static void fsi_cfam_s_realize(DeviceState *dev, Error **errp)
+{
+    FSICFAMSState *cfam = FSI_CFAM_S(dev);
+
+    memory_region_init_io(&cfam->mr, OBJECT(cfam), &cfam_s_ops, cfam,
+                          TYPE_FSI_CFAM_S, CFAM_WINDOW_SIZE);
+}
+
+static void fsi_cfam_s_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->bus_type = TYPE_FSI_BUS;
+    dc->realize = fsi_cfam_s_realize;
+}
+
+static const TypeInfo fsi_cfam_s_info = {
+    .name = TYPE_FSI_CFAM_S,
+    .parent = TYPE_FSI_SLAVE,
+    .instance_size = sizeof(FSICFAMSState),
+    .class_init = fsi_cfam_s_class_init,
+};
+
+static void fsi_cfam_s_register_types(void)
+{
+    type_register_static(&fsi_cfam_s_info);
+}
+
+type_init(fsi_cfam_s_register_types);
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index 083a5507ab..f7c19e24b0 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "trace.h"
 
 #include "hw/fsi/fsi-master.h"
@@ -112,8 +113,6 @@ static void fsi_master_init(Object *o)
 {
     FSIMasterState *s = FSI_MASTER(o);
 
-    object_initialize_child(o, "cfam", &s->cfam, TYPE_FSI_CFAM);
-
     qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
@@ -125,12 +124,19 @@ static void fsi_master_realize(DeviceState *dev, Error **errp)
 {
     FSIMasterState *s = FSI_MASTER(dev);
 
+    object_initialize_child(OBJECT(dev), "cfam", &s->cfam, TYPE_FSI_CFAM);
     if (!qdev_realize(DEVICE(&s->cfam), BUS(&s->bus), errp)) {
         return;
     }
 
     /* address ? */
     memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
+
+    object_initialize_child(OBJECT(dev), "cfam-s", &s->cfam_s, TYPE_FSI_CFAM_S);
+    if (!qdev_realize(DEVICE(&s->cfam_s), BUS(&s->bus), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->opb2fsi, 2 * MiB, &s->cfam_s.mr);
 }
 
 static void fsi_master_reset(DeviceState *dev)
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index a18a076552..585d549405 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,2 +1,2 @@
-system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','fsi-master.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','cfam-s.c','fsi-master.c'))
 system_ss.add(when: 'CONFIG_FSI_APB2OPB_ASPEED', if_true: files('aspeed_apb2opb.c'))
-- 
2.53.0


