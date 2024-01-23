Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09410C47DDC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 21:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSOFe-0008Vm-RX; Tue, 23 Jan 2024 16:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1rSMmz-0003B9-3j
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 14:50:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1rSMmu-0006ng-73
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 14:50:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40NJIrXu017648; Tue, 23 Jan 2024 19:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FyMg7DyGtb9KE308hqwf8QEanwme8lOdWQT1vUdNquQ=;
 b=Mw7S6teYYwtr9/8dbcMbUis6AJ1K4O2XiLM0HYcVz7hU4AFp9Y2fvmHQrm3VVmio+LY0
 UmV0KZhwLhxf56eijA0xWYMV6qOZ3wIDQaBpWKd4U3I8tCqubc9ts1i6zAypBqEOLC+q
 0hHW0ti3yR8OXjh1kyYjkslmXZo7Or1kFL5maoK9/4HsIt+VFndxrJik514s1pjQVxFN
 VpvcA5J+HUtwNfjoQbfmkgBUtrAfC9AFniBGYG4+ljLL+BeXmKf2eVvZh73FjnFWzXlM
 dvdfDhZ+DwXd0L8D/9aZ33fyxCsgnXizBPYI58UT+Gm51PXuCU+DrNTuIR9zACedzRRU fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtk6b9hs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 19:50:16 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NJlwcd002178;
 Tue, 23 Jan 2024 19:50:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtk6b9hrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 19:50:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40NHMQxJ010861; Tue, 23 Jan 2024 19:50:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrvysgqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 19:50:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40NJoEtj20644532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jan 2024 19:50:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37A9858056;
 Tue, 23 Jan 2024 19:50:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDC5658052;
 Tue, 23 Jan 2024 19:50:13 +0000 (GMT)
Received: from gfwr540.rchland.ibm.com (unknown [9.10.239.160])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jan 2024 19:50:13 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com,
 danielhb413@gmail.com
Subject: [PATCH] ppc/pnv: Improve pervasive topology calculation for big-core
Date: Tue, 23 Jan 2024 13:50:05 -0600
Message-Id: <20240123195005.8965-1-calebs@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uVeOJngu5TqTPO2w44j9ssOcy90pcwBt
X-Proofpoint-ORIG-GUID: 9XuIJBRKJa8E192k5E4NFA5eA-hD_XSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230147
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=calebs@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Jan 2024 16:24:01 -0500
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

Big (SMT8) cores have a complicated function to map the core, thread ID
to pervasive topology (PIR). Fix this for power8, power9, and power10.

