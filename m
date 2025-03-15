Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D32FC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKs0-0003oE-9F; Sat, 15 Mar 2025 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrF-00039q-3m; Sat, 15 Mar 2025 02:18:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrC-0003FG-QE; Sat, 15 Mar 2025 02:18:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80712FF9D3;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57DFB1CAC3C;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3BBE4558BD; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 07/51] target/arm: Honour SDCR.TDCC and SCR.TERR in
 AArch32 EL3 non-Monitor modes
Date: Sat, 15 Mar 2025 09:17:13 +0300
Message-Id: <20250315061801.622606-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There are not many traps in AArch32 which should trap to Monitor
mode, but these trap bits should trap not just lower ELs to Monitor
mode but also the non-Monitor modes running at EL3 (i.e.  Secure
System, Secure Undef, etc).

We get this wrong because the relevant access functions implement the
AArch64-style logic of
   if (el < 3 && trap_bit_set) {
       return CP_ACCESS_TRAP_EL3;
   }
which won't trap the non-Monitor modes at EL3.

Correct this error by using arm_is_el3_or_mon() instead, which
returns true when the CPU is at AArch64 EL3 or AArch32 Monitor mode.
(Since the new callsites are compiled also for the linux-user mode,
we need to provide a dummy implementation for CONFIG_USER_ONLY.)

This affects only:
 * trapping of ERRIDR via SCR.TERR
 * trapping of the debug channel registers via SDCR.TDCC
 * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
   (which we already used arm_is_el3_or_mon() for)

This patch changes the handling of SCR.TERR and SDCR.TDCC. This
patch only changes guest-visible behaviour for "-cpu max" on
the qemu-system-arm binary, because SCR.TERR
and SDCR.TDCC (and indeed the entire SDCR register) only arrived
in Armv8, and the only guest CPU we support which has any v8
features and also starts in AArch32 EL3 is the 32-bit 'max'.

Other uses of CP_ACCESS_TRAP_EL3 don't need changing:

 * uses in code paths that can't happen when EL3 is AArch32:
   access_trap_aa32s_el1, cpacr_access, cptr_access, nsacr_access
 * uses which are in accessfns for AArch64-only registers:
   gt_stimer_access, gt_cntpoff_access, access_hxen, access_tpidr2,
   access_smpri, access_smprimap, access_lor_ns, access_pauth,
   access_mte, access_tfsr_el2, access_scxtnum, access_fgt
 * trap bits which exist only in the AArch64 version of the
   trap register, not the AArch32 one:
   access_tpm, pmreg_access, access_dbgvcr32, access_tdra,
   access_tda, access_tdosa (TPM, TDA and TDOSA exist only in
   MDCR_EL3, not in SDCR, and we enforce this in sdcr_write())

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-8-peter.maydell@linaro.org
(cherry picked from commit 4d436fb05c2a1fff7befc815ebcbb04a14977448)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3416cd435..b005f93735 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2562,6 +2562,11 @@ static inline bool arm_is_secure_below_el3(CPUARMState *env)
     return false;
 }
 
+static inline bool arm_is_el3_or_mon(CPUARMState *env)
+{
+    return false;
+}
+
 static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
 {
     return ARMSS_NonSecure;
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 7d856acddf..019b2b6f97 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -880,7 +880,8 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
+    if (!arm_is_el3_or_mon(env) &&
+        ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe255ccb43..8df38a30a1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7052,7 +7052,7 @@ static CPAccessResult access_terr(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (arm_hcr_el2_eff(env) & HCR_TERR)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && (env->cp15.scr_el3 & SCR_TERR)) {
+    if (!arm_is_el3_or_mon(env) && (env->cp15.scr_el3 & SCR_TERR)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
-- 
2.39.5


