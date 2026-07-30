Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61131C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7e-0005BL-BG; Wed, 29 Jul 2026 23:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7N-0004iP-E1
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:36 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7E-00030W-1i
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=yLtiDPWrhpHEzs+8I04IWvaSBZQpQvDVHMWqtGD46Jg=; b=eUUEcOmZd5mwIy0
 Hq0H/8Bxrf8tqXNHtHPfrO0cP2r5u/bKhFC5Dns3RQDGZhH+98r6WuBP74CeuURW6/5VJcQQP9mmj
 GnyITRZ3DD39z3fDNxJ/HojTEpSJuMZln+5eQ6RA24/m1DhvaESwYqVAdIaWg7G67mdkLX0k2QAWh
 rA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 39/50] helper-to-tcg: Add end-to-end tests
Date: Thu, 30 Jul 2026 05:10:13 +0200
Message-ID: <20260730031025.12926-40-anjo@rev.ng>
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

Introduces simple end-to-end tests, providing input functions covering a
variety of features, and expected outputs for each of test and supported
LLVM version. (Currently reference code for LLVM 15 and 21 is added).

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   2 +
 .../helper-to-tcg/tests/call-to-declaration.c |  33 ++
 .../helper-to-tcg/tests/call-translation.c    |  35 ++
 subprojects/helper-to-tcg/tests/cpustate.c    |  44 ++
 .../helper-to-tcg/tests/forward-context.c     |  21 +
 subprojects/helper-to-tcg/tests/ldst.c        |  17 +
 subprojects/helper-to-tcg/tests/meson.build   | 121 ++++
 .../tests/ref/15/call-to-declaration.c        |  26 +
 .../tests/ref/15/call-translation.c           |  28 +
 .../helper-to-tcg/tests/ref/15/cpustate.c     |  36 ++
 .../tests/ref/15/forward-context.c            |  30 +
 subprojects/helper-to-tcg/tests/ref/15/ldst.c |  21 +
 .../helper-to-tcg/tests/ref/15/scalar.c       |  21 +
 .../tests/ref/15/user-pcrel-jump.c            |  33 ++
 .../tests/ref/15/vector-layout-f16L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f16M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f32L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f32M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f64L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f64M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f8L.c          | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-f8M.c          | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t16L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t16M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t32L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t32M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t64L.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t64M.c         | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t8L.c          | 527 ++++++++++++++++++
 .../tests/ref/15/vector-layout-t8M.c          | 527 ++++++++++++++++++
 .../helper-to-tcg/tests/ref/15/vector.c       |  31 ++
 .../tests/ref/21/call-to-declaration.c        |  26 +
 .../tests/ref/21/call-translation.c           |  28 +
 .../helper-to-tcg/tests/ref/21/cpustate.c     |  36 ++
 .../tests/ref/21/forward-context.c            |  30 +
 subprojects/helper-to-tcg/tests/ref/21/ldst.c |  21 +
 .../helper-to-tcg/tests/ref/21/scalar.c       |  21 +
 .../tests/ref/21/user-pcrel-jump.c            |  33 ++
 .../tests/ref/21/vector-layout-f16L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f16M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f32L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f32M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f64L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f64M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f8L.c          | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-f8M.c          | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t16L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t16M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t32L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t32M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t64L.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t64M.c         | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t8L.c          | 527 ++++++++++++++++++
 .../tests/ref/21/vector-layout-t8M.c          | 527 ++++++++++++++++++
 .../helper-to-tcg/tests/ref/21/vector.c       |  31 ++
 subprojects/helper-to-tcg/tests/scalar.c      |  15 +
 .../helper-to-tcg/tests/tcg-global-mappings.h | 118 ++++
 .../helper-to-tcg/tests/user-pcrel-jump.c     |  28 +
 .../helper-to-tcg/tests/vector-layout.c       |  51 ++
 subprojects/helper-to-tcg/tests/vector.c      |  34 ++
 60 files changed, 17835 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/tests/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/meson.build
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector.c
 create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/tests/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/vector-layout.c
 create mode 100644 subprojects/helper-to-tcg/tests/vector.c

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 413d7ad8fa..d903b560d1 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -82,3 +82,5 @@ pipeline = executable('helper-to-tcg', sources,
                       include_directories: ['include'] + [incdir],
                       link_args: [ldflags] + [libs] + [syslibs],
                       cpp_args: cpp_args)
