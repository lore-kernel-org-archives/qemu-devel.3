Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322B5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkQ-0001If-F9; Thu, 23 Oct 2025 07:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkL-0001Gr-1Q
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkI-0001aE-K3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5R1Fu023364;
 Thu, 23 Oct 2025 11:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aGpdOx
 5srQqBseabcnjAruwWDGp9OZFmOqRMpxt9nGw=; b=AL+fA6xfVH6M3kV1yXtMCK
 nKP2AcdPXw3qComzT65W4x/wa82rZ/F7RtHaRWveo7GOo4LZlpdGm4c4dkyXay+x
 yUb9Q11iRlWPS/SUfqf+S2MiXwADE4UTgWwjcLnNWuiXaWAyAKPYNgfoV3EXlc0Y
 EL/8CnYJjMsbpNgNPpTNRQVSrq2pziVXN06NM3LmDnVtqSSBVEtcdjrVrbZ7vbfd
 VX+Ui9LDLFGqLQKgEFZqWF3XlJIFNH1xMlbr4vwlMSfnz9owCn2jWdunPAa1rnqm
 tw09UNEFJlYSODDIAh7sFGvE8Y0WnvVCCLGroHI+ifvTsRm9gJ1Kho50TF/QTQ9A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w0ef0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9dfpb017052;
 Thu, 23 Oct 2025 11:44:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky5krj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiUBF44564840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C454820040;
 Thu, 23 Oct 2025 11:44:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA84D20049;
 Thu, 23 Oct 2025 11:44:29 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/32] ppc/spapr: remove deprecated machine pseries-3.0
Date: Thu, 23 Oct 2025 17:13:48 +0530
Message-ID: <20251023114422.3675018-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BtFsqrKzjrnTIem3QKwC2V3-7yh85U7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2tiAI+JCywUE
 TddDWRvkPJDscJbr0L0zHqDNVax7E4J19ZHOyzltL2jLaRNZXcHTpmFSOOOL5zfYbJpw+U4pTdb
 DqD0Fz+nBqF5Q+yU97LYVIjGUjQUO0yUYNUxS+v9biDbGey5q63rl9Ct0hLYXi9U9XUCOEHX6hS
 IciXzOu2UTG5pW5nsX+Jp9pJvj0VlQyW/mZO+JzUMntgzuqdaQFIGKNhhHNCeicQM2ofDBHhlWD
 4+9GfWQb2qDttV6FH1cnRH8jCwWHa4ErWVkE2ElmdAgFA9H6byu+fkywKrptznOQCuCVM0vUUOC
 g8RYCNmcTJf+lWVii97Ja/Ud43LV0wKWJiNVhxd7T2+iV9HxHcDWJBxWRLXRdQj6U7FLJHoRAoq
 XTt1kKbXvCtOLxgd0eNHCPISpW9Egg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa1521 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=GhfPg2sD2UaM3MgJKtQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: BtFsqrKzjrnTIem3QKwC2V3-7yh85U7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

pseries-3.0 had been deprecated and due for removal now as per policy.
Also remove legacy irq support which existed for pre pseries-3.1 machines.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-2-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h     |  1 -
 include/hw/ppc/spapr_irq.h |  1 -
 hw/ppc/spapr.c             | 27 +--------------------------
 hw/ppc/spapr_events.c      |  8 --------
 hw/ppc/spapr_irq.c         | 16 +---------------
 hw/ppc/spapr_pci.c         | 32 ++++----------------------------
 hw/ppc/spapr_vio.c         |  9 ---------
 7 files changed, 6 insertions(+), 88 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed..0c1e5132de 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool legacy_irq_allocation;
     uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index cb9a85f657..5ddd1107c3 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -100,7 +100,6 @@ typedef struct SpaprIrq {
 } SpaprIrq;
 
 extern SpaprIrq spapr_irq_xics;
