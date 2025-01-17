Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2186C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 04:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYddZ-0005p3-Mu; Thu, 16 Jan 2025 23:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tYddY-0005oj-60; Thu, 16 Jan 2025 23:07:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tYddW-0006xr-33; Thu, 16 Jan 2025 23:07:11 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GNbZEh020917;
 Fri, 17 Jan 2025 04:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0pV93E
 ViWdDoNo5Cu5nA0H5+nZGYegvpL50nDRP8J2o=; b=XCZUCl1S8doFTZAAFpg4zG
 7KdhsVVXjagRj7eeeLoGKNG53LMbfjRul82TKDOh3hLXgBqWtBrXfh8rO0xdQ97q
 JL9gTAfj4XbHABetblex3YS/VSSMlxmS9I2msBv+cb9zY4o7IAswViAtUlOo6aVd
 Ni38bwulooxpJxSgTspgAB0Bpfk/+ES/KGwD41RJ20FQ89wRRHkPE/Pxd1XpNvzf
 VCKdfto+eWuSgRvhPv1G0j8NfdVYv7otA1eYgCQFod5/sJBfcDNH6eHlN45aJJtE
 hPhXAdoOyJ6UtKyLilmCZvWg1ga+9NmRsKEyjdFmCoUnY7FpNfdZZfDVwIScVM8g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447bxb0u35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:07:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50H478pe011959;
 Fri, 17 Jan 2025 04:07:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447bxb0u33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:07:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50H1vCTK007386;
 Fri, 17 Jan 2025 04:07:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynh503-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:07:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50H473wR50987468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 04:07:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C73112004D;
 Fri, 17 Jan 2025 04:07:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80F1B20043;
 Fri, 17 Jan 2025 04:07:02 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2025 04:07:02 +0000 (GMT)
Subject: [PATCH v9 2/2] ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: npiggin@gmail.com
Cc: danielhb413@gmail.com, harshpb@linux.ibm.com, pbonzini@redhat.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 sbhat@linux.ibm.com
Date: Fri, 17 Jan 2025 04:07:01 +0000
Message-ID: <173708681866.1678.11128625982438367069.stgit@linux.ibm.com>
In-Reply-To: <173708679976.1678.10844458987521427074.stgit@linux.ibm.com>
References: <173708679976.1678.10844458987521427074.stgit@linux.ibm.com>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tiJc9a20iWVCtA5JE4MFXSVuVGpHS_-f
X-Proofpoint-GUID: 5BSzzkHAEsmzpG2l6MwCdbVGV95XujVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=574
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

As per the PAPR, bit 0 of byte 64 in pa-features property
indicates availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
whether kvm supports 2nd DAWR or not. If it's supported, allow user to set
the pa-feature bit in guest DT using cap-dawr1 machine capability.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr.c         |    7 ++++++-
 hw/ppc/spapr_caps.c    |   43 +++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   |   27 ++++++++++++++++++---------
 include/hw/ppc/spapr.h |    6 +++++-
 target/ppc/kvm.c       |   12 ++++++++++++
 target/ppc/kvm_ppc.h   |   12 ++++++++++++
 6 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 623842f806..9518270e50 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -243,7 +243,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
         /* 54: DecFP, 56: DecI, 58: SHA */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
-        /* 60: NM atomic, 62: RNG */
+        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
         /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
         0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
@@ -292,6 +292,9 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
          * in pa-features. So hide it from them. */
         pa_features[40 + 2] &= ~0x80; /* Radix MMU */
     }
+    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
+        pa_features[66] |= 0x80;
+    }
 
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
 }
@@ -2138,6 +2141,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_rpt_invalidate,
         &vmstate_spapr_cap_ail_mode_3,
         &vmstate_spapr_cap_nested_papr,
+        &vmstate_spapr_cap_dawr1,
         NULL
     }
 };
@@ -4655,6 +4659,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_DAWR1] = SPAPR_CAP_ON;
 
     /*
      * This cap specifies whether the AIL 3 mode for
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7edd138360..ea87a4b100 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -696,6 +696,34 @@ static void cap_ail_mode_3_apply(SpaprMachineState *spapr,
     }
 }
 
+static void cap_dawr1_apply(SpaprMachineState *spapr, uint8_t val,
+                               Error **errp)
+{
+    ERRP_GUARD();
+
+    if (!val) {
+        return; /* Disable by default */
+    }
+
+    if (!ppc_type_check_compat(MACHINE(spapr)->cpu_type,
+                               CPU_POWERPC_LOGICAL_3_10, 0,
+                               spapr->max_compat_pvr)) {
+        error_setg(errp, "DAWR1 supported only on POWER10 and later CPUs");
+        error_append_hint(errp, "Try appending -machine cap-dawr1=off\n");
+        return;
+    }
+
+    if (kvm_enabled()) {
+        if (!kvmppc_has_cap_dawr1()) {
+            error_setg(errp, "DAWR1 not supported by KVM.");
+            error_append_hint(errp, "Try appending -machine cap-dawr1=off");
+        } else if (kvmppc_set_cap_dawr1(val) < 0) {
+            error_setg(errp, "Error enabling cap-dawr1 with KVM.");
+            error_append_hint(errp, "Try appending -machine cap-dawr1=off");
+        }
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -831,6 +859,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_ail_mode_3_apply,
     },
