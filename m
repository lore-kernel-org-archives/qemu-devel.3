Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0AD743FF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwK7-0008Hu-DP; Wed, 20 Nov 2024 20:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwK6-00087S-5l
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:34 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwK4-0004tX-DY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=e9Q0spTYTQ6FChSJsHReGLb3mMStqUbY3UIv4xcEKXQ=; b=nxVu8FWkMR2wWBb
 +KWQA0MvgmQGgKINhTshe7ddIXWZ3zfZVUarFHvaclMfbdyVpBC/kXy5tu3y8txBKepvasBfuYwwL
 FGNqeqyr1XcESac+m6Ly+SYt+EoX5PsdRFTqhdyfWceRN7/tueVkmWTt/D5AbohHDnXBfg6qcSy+q
 ZQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 41/43] target/hexagon: Manually call generated HVX
 instructions
Date: Thu, 21 Nov 2024 02:49:45 +0100
Message-ID: <20241121014947.18666-42-anjo@rev.ng>
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

For HVX instructions that were successfully translated by helper-to-tcg,
emit calls to emit_*() "manually" from generate_*().  Recall that scalar
instructions translated by helper-to-tcg are automatically called by a
hook in tcg_gen_callN.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_tcg_funcs.py | 13 ++++++++
 target/hexagon/hex_common.py    | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index a06edeb9de..fd8dbf3724 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -75,7 +75,18 @@ def gen_tcg_func(f, tag, regs, imms):
 
         arguments = ", ".join(["ctx", "ctx->insn", "ctx->pkt"] + declared)
         f.write(f"    emit_{tag}({arguments});\n")
+    elif hex_common.is_helper_to_tcg_enabled(tag) and tag.startswith("V6_"):
+        ## For vector functions translated by helper-to-tcg we need to
+        ## manually call the emitted code.  All other instructions translated
+        ## are automatically called by the helper-functions dispatcher in
+        ## tcg_gen_callN.
+        declared = []
+        ## Handle registers
+        for arg in hex_common.helper_to_tcg_hvx_call_args(tag, regs, imms):
+            declared.append(arg)
 
+        arguments = ", ".join(declared)
+        f.write(f"    emit_{tag}({arguments});\n")
     elif hex_common.skip_qemu_helper(tag):
         f.write(f"    fGEN_TCG_{tag}({hex_common.semdict[tag]});\n")
     else:
@@ -119,6 +130,8 @@ def main():
         f.write("#define HEXAGON_TCG_FUNCS_H\n\n")
         if args.idef_parser:
             f.write('#include "idef-generated-emitter.h.inc"\n\n')
+        if args.helper_to_tcg:
+            f.write('#include "helper-to-tcg-emitted.h"\n\n')
 
         for tag in hex_common.tags:
             ## Skip the priv instructions
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index fc4c9f648e..8391084982 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1105,6 +1105,60 @@ def helper_ret_type(tag, regs):
     return return_type
 
 
+def helper_to_tcg_hvx_call_args(tag, regs, imms):
+    args = []
+    # Used to ensure immediates are passed translated as immediates by
+    # helper-to-tcg.
+    imm_indices = []
+
+    ## First argument is the CPU state
+    if need_env(tag):
+        args.append("tcg_env")
+
+    ## For predicated instructions, we pass in the destination register
+    if is_predicated(tag):
+        for regtype, regid in regs:
+            reg = get_register(tag, regtype, regid)
+            if reg.is_writeonly() and not reg.is_hvx_reg():
+                args.append(reg.helper_arg().call_arg)
+
+    ## Pass the HVX destination registers
+    for regtype, regid in regs:
+        reg = get_register(tag, regtype, regid)
+        if reg.is_written() and reg.is_hvx_reg():
+            args.append(reg.hvx_off())
+
+    ## Pass the source registers
+    for regtype, regid in regs:
+        reg = get_register(tag, regtype, regid)
+        if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+            if reg.is_hvx_reg():
+                args.append(reg.hvx_off())
+            else:
+                args.append(reg.helper_arg().call_arg)
+
+    ## Pass the immediates
+    for immlett, bits, immshift in imms:
+        imm_indices.append(len(args))
+        args.append(f"{imm_name(immlett)}")
+
+    ## Other stuff the helper might need
+    if need_pkt_has_multi_cof(tag):
+        args.append("ctx->pkt->pkt_has_multi_cof")
+    if need_pkt_need_commit(tag):
+        args.append("ctx->need_commit")
+    if need_PC(tag):
+        args.append("ctx->pkt->pc")
+    if need_next_PC(tag):
+        args.append("ctx->next_PC")
+    if need_slot(tag):
+        args.append("gen_slotval(ctx)")
+    if need_part1(tag):
+        args.append("insn->part1")
+
+    return args
+
+
 def helper_args(tag, regs, imms):
     args = []
     # Used to ensure immediates are passed translated as immediates by
@@ -1216,12 +1270,15 @@ def parse_common_args(desc):
     parser.add_argument("overrides_vec", help="vector overrides file")
     parser.add_argument("out", help="output file")
     parser.add_argument("--idef-parser", help="file of instructions translated by idef-parser")
+    parser.add_argument("--helper-to-tcg", help="file of instructions translated by helper-to-tcg")
     args = parser.parse_args()
     read_semantics_file(args.semantics)
     read_overrides_file(args.overrides)
     read_overrides_file(args.overrides_vec)
     if args.idef_parser:
         read_idef_parser_enabled_file(args.idef_parser)
+    if args.helper_to_tcg:
+        read_helper_to_tcg_enabled_file(args.helper_to_tcg)
     calculate_attribs()
     init_registers()
     return args
-- 
2.45.2


