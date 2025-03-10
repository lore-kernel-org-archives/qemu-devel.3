Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE19C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tren4-00026h-2z; Mon, 10 Mar 2025 11:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremz-00021y-2v
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:33 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremu-0007fk-F6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:32 -0400
Received: (qmail 30673 invoked by uid 484); 10 Mar 2025 15:11:09 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013291 secs); 10 Mar 2025 15:11:09 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:09 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 03/16] mcd: Implement target initialization API
Date: Mon, 10 Mar 2025 16:04:57 +0100
Message-Id: <20250310150510.200607-4-mario.fleischmann@lauterbach.com>
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

The target initialization API ensures that the requested and provided
MCD versions are compatible.

* implement mcd_initialize_f and mcd_qry_error_info_f in mcdserver
* implement QMP stub functionality
* add QTest

Thanks to the QMP integration in QTest, function arguments and results
can be (de)serialized automatically.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 MAINTAINERS               |   2 +
 mcd/libmcd_qapi.c         |  66 ++++++++++++++
 mcd/libmcd_qapi.h         |  26 ++++++
 mcd/mcdserver.c           |  44 ++++++++-
 mcd/mcdstub_qapi.c        |  35 ++++++++
 mcd/meson.build           |   2 +-
 qapi/mcd.json             | 183 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/libmcd-test.c |  88 ++++++++++++++++++
 tests/qtest/libmcd-test.h |  23 +++++
 tests/qtest/mcd-test.c    |  93 +++++++++++++++++++
 tests/qtest/meson.build   |   2 +
 11 files changed, 562 insertions(+), 2 deletions(-)
 create mode 100644 mcd/libmcd_qapi.c
 create mode 100644 mcd/libmcd_qapi.h
 create mode 100644 tests/qtest/libmcd-test.c
 create mode 100644 tests/qtest/libmcd-test.h
 create mode 100644 tests/qtest/mcd-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 58d94b392f..0687a6baef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3107,6 +3107,8 @@ S: Maintained
 F: mcd/*
 F: docs/interop/mcd.rst
 F: qapi/mcd.json
+F: tests/qtest/libmcd-test.*
+F: tests/qtest/mcd-test.c
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
new file mode 100644
index 0000000000..bc147072a1
--- /dev/null
+++ b/mcd/libmcd_qapi.c
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
+#include "libmcd_qapi.h"
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
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
new file mode 100644
index 0000000000..fc7436bf65
--- /dev/null
+++ b/mcd/libmcd_qapi.h
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
+#ifndef LIBMCD_QAPI_H
+#define LIBMCD_QAPI_H
+
+#include "mcd_api.h"
+#include "qapi-types-mcd.h"
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
+#endif /* LIBMCD_QAPI_H */
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index a20708db1b..6e941f0531 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
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
 
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index 6f79ae38a9..a76d2d081f 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -10,4 +10,39 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "mcd_api.h"
+#include "libmcd_qapi.h"
+#include "qapi/qapi-commands-mcd.h"
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
index bc783dae54..90d1c6be67 100644
--- a/mcd/meson.build
+++ b/mcd/meson.build
@@ -1,7 +1,7 @@
 # MCD is only supported in system emulation
 mcd_system_ss = ss.source_set()
 
-mcd_system_ss.add(files('mcdserver.c', 'mcdstub_qapi.c'))
+mcd_system_ss.add(files('mcdserver.c', 'mcdstub_qapi.c', 'libmcd_qapi.c'))
 mcd_system_ss = mcd_system_ss.apply({})
 
 libmcd_system = static_library('mcd_system',
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 701fd03ece..7b42a74036 100644
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
diff --git a/tests/qtest/libmcd-test.c b/tests/qtest/libmcd-test.c
new file mode 100644
index 0000000000..597ebec9b5
--- /dev/null
+++ b/tests/qtest/libmcd-test.c
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QTest helpers for functions of the MCD API
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libmcd-test.h"
+#include "mcd/mcd_api.h"
+#include "mcd/libmcd_qapi.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qjson.h"
+#include "qapi/qapi-commands-mcd.h"
+#include "qapi/qapi-visit-mcd.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/compat-policy.h"
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
+MCDInitializeResult *qtest_mcd_initialize(QTestState *qts,
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
+    resp = qtest_qmp(qts, "{'execute': 'mcd-initialize',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDInitializeResult);
+
+    return unmarshal;
+}
+
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestState *qts)
+{
+    Visitor *v;
+    QDict *resp;
+    QObject *ret;
+    bool ok;
+    MCDErrorInfo *unmarshal;
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-qry-error-info'}");
+
+    UNMARSHAL_RESULT(MCDErrorInfo);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/libmcd-test.h b/tests/qtest/libmcd-test.h
new file mode 100644
index 0000000000..1c5da9de62
--- /dev/null
+++ b/tests/qtest/libmcd-test.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QTest helpers for functions of the MCD API
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBMCD_TEST_H
+#define LIBMCD_TEST_H
+
+#include "libqtest.h"
+#include "mcd/mcd_api.h"
+#include "qapi/qapi-visit-mcd.h"
+
+MCDInitializeResult *qtest_mcd_initialize(QTestState *qts,
+                                          q_obj_mcd_initialize_arg *args);
+
+MCDErrorInfo *qtest_mcd_qry_error_info(QTestState *qts);
+
+#endif /* LIBMCD_TEST_H */
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
new file mode 100644
index 0000000000..275fb46aaa
--- /dev/null
+++ b/tests/qtest/mcd-test.c
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Architecture independent QTests for the MCD server with QAPI stub
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "mcd/mcd_api.h"
+#include "mcd/libmcd_qapi.h"
+#include "qapi/qapi-visit-mcd.h"
+#include "qapi/qapi-types-mcd.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/compat-policy.h"
+#include "libmcd-test.h"
+
+#define QEMU_EXTRA_ARGS ""
+
+static bool verbose;
+
+static void test_initialize(void)
+{
+    QTestState *qts = qtest_init(QEMU_EXTRA_ARGS);
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
+    MCDInitializeResult *result = qtest_mcd_initialize(qts, &qapi_args);
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
+    result = qtest_mcd_initialize(qts, &qapi_args);
+    g_assert(result->return_status != MCD_RET_ACT_NONE);
+
+    error_info = qtest_mcd_qry_error_info(qts);
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
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    char *v_env = getenv("V");
+    verbose = v_env && atoi(v_env) >= 1;
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("mcd/initialize", test_initialize);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8a6243382a..1e39a7191b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -30,6 +30,7 @@ qtests_generic = [
   'qos-test',
   'readconfig-test',
   'netdev-socket',
+  'mcd-test',
 ]
 if enable_modules
   qtests_generic += [ 'modules-test' ]
@@ -383,6 +384,7 @@ qtests = {
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
+  'mcd-test': files('mcd-test.c', 'libmcd-test.c', '../../mcd/libmcd_qapi.c'),
 }
 
 if vnc.found()
-- 
2.34.1


