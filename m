Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E17ECD1283
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 05:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrAdh-0001ge-2j; Mon, 01 Apr 2024 01:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAdg-0001g9-9H
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAdc-0004VM-40
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4315cJdJ005649
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EuZr6Hx/ATGjxnu/wN+FnNHXAHiR4VyhYdlP+3XyF08=;
 b=P5B9LJFjisBG0haeg9y5UOAq5N3hc1VHOnkjiMps/8o/BAF9wPA8vwPJ0S/YTyvmRIVf
 8JyL1lWdT5xSvt+iUfF4DC1pAnk2jWBfCMj4wDMZxLJFJg0VKjQJy5C9SOZ7JR4mYrEv
 DEZUA07h2RcRq6aqVhovU4Z5VML+HtjgKzaiDCSfQHZSRRTE2Y74pJPkbIrY7UER7brg
 oVwUZlkBQIA6ApBR+3jZL2WQWVkBOs6bewpekLLzIOwC9XRC8TFRZKdxRBAy4AjSRoFV
 RGhpqwyj5ZqZyumWRHStg4xVP22nu0Bmw9VWYRb75h/FaAl754w56md5gSJPLdpJpIT0 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7pxb00x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:55:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4315tH2k031944
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7pxb00ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43133BQn027151; Mon, 1 Apr 2024 05:55:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6weyxr28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4315tAZ915925530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Apr 2024 05:55:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 066E42004F;
 Mon,  1 Apr 2024 05:55:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A080420040;
 Mon,  1 Apr 2024 05:55:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Apr 2024 05:55:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] ppc: powernv11: add base support for P11 PowerNV
Date: Mon,  1 Apr 2024 11:25:03 +0530
Message-ID: <20240401055503.1880587-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240401055503.1880587-1-adityag@linux.ibm.com>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kF7YGz9IFY202EPPcDuSP3Jtfo22qxON
X-Proofpoint-GUID: xRnHAd_qLA_WcgGRPs-xDdNvkYRte4ZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_03,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Most of the base support is based on P10 PowerNV

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c               | 409 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c          |  94 +++++++++
 hw/ppc/pnv_homer.c         |  64 ++++++
 hw/ppc/pnv_lpc.c           |  14 ++
 hw/ppc/pnv_occ.c           |  14 ++
 hw/ppc/pnv_psi.c           |  21 ++
 hw/ppc/pnv_sbe.c           |  19 ++
 include/hw/ppc/pnv.h       |  51 +++++
 include/hw/ppc/pnv_chip.h  |  30 +++
 include/hw/ppc/pnv_homer.h |   3 +
 include/hw/ppc/pnv_lpc.h   |   4 +
 include/hw/ppc/pnv_occ.h   |   2 +
 include/hw/ppc/pnv_psi.h   |   2 +
 include/hw/ppc/pnv_sbe.h   |   2 +
 include/hw/ppc/pnv_xscom.h |  55 +++++
 15 files changed, 784 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd5d..14ccbdc7b5f4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -369,6 +369,29 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
     pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
 }
 
+static void pnv_chip_power11_dt_populate(PnvChip *chip, void *fdt)
+{
+    static const char compat[] = "ibm,power11-xscom\0ibm,xscom";
+    int i;
+
+    pnv_dt_xscom(chip, fdt, 0,
+                 cpu_to_be64(PNV11_XSCOM_BASE(chip)),
+                 cpu_to_be64(PNV11_XSCOM_SIZE),
+                 compat, sizeof(compat));
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pnv_core = chip->cores[i];
+
+        pnv_dt_core(chip, pnv_core, fdt);
+    }
+
+    if (chip->ram_size) {
+        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_size);
+    }
+
+    pnv_dt_lpc(chip, fdt, 0, PNV11_LPCM_BASE(chip), PNV11_LPCM_SIZE);
+}
+
 static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
 {
     uint32_t io_base = d->ioport_id;
@@ -672,6 +695,15 @@ static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
     return pnv_lpc_isa_create(&chip10->lpc, false, errp);
 }
 
+static ISABus *pnv_chip_power11_isa_create(PnvChip *chip, Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPCHC);
+
+    qdev_connect_gpio_out(DEVICE(&chip11->lpc), 0, irq);
+    return pnv_lpc_isa_create(&chip11->lpc, false, errp);
+}
+
 static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
 {
     return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
@@ -736,6 +768,12 @@ static uint64_t pnv_chip_power10_xscom_core_base(PnvChip *chip,
     return PNV10_XSCOM_EC_BASE(core_id);
 }
 
+static uint64_t pnv_chip_power11_xscom_core_base(PnvChip *chip,
+                                                 uint32_t core_id)
+{
+    return PNV11_XSCOM_EC_BASE(core_id);
+}
+
 static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
 {
     PowerPCCPUClass *ppc_default =
@@ -766,6 +804,17 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
                          pnv_chip_power9_pic_print_info_child, mon);
 }
 