-extern SpaprIrq spapr_irq_xics_legacy;
 extern SpaprIrq spapr_irq_xive;
 extern SpaprIrq spapr_irq_dual;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e0a2e5a984..3728ae2a5e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3347,9 +3347,7 @@ static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (spapr->irq == &spapr_irq_xics_legacy) {
-        return g_strdup("legacy");
-    } else if (spapr->irq == &spapr_irq_xics) {
+    if (spapr->irq == &spapr_irq_xics) {
         return g_strdup("xics");
     } else if (spapr->irq == &spapr_irq_xive) {
         return g_strdup("xive");
@@ -3363,11 +3361,6 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        error_setg(errp, "This machine only uses the legacy XICS backend, don't pass ic-mode");
-        return;
-    }
-
     /* The legacy IRQ backend can not be set */
     if (strcmp(value, "xics") == 0) {
         spapr->irq = &spapr_irq_xics;
@@ -5062,24 +5055,6 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(3, 1);
 
-/*
- * pseries-3.0
- */
-
-static void spapr_machine_3_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_3_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-
-    smc->legacy_irq_allocation = true;
-    smc->nr_xirqs = 0x400;
-    smc->irq = &spapr_irq_xics_legacy;
-}
-
-DEFINE_SPAPR_MACHINE(3, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 832b0212f3..548a190ce8 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1043,10 +1043,6 @@ void spapr_events_init(SpaprMachineState *spapr)
 {
     int epow_irq = SPAPR_IRQ_EPOW;
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        epow_irq = spapr_irq_findone(spapr, &error_fatal);
-    }
-
     spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
@@ -1067,10 +1063,6 @@ void spapr_events_init(SpaprMachineState *spapr)
     if (spapr->use_hotplug_event_source) {
         int hp_irq = SPAPR_IRQ_HOTPLUG;
 
-        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-            hp_irq = spapr_irq_findone(spapr, &error_fatal);
-        }
-
         spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6d368dd08..317d57a380 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -33,11 +33,6 @@ static const TypeInfo spapr_intc_info = {
 
 static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        /* Legacy mode doesn't use this allocator */
-        return;
-    }
-
     spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
     spapr->irq_map = bitmap_new(spapr->irq_map_nr);
 }
@@ -286,11 +281,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
-    if (smc->legacy_irq_allocation) {
-        return smc->nr_xirqs;
-    } else {
-        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
-    }
+    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
 }
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
@@ -588,11 +579,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
     return first + ics->offset;
 }
 
-SpaprIrq spapr_irq_xics_legacy = {
-    .xics        = true,
-    .xive        = false,
-};
-
 static void spapr_irq_register_types(void)
 {
     type_register_static(&spapr_intc_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f9095552e8..bdec8f0728 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -268,7 +268,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                 target_ulong args, uint32_t nret,
                                 target_ulong rets)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t config_addr = rtas_ld(args, 0);
     uint64_t buid = rtas_ldq(args, 1);
     unsigned int func = rtas_ld(args, 3);
@@ -373,13 +372,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     /* Allocate MSIs */
-    if (smc->legacy_irq_allocation) {
-        irq = spapr_irq_find(spapr, req_num, ret_intr_type == RTAS_TYPE_MSI,
-                             &err);
-    } else {
-        irq = spapr_irq_msi_alloc(spapr, req_num,
-                                  ret_intr_type == RTAS_TYPE_MSI, &err);
-    }
+    irq = spapr_irq_msi_alloc(spapr, req_num,
+                              ret_intr_type == RTAS_TYPE_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -393,9 +387,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
             if (i) {
                 spapr_irq_free(spapr, irq, i);
             }
-            if (!smc->legacy_irq_allocation) {
-                spapr_irq_msi_free(spapr, irq, req_num);
-            }
+            spapr_irq_msi_free(spapr, irq, req_num);
             error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                               config_addr);
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -1789,12 +1781,9 @@ static void spapr_phb_unrealize(DeviceState *dev)
 static void spapr_phb_destroy_msi(gpointer opaque)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     SpaprPciMsi *msi = opaque;
 
-    if (!smc->legacy_irq_allocation) {
-        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-    }
+    spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
     spapr_irq_free(spapr, msi->first_irq, msi->num);
     g_free(msi);
 }
@@ -1808,7 +1797,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SpaprMachineState *spapr =
         (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
     PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
@@ -1956,18 +1944,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PCI_NUM_PINS; i++) {
         int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
 
-        if (smc->legacy_irq_allocation) {
-            irq = spapr_irq_findone(spapr, errp);
-            if (irq < 0) {
-                error_prepend(errp, "can't allocate LSIs: ");
-                /*
-                 * Older machines will never support PHB hotplug, ie, this is an
-                 * init only path and QEMU will terminate. No need to rollback.
-                 */
-                return;
-            }
-        }
-
         if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
             error_prepend(errp, "can't allocate LSIs: ");
             goto unrealize;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7759436a4f..c21a2a3274 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -507,15 +507,6 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 
     dev->irq = spapr_vio_reg_to_irq(dev->reg);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        int irq = spapr_irq_findone(spapr, errp);
-
-        if (irq < 0) {
-            return;
-        }
-        dev->irq = irq;
-    }
-
     if (spapr_irq_claim(spapr, dev->irq, false, errp) < 0) {
         return;
     }
-- 
2.43.5


