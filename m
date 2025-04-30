Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0233C3ABAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9zzh-0002BL-3z; Wed, 30 Apr 2025 01:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzd-0002A4-JY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:25 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zza-0006hu-7Q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:25 -0400
Received: (qmail 1768 invoked by uid 484); 30 Apr 2025 05:28:04 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013014 secs); 30 Apr 2025 05:28:04 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:04 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 07/20] mcd: Implement target initialization API
Date: Wed, 30 Apr 2025 07:27:28 +0200
Message-Id: <20250430052741.21145-8-mario.fleischmann@lauterbach.com>
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

The target initialization API ensures that the requested and provided
MCD versions are compatible.

* implement mcd_initialize_f and mcd_qry_error_info_f in mcdserver
* implement QMP stub functionality
* add QTest

Thanks to the QMP integration in QTest, function arguments and results
can be (de)serialized automatically.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/mcd_qapi.c          |  66 +++++++++++++++
 mcd/mcd_qapi.h          |  26 ++++++
 mcd/mcd_server.c        |  44 +++++++++-
 mcd/mcd_stub.c          |  35 ++++++++
 mcd/meson.build         |  49 +++++++----
 qapi/mcd.json           | 183 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/mcd-test.c  |  62 ++++++++++++++
 tests/qtest/mcd-util.c  |  99 ++++++++++++++++++++++
 tests/qtest/mcd-util.h  |   6 ++
 tests/qtest/meson.build |   2 +-
 10 files changed, 554 insertions(+), 18 deletions(-)
 create mode 100644 mcd/mcd_qapi.c
 create mode 100644 mcd/mcd_qapi.h
 create mode 100644 tests/qtest/mcd-util.c

diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
new file mode 100644
index 0000000..9a99866
--- /dev/null
+++ b/mcd/mcd_qapi.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QAPI marshalling helpers for structures of the MCD API
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "mcd_qapi.h"
+
+MCDAPIVersion *marshal_mcd_api_version(const mcd_api_version_st *api_version)
+{
+    MCDAPIVersion *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDAPIVersion) {
+        .v_api_major = api_version->v_api_major,
+        .v_api_minor = api_version->v_api_minor,
+        .author = g_strdup(api_version->author),
+    };
+
+    return marshal;
+}
+
+mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version)
+{
+    mcd_api_version_st unmarshal =  {
+        .v_api_major = api_version->v_api_major,
+        .v_api_minor = api_version->v_api_minor,
+    };
+    strncpy(unmarshal.author, api_version->author, MCD_API_IMP_VENDOR_LEN - 1);
+    return unmarshal;
+}
+
+MCDImplVersionInfo *marshal_mcd_impl_version_info(
+    const mcd_impl_version_info_st *impl_info)
+{
+    MCDImplVersionInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDImplVersionInfo) {
+        .v_api = marshal_mcd_api_version(&impl_info->v_api),
+        .v_imp_major = impl_info->v_imp_major,
+        .v_imp_minor = impl_info->v_imp_minor,
+        .v_imp_build = impl_info->v_imp_build,
+        .vendor = g_strdup(impl_info->vendor),
+        .date = g_strdup(impl_info->date),
+    };
+
+    return marshal;
+}
+
+MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info)
+{
+    MCDErrorInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDErrorInfo) {
+        .return_status = error_info->return_status,
+        .error_code = error_info->error_code,
+        .error_events = error_info->error_events,
+        .error_str = g_strdup(error_info->error_str),
+    };
+
+    return marshal;
+}
diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
new file mode 100644
index 0000000..47f4e16
--- /dev/null
+++ b/mcd/mcd_qapi.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QAPI marshalling helpers for structures of the MCD API
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MCD_QAPI_H
+#define MCD_QAPI_H
+
+#include "mcd_api.h"
+#include "mcd/mcd-qapi-types.h"
+
+MCDAPIVersion *marshal_mcd_api_version(const mcd_api_version_st *api_version);
+
+MCDImplVersionInfo *marshal_mcd_impl_version_info(
+    const mcd_impl_version_info_st *impl_info);
+
+MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info);
+
+mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
+
+#endif /* MCD_QAPI_H */
diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
index a20708d..6e941f0 100644
--- a/mcd/mcd_server.c
+++ b/mcd/mcd_server.c
@@ -8,6 +8,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "mcd_api.h"
 
 static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
@@ -17,6 +18,13 @@ static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
     .error_str = "",
 };
 
