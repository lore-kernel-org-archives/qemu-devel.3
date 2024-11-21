Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C2D743FF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJT-0005Sq-1d; Wed, 20 Nov 2024 20:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJP-0005LF-BS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:52 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJN-0004nq-0E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=bZuxt5qAqK6NkZvo8x4OT4L1OuOUMSkYtpG4jSe71JU=; b=o5/46J14uW1iY+9
 PNfgqltgr0FOgC7Tk/87WFrSUwwBBV74UWHBnRm6GtWkm7ICn5ABC//JDcTz6azBX5YayojzdoZRe
 lhAVHcO0nBcpjMbRL7cAESII3mmZ2lsWYHbEtkxB4Qlcc4P4o7YzQvM1wuAWWGV+76ARMEfiEg7Qt
 SQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 35/43] target/hexagon: Use argparse in all python
 scripts
Date: Thu, 21 Nov 2024 02:49:39 +0100
Message-ID: <20241121014947.18666-36-anjo@rev.ng>
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

QOL commit, all the various gen_* python scripts take a large set
arguments where order is implicit.  Using argparse we also get decent
error messages if a field is missing or too many are added.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_analyze_funcs.py     |  6 +++--
 target/hexagon/gen_decodetree.py        | 19 +++++++++++----
 target/hexagon/gen_helper_funcs.py      |  7 +++---
 target/hexagon/gen_helper_protos.py     |  7 +++---
 target/hexagon/gen_idef_parser_funcs.py | 11 +++++++--
 target/hexagon/gen_op_attribs.py        | 11 +++++++--
 target/hexagon/gen_opcodes_def.py       | 11 +++++++--
 target/hexagon/gen_printinsn.py         | 11 +++++++--
 target/hexagon/gen_tcg_func_table.py    | 11 +++++++--
 target/hexagon/gen_tcg_funcs.py         |  9 +++----
 target/hexagon/gen_trans_funcs.py       | 17 ++++++++++---
 target/hexagon/hex_common.py            | 32 ++++++++++++-------------
 target/hexagon/meson.build              |  2 +-
 13 files changed, 107 insertions(+), 47 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 54bac19724..3ac7cc2cfe 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -78,11 +78,13 @@ def gen_analyze_func(f, tag, regs, imms):
 
 
 def main():
-    hex_common.read_common_files()
+    args = hex_common.parse_common_args(
+        "Emit functions analyzing register accesses"
+    )
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         f.write("#ifndef HEXAGON_ANALYZE_FUNCS_C_INC\n")
         f.write("#define HEXAGON_ANALYZE_FUNCS_C_INC\n\n")
 
diff --git a/target/hexagon/gen_decodetree.py b/target/hexagon/gen_decodetree.py
index a4fcd622c5..ce703af41d 100755
--- a/target/hexagon/gen_decodetree.py
+++ b/target/hexagon/gen_decodetree.py
@@ -24,6 +24,7 @@
 import textwrap
 import iset
 import hex_common
