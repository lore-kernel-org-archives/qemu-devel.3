Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6293EC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7e-0005DT-Qb; Wed, 29 Jul 2026 23:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7P-0004jL-8w
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7L-000322-N9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LWbK1ogEKI4l0O6ZYb7uczyO2GYhf+0xCu+Lx1buNeQ=; b=eC4XQHX8rJvHT/E
 HwiQuYdpsnjZd7FnNu52ZwfzUIRX6CDYEKTflHIYVqhMd4g9klqTezntGETzCwe0Yo4DyFYIOoddu
 QeDriLo3qLgjQlbTVRjoVBEqPoXL0N5Ifdq6tkyCSf6FBkpeNTOl9nfAcMnanIZ2eDjjYTymHn/5b
 Zs=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 45/50] target/hexagon: Emit annotations for helpers
Date: Thu, 30 Jul 2026 05:10:19 +0200
Message-ID: <20260730031025.12926-46-anjo@rev.ng>
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

Adds the following LLVM_ANNOTATE attributes to helper functions generated
by Hexagon:

  1. "helper-to-tcg", to specify that a given helper functions should be
     translated, and;

  2. "immediate: ..." to make sure immediate arguments to helper
     functions remain immediates in the emitted TCG code (e.g. slot).

  3. "ptr-to-offset: ..." to make sure pointer arguments are treated as
     immediates representing an offset into the CPU state, needed to
     work with gvec.

Two functions are also added to hex_common.py, to firstly parse the
generated file containing all successfully translated helper functions,
and secondly to expose the indices of immediate and pointer (vector)
arguments to helper functions.  The latter is needed to generate the
input of helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_helper_funcs.py  | 17 ++++++++++-
 target/hexagon/gen_helper_protos.py |  2 +-
 target/hexagon/gen_tcg_funcs.py     |  2 +-
 target/hexagon/hex_common.py        | 45 +++++++++++++++++++++++------
 4 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index 1629ebc0e1..7a3de21019 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -41,9 +41,23 @@ def gen_helper_function(f, tag, tagregs, tagimms):
     ret_type = hex_common.helper_ret_type(tag, regs).func_arg
 
     declared = []
-    for arg in hex_common.helper_args(tag, regs, imms):
+    helper_args, imm_inds, hvx_inds = hex_common.helper_args(tag, regs, imms)
+    for arg in helper_args:
         declared.append(arg.func_arg)
 
+    ## Specify that helpers should be translated by helper-to-tcg
+    f.write(f'QEMU_ANNOTATE("helper-to-tcg")\n')
+    ## Specify which arguments to the helper function should be treated as
+    ## immediate arguments
+    if len(imm_inds) > 0:
+        imm_inds_str = ','.join(str(i) for i in imm_inds)
+        f.write(f'QEMU_ANNOTATE("immediate: {imm_inds_str}")\n')
+    ## Specify which arguments to the helper function should be treated as
+    ## gvec vectors
+    if len(hvx_inds) > 0:
+        hvx_inds_str = ','.join(str(i) for i in hvx_inds)
+        f.write(f'QEMU_ANNOTATE("ptr-to-offset: {hvx_inds_str}")\n')
+
     arguments = ", ".join(declared)
     f.write(f"{ret_type} HELPER({tag})({arguments})\n")
     f.write("{\n")
@@ -51,6 +65,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
         f.write(hex_common.code_fmt(f"""\
             uint32_t EA;
         """))
+
     ## Declare the return variable
     if not hex_common.is_predicated(tag):
         for regtype, regid in regs:
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 59c8bdd05c..769611e56c 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -36,7 +36,7 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     ret_type = hex_common.helper_ret_type(tag, regs).proto_arg
     declared.append(ret_type)
 
-    for arg in hex_common.helper_args(tag, regs, imms):
+    for arg in hex_common.helper_args(tag, regs, imms)[0]:
         declared.append(arg.proto_arg)
 
     arguments = ", ".join(declared)
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 6d5d99cee3..42b0064131 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -100,7 +100,7 @@ def gen_tcg_func(f, tag, regs, imms):
         if ret_type != "void":
             declared.append(ret_type)
 
