Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1EC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7Y-0004s0-Sl; Wed, 29 Jul 2026 23:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7J-0004hj-UR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:33 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7I-00031S-27
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=e8S9uzCAuoCBY6pZkq2YHmBcWy9lWVl15Vgdc8Hi8NE=; b=a5+N7Iz2fTim1G3
 X4kI48tN1CAF/qcd367wSQPI8cc9oMNTFtx2Iju/jmeISgB9Z9oBcfvd8snNymqFYEiUmat+UNcDd
 exenVIGZp85plwjn9oelnVV57ceIfKhYOULEEZPM2036dZb6me16bHv2ETJc8Q7JCgq6qZurCxsPv
 sk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 43/50] target/hexagon: Provide env to tcg global mapping
Date: Thu, 30 Jul 2026 05:10:17 +0200
Message-ID: <20260730031025.12926-44-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces previous calls to tcg_global_mem_new*() with a declarative
global array of cpu_mapping structs.  This array can be used to
initialize all TCG globals with one function call from the target, and
may additionally be used from LLVM based tools to map between offsets
into a struct and a mapped TCGv global.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/translate.c | 119 ++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index bfd84bba4e..870475010b 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -33,6 +33,7 @@
 #include "genptr.h"
 #include "printinsn.h"
 #include "exec/target_page.h"
+#include "tcg/tcg-global-mappings.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1328,77 +1329,68 @@ static char store_val64_names[STORES_MAX][NAME_LEN];
 static char vstore_addr_names[VSTORES_MAX][NAME_LEN];
 static char vstore_size_names[VSTORES_MAX][NAME_LEN];
 static char vstore_pending_names[VSTORES_MAX][NAME_LEN];
-
-void hexagon_translate_init(void)
-{
-    int i;
-
-    opcode_init();
+static const char *store_addr_names_ptr[STORES_MAX];
+static const char *store_width_names_ptr[STORES_MAX];
+static const char *store_val32_names_ptr[STORES_MAX];
+static const char *store_val64_names_ptr[STORES_MAX];
+
+cpu_tcg_mapping tcg_global_mappings[] = {
+    /* General purpose and predicate registers */
+    CPU_TCG_MAP_ARRAY(CPUHexagonState, hex_gpr,  gpr,  hexagon_regnames),
+    CPU_TCG_MAP_ARRAY(CPUHexagonState, hex_pred, pred, hexagon_prednames),
+
+    /* Misc */
+    CPU_TCG_MAP(CPUHexagonState, hex_new_value_usr,  new_value_usr),
+    CPU_TCG_MAP(CPUHexagonState, hex_next_PC,        next_PC),
+    CPU_TCG_MAP(CPUHexagonState, hex_slot_cancelled, slot_cancelled),
+    CPU_TCG_MAP(CPUHexagonState, hex_llsc_addr,      llsc_addr),
+    CPU_TCG_MAP(CPUHexagonState, hex_llsc_val,       llsc_val),
+    CPU_TCG_MAP(CPUHexagonState, hex_llsc_val_i64,   llsc_val_i64),
 
 #ifndef CONFIG_USER_ONLY
-    for (i = 0; i < NUM_GREGS; i++) {
-            hex_greg[i] = tcg_global_mem_new_i32(tcg_env,
-                offsetof(CPUHexagonState, greg[i]),
-                hexagon_gregnames[i]);
-    }
-    for (i = 0; i < NUM_SREGS; i++) {
-        if (i < HEX_SREG_GLB_START) {
-            hex_t_sreg[i] = tcg_global_mem_new_i32(tcg_env,
-                offsetof(CPUHexagonState, t_sreg[i]),
-                hexagon_sregnames[i]);
-        }
-    }
+    CPU_TCG_MAP(CPUHexagonState, hex_cause_code, cause_code),
+    CPU_TCG_MAP(CPUHexagonState, hex_cycle_count, t_cycle_count),
+    CPU_TCG_MAP_ARRAY(CPUHexagonState, hex_greg, greg, hexagon_gregnames),
+    CPU_TCG_MAP_ARRAY(CPUHexagonState, hex_t_sreg, t_sreg, hexagon_sregnames),
 #endif
-    for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
-        hex_gpr[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPUHexagonState, gpr[i]),
-            hexagon_regnames[i]);
-    }
-    hex_new_value_usr = tcg_global_mem_new(tcg_env,
-        offsetof(CPUHexagonState, new_value_usr), "new_value_usr");
-    hex_next_PC = tcg_global_mem_new(tcg_env,
-        offsetof(CPUHexagonState, next_PC), "next_PC");
 
