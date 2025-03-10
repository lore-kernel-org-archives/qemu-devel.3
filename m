Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F819C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trenW-0002GP-EX; Mon, 10 Mar 2025 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren4-00026v-2C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:38 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremz-0007i7-Tz
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:37 -0400
Received: (qmail 30940 invoked by uid 484); 10 Mar 2025 15:11:13 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012684 secs); 10 Mar 2025 15:11:13 -0000
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
Subject: [PATCH 14/16] mcd: Implement single stepping
Date: Mon, 10 Mar 2025 16:05:08 +0100
Message-Id: <20250310150510.200607-15-mario.fleischmann@lauterbach.com>
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

gdbstub: abort gdb_set_stop_cpu when step is issued by mcdserver
Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 gdbstub/gdbstub.c  |   6 ++-
 mcd/mcdserver.c    | 115 +++++++++++++++++++++++++++++++++++++++++----
 mcd/mcdstub_qapi.c |  17 +++++++
 qapi/mcd.json      |  38 ++++++++++++++-
 4 files changed, 164 insertions(+), 12 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 830854ef72..3821ebc0ba 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -226,6 +226,10 @@ GDBProcess *gdb_get_process(uint32_t pid)
 
 static GDBProcess *gdb_get_cpu_process(CPUState *cpu)
 {
+    if (!gdbserver_state.processes) {
+        return NULL;
+    }
+
     return gdb_get_process(gdb_get_cpu_pid(cpu));
 }
 
@@ -2272,7 +2276,7 @@ void gdb_set_stop_cpu(CPUState *cpu)
 {
     GDBProcess *p = gdb_get_cpu_process(cpu);
 
-    if (!p->attached) {
+    if (!p || !p->attached) {
         /*
          * Having a stop CPU corresponding to a process that is not attached
          * confuses GDB. So we ignore the request.
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index 837c0276e7..bdb4767060 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -59,14 +59,19 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
 /**
  * struct mcdcore_state - State of a core.
  *
- * @last_error:      Error info of most recent executed core-related function.
- * @custom_error:    Reserves memory for custom MCD errors.
- * @info:            Core connection information.
- * @open_core:       Open core instance as allocated in mcd_open_core_f().
- * @cpu:             QEMU's internal CPU handle.
- * @memory_spaces:   Memory spaces as queried by mcd_qry_mem_spaces_f().
- * @register_groups: Register groups as queried by mcd_qry_reg_groups_f().
- * @registers:       Registers as queried by mcd_qry_reg_map_f().
+ * @last_error:              Error info of most recent executed core-related
+ *                           function.
+ * @custom_error:            Reserves memory for custom MCD errors.
+ * @info:                    Core connection information.
+ * @open_core:               Open core instance as allocated in
+ *                           mcd_open_core_f().
+ * @cpu:                     QEMU's internal CPU handle.
+ * @memory_spaces:           Memory spaces as queried by
+ *                           mcd_qry_mem_spaces_f().
+ * @register_groups:         Register groups as queried by
+ *                           mcd_qry_reg_groups_f().
+ * @registers:               Registers as queried by mcd_qry_reg_map_f().
+ * @vm_state_change_handler: State change handler.
  *
  * MCD is mainly being used on the core level:
  * After the initial query functions, a core connection is opened in
@@ -85,6 +90,7 @@ typedef struct mcdcore_state {
     GArray *memory_spaces;
     GArray *register_groups;
     GArray *registers;
+    VMChangeStateEntry *vm_state_change_handler;
 } mcdcore_state;
 
 /**
@@ -129,6 +135,16 @@ static mcdcore_state *find_core(const mcd_core_con_info_st *core_con_info)
     return core;
 }
 
+static void mcd_handle_vm_state_change(void *opaque, bool running,
+                                       RunState state)
+{
+    mcdcore_state *core_state = (mcdcore_state *)opaque;
+    CPUState *cpu = core_state->cpu;
+
+    /* disable single step if it was enabled */
+    cpu_single_step(cpu, 0);
+}
+
 mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
                                mcd_impl_version_info_st *impl_info)
 {
@@ -279,6 +295,7 @@ mcd_return_et mcd_open_server_f(const char *system_key,
                                            sizeof(mcd_register_group_st)),
             .registers = g_array_new(false, true,
                                      sizeof(mcd_register_info_st)),
+            .vm_state_change_handler = NULL,
         };
         pstrcpy(c.info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
         g_array_append_val(g_server_state.cores, c);
@@ -663,6 +680,8 @@ mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
     (*core)->instance = NULL;
     core_state->open_core = *core;
     core_state->last_error = &MCD_ERROR_NONE;
+    core_state->vm_state_change_handler = qemu_add_vm_change_state_handler(
+        mcd_handle_vm_state_change, core_state);
 
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
@@ -694,6 +713,8 @@ mcd_return_et mcd_close_core_f(const mcd_core_st *core)
         return g_server_state.last_error->return_status;
     }
 
+    qemu_del_vm_change_state_handler(core_state->vm_state_change_handler);
+    core_state->vm_state_change_handler = NULL;
     g_free((void *)core->core_con_info);
     g_free((void *)core);
     core_state->open_core = NULL;
@@ -1329,8 +1350,82 @@ mcd_return_et mcd_qry_current_time_f(const mcd_core_st *core,
 mcd_return_et mcd_step_f(const mcd_core_st *core, bool global,
                          mcd_core_step_type_et step_type, uint32_t n_steps)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    int supported_step_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
+
+    if (global) {
+        g_server_state.custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_FN_UNIMPLEMENTED,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "global step not implemented",
+        };
+        g_server_state.last_error = &g_server_state.custom_error;
+        return g_server_state.last_error->return_status;
+    }
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
+    if (n_steps != 1) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "only single step supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (runstate_needs_reset()) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_GENERAL,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "internal error: runstate needs reset",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (vm_prepare_start(true) != 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_GENERAL,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "internal error: vm_prepare_start failed",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (step_type != MCD_CORE_STEP_TYPE_INSTR) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "step type not supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    supported_step_flags &= accel_supported_gdbstub_sstep_flags();
+    cpu_single_step(core_state->cpu, supported_step_flags);
+    cpu_resume(core_state->cpu);
+    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_set_global_f(const mcd_core_st *core, bool enable)
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index 724b7ff7ea..872fb7c9da 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -566,6 +566,23 @@ MCDStopResult *qmp_mcd_stop(uint32_t core_uid, bool global, Error **errp)
     return result;
 }
 
