Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42602C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIz-0003QF-Ep; Tue, 11 Mar 2025 09:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEn-0005c4-1n; Tue, 11 Mar 2025 09:01:37 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEk-0000If-81; Tue, 11 Mar 2025 09:01:36 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso2351212a91.3; 
 Tue, 11 Mar 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698092; x=1742302892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JRInH28kT8NQFjaUfcoifBn4ExD1TRUGhB92fe2nGc=;
 b=HpAb6kZQCNJzCN4jJ/rcAIs3rZlOR2qm3G0RUvOcA3xrqhcV4ufKKBpdulqbV0jtYN
 YTd76e2k3rK2Qbpjr5ttwzG8CJhZlZQi86uHSfYZmn1RF1m58+N3rZ2QzSa4lgpBfZhK
 vFayUvM/ZogNQsl1Ku1u5TzbjtWJWhcoVvYoI2YOs7w0OYx63LXNBk6AKMjteC1tbUWV
 yDqN4g9cQdvIDspBTbMSzIo41pYYujxagUkzbegYnCZVDoLdzw1dWHtjV/o++tzO559F
 F6khPgQ3GoOIge3tALkCrH2I1qp6inWoI93TrzXPH/wm49Fd5Wwz/K+GgAUhBahhOBLr
 S6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698092; x=1742302892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JRInH28kT8NQFjaUfcoifBn4ExD1TRUGhB92fe2nGc=;
 b=dNfGiuTuXnod5aqzNmjC+JG8cQqjDbniCOWnFraQg3XLYlJuWRiI0PHzlS37Wp+38p
 4ZfBUEd208YSJE3EeU/9u3OQqL/HbvgBJr0HhfTt3qrngtild5awj8EyOYSkncNawLy+
 OehxG/OTOH9AFYXtpMK48hLzkSo0zi56GvDq0Tu9iTyIlTRUgSKO5Oipyptt0s8jv/ZJ
 vtdw3ivgbNB6B8koEUAe4c5w3CXUbltVroA4ROa4Xg0A3iIF2T9TC9uRQhQBHA0r/l4B
 8qmGHG0mY/elNEnuHd6YWHl7vDaATA+TvKSvBmlAMYMQn9hJyuRpegdUVfg7kVeynQVv
 fHHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxK3WuK8C58ZAtrKnghWohlf/Z8GqYBvLT6QV4VcdJDo/kDLM7yZYbCB88FuenRoIiCvngTHiLCg==@nongnu.org
X-Gm-Message-State: AOJu0YyHrsVj2/gY7qD/Z31Ck6JdgDrZRxmfRa3yBgDZZl6eHQWsBrTn
 nXpHyuXx2TaqoBqyetNOzuzscrg9NxOlGsDf3e3GVbolB7ZxuxBOTDWgdw==
X-Gm-Gg: ASbGncvdZ4P+wMAqb0UWnjbl87ZajBZWu01MEbg0qRZ+c1CV6qmcJvRbk4rRTrSvPcJ
 OBoIywQlqODOA2BExIgaluPZHGp3urK1S0zjQ9FOZcO5XoaEj4Vxz5aDosgtakE2prgXzxFgibs
 vWM7mb2FFhTqT70FjR9k70qf3OQr1mui9cl99XlXk2CSajuhzTGxcvr2CkmMJ1xyGrW2j4Ag5A7
 uXW05BzuOlKTZlb0aFbYkxmY4Q/CMiX0R00NnuqDCcrOEGyJLqrCGBzl+VGsoXjqCk1u+dWKTWh
 OPRFzHOtGDQZKDZS1yyM0KZuCXXsouPspjQQ68pf72SU0y6lqNQ=
X-Google-Smtp-Source: AGHT+IF6rtusrJ9DZlMX+zGfMn0HFO0XtTsFU4OPR/740n799Hj9OtxiKDjfWWfmOec/CCvtKM8BCA==
X-Received: by 2002:a17:90b:3e4f:b0:2ff:7b15:813b with SMTP id
 98e67ed59e1d1-2ff7ce93a00mr30063132a91.17.1741698090463; 
 Tue, 11 Mar 2025 06:01:30 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 60/72] ppc: Enable 2nd DAWR support on Power10 PowerNV machine
Date: Tue, 11 Mar 2025 22:57:54 +1000
Message-ID: <20250311125815.903177-61-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Extend the existing watchpoint facility from TCG DAWR0 emulation
to DAWR1 on POWER10.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <173708680684.1678.13237334676438770057.stgit@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.c             | 45 +++++++++++++++++++--------
 target/ppc/cpu.h             |  6 ++--
 target/ppc/cpu_init.c        | 15 +++++++++
 target/ppc/helper.h          |  2 ++
 target/ppc/machine.c         |  3 +-
 target/ppc/misc_helper.c     | 10 ++++++
 target/ppc/spr_common.h      |  2 ++
 target/ppc/tcg-excp_helper.c | 59 +++++++++++++++++++-----------------
 target/ppc/translate.c       | 12 ++++++++
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
index 8d43983fe1..efab54a068 100644
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
index 8d73e11540..9dc5ace828 100644
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
@@ -6584,6 +6598,7 @@ static void init_proc_POWER10(CPUPPCState *env)
 {
     register_power9_common_sprs(env);
     register_HEIR64_spr(env);
+    register_book3s_310_dbg_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 11b914e640..ca414f2f43 100644
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
index 190e9091fc..2d9512c116 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -234,6 +234,16 @@ void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
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
index 8e3117b463..84c910c440 100644
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
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 4b859a8ffa..5a189dc3d7 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -345,39 +345,42 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b0cc8bf283..a52cbc869a 100644
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
-- 
2.47.1


