Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD26D64061
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenJ-0001Is-VZ; Tue, 16 Dec 2025 18:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen2-0001BS-32
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:14 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemz-0006lu-PV
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OnTlwtr2WErgQ6f6Hrd7x4go/fqxZMxAQBasqqI88jM=; b=OQzs5zF3ZLaI+i5
 guotCSUEL8OdZANKZmJ0Xdviff2kluCbnzks0PkBCCw3u0cRgxmSJu5RazCVhZbdWKF6VRRmW+iwc
 7N2KCIfYRnvlU8EEFTA2l978C8thhJcOM+VMlFsmodp4pKCJpLLg8vRFBP+BWvdz0YgY9IKvOV9St
 0s=;
Date: Wed, 17 Dec 2025 00:51:13 +0100
Subject: [PATCH 08/14] target/riscv: Remove ifdefs in cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-8-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KVM fields of CPURISCVState are now always exposed as CONFIG_KVM cannot
be used in common code.

riscv_cpu_mxl() is changed to return CPURISCVState::misa_mxl
unconditionally, as use of target_riscv64() would result in an extra
load and compare with TargetInfo::target_arch.  We might as well just
perform a single load.  Likewise, for cpu_recompute_xl(),
cpu_address_xl(), and riscv_cpu_sxl(), we opt for returning the
corresponding CPURISCVState field with ifdefs for system mode adding
extra conditions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index da2bc554d3..946665d9ed 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -497,14 +497,12 @@ struct CPUArchState {
     hwaddr kernel_addr;
     hwaddr fdt_addr;
 
-#ifdef CONFIG_KVM
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
-#endif /* CONFIG_KVM */
 
     /* RNMI */
     uint64_t mnscratch;
@@ -703,14 +701,10 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
-#ifdef TARGET_RISCV32
-#define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
 {
     return env->misa_mxl;
 }
-#endif
 #define riscv_cpu_mxl_bits(env) (1UL << (4 + riscv_cpu_mxl(env)))
 
 static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
@@ -754,9 +748,6 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 }
 #endif
 
-#if defined(TARGET_RISCV32)
-#define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -765,43 +756,32 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
     return env->misa_mxl;
 #endif
 }
-#endif
 
-#if defined(TARGET_RISCV32)
-#define cpu_address_xl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 {
-#ifdef CONFIG_USER_ONLY
-    return env->xl;
-#else
-    int mode = cpu_address_mode(env);
-
-    return cpu_get_xl(env, mode);
+#ifndef CONFIG_USER_ONLY
+    if (target_riscv64()) {
+        int mode = cpu_address_mode(env);
+        return cpu_get_xl(env, mode);
+    }
 #endif
+    return env->xl;
 }
-#endif
 
 static inline int riscv_cpu_xlen(CPURISCVState *env)
 {
     return 16 << env->xl;
 }
 
-#ifdef TARGET_RISCV32
-#define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 {
-#ifdef CONFIG_USER_ONLY
-    return env->misa_mxl;
-#else
+#ifndef CONFIG_USER_ONLY
     if (env->misa_mxl != MXL_RV32) {
         return get_field(env->mstatus, MSTATUS64_SXL);
     }
 #endif
-    return MXL_RV32;
+    return env->misa_mxl;
 }
-#endif
 
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
                                               uint32_t priv_ver,

-- 
2.51.0


