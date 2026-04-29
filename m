Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E8CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jh-0007vs-Pd; Wed, 29 Apr 2026 14:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9je-0007qG-Oc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jc-0007Dc-GY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9Cd4Q2845814
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gUK8qI+cFr+8wrktg
 5ODjP3hFeZAj0T0v/OF5jVh3Iw=; b=Lw1lLyKr1JRl60cCpEYfv/YRf5dtLUuta
 gGHX/Y8Zyi2BuQdeM4mFcSs3Iy4DCPXMEFdd1kSXQmGL9tKVxoncsqGNvHZBEpCm
 gXqEe2hVVBre5Wv0S56yN5W4Lml1GH+k4iialQiViZBeGFGjMcXxxnhHARHCP5vf
 cqcoQ6VNrQu/RQmlN8t53GQTdval4x3mb53aTwAsowWZxCgZxXqsEu9OEiLciQHf
 bNxmyvmDFdoYnM9Zl3nknhoTwtE/kqsnROhytI45z8P8HGGm4mjzEdJ4NorGIW7B
 goPLPOhTP/TwayPlJQJdI7ByseKRwgl5PY8Gg1fT9krv+pENMPHRA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rc249-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:34:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINlO9004874
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:34:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehfgrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:34:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIY1Qv53477872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:34:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60B602004E;
 Wed, 29 Apr 2026 18:34:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CEF420049;
 Wed, 29 Apr 2026 18:33:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:58 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 12/13] ppc/pnv: Add a nest MMU model
Date: Thu, 30 Apr 2026 00:03:02 +0530
Message-ID: <20260429183310.12455-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fOnATU-HpktBP_OYrJHGUqHKawoOejSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfXwkT0oz8JCzJq
 Me4HQO7J6HLcpcDH5qGWGOeo6KZSyurfvHxtgzbB9RGv5/LNsEUOGx8lumnO34et7ThzNt2PJCF
 WcU5L9eXQ9z7B4TfPrOhSWutoGB2ayBQ0b35RS26xUN3iLdbMu16DQr4Od6EtZWGpVsRdoE/xO7
 6ZSe9d3QPo2mSfq4M9hJc1vbAorkD/q4A0h6cNnmpLsQzLpcrbAO5rmIC4SJjVtWwYw06Vft+Qb
 bWe/ws2FzPfEuPPsK/HuLBnfPSX5jQsNtgVJwvHwJjWT+diBorcxrS6bCyPrBFqC5PAxWSI2k3R
 MJ9z7QStw5EKlPe1znZtULH6+sHPyp9ZTe7ClWPEDwMvYFUNWNmwRl97gqj9zVeZ7eHjppTrncW
 jIpsQrE7zCJHxpXeEpMvwfX17hYh2+wSoKS8Jq65bdZ1mzcgSazQ6ztCQLVFxNSXdNSfn+EQbwQ
 79Pu88QbZwBxva4DV4A==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24f1e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gBQiksIdkjhXAVLJLEgA:9
X-Proofpoint-ORIG-GUID: fOnATU-HpktBP_OYrJHGUqHKawoOejSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Caleb Schlossin <calebs@linux.ibm.com>

The nest MMU is used for translations needed by I/O subsystems
on Power10. The nest is the shared, on-chip infrastructure
that connects CPU cores, memory controllers, and I/O.

This patch sets up a basic skeleton with its xscom
area, mapping both needed xscom regions. Support required
for PowerVM bringup.

Use Power9 property for device tree to allow OPAL to
work with Power9 and Power10.

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260120150139.714805-1-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_nmmu.h  |  28 ++++++++
 include/hw/ppc/pnv_xscom.h |   4 ++
 hw/ppc/pnv.c               |  20 ++++++
 hw/ppc/pnv_nmmu.c          | 132 +++++++++++++++++++++++++++++++++++++
 hw/ppc/meson.build         |   1 +
 6 files changed, 188 insertions(+)
 create mode 100644 include/hw/ppc/pnv_nmmu.h
 create mode 100644 hw/ppc/pnv_nmmu.c

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index ea47c97dd3..8ef75fdcca 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_nmmu.h"
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
@@ -126,6 +127,8 @@ struct Pnv10Chip {
     PnvN1Chiplet     n1_chiplet;
 #define PNV10_CHIP_MAX_PIB_SPIC 6
     PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
+#define PNV10_CHIP_MAX_NMMU 2
+    PnvNMMU      nmmu[PNV10_CHIP_MAX_NMMU];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/include/hw/ppc/pnv_nmmu.h b/include/hw/ppc/pnv_nmmu.h
new file mode 100644
index 0000000000..d3ba46ecf4
--- /dev/null
+++ b/include/hw/ppc/pnv_nmmu.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU PowerPC nest MMU model
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_NMMU_H
+#define PPC_PNV_NMMU_H
+
+#define TYPE_PNV_NMMU "pnv-nmmu"
+#define PNV_NMMU(obj) OBJECT_CHECK(PnvNMMU, (obj), TYPE_PNV_NMMU)
+
+typedef struct PnvNMMU {
+    DeviceState parent;
+
+    struct PnvChip *chip;
+
+    MemoryRegion xscom_regs;
+    uint32_t nmmu_id;
+    uint64_t ptcr;
+} PnvNMMU;
+
+#endif /*PPC_PNV_NMMU_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 610b075a27..6dab803d1f 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -196,6 +196,10 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
 #define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
 
+#define PNV10_XSCOM_NEST0_MMU_BASE      0x2010c40
+#define PNV10_XSCOM_NEST1_MMU_BASE      0x3010c40
+#define PNV10_XSCOM_NMMU_SIZE      0x20
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 89096f9a84..9ed918fa6a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2297,6 +2297,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
                                 TYPE_PNV_PHB5_PEC);
     }
 
