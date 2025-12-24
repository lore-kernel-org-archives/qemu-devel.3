Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043CDE7545F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPlj-0002OU-3h; Wed, 24 Dec 2025 09:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vYPlV-0002Mv-EP; Wed, 24 Dec 2025 09:23:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vYPlT-0005fq-FG; Wed, 24 Dec 2025 09:23:01 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BO0bcsb013945;
 Wed, 24 Dec 2025 14:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fI5lsVRTVCtUlDm69PXetZVNcAoC3VF8u+cYF4x1x
 l8=; b=nj7GitkZMPMK8f2Bb5UVzyhqSpgonsrTkVk0upM4FpSrO3x0ShZo7z/xq
 mcZwteeS0hIsRYk3HOXwdwbst8dOUwjzZFGNiGTD2BAyVeDoXPwfLwdwt1d6EELs
 5jzJXCOXfwPoHGAMLEg90FuiYZh5IZjhyumBbiSZzLziakbKKnhML91wmC/oCkI7
 KjRjCjjcZF4J7eM2xPgTRGHcCgBXkHnNuq2JjTUBDFDqYfmrJIEpz7caNwghReI/
 duTZpv49H7xTDnYq8Sq54n9fAoJYT69xY2GmZsejPpAGPqzJQVlqZ7oyvQzaOl73
 ZZDReTtcCr1mutPZ/hXy0ZIzSjfTw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kfq9rht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Dec 2025 14:22:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BOEMDqZ009797;
 Wed, 24 Dec 2025 14:22:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kfq9rhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Dec 2025 14:22:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BOAqNEU001092;
 Wed, 24 Dec 2025 14:22:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664sgh3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Dec 2025 14:22:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BOEMr5537749092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Dec 2025 14:22:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 893A958056;
 Wed, 24 Dec 2025 14:22:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BAD958052;
 Wed, 24 Dec 2025 14:22:53 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Dec 2025 14:22:52 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com
Subject: [PATCH] ppc/pnv: Add dummy MMIO support for OCMB chips
Date: Wed, 24 Dec 2025 08:22:49 -0600
Message-ID: <20251224142249.1356424-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=carfb3DM c=1 sm=1 tr=0 ts=694bf73f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pdFbJQVkERdRXlGXiJMA:9
X-Proofpoint-ORIG-GUID: ePrwze2t9XN3KvCFsAnUF6J8VRsMV6eh
X-Proofpoint-GUID: mjof_isrwF4-rOJrsCXV6Sq69JdGpjo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDEyMSBTYWx0ZWRfXyF99sUiJssiu
 jyQ9dDPVTjM6e/Ic1xyt0ea6jK40sKKs+bUaHN4WItVzU7mEZWmWfgKhVu/AgE4ka0EmJgiCtiz
 P998sC9z+e+zYuctWs+HoViGawAHsTwGGP1nQ1LRkLaDFe0oTK5D+ONQcMGPtQu5/Nw0UCFgTnI
 4R2Ub1vqO+fH1JxBSZag/aUmne6XQ8DXn5ASvJ/c5GZv5qieoA6ZkfiBbNJDwSDyGfjTyYf5TTX
 W4NKzbfpmcKRVbPlM0waMdesdHtSg6I4f8wT+njRjFyy5s5IHiXy7K0Pxe1zJWciEKV+VY5sQu2
 KYeyqTKQazAa0ZXWR9+FPB6vFkiJtkaeCjtyGsahsb7eNnsAOGGE8B9HE2Qn8Ygs1jyFALd6Pvi
 b+OPpimCuK5f3VUoU11qPffLaW39ySsbvYPYqlKaFt9VqaNPfT+7Uiy62h3IBpb+JApOhOg3T5E
 Jra82InasMK7buyUFDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512240121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The Power Hypervisor for P10 expects to be able to access certain
Open CAPI Memory Buffer (OCMB) chip registers.  Since QEMU does not
currently support these registers, several access errors are being
posted.  The hypervisor is able to progress despite these errors,
but it does create unwanted noise on the console.  Adding some
dummy MMIO support for this IO region in order to suppress the
error messages.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/meson.build        |   1 +
 hw/ppc/pnv.c              |  10 ++++
 hw/ppc/pnv_ocmb.c         | 103 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h      |   3 ++
 include/hw/ppc/pnv_chip.h |   2 +
 include/hw/ppc/pnv_ocmb.h |  38 ++++++++++++++
 6 files changed, 157 insertions(+)
 create mode 100644 hw/ppc/pnv_ocmb.c
 create mode 100644 include/hw/ppc/pnv_ocmb.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index f7dac87a2a..b3924119ae 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
+  'pnv_ocmb.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895132da91..670c28fed2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2187,6 +2187,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
     object_initialize_child(obj, "n1-chiplet", &chip10->n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
+    object_initialize_child(obj, "ocmb", &chip10->ocmb, TYPE_PNV10_OCMB);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -2409,6 +2410,15 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
                            &chip10->n1_chiplet.xscom_pb_es_mr);
 
