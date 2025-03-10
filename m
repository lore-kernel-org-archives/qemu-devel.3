Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F72C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trenW-0002GM-Ea; Mon, 10 Mar 2025 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren3-00026Z-Qo
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:37 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremy-0007hx-Do
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:37 -0400
Received: (qmail 30868 invoked by uid 484); 10 Mar 2025 15:11:12 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012867 secs); 10 Mar 2025 15:11:12 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:12 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/16] mcd test: Implement core state query
Date: Mon, 10 Mar 2025 16:05:05 +0100
Message-Id: <20250310150510.200607-12-mario.fleischmann@lauterbach.com>
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

Depending on the VM and CPU state, core states can be queried:

* MCD_CORE_STATE_DEBUG:   VM halted or CPU artifically stopped
* MCD_CORE_STATE_RUNNING: VM and CPU running
* MCD_CORE_STATE_HALTED:  CPU suspended

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/libmcd_qapi.c         |  16 +++++
 mcd/libmcd_qapi.h         |   2 +
 mcd/mcdserver.c           |  48 ++++++++++++++-
 mcd/mcdstub_qapi.c        |  21 +++++++
 qapi/mcd.json             |  55 +++++++++++++++++
 tests/qtest/libmcd-test.c |  59 +++++++++++++++++++
 tests/qtest/libmcd-test.h |   9 +++
 tests/qtest/mcd-test.c    | 120 +++++++++++++++++++++++++++++++++++++-
 8 files changed, 328 insertions(+), 2 deletions(-)

diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
index 99177b2fd2..44fc9bd6b4 100644
--- a/mcd/libmcd_qapi.c
+++ b/mcd/libmcd_qapi.c
@@ -195,3 +195,19 @@ MCDRegisterInfo *marshal_mcd_register_info(const mcd_register_info_st *reg_info)
 
     return marshal;
 }
+
+MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state)
+{
+    MCDCoreState *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDCoreState) {
+        .state = state->state,
+        .event = state->event,
+        .hw_thread_id = state->hw_thread_id,
+        .trig_id = state->trig_id,
+        .stop_str = g_strdup(state->stop_str),
+        .info_str = g_strdup(state->info_str),
+    };
+
+    return marshal;
+}
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
index edcc6d0b7c..7d68d60f02 100644
--- a/mcd/libmcd_qapi.h
+++ b/mcd/libmcd_qapi.h
@@ -35,6 +35,8 @@ MCDAddr *marshal_mcd_addr(const mcd_addr_st *addr);
 MCDRegisterInfo *marshal_mcd_register_info(
     const mcd_register_info_st *reg_info);
 
+MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
 mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index 9e46ea5fa5..116fbfaa30 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -16,6 +16,7 @@
 #include "exec/gdbstub.h"
 #include "hw/core/cpu.h"
 #include "system/runstate.h"
+#include "system/hw_accel.h"
 
 /* Custom memory space type */
 static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
@@ -1192,7 +1193,52 @@ mcd_return_et mcd_set_global_f(const mcd_core_st *core, bool enable)
 
 mcd_return_et mcd_qry_state_f(const mcd_core_st *core, mcd_core_state_st *state)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    mcdcore_state *core_state;
+    RunState rs;
+
+    if (!core || !state) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    *state = (mcd_core_state_st) {
+        .stop_str = "",
+        .info_str = "",
+    };
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    cpu_synchronize_state(core_state->cpu);
+    rs = runstate_get();
+    switch (rs) {
+    case RUN_STATE_PRELAUNCH:
+    case RUN_STATE_DEBUG:
+    case RUN_STATE_PAUSED:
+        state->state = MCD_CORE_STATE_DEBUG;
+        pstrcpy(state->stop_str, MCD_INFO_STR_LEN, "RUN_STATE_PAUSED");
+        break;
+    case RUN_STATE_RUNNING:
+        if (core_state->cpu->running) {
+            state->state = MCD_CORE_STATE_RUNNING;
+        } else if (core_state->cpu->stopped) {
+            state->state = MCD_CORE_STATE_DEBUG;
+        } else if (core_state->cpu->halted) {
+            state->state = MCD_CORE_STATE_HALTED;
+            pstrcpy(state->info_str, MCD_INFO_STR_LEN, "halted");
+        } else {
+            state->state = MCD_CORE_STATE_UNKNOWN;
+        }
+        break;
+    default:
+        state->state = MCD_CORE_STATE_UNKNOWN;
+        break;
+    }
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index 635f95181b..e1bde14b47 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -557,3 +557,24 @@ MCDSetGlobalResult *qmp_mcd_set_global(uint32_t core_uid, bool enable,
     g_stub_state.on_error_ask_server = true;
     return result;
 }
