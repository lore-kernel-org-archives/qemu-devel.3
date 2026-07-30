Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E372AC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5s-0001mu-Ps; Wed, 29 Jul 2026 23:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5r-0001lP-4Q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:59 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5l-0002qg-Oh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/yrhCiwZxhpBbFg+pWTw+aPmGPtG9P1Y5tKxmOCNipk=; b=oLAQI28zPmNXjfF
 fZCz03lpFjp9mdiQ4T21MYVE7jFfW7VdfnhvliW0UNsBAZ3MY3SW6Ee7m9D+dsz+U9kYOMqDKaGIP
 hKIxBWmXlVQ9M2LcADcwSTUfMcRoL99AQUZ9xR0VOj3AhkEWo4GzEiSwifRk0zljSda7bqyAPeimM
 Dw=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 03/50] tcg: Introduce tcg-global-mappings
Date: Thu, 30 Jul 2026 05:09:37 +0200
Message-ID: <20260730031025.12926-4-anjo@rev.ng>
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

Adds a cpu_mapping struct to describe, in a declarative fashion, the
mapping between fields in a struct, and a corresponding TCG global.  As
such, tcg_global_mem_new() can be automatically called given an array of
cpu_mappings.

This change is not limited to helper-to-tcg, but will be required in
future commits to map between offsets into CPUArchState and TCGv
globals in a target-agnostic way.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/tcg/tcg-global-mappings.h | 118 ++++++++++++++++++++++++++++++
 tcg/meson.build                   |   1 +
 tcg/tcg-global-mappings.c         |  62 ++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 include/tcg/tcg-global-mappings.h
 create mode 100644 tcg/tcg-global-mappings.c

diff --git a/include/tcg/tcg-global-mappings.h b/include/tcg/tcg-global-mappings.h
new file mode 100644
index 0000000000..341dcd20b3
--- /dev/null
+++ b/include/tcg/tcg-global-mappings.h
@@ -0,0 +1,118 @@
+/*
+ *  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TCG_GLOBAL_MAP_H
+#define TCG_GLOBAL_MAP_H
+
+/**
+ * cpu_tcg_mapping: Declarative mapping of offsets into a struct to global
+ *                  TCGvs.  Parseable by LLVM-based tools.
+ * @tcg_var_name: String name of the TCGv to use as destination of the mapping.
+ * @tcg_var_base_address: Address of the above TCGv.
+ * @cpu_type_name: String name of the base type being mapped, e.g. "CPUArchState".
+ * @cpu_var_names: Array of printable names of TCGvs, used when calling
+ *                 tcg_global_mem_new from init_cpu_tcg_mappings.  Contains
+ *                 @number_of_elements strings.
+ * @cpu_var_base_offset: Base offset of field in the source struct.
+ * @cpu_var_size: Size of field in the source struct, if the field is an array,
+ *                this holds the size of the element type.
+ * @cpu_var_stride: Stride between array elements in the source struct.  This
+ *                  can be greater than the element size when mapping a field
+ *                  in an array of structs.
+ * @number_of_elements: Number of elements of array in the source struct.
+ */
+typedef struct cpu_tcg_mapping {
+    const char *tcg_var_name;
+    void *tcg_var_base_address;
+
+    const char *cpu_type_name;
+    const char *const *cpu_var_names;
+    size_t cpu_var_base_offset;
+    size_t cpu_var_size;
+    size_t cpu_var_stride;
+
+    size_t number_of_elements;
+} cpu_tcg_mapping;
+
+#define STRUCT_SIZEOF_FIELD(S, member) sizeof(((S *)0)->member)
+
+#define STRUCT_ARRAY_SIZE(S, array)                                            \
+    (STRUCT_SIZEOF_FIELD(S, array) / STRUCT_SIZEOF_FIELD(S, array[0]))
+
+/*
+ * Following are a few macros that aid in constructing
+ * `cpu_tcg_mapping`s for a few common cases.
+ */
+
+/* Map between single CPU register and to TCG global */
+#define CPU_TCG_MAP(struct_type, tcg_var, cpu_var)                             \
+    (cpu_tcg_mapping)                                                          \
+    {                                                                          \
+        .tcg_var_name = stringify(tcg_var),                                    \
+        .tcg_var_base_address = &tcg_var,                                      \
+        .cpu_type_name = stringify(struct_type),                               \
+        .cpu_var_names = (const char *[]){stringify(cpu_var)},                 \
+        .cpu_var_base_offset = offsetof(struct_type, cpu_var),                 \
+        .cpu_var_size = STRUCT_SIZEOF_FIELD(struct_type, cpu_var),             \
+        .cpu_var_stride = 0, .number_of_elements = 1,                          \
+    }
+
+/* Map between array of CPU registers and array of TCG globals. */
+#define CPU_TCG_MAP_ARRAY(struct_type, tcg_var, cpu_var, names)                \
+    (cpu_tcg_mapping)                                                          \
+    {                                                                          \
+        .tcg_var_name = stringify(tcg_var),                                    \
+        .tcg_var_base_address = tcg_var,                                       \
+        .cpu_type_name = stringify(struct_type),                               \
+        .cpu_var_names = names,                                                \
+        .cpu_var_base_offset = offsetof(struct_type, cpu_var),                 \
+        .cpu_var_size = STRUCT_SIZEOF_FIELD(struct_type, cpu_var[0]),          \
+        .cpu_var_stride = STRUCT_SIZEOF_FIELD(struct_type, cpu_var[0]),        \
+        .number_of_elements = STRUCT_ARRAY_SIZE(struct_type, cpu_var),         \
+    }
+
+/*
+ * Map between single member in an array of structs to an array
+ * of TCG globals, e.g. maps
+ *
+ *     cpu_state.array_of_structs[i].member
+ *
+ * to
+ *
+ *     tcg_global_member[i]
+ */
+#define CPU_TCG_MAP_ARRAY_OF_STRUCTS(struct_type, tcg_var, cpu_struct,         \
+                                     cpu_var, names)                           \
+    (cpu_tcg_mapping)                                                          \
+    {                                                                          \
+        .tcg_var_name = stringify(tcg_var),                                    \
+        .tcg_var_base_address = tcg_var,                                       \
+        .cpu_type_name = stringify(struct_type),                               \
+        .cpu_var_names = names,                                                \
+        .cpu_var_base_offset = offsetof(struct_type, cpu_struct[0].cpu_var),   \
+        .cpu_var_size =                                                        \
+            STRUCT_SIZEOF_FIELD(struct_type, cpu_struct[0].cpu_var),           \
+        .cpu_var_stride = STRUCT_SIZEOF_FIELD(struct_type, cpu_struct[0]),     \
+        .number_of_elements = STRUCT_ARRAY_SIZE(struct_type, cpu_struct),      \
+    }
+
+extern cpu_tcg_mapping tcg_global_mappings[];
+extern size_t tcg_global_mapping_count;
+
+void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size);
+
+#endif /* TCG_GLOBAL_MAP_H */
diff --git a/tcg/meson.build b/tcg/meson.build
index 706a6eb260..c7c16eeb05 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_ss.add(files(
   'tcg-op-ldst.c',
   'tcg-op-gvec.c',
   'tcg-op-vec.c',
+  'tcg-global-mappings.c',
 ))
 
 if get_option('tcg_interpreter')