+static void pnv_chip_power11_pic_print_info(PnvChip *chip, Monitor *mon)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+
+    pnv_xive2_pic_print_info(&chip11->xive, mon);
+    pnv_psi_pic_print_info(&chip11->psi, mon);
+
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, mon);
+}
+
 /* Always give the first 1GB to chip 0 else we won't boot */
 static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
 {
@@ -1051,6 +1100,11 @@ static uint32_t pnv_chip_core_pir_p10(PnvChip *chip, uint32_t core_id)
     return (chip->chip_id << 8) | (core_id << 2);
 }
 
+static uint32_t pnv_chip_core_pir_p11(PnvChip *chip, uint32_t core_id)
+{
+    return (chip->chip_id << 8) | (core_id << 2);
+}
+
 static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
@@ -1139,6 +1193,29 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
 }
 
+static void pnv_chip_power11_intc_create(PnvChip *chip, PowerPCCPU *cpu,
+                                        Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    Error *local_err = NULL;
+    Object *obj;
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    /*
+     * The core creates its interrupt presenter but the XIVE2 interrupt
+     * controller object is initialized afterwards. Hopefully, it's
+     * only used at runtime.
+     */
+    obj = xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip11->xive),
+                           &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pnv_cpu->intc = obj;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -1169,6 +1246,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
 
 #define POWER10_CORE_MASK  (0xffffffffffffffull)
 
+#define POWER11_CORE_MASK  (0xffffffffffffffull)
+
 static void pnv_chip_power8_instance_init(Object *obj)
 {
     Pnv8Chip *chip8 = PNV8_CHIP(obj);
@@ -1914,6 +1993,255 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
+static void pnv_chip_power11_instance_init(Object *obj)
+{
+    PnvChip *chip = PNV_CHIP(obj);
+    Pnv11Chip *chip11 = PNV11_CHIP(obj);
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
+    int i;
+
+    object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
+    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
+                              "xive-fabric");
+    object_initialize_child(obj, "psi", &chip11->psi, TYPE_PNV11_PSI);
+    object_initialize_child(obj, "lpc", &chip11->lpc, TYPE_PNV11_LPC);
+    object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV11_OCC);
+    object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV11_SBE);
+    object_initialize_child(obj, "homer", &chip11->homer, TYPE_PNV11_HOMER);
+
+    chip->num_pecs = pcc->num_pecs;
+
+    for (i = 0; i < chip->num_pecs; i++) {
+        object_initialize_child(obj, "pec[*]", &chip11->pecs[i],
+                                TYPE_PNV_PHB5_PEC);
+    }
+
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        object_initialize_child(obj, "i2c[*]", &chip11->i2c[i], TYPE_PNV_I2C);
+    }
+}
+
+static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
+{
+    PnvChip *chip = PNV_CHIP(chip11);
+    int i;
+
+    chip11->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
+    chip11->quads = g_new0(PnvQuad, chip11->nr_quads);
+
+    for (i = 0; i < chip11->nr_quads; i++) {
+        PnvQuad *eq = &chip11->quads[i];
+
+        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
+                                  PNV_QUAD_TYPE_NAME("power11"));
+
+        pnv_xscom_add_subregion(chip, PNV11_XSCOM_EQ_BASE(eq->quad_id),
+                                &eq->xscom_regs);
+
+        pnv_xscom_add_subregion(chip, PNV11_XSCOM_QME_BASE(eq->quad_id),
+                                &eq->xscom_qme_regs);
+    }
+}
+
+static void pnv_chip_power11_phb_realize(PnvChip *chip, Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    int i;
+
+    for (i = 0; i < chip->num_pecs; i++) {
+        PnvPhb4PecState *pec = &chip11->pecs[i];
+        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_nest_base;
+        uint32_t pec_pci_base;
+
+        object_property_set_int(OBJECT(pec), "index", i, &error_fatal);
+        object_property_set_int(OBJECT(pec), "chip-id", chip->chip_id,
+                                &error_fatal);
+        object_property_set_link(OBJECT(pec), "chip", OBJECT(chip),
+                                 &error_fatal);
+        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
+            return;
+        }
+
+        pec_nest_base = pecc->xscom_nest_base(pec);
+        pec_pci_base = pecc->xscom_pci_base(pec);
+
+        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
+    }
+}
+
+static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
+{
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
+    PnvChip *chip = PNV_CHIP(dev);
+    Pnv11Chip *chip11 = PNV11_CHIP(dev);
+    Error *local_err = NULL;
+    int i;
+
+    /* XSCOM bridge is first */
+    pnv_xscom_init(chip, PNV11_XSCOM_SIZE, PNV11_XSCOM_BASE(chip));
+
+    pcc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pnv_chip_power11_quad_realize(chip11, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* XIVE2 interrupt controller (POWER11) */
+    object_property_set_int(OBJECT(&chip11->xive), "ic-bar",
+                            PNV11_XIVE2_IC_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip11->xive), "esb-bar",
+                            PNV11_XIVE2_ESB_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip11->xive), "end-bar",
+                            PNV11_XIVE2_END_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip11->xive), "nvpg-bar",
+                            PNV11_XIVE2_NVPG_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip11->xive), "nvc-bar",
+                            PNV11_XIVE2_NVC_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip11->xive), "tm-bar",
+                            PNV11_XIVE2_TM_BASE(chip), &error_fatal);
+    object_property_set_link(OBJECT(&chip11->xive), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&chip11->xive), errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_XIVE2_BASE,
+                            &chip11->xive.xscom_regs);
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    object_property_set_int(OBJECT(&chip11->psi), "bar",
+                            PNV11_PSIHB_BASE(chip), &error_fatal);
+    /* PSI can now be configured to use 64k ESB pages on POWER11 */
+    object_property_set_int(OBJECT(&chip11->psi), "shift", XIVE_ESB_64K,
+                            &error_fatal);
+    if (!qdev_realize(DEVICE(&chip11->psi), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_PSIHB_BASE,
+                            &PNV_PSI(&chip11->psi)->xscom_regs);
+
+    /* LPC */
+    if (!qdev_realize(DEVICE(&chip11->lpc), NULL, errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), PNV11_LPCM_BASE(chip),
+                                &chip11->lpc.xscom_regs);
+
+    chip->fw_mr = &chip11->lpc.isa_fw;
+    chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
+                                            (uint64_t) PNV11_LPCM_BASE(chip));
+
+    /* Create the simplified OCC model */
+    if (!qdev_realize(DEVICE(&chip11->occ), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_OCC_BASE,
+                            &chip11->occ.xscom_regs);
+    qdev_connect_gpio_out(DEVICE(&chip11->occ), 0, qdev_get_gpio_in(
+                              DEVICE(&chip11->psi), PSIHB9_IRQ_OCC));
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(),
+                                PNV11_OCC_SENSOR_BASE(chip),
+                                &chip11->occ.sram_regs);
+
+    /* SBE */
+    if (!qdev_realize(DEVICE(&chip11->sbe), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_SBE_CTRL_BASE,
+                            &chip11->sbe.xscom_ctrl_regs);
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_SBE_MBOX_BASE,
+                            &chip11->sbe.xscom_mbox_regs);
+    qdev_connect_gpio_out(DEVICE(&chip11->sbe), 0, qdev_get_gpio_in(
+                              DEVICE(&chip11->psi), PSIHB9_IRQ_PSU));
+
+    /* HOMER */
+    object_property_set_link(OBJECT(&chip11->homer), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip11->homer), NULL, errp)) {
+        return;
+    }
+    /* Homer Xscom region */
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_PBA_BASE,
+                            &chip11->homer.pba_regs);
+
+    /* Homer mmio region */
+    memory_region_add_subregion(get_system_memory(), PNV11_HOMER_BASE(chip),
+                                &chip11->homer.regs);
+
+    /* PHBs */
+    pnv_chip_power11_phb_realize(chip, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        Object *obj =  OBJECT(&chip11->i2c[i]);
+
+        object_property_set_int(obj, "engine", i + 1, &error_fatal);
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
+                                &error_fatal);
+        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV11_XSCOM_I2CM_BASE +
+                                (chip11->i2c[i].engine - 1) *
+                                        PNV11_XSCOM_I2CM_SIZE,
+                                &chip11->i2c[i].xscom_regs);
+        qdev_connect_gpio_out(DEVICE(&chip11->i2c[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&chip11->psi),
+                                               PSIHB9_IRQ_SBE_I2C));
+    }
+}
+
+static uint32_t pnv_chip_power11_xscom_pcba(PnvChip *chip, uint64_t addr)
+{
+    addr &= (PNV11_XSCOM_SIZE - 1);
+    return addr >> 3;
+}
+
+static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvChipClass *k = PNV_CHIP_CLASS(klass);
+    static const int i2c_ports_per_engine[PNV11_CHIP_MAX_I2C] = {14, 14, 2, 16};
+
+    k->chip_cfam_id = 0x120da04900008000ull; /* P11 (with NX) */
+    k->cores_mask = POWER11_CORE_MASK;
+    k->core_pir = pnv_chip_core_pir_p11;
+    k->intc_create = pnv_chip_power11_intc_create;
+    k->intc_reset = pnv_chip_power10_intc_reset;
+    k->intc_destroy = pnv_chip_power10_intc_destroy;
+    k->intc_print_info = pnv_chip_power10_intc_print_info;
+    k->isa_create = pnv_chip_power11_isa_create;
+    k->dt_populate = pnv_chip_power11_dt_populate;
+    k->pic_print_info = pnv_chip_power11_pic_print_info;
+    k->xscom_core_base = pnv_chip_power11_xscom_core_base;
+    k->xscom_pcba = pnv_chip_power11_xscom_pcba;
+    dc->desc = "PowerNV Chip POWER11";
+    k->num_pecs = PNV11_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV11_CHIP_MAX_I2C;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
+
+    device_class_set_parent_realize(dc, pnv_chip_power11_realize,
+                                    &k->parent_realize);
+}
+
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
@@ -2198,6 +2526,35 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
     return total_count;
 }
 
