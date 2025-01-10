Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC92EE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqI-00030X-BE; Fri, 10 Jan 2025 09:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqH-0002zj-4B
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqE-0005B1-MF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpxefguLDSU4LbhTpLSs1XS6WrZ6hJ5XZ+czuiJYKhI=;
 b=cNp+ksz+uxU9a4X88OSKvLv/9y/u+Q/DvHIBO9tPCNkN9fN3I86kmRgw1Q2KAU71Fjji00
 QyXG5e63hkTLsxnTHOP6goAGYrEYN2ho8eS9AeJjJ+VAz9db7cupDKMDBgcAA7sy0ljZfn
 NWN4IcTriFqm6Op2um0uy2zCdHa1ATU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-o87XJFDgObCwTfNB-yjclQ-1; Fri,
 10 Jan 2025 09:18:22 -0500
X-MC-Unique: o87XJFDgObCwTfNB-yjclQ-1
X-Mimecast-MFC-AGG-ID: o87XJFDgObCwTfNB-yjclQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5325195608B; Fri, 10 Jan 2025 14:18:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A920195E3D9; Fri, 10 Jan 2025 14:18:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 6/9] ppc/ppc405: Remove timer support
Date: Fri, 10 Jan 2025 15:17:57 +0100
Message-ID: <20250110141800.1587589-7-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the 405 CPU family was phased out, these timer models have no
users anymore.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/ppc.h         |  15 ---
 target/ppc/cpu.h             |   7 -
 target/ppc/helper.h          |   4 -
 target/ppc/spr_common.h      |   4 -
 hw/ppc/ppc.c                 | 251 -----------------------------------
 target/ppc/timebase_helper.c |  20 ---
 target/ppc/translate.c       |  24 ----
 hw/ppc/trace-events          |   5 -
 8 files changed, 330 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 8a14d623f8ca..18b0492dd198 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -8,19 +8,6 @@ PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
 int ppc_cpu_pir(PowerPCCPU *cpu);
 int ppc_cpu_tir(PowerPCCPU *cpu);
 
