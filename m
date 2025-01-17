Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BBDC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 04:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYddt-0005v7-2u; Thu, 16 Jan 2025 23:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tYddk-0005qN-Hl; Thu, 16 Jan 2025 23:07:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tYddg-0006xB-O4; Thu, 16 Jan 2025 23:07:22 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H3rRXZ014897;
 Fri, 17 Jan 2025 04:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/Z11Gf
 Esv0xrcq2OHlJIu8GHxaJHxz9TqWOskA+NXNk=; b=cnu9lck5n0qibOBYpUpRjF
 Pa9THV5lWQy53slvsN4kjUx3V43T23wlEUIrsTCEzzMdiqqqOOTVeQcb0ZsUWwZz
 r911Yk2I+NEoK2J7Jxj8jCiwoRlttMvxBvDqlSDftlHy4iGavj3ShnK2PVQUJRly
 S1RYBuW704LZpZQ875xS0hedgtj0LVKjLyd/J1kaeP/A+5j25mFExighEB51zeFY
 +izH/ylLq+eMbaeGIHNTBxZBWihmY8Azln7+TEPcUOpvhQoepCgtt0LTkrCfPZO4
 /cuPyRXsyvH7KHz9iWLviQV/CsdrE5l1FR8I/v39gAqFqOLjU8yij9OIFJVL5IQw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpu81b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:06:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50H46wIm009059;
 Fri, 17 Jan 2025 04:06:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpu81b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:06:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50H149BW002700;
 Fri, 17 Jan 2025 04:06:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byh8tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 04:06:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50H46rq343385230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 04:06:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D7B12004B;
 Fri, 17 Jan 2025 04:06:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3789520049;
 Fri, 17 Jan 2025 04:06:52 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2025 04:06:52 +0000 (GMT)
Subject: [PATCH v9 1/2] ppc: Enable 2nd DAWR support on Power10 PowerNV machine
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: npiggin@gmail.com
Cc: danielhb413@gmail.com, harshpb@linux.ibm.com, pbonzini@redhat.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 sbhat@linux.ibm.com
Date: Fri, 17 Jan 2025 04:06:51 +0000
Message-ID: <173708680684.1678.13237334676438770057.stgit@linux.ibm.com>
In-Reply-To: <173708679976.1678.10844458987521427074.stgit@linux.ibm.com>
References: <173708679976.1678.10844458987521427074.stgit@linux.ibm.com>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OhoRwfU33Q7Jet_8TB2AnyxSNj24n4nX
X-Proofpoint-ORIG-GUID: EVkY9Rnu_vUV7WEpjF9zNs9p-HanRHsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=886
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170028
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Extend the existing watchpoint facility from TCG DAWR0 emulation
to DAWR1 on POWER10.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
---
 target/ppc/cpu.c         |   45 +++++++++++++++++++++++++----------
 target/ppc/cpu.h         |    6 +++--
 target/ppc/cpu_init.c    |   15 ++++++++++++
 target/ppc/excp_helper.c |   59 ++++++++++++++++++++++++----------------------
 target/ppc/helper.h      |    2 ++
 target/ppc/machine.c     |    3 ++
 target/ppc/misc_helper.c |   10 ++++++++
 target/ppc/spr_common.h  |    2 ++
 target/ppc/translate.c   |   12 +++++++++
 9 files changed, 110 insertions(+), 44 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index d148cd76b4..bfcc695de7 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -130,11 +130,13 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
     ppc_update_ciabr(env);
 }
 
-void ppc_update_daw0(CPUPPCState *env)
+void ppc_update_daw(CPUPPCState *env, int rid)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
-    uint32_t dawrx = env->spr[SPR_DAWRX0];
+    int spr_dawr = rid ? SPR_DAWR1 : SPR_DAWR0;
+    int spr_dawrx = rid ? SPR_DAWRX1 : SPR_DAWRX0;
+    target_ulong deaw = env->spr[spr_dawr] & PPC_BITMASK(0, 60);
+    uint32_t dawrx = env->spr[spr_dawrx];
     int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
     bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
     bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
@@ -144,9 +146,9 @@ void ppc_update_daw0(CPUPPCState *env)
     vaddr len;
     int flags;
 
-    if (env->dawr0_watchpoint) {
-        cpu_watchpoint_remove_by_ref(cs, env->dawr0_watchpoint);
-        env->dawr0_watchpoint = NULL;
+    if (env->dawr_watchpoint[rid]) {
+        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
+        env->dawr_watchpoint[rid] = NULL;
     }
 
     if (!dr && !dw) {
@@ -166,28 +168,45 @@ void ppc_update_daw0(CPUPPCState *env)
         flags |= BP_MEM_WRITE;
     }
 
-    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr0_watchpoint);
+    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
 }
 
 void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
 {
     env->spr[SPR_DAWR0] = val;
-    ppc_update_daw0(env);
+    ppc_update_daw(env, 0);
 }
 
-void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
+static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
 {
     int hrammc = extract32(val, PPC_BIT_NR(56), 1);
 
     if (hrammc) {
         /* This might be done with a second watchpoint at the xor of DEAW[0] */
-        qemu_log_mask(LOG_UNIMP, "%s: DAWRX0[HRAMMC] is unimplemented\n",
-                      __func__);
+        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n",
+                      __func__, rid);
     }
 