+static int pnv11_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool cam_ignore, uint8_t priority,
+                                uint32_t logic_serv,
+                                XiveTCTXMatch *match)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int total_count = 0;
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+        int count;
+
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+                               priority, logic_serv, match);
+
+        if (count < 0) {
+            return count;
+        }
+
+        total_count += count;
+    }
+
+    return total_count;
+}
+
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2276,6 +2633,31 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
+static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
+    static const char compat[] = "qemu,powernv11\0ibm,powernv";
+
+    static GlobalProperty phb_compat[] = {
+        { TYPE_PNV_PHB, "version", "5" },
+        { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
+    };
+
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
+    compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
+    pmc->dt_power_mgt = pnv_dt_power_mgt;
+
+    xfc->match_nvt = pnv11_xive_match_nvt;
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2380,7 +2762,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
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
         .name          = MACHINE_TYPE_NAME("powernv10"),
         .parent        = TYPE_PNV_MACHINE,
@@ -2430,6 +2828,17 @@ static const TypeInfo types[] = {
         .abstract      = true,
     },
 
+    /*
+     * P11 chip and variants
+     */
+    {
+        .name          = TYPE_PNV11_CHIP,
+        .parent        = TYPE_PNV_CHIP,
+        .instance_init = pnv_chip_power11_instance_init,
+        .instance_size = sizeof(Pnv11Chip),
+    },
+    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
+
     /*
      * P10 chip and variants
      */
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8c7afe037f00..f99724b7924e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -222,6 +222,52 @@ static const MemoryRegionOps pnv_core_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+/*
+ * POWER11 core controls
+ */
+
+#define PNV11_XSCOM_EC_CORE_THREAD_STATE    0x412
+
+static uint64_t pnv_core_power11_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = 0;
+
+    switch (offset) {
+    case PNV11_XSCOM_EC_CORE_THREAD_STATE:
+        val = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
+    }
+
+    return val;
+}
+
+static void pnv_core_power11_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
+    }
+}
+
+static const MemoryRegionOps pnv_core_power11_xscom_ops = {
+    .read = pnv_core_power11_xscom_read,
+    .write = pnv_core_power11_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
                                  int thread_index)
 {
@@ -372,6 +418,14 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
     pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
 }
 
+static void pnv_core_power11_class_init(ObjectClass *oc, void *data)
+{
+    PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
+
+    pcc->xscom_ops = &pnv_core_power11_xscom_ops;
+    pcc->xscom_size = PNV11_XSCOM_EC_SIZE;
+}
+
 static void pnv_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -403,6 +457,7 @@ static const TypeInfo pnv_core_infos[] = {
     DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
     DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
     DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
+    DEFINE_PNV_CORE_TYPE(power11, "power11"),
 };
 
 DEFINE_TYPES(pnv_core_infos)
@@ -498,6 +553,16 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static const MemoryRegionOps pnv_quad_power11_xscom_ops = {
+    .read = pnv_quad_power10_xscom_read,
+    .write = pnv_quad_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 #define P10_QME_SPWU_HYP 0x83c
 #define P10_QME_SSH_HYP  0x82c
 
@@ -545,6 +610,16 @@ static const MemoryRegionOps pnv_qme_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static const MemoryRegionOps pnv_qme_power11_xscom_ops = {
+    .read = pnv_qme_power10_xscom_read,
+    .write = pnv_qme_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_quad_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
@@ -607,6 +682,20 @@ static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
     pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
 }
 
+static void pnv_quad_power11_class_init(ObjectClass *oc, void *data)
+{
+    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = pnv_quad_power10_realize;
+
+    pqc->xscom_ops = &pnv_quad_power11_xscom_ops;
+    pqc->xscom_size = PNV11_XSCOM_EQ_SIZE;
+
+    pqc->xscom_qme_ops = &pnv_qme_power11_xscom_ops;
+    pqc->xscom_qme_size = PNV11_XSCOM_QME_SIZE;
+}
+
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -634,6 +723,11 @@ static const TypeInfo pnv_quad_infos[] = {
         .name = PNV_QUAD_TYPE_NAME("power10"),
         .class_init = pnv_quad_power10_class_init,
     },
+    {
+        .parent = TYPE_PNV_QUAD,
+        .name = PNV_QUAD_TYPE_NAME("power11"),
+        .class_init = pnv_quad_power11_class_init,
+    },
 };
 
 DEFINE_TYPES(pnv_quad_infos);
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index f9a203d11d0d..619c59a1b17e 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -396,6 +396,69 @@ static const TypeInfo pnv_homer_power10_type_info = {
     .class_init    = pnv_homer_power10_class_init,
 };
 