-/* PowerPC hardware exceptions management helpers */
-typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
-typedef struct clk_setup_t clk_setup_t;
-struct clk_setup_t {
-    clk_setup_cb cb;
-    void *opaque;
-};
-static inline void clk_setup (clk_setup_t *clk, uint32_t freq)
-{
-    if (clk->cb != NULL)
-        (*clk->cb)(clk->opaque, freq);
-}
-
 struct ppc_tb_t {
     /* Time base management */
     int64_t  tb_offset;    /* Compensation                    */
@@ -67,8 +54,6 @@ int ppc_dcr_init (CPUPPCState *env, int (*dcr_read_error)(int dcrn),
                   int (*dcr_write_error)(int dcrn));
 int ppc_dcr_register (CPUPPCState *env, int dcrn, void *opaque,
                       dcr_read_cb drc_read, dcr_write_cb dcr_write);
-clk_setup_cb ppc_40x_timers_init (CPUPPCState *env, uint32_t freq,
-                                  unsigned int decr_excp);
 
 /* Embedded PowerPC reset */
 void ppc40x_core_reset(PowerPCCPU *cpu);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 32423cfb7368..504924f10561 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1615,11 +1615,7 @@ void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 #if !defined(CONFIG_USER_ONLY)
-target_ulong load_40x_pit(CPUPPCState *env);
-void store_40x_pit(CPUPPCState *env, target_ulong val);
 void store_40x_dbcr0(CPUPPCState *env, uint32_t val);
-void store_40x_tcr(CPUPPCState *env, target_ulong val);
-void store_40x_tsr(CPUPPCState *env, target_ulong val);
 void store_booke_tcr(CPUPPCState *env, target_ulong val);
 void store_booke_tsr(CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all(CPUPPCState *env);
@@ -2196,11 +2192,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_403_CDBCR         (0x3D7)
 #define SPR_L3ITCR0           (0x3D8)
 #define SPR_TCR               (0x3D8)
-#define SPR_40x_TSR           (0x3D8)
 #define SPR_IBR               (0x3DA)
-#define SPR_40x_TCR           (0x3DA)
 #define SPR_ESASRR            (0x3DB)
-#define SPR_40x_PIT           (0x3DB)
 #define SPR_403_TBL           (0x3DC)
 #define SPR_403_TBU           (0x3DD)
 #define SPR_SEBR              (0x3DE)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 8272ceb5d7b1..025f2b5ac902 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -746,10 +746,6 @@ DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
-DEF_HELPER_FLAGS_2(store_40x_pit, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(store_40x_tcr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(store_40x_tsr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_40x_pid, void, env, tl)
 DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index e98fb07bb285..4aab0e5f8291 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -135,11 +135,7 @@ void spr_write_dbatu_h(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dbatl(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dbatl_h(DisasContext *ctx, int sprn, int gprn);
 void spr_write_sdr1(DisasContext *ctx, int sprn, int gprn);
-void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn);
-void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn);
-void spr_write_40x_tcr(DisasContext *ctx, int sprn, int gprn);
-void spr_write_40x_tsr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn);
 void spr_write_booke_tcr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_booke_tsr(DisasContext *ctx, int sprn, int gprn);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 90e3db5cfeba..2c72c43f6ed3 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1163,257 +1163,6 @@ void cpu_ppc_hdecr_exit(CPUPPCState *env)
     cpu_ppc_hdecr_lower(cpu);
 }
 
-/*****************************************************************************/
-/* PowerPC 40x timers */
-
-/* PIT, FIT & WDT */
-typedef struct ppc40x_timer_t ppc40x_timer_t;
-struct ppc40x_timer_t {
-    uint64_t pit_reload;  /* PIT auto-reload value        */
-    uint64_t fit_next;    /* Tick for next FIT interrupt  */
-    QEMUTimer *fit_timer;
-    uint64_t wdt_next;    /* Tick for next WDT interrupt  */
-    QEMUTimer *wdt_timer;
-
-    /* 405 have the PIT, 440 have a DECR.  */
-    unsigned int decr_excp;
-};
-
-/* Fixed interval timer */
-static void cpu_4xx_fit_cb (void *opaque)
-{
-    PowerPCCPU *cpu = opaque;
-    CPUPPCState *env = &cpu->env;
-    ppc_tb_t *tb_env;
-    ppc40x_timer_t *ppc40x_timer;
-    uint64_t now, next;
-
-    tb_env = env->tb_env;
-    ppc40x_timer = tb_env->opaque;
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    switch ((env->spr[SPR_40x_TCR] >> 24) & 0x3) {
-    case 0:
-        next = 1 << 9;
-        break;
-    case 1:
-        next = 1 << 13;
-        break;
-    case 2:
-        next = 1 << 17;
-        break;
-    case 3:
-        next = 1 << 21;
-        break;
-    default:
-        /* Cannot occur, but makes gcc happy */
-        return;
-    }
-    next = now + tb_to_ns_round_up(tb_env->tb_freq, next);
-    timer_mod(ppc40x_timer->fit_timer, next);
-    env->spr[SPR_40x_TSR] |= 1 << 26;
-    if ((env->spr[SPR_40x_TCR] >> 23) & 0x1) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_FIT, 1);
-    }
-    trace_ppc4xx_fit((int)((env->spr[SPR_40x_TCR] >> 23) & 0x1),
-                         env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
-}
-
-/* Programmable interval timer */
-static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
-{
-    ppc40x_timer_t *ppc40x_timer;
-    uint64_t now, next;
-
-    ppc40x_timer = tb_env->opaque;
-    if (ppc40x_timer->pit_reload <= 1 ||
-        !((env->spr[SPR_40x_TCR] >> 26) & 0x1) ||
-        (is_excp && !((env->spr[SPR_40x_TCR] >> 22) & 0x1))) {
-        /* Stop PIT */
-        trace_ppc4xx_pit_stop();
-        timer_del(tb_env->decr_timer);
-    } else {
-        trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
-        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        if (is_excp) {
-            tb_env->decr_next += ppc40x_timer->pit_reload;
-        } else {
-            tb_env->decr_next = ns_to_tb(tb_env->decr_freq, now)
-                                + ppc40x_timer->pit_reload;
-        }
-        next = tb_to_ns_round_up(tb_env->decr_freq, tb_env->decr_next);
-        timer_mod(tb_env->decr_timer, next);
-    }
-}
-
-static void cpu_4xx_pit_cb (void *opaque)
-{
-    PowerPCCPU *cpu = opaque;
-    CPUPPCState *env = &cpu->env;
-    ppc_tb_t *tb_env;
-    ppc40x_timer_t *ppc40x_timer;
-
-    tb_env = env->tb_env;
-    ppc40x_timer = tb_env->opaque;
-    env->spr[SPR_40x_TSR] |= 1 << 27;
-    if ((env->spr[SPR_40x_TCR] >> 26) & 0x1) {
-        ppc_set_irq(cpu, ppc40x_timer->decr_excp, 1);
-    }
-    start_stop_pit(env, tb_env, 1);
-    trace_ppc4xx_pit((int)((env->spr[SPR_40x_TCR] >> 22) & 0x1),
-           (int)((env->spr[SPR_40x_TCR] >> 26) & 0x1),
-           env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR],
-           ppc40x_timer->pit_reload);
-}
-
-/* Watchdog timer */
-static void cpu_4xx_wdt_cb (void *opaque)
-{
-    PowerPCCPU *cpu = opaque;
-    CPUPPCState *env = &cpu->env;
-    ppc_tb_t *tb_env;
-    ppc40x_timer_t *ppc40x_timer;
-    uint64_t now, next;
-
-    tb_env = env->tb_env;
-    ppc40x_timer = tb_env->opaque;
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    switch ((env->spr[SPR_40x_TCR] >> 30) & 0x3) {
-    case 0:
-        next = 1 << 17;
-        break;
-    case 1:
-        next = 1 << 21;
-        break;
-    case 2:
-        next = 1 << 25;
-        break;
-    case 3:
-        next = 1 << 29;
-        break;
-    default:
-        /* Cannot occur, but makes gcc happy */
-        return;
-    }
-    next = now + tb_to_ns_round_up(tb_env->decr_freq, next);
-    trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
-    switch ((env->spr[SPR_40x_TSR] >> 30) & 0x3) {
-    case 0x0:
-    case 0x1:
-        timer_mod(ppc40x_timer->wdt_timer, next);
-        ppc40x_timer->wdt_next = next;
-        env->spr[SPR_40x_TSR] |= 1U << 31;
-        break;
-    case 0x2:
-        timer_mod(ppc40x_timer->wdt_timer, next);
-        ppc40x_timer->wdt_next = next;
-        env->spr[SPR_40x_TSR] |= 1 << 30;
-        if ((env->spr[SPR_40x_TCR] >> 27) & 0x1) {
-            ppc_set_irq(cpu, PPC_INTERRUPT_WDT, 1);
-        }
-        break;
-    case 0x3:
-        env->spr[SPR_40x_TSR] &= ~0x30000000;
-        env->spr[SPR_40x_TSR] |= env->spr[SPR_40x_TCR] & 0x30000000;
-        switch ((env->spr[SPR_40x_TCR] >> 28) & 0x3) {
-        case 0x0:
-            /* No reset */
-            break;
-        case 0x1: /* Core reset */
-            ppc40x_core_reset(cpu);
-            break;
-        case 0x2: /* Chip reset */
-            ppc40x_chip_reset(cpu);
-            break;
-        case 0x3: /* System reset */
-            ppc40x_system_reset(cpu);
-            break;
-        }
-    }
-}
-
-void store_40x_pit (CPUPPCState *env, target_ulong val)
-{
-    ppc_tb_t *tb_env;
-    ppc40x_timer_t *ppc40x_timer;
-
-    tb_env = env->tb_env;
-    ppc40x_timer = tb_env->opaque;
-    trace_ppc40x_store_pit(val);
-    ppc40x_timer->pit_reload = val;
-    start_stop_pit(env, tb_env, 0);
-}
-
-target_ulong load_40x_pit (CPUPPCState *env)
-{
-    return cpu_ppc_load_decr(env);
-}
-
-void store_40x_tsr(CPUPPCState *env, target_ulong val)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-
-    trace_ppc40x_store_tcr(val);
-
-    env->spr[SPR_40x_TSR] &= ~(val & 0xFC000000);
-    if (val & 0x80000000) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_PIT, 0);
-    }
-}
-
-void store_40x_tcr(CPUPPCState *env, target_ulong val)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-    ppc_tb_t *tb_env;
-
-    trace_ppc40x_store_tsr(val);
-
-    tb_env = env->tb_env;
-    env->spr[SPR_40x_TCR] = val & 0xFFC00000;
-    start_stop_pit(env, tb_env, 1);
-    cpu_4xx_wdt_cb(cpu);
-}
-
-static void ppc_40x_set_tb_clk (void *opaque, uint32_t freq)
-{
-    CPUPPCState *env = opaque;
-    ppc_tb_t *tb_env = env->tb_env;
-
-    trace_ppc40x_set_tb_clk(freq);
-    tb_env->tb_freq = freq;
-    tb_env->decr_freq = freq;
-    /* XXX: we should also update all timers */
-}
-
-clk_setup_cb ppc_40x_timers_init (CPUPPCState *env, uint32_t freq,
-                                  unsigned int decr_excp)
-{
-    ppc_tb_t *tb_env;
-    ppc40x_timer_t *ppc40x_timer;
-    PowerPCCPU *cpu = env_archcpu(env);
-
-    trace_ppc40x_timers_init(freq);
-
-    tb_env = g_new0(ppc_tb_t, 1);
-    ppc40x_timer = g_new0(ppc40x_timer_t, 1);
-
-    env->tb_env = tb_env;
-    tb_env->flags = PPC_DECR_UNDERFLOW_TRIGGERED;
-    tb_env->tb_freq = freq;
-    tb_env->decr_freq = freq;
-    tb_env->opaque = ppc40x_timer;
-
-    /* We use decr timer for PIT */
-    tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_4xx_pit_cb, cpu);
-    ppc40x_timer->fit_timer =
-        timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_4xx_fit_cb, cpu);
-    ppc40x_timer->wdt_timer =
-        timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_4xx_wdt_cb, cpu);
-    ppc40x_timer->decr_excp = decr_excp;
-
-    return &ppc_40x_set_tb_clk;
-}
-
 /*****************************************************************************/
 /* Embedded PowerPC Device Control Registers */
 typedef struct ppc_dcrn_t ppc_dcrn_t;
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 73120323b4e6..1eee0a6918d3 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -181,26 +181,6 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
     }
 }
 