+    for (i = 0; i < PNV10_CHIP_MAX_NMMU; i++) {
+        object_initialize_child(obj, "nmmu[*]", &chip10->nmmu[i],
+                                TYPE_PNV_NMMU);
+    }
+
     for (i = 0; i < pcc->i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
     }
@@ -2511,6 +2516,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
                            &chip10->n1_chiplet.xscom_pb_es_mr);
 
+    /* nest0/1 MMU */
+    for (i = 0; i < PNV10_CHIP_MAX_NMMU; i++) {
+        object_property_set_int(OBJECT(&chip10->nmmu[i]), "nmmu_id",
+                                i , &error_fatal);
+        object_property_set_link(OBJECT(&chip10->nmmu[i]), "chip",
+                                 OBJECT(chip), &error_abort);
+        if (!qdev_realize(DEVICE(&chip10->nmmu[i]), NULL, errp)) {
+            return;
+        }
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST0_MMU_BASE,
+                            &chip10->nmmu[0].xscom_regs);
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_MMU_BASE,
+                            &chip10->nmmu[1].xscom_regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_nmmu.c b/hw/ppc/pnv_nmmu.c
new file mode 100644
index 0000000000..c1b00bac89
--- /dev/null
+++ b/hw/ppc/pnv_nmmu.c
@@ -0,0 +1,132 @@
+/*
+ * QEMU PowerPC nest MMU model
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/qdev-properties.h"
+
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nmmu.h"
+#include "hw/ppc/fdt.h"
+
+#include <libfdt.h>
+
+#define NMMU_XLAT_CTL_PTCR 0xb
+
+static uint64_t pnv_nmmu_xscom_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvNMMU *nmmu = PNV_NMMU(opaque);
+    int reg = addr >> 3;
+    uint64_t val;
+
+    if (reg == NMMU_XLAT_CTL_PTCR) {
+        val = nmmu->ptcr;
+    } else {
+        val = 0xffffffffffffffffull;
+        qemu_log_mask(LOG_UNIMP, "nMMU: xscom read at 0x%" PRIx32 "\n", reg);
+    }
+    return val;
+}
+
+static void pnv_nmmu_xscom_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNMMU *nmmu = PNV_NMMU(opaque);
+    int reg = addr >> 3;
+
+    if (reg == NMMU_XLAT_CTL_PTCR) {
+        nmmu->ptcr = val;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "nMMU: xscom write at 0x%" PRIx32 "\n", reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nmmu_xscom_ops = {
+    .read = pnv_nmmu_xscom_read,
+    .write = pnv_nmmu_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nmmu_realize(DeviceState *dev, Error **errp)
+{
+    PnvNMMU *nmmu = PNV_NMMU(dev);
+
+    assert(nmmu->chip);
+
+    /* NMMU xscom region */
+    pnv_xscom_region_init(&nmmu->xscom_regs, OBJECT(nmmu),
+                          &pnv_nmmu_xscom_ops, nmmu,
+                          "xscom-nmmu",
+                          PNV10_XSCOM_NMMU_SIZE);
+}
+
+static int pnv_nmmu_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvNMMU *nmmu = PNV_NMMU(dev);
+    char *name;
+    int nmmu_offset;
+    const char compat[] = "ibm,power9-nest-mmu";
+    uint32_t nmmu_pcba = PNV10_XSCOM_NEST0_MMU_BASE + nmmu->nmmu_id * 0x1000000;
+    uint32_t reg[2] = {
+        cpu_to_be32(nmmu_pcba),
+        cpu_to_be32(PNV10_XSCOM_NMMU_SIZE)
+    };
+
+    name = g_strdup_printf("nmmu@%x", nmmu_pcba);
+    nmmu_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nmmu_offset);
+    g_free(name);
+
+    _FDT(fdt_setprop(fdt, nmmu_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, nmmu_offset, "compatible", compat, sizeof(compat)));
+    return 0;
+}
+
+static const Property pnv_nmmu_properties[] = {
+    DEFINE_PROP_UINT32("nmmu_id", PnvNMMU, nmmu_id, 0),
+    DEFINE_PROP_LINK("chip", PnvNMMU, chip, TYPE_PNV_CHIP, PnvChip *),
+};
+
+static void pnv_nmmu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_nmmu_dt_xscom;
+
+    dc->desc = "PowerNV nest MMU";
+    dc->realize = pnv_nmmu_realize;
+    device_class_set_props(dc, pnv_nmmu_properties);
+}
+
+static const TypeInfo pnv_nmmu_info = {
+    .name          = TYPE_PNV_NMMU,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNMMU),
+    .class_init    = pnv_nmmu_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nmmu_register_types(void)
+{
+    type_register_static(&pnv_nmmu_info);
+}
+
+type_init(pnv_nmmu_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index c61fba4ec8..37aa535db2 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -57,6 +57,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
   'pnv_mpipl.c',
+  'pnv_nmmu.c'
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.52.0


