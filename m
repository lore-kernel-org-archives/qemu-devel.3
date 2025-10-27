Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9A5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmm-0004xK-Na; Mon, 27 Oct 2025 14:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRmX-0004tJ-CA
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRmA-0003xs-00
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uD7zp++GFjV5NIFD6eAmwg15QuzE49KjMgQ6U39c9kg=; b=Zs1gfuuVihNj71l
 aFtueolpJVDkuM+tO8JTCwDVgnVkM/p0XI2EQiIrPmoFEePUD2//C6MtoPGXcgdUE58s53ksodxaZ
 UHJNyq8hbWai+mD5I6JAYjSI3+bVmqhjKrhPC//Mn85sry352fx777GXd2xAynUil5QBwvf32TXUF
 hU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 01/33] target/riscv: Fix size of trivial CPUArchState fields
Date: Mon, 27 Oct 2025 19:17:58 +0100
Message-ID: <20251027181831.27016-2-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
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

Note, the cpu/hyper, cpu/envcfg, cpu/jvt, and cpu VMSTATE versions are
bumped, breaking migration from older versions.

References to the privileged/unprivileged RISCV specification refer to
version 20250508.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 78 +++++++++++++++++++--------------------
 target/riscv/machine.c | 84 +++++++++++++++++++++---------------------
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..7ffc4dac26 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,7 +255,7 @@ struct CPUArchState {
     /* 128-bit helpers upper part return value */
     target_ulong retxh;
 
-    target_ulong jvt;
+    uint64_t jvt;
 
     /* elp state for zicfilp extension */
     bool      elp;
@@ -272,7 +272,7 @@ struct CPUArchState {
     target_ulong priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
-    target_ulong senvcfg;
+    uint64_t senvcfg;
 
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
@@ -314,18 +314,18 @@ struct CPUArchState {
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
-    target_ulong mcause;
-    target_ulong mtval;  /* since: priv-1.10.0 */
+    uint64_t mtvec;
+    uint64_t mepc;
+    uint64_t mcause;
+    uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
     uint32_t sctrdepth;
@@ -347,13 +347,13 @@ struct CPUArchState {
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
@@ -367,7 +367,7 @@ struct CPUArchState {
     uint64_t hvip;
 
     /* Hypervisor controlled virtual interrupt priorities */
-    target_ulong hvictl;
+    uint32_t hvictl;
     uint8_t hviprio[64];
 
     /* Upper 64-bits of 128-bit CSRs */
@@ -380,26 +380,26 @@ struct CPUArchState {
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
@@ -436,8 +436,8 @@ struct CPUArchState {
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
 
-    target_ulong sscratch;
-    target_ulong mscratch;
+    uint64_t sscratch;
+    uint64_t mscratch;
 
     /* Sstc CSRs */
     uint64_t stimecmp;
@@ -507,11 +507,11 @@ struct CPUArchState {
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
index 18d790af0d..f6ca017211 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -80,17 +80,17 @@ static bool hyper_needed(void *opaque)
 
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
-    .version_id = 4,
-    .minimum_version_id = 4,
+    .version_id = 5,
+    .minimum_version_id = 5,
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
@@ -291,12 +291,12 @@ static bool envcfg_needed(void *opaque)
 
 static const VMStateDescription vmstate_envcfg = {
     .name = "cpu/envcfg",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = envcfg_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
-        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINT64(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -356,11 +356,11 @@ static bool jvt_needed(void *opaque)
 
 static const VMStateDescription vmstate_jvt = {
     .name = "cpu/jvt",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = jvt_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.jvt, RISCVCPU),
+        VMSTATE_UINT64(env.jvt, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -427,8 +427,8 @@ static const VMStateDescription vmstate_sstc = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -459,16 +459,16 @@ const VMStateDescription vmstate_riscv_cpu = {
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
-        VMSTATE_UINTTL(env.mcause, RISCVCPU),
-        VMSTATE_UINTTL(env.mtval, RISCVCPU),
+        VMSTATE_UINT64(env.satp, RISCVCPU),
+        VMSTATE_UINT64(env.stval, RISCVCPU),
+        VMSTATE_UINT64(env.medeleg, RISCVCPU),
+        VMSTATE_UINT64(env.stvec, RISCVCPU),
+        VMSTATE_UINT64(env.sepc, RISCVCPU),
+        VMSTATE_UINT64(env.scause, RISCVCPU),
+        VMSTATE_UINT64(env.mtvec, RISCVCPU),
+        VMSTATE_UINT64(env.mepc, RISCVCPU),
+        VMSTATE_UINT64(env.mcause, RISCVCPU),
+        VMSTATE_UINT64(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
@@ -479,8 +479,8 @@ const VMStateDescription vmstate_riscv_cpu = {
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