+
+subdir('tests')
diff --git a/subprojects/helper-to-tcg/tests/call-to-declaration.c b/subprojects/helper-to-tcg/tests/call-to-declaration.c
new file mode 100644
index 0000000000..d0fc583270
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/call-to-declaration.c
@@ -0,0 +1,33 @@
+/*
+ * Test translation of calls to declration
+ *
+ * (experimental)
+ */
+
+#define ANNOTATE(str) __attribute__((annotate(str)))
+
+int fdecl0(int a);
+
+ANNOTATE("helper-to-tcg")
+int f0(int cond, int b) {
+    return fdecl0(b);
+}
+
+ANNOTATE("immediate: 0")
+int fdecl1(int a);
+
+ANNOTATE("helper-to-tcg")
+ANNOTATE("immediate: 1")
+int f1(int cond, int b) {
+    return fdecl1(b);
+}
+
+ANNOTATE("returns-immediate")
+ANNOTATE("immediate: 0")
+int fdecl2(int a);
+
+ANNOTATE("helper-to-tcg")
+ANNOTATE("immediate: 0")
+int f2(int b) {
+    return fdecl2(b);
+}
diff --git a/subprojects/helper-to-tcg/tests/call-translation.c b/subprojects/helper-to-tcg/tests/call-translation.c
new file mode 100644
index 0000000000..fc3ca68755
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/call-translation.c
@@ -0,0 +1,35 @@
+/*
+ * Test translation of dependent functions.
+ *
+ * This test will be ran without --translate-all-helpers, meaning we have to
+ * manually mark them for translation.
+ */
+
+#define ANNOTATE(str) __attribute__((annotate(str)))
+
+/*
+ * Only inner0 is marked for translation, outer0 will be skipped.
+ */
+ANNOTATE("helper-to-tcg")
+int inner0(int a) { return a + 5; }
+
+int outer0(int cond, int b) {
+    if (cond) {
+        return inner0(b);
+    }
+    return 0;
+}
+
+/*
+ * Both inner1 and outer1 will be translated since outer1 is marked for
+ * translation and depends on inner1.
+ */
+int inner1(int a) { return a + 5; }
+
+ANNOTATE("helper-to-tcg")
+int outer1(int cond, int b) {
+    if (cond) {
+        return inner1(b);
+    }
+    return 0;
+}
diff --git a/subprojects/helper-to-tcg/tests/cpustate.c b/subprojects/helper-to-tcg/tests/cpustate.c
new file mode 100644
index 0000000000..61ff6b28cf
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/cpustate.c
@@ -0,0 +1,44 @@
+#include <stddef.h>
+#include <stdint.h>
+
+#define stringify(str) #str
+
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
+/* Global TCGv's representing CPU state */
+struct{} tcg_regs[32];
+struct{} tcg_a[8];
+struct{} tcg_field;
+
+cpu_tcg_mapping mappings[] = {
+    CPU_TCG_MAP_ARRAY(CPUArchState, tcg_regs, regs, NULL),
+    CPU_TCG_MAP_ARRAY_OF_STRUCTS(CPUArchState, tcg_a, data, a, NULL),
+    CPU_TCG_MAP(CPUArchState, tcg_field, mapped_field),
+};
+
+__attribute__((annotate("immediate: 1"))) uint32_t helper_reg(CPUArchState *env,
+                                                              uint32_t i) {
+    return env->regs[i];
+}
+
+__attribute__((annotate("immediate: 1"))) uint32_t
+helper_data_a(CPUArchState *env, uint32_t i) {
+    return env->data[i].a;
+}
+
+uint32_t helper_single_mapped(CPUArchState *env) { return env->mapped_field; }
+
+uint32_t helper_unmapped(CPUArchState *env) { return env->unmapped_field; }
diff --git a/subprojects/helper-to-tcg/tests/forward-context.c b/subprojects/helper-to-tcg/tests/forward-context.c
new file mode 100644
index 0000000000..4eb55b7e3d
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/forward-context.c
@@ -0,0 +1,21 @@
+/*
+ * Test translation of calls to declration
+ *
+ * This test will be ran without --translate-all-helpers, meaning we have to
+ * manually mark them for translation.
+ */
+
+#define ANNOTATE(str) __attribute__((annotate(str)))
+
+ANNOTATE("immediate: 0")
+int fdecl0(int a);
+
+ANNOTATE("helper-to-tcg")
+int f0(int a, int off) {
+    return a + fdecl0(off);
+}
+
+ANNOTATE("helper-to-tcg")
+int f1(int a) {
+    return f0(a,a) + f0(-a,-a);
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
index 0000000000..b2e53550eb
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/meson.build
@@ -0,0 +1,121 @@
+fs = import('fs')
+
+sources = {
+    'scalar.c' : ['--translate-all-helpers'],
+    'ldst.c' : [
+        '--translate-all-helpers',
+        '--mmu-index-function=tb_mmu_index',
+    ],
+    'cpustate.c' : [
+        '--translate-all-helpers',
+        '--tcg-global-mappings=mappings',
+    ],
+    'vector.c' : [
+        '--translate-all-helpers',
+        '--temp-vector-block=vmem',
+    ],
+    'call-translation.c' : [],
+    'call-to-declaration.c' : [
+        '--allow-decl-call',
+    ],
+    'forward-context.c' : [
+        '--allow-decl-call',
+        '--forward-context',
+    ],
+    'user-pcrel-jump.c' : [
+        '--allow-decl-call',
+        '--user-pcrel-branch-func=target_pcrel_jump',
+        '--user-pcrel-branch-conditional-func=target_pcrel_jump_cond',
+        '--user-pcrel-branch-fallthrough-func=target_pcrel_jump_fall',
+    ],
+}
+
+sources_vector_layout = {
+    'vector-layout.c' : [],
+}
+
+diff = find_program('diff')
+
+foreach file : sources.keys()
+    extra_flags = sources.get(file)
+
+    name = file.split('.')[0]
+    name_ll = name + '.ll'
+
+    ll = custom_target(name_ll,
+        input: files(file),
+        output: name_ll,
+        command: [clang, '-O0', '-Xclang', '-disable-O0-optnone',
+                  '-g', '-S', '-emit-llvm', '-o', '@OUTPUT@', '@INPUT@']
+    )
+
+    output_prefix = join_paths(meson.current_build_dir(), name)
+    flags = [ll,
+        '--output-enabled=' + output_prefix + '-enabled',
+        '--output-source=' + output_prefix + '.c',
+        '--output-header=' + output_prefix + '.h',
+        '--mmu-index-function=tb_mmu_index',
+        '--tcg-global-mappings=mappings']
+    flags += extra_flags
+
+    runtest = name + '-run-' + version_major.to_string()
+    test(runtest,
+        pipeline,
+        depends: ll,
+        priority: 2,
+        args: flags,
+        suite: 'helper-to-tcg')
+
+    ref = join_paths(meson.current_source_dir(), 'ref', version_major.to_string(), name + '.c')
+    if fs.exists(ref)
+        test(name + '-diff-' + version_major.to_string(),
+            diff,
+            priority: 1,
+            args: ['-u', output_prefix + '.c', ref ], suite: 'helper-to-tcg')
+    endif
+endforeach
+
+# Build and compare tests against references again, but force different vector layouts.
+foreach file : sources_vector_layout.keys()
+    extra_flags = sources_vector_layout.get(file)
+    name = file.split('.')[0]
+    name_ll = name + '.ll'
+
+    ll = custom_target(name_ll,
+        input: files(file),
+        output: name_ll,
+        command: [clang, '-O0', '-Xclang', '-disable-O0-optnone',
+                  '-g', '-S', '-emit-llvm', '-o', '@OUTPUT@', '@INPUT@']
+    )
+
+    foreach size : [8,16,32,64]
+        foreach lane0 : ['LeastSignificant', 'MostSignificant']
+            foreach big_endian: ['true', 'false']
+                test_str = big_endian[0] + size.to_string() + lane0[0]
+                output_prefix = join_paths(meson.current_build_dir(), name + '-' + test_str)
+                runtest = name + '-run-' + test_str
+                test(runtest,
+                    pipeline,
+                    depends: ll,
+                    priority: 2,
+                    args: [ll,
+                           '--output-enabled=' + output_prefix + '-enabled',
+                           '--output-source=' + output_prefix + '.c',
+                           '--output-header=' + output_prefix + '.h',
+                           '--translate-all-helpers',
+                           '--vec-force-big-endian=' + big_endian,
+                           '--vec-block-bytes=' + size.to_string(),
+                           '--vec-lane-0=' + lane0,
+                    ] + extra_flags,
+                    suite: 'helper-to-tcg')
+                ref = join_paths(meson.current_source_dir(), 'ref', version_major.to_string(), name + '-' + test_str + '.c')
+                if fs.exists(ref)
+                    test(name + '-diff-' + test_str,
+                        diff,
+                        priority: 1,
+                        args: ['-u', output_prefix + '.c', ref ], suite: 'helper-to-tcg')
+                endif
+            endforeach
+        endforeach
+    endforeach
+endforeach
diff --git a/subprojects/helper-to-tcg/tests/ref/15/call-to-declaration.c b/subprojects/helper-to-tcg/tests/ref/15/call-to-declaration.c
new file mode 100644
index 0000000000..e778d8785d
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/call-to-declaration.c
@@ -0,0 +1,26 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "call-to-declaration.h"
+
+// i32 f0
+void emit_f0(TCGv_i32 tmp2, TCGv_i32 tmp0, TCGv_i32 b) {
+tmp2 = fdecl0(b);
+}
+
+// i32 f1
+void emit_f1(TCGv_i32 tmp2, TCGv_i32 tmp0, uint32_t b) {
+tmp2 = fdecl1(tcg_constant_i32(b));
+}
+
+// i32 f2
+void emit_f2(TCGv_i32 tmp1, uint32_t b) {
+tmp1 = fdecl2(tcg_constant_i32(b));
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/call-translation.c b/subprojects/helper-to-tcg/tests/ref/15/call-translation.c
new file mode 100644
index 0000000000..406f48953e
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/call-translation.c
@@ -0,0 +1,28 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "call-translation.h"
+
+// i32 inner0
+void emit_inner0(TCGv_i32 tmp2, TCGv_i32 a) {
+tcg_gen_add_i32(tmp2, a, tcg_constant_i32(5));
+}
+
+// i32 inner1
+void emit_inner1(TCGv_i32 tmp2, TCGv_i32 a) {
+tcg_gen_add_i32(tmp2, a, tcg_constant_i32(5));
+}
+
+// i32 outer1
+void emit_outer1(TCGv_i32 tmp5, TCGv_i32 cond, TCGv_i32 b) {
+TCGv_i32 tmp6 = tcg_temp_new_i32();
+tcg_gen_add_i32(tmp6, b, tcg_constant_i32(5));
+tcg_gen_movcond_i32(TCG_COND_EQ, tmp5, cond, tcg_constant_i32(0), tcg_constant_i32(0), tmp6);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/cpustate.c b/subprojects/helper-to-tcg/tests/ref/15/cpustate.c
new file mode 100644
index 0000000000..e022a14d0c
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/cpustate.c
@@ -0,0 +1,36 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "cpustate.h"
+
+extern TCGv_i32 tcg_regs[32];
+extern TCGv_i32 tcg_a[8];
+extern TCGv_i32 tcg_field;
+// i32 helper_reg
+void emit_reg(TCGv_i32 tmp5, TCGv_ptr env, uint32_t i) {
+tcg_gen_mov_i32(tmp5, tcg_regs[((uint64_t) (uint32_t) i)]);
+}
+
+// i32 helper_data_a
+void emit_data_a(TCGv_i32 tmp6, TCGv_ptr env, uint32_t i) {
+tcg_gen_mov_i32(tmp6, tcg_a[((uint64_t) (uint32_t) i)]);
+}
+
+// i32 helper_single_mapped
+void emit_single_mapped(TCGv_i32 tmp4, TCGv_ptr env) {
+tcg_gen_mov_i32(tmp4, tcg_field);
+}
+
+// i32 helper_unmapped
+void emit_unmapped(TCGv_i32 tmp2, TCGv_ptr env) {
+TCGv_ptr ptr3 = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(ptr3, env, 128ull);
+tcg_gen_ld_i32(tmp2, ptr3, 0);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/forward-context.c b/subprojects/helper-to-tcg/tests/ref/15/forward-context.c
new file mode 100644
index 0000000000..a1c0e5f37a
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/forward-context.c
@@ -0,0 +1,30 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "translate.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "forward-context.h"
+
+#include "translate.h"
+// i32 f0
+void emit_f0(DisasContext *ctx, TCGv_i32 tmp2, TCGv_i32 a, TCGv_i32 off) {
+TCGv_i32 tmp3 = tcg_temp_new_i32();
+tmp3 = fdecl0(ctx, off);
+tcg_gen_add_i32(tmp2, tmp3, a);
+}
+
+// i32 f1
+void emit_f1(DisasContext *ctx, TCGv_i32 tmp2, TCGv_i32 a) {
+TCGv_i32 tmp4 = tcg_temp_new_i32();
+tmp4 = fdecl0(ctx, a);
+tcg_gen_sub_i32(tmp2, tcg_constant_i32(0), a);
+TCGv_i32 tmp3 = tcg_temp_new_i32();
+tmp3 = fdecl0(ctx, tmp2);
+tcg_gen_add_i32(tmp2, tmp3, tmp4);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/ldst.c b/subprojects/helper-to-tcg/tests/ref/15/ldst.c
new file mode 100644
index 0000000000..5710b0b285
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/ldst.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "ldst.h"
+
+// i32 helper_ld8
+void emit_ld8(TCGv_i32 tmp4, TCGv_ptr env, TCGv_i32 addr) {
+tcg_gen_qemu_ld_i32(tmp4, addr, tb_mmu_index(tcg_ctx->gen_tb->flags), MO_8);
+}
+
+// void helper_st8
+void emit_st8(TCGv_ptr env, TCGv_i32 addr, TCGv_i32 data) {
+tcg_gen_qemu_st_i32(data, addr, tb_mmu_index(tcg_ctx->gen_tb->flags), MO_8);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/scalar.c b/subprojects/helper-to-tcg/tests/ref/15/scalar.c
new file mode 100644
index 0000000000..50fe4307c0
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/scalar.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "scalar.h"
+
+// i32 helper_add
+void emit_add(TCGv_i32 tmp2, TCGv_i32 a, TCGv_i32 b) {
+tcg_gen_add_i32(tmp2, b, a);
+}
+
+// i32 helper_cmov
+void emit_cmov(TCGv_i32 tmp5, TCGv_i32 c0, TCGv_i32 c1, TCGv_i32 a, TCGv_i32 b) {
+tcg_gen_movcond_i32(TCG_COND_LTU, tmp5, c0, c1, a, b);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/user-pcrel-jump.c b/subprojects/helper-to-tcg/tests/ref/15/user-pcrel-jump.c
new file mode 100644
index 0000000000..68e6c5d441
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/user-pcrel-jump.c
@@ -0,0 +1,33 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "user-pcrel-jump.h"
+
+// void prcel_jump
+void emit_prcel_jump(TCGv_i32 off) {
+TCGv_i32 ea = tcg_temp_new_i32();
+tcg_gen_shl_i32(ea, off, tcg_constant_i32(2));
+tcg_gen_or_i32(ea, ea, tcg_constant_i32(3));
+target_pcrel_jump(ea);
+}
+
+// void prcel_condjump
+void emit_prcel_condjump(TCGv_i32 cond, TCGv_i32 off) {
+TCGLabel * label8 = gen_new_label();
+TCGLabel * label9 = gen_new_label();
+tcg_gen_brcondi_i32(TCG_COND_EQ, cond, 0, label8);
+gen_set_label(label9);
+TCGv_i32 ea = tcg_temp_new_i32();
+tcg_gen_shl_i32(ea, off, tcg_constant_i32(2));
+tcg_gen_or_i32(ea, ea, tcg_constant_i32(3));
+target_pcrel_jump(ea);
+tcg_gen_br(label8);
+gen_set_label(label8);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16L.c
new file mode 100644
index 0000000000..146c940bd4
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f16L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16M.c
new file mode 100644
index 0000000000..76cff20bee
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f16M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * (1 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * (1 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * (1 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * (1 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x90A0B0C0D0E0F10, 0x102030405060708, 0x191A1B1C1D1E1F20, 0x1112131415161718};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32L.c
new file mode 100644
index 0000000000..8515b3488e
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f32L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32M.c
new file mode 100644
index 0000000000..41067c4c62
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f32M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * (3 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * (3 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * (3 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * (3 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x191A1B1C1D1E1F20, 0x1112131415161718, 0x90A0B0C0D0E0F10, 0x102030405060708};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64L.c
new file mode 100644
index 0000000000..d8e660be8b
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f64L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64M.c
new file mode 100644
index 0000000000..facfe730c1
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f64M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * (7 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * (7 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * (7 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * (7 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x191A1B1C1D1E1F20, 0x1112131415161718, 0x90A0B0C0D0E0F10, 0x102030405060708};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8L.c
new file mode 100644
index 0000000000..98f4d0a584
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f8L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8M.c
new file mode 100644
index 0000000000..a768efc628
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f8M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * (0 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * (0 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * (0 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * (0 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16L.c
new file mode 100644
index 0000000000..ca6944fa92
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t16L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * (1 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * (1 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * (1 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * (1 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x100F0E0D0C0B0A09, 0x807060504030201, 0x201F1E1D1C1B1A19, 0x1817161514131211};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16M.c
new file mode 100644
index 0000000000..a4e0ca054f
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t16M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32L.c
new file mode 100644
index 0000000000..b142d9b8ce
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t32L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * (3 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * (3 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * (3 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * (3 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x201F1E1D1C1B1A19, 0x1817161514131211, 0x100F0E0D0C0B0A09, 0x807060504030201};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32M.c
new file mode 100644
index 0000000000..109ab19c39
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t32M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64L.c
new file mode 100644
index 0000000000..4f325caa75
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t64L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * (7 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * (7 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * (7 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * (7 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x201F1E1D1C1B1A19, 0x1817161514131211, 0x100F0E0D0C0B0A09, 0x807060504030201};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64M.c
new file mode 100644
index 0000000000..766a827128
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t64M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8L.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8L.c
new file mode 100644
index 0000000000..18feb85fad
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t8L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * (0 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * (0 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * (0 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * (0 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8M.c b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8M.c
new file mode 100644
index 0000000000..97ebe17e91
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t8M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/15/vector.c b/subprojects/helper-to-tcg/tests/ref/15/vector.c
new file mode 100644
index 0000000000..deeec8e8ab
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/15/vector.c
@@ -0,0 +1,31 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector.h"
+
+// void helper_vec_splat_reg
+void emit_vec_splat_reg(intptr_t d, TCGv_i32 imm) {
+tcg_gen_gvec_dup_i32(MO_8, d, 32ull, 32ull, imm);
+}
+
+// void helper_vec_splat_imm
+void emit_vec_splat_imm(intptr_t d, uint8_t imm) {
+tcg_gen_gvec_dup_imm(MO_8, d, 32ull, 32ull, imm);
+}
+
+// void helper_vec_add
+void emit_vec_add(intptr_t d, intptr_t a, intptr_t b) {
+tcg_gen_gvec_add(MO_8, d, b, a, 32, 32);
+}
+
+// void helper_vec_add32
+void emit_vec_add32(intptr_t d, intptr_t a, intptr_t b) {
+tcg_gen_gvec_add(MO_32, d, b, a, 128, 128);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/call-to-declaration.c b/subprojects/helper-to-tcg/tests/ref/21/call-to-declaration.c
new file mode 100644
index 0000000000..4b445ec8b1
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/call-to-declaration.c
@@ -0,0 +1,26 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "call-to-declaration.h"
+
+// i32 f0
+void emit_f0(TCGv_i32 tmp2, TCGv_i32 tmp0, TCGv_i32 b) {
+tmp2 = fdecl0(b);
+}
+
+// i32 f1
+void emit_f1(TCGv_i32 tmp2, TCGv_i32 tmp0, uint32_t b) {
+tmp2 = fdecl1(b);
+}
+
+// i32 f2
+void emit_f2(TCGv_i32 tmp2, uint32_t b) {
+tcg_gen_movi_i32(tmp2, imm1);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/call-translation.c b/subprojects/helper-to-tcg/tests/ref/21/call-translation.c
new file mode 100644
index 0000000000..406f48953e
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/call-translation.c
@@ -0,0 +1,28 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "call-translation.h"
+
+// i32 inner0
+void emit_inner0(TCGv_i32 tmp2, TCGv_i32 a) {
+tcg_gen_add_i32(tmp2, a, tcg_constant_i32(5));
+}
+
+// i32 inner1
+void emit_inner1(TCGv_i32 tmp2, TCGv_i32 a) {
+tcg_gen_add_i32(tmp2, a, tcg_constant_i32(5));
+}
+
+// i32 outer1
+void emit_outer1(TCGv_i32 tmp5, TCGv_i32 cond, TCGv_i32 b) {
+TCGv_i32 tmp6 = tcg_temp_new_i32();
+tcg_gen_add_i32(tmp6, b, tcg_constant_i32(5));
+tcg_gen_movcond_i32(TCG_COND_EQ, tmp5, cond, tcg_constant_i32(0), tcg_constant_i32(0), tmp6);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/cpustate.c b/subprojects/helper-to-tcg/tests/ref/21/cpustate.c
new file mode 100644
index 0000000000..e022a14d0c
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/cpustate.c
@@ -0,0 +1,36 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "cpustate.h"
+
+extern TCGv_i32 tcg_regs[32];
+extern TCGv_i32 tcg_a[8];
+extern TCGv_i32 tcg_field;
+// i32 helper_reg
+void emit_reg(TCGv_i32 tmp5, TCGv_ptr env, uint32_t i) {
+tcg_gen_mov_i32(tmp5, tcg_regs[((uint64_t) (uint32_t) i)]);
+}
+
+// i32 helper_data_a
+void emit_data_a(TCGv_i32 tmp6, TCGv_ptr env, uint32_t i) {
+tcg_gen_mov_i32(tmp6, tcg_a[((uint64_t) (uint32_t) i)]);
+}
+
+// i32 helper_single_mapped
+void emit_single_mapped(TCGv_i32 tmp4, TCGv_ptr env) {
+tcg_gen_mov_i32(tmp4, tcg_field);
+}
+
+// i32 helper_unmapped
+void emit_unmapped(TCGv_i32 tmp2, TCGv_ptr env) {
+TCGv_ptr ptr3 = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(ptr3, env, 128ull);
+tcg_gen_ld_i32(tmp2, ptr3, 0);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/forward-context.c b/subprojects/helper-to-tcg/tests/ref/21/forward-context.c
new file mode 100644
index 0000000000..a1c0e5f37a
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/forward-context.c
@@ -0,0 +1,30 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "translate.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "forward-context.h"
+
+#include "translate.h"
+// i32 f0
+void emit_f0(DisasContext *ctx, TCGv_i32 tmp2, TCGv_i32 a, TCGv_i32 off) {
+TCGv_i32 tmp3 = tcg_temp_new_i32();
+tmp3 = fdecl0(ctx, off);
+tcg_gen_add_i32(tmp2, tmp3, a);
+}
+
+// i32 f1
+void emit_f1(DisasContext *ctx, TCGv_i32 tmp2, TCGv_i32 a) {
+TCGv_i32 tmp4 = tcg_temp_new_i32();
+tmp4 = fdecl0(ctx, a);
+tcg_gen_sub_i32(tmp2, tcg_constant_i32(0), a);
+TCGv_i32 tmp3 = tcg_temp_new_i32();
+tmp3 = fdecl0(ctx, tmp2);
+tcg_gen_add_i32(tmp2, tmp3, tmp4);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/ldst.c b/subprojects/helper-to-tcg/tests/ref/21/ldst.c
new file mode 100644
index 0000000000..5710b0b285
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/ldst.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "ldst.h"
+
+// i32 helper_ld8
+void emit_ld8(TCGv_i32 tmp4, TCGv_ptr env, TCGv_i32 addr) {
+tcg_gen_qemu_ld_i32(tmp4, addr, tb_mmu_index(tcg_ctx->gen_tb->flags), MO_8);
+}
+
+// void helper_st8
+void emit_st8(TCGv_ptr env, TCGv_i32 addr, TCGv_i32 data) {
+tcg_gen_qemu_st_i32(data, addr, tb_mmu_index(tcg_ctx->gen_tb->flags), MO_8);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/scalar.c b/subprojects/helper-to-tcg/tests/ref/21/scalar.c
new file mode 100644
index 0000000000..50fe4307c0
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/scalar.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "scalar.h"
+
+// i32 helper_add
+void emit_add(TCGv_i32 tmp2, TCGv_i32 a, TCGv_i32 b) {
+tcg_gen_add_i32(tmp2, b, a);
+}
+
+// i32 helper_cmov
+void emit_cmov(TCGv_i32 tmp5, TCGv_i32 c0, TCGv_i32 c1, TCGv_i32 a, TCGv_i32 b) {
+tcg_gen_movcond_i32(TCG_COND_LTU, tmp5, c0, c1, a, b);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/user-pcrel-jump.c b/subprojects/helper-to-tcg/tests/ref/21/user-pcrel-jump.c
new file mode 100644
index 0000000000..68e6c5d441
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/user-pcrel-jump.c
@@ -0,0 +1,33 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "user-pcrel-jump.h"
+
+// void prcel_jump
+void emit_prcel_jump(TCGv_i32 off) {
+TCGv_i32 ea = tcg_temp_new_i32();
+tcg_gen_shl_i32(ea, off, tcg_constant_i32(2));
+tcg_gen_or_i32(ea, ea, tcg_constant_i32(3));
+target_pcrel_jump(ea);
+}
+
+// void prcel_condjump
+void emit_prcel_condjump(TCGv_i32 cond, TCGv_i32 off) {
+TCGLabel * label8 = gen_new_label();
+TCGLabel * label9 = gen_new_label();
+tcg_gen_brcondi_i32(TCG_COND_EQ, cond, 0, label8);
+gen_set_label(label9);
+TCGv_i32 ea = tcg_temp_new_i32();
+tcg_gen_shl_i32(ea, off, tcg_constant_i32(2));
+tcg_gen_or_i32(ea, ea, tcg_constant_i32(3));
+target_pcrel_jump(ea);
+tcg_gen_br(label8);
+gen_set_label(label8);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16L.c
new file mode 100644
index 0000000000..146c940bd4
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f16L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16M.c
new file mode 100644
index 0000000000..76cff20bee
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f16M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * (1 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * (1 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * (1 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * (1 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x90A0B0C0D0E0F10, 0x102030405060708, 0x191A1B1C1D1E1F20, 0x1112131415161718};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32L.c
new file mode 100644
index 0000000000..8515b3488e
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f32L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32M.c
new file mode 100644
index 0000000000..41067c4c62
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f32M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * (3 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * (3 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * (3 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * (3 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x191A1B1C1D1E1F20, 0x1112131415161718, 0x90A0B0C0D0E0F10, 0x102030405060708};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64L.c
new file mode 100644
index 0000000000..d8e660be8b
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f64L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64M.c
new file mode 100644
index 0000000000..facfe730c1
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f64M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * (7 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * (7 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * (7 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * (7 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x191A1B1C1D1E1F20, 0x1112131415161718, 0x90A0B0C0D0E0F10, 0x102030405060708};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8L.c
new file mode 100644
index 0000000000..98f4d0a584
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f8L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8M.c
new file mode 100644
index 0000000000..a768efc628
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-f8M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * (0 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * (0 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * (0 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * (0 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16L.c
new file mode 100644
index 0000000000..ca6944fa92
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t16L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * (1 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * (1 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * (1 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * (1 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x100F0E0D0C0B0A09, 0x807060504030201, 0x201F1E1D1C1B1A19, 0x1817161514131211};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16M.c
new file mode 100644
index 0000000000..a4e0ca054f
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t16M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 2;
+const size_t ci = i % 8;
+const size_t bc = c % 2;
+return 16 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 2;
+const size_t ci = i % 4;
+const size_t bc = c % 2;
+return 8 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 2;
+const size_t ci = i % 2;
+const size_t bc = c % 2;
+return 4 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 2;
+const size_t ci = i % 1;
+const size_t bc = c % 2;
+return 2 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32L.c
new file mode 100644
index 0000000000..b142d9b8ce
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t32L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * (3 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * (3 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * (3 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * (3 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x201F1E1D1C1B1A19, 0x1817161514131211, 0x100F0E0D0C0B0A09, 0x807060504030201};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32M.c
new file mode 100644
index 0000000000..109ab19c39
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t32M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 4;
+const size_t ci = i % 8;
+const size_t bc = c % 4;
+return 32 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 4;
+const size_t ci = i % 4;
+const size_t bc = c % 4;
+return 16 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 4;
+const size_t ci = i % 2;
+const size_t bc = c % 4;
+return 8 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 4;
+const size_t ci = i % 1;
+const size_t bc = c % 4;
+return 4 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64L.c
new file mode 100644
index 0000000000..4f325caa75
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t64L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * (7 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * (7 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * (7 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * (7 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x201F1E1D1C1B1A19, 0x1817161514131211, 0x100F0E0D0C0B0A09, 0x807060504030201};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64M.c
new file mode 100644
index 0000000000..766a827128
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t64M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 8;
+const size_t ci = i % 8;
+const size_t bc = c % 8;
+return 64 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 8;
+const size_t ci = i % 4;
+const size_t bc = c % 8;
+return 32 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 8;
+const size_t ci = i % 2;
+const size_t bc = c % 8;
+return 16 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 8;
+const size_t ci = i % 1;
+const size_t bc = c % 8;
+return 8 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8L.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8L.c
new file mode 100644
index 0000000000..18feb85fad
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8L.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t8L.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * (0 - bc) + (7 - ci);
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * (0 - bc) + (3 - ci);
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * (0 - bc) + (1 - ci);
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * (0 - bc) + (0 - ci);
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x807060504030201, 0x100F0E0D0C0B0A09, 0x1817161514131211, 0x201F1E1D1C1B1A19};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x807060504030201);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8M.c b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8M.c
new file mode 100644
index 0000000000..97ebe17e91
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8M.c
@@ -0,0 +1,527 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector-layout-t8M.h"
+
+#define HELPER_H "helper-to-tcg-support-helpers.h"
+#include "exec/helper-proto-common.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen-common.h"
+#include "exec/helper-gen.h.inc"
+
+inline size_t ind_8(size_t i) {
+const size_t c = i / 8;
+const size_t b = c / 1;
+const size_t ci = i % 8;
+const size_t bc = c % 1;
+return 8 * b + 8 * bc + ci;
+}
+
+inline size_t ind_16(size_t i) {
+const size_t c = i / 4;
+const size_t b = c / 1;
+const size_t ci = i % 4;
+const size_t bc = c % 1;
+return 4 * b + 4 * bc + ci;
+}
+
+inline size_t ind_32(size_t i) {
+const size_t c = i / 2;
+const size_t b = c / 1;
+const size_t ci = i % 2;
+const size_t bc = c % 1;
+return 2 * b + 2 * bc + ci;
+}
+
+inline size_t ind_64(size_t i) {
+const size_t c = i / 1;
+const size_t b = c / 1;
+const size_t ci = i % 1;
+const size_t bc = c % 1;
+return 1 * b + 1 * bc + ci;
+}
+
+void HELPER(vec_trunc_16_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_16_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_16_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_8)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint8_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_8(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_8(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint8_t)); ++i) {
+uint8_t aa = *((uint8_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_8_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int8_t)); ++i) {
+int8_t aa = *((int8_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_8_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_8_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_32_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_32_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_32_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_16)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint16_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_16(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_16(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint16_t)); ++i) {
+uint16_t aa = *((uint16_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_16_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int16_t)); ++i) {
+int16_t aa = *((int16_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_16_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_16_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_trunc_64_32)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint64_t)); ++i) {
+uint64_t aa = *((uint64_t *) a + i);
+*((uint32_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_trunc_64_32(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_trunc_64_32(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_zext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(uint32_t)); ++i) {
+uint32_t aa = *((uint32_t *) a + i);
+*((uint64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_zext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_zext_32_64(d, a, tcg_constant_i32(size));
+}
+
+void HELPER(vec_sext_32_64)(void *d, void *a, uint32_t size)
+{
+for (intptr_t i = 0; i < (size / sizeof(int32_t)); ++i) {
+int32_t aa = *((int32_t *) a + i);
+*((int64_t *) d + i) = aa;
+}
+}
+
+static inline void G_GNUC_UNUSED gen_vec_sext_32_64(intptr_t dofs, intptr_t aofs, uint32_t size)
+{
+TCGv_ptr d = tcg_temp_new_ptr();
+TCGv_ptr a = tcg_temp_new_ptr();
+tcg_gen_addi_ptr(d, tcg_env, dofs);
+tcg_gen_addi_ptr(a, tcg_env, aofs);
+gen_helper_vec_sext_32_64(d, a, tcg_constant_i32(size));
+}
+
+typedef struct VectorMem {
+    uint32_t allocated;
+} VectorMem;
+
+static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)
+{
+    uint32_t off = ROUND_UP(mem->allocated, size);
+    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, tmp_vmem));
+    mem->allocated = off + size;
+    return offsetof(CPUArchState, tmp_vmem) + off;
+}
+// void helper_vec_constant
+void emit_vec_constant(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+static const uint64_t vec4_data[] = {0x102030405060708, 0x90A0B0C0D0E0F10, 0x1112131415161718, 0x191A1B1C1D1E1F20};
+tcg_gen_gvec_mov_var(MO_64, tcg_env, vec4, tcg_constant_ptr(vec4_data), 0, 32, 32);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_splat
+void emit_vec_splat(intptr_t d, intptr_t a) {
+VectorMem mem = {0};
+intptr_t vec4 = temp_new_gvec(&mem, 32);
+tcg_gen_gvec_dup_imm(MO_64, vec4, 32, 32, 0x102030405060708);
+tcg_gen_gvec_add(MO_8, d, a, vec4, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint8_t
+void emit_vec_trunc_uint64_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 32);
+gen_vec_trunc_64_8(vec5, b, 256);
+tcg_gen_gvec_add(MO_8, d, vec5, vec6, 32, 32);
+}
+
+// void helper_vec_trunc_uint64_t_uint16_t
+void emit_vec_trunc_uint64_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec6, a, 256);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_trunc_64_16(vec5, b, 256);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_trunc_uint32_t_uint8_t
+void emit_vec_trunc_uint32_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_8(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint32_t_uint16_t
+void emit_vec_trunc_uint32_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+tcg_gen_gvec_add(MO_32, vec6, b, a, 128, 128);
+gen_vec_trunc_32_16(d, vec6, 128);
+}
+
+// void helper_vec_trunc_uint16_t_uint8_t
+void emit_vec_trunc_uint16_t_uint8_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+tcg_gen_gvec_add(MO_16, vec6, b, a, 64, 64);
+gen_vec_trunc_16_8(d, vec6, 64);
+}
+
+// void helper_vec_zext_uint8_t_uint64_t
+void emit_vec_zext_uint8_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint16_t_uint64_t
+void emit_vec_zext_uint16_t_uint64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_zext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_zext_uint8_t_uint32_t
+void emit_vec_zext_uint8_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint16_t_uint32_t
+void emit_vec_zext_uint16_t_uint32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_zext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_zext_uint8_t_uint16_t
+void emit_vec_zext_uint8_t_uint16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_zext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
+// void helper_vec_sext_int8_t_int64_t
+void emit_vec_sext_int8_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_8_64(vec5, b, 32);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int16_t_int64_t
+void emit_vec_sext_int16_t_int64_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 256);
+gen_vec_sext_16_64(vec5, b, 64);
+tcg_gen_gvec_add(MO_64, d, vec5, vec6, 256, 256);
+}
+
+// void helper_vec_sext_int8_t_int32_t
+void emit_vec_sext_int8_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_8_32(vec5, b, 32);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int16_t_int32_t
+void emit_vec_sext_int16_t_int32_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec6, a, 64);
+intptr_t vec5 = temp_new_gvec(&mem, 128);
+gen_vec_sext_16_32(vec5, b, 64);
+tcg_gen_gvec_add(MO_32, d, vec5, vec6, 128, 128);
+}
+
+// void helper_vec_sext_int8_t_int16_t
+void emit_vec_sext_int8_t_int16_t(intptr_t d, intptr_t a, intptr_t b) {
+VectorMem mem = {0};
+intptr_t vec6 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec6, a, 32);
+intptr_t vec5 = temp_new_gvec(&mem, 64);
+gen_vec_sext_8_16(vec5, b, 32);
+tcg_gen_gvec_add(MO_16, d, vec5, vec6, 64, 64);
+}
+
diff --git a/subprojects/helper-to-tcg/tests/ref/21/vector.c b/subprojects/helper-to-tcg/tests/ref/21/vector.c
new file mode 100644
index 0000000000..deeec8e8ab
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/ref/21/vector.c
@@ -0,0 +1,31 @@
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "translate.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-global-mappings.h"
+#include "exec/translation-block.h"
+#include "vector.h"
+
+// void helper_vec_splat_reg
+void emit_vec_splat_reg(intptr_t d, TCGv_i32 imm) {
+tcg_gen_gvec_dup_i32(MO_8, d, 32ull, 32ull, imm);
+}
+
+// void helper_vec_splat_imm
+void emit_vec_splat_imm(intptr_t d, uint8_t imm) {
+tcg_gen_gvec_dup_imm(MO_8, d, 32ull, 32ull, imm);
+}
+
+// void helper_vec_add
+void emit_vec_add(intptr_t d, intptr_t a, intptr_t b) {
+tcg_gen_gvec_add(MO_8, d, b, a, 32, 32);
+}
+
+// void helper_vec_add32
+void emit_vec_add32(intptr_t d, intptr_t a, intptr_t b) {
+tcg_gen_gvec_add(MO_32, d, b, a, 128, 128);
+}
+
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
index 0000000000..341dcd20b3
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/tcg-global-mappings.h
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
diff --git a/subprojects/helper-to-tcg/tests/user-pcrel-jump.c b/subprojects/helper-to-tcg/tests/user-pcrel-jump.c
new file mode 100644
index 0000000000..7c0f89c374
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/user-pcrel-jump.c
@@ -0,0 +1,28 @@
+/*
+ * Test translation custom jump instructions
+ *
+ * (experimental)
+ */
+
+#define ANNOTATE(str) __attribute__((annotate("helper-to-tcg")))
+
+ANNOTATE("immediate: 0")
+void target_pcrel_jump(int pc);
+ANNOTATE("immediate: 0")
+void target_pcrel_jump_cond(int pc);
+ANNOTATE("immediate: 0")
+void target_pcrel_jump_fall(int pc);
+
+ANNOTATE("helper-to-tcg")
+void prcel_jump(int off) {
+    int ea = 4*off + 3;
+    target_pcrel_jump(ea);
+}
+
+ANNOTATE("helper-to-tcg")
+void prcel_condjump(int cond, int off) {
+    if (cond) {
+        int ea = 4*off + 3;
+        target_pcrel_jump(ea);
+    }
+}
diff --git a/subprojects/helper-to-tcg/tests/vector-layout.c b/subprojects/helper-to-tcg/tests/vector-layout.c
new file mode 100644
index 0000000000..fa7d1857c7
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/vector-layout.c
@@ -0,0 +1,51 @@
+#include <stdint.h>
+#include <string.h>
+
+__attribute__((annotate("ptr-to-offset: 0, 1"))) void
+helper_vec_constant(void *restrict d, void *restrict a) {
+    const uint8_t arr[] = {
+        1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15, 16,
+        17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
+    };
+    for (int i = 0; i < 32; ++i) {
+        ((uint8_t *)d)[i] = ((uint8_t *)a)[i] + arr[i];
+    }
+}
+
+__attribute__((annotate("ptr-to-offset: 0, 1"))) void
+helper_vec_splat(void *restrict d, void *restrict a) {
+    const uint8_t arr[] = {
+        1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8,
+        1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8,
+    };
+    for (int i = 0; i < 32; ++i) {
+        ((uint8_t *)d)[i] = ((uint8_t *)a)[i] + arr[i];
+    }
+}
+
+#define GENSZ(NAME, SRC, DST)                                                  \
+    __attribute__((annotate("ptr-to-offset: 0, 1, 2"))) void                   \
+    helper_vec_##NAME##_##SRC##_##DST(void *restrict d, void *restrict a,      \
+                                      void *restrict b) {                      \
+        for (int i = 0; i < 32; ++i) {                                         \
+            ((DST *)d)[i] = (DST)((SRC *)a)[i] + (DST)((SRC *)b)[i];           \
+        }                                                                      \
+    }
+
+GENSZ(trunc, uint64_t, uint8_t)
+GENSZ(trunc, uint64_t, uint16_t)
+GENSZ(trunc, uint32_t, uint8_t)
+GENSZ(trunc, uint32_t, uint16_t)
+GENSZ(trunc, uint16_t, uint8_t)
+
+GENSZ(zext, uint8_t, uint64_t)
+GENSZ(zext, uint16_t, uint64_t)
+GENSZ(zext, uint8_t, uint32_t)
+GENSZ(zext, uint16_t, uint32_t)
+GENSZ(zext, uint8_t, uint16_t)
+
+GENSZ(sext, int8_t, int64_t)
+GENSZ(sext, int16_t, int64_t)
+GENSZ(sext, int8_t, int32_t)
+GENSZ(sext, int16_t, int32_t)
+GENSZ(sext, int8_t, int16_t)
diff --git a/subprojects/helper-to-tcg/tests/vector.c b/subprojects/helper-to-tcg/tests/vector.c
new file mode 100644
index 0000000000..b823976dca
--- /dev/null
+++ b/subprojects/helper-to-tcg/tests/vector.c
@@ -0,0 +1,34 @@
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
+
+__attribute__((annotate("ptr-to-offset: 0, 1, 2"))) void
+helper_vec_add32(void *restrict d, void *restrict a, void *restrict b)
+{
+    for (int i = 0; i < 32; ++i) {
+        ((uint32_t *)d)[i] = ((uint32_t *)a)[i] + ((uint32_t *)b)[i];
+    }
+}
-- 
2.52.0


