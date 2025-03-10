Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B51C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tren0-00022W-7c; Mon, 10 Mar 2025 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremx-000204-UK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:31 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremu-0007g1-F6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:31 -0400
Received: (qmail 30701 invoked by uid 484); 10 Mar 2025 15:11:10 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013713 secs); 10 Mar 2025 15:11:10 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:10 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/16] mcd: Implement server connection API
Date: Mon, 10 Mar 2025 16:04:58 +0100
Message-Id: <20250310150510.200607-5-mario.fleischmann@lauterbach.com>
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

This commit implements the necessary operations required to establish
a connection with the MCD server:

* query information about the server
* connect to "
* disconnect from "

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/libmcd_qapi.c         |  13 +++
 mcd/libmcd_qapi.h         |   2 +
 mcd/mcdserver.c           | 110 +++++++++++++++++++-
 mcd/mcdstub_qapi.c        |  98 ++++++++++++++++++
 qapi/mcd.json             | 205 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/libmcd-test.c |  60 +++++++++++
 tests/qtest/libmcd-test.h |   9 ++
 tests/qtest/mcd-test.c    |  96 ++++++++++++++++++
 8 files changed, 588 insertions(+), 5 deletions(-)

diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
index bc147072a1..44adb04c76 100644
--- a/mcd/libmcd_qapi.c
+++ b/mcd/libmcd_qapi.c
@@ -64,3 +64,16 @@ MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info)
 
     return marshal;
 }
+
+MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info)
+{
+    MCDServerInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDServerInfo) {
+        .server = g_strdup(server_info->server),
+        .system_instance = g_strdup(server_info->system_instance),
+        .acc_hw = g_strdup(server_info->acc_hw),
+    };
+
+    return marshal;
+}
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
index fc7436bf65..6fc99edc93 100644
--- a/mcd/libmcd_qapi.h
+++ b/mcd/libmcd_qapi.h
@@ -21,6 +21,8 @@ MCDImplVersionInfo *marshal_mcd_impl_version_info(
 
 MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info);
 
+MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
 #endif /* LIBMCD_QAPI_H */
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index 6e941f0531..4d06c255f2 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -38,14 +38,17 @@ static mcd_error_info_st custom_mcd_error;
 /**
  * struct mcdserver_state - State of the MCD server
  *
- * @last_error: Error info of most recent executed function.
+ * @last_error:  Error info of most recent executed function.
+ * @open_server: Open server instance as allocated in mcd_open_server_f().
  */
 typedef struct mcdserver_state {
     const mcd_error_info_st *last_error;
+    mcd_server_st *open_server;
 } mcdserver_state;
 
 static mcdserver_state g_server_state = {
     .last_error = &MCD_ERROR_NONE,
+    .open_server = NULL,
 };
 
 mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
@@ -87,7 +90,10 @@ mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
 
 void mcd_exit_f(void)
 {
-    g_server_state.last_error = &MCD_ERROR_NONE;
+    if (g_server_state.open_server) {
+        mcd_close_server_f(g_server_state.open_server);
+    }
+
     return;
 }
 