+    [SPAPR_CAP_DAWR1] = {
+        .name = "dawr1",
+        .description = "Allow 2nd Data Address Watchpoint Register (DAWR1)",
+        .index = SPAPR_CAP_DAWR1,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_dawr1_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -841,6 +878,11 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
 
     caps = smc->default_caps;
 
+    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_10,
+                               0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_DAWR1] = SPAPR_CAP_OFF;
+    }
+
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
@@ -975,6 +1017,7 @@ SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
 SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
 SPAPR_CAP_MIG_STATE(ail_mode_3, SPAPR_CAP_AIL_MODE_3);
+SPAPR_CAP_MIG_STATE(dawr1, SPAPR_CAP_DAWR1);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f8ab767063..d5a915fc3a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -818,11 +818,12 @@ static target_ulong h_set_mode_resource_set_ciabr(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong mflags,
-                                                  target_ulong value1,
-                                                  target_ulong value2)
+static target_ulong h_set_mode_resource_set_dawr(PowerPCCPU *cpu,
+                                                 SpaprMachineState *spapr,
+                                                 target_ulong mflags,
+                                                 target_ulong resource,
+                                                 target_ulong value1,
+                                                 target_ulong value2)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -835,8 +836,15 @@ static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
         return H_P4;
     }
 
-    ppc_store_dawr0(env, value1);
-    ppc_store_dawrx0(env, value2);
+    if (resource == H_SET_MODE_RESOURCE_SET_DAWR0) {
+        ppc_store_dawr0(env, value1);
+        ppc_store_dawrx0(env, value2);
+    } else if (resource == H_SET_MODE_RESOURCE_SET_DAWR1) {
+        ppc_store_dawr1(env, value1);
+        ppc_store_dawrx1(env, value2);
+    } else {
+        g_assert_not_reached();
+    }
 
     return H_SUCCESS;
 }
@@ -915,8 +923,9 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                             args[3]);
         break;
     case H_SET_MODE_RESOURCE_SET_DAWR0:
-        ret = h_set_mode_resource_set_dawr0(cpu, spapr, args[0], args[2],
-                                            args[3]);
+    case H_SET_MODE_RESOURCE_SET_DAWR1:
+        ret = h_set_mode_resource_set_dawr(cpu, spapr, args[0], args[1],
+                                           args[2], args[3]);
         break;
     case H_SET_MODE_RESOURCE_LE:
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a6c0547e31..d227f0b94b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -83,8 +83,10 @@ typedef enum {
 #define SPAPR_CAP_AIL_MODE_3            0x0C
 /* Nested PAPR */
 #define SPAPR_CAP_NESTED_PAPR           0x0D
+/* DAWR1 */
+#define SPAPR_CAP_DAWR1                 0x0E
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_DAWR1 + 1)
 
 /*
  * Capability Values
@@ -406,6 +408,7 @@ struct SpaprMachineState {
 #define H_SET_MODE_RESOURCE_SET_DAWR0           2
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE     3
 #define H_SET_MODE_RESOURCE_LE                  4
+#define H_SET_MODE_RESOURCE_SET_DAWR1           5
 
 /* Flags for H_SET_MODE_RESOURCE_LE */
 #define H_SET_MODE_ENDIAN_BIG    0
@@ -1003,6 +1006,7 @@ extern const VMStateDescription vmstate_spapr_cap_fwnmi;
 extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
 extern const VMStateDescription vmstate_spapr_cap_ail_mode_3;
 extern const VMStateDescription vmstate_spapr_wdt;
+extern const VMStateDescription vmstate_spapr_cap_dawr1;
 
 static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 966c2c6572..67287ed14e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -92,6 +92,7 @@ static int cap_large_decr;
 static int cap_fwnmi;
 static int cap_rpt_invalidate;
 static int cap_ail_mode_3;
+static int cap_dawr1;
 
 #ifdef CONFIG_PSERIES
 static int cap_papr;
@@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
     cap_fwnmi = kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
+    cap_dawr1 = kvm_vm_check_extension(s, KVM_CAP_PPC_DAWR1);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2114,6 +2116,16 @@ int kvmppc_set_fwnmi(PowerPCCPU *cpu)
     return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
 }
 
+bool kvmppc_has_cap_dawr1(void)
+{
+    return !!cap_dawr1;
+}
+
+int kvmppc_set_cap_dawr1(int enable)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_DAWR1, 0, enable);
+}
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 1d8cb76a6b..a8768c1dfd 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -68,6 +68,8 @@ bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
 bool kvmppc_has_cap_xive(void);
+bool kvmppc_has_cap_dawr1(void);
+int kvmppc_set_cap_dawr1(int enable);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
@@ -377,6 +379,16 @@ static inline bool kvmppc_has_cap_xive(void)
     return false;
 }
 
+static inline bool kvmppc_has_cap_dawr1(void)
+{
+    return false;
+}
+
+static inline int kvmppc_set_cap_dawr1(int enable)
+{
+    abort();
+}
+
 static inline int kvmppc_get_cap_safe_cache(void)
 {
     return 0;