diff --git a/tcg/tcg-global-mappings.c b/tcg/tcg-global-mappings.c
new file mode 100644
index 0000000000..a75fad0c21
--- /dev/null
+++ b/tcg/tcg-global-mappings.c
@@ -0,0 +1,62 @@
+/*
+ *  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg-global-mappings.h"
+#include "tcg/tcg-op-common.h"
+#include "tcg/tcg.h"
+
+void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size)
+{
+    uintptr_t tcg_addr;
+    size_t cpu_offset;
+    const char *name;
+    cpu_tcg_mapping m;
+
+    /*
+     * Paranoid assertion, this should always hold since
+     * they're typedef'd to pointers. But you never know!
+     */
+    g_assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));
+
+    /*
+     * Loop over entries in tcg_global_mappings and
+     * create the `mapped to` TCGv's.
+     */
+    for (int i = 0; i < size; ++i) {
+        m = mappings[i];
+
+        for (int j = 0; j < m.number_of_elements; ++j) {
+            /*
+             * Here we are using the fact that
+             * sizeof(TCGv_i32) == sizeof(TCGv_i64) == sizeof(TCGv)
+             */
+            assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));
+            tcg_addr = (uintptr_t)m.tcg_var_base_address + j * sizeof(TCGv_i32);
+            cpu_offset = m.cpu_var_base_offset + j * m.cpu_var_stride;
+            name = m.cpu_var_names[j];
+
+            if (m.cpu_var_size < 8) {
+                *(TCGv_i32 *)tcg_addr =
+                    tcg_global_mem_new_i32(tcg_env, cpu_offset, name);
+            } else {
+                *(TCGv_i64 *)tcg_addr =
+                    tcg_global_mem_new_i64(tcg_env, cpu_offset, name);
+            }
+        }
+    }
+}
-- 
2.52.0