-target_ulong helper_load_40x_pit(CPUPPCState *env)
-{
-    return load_40x_pit(env);
-}
-
-void helper_store_40x_pit(CPUPPCState *env, target_ulong val)
-{
-    store_40x_pit(env, val);
-}
-
-void helper_store_40x_tcr(CPUPPCState *env, target_ulong val)
-{
-    store_40x_tcr(env, val);
-}
-
-void helper_store_40x_tsr(CPUPPCState *env, target_ulong val)
-{
-    store_40x_tsr(env, val);
-}
-
 void helper_store_booke_tcr(CPUPPCState *env, target_ulong val)
 {
     store_booke_tcr(env, val);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0f19949897f4..ea5eff7cf0f8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -946,18 +946,6 @@ void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 
 /* PowerPC 40x specific registers */
 #if !defined(CONFIG_USER_ONLY)
-void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn)
-{
-    translator_io_start(&ctx->base);
-    gen_helper_load_40x_pit(cpu_gpr[gprn], tcg_env);
-}
-
-void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn)
-{
-    translator_io_start(&ctx->base);
-    gen_helper_store_40x_pit(tcg_env, cpu_gpr[gprn]);
-}
-
 void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
@@ -967,18 +955,6 @@ void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-void spr_write_40x_tcr(DisasContext *ctx, int sprn, int gprn)
-{
-    translator_io_start(&ctx->base);
-    gen_helper_store_40x_tcr(tcg_env, cpu_gpr[gprn]);
-}
-
-void spr_write_40x_tsr(DisasContext *ctx, int sprn, int gprn)
-{
-    translator_io_start(&ctx->base);
-    gen_helper_store_40x_tsr(tcg_env, cpu_gpr[gprn]);
-}
-
 void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 1f125ce84193..d00a81666c82 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -123,16 +123,11 @@ ppc_decr_load(uint64_t tb) "decr 0x%016" PRIx64
 ppc_decr_excp(const char *action) "%s decrementer"
 ppc_decr_store(uint32_t nr_bits, uint64_t decr, uint64_t value) "%d-bit 0x%016" PRIx64 " => 0x%016" PRIx64
 
