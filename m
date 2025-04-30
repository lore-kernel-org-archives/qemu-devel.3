Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D276C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA00E-0002fs-3p; Wed, 30 Apr 2025 01:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzs-0002KQ-OM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:41 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzo-0006if-IM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:40 -0400
Received: (qmail 1836 invoked by uid 484); 30 Apr 2025 05:28:05 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013071 secs); 30 Apr 2025 05:28:05 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:05 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 10/20] mcd: Implement core connection control
Date: Wed, 30 Apr 2025 07:27:31 +0200
Message-Id: <20250430052741.21145-11-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In MCD, core-specific operations require an open connection to the core.
This commit implements the necessary operations to open and close the
connection to cores.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/mcd_server.c       | 176 +++++++++++++++++++++++++++++++---
 mcd/mcd_stub.c         | 129 ++++++++++++++++++++++++-
 qapi/mcd.json          | 132 +++++++++++++++++++++++++-
 tests/qtest/mcd-test.c | 210 +++++++++++++++++++++++++++++------------
 tests/qtest/mcd-util.c |  51 +++++++++-
 tests/qtest/mcd-util.h |   9 +-
 6 files changed, 625 insertions(+), 82 deletions(-)

diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
index 9cc7ec0..83ffa4f 100644
--- a/mcd/mcd_server.c
+++ b/mcd/mcd_server.c
@@ -34,6 +34,13 @@ static const mcd_error_info_st MCD_ERROR_SERVER_NOT_OPEN = {
     .error_str = "server is not open",
 };
 
