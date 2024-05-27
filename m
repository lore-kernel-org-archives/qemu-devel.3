Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984CCC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUVo-0003iQ-9E; Mon, 27 May 2024 03:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVm-0003gk-8O; Mon, 27 May 2024 03:11:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVj-0003RD-W0; Mon, 27 May 2024 03:11:13 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R6kCYN021880; Mon, 27 May 2024 07:11:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DDeT?=
 =?UTF-8?Q?cTcYaOhoiR3Y7KR1FvalnB4gbA8oCGuIs69c93Oo=3D;_b=3DrLIwo0vfCABMVM?=
 =?UTF-8?Q?MtQgIfu16Yz0Yi2mdmAZrR4wFlL87vhrjD++QqHgtZWYgN8en6jSZ0_qSK+adjP?=
 =?UTF-8?Q?RcDrGy2CLpeWCtPm/99/fj/suXe4XhjMBaPlHfZvtGRtq3A/toep2JBCvdfC_sU?=
 =?UTF-8?Q?TgHCMKsXEqh+31OdJOkgRI49/xrGgEWPUyJnnv9aOKBPOIhUOba7LdH/bRibruP?=
 =?UTF-8?Q?Auh_9hL4sBD+4JuRRFuRIh03pInX6kN6r3+2dA6SdPbIMDTwA0OaK/WCh/VzwyC?=
 =?UTF-8?Q?irc1EYfvM_r9fYo6RLmKs+RKJmJqwJymgqEwfp4NFdigFQ3/yRZaIYVpmQqIV3/?=
 =?UTF-8?Q?ZK5uIfREzrPNfdw_+A=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycfxdgpy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:07 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7B7K8001172;
 Mon, 27 May 2024 07:11:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycfxdgpxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R5L6kV004505; Mon, 27 May 2024 07:11:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybuanqhdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7B0ZN51380566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:11:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F82020040;
 Mon, 27 May 2024 07:11:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52E9F20043;
 Mon, 27 May 2024 07:10:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:10:58 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 05/11] ppc/pnv: Add a Power11 Pnv11Chip,
 and a Power11 Machine
Date: Mon, 27 May 2024 12:40:36 +0530
Message-ID: <20240527071042.489540-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527071042.489540-1-adityag@linux.ibm.com>
References: <20240527071042.489540-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W4YYLZJHorfJn4uJ7rmH2PkXK41_yv58
X-Proofpoint-ORIG-GUID: Sq85TA62WVkMAkagrmbUjO7tqFz1jTXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Power11 core is same as Power10, use the existing functionalities to
introduce a Power11 chip and machine, with Power10 chip as parent of
Power11 chip, thus going through similar class_init paths

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/powernv.rst |   9 +--
 hw/ppc/pnv.c                | 119 ++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv_core.c           |  11 ++++
 include/hw/ppc/pnv.h        |   5 ++
 include/hw/ppc/pnv_chip.h   |   7 +++
 include/hw/ppc/pnv_core.h   |   1 +
 6 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index 09f39658587d..65606aa767aa 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -1,5 +1,5 @@
-PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
-==================================================================
+PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
+================================================================================
 
 PowerNV (as Non-Virtualized) is the "bare metal" platform using the
 OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
@@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL and POWER9.
+ * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
+   Power11).
  * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
  * Simple OCC is an on-chip micro-controller used for power management tasks.
  * iBT device to handle BMC communication, with the internal BMC simulator
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec76..939163f91784 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -456,6 +456,33 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
     pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
 }
 
+static void pnv_chip_power11_dt_populate(PnvChip *chip, void *fdt)
+{
+    static const char compat[] = "ibm,power11-xscom\0ibm,xscom";
+    int i;
+
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV10_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV10_XSCOM_SIZE),
+                 compat, sizeof(compat));
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pnv_core = chip->cores[i];
+        int offset;
+
+        offset = pnv_dt_core(chip, pnv_core, fdt);
+
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_31, sizeof(pa_features_31))));
+    }
+
+    if (chip->ram_size) {
+        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_size);
+    }
+
+    pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
+}
+
 static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
 {
     uint32_t io_base = d->ioport_id;
@@ -1288,6 +1315,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
 
 #define POWER10_CORE_MASK  (0xffffffffffffffull)
 
+#define POWER11_CORE_MASK  (0xffffffffffffffull)
+
 static void pnv_chip_power8_instance_init(Object *obj)
 {
     Pnv8Chip *chip8 = PNV8_CHIP(obj);
@@ -1831,7 +1860,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     }
 }
 
-static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
+static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp,
+        const char *cpu_model)
 {
     PnvChip *chip = PNV_CHIP(chip10);
     int i;
@@ -1843,7 +1873,7 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
         PnvQuad *eq = &chip10->quads[i];
 
         pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
-                                  PNV_QUAD_TYPE_NAME("power10"));
+                                  PNV_QUAD_TYPE_NAME_DYN(cpu_model));
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
@@ -1881,7 +1911,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
     }
 }
 
-static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
+static void pnv_chip_power10_common_realize(DeviceState *dev, Error **errp,
+        const char *cpu_model)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip = PNV_CHIP(dev);
@@ -1898,7 +1929,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pnv_chip_power10_quad_realize(chip10, &local_err);
+    pnv_chip_power10_quad_realize(chip10, &local_err, cpu_model);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -2046,6 +2077,16 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 
 }
 
