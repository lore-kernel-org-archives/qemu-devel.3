Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AADCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwqx-0007YY-F3; Fri, 15 May 2026 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqL-0007Km-I1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:07 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqI-0001MA-7r
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1I3Bgv0SQHY8SsYW832jIY3xIe6YZKMN3LWNdtZDkRc=; b=RzL/mX6+TKVos4K
 DmEgxAGgcaXGAyIRJz+ISEP563Gdub9S8oZKmcIzf98tdl+/Vz0pGcCG5hJlMSeQdWKJ+QBriK+gv
 sk3KOuu8/4Y6yG51jsi9VcyQmQFTgyPaZ1mi6Ge7qwW4RLJqK4aeJS7rimJG5Fl2uz6QOrypnGJSf
 FA=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 13/27] target/riscv: Fix size of gei fields
Date: Fri, 15 May 2026 20:04:23 +0200
Message-ID: <20260515180437.23620-14-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

geilen takes the values 31 or 63, fix it to 8 bits. hgeie and hgeip are
at most 64 bits in size, fix to 64.  Update relevant function arguments
and uses of hgeie and hgeip.  Note, masking is widened to 64-bit as
geilen is already verified to be smaller than the target long size, and
an out-of-bounds shift would be UB anyway.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 10 +++++-----
 target/riscv/cpu.c        |  4 ++--
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/csr.c        |  4 ++--
 target/riscv/machine.c    |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 79d3e74b7a..a2ba5bef60 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -279,7 +279,7 @@ struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
-    target_ulong geilen;
+    uint8_t geilen;
     uint64_t resetvec;
 
     uint64_t mhartid;
@@ -356,8 +356,8 @@ struct CPUArchState {
     uint64_t htval;
     uint64_t htinst;
     uint64_t hgatp;
-    target_ulong hgeie;
-    target_ulong hgeip;
+    uint64_t hgeie;
+    uint64_t hgeip;
     uint64_t htimedelta;
     uint64_t hvien;
 
@@ -609,8 +609,8 @@ int riscv_cpu_mirq_pending(CPURISCVState *env);
 int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 27310a95d1..d7219edd87 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1064,9 +1064,9 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         }
 
         /* Update HGEIP CSR */
-        env->hgeip &= ~((target_ulong)1 << irq);
+        env->hgeip &= ~(1ULL << irq);
         if (level) {
-            env->hgeip |= (target_ulong)1 << irq;
+            env->hgeip |= 1ULL << irq;
         }
 
         /* Update mip.SGEIP bit */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ff4e941d94..e7c0ff49d0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -712,7 +712,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
         return 0;
@@ -721,7 +721,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
     return env->geilen;
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
         return;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ec08fbddce..0e84554f29 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3768,7 +3768,7 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
 
     if (csrno != CSR_HVIP) {
         gin = get_field(env->hstatus, HSTATUS_VGEIN);
-        old_mip |= (env->hgeip & ((target_ulong)1 << gin)) ? MIP_VSEIP : 0;
+        old_mip |= (env->hgeip & (1ULL << gin)) ? MIP_VSEIP : 0;
         old_mip |= env->vstime_irq ? MIP_VSTIP : 0;
     }
 
@@ -4953,7 +4953,7 @@ static RISCVException write_hgeie(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
     /* Only GEILEN:1 bits implemented and BIT0 is never implemented */
-    val &= ((((target_ulong)1) << env->geilen) - 1) << 1;
+    val &= ((1ULL << env->geilen) - 1) << 1;
     env->hgeie = val;
     /* Update mip.SGEIP bit */
     riscv_cpu_update_mip(env, MIP_SGEIP,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ce5e44325d..8a8f5be8d6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -91,8 +91,8 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.htval, RISCVCPU),
         VMSTATE_UINT64(env.htinst, RISCVCPU),
         VMSTATE_UINT64(env.hgatp, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeie, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeip, RISCVCPU),
+        VMSTATE_UINT64(env.hgeie, RISCVCPU),
+        VMSTATE_UINT64(env.hgeip, RISCVCPU),
         VMSTATE_UINT64(env.hvien, RISCVCPU),
         VMSTATE_UINT64(env.hvip, RISCVCPU),
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
-- 
2.52.0


