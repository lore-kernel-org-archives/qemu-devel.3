Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45557C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLd3-0003qe-8H; Tue, 20 Feb 2024 03:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLca-0003HX-Nw; Tue, 20 Feb 2024 03:37:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcX-00058m-7e; Tue, 20 Feb 2024 03:36:59 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7VBUv005130; Tue, 20 Feb 2024 08:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CvXXSsiKK68SuGperjvnxcHgxVcBu/7LMySO1QxajDM=;
 b=gRQtnsLPM9HvKCm+ncWzKyUGXASrKy0lvJ2Ps7opHScrqQYqo6sRy+pHq0dnbuUb5EsH
 WuJ+MGIgs6WBh0aUW2fABwKXquJBaoN/+jnuf8RlAVy4ijwJM7PgPjGHrcFPdgeZY+gP
 Va00At+M0faIDmI/0VKw5OFjq2W0IkwwVKb/TIP+Vyzu7mUgxlJy9+SsXOQDjxM42m8Y
 erpNdVdOE3QW9ecZ11KRMSFTDnDKSFqn8xI1uOj5+K2j/LzpbR9rmUwf+PBgu/fPNtIi
 3xwkfe0up0Kf21YXavGASrdX9PSJvkmiqAo5Y+g7oQHjqyEqojtmffrPI7MGJyrXK9RQ qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:53 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8HkQf027653;
 Tue, 20 Feb 2024 08:36:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K5tAHh017261; Tue, 20 Feb 2024 08:36:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm6sq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8ajx625494160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC84820043;
 Tue, 20 Feb 2024 08:36:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0908020040;
 Tue, 20 Feb 2024 08:36:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 14/15] spapr: nested: Introduce cap-nested-papr for Nested
 PAPR API
Date: Tue, 20 Feb 2024 14:06:08 +0530
Message-Id: <20240220083609.748325-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uvSGEvkUwgKzcVhVuAEeDpJW7T1uzWnn
X-Proofpoint-GUID: ApD7FyHGNW1lxsbx63wnygmUdgGK5Gox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
API for nested guests. This new API is to enable support for KVM on PowerVM
and the support in Linux kernel has already merged upstream.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  6 ++++-
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nested.c  | 19 ++++++++++++--
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 036a7db2bc..1b1d37123a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,10 @@ typedef enum {
 #define SPAPR_CAP_RPT_INVALIDATE        0x0B
 /* Support for AIL modes */
 #define SPAPR_CAP_AIL_MODE_3            0x0C
+/* Nested PAPR */
+#define SPAPR_CAP_NESTED_PAPR           0x0D
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
 
 /*
  * Capability Values
@@ -994,6 +996,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_nested_papr;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
@@ -1041,5 +1044,6 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
 void spapr_register_nested_hv(void);
 void spapr_unregister_nested_hv(void);
 void spapr_register_nested_papr(void);
+void spapr_unregister_nested_papr(void);
 
 #endif /* HW_SPAPR_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3453b30a57..cb556ae6a8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2120,6 +2120,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_nested_papr,
         NULL
     }
 };
@@ -4688,6 +4689,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 721ddad23b..9a29ce1872 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -487,12 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
             error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
                                     "or use threads=1 with -smp\n");
         }
+        if (spapr->nested.api) {
+            warn_report("nested.api already set as %d, re-init to kvm-hv",
+                        spapr->nested.api);
+        }
         spapr->nested.api = NESTED_API_KVM_HV;
         spapr_unregister_nested_hv(); /* reset across reboots */
         spapr_register_nested_hv();
     }
 }
 
+static void cap_nested_papr_apply(SpaprMachineState *spapr,
+                                    uint8_t val, Error **errp)
+{
+    ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (tcg_enabled()) {
+        if (!(env->insns_flags2 & PPC2_ISA300)) {
+            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-papr=off\n");
+            return;
+        }
+    } else if (kvm_enabled()) {
+        /*
+         * this gets executed in L1 qemu when L2 is launched,
+         * needs kvm-hv support in L1 kernel.
+         */
+        if (!kvmppc_has_cap_nested_kvm_hv()) {
+            error_setg(errp,
+                       "KVM implementation does not support Nested-HV");
+        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
+            error_setg(errp, "Error enabling Nested-HV with KVM");
+        }
+    }
+    if (spapr->nested.api) {
+        warn_report("nested.api already set as %d, re-init to nested-papr",
+                    spapr->nested.api);
+    }
+    spapr->nested.api = NESTED_API_PAPR;
+    spapr->nested.capabilities_set = false;
+    spapr_unregister_nested_papr(); /* reset across reboots */
+    spapr_register_nested_papr();
+    spapr_nested_gsb_init();
+}
+
 static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
@@ -738,6 +784,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_NESTED_PAPR] = {
+        .name = "nested-papr",
+        .description = "Allow Nested HV (PAPR API)",
+        .index = SPAPR_CAP_NESTED_PAPR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_papr_apply,
+    },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
         .description = "Allow Large Decrementer",
@@ -922,6 +977,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index db1c59a8f5..6e6a90616e 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -13,8 +13,6 @@
 void spapr_nested_init(SpaprMachineState *spapr)
 {
     spapr->nested.api = 0;
-    spapr->nested.capabilities_set = false;
-    spapr_nested_gsb_init();
 }
 
 uint8_t spapr_nested_api(SpaprMachineState *spapr)
@@ -1821,6 +1819,18 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
 }
 
+void spapr_unregister_nested_papr(void)
+{
+    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_CREATE);
+    spapr_unregister_hypercall(H_GUEST_DELETE);
+    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
+    spapr_unregister_hypercall(H_GUEST_SET_STATE);
+    spapr_unregister_hypercall(H_GUEST_GET_STATE);
+    spapr_unregister_hypercall(H_GUEST_RUN_VCPU);
+}
+
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -1854,6 +1864,11 @@ void spapr_register_nested_papr(void)
     /* DO NOTHING */
 }
 
+void spapr_unregister_nested_papr(void)
+{
+    /* DO NOTHING */
+}
+
 void spapr_nested_gsb_init(void)
 {
     /* DO NOTHING */
-- 
2.39.3