Signed-off-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
---
 include/hw/ppc/pnv_chip.h |  2 +-
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 60 ++++++++++++++++++++++++++-------------
 hw/ppc/pnv_core.c         |  8 +++---
 target/ppc/misc_helper.c  |  3 --
 5 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..d77e63b0a4 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -142,7 +142,7 @@ struct PnvChipClass {
 
     DeviceRealize parent_realize;
 
-    uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
+    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 4db21229a6..c6d62fd145 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -36,6 +36,7 @@ struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
+    uint32_t hwid;
     uint64_t hrmor;
     PnvChip *chip;
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..9964f2665a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -141,8 +141,10 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     int smt_threads = CPU_CORE(pc)->nr_threads;
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
     g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
     int i;
+    uint32_t pir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -158,15 +160,17 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    nodename = g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
+    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
     _FDT(offset);
     g_free(nodename);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id", chip->chip_id)));
 
-    _FDT((fdt_setprop_cell(fdt, offset, "reg", pc->pir)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,pir", pc->pir)));
+    _FDT((fdt_setprop_cell(fdt, offset, "reg", pir)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,pir", pir)));
     _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
 
     _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
@@ -241,15 +245,17 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(pc->pir + i);
+        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
 }
 
-static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
+static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
                        uint32_t nr_threads)
 {
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
     uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
     char *name;
     const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
@@ -263,6 +269,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
     rsize = sizeof(uint64_t) * 2 * nr_threads;
     reg = g_malloc(rsize);
     for (i = 0; i < nr_threads; i++) {
+        /* We know P8 PIR is linear with thread id */
         reg[i * 2] = cpu_to_be64(addr | ((pir + i) * 0x1000));
         reg[i * 2 + 1] = cpu_to_be64(0x1000);
     }
@@ -315,7 +322,7 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
         pnv_dt_core(chip, pnv_core, fdt);
 
         /* Interrupt Control Presenters (ICP). One per core. */
-        pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
+        pnv_dt_icp(chip, fdt, pnv_core->hwid, CPU_CORE(pnv_core)->nr_threads);
     }
 
     if (chip->ram_size) {
@@ -987,9 +994,10 @@ static void pnv_init(MachineState *machine)
  *   25:28  Core number
  *   29:31  Thread ID
  */
-static uint32_t pnv_chip_core_pir_p8(PnvChip *chip, uint32_t core_id)
+static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
+                                uint32_t thread_id)
 {
-    return (chip->chip_id << 7) | (core_id << 3);
+    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
 }
 
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1041,14 +1049,26 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, uint32_t core_id)
+static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
+                                uint32_t thread_id)
 {
-    return (chip->chip_id << 8) | (core_id << 2);
+    if (chip->nr_threads == 8) {
+        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
+               (thread_id >> 1);
+    } else {
+        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+    }
 }
 
-static uint32_t pnv_chip_core_pir_p10(PnvChip *chip, uint32_t core_id)
+static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
+                                 uint32_t thread_id)
 {
-    return (chip->chip_id << 8) | (core_id << 2);
+    if (chip->nr_threads == 8) {
+        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
+               (thread_id >> 1);
+    } else {
+        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+    }
 }
 
 static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1227,7 +1247,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
         int core_hwid = CPU_CORE(pnv_core)->core_id;
 
         for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir = pcc->core_pir(chip, core_hwid) + j;
+            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
             PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
 
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
@@ -1340,7 +1360,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1364,7 +1384,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1388,7 +1408,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1646,7 +1666,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
-    k->core_pir = pnv_chip_core_pir_p9;
+    k->chip_pir = pnv_chip_pir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
@@ -1895,7 +1915,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
-    k->core_pir = pnv_chip_core_pir_p10;
+    k->chip_pir = pnv_chip_pir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
@@ -1985,8 +2005,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 chip->nr_threads, &error_fatal);
         object_property_set_int(OBJECT(pnv_core), CPU_CORE_PROP_CORE_ID,
                                 core_hwid, &error_fatal);
-        object_property_set_int(OBJECT(pnv_core), "pir",
-                                pcc->core_pir(chip, core_hwid), &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), "hwid", core_hwid,
+                                &error_fatal);
         object_property_set_int(OBJECT(pnv_core), "hrmor", pnv->fw_load_addr,
                                 &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8c7afe037f..f40ab721d6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -226,7 +226,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
                                  int thread_index)
 {
     CPUPPCState *env = &cpu->env;
-    int core_pir;
+    int core_hwid;
     ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
     ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
     Error *local_err = NULL;
@@ -242,10 +242,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
         return;
     }
 
-    core_pir = object_property_get_uint(OBJECT(pc), "pir", &error_abort);
+    core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
 
     tir->default_value = thread_index;
-    pir->default_value = core_pir + thread_index;
+    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
@@ -342,7 +342,7 @@ static void pnv_core_unrealize(DeviceState *dev)
 }
 
 static Property pnv_core_properties[] = {
-    DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
+    DEFINE_PROP_UINT32("hwid", PnvCore, hwid, 0),
     DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a9d41d2802..58e808dc96 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -49,9 +49,6 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
     uint32_t nr_threads = cs->nr_threads;
-    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
-
-    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
 
     if (nr_threads == 1) {
         env->spr[sprn] = val;
-- 
2.31.1


