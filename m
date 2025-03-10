Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61930C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trens-0002Z1-Kx; Mon, 10 Mar 2025 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1trenE-0002D6-4V
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:58 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren9-0007h3-TT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:47 -0400
Received: (qmail 30817 invoked by uid 484); 10 Mar 2025 15:11:11 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013285 secs); 10 Mar 2025 15:11:11 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:11 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/16] mcd: Implement register query
Date: Mon, 10 Mar 2025 16:05:03 +0100
Message-Id: <20250310150510.200607-10-mario.fleischmann@lauterbach.com>
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

Directly map MCD register groups to GDB features lists

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/libmcd_qapi.c         |  48 +++++++
 mcd/libmcd_qapi.h         |   8 ++
 mcd/mcdserver.c           | 237 ++++++++++++++++++++++++++++--
 mcd/mcdstub_qapi.c        |  93 ++++++++++++
 qapi/mcd.json             | 296 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/libmcd-test.c |  40 ++++++
 tests/qtest/libmcd-test.h |   6 +
 tests/qtest/mcd-test.c    |  85 +++++++++++
 8 files changed, 803 insertions(+), 10 deletions(-)

diff --git a/mcd/libmcd_qapi.c b/mcd/libmcd_qapi.c
index 0421152705..99177b2fd2 100644
--- a/mcd/libmcd_qapi.c
+++ b/mcd/libmcd_qapi.c
@@ -147,3 +147,51 @@ MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space)
 
     return marshal;
 }
+
+MCDRegisterGroup *marshal_mcd_register_group(
+    const mcd_register_group_st *reg_group)
+{
+    MCDRegisterGroup *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDRegisterGroup) {
+        .reg_group_id = reg_group->reg_group_id,
+        .reg_group_name = g_strdup(reg_group->reg_group_name),
+        .n_registers = reg_group->n_registers,
+    };
+
+    return marshal;
+}
+
+MCDAddr *marshal_mcd_addr(const mcd_addr_st *addr)
+{
+    MCDAddr *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDAddr) {
+        .address = addr->address,
+        .mem_space_id = addr->mem_space_id,
+        .addr_space_id = addr->addr_space_id,
+        .addr_space_type = addr->addr_space_type,
+    };
+
+    return marshal;
+}
+
+MCDRegisterInfo *marshal_mcd_register_info(const mcd_register_info_st *reg_info)
+{
+    MCDRegisterInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDRegisterInfo) {
+        .addr = marshal_mcd_addr(&reg_info->addr),
+        .reg_group_id = reg_info->reg_group_id,
+        .regname = g_strdup(reg_info->regname),
+        .regsize = reg_info->regsize,
+        .core_mode_mask_read = reg_info->core_mode_mask_read,
+        .core_mode_mask_write = reg_info->core_mode_mask_write,
+        .side_effects_read = reg_info->has_side_effects_read,
+        .side_effects_write = reg_info->has_side_effects_write,
+        .reg_type = reg_info->reg_type,
+        .hw_thread_id = reg_info->hw_thread_id,
+    };
+
+    return marshal;
+}
diff --git a/mcd/libmcd_qapi.h b/mcd/libmcd_qapi.h
index 7e874dec25..edcc6d0b7c 100644
--- a/mcd/libmcd_qapi.h
+++ b/mcd/libmcd_qapi.h
@@ -27,6 +27,14 @@ MCDCoreConInfo *marshal_mcd_core_con_info(const mcd_core_con_info_st *con_info);
 
 MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space);
 
+MCDRegisterGroup *marshal_mcd_register_group(
+    const mcd_register_group_st *reg_group);
+
+MCDAddr *marshal_mcd_addr(const mcd_addr_st *addr);
+
+MCDRegisterInfo *marshal_mcd_register_info(
+    const mcd_register_info_st *reg_info);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
 mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
index f924bf3799..f0cda23981 100644
--- a/mcd/mcdserver.c
+++ b/mcd/mcdserver.c
@@ -13,6 +13,7 @@
 #include "mcd_api.h"
 #include "hw/boards.h"
 #include "exec/tswap.h"
+#include "exec/gdbstub.h"
 
 /* Custom memory space type */
 static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