+import argparse
 
 encs = {
     tag: "".join(reversed(iset.iset[tag]["enc"].replace(" ", "")))
@@ -191,8 +192,18 @@ def gen_decodetree_file(f, class_to_decode):
         f.write(f"{tag}\t{enc_str} @{tag}\n")
 
 
+def main():
+    parser = argparse.ArgumentParser(
+        description="Emit opaque macro calls with instruction semantics"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("class_to_decode", help="instruction class to decode")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+
+    hex_common.read_semantics_file(args.semantics)
+    with open(args.out, "w") as f:
+        gen_decodetree_file(f, args.class_to_decode)
+
 if __name__ == "__main__":
-    hex_common.read_semantics_file(sys.argv[1])
-    class_to_decode = sys.argv[2]
-    with open(sys.argv[3], "w") as f:
-        gen_decodetree_file(f, class_to_decode)
+    main()
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index e9685bff2f..c1f806ac4b 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -102,12 +102,13 @@ def gen_helper_function(f, tag, tagregs, tagimms):
 
 
 def main():
-    hex_common.read_common_files()
+    args = hex_common.parse_common_args(
+        "Emit helper function definitions for each instruction"
+    )
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    output_file = sys.argv[-1]
-    with open(output_file, "w") as f:
+    with open(args.out, "w") as f:
         for tag in hex_common.tags:
             ## Skip the priv instructions
             if "A_PRIV" in hex_common.attribdict[tag]:
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index fd2bfd0f36..77f8e0a6a3 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -52,12 +52,13 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
 
 
 def main():
-    hex_common.read_common_files()
+    args = hex_common.parse_common_args(
+        "Emit helper function prototypes for each instruction"
+    )
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    output_file = sys.argv[-1]
-    with open(output_file, "w") as f:
+    with open(args.out, "w") as f:
         for tag in hex_common.tags:
             ## Skip the priv instructions
             if "A_PRIV" in hex_common.attribdict[tag]:
diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 72f11c68ca..2f6e826f76 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -20,6 +20,7 @@
 import sys
 import re
 import string
+import argparse
 from io import StringIO
 
 import hex_common
@@ -43,13 +44,19 @@
 ## them are inputs ("in" prefix), while some others are outputs.
 ##
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
+    parser = argparse.ArgumentParser(
+        "Emit instruction implementations that can be fed to idef-parser"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
     hex_common.calculate_attribs()
     hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         f.write('#include "macros.h.inc"\n\n')
 
         for tag in hex_common.tags:
diff --git a/target/hexagon/gen_op_attribs.py b/target/hexagon/gen_op_attribs.py
index 99448220da..bbbb02df3a 100755
--- a/target/hexagon/gen_op_attribs.py
+++ b/target/hexagon/gen_op_attribs.py
@@ -21,16 +21,23 @@
 import re
 import string
 import hex_common
+import argparse
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
+    parser = argparse.ArgumentParser(
+        "Emit opaque macro calls containing instruction attributes"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
     hex_common.calculate_attribs()
 
     ##
     ##     Generate all the attributes associated with each instruction
     ##
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         for tag in hex_common.tags:
             f.write(
                 f"OP_ATTRIB({tag},ATTRIBS("
diff --git a/target/hexagon/gen_opcodes_def.py b/target/hexagon/gen_opcodes_def.py
index 536f0eb68a..94a19ff412 100755
--- a/target/hexagon/gen_opcodes_def.py
+++ b/target/hexagon/gen_opcodes_def.py
@@ -21,15 +21,22 @@
 import re
 import string
 import hex_common
+import argparse
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
+    parser = argparse.ArgumentParser(
+        description="Emit opaque macro calls with instruction names"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
 
     ##
     ##     Generate a list of all the opcodes
     ##
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         for tag in hex_common.tags:
             f.write(f"OPCODE({tag}),\n")
 
diff --git a/target/hexagon/gen_printinsn.py b/target/hexagon/gen_printinsn.py
index 8bf4d0985c..d5f969960a 100755
--- a/target/hexagon/gen_printinsn.py
+++ b/target/hexagon/gen_printinsn.py
@@ -21,6 +21,7 @@
 import re
 import string
 import hex_common
+import argparse
 
 
 ##
@@ -96,11 +97,17 @@ def spacify(s):
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
+    parser = argparse.ArgumentParser(
+        "Emit opaque macro calls with information for printing string representations of instrucions"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
 
     immext_casere = re.compile(r"IMMEXT\(([A-Za-z])")
 
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         for tag in hex_common.tags:
             if not hex_common.behdict[tag]:
                 continue
diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
index 978ac1819b..299a39b1aa 100755
--- a/target/hexagon/gen_tcg_func_table.py
+++ b/target/hexagon/gen_tcg_func_table.py
@@ -21,15 +21,22 @@
 import re
 import string
 import hex_common
+import argparse
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
+    parser = argparse.ArgumentParser(
+        "Emit opaque macro calls with instruction semantics"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
     hex_common.calculate_attribs()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    with open(sys.argv[-1], "w") as f:
+    with open(args.out, "w") as f:
         f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
         f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
 
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 05aa0a7855..c2ba91ddc0 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -108,15 +108,16 @@ def gen_def_tcg_func(f, tag, tagregs, tagimms):
 
 
 def main():
-    is_idef_parser_enabled = hex_common.read_common_files()
+    args = hex_common.parse_common_args(
+        "Emit functions calling generated code implementing instruction semantics (helpers, idef-parser)"
+    )
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    output_file = sys.argv[-1]
-    with open(output_file, "w") as f:
+    with open(args.out, "w") as f:
         f.write("#ifndef HEXAGON_TCG_FUNCS_H\n")
         f.write("#define HEXAGON_TCG_FUNCS_H\n\n")
-        if is_idef_parser_enabled:
+        if args.idef_parser:
             f.write('#include "idef-generated-emitter.h.inc"\n\n')
 
         for tag in hex_common.tags:
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 30f0c73e0c..aea1c36f7d 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -24,6 +24,7 @@
 import textwrap
 import iset
 import hex_common
+import argparse
 
 encs = {
     tag: "".join(reversed(iset.iset[tag]["enc"].replace(" ", "")))
@@ -136,8 +137,18 @@ def gen_trans_funcs(f):
         """))
 
 
-if __name__ == "__main__":
-    hex_common.read_semantics_file(sys.argv[1])
+def main():
+    parser = argparse.ArgumentParser(
+        description="Emit trans_*() functions to be called by instruction decoder"
+    )
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("out", help="output file")
+    args = parser.parse_args()
+    hex_common.read_semantics_file(args.semantics)
     hex_common.init_registers()
-    with open(sys.argv[2], "w") as f:
+    with open(args.out, "w") as f:
         gen_trans_funcs(f)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 15ed4980e4..bb20711a2e 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -21,6 +21,7 @@
 import re
 import string
 import textwrap
+import argparse
 
 behdict = {}  # tag ->behavior
 semdict = {}  # tag -> semantics
@@ -1181,22 +1182,19 @@ def helper_args(tag, regs, imms):
     return args
 
 
-def read_common_files():
-    read_semantics_file(sys.argv[1])
-    read_overrides_file(sys.argv[2])
-    read_overrides_file(sys.argv[3])
-    ## Whether or not idef-parser is enabled is
-    ## determined by the number of arguments to
-    ## this script:
-    ##
-    ##   4 args. -> not enabled,
-    ##   5 args. -> idef-parser enabled.
-    ##
-    ## The 5:th arg. then holds a list of the successfully
-    ## parsed instructions.
-    is_idef_parser_enabled = len(sys.argv) > 5
-    if is_idef_parser_enabled:
-        read_idef_parser_enabled_file(sys.argv[4])
+def parse_common_args(desc):
+    parser = argparse.ArgumentParser(desc)
+    parser.add_argument("semantics", help="semantics file")
+    parser.add_argument("overrides", help="overrides file")
+    parser.add_argument("overrides_vec", help="vector overrides file")
+    parser.add_argument("out", help="output file")
+    parser.add_argument("--idef-parser", help="file of instructions translated by idef-parser")
+    args = parser.parse_args()
+    read_semantics_file(args.semantics)
+    read_overrides_file(args.overrides)
+    read_overrides_file(args.overrides_vec)
+    if args.idef_parser:
+        read_idef_parser_enabled_file(args.idef_parser)
     calculate_attribs()
     init_registers()
-    return is_idef_parser_enabled
+    return args
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index f1723778a6..bb4ebaae81 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -346,7 +346,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
     helper_dep = [semantics_generated, idef_generated_tcg_c, idef_generated_tcg]
-    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, idef_generated_list]
+    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, '--idef-parser', idef_generated_list]
 else
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
-- 
2.45.2