+
+MCDQryStateResult *qmp_mcd_qry_state(uint32_t core_uid, Error **errp)
+{
+    MCDQryStateResult *result = g_malloc0(sizeof(*result));
+    mcd_core_state_st state;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_state_f(core, &state);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->state = marshal_mcd_core_state(&state);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
diff --git a/qapi/mcd.json b/qapi/mcd.json
index c8b82e7f82..3560658451 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -307,6 +307,29 @@
     'hw-thread-id'        : 'uint32' } }
 
 
+##
+# @MCDCoreState:
+#
+# Structure type containing the state of a core.
+#
+# @state:        Core state.
+# @event:        Core events (OR'ed bitmask)
+# @hw-thread-id: ID of the hardware thread that caused the core to stop.
+# @trig-id:      ID of the trigger that caused the core to stop.
+# @stop-str:     Detailed description of a special stop reason.
+# @info-str:     Detailed description of the core state.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCoreState',
+  'data': {
+    'state'       : 'uint32',
+    'event'       : 'uint32',
+    'hw-thread-id': 'uint32',
+    'trig-id'     : 'uint32',
+    'stop-str'    : 'str',
+    'info-str'    : 'str' } }
+
 ##
 # == Target Initialization API
 ##
@@ -1473,3 +1496,35 @@
     'core-uid': 'uint32',
     'enable'  : 'bool' },
   'returns': 'MCDSetGlobalResult' }
+
+
+##
+# @MCDQryStateResult:
+#
+# Return value of @mcd-qry-state.
+#
+# @return-status: Return code.
+# @state:         The current execution state of the target core.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryStateResult',
+  'data': {
+    'return-status': 'uint32',
+    '*state': 'MCDCoreState' }}
+
+
+##
+# @mcd-qry-state:
+#
+# Function querying the execution state of a target core.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDQryStateResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-state',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDQryStateResult' }
diff --git a/tests/qtest/libmcd-test.c b/tests/qtest/libmcd-test.c
index 82a39366b2..52f3ffcaa1 100644
--- a/tests/qtest/libmcd-test.c
+++ b/tests/qtest/libmcd-test.c
@@ -316,5 +316,64 @@ MCDQryRegMapResult *qtest_mcd_qry_reg_map(QTestState *qts,
 
     UNMARSHAL_RESULT(MCDQryRegMapResult);
 
+    return unmarshal;
+
+}
+
+MCDRunResult *qtest_mcd_run(QTestState *qts, q_obj_mcd_run_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDRunResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_run_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-run',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDRunResult);
+
+    return unmarshal;
+}
+
+MCDStopResult *qtest_mcd_stop(QTestState *qts, q_obj_mcd_stop_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDStopResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_stop_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-stop',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDStopResult);
+
+    return unmarshal;
+}
+
+MCDQryStateResult *qtest_mcd_qry_state(QTestState *qts,
+                                       q_obj_mcd_qry_state_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryStateResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_state_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-qry-state',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryStateResult);
+
     return unmarshal;
 }
diff --git a/tests/qtest/libmcd-test.h b/tests/qtest/libmcd-test.h
index 266b6fe854..e45386847d 100644
--- a/tests/qtest/libmcd-test.h
+++ b/tests/qtest/libmcd-test.h
@@ -56,4 +56,13 @@ MCDQryRegGroupsResult *qtest_mcd_qry_reg_groups(QTestState *qts,
 MCDQryRegMapResult *qtest_mcd_qry_reg_map(QTestState *qts,
                                           q_obj_mcd_qry_reg_map_arg *args);
 
+MCDRunResult *qtest_mcd_run(QTestState *qts,
+                            q_obj_mcd_run_arg *args);
+
+MCDStopResult *qtest_mcd_stop(QTestState *qts,
+                              q_obj_mcd_stop_arg *args);
+
+MCDQryStateResult *qtest_mcd_qry_state(QTestState *qts,
+                                       q_obj_mcd_qry_state_arg *args);
+
 #endif /* LIBMCD_TEST_H */
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index 820408a9a9..9ab6b8e675 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -18,7 +18,7 @@
 #include "qapi/compat-policy.h"
 #include "libmcd-test.h"
 
-#define QEMU_EXTRA_ARGS ""
+#define QEMU_EXTRA_ARGS "-accel tcg"
 
 static bool verbose;
 
@@ -87,6 +87,45 @@ static MCDQryCoresResult *open_server_query_cores(QTestState *qts)
     return qry_cores_result;
 }
 
