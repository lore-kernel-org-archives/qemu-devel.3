Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28483E6F098
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3rI-0004O7-Q5; Tue, 23 Dec 2025 09:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vY3rH-0004N2-MV; Tue, 23 Dec 2025 09:59:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vY3rF-0007k7-Ms; Tue, 23 Dec 2025 09:59:31 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNCxRH5030307;
 Tue, 23 Dec 2025 14:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=E7aCTS7P+6ax21Zj0204A4w0oRkTZNeK0NVVmbNk7
 ys=; b=sG8bP96Ch6KIf8LD4c1+NW53bm725TNYmH9AVMYYrBo/13H7mHsv50Dix
 3Lsp3OWmntjpUvfhaZqj+FEHIKy8K79Ib+MAG0WiB39G9Fahw29nBlW0bs3vz7qV
 rSPN47/RoZqn8v5lOIcYGY72TAGXvZY5grkSA5RyQaPlhcz4tHCDa/RkUGCCjeos
 7AtapVACryrjifMigcnNm/iCL1zdRmItyfsZg/xajbTdeTMtMjkrekyfJ6sGxHLW
 yTUpMMjnoPdi0OKiXXsCgiTyqR04jq3mQc3iQ91OtUQ8yGyRHEWP3UR8qgQcfJx0
 J/vLFd1c1pbnJ0CRSBYhr4yU960qg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4d8q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 14:59:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BNEwObl014003;
 Tue, 23 Dec 2025 14:59:26 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4d8q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 14:59:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNDCEIr001109;
 Tue, 23 Dec 2025 14:59:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664sbtdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 14:59:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BNExOQN32572022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Dec 2025 14:59:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EC6358055;
 Tue, 23 Dec 2025 14:59:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F87B58043;
 Tue, 23 Dec 2025 14:59:23 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Dec 2025 14:59:23 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, fbarrat@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH] ppc/pnv: Add a nest MMU model
Date: Tue, 23 Dec 2025 08:59:19 -0600
Message-ID: <20251223145919.2540097-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=694aae4e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=r03UDPAKYrhx904b1scA:9
X-Proofpoint-ORIG-GUID: m_YGLriOaC7XRNmvkDT7zMfP5GcS1poF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEyMiBTYWx0ZWRfX+WfLX6XrGEjx
 oPhI3wx+WnXsDkz1JT4kB80twQvtMG6V5T9cknHUM4paj4rGkzpSUPXYLrs7GVg+2DO7liCfkvA
 Zd1EwB+blfenfjuD/31ZxxgT7uNOLc1lybgJD7uVywrb8CoXP4kek9Tkst87osBYhYHORd7sAU7
 GIPBrW5ehCC4NP/z3Z1sYMvtIZU/oMPz3wS9io+K7LXuULYuKdDGTV2lgZfET3m15IlPAjJ+u1+
 nwSVt4HjMDCBZKiGUE2SvWb0A9qDg5I3yruSpcz8c76macGDYcuYXNBTpK+vSTf23+Xa9HZBgoL
 IhXhTRpMDdFsrhvIMysOD1CMLW4KvAh+8xMXFM0V3rZ3QSLQP2e48uWhSyu9qA8ACg0ISgcZGNb
 ILtJ9lD2XJw54XZgaCaVJFaHgCASquxfCG5YusI5vnziv788iOrD0DgTGKS81yKVgrnzRPsOMVJ
 sOjkDCnbDvGTU5sIHgA==
X-Proofpoint-GUID: mJvogVOVGM0Wz3af4y4zfEtgx90Fsn89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512230122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The nest MMU is used for translations needed by I/O subsystems
on Power10. The nest is the shared, on-chip infrastructure
that connects CPU cores, memory controllers, and I/O.

This patch sets up a basic skeleton with its xscom
area, mapping both needed xscom regions. Support required
for PowerVM bringup.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/meson.build         |   1 +
 hw/ppc/pnv.c               |  20 ++++++
 hw/ppc/pnv_nmmu.c          | 132 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_nmmu.h  |  28 ++++++++
 include/hw/ppc/pnv_xscom.h |   4 ++
 6 files changed, 188 insertions(+)
 create mode 100644 hw/ppc/pnv_nmmu.c
 create mode 100644 include/hw/ppc/pnv_nmmu.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index f7dac87a2a..69e2fc34c4 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
+  'pnv_nmmu.c'
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895132da91..8d24570607 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2195,6 +2195,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
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
@@ -2409,6 +2414,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
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
index 0000000000..37c739b242
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
+#include "hw/qdev-properties.h"
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
+    const char compat[] = "ibm,power10-nest-mmu";
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
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a5b8c49680..b6382407c9 100644
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
 
-- 
2.47.3


