Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACAAD743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJX-0005tm-Rt; Wed, 20 Nov 2024 20:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJV-0005dx-4x
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:58 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJS-0004oR-Sr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jgCd+M5r15AZHXI9ALG7AycpEm51VFk6or8yUWOvEIc=; b=OS6n2Kfj/8mms83
 8sAytOmvykelhX5+HLyIFNH4QF5m1uJLiUlinc/SttYg6XBQvKj0oL61SdzOXjrS6bmauM7llaBiB
 GVGTt61F6cmi+yblF0NeVbGlSjDYIDUD2lcafP7+khepcoiCynaplMNyA0+9DwJeqosBrH9Vbp1S/
 Yo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 33/43] helper-to-tcg: Add end-to-end tests
Date: Thu, 21 Nov 2024 02:49:37 +0100
Message-ID: <20241121014947.18666-34-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduces simple end-to-end tests of helper-to-tcg of functions the
translator is expected to handle, any translation failure will result in
a test failure.  More test cases to come.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   2 +
 subprojects/helper-to-tcg/tests/cpustate.c    |  45 +++++++
 subprojects/helper-to-tcg/tests/ldst.c        |  17 +++
 subprojects/helper-to-tcg/tests/meson.build   |  24 ++++
 subprojects/helper-to-tcg/tests/scalar.c      |  15 +++
 .../helper-to-tcg/tests/tcg-global-mappings.h | 115 ++++++++++++++++++
 subprojects/helper-to-tcg/tests/vector.c      |  26 ++++
 7 files changed, 244 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/meson.build
 create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/tests/vector.c

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 4f045eb1da..e09f121e18 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -80,3 +80,5 @@ pipeline = executable('helper-to-tcg', sources,
                       include_directories: ['passes', './', 'include'] + [incdir],
                       link_args: [ldflags] + [libs] + [syslibs],
                       cpp_args: cpp_args)
