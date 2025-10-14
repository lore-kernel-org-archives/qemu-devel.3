Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC62CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8li1-0000vD-8w; Tue, 14 Oct 2025 16:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8lhy-0000uh-B7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:22 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8lhw-0000RX-2p
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Y+4Cumc5Qkouvk1Dg3g4Kt6jmVFQrDVTaxt8WMZNIw4=; b=bp7SsQCdumdwGdN
 2GNAljE4GDM4UKbtCwjP30MDZRtW3PniqoYM5sj2JGDxTsZnbjVw81oImsl6oWRaby0Ix7bqiwYpz
 fKO/slFHOTV3ZHBbtgcv14PrCk3HVkSEZpnMlBkNK2xR7UdYpXwejR3KwSzIfz4ZngYxp0Who7FU+
 po=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 12/34] target/riscv: Fix size of pc, load_[val|res]
Date: Tue, 14 Oct 2025 22:34:49 +0200
Message-ID: <20251014203512.26282-13-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
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

Fix to 64 bits in size and as these are mapped to TCG globals, be
careful with host endianness when allocating globals.  Casts are
added to logging expressions to retain the correct size for
TARGET_RISCV32.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h        |  6 +++---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_helper.c |  6 +++---
 target/riscv/machine.c    |  6 +++---
 target/riscv/translate.c  | 12 +++++++-----
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ff1562b7ff..a25c75ca64 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,9 +224,9 @@ struct CPUArchState {
     uint8_t vxsat;
     bool vill;
 
-    target_ulong pc;
-    target_ulong load_res;
-    target_ulong load_val;
+    uint64_t pc;
+    uint64_t load_res;
+    uint64_t load_val;
 
     /* Floating-Point state */
     uint64_t fpr[32]; /* assume both F and D extensions */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b7690ac00f..c86a64b727 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -528,7 +528,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
     }
 #endif
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
+    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     {
         static const int dump_csrs[] = {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9d0683f200..5a20596f1f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2279,9 +2279,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     qemu_log_mask(CPU_LOG_INT,
                   "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", "
-                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
-                  __func__, env->mhartid, async, cause, env->pc, tval,
-                  riscv_cpu_get_trap_name(cause, async));
+                  "epc:0x%"PRIx64", tval:0x"TARGET_FMT_lx", desc=%s\n",
+                  __func__, env->mhartid, async, cause, env->pc,
+                  tval, riscv_cpu_get_trap_name(cause, async));
 
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 440b09fc32..66ed3f6504 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -433,9 +433,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
         VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
-        VMSTATE_UINTTL(env.pc, RISCVCPU),
-        VMSTATE_UINTTL(env.load_res, RISCVCPU),
-        VMSTATE_UINTTL(env.load_val, RISCVCPU),
+        VMSTATE_UINT64(env.pc, RISCVCPU),
+        VMSTATE_UINT64(env.load_res, RISCVCPU),
+        VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINTTL(env.frm, RISCVCPU),
         VMSTATE_UINTTL(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 98fd4b9051..6b84d0c384 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1444,6 +1444,10 @@ void riscv_translate_init(void)
     /* 32 bits in size, no offset needed */
     size_t vl_offset = offsetof(CPURISCVState, vl);
     size_t vstart_offset = offsetof(CPURISCVState, vstart);
+    /* 64 bits in size mapped to TCGv, needs offset */
+    size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
+    size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
+    size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
@@ -1459,11 +1463,9 @@ void riscv_translate_init(void)
             offsetof(CPURISCVState, fpr[i]), riscv_fpr_regnames[i]);
     }
 
-    cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
+    cpu_pc = tcg_global_mem_new(tcg_env, pc_offset, "pc");
     cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
     cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
-    load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
-                             "load_res");
-    load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-                             "load_val");
+    load_res = tcg_global_mem_new(tcg_env, res_offset, "load_res");
+    load_val = tcg_global_mem_new(tcg_env, val_offset, "load_val");
 }
-- 
2.51.0