+static uint64_t pnv_homer_power11_pba_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvHomer *homer = PNV_HOMER(opaque);
+    PnvChip *chip = homer->chip;
+    uint32_t reg = addr >> 3;
+    uint64_t val = 0;
+
+    switch (reg) {
+    case PBA_BAR0:
+        val = PNV11_HOMER_BASE(chip);
+        break;
+    case PBA_BARMASK0: /* P10 homer region mask */
+        val = (PNV11_HOMER_SIZE - 1) & 0x300000;
+        break;
+    case PBA_BAR2: /* P10 occ common area */
+        val = PNV11_OCC_COMMON_AREA_BASE;
+        break;
+    case PBA_BARMASK2: /* P10 occ common area size */
+        val = (PNV11_OCC_COMMON_AREA_SIZE - 1) & 0x700000;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "PBA: read to unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+    return val;
+}
+
+static void pnv_homer_power11_pba_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "PBA: write to unimplemented register: Ox%"
+                  HWADDR_PRIx "\n", addr >> 3);
+}
+
+static const MemoryRegionOps pnv_homer_power11_pba_ops = {
+    .read = pnv_homer_power11_pba_read,
+    .write = pnv_homer_power11_pba_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_homer_power11_class_init(ObjectClass *klass, void *data)
+{
+    PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
+
+    homer->pba_size = PNV11_XSCOM_PBA_SIZE;
+    homer->pba_ops = &pnv_homer_power11_pba_ops;
+    homer->homer_size = PNV11_HOMER_SIZE;
+    homer->homer_ops = &pnv_power9_homer_ops; /* TODO */
+    homer->core_max_base = PNV9_CORE_MAX_BASE;
+}
+
+static const TypeInfo pnv_homer_power11_type_info = {
+    .name          = TYPE_PNV11_HOMER,
+    .parent        = TYPE_PNV_HOMER,
+    .instance_size = sizeof(PnvHomer),
+    .class_init    = pnv_homer_power11_class_init,
+};
+
 static void pnv_homer_realize(DeviceState *dev, Error **errp)
 {
     PnvHomer *homer = PNV_HOMER(dev);
@@ -442,6 +505,7 @@ static void pnv_homer_register_types(void)
     type_register_static(&pnv_homer_power8_type_info);
     type_register_static(&pnv_homer_power9_type_info);
     type_register_static(&pnv_homer_power10_type_info);
+    type_register_static(&pnv_homer_power11_type_info);
 }
 
 type_init(pnv_homer_register_types);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d692858bee78..ef7f270ee0ec 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -692,6 +692,19 @@ static void pnv_lpc_power10_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV LPC Controller POWER10";
 }
 
+static void pnv_lpc_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV LPC Controller POWER11";
+}
+
+static const TypeInfo pnv_lpc_power11_info = {
+    .name          = TYPE_PNV11_LPC,
+    .parent        = TYPE_PNV10_LPC,
+    .class_init    = pnv_lpc_power11_class_init,
+};
+
 static const TypeInfo pnv_lpc_power10_info = {
     .name          = TYPE_PNV10_LPC,
     .parent        = TYPE_PNV9_LPC,
@@ -771,6 +784,7 @@ static void pnv_lpc_register_types(void)
     type_register_static(&pnv_lpc_power8_info);
     type_register_static(&pnv_lpc_power9_info);
     type_register_static(&pnv_lpc_power10_info);
+    type_register_static(&pnv_lpc_power11_info);
 }
 
 type_init(pnv_lpc_register_types)
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 48123ceae176..4f510419045e 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -262,6 +262,19 @@ static const TypeInfo pnv_occ_power10_type_info = {
     .class_init    = pnv_occ_power10_class_init,
 };
 
+static void pnv_occ_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV OCC Controller (POWER11)";
+}
+
+static const TypeInfo pnv_occ_power11_type_info = {
+    .name          = TYPE_PNV11_OCC,
+    .parent        = TYPE_PNV10_OCC,
+    .class_init    = pnv_occ_power11_class_init,
+};
+
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ = PNV_OCC(dev);
@@ -305,6 +318,7 @@ static void pnv_occ_register_types(void)
     type_register_static(&pnv_occ_power8_type_info);
     type_register_static(&pnv_occ_power9_type_info);
     type_register_static(&pnv_occ_power10_type_info);