+static const mcd_error_info_st MCD_ERROR_UNKNOWN_CORE = {
+    .return_status = MCD_RET_ACT_HANDLE_ERROR,
+    .error_code = MCD_ERR_PARAM,
+    .error_events = MCD_ERR_EVT_NONE,
+    .error_str = "specified core is unknown to server",
+};
+
 static const mcd_error_info_st MCD_ERROR_NONE = {
     .return_status = MCD_RET_ACT_NONE,
     .error_code = MCD_ERR_NONE,
@@ -44,6 +51,24 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
 /* reserves memory for custom errors */
 static mcd_error_info_st custom_mcd_error;
 
+/**
+ * struct mcdcore_state - State of a core.
+ *
+ * @last_error: Error info of most recent executed function.
+ * @info:       Core connection information.
+ * @open_core:  Open core instance as allocated in mcd_open_core_f().
+ *
+ * MCD is mainly being used on the core level:
+ * After the initial query functions, a core connection is opened in
+ * mcd_open_core_f(). The allocated mcd_core_st instance is then the basis
+ * of subsequent operations.
+ */
+typedef struct mcdcore_state {
+    const mcd_error_info_st *last_error;
+    mcd_core_con_info_st info;
+    mcd_core_st *open_core;
+} mcdcore_state;
+
 /**
  * struct mcdserver_state - State of the MCD server
  *
@@ -66,6 +91,24 @@ static mcdserver_state g_server_state = {
     .cores = NULL,
 };
 
+static mcdcore_state *find_core(const mcd_core_con_info_st *core_con_info)
+{
+    uint32_t core_id;
+    mcdcore_state *core;
+
+    if (!core_con_info || !g_server_state.cores) {
+        return NULL;
+    }
+
+    core_id = core_con_info->core_id;
+    if (core_id > g_server_state.cores->len) {
+        return NULL;
+    }
+
+    core = &g_array_index(g_server_state.cores, mcdcore_state, core_id);
+    return core;
+}
+
 mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
                                mcd_impl_version_info_st *impl_info)
 {
@@ -200,16 +243,19 @@ mcd_return_et mcd_open_server_f(const char *system_key,
     }
 
     /* update the internal core information data base */
-    g_server_state.cores = g_array_new(false, true,
-                                       sizeof(mcd_core_con_info_st));
+    g_server_state.cores = g_array_new(false, true, sizeof(mcdcore_state));
     CPU_FOREACH(cpu) {
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
-        mcd_core_con_info_st info = {
-            .core_id = g_server_state.cores->len,
+        mcdcore_state c = {
+            .info = (mcd_core_con_info_st) {
+                .core_id = g_server_state.cores->len,
+            },
+            .last_error = &MCD_ERROR_NONE,
+            .open_core = NULL,
         };
-        pstrcpy(info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
-        g_array_append_val(g_server_state.cores, info);
+        pstrcpy(c.info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
+        g_array_append_val(g_server_state.cores, c);
     }
 
     g_server_state.last_error = &MCD_ERROR_NONE;
@@ -240,6 +286,14 @@ mcd_return_et mcd_close_server_f(const mcd_server_st *server)
         return g_server_state.last_error->return_status;
     }
 
+    for (int i = 0; i < g_server_state.cores->len; i++) {
+        mcdcore_state *c = &g_array_index(g_server_state.cores,
+                                          mcdcore_state, i);
+        if (c->open_core) {
+            mcd_close_core_f(c->open_core);
+        }
+    }
+
     g_array_free(g_server_state.cores, true);
     g_free(g_server_state.open_server);
     g_server_state.open_server = NULL;
@@ -396,12 +450,11 @@ mcd_return_et mcd_qry_cores_f(const mcd_core_con_info_st *connection_info,
          i < *num_cores && start_index + i < g_server_state.cores->len;
          i++) {
 
-        mcd_core_con_info_st *info = &g_array_index(g_server_state.cores,
-                                                    mcd_core_con_info_st,
-                                                    start_index + i);
+        mcdcore_state *c = &g_array_index(g_server_state.cores, mcdcore_state,
+                                          start_index + i);
         core_con_info[i] = *connection_info;
-        core_con_info[i].core_id = info->core_id;
-        pstrcpy(core_con_info[i].core, MCD_UNIQUE_NAME_LEN, info->core);
+        core_con_info[i].core_id = c->info.core_id;
+        pstrcpy(core_con_info[i].core, MCD_UNIQUE_NAME_LEN, c->info.core);
     }
 
     *num_cores = i;
@@ -421,21 +474,116 @@ mcd_return_et mcd_qry_core_modes_f(const mcd_core_st *core,
 mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
                               mcd_core_st **core)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    uint32_t core_id;
+    mcdcore_state *core_state;
+    mcd_core_con_info_st *info;
+
+    if (!g_server_state.open_server) {
+        g_server_state.last_error = &MCD_ERROR_SERVER_NOT_OPEN;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!core_con_info || !core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_id = core_con_info->core_id;
+    if (core_id > g_server_state.cores->len) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "specified core index exceeds the number of cores",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = &g_array_index(g_server_state.cores, mcdcore_state, core_id);
+    if (core_state->open_core) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "core already open",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    *core = g_malloc(sizeof(mcd_core_st));
+    info = g_malloc(sizeof(mcd_core_con_info_st));
+    *info = *core_con_info;
+    (*core)->core_con_info = info;
+    (*core)->instance = NULL;
+    core_state->open_core = *core;
+    core_state->last_error = &MCD_ERROR_NONE;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
 mcd_return_et mcd_close_core_f(const mcd_core_st *core)
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
+    if (!core_state) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (core_state->open_core != core) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "core not open",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    g_free((void *)core->core_con_info);
+    g_free((void *)core);
+    core_state->open_core = NULL;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
 void mcd_qry_error_info_f(const mcd_core_st *core,
                           mcd_error_info_st *error_info)
 {
-    if (error_info) {
+    mcdcore_state *core_state;
+
+    if (!error_info) {
+        return;
+    }
+
+    if (!core) {
         *error_info = *g_server_state.last_error;
+        return;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state)  {
+        *error_info = MCD_ERROR_UNKNOWN_CORE;
+    } else if (core_state->open_core != core) {
+        *error_info = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "core not open",
+        };
+    } else {
+        *error_info = *core_state->last_error;
     }
 }
 
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
index 02d16b4..c49fcb4 100644
--- a/mcd/mcd_stub.c
+++ b/mcd/mcd_stub.c
@@ -16,18 +16,27 @@
 /**
  * struct mcdstub_state - State of the MCD server stub
  *
- * @open_server:     Open server instance as allocated in mcd_open_server_f().
- * @open_server_uid: Unique identifier of the open server.
+ * @open_server:         Open server instance as allocated in
+ *                       mcd_open_server_f().
+ * @open_server_uid:     Unique identifier of the open server.
+ * @open_cores:          Array of open cores.
+ * @custom_error:        Last error which occurred in the server stub.
+ * @on_error_ask_server: Call mcd_qry_error_info_f() when asked for most recent
+ *                       error.
  */
 typedef struct mcdstub_state {
     mcd_server_st *open_server;
     uint32_t open_server_uid;
+    GPtrArray *open_cores;
+    mcd_error_info_st custom_error;
+    bool on_error_ask_server;
 } mcdstub_state;
 
 
 static mcdstub_state g_stub_state = {
     .open_server = NULL,
     .open_server_uid = 0,
+    .on_error_ask_server = true,
 };
 
 static uint32_t store_open_server(mcd_server_st *server)
@@ -46,6 +55,59 @@ static mcd_server_st *retrieve_open_server(uint32_t server_uid)
     }
 }
 
+static uint32_t store_open_core(mcd_core_st *core)
+{
+    /* core_uid 0 is reserved */
+    uint32_t core_uid = core->core_con_info->core_id + 1;
+    mcd_core_st **core_p;
+
+    if (!g_stub_state.open_cores) {
+        g_stub_state.open_cores = g_ptr_array_new();
+    }
+
+    if (core_uid > g_stub_state.open_cores->len) {
+        g_ptr_array_set_size(g_stub_state.open_cores, core_uid);
+    }
+
+    core_p = (mcd_core_st **) &g_ptr_array_index(g_stub_state.open_cores,
+                                                 core_uid - 1);
+    *core_p = core;
+    return core_uid;
+}
+
+static void remove_closed_core(uint32_t core_uid)
+{
+    if (core_uid <= g_stub_state.open_cores->len) {
+        mcd_core_st ** core_p = (mcd_core_st **) &g_ptr_array_index(
+            g_stub_state.open_cores, core_uid - 1);
+        *core_p = NULL;
+    }
+}
+
+static mcd_return_et retrieve_open_core(uint32_t core_uid, mcd_core_st **core)
+{
+    if (core_uid > 0 &&
+       (!g_stub_state.open_cores || core_uid > g_stub_state.open_cores->len)) {
+        g_stub_state.custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "stub: core UID not found",
+        };
+        return g_stub_state.custom_error.return_status;
+    }
+
+    g_assert(core);
+
+    if (!core_uid) {
+        *core = NULL;
+    } else {
+        *core = g_ptr_array_index(g_stub_state.open_cores, core_uid - 1);
+    }
+
+    return MCD_RET_ACT_NONE;
+}
+
 MCDInitializeResult *qmp_mcd_initialize(MCDAPIVersion *version_req,
                                         Error **errp)
 {
@@ -61,6 +123,7 @@ MCDInitializeResult *qmp_mcd_initialize(MCDAPIVersion *version_req,
         result->impl_info = marshal_mcd_impl_version_info(&impl_info);
     }
 
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
@@ -103,6 +166,7 @@ MCDQryServersResult *qmp_mcd_qry_servers(const char *host, bool running,
         g_free(server_info);
     }
 
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
@@ -123,6 +187,7 @@ MCDOpenServerResult *qmp_mcd_open_server(const char *system_key,
         result->config_string = g_strdup(server->config_string);
     }
 
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
@@ -167,6 +232,7 @@ MCDQrySystemsResult *qmp_mcd_qry_systems(uint32_t start_index,
         g_free(system_con_info);
     }
 
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
@@ -207,6 +273,7 @@ MCDQryDevicesResult *qmp_mcd_qry_devices(MCDCoreConInfo *system_con_info,
         g_free(device_con_info);
     }
 
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
@@ -247,14 +314,68 @@ MCDQryCoresResult *qmp_mcd_qry_cores(MCDCoreConInfo *connection_info,
         g_free(core_con_info);
     }
 
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDOpenCoreResult *qmp_mcd_open_core(MCDCoreConInfo *core_con_info,
+                                     Error **errp)
+{
+    MCDOpenCoreResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core;
+    mcd_core_con_info_st core_con_info_unmarshalled =
+        unmarshal_mcd_core_con_info(core_con_info);
+
+    result->return_status =  mcd_open_core_f(&core_con_info_unmarshalled,
+                                             &core);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_core_uid = true;
+        result->core_uid = store_open_core(core);
+        result->core_con_info = marshal_mcd_core_con_info(core->core_con_info);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDCloseCoreResult *qmp_mcd_close_core(uint32_t core_uid, Error **errp)
+{
+    MCDCloseCoreResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_close_core_f(core);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        remove_closed_core(core_uid);
+    }
+
+    g_stub_state.on_error_ask_server = true;
     return result;
 }
 
-MCDErrorInfo *qmp_mcd_qry_error_info(Error **errp)
+MCDErrorInfo *qmp_mcd_qry_error_info(uint32_t core_uid, Error **errp)
 {
     MCDErrorInfo *result;
+    mcd_core_st *core = NULL;
     mcd_error_info_st error_info;
-    mcd_qry_error_info_f(NULL, &error_info);
+
+    if (retrieve_open_core(core_uid, &core) != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+    }
+
+    if (g_stub_state.on_error_ask_server) {
+        mcd_qry_error_info_f(core, &error_info);
+    } else {
+        error_info = g_stub_state.custom_error;
+    }
+
     result = marshal_mcd_error_info(&error_info);
     return result;
 }
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 2d581b9..7219056 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -713,6 +713,133 @@
 # == Core Connection API
 ##
 
+##
+# @MCDOpenCoreResult:
+#
+# Return value of @mcd-open-core.
+#
+# @return-status: Return code.
+# @core-uid:      Unique identifier of the core instance.
+# @core-con-info: Core connection information of the core instance.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDOpenCoreResult',
+  'data': {
+    'return-status' : 'uint32',
+    '*core-uid'     : 'uint32',
+    '*core-con-info': 'MCDCoreConInfo' }}
+
+
+##
+# @mcd-open-core:
+#
+# Function opening a core connection.
+#
+# @core-con-info: Unambiguous core information (e.g. from @mcd-qry-cores).
+#
+# Returns: @MCDOpenCoreResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-open-core",
+#          "arguments": {
+#              "core-con-info": {
+#                  "core-id": 0,
+#                  "device": "virt-10.0",
+#                  "device-id": 0,
+#                  "device-key": "",
+#                  "system": "",
+#                  "core": "cortex-a53-arm-cpu",
+#                  "host": "",
+#                  "system-key": "qemu-system-aarch64",
+#                  "system-instance": "",
+#                  "acc-hw": "",
+#                  "core-type": 0,
+#                  "device-type": 0,
+#                  "server-key": "",
+#                  "server-port": 0 } } }
+#     <- {
+#          "return": {
+#              "core-con-info": {
+#                  "core-id": 0,
+#                  "device": "virt-10.0",
+#                  "device-id": 0,
+#                  "device-key": "",
+#                  "system": "",
+#                  "core": "cortex-a53-arm-cpu",
+#                  "host": "",
+#                  "system-key": "qemu-system-aarch64",
+#                  "system-instance": "",
+#                  "acc-hw": "",
+#                  "core-type": 0,
+#                  "device-type": 0,
+#                  "server-key": "",
+#                  "server-port": 0
+#              },
+#              "return-status": 0,
+#              "core-uid": 1
+#          }
+#        }
+##
+{ 'command': 'mcd-open-core',
+  'data': { 'core-con-info': 'MCDCoreConInfo' },
+  'returns': 'MCDOpenCoreResult' }
+
+
+##
+# @MCDCloseCoreResult:
+#
+# Return value of @mcd-close-core.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCloseCoreResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-close-core:
+#
+# Function closing a core connection.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDCloseCoreResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-close-core", "arguments": { "core-uid": 1 } }
+#     <- {
+#            "return": {
+#                "return-status": 0
+#            }
+#        }
+#     -> { "execute": "mcd-close-core", "arguments": { "core-uid": 1 } }
+#     <- {
+#            "return": {
+#                "return-status": 3
+#            }
+#        }
+#     -> { "execute": "mcd-qry-error-info", "arguments": { "core-uid": 1 } }
+#     <- {
+#            "return": {
+#                "error-str": "core not open",
+#                "error-code": 512,
+#                "error-events": 0,
+#                "return-status": 3
+#            }
+#        }
+##
+{ 'command': 'mcd-close-core',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDCloseCoreResult' }
+
 
 ##
 # @mcd-qry-error-info:
@@ -720,6 +847,8 @@
 # Function allowing the access to detailed error and/or event information after
 # an API call.
 #
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
 # Returns: @MCDErrorInfo
 #
 # Since: 9.1
@@ -736,7 +865,7 @@
 #                "return-status": 3
 #            }
 #        }
-#     -> { "execute": "mcd-qry-error-info" }
+#     -> { "execute": "mcd-qry-error-info", "arguments": { "core-uid": 0 }}
 #     <- {
 #            "return": {
 #                "error-str": "incompatible versions",
@@ -747,4 +876,5 @@
 #        }
 ##
 { 'command': 'mcd-qry-error-info',
+  'data': { 'core-uid': 'uint32' },
   'returns': 'MCDErrorInfo' }
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index b1b36d9..9596309 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -72,6 +72,71 @@ static void test_initialize_mcdtest(void)
     mcdtest_quit(&qts);
 }
 
+static MCDQryCoresResult *open_server_query_cores(QTestStateMCD *qts)
+{
+    char empty_string[] = "";
+
+    q_obj_mcd_open_server_arg open_server_args = {
+        .system_key = empty_string,
+        .config_string = empty_string,
+    };
+
+    q_obj_mcd_qry_systems_arg qry_systems_args = {
+        .start_index = 0,
+        .num_systems = 1,
+    };
+
+    q_obj_mcd_qry_devices_arg qry_devices_args = {
+        .start_index = 0,
+        .num_devices = 1,
+    };
+
+    /* first for num_cores only */
+    q_obj_mcd_qry_cores_arg qry_cores_args = {
+        .start_index = 0,
+        .num_cores = 0,
+    };
+
+    MCDOpenServerResult *open_server_result;
+    MCDQrySystemsResult *qry_systems_result;
+    MCDQryDevicesResult *qry_devices_result;
+    MCDQryCoresResult *qry_cores_result;
+
+    open_server_result = qtest_mcd_open_server(qts, &open_server_args);
+    g_assert(open_server_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(open_server_result->has_server_uid);
+    qapi_free_MCDOpenServerResult(open_server_result);
+
+    qry_systems_result = qtest_mcd_qry_systems(qts, &qry_systems_args);
+    g_assert(qry_systems_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_systems_result->has_system_con_info);
+
+    qry_devices_args.system_con_info =
+        qry_systems_result->system_con_info->value;
+
+    qry_devices_result = qtest_mcd_qry_devices(qts, &qry_devices_args);
+    g_assert(qry_devices_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_devices_result->has_device_con_info);
+    qapi_free_MCDQrySystemsResult(qry_systems_result);
+
+    qry_cores_args.connection_info =
+        qry_devices_result->device_con_info->value;
+
+    qry_cores_result = qtest_mcd_qry_cores(qts, &qry_cores_args);
+    g_assert(qry_cores_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_cores_result->has_num_cores);
+    g_assert(qry_cores_result->num_cores > 0);
+    qry_cores_args.num_cores = qry_cores_result->num_cores;
+    qapi_free_MCDQryCoresResult(qry_cores_result);
+    qry_cores_result = qtest_mcd_qry_cores(qts, &qry_cores_args);
+    g_assert(qry_cores_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_cores_result->has_num_cores);
+    g_assert(qry_cores_result->num_cores > 0);
+    qapi_free_MCDQryDevicesResult(qry_devices_result);
+
+    return qry_cores_result;
+}
+
 static void test_initialize(void)
 {
     QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
@@ -87,6 +152,8 @@ static void test_initialize(void)
         .version_req = marshal_mcd_api_version(&version_req),
     };
 
+    q_obj_mcd_qry_error_info_arg qry_error_info_args = { .core_uid = 0 };
+
     MCDInitializeResult *result = qtest_mcd_initialize(&qts, &qapi_args);
     g_assert(result->return_status == MCD_RET_ACT_NONE);
 
@@ -117,7 +184,7 @@ static void test_initialize(void)
     result = qtest_mcd_initialize(&qts, &qapi_args);
     g_assert(result->return_status != MCD_RET_ACT_NONE);
 
-    error_info = qtest_mcd_qry_error_info(&qts);
+    error_info = qtest_mcd_qry_error_info(&qts, &qry_error_info_args);
     g_assert(error_info->error_code == MCD_ERR_GENERAL);
 
     if (verbose) {
@@ -200,7 +267,9 @@ static void test_open_server(void)
     g_assert(open_server_result->return_status != MCD_RET_ACT_NONE);
 
     if (verbose) {
-        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(&qts);
+        q_obj_mcd_qry_error_info_arg qry_error_info_args = { .core_uid = 0 };
+        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(&qts,
+            &qry_error_info_args);
         fprintf(stderr, "[INFO]\tServer cannot be opened twice: %s\n",
                         error_info->error_str);
         qapi_free_MCDErrorInfo(error_info);
@@ -216,7 +285,9 @@ static void test_open_server(void)
     g_assert(close_server_result->return_status != MCD_RET_ACT_NONE);
 
     if (verbose) {
-        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(&qts);
+        q_obj_mcd_qry_error_info_arg qry_error_info_args = { .core_uid = 0 };
+        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(&qts,
+            &qry_error_info_args);
         fprintf(stderr, "[INFO]\tServer cannot be closed twice: %s\n",
                         error_info->error_str);
         qapi_free_MCDErrorInfo(error_info);
@@ -230,62 +301,7 @@ static void test_qry_cores(void)
 {
     QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
 
-    char empty_string[] = "";
-
-    q_obj_mcd_open_server_arg open_server_args = {
-        .system_key = empty_string,
-        .config_string = empty_string,
-    };
-
-    q_obj_mcd_qry_systems_arg qry_systems_args = {
-        .start_index = 0,
-        .num_systems = 1,
-    };
-
-    q_obj_mcd_qry_devices_arg qry_devices_args = {
-        .start_index = 0,
-        .num_devices = 1,
-    };
-
-    q_obj_mcd_qry_cores_arg qry_cores_args = {
-        .start_index = 0,
-        /* first, only query the number of cores */
-        .num_cores = 0,
-    };
-
-    MCDOpenServerResult *open_server_result;
-    MCDQrySystemsResult *qry_systems_result;
-    MCDQryDevicesResult *qry_devices_result;
-    MCDQryCoresResult *qry_cores_result;
-
-    open_server_result = qtest_mcd_open_server(&qts, &open_server_args);
-    g_assert(open_server_result->return_status == MCD_RET_ACT_NONE);
-    g_assert(open_server_result->has_server_uid);
-    qapi_free_MCDOpenServerResult(open_server_result);
-
-    qry_systems_result = qtest_mcd_qry_systems(&qts, &qry_systems_args);
-    g_assert(qry_systems_result->return_status == MCD_RET_ACT_NONE);
-    g_assert(qry_systems_result->has_system_con_info);
-
-    qry_devices_args.system_con_info =
-        qry_systems_result->system_con_info->value;
-
-    qry_devices_result = qtest_mcd_qry_devices(&qts, &qry_devices_args);
-    g_assert(qry_devices_result->return_status == MCD_RET_ACT_NONE);
-    g_assert(qry_devices_result->has_device_con_info);
-    qapi_free_MCDQrySystemsResult(qry_systems_result);
-
-    qry_cores_args.connection_info =
-        qry_devices_result->device_con_info->value;
-
-    qry_cores_result = qtest_mcd_qry_cores(&qts, &qry_cores_args);
-    g_assert(qry_cores_result->return_status == MCD_RET_ACT_NONE);
-    g_assert(qry_cores_result->has_num_cores);
-    g_assert(qry_cores_result->num_cores > 0);
-    qry_cores_args.num_cores = qry_cores_result->num_cores;
-    qapi_free_MCDQryCoresResult(qry_cores_result);
-    qry_cores_result = qtest_mcd_qry_cores(&qts, &qry_cores_args);
-    qapi_free_MCDQryDevicesResult(qry_devices_result);
+    MCDQryCoresResult *qry_cores_result = open_server_query_cores(&qts);
 
     if (verbose) {
         MCDCoreConInfoList *core_head = qry_cores_result->core_con_info;
@@ -308,6 +324,81 @@ static void test_qry_cores(void)
     mcdtest_quit(&qts);
 }
 
+static void test_open_core(void)
+{
+    QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
+    MCDQryCoresResult *cores_query = open_server_query_cores(&qts);
+
+    MCDCoreConInfoList *core_head = cores_query->core_con_info;
+    for (uint32_t c = 0; c < cores_query->num_cores; c++) {
+        q_obj_mcd_close_core_arg close_core_args;
+        MCDCloseCoreResult *close_core_result;
+
+        MCDCoreConInfo *core_con_info = core_head->value;
+        q_obj_mcd_open_core_arg open_core_args = {
+            .core_con_info = core_con_info,
+        };
+
+        q_obj_mcd_qry_error_info_arg error_info_args = {
+            .core_uid = 0,
+        };
+        MCDErrorInfo *last_server_error;
+
+        MCDOpenCoreResult *open_core_result =
+            qtest_mcd_open_core(&qts, &open_core_args);
+        g_assert(open_core_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(open_core_result->has_core_uid);
+
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tCore #%d open with UID %d\n",
+                             core_con_info->core_id,
+                             open_core_result->core_uid);
+        }
+
+        close_core_args.core_uid = open_core_result->core_uid;
+
+        /* Verify that core cannot be opened twice */
+        qapi_free_MCDOpenCoreResult(open_core_result);
+        open_core_result = qtest_mcd_open_core(&qts, &open_core_args);
+        g_assert(open_core_result->return_status != MCD_RET_ACT_NONE);
+
+        last_server_error = qtest_mcd_qry_error_info(&qts, &error_info_args);
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tCore cannot be opened twice: %s\n",
+                            last_server_error->error_str);
+        }
+        qapi_free_MCDErrorInfo(last_server_error);
+
+        close_core_result = qtest_mcd_close_core(&qts, &close_core_args);
+        g_assert(close_core_result->return_status == MCD_RET_ACT_NONE);
+
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tCore with UID %d closed\n",
+                            close_core_args.core_uid);
+        }
+
+        /* Check that core cannot be closed twice */
+        qapi_free_MCDCloseCoreResult(close_core_result);
+        close_core_result = qtest_mcd_close_core(&qts, &close_core_args);
+        g_assert(close_core_result->return_status != MCD_RET_ACT_NONE);
+
+        last_server_error = qtest_mcd_qry_error_info(&qts, &error_info_args);
+        if (verbose) {
+            fprintf(stderr, "[INFO]\tCore cannot be closed twice: %s\n",
+                            last_server_error->error_str);
+        }
+        qapi_free_MCDErrorInfo(last_server_error);
+
+        qapi_free_MCDCloseCoreResult(close_core_result);
+        qapi_free_MCDOpenCoreResult(open_core_result);
+        core_head = core_head->next;
+    }
+
+    qapi_free_MCDQryCoresResult(cores_query);
+    qtest_mcd_exit(&qts);
+    mcdtest_quit(&qts);
+}
+
 int main(int argc, char *argv[])
 {
     char *v_env = getenv("V");
@@ -319,5 +410,6 @@ int main(int argc, char *argv[])
     qtest_add_func("mcd/qry-servers", test_qry_servers);
     qtest_add_func("mcd/open-server", test_open_server);
     qtest_add_func("mcd/qry-cores", test_qry_cores);
+    qtest_add_func("mcd/open-core", test_open_core);
     return g_test_run();
 }
diff --git a/tests/qtest/mcd-util.c b/tests/qtest/mcd-util.c
index d37b44e..53694d9 100644
--- a/tests/qtest/mcd-util.c
+++ b/tests/qtest/mcd-util.c
@@ -83,15 +83,20 @@ MCDInitializeResult *qtest_mcd_initialize(QTestStateMCD *qts,
     return unmarshal;
 }
 
-MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts)
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts,
+                                       q_obj_mcd_qry_error_info_arg *args)
 {
     Visitor *v;
-    QDict *resp;
+    QObject *marshal;
+    QDict *arg, *resp;
     QObject *ret;
     bool ok;
     MCDErrorInfo *unmarshal;
 
-    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-error-info'}");
+    MARSHAL_ARGS(q_obj_mcd_qry_error_info_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-error-info',"
+                          "'arguments': %p}", arg);
 
     UNMARSHAL_RESULT(MCDErrorInfo);
 
@@ -224,3 +229,43 @@ MCDQryCoresResult *qtest_mcd_qry_cores(QTestStateMCD *qts,
 
     return unmarshal;
 }
+
+MCDOpenCoreResult *qtest_mcd_open_core(QTestStateMCD *qts,
+                                       q_obj_mcd_open_core_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDOpenCoreResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_open_core_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-open-core',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDOpenCoreResult);
+
+    return unmarshal;
+}
+
+MCDCloseCoreResult *qtest_mcd_close_core(QTestStateMCD *qts,
+                                         q_obj_mcd_close_core_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDCloseCoreResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_close_core_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-close-core',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDCloseCoreResult);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/mcd-util.h b/tests/qtest/mcd-util.h
index fbac3b7..5e7c3ca 100644
--- a/tests/qtest/mcd-util.h
+++ b/tests/qtest/mcd-util.h
@@ -22,7 +22,8 @@ typedef struct {
 MCDInitializeResult *qtest_mcd_initialize(QTestStateMCD *qts,
                                           q_obj_mcd_initialize_arg *args);
 
-MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts);
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts,
+                                       q_obj_mcd_qry_error_info_arg *args);
 
 void qtest_mcd_exit(QTestStateMCD *qts);
 
@@ -44,4 +45,10 @@ MCDQryDevicesResult *qtest_mcd_qry_devices(QTestStateMCD *qts,
 MCDQryCoresResult *qtest_mcd_qry_cores(QTestStateMCD *qts,
                                        q_obj_mcd_qry_cores_arg *args);
 
+MCDOpenCoreResult *qtest_mcd_open_core(QTestStateMCD *qts,
+                                       q_obj_mcd_open_core_arg *args);
+
+MCDCloseCoreResult *qtest_mcd_close_core(QTestStateMCD *qts,
+                                         q_obj_mcd_close_core_arg *args);
+
 #endif /* TEST_MCD_UTILS_H */
-- 
2.34.1


