Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EEAD743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwIz-0004Hj-5w; Wed, 20 Nov 2024 20:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwIx-00042K-8j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:23 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwIu-0004hy-0I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ktv0i4T9quoFh1XqbHeead8oN9HJCwFMqj8THqsqa04=; b=PVqGTMib49hP9Z2
 OZtlZ8SOe1PAbISs/5MJTmf9evN7cIWHaSJSJ/lZL1fmtwAMY11472wgiKZCJ/fCbuZPbTjdwKFZy
 W8g2fniFXqHRl7I3DMg66/NnVz6W8QmTDcReD+STcii0uXoXvh6rXLRu8CCCQ2SFY+NLdDyBo5DYM
 ns=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 43/43] target/hexagon: Use helper-to-tcg
Date: Thu, 21 Nov 2024 02:49:47 +0100
Message-ID: <20241121014947.18666-44-anjo@rev.ng>
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

Modifies meson.build to use helper-to-tcg for automatic translation of
helper functions.  Any helper functions with the "helper-to-tcg"
attribute will be automatically translated to TCG.

Order of code generation is changed, and helper functions are always
generated first, for all instructions.  Helper functions are needed as
input helper-to-tcg.  Next, input to idef-parser is generated for all
instructions that were not successfully translated by helper-to-tcg.

As such, a majority of instructions will be translated by helper-to-tcg,
and the remaining instructions fed through idef-parser can be reduced
moving forward.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/meson.build | 151 +++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 40 deletions(-)

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index bb4ebaae81..563d60e976 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -262,22 +262,127 @@ hexagon_ss.add(files(
     'mmvec/system_ext_mmvec.c',
 ))
 
+helper_dep = [semantics_generated]
+helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h]
+
+#
+# Step 5
+# We use Python scripts to generate the following files
+#     helper_protos_generated.h.inc
+#     helper_funcs_generated.c.inc
+#     analyze_funcs_generated.c.inc
+#
+helper_protos_generated = custom_target(
+    'helper_protos_generated.h.inc',
+    output: 'helper_protos_generated.h.inc',
+    depends: helper_dep,
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT@'],
+)
+hexagon_ss.add(helper_protos_generated)
+
+helper_funcs_generated = custom_target(
+    'helper_funcs_generated.c.inc',
+    output: 'helper_funcs_generated.c.inc',
+    depends: helper_dep,
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@'],
+)
+hexagon_ss.add(helper_funcs_generated)
+
+analyze_funcs_generated = custom_target(
+    'analyze_funcs_generated.c.inc',
+    output: 'analyze_funcs_generated.c.inc',
+    depends: helper_dep,
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT@'],
+)
+hexagon_ss.add(analyze_funcs_generated)
+
+#
+# Step 6
+# If enabled, run helper-to-tcg to attempt to translate any remaining
+# helper functions, producing:
+#     helper-to-tcg-emitted.c
+#     helper-to-tcg-emitted.h
+#     helper-to-tcg-enabled
+#     helper-to-tcg-log
 #
