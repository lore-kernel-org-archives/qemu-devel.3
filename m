Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE5FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tren1-00022q-A4; Mon, 10 Mar 2025 11:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremz-000220-35
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:33 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremu-0007fU-OE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:32 -0400
Received: (qmail 30644 invoked by uid 484); 10 Mar 2025 15:11:09 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.257821 secs); 10 Mar 2025 15:11:09 -0000
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 02/16] mcd: Introduce MCD server
Date: Mon, 10 Mar 2025 16:04:56 +0100
Message-Id: <20250310150510.200607-3-mario.fleischmann@lauterbach.com>
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

The MCD implementation follows a remote procedure call approach
and uses QMP as the communication protocol:

* mcdserver implements the MCD API
* mcd.json and mcdstub_qapi.c declare and implement the server stub

Our client stub supporting QMP can be found at:
https://gitlab.com/lauterbach/mcdrefsrv

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 MAINTAINERS           |   1 +
 docs/interop/mcd.rst  |  14 ++
 mcd/mcdserver.c       | 431 ++++++++++++++++++++++++++++++++++++++++++
 mcd/mcdstub_qapi.c    |  13 ++
 mcd/meson.build       |  12 ++
 meson.build           |   1 +
 qapi/mcd.json         |   6 +
 qapi/meson.build      |   1 +
 qapi/qapi-schema.json |   1 +
 9 files changed, 480 insertions(+)
 create mode 100644 mcd/mcdserver.c
 create mode 100644 mcd/mcdstub_qapi.c
 create mode 100644 mcd/meson.build
 create mode 100644 qapi/mcd.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 448fb55a09..58d94b392f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3106,6 +3106,7 @@ M: Mario Fleischmann <mario.fleischmann@lauterbach.com>
 S: Maintained
 F: mcd/*
 F: docs/interop/mcd.rst
+F: qapi/mcd.json
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/docs/interop/mcd.rst b/docs/interop/mcd.rst
index 9587cfb010..de7b7a8d5c 100644
--- a/docs/interop/mcd.rst
+++ b/docs/interop/mcd.rst
@@ -38,6 +38,20 @@ The resulting system can be visualized as follows::
     | qemu-system-*  |      | -machine |           | -cpu |
     +----------------+      +----------+           +------+
 
+
+Debugging via QMP
+-----------------
+
+Since the MCD API does not define a communication protocol, the QEMU Machine
+Protocol (QMP) is utilized to implement a remote procedure call mechanism.
+Each function within the API corresponds to one QMP command, ensuring a
+one-to-one mapping between the API's functions and the QMP commands.
+
+If you are not familiar with QMP, see the :doc:`qmp-spec` for the
+protocol, and the :doc:`qemu-qmp-ref` for a full reference of all
+commands.
+
+
 API Reference
 -------------
 
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
new file mode 100644
index 0000000000..a20708db1b
--- /dev/null
+++ b/mcd/mcdserver.c
@@ -0,0 +1,431 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdserver - Multi-Core Debug (MCD) API implementation
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "mcd_api.h"
+
+static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
+    .return_status = MCD_RET_ACT_HANDLE_ERROR,
+    .error_code = MCD_ERR_FN_UNIMPLEMENTED,
+    .error_events = MCD_ERR_EVT_NONE,
+    .error_str = "",
+};
+
+static const mcd_error_info_st MCD_ERROR_NONE = {
+    .return_status = MCD_RET_ACT_NONE,
+    .error_code = MCD_ERR_NONE,
+    .error_events = MCD_ERR_EVT_NONE,
+    .error_str = "",
+};
+
+/**
+ * struct mcdserver_state - State of the MCD server
+ *
+ * @last_error: Error info of most recent executed function.
+ */
+typedef struct mcdserver_state {
+    const mcd_error_info_st *last_error;
+} mcdserver_state;
+
+static mcdserver_state g_server_state = {
+    .last_error = &MCD_ERROR_NONE,
+};
+
+mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
+                               mcd_impl_version_info_st *impl_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+void mcd_exit_f(void)
+{
+    return;
+}
+
+mcd_return_et mcd_qry_servers_f(const char *host, bool running,
+                                uint32_t start_index, uint32_t *num_servers,
+                                mcd_server_info_st *server_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_open_server_f(const char *system_key,
+                                const char *config_string,
+                                mcd_server_st **server)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_close_server_f(const mcd_server_st *server)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_set_server_config_f(const mcd_server_st *server,
+                                      const char *config_string)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_server_config_f(const mcd_server_st *server,
+                                      uint32_t *max_len,
+                                      char *config_string)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_systems_f(uint32_t start_index, uint32_t *num_systems,
+                                mcd_core_con_info_st *system_con_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_devices_f(const mcd_core_con_info_st *system_con_info,
+                                uint32_t start_index, uint32_t *num_devices,
+                                mcd_core_con_info_st *device_con_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_cores_f(const mcd_core_con_info_st *connection_info,
+                              uint32_t start_index, uint32_t *num_cores,
+                              mcd_core_con_info_st *core_con_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_core_modes_f(const mcd_core_st *core,
+                                   uint32_t start_index, uint32_t *num_modes,
+                                   mcd_core_mode_info_st *core_mode_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
+                              mcd_core_st **core)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_close_core_f(const mcd_core_st *core)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+void mcd_qry_error_info_f(const mcd_core_st *core,
+                          mcd_error_info_st *error_info)
+{
+    if (error_info) {
+        *error_info = *g_server_state.last_error;
+    }
+}
+
+mcd_return_et mcd_qry_device_description_f(const mcd_core_st *core, char *url,
+                                           uint32_t *url_length)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_max_payload_size_f(const mcd_core_st *core,
+                                         uint32_t *max_payload)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_input_handle_f(const mcd_core_st *core,
+                                     uint32_t *input_handle)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_mem_spaces_f(const mcd_core_st *core,
+                                   uint32_t start_index,
+                                   uint32_t *num_mem_spaces,
+                                   mcd_memspace_st *mem_spaces)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_mem_blocks_f(const mcd_core_st *core,
+                                   uint32_t mem_space_id, uint32_t start_index,
+                                   uint32_t *num_mem_blocks,
+                                   mcd_memblock_st *mem_blocks)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_active_overlays_f(const mcd_core_st *core,
+                                        uint32_t start_index,
+                                        uint32_t *num_active_overlays,
+                                        uint32_t *active_overlays)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_reg_groups_f(const mcd_core_st *core,
+                                   uint32_t start_index,
+                                   uint32_t *num_reg_groups,
+                                   mcd_register_group_st *reg_groups)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_reg_map_f(const mcd_core_st *core, uint32_t reg_group_id,
+                                uint32_t start_index, uint32_t *num_regs,
+                                mcd_register_info_st *reg_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_reg_compound_f(const mcd_core_st *core,
+                                     uint32_t compound_reg_id,
+                                     uint32_t start_index,
+                                     uint32_t *num_reg_ids,
+                                     uint32_t *reg_id_array)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trig_info_f(const mcd_core_st *core,
+                                  mcd_trig_info_st *trig_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_ctrigs_f(const mcd_core_st *core, uint32_t start_index,
+                               uint32_t *num_ctrigs,
+                               mcd_ctrig_info_st *ctrig_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_create_trig_f(const mcd_core_st *core, void *trig,
+                                uint32_t *trig_id)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trig_f(const mcd_core_st *core, uint32_t trig_id,
+                             uint32_t max_trig_size, void *trig)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_remove_trig_f(const mcd_core_st *core, uint32_t trig_id)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trig_state_f(const mcd_core_st *core, uint32_t trig_id,
+                                   mcd_trig_state_st *trig_state)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_activate_trig_set_f(const mcd_core_st *core)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_remove_trig_set_f(const mcd_core_st *core)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trig_set_f(const mcd_core_st *core, uint32_t start_index,
+                                 uint32_t *num_trigs, uint32_t *trig_ids)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trig_set_state_f(const mcd_core_st *core,
+                                       mcd_trig_set_state_st *trig_state)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_execute_txlist_f(const mcd_core_st *core,
+                                   mcd_txlist_st *txlist)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_run_f(const mcd_core_st *core, bool global)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_stop_f(const mcd_core_st *core, bool global)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_run_until_f(const mcd_core_st *core, bool global,
+                              bool absolute_time, uint64_t run_until_time)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_current_time_f(const mcd_core_st *core,
+                                     uint64_t *current_time)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_step_f(const mcd_core_st *core, bool global,
+                         mcd_core_step_type_et step_type, uint32_t n_steps)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_set_global_f(const mcd_core_st *core, bool enable)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_state_f(const mcd_core_st *core, mcd_core_state_st *state)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_execute_command_f(const mcd_core_st *core,
+                                    const char *command_string,
+                                    uint32_t result_string_size,
+                                    char *result_string)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_rst_classes_f(const mcd_core_st *core,
+                                    uint32_t *rst_class_vector)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_rst_class_info_f(const mcd_core_st *core,
+                                       uint8_t rst_class,
+                                       mcd_rst_info_st *rst_info)
+{
+
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_rst_f(const mcd_core_st *core, uint32_t rst_class_vector,
+                        bool rst_and_halt)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_chl_open_f(const mcd_core_st *core, mcd_chl_st *channel)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_send_msg_f(const mcd_core_st *core, const mcd_chl_st *channel,
+                             uint32_t msg_len, const uint8_t *msg)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_receive_msg_f(const mcd_core_st *core,
+                                const mcd_chl_st *channel, uint32_t timeout,
+                                uint32_t *msg_len, uint8_t *msg)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_chl_reset_f(const mcd_core_st *core,
+                              const mcd_chl_st *channel)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_chl_close_f(const mcd_core_st *core,
+                              const mcd_chl_st *channel)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_traces_f(const mcd_core_st *core, uint32_t start_index,
+                               uint32_t *num_traces,
+                               mcd_trace_info_st *trace_info)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_qry_trace_state_f(const mcd_core_st *core, uint32_t trace_id,
+                                    mcd_trace_state_st *state)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_set_trace_state_f(const mcd_core_st *core, uint32_t trace_id,
+                                    mcd_trace_state_st *state)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
+
+mcd_return_et mcd_read_trace_f(const mcd_core_st *core, uint32_t trace_id,
+                               uint64_t start_index, uint32_t *num_frames,
+                               uint32_t trace_data_size, void *trace_data)
+{
+    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    return g_server_state.last_error->return_status;
+}
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
new file mode 100644
index 0000000000..6f79ae38a9
--- /dev/null
+++ b/mcd/mcdstub_qapi.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * MCD server stub using QMP
+ *
+ * see qapi/mcd.json for the declarations of the (un)marshalling functions
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "mcd_api.h"
diff --git a/mcd/meson.build b/mcd/meson.build
new file mode 100644
index 0000000000..bc783dae54
--- /dev/null
+++ b/mcd/meson.build
@@ -0,0 +1,12 @@
+# MCD is only supported in system emulation
+mcd_system_ss = ss.source_set()
+
+mcd_system_ss.add(files('mcdserver.c', 'mcdstub_qapi.c'))
+mcd_system_ss = mcd_system_ss.apply({})
+
+libmcd_system = static_library('mcd_system',
+                                mcd_system_ss.sources() + genh,
+                                build_by_default: false)
+
+mcd_system = declare_dependency(objects: libmcd_system.extract_all_objects(recursive: false))
+system_ss.add(mcd_system)
diff --git a/meson.build b/meson.build
index 4899d896de..5e1b4865f7 100644
--- a/meson.build
+++ b/meson.build
@@ -3685,6 +3685,7 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 subdir('gdbstub')
+subdir('mcd')
 if have_system
   subdir('hw')
 else
diff --git a/qapi/mcd.json b/qapi/mcd.json
new file mode 100644
index 0000000000..701fd03ece
--- /dev/null
+++ b/qapi/mcd.json
@@ -0,0 +1,6 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = Multi-Core Debug (MCD) API
+##
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db30..d05f17fe95 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -40,6 +40,7 @@ qapi_all_modules = [
   'machine-common',
   'machine',
   'machine-target',
+  'mcd',
   'migration',
   'misc',
   'misc-target',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 2877aff73d..07907b0a53 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -82,3 +82,4 @@
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
 { 'include': 'uefi.json' }
+{ 'include': 'mcd.json' }
-- 
2.34.1