+    type_register_static(&pnv_occ_power11_type_info);
 }
 
 type_init(pnv_occ_register_types);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 26460d210deb..4304eeb33232 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -941,6 +941,26 @@ static const TypeInfo pnv_psi_power10_info = {
     .class_init    = pnv_psi_power10_class_init,
 };
 
+static void pnv_psi_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
+    static const char compat[] = "ibm,power11-psihb-x\0ibm,psihb-x";
+
+    dc->desc    = "PowerNV PSI Controller POWER11";
+
+    ppc->xscom_pcba = PNV11_XSCOM_PSIHB_BASE;
+    ppc->xscom_size = PNV11_XSCOM_PSIHB_SIZE;
+    ppc->compat     = compat;
+    ppc->compat_size = sizeof(compat);
+}
+
+static const TypeInfo pnv_psi_power11_info = {
+    .name          = TYPE_PNV11_PSI,
+    .parent        = TYPE_PNV10_PSI,
+    .class_init    = pnv_psi_power11_class_init,
+};
+
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -973,6 +993,7 @@ static void pnv_psi_register_types(void)
     type_register_static(&pnv_psi_power8_info);
     type_register_static(&pnv_psi_power9_info);
     type_register_static(&pnv_psi_power10_info);
+    type_register_static(&pnv_psi_power11_info);
 }
 
 type_init(pnv_psi_register_types);
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 74cee4eea7ad..af7b4ad622e3 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -368,6 +368,24 @@ static const TypeInfo pnv_sbe_power10_type_info = {
     .class_init    = pnv_sbe_power10_class_init,
 };
 
+static void pnv_sbe_power11_class_init(ObjectClass *klass, void *data)
+{
+    PnvSBEClass *psc = PNV_SBE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV SBE Controller (POWER11)";
+    psc->xscom_ctrl_size = PNV11_XSCOM_SBE_CTRL_SIZE;
+    psc->xscom_ctrl_ops = &pnv_sbe_power9_xscom_ctrl_ops;
+    psc->xscom_mbox_size = PNV11_XSCOM_SBE_MBOX_SIZE;
+    psc->xscom_mbox_ops = &pnv_sbe_power9_xscom_mbox_ops;
+}
+
+static const TypeInfo pnv_sbe_power11_type_info = {
+    .name          = TYPE_PNV11_SBE,
+    .parent        = TYPE_PNV10_SBE,
+    .class_init    = pnv_sbe_power11_class_init,
+};
+
 static void pnv_sbe_realize(DeviceState *dev, Error **errp)
 {
     PnvSBE *sbe = PNV_SBE(dev);
@@ -409,6 +427,7 @@ static void pnv_sbe_register_types(void)
     type_register_static(&pnv_sbe_type_info);
     type_register_static(&pnv_sbe_power9_type_info);
     type_register_static(&pnv_sbe_power10_type_info);
+    type_register_static(&pnv_sbe_power11_type_info);
 }
 
 type_init(pnv_sbe_register_types);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7e5fef7c4331..2d16bd44b8c8 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -32,6 +32,7 @@ typedef struct PnvChip PnvChip;
 typedef struct Pnv8Chip Pnv8Chip;
 typedef struct Pnv9Chip Pnv9Chip;
 typedef struct Pnv10Chip Pnv10Chip;
+typedef struct Pnv11Chip Pnv11Chip;
 
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
 #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
@@ -56,6 +57,10 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
                          TYPE_PNV_CHIP_POWER10)
 
+#define TYPE_PNV_CHIP_POWER11 PNV_CHIP_TYPE_NAME("power11")
+DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER11,
+                         TYPE_PNV_CHIP_POWER11)
+
 PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
 
 typedef struct PnvPHB PnvPHB;
@@ -243,4 +248,50 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV10_HOMER_BASE(chip)                                           \
     (0x300ffd800000ll + ((uint64_t)(chip)->chip_id) * PNV10_HOMER_SIZE)
 