-# Step 4.5
+
+if helper_to_tcg_enabled
+    helper_to_tcg = subproject('helper-to-tcg', required: true)
+    helper_to_tcg_get_llvm_ir_cmd = helper_to_tcg.get_variable('get_llvm_ir_cmd')
+    helper_to_tcg_pipeline = helper_to_tcg.get_variable('pipeline')
+endif
+
+idef_command_extra = []
+idef_dep_extra = []
+if helper_to_tcg_enabled
+    helper_to_tcg_input_files = [
+        meson.current_source_dir() / 'op_helper.c',
+        meson.current_source_dir() / 'translate.c',
+        meson.current_source_dir() / 'reg_fields.c',
+        meson.current_source_dir() / 'arch.c',
+    ]
+
+    ll = custom_target('to-ll',
+        input: helper_to_tcg_input_files,
+        output:'helper-to-tcg-input.ll',
+        depends: [helper_funcs_generated, helper_protos_generated],
+        command: helper_to_tcg_get_llvm_ir_cmd + ['-o', '@OUTPUT@', '@INPUT@', '--target-path', 'target/hexagon']
+    )
+
+    helper_to_tcg_target = custom_target('helper-to-tcg-hexagon',
+        output: ['helper-to-tcg-emitted.c',
+                 'helper-to-tcg-emitted.h',
+                 'helper-to-tcg-enabled',
+                 'helper-to-tcg-log'],
+        input: [ll],
+        depends: [helper_to_tcg_pipeline, analyze_funcs_generated, helper_funcs_generated, helper_protos_generated],
+        command: [helper_to_tcg_pipeline,
+                  '--temp-vector-block=tmp_vmem',
+                  '--mmu-index-function=get_tb_mmu_index',
+                  '--tcg-global-mappings=tcg_global_mappings',
+                  '--output-source=@OUTPUT0@',
+                  '--output-header=@OUTPUT1@',
+                  '--output-enabled=@OUTPUT2@',
+                  '--output-log=@OUTPUT3@',
+                  '@INPUT@']
+    )
+
+    hexagon_ss.add(helper_to_tcg_target)
+
+    # List of instructions for which TCG generation was successful
+    generated_tcg_list = helper_to_tcg_target[2].full_path()
+
+    # Setup dependencies for idef-parser
+    idef_dep_extra += helper_to_tcg_target
+    idef_command_extra += ['--helper-to-tcg', generated_tcg_list]
+
+    # Setup input and dependencies for the final step, this depends on whether
+    helper_dep += [helper_to_tcg_target]
+    helper_in += ['--helper-to-tcg', generated_tcg_list]
+endif
+
+
+
+#
+# Step 6
 # We use flex/bison based idef-parser to generate TCG code for a lot
 # of instructions. idef-parser outputs
 #     idef-generated-emitter.c
 #     idef-generated-emitter.h.inc
 #     idef-generated-enabled-instructions
 #
+
 idef_parser_enabled = get_option('hexagon_idef_parser')
 if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
     idef_parser_input_generated = custom_target(
         'idef_parser_input.h.inc',
         output: 'idef_parser_input.h.inc',
-        depends: [semantics_generated],
+        depends: [semantics_generated, ] + idef_dep_extra,
         depend_files: [hex_common_py],
-        command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'],
+        command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'] + idef_command_extra
     )
 
     preprocessed_idef_parser_input_generated = custom_target(
@@ -345,39 +450,14 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
 
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
-    helper_dep = [semantics_generated, idef_generated_tcg_c, idef_generated_tcg]
-    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, '--idef-parser', idef_generated_list]
-else
-    # Setup input and dependencies for the next step, this depends on whether or
-    # not idef-parser is enabled
-    helper_dep = [semantics_generated]
-    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h]
+    helper_dep += [idef_generated_tcg_c, idef_generated_tcg]
+    helper_in += ['--idef-parser', idef_generated_list]
 endif
 
 #
-# Step 5
+# Step 7
 # We use Python scripts to generate the following files
-#     helper_protos_generated.h.inc
-#     helper_funcs_generated.c.inc
 #     tcg_funcs_generated.c.inc
-#
-helper_protos_generated = custom_target(
-    'helper_protos_generated.h.inc',
-    output: 'helper_protos_generated.h.inc',
-    depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
-    command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT@'],
-)
-hexagon_ss.add(helper_protos_generated)
-
-helper_funcs_generated = custom_target(
-    'helper_funcs_generated.c.inc',
-    output: 'helper_funcs_generated.c.inc',
-    depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
-    command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@'],
-)
-hexagon_ss.add(helper_funcs_generated)
 
 tcg_funcs_generated = custom_target(
     'tcg_funcs_generated.c.inc',
@@ -388,13 +468,4 @@ tcg_funcs_generated = custom_target(
 )
 hexagon_ss.add(tcg_funcs_generated)
 
-analyze_funcs_generated = custom_target(
-    'analyze_funcs_generated.c.inc',
-    output: 'analyze_funcs_generated.c.inc',
-    depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
-    command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT@'],
-)
-hexagon_ss.add(analyze_funcs_generated)
-
 target_arch += {'hexagon': hexagon_ss}
-- 
2.45.2