+MCDStepResult *qmp_mcd_step(uint32_t core_uid, bool global, uint32_t step_type,
+                            uint32_t n_steps, Error **errp)
+{
+    MCDStepResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+    result->return_status = mcd_step_f(core, global, step_type, n_steps);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
 MCDSetGlobalResult *qmp_mcd_set_global(uint32_t core_uid, bool enable,
                                        Error **errp)
 {
diff --git a/qapi/mcd.json b/qapi/mcd.json
index fabb3eea89..b4f21995e3 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -1549,6 +1549,43 @@
     'global'  : 'bool' },
   'returns': 'MCDStopResult' }
 
+
+##
+# @MCDStepResult:
+#
+# Return value of @mcd-step.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDStepResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-step:
+#
+# Function stepping a target core based on the particular step type.
+#
+# @core-uid:  Unique identifier of the open core as returned by @mcd-open-core.
+# @global:    Set to "TRUE" if all cores of a system shall start
+#             execution. Otherwise, starting execution of selected core only.
+# @step-type: The unit, the stepping of the target core is based on.
+# @n-steps:   The number of steps, the target core is stepped for.
+#
+# Returns: @MCDStepResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-step',
+  'data': {
+    'core-uid' : 'uint32',
+    'global'   : 'bool',
+    'step-type': 'uint32',
+    'n-steps'  : 'uint32' },
+  'returns': 'MCDStepResult' }
+
+
 ##
 # @MCDSetGlobalResult:
 #
@@ -1580,7 +1617,6 @@
     'enable'  : 'bool' },
   'returns': 'MCDSetGlobalResult' }
 
-
 ##
 # @MCDQryStateResult:
 #
-- 
2.34.1


