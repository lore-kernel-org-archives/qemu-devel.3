Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBADBC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trenu-0002ie-NG; Mon, 10 Mar 2025 11:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren6-00029H-SG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:40 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren0-0007iC-EP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:40 -0400
Received: (qmail 30961 invoked by uid 484); 10 Mar 2025 15:11:13 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012861 secs); 10 Mar 2025 15:11:13 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:13 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 15/16] mcd: Implement trigger control
Date: Mon, 10 Mar 2025 16:05:09 +0100
Message-Id: <20250310150510.200607-16-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

MCD's trigger API functions support multiple triggers by expecting a pointer
to the trigger instance. Each trigger structure reserves the first four bytes
for its size. To get the specific structure, read a uint32_t at passed pointer
and compare it to the sizes of known trigger structures.

This approach does not work for serialization. The sizes might vary between
host machines and pointers cannot be sent over the network anyway.

Therefore, we define a MCDTrig structure which explicitly lists all supported
trigger types as optional fields:

* mcd_trig_simple_core_st: mcd-trig-simple-core
* mcd_trig_complex_core_st: mcd-trig-complex-core

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/libmcd_qapi.c  | 155 +++++++++++-
 mcd/libmcd_qapi.h  |  21 ++
 mcd/mcdserver.c    | 585 ++++++++++++++++++++++++++++++++++++++++++--
 mcd/mcdstub_qapi.c | 290 ++++++++++++++++++++++
 qapi/mcd.json      | 588 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1619 insertions(+), 20 deletions(-)

diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
index 8088a9eed2..db3d11d3e5 100644
--- a/mcd/libmcd_qapi.c
+++ b/mcd/libmcd_qapi.c
@@ -188,7 +188,8 @@ mcd_addr_st unmarshal_mcd_addr(MCDAddr *addr)
     return unmarshal;
 }
 
-MCDRegisterInfo *marshal_mcd_register_info(const mcd_register_info_st *reg_info)
+MCDRegisterInfo *marshal_mcd_register_info(
+    const mcd_register_info_st *reg_info)
 {
     MCDRegisterInfo *marshal = g_malloc0(sizeof(*marshal));
 
@@ -224,6 +225,158 @@ MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state)
     return marshal;
 }
 
