Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9485CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jn2-0005RU-QW; Wed, 24 Sep 2025 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jn1-0005PS-6X
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmq-0003Nw-Lt
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hvwxp5Gp5ncdRD3D2T1SDCR8Zg+RxKaqreS/I19bOrI=; b=GmF7eTRoCSfr+MV
 NHlQhxNJ40M3U5R+WnpmoyQ+jABMJTdAXnOjtewqgv0t2ETdmmMwEUfqIsJDlltaa21fjJx8L7zNF
 Qks66j3Yy3zzP8pkNvxKzZ98JiguaJfdUOK+XdhzWaq71SRnI0UHCv15/ranlFwbp5qNako2d8Y+L
 QY=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 02/34] target/riscv: Fix size of trivial CPUArchState
 fields
Date: Wed, 24 Sep 2025 09:20:52 +0200
Message-ID: <20250924072124.6493-3-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This commits groups together all CPUArchState fields whose behaviour can
be retained by simply changing the size of the field.

Note, senvcfg is defined to be SXLEN bits wide, but is widened to 64
bits to match henvcfg and menvcfg.  Next, [m|h]edeleg are changed to
64 bits as defined privileged specification, and hvictl is fixed to 32
bits which holds all relevant values, see HVICTL_VALID_MASK.  The
remaining fields touched in the commit are widened from [H|S|M]XLEN
to 64-bit.