@@ -95,7 +101,51 @@ mcd_return_et mcd_qry_servers_f(const char *host, bool running,
                                 uint32_t start_index, uint32_t *num_servers,
                                 mcd_server_info_st *server_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (start_index >= 1) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "QEMU only has one MCD server",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!num_servers) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!running) {
+        /* MCD server is always running */
+        *num_servers = 0;
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (*num_servers == 0) {
+        *num_servers = 1;
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    /* num_servers != 0 => return server information */
+
+    if (!server_info) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    *server_info = (mcd_server_info_st) {
+        .server = "QEMU"
+    };
+    snprintf(server_info->system_instance, MCD_UNIQUE_NAME_LEN,
+             "Process ID: %d", (int) getpid());
+
+    *num_servers = 1;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
@@ -103,13 +153,63 @@ mcd_return_et mcd_open_server_f(const char *system_key,
                                 const char *config_string,
                                 mcd_server_st **server)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (g_server_state.open_server) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "server already open",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!server) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    g_server_state.open_server = g_malloc(sizeof(mcd_server_st));
+    *g_server_state.open_server = (mcd_server_st) {
+        .instance = NULL,
+        .host = "QEMU",
+        .config_string = "",
+    };
+
+    *server = g_server_state.open_server;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
 mcd_return_et mcd_close_server_f(const mcd_server_st *server)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (!g_server_state.open_server) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "server not open",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (server != g_server_state.open_server) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_CONNECTION,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown server",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    g_free(g_server_state.open_server);
+    g_server_state.open_server = NULL;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index a76d2d081f..425bcacd00 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -15,6 +15,39 @@
 #include "libmcd_qapi.h"
 #include "qapi/qapi-commands-mcd.h"
 
+/**
+ * struct mcdstub_state - State of the MCD server stub
+ *
+ * @open_server:     Open server instance as allocated in mcd_open_server_f().
+ * @open_server_uid: Unique identifier of the open server.
+ */
+typedef struct mcdstub_state {
+    mcd_server_st *open_server;
+    uint32_t open_server_uid;
+} mcdstub_state;
+
+
+static mcdstub_state g_stub_state = {
+    .open_server = NULL,
+    .open_server_uid = 0,
+};
+
+static uint32_t store_open_server(mcd_server_st *server)
+{
+    g_stub_state.open_server = server;
+    g_stub_state.open_server_uid++;
+    return g_stub_state.open_server_uid;
+}
+
+static mcd_server_st *retrieve_open_server(uint32_t server_uid)
+{
+    if (server_uid == g_stub_state.open_server_uid) {
+        return g_stub_state.open_server;
+    } else {
+        return NULL;
+    }
+}
+
 MCDInitializeResult *qmp_mcd_initialize(MCDAPIVersion *version_req,
                                         Error **errp)
 {
@@ -38,6 +71,71 @@ void qmp_mcd_exit(Error **errp)
     mcd_exit_f();
 }
 
+MCDQryServersResult *qmp_mcd_qry_servers(const char *host, bool running,
+                                         uint32_t start_index,
+                                         uint32_t num_servers, Error **errp)
+{
+    MCDServerInfoList **tailp;
+    MCDServerInfo *info;
+    mcd_server_info_st *server_info = NULL;
+    bool query_num_only = num_servers == 0;
+    MCDQryServersResult *result = g_malloc0(sizeof(*result));
+
+    if (!query_num_only) {
+        server_info = g_malloc0(num_servers * sizeof(*server_info));
+    }
+
+    result->return_status = mcd_qry_servers_f(host, running, start_index,
+                                              &num_servers, server_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_servers = true;
+        result->num_servers = num_servers;
+        if (!query_num_only) {
+            result->has_server_info = true;
+            tailp = &(result->server_info);
+            for (uint32_t i = 0; i < num_servers; i++) {
+                info = marshal_mcd_server_info(server_info + i);
+                QAPI_LIST_APPEND(tailp, info);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(server_info);
+    }
+
+    return result;
+}
+
+MCDOpenServerResult *qmp_mcd_open_server(const char *system_key,
+                                         const char *config_string,
+                                         Error **errp)
+{
+    MCDOpenServerResult *result = g_malloc0(sizeof(*result));
+    mcd_server_st *server;
+
+    result->return_status = mcd_open_server_f(system_key, config_string,
+                                              &server);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_server_uid = true;
+        result->server_uid = store_open_server(server);
+        result->host = g_strdup(server->host);
+        result->config_string = g_strdup(server->config_string);
+    }
+
+    return result;
+}
+
+MCDCloseServerResult *qmp_mcd_close_server(uint32_t server_uid, Error **errp)
+{
+    MCDCloseServerResult *result = g_malloc0(sizeof(*result));
+    mcd_server_st *server = retrieve_open_server(server_uid);
+    result->return_status = mcd_close_server_f(server);
+    return result;
+}
+
 MCDErrorInfo *qmp_mcd_qry_error_info(Error **errp)
 {
     MCDErrorInfo *result;
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 7b42a74036..3cdfd5dc29 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -73,6 +73,24 @@
     'error-str'    : 'str' }}
 
 
+##
+# @MCDServerInfo:
+#
+# Structure type containing the server information.
+#
+# @server:          String containing the server name.
+# @system-instance: String containing the unique system instance identifier.
+# @acc-hw:          String containing the unique device access hardware name.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDServerInfo',
+  'data': {
+    'server'         : 'str',
+    'system-instance': 'str',
+    'acc-hw'         : 'str' } }
+
+
 ##
 # == Target Initialization API
 ##
@@ -148,6 +166,193 @@
 { 'command': 'mcd-exit' }
 
 
