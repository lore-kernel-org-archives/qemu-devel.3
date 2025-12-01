Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C561DD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 08:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPyvC-0006SD-NN; Mon, 01 Dec 2025 03:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPyv4-0006Pm-KU; Mon, 01 Dec 2025 03:06:03 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPyv1-0002Th-CL; Mon, 01 Dec 2025 03:06:02 -0500
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5B185UmR081446
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Dec 2025 16:05:30 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Dec 2025
 16:05:30 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <vivahavey@gmail.com>, Alvin Chang
 <alvinga@andestech.com>, Yu-Ming Chang <yumin686@andestech.com>
Subject: [PATCH] target/riscv: Make number of debug triggers configurable
Date: Mon, 1 Dec 2025 16:05:24 +0800
Message-ID: <20251201080524.186697-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B185UmR081446
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In current implementation, the number of debug triggers was hardcoded as
RV_MAX_TRIGGERS macro. This commit replaces the fixed value with a new
"num_triggers" configuration, allowing platforms to configure the number
of debug triggers they want.

If no specific option is provided, the default number of debug triggers
remains 2 as before.

A new CPU property "num-triggers" is added to let users configure the
number of debug triggers from the command line. For example:

  -cpu max,num-triggers=8

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
---
 target/riscv/cpu.c                | 34 +++++++++++++++++++++++++++++++
 target/riscv/cpu.h                | 12 +++++------
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                |  3 ++-
 target/riscv/debug.c              | 23 +++++++++++++--------
 target/riscv/debug.h              |  2 --
 target/riscv/machine.c            | 16 ++++++++++-----
 7 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280..5996d13 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1122,6 +1122,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
     cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
+    cpu->cfg.num_triggers = 2;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1644,6 +1645,38 @@ static const PropertyInfo prop_pmp_granularity = {
     .set = prop_pmp_granularity_set,
 };
 
+static void prop_num_triggers_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+
+    if (cpu->cfg.num_triggers != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.num_triggers = value;
+}
+
+static void prop_num_triggers_get(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    uint32_t value = RISCV_CPU(obj)->cfg.pmp_regions;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_num_triggers = {
+    .type = "uint32",
+    .description = "num-triggers",
+    .get = prop_num_triggers_get,
+    .set = prop_num_triggers_set,
+};
+
 static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
@@ -2645,6 +2678,7 @@ static const Property riscv_cpu_properties[] = {
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
     {.name = "pmp-granularity", .info = &prop_pmp_granularity},
+    {.name = "num-triggers", .info = &prop_num_triggers},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10..b32ed78 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -450,13 +450,13 @@ struct CPUArchState {
 
     /* trigger module */
     target_ulong trigger_cur;
-    target_ulong tdata1[RV_MAX_TRIGGERS];
-    target_ulong tdata2[RV_MAX_TRIGGERS];
-    target_ulong tdata3[RV_MAX_TRIGGERS];
+    target_ulong *tdata1;
+    target_ulong *tdata2;
+    target_ulong *tdata3;
     target_ulong mcontext;
-    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
-    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
+    struct CPUBreakpoint **cpu_breakpoint;
+    struct CPUWatchpoint **cpu_watchpoint;
+    QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecd..840e8c4 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -167,6 +167,7 @@ TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 TYPED_FIELD(uint8_t,  pmp_regions, 0)
 TYPED_FIELD(uint32_t, pmp_granularity, 0)
+TYPED_FIELD(uint32_t, num_triggers, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658..fce5f94 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5346,7 +5346,8 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
-    if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
+    if (env->trigger_cur >= riscv_cpu_cfg(env)->num_triggers &&
+        csrno == CSR_TDATA1) {
         *val = 0;
         return RISCV_EXCP_NONE;
     }
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466..460363f 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -171,7 +171,7 @@ target_ulong tselect_csr_read(CPURISCVState *env)
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_MAX_TRIGGERS) {
+    if (val < riscv_cpu_cfg(env)->num_triggers) {
         env->trigger_cur = val;
     }
 }
@@ -700,7 +700,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -720,7 +720,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -749,7 +749,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -949,7 +949,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     int i;
 
     QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        for (i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
             trigger_type = get_trigger_type(env, i);
 
             if (!trigger_common_match(env, trigger_type, i)) {
@@ -995,7 +995,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     int flags;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
         trigger_type = get_trigger_type(env, i);
 
         if (!trigger_common_match(env, trigger_type, i)) {
@@ -1046,9 +1046,16 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
 void riscv_trigger_realize(CPURISCVState *env)
 {
+    uint32_t num_triggers = riscv_cpu_cfg(env)->num_triggers;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    env->tdata1 = g_new0(target_ulong, num_triggers);
+    env->tdata2 = g_new0(target_ulong, num_triggers);
+    env->tdata3 = g_new0(target_ulong, num_triggers);
+    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, num_triggers);
+    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, num_triggers);
+    env->itrigger_timer = g_new0(QEMUTimer *, num_triggers);
+    for (i = 0; i < num_triggers; i++) {
         env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               riscv_itrigger_timer_cb, env);
     }
@@ -1060,7 +1067,7 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     int i;
 
     /* init to type 2 triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < riscv_cpu_cfg(env)->num_triggers; i++) {
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f9..d3aae61 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -24,8 +24,6 @@
 
 #include "exec/breakpoint.h"
 
-#define RV_MAX_TRIGGERS         2
-
 /* register index of tdata CSRs */
 enum {
     TDATA1 = 0,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790a..c7244b7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -239,15 +239,21 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
+                              cfg.num_triggers, 0,
+                              vmstate_info_uinttl, target_ulong),
+        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
+                              cfg.num_triggers, 0,
+                              vmstate_info_uinttl, target_ulong),
+        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
+                              cfg.num_triggers, 0,
+                              vmstate_info_uinttl, target_ulong),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