-        for arg in hex_common.helper_args(tag, regs, imms):
+        for arg in hex_common.helper_args(tag, regs, imms)[0]:
             declared.append(arg.call_arg)
 
         arguments = ", ".join(declared)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index d91a653c3d..3809749dfa 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -32,6 +32,7 @@
 tags = []  # list of all tags
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
+helper_to_tcg_enabled = {}  # tags enabled for helper-to-tcg
 
 
 def is_sysemu_tag(tag):
@@ -307,6 +308,10 @@ def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
 
+def is_helper_to_tcg_enabled(tag):
+    return tag in helper_to_tcg_enabled
+
+
 def is_hvx_insn(tag):
     return "A_CVI" in attribdict[tag]
 
@@ -349,6 +354,13 @@ def read_idef_parser_enabled_file(name):
         idef_parser_enabled = set(lines)
 
 
+def read_helper_to_tcg_enabled_file(name):
+    global helper_to_tcg_enabled
+    with open(name, "r") as helper_to_tcg_enabled_file:
+        lines = helper_to_tcg_enabled_file.read().strip().split("\n")
+        helper_to_tcg_enabled = set(lines)
+
+
 def is_predicated(tag):
     return "A_CONDEXEC" in attribdict[tag]
 
@@ -433,7 +445,7 @@ def hvx_off(self):
     def helper_proto_type(self):
         return "ptr"
     def helper_arg_type(self):
-        return "void *"
+        return "void * restrict"
     def helper_arg_name(self):
         return f"{self.reg_tcg()}_void"
 
@@ -767,7 +779,7 @@ def decl_tcg(self, f, tag, regno):
             const intptr_t {self.hvx_off()} =
                 {vreg_offset_func(tag)}(ctx, {self.reg_num}, 1, true);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -792,7 +804,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             const intptr_t {self.hvx_off()} = vreg_src_off(ctx, {self.reg_num});
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -833,7 +845,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num}),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -862,7 +874,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             const intptr_t {self.hvx_off()} = offsetof(CPUHexagonState, vtmp);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -898,7 +910,7 @@ def decl_tcg(self, f, tag, regno):
             const intptr_t {self.hvx_off()} =
                 {vreg_offset_func(tag)}(ctx, {self.reg_num}, 2, true);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -930,7 +942,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num} ^ 1),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -957,7 +969,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num} ^ 1),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -1280,8 +1292,13 @@ def helper_ret_type(tag, regs):
         raise Exception("numscalarresults > 1")
     return return_type
 
+
 def helper_args(tag, regs, imms):
     args = []
+    # Used to ensure immediates are passed translated as immediates by
+    # helper-to-tcg.
+    imm_indices = []
+    hvx_indices = []
 
     ## First argument is the CPU state
     if need_env(tag):
@@ -1302,16 +1319,20 @@ def helper_args(tag, regs, imms):
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
         if reg.is_written() and reg.is_hvx_reg():
+            hvx_indices.append(len(args))
             args.append(reg.helper_arg())
 
     ## Pass the source registers
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
         if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+            if reg.is_hvx_reg():
+                hvx_indices.append(len(args))
             args.append(reg.helper_arg())
 
     ## Pass the immediates
     for immlett, bits, immshift in imms:
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "s32",
             f"tcg_constant_tl({imm_name(immlett)})",
@@ -1320,24 +1341,28 @@ def helper_args(tag, regs, imms):
 
     ## Other stuff the helper might need
     if need_pkt_has_multi_cof(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->pkt.pkt_has_multi_cof)",
             "uint32_t pkt_has_multi_cof"
         ))
     if need_pkt_need_commit(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->need_commit)",
             "uint32_t pkt_need_commit"
         ))
     if need_PC(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->pkt.pc)",
             "target_ulong PC"
         ))
     if need_next_PC(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->next_PC)",
@@ -1356,18 +1381,20 @@ def helper_args(tag, regs, imms):
             "uint32_t SP"
         ))
     if need_slot(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "gen_slotval(ctx)",
             "uint32_t slotval"
         ))
     if need_part1(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(insn->part1)"
             "uint32_t part1"
         ))
-    return args
+    return args, imm_indices, hvx_indices
 
 
 def parse_common_args(desc):
-- 
2.52.0