+##
+# == Server Connection API
+##
+
+
+##
+# @MCDQryServersResult:
+#
+# Return value of @mcd-qry-servers.
+#
+# @return-status: Return code.
+# @num-servers:   The number of returned servers. In case the input value of
+#                 @num-servers is '0', this is the number of all available
+#                 servers.
+# @server-info:   Server information.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryServersResult',
+  'data': {
+    'return-status': 'uint32',
+    '*num-servers' : 'uint32',
+    '*server-info' : [ 'MCDServerInfo' ] }}
+
+
+##
+# @mcd-qry-servers:
+#
+# Function returning a list of available servers.
+#
+# @host:        String containing the host name.
+# @running:     Selects between running and installed servers.
+# @start-index: Start index of the queried servers. This refers to an
+#               internal list of the target side implementation.
+# @num-servers: The number of queried servers starting from the defined
+#               @start-index. If it is set to '0', no server descriptions are
+#               returned but the number of all available servers.
+#
+# Returns: @MCDQryServersResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-qry-servers",
+#        "arguments": { "host": "",
+#                       "running": true,
+#                       "start-index": 0,
+#                       "num-servers": 0 } }
+#    <- {
+#           "return": {
+#               "num-servers": 1,
+#               "return-status": 0
+#           }
+#       }
+#
+#    -> { "execute": "mcd-qry-servers",
+#         "arguments": { "host": "",
+#                        "running": true,
+#                        "start-index": 0,
+#                        "num-servers": 1 } }
+#    <- {
+#           "return": {
+#               "num-servers": 1,
+#               "server-info": [
+#                   {
+#                       "system-instance": "Process ID: 44801",
+#                       "acc-hw": "",
+#                       "server": "QEMU"
+#                   }
+#               ],
+#               "return-status": 0
+#           }
+#       }
+##
+{ 'command': 'mcd-qry-servers',
+  'data': {
+    'host'       : 'str',
+    'running'    : 'bool',
+    'start-index': 'uint32',
+    'num-servers': 'uint32' },
+  'returns': 'MCDQryServersResult' }
+
+
+##
+# @MCDOpenServerResult:
+#
+# Return value of @mcd-open-server.
+#
+# @return-status: Return code.
+# @server-uid:    Unique identifier of the server instance.
+# @host:          String containing the host name.
+# @config-string: Server configuration information.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDOpenServerResult',
+  'data': {
+    'return-status' : 'uint32',
+    '*server-uid'   : 'uint32',
+    '*host'         : 'str',
+    '*config-string': 'str' } }
+
+
+##
+# @mcd-open-server:
+#
+# Function opening the connection to a server on a host computer.
+#
+# @system-key:    A server is claimed by this key when being opened.
+# @config-string: Allows the configuration of the server connection by a
+#                 character string. Delimiters are blanks, tabs and line
+#                 breaks. Value strings are always enclosed with "double
+#                 quotes". Bool values can be "TRUE" or "FALSE" (both in
+#                 small letters).
+#
+# Returns: @MCDOpenServerResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#    -> { "execute": "mcd-open-server",
+#         "arguments": { "system-key": "",
+#                        "config-string": "" } }
+#    <- {
+#           "return": {
+#               "config-string": "",
+#               "host": "QEMU",
+#               "server-uid": 1,
+#               "return-status": 0
+#           }
+#       }
+#    -> { "execute": "mcd-open-server",
+#         "arguments": { "system-key": "",
+#                        "config-string": "" } }
+#    <- {
+#           "return": {
+#               "return-status": 3
+#           }
+#       }
+#    -> { "execute": "mcd-qry-error-info" }
+#    <- {
+#           "return": {
+#               "error-str": "server already open",
+#               "error-code": 512,
+#               "error-events": 0,
+#               "return-status": 3
+#           }
+#       }
+##
+{ 'command': 'mcd-open-server',
+  'data': {
+    'system-key'   : 'str',
+    'config-string': 'str' },
+  'returns': 'MCDOpenServerResult' }
+
+
+##
+# @MCDCloseServerResult:
+#
+# Return value of @mcd-close-server.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCloseServerResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-close-server:
+#
+# Function closing the connection to a debug server on a host computer.
+#
+# @server-uid: Unique identifier of the open server as returned by
+#              @mcd-open-server.
+#
+# Returns: @MCDCloseServerResult.
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-close-server',
+  'data': { 'server-uid': 'uint32' },
+  'returns': 'MCDCloseServerResult' }
+
+
 ##
 # == Core Connection API
 ##
diff --git a/tests/qtest/libmcd-test.c b/tests/qtest/libmcd-test.c
index 597ebec9b5..043ac09cad 100644
--- a/tests/qtest/libmcd-test.c
+++ b/tests/qtest/libmcd-test.c
@@ -86,3 +86,63 @@ MCDErrorInfo *qtest_mcd_qry_error_info(QTestState *qts)
 
     return unmarshal;
 }
