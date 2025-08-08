Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E8C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLm6-0006MD-DO; Fri, 08 Aug 2025 08:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlR-0004lA-Qi; Fri, 08 Aug 2025 08:00:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlM-0006h0-ME; Fri, 08 Aug 2025 07:59:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578BlF9Z019429;
 Fri, 8 Aug 2025 11:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mq0tA3
 MAi2iPVby4xzpXDdo2FkM7A+Ard6hclULS7hs=; b=emWc1+q2yaFY5EIRX4Bmdj
 ReLzku8fg1r4Yth5CHqnZG0zawUQjAHXMzzSNOYZFuoA6nu5Z11vD34VPBRG7Oxf
 FEQ+IiXSzuq+cDnrkZdkvJ+Lx4iDC1coSCsU+MhN2aMJrrIuLLhfhg7QgxvpQCtC
 Yo42wW9qQm0uHeTw6iukhTgJFkOYbY/p0KIwLu7+F6xOKxIywH8OlvRlH9jQKR9G
 wbYWkgN1vm+Eq7B9+KFRrenbOaXyh9MjdTVmXyBVu83LauzWpEFNPan8luYMiNVW
 mDraw29NnJPwGhLLz//fTH+pDW3NMX2b9LkrHg6aRTri/KpggYqD9ll6g1Xah1nA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5j0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578Bnau3004892;
 Fri, 8 Aug 2025 11:59:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5j09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578AH0uT001500;
 Fri, 8 Aug 2025 11:59:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr5gex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578BxnDI33751444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 11:59:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51C142004D;
 Fri,  8 Aug 2025 11:59:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F35320040;
 Fri,  8 Aug 2025 11:59:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.151])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 11:59:45 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v9 3/7] ppc/pnv: Add XIVE2 controller to Power11
Date: Fri,  8 Aug 2025 17:29:25 +0530
Message-ID: <20250808115929.1073910-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808115929.1073910-1-adityag@linux.ibm.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lT9WlnaoG2lHxqe0v6A2V-kmuN5s1_GD
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6895e6ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VvyhdzPrB7g4W_GO34sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lyWsG-CG1ZN17uf-Rrmo1Uy98MZFW9wH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5NiBTYWx0ZWRfX5wxtYql2+pFq
 SLsMuPmeJQPwHJPDKvhuVAc4/JhzuSUn56KMc0ymjglCCkv54+l+TuM69IcYvp9QlFz/NH3JxGw
 d+efX+4ssRYpP5LAg9IZNbuG8brY2FCm1/54MWeHpHlu78E6x50toT+cY2yoZKKYin5Ym8KudMH
 PCZms07+uopNuyHMxAE3pfzYGdeKjxhvUQ0t8kotS4Aaijqpo+ieIv2How+zlNTjL5pxCaSxGrF
 7X0UHegJpKlc6x4Sd2papMMR2X4nPhLk/tdG8laCAwDJ7BAJM6eqJVF1XvH1NJiOVx/o/vRX1Zd
 8jHsDjd2gr0KSFKpTBr5lcQHaBUojcF/nsZHKFwk+9KxHFn4RJzKPd6KufNE3JLHf0GMg3Ho9Zk
 cHCbWnocqimDtN0Df7ESAJ0J0ILAolrfLuTo/GcpDHg80O93Cvq5GjGL1P9b9hokH0M0nIUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Add a XIVE2 controller to Power11 chip and machine.
The controller has the same logic as Power10.

Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c         | 121 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/pnv.h |  18 +++++++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b21c4aafaecb..eb89dd8b5a89 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -975,6 +975,7 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
 {
     Pnv11Chip *chip11 = PNV11_CHIP(chip);
 
+    pnv_xive2_pic_print_info(&chip11->xive, buf);
     pnv_psi_pic_print_info(&chip11->psi, buf);
 }
 