+/*
+ * POWER11 MMIO base addresses - 16TB stride per chip
+ */
+#define PNV11_CHIP_BASE(chip, base)   \
+    ((base) + ((uint64_t) (chip)->chip_id << 44))
+
+#define PNV11_XSCOM_SIZE             0x0000000400000000ull
+#define PNV11_XSCOM_BASE(chip)       PNV11_CHIP_BASE(chip, 0x00603fc00000000ull)
+
+#define PNV11_LPCM_SIZE             0x0000000100000000ull
+#define PNV11_LPCM_BASE(chip)       PNV11_CHIP_BASE(chip, 0x0006030000000000ull)
+
+#define PNV11_XIVE2_IC_SIZE         0x0000000002000000ull
+#define PNV11_XIVE2_IC_BASE(chip)   PNV11_CHIP_BASE(chip, 0x0006030200000000ull)
+
+#define PNV11_PSIHB_ESB_SIZE        0x0000000000100000ull
+#define PNV11_PSIHB_ESB_BASE(chip)  PNV11_CHIP_BASE(chip, 0x0006030202000000ull)
+
+#define PNV11_PSIHB_SIZE            0x0000000000100000ull
+#define PNV11_PSIHB_BASE(chip)      PNV11_CHIP_BASE(chip, 0x0006030203000000ull)
+
+#define PNV11_XIVE2_TM_SIZE         0x0000000000040000ull
+#define PNV11_XIVE2_TM_BASE(chip)   PNV11_CHIP_BASE(chip, 0x0006030203180000ull)
+
+#define PNV11_XIVE2_NVC_SIZE        0x0000000008000000ull
+#define PNV11_XIVE2_NVC_BASE(chip)  PNV11_CHIP_BASE(chip, 0x0006030208000000ull)
+
+#define PNV11_XIVE2_NVPG_SIZE       0x0000010000000000ull
+#define PNV11_XIVE2_NVPG_BASE(chip) PNV11_CHIP_BASE(chip, 0x0006040000000000ull)
+
+#define PNV11_XIVE2_ESB_SIZE        0x0000010000000000ull
+#define PNV11_XIVE2_ESB_BASE(chip)  PNV11_CHIP_BASE(chip, 0x0006050000000000ull)
+
+#define PNV11_XIVE2_END_SIZE        0x0000020000000000ull
+#define PNV11_XIVE2_END_BASE(chip)  PNV11_CHIP_BASE(chip, 0x0006060000000000ull)
+
+#define PNV11_OCC_COMMON_AREA_SIZE  0x0000000000800000ull
+#define PNV11_OCC_COMMON_AREA_BASE  0x300fff800000ull
+#define PNV11_OCC_SENSOR_BASE(chip) (PNV11_OCC_COMMON_AREA_BASE +       \
+    PNV_OCC_SENSOR_DATA_BLOCK_BASE((chip)->chip_id))
+
+#define PNV11_HOMER_SIZE              0x0000000000400000ull
+#define PNV11_HOMER_BASE(chip)                                           \
+    (0x300ffd800000ll + ((uint64_t)(chip)->chip_id) * PNV11_HOMER_SIZE)
+
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c423088c..fcf65a69e8ed 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -127,6 +127,36 @@ struct Pnv10Chip {
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
 #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
 
+#define TYPE_PNV11_CHIP "pnv11-chip"
+DECLARE_INSTANCE_CHECKER(Pnv11Chip, PNV11_CHIP,
+                         TYPE_PNV11_CHIP)
+
+struct Pnv11Chip {
+    /*< private >*/
+    PnvChip      parent_obj;
+
+    /*< public >*/
+    PnvXive2     xive;
+    Pnv9Psi      psi;
+    PnvLpcController lpc;
+    PnvOCC       occ;
+    PnvSBE       sbe;
+    PnvHomer     homer;
+
+    uint32_t     nr_quads;
+    PnvQuad      *quads;
+
+/* TODO: Check if P11 still should have 'PnvPhb4PecState' or newer Phb5 */
+#define PNV11_CHIP_MAX_PEC 2
+    PnvPhb4PecState pecs[PNV11_CHIP_MAX_PEC];
+
+#define PNV11_CHIP_MAX_I2C 4
+    PnvI2C       i2c[PNV11_CHIP_MAX_I2C];
+};
+
+#define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
+#define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
+
 struct PnvChipClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index b1c5d498dc55..8f1cc8135937 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -35,6 +35,9 @@ DECLARE_INSTANCE_CHECKER(PnvHomer, PNV9_HOMER,
 #define TYPE_PNV10_HOMER TYPE_PNV_HOMER "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvHomer, PNV10_HOMER,
                          TYPE_PNV10_HOMER)
+#define TYPE_PNV11_HOMER TYPE_PNV_HOMER "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvHomer, PNV11_HOMER,
+                         TYPE_PNV11_HOMER)
 
 struct PnvHomer {
     DeviceState parent;
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 5d22c4557041..1069bca38dfd 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -41,6 +41,10 @@ DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV9_LPC,
 DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV10_LPC,
                          TYPE_PNV10_LPC)
 
