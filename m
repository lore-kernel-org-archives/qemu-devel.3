Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350CCCCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFy3s-0000Wq-Gu; Mon, 03 Nov 2025 12:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3r-0000WA-5k
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:43 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3i-0000si-Jo
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Ty7V6mUm7E7xW82v49FaJ5HOHnoOvuLwGtXFsf+RLyA=; b=gyn0j9JPXyqaomj
 DnUcufYH21DTx5F14tF3Jjw5RT5X7oEUXpEf+P+rfatbg6UlEuG6dlqBYOV5AI5ONMMT5ESaDpa8z
 VWxBFUsVHPAaDu8yMmBjstK+LW+m/3254rbNc4E+bDtLBRBhFThN00RIaJRcvl/JjJ4rdG5YwYU0j
 Ns=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 14/25] target/riscv: Fix size of [m|s|vs]iselect fields
Date: Mon,  3 Nov 2025 18:11:57 +0100
Message-ID: <20251103171208.24355-15-anjo@rev.ng>
In-Reply-To: <20251103171208.24355-1-anjo@rev.ng>
References: <20251103171208.24355-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

[m|s|vs]iselect are defined in version 20250508 of the privileged
specification to be XLEN in size, however QEMU only ever uses at most
16 bits of these fields, so fix them to 16.  Update relevant function
arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  6 +++---
 target/riscv/csr.c     | 32 ++++++++++++++++----------------
 target/riscv/machine.c |  6 +++---
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5f051796f4..b35851cf4f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -343,8 +343,8 @@ struct CPUArchState {
     uint8_t siprio[64];
 
     /* AIA CSRs */
-    target_ulong miselect;
-    target_ulong siselect;
+    uint16_t miselect;
+    uint16_t siselect;
     uint64_t mvien;
     uint64_t mvip;
 
@@ -390,7 +390,7 @@ struct CPUArchState {
     uint64_t vsatp;
 
     /* AIA VS-mode CSRs */
-    target_ulong vsiselect;
+    uint16_t vsiselect;
 
     uint64_t mtval2;
     uint64_t mtinst;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1c6797ca8d..a29edbb369 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2398,7 +2398,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong *val, target_ulong new_val,
                                    target_ulong wr_mask)
 {
-    target_ulong *iselect;
+    uint16_t *iselect;
     int ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
@@ -2441,18 +2441,18 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static bool xiselect_aia_range(target_ulong isel)
+static bool xiselect_aia_range(uint16_t isel)
 {
     return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
-static bool xiselect_cd_range(target_ulong isel)
+static bool xiselect_cd_range(uint16_t isel)
 {
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
-static bool xiselect_ctr_range(int csrno, target_ulong isel)
+static bool xiselect_ctr_range(int csrno, uint16_t isel)
 {
     /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
     return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
@@ -2460,7 +2460,7 @@ static bool xiselect_ctr_range(int csrno, target_ulong isel)
 }
 
 static int rmw_iprio(target_ulong xlen,
-                     target_ulong iselect, uint8_t *iprio,
+                     uint16_t iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
                      target_ulong wr_mask, int ext_irq_no)
 {
@@ -2504,7 +2504,7 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2543,7 +2543,7 @@ static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2582,7 +2582,7 @@ static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2623,7 +2623,7 @@ static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
 }
 
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
-                         target_ulong isel, target_ulong *val,
+                         uint16_t isel, target_ulong *val,
                          target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = false, isel_reserved = false;
@@ -2703,12 +2703,12 @@ done:
 }
 
 static int rmw_xireg_cd(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    int ctr_index = isel - ISELECT_CD_FIRST;
-    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+    uint16_t ctr_index = isel - ISELECT_CD_FIRST;
+    uint16_t isel_hpm_start = ISELECT_CD_FIRST + 3;
 
     if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
         ret = RISCV_EXCP_ILLEGAL_INST;
@@ -2775,7 +2775,7 @@ done:
 }
 
 static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
@@ -2803,7 +2803,7 @@ static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
  * extension using csrind should be implemented here.
  */
 static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
-                              target_ulong isel, target_ulong *val,
+                              uint16_t isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = csrno == CSR_VSIREG ? true : false;
@@ -2833,7 +2833,7 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
                       target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
@@ -2864,7 +2864,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 8a8f5be8d6..376075b2bd 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -108,7 +108,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.vscause, RISCVCPU),
         VMSTATE_UINT64(env.vstval, RISCVCPU),
         VMSTATE_UINT64(env.vsatp, RISCVCPU),
-        VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
+        VMSTATE_UINT16(env.vsiselect, RISCVCPU),
         VMSTATE_UINT64(env.vsie, RISCVCPU),
 
         VMSTATE_UINT64(env.mtval2, RISCVCPU),
@@ -467,8 +467,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.mepc, RISCVCPU),
         VMSTATE_UINT64(env.mcause, RISCVCPU),
         VMSTATE_UINT64(env.mtval, RISCVCPU),
-        VMSTATE_UINTTL(env.miselect, RISCVCPU),
-        VMSTATE_UINTTL(env.siselect, RISCVCPU),
+        VMSTATE_UINT16(env.miselect, RISCVCPU),
+        VMSTATE_UINT16(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
-- 
2.51.0