+    /* Memory Controller OCMB CFG/MMIO space */
+    object_property_set_link(OBJECT(&chip10->ocmb), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->ocmb), NULL, errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), PNV10_OCMB_BASE(chip),
+                                &chip10->ocmb.regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_ocmb.c b/hw/ppc/pnv_ocmb.c
new file mode 100644
index 0000000000..c991ccbd54
--- /dev/null
+++ b/hw/ppc/pnv_ocmb.c
@@ -0,0 +1,103 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of OCMB related registers
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "exec/hwaddr.h"
+#include "system/memory.h"
+#include "system/cpus.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_chip.h"
+#include "hw/ppc/pnv_ocmb.h"
+
+static uint64_t pnv_power10_ocmb_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    /* TODO: Add support for OCMB reads */
+    return 0;
+}
+
+static void pnv_power10_ocmb_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
+{
+    /* TODO: Add support for OCMB writes */
+    return;
+}
+
+static const MemoryRegionOps pnv_power10_ocmb_ops = {
+    .read = pnv_power10_ocmb_read,
+    .write = pnv_power10_ocmb_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_ocmb_power10_class_init(ObjectClass *klass, const void *data)
+{
+    PnvOcmbClass *ocmb = PNV_OCMB_CLASS(klass);
+
+    ocmb->ocmb_size = PNV10_OCMB_SIZE;
+    ocmb->ocmb_ops = &pnv_power10_ocmb_ops;
+}
+
+static const TypeInfo pnv_ocmb_power10_type_info = {
+    .name          = TYPE_PNV10_OCMB,
+    .parent        = TYPE_PNV_OCMB,
+    .instance_size = sizeof(PnvOcmb),
+    .class_init    = pnv_ocmb_power10_class_init,
+};
+
+static void pnv_ocmb_realize(DeviceState *dev, Error **errp)
+{
+    PnvOcmb *ocmb = PNV_OCMB(dev);
+    PnvOcmbClass *ocmbc = PNV_OCMB_GET_CLASS(ocmb);
+
+    assert(ocmb->chip);
+
+    /* ocmb region */
+    memory_region_init_io(&ocmb->regs, OBJECT(dev),
+                          ocmbc->ocmb_ops, ocmb, "ocmb-main-memory",
+                          ocmbc->ocmb_size);
+}
+
+static const Property pnv_ocmb_properties[] = {
+    DEFINE_PROP_LINK("chip", PnvOcmb, chip, TYPE_PNV_CHIP, PnvChip *),
+};
+
+static void pnv_ocmb_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = pnv_ocmb_realize;
+    dc->desc = "PowerNV OCMB Memory";
+    device_class_set_props(dc, pnv_ocmb_properties);
+    dc->user_creatable = false;
+}
+
+static const TypeInfo pnv_ocmb_type_info = {
+    .name          = TYPE_PNV_OCMB,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvOcmb),
+    .class_init    = pnv_ocmb_class_init,
+    .class_size    = sizeof(PnvOcmbClass),
+    .abstract      = true,
+};
+
+static void pnv_ocmb_register_types(void)
+{
+    type_register_static(&pnv_ocmb_type_info);
+    type_register_static(&pnv_ocmb_power10_type_info);
+}
+
+type_init(pnv_ocmb_register_types);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index cbdddfc73c..cf28f23843 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -240,6 +240,9 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV10_XIVE2_NVC_SIZE        0x0000000008000000ull
 #define PNV10_XIVE2_NVC_BASE(chip)  PNV10_CHIP_BASE(chip, 0x0006030208000000ull)
 
+#define PNV10_OCMB_SIZE             0x0000001000000000ull
+#define PNV10_OCMB_BASE(chip)       PNV10_CHIP_BASE(chip, 0x0006030400000000ull)
+
 #define PNV10_XIVE2_NVPG_SIZE       0x0000010000000000ull
 #define PNV10_XIVE2_NVPG_BASE(chip) PNV10_CHIP_BASE(chip, 0x0006040000000000ull)
 
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a5b8c49680..1d7077207a 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_ocmb.h"
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
@@ -124,6 +125,7 @@ struct Pnv10Chip {
     PnvSBE       sbe;
     PnvHomer     homer;
     PnvN1Chiplet     n1_chiplet;
+    PnvOcmb      ocmb;
 #define PNV10_CHIP_MAX_PIB_SPIC 6
     PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
 
diff --git a/include/hw/ppc/pnv_ocmb.h b/include/hw/ppc/pnv_ocmb.h
new file mode 100644
index 0000000000..c16ae4e477
--- /dev/null
+++ b/include/hw/ppc/pnv_ocmb.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of OCMB related registers
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef PPC_PNV_OCMB_H
+#define PPC_PNV_OCMB_H
+
+#include "hw/ppc/pnv.h"
+#include "qom/object.h"
+
+#define TYPE_PNV_OCMB "pnv-ocmb"
+OBJECT_DECLARE_TYPE(PnvOcmb, PnvOcmbClass,
+                    PNV_OCMB)
+#define TYPE_PNV10_OCMB TYPE_PNV_OCMB "-POWER10"
+DECLARE_INSTANCE_CHECKER(PnvOcmb, PNV10_OCMB,
+                         TYPE_PNV10_OCMB)
+
+struct PnvOcmb {
+    DeviceState parent;
+
+    PnvChip *chip;
+    MemoryRegion regs;
+};
+
+
+struct PnvOcmbClass {
+    DeviceClass parent_class;
+
+    uint64_t ocmb_size;
+    const MemoryRegionOps *ocmb_ops;
+};
+
+#endif /* PPC_PNV_OCMB_H */
-- 
2.47.3