@@ -55,12 +56,14 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
 /**
  * struct mcdcore_state - State of a core.
  *
- * @last_error:    Error info of most recent executed core-related function.
- * @custom_error:  Reserves memory for custom MCD errors.
- * @info:          Core connection information.
- * @open_core:     Open core instance as allocated in mcd_open_core_f().
- * @cpu:           QEMU's internal CPU handle.
- * @memory_spaces: Memory spaces as queried by mcd_qry_mem_spaces_f().
+ * @last_error:      Error info of most recent executed core-related function.
+ * @custom_error:    Reserves memory for custom MCD errors.
+ * @info:            Core connection information.
+ * @open_core:       Open core instance as allocated in mcd_open_core_f().
+ * @cpu:             QEMU's internal CPU handle.
+ * @memory_spaces:   Memory spaces as queried by mcd_qry_mem_spaces_f().
+ * @register_groups: Register groups as queried by mcd_qry_reg_groups_f().
+ * @registers:       Registers as queried by mcd_qry_reg_map_f().
  *
  * MCD is mainly being used on the core level:
  * After the initial query functions, a core connection is opened in
@@ -77,6 +80,8 @@ typedef struct mcdcore_state {
     mcd_core_st *open_core;
     CPUState *cpu;
     GArray *memory_spaces;
+    GArray *register_groups;
+    GArray *registers;
 } mcdcore_state;
 
 /**
@@ -267,6 +272,10 @@ mcd_return_et mcd_open_server_f(const char *system_key,
             .open_core = NULL,
             .cpu = cpu,
             .memory_spaces = g_array_new(false, true, sizeof(mcd_memspace_st)),
+            .register_groups = g_array_new(false, true,
+                                           sizeof(mcd_register_group_st)),
+            .registers = g_array_new(false, true,
+                                     sizeof(mcd_register_info_st)),
         };
         pstrcpy(c.info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
         g_array_append_val(g_server_state.cores, c);
@@ -306,6 +315,10 @@ mcd_return_et mcd_close_server_f(const mcd_server_st *server)
         if (c->open_core) {
             mcd_close_core_f(c->open_core);
         }
+
+        g_array_free(c->memory_spaces, true);
+        g_array_free(c->register_groups, true);
+        g_array_free(c->registers, true);
     }
 
     g_array_free(g_server_state.cores, true);
@@ -538,6 +551,59 @@ static mcd_return_et query_memspaces(mcdcore_state *core_state)
     return MCD_RET_ACT_NONE;
 }
 
+static mcd_return_et query_registers(mcdcore_state *core_state)
+{
+    GArray *gdb_regs = core_state->cpu->gdb_regs;
+    assert(gdb_regs);
+
+    g_array_set_size(core_state->register_groups, 0);
+    g_array_set_size(core_state->registers, 0);
+
+    for (int feature_id = 0; feature_id < gdb_regs->len; feature_id++) {
+        GDBRegisterState *f = &g_array_index(gdb_regs, GDBRegisterState,
+                                             feature_id);
+        /* register group ID 0 is reserved */
+        uint32_t group_id = feature_id + 1;
+        uint32_t num_regs = 0;
+
+        GByteArray *mem_buf = g_byte_array_new();
+        for (int i = 0; i < f->feature->num_regs; i++) {
+            const char *name = f->feature->regs[i];
+            if (name) {
+                int reg_id = f->base_reg + i;
+                int bitsize = gdb_read_register(core_state->cpu,
+                                                mem_buf, reg_id) * 8;
+                mcd_register_info_st r = {
+                    .addr = {
+                        .address = (uint64_t) reg_id,
+                        /* memory space "GDB Registers" */
+                        .mem_space_id = core_state->memory_spaces->len,
+                        .addr_space_type = MCD_NOTUSED_ID,
+                    },
+                    .reg_group_id = group_id,
+                    .regsize = (uint32_t) bitsize,
+                    .reg_type = MCD_REG_TYPE_SIMPLE,
+                    /* ID 0 reserved */
+                    .hw_thread_id = core_state->info.core_id + 1,
+                };
+                strncpy(r.regname, name, MCD_REG_NAME_LEN - 1);
+                g_array_append_val(core_state->registers, r);
+                num_regs++;
+            }
+        }
+        g_byte_array_free(mem_buf, true);
+
+        mcd_register_group_st rg = {
+            .reg_group_id = group_id,
+            .n_registers = num_regs,
+        };
+        strncpy(rg.reg_group_name, f->feature->name, MCD_REG_NAME_LEN - 1);
+        g_array_append_val(core_state->register_groups, rg);
+    }
+
+    return MCD_RET_ACT_NONE;
+}
+
 mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
                               mcd_core_st **core)
 {
@@ -583,6 +649,10 @@ mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
         return g_server_state.last_error->return_status;
     }
 
