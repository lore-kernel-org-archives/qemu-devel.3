Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EF2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trena-0002JS-Tg; Mon, 10 Mar 2025 11:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren8-0002A8-Ca
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:43 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren2-0007iJ-0R
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:42 -0400
Received: (qmail 30984 invoked by uid 484); 10 Mar 2025 15:11:14 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.248327 secs); 10 Mar 2025 15:11:14 -0000
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
Subject: [PATCH 16/16] mcd: Implement reset control
Date: Mon, 10 Mar 2025 16:05:10 +0100
Message-Id: <20250310150510.200607-17-mario.fleischmann@lauterbach.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Provide a system reset vector and handle it similar to hmp_system_reset

We don't use a QMP related shutdown reason because the mcdserver is
implemented independent of the used communication protocol.
(In fact, another communication protocol implementation for MCD already
exists and can be found at https://gitlab.com/lauterbach/mcdrefsrv)

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/libmcd_qapi.c  |  12 +++++
 mcd/libmcd_qapi.h  |   2 +
 mcd/mcdserver.c    |  98 ++++++++++++++++++++++++++++++++--
 mcd/mcdstub_qapi.c |  61 +++++++++++++++++++++
 qapi/mcd.json      | 129 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+), 5 deletions(-)

diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
index db3d11d3e5..888a92dcb8 100644
--- a/mcd/libmcd_qapi.c
+++ b/mcd/libmcd_qapi.c
@@ -492,3 +492,15 @@ void free_mcd_txlist(mcd_txlist_st *txlist)
 
     g_free(txlist->tx);
 }
+
+MCDRstInfo *marshal_mcd_rst_info(const mcd_rst_info_st *rst_info)
+{
+    MCDRstInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDRstInfo) {
+        .class_vector = rst_info->class_vector,
+        .info_str = g_strdup(rst_info->info_str),
+    };
+
+    return marshal;
+}
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
index 133dfbf9d3..220698c957 100644
--- a/mcd/libmcd_qapi.h
+++ b/mcd/libmcd_qapi.h
@@ -56,6 +56,8 @@ MCDTx *marshal_mcd_tx(const mcd_tx_st *tx);
 
 MCDTxlist *marshal_mcd_txlist(const mcd_txlist_st *txlist);
 
+MCDRstInfo *marshal_mcd_rst_info(const mcd_rst_info_st *rst_info);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
 mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index 649c4d387b..a5995ae09e 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -21,6 +21,8 @@
 /* Custom memory space type */
 static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
 
+#define MCD_RST_CLASS_SYSTEM_RESET 0
+
 static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
     .return_status = MCD_RET_ACT_HANDLE_ERROR,
     .error_code = MCD_ERR_FN_UNIMPLEMENTED,
@@ -2068,24 +2070,110 @@ mcd_return_et mcd_execute_command_f(const mcd_core_st *core,
 mcd_return_et mcd_qry_rst_classes_f(const mcd_core_st *core,
                                     uint32_t *rst_class_vector)
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
+    if (!rst_class_vector) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    *rst_class_vector = (1 << MCD_RST_CLASS_SYSTEM_RESET);
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_rst_class_info_f(const mcd_core_st *core,
                                        uint8_t rst_class,
                                        mcd_rst_info_st *rst_info)
 {
+    mcdcore_state *core_state;
 
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
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
+    if (rst_class != MCD_RST_CLASS_SYSTEM_RESET) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown reset class",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (!rst_info) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    *rst_info = (mcd_rst_info_st) {
+        .class_vector = (1 << MCD_RST_CLASS_SYSTEM_RESET),
+        .info_str = "System Reset",
+    };
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
 mcd_return_et mcd_rst_f(const mcd_core_st *core, uint32_t rst_class_vector,
                         bool rst_and_halt)
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
+    if (rst_class_vector != (1 << MCD_RST_CLASS_SYSTEM_RESET)) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown reset class",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (rst_and_halt) {
+        mcd_return_et ret = mcd_stop_f(core, true);
+        if (ret != MCD_RET_ACT_NONE) {
+            return ret;
+        }
+    }
+
+    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_UI);
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_chl_open_f(const mcd_core_st *core, mcd_chl_st *channel)
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index a1d5cbc5d9..224a8d2b50 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -622,6 +622,67 @@ MCDQryStateResult *qmp_mcd_qry_state(uint32_t core_uid, Error **errp)
     return result;
 }
 