+static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
+{
+    pnv_chip_power10_common_realize(dev, errp, "power10");
+}
+
+static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
+{
+    pnv_chip_power10_common_realize(dev, errp, "power11");
+}
+
 static void pnv_rainier_i2c_init(PnvMachineState *pnv)
 {
     int i;
@@ -2111,6 +2152,34 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
+static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvChipClass *k = PNV_CHIP_CLASS(klass);
+
+    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
+
+    k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
+    k->cores_mask = POWER11_CORE_MASK;
+    k->chip_pir = pnv_chip_pir_p10;
+    k->intc_create = pnv_chip_power10_intc_create;
+    k->intc_reset = pnv_chip_power10_intc_reset;
+    k->intc_destroy = pnv_chip_power10_intc_destroy;
+    k->intc_print_info = pnv_chip_power10_intc_print_info;
+    k->isa_create = pnv_chip_power10_isa_create;
+    k->dt_populate = pnv_chip_power11_dt_populate;
+    k->pic_print_info = pnv_chip_power10_pic_print_info;
+    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
+    dc->desc = "PowerNV Chip POWER11";
+    k->num_pecs = PNV10_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
+
+    device_class_set_parent_realize(dc, pnv_chip_power11_realize,
+                                    &k->parent_realize);
+}
+
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
@@ -2505,6 +2574,22 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
     pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
+static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv11\0ibm,powernv";
+
+    /* do power10_class_init as p11 core is same as p10 */
+    pnv_machine_p10_common_class_init(oc, data);
+
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2608,7 +2693,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
         .parent        = TYPE_PNV10_CHIP,          \
     }
 
+#define DEFINE_PNV11_CHIP_TYPE(type, class_initfn) \
+    {                                              \
+        .name          = type,                     \
+        .class_init    = class_initfn,             \
+        .parent        = TYPE_PNV11_CHIP,          \
+    }
+
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv11"),
+        .parent        = TYPE_PNV_MACHINE,
+        .class_init    = pnv_machine_power11_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_XIVE_FABRIC },
+            { },
+        },
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
         .parent        = MACHINE_TYPE_NAME("powernv10"),
@@ -2663,6 +2764,16 @@ static const TypeInfo types[] = {
         .abstract      = true,
     },
 
+    /*
+     * P11 chip and variants
+     */
+    {
+        .name          = TYPE_PNV11_CHIP,
+        .parent        = TYPE_PNV10_CHIP,
+        .instance_size = sizeof(Pnv11Chip),
+    },
+    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
+
     /*
      * P10 chip and variants
      */
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f40ab721d6fc..87c2e7ce2084 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -372,6 +372,11 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
     pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
 }
 
+static void pnv_core_power11_class_init(ObjectClass *oc, void *data)
+{
+    pnv_core_power10_class_init(oc, data);
+}
+
 static void pnv_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -403,6 +408,7 @@ static const TypeInfo pnv_core_infos[] = {
     DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
     DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
     DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
+    DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
 };
 
 DEFINE_TYPES(pnv_core_infos)
@@ -634,6 +640,11 @@ static const TypeInfo pnv_quad_infos[] = {
         .name = PNV_QUAD_TYPE_NAME("power10"),
         .class_init = pnv_quad_power10_class_init,
     },
+    {
+        .parent = PNV_QUAD_TYPE_NAME("power10"),
+        .name = PNV_QUAD_TYPE_NAME("power11"),
+        .class_init = pnv_quad_power10_class_init,
+    },
 };
 
 DEFINE_TYPES(pnv_quad_infos);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b13614640..386aab0478d3 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -33,6 +33,7 @@ typedef struct PnvChip PnvChip;
 typedef struct Pnv8Chip Pnv8Chip;
 typedef struct Pnv9Chip Pnv9Chip;
 typedef struct Pnv10Chip Pnv10Chip;
+typedef struct Pnv10Chip Pnv11Chip;
 
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
 #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
@@ -57,6 +58,10 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
                          TYPE_PNV_CHIP_POWER10)
 
+#define TYPE_PNV_CHIP_POWER11 PNV_CHIP_TYPE_NAME("power11_v2.0")
+DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER11,
+                         TYPE_PNV_CHIP_POWER11)
+
 PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id);
 PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
 
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291ed3..3aefef051995 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -132,6 +132,13 @@ struct Pnv10Chip {
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
 #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
 
+#define TYPE_PNV11_CHIP "pnv11-chip"
+DECLARE_INSTANCE_CHECKER(Pnv11Chip, PNV11_CHIP,
+                         TYPE_PNV11_CHIP)
+
+/* Power11 core is same as Power10 */
+typedef struct Pnv10Chip Pnv11Chip;
+
 struct PnvChipClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c6d62fd14593..9e9a305061d0 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -76,6 +76,7 @@ struct PnvQuadClass {
 
 #define PNV_QUAD_TYPE_SUFFIX "-" TYPE_PNV_QUAD
 #define PNV_QUAD_TYPE_NAME(cpu_model) cpu_model PNV_QUAD_TYPE_SUFFIX
+#define PNV_QUAD_TYPE_NAME_DYN(cpu) g_strconcat(cpu, PNV_QUAD_TYPE_SUFFIX, NULL)
 
 OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
 
-- 
2.45.1