+static const mcd_error_info_st MCD_ERROR_INVALID_NULL_PARAM = {
+    .return_status = MCD_RET_ACT_HANDLE_ERROR,
+    .error_code = MCD_ERR_PARAM,
+    .error_events = MCD_ERR_EVT_NONE,
+    .error_str = "null was invalidly passed as a parameter",
+};
+
 static const mcd_error_info_st MCD_ERROR_NONE = {
     .return_status = MCD_RET_ACT_NONE,
     .error_code = MCD_ERR_NONE,
@@ -24,6 +32,9 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
     .error_str = "",
 };
 
+/* reserves memory for custom errors */
+static mcd_error_info_st custom_mcd_error;
+
 /**
  * struct mcdserver_state - State of the MCD server
  *
@@ -40,12 +51,43 @@ static mcdserver_state g_server_state = {
 mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
                                mcd_impl_version_info_st *impl_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (!version_req || !impl_info) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    *impl_info = (mcd_impl_version_info_st) {
+        .v_api = (mcd_api_version_st) {
+            .v_api_major = MCD_API_VER_MAJOR,
+            .v_api_minor = MCD_API_VER_MINOR,
+            .author = MCD_API_VER_AUTHOR,
+        },
+        .v_imp_major = QEMU_VERSION_MAJOR,
+        .v_imp_minor = QEMU_VERSION_MINOR,
+        .v_imp_build = 0,
+        .vendor = "QEMU",
+        .date = __DATE__,
+    };
+
+    if (version_req->v_api_major == MCD_API_VER_MAJOR &&
+        version_req->v_api_minor <= MCD_API_VER_MINOR) {
+        g_server_state.last_error = &MCD_ERROR_NONE;
+    } else {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_GENERAL,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "incompatible versions",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+    }
+
     return g_server_state.last_error->return_status;
 }
 
 void mcd_exit_f(void)
 {
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return;
 }
 
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
index de679a4..23db1cf 100644
--- a/mcd/mcd_stub.c
+++ b/mcd/mcd_stub.c
@@ -8,4 +8,39 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "mcd_api.h"
+#include "mcd_qapi.h"
+#include "mcd/mcd-qapi-commands.h"
+
+MCDInitializeResult *qmp_mcd_initialize(MCDAPIVersion *version_req,
+                                        Error **errp)
+{
+    mcd_impl_version_info_st impl_info;
+    MCDInitializeResult *result = g_malloc0(sizeof(*result));
+    mcd_api_version_st version_req_unmarshalled =
+        unmarshal_mcd_api_version(version_req);
+
+    result->return_status = mcd_initialize_f(&version_req_unmarshalled,
+                                             &impl_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->impl_info = marshal_mcd_impl_version_info(&impl_info);
+    }
+
+    return result;
+}
+
+void qmp_mcd_exit(Error **errp)
+{
+    mcd_exit_f();
+}
+
+MCDErrorInfo *qmp_mcd_qry_error_info(Error **errp)
+{
+    MCDErrorInfo *result;
+    mcd_error_info_st error_info;
+    mcd_qry_error_info_f(NULL, &error_info);
+    result = marshal_mcd_error_info(&error_info);
+    return result;
+}
diff --git a/mcd/meson.build b/mcd/meson.build
index 191f0cc..2adaa1b 100644
--- a/mcd/meson.build
+++ b/mcd/meson.build
@@ -1,14 +1,10 @@
 mcd_qapi_outputs = [
-  'mcd-qapi-commands.c',
-  'mcd-qapi-commands.h',
   'mcd-qapi-emit-events.c',
   'mcd-qapi-emit-events.h',
   'mcd-qapi-events.c',
   'mcd-qapi-events.h',
   'mcd-qapi-features.c',
   'mcd-qapi-features.h',
-  'mcd-qapi-init-commands.c',
-  'mcd-qapi-init-commands.h',
   'mcd-qapi-introspect.c',
   'mcd-qapi-introspect.h',
   'mcd-qapi-types.c',
@@ -17,27 +13,48 @@ mcd_qapi_outputs = [
   'mcd-qapi-visit.h',
 ]
 
+# QAPI outputs that will only be used by the MCD server
+mcd_qapi_server_outputs = [
+  'mcd-qapi-commands.c',
+  'mcd-qapi-commands.h',
+  'mcd-qapi-init-commands.c',
+  'mcd-qapi-init-commands.h'
+]
+
 mcd_qapi_files = custom_target('MCD QAPI files',
-                               output: mcd_qapi_outputs,
+                               output: mcd_qapi_outputs + mcd_qapi_server_outputs,
                                input: '../qapi/mcd.json',
                                command: [ qapi_gen, '-p', 'mcd-', '-o', 'mcd',
                                           '--suppress-tracing','@INPUT0@'],
                                depend_files: qapi_gen_depends)
 
-mcd_ss = ss.source_set()
+mcd_qapi_ss = ss.source_set()
 
-mcd_ss.add(mcd_qapi_files.to_list())
-mcd_ss.add(files(
-  'mcd_server.c',
-  'mcd_stub.c',
-  'mcd_monitor.c'))
+foreach f : mcd_qapi_files.to_list()
+  if mcd_qapi_outputs.contains(fs.name(f))
+    mcd_qapi_ss.add([f])
+  endif
+endforeach
 
-mcd_ss = mcd_ss.apply({})
+mcd_qapi_ss.add(files('mcd_qapi.c'))
+mcd_qapi_ss = mcd_qapi_ss.apply({})
 
-libmcd = static_library('mcd_system',
-                        mcd_ss.sources() + genh,
+libmcd_qapi = static_library('mcd_qapi',
+                        mcd_qapi_ss.sources() + genh,
                         build_by_default: false)
 
-mcd = declare_dependency(objects: libmcd.extract_all_objects(recursive: false))
+mcd_qapi = declare_dependency(
+    objects: libmcd_qapi.extract_all_objects(recursive: false))
+
+foreach f : mcd_qapi_files.to_list()
+  if mcd_qapi_server_outputs.contains(fs.name(f))
+    libsystem_ss.add([f])
+  endif
+endforeach
+
+libsystem_ss.add(files(
+  'mcd_server.c',
+  'mcd_stub.c',
+  'mcd_monitor.c'))
 
-system_ss.add(mcd)
+libsystem_ss.add(mcd_qapi)
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 701fd03..7b42a74 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -4,3 +4,186 @@
 ##
 # = Multi-Core Debug (MCD) API
 ##
+
+
+##
+# == Definition of Structures
+##
+
+
+##
+# @MCDAPIVersion:
+#
+# Structure type containing the MCD API version information of the tool.
+#
+# @v-api-major: API major version.
+# @v-api-minor: API minor version.
+# @author:      API name of the author of this MCD API version.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDAPIVersion',
+  'data': {
+    'v-api-major': 'uint16',
+    'v-api-minor': 'uint16',
+    'author':      'str' } }
+
+
+##
+# @MCDImplVersionInfo:
+#
+# Structure type containing the MCD API implementation information.
+#
+# @v-api:       Implemented API version.
+# @v-imp-major: Major version number of this implementation.
+# @v-imp-minor: Minor version number of this implementation.
+# @v-imp-build: Build number of this implementation.
+# @vendor:      Name of vendor of the implementation.
+# @date:        String from __DATE__ macro at compile time.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDImplVersionInfo',
+  'data': {
+    'v-api'      : 'MCDAPIVersion',
+    'v-imp-major': 'uint16',
+    'v-imp-minor': 'uint16',
+    'v-imp-build': 'uint16',
+    'vendor'     : 'str',
+    'date'       : 'str' } }
+
+
+##
+# @MCDErrorInfo:
+#
+# Structure type containing the error status and error event notification.
+#
+# @return-status: Return status from the last API call.
+# @error-code:    Detailed error code from the last API call.
+# @error-events:  Detailed event code from the last API call.
+# @error-str:     Detailed error text string from the last API call.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDErrorInfo',
+  'data': {
+    'return-status': 'uint32',
+    'error-code'   : 'uint32',
+    'error-events' : 'uint32',
+    'error-str'    : 'str' }}
+
+
+##
+# == Target Initialization API
+##
+
+
+##
+# @MCDInitializeResult:
+#
+# Return value of @mcd-initialize.
+#
+# @return-status: Return code.
+#
+# @impl-info: Information about the QEMU build, its version and the version of
+#             the implemented MCD API.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDInitializeResult',
+  'data': {
+    'return-status': 'uint32',
+    '*impl-info'   : 'MCDImplVersionInfo' } }
+
+
+##
+# @mcd-initialize:
+#
+# Function initializing the interaction between a tool-side implementation and
+# target-side implementation.
+#
+# @version-req: MCD API version as requested by an upper layer.
+#
+# Returns: @MCDInitializeResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#    :title: Check compatibility with MCD server
+#
+#     -> { "execute": "mcd-initialize",
+#          "arguments": { "version-req": { "v-api-major": 1,
+#                                          "v-api-minor": 1,
+#                                          "author": "" } } }
+#     <- {
+#            "return": {
+#                "impl-info": {
+#                    "v-api": {
+#                        "v-api-minor": 1,
+#                        "v-api-major": 1,
+#                        "author": "QEMU Release"
+#                    },
+#                    "vendor": "QEMU",
+#                    "v-imp-minor": 2,
+#                    "v-imp-major": 9,
+#                    "v-imp-build": 0,
+#                    "date": "Dec 18 2024"
+#                },
+#                "return-status": 0
+#            }
+#        }
+##
+{ 'command': 'mcd-initialize',
+  'data': { 'version-req': 'MCDAPIVersion' },
+  'returns': 'MCDInitializeResult' }
+
+
+##
+# @mcd-exit:
+#
+# Function cleaning up all core and server connections from a tool.
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-exit' }
+
+
+##
+# == Core Connection API
+##
+
+
+##
+# @mcd-qry-error-info:
+#
+# Function allowing the access to detailed error and/or event information after
+# an API call.
+#
+# Returns: @MCDErrorInfo
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#    :title: Incompatible MCD versions
+#
+#     -> { "execute": "mcd-initialize",
+#          "arguments": { "version-req": { "v-api-major": 2,
+#                                          "v-api-minor": 0,
+#                                          "author": "" } } }
+#     <- {
+#            "return": {
+#                "return-status": 3
+#            }
+#        }
+#     -> { "execute": "mcd-qry-error-info" }
+#     <- {
+#            "return": {
+#                "error-str": "incompatible versions",
+#                "error-code": 3840,
+#                "error-events": 0,
+#                "return-status": 3
+#            }
+#        }
+##
+{ 'command': 'mcd-qry-error-info',
+  'returns': 'MCDErrorInfo' }
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index b9ee3f4..9911804 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -22,6 +22,7 @@
 #include <sys/procctl.h>
 #endif /* __FreeBSD__ */
 
