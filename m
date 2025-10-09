Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A14DCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6n2g-0005uz-2b; Thu, 09 Oct 2025 05:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2e-0005sY-3U; Thu, 09 Oct 2025 05:34:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2U-0001lg-Uh; Thu, 09 Oct 2025 05:34:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59953vCd012427;
 Thu, 9 Oct 2025 09:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=POA1He
 S75COE92NsOG/SsNmTEwJpDG97qvIL24lTrB0=; b=YjW4Kh/jhhzZ86AKL0ZszN
 IS2TBW58FWP8+xh16b/HMs5ZjFcZcurtsSkUUchO3Xqt01NvSfjn/jguo8cjgRKd
 V3VPgJ8tkKbkZ3qetlb2eBxZDzGri/z79V97RCN9nFzHvAAtah1LD55s1X+XDhJy
 nW5PLRlEM1T31pWTOE6vOWsD9Yr6urzjYmkYHSoGPrq6g16V1wa6Z12CuFkt2gWK
 sSJPpJVjeGA0X1Y0+wq1jmciTnvU1TfncS/VdkqwbzfC2ZcSzP7rP2GK0rtdwHup
 1DIZx4Z3I1XKduHWeTpXT4qo0dEvRqDHozdTLa5j5tOEUGJ91YXjEE32uvh9NUSg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7ybwpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5999UVBI029054;
 Thu, 9 Oct 2025 09:34:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7ybwpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998Ub6Q012985;
 Thu, 9 Oct 2025 09:34:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamusaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5999Y8Th52232496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 09:34:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 834B320075;
 Thu,  9 Oct 2025 09:34:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CAD520082;
 Thu,  9 Oct 2025 09:34:07 +0000 (GMT)
Received: from ltcfuji9aw-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 09:34:07 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, philmd@linaro.org
Cc: npiggin@gmail.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/5] ppc/spapr: remove deprecated machine pseries-3.0
Date: Thu,  9 Oct 2025 14:40:53 -0400
Message-ID: <20251009184057.19973-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009184057.19973-1-harshpb@linux.ibm.com>
References: <20251009184057.19973-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: URw9sM3SFWxZai4rqkufJ162dVtx-LaB
X-Proofpoint-ORIG-GUID: G99mRDUBZDXyonkEyCEYR3-t3S7lOlbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8u56AvYOx8tS
 fECAQBc5Q6PhKUIS0eTH/kO+srgV6yi9E8DAog4+sFpw9Mgk9A19/m5TBMHssUpLuP+0PbAYcma
 CADz3tP85OZstHfcdGsNIpQ4aFRWgAsmFtZ8ksSCrcwFN6ZbrJFc7gD5q0/XSe7WPj4iVEPrbh5
 oRHX6G6OOSGj+V+Sd9jUMqcFr73pKHXTTg2lakl/zdrSkc8MZSqimyX24rgxcPPhQMURSeVNW90
 9DtAc5d8kTnYM54sNHo1VrfZ6NM3p1FGaW+SB/Ezu3yLCKTj4rDlFM/IBzbqpa7yfashtTYG9Fo
 nQsxVAMJKPaEYsLEb1OMl6k7Ww0m9mhls2oXK5gRe5A8q3qizn3MNN7Ew2PALI8s7UeUm25nC3T
 kSBfNSNY1R8yTsAGEpbGeJie6cpwdg==
X-Authority-Analysis: v=2.4 cv=FtwIPmrq c=1 sm=1 tr=0 ts=68e78193 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=GhfPg2sD2UaM3MgJKtQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
index 97ab6bebd2..426a778d3e 100644
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
2.51.0


