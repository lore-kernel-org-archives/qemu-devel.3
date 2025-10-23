Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFEFCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkl-0001dW-2k; Thu, 23 Oct 2025 07:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkZ-0001PC-OS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkV-0001c0-Ct
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3aMWO026207;
 Thu, 23 Oct 2025 11:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wih0cG
 6UAMGul2imA4gk0mNhbLpBRw+cuAyP66e7sFA=; b=nWkNCTs75gvSSYgefLUS6H
 3ArqbbItDqnz8NF6OsRn1Pt0v+fnf7Mq69Xl7xNOw7SZMErUkCGRUhChgF4pddlK
 2x5stfzHChaiCeYVC61ngD0hGpOm7u4ZWEDMUEc0nE2Y4CvFp57R2thLSNBSeFrW
 8nZPwbK5EcY5/ziT9fxXN5g8lWQRBXqNjUbPA0HJ9w/CBinmtr2DxalGaoM8KVzj
 ETMl0y5wfEhx/UpKMAi0xXBfV2t0R/s9baZ4pPdzjRMpymgsiNA/nR2nNGxLNAmX
 /aNO072U00Pspeokv8lUEqY+ZINbVsRt/OxUArJjcb3e9Ba4AkEmtNtflR77z5Pg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fhx5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA8XLE024303;
 Thu, 23 Oct 2025 11:44:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5ds9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBifHA46727562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCC7020040;
 Thu, 23 Oct 2025 11:44:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D29C020049;
 Thu, 23 Oct 2025 11:44:40 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:40 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/32] ppc/spapr: remove deprecated machine pseries-4.1
Date: Thu, 23 Oct 2025 17:13:57 +0530
Message-ID: <20251023114422.3675018-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa152d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=DRTwgpVIqhQ9bHD4Ks0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: jZK9Rvhs_qjY0Z5AnA_xe8EaQlrkRDJS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+SSInFEZjA5g
 3xmW90rSkFv0NjjNBcxT1LYHzPJb0shZnwEVFc0suDYY6ThMg19nfU/iqz7v4IpaQjQo4RtQqwb
 x2lxly83ccueK2xnHr7QMRrDB92izPgZdCG6sSCU/FYe1Im/hxRPEn6rIOkCTMO9Fqp3DnFVtIg
 wrUt46FUucziclWloQVPBtSK4B9OcjiBp1hx/nO6sGYyrqq/muKlatL31pnaUug5B2XDMyGTTHH
 GAQpoE3O1VKC6pXgER4x7tfKt8lh23IFb0hC4YFddJtRHpaRBtwiahFW0rHS5GoGMcHUFwOx+9r
 Jk9N4gScTIc36/hdLm0eWb4JgMfdwuJmlf6Yd5R6vbTMV1bWHYySVjC86dTFSN/FjVHvP9zDChY
 9ShotR4rVfDh+mS+7ZcGXLBnGb1YGg==
X-Proofpoint-ORIG-GUID: jZK9Rvhs_qjY0Z5AnA_xe8EaQlrkRDJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Remove the pseries-4.1 machine specific logic as had been deprecated and
due for removal now as per policy.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-11-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  2 --
 hw/ppc/spapr.c         | 37 +------------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd783e92e1..60d9a8a037 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,8 +141,6 @@ struct SpaprCapabilities {
 struct SpaprMachineClass {
     MachineClass parent_class;
 
-    bool linux_pci_probe;
-    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 371593d0b5..0e6218dc9c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1072,7 +1072,6 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
 static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int chosen;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
@@ -1143,9 +1142,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
          * We can deal with BAR reallocation just fine, advertise it
          * to the guest
          */
-        if (smc->linux_pci_probe) {
-            _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
-        }
+        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
 
         spapr_dt_ov5_platform_support(spapr, fdt, chosen);
     }
@@ -2589,7 +2586,6 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *ms = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err = NULL;
     bool vsmt_user = !!spapr->vsmt;
     int kvm_smt = kvmppc_smt_threads();
@@ -2625,15 +2621,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
             return;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else if (!smc->smp_threads_vsmt) {
-        /*
-         * Default VSMT value is tricky, because we need it to be as
-         * consistent as possible (for migration), but this requires
-         * changing it for at least some existing cases.  We pick 8 as
-         * the value that we'd get with KVM on POWER8, the
-         * overwhelmingly common case in production systems.
-         */
-        spapr->vsmt = MAX(8, smp_threads);
     } else {
         spapr->vsmt = smp_threads;
     }
@@ -4649,8 +4636,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->linux_pci_probe = true;
-    smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
@@ -4945,26 +4930,6 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 2);
 
-/*
- * pseries-4.1
- */
-static void spapr_machine_4_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        /* Only allow 4kiB and 64kiB IOMMU pagesizes */
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
-    };
-
-    spapr_machine_4_2_class_options(mc);
-    smc->linux_pci_probe = false;
-    smc->smp_threads_vsmt = false;
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(4, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.43.5