@@ -1485,6 +1486,50 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
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
+static void pnv_chip_power11_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
+}
+
+static void pnv_chip_power11_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
+    pnv_cpu->intc = NULL;
+}
+
+static void pnv_chip_power11_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                             GString *buf)
+{
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -2347,6 +2392,10 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip11->homer, TYPE_PNV10_HOMER);
+
+    object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
+    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
+                              "xive-fabric");
     object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
@@ -2414,7 +2463,26 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* WIP: XIVE added in future patch */
+    /* XIVE2 interrupt controller */
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
 
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip11->psi), "bar",
@@ -2615,6 +2683,10 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
     k->cores_mask = POWER11_CORE_MASK;
     k->get_pir_tir = pnv_get_pir_tir_p10;
+    k->intc_create = pnv_chip_power11_intc_create;
+    k->intc_reset = pnv_chip_power11_intc_reset;
+    k->intc_destroy = pnv_chip_power11_intc_destroy;
+    k->intc_print_info = pnv_chip_power11_intc_print_info;
     k->isa_create = pnv_chip_power11_isa_create;
     k->dt_populate = pnv_chip_power11_dt_populate;
     k->pic_print_info = pnv_chip_power11_pic_print_info;
@@ -2967,6 +3039,45 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
     return 0;
 }
 
+static bool pnv11_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool crowd, bool cam_ignore, uint8_t priority,
+                                 uint32_t logic_serv,
+                                 XiveTCTXMatch *match)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                       cam_ignore, priority, logic_serv, match);
+    }
+
+    return !!match->count;
+}
+
+static int pnv11_xive_broadcast(XiveFabric *xfb,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore,
+                                uint8_t priority)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
+    }
+    return 0;
+}
+
 static bool pnv_machine_get_big_core(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -3145,6 +3256,7 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
     static const char compat[] = "qemu,powernv11\0ibm,powernv";
 
     pmc->compat = compat;
@@ -3154,6 +3266,9 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
+    xfc->match_nvt = pnv11_xive_match_nvt;
+    xfc->broadcast = pnv11_xive_broadcast;
+
     mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
 
@@ -3287,6 +3402,10 @@ static const TypeInfo types[] = {
         .name          = MACHINE_TYPE_NAME("powernv11"),
         .parent        = TYPE_PNV_MACHINE,
         .class_init    = pnv_machine_power11_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_XIVE_FABRIC },
+            { },
+        },
     },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f0002627bcab..cbdddfc73cd4 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -270,6 +270,24 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV11_PSIHB_SIZE            PNV10_PSIHB_SIZE
 #define PNV11_PSIHB_BASE(chip)      PNV10_PSIHB_BASE(chip)
 
+#define PNV11_XIVE2_IC_SIZE         PNV10_XIVE2_IC_SIZE
+#define PNV11_XIVE2_IC_BASE(chip)   PNV10_XIVE2_IC_BASE(chip)
+
+#define PNV11_XIVE2_TM_SIZE         PNV10_XIVE2_TM_SIZE
+#define PNV11_XIVE2_TM_BASE(chip)   PNV10_XIVE2_TM_BASE(chip)
+
+#define PNV11_XIVE2_NVC_SIZE        PNV10_XIVE2_NVC_SIZE
+#define PNV11_XIVE2_NVC_BASE(chip)  PNV10_XIVE2_NVC_BASE(chip)
+
+#define PNV11_XIVE2_NVPG_SIZE       PNV10_XIVE2_NVPG_SIZE
+#define PNV11_XIVE2_NVPG_BASE(chip) PNV10_XIVE2_NVPG_BASE(chip)
+
+#define PNV11_XIVE2_ESB_SIZE        PNV10_XIVE2_ESB_SIZE
+#define PNV11_XIVE2_ESB_BASE(chip)  PNV10_XIVE2_ESB_BASE(chip)
+
+#define PNV11_XIVE2_END_SIZE        PNV10_XIVE2_END_SIZE
+#define PNV11_XIVE2_END_BASE(chip)  PNV10_XIVE2_END_BASE(chip)
+
 #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
 
 #endif /* PPC_PNV_H */
-- 
2.50.1