+#define TYPE_PNV11_LPC TYPE_PNV_LPC "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV11_LPC,
+                         TYPE_PNV11_LPC)
+
 struct PnvLpcController {
     DeviceState parent;
 
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index df321244e3b1..7b5e28f13b4f 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -34,6 +34,8 @@ DECLARE_INSTANCE_CHECKER(PnvOCC, PNV9_OCC,
                          TYPE_PNV9_OCC)
 #define TYPE_PNV10_OCC TYPE_PNV_OCC "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvOCC, PNV10_OCC, TYPE_PNV10_OCC)
+#define TYPE_PNV11_OCC TYPE_PNV_OCC "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvOCC, PNV11_OCC, TYPE_PNV11_OCC)
 
 #define PNV_OCC_SENSOR_DATA_BLOCK_OFFSET 0x00580000
 #define PNV_OCC_SENSOR_DATA_BLOCK_SIZE   0x00025800
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 2a6f715350b6..9e1d31779204 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -70,6 +70,8 @@ struct Pnv9Psi {
 
 #define TYPE_PNV10_PSI TYPE_PNV_PSI "-POWER10"
 
+#define TYPE_PNV11_PSI TYPE_PNV_PSI "-POWER11"
+
 
 struct PnvPsiClass {
     SysBusDeviceClass parent_class;
diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
index b6b378ad14c7..09073a1256d6 100644
--- a/include/hw/ppc/pnv_sbe.h
+++ b/include/hw/ppc/pnv_sbe.h
@@ -29,6 +29,8 @@ OBJECT_DECLARE_TYPE(PnvSBE, PnvSBEClass, PNV_SBE)
 DECLARE_INSTANCE_CHECKER(PnvSBE, PNV9_SBE, TYPE_PNV9_SBE)
 #define TYPE_PNV10_SBE TYPE_PNV_SBE "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvSBE, PNV10_SBE, TYPE_PNV10_SBE)
+#define TYPE_PNV11_SBE TYPE_PNV_SBE "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvSBE, PNV11_SBE, TYPE_PNV11_SBE)
 
 struct PnvSBE {
     DeviceState xd;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab416d..ad2108568c74 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -176,6 +176,61 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
+/*
+ * Layout of the XSCOM PCB addresses (POWER 11)
+ */
+#define PNV11_XSCOM_EQ_CHIPLET(core)  (0x20 + ((core) >> 2))
+#define PNV11_XSCOM_EQ(chiplet)       ((chiplet) << 24)
+#define PNV11_XSCOM_EC(proc)                    \
+    ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
+
+#define PNV11_XSCOM_QME(chiplet) \
+        (PNV11_XSCOM_EQ(chiplet) | (0xE << 16))
+
+/*
+ * Make the region larger by 0x1000 (instead of starting at an offset) so the
+ * modelled addresses start from 0
+ */
+#define PNV11_XSCOM_QME_BASE(core)     \
+    ((uint64_t) PNV11_XSCOM_QME(PNV11_XSCOM_EQ_CHIPLET(core)))
+#define PNV11_XSCOM_QME_SIZE        (0x8000 + 0x1000)
+
+#define PNV11_XSCOM_EQ_BASE(core)     \
+    ((uint64_t) PNV11_XSCOM_EQ(PNV11_XSCOM_EQ_CHIPLET(core)))
+#define PNV11_XSCOM_EQ_SIZE        0x20000
+
+#define PNV11_XSCOM_EC_BASE(core) \
+    ((uint64_t) PNV11_XSCOM_EQ_BASE(core) | PNV11_XSCOM_EC(core & 0x3))
+#define PNV11_XSCOM_EC_SIZE        0x1000
+
+#define PNV11_XSCOM_PSIHB_BASE     0x3011D00
+#define PNV11_XSCOM_PSIHB_SIZE     0x100
+
+#define PNV11_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
+#define PNV11_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
+
+#define PNV11_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
+#define PNV11_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
+
+#define PNV11_XSCOM_SBE_CTRL_BASE  PNV9_XSCOM_SBE_CTRL_BASE
+#define PNV11_XSCOM_SBE_CTRL_SIZE  PNV9_XSCOM_SBE_CTRL_SIZE
+
+#define PNV11_XSCOM_SBE_MBOX_BASE  PNV9_XSCOM_SBE_MBOX_BASE
+#define PNV11_XSCOM_SBE_MBOX_SIZE  PNV9_XSCOM_SBE_MBOX_SIZE
+
+#define PNV11_XSCOM_PBA_BASE       0x01010CDA
+#define PNV11_XSCOM_PBA_SIZE       0x40
+
+#define PNV11_XSCOM_XIVE2_BASE     0x2010800
+#define PNV11_XSCOM_XIVE2_SIZE     0x400
+
+#define PNV11_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
+#define PNV11_XSCOM_PEC_NEST_SIZE  0x100
+
+#define PNV11_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
+#define PNV11_XSCOM_PEC_PCI_SIZE   0x200
+
+
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
-- 
2.43.0