-    env->spr[SPR_DAWRX0] = val;
-    ppc_update_daw0(env);
+    env->spr[rid ? SPR_DAWRX1 : SPR_DAWRX0] = val;
+    ppc_update_daw(env, rid);
+}
+
+void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
+{
+    ppc_store_dawrx(env, val, 0);
+}
+
+void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_DAWR1] = val;
+    ppc_update_daw(env, 1);
+}
+
+void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
+{
+    ppc_store_dawrx(env, val, 1);
 }
+
 #endif
 #endif
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c0517..f6d4777e49 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1260,7 +1260,7 @@ struct CPUArchState {
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
-    struct CPUWatchpoint *dawr0_watchpoint;
+    struct CPUWatchpoint *dawr_watchpoint[2];
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1589,9 +1589,11 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_update_ciabr(CPUPPCState *env);
 void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
-void ppc_update_daw0(CPUPPCState *env);
+void ppc_update_daw(CPUPPCState *env, int rid);
 void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
 void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
+void ppc_store_dawr1(CPUPPCState *env, target_ulong value);
+void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c05c2dc42d..bc827c936a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5172,6 +5172,20 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
                         KVM_REG_PPC_CIABR, 0x00000000);
 }
 
+static void register_book3s_310_dbg_sprs(CPUPPCState *env)
+{
+    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawr1,
+                        KVM_REG_PPC_DAWR1, 0x00000000);
+    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawrx1,
+                        KVM_REG_PPC_DAWRX1, 0x00000000);
+}
+
 static void register_970_dbg_sprs(CPUPPCState *env)
 {
     /* Breakpoints */
@@ -6568,6 +6582,7 @@ static void init_proc_POWER10(CPUPPCState *env)
 {
     register_power9_common_sprs(env);
     register_HEIR64_spr(env);
+    register_book3s_310_dbg_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fde9912230..55b379d319 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3279,39 +3279,42 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
+    bool wt, wti, hv, sv, pr;
+    uint32_t dawrx;
+
+    if ((env->insns_flags2 & PPC2_ISA207S) &&
+        (wp == env->dawr_watchpoint[0])) {
+        dawrx = env->spr[SPR_DAWRX0];
+    } else if ((env->insns_flags2 & PPC2_ISA310) &&
+               (wp == env->dawr_watchpoint[1])) {
+        dawrx = env->spr[SPR_DAWRX1];
+    } else {
+        return false;
+    }
 
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        if (wp == env->dawr0_watchpoint) {
-            uint32_t dawrx = env->spr[SPR_DAWRX0];
-            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
-            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
-            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
-            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
-            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
-
-            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
-                return false;
-            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
-                return false;
-            } else if (!sv) {
-                return false;
-            }
+    wt = extract32(dawrx, PPC_BIT_NR(59), 1);
+    wti = extract32(dawrx, PPC_BIT_NR(60), 1);
+    hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    pr = extract32(dawrx, PPC_BIT_NR(62), 1);
 
-            if (!wti) {
-                if (env->msr & ((target_ulong)1 << MSR_DR)) {
-                    if (!wt) {
-                        return false;
-                    }
-                } else {
-                    if (wt) {
-                        return false;
-                    }
-                }
-            }
+    if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
+        return false;
+    } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
+        return false;
+    } else if (!sv) {
+        return false;
+    }
 
-            return true;
+    if (!wti) {
+        if (env->msr & ((target_ulong)1 << MSR_DR)) {
+            return wt;
+        } else {
+            return !wt;
         }
     }
+
+    return true;
 #endif
 
     return false;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a77e761bd..3353b7cb73 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -28,6 +28,8 @@ DEF_HELPER_2(store_pcr, void, env, tl)
 DEF_HELPER_2(store_ciabr, void, env, tl)
 DEF_HELPER_2(store_dawr0, void, env, tl)
 DEF_HELPER_2(store_dawrx0, void, env, tl)
+DEF_HELPER_2(store_dawr1, void, env, tl)
+DEF_HELPER_2(store_dawrx1, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
 DEF_HELPER_2(store_mmcrA, void, env, tl)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 0bd7ae6c0c..98df5b4a3a 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -264,7 +264,8 @@ static int cpu_post_load(void *opaque, int version_id)
         /* Re-set breaks based on regs */
 #if defined(TARGET_PPC64)
         ppc_update_ciabr(env);
-        ppc_update_daw0(env);
+        ppc_update_daw(env, 0);
+        ppc_update_daw(env, 1);
 #endif
         /*
          * TCG needs to re-start the decrementer timer and/or raise the
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b..60a6b751e0 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -233,6 +233,16 @@ void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
     ppc_store_dawrx0(env, value);
 }
 
+void helper_store_dawr1(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawr1(env, value);
+}
+
+void helper_store_dawrx1(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawrx1(env, value);
+}
+
 /*
  * DPDES register is shared. Each bit reflects the state of the
  * doorbell interrupt of a thread of the same core.
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 01aff449bc..5de5e8d35e 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -165,6 +165,8 @@ void spr_write_cfar(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80638ab535..20d4dad2cb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -637,6 +637,18 @@ void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn)
     translator_io_start(&ctx->base);
     gen_helper_store_dawrx0(tcg_env, cpu_gpr[gprn]);
 }
+
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawr1(tcg_env, cpu_gpr[gprn]);
+}
+
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawrx1(tcg_env, cpu_gpr[gprn]);
+}
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */



