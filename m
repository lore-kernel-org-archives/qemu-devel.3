Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE25606A338
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=IpISDNOp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgnw-0007Ln-DW; Wed, 18 Nov 2026 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xTgnu-0007LV-4u
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:38:30 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xTgns-00008C-Dj
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=xRKyD6YfUwdxfu1moGC7CiKwDJtwAXXPBQcvjyebL9Y=; b=IpISDNOphRnA9Bq
 DTJnD8lpE0rd0oPbGBku+jdXv0/iP6rK0kPKbzS+jDyCNqK2xMFO3Fgk5pktuwusbSMg1/j9FKzd0
 2H9Mv8wGGhP4IzELKNqkTdg1FENJwdiIVg6VG5pyGoATH3tEh7l0pk+cTgSFgk4hXICAg+Pq6Nol7
 pE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/hexagon: Explicitly pass GP to helpers
Date: Wed, 18 Nov 2026 15:44:41 +0100
Message-ID: <20261118144441.27680-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

helpers using fREAD_GP() are broken and do not account for the presence
of extenders which change the addressing mode from GP-relative to
absolute.  Explicitly pass GP to helpers and check for expanders at the
call-site.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/macros.h          |  8 +-------
 target/hexagon/attribs_def.h.inc |  1 +
 target/hexagon/hex_common.py     | 11 +++++++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 2748e26d6c..9187b02e6c 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -347,13 +347,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fREAD_SA0 (env->gpr[HEX_REG_SA0])
 #define fREAD_SA1 (env->gpr[HEX_REG_SA1])
 #define fREAD_FP() (env->gpr[HEX_REG_FP])
-#ifdef FIXME
-/* Figure out how to get insn->extension_valid to helper */
-#define fREAD_GP() \
-    (insn->extension_valid ? 0 : env->gpr[HEX_REG_GP])
-#else
-#define fREAD_GP() (env->gpr[HEX_REG_GP])
-#endif
+#define fREAD_GP() (GP)
 #define fREAD_PC() (PC)
 
 #define fREAD_P0() (P0)
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 71c6f04912..bef7ff45d9 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -133,6 +133,7 @@ DEF_ATTRIB(IMPLICIT_WRITES_LR, "Writes the link register", "", "UREG.LR")
 DEF_ATTRIB(IMPLICIT_READS_PC, "Reads the program counter", "UREG.PC", "")
 DEF_ATTRIB(IMPLICIT_WRITES_SP, "Writes the stack pointer", "", "UREG.SP")
 DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the stack pointer", "UREG.SP", "")
+DEF_ATTRIB(IMPLICIT_READS_GP, "Reads the global pointer", "UREG.GP", "")
 DEF_ATTRIB(IMPLICIT_WRITES_FP, "Writes the frame pointer", "", "UREG.FP")
 DEF_ATTRIB(IMPLICIT_WRITES_LC0, "Writes loop count for loop 0", "", "UREG.LC0")
 DEF_ATTRIB(IMPLICIT_WRITES_LC1, "Writes loop count for loop 1", "", "UREG.LC1")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index f85f063f52..24dcdb5ce1 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -142,6 +142,7 @@ def calculate_attribs():
     add_qemu_macro_attrib('fLSBNEW1NOT', 'A_IMPLICIT_READS_P1')
     add_qemu_macro_attrib('fREAD_P3', 'A_IMPLICIT_READS_P3')
     add_qemu_macro_attrib('fREAD_SP', 'A_IMPLICIT_READS_SP')
+    add_qemu_macro_attrib('fREAD_GP', 'A_IMPLICIT_READS_GP')
 
     # Recurse down macros, find attributes from sub-macros
     macroValues = list(macros.values())
@@ -246,6 +247,10 @@ def need_sp(tag):
     return "A_IMPLICIT_READS_SP" in attribdict[tag]
 
 
+def need_gp(tag):
+    return "A_IMPLICIT_READS_GP" in attribdict[tag]
+
+
 def is_hvx_insn(tag):
     return "A_CVI" in attribdict[tag]
 
@@ -2210,6 +2215,12 @@ def helper_args(tag, regs, imms):
             "hex_gpr[HEX_REG_SP]",
             "uint32_t SP"
         ))
+    if need_gp(tag):
+        args.append(HelperArg(
+            "i32",
+            "insn->extension_valid ? tcg_constant_tl(0) : hex_gpr[HEX_REG_GP]",
+            "uint32_t GP"
+        ))
     if need_slot(tag):
         args.append(HelperArg(
             "i32",
-- 
2.52.0


