Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C9D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kQZ-0000Ua-HL; Sat, 09 Nov 2024 07:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kPO-0006P1-6O; Sat, 09 Nov 2024 07:17:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kPM-0005Fs-9y; Sat, 09 Nov 2024 07:17:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6346FA1645;
 Sat,  9 Nov 2024 15:08:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 29E0C167FCB;
 Sat,  9 Nov 2024 15:09:03 +0300 (MSK)
Received: (nullmailer pid 3296210 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 27/58] target/arm: Store FPSR cumulative exception bits
 in env->vfp.fpsr
Date: Sat,  9 Nov 2024 15:08:28 +0300
Message-Id: <20241109120901.3295995-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently we store the FPSR cumulative exception bits in the
float_status fields, and use env->vfp.fpsr only for the NZCV bits.
(The QC bit is stored in env->vfp.qc[].)

This works for TCG, but if QEMU was built without CONFIG_TCG (i.e.
with KVM support only) then we use the stub versions of
vfp_get_fpsr_from_host() and vfp_set_fpsr_to_host() which do nothing,
throwing away the cumulative exception bit state.  The effect is that
if the FPSR state is round-tripped from KVM to QEMU then we lose the
cumulative exception bits.  In particular, this will happen if the VM
is migrated.  There is no user-visible bug when using KVM with a QEMU
binary that was built with CONFIG_TCG.

Fix this by always storing the cumulative exception bits in
env->vfp.fpsr.  If we are using TCG then we may also keep pending
cumulative exception information in the float_status fields, so we
continue to fold that in on reads.

This change will also be helpful for implementing FEAT_AFP later,
because that includes a feature where in some situations we want to
cause input denormals to be flushed to zero without affecting the
existing state of the FPSR.IDC bit, so we need a place to store IDC
which is distinct from the various float_status fields.

(Note for stable backports: the bug goes back to 4a15527c9fee but
this code was refactored in commits ea8618382aba..a8ab8706d4cc461, so
fixing it in branches without those refactorings will mean either
backporting the refactor or else implementing a conceptually similar
fix for the old code.)

Cc: qemu-stable@nongnu.org
Fixes: 4a15527c9fee ("target/arm/vfp_helper: Restrict the SoftFloat use to TCG")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241011162401.3672735-1-peter.maydell@linaro.org
(cherry picked from commit d9c7adb6019f2ac3d6a5a36c4121341f4b6424af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index b3698da8ca..45ec71a8ad 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -59,32 +59,6 @@ static inline int vfp_exceptbits_from_host(int host_bits)
     return target_bits;
 }
 
-/* Convert vfp exception flags to target form.  */
-static inline int vfp_exceptbits_to_host(int target_bits)
-{
-    int host_bits = 0;
-
-    if (target_bits & 1) {
-        host_bits |= float_flag_invalid;
-    }
-    if (target_bits & 2) {
-        host_bits |= float_flag_divbyzero;
-    }
-    if (target_bits & 4) {
-        host_bits |= float_flag_overflow;
-    }
-    if (target_bits & 8) {
-        host_bits |= float_flag_underflow;
-    }
-    if (target_bits & 0x10) {
-        host_bits |= float_flag_inexact;
-    }
-    if (target_bits & 0x80) {
-        host_bits |= float_flag_input_denormal;
-    }
-    return host_bits;
-}
-
 static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t i;
@@ -99,15 +73,14 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     return vfp_exceptbits_from_host(i);
 }
 
-static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_clear_float_status_exc_flags(CPUARMState *env)
 {
     /*
-     * The exception flags are ORed together when we read fpscr so we
-     * only need to preserve the current state in one of our
-     * float_status values.
+     * Clear out all the exception-flag information in the float_status
+     * values. The caller should have arranged for env->vfp.fpsr to
+     * be the architecturally up-to-date exception flag information first.
      */
-    int i = vfp_exceptbits_to_host(val);
-    set_float_exception_flags(i, &env->vfp.fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
@@ -164,7 +137,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     return 0;
 }
 
-static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_clear_float_status_exc_flags(CPUARMState *env)
 {
 }
 
@@ -216,8 +189,6 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
 {
     ARMCPU *cpu = env_archcpu(env);
 
-    vfp_set_fpsr_to_host(env, val);
-
     if (arm_feature(env, ARM_FEATURE_NEON) ||
         cpu_isar_feature(aa32_mve, cpu)) {
         /*
@@ -231,13 +202,18 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     }
 
     /*
-     * The only FPSR bits we keep in vfp.fpsr are NZCV:
-     * the exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
-     * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
-     * and zero any of the other FPSR bits.
+     * NZCV lives only in env->vfp.fpsr. The cumulative exception flags
+     * IOC|DZC|OFC|UFC|IXC|IDC also live in env->vfp.fpsr, with possible
+     * extra pending exception information that hasn't yet been folded in
+     * living in the float_status values (for TCG).
+     * Since this FPSR write gives us the up to date values of the exception
+     * flags, we want to store into vfp.fpsr the NZCV and CEXC bits, zeroing
+     * anything else. We also need to clear out the float_status exception
+     * information so that the next vfp_get_fpsr does not fold in stale data.
      */
-    val &= FPSR_NZCV_MASK;
+    val &= FPSR_NZCV_MASK | FPSR_CEXC_MASK;
     env->vfp.fpsr = val;
+    vfp_clear_float_status_exc_flags(env);
 }
 
 static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
-- 
2.39.5