+#include "mcd/mcd_qapi.h"
 #include "libqtest.h"
 #include "mcd-util.h"
 
@@ -71,6 +72,66 @@ static void test_initialize_mcdtest(void)
     mcdtest_quit(&qts);
 }
 
+static void test_initialize(void)
+{
+    QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
+    MCDErrorInfo *error_info;
+
+    mcd_api_version_st version_req = {
+        .v_api_major = MCD_API_VER_MAJOR,
+        .v_api_minor = MCD_API_VER_MINOR,
+        .author = "",
+    };
+
+    q_obj_mcd_initialize_arg qapi_args = {
+        .version_req = marshal_mcd_api_version(&version_req),
+    };
+
+    MCDInitializeResult *result = qtest_mcd_initialize(&qts, &qapi_args);
+    g_assert(result->return_status == MCD_RET_ACT_NONE);
+
+    if (verbose) {
+        fprintf(stderr, "[INFO]\tAPI v%d.%d (%s)\n",
+                        result->impl_info->v_api->v_api_major,
+                        result->impl_info->v_api->v_api_minor,
+                        result->impl_info->v_api->author);
+        fprintf(stderr, "[INFO]\tImplementation v%d.%d.%d %s (%s)\n",
+                        result->impl_info->v_imp_major,
+                        result->impl_info->v_imp_minor,
+                        result->impl_info->v_imp_build,
+                        result->impl_info->date,
+                        result->impl_info->vendor);
+    }
+
+    qapi_free_MCDAPIVersion(qapi_args.version_req);
+    qapi_free_MCDInitializeResult(result);
+
+    /* Incompatible version */
+    version_req = (mcd_api_version_st) {
+        .v_api_major = MCD_API_VER_MAJOR,
+        .v_api_minor = MCD_API_VER_MINOR + 1,
+        .author = "",
+    };
+
+    qapi_args.version_req = marshal_mcd_api_version(&version_req);
+    result = qtest_mcd_initialize(&qts, &qapi_args);
+    g_assert(result->return_status != MCD_RET_ACT_NONE);
+
+    error_info = qtest_mcd_qry_error_info(&qts);
+    g_assert(error_info->error_code == MCD_ERR_GENERAL);
+
+    if (verbose) {
+        fprintf(stderr, "[INFO]\tInitialization with newer API failed "
+                        "successfully: %s\n", error_info->error_str);
+    }
+
+    qapi_free_MCDAPIVersion(qapi_args.version_req);
+    qapi_free_MCDInitializeResult(result);
+    qapi_free_MCDErrorInfo(error_info);
+
+    mcdtest_quit(&qts);
+}
+
 int main(int argc, char *argv[])
 {
     char *v_env = getenv("V");
@@ -78,5 +139,6 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("mcd/initialize-mcdtest", test_initialize_mcdtest);
+    qtest_add_func("mcd/initialize", test_initialize);
     return g_test_run();
 }