-    for (i = 0; i < NUM_PREGS; i++) {
-        hex_pred[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPUHexagonState, pred[i]),
-            hexagon_prednames[i]);
-    }
-    hex_slot_cancelled = tcg_global_mem_new(tcg_env,
-        offsetof(CPUHexagonState, slot_cancelled), "slot_cancelled");
-    hex_llsc_addr = tcg_global_mem_new(tcg_env,
-        offsetof(CPUHexagonState, llsc_addr), "llsc_addr");
-    hex_llsc_val = tcg_global_mem_new(tcg_env,
-        offsetof(CPUHexagonState, llsc_val), "llsc_val");
-    hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
-        offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
-#ifndef CONFIG_USER_ONLY
-    hex_cause_code = tcg_global_mem_new_i32(tcg_env,
-        offsetof(CPUHexagonState, cause_code), "cause_code");
-    hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
-        offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
-#endif
-    for (i = 0; i < STORES_MAX; i++) {
-        snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
-        hex_store_addr[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPUHexagonState, mem_log_stores[i].va),
-            store_addr_names[i]);
+    /* Logging stores */
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUHexagonState, hex_store_addr,
+                                 mem_log_stores, va,     store_addr_names_ptr),
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUHexagonState, hex_store_width,
+                                 mem_log_stores, width,  store_width_names_ptr),
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUHexagonState, hex_store_val32,
+                                 mem_log_stores, data32, store_val32_names_ptr),
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUHexagonState, hex_store_val64,
+                                 mem_log_stores, data64, store_val64_names_ptr),
+};
 
-        snprintf(store_width_names[i], NAME_LEN, "store_width_%d", i);
-        hex_store_width[i] = tcg_global_mem_new_i32(tcg_env,
-            offsetof(CPUHexagonState, mem_log_stores[i].width),
-            store_width_names[i]);
+size_t tcg_global_mapping_count = ARRAY_SIZE(tcg_global_mappings);
 
+static void init_cpu_reg_names(void) {
+    /*
+     * Create register names and store them in `*_names`,
+     * then copy to and array of pointers in `*_names_ptr`
+     * which is easier to pass around.
+     */
+    for (int i = 0; i < STORES_MAX; ++i) {
+        snprintf(store_addr_names[i],  NAME_LEN, "store_addr_%d",  i);
+        snprintf(store_width_names[i], NAME_LEN, "store_width_%d", i);
         snprintf(store_val32_names[i], NAME_LEN, "store_val32_%d", i);
-        hex_store_val32[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPUHexagonState, mem_log_stores[i].data32),
-            store_val32_names[i]);
-
         snprintf(store_val64_names[i], NAME_LEN, "store_val64_%d", i);
-        hex_store_val64[i] = tcg_global_mem_new_i64(tcg_env,
-            offsetof(CPUHexagonState, mem_log_stores[i].data64),
-            store_val64_names[i]);
+        store_addr_names_ptr[i]  = store_addr_names[i];
+        store_width_names_ptr[i] = store_width_names[i];
+        store_val32_names_ptr[i] = store_val32_names[i];
+        store_val64_names_ptr[i] = store_val64_names[i];
     }
+}
+
+void hexagon_translate_init(void)
+{
+    int i;
+
+    opcode_init();
+
     for (i = 0; i < VSTORES_MAX; i++) {
         snprintf(vstore_addr_names[i], NAME_LEN, "vstore_addr_%d", i);
         hex_vstore_addr[i] = tcg_global_mem_new(tcg_env,
@@ -1415,4 +1407,7 @@ void hexagon_translate_init(void)
             offsetof(CPUHexagonState, vstore_pending[i]),
             vstore_pending_names[i]);
     }
+
+    init_cpu_reg_names();
+    init_cpu_tcg_mappings(tcg_global_mappings, tcg_global_mapping_count);
 }
-- 
2.52.0