+    if (query_registers(core_state) != MCD_RET_ACT_NONE) {
+        return g_server_state.last_error->return_status;
+    }
+
     *core = g_malloc(sizeof(mcd_core_st));
     info = g_malloc(sizeof(mcd_core_con_info_st));
     *info = *core_con_info;
@@ -626,6 +696,8 @@ mcd_return_et mcd_close_core_f(const mcd_core_st *core)
     core_state->open_core = NULL;
     core_state->cpu = NULL;
     g_array_set_size(core_state->memory_spaces, 0);
+    g_array_set_size(core_state->register_groups, 0);
+    g_array_set_size(core_state->registers, 0);
 
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
@@ -771,16 +843,161 @@ mcd_return_et mcd_qry_reg_groups_f(const mcd_core_st *core,
                                    uint32_t *num_reg_groups,
                                    mcd_register_group_st *reg_groups)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    uint32_t i;
+    mcdcore_state *core_state;
+
+    if (!core || !num_reg_groups) {
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
+    g_assert(core_state->register_groups);
+
+    if (core_state->register_groups->len == 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_NO_REG_GROUPS,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (*num_reg_groups == 0) {
+        *num_reg_groups = core_state->register_groups->len;
+        core_state->last_error = &MCD_ERROR_NONE;
+        return core_state->last_error->return_status;
+    }
+
+    if (start_index >= core_state->register_groups->len) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "start_index exceeds the number of register groups",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (!reg_groups) {
+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return core_state->last_error->return_status;
+    }
+
+    for (i = 0; i < *num_reg_groups &&
+         start_index + i < core_state->register_groups->len; i++) {
+
+        reg_groups[i] = g_array_index(core_state->register_groups,
+                                      mcd_register_group_st, start_index + i);
+    }
+
+    *num_reg_groups = i;
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_reg_map_f(const mcd_core_st *core, uint32_t reg_group_id,
                                 uint32_t start_index, uint32_t *num_regs,
                                 mcd_register_info_st *reg_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+    bool query_all_regs = reg_group_id == 0;
+    bool query_num_only;
+
+    if (!core || !num_regs) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    query_num_only = *num_regs == 0;
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (core_state->register_groups->len == 0 ||
+        reg_group_id > core_state->register_groups->len) {
+
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_REG_GROUP_ID,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    /*
+     * Depending on reg_group_id, start_index refers either to the total list of
+     * register or a single register group.
+     */
+
+    if (query_all_regs) {
+        if (start_index >= core_state->registers->len) {
+            core_state->custom_error = (mcd_error_info_st) {
+                .return_status = MCD_RET_ACT_HANDLE_ERROR,
+                .error_code = MCD_ERR_PARAM,
+                .error_events = MCD_ERR_EVT_NONE,
+                .error_str = "start_index exceeds the number of registers",
+            };
+            core_state->last_error = &core_state->custom_error;
+            return core_state->last_error->return_status;
+        };
+
+        if (*num_regs == 0) {
+            *num_regs = core_state->registers->len;
+        } else if (*num_regs > core_state->registers->len - start_index) {
+            *num_regs = core_state->registers->len - start_index;
+        }
+    } else {
+        mcd_register_group_st *rg = &g_array_index(core_state->register_groups,
+            mcd_register_group_st, reg_group_id - 1);
+
+        if (start_index > rg->n_registers) {
+            core_state->custom_error = (mcd_error_info_st) {
+                .return_status = MCD_RET_ACT_HANDLE_ERROR,
+                .error_code = MCD_ERR_PARAM,
+                .error_events = MCD_ERR_EVT_NONE,
+                .error_str = "start_index exceeds the number of registers",
+            };
+            core_state->last_error = &core_state->custom_error;
+            return core_state->last_error->return_status;
+        }
+
+        if (*num_regs == 0) {
+            *num_regs = rg->n_registers;
+        } else if (*num_regs > rg->n_registers - start_index) {
+            *num_regs = rg->n_registers - start_index;
+        }
+
+        for (uint32_t rg_id = 0; rg_id < reg_group_id - 1; rg_id++) {
+            mcd_register_group_st *prev_rg = &g_array_index(
+                core_state->register_groups, mcd_register_group_st, rg_id);
+            start_index += prev_rg->n_registers;
+        }
+    }
+
+    if (!query_num_only) {
+        for (uint32_t i = 0; i < *num_regs; i++) {
+            reg_info[i] = g_array_index(
+                core_state->registers, mcd_register_info_st, start_index + i);
+        }
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_qry_reg_compound_f(const mcd_core_st *core,
diff --git a/mcd/mcdstub_qapi.c b/mcd/mcdstub_qapi.c
index 437d2c2e3e..6aa72b025c 100644
--- a/mcd/mcdstub_qapi.c
+++ b/mcd/mcdstub_qapi.c
@@ -412,3 +412,96 @@ MCDQryMemSpacesResult *qmp_mcd_qry_mem_spaces(uint32_t core_uid,
     g_stub_state.on_error_ask_server = true;
     return result;
 }
+
+MCDQryRegGroupsResult *qmp_mcd_qry_reg_groups(uint32_t core_uid,
+                                              uint32_t start_index,
+                                              uint32_t num_reg_groups,
+                                              Error **errp)
+{
+    MCDRegisterGroupList **tailp;
+    MCDRegisterGroup *rg;
+    mcd_register_group_st *reg_groups = NULL;
+    bool query_num_only = num_reg_groups == 0;
+    MCDQryRegGroupsResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    if (!query_num_only) {
+        reg_groups = g_malloc0(num_reg_groups * sizeof(*reg_groups));
+    }
+
+    result->return_status = mcd_qry_reg_groups_f(core, start_index,
+                                                 &num_reg_groups, reg_groups);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_reg_groups = true;
+        result->num_reg_groups = num_reg_groups;
+        if (!query_num_only) {
+            result->has_reg_groups = true;
+            tailp = &(result->reg_groups);
+            for (uint32_t i = 0; i < num_reg_groups; i++) {
+                rg = marshal_mcd_register_group(reg_groups + i);
+                QAPI_LIST_APPEND(tailp, rg);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(reg_groups);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDQryRegMapResult *qmp_mcd_qry_reg_map(uint32_t core_uid,
+                                        uint32_t reg_group_id,
+                                        uint32_t start_index, uint32_t num_regs,
+                                        Error **errp)
+{
+    MCDRegisterInfoList **tailp;
+    MCDRegisterInfo *r;
+    mcd_register_info_st *regs = NULL;
+    bool query_num_only = num_regs == 0;
+    MCDQryRegMapResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    if (!query_num_only) {
+        regs = g_malloc0(num_regs * sizeof(*regs));
+    }
+
+    result->return_status = mcd_qry_reg_map_f(core, reg_group_id,
+                                              start_index, &num_regs,
+                                              regs);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_regs = true;
+        result->num_regs = num_regs;
+        if (!query_num_only) {
+            result->has_reg_info = true;
+            tailp = &(result->reg_info);
+            for (uint32_t i = 0; i < num_regs; i++) {
+                r = marshal_mcd_register_info(regs + i);
+                QAPI_LIST_APPEND(tailp, r);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(regs);
+    }
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 214933e279..936016de45 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -215,6 +215,98 @@
     'core-mode-mask-write'    : 'uint32' } }
 
 
+##
+# @MCDRegisterGroup:
+#
+# Structure type containing register group information.
+#
+# @reg-group-id:   Contains the ID of this register group. A register group ID
+#                  must be unique within the scope of a target core. ID '0' is
+#                  reserved.
+# @reg-group-name: The name of a register group. A register group name cannot
+#                  be longer than MCD_REG_NAME_LEN characters (use
+#                  representative names).
+# @n-registers:    Number of registers part of this group.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRegisterGroup',
+  'data': {
+    'reg-group-id'  : 'uint32',
+    'reg-group-name': 'str',
+    'n-registers'   : 'uint32' } }
+
+
+##
+# @MCDAddr:
+#
+# Structure type containing a completely resolved logical or physical memory
+# address.
+#
+# @address:         Address value within a memory space, expressed in bytes.
+# @mem-space-id:    ID of the memory space associated with this address, e.g. a
+#                   program memory, a data memory or registers .
+# @addr-space-id:   ID of the address space in which this address is valid.
+# @addr-space-type: Type of the address space in which this address is valid.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDAddr',
+  'data': {
+    'address'        : 'uint64',
+    'mem-space-id'   : 'uint32',
+    'addr-space-id'  : 'uint32',
+    'addr-space-type': 'uint32' } }
+
+
+##
+# @MCDRegisterInfo:
+#
+# Structure type containing register information for a single register.
+#
+# @addr:                   Either the address of a memory mapped register or
+#                          the register address in a dedicated
+#                          "register memory space"
+# @reg-group-id:           ID of the group this register belongs to.
+# @regname:                The name of a register. A register name cannot be
+#                          longer than MCD_REG_NAME_LEN characters (use
+#                          representative names).
+# @regsize:                Register size in bits.
+# @core-mode-mask-read:    Mask of core modes for which read accesses are
+#                          impossible. A set bit indicates that read accesses
+#                          are denied in this mode. Bit 0 represents core mode
+#                          '1', bit 31 represents core mode 32. Overrides
+#                          @core-mode-mask-read of the corresponding
+#                          mcd_memspace_st.
+# @core-mode-mask-write:   Mask of core modes for which write accesses are
+#                          impossible. A set bit indicates that write accesses
+#                          are denied in this mode. Bit 0 represents core mode
+#                          '1', bit 31 represents core mode '32'. Overrides
+#                          @core-mode-mask-write of the corresponding
+#                          mcd_memspace_st.
+# @side-effects-read:      Reading this register can trigger side effects.
+# @side-effects-write:     Writing this register can trigger side effects.
+# @reg-type:               Register type (simple, compound or partial)
+# @hw-thread-id:           Hardware thread ID this register belongs to. The ID
+#                          must be set to '0' if the register is not assigned
+#                          to a hardware thread.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRegisterInfo',
+  'data': {
+    'addr'                : 'MCDAddr',
+    'reg-group-id'        : 'uint32',
+    'regname'             : 'str',
+    'regsize'             : 'uint32',
+    'core-mode-mask-read' : 'uint32',
+    'core-mode-mask-write': 'uint32',
+    'side-effects-read'   : 'bool',
+    'side-effects-write'  : 'bool',
+    'reg-type'            : 'uint32',
+    'hw-thread-id'        : 'uint32' } }
+
+
 ##
 # == Target Initialization API
 ##
@@ -1077,3 +1169,207 @@
      'start-index'   : 'uint32',
      'num-mem-spaces': 'uint32' },
   'returns': 'MCDQryMemSpacesResult' }
+
+
+##
+# @MCDQryRegGroupsResult:
+#
+# Return value of @mcd-qry-reg-groups.
+#
+# @return-status:  Return code.
+# @num-reg-groups: Number of returned register groups. In case the input value
+#                  of @num-reg-groups is '0', this is the number of all
+#                  available register groups for the selected core.
+# @reg-groups:     Register group information.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryRegGroupsResult',
+  'data': {
+    'return-status'  : 'uint32',
+    '*num-reg-groups': 'uint32',
+    '*reg-groups'    : [ 'MCDRegisterGroup' ] }}
+
+
+##
+# @mcd-qry-reg-groups:
+#
+# Function querying the register groups defined for a particular component.
+#
+# @core-uid:       Unique ID of the core the calling function addresses.
+# @start-index:    Start index of the requested register groups. This refers
+#                  to an internal list of the target side implementation.
+# @num-reg-groups: Number of register groups, information is requested of. If
+#                  it is set to '0', no register groups information is returned
+#                  but the number of all available register groups for the
+#                  selected core.
+#
+# Returns: @MCDQryRegGroupsResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-qry-reg-groups',
+  'data': {
+    'core-uid'      : 'uint32',
+    'start-index'   : 'uint32',
+    'num-reg-groups': 'uint32' },
+  'returns': 'MCDQryRegGroupsResult' }
+
+
+##
+# @MCDQryRegMapResult:
+#
+# Return value of @mcd-qry-reg-map.
+#
+# @return-status: Return code.
+# @num-regs:      Number of returned registers. In case the input value of
+#                 @num-regs is '0', this is the number of all available register
+#                 for the selected register group.
+# @reg-info:      Register information.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryRegMapResult',
+  'data': {
+    'return-status': 'uint32',
+    '*num-regs'    : 'uint32',
+    '*reg-info'    : [ 'MCDRegisterInfo' ] }}
+
+##
+# @mcd-qry-reg-map:
+#
+# Function querying the register information of a particular register group.
+#
+# @core-uid:     Unique ID of the core the calling function addresses.
+# @reg-group-id: ID of the register group detailed register information is
+#                requested for.
+# @start-index:  Start index of the requested registers. This refers to an
+#                internal list of the target side implementation.
+# @num-regs:     Number of registers, information is requested of. If it
+#                is set to '0', no register information is returned but the
+#                number of all available registers within for the selected
+#                register group.
+#
+# Returns: @MCDQryRegMapResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-qry-reg-groups",
+#          "arguments": { "core-uid": 1,
+#                         "start-index": 0,
+#                         "num-reg-groups": 3 } }
+#     <- {
+#            "return": {
+#                "reg-groups": [
+#                    {
+#                        "reg-group-id": 1,
+#                        "reg-group-name": "org.gnu.gdb.aarch64.core",
+#                        "n-registers": 34
+#                    },
+#                    {
+#                        "reg-group-id": 2,
+#                        "reg-group-name": "org.gnu.gdb.aarch64.fpu",
+#                        "n-registers": 34
+#                    },
+#                    {
+#                        "reg-group-id": 3,
+#                        "reg-group-name": "org.qemu.gdb.arm.sys.regs",
+#                        "n-registers": 210
+#                    }
+#                ],
+#                "return-status": 0,
+#                "num-reg-groups": 3
+#            }
+#        }
+#     -> { "execute": "mcd-qry-reg-map",
+#          "arguments": { "core-uid": 1,
+#                         "reg-group-id": 1,
+#                         "start-index": 0,
+#                         "num-regs": 34 } }
+#     <- {
+#            "return": {
+#                "reg-info": [
+#                    {
+#                        "reg-group-id": 1,
+#                        "regname": "x0",
+#                        "side-effects-read": false,
+#                        "addr": {
+#                            "mem-space-id": 5,
+#                            "addr-space-id": 0,
+#                            "address": 0,
+#                            "addr-space-type": 0
+#                        },
+#                        "reg-type": 0,
+#                        "core-mode-mask-write": 0,
+#                        "core-mode-mask-read": 0,
+#                        "regsize": 64,
+#                        "hw-thread-id": 0,
+#                        "side-effects-write": false
+#                    },
+#                    {
+#                        "reg-group-id": 1,
+#                        "regname": "x1",
+#                        "side-effects-read": false,
+#                        "addr": {
+#                            "mem-space-id": 5,
+#                            "addr-space-id": 0,
+#                            "address": 1,
+#                            "addr-space-type": 0
+#                        },
+#                        "reg-type": 0,
+#                        "core-mode-mask-write": 0,
+#                        "core-mode-mask-read": 0,
+#                        "regsize": 64,
+#                        "hw-thread-id": 0,
+#                        "side-effects-write": false
+#                    },
+#                    {
+#                        "reg-group-id": 1,
+#                        "regname": "x2",
+#                        "side-effects-read": false,
+#                        "addr": {
+#                            "mem-space-id": 5,
+#                            "addr-space-id": 0,
+#                            "address": 2,
+#                            "addr-space-type": 0
+#                        },
+#                        "reg-type": 0,
+#                        "core-mode-mask-write": 0,
+#                        "core-mode-mask-read": 0,
+#                        "regsize": 64,
+#                        "hw-thread-id": 0,
+#                        "side-effects-write": false
+#                    },
+#                    {
+#                        "reg-group-id": 1,
+#                        "regname": "x3",
+#                        "side-effects-read": false,
+#                        "addr": {
+#                            "mem-space-id": 5,
+#                            "addr-space-id": 0,
+#                            "address": 3,
+#                            "addr-space-type": 0
+#                        },
+#                        "reg-type": 0,
+#                        "core-mode-mask-write": 0,
+#                        "core-mode-mask-read": 0,
+#                        "regsize": 64,
+#                        "hw-thread-id": 0,
+#                        "side-effects-write": false
+#                    },
+#                    ...
+#                ],
+#                "return-status": 0,
+#                "num-regs": 34
+#            }
+#        }
+##
+{ 'command': 'mcd-qry-reg-map',
+  'data': {
+    'core-uid': 'uint32',
+    'reg-group-id': 'uint32',
+    'start-index': 'uint32',
+    'num-regs': 'uint32' },
+  'returns': 'MCDQryRegMapResult' }
diff --git a/tests/qtest/libmcd-test.c b/tests/qtest/libmcd-test.c
index 9e41a0218f..82a39366b2 100644
--- a/tests/qtest/libmcd-test.c
+++ b/tests/qtest/libmcd-test.c
@@ -278,3 +278,43 @@ MCDQryMemSpacesResult *qtest_mcd_qry_mem_spaces(
 
     return unmarshal;
 }
+
+MCDQryRegGroupsResult *qtest_mcd_qry_reg_groups(
+    QTestState *qts, q_obj_mcd_qry_reg_groups_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryRegGroupsResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_reg_groups_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-qry-reg-groups',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryRegGroupsResult);
+
+    return unmarshal;
+}
+
+MCDQryRegMapResult *qtest_mcd_qry_reg_map(QTestState *qts,
+                                          q_obj_mcd_qry_reg_map_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryRegMapResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_reg_map_arg);
+
+    resp = qtest_qmp(qts, "{'execute': 'mcd-qry-reg-map',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryRegMapResult);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/libmcd-test.h b/tests/qtest/libmcd-test.h
index 26f35b8931..266b6fe854 100644
--- a/tests/qtest/libmcd-test.h
+++ b/tests/qtest/libmcd-test.h
@@ -50,4 +50,10 @@ MCDCloseCoreResult *qtest_mcd_close_core(QTestState *qts,
 MCDQryMemSpacesResult *qtest_mcd_qry_mem_spaces(QTestState *qts,
     q_obj_mcd_qry_mem_spaces_arg *args);
 
+MCDQryRegGroupsResult *qtest_mcd_qry_reg_groups(QTestState *qts,
+    q_obj_mcd_qry_reg_groups_arg *args);
+
+MCDQryRegMapResult *qtest_mcd_qry_reg_map(QTestState *qts,
+                                          q_obj_mcd_qry_reg_map_arg *args);
+
 #endif /* LIBMCD_TEST_H */
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index 7deca39f93..820408a9a9 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -355,8 +355,12 @@ static void test_qry_core_info(void)
     MCDCoreConInfoList *core_head = cores_query->core_con_info;
     for (uint32_t c = 0; c < cores_query->num_cores; c++) {
         q_obj_mcd_qry_mem_spaces_arg qry_mem_spaces_args;
+        q_obj_mcd_qry_reg_groups_arg qry_reg_groups_args;
+        q_obj_mcd_qry_reg_map_arg qry_reg_map_args;
         q_obj_mcd_close_core_arg close_core_args;
         MCDQryMemSpacesResult *qry_mem_spaces_result;
+        MCDQryRegGroupsResult *qry_reg_groups_result;
+        MCDQryRegMapResult *qry_reg_map_result;
         MCDCloseCoreResult *close_core_result;
 
         MCDCoreConInfo *core_con_info = core_head->value;
@@ -374,6 +378,8 @@ static void test_qry_core_info(void)
                                 core_con_info->core_id);
         }
 
+        /* Memory Space Query */
+
         qry_mem_spaces_args = (q_obj_mcd_qry_mem_spaces_arg) {
             .core_uid = open_core_result->core_uid,
             .start_index = 0,
@@ -411,6 +417,85 @@ static void test_qry_core_info(void)
         }
 
         qapi_free_MCDQryMemSpacesResult(qry_mem_spaces_result);
+
+        /* Register Query */
+
+        qry_reg_groups_args = (q_obj_mcd_qry_reg_groups_arg) {
+            .core_uid = open_core_result->core_uid,
+            .start_index = 0,
+            .num_reg_groups = 0, /* query only number of register groups */
+        };
+
+        qry_reg_groups_result = qtest_mcd_qry_reg_groups(qts,
+                                                        &qry_reg_groups_args);
+        g_assert(qry_reg_groups_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(qry_reg_groups_result->has_num_reg_groups);
+
+        if (qry_reg_groups_result->num_reg_groups == 0) {
+            fprintf(stderr, "[WARN]\tTNo register groups!\n");
+        }
+
+        qry_reg_groups_args.num_reg_groups =
+            qry_reg_groups_result->num_reg_groups;
+
+        qapi_free_MCDQryRegGroupsResult(qry_reg_groups_result);
+        qry_reg_groups_result = qtest_mcd_qry_reg_groups(qts,
+                                                         &qry_reg_groups_args);
+        g_assert(qry_reg_groups_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(qry_reg_groups_result->has_num_reg_groups);
+
+        if (verbose) {
+            MCDRegisterGroupList *rg_head = qry_reg_groups_result->reg_groups;
+            for (uint32_t i = 0;
+                 i < qry_reg_groups_result->num_reg_groups; i++) {
+                MCDRegisterGroup *rg = rg_head->value;
+                if (verbose) {
+                    fprintf(stderr, "\tRegister Group: %s (#%d) with "
+                                    "%d registers\n",
+                                    rg->reg_group_name,
+                                    rg->reg_group_id,
+                                    rg->n_registers);
+                }
+                rg_head = rg_head->next;
+            }
+        }
+
+        qapi_free_MCDQryRegGroupsResult(qry_reg_groups_result);
+
+        qry_reg_map_args = (q_obj_mcd_qry_reg_map_arg) {
+            .core_uid = open_core_result->core_uid,
+            .reg_group_id = 0,
+            .start_index = 0,
+            .num_regs = 0, /* query only number of registers */
+        };
+
+        qry_reg_map_result = qtest_mcd_qry_reg_map(qts, &qry_reg_map_args);
+        g_assert(qry_reg_map_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(qry_reg_map_result->has_num_regs);
+
+        if (verbose) {
+            fprintf(stderr, "\t%d registers found\n",
+                qry_reg_map_result->num_regs);
+        }
+
+        qry_reg_map_args.num_regs = qry_reg_map_result->num_regs;
+        qapi_free_MCDQryRegMapResult(qry_reg_map_result);
+
+        qry_reg_map_result = qtest_mcd_qry_reg_map(qts, &qry_reg_map_args);
+        g_assert(qry_reg_map_result->return_status == MCD_RET_ACT_NONE);
+        g_assert(qry_reg_map_result->has_num_regs);
+        if (verbose) {
+            MCDRegisterInfoList *r_head = qry_reg_map_result->reg_info;
+            for (uint32_t i = 0;
+                 i < qry_reg_map_result->num_regs; i++) {
+                MCDRegisterInfo *r = r_head->value;
+                fprintf(stderr, "\tRegister: %s (#%lx)\n",
+                        r->regname, r->addr->address);
+                r_head = r_head->next;
+            }
+        }
+        qapi_free_MCDQryRegMapResult(qry_reg_map_result);
+
         close_core_args.core_uid = open_core_result->core_uid;
         close_core_result = qtest_mcd_close_core(qts, &close_core_args);
         g_assert(close_core_result->return_status == MCD_RET_ACT_NONE);
-- 
2.34.1