+MCDQryRstClassesResult *qmp_mcd_qry_rst_classes(uint32_t core_uid, Error **errp)
+{
+    MCDQryRstClassesResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_rst_classes_f(core,
+                                                  &result->rst_class_vector);
+    result->has_rst_class_vector = result->return_status == MCD_RET_ACT_NONE;
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryRstClassInfoResult *qmp_mcd_qry_rst_class_info(uint32_t core_uid,
+                                                     uint8_t rst_class,
+                                                     Error **errp)
+{
+    MCDQryRstClassInfoResult *result = g_malloc0(sizeof(*result));
+    mcd_rst_info_st rst_info;
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_qry_rst_class_info_f(core, rst_class,
+                                                     &rst_info);
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->rst_info = marshal_mcd_rst_info(&rst_info);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDRstResult *qmp_mcd_rst(uint32_t core_uid, uint32_t rst_class_vector,
+                          bool rst_and_halt, Error **errp)
+{
+    MCDRstResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_rst_f(core, rst_class_vector, rst_and_halt);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
 MCDQryTrigInfoResult *qmp_mcd_qry_trig_info(uint32_t core_uid, Error **errp)
 {
     MCDQryTrigInfoResult *result = g_malloc0(sizeof(*result));
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 8934d2d057..b90cdfab03 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -610,6 +610,24 @@
     'stop-str'    : 'str',
     'info-str'    : 'str' } }
 
+
+##
+# @MCDRstInfo:
+#
+# Structure type containing information about a particular reset class.
+#
+# @class-vector: Reset class vector which issues this reset. Exactly one bit
+#                may be set.
+# @info-str:     Description of the reset class.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRstInfo',
+  'data': {
+    'class-vector': 'uint32',
+    'info-str'    : 'str' } }
+
+
 ##
 # == Target Initialization API
 ##
@@ -1881,6 +1899,117 @@
   'returns': 'MCDQryStateResult' }
 
 
+##
+# == Reset Control API
+##
+
+
+##
+# @MCDQryRstClassesResult:
+#
+# Return value of @mcd-qry-rst-classes.
+#
+# @return-status:    Return code.
+# @rst-class-vector: A 32 bit vector that defines the available reset classes.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryRstClassesResult',
+   'data': {
+     'return-status': 'uint32',
+     '*rst-class-vector': 'uint32' }}
+
+
+##
+# @mcd-qry-rst-classes:
+#
+# Function querying information about reset classes supported by the target
+# system.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+#
+# Returns: @MCDQryRstClassesResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-rst-classes',
+  'data': { 'core-uid': 'uint32' },
+  'returns': 'MCDQryRstClassesResult' }
+
+
+##
+# @MCDQryRstClassInfoResult:
+#
+# Return value of @mcd-qry-rst-class-info.
+#
+# @return-status: Return code.
+# @rst-info:      Detailed information about the reset class.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryRstClassInfoResult',
+  'data': {
+    'return-status': 'uint32',
+    '*rst-info': 'MCDRstInfo' }}
+
+
+##
+# @mcd-qry-rst-class-info:
+#
+# Function querying information about a particular reset class supported by the
+# target system.
+#
+# @core-uid:  Unique identifier of the open core as returned by @mcd-open-core.
+# @rst-class: Reset class ID which refers to a bit in the 32-bit reset class
+#             vector as obtained by @mcd-qry-rst-classes.
+#
+# Returns: @MCDQryRstClassInfoResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-rst-class-info',
+  'data': {
+    'core-uid' : 'uint32',
+    'rst-class': 'uint8'},
+  'returns': 'MCDQryRstClassInfoResult' }
+
+
+##
+# @MCDRstResult:
+#
+# Return value of @mcd-rst.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRstResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-rst:
+#
+# Function triggering one or more reset signals in parallel on the target
+# system.
+#
+# @core-uid:         Unique identifier of the open core as returned by
+#                    @mcd-open-core.
+# @rst-class-vector: Reset vector specifying the resets which shall be issued.
+# @rst-and-halt:     Optionally halting the core if the reset changes the core
+#                    state.
+#
+# Returns: @MCDRstResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-rst',
+  'data': {
+    'core-uid'        : 'uint32',
+    'rst-class-vector': 'uint32',
+    'rst-and-halt'    : 'bool'},
+  'returns': 'MCDRstResult' }
+
+
 ##
 # == Target Trigger Setup API
 ##
-- 
2.34.1


