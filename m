Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5C0C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JKj-0000ME-Ln; Fri, 26 Apr 2024 07:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JK9-0008Qv-JV; Fri, 26 Apr 2024 07:01:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JK3-0008IA-Px; Fri, 26 Apr 2024 07:00:58 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QAwEGv015541; Fri, 26 Apr 2024 11:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=TMM1+sfneYtcB1MXX2g+wQSP6i1dtEZaYD958PjyiV8=;
 b=PwQz/Dw2rPAhx4jIsCPFvERwAUJ3oiYRyxITiDIFdeSfItXVPH5IKSpFfMbfhUkpnmbJ
 9/glwgfyqF0CSAW1PaOOnpbocYxEUHhhsLq8F20FOotEmVNc631U31VztNTbqaPUcMwP
 Ufhn3mSv/wkC6Iv+v2lpu7/DNCEwAF6m8jnfvjzILvDoxB2JmLpxGaw6wrLLU+7bxVPG
 2t62jbjvJ89nCdjulAN9zPUj5CdDQ7ctluqKBL8kPa2z0QnpsYD97h3o6Og2ujApmr3Z
 elHlFiopYvuxOrYUB1qnqoU/o6Wh1romCxVSeAlxp7JZlcGTyEQZcanrTWeaa41AhHvf Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xraye807g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QB0j0s019815;
 Fri, 26 Apr 2024 11:00:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xraye807f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q8foHD023012; Fri, 26 Apr 2024 11:00:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pfae0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB0aM117695084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:00:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 040E02004B;
 Fri, 26 Apr 2024 11:00:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2F8920043;
 Fri, 26 Apr 2024 11:00:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.14.245]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 11:00:33 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 03/10] ppc/pnv: Add a Power11 Pnv11Chip,
 and a Power11 Machine
Date: Fri, 26 Apr 2024 16:30:16 +0530
Message-ID: <20240426110023.733309-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110023.733309-1-adityag@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wmYx7T_IUZ_a0xRqxp_HuF9UwHOl-Pti
X-Proofpoint-ORIG-GUID: -RxM7pej_3uPQA7JMWbrLoG-UaVXqKbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 docs/system/ppc/powernv.rst |  9 ++--
 hw/ppc/pnv.c                | 98 +++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv_core.c           | 16 +++++-
 include/hw/ppc/pnv.h        |  5 ++
 include/hw/ppc/pnv_chip.h   | 10 ++++
 5 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index 09f39658587d..626f2a119521 100644
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
+ * Multi processor support for POWER8, POWER8NVL, POWER9, POWER10 and Power11.
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
index 74e7908e5ffb..06e272f3bdd3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -431,13 +431,27 @@ static const uint8_t pa_features_31[] = { 74, 0,
 
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
-    static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    static const char compat_p10[] = "ibm,power10-xscom\0ibm,xscom";
+    static const char compat_p11[] = "ibm,power11-xscom\0ibm,xscom";
+
+    PnvChipType chip_type = pcc->chip_type;
+    const char *compat;
+    int compat_len;
     int i;
 
+    if (chip_type == PNV_TYPE_POWER11) {
+        compat = compat_p11;
+        compat_len = sizeof(compat_p11);
+    } else {
+        compat = compat_p10;
+        compat_len = sizeof(compat_p10);
+    }
+
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV10_XSCOM_BASE(chip)),
                  cpu_to_be64(PNV10_XSCOM_SIZE),
-                 compat, sizeof(compat));
+                 compat, compat_len);
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
@@ -1288,6 +1302,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
 
 #define POWER10_CORE_MASK  (0xffffffffffffffull)
 