+MCDTrigInfo *marshal_mcd_trig_info(const mcd_trig_info_st *trig_info)
+{
+    MCDTrigInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTrigInfo) {
+        .type = trig_info->type,
+        .option = trig_info->option,
+        .action = trig_info->action,
+        .trig_number = trig_info->trig_number,
+        .state_number = trig_info->state_number,
+        .counter_number = trig_info->counter_number,
+        .sw_breakpoints = trig_info->sw_breakpoints,
+    };
+
+    return marshal;
+}
+
+MCDCtrigInfo *marshal_mcd_ctrig_info(const mcd_ctrig_info_st *trig_info)
+{
+    MCDCtrigInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDCtrigInfo) {
+        .ctrig_id = trig_info->ctrig_id,
+        .info_str = g_strdup(trig_info->info_str),
+    };
+
+    return marshal;
+}
+
+MCDTrigSimpleCore *marshal_mcd_trig_simple_core(
+    mcd_trig_simple_core_st const *trig_simple_core)
+{
+    MCDTrigSimpleCore *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTrigSimpleCore) {
+        .type = trig_simple_core->type,
+        .option = trig_simple_core->option,
+        .action = trig_simple_core->action,
+        .action_param = trig_simple_core->action_param,
+        .modified = trig_simple_core->modified,
+        .state_mask = trig_simple_core->state_mask,
+        .addr_start = marshal_mcd_addr(&trig_simple_core->addr_start),
+        .addr_range = trig_simple_core->addr_range,
+    };
+
+    return marshal;
+}
+
+mcd_trig_simple_core_st unmarshal_mcd_trig_simple_core(
+     MCDTrigSimpleCore *trig_simple_core)
+{
+    mcd_trig_simple_core_st unmarshal =  {
+        .struct_size = sizeof(mcd_trig_simple_core_st),
+        .type = trig_simple_core->type,
+        .option = trig_simple_core->option,
+        .action = trig_simple_core->action,
+        .action_param = trig_simple_core->action_param,
+        .modified = trig_simple_core->modified,
+        .state_mask = trig_simple_core->state_mask,
+        .addr_start = unmarshal_mcd_addr(trig_simple_core->addr_start),
+        .addr_range = trig_simple_core->addr_range,
+    };
+
+    return unmarshal;
+}
+
+MCDTrigComplexCore *marshal_mcd_trig_complex_core(
+    mcd_trig_complex_core_st const *trig_complex_core)
+{
+    MCDTrigComplexCore *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTrigComplexCore) {
+        .type = trig_complex_core->type,
+        .option = trig_complex_core->option,
+        .action = trig_complex_core->action,
+        .action_param = trig_complex_core->action_param,
+        .modified = trig_complex_core->modified,
+        .state_mask = trig_complex_core->state_mask,
+        .addr_start = marshal_mcd_addr(&trig_complex_core->addr_start),
+        .addr_range = trig_complex_core->addr_range,
+        .data_start = trig_complex_core->data_start,
+        .data_range = trig_complex_core->data_range,
+        .data_mask = trig_complex_core->data_mask,
+        .data_size = trig_complex_core->data_size,
+        .hw_thread_id = trig_complex_core->hw_thread_id,
+        .sw_thread_id = trig_complex_core->sw_thread_id,
+        .core_mode_mask = trig_complex_core->core_mode_mask,
+    };
+
+    return marshal;
+}
+
+mcd_trig_complex_core_st unmarshal_mcd_trig_complex_core(
+     MCDTrigComplexCore *trig_complex_core)
+{
+    mcd_trig_complex_core_st unmarshal =  {
+        .struct_size = sizeof(mcd_trig_complex_core_st),
+        .type = trig_complex_core->type,
+        .option = trig_complex_core->option,
+        .action = trig_complex_core->action,
+        .action_param = trig_complex_core->action_param,
+        .modified = trig_complex_core->modified,
+        .state_mask = trig_complex_core->state_mask,
+        .addr_start = unmarshal_mcd_addr(trig_complex_core->addr_start),
+        .addr_range = trig_complex_core->addr_range,
+        .data_start = trig_complex_core->data_start,
+        .data_range = trig_complex_core->data_range,
+        .data_mask = trig_complex_core->data_mask,
+        .data_size = trig_complex_core->data_size,
+        .hw_thread_id = trig_complex_core->hw_thread_id,
+        .sw_thread_id = trig_complex_core->sw_thread_id,
+        .core_mode_mask = trig_complex_core->core_mode_mask,
+    };
+
+    return unmarshal;
+}
+
+MCDTrigState *marshal_mcd_trig_state(const mcd_trig_state_st *trig_info)
+{
+    MCDTrigState *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTrigState) {
+        .active = trig_info->active,
+        .captured = trig_info->captured,
+        .captured_valid = trig_info->captured_valid,
+        .count_value = trig_info->count_value,
+        .count_valid = trig_info->count_valid,
+    };
+
+    return marshal;
+}
+
+MCDTrigSetState *marshal_mcd_trig_set_state(
+    const mcd_trig_set_state_st *trig_state)
+{
+    MCDTrigSetState *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTrigSetState) {
+        .active = trig_state->active,
+        .state = trig_state->state,
+        .state_valid = trig_state->state_valid,
+        .trig_bus = trig_state->trig_bus,
+        .trig_bus_valid = trig_state->trig_bus_valid,
+        .trace = trig_state->trace,
+        .trace_valid = trig_state->trace_valid,
+        .analysis = trig_state->analysis,
+        .analysis_valid = trig_state->analysis_valid,
+    };
+
+    return marshal;
+}
+
 MCDTx *marshal_mcd_tx(const mcd_tx_st *tx)
 {
     MCDTx *marshal = g_malloc0(sizeof(*marshal));
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
index 27bb945db5..133dfbf9d3 100644
--- a/mcd/libmcd_qapi.h
+++ b/mcd/libmcd_qapi.h
@@ -37,6 +37,21 @@ MCDRegisterInfo *marshal_mcd_register_info(
 
 MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state);
 
+MCDTrigInfo *marshal_mcd_trig_info(const mcd_trig_info_st *trig_info);
+
+MCDCtrigInfo *marshal_mcd_ctrig_info(const mcd_ctrig_info_st *trig_info);
+
+MCDTrigSimpleCore *marshal_mcd_trig_simple_core(
+    const mcd_trig_simple_core_st *trig_simple_core);
+
+MCDTrigComplexCore *marshal_mcd_trig_complex_core(
+    const mcd_trig_complex_core_st *trig_complex_core);
+
+MCDTrigState *marshal_mcd_trig_state(const mcd_trig_state_st *trig_info);
+
+MCDTrigSetState *marshal_mcd_trig_set_state(
+    const mcd_trig_set_state_st *trig_state);
+
 MCDTx *marshal_mcd_tx(const mcd_tx_st *tx);
 
 MCDTxlist *marshal_mcd_txlist(const mcd_txlist_st *txlist);
@@ -47,6 +62,12 @@ mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
 
 mcd_addr_st unmarshal_mcd_addr(MCDAddr *addr);
 
+mcd_trig_simple_core_st unmarshal_mcd_trig_simple_core(
+    MCDTrigSimpleCore *trig_simple_core);
+
+mcd_trig_complex_core_st unmarshal_mcd_trig_complex_core(
+    MCDTrigComplexCore *trig_complex_core);
+
 mcd_tx_st unmarshal_mcd_tx(MCDTx *tx);
 
 mcd_txlist_st unmarshal_mcd_txlist(MCDTxlist *txlist);
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index bdb4767060..649c4d387b 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -71,7 +71,10 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
  * @register_groups:         Register groups as queried by
  *                           mcd_qry_reg_groups_f().
  * @registers:               Registers as queried by mcd_qry_reg_map_f().
+ * @triggers:                Triggers as created in mcd_create_trig_f().
  * @vm_state_change_handler: State change handler.
+ * @num_created_triggers:    Total amount of created triggers since last
+ *                           mcd_open_server_f().
  *
  * MCD is mainly being used on the core level:
  * After the initial query functions, a core connection is opened in
@@ -91,6 +94,8 @@ typedef struct mcdcore_state {
     GArray *register_groups;
     GArray *registers;
     VMChangeStateEntry *vm_state_change_handler;
+    GArray *triggers;
+    uint32_t num_created_triggers;
 } mcdcore_state;
 
 /**
@@ -101,6 +106,8 @@ typedef struct mcdcore_state {
  * @open_server:  Open server instance as allocated in mcd_open_server_f().
  * @system_key:   System key as provided in mcd_open_server_f()
  * @cores:        Internal core information database.
+ * @bp_cpu:       CPU hitting the most recent break-/watchpoint.
+ * @bp_addr:      Address of the most recent break-/watchpoint.
  */
 typedef struct mcdserver_state {
     const mcd_error_info_st *last_error;
@@ -108,6 +115,8 @@ typedef struct mcdserver_state {
     mcd_server_st *open_server;
     char system_key[MCD_KEY_LEN];
     GArray *cores;
+    CPUState const *bp_cpu;
+    vaddr bp_addr;
 } mcdserver_state;
 
 static mcdserver_state g_server_state = {
@@ -115,8 +124,24 @@ static mcdserver_state g_server_state = {
     .open_server = NULL,
     .system_key = "",
     .cores = NULL,
+    .bp_cpu = NULL,
 };
 
+/**
+ * struct mcd_active_trigger - Identifiable active trigger
+ *
+ * @trig: Trigger instance as created in mcd_create_trig_f().
+ * @id:   Unique trigger identifier.
+ *
+ * Currently, only mcd_trig_simple_core_st is supported.
+ */
+typedef struct mcd_active_trigger {
+    mcd_trig_simple_core_st trig;
+    uint32_t id;
+    bool captured;
+} mcd_active_trigger;
+
+
 static mcdcore_state *find_core(const mcd_core_con_info_st *core_con_info)
 {
     uint32_t core_id;
@@ -140,6 +165,16 @@ static void mcd_handle_vm_state_change(void *opaque, bool running,
 {
     mcdcore_state *core_state = (mcdcore_state *)opaque;
     CPUState *cpu = core_state->cpu;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (state == RUN_STATE_DEBUG && cpu->watchpoint_hit) {
+        g_server_state.bp_cpu = cpu;
+        g_server_state.bp_addr = cpu->watchpoint_hit->vaddr;
+        cpu->watchpoint_hit = NULL;
+    } else if (cpu_breakpoint_test(cpu, cc->get_pc(cpu), BP_GDB)) {
+        g_server_state.bp_cpu = cpu;
+        g_server_state.bp_addr = cc->get_pc(cpu);
+    }
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
@@ -295,7 +330,9 @@ mcd_return_et mcd_open_server_f(const char *system_key,
                                            sizeof(mcd_register_group_st)),
             .registers = g_array_new(false, true,
                                      sizeof(mcd_register_info_st)),
+            .triggers = g_array_new(false, true, sizeof(mcd_active_trigger)),
             .vm_state_change_handler = NULL,
+            .num_created_triggers = 0,
         };
         pstrcpy(c.info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
         g_array_append_val(g_server_state.cores, c);
@@ -339,6 +376,7 @@ mcd_return_et mcd_close_server_f(const mcd_server_st *server)
         g_array_free(c->memory_spaces, true);
         g_array_free(c->register_groups, true);
         g_array_free(c->registers, true);
+        g_array_free(c->triggers, true);
     }
 
     g_array_free(g_server_state.cores, true);
@@ -682,6 +720,8 @@ mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
     core_state->last_error = &MCD_ERROR_NONE;
     core_state->vm_state_change_handler = qemu_add_vm_change_state_handler(
         mcd_handle_vm_state_change, core_state);
+    g_array_set_size(core_state->triggers, 0);
+    core_state->num_created_triggers = 0;
 
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
@@ -722,6 +762,8 @@ mcd_return_et mcd_close_core_f(const mcd_core_st *core)
     g_array_set_size(core_state->memory_spaces, 0);
     g_array_set_size(core_state->register_groups, 0);
     g_array_set_size(core_state->registers, 0);
+    g_array_set_size(core_state->triggers, 0);
+    core_state->num_created_triggers = 0;
 
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
@@ -1037,68 +1079,553 @@ mcd_return_et mcd_qry_reg_compound_f(const mcd_core_st *core,
 mcd_return_et mcd_qry_trig_info_f(const mcd_core_st *core,
                                   mcd_trig_info_st *trig_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!trig_info) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    *trig_info = (mcd_trig_info_st){
+        .type = MCD_TRIG_TYPE_IP |
+                MCD_TRIG_TYPE_READ |
+                MCD_TRIG_TYPE_WRITE |
+                MCD_TRIG_TYPE_RW,
+        .option = MCD_TRIG_OPT_DEFAULT,
+        .action = MCD_TRIG_ACTION_DBG_DEBUG,
+        .trig_number = 0,
+        .state_number = 0,
+        .counter_number = 0,
+        .sw_breakpoints = false,
+    };
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_ctrigs_f(const mcd_core_st *core, uint32_t start_index,
                                uint32_t *num_ctrigs,
                                mcd_ctrig_info_st *ctrig_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (!core || !num_ctrigs) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (*num_ctrigs == 0) {
+        core_state->last_error = &MCD_ERROR_NONE;
+        return core_state->last_error->return_status;
+    }
+
+    if (start_index > 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "custom triggers are currently not supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    *num_ctrigs = 0;
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
+}
+
+static mcd_return_et mcd_create_trig_simple_core(mcdcore_state *core_state,
+                                                 mcd_trig_simple_core_st *trig)
+{
+    uint32_t ms_id = trig->addr_start.mem_space_id;
+    const mcd_memspace_st *ms;
+    int ret_val;
+
+    /* memory space ID 0 is reserved */
+    if (ms_id == 0 || ms_id > core_state->memory_spaces->len) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown memory space ID",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    ms = &g_array_index(core_state->memory_spaces, mcd_memspace_st, ms_id - 1);
+    if (!(ms->mem_type & MCD_MEM_SPACE_IS_LOGICAL)) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "only logical trigger addresses are supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    switch (trig->type) {
+    case MCD_TRIG_TYPE_IP:
+        ret_val = cpu_breakpoint_insert(core_state->cpu,
+                                        trig->addr_start.address,
+                                        BP_GDB, NULL);
+        break;
+    case MCD_TRIG_TYPE_WRITE:
+        ret_val = cpu_watchpoint_insert(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_WRITE, NULL);
+        break;
+    case MCD_TRIG_TYPE_READ:
+        ret_val = cpu_watchpoint_insert(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_READ, NULL);
+        break;
+    case MCD_TRIG_TYPE_RW:
+        ret_val = cpu_watchpoint_insert(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_ACCESS, NULL);
+        break;
+    default:
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_CREATE,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown trigger type",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (ret_val != 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_CREATE,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger could not be created",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    return MCD_RET_ACT_NONE;
 }
 
 mcd_return_et mcd_create_trig_f(const mcd_core_st *core, void *trig,
                                 uint32_t *trig_id)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    uint32_t struct_size;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!trig || !trig_id) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    struct_size = *((uint32_t *)trig);
+    if (struct_size == (uint32_t) sizeof(mcd_trig_simple_core_st) ||
+        struct_size == (uint32_t) sizeof(mcd_trig_complex_core_st))
+    {
+        /* only trig_simple_cores are currently supported */
+        mcd_trig_simple_core_st *simple_trig = (mcd_trig_simple_core_st *)trig;
+
+        if (mcd_create_trig_simple_core(core_state, simple_trig) !=
+            MCD_RET_ACT_NONE) {
+            return core_state->last_error->return_status;
+        }
+
+        *trig_id = ++core_state->num_created_triggers;
+        mcd_active_trigger t = {
+            .trig = *simple_trig,
+            .id = *trig_id,
+            .captured = false,
+        };
+        g_array_append_val(core_state->triggers, t);
+    } else {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_CREATE,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger with struct_size not supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
+}
+
+/*
+ * find_trig() - Searches for a trigger with trig_id in the core-internal
+ *               trigger list. If found, the trigger as well as (optionally)
+ *               its index in the internal list are returned.
+ */
+static mcd_active_trigger *find_trig(mcdcore_state *core_state,
+                                     uint32_t trig_id,
+                                     uint32_t *trig_array_index)
+{
+    g_assert(core_state->triggers);
+    for (uint32_t i = 0; i < core_state->triggers->len; i++) {
+        mcd_active_trigger *t = &g_array_index(core_state->triggers,
+                                               mcd_active_trigger, i);
+        if (t->id == trig_id) {
+            if (trig_array_index) {
+                *trig_array_index = i;
+            }
+            return t;
+        }
+    }
+
+    return NULL;
 }
 
 mcd_return_et mcd_qry_trig_f(const mcd_core_st *core, uint32_t trig_id,
                              uint32_t max_trig_size, void *trig)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    mcd_active_trigger *active_trig;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (max_trig_size < sizeof(*active_trig)) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_RESULT_TOO_LONG,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (!trig) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    active_trig = find_trig(core_state, trig_id, NULL);
+    if (!active_trig) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_ACCESS,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger with trig_id not found",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    memcpy(trig, &active_trig->trig, sizeof(active_trig->trig));
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
+}
+
+static mcd_return_et mcd_remove_trig_simple_core(mcdcore_state *core_state,
+                                                 mcd_trig_simple_core_st *trig)
+{
+    int ret_val;
+
+    switch (trig->type) {
+    case MCD_TRIG_TYPE_IP:
+        ret_val = cpu_breakpoint_remove(core_state->cpu,
+                                    trig->addr_start.address,
+                                    BP_GDB);
+        break;
+    case MCD_TRIG_TYPE_WRITE:
+        ret_val = cpu_watchpoint_remove(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_WRITE);
+        break;
+    case MCD_TRIG_TYPE_READ:
+        ret_val = cpu_watchpoint_remove(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_READ);
+        break;
+    case MCD_TRIG_TYPE_RW:
+        ret_val = cpu_watchpoint_remove(core_state->cpu,
+                                        trig->addr_start.address, 4,
+                                        BP_GDB | BP_MEM_ACCESS);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (ret_val != 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_CREATE,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger could not be removed",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    return MCD_RET_ACT_NONE;
 }
 
 mcd_return_et mcd_remove_trig_f(const mcd_core_st *core, uint32_t trig_id)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    mcd_active_trigger *trig;
+    uint32_t trig_index;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    trig = find_trig(core_state, trig_id, &trig_index);
+    if (!trig) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_ACCESS,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger with trig_id not found",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (mcd_remove_trig_simple_core(core_state, &trig->trig)
+        != MCD_RET_ACT_NONE) {
+        return core_state->last_error->return_status;
+    }
+
+    g_array_remove_index(core_state->triggers, trig_index);
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_trig_state_f(const mcd_core_st *core, uint32_t trig_id,
                                    mcd_trig_state_st *trig_state)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    mcd_active_trigger *trig;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!trig_state) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    trig = find_trig(core_state, trig_id, NULL);
+    if (!trig) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TRIG_ACCESS,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "trigger with trig_id not found",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    /* triggers are always active */
+    *trig_state = (mcd_trig_state_st) {
+        .active = true,
+        .captured = trig->captured,
+        .captured_valid = true,
+        .count_valid = false,
+    };
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_activate_trig_set_f(const mcd_core_st *core)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    /* Triggers are already activated when being created */
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_remove_trig_set_f(const mcd_core_st *core)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    g_assert(core_state->triggers);
+
+    while (core_state->triggers->len > 0) {
+        uint32_t len = core_state->triggers->len;
+        mcd_active_trigger *trig = &g_array_index(core_state->triggers,
+                                                  mcd_active_trigger, 0);
+        if (mcd_remove_trig_f(core, trig->id) != MCD_RET_ACT_NONE) {
+            return core_state->last_error->return_status;
+        }
+        g_assert(core_state->triggers->len == len - 1);
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_trig_set_f(const mcd_core_st *core, uint32_t start_index,
                                  uint32_t *num_trigs, uint32_t *trig_ids)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    uint32_t i;
+    mcdcore_state *core_state;
+
+    if (!core || !num_trigs) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    g_assert(core_state->triggers);
+
+    if (*num_trigs == 0) {
+        *num_trigs = core_state->triggers->len;
+        core_state->last_error = &MCD_ERROR_NONE;
+        return core_state->last_error->return_status;
+    }
+
+    if (start_index >= core_state->triggers->len) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "start_index exceeds the number of triggers",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (!trig_ids) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    for (i = 0; i < *num_trigs &&
+         start_index + i < core_state->triggers->len; i++) {
+
+        mcd_active_trigger *t = &g_array_index(core_state->triggers,
+                                               mcd_active_trigger,
+                                               start_index + i);
+        trig_ids[i] = t->id;
+    }
+
+    *num_trigs = i;
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_trig_set_state_f(const mcd_core_st *core,
                                        mcd_trig_set_state_st *trig_state)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    mcdcore_state *core_state;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!trig_state) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    *trig_state = (mcd_trig_set_state_st) {
+        .active = true,
+        .state_valid = false,
+        .trig_bus_valid = false,
+        .trace_valid = false,
+        .analysis_valid = false,
+    };
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
@@ -1505,6 +2032,26 @@ mcd_return_et mcd_qry_state_f(const mcd_core_st *core, mcd_core_state_st *state)
         break;
     }
 
+    if (state->state == MCD_CORE_STATE_DEBUG && g_server_state.bp_cpu) {
+        if (g_server_state.bp_cpu == core_state->cpu) {
+            state->event = MCD_CORE_EVENT_TRIGGER_CHANGE;
+            GArray *trigs = core_state->triggers;
+            for (int i = 0; i < trigs->len; i++) {
+                mcd_active_trigger *t = &g_array_index(trigs,
+                                                       mcd_active_trigger, i);
+                if (g_server_state.bp_addr >= t->trig.addr_start.address
+                &&  g_server_state.bp_addr <= t->trig.addr_start.address
+                                            + t->trig.addr_range) {
+                    state->trig_id = t->id;
+                    t->captured = true;
+                }
+            }
+            g_server_state.bp_cpu = NULL;
+        } else {
+            state->state = MCD_CORE_STATE_HALTED;
+        }
+    }
+
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index 872fb7c9da..a1d5cbc5d9 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -621,3 +621,293 @@ MCDQryStateResult *qmp_mcd_qry_state(uint32_t core_uid, Error **errp)
     g_stub_state.on_error_ask_server = true;
     return result;
 }
+
+MCDQryTrigInfoResult *qmp_mcd_qry_trig_info(uint32_t core_uid, Error **errp)
+{
+    MCDQryTrigInfoResult *result = g_malloc0(sizeof(*result));
+    mcd_trig_info_st trig_info;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_trig_info_f(core, &trig_info);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->trig_info = marshal_mcd_trig_info(&trig_info);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryCtrigsResult *qmp_mcd_qry_ctrigs(uint32_t core_uid, uint32_t start_index,
+                                       uint32_t num_ctrigs, Error **errp)
+{
+    MCDCtrigInfoList **tailp;
+    MCDCtrigInfo *info;
+    MCDQryCtrigsResult *result = g_malloc0(sizeof(*result));
+    mcd_ctrig_info_st *ctrig_info = NULL;
+    bool query_num_only = num_ctrigs == 0;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    if (!query_num_only) {
+        ctrig_info = g_malloc0(num_ctrigs * sizeof(*ctrig_info));
+    }
+
+    result->return_status = mcd_qry_ctrigs_f(core, start_index, &num_ctrigs,
+                                             ctrig_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_ctrigs = true;
+        result->num_ctrigs = num_ctrigs;
+        if (!query_num_only) {
+            result->has_ctrig_info = true;
+            tailp = &(result->ctrig_info);
+            for (uint32_t i = 0; i < num_ctrigs; i++) {
+                info = marshal_mcd_ctrig_info(ctrig_info + i);
+                QAPI_LIST_APPEND(tailp, info);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(ctrig_info);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDCreateTrigResult *qmp_mcd_create_trig(uint32_t core_uid, MCDTrig *trig,
+                                         Error **errp)
+{
+    MCDCreateTrigResult *result = g_malloc0(sizeof(*result));
+    mcd_trig_simple_core_st trig_simple;
+    mcd_trig_complex_core_st trig_complex;
+    void *trig_p;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+
+    if (trig->trig_simple_core) {
+        trig_simple = unmarshal_mcd_trig_simple_core(trig->trig_simple_core);
+        trig_p = (void *) &trig_simple;
+    } else if (trig->trig_complex_core) {
+        trig_complex = unmarshal_mcd_trig_complex_core(trig->trig_complex_core);
+        trig_p = (void *) &trig_complex;
+    } else {
+        g_assert_not_reached();
+    }
+
+    uint32_t trig_id;
+    result->return_status = mcd_create_trig_f(core, trig_p, &trig_id);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_trig_id = true;
+        result->trig_id = trig_id;
+        result->trig = g_malloc0(sizeof(*result->trig));
+        if (trig_p == &trig_simple) {
+            result->trig->trig_simple_core =
+                marshal_mcd_trig_simple_core(&trig_simple);
+            result->trig->trig_complex_core = NULL;
+        } else if (trig_p == &trig_complex) {
+            result->trig->trig_complex_core =
+                marshal_mcd_trig_complex_core(&trig_complex);
+            result->trig->trig_simple_core = NULL;
+        } else {
+            g_assert_not_reached();
+        }
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryTrigResult *qmp_mcd_qry_trig(uint32_t core_uid, uint32_t trig_id,
+                                   Error **errp)
+{
+    MCDQryTrigResult *result = g_malloc0(sizeof(*result));
+    /* Currently, only trig simple and complex cores are supported */
+    mcd_trig_complex_core_st trig;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_trig_f(core, trig_id, sizeof(trig), &trig);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->trig = g_malloc0(sizeof(*result->trig));
+        if (trig.struct_size == sizeof(mcd_trig_complex_core_st)) {
+            result->trig->trig_complex_core =
+                marshal_mcd_trig_complex_core(&trig);
+        } else if (trig.struct_size == sizeof(mcd_trig_simple_core_st)) {
+            mcd_trig_simple_core_st *trig_simple =
+                (mcd_trig_simple_core_st *) &trig;
+            result->trig->trig_simple_core =
+                marshal_mcd_trig_simple_core(trig_simple);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDRemoveTrigResult *qmp_mcd_remove_trig(uint32_t core_uid, uint32_t trig_id,
+                                         Error **errp)
+{
+    MCDRemoveTrigResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_remove_trig_f(core, trig_id);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryTrigStateResult *qmp_mcd_qry_trig_state(uint32_t core_uid,
+                                              uint32_t trig_id, Error **errp)
+{
+    MCDQryTrigStateResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    mcd_trig_state_st trig_state;
+    result->return_status = mcd_qry_trig_state_f(core, trig_id, &trig_state);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->trig_state = marshal_mcd_trig_state(&trig_state);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDActivateTrigSetResult *qmp_mcd_activate_trig_set(uint32_t core_uid,
+                                                    Error **errp)
+{
+    MCDActivateTrigSetResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_activate_trig_set_f(core);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDActivateTrigSetResult *qmp_mcd_remove_trig_set(uint32_t core_uid,
+                                                  Error **errp)
+{
+    MCDActivateTrigSetResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_remove_trig_set_f(core);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryTrigSetResult *qmp_mcd_qry_trig_set(uint32_t core_uid,
+                                          uint32_t start_index,
+                                          uint32_t num_trigs, Error **errp)
+{
+    uint32List **tailp;
+    MCDQryTrigSetResult *result = g_malloc0(sizeof(*result));
+    uint32_t *trig_ids = NULL;
+    bool query_num_only = num_trigs == 0;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    if (!query_num_only) {
+        trig_ids = g_malloc0(num_trigs * sizeof(*trig_ids));
+    }
+
+    result->return_status = mcd_qry_trig_set_f(core, start_index, &num_trigs,
+                                               trig_ids);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_trigs = true;
+        result->num_trigs = num_trigs;
+        if (!query_num_only) {
+            result->has_trig_ids = true;
+            tailp = &(result->trig_ids);
+            for (uint32_t i = 0; i < num_trigs; i++) {
+                QAPI_LIST_APPEND(tailp, trig_ids[i]);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(trig_ids);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryTrigSetStateResult *qmp_mcd_qry_trig_set_state(uint32_t core_uid,
+                                                     Error **errp)
+{
+    MCDQryTrigSetStateResult *result = g_malloc0(sizeof(*result));
+    mcd_trig_set_state_st trig_state;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_trig_set_state_f(core, &trig_state);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->trig_state = marshal_mcd_trig_set_state(&trig_state);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
diff --git a/qapi/mcd.json b/qapi/mcd.json
index b4f21995e3..8934d2d057 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -306,6 +306,238 @@
     'reg-type'            : 'uint32',
     'hw-thread-id'        : 'uint32' } }
 
+
+##
+# @MCDTrigInfo:
+#
+# Structure type containing information about trigger capabilities.
+#
+# @type:           Supported trigger types (OR'ed bitmask).
+# @option:         Supported trigger options (OR'ed bitmask).
+# @action:         Supported trigger actions (OR'ed bitmask).
+# @trig-number:    Number of usable triggers (or 0 if number not known).
+# @state-number:   Number of states of the trigger set's state machine (or 0 if
+#                  not known).
+# @counter-number: Number of usable counters (or 0 if not known)
+# @sw-breakpoints: True if software breakpoints via code patch are available.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrigInfo',
+  'data': {
+      'type'          : 'uint32',
+      'option'        : 'uint32',
+      'action'        : 'uint32',
+      'trig-number'   : 'uint32',
+      'state-number'  : 'uint32',
+      'counter-number': 'uint32',
+      'sw-breakpoints': 'bool' } }
+
+
+##
+# @MCDCtrigInfo:
+#
+# Structure type containing information about a custom trigger.
+#
+# @ctrig-id: Custom trigger ID, ID 0 is reserved.
+# @info-str: Description of the custom trigger.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCtrigInfo',
+  'data': {
+    'ctrig-id': 'uint32',
+    'info-str': 'str' } }
+
+
+##
+# @MCDTrigSimpleCore:
+#
+# Structure type containing information about a simple core trigger condition.
+#
+# @type:           Trigger type, for this structure type it must be one of:
+#                  - %MCD_TRIG_TYPE_IP
+#                  - %MCD_TRIG_TYPE_READ
+#                  - %MCD_TRIG_TYPE_WRITE
+#                  - %MCD_TRIG_TYPE_RW
+#                  - %MCD_TRIG_TYPE_NOCYCLE
+# @option:         Adds further qualifiers to the trigger or overrides the
+#                  behaviour (multiple options possible)
+# @action:         Action to be taken on trigger. Only one per trigger allowed.
+# @action-param:   Parameter for action - depends on the selected action.
+# @modified:       Set to "TRUE" on return of @mcd-create-trig if trigger
+#                  was modified by implementation, untouched otherwise.
+# @state-mask:     Set bits indicate that this trigger is inactive when
+#                  reaching the corresponding state of the state machine. Bit 0
+#                  represents state '1' of the state machine. Only to be
+#                  considered if %MCD_TRIG_OPT_STATE_IS_CONDITION is set in
+#                  @option.
+# @addr-start:     Start address for the address range the trigger shall be
+#                  activated for.
+# @addr-range:     Size of the address range for the trigger (in bytes). If it
+#                  is set to '0', the trigger is activated by an access to a
+#                  single address. If it is set to '1', the range of addresses
+#                  is two (@addr_start + 1). The address range can be
+#                  "inverted" if %MCD_TRIG_OPT_OUT_OF_RANGE is set in @option.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrigSimpleCore',
+  'data': {
+  'type'        : 'uint32',
+  'option'      : 'uint32',
+  'action'      : 'uint32',
+  'action-param': 'uint32',
+  'modified'    : 'bool',
+  'state-mask'  : 'uint32',
+  'addr-start'  : 'MCDAddr',
+  'addr-range'  : 'uint64' }}
+
+
+##
+# @MCDTrigComplexCore:
+#
+# Structure type containing information about a complex core trigger condition.
+#
+# @type:           Trigger type, for this structure type it must be one of:
+#                  - %MCD_TRIG_TYPE_IP
+#                  - %MCD_TRIG_TYPE_READ
+#                  - %MCD_TRIG_TYPE_WRITE
+#                  - %MCD_TRIG_TYPE_RW
+#                  - %MCD_TRIG_TYPE_NOCYCLE
+# @option:         Adds further qualifiers to the trigger or overrides the
+#                  behaviour (multiple options possible)
+# @action:         Action to be taken on trigger. Only one per trigger allowed.
+# @action-param:   Parameter for action - depends on the selected action.
+# @modified:       Set to "TRUE" on return of @mcd-create-trig if trigger
+#                  was modified by implementation, untouched otherwise.
+# @state-mask:     Set bits indicate that this trigger is inactive when
+#                  reaching the corresponding state of the state machine. Bit 0
+#                  represents state '1' of the state machine. Only to be
+#                  considered if %MCD_TRIG_OPT_STATE_IS_CONDITION is set in
+#                  @option.
+# @addr-start:     Start address for the address range the trigger shall be
+#                  activated for.
+# @addr-range:     Size of the address range for the trigger (in bytes). If it
+#                  is set to '0', the trigger is activated by an access to a
+#                  single address. If it is set to '1', the range of addresses
+#                  is two (@addr_start + 1). The address range can be
+#                  "inverted" if %MCD_TRIG_OPT_OUT_OF_RANGE is set in @option.
+# @data-start:     Data comparison value of the trigger. Only considered if
+#                  %MCD_TRIG_OPT_DATA_IS_CONDITION is set in @option. Setting
+#                  option %MCD_TRIG_OPT_NOT_DATA activates the trigger on a
+#                  data mismatch.
+# @data-range:     Size of the data value range for the trigger. If it is set
+#                  to '0', the trigger is activated on a match with a single
+#                  value. If it is set to '1', the range of values is two
+#                  (@data_range + 1). Option %MCD_TRIG_OPT_SIGNED_DATA may be
+#                  set in @option if the data shall be interpreted as signed.
+#                  This usually also requires the option
+#                  %MCD_TRIG_OPT_DATASIZE_IS_CONDITION to be set in @option.
+# @data-mask:      Only value bits are considered for which the mask is set to
+#                  '0'
+# @data-size:      Size of the access in bytes. If set to '0' the size shall
+#                  not be considered. Shall be only considered if
+#                  %MCD_TRIG_OPT_DATASIZE_IS_CONDITION is set in @option.
+# @hw-thread-id:   ID of the hardware thread this trigger is associated with.
+# @sw-thread-id:   ID of the software thread this trigger is associated with.
+# @core-mode-mask: Mask of core modes for which the trigger shall not be
+#                  activated. A set bit disables the trigger for the
+#                  corresponding mode. Bit 0 represents core mode '1', bit 31
+#                  represents core mode '32'.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrigComplexCore',
+  'data': {
+    'type'          : 'uint32',
+    'option'        : 'uint32',
+    'action'        : 'uint32',
+    'action-param'  : 'uint32',
+    'modified'      : 'bool',
+    'state-mask'    : 'uint32',
+    'addr-start'    : 'MCDAddr',
+    'addr-range'    : 'uint64',
+    'data-start'    : 'uint64',
+    'data-range'    : 'uint64',
+    'data-mask'     : 'uint64',
+    'data-size'     : 'uint32',
+    'hw-thread-id'  : 'uint32',
+    'sw-thread-id'  : 'uint64',
+    'core-mode-mask': 'uint32' }}
+
+
+##
+# @MCDTrig:
+#
+# Compound structure which can be set to every supported trigger type.
+# Only one member is supposed to be set at once.
+#
+# @trig-simple-core:  Simple core trigger condition.
+# @trig-complex-core: Complex core trigger condition.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrig',
+  'data': {
+    '*trig-simple-core':  'MCDTrigSimpleCore',
+    '*trig-complex-core': 'MCDTrigComplexCore' } }
+
+
+##
+# @MCDTrigState:
+#
+# Structure type containing a trigger state.
+#
+# @active:         Was active at the point of time the trigger set was
+#                  uploaded.
+# @captured:       Activated at least once after trigger got downloaded to the
+#                  target.
+# @captured-valid: The information in @captured is valid.
+# @count-value:    Current value of the counter (for counter triggers).
+# @count-valid:    The information in @count-value is valid.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrigState',
+  'data': {
+     'active'        : 'bool',
+     'captured'      : 'bool',
+     'captured-valid': 'bool',
+     'count-value'   : 'uint64',
+     'count-valid'   : 'bool' } }
+
+
+##
+# @MCDTrigSetState:
+#
+# Structure type containing a trigger state.
+#
+# @active: Set if the trigger set is currently active.
+# @state: Current state of the trigger set's state machine.
+# @state-valid: Current state is valid.
+# @trig-bus: Current state of trigger bus.
+# @trig-bus-valid: Current state of trig-bus is valid.
+# @trace: Current state of trace start/stop.
+# @trace-valid: Current state is valid.
+# @analysis: Current state of performance analysis start/stop.
+# @analysis-valid: Current state is valid.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTrigSetState',
+  'data': {
+    'active'        : 'bool',
+    'state'         : 'uint32',
+    'state-valid'   : 'bool',
+    'trig-bus'      : 'uint32',
+    'trig-bus-valid': 'bool',
+    'trace'         : 'bool',
+    'trace-valid'   : 'bool',
+    'analysis'      : 'bool',
+    'analysis-valid': 'bool' } }
+
+
 ##
 # @MCDTx:
 #
@@ -1647,3 +1879,359 @@
 { 'command': 'mcd-qry-state',
   'data': { 'core-uid': 'uint32' },
   'returns': 'MCDQryStateResult' }
+
+
+##
+# == Target Trigger Setup API
+##
+
+
+##
+# @MCDQryTrigInfoResult:
+#
+# Return value of @mcd-qry-trig-info.
+#
+# @return-status: Return code.
+# @trig-info:     Information about supported triggers.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryTrigInfoResult',
+  'data': {
+    'return-status': 'uint32',
+    '*trig-info'   : 'MCDTrigInfo' }}
+
+
+##
+# @mcd-qry-trig-info:
+#
+# Function querying information about trigger capabilities.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDQryTrigInfoResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-trig-info',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDQryTrigInfoResult' }
+
+
+##
+# @MCDQryCtrigsResult:
+#
+# Return value of @mcd-qry-ctrigs.
+#
+# @return-status: Return code.
+# @num-ctrigs:    Number of returned custom triggers. In case the input value of
+#                 @num_ctrigs is '0', this is the number of all available custom
+#                 triggers for the selected core.
+# @ctrig-info:    Custom trigger information.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryCtrigsResult',
+  'data': {
+    'return-status': 'uint32',
+    '*num-ctrigs'  : 'uint32',
+    '*ctrig-info'  : [ 'MCDCtrigInfo' ] }}
+
+
+##
+# @mcd-qry-ctrigs:
+#
+# Function querying information about custom triggers.
+#
+# @core-uid:    Unique identifier of the open core as returned by
+#               @mcd-open-core.
+# @start-index: Start index of the requested custom triggers. This refers
+#               to an internal list of the target side implementation.
+# @num-ctrigs:  Number of custom triggers, information is requested of. If it is
+#               set to '0', no custom trigger information is returned but the
+#               number of all available custom triggers for the selected core.
+#
+# Returns: @MCDQryCtrigsResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-ctrigs',
+  'data': {
+    'core-uid'   : 'uint32',
+    'start-index': 'uint32',
+    'num-ctrigs' : 'uint32' },
+  'returns': 'MCDQryCtrigsResult' }
+
+
+##
+# @MCDCreateTrigResult:
+#
+# Return value of @mcd-create-trig.
+#
+# @return-status: Return code.
+# @trig:          Information about the created trigger object.
+# @trig-id:       Unique ID for the newly created trigger returned by the API
+#                 implementation. A value of '0' indicates that the breakpoint
+#                 is set, but cannot be identified by an ID. Removing such
+#                 breakpoints is only possible by calling @mcd-remove-trig-set.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCreateTrigResult',
+  'data': {
+    'return-status': 'uint32',
+    '*trig'        : 'MCDTrig',
+    '*trig-id'     : 'uint32' }}
+
+
+##
+# @mcd-create-trig:
+#
+# Function allowing the creation of a new trigger.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @trig:     Information about the trigger object to be created.
+#
+# Returns: @MCDCreateTrigResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-create-trig',
+  'data': {
+    'core-uid': 'uint32',
+    'trig'    : 'MCDTrig' },
+  'returns': 'MCDCreateTrigResult' }
+
+
+##
+# @MCDQryTrigResult:
+#
+# Return value of @mcd-qry-trig.
+#
+# @return-status: Return code.
+# @trig:          Information about the trigger object.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryTrigResult',
+  'data': {
+    'return-status': 'uint32',
+    '*trig'        : 'MCDTrig' }}
+
+
+##
+# @mcd-qry-trig:
+#
+# Function querying the contents of a trigger.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @trig-id:  ID of the trigger the user queries.
+#
+# Returns: @MCDQryTrigResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-trig',
+  'data': {
+    'core-uid': 'uint32',
+    'trig-id' : 'uint32'},
+  'returns': 'MCDQryTrigResult' }
+
+
+##
+# @MCDRemoveTrigResult:
+#
+# Return value of @mcd-remove-trig.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRemoveTrigResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-remove-trig:
+#
+# Function allowing a user to delete a particular trigger from a trigger set.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @trig-id:  ID of the trigger the user wants to delete.
+#
+# Returns: @MCDRemoveTrigResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-remove-trig',
+  'data': {
+    'core-uid': 'uint32',
+    'trig-id' : 'uint32' },
+  'returns': 'MCDRemoveTrigResult' }
+
+
+##
+# @MCDQryTrigStateResult:
+#
+# Return value of @mcd-qry-trig-state.
+#
+# @return-status: Return code.
+# @trig-state:    Queried Trigger state.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryTrigStateResult',
+  'data': {
+    'return-status': 'uint32',
+    '*trig-state'  : 'MCDTrigState' }}
+
+
+##
+# @mcd-qry-trig-state:
+#
+# Function allowing a user to query the trigger states from the target.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @trig-id:  ID of the trigger, the tool queries the state for.
+#
+# Returns: @MCDQryTrigStateResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-trig-state',
+  'data': {
+    'core-uid': 'uint32',
+    'trig-id' : 'uint32' },
+  'returns': 'MCDQryTrigStateResult' }
+
+
+##
+# @MCDActivateTrigSetResult:
+#
+# Return value of @mcd-activate-trig-set.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDActivateTrigSetResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-activate-trig-set:
+#
+# Function allowing a user to activate a trigger set on the target.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDActivateTrigSetResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-activate-trig-set',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDActivateTrigSetResult' }
+
+
+##
+# @MCDRemoveTrigSetResult:
+#
+# Return value of @mcd-remove-trig-set.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRemoveTrigSetResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-remove-trig-set:
+#
+# Function allowing a user to delete a trigger set.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDActivateTrigSetResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-remove-trig-set',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDActivateTrigSetResult' }
+
+
+##
+# @MCDQryTrigSetResult:
+#
+# Return value of @mcd-qry-trig-set.
+#
+# @return-status: Return code.
+# @num-trigs:     The number of returned triggers. In case the input value of
+#                 @num_trigs is '0', this is the number of all available triggers
+#                 of this core's trigger set.
+# @trig-ids:      List of trigger IDs set in the target.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryTrigSetResult',
+  'data': {
+    'return-status': 'uint32',
+    '*num-trigs'   : 'uint32',
+    '*trig-ids'    : [ 'uint32' ] }}
+
+
+##
+# @mcd-qry-trig-set:
+#
+# Function querying the contents of a trigger set.
+#
+# @core-uid:    Unique identifier of the open core as returned by
+#               @mcd-open-core.
+# @start-index: Start index of the requested triggers. This refers to an
+#               internal list of the target side implementation.
+# @num-trigs:   The number of queried triggers starting from the defined
+#               @start-index. If it is set to '0', no triggers are returned but
+#               the number of all available triggers of the trigger set.
+#
+# Returns: @MCDQryTrigSetResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-trig-set',
+  'data': {
+      'core-uid'   : 'uint32',
+      'start-index': 'uint32',
+      'num-trigs'  : 'uint32' },
+  'returns': 'MCDQryTrigSetResult' }
+
+
+##
+# @MCDQryTrigSetStateResult:
+#
+# Return value of @mcd-qry-trig-set-state.
+#
+# @return-status: Return code.
+# @trig-state:    Information about the current state of the trigger set.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryTrigSetStateResult',
+  'data': {
+    'return-status': 'uint32',
+    '*trig-state'  : 'MCDTrigSetState' }}
+
+
+##
+# @mcd-qry-trig-set-state:
+#
+# Function querying the state of a trigger set.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDQryTrigSetStateResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-trig-set-state',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDQryTrigSetStateResult' }
-- 
2.34.1