+
+subdir('tests')
diff --git a/subprojects/helper-to-tcg/tests/cpustate.c b/subprojects/helper-to-tcg/tests/cpustate.c
new file mode 100644
index 0000000000..79205da75e
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/cpustate.c
@@ -0,0 +1,45 @@
+#include <stdint.h>
+#include "tcg-global-mappings.h"
+
+typedef struct SpecialData {
+    uint32_t a;
+    uint32_t unmapped_field;
+} SpecialData;
+
+typedef struct CPUArchState {
+    uint32_t regs[32];
+    uint32_t unmapped_field;
+    SpecialData data[8];
+    uint32_t mapped_field;
+} CPUArchState;
+
+/* Dummy struct, in QEMU this would correspond to TCGv_i32 in tcg.h */
+typedef struct TCGv_i32 {} TCGv_i32;
+/* Global TCGv's representing CPU state */
+TCGv_i32 tcg_regs[32];
+TCGv_i32 tcg_a[8];
+TCGv_i32 tcg_field;
+
+cpu_tcg_mapping mappings[] = {
+    CPU_TCG_MAP_ARRAY(CPUArchState, tcg_regs, regs, NULL),
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUArchState, tcg_a, data, a, NULL),
+    CPU_TCG_MAP(CPUArchState, tcg_field, mapped_field, NULL),
+};
+
+__attribute__((annotate ("immediate: 1")))
+uint32_t helper_reg(CPUArchState *env, uint32_t i) {
+    return env->regs[i];
+}
+
+__attribute__((annotate ("immediate: 1")))
+uint32_t helper_data_a(CPUArchState *env, uint32_t i) {
+    return env->data[i].a;
+}
+
+uint32_t helper_single_mapped(CPUArchState *env) {
+    return env->mapped_field;
+}
+
+uint32_t helper_unmapped(CPUArchState *env) {
+    return env->unmapped_field;
+}
diff --git a/subprojects/helper-to-tcg/tests/ldst.c b/subprojects/helper-to-tcg/tests/ldst.c
new file mode 100644
index 0000000000..44d32d0875
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ldst.c
@@ -0,0 +1,17 @@
+#include <stdint.h>
+
+/* Opaque CPU state type, will be mapped to tcg_env */
+struct CPUArchState;
+typedef struct CPUArchState CPUArchState;
+
+/* Prototype of QEMU helper guest load/store functions, see exec/cpu_ldst.h */
+uint32_t cpu_ldub_data(CPUArchState *, uint32_t ptr);
+void cpu_stb_data(CPUArchState *, uint32_t ptr, uint32_t data);
+
+uint32_t helper_ld8(CPUArchState *env, uint32_t addr) {
+    return cpu_ldub_data(env, addr);
+}
+
+void helper_st8(CPUArchState *env, uint32_t addr, uint32_t data) {
+    return cpu_stb_data(env, addr, data);
+}
diff --git a/subprojects/helper-to-tcg/tests/meson.build b/subprojects/helper-to-tcg/tests/meson.build
new file mode 100644
index 0000000000..e7b9329c82
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/meson.build
@@ -0,0 +1,24 @@
+sources = [
+    'scalar.c',
+    'vector.c',
+    'ldst.c',
+    'cpustate.c',
+]
+
+
+foreach s : sources
+    name = s.split('.')[0]
+    name_ll = name + '.ll'
+    ll = custom_target(name_ll,
+        input: s,
+        output: name_ll,
+        command: [clang, '-O0', '-Xclang', '-disable-O0-optnone',
+                  '-S', '-emit-llvm', '-o', '@OUTPUT@', '@INPUT@']
+    )
+    test(name, pipeline,
+        args: [ll,
+               '--mmu-index-function=tb_mmu_index',
+               '--tcg-global-mappings=mappings',
+               '--translate-all-helpers'],
+        suite: 'end-to-end')
+endforeach
diff --git a/subprojects/helper-to-tcg/tests/scalar.c b/subprojects/helper-to-tcg/tests/scalar.c
new file mode 100644
index 0000000000..09af72371d
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/scalar.c
@@ -0,0 +1,15 @@
+#include <stdint.h>
+
+/* Simple arithmetic */
+uint32_t helper_add(uint32_t a, uint32_t b) {
+    return a + b;
+}
+
+/* Control flow reducable to conditinal move */
+uint32_t helper_cmov(uint32_t c0, uint32_t c1, uint32_t a, uint32_t b) {
+    if (c0 < c1) {
+        return a;
+    } else {
+        return b;
+    }
+}
diff --git a/subprojects/helper-to-tcg/tests/tcg-global-mappings.h b/subprojects/helper-to-tcg/tests/tcg-global-mappings.h
new file mode 100644
index 0000000000..fed3577bcf
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/tcg-global-mappings.h
@@ -0,0 +1,115 @@
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
+#ifndef TCG_GLOBAL_MAP_H
+#define TCG_GLOBAL_MAP_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+#define _stringify(STR) #STR
+#define stringify(STR) _stringify(TR)
+
+/**
+ * cpu_tcg_mapping: Declarative mapping of offsets into a struct to global
+ *                  TCGvs.  Parseable by LLVM-based tools.
+ * @tcg_var_name: String name of the TCGv to use as destination of the mapping.
+ * @tcg_var_base_address: Address of the above TCGv.
+ * @cpu_var_names: Array of printable names of TCGvs, used when calling
+ *                 tcg_global_mem_new from init_cpu_tcg_mappings.
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
+#define CPU_TCG_MAP(struct_type, tcg_var, cpu_var, name_str)                   \
+    (cpu_tcg_mapping)                                                          \
+    {                                                                          \
+        .tcg_var_name = stringify(tcg_var), .tcg_var_base_address = &tcg_var,  \
+        .cpu_var_names = (const char *[]){name_str},                           \
+        .cpu_var_base_offset = offsetof(struct_type, cpu_var),                 \
+        .cpu_var_size = STRUCT_SIZEOF_FIELD(struct_type, cpu_var),             \
+        .cpu_var_stride = 0, .number_of_elements = 1,                          \
+    }
+
+/* Map between array of CPU registers and array of TCG globals. */
+#define CPU_TCG_MAP_ARRAY(struct_type, tcg_var, cpu_var, names)                \
+    (cpu_tcg_mapping)                                                          \
+    {                                                                          \
+        .tcg_var_name = #tcg_var, .tcg_var_base_address = tcg_var,             \
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
+        .tcg_var_name = #tcg_var, .tcg_var_base_address = tcg_var,             \
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
diff --git a/subprojects/helper-to-tcg/tests/vector.c b/subprojects/helper-to-tcg/tests/vector.c
new file mode 100644
index 0000000000..c40f63b60d
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/vector.c
@@ -0,0 +1,26 @@
+#include <stdint.h>
+
+__attribute__((annotate("ptr-to-offset: 0"))) void
+helper_vec_splat_reg(void *restrict d, uint8_t imm)
+{
+    for (int i = 0; i < 32; ++i) {
+        ((uint8_t *)d)[i] = imm;
+    }
+}
+
+__attribute__((annotate("immediate: 1")))
+__attribute__((annotate("ptr-to-offset: 0"))) void
+helper_vec_splat_imm(void *restrict d, uint8_t imm)
+{
+    for (int i = 0; i < 32; ++i) {
+        ((uint8_t *)d)[i] = imm;
+    }
+}
+
+__attribute__((annotate("ptr-to-offset: 0, 1, 2"))) void
+helper_vec_add(void *restrict d, void *restrict a, void *restrict b)
+{
+    for (int i = 0; i < 32; ++i) {
+        ((uint8_t *)d)[i] = ((uint8_t *)a)[i] + ((uint8_t *)b)[i];
+    }
+}
-- 
2.45.2