-ppc4xx_fit(uint32_t ir, uint64_t tcr, uint64_t tsr) "ir %d TCR 0x%" PRIx64 " TSR 0x%" PRIx64
 ppc4xx_pit_stop(void) ""
 ppc4xx_pit_start(uint64_t reload) "PIT 0x%016" PRIx64
-ppc4xx_pit(uint32_t ar, uint32_t ir, uint64_t tcr, uint64_t tsr, uint64_t reload) "ar %d ir %d TCR 0x%" PRIx64 " TSR 0x%" PRIx64 " PIT 0x%016" PRIx64
 ppc4xx_wdt(uint64_t tcr, uint64_t tsr) "TCR 0x%" PRIx64 " TSR 0x%" PRIx64
-ppc40x_store_pit(uint64_t value) "val 0x%" PRIx64
 ppc40x_store_tcr(uint64_t value) "val 0x%" PRIx64
 ppc40x_store_tsr(uint64_t value) "val 0x%" PRIx64
-ppc40x_set_tb_clk(uint32_t value) "new frequency %" PRIu32
-ppc40x_timers_init(uint32_t value) "frequency %" PRIu32
 
 ppc_irq_set(void *env, uint32_t pin, uint32_t level) "env [%p] pin %d level %d"
 ppc_irq_set_exit(void *env, uint32_t irq, uint32_t level, uint32_t pending, uint32_t request) "env [%p] irq 0x%05" PRIx32 " level %d => pending 0x%08" PRIx32 " req 0x%08" PRIx32
-- 
2.47.1