+
+MCDQryServersResult *qtest_mcd_qry_servers(QTestState *qts,
+                                           q_obj_mcd_qry_servers_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryServersResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_servers_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-qry-servers',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryServersResult);
+
+    return unmarshal;
+}
+
+MCDOpenServerResult *qtest_mcd_open_server(QTestState *qts,
+                                           q_obj_mcd_open_server_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDOpenServerResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_open_server_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-open-server',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDOpenServerResult);
+
+    return unmarshal;
+}
+
+MCDCloseServerResult *qtest_mcd_close_server(QTestState *qts,
+                                             q_obj_mcd_close_server_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDCloseServerResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_close_server_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-close-server',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDCloseServerResult);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/libmcd-test.h b/tests/qtest/libmcd-test.h
index 1c5da9de62..473416f99f 100644
--- a/tests/qtest/libmcd-test.h
+++ b/tests/qtest/libmcd-test.h
@@ -20,4 +20,13 @@ MCDInitializeResult *qtest_mcd_initialize(QTestState *qts,
 
 MCDErrorInfo *qtest_mcd_qry_error_info(QTestState *qts);
 
+MCDQryServersResult *qtest_mcd_qry_servers(QTestState *qts,
+                                           q_obj_mcd_qry_servers_arg *args);
+
+MCDOpenServerResult *qtest_mcd_open_server(QTestState *qts,
+                                           q_obj_mcd_open_server_arg *args);
+
+MCDCloseServerResult *qtest_mcd_close_server(QTestState *qts,
+                                             q_obj_mcd_close_server_arg *args);
+
 #endif /* LIBMCD_TEST_H */
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index 275fb46aaa..a0a7cbba46 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -82,6 +82,100 @@ static void test_initialize(void)
     qtest_quit(qts);
 }
 
+static void test_qry_servers(void)
+{
+    QTestState *qts = qtest_init(QEMU_EXTRA_ARGS);
+
+    char host[] = "";
+
+    q_obj_mcd_qry_servers_arg qapi_args = {
+        .host = host,
+        .running = true,
+        .start_index = 0,
+        .num_servers = 0,
+    };
+
+    MCDQryServersResult *result = qtest_mcd_qry_servers(qts, &qapi_args);
+    g_assert(result->return_status == MCD_RET_ACT_NONE);
+    g_assert(result->has_num_servers);
+    g_assert(result->num_servers == 1);
+    g_assert(result->has_server_info == false);
+
+    qapi_args.num_servers = result->num_servers;
+    qapi_free_MCDQryServersResult(result);
+
+    result = qtest_mcd_qry_servers(qts, &qapi_args);
+
+    g_assert(result->return_status == MCD_RET_ACT_NONE);
+    g_assert(result->has_num_servers);
+    g_assert(result->num_servers == 1);
+    g_assert(result->has_server_info);
+
+    if (verbose) {
+        MCDServerInfo *server_info = result->server_info->value;
+        fprintf(stderr, "[INFO]\tServer info: %s (%s)\n",
+                        server_info->server,
+                        server_info->system_instance);
+    }
+
+    qapi_free_MCDQryServersResult(result);
+    qtest_quit(qts);
+}
+
+static void test_open_server(void)
+{
+    QTestState *qts = qtest_init(QEMU_EXTRA_ARGS);
+
+    char empty_string[] = "";
+
+    q_obj_mcd_open_server_arg open_server_args = {
+        .system_key = empty_string,
+        .config_string = empty_string,
+    };
+
+    q_obj_mcd_close_server_arg close_server_args;
+
+    MCDOpenServerResult *open_server_result;
+    MCDCloseServerResult *close_server_result;
+
+    open_server_result = qtest_mcd_open_server(qts, &open_server_args);
+    g_assert(open_server_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(open_server_result->has_server_uid);
+
+    close_server_args.server_uid = open_server_result->server_uid;
+    qapi_free_MCDOpenServerResult(open_server_result);
+
+    /* Check that server cannot be opened twice */
+    open_server_result = qtest_mcd_open_server(qts, &open_server_args);
+    g_assert(open_server_result->return_status != MCD_RET_ACT_NONE);
+
+    if (verbose) {
+        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(qts);
+        fprintf(stderr, "[INFO]\tServer cannot be opened twice: %s\n",
+                        error_info->error_str);
+        qapi_free_MCDErrorInfo(error_info);
+    }
+
+    qapi_free_MCDOpenServerResult(open_server_result);
+    close_server_result = qtest_mcd_close_server(qts, &close_server_args);
+    g_assert(close_server_result->return_status == MCD_RET_ACT_NONE);
+    qapi_free_MCDCloseServerResult(close_server_result);
+
+    /* Check that server cannot be closed twice */
+    close_server_result = qtest_mcd_close_server(qts, &close_server_args);
+    g_assert(close_server_result->return_status != MCD_RET_ACT_NONE);
+
+    if (verbose) {
+        MCDErrorInfo *error_info = qtest_mcd_qry_error_info(qts);
+        fprintf(stderr, "[INFO]\tServer cannot be closed twice: %s\n",
+                        error_info->error_str);
+        qapi_free_MCDErrorInfo(error_info);
+    }
+
+    qapi_free_MCDCloseServerResult(close_server_result);
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     char *v_env = getenv("V");
@@ -89,5 +183,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("mcd/initialize", test_initialize);
+    qtest_add_func("mcd/qry-servers", test_qry_servers);
+    qtest_add_func("mcd/open-server", test_open_server);
     return g_test_run();
 }
-- 
2.34.1