+#define POWER11_CORE_MASK  (0xffffffffffffffull)
+
 static void pnv_chip_power8_instance_init(Object *obj)
 {
     Pnv8Chip *chip8 = PNV8_CHIP(obj);
@@ -1838,6 +1854,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
 static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
 {
     PnvChip *chip = PNV_CHIP(chip10);
+    PnvChipClass *chip_class = PNV_CHIP_GET_CLASS(chip);
     int i;
 
     chip10->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
@@ -1846,7 +1863,11 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
     for (i = 0; i < chip10->nr_quads; i++) {
         PnvQuad *eq = &chip10->quads[i];
 
-        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
+        if (chip_class->chip_type == PNV_TYPE_POWER11)
+            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
+                                  PNV_QUAD_TYPE_NAME("power11"));
+        else
+            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
                                   PNV_QUAD_TYPE_NAME("power10"));
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
@@ -2116,6 +2137,35 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
+static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvChipClass *k = PNV_CHIP_CLASS(klass);
+
+    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
+
+    k->chip_cfam_id = 0x120da04900008000ull; /* P11 (with NX) */
+    k->chip_type = PNV_TYPE_POWER11;
+    k->cores_mask = POWER11_CORE_MASK;
+    k->chip_pir = pnv_chip_pir_p10;
+    k->intc_create = pnv_chip_power10_intc_create;
+    k->intc_reset = pnv_chip_power10_intc_reset;
+    k->intc_destroy = pnv_chip_power10_intc_destroy;
+    k->intc_print_info = pnv_chip_power10_intc_print_info;
+    k->isa_create = pnv_chip_power10_isa_create;
+    k->dt_populate = pnv_chip_power10_dt_populate;
+    k->pic_print_info = pnv_chip_power10_pic_print_info;
+    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
+    dc->desc = "PowerNV Chip POWER11";
+    k->num_pecs = PNV10_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
+
+    device_class_set_parent_realize(dc, pnv_chip_power10_realize,
+                                    &k->parent_realize);
+}
+
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
@@ -2510,6 +2560,22 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
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
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2613,7 +2679,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
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
@@ -2668,6 +2750,16 @@ static const TypeInfo types[] = {
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
index f40ab721d6fc..4522655793da 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -402,7 +402,16 @@ static const TypeInfo pnv_core_infos[] = {
     DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
     DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
     DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
-    DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
+    {
+        .parent = TYPE_PNV_CORE,
+        .name = PNV_CORE_TYPE_NAME("power10_v2.0"),
+        .class_init = pnv_core_power10_class_init,
+        .class_base_init = pnv_core_power10_class_init,
+    },
+    {
+        .parent = PNV_CORE_TYPE_NAME("power10_v2.0"),
+        .name = PNV_CORE_TYPE_NAME("power11"),
+    }
 };
 
 DEFINE_TYPES(pnv_core_infos)
@@ -633,6 +642,11 @@ static const TypeInfo pnv_quad_infos[] = {
         .parent = TYPE_PNV_QUAD,
         .name = PNV_QUAD_TYPE_NAME("power10"),
         .class_init = pnv_quad_power10_class_init,
+        .class_base_init = pnv_quad_power10_class_init,
+    },
+    {
+        .parent = PNV_QUAD_TYPE_NAME("power10"),
+        .name = PNV_QUAD_TYPE_NAME("power11"),
     },
 };
 
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b13614640..7c5431500512 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -33,6 +33,7 @@ typedef struct PnvChip PnvChip;
 typedef struct Pnv8Chip Pnv8Chip;
 typedef struct Pnv9Chip Pnv9Chip;
 typedef struct Pnv10Chip Pnv10Chip;
+typedef struct Pnv11Chip Pnv11Chip;
 
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
 #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
@@ -57,6 +58,10 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
                          TYPE_PNV_CHIP_POWER10)
 
+#define TYPE_PNV_CHIP_POWER11 PNV_CHIP_TYPE_NAME("power11")
+DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER11,
+                         TYPE_PNV_CHIP_POWER11)
+
 PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id);
 PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
 
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index ebfe82b89537..e56433676bca 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -23,6 +23,7 @@ typedef enum PnvChipType {
     PNV_TYPE_POWER8NVL,   /* AKA Naples */
     PNV_TYPE_POWER9,      /* AKA Nimbus */
     PNV_TYPE_POWER10,
+    PNV_TYPE_POWER11,
 } PnvChipType;
 
 struct PnvChip {
@@ -141,6 +142,15 @@ struct Pnv10Chip {
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
 #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
 
+#define TYPE_PNV11_CHIP "pnv11-chip"
+DECLARE_INSTANCE_CHECKER(Pnv11Chip, PNV11_CHIP,
+                         TYPE_PNV11_CHIP)
+
+struct Pnv11Chip {
+    /*< private >*/
+    Pnv10Chip      parent_obj;
+};
+
 struct PnvChipClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
-- 
2.44.0