References to the privileged/unprivileged RISCV specification refer to
version 20250508.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h     | 76 +++++++++++++++++++++---------------------
 target/riscv/machine.c | 66 ++++++++++++++++++------------------
 2 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a0b2ef1cc1..8c8d34f3ac 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -254,7 +254,7 @@ struct CPUArchState {
     /* 128-bit helpers upper part return value */
     target_ulong retxh;
 
-    target_ulong jvt;
+    uint64_t jvt;
 
     /* elp state for zicfilp extension */
     bool      elp;
@@ -271,7 +271,7 @@ struct CPUArchState {
     target_ulong priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
-    target_ulong senvcfg;
+    uint64_t senvcfg;
 
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
@@ -313,18 +313,18 @@ struct CPUArchState {
      */
     uint64_t vsie;
 
-    target_ulong satp;   /* since: priv-1.10.0 */
-    target_ulong stval;
-    target_ulong medeleg;
+    uint64_t satp;   /* since: priv-1.10.0 */
+    uint64_t stval;
+    uint64_t medeleg;
 
-    target_ulong stvec;
-    target_ulong sepc;
-    target_ulong scause;
+    uint64_t stvec;
+    uint64_t sepc;
+    uint64_t scause;
 
-    target_ulong mtvec;
-    target_ulong mepc;
+    uint64_t mtvec;
+    uint64_t mepc;
     target_ulong mcause;
-    target_ulong mtval;  /* since: priv-1.10.0 */
+    uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
     uint32_t sctrdepth;
@@ -346,13 +346,13 @@ struct CPUArchState {
     uint64_t mvip;
 
     /* Hypervisor CSRs */
-    target_ulong hstatus;
-    target_ulong hedeleg;
+    uint64_t hstatus;
+    uint64_t hedeleg;
     uint64_t hideleg;
     uint32_t hcounteren;
-    target_ulong htval;
-    target_ulong htinst;
-    target_ulong hgatp;
+    uint64_t htval;
+    uint64_t htinst;
+    uint64_t hgatp;
     target_ulong hgeie;
     target_ulong hgeip;
     uint64_t htimedelta;
@@ -366,7 +366,7 @@ struct CPUArchState {
     uint64_t hvip;
 
     /* Hypervisor controlled virtual interrupt priorities */
-    target_ulong hvictl;
+    uint32_t hvictl;
     uint8_t hviprio[64];
 
     /* Upper 64-bits of 128-bit CSRs */
@@ -379,26 +379,26 @@ struct CPUArchState {
      * For RV64 this is a 64-bit vsstatus.
      */
     uint64_t vsstatus;
-    target_ulong vstvec;
-    target_ulong vsscratch;
-    target_ulong vsepc;
-    target_ulong vscause;
-    target_ulong vstval;
-    target_ulong vsatp;
+    uint64_t vstvec;
+    uint64_t vsscratch;
+    uint64_t vsepc;
+    uint64_t vscause;
+    uint64_t vstval;
+    uint64_t vsatp;
 
     /* AIA VS-mode CSRs */
     target_ulong vsiselect;
 
-    target_ulong mtval2;
-    target_ulong mtinst;
+    uint64_t mtval2;
+    uint64_t mtinst;
 
     /* HS Backup CSRs */
-    target_ulong stvec_hs;
-    target_ulong sscratch_hs;
-    target_ulong sepc_hs;
-    target_ulong scause_hs;
-    target_ulong stval_hs;
-    target_ulong satp_hs;
+    uint64_t stvec_hs;
+    uint64_t sscratch_hs;
+    uint64_t sepc_hs;
+    uint64_t scause_hs;
+    uint64_t stval_hs;
+    uint64_t satp_hs;
     uint64_t mstatus_hs;
 
     /*
@@ -435,8 +435,8 @@ struct CPUArchState {
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
 
-    target_ulong sscratch;
-    target_ulong mscratch;
+    uint64_t sscratch;
+    uint64_t mscratch;
 
     /* Sstc CSRs */
     uint64_t stimecmp;
@@ -506,11 +506,11 @@ struct CPUArchState {
 #endif /* CONFIG_KVM */
 
     /* RNMI */
-    target_ulong mnscratch;
-    target_ulong mnepc;
-    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
-    target_ulong mnstatus;
-    target_ulong rnmip;
+    uint64_t mnscratch;
+    uint64_t mnepc;
+    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
+    uint64_t mnstatus;
+    uint64_t rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
 };
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1600ec44f0..f42be027e3 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -84,13 +84,13 @@ static const VMStateDescription vmstate_hyper = {
     .minimum_version_id = 4,
     .needed = hyper_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
-        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
+        VMSTATE_UINT64(env.hstatus, RISCVCPU),
+        VMSTATE_UINT64(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
         VMSTATE_UINT32(env.hcounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.htval, RISCVCPU),
-        VMSTATE_UINTTL(env.htinst, RISCVCPU),
-        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
+        VMSTATE_UINT64(env.htval, RISCVCPU),
+        VMSTATE_UINT64(env.htinst, RISCVCPU),
+        VMSTATE_UINT64(env.hgatp, RISCVCPU),
         VMSTATE_UINTTL(env.hgeie, RISCVCPU),
         VMSTATE_UINTTL(env.hgeip, RISCVCPU),
         VMSTATE_UINT64(env.hvien, RISCVCPU),
@@ -98,28 +98,28 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
         VMSTATE_UINT64(env.vstimecmp, RISCVCPU),
 
-        VMSTATE_UINTTL(env.hvictl, RISCVCPU),
+        VMSTATE_UINT32(env.hvictl, RISCVCPU),
         VMSTATE_UINT8_ARRAY(env.hviprio, RISCVCPU, 64),
 
         VMSTATE_UINT64(env.vsstatus, RISCVCPU),
-        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
-        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
-        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
-        VMSTATE_UINTTL(env.vscause, RISCVCPU),
-        VMSTATE_UINTTL(env.vstval, RISCVCPU),
-        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
+        VMSTATE_UINT64(env.vstvec, RISCVCPU),
+        VMSTATE_UINT64(env.vsscratch, RISCVCPU),
+        VMSTATE_UINT64(env.vsepc, RISCVCPU),
+        VMSTATE_UINT64(env.vscause, RISCVCPU),
+        VMSTATE_UINT64(env.vstval, RISCVCPU),
+        VMSTATE_UINT64(env.vsatp, RISCVCPU),
         VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
         VMSTATE_UINT64(env.vsie, RISCVCPU),
 
-        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
-        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
+        VMSTATE_UINT64(env.mtval2, RISCVCPU),
+        VMSTATE_UINT64(env.mtinst, RISCVCPU),
 
-        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
+        VMSTATE_UINT64(env.stvec_hs, RISCVCPU),
+        VMSTATE_UINT64(env.sscratch_hs, RISCVCPU),
+        VMSTATE_UINT64(env.sepc_hs, RISCVCPU),
+        VMSTATE_UINT64(env.scause_hs, RISCVCPU),
+        VMSTATE_UINT64(env.stval_hs, RISCVCPU),
+        VMSTATE_UINT64(env.satp_hs, RISCVCPU),
         VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
@@ -295,7 +295,7 @@ static const VMStateDescription vmstate_envcfg = {
     .needed = envcfg_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
-        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINT64(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -359,7 +359,7 @@ static const VMStateDescription vmstate_jvt = {
     .minimum_version_id = 1,
     .needed = jvt_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.jvt, RISCVCPU),
+        VMSTATE_UINT64(env.jvt, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -434,16 +434,16 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.mvip, RISCVCPU),
         VMSTATE_UINT64(env.sie, RISCVCPU),
         VMSTATE_UINT64(env.mideleg, RISCVCPU),
-        VMSTATE_UINTTL(env.satp, RISCVCPU),
-        VMSTATE_UINTTL(env.stval, RISCVCPU),
-        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
-        VMSTATE_UINTTL(env.stvec, RISCVCPU),
-        VMSTATE_UINTTL(env.sepc, RISCVCPU),
-        VMSTATE_UINTTL(env.scause, RISCVCPU),
-        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
-        VMSTATE_UINTTL(env.mepc, RISCVCPU),
+        VMSTATE_UINT64(env.satp, RISCVCPU),
+        VMSTATE_UINT64(env.stval, RISCVCPU),
+        VMSTATE_UINT64(env.medeleg, RISCVCPU),
+        VMSTATE_UINT64(env.stvec, RISCVCPU),
+        VMSTATE_UINT64(env.sepc, RISCVCPU),
+        VMSTATE_UINT64(env.scause, RISCVCPU),
+        VMSTATE_UINT64(env.mtvec, RISCVCPU),
+        VMSTATE_UINT64(env.mepc, RISCVCPU),
         VMSTATE_UINTTL(env.mcause, RISCVCPU),
-        VMSTATE_UINTTL(env.mtval, RISCVCPU),
+        VMSTATE_UINT64(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
@@ -454,8 +454,8 @@ const VMStateDescription vmstate_riscv_cpu = {
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
         VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
-        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
+        VMSTATE_UINT64(env.sscratch, RISCVCPU),
+        VMSTATE_UINT64(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.stimecmp, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
-- 
2.51.0