diff --git a/tests/qtest/mcd-util.c b/tests/qtest/mcd-util.c
new file mode 100644
index 0000000..50c5d4e
--- /dev/null
+++ b/tests/qtest/mcd-util.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdutil - Utility functions for the MCD API test suite
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "mcd-util.h"
+#include "qapi/compat-policy.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qobject/qdict.h"
+
+/*
+ * We can use the %p format specifier of qtest_qmp() to automatically
+ * serialize the arguments into JSON.
+ * The serialization works only after the arguments have been converted into
+ * a QDict.
+ */
+
+ #define MARSHAL_ARGS(type) do {                     \
+    v = qobject_output_visitor_new_qmp(&marshal);    \
+    ok = visit_start_struct(v, NULL, (void **)&args, \
+                            sizeof(type), NULL);     \
+    g_assert(ok);                                    \
+    ok = visit_type_##type##_members(v, args, NULL); \
+    g_assert(ok);                                    \
+    ok = visit_check_struct(v, NULL);                \
+    g_assert(ok);                                    \
+    visit_end_struct(v, (void **)&args);             \
+    visit_complete(v, &marshal);                     \
+    visit_free(v);                                   \
+    arg = qobject_to(QDict, marshal);                \
+} while (0)
+
+#define UNMARSHAL_RESULT(type) do {                    \
+    ret = qdict_get(resp, "return");                   \
+    g_assert(ret);                                     \
+    v = qobject_input_visitor_new(ret);                \
+    ok = visit_type_##type(v, NULL, &unmarshal, NULL); \
+    g_assert(ok);                                      \
+    visit_free(v);                                     \
+    qobject_unref(resp);                               \
+} while (0)
+
+static QDict *qtest_mcd(QTestStateMCD *s, const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
+static QDict *qtest_mcd(QTestStateMCD *s, const char *fmt, ...)
+{
+    va_list ap;
+    QDict *response;
+
+    va_start(ap, fmt);
+    qmp_fd_vsend(s->mcd_fd, fmt, ap);
+    va_end(ap);
+
+    response = qmp_fd_receive(s->mcd_fd);
+
+    return response;
+}
+
+MCDInitializeResult *qtest_mcd_initialize(QTestStateMCD *qts,
+                                          q_obj_mcd_initialize_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDInitializeResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_initialize_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-initialize',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDInitializeResult);
+
+    return unmarshal;
+}
+
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts)
+{
+    Visitor *v;
+    QDict *resp;
+    QObject *ret;
+    bool ok;
+    MCDErrorInfo *unmarshal;
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-error-info'}");
+
+    UNMARSHAL_RESULT(MCDErrorInfo);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/mcd-util.h b/tests/qtest/mcd-util.h
index 18ff8bd..2cff29c 100644
--- a/tests/qtest/mcd-util.h
+++ b/tests/qtest/mcd-util.h
@@ -12,10 +12,16 @@
 #define TEST_MCD_UTILS_H
 
 #include "libqtest.h"
+#include "mcd/mcd-qapi-visit.h"
 
 typedef struct {
     QTestState *qts;
     int mcd_fd;
 } QTestStateMCD;
 
+MCDInitializeResult *qtest_mcd_initialize(QTestStateMCD *qts,
+                                          q_obj_mcd_initialize_arg *args);
+
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts);
+
 #endif /* TEST_MCD_UTILS_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3dc9508..11a9270 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -398,7 +398,7 @@ if dbus_display
 endif
 
 if get_option('mcd').enabled()
-  qtests += { 'mcd-test': files('mcd-test.c') }
+  qtests += { 'mcd-test': files('mcd-test.c', 'mcd-util.c') + mcd_qapi }
   qtests_generic += [ 'mcd-test' ]
 endif
 
-- 
2.34.1