+static mcd_core_state_et check_core_state(QTestState *qts, uint32_t core_uid)
+{
+    mcd_core_state_et state;
+
+    q_obj_mcd_qry_state_arg qry_state_args = {
+        .core_uid = core_uid,
+    };
+
+    MCDQryStateResult *qry_state_result = qtest_mcd_qry_state(qts,
+                                                              &qry_state_args);
+
+    g_assert(qry_state_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_state_result->state);
+    state = qry_state_result->state->state;
+
+    if (verbose) {
+        fprintf(stderr, "[INFO]\tCore state: ");
+        switch (qry_state_result->state->state) {
+        case MCD_CORE_STATE_RUNNING:
+            fprintf(stderr, "running\n");
+            break;
+        case MCD_CORE_STATE_HALTED:
+            fprintf(stderr, "halted\n");
+            break;
+        case MCD_CORE_STATE_DEBUG:
+            fprintf(stderr, "debug\n");
+            break;
+        case MCD_CORE_STATE_UNKNOWN:
+            fprintf(stderr, "unknown\n");
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    qapi_free_MCDQryStateResult(qry_state_result);
+    return state;
+}
+
 static void test_initialize(void)
 {
     QTestState *qts = qtest_init(QEMU_EXTRA_ARGS);
@@ -510,6 +549,84 @@ static void test_qry_core_info(void)
     qtest_quit(qts);
 }
 
+static void test_go_stop(void)
+{
+    QTestState *qts = qtest_init(QEMU_EXTRA_ARGS);
+    mcd_core_state_et core_state;
+    MCDQryCoresResult *cores_query = open_server_query_cores(qts);
+
+    MCDCoreConInfoList *core_head = cores_query->core_con_info;
+    for (uint32_t c = 0; c < cores_query->num_cores; c++) {
+        q_obj_mcd_stop_arg stop_args = {
+            .global = true, /* only global stops currently supported */
+        };
+
+        q_obj_mcd_run_arg run_args = {
+            .global = true,
+        };
+
+        q_obj_mcd_close_core_arg close_core_args;
+
+        MCDRunResult *run_result;
+        MCDStopResult *stop_result;
+        MCDOpenCoreResult *open_core_result;
+        MCDCloseCoreResult *close_core_result;
+
+        MCDCoreConInfo *core_con_info = core_head->value;
+        q_obj_mcd_open_core_arg open_core_args = {
+            .core_con_info = core_con_info,
+        };
+
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tTesting core %s (#%d)...\n",
+                            core_con_info->core,
+                            core_con_info->core_id);
+        }
+
+        open_core_result = qtest_mcd_open_core(qts, &open_core_args);
+        g_assert(open_core_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(open_core_result->has_core_uid);
+
+        check_core_state(qts, open_core_result->core_uid);
+
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tStop core\n");
+        }
+
+        stop_args.core_uid = open_core_result->core_uid;
+        stop_result = qtest_mcd_stop(qts, &stop_args);
+        g_assert(stop_result->return_status == MCD_RET_ACT_NONE);
+        qapi_free_MCDStopResult(stop_result);
+
+        core_state = check_core_state(qts, open_core_result->core_uid);
+        g_assert(core_state == MCD_CORE_STATE_DEBUG);
+
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tResume core\n");
+        }
+
+        run_args.core_uid = open_core_result->core_uid;
+        run_result = qtest_mcd_run(qts, &run_args);
+        g_assert(run_result->return_status == MCD_RET_ACT_NONE);
+        qapi_free_MCDRunResult(run_result);
+
+        core_state = check_core_state(qts, open_core_result->core_uid);
+        g_assert(core_state == MCD_CORE_STATE_RUNNING);
+
+        close_core_args.core_uid = open_core_result->core_uid;
+        close_core_result = qtest_mcd_close_core(qts, &close_core_args);
+        g_assert(close_core_result->return_status == MCD_RET_ACT_NONE);
+
+        qapi_free_MCDCloseCoreResult(close_core_result);
+        qapi_free_MCDOpenCoreResult(open_core_result);
+        core_head = core_head->next;
+    }
+
+    qapi_free_MCDQryCoresResult(cores_query);
+    qtest_mcd_exit(qts);
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     char *v_env = getenv("V");
@@ -522,5 +639,6 @@ int main(int argc, char *argv[])
     qtest_add_func("mcd/qry-cores", test_qry_cores);
     qtest_add_func("mcd/open-core", test_open_core);
     qtest_add_func("mcd/qry-core-info", test_qry_core_info);
+    qtest_add_func("mcd/go-stop", test_go_stop);
     return g_test_run();
 }
-- 
2.34.1


