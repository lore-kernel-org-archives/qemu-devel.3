Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F101C04FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVre-0001tx-8c; Sat, 13 Apr 2024 01:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrc-0001t3-C5
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:44 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrX-0001cn-P1
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:44 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-22ed075a629so906439fac.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985818; x=1713590618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtyEz9ZqG6bUxigt3H0a/+KeCYzNX8VAHbBRr96gz24=;
 b=GQ65+x5VKwIDuurB3w7tNV+yQn5ws/8Q9EImJOLNLJu5uteHb34VtdKIgnppaTgtgN
 K/aePfNTysAbXy969wj0l8fts2CEgo0nBdw5LD/9d8ezbpH3mkPDwcKmFMiB3J9ZacpJ
 Xmo/tJ5JYbIkoSgswdWNSRhry/yFD4Eqqa2Fy/zAar5zbzbsTrYu8TYLzZLJ/A9mAV2a
 ZsW2gQ22YqMRXhUQXLPj4gvXAdFT4pdi0D67c1mtydvhLB0bKsr42DX6OMsLyWLmOktF
 T378Jx8Q85WSOwidtfvchm27mCUHA+ASyPDnbLlATrkH+54BgoStYdXadT7eGRMVUZ5z
 u2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985818; x=1713590618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtyEz9ZqG6bUxigt3H0a/+KeCYzNX8VAHbBRr96gz24=;
 b=fL9gzcQDtTTp7FtDEuEmJZGQh+uFA0QBTtdCgaFePAnt89it+Y2iVRD4g7b1ffqa3l
 NBBmWV/58rzHLGgdywP/OrFDgPmvL+463FKGHT2amkmG3EHzFoiixCh9Ih9CaQprtLW8
 KLiEBXNXwOR80NCNCbqmG57RgdHlWnfF1O1RoR1Meft27eIh3trhTKWVMH/tggw6us5d
 9WTqc4D28Q4spbCQEEBndcCweKJtE6FkrC6nRYLy9afu7QyQEexbhqOWi4LHVirF6Ml1
 k6EnmcyZ1HHMD52SLp/dgv3QPofXc9h/EwiruPUDS/tHW7+5UU/PZZ3J4AXEvVnp8fu+
 xMIw==
X-Gm-Message-State: AOJu0Yw0lCIcRGb4se7YbPg5/EWHPHwm3Cb3WGXGQdGCHyODjDKStxsT
 48cLCVwsmqG24z+cSB5SuMittLz28MSbbuof8IyprNETikOOujvtSb4qACT0CLEncCKsDynKEmU
 F
X-Google-Smtp-Source: AGHT+IGJt/F5qCX8Yh+EjuxwDoKDKdD3PJ1JDURTAnRgj18sQilOYTd09i1mOcqK410DI6RCyxYRQA==
X-Received: by 2002:a05:6358:690f:b0:186:3ae:e138 with SMTP id
 d15-20020a056358690f00b0018603aee138mr5060841rwh.25.1712985817107; 
 Fri, 12 Apr 2024 22:23:37 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 1/6] disas/cris: Untabify
Date: Fri, 12 Apr 2024 22:23:28 -0700
Message-Id: <20240413052333.688151-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
References: <20240413052333.688151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nothing but whitespace changes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 2266 +++++++++++++++++++++++++-------------------------
 1 file changed, 1133 insertions(+), 1133 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 409a224c5d..d62f9e3264 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -53,64 +53,64 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.  */
 const struct cris_spec_reg
 cris_spec_regs[] =
 {
-  {"bz",  0,  1, cris_ver_v32p,	   NULL},
-  {"p0",  0,  1, 0,		   NULL},
-  {"vr",  1,  1, 0,		   NULL},
-  {"p1",  1,  1, 0,		   NULL},
+  {"bz",  0,  1, cris_ver_v32p,    NULL},
+  {"p0",  0,  1, 0,                NULL},
+  {"vr",  1,  1, 0,                NULL},
+  {"p1",  1,  1, 0,                NULL},
   {"pid", 2,  1, cris_ver_v32p,    NULL},
-  {"p2",  2,  1, cris_ver_v32p,	   NULL},
+  {"p2",  2,  1, cris_ver_v32p,    NULL},
   {"p2",  2,  1, cris_ver_warning, NULL},
   {"srs", 3,  1, cris_ver_v32p,    NULL},
-  {"p3",  3,  1, cris_ver_v32p,	   NULL},
+  {"p3",  3,  1, cris_ver_v32p,    NULL},
   {"p3",  3,  1, cris_ver_warning, NULL},
-  {"wz",  4,  2, cris_ver_v32p,	   NULL},
-  {"p4",  4,  2, 0,		   NULL},
+  {"wz",  4,  2, cris_ver_v32p,    NULL},
+  {"p4",  4,  2, 0,                NULL},
   {"ccr", 5,  2, cris_ver_v0_10,   NULL},
-  {"exs", 5,  4, cris_ver_v32p,	   NULL},
+  {"exs", 5,  4, cris_ver_v32p,    NULL},
   {"p5",  5,  2, cris_ver_v0_10,   NULL},
-  {"p5",  5,  4, cris_ver_v32p,	   NULL},
-  {"dcr0",6,  2, cris_ver_v0_3,	   NULL},
-  {"eda", 6,  4, cris_ver_v32p,	   NULL},
-  {"p6",  6,  2, cris_ver_v0_3,	   NULL},
-  {"p6",  6,  4, cris_ver_v32p,	   NULL},
+  {"p5",  5,  4, cris_ver_v32p,    NULL},
+  {"dcr0",6,  2, cris_ver_v0_3,    NULL},
+  {"eda", 6,  4, cris_ver_v32p,    NULL},
+  {"p6",  6,  2, cris_ver_v0_3,    NULL},
+  {"p6",  6,  4, cris_ver_v32p,    NULL},
   {"dcr1/mof", 7, 4, cris_ver_v10p,
    "Register `dcr1/mof' with ambiguous size specified.  Guessing 4 bytes"},
   {"dcr1/mof", 7, 2, cris_ver_v0_3,
    "Register `dcr1/mof' with ambiguous size specified.  Guessing 2 bytes"},
-  {"mof", 7,  4, cris_ver_v10p,	   NULL},
-  {"dcr1",7,  2, cris_ver_v0_3,	   NULL},
-  {"p7",  7,  4, cris_ver_v10p,	   NULL},
-  {"p7",  7,  2, cris_ver_v0_3,	   NULL},
-  {"dz",  8,  4, cris_ver_v32p,	   NULL},
-  {"p8",  8,  4, 0,		   NULL},
+  {"mof", 7,  4, cris_ver_v10p,    NULL},
+  {"dcr1",7,  2, cris_ver_v0_3,    NULL},
+  {"p7",  7,  4, cris_ver_v10p,    NULL},
+  {"p7",  7,  2, cris_ver_v0_3,    NULL},
+  {"dz",  8,  4, cris_ver_v32p,    NULL},
+  {"p8",  8,  4, 0,                NULL},
   {"ibr", 9,  4, cris_ver_v0_10,   NULL},
-  {"ebp", 9,  4, cris_ver_v32p,	   NULL},
-  {"p9",  9,  4, 0,		   NULL},
+  {"ebp", 9,  4, cris_ver_v32p,    NULL},
+  {"p9",  9,  4, 0,                NULL},
   {"irp", 10, 4, cris_ver_v0_10,   NULL},
-  {"erp", 10, 4, cris_ver_v32p,	   NULL},
-  {"p10", 10, 4, 0,		   NULL},
-  {"srp", 11, 4, 0,		   NULL},
-  {"p11", 11, 4, 0,		   NULL},
+  {"erp", 10, 4, cris_ver_v32p,    NULL},
+  {"p10", 10, 4, 0,                NULL},
+  {"srp", 11, 4, 0,                NULL},
+  {"p11", 11, 4, 0,                NULL},
   /* For disassembly use only.  Accept at assembly with a warning.  */
   {"bar/dtp0", 12, 4, cris_ver_warning,
    "Ambiguous register `bar/dtp0' specified"},
-  {"nrp", 12, 4, cris_ver_v32p,	   NULL},
+  {"nrp", 12, 4, cris_ver_v32p,    NULL},
   {"bar", 12, 4, cris_ver_v8_10,   NULL},
-  {"dtp0",12, 4, cris_ver_v0_3,	   NULL},
-  {"p12", 12, 4, 0,		   NULL},
+  {"dtp0",12, 4, cris_ver_v0_3,    NULL},
+  {"p12", 12, 4, 0,                NULL},
   /* For disassembly use only.  Accept at assembly with a warning.  */
   {"dccr/dtp1",13, 4, cris_ver_warning,
    "Ambiguous register `dccr/dtp1' specified"},
-  {"ccs", 13, 4, cris_ver_v32p,	   NULL},
+  {"ccs", 13, 4, cris_ver_v32p,    NULL},
   {"dccr",13, 4, cris_ver_v8_10,   NULL},
-  {"dtp1",13, 4, cris_ver_v0_3,	   NULL},
-  {"p13", 13, 4, 0,		   NULL},
+  {"dtp1",13, 4, cris_ver_v0_3,    NULL},
+  {"p13", 13, 4, 0,                NULL},
   {"brp", 14, 4, cris_ver_v3_10,   NULL},
-  {"usp", 14, 4, cris_ver_v32p,	   NULL},
-  {"p14", 14, 4, cris_ver_v3p,	   NULL},
-  {"usp", 15, 4, cris_ver_v10,	   NULL},
-  {"spc", 15, 4, cris_ver_v32p,	   NULL},
-  {"p15", 15, 4, cris_ver_v10p,	   NULL},
+  {"usp", 14, 4, cris_ver_v32p,    NULL},
+  {"p14", 14, 4, cris_ver_v3p,     NULL},
+  {"usp", 15, 4, cris_ver_v10,     NULL},
+  {"spc", 15, 4, cris_ver_v32p,    NULL},
+  {"p15", 15, 4, cris_ver_v10p,    NULL},
   {NULL, 0, 0, cris_ver_version_all, NULL}
 };
 
@@ -151,53 +151,53 @@ const struct cris_support_reg cris_support_regs[] =
      Operand-matching characters:
      [ ] , space
         Verbatim.
-     A	The string "ACR" (case-insensitive).
-     B	Not really an operand.  It causes a "BDAP -size,SP" prefix to be
-	output for the PUSH alias-instructions and recognizes a push-
-	prefix at disassembly.  This letter isn't recognized for v32.
-	Must be followed by a R or P letter.
-     !	Non-match pattern, will not match if there's a prefix insn.
-     b	Non-matching operand, used for branches with 16-bit
-	displacement. Only recognized by the disassembler.
-     c	5-bit unsigned immediate in bits <4:0>.
-     C	4-bit unsigned immediate in bits <3:0>.
+     A  The string "ACR" (case-insensitive).
+     B  Not really an operand.  It causes a "BDAP -size,SP" prefix to be
+        output for the PUSH alias-instructions and recognizes a push-
+        prefix at disassembly.  This letter isn't recognized for v32.
+        Must be followed by a R or P letter.
+     !  Non-match pattern, will not match if there's a prefix insn.
+     b  Non-matching operand, used for branches with 16-bit
+        displacement. Only recognized by the disassembler.
+     c  5-bit unsigned immediate in bits <4:0>.
+     C  4-bit unsigned immediate in bits <3:0>.
      d  At assembly, optionally (as in put other cases before this one)
-	".d" or ".D" at the start of the operands, followed by one space
-	character.  At disassembly, nothing.
-     D	General register in bits <15:12> and <3:0>.
-     f	List of flags in bits <15:12> and <3:0>.
-     i	6-bit signed immediate in bits <5:0>.
-     I	6-bit unsigned immediate in bits <5:0>.
-     M	Size modifier (B, W or D) for CLEAR instructions.
-     m	Size modifier (B, W or D) in bits <5:4>
+        ".d" or ".D" at the start of the operands, followed by one space
+        character.  At disassembly, nothing.
+     D  General register in bits <15:12> and <3:0>.
+     f  List of flags in bits <15:12> and <3:0>.
+     i  6-bit signed immediate in bits <5:0>.
+     I  6-bit unsigned immediate in bits <5:0>.
+     M  Size modifier (B, W or D) for CLEAR instructions.
+     m  Size modifier (B, W or D) in bits <5:4>
      N  A 32-bit dword, like in the difference between s and y.
         This has no effect on bits in the opcode.  Can also be expressed
-	as "[pc+]" in input.
+        as "[pc+]" in input.
      n  As N, but PC-relative (to the start of the instruction).
-     o	[-128..127] word offset in bits <7:1> and <0>.  Used by 8-bit
-	branch instructions.
-     O	[-128..127] offset in bits <7:0>.  Also matches a comma and a
-	general register after the expression, in bits <15:12>.  Used
-	only for the BDAP prefix insn (in v32 the ADDOQ insn; same opcode).
-     P	Special register in bits <15:12>.
-     p	Indicates that the insn is a prefix insn.  Must be first
-	character.
+     o  [-128..127] word offset in bits <7:1> and <0>.  Used by 8-bit
+        branch instructions.
+     O  [-128..127] offset in bits <7:0>.  Also matches a comma and a
+        general register after the expression, in bits <15:12>.  Used
+        only for the BDAP prefix insn (in v32 the ADDOQ insn; same opcode).
+     P  Special register in bits <15:12>.
+     p  Indicates that the insn is a prefix insn.  Must be first
+        character.
      Q  As O, but don't relax; force an 8-bit offset.
-     R	General register in bits <15:12>.
-     r	General register in bits <3:0>.
-     S	Source operand in bit <10> and a prefix; a 3-operand prefix
-	without side-effect.
-     s	Source operand in bits <10> and <3:0>, optionally with a
-	side-effect prefix, except [pc] (the name, not R15 as in ACR)
-	isn't allowed for v32 and higher.
+     R  General register in bits <15:12>.
+     r  General register in bits <3:0>.
+     S  Source operand in bit <10> and a prefix; a 3-operand prefix
+        without side-effect.
+     s  Source operand in bits <10> and <3:0>, optionally with a
+        side-effect prefix, except [pc] (the name, not R15 as in ACR)
+        isn't allowed for v32 and higher.
      T  Support register in bits <15:12>.
      u  4-bit (PC-relative) unsigned immediate word offset in bits <3:0>.
      U  Relaxes to either u or n, instruction is assumed LAPCQ or LAPC.
-	Not recognized at disassembly.
-     x	Register-dot-modifier, for example "r5.w" in bits <15:12> and <5:4>.
-     y	Like 's' but do not allow an integer at assembly.
-     Y	The difference s-y; only an integer is allowed.
-     z	Size modifier (B or W) in bit <4>.  */
+        Not recognized at disassembly.
+     x  Register-dot-modifier, for example "r5.w" in bits <15:12> and <5:4>.
+     y  Like 's' but do not allow an integer at assembly.
+     Y  The difference s-y; only an integer is allowed.
+     z  Size modifier (B or W) in bit <4>.  */
 
 
 /* Please note the order of the opcodes in this table is significant.
@@ -216,150 +216,150 @@ const struct cris_support_reg cris_support_regs[] =
 const struct cris_opcode
 cris_opcodes[] =
 {
-  {"abs",     0x06B0, 0x0940,		  "r,R",     0, SIZE_NONE,     0,
+  {"abs",     0x06B0, 0x0940,             "r,R",     0, SIZE_NONE,     0,
    cris_abs_op},
 
-  {"add",     0x0600, 0x09c0,		  "m r,R",   0, SIZE_NONE,     0,
+  {"add",     0x0600, 0x09c0,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"add",     0x0A00, 0x01c0,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"add",     0x0A00, 0x01c0,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"add",     0x0A00, 0x01c0,		  "m S,D",   0, SIZE_NONE,
+  {"add",     0x0A00, 0x01c0,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"add",     0x0a00, 0x05c0,		  "m S,R,r", 0, SIZE_NONE,
+  {"add",     0x0a00, 0x05c0,             "m S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"add",     0x0A00, 0x01c0,		  "m s,R",   0, SIZE_FIELD,
+  {"add",     0x0A00, 0x01c0,             "m s,R",   0, SIZE_FIELD,
    cris_ver_v32p,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"addc",    0x0570, 0x0A80,		  "r,R",     0, SIZE_FIX_32,
+  {"addc",    0x0570, 0x0A80,             "r,R",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"addc",    0x09A0, 0x0250,		  "s,R",     0, SIZE_FIX_32,
+  {"addc",    0x09A0, 0x0250,             "s,R",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"addi",    0x0540, 0x0A80,		  "x,r,A",   0, SIZE_NONE,
+  {"addi",    0x0540, 0x0A80,             "x,r,A",   0, SIZE_NONE,
    cris_ver_v32p,
    cris_addi_op},
 
-  {"addi",    0x0500, 0x0Ac0,		  "x,r",     0, SIZE_NONE,     0,
+  {"addi",    0x0500, 0x0Ac0,             "x,r",     0, SIZE_NONE,     0,
    cris_addi_op},
 
   /* This collates after "addo", but we want to disassemble as "addoq",
      not "addo".  */
-  {"addoq",   0x0100, 0x0E00,		  "Q,A",     0, SIZE_NONE,
+  {"addoq",   0x0100, 0x0E00,             "Q,A",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"addo",    0x0940, 0x0280,		  "m s,R,A", 0, SIZE_FIELD_SIGNED,
+  {"addo",    0x0940, 0x0280,             "m s,R,A", 0, SIZE_FIELD_SIGNED,
    cris_ver_v32p,
    cris_not_implemented_op},
 
   /* This must be located after the insn above, lest we misinterpret
      "addo.b -1,r0,acr" as "addo .b-1,r0,acr".  FIXME: Sounds like a
      parser bug.  */
-  {"addo",   0x0100, 0x0E00,		  "O,A",     0, SIZE_NONE,
+  {"addo",   0x0100, 0x0E00,              "O,A",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"addq",    0x0200, 0x0Dc0,		  "I,R",     0, SIZE_NONE,     0,
+  {"addq",    0x0200, 0x0Dc0,             "I,R",     0, SIZE_NONE,     0,
    cris_quick_mode_add_sub_op},
 
-  {"adds",    0x0420, 0x0Bc0,		  "z r,R",   0, SIZE_NONE,     0,
+  {"adds",    0x0420, 0x0Bc0,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_SIGNED and all necessary changes.  */
-  {"adds",    0x0820, 0x03c0,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"adds",    0x0820, 0x03c0,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"adds",    0x0820, 0x03c0,		  "z S,D",   0, SIZE_NONE,
+  {"adds",    0x0820, 0x03c0,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"adds",    0x0820, 0x07c0,		  "z S,R,r", 0, SIZE_NONE,
+  {"adds",    0x0820, 0x07c0,             "z S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"addu",    0x0400, 0x0be0,		  "z r,R",   0, SIZE_NONE,     0,
+  {"addu",    0x0400, 0x0be0,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"addu",    0x0800, 0x03e0,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"addu",    0x0800, 0x03e0,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"addu",    0x0800, 0x03e0,		  "z S,D",   0, SIZE_NONE,
+  {"addu",    0x0800, 0x03e0,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"addu",    0x0800, 0x07e0,		  "z S,R,r", 0, SIZE_NONE,
+  {"addu",    0x0800, 0x07e0,             "z S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"and",     0x0700, 0x08C0,		  "m r,R",   0, SIZE_NONE,     0,
+  {"and",     0x0700, 0x08C0,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"and",     0x0B00, 0x00C0,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"and",     0x0B00, 0x00C0,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"and",     0x0B00, 0x00C0,		  "m S,D",   0, SIZE_NONE,
+  {"and",     0x0B00, 0x00C0,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"and",     0x0B00, 0x04C0,		  "m S,R,r", 0, SIZE_NONE,
+  {"and",     0x0B00, 0x04C0,             "m S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"andq",    0x0300, 0x0CC0,		  "i,R",     0, SIZE_NONE,     0,
+  {"andq",    0x0300, 0x0CC0,             "i,R",     0, SIZE_NONE,     0,
    cris_quick_mode_and_cmp_move_or_op},
 
-  {"asr",     0x0780, 0x0840,		  "m r,R",   0, SIZE_NONE,     0,
+  {"asr",     0x0780, 0x0840,             "m r,R",   0, SIZE_NONE,     0,
    cris_asr_op},
 
-  {"asrq",    0x03a0, 0x0c40,		  "c,R",     0, SIZE_NONE,     0,
+  {"asrq",    0x03a0, 0x0c40,             "c,R",     0, SIZE_NONE,     0,
    cris_asrq_op},
 
-  {"ax",      0x15B0, 0xEA4F,		  "",	     0, SIZE_NONE,     0,
+  {"ax",      0x15B0, 0xEA4F,             "",        0, SIZE_NONE,     0,
    cris_ax_ei_setf_op},
 
   /* FIXME: Should use branch #defines.  */
-  {"b",	      0x0dff, 0x0200,		  "b",	     1, SIZE_NONE,     0,
+  {"b",       0x0dff, 0x0200,             "b",       1, SIZE_NONE,     0,
    cris_sixteen_bit_offset_branch_op},
 
   {"ba",
    BA_QUICK_OPCODE,
-   0x0F00+(0xF-CC_A)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0F00+(0xF-CC_A)*0x1000,              "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   /* Needs to come after the usual "ba o", which might be relaxed to
      this one.  */
   {"ba",     BA_DWORD_OPCODE,
-   0xffff & (~BA_DWORD_OPCODE),		  "n",	     0, SIZE_FIX_32,
+   0xffff & (~BA_DWORD_OPCODE),           "n",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"bas",     0x0EBF, 0x0140,		  "n,P",     0, SIZE_FIX_32,
+  {"bas",     0x0EBF, 0x0140,             "n,P",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"basc",     0x0EFF, 0x0100,		  "n,P",     0, SIZE_FIX_32,
+  {"basc",     0x0EFF, 0x0100,            "n,P",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
   {"bcc",
    BRANCH_QUICK_OPCODE+CC_CC*0x1000,
-   0x0f00+(0xF-CC_CC)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_CC)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bcs",
    BRANCH_QUICK_OPCODE+CC_CS*0x1000,
-   0x0f00+(0xF-CC_CS)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_CS)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bdap",
@@ -368,13 +368,13 @@ cris_opcodes[] =
    cris_bdap_prefix},
 
   {"bdap",
-   BDAP_QUICK_OPCODE, BDAP_QUICK_Z_BITS,  "pO",	     0, SIZE_NONE,
+   BDAP_QUICK_OPCODE, BDAP_QUICK_Z_BITS,  "pO",      0, SIZE_NONE,
    cris_ver_v0_10,
    cris_quick_mode_bdap_prefix},
 
   {"beq",
    BRANCH_QUICK_OPCODE+CC_EQ*0x1000,
-   0x0f00+(0xF-CC_EQ)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_EQ)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   /* This is deliberately put before "bext" to trump it, even though not
@@ -382,396 +382,396 @@ cris_opcodes[] =
      for v0..v10.  */
   {"bwf",
    BRANCH_QUICK_OPCODE+CC_EXT*0x1000,
-   0x0f00+(0xF-CC_EXT)*0x1000,		  "o",	     1, SIZE_NONE,
+   0x0f00+(0xF-CC_EXT)*0x1000,            "o",       1, SIZE_NONE,
    cris_ver_v10,
    cris_eight_bit_offset_branch_op},
 
   {"bext",
    BRANCH_QUICK_OPCODE+CC_EXT*0x1000,
-   0x0f00+(0xF-CC_EXT)*0x1000,		  "o",	     1, SIZE_NONE,
+   0x0f00+(0xF-CC_EXT)*0x1000,            "o",       1, SIZE_NONE,
    cris_ver_v0_3,
    cris_eight_bit_offset_branch_op},
 
   {"bge",
    BRANCH_QUICK_OPCODE+CC_GE*0x1000,
-   0x0f00+(0xF-CC_GE)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_GE)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bgt",
    BRANCH_QUICK_OPCODE+CC_GT*0x1000,
-   0x0f00+(0xF-CC_GT)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_GT)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bhi",
    BRANCH_QUICK_OPCODE+CC_HI*0x1000,
-   0x0f00+(0xF-CC_HI)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_HI)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bhs",
    BRANCH_QUICK_OPCODE+CC_HS*0x1000,
-   0x0f00+(0xF-CC_HS)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_HS)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
-  {"biap", BIAP_OPCODE, BIAP_Z_BITS,	  "pm r,R",  0, SIZE_NONE,
+  {"biap", BIAP_OPCODE, BIAP_Z_BITS,      "pm r,R",  0, SIZE_NONE,
    cris_ver_v0_10,
    cris_biap_prefix},
 
   {"ble",
    BRANCH_QUICK_OPCODE+CC_LE*0x1000,
-   0x0f00+(0xF-CC_LE)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_LE)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"blo",
    BRANCH_QUICK_OPCODE+CC_LO*0x1000,
-   0x0f00+(0xF-CC_LO)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_LO)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bls",
    BRANCH_QUICK_OPCODE+CC_LS*0x1000,
-   0x0f00+(0xF-CC_LS)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_LS)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"blt",
    BRANCH_QUICK_OPCODE+CC_LT*0x1000,
-   0x0f00+(0xF-CC_LT)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_LT)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bmi",
    BRANCH_QUICK_OPCODE+CC_MI*0x1000,
-   0x0f00+(0xF-CC_MI)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_MI)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
-  {"bmod",    0x0ab0, 0x0140,		  "s,R",     0, SIZE_FIX_32,
+  {"bmod",    0x0ab0, 0x0140,             "s,R",     0, SIZE_FIX_32,
    cris_ver_sim_v0_10,
    cris_not_implemented_op},
 
-  {"bmod",    0x0ab0, 0x0140,		  "S,D",     0, SIZE_NONE,
+  {"bmod",    0x0ab0, 0x0140,             "S,D",     0, SIZE_NONE,
    cris_ver_sim_v0_10,
    cris_not_implemented_op},
 
-  {"bmod",    0x0ab0, 0x0540,		  "S,R,r",   0, SIZE_NONE,
+  {"bmod",    0x0ab0, 0x0540,             "S,R,r",   0, SIZE_NONE,
    cris_ver_sim_v0_10,
    cris_not_implemented_op},
 
   {"bne",
    BRANCH_QUICK_OPCODE+CC_NE*0x1000,
-   0x0f00+(0xF-CC_NE)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_NE)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
-  {"bound",   0x05c0, 0x0A00,		  "m r,R",   0, SIZE_NONE,     0,
+  {"bound",   0x05c0, 0x0A00,             "m r,R",   0, SIZE_NONE,     0,
    cris_two_operand_bound_op},
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"bound",   0x09c0, 0x0200,		  "m s,R",   0, SIZE_FIELD,
+  {"bound",   0x09c0, 0x0200,             "m s,R",   0, SIZE_FIELD,
    cris_ver_v0_10,
    cris_two_operand_bound_op},
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"bound",   0x0dcf, 0x0200,		  "m Y,R",   0, SIZE_FIELD,    0,
+  {"bound",   0x0dcf, 0x0200,             "m Y,R",   0, SIZE_FIELD,    0,
    cris_two_operand_bound_op},
-  {"bound",   0x09c0, 0x0200,		  "m S,D",   0, SIZE_NONE,
+  {"bound",   0x09c0, 0x0200,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_two_operand_bound_op},
-  {"bound",   0x09c0, 0x0600,		  "m S,R,r", 0, SIZE_NONE,
+  {"bound",   0x09c0, 0x0600,             "m S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_bound_op},
 
   {"bpl",
    BRANCH_QUICK_OPCODE+CC_PL*0x1000,
-   0x0f00+(0xF-CC_PL)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_PL)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
-  {"break",   0xe930, 0x16c0,		  "C",	     0, SIZE_NONE,
+  {"break",   0xe930, 0x16c0,             "C",       0, SIZE_NONE,
    cris_ver_v3p,
    cris_break_op},
 
   {"bsb",
    BRANCH_QUICK_OPCODE+CC_EXT*0x1000,
-   0x0f00+(0xF-CC_EXT)*0x1000,		  "o",	     1, SIZE_NONE,
+   0x0f00+(0xF-CC_EXT)*0x1000,            "o",       1, SIZE_NONE,
    cris_ver_v32p,
    cris_eight_bit_offset_branch_op},
 
-  {"bsr",     0xBEBF, 0x4140,		  "n",	     0, SIZE_FIX_32,
+  {"bsr",     0xBEBF, 0x4140,             "n",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"bsrc",     0xBEFF, 0x4100,		  "n",	     0, SIZE_FIX_32,
+  {"bsrc",     0xBEFF, 0x4100,            "n",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"bstore",  0x0af0, 0x0100,		  "s,R",     0, SIZE_FIX_32,
+  {"bstore",  0x0af0, 0x0100,             "s,R",     0, SIZE_FIX_32,
    cris_ver_warning,
    cris_not_implemented_op},
 
-  {"bstore",  0x0af0, 0x0100,		  "S,D",     0, SIZE_NONE,
+  {"bstore",  0x0af0, 0x0100,             "S,D",     0, SIZE_NONE,
    cris_ver_warning,
    cris_not_implemented_op},
 
-  {"bstore",  0x0af0, 0x0500,		  "S,R,r",   0, SIZE_NONE,
+  {"bstore",  0x0af0, 0x0500,             "S,R,r",   0, SIZE_NONE,
    cris_ver_warning,
    cris_not_implemented_op},
 
-  {"btst",    0x04F0, 0x0B00,		  "r,R",     0, SIZE_NONE,     0,
+  {"btst",    0x04F0, 0x0B00,             "r,R",     0, SIZE_NONE,     0,
    cris_btst_nop_op},
-  {"btstq",   0x0380, 0x0C60,		  "c,R",     0, SIZE_NONE,     0,
+  {"btstq",   0x0380, 0x0C60,             "c,R",     0, SIZE_NONE,     0,
    cris_btst_nop_op},
 
   {"bvc",
    BRANCH_QUICK_OPCODE+CC_VC*0x1000,
-   0x0f00+(0xF-CC_VC)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_VC)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
   {"bvs",
    BRANCH_QUICK_OPCODE+CC_VS*0x1000,
-   0x0f00+(0xF-CC_VS)*0x1000,		  "o",	     1, SIZE_NONE,     0,
+   0x0f00+(0xF-CC_VS)*0x1000,             "o",       1, SIZE_NONE,     0,
    cris_eight_bit_offset_branch_op},
 
-  {"clear",   0x0670, 0x3980,		  "M r",     0, SIZE_NONE,     0,
+  {"clear",   0x0670, 0x3980,             "M r",     0, SIZE_NONE,     0,
    cris_reg_mode_clear_op},
 
-  {"clear",   0x0A70, 0x3180,		  "M y",     0, SIZE_NONE,     0,
+  {"clear",   0x0A70, 0x3180,             "M y",     0, SIZE_NONE,     0,
    cris_none_reg_mode_clear_test_op},
 
-  {"clear",   0x0A70, 0x3180,		  "M S",     0, SIZE_NONE,
+  {"clear",   0x0A70, 0x3180,             "M S",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_clear_test_op},
 
-  {"clearf",  0x05F0, 0x0A00,		  "f",	     0, SIZE_NONE,     0,
+  {"clearf",  0x05F0, 0x0A00,             "f",       0, SIZE_NONE,     0,
    cris_clearf_di_op},
 
-  {"cmp",     0x06C0, 0x0900,		  "m r,R",   0, SIZE_NONE,     0,
+  {"cmp",     0x06C0, 0x0900,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"cmp",     0x0Ac0, 0x0100,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"cmp",     0x0Ac0, 0x0100,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"cmp",     0x0Ac0, 0x0100,		  "m S,D",   0, SIZE_NONE,
+  {"cmp",     0x0Ac0, 0x0100,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"cmpq",    0x02C0, 0x0D00,		  "i,R",     0, SIZE_NONE,     0,
+  {"cmpq",    0x02C0, 0x0D00,             "i,R",     0, SIZE_NONE,     0,
    cris_quick_mode_and_cmp_move_or_op},
 
   /* FIXME: SIZE_FIELD_SIGNED and all necessary changes.  */
-  {"cmps",    0x08e0, 0x0300,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"cmps",    0x08e0, 0x0300,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"cmps",    0x08e0, 0x0300,		  "z S,D",   0, SIZE_NONE,
+  {"cmps",    0x08e0, 0x0300,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"cmpu",    0x08c0, 0x0320,		  "z s,R" ,  0, SIZE_FIELD,    0,
+  {"cmpu",    0x08c0, 0x0320,             "z s,R" ,  0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"cmpu",    0x08c0, 0x0320,		  "z S,D",   0, SIZE_NONE,
+  {"cmpu",    0x08c0, 0x0320,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"di",      0x25F0, 0xDA0F,		  "",	     0, SIZE_NONE,     0,
+  {"di",      0x25F0, 0xDA0F,             "",        0, SIZE_NONE,     0,
    cris_clearf_di_op},
 
-  {"dip",     DIP_OPCODE, DIP_Z_BITS,	  "ps",	     0, SIZE_FIX_32,
+  {"dip",     DIP_OPCODE, DIP_Z_BITS,     "ps",      0, SIZE_FIX_32,
    cris_ver_v0_10,
    cris_dip_prefix},
 
-  {"div",     0x0980, 0x0640,		  "m R,r",   0, SIZE_FIELD,    0,
+  {"div",     0x0980, 0x0640,             "m R,r",   0, SIZE_FIELD,    0,
    cris_not_implemented_op},
 
-  {"dstep",   0x06f0, 0x0900,		  "r,R",     0, SIZE_NONE,     0,
+  {"dstep",   0x06f0, 0x0900,             "r,R",     0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"ei",      0x25B0, 0xDA4F,		  "",	     0, SIZE_NONE,     0,
+  {"ei",      0x25B0, 0xDA4F,             "",        0, SIZE_NONE,     0,
    cris_ax_ei_setf_op},
 
-  {"fidxd",    0x0ab0, 0xf540,		  "[r]",     0, SIZE_NONE,
+  {"fidxd",    0x0ab0, 0xf540,            "[r]",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"fidxi",    0x0d30, 0xF2C0,		  "[r]",     0, SIZE_NONE,
+  {"fidxi",    0x0d30, 0xF2C0,            "[r]",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"ftagd",    0x1AB0, 0xE540,		  "[r]",     0, SIZE_NONE,
+  {"ftagd",    0x1AB0, 0xE540,            "[r]",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"ftagi",    0x1D30, 0xE2C0,		  "[r]",     0, SIZE_NONE,
+  {"ftagi",    0x1D30, 0xE2C0,            "[r]",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"halt",    0xF930, 0x06CF,		  "",	     0, SIZE_NONE,
+  {"halt",    0xF930, 0x06CF,             "",        0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"jas",    0x09B0, 0x0640,		  "r,P",     0, SIZE_NONE,
+  {"jas",    0x09B0, 0x0640,              "r,P",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jas",    0x0DBF, 0x0240,		  "N,P",     0, SIZE_FIX_32,
+  {"jas",    0x0DBF, 0x0240,              "N,P",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jasc",    0x0B30, 0x04C0,		  "r,P",     0, SIZE_NONE,
+  {"jasc",    0x0B30, 0x04C0,             "r,P",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jasc",    0x0F3F, 0x00C0,		  "N,P",     0, SIZE_FIX_32,
+  {"jasc",    0x0F3F, 0x00C0,             "N,P",     0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jbrc",    0x69b0, 0x9640,		  "r",	     0, SIZE_NONE,
+  {"jbrc",    0x69b0, 0x9640,             "r",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_reg_mode_jump_op},
 
-  {"jbrc",    0x6930, 0x92c0,		  "s",	     0, SIZE_FIX_32,
+  {"jbrc",    0x6930, 0x92c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jbrc",    0x6930, 0x92c0,		  "S",	     0, SIZE_NONE,
+  {"jbrc",    0x6930, 0x92c0,             "S",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jir",     0xA9b0, 0x5640,		  "r",	     0, SIZE_NONE,
+  {"jir",     0xA9b0, 0x5640,             "r",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_reg_mode_jump_op},
 
-  {"jir",     0xA930, 0x52c0,		  "s",	     0, SIZE_FIX_32,
+  {"jir",     0xA930, 0x52c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jir",     0xA930, 0x52c0,		  "S",	     0, SIZE_NONE,
+  {"jir",     0xA930, 0x52c0,             "S",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jirc",    0x29b0, 0xd640,		  "r",	     0, SIZE_NONE,
+  {"jirc",    0x29b0, 0xd640,             "r",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_reg_mode_jump_op},
 
-  {"jirc",    0x2930, 0xd2c0,		  "s",	     0, SIZE_FIX_32,
+  {"jirc",    0x2930, 0xd2c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jirc",    0x2930, 0xd2c0,		  "S",	     0, SIZE_NONE,
+  {"jirc",    0x2930, 0xd2c0,             "S",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jsr",     0xB9b0, 0x4640,		  "r",	     0, SIZE_NONE,     0,
+  {"jsr",     0xB9b0, 0x4640,             "r",       0, SIZE_NONE,     0,
    cris_reg_mode_jump_op},
 
-  {"jsr",     0xB930, 0x42c0,		  "s",	     0, SIZE_FIX_32,
+  {"jsr",     0xB930, 0x42c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v0_10,
    cris_none_reg_mode_jump_op},
 
-  {"jsr",     0xBDBF, 0x4240,		  "N",	     0, SIZE_FIX_32,
+  {"jsr",     0xBDBF, 0x4240,             "N",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"jsr",     0xB930, 0x42c0,		  "S",	     0, SIZE_NONE,
+  {"jsr",     0xB930, 0x42c0,             "S",       0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_jump_op},
 
-  {"jsrc",    0x39b0, 0xc640,		  "r",	     0, SIZE_NONE,
+  {"jsrc",    0x39b0, 0xc640,             "r",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_reg_mode_jump_op},
 
-  {"jsrc",    0x3930, 0xc2c0,		  "s",	     0, SIZE_FIX_32,
+  {"jsrc",    0x3930, 0xc2c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jsrc",    0x3930, 0xc2c0,		  "S",	     0, SIZE_NONE,
+  {"jsrc",    0x3930, 0xc2c0,             "S",       0, SIZE_NONE,
    cris_ver_v8_10,
    cris_none_reg_mode_jump_op},
 
-  {"jsrc",    0xBB30, 0x44C0,		  "r",       0, SIZE_NONE,
+  {"jsrc",    0xBB30, 0x44C0,             "r",       0, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jsrc",    0xBF3F, 0x40C0,		  "N",	     0, SIZE_FIX_32,
+  {"jsrc",    0xBF3F, 0x40C0,             "N",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_reg_mode_jump_op},
 
-  {"jump",    0x09b0, 0xF640,		  "r",	     0, SIZE_NONE,     0,
+  {"jump",    0x09b0, 0xF640,             "r",       0, SIZE_NONE,     0,
    cris_reg_mode_jump_op},
 
   {"jump",
-   JUMP_INDIR_OPCODE, JUMP_INDIR_Z_BITS,  "s",	     0, SIZE_FIX_32,
+   JUMP_INDIR_OPCODE, JUMP_INDIR_Z_BITS,  "s",       0, SIZE_FIX_32,
    cris_ver_v0_10,
    cris_none_reg_mode_jump_op},
 
   {"jump",
-   JUMP_INDIR_OPCODE, JUMP_INDIR_Z_BITS,  "S",	     0, SIZE_NONE,
+   JUMP_INDIR_OPCODE, JUMP_INDIR_Z_BITS,  "S",       0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_jump_op},
 
-  {"jump",    0x09F0, 0x060F,		  "P",	     0, SIZE_NONE,
+  {"jump",    0x09F0, 0x060F,             "P",       0, SIZE_NONE,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
   {"jump",
    JUMP_PC_INCR_OPCODE_V32,
-   (0xffff & ~JUMP_PC_INCR_OPCODE_V32),	  "N",	     0, SIZE_FIX_32,
+   (0xffff & ~JUMP_PC_INCR_OPCODE_V32),   "N",       0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_none_reg_mode_jump_op},
 
-  {"jmpu",    0x8930, 0x72c0,		  "s",	     0, SIZE_FIX_32,
+  {"jmpu",    0x8930, 0x72c0,             "s",       0, SIZE_FIX_32,
    cris_ver_v10,
    cris_none_reg_mode_jump_op},
 
-  {"jmpu",    0x8930, 0x72c0,		   "S",	     0, SIZE_NONE,
+  {"jmpu",    0x8930, 0x72c0,              "S",      0, SIZE_NONE,
    cris_ver_v10,
    cris_none_reg_mode_jump_op},
 
-  {"lapc",    0x0970, 0x0680,		  "U,R",    0, SIZE_NONE,
+  {"lapc",    0x0970, 0x0680,             "U,R",    0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"lapc",    0x0D7F, 0x0280,		  "dn,R",    0, SIZE_FIX_32,
+  {"lapc",    0x0D7F, 0x0280,             "dn,R",    0, SIZE_FIX_32,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"lapcq",   0x0970, 0x0680,		  "u,R",     0, SIZE_NONE,
+  {"lapcq",   0x0970, 0x0680,             "u,R",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_addi_op},
 
-  {"lsl",     0x04C0, 0x0B00,		  "m r,R",   0, SIZE_NONE,     0,
+  {"lsl",     0x04C0, 0x0B00,             "m r,R",   0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"lslq",    0x03c0, 0x0C20,		  "c,R",     0, SIZE_NONE,     0,
+  {"lslq",    0x03c0, 0x0C20,             "c,R",     0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"lsr",     0x07C0, 0x0800,		  "m r,R",   0, SIZE_NONE,     0,
+  {"lsr",     0x07C0, 0x0800,             "m r,R",   0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"lsrq",    0x03e0, 0x0C00,		  "c,R",     0, SIZE_NONE,     0,
+  {"lsrq",    0x03e0, 0x0C00,             "c,R",     0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"lz",      0x0730, 0x08C0,		  "r,R",     0, SIZE_NONE,
+  {"lz",      0x0730, 0x08C0,             "r,R",     0, SIZE_NONE,
    cris_ver_v3p,
    cris_not_implemented_op},
 
-  {"mcp",      0x07f0, 0x0800,		  "P,r",     0, SIZE_NONE,
+  {"mcp",      0x07f0, 0x0800,            "P,r",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"move",    0x0640, 0x0980,		  "m r,R",   0, SIZE_NONE,     0,
+  {"move",    0x0640, 0x0980,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"move",    0x0A40, 0x0180,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"move",    0x0A40, 0x0180,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"move",    0x0A40, 0x0180,		  "m S,D",   0, SIZE_NONE,
+  {"move",    0x0A40, 0x0180,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"move",    0x0630, 0x09c0,		  "r,P",     0, SIZE_NONE,     0,
+  {"move",    0x0630, 0x09c0,             "r,P",     0, SIZE_NONE,     0,
    cris_move_to_preg_op},
 
-  {"move",    0x0670, 0x0980,		  "P,r",     0, SIZE_NONE,     0,
+  {"move",    0x0670, 0x0980,             "P,r",     0, SIZE_NONE,     0,
    cris_reg_mode_move_from_preg_op},
 
-  {"move",    0x0BC0, 0x0000,		  "m R,y",   0, SIZE_FIELD,    0,
+  {"move",    0x0BC0, 0x0000,             "m R,y",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"move",    0x0BC0, 0x0000,		  "m D,S",   0, SIZE_NONE,
+  {"move",    0x0BC0, 0x0000,             "m D,S",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
@@ -780,80 +780,80 @@ cris_opcodes[] =
    "s,P",   0, SIZE_SPEC_REG, 0,
    cris_move_to_preg_op},
 
-  {"move",    0x0A30, 0x01c0,		  "S,P",     0, SIZE_NONE,
+  {"move",    0x0A30, 0x01c0,             "S,P",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_move_to_preg_op},
 
-  {"move",    0x0A70, 0x0180,		  "P,y",     0, SIZE_SPEC_REG, 0,
+  {"move",    0x0A70, 0x0180,             "P,y",     0, SIZE_SPEC_REG, 0,
    cris_none_reg_mode_move_from_preg_op},
 
-  {"move",    0x0A70, 0x0180,		  "P,S",     0, SIZE_NONE,
+  {"move",    0x0A70, 0x0180,             "P,S",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_move_from_preg_op},
 
-  {"move",    0x0B70, 0x0480,		  "r,T",     0, SIZE_NONE,
+  {"move",    0x0B70, 0x0480,             "r,T",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"move",    0x0F70, 0x0080,		  "T,r",     0, SIZE_NONE,
+  {"move",    0x0F70, 0x0080,             "T,r",     0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"movem",   0x0BF0, 0x0000,		  "R,y",     0, SIZE_FIX_32,   0,
+  {"movem",   0x0BF0, 0x0000,             "R,y",     0, SIZE_FIX_32,   0,
    cris_move_reg_to_mem_movem_op},
 
-  {"movem",   0x0BF0, 0x0000,		  "D,S",     0, SIZE_NONE,
+  {"movem",   0x0BF0, 0x0000,             "D,S",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_move_reg_to_mem_movem_op},
 
-  {"movem",   0x0BB0, 0x0040,		  "s,R",     0, SIZE_FIX_32,   0,
+  {"movem",   0x0BB0, 0x0040,             "s,R",     0, SIZE_FIX_32,   0,
    cris_move_mem_to_reg_movem_op},
 
-  {"movem",   0x0BB0, 0x0040,		  "S,D",     0, SIZE_NONE,
+  {"movem",   0x0BB0, 0x0040,             "S,D",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_move_mem_to_reg_movem_op},
 
-  {"moveq",   0x0240, 0x0D80,		  "i,R",     0, SIZE_NONE,     0,
+  {"moveq",   0x0240, 0x0D80,             "i,R",     0, SIZE_NONE,     0,
    cris_quick_mode_and_cmp_move_or_op},
 
-  {"movs",    0x0460, 0x0B80,		  "z r,R",   0, SIZE_NONE,     0,
+  {"movs",    0x0460, 0x0B80,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_SIGNED and all necessary changes.  */
-  {"movs",    0x0860, 0x0380,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"movs",    0x0860, 0x0380,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"movs",    0x0860, 0x0380,		  "z S,D",   0, SIZE_NONE,
+  {"movs",    0x0860, 0x0380,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"movu",    0x0440, 0x0Ba0,		  "z r,R",   0, SIZE_NONE,     0,
+  {"movu",    0x0440, 0x0Ba0,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"movu",    0x0840, 0x03a0,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"movu",    0x0840, 0x03a0,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"movu",    0x0840, 0x03a0,		  "z S,D",   0, SIZE_NONE,
+  {"movu",    0x0840, 0x03a0,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"mstep",   0x07f0, 0x0800,		  "r,R",     0, SIZE_NONE,
+  {"mstep",   0x07f0, 0x0800,             "r,R",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"muls",    0x0d00, 0x02c0,		  "m r,R",   0, SIZE_NONE,
+  {"muls",    0x0d00, 0x02c0,             "m r,R",   0, SIZE_NONE,
    cris_ver_v10p,
    cris_muls_op},
 
-  {"mulu",    0x0900, 0x06c0,		  "m r,R",   0, SIZE_NONE,
+  {"mulu",    0x0900, 0x06c0,             "m r,R",   0, SIZE_NONE,
    cris_ver_v10p,
    cris_mulu_op},
 
-  {"neg",     0x0580, 0x0A40,		  "m r,R",   0, SIZE_NONE,     0,
+  {"neg",     0x0580, 0x0A40,             "m r,R",   0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"nop",     NOP_OPCODE, NOP_Z_BITS,	  "",	     0, SIZE_NONE,
+  {"nop",     NOP_OPCODE, NOP_Z_BITS,     "",        0, SIZE_NONE,
    cris_ver_v0_10,
    cris_btst_nop_op},
 
@@ -861,124 +861,124 @@ cris_opcodes[] =
    cris_ver_v32p,
    cris_btst_nop_op},
 
-  {"not",     0x8770, 0x7880,		  "r",	     0, SIZE_NONE,     0,
+  {"not",     0x8770, 0x7880,             "r",       0, SIZE_NONE,     0,
    cris_dstep_logshift_mstep_neg_not_op},
 
-  {"or",      0x0740, 0x0880,		  "m r,R",   0, SIZE_NONE,     0,
+  {"or",      0x0740, 0x0880,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"or",      0x0B40, 0x0080,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"or",      0x0B40, 0x0080,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"or",      0x0B40, 0x0080,		  "m S,D",   0, SIZE_NONE,
+  {"or",      0x0B40, 0x0080,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"or",      0x0B40, 0x0480,		  "m S,R,r", 0, SIZE_NONE,
+  {"or",      0x0B40, 0x0480,             "m S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"orq",     0x0340, 0x0C80,		  "i,R",     0, SIZE_NONE,     0,
+  {"orq",     0x0340, 0x0C80,             "i,R",     0, SIZE_NONE,     0,
    cris_quick_mode_and_cmp_move_or_op},
 
-  {"pop",     0x0E6E, 0x0191,		  "!R",	     0, SIZE_NONE,
+  {"pop",     0x0E6E, 0x0191,             "!R",      0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"pop",     0x0e3e, 0x01c1,		  "!P",	     0, SIZE_NONE,
+  {"pop",     0x0e3e, 0x01c1,             "!P",      0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_move_from_preg_op},
 
-  {"push",    0x0FEE, 0x0011,		  "BR",	     0, SIZE_NONE,
+  {"push",    0x0FEE, 0x0011,             "BR",      0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"push",    0x0E7E, 0x0181,		  "BP",	     0, SIZE_NONE,
+  {"push",    0x0E7E, 0x0181,             "BP",      0, SIZE_NONE,
    cris_ver_v0_10,
    cris_move_to_preg_op},
 
-  {"rbf",     0x3b30, 0xc0c0,		  "y",	     0, SIZE_NONE,
+  {"rbf",     0x3b30, 0xc0c0,             "y",       0, SIZE_NONE,
    cris_ver_v10,
    cris_not_implemented_op},
 
-  {"rbf",     0x3b30, 0xc0c0,		  "S",	     0, SIZE_NONE,
+  {"rbf",     0x3b30, 0xc0c0,             "S",       0, SIZE_NONE,
    cris_ver_v10,
    cris_not_implemented_op},
 
-  {"rfe",     0x2930, 0xD6CF,		  "",	     0, SIZE_NONE,
+  {"rfe",     0x2930, 0xD6CF,             "",        0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"rfg",     0x4930, 0xB6CF,		  "",	     0, SIZE_NONE,
+  {"rfg",     0x4930, 0xB6CF,             "",        0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"rfn",     0x5930, 0xA6CF,		  "",	     0, SIZE_NONE,
+  {"rfn",     0x5930, 0xA6CF,             "",        0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
-  {"ret",     0xB67F, 0x4980,		  "",	     1, SIZE_NONE,
+  {"ret",     0xB67F, 0x4980,             "",        1, SIZE_NONE,
    cris_ver_v0_10,
    cris_reg_mode_move_from_preg_op},
 
-  {"ret",     0xB9F0, 0x460F,		  "",	     1, SIZE_NONE,
+  {"ret",     0xB9F0, 0x460F,             "",        1, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_move_from_preg_op},
 
-  {"retb",    0xe67f, 0x1980,		  "",	     1, SIZE_NONE,
+  {"retb",    0xe67f, 0x1980,             "",        1, SIZE_NONE,
    cris_ver_v0_10,
    cris_reg_mode_move_from_preg_op},
 
-  {"rete",     0xA9F0, 0x560F,		  "",	     1, SIZE_NONE,
+  {"rete",     0xA9F0, 0x560F,            "",        1, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_move_from_preg_op},
 
-  {"reti",    0xA67F, 0x5980,		  "",	     1, SIZE_NONE,
+  {"reti",    0xA67F, 0x5980,             "",        1, SIZE_NONE,
    cris_ver_v0_10,
    cris_reg_mode_move_from_preg_op},
 
-  {"retn",     0xC9F0, 0x360F,		  "",	     1, SIZE_NONE,
+  {"retn",     0xC9F0, 0x360F,            "",        1, SIZE_NONE,
    cris_ver_v32p,
    cris_reg_mode_move_from_preg_op},
 
-  {"sbfs",    0x3b70, 0xc080,		  "y",	     0, SIZE_NONE,
+  {"sbfs",    0x3b70, 0xc080,             "y",       0, SIZE_NONE,
    cris_ver_v10,
    cris_not_implemented_op},
 
-  {"sbfs",    0x3b70, 0xc080,		  "S",	     0, SIZE_NONE,
+  {"sbfs",    0x3b70, 0xc080,             "S",       0, SIZE_NONE,
    cris_ver_v10,
    cris_not_implemented_op},
 
   {"sa",
    0x0530+CC_A*0x1000,
-   0x0AC0+(0xf-CC_A)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_A)*0x1000,              "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"ssb",
    0x0530+CC_EXT*0x1000,
-   0x0AC0+(0xf-CC_EXT)*0x1000,		  "r",	     0, SIZE_NONE,
+   0x0AC0+(0xf-CC_EXT)*0x1000,            "r",       0, SIZE_NONE,
    cris_ver_v32p,
    cris_scc_op},
 
   {"scc",
    0x0530+CC_CC*0x1000,
-   0x0AC0+(0xf-CC_CC)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_CC)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"scs",
    0x0530+CC_CS*0x1000,
-   0x0AC0+(0xf-CC_CS)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_CS)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"seq",
    0x0530+CC_EQ*0x1000,
-   0x0AC0+(0xf-CC_EQ)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_EQ)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
-  {"setf",    0x05b0, 0x0A40,		  "f",	     0, SIZE_NONE,     0,
+  {"setf",    0x05b0, 0x0A40,             "f",       0, SIZE_NONE,     0,
    cris_ax_ei_setf_op},
 
-  {"sfe",    0x3930, 0xC6CF,		  "",	     0, SIZE_NONE,
+  {"sfe",    0x3930, 0xC6CF,              "",        0, SIZE_NONE,
    cris_ver_v32p,
    cris_not_implemented_op},
 
@@ -986,203 +986,203 @@ cris_opcodes[] =
      disassembly.  */
   {"swf",
    0x0530+CC_EXT*0x1000,
-   0x0AC0+(0xf-CC_EXT)*0x1000,		  "r",	     0, SIZE_NONE,
+   0x0AC0+(0xf-CC_EXT)*0x1000,            "r",       0, SIZE_NONE,
    cris_ver_v10,
    cris_scc_op},
 
   {"sext",
    0x0530+CC_EXT*0x1000,
-   0x0AC0+(0xf-CC_EXT)*0x1000,		  "r",	     0, SIZE_NONE,
+   0x0AC0+(0xf-CC_EXT)*0x1000,            "r",       0, SIZE_NONE,
    cris_ver_v0_3,
    cris_scc_op},
 
   {"sge",
    0x0530+CC_GE*0x1000,
-   0x0AC0+(0xf-CC_GE)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_GE)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"sgt",
    0x0530+CC_GT*0x1000,
-   0x0AC0+(0xf-CC_GT)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_GT)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"shi",
    0x0530+CC_HI*0x1000,
-   0x0AC0+(0xf-CC_HI)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_HI)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"shs",
    0x0530+CC_HS*0x1000,
-   0x0AC0+(0xf-CC_HS)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_HS)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"sle",
    0x0530+CC_LE*0x1000,
-   0x0AC0+(0xf-CC_LE)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_LE)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"slo",
    0x0530+CC_LO*0x1000,
-   0x0AC0+(0xf-CC_LO)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_LO)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"sls",
    0x0530+CC_LS*0x1000,
-   0x0AC0+(0xf-CC_LS)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_LS)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"slt",
    0x0530+CC_LT*0x1000,
-   0x0AC0+(0xf-CC_LT)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_LT)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"smi",
    0x0530+CC_MI*0x1000,
-   0x0AC0+(0xf-CC_MI)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_MI)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"sne",
    0x0530+CC_NE*0x1000,
-   0x0AC0+(0xf-CC_NE)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_NE)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"spl",
    0x0530+CC_PL*0x1000,
-   0x0AC0+(0xf-CC_PL)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_PL)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
-  {"sub",     0x0680, 0x0940,		  "m r,R",   0, SIZE_NONE,     0,
+  {"sub",     0x0680, 0x0940,             "m r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"sub",     0x0a80, 0x0140,		  "m s,R",   0, SIZE_FIELD,    0,
+  {"sub",     0x0a80, 0x0140,             "m s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"sub",     0x0a80, 0x0140,		  "m S,D",   0, SIZE_NONE,
+  {"sub",     0x0a80, 0x0140,             "m S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"sub",     0x0a80, 0x0540,		  "m S,R,r", 0, SIZE_NONE,
+  {"sub",     0x0a80, 0x0540,             "m S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"subq",    0x0280, 0x0d40,		  "I,R",     0, SIZE_NONE,     0,
+  {"subq",    0x0280, 0x0d40,             "I,R",     0, SIZE_NONE,     0,
    cris_quick_mode_add_sub_op},
 
-  {"subs",    0x04a0, 0x0b40,		  "z r,R",   0, SIZE_NONE,     0,
+  {"subs",    0x04a0, 0x0b40,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_SIGNED and all necessary changes.  */
-  {"subs",    0x08a0, 0x0340,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"subs",    0x08a0, 0x0340,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"subs",    0x08a0, 0x0340,		  "z S,D",   0, SIZE_NONE,
+  {"subs",    0x08a0, 0x0340,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"subs",    0x08a0, 0x0740,		  "z S,R,r", 0, SIZE_NONE,
+  {"subs",    0x08a0, 0x0740,             "z S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
-  {"subu",    0x0480, 0x0b60,		  "z r,R",   0, SIZE_NONE,     0,
+  {"subu",    0x0480, 0x0b60,             "z r,R",   0, SIZE_NONE,     0,
    cris_reg_mode_add_sub_cmp_and_or_move_op},
 
   /* FIXME: SIZE_FIELD_UNSIGNED and all necessary changes.  */
-  {"subu",    0x0880, 0x0360,		  "z s,R",   0, SIZE_FIELD,    0,
+  {"subu",    0x0880, 0x0360,             "z s,R",   0, SIZE_FIELD,    0,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"subu",    0x0880, 0x0360,		  "z S,D",   0, SIZE_NONE,
+  {"subu",    0x0880, 0x0360,             "z S,D",   0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_add_sub_cmp_and_or_move_op},
 
-  {"subu",    0x0880, 0x0760,		  "z S,R,r", 0, SIZE_NONE,
+  {"subu",    0x0880, 0x0760,             "z S,R,r", 0, SIZE_NONE,
    cris_ver_v0_10,
    cris_three_operand_add_sub_cmp_and_or_op},
 
   {"svc",
    0x0530+CC_VC*0x1000,
-   0x0AC0+(0xf-CC_VC)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_VC)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   {"svs",
    0x0530+CC_VS*0x1000,
-   0x0AC0+(0xf-CC_VS)*0x1000,		  "r",	     0, SIZE_NONE,     0,
+   0x0AC0+(0xf-CC_VS)*0x1000,             "r",       0, SIZE_NONE,     0,
    cris_scc_op},
 
   /* The insn "swapn" is the same as "not" and will be disassembled as
      such, but the swap* family of mnmonics are generally v8-and-higher
      only, so count it in.  */
-  {"swapn",   0x8770, 0x7880,		  "r",	     0, SIZE_NONE,
+  {"swapn",   0x8770, 0x7880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapw",   0x4770, 0xb880,		  "r",	     0, SIZE_NONE,
+  {"swapw",   0x4770, 0xb880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnw",  0xc770, 0x3880,		  "r",	     0, SIZE_NONE,
+  {"swapnw",  0xc770, 0x3880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapb",   0x2770, 0xd880,		  "r",	     0, SIZE_NONE,
+  {"swapb",   0x2770, 0xd880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnb",  0xA770, 0x5880,		  "r",	     0, SIZE_NONE,
+  {"swapnb",  0xA770, 0x5880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapwb",  0x6770, 0x9880,		  "r",	     0, SIZE_NONE,
+  {"swapwb",  0x6770, 0x9880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnwb", 0xE770, 0x1880,		  "r",	     0, SIZE_NONE,
+  {"swapnwb", 0xE770, 0x1880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapr",   0x1770, 0xe880,		  "r",	     0, SIZE_NONE,
+  {"swapr",   0x1770, 0xe880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnr",  0x9770, 0x6880,		  "r",	     0, SIZE_NONE,
+  {"swapnr",  0x9770, 0x6880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapwr",  0x5770, 0xa880,		  "r",	     0, SIZE_NONE,
+  {"swapwr",  0x5770, 0xa880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnwr", 0xd770, 0x2880,		  "r",	     0, SIZE_NONE,
+  {"swapnwr", 0xd770, 0x2880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapbr",  0x3770, 0xc880,		  "r",	     0, SIZE_NONE,
+  {"swapbr",  0x3770, 0xc880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnbr", 0xb770, 0x4880,		  "r",	     0, SIZE_NONE,
+  {"swapnbr", 0xb770, 0x4880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapwbr", 0x7770, 0x8880,		  "r",	     0, SIZE_NONE,
+  {"swapwbr", 0x7770, 0x8880,             "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"swapnwbr", 0xf770, 0x0880,		  "r",	     0, SIZE_NONE,
+  {"swapnwbr", 0xf770, 0x0880,            "r",       0, SIZE_NONE,
    cris_ver_v8p,
    cris_not_implemented_op},
 
-  {"test",    0x0640, 0x0980,		  "m D",     0, SIZE_NONE,
+  {"test",    0x0640, 0x0980,             "m D",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_reg_mode_test_op},
 
-  {"test",    0x0b80, 0xf040,		  "m y",     0, SIZE_FIELD,    0,
+  {"test",    0x0b80, 0xf040,             "m y",     0, SIZE_FIELD,    0,
    cris_none_reg_mode_clear_test_op},
 
-  {"test",    0x0b80, 0xf040,		  "m S",     0, SIZE_NONE,
+  {"test",    0x0b80, 0xf040,             "m S",     0, SIZE_NONE,
    cris_ver_v0_10,
    cris_none_reg_mode_clear_test_op},
 
-  {"xor",     0x07B0, 0x0840,		  "r,R",     0, SIZE_NONE,     0,
+  {"xor",     0x07B0, 0x0840,             "r,R",     0, SIZE_NONE,     0,
    cris_xor_op},
 
   {NULL, 0, 0, NULL, 0, 0, 0, cris_not_implemented_op}
@@ -1296,8 +1296,8 @@ static int cris_constraint
 
 static void
 cris_parse_disassembler_options (struct cris_disasm_data *disdata,
-				 char *disassembler_options,
-				 enum cris_disass_family distype)
+                                 char *disassembler_options,
+                                 enum cris_disass_family distype)
 {
   /* Default true.  */
   disdata->trace_case
@@ -1315,25 +1315,25 @@ spec_reg_info (unsigned int sreg, enum cris_disass_family distype)
   for (i = 0; cris_spec_regs[i].name != NULL; i++)
     {
       if (cris_spec_regs[i].number == sreg)
-	{
-	  if (distype == cris_dis_v32)
-	    switch (cris_spec_regs[i].applicable_version)
-	      {
-	      case cris_ver_warning:
-	      case cris_ver_version_all:
-	      case cris_ver_v3p:
-	      case cris_ver_v8p:
-	      case cris_ver_v10p:
-	      case cris_ver_v32p:
-		/* No ambiguous sizes or register names with CRISv32.  */
-		if (cris_spec_regs[i].warning == NULL)
-		  return &cris_spec_regs[i];
-	      default:
-		;
-	      }
-	  else if (cris_spec_regs[i].applicable_version != cris_ver_v32p)
-	    return &cris_spec_regs[i];
-	}
+        {
+          if (distype == cris_dis_v32)
+            switch (cris_spec_regs[i].applicable_version)
+              {
+              case cris_ver_warning:
+              case cris_ver_version_all:
+              case cris_ver_v3p:
+              case cris_ver_v8p:
+              case cris_ver_v10p:
+              case cris_ver_v32p:
+                /* No ambiguous sizes or register names with CRISv32.  */
+                if (cris_spec_regs[i].warning == NULL)
+                  return &cris_spec_regs[i];
+              default:
+                ;
+              }
+          else if (cris_spec_regs[i].applicable_version != cris_ver_v32p)
+            return &cris_spec_regs[i];
+        }
     }
 
   return NULL;
@@ -1356,8 +1356,8 @@ number_of_bits (unsigned int val)
 
 static const struct cris_opcode *
 get_opcode_entry (unsigned int insn,
-		  unsigned int prefix_insn,
-		  struct cris_disasm_data *disdata)
+                  unsigned int prefix_insn,
+                  struct cris_disasm_data *disdata)
 {
   /* For non-prefixed insns, we keep a table of pointers, indexed by the
      insn code.  Each entry is initialized when found to be NULL.  */
@@ -1393,47 +1393,47 @@ get_opcode_entry (unsigned int insn,
   if (prefix_insn != NO_CRIS_PREFIX)
     {
       const struct cris_opcode *popcodep
-	= (opc_table[prefix_insn] != NULL
-	   ? opc_table[prefix_insn]
-	   : get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata));
+        = (opc_table[prefix_insn] != NULL
+           ? opc_table[prefix_insn]
+           : get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata));
 
       if (popcodep == NULL)
-	return NULL;
+        return NULL;
 
       if (popcodep->match == BDAP_QUICK_OPCODE)
-	{
-	  /* Since some offsets are recognized with "push" macros, we
-	     have to have different tables for them.  */
-	  int offset = (prefix_insn & 255);
+        {
+          /* Since some offsets are recognized with "push" macros, we
+             have to have different tables for them.  */
+          int offset = (prefix_insn & 255);
 
-	  if (offset > 127)
-	    offset -= 256;
+          if (offset > 127)
+            offset -= 256;
 
-	  switch (offset)
-	    {
-	    case -4:
-	      prefix_opc_table = bdapq_m4_prefixes;
-	      break;
+          switch (offset)
+            {
+            case -4:
+              prefix_opc_table = bdapq_m4_prefixes;
+              break;
 
-	    case -2:
-	      prefix_opc_table = bdapq_m2_prefixes;
-	      break;
+            case -2:
+              prefix_opc_table = bdapq_m2_prefixes;
+              break;
 
-	    case -1:
-	      prefix_opc_table = bdapq_m1_prefixes;
-	      break;
+            case -1:
+              prefix_opc_table = bdapq_m1_prefixes;
+              break;
 
-	    default:
-	      prefix_opc_table = rest_prefixes;
-	      break;
-	    }
-	}
+            default:
+              prefix_opc_table = rest_prefixes;
+              break;
+            }
+        }
       else if (popcodep->match == DIP_OPCODE)
-	/* We don't allow postincrement when the prefix is DIP, so use a
-	   different table for DIP.  */
-	prefix_opc_table = dip_prefixes;
+        /* We don't allow postincrement when the prefix is DIP, so use a
+           different table for DIP.  */
+        prefix_opc_table = dip_prefixes;
       else
-	prefix_opc_table = rest_prefixes;
+        prefix_opc_table = rest_prefixes;
     }
 
   if (prefix_insn != NO_CRIS_PREFIX
@@ -1447,104 +1447,104 @@ get_opcode_entry (unsigned int insn,
       int max_level_of_match = -1;
 
       for (opcodep = cris_opcodes;
-	   opcodep->name != NULL;
-	   opcodep++)
-	{
-	  int level_of_match;
+           opcodep->name != NULL;
+           opcodep++)
+        {
+          int level_of_match;
 
-	  if (disdata->distype == cris_dis_v32)
-	    {
-	      switch (opcodep->applicable_version)
-		{
-		case cris_ver_version_all:
-		  break;
+          if (disdata->distype == cris_dis_v32)
+            {
+              switch (opcodep->applicable_version)
+                {
+                case cris_ver_version_all:
+                  break;
 
-		case cris_ver_v0_3:
-		case cris_ver_v0_10:
-		case cris_ver_v3_10:
-		case cris_ver_sim_v0_10:
-		case cris_ver_v8_10:
-		case cris_ver_v10:
-		case cris_ver_warning:
-		  continue;
+                case cris_ver_v0_3:
+                case cris_ver_v0_10:
+                case cris_ver_v3_10:
+                case cris_ver_sim_v0_10:
+                case cris_ver_v8_10:
+                case cris_ver_v10:
+                case cris_ver_warning:
+                  continue;
 
-		case cris_ver_v3p:
-		case cris_ver_v8p:
-		case cris_ver_v10p:
-		case cris_ver_v32p:
-		  break;
+                case cris_ver_v3p:
+                case cris_ver_v8p:
+                case cris_ver_v10p:
+                case cris_ver_v32p:
+                  break;
 
-		case cris_ver_v8:
-		  abort ();
-		default:
-		  abort ();
-		}
-	    }
-	  else
-	    {
-	      switch (opcodep->applicable_version)
-		{
-		case cris_ver_version_all:
-		case cris_ver_v0_3:
-		case cris_ver_v3p:
-		case cris_ver_v0_10:
-		case cris_ver_v8p:
-		case cris_ver_v8_10:
-		case cris_ver_v10:
-		case cris_ver_sim_v0_10:
-		case cris_ver_v10p:
-		case cris_ver_warning:
-		  break;
+                case cris_ver_v8:
+                  abort ();
+                default:
+                  abort ();
+                }
+            }
+          else
+            {
+              switch (opcodep->applicable_version)
+                {
+                case cris_ver_version_all:
+                case cris_ver_v0_3:
+                case cris_ver_v3p:
+                case cris_ver_v0_10:
+                case cris_ver_v8p:
+                case cris_ver_v8_10:
+                case cris_ver_v10:
+                case cris_ver_sim_v0_10:
+                case cris_ver_v10p:
+                case cris_ver_warning:
+                  break;
 
-		case cris_ver_v32p:
-		  continue;
+                case cris_ver_v32p:
+                  continue;
 
-		case cris_ver_v8:
-		  abort ();
-		default:
-		  abort ();
-		}
-	    }
+                case cris_ver_v8:
+                  abort ();
+                default:
+                  abort ();
+                }
+            }
 
-	  /* We give a double lead for bits matching the template in
-	     cris_opcodes.  Not even, because then "move p8,r10" would
-	     be given 2 bits lead over "clear.d r10".  When there's a
-	     tie, the first entry in the table wins.  This is
-	     deliberate, to avoid a more complicated recognition
-	     formula.  */
-	  if ((opcodep->match & insn) == opcodep->match
-	      && (opcodep->lose & insn) == 0
-	      && ((level_of_match
-		   = cris_constraint (opcodep->args,
-				      insn,
-				      prefix_insn,
-				      disdata))
-		  >= 0)
-	      && ((level_of_match
-		   += 2 * number_of_bits (opcodep->match
-					  | opcodep->lose))
-			  > max_level_of_match))
-		    {
-		      max_matchedp = opcodep;
-		      max_level_of_match = level_of_match;
+          /* We give a double lead for bits matching the template in
+             cris_opcodes.  Not even, because then "move p8,r10" would
+             be given 2 bits lead over "clear.d r10".  When there's a
+             tie, the first entry in the table wins.  This is
+             deliberate, to avoid a more complicated recognition
+             formula.  */
+          if ((opcodep->match & insn) == opcodep->match
+              && (opcodep->lose & insn) == 0
+              && ((level_of_match
+                   = cris_constraint (opcodep->args,
+                                      insn,
+                                      prefix_insn,
+                                      disdata))
+                  >= 0)
+              && ((level_of_match
+                   += 2 * number_of_bits (opcodep->match
+                                          | opcodep->lose))
+                          > max_level_of_match))
+                    {
+                      max_matchedp = opcodep;
+                      max_level_of_match = level_of_match;
 
-		      /* If there was a full match, never mind looking
-			 further.  */
-		      if (level_of_match >= 2 * 16)
-			break;
-		    }
-		}
+                      /* If there was a full match, never mind looking
+                         further.  */
+                      if (level_of_match >= 2 * 16)
+                        break;
+                    }
+                }
       /* Fill in the new entry.
 
-	 If there are changes to the opcode-table involving prefixes, and
-	 disassembly then does not work correctly, try removing the
-	 else-clause below that fills in the prefix-table.  If that
-	 helps, you need to change the prefix_opc_table setting above, or
-	 something related.  */
+         If there are changes to the opcode-table involving prefixes, and
+         disassembly then does not work correctly, try removing the
+         else-clause below that fills in the prefix-table.  If that
+         helps, you need to change the prefix_opc_table setting above, or
+         something related.  */
       if (prefix_insn == NO_CRIS_PREFIX)
-	opc_table[insn] = max_matchedp;
+        opc_table[insn] = max_matchedp;
       else
-	prefix_opc_table[insn] = max_matchedp;
+        prefix_opc_table[insn] = max_matchedp;
     }
 
   return max_matchedp;
@@ -1556,9 +1556,9 @@ get_opcode_entry (unsigned int insn,
 
 static int
 cris_constraint (const char *cs,
-		 unsigned int insn,
-		 unsigned int prefix_insn,
-		 struct cris_disasm_data *disdata)
+                 unsigned int insn,
+                 unsigned int prefix_insn,
+                 struct cris_disasm_data *disdata)
 {
   int retval = 0;
   int tmp;
@@ -1569,136 +1569,136 @@ cris_constraint (const char *cs,
     switch (*s)
       {
       case '!':
-	/* Do not recognize "pop" if there's a prefix and then only for
+        /* Do not recognize "pop" if there's a prefix and then only for
            v0..v10.  */
-	if (prefix_insn != NO_CRIS_PREFIX
-	    || disdata->distype != cris_dis_v0_v10)
-	  return -1;
-	break;
+        if (prefix_insn != NO_CRIS_PREFIX
+            || disdata->distype != cris_dis_v0_v10)
+          return -1;
+        break;
 
       case 'U':
-	/* Not recognized at disassembly.  */
-	return -1;
+        /* Not recognized at disassembly.  */
+        return -1;
 
       case 'M':
-	/* Size modifier for "clear", i.e. special register 0, 4 or 8.
-	   Check that it is one of them.  Only special register 12 could
-	   be mismatched, but checking for matches is more logical than
-	   checking for mismatches when there are only a few cases.  */
-	tmp = ((insn >> 12) & 0xf);
-	if (tmp != 0 && tmp != 4 && tmp != 8)
-	  return -1;
-	break;
+        /* Size modifier for "clear", i.e. special register 0, 4 or 8.
+           Check that it is one of them.  Only special register 12 could
+           be mismatched, but checking for matches is more logical than
+           checking for mismatches when there are only a few cases.  */
+        tmp = ((insn >> 12) & 0xf);
+        if (tmp != 0 && tmp != 4 && tmp != 8)
+          return -1;
+        break;
 
       case 'm':
-	if ((insn & 0x30) == 0x30)
-	  return -1;
-	break;
+        if ((insn & 0x30) == 0x30)
+          return -1;
+        break;
 
       case 'S':
-	/* A prefix operand without side-effect.  */
-	if (prefix_insn != NO_CRIS_PREFIX && (insn & 0x400) == 0)
-	  {
-	    prefix_ok = 1;
-	    break;
-	  }
-	else
-	  return -1;
+        /* A prefix operand without side-effect.  */
+        if (prefix_insn != NO_CRIS_PREFIX && (insn & 0x400) == 0)
+          {
+            prefix_ok = 1;
+            break;
+          }
+        else
+          return -1;
 
       case 's':
       case 'y':
       case 'Y':
-	/* If this is a prefixed insn with postincrement (side-effect),
-	   the prefix must not be DIP.  */
-	if (prefix_insn != NO_CRIS_PREFIX)
-	  {
-	    if (insn & 0x400)
-	      {
-		const struct cris_opcode *prefix_opcodep
-		  = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
+        /* If this is a prefixed insn with postincrement (side-effect),
+           the prefix must not be DIP.  */
+        if (prefix_insn != NO_CRIS_PREFIX)
+          {
+            if (insn & 0x400)
+              {
+                const struct cris_opcode *prefix_opcodep
+                  = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
 
-		if (prefix_opcodep->match == DIP_OPCODE)
-		  return -1;
-	      }
+                if (prefix_opcodep->match == DIP_OPCODE)
+                  return -1;
+              }
 
-	    prefix_ok = 1;
-	  }
-	break;
+            prefix_ok = 1;
+          }
+        break;
 
       case 'B':
-	/* If we don't fall through, then the prefix is ok.  */
-	prefix_ok = 1;
+        /* If we don't fall through, then the prefix is ok.  */
+        prefix_ok = 1;
 
-	/* A "push" prefix.  Check for valid "push" size.
-	   In case of special register, it may be != 4.  */
-	if (prefix_insn != NO_CRIS_PREFIX)
-	  {
-	    /* Match the prefix insn to BDAPQ.  */
-	    const struct cris_opcode *prefix_opcodep
-	      = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
+        /* A "push" prefix.  Check for valid "push" size.
+           In case of special register, it may be != 4.  */
+        if (prefix_insn != NO_CRIS_PREFIX)
+          {
+            /* Match the prefix insn to BDAPQ.  */
+            const struct cris_opcode *prefix_opcodep
+              = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
 
-	    if (prefix_opcodep->match == BDAP_QUICK_OPCODE)
-	      {
-		int pushsize = (prefix_insn & 255);
+            if (prefix_opcodep->match == BDAP_QUICK_OPCODE)
+              {
+                int pushsize = (prefix_insn & 255);
 
-		if (pushsize > 127)
-		  pushsize -= 256;
+                if (pushsize > 127)
+                  pushsize -= 256;
 
-		if (s[1] == 'P')
-		  {
-		    unsigned int spec_reg = (insn >> 12) & 15;
-		    const struct cris_spec_reg *sregp
-		      = spec_reg_info (spec_reg, disdata->distype);
+                if (s[1] == 'P')
+                  {
+                    unsigned int spec_reg = (insn >> 12) & 15;
+                    const struct cris_spec_reg *sregp
+                      = spec_reg_info (spec_reg, disdata->distype);
 
-		    /* For a special-register, the "prefix size" must
-		       match the size of the register.  */
-		    if (sregp && sregp->reg_size == (unsigned int) -pushsize)
-		      break;
-		  }
-		else if (s[1] == 'R')
-		  {
-		    if ((insn & 0x30) == 0x20 && pushsize == -4)
-		      break;
-		  }
-		/* FIXME:  Should abort here; next constraint letter
-		   *must* be 'P' or 'R'.  */
-	      }
-	  }
-	return -1;
+                    /* For a special-register, the "prefix size" must
+                       match the size of the register.  */
+                    if (sregp && sregp->reg_size == (unsigned int) -pushsize)
+                      break;
+                  }
+                else if (s[1] == 'R')
+                  {
+                    if ((insn & 0x30) == 0x20 && pushsize == -4)
+                      break;
+                  }
+                /* FIXME:  Should abort here; next constraint letter
+                   *must* be 'P' or 'R'.  */
+              }
+          }
+        return -1;
 
       case 'D':
-	retval = (((insn >> 12) & 15) == (insn & 15));
-	if (!retval)
-	  return -1;
-	else
-	  retval += 4;
-	break;
+        retval = (((insn >> 12) & 15) == (insn & 15));
+        if (!retval)
+          return -1;
+        else
+          retval += 4;
+        break;
 
       case 'P':
-	{
-	  const struct cris_spec_reg *sregp
-	    = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+        {
+          const struct cris_spec_reg *sregp
+            = spec_reg_info ((insn >> 12) & 15, disdata->distype);
 
-	  /* Since we match four bits, we will give a value of 4-1 = 3
-	     in a match.  If there is a corresponding exact match of a
-	     special register in another pattern, it will get a value of
-	     4, which will be higher.  This should be correct in that an
-	     exact pattern would match better than a general pattern.
+          /* Since we match four bits, we will give a value of 4-1 = 3
+             in a match.  If there is a corresponding exact match of a
+             special register in another pattern, it will get a value of
+             4, which will be higher.  This should be correct in that an
+             exact pattern would match better than a general pattern.
 
-	     Note that there is a reason for not returning zero; the
-	     pattern for "clear" is partly  matched in the bit-pattern
-	     (the two lower bits must be zero), while the bit-pattern
-	     for a move from a special register is matched in the
-	     register constraint.  */
+             Note that there is a reason for not returning zero; the
+             pattern for "clear" is partly  matched in the bit-pattern
+             (the two lower bits must be zero), while the bit-pattern
+             for a move from a special register is matched in the
+             register constraint.  */
 
-	  if (sregp != NULL)
-	    {
-	      retval += 3;
-	      break;
-	    }
-	  else
-	    return -1;
-	}
+          if (sregp != NULL)
+            {
+              retval += 3;
+              break;
+            }
+          else
+            return -1;
+        }
       }
 
   if (prefix_insn != NO_CRIS_PREFIX && ! prefix_ok)
@@ -1711,8 +1711,8 @@ cris_constraint (const char *cs,
 
 static char *
 format_hex (unsigned long number,
-	    char *outbuffer,
-	    struct cris_disasm_data *disdata)
+            char *outbuffer,
+            struct cris_disasm_data *disdata)
 {
   /* Truncate negative numbers on >32-bit hosts.  */
   number &= 0xffffffff;
@@ -1743,9 +1743,9 @@ format_dec (long number, char *outbuffer, size_t outsize, int signedp)
 
 static char *
 format_reg (struct cris_disasm_data *disdata,
-	    int regno,
-	    char *outbuffer_start,
-	    bfd_boolean with_reg_prefix)
+            int regno,
+            char *outbuffer_start,
+            bfd_boolean with_reg_prefix)
 {
   char *outbuffer = outbuffer_start;
 
@@ -1757,9 +1757,9 @@ format_reg (struct cris_disasm_data *disdata,
     case 15:
       /* For v32, there is no context in which we output PC.  */
       if (disdata->distype == cris_dis_v32)
-	strcpy (outbuffer, "acr");
+        strcpy (outbuffer, "acr");
       else
-	strcpy (outbuffer, "pc");
+        strcpy (outbuffer, "pc");
       break;
 
     case 14:
@@ -1778,8 +1778,8 @@ format_reg (struct cris_disasm_data *disdata,
 
 static char *
 format_sup_reg (unsigned int regno,
-		char *outbuffer_start,
-		bfd_boolean with_reg_prefix)
+                char *outbuffer_start,
+                bfd_boolean with_reg_prefix)
 {
   char *outbuffer = outbuffer_start;
   int i;
@@ -1790,8 +1790,8 @@ format_sup_reg (unsigned int regno,
   for (i = 0; cris_support_regs[i].name != NULL; i++)
     if (cris_support_regs[i].number == regno)
       {
-	sprintf (outbuffer, "%s", cris_support_regs[i].name);
-	return outbuffer_start + strlen (outbuffer_start);
+        sprintf (outbuffer, "%s", cris_support_regs[i].name);
+        return outbuffer_start + strlen (outbuffer_start);
       }
 
   /* There's supposed to be register names covering all numbers, though
@@ -1804,9 +1804,9 @@ format_sup_reg (unsigned int regno,
 
 static unsigned
 bytes_to_skip (unsigned int insn,
-	       const struct cris_opcode *matchedp,
-	       enum cris_disass_family distype,
-	       const struct cris_opcode *prefix_matchedp)
+               const struct cris_opcode *matchedp,
+               enum cris_disass_family distype,
+               const struct cris_opcode *prefix_matchedp)
 {
   /* Each insn is a word plus "immediate" operands.  */
   unsigned to_skip = 2;
@@ -1815,33 +1815,33 @@ bytes_to_skip (unsigned int insn,
 
   for (s = template; *s; s++)
     if ((*s == 's' || *s == 'N' || *s == 'Y')
-	&& (insn & 0x400) && (insn & 15) == 15
-	&& prefix_matchedp == NULL)
+        && (insn & 0x400) && (insn & 15) == 15
+        && prefix_matchedp == NULL)
       {
-	/* Immediate via [pc+], so we have to check the size of the
-	   operand.  */
-	int mode_size = 1 << ((insn >> 4) & (*template == 'z' ? 1 : 3));
+        /* Immediate via [pc+], so we have to check the size of the
+           operand.  */
+        int mode_size = 1 << ((insn >> 4) & (*template == 'z' ? 1 : 3));
 
-	if (matchedp->imm_oprnd_size == SIZE_FIX_32)
-	  to_skip += 4;
-	else if (matchedp->imm_oprnd_size == SIZE_SPEC_REG)
-	  {
-	    const struct cris_spec_reg *sregp
-	      = spec_reg_info ((insn >> 12) & 15, distype);
+        if (matchedp->imm_oprnd_size == SIZE_FIX_32)
+          to_skip += 4;
+        else if (matchedp->imm_oprnd_size == SIZE_SPEC_REG)
+          {
+            const struct cris_spec_reg *sregp
+              = spec_reg_info ((insn >> 12) & 15, distype);
 
-	    /* FIXME: Improve error handling; should have been caught
-	       earlier.  */
-	    if (sregp == NULL)
-	      return 2;
+            /* FIXME: Improve error handling; should have been caught
+               earlier.  */
+            if (sregp == NULL)
+              return 2;
 
-	    /* PC is incremented by two, not one, for a byte.  Except on
-	       CRISv32, where constants are always DWORD-size for
-	       special registers.  */
-	    to_skip +=
-	      distype == cris_dis_v32 ? 4 : (sregp->reg_size + 1) & ~1;
-	  }
-	else
-	  to_skip += (mode_size + 1) & ~1;
+            /* PC is incremented by two, not one, for a byte.  Except on
+               CRISv32, where constants are always DWORD-size for
+               special registers.  */
+            to_skip +=
+              distype == cris_dis_v32 ? 4 : (sregp->reg_size + 1) & ~1;
+          }
+        else
+          to_skip += (mode_size + 1) & ~1;
       }
     else if (*s == 'n')
       to_skip += 4;
@@ -1888,17 +1888,17 @@ print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
 
 static void
 print_with_operands (const struct cris_opcode *opcodep,
-		     unsigned int insn,
-		     unsigned char *buffer,
-		     bfd_vma addr,
-		     disassemble_info *info,
-		     /* If a prefix insn was before this insn (and is supposed
-			to be output as an address), here is a description of
-			it.  */
-		     const struct cris_opcode *prefix_opcodep,
-		     unsigned int prefix_insn,
-		     unsigned char *prefix_buffer,
-		     bfd_boolean with_reg_prefix)
+                     unsigned int insn,
+                     unsigned char *buffer,
+                     bfd_vma addr,
+                     disassemble_info *info,
+                     /* If a prefix insn was before this insn (and is supposed
+                        to be output as an address), here is a description of
+                        it.  */
+                     const struct cris_opcode *prefix_opcodep,
+                     unsigned int prefix_insn,
+                     unsigned char *prefix_buffer,
+                     bfd_boolean with_reg_prefix)
 {
   /* Get a buffer of somewhat reasonable size where we store
      intermediate parts of the insn.  */
@@ -1926,9 +1926,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 
       /* Get the size-letter.  */
       *tp++ = *s == 'M'
-	? (insn & 0x8000 ? 'd'
-	   : insn & 0x4000 ? 'w' : 'b')
-	: mode_char[(insn >> 4) & (*s == 'z' ? 1 : 3)];
+        ? (insn & 0x8000 ? 'd'
+           : insn & 0x4000 ? 'w' : 'b')
+        : mode_char[(insn >> 4) & (*s == 'z' ? 1 : 3)];
 
       /* Ignore the size and the space character that follows.  */
       s += 2;
@@ -1944,11 +1944,11 @@ print_with_operands (const struct cris_opcode *opcodep,
   if (opcodep->name[0] == 'j')
     {
       if (CONST_STRNEQ (opcodep->name, "jsr"))
-	/* It's "jsr" or "jsrc".  */
-	info->insn_type = dis_jsr;
+        /* It's "jsr" or "jsrc".  */
+        info->insn_type = dis_jsr;
       else
-	/* Any other jump-type insn is considered a branch.  */
-	info->insn_type = dis_branch;
+        /* Any other jump-type insn is considered a branch.  */
+        info->insn_type = dis_branch;
     }
 
   /* We might know some more fields right now.  */
@@ -1960,475 +1960,475 @@ print_with_operands (const struct cris_opcode *opcodep,
     switch (*s)
       {
       case 'T':
-	tp = format_sup_reg ((insn >> 12) & 15, tp, with_reg_prefix);
-	break;
+        tp = format_sup_reg ((insn >> 12) & 15, tp, with_reg_prefix);
+        break;
 
       case 'A':
-	if (with_reg_prefix)
-	  *tp++ = REGISTER_PREFIX_CHAR;
-	*tp++ = 'a';
-	*tp++ = 'c';
-	*tp++ = 'r';
-	break;
+        if (with_reg_prefix)
+          *tp++ = REGISTER_PREFIX_CHAR;
+        *tp++ = 'a';
+        *tp++ = 'c';
+        *tp++ = 'r';
+        break;
 
       case '[':
       case ']':
       case ',':
-	*tp++ = *s;
-	break;
+        *tp++ = *s;
+        break;
 
       case '!':
-	/* Ignore at this point; used at earlier stages to avoid
-	   recognition if there's a prefix at something that in other
-	   ways looks like a "pop".  */
-	break;
+        /* Ignore at this point; used at earlier stages to avoid
+           recognition if there's a prefix at something that in other
+           ways looks like a "pop".  */
+        break;
 
       case 'd':
-	/* Ignore.  This is an optional ".d " on the large one of
-	   relaxable insns.  */
-	break;
+        /* Ignore.  This is an optional ".d " on the large one of
+           relaxable insns.  */
+        break;
 
       case 'B':
-	/* This was the prefix that made this a "push".  We've already
-	   handled it by recognizing it, so signal that the prefix is
-	   handled by setting it to NULL.  */
-	prefix_opcodep = NULL;
-	break;
+        /* This was the prefix that made this a "push".  We've already
+           handled it by recognizing it, so signal that the prefix is
+           handled by setting it to NULL.  */
+        prefix_opcodep = NULL;
+        break;
 
       case 'D':
       case 'r':
-	tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
-	break;
+        tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+        break;
 
       case 'R':
-	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
-	break;
+        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        break;
 
       case 'n':
-	{
-	  /* Like N but pc-relative to the start of the insn.  */
-	  uint32_t number
-	    = (buffer[2] + buffer[3] * 256 + buffer[4] * 65536
-	       + buffer[5] * 0x1000000 + addr);
+        {
+          /* Like N but pc-relative to the start of the insn.  */
+          uint32_t number
+            = (buffer[2] + buffer[3] * 256 + buffer[4] * 65536
+               + buffer[5] * 0x1000000 + addr);
 
-	  /* Finish off and output previous formatted bytes.  */
-	  *tp = 0;
-	  if (temp[0])
-	    (*info->fprintf_func) (info->stream, "%s", temp);
-	  tp = temp;
+          /* Finish off and output previous formatted bytes.  */
+          *tp = 0;
+          if (temp[0])
+            (*info->fprintf_func) (info->stream, "%s", temp);
+          tp = temp;
 
-	  (*info->print_address_func) ((bfd_vma) number, info);
-	}
-	break;
+          (*info->print_address_func) ((bfd_vma) number, info);
+        }
+        break;
 
       case 'u':
-	{
-	  /* Like n but the offset is bits <3:0> in the instruction.  */
-	  unsigned long number = (buffer[0] & 0xf) * 2 + addr;
+        {
+          /* Like n but the offset is bits <3:0> in the instruction.  */
+          unsigned long number = (buffer[0] & 0xf) * 2 + addr;
 
-	  /* Finish off and output previous formatted bytes.  */
-	  *tp = 0;
-	  if (temp[0])
-	    (*info->fprintf_func) (info->stream, "%s", temp);
-	  tp = temp;
+          /* Finish off and output previous formatted bytes.  */
+          *tp = 0;
+          if (temp[0])
+            (*info->fprintf_func) (info->stream, "%s", temp);
+          tp = temp;
 
-	  (*info->print_address_func) ((bfd_vma) number, info);
-	}
-	break;
+          (*info->print_address_func) ((bfd_vma) number, info);
+        }
+        break;
 
       case 'N':
       case 'y':
       case 'Y':
       case 'S':
       case 's':
-	/* Any "normal" memory operand.  */
-	if ((insn & 0x400) && (insn & 15) == 15 && prefix_opcodep == NULL)
-	  {
-	    /* We're looking at [pc+], i.e. we need to output an immediate
-	       number, where the size can depend on different things.  */
-	    int32_t number;
-	    int signedp
-	      = ((*cs == 'z' && (insn & 0x20))
-		 || opcodep->match == BDAP_QUICK_OPCODE);
-	    int nbytes;
+        /* Any "normal" memory operand.  */
+        if ((insn & 0x400) && (insn & 15) == 15 && prefix_opcodep == NULL)
+          {
+            /* We're looking at [pc+], i.e. we need to output an immediate
+               number, where the size can depend on different things.  */
+            int32_t number;
+            int signedp
+              = ((*cs == 'z' && (insn & 0x20))
+                 || opcodep->match == BDAP_QUICK_OPCODE);
+            int nbytes;
 
-	    if (opcodep->imm_oprnd_size == SIZE_FIX_32)
-	      nbytes = 4;
-	    else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
-	      {
-		const struct cris_spec_reg *sregp
-		  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+            if (opcodep->imm_oprnd_size == SIZE_FIX_32)
+              nbytes = 4;
+            else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
+              {
+                const struct cris_spec_reg *sregp
+                  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
 
-		/* A NULL return should have been as a non-match earlier,
-		   so catch it as an internal error in the error-case
-		   below.  */
-		if (sregp == NULL)
-		  /* Whatever non-valid size.  */
-		  nbytes = 42;
-		else
-		  /* PC is always incremented by a multiple of two.
-		     For CRISv32, immediates are always 4 bytes for
-		     special registers.  */
-		  nbytes = disdata->distype == cris_dis_v32
-		    ? 4 : (sregp->reg_size + 1) & ~1;
-	      }
-	    else
-	      {
-		int mode_size = 1 << ((insn >> 4) & (*cs == 'z' ? 1 : 3));
+                /* A NULL return should have been as a non-match earlier,
+                   so catch it as an internal error in the error-case
+                   below.  */
+                if (sregp == NULL)
+                  /* Whatever non-valid size.  */
+                  nbytes = 42;
+                else
+                  /* PC is always incremented by a multiple of two.
+                     For CRISv32, immediates are always 4 bytes for
+                     special registers.  */
+                  nbytes = disdata->distype == cris_dis_v32
+                    ? 4 : (sregp->reg_size + 1) & ~1;
+              }
+            else
+              {
+                int mode_size = 1 << ((insn >> 4) & (*cs == 'z' ? 1 : 3));
 
-		if (mode_size == 1)
-		  nbytes = 2;
-		else
-		  nbytes = mode_size;
-	      }
+                if (mode_size == 1)
+                  nbytes = 2;
+                else
+                  nbytes = mode_size;
+              }
 
-	    switch (nbytes)
-	      {
-	      case 1:
-		number = buffer[2];
-		if (signedp && number > 127)
-		  number -= 256;
-		break;
+            switch (nbytes)
+              {
+              case 1:
+                number = buffer[2];
+                if (signedp && number > 127)
+                  number -= 256;
+                break;
 
-	      case 2:
-		number = buffer[2] + buffer[3] * 256;
-		if (signedp && number > 32767)
-		  number -= 65536;
-		break;
+              case 2:
+                number = buffer[2] + buffer[3] * 256;
+                if (signedp && number > 32767)
+                  number -= 65536;
+                break;
 
-	      case 4:
-		number
-		  = buffer[2] + buffer[3] * 256 + buffer[4] * 65536
-		  + buffer[5] * 0x1000000;
-		break;
+              case 4:
+                number
+                  = buffer[2] + buffer[3] * 256 + buffer[4] * 65536
+                  + buffer[5] * 0x1000000;
+                break;
 
-	      default:
-		strcpy (tp, "bug");
-		tp += 3;
-		number = 42;
-	      }
+              default:
+                strcpy (tp, "bug");
+                tp += 3;
+                number = 42;
+              }
 
-	    if ((*cs == 'z' && (insn & 0x20))
-		|| (opcodep->match == BDAP_QUICK_OPCODE
-		    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
-	      tp = FORMAT_DEC (number, tp, signedp);
-	    else
-	      {
-		unsigned int highbyte = (number >> 24) & 0xff;
+            if ((*cs == 'z' && (insn & 0x20))
+                || (opcodep->match == BDAP_QUICK_OPCODE
+                    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
+              tp = FORMAT_DEC (number, tp, signedp);
+            else
+              {
+                unsigned int highbyte = (number >> 24) & 0xff;
 
-		/* Either output this as an address or as a number.  If it's
-		   a dword with the same high-byte as the address of the
-		   insn, assume it's an address, and also if it's a non-zero
-		   non-0xff high-byte.  If this is a jsr or a jump, then
-		   it's definitely an address.  */
-		if (nbytes == 4
-		    && (highbyte == ((addr >> 24) & 0xff)
-			|| (highbyte != 0 && highbyte != 0xff)
-			|| info->insn_type == dis_branch
-			|| info->insn_type == dis_jsr))
-		  {
-		    /* Finish off and output previous formatted bytes.  */
-		    *tp = 0;
-		    tp = temp;
-		    if (temp[0])
-		      (*info->fprintf_func) (info->stream, "%s", temp);
+                /* Either output this as an address or as a number.  If it's
+                   a dword with the same high-byte as the address of the
+                   insn, assume it's an address, and also if it's a non-zero
+                   non-0xff high-byte.  If this is a jsr or a jump, then
+                   it's definitely an address.  */
+                if (nbytes == 4
+                    && (highbyte == ((addr >> 24) & 0xff)
+                        || (highbyte != 0 && highbyte != 0xff)
+                        || info->insn_type == dis_branch
+                        || info->insn_type == dis_jsr))
+                  {
+                    /* Finish off and output previous formatted bytes.  */
+                    *tp = 0;
+                    tp = temp;
+                    if (temp[0])
+                      (*info->fprintf_func) (info->stream, "%s", temp);
 
-		    (*info->print_address_func) ((bfd_vma) number, info);
+                    (*info->print_address_func) ((bfd_vma) number, info);
 
-		    info->target = number;
-		  }
-		else
-		  tp = format_hex (number, tp, disdata);
-	      }
-	  }
-	else
-	  {
-	    /* Not an immediate number.  Then this is a (possibly
-	       prefixed) memory operand.  */
-	    if (info->insn_type != dis_nonbranch)
-	      {
-		int mode_size
-		  = 1 << ((insn >> 4)
-			  & (opcodep->args[0] == 'z' ? 1 : 3));
-		int size;
-		info->insn_type = dis_dref;
-		info->flags |= CRIS_DIS_FLAG_MEMREF;
+                    info->target = number;
+                  }
+                else
+                  tp = format_hex (number, tp, disdata);
+              }
+          }
+        else
+          {
+            /* Not an immediate number.  Then this is a (possibly
+               prefixed) memory operand.  */
+            if (info->insn_type != dis_nonbranch)
+              {
+                int mode_size
+                  = 1 << ((insn >> 4)
+                          & (opcodep->args[0] == 'z' ? 1 : 3));
+                int size;
+                info->insn_type = dis_dref;
+                info->flags |= CRIS_DIS_FLAG_MEMREF;
 
-		if (opcodep->imm_oprnd_size == SIZE_FIX_32)
-		  size = 4;
-		else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
-		  {
-		    const struct cris_spec_reg *sregp
-		      = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+                if (opcodep->imm_oprnd_size == SIZE_FIX_32)
+                  size = 4;
+                else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
+                  {
+                    const struct cris_spec_reg *sregp
+                      = spec_reg_info ((insn >> 12) & 15, disdata->distype);
 
-		    /* FIXME: Improve error handling; should have been caught
-		       earlier.  */
-		    if (sregp == NULL)
-		      size = 4;
-		    else
-		      size = sregp->reg_size;
-		  }
-		else
-		  size = mode_size;
+                    /* FIXME: Improve error handling; should have been caught
+                       earlier.  */
+                    if (sregp == NULL)
+                      size = 4;
+                    else
+                      size = sregp->reg_size;
+                  }
+                else
+                  size = mode_size;
 
-		info->data_size = size;
-	      }
+                info->data_size = size;
+              }
 
-	    *tp++ = '[';
+            *tp++ = '[';
 
-	    if (prefix_opcodep
-		/* We don't match dip with a postincremented field
-		   as a side-effect address mode.  */
-		&& ((insn & 0x400) == 0
-		    || prefix_opcodep->match != DIP_OPCODE))
-	      {
-		if (insn & 0x400)
-		  {
-		    tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
-		    *tp++ = '=';
-		  }
+            if (prefix_opcodep
+                /* We don't match dip with a postincremented field
+                   as a side-effect address mode.  */
+                && ((insn & 0x400) == 0
+                    || prefix_opcodep->match != DIP_OPCODE))
+              {
+                if (insn & 0x400)
+                  {
+                    tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+                    *tp++ = '=';
+                  }
 
 
-		/* We mainly ignore the prefix format string when the
-		   address-mode syntax is output.  */
-		switch (prefix_opcodep->match)
-		  {
-		  case DIP_OPCODE:
-		    /* It's [r], [r+] or [pc+].  */
-		    if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
-		      {
-			/* It's [pc+].  This cannot possibly be anything
-			   but an address.  */
-			uint32_t number
-			  = prefix_buffer[2] + prefix_buffer[3] * 256
-			  + prefix_buffer[4] * 65536
-			  + prefix_buffer[5] * 0x1000000;
+                /* We mainly ignore the prefix format string when the
+                   address-mode syntax is output.  */
+                switch (prefix_opcodep->match)
+                  {
+                  case DIP_OPCODE:
+                    /* It's [r], [r+] or [pc+].  */
+                    if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
+                      {
+                        /* It's [pc+].  This cannot possibly be anything
+                           but an address.  */
+                        uint32_t number
+                          = prefix_buffer[2] + prefix_buffer[3] * 256
+                          + prefix_buffer[4] * 65536
+                          + prefix_buffer[5] * 0x1000000;
 
-			info->target = (bfd_vma) number;
+                        info->target = (bfd_vma) number;
 
-			/* Finish off and output previous formatted
-			   data.  */
-			*tp = 0;
-			tp = temp;
-			if (temp[0])
-			  (*info->fprintf_func) (info->stream, "%s", temp);
+                        /* Finish off and output previous formatted
+                           data.  */
+                        *tp = 0;
+                        tp = temp;
+                        if (temp[0])
+                          (*info->fprintf_func) (info->stream, "%s", temp);
 
-			(*info->print_address_func) ((bfd_vma) number, info);
-		      }
-		    else
-		      {
-			/* For a memref in an address, we use target2.
-			   In this case, target is zero.  */
-			info->flags
-			  |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
-			      | CRIS_DIS_FLAG_MEM_TARGET2_MEM);
+                        (*info->print_address_func) ((bfd_vma) number, info);
+                      }
+                    else
+                      {
+                        /* For a memref in an address, we use target2.
+                           In this case, target is zero.  */
+                        info->flags
+                          |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
+                              | CRIS_DIS_FLAG_MEM_TARGET2_MEM);
 
-			info->target2 = prefix_insn & 15;
+                        info->target2 = prefix_insn & 15;
 
-			*tp++ = '[';
-			tp = format_reg (disdata, prefix_insn & 15, tp,
-					 with_reg_prefix);
-			if (prefix_insn & 0x400)
-			  *tp++ = '+';
-			*tp++ = ']';
-		      }
-		    break;
+                        *tp++ = '[';
+                        tp = format_reg (disdata, prefix_insn & 15, tp,
+                                         with_reg_prefix);
+                        if (prefix_insn & 0x400)
+                          *tp++ = '+';
+                        *tp++ = ']';
+                      }
+                    break;
 
-		  case BDAP_QUICK_OPCODE:
-		    {
-		      int number;
+                  case BDAP_QUICK_OPCODE:
+                    {
+                      int number;
 
-		      number = prefix_buffer[0];
-		      if (number > 127)
-			number -= 256;
+                      number = prefix_buffer[0];
+                      if (number > 127)
+                        number -= 256;
 
-		      /* Output "reg+num" or, if num < 0, "reg-num".  */
-		      tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-				       with_reg_prefix);
-		      if (number >= 0)
-			*tp++ = '+';
-		      tp = FORMAT_DEC (number, tp, 1);
+                      /* Output "reg+num" or, if num < 0, "reg-num".  */
+                      tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
+                                       with_reg_prefix);
+                      if (number >= 0)
+                        *tp++ = '+';
+                      tp = FORMAT_DEC (number, tp, 1);
 
-		      info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
-		      info->target = (prefix_insn >> 12) & 15;
-		      info->target2 = (bfd_vma) number;
-		      break;
-		    }
+                      info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
+                      info->target = (prefix_insn >> 12) & 15;
+                      info->target2 = (bfd_vma) number;
+                      break;
+                    }
 
-		  case BIAP_OPCODE:
-		    /* Output "r+R.m".  */
-		    tp = format_reg (disdata, prefix_insn & 15, tp,
-				     with_reg_prefix);
-		    *tp++ = '+';
-		    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-				     with_reg_prefix);
-		    *tp++ = '.';
-		    *tp++ = mode_char[(prefix_insn >> 4) & 3];
+                  case BIAP_OPCODE:
+                    /* Output "r+R.m".  */
+                    tp = format_reg (disdata, prefix_insn & 15, tp,
+                                     with_reg_prefix);
+                    *tp++ = '+';
+                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
+                                     with_reg_prefix);
+                    *tp++ = '.';
+                    *tp++ = mode_char[(prefix_insn >> 4) & 3];
 
-		    info->flags
-		      |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
-			  | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
+                    info->flags
+                      |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
+                          | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
 
-			  | ((prefix_insn & 0x8000)
-			     ? CRIS_DIS_FLAG_MEM_TARGET2_MULT4
-			     : ((prefix_insn & 0x8000)
-				? CRIS_DIS_FLAG_MEM_TARGET2_MULT2 : 0)));
+                          | ((prefix_insn & 0x8000)
+                             ? CRIS_DIS_FLAG_MEM_TARGET2_MULT4
+                             : ((prefix_insn & 0x8000)
+                                ? CRIS_DIS_FLAG_MEM_TARGET2_MULT2 : 0)));
 
-		    /* Is it the casejump?  It's a "adds.w [pc+r%d.w],pc".  */
-		    if (insn == 0xf83f && (prefix_insn & ~0xf000) == 0x55f)
-		      /* Then start interpreting data as offsets.  */
-		      case_offset_counter = no_of_case_offsets;
-		    break;
+                    /* Is it the casejump?  It's a "adds.w [pc+r%d.w],pc".  */
+                    if (insn == 0xf83f && (prefix_insn & ~0xf000) == 0x55f)
+                      /* Then start interpreting data as offsets.  */
+                      case_offset_counter = no_of_case_offsets;
+                    break;
 
-		  case BDAP_INDIR_OPCODE:
-		    /* Output "r+s.m", or, if "s" is [pc+], "r+s" or
-		       "r-s".  */
-		    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-				     with_reg_prefix);
+                  case BDAP_INDIR_OPCODE:
+                    /* Output "r+s.m", or, if "s" is [pc+], "r+s" or
+                       "r-s".  */
+                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
+                                     with_reg_prefix);
 
-		    if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
-		      {
-			int32_t number;
-			unsigned int nbytes;
+                    if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
+                      {
+                        int32_t number;
+                        unsigned int nbytes;
 
-			/* It's a value.  Get its size.  */
-			int mode_size = 1 << ((prefix_insn >> 4) & 3);
+                        /* It's a value.  Get its size.  */
+                        int mode_size = 1 << ((prefix_insn >> 4) & 3);
 
-			if (mode_size == 1)
-			  nbytes = 2;
-			else
-			  nbytes = mode_size;
+                        if (mode_size == 1)
+                          nbytes = 2;
+                        else
+                          nbytes = mode_size;
 
-			switch (nbytes)
-			  {
-			  case 1:
-			    number = prefix_buffer[2];
-			    if (number > 127)
-			      number -= 256;
-			    break;
+                        switch (nbytes)
+                          {
+                          case 1:
+                            number = prefix_buffer[2];
+                            if (number > 127)
+                              number -= 256;
+                            break;
 
-			  case 2:
-			    number = prefix_buffer[2] + prefix_buffer[3] * 256;
-			    if (number > 32767)
-			      number -= 65536;
-			    break;
+                          case 2:
+                            number = prefix_buffer[2] + prefix_buffer[3] * 256;
+                            if (number > 32767)
+                              number -= 65536;
+                            break;
 
-			  case 4:
-			    number
-			      = prefix_buffer[2] + prefix_buffer[3] * 256
-			      + prefix_buffer[4] * 65536
-			      + prefix_buffer[5] * 0x1000000;
-			    break;
+                          case 4:
+                            number
+                              = prefix_buffer[2] + prefix_buffer[3] * 256
+                              + prefix_buffer[4] * 65536
+                              + prefix_buffer[5] * 0x1000000;
+                            break;
 
-			  default:
-			    strcpy (tp, "bug");
-			    tp += 3;
-			    number = 42;
-			  }
+                          default:
+                            strcpy (tp, "bug");
+                            tp += 3;
+                            number = 42;
+                          }
 
-			info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
-			info->target2 = (bfd_vma) number;
+                        info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
+                        info->target2 = (bfd_vma) number;
 
-			/* If the size is dword, then assume it's an
-			   address.  */
-			if (nbytes == 4)
-			  {
-			    /* Finish off and output previous formatted
-			       bytes.  */
-			    *tp++ = '+';
-			    *tp = 0;
-			    tp = temp;
-			    (*info->fprintf_func) (info->stream, "%s", temp);
+                        /* If the size is dword, then assume it's an
+                           address.  */
+                        if (nbytes == 4)
+                          {
+                            /* Finish off and output previous formatted
+                               bytes.  */
+                            *tp++ = '+';
+                            *tp = 0;
+                            tp = temp;
+                            (*info->fprintf_func) (info->stream, "%s", temp);
 
-			    (*info->print_address_func) ((bfd_vma) number, info);
-			  }
-			else
-			  {
-			    if (number >= 0)
-			      *tp++ = '+';
-			    tp = FORMAT_DEC (number, tp, 1);
-			  }
-		      }
-		    else
-		      {
-			/* Output "r+[R].m" or "r+[R+].m".  */
-			*tp++ = '+';
-			*tp++ = '[';
-			tp = format_reg (disdata, prefix_insn & 15, tp,
-					 with_reg_prefix);
-			if (prefix_insn & 0x400)
-			  *tp++ = '+';
-			*tp++ = ']';
-			*tp++ = '.';
-			*tp++ = mode_char[(prefix_insn >> 4) & 3];
+                            (*info->print_address_func) ((bfd_vma) number, info);
+                          }
+                        else
+                          {
+                            if (number >= 0)
+                              *tp++ = '+';
+                            tp = FORMAT_DEC (number, tp, 1);
+                          }
+                      }
+                    else
+                      {
+                        /* Output "r+[R].m" or "r+[R+].m".  */
+                        *tp++ = '+';
+                        *tp++ = '[';
+                        tp = format_reg (disdata, prefix_insn & 15, tp,
+                                         with_reg_prefix);
+                        if (prefix_insn & 0x400)
+                          *tp++ = '+';
+                        *tp++ = ']';
+                        *tp++ = '.';
+                        *tp++ = mode_char[(prefix_insn >> 4) & 3];
 
-			info->flags
-			  |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
-			      | CRIS_DIS_FLAG_MEM_TARGET2_MEM
-			      | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
+                        info->flags
+                          |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
+                              | CRIS_DIS_FLAG_MEM_TARGET2_MEM
+                              | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
 
-			      | (((prefix_insn >> 4) == 2)
-				 ? 0
-				 : (((prefix_insn >> 4) & 3) == 1
-				    ? CRIS_DIS_FLAG_MEM_TARGET2_MEM_WORD
-				    : CRIS_DIS_FLAG_MEM_TARGET2_MEM_BYTE)));
-		      }
-		    break;
+                              | (((prefix_insn >> 4) == 2)
+                                 ? 0
+                                 : (((prefix_insn >> 4) & 3) == 1
+                                    ? CRIS_DIS_FLAG_MEM_TARGET2_MEM_WORD
+                                    : CRIS_DIS_FLAG_MEM_TARGET2_MEM_BYTE)));
+                      }
+                    break;
 
-		  default:
-		    (*info->fprintf_func) (info->stream, "?prefix-bug");
-		  }
+                  default:
+                    (*info->fprintf_func) (info->stream, "?prefix-bug");
+                  }
 
-		/* To mark that the prefix is used, reset it.  */
-		prefix_opcodep = NULL;
-	      }
-	    else
-	      {
-		tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+                /* To mark that the prefix is used, reset it.  */
+                prefix_opcodep = NULL;
+              }
+            else
+              {
+                tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
 
-		info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
-		info->target = insn & 15;
+                info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
+                info->target = insn & 15;
 
-		if (insn & 0x400)
-		  *tp++ = '+';
-	      }
-	    *tp++ = ']';
-	  }
-	break;
+                if (insn & 0x400)
+                  *tp++ = '+';
+              }
+            *tp++ = ']';
+          }
+        break;
 
       case 'x':
-	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
-	*tp++ = '.';
-	*tp++ = mode_char[(insn >> 4) & 3];
-	break;
+        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        *tp++ = '.';
+        *tp++ = mode_char[(insn >> 4) & 3];
+        break;
 
       case 'I':
-	tp = FORMAT_DEC (insn & 63, tp, 0);
-	break;
+        tp = FORMAT_DEC (insn & 63, tp, 0);
+        break;
 
       case 'b':
-	{
-	  int where = buffer[2] + buffer[3] * 256;
+        {
+          int where = buffer[2] + buffer[3] * 256;
 
-	  if (where > 32767)
-	    where -= 65536;
+          if (where > 32767)
+            where -= 65536;
 
-	  where += addr + ((disdata->distype == cris_dis_v32) ? 0 : 4);
+          where += addr + ((disdata->distype == cris_dis_v32) ? 0 : 4);
 
-	  if (insn == BA_PC_INCR_OPCODE)
-	    info->insn_type = dis_branch;
-	  else
-	    info->insn_type = dis_condbranch;
+          if (insn == BA_PC_INCR_OPCODE)
+            info->insn_type = dis_branch;
+          else
+            info->insn_type = dis_condbranch;
 
-	  info->target = (bfd_vma) where;
+          info->target = (bfd_vma) where;
 
-	  *tp = 0;
-	  tp = temp;
-	  (*info->fprintf_func) (info->stream, "%s%s ",
-				 temp, cris_cc_strings[insn >> 12]);
+          *tp = 0;
+          tp = temp;
+          (*info->fprintf_func) (info->stream, "%s%s ",
+                                 temp, cris_cc_strings[insn >> 12]);
 
-	  (*info->print_address_func) ((bfd_vma) where, info);
-	}
+          (*info->print_address_func) ((bfd_vma) where, info);
+        }
       break;
 
     case 'c':
@@ -2441,37 +2441,37 @@ print_with_operands (const struct cris_opcode *opcodep,
 
     case 'o':
       {
-	long offset = insn & 0xfe;
-	bfd_vma target;
+        long offset = insn & 0xfe;
+        bfd_vma target;
 
-	if (insn & 1)
-	  offset |= ~0xff;
+        if (insn & 1)
+          offset |= ~0xff;
 
-	if (opcodep->match == BA_QUICK_OPCODE)
-	  info->insn_type = dis_branch;
-	else
-	  info->insn_type = dis_condbranch;
+        if (opcodep->match == BA_QUICK_OPCODE)
+          info->insn_type = dis_branch;
+        else
+          info->insn_type = dis_condbranch;
 
-	target = addr + ((disdata->distype == cris_dis_v32) ? 0 : 2) + offset;
-	info->target = target;
-	*tp = 0;
-	tp = temp;
-	(*info->fprintf_func) (info->stream, "%s", temp);
-	(*info->print_address_func) (target, info);
+        target = addr + ((disdata->distype == cris_dis_v32) ? 0 : 2) + offset;
+        info->target = target;
+        *tp = 0;
+        tp = temp;
+        (*info->fprintf_func) (info->stream, "%s", temp);
+        (*info->print_address_func) (target, info);
       }
       break;
 
     case 'Q':
     case 'O':
       {
-	long number = buffer[0];
+        long number = buffer[0];
 
-	if (number > 127)
-	  number = number - 256;
+        if (number > 127)
+          number = number - 256;
 
-	tp = FORMAT_DEC (number, tp, 1);
-	*tp++ = ',';
-	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        tp = FORMAT_DEC (number, tp, 1);
+        *tp++ = ',';
+        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
       }
       break;
 
@@ -2485,19 +2485,19 @@ print_with_operands (const struct cris_opcode *opcodep,
 
     case 'P':
       {
-	const struct cris_spec_reg *sregp
-	  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+        const struct cris_spec_reg *sregp
+          = spec_reg_info ((insn >> 12) & 15, disdata->distype);
 
-	if (sregp == NULL || sregp->name == NULL)
-	  /* Should have been caught as a non-match earlier.  */
-	  *tp++ = '?';
-	else
-	  {
-	    if (with_reg_prefix)
-	      *tp++ = REGISTER_PREFIX_CHAR;
-	    strcpy (tp, sregp->name);
-	    tp += strlen (tp);
-	  }
+        if (sregp == NULL || sregp->name == NULL)
+          /* Should have been caught as a non-match earlier.  */
+          *tp++ = '?';
+        else
+          {
+            if (with_reg_prefix)
+              *tp++ = REGISTER_PREFIX_CHAR;
+            strcpy (tp, sregp->name);
+            tp += strlen (tp);
+          }
       }
       break;
 
@@ -2511,7 +2511,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 
   if (prefix_opcodep)
     (*info->fprintf_func) (info->stream, " (OOPS unused prefix \"%s: %s\")",
-			   prefix_opcodep->name, prefix_opcodep->args);
+                           prefix_opcodep->name, prefix_opcodep->args);
 
   (*info->fprintf_func) (info->stream, "%s", temp);
 
@@ -2521,23 +2521,23 @@ print_with_operands (const struct cris_opcode *opcodep,
   if (TRACE_CASE && case_offset_counter == 0)
     {
       if (CONST_STRNEQ (opcodep->name, "sub"))
-	case_offset = last_immediate;
+        case_offset = last_immediate;
 
       /* It could also be an "add", if there are negative case-values.  */
       else if (CONST_STRNEQ (opcodep->name, "add"))
-	/* The first case is the negated operand to the add.  */
-	case_offset = -last_immediate;
+        /* The first case is the negated operand to the add.  */
+        case_offset = -last_immediate;
 
       /* A bound insn will tell us the number of cases.  */
       else if (CONST_STRNEQ (opcodep->name, "bound"))
-	no_of_case_offsets = last_immediate + 1;
+        no_of_case_offsets = last_immediate + 1;
 
       /* A jump or jsr or branch breaks the chain of insns for a
-	 case-table, so assume default first-case again.  */
+         case-table, so assume default first-case again.  */
       else if (info->insn_type == dis_jsr
-	       || info->insn_type == dis_branch
-	       || info->insn_type == dis_condbranch)
-	case_offset = 0;
+               || info->insn_type == dis_branch
+               || info->insn_type == dis_condbranch)
+        case_offset = 0;
     }
 }
 
@@ -2548,8 +2548,8 @@ print_with_operands (const struct cris_opcode *opcodep,
 
 static int
 print_insn_cris_generic (bfd_vma memaddr,
-			 disassemble_info *info,
-			 bfd_boolean with_reg_prefix)
+                         disassemble_info *info,
+                         bfd_boolean with_reg_prefix)
 {
   int nbytes;
   unsigned int insn;
@@ -2575,7 +2575,7 @@ print_insn_cris_generic (bfd_vma memaddr,
   nbytes = info->buffer_length ? info->buffer_length
                                : MAX_BYTES_PER_CRIS_INSN;
   nbytes = MIN(nbytes, MAX_BYTES_PER_CRIS_INSN);
-  status = (*info->read_memory_func) (memaddr, buffer, nbytes, info);  
+  status = (*info->read_memory_func) (memaddr, buffer, nbytes, info);
 
   /* If we did not get all we asked for, then clear the rest.
      Hopefully this makes a reproducible result in case of errors.  */
@@ -2603,101 +2603,101 @@ print_insn_cris_generic (bfd_vma memaddr,
 
       /* If we're in a case-table, don't disassemble the offsets.  */
       if (TRACE_CASE && case_offset_counter != 0)
-	{
-	  info->insn_type = dis_noninsn;
-	  advance += 2;
+        {
+          info->insn_type = dis_noninsn;
+          advance += 2;
 
-	  /* If to print data as offsets, then shortcut here.  */
-	  (*info->fprintf_func) (info->stream, "case %ld%s: -> ",
-				 case_offset + no_of_case_offsets
-				 - case_offset_counter,
-				 case_offset_counter == 1 ? "/default" :
-				 "");
+          /* If to print data as offsets, then shortcut here.  */
+          (*info->fprintf_func) (info->stream, "case %ld%s: -> ",
+                                 case_offset + no_of_case_offsets
+                                 - case_offset_counter,
+                                 case_offset_counter == 1 ? "/default" :
+                                 "");
 
-	  (*info->print_address_func) ((bfd_vma)
-				       ((short) (insn)
-					+ (long) (addr
-						  - (no_of_case_offsets
-						     - case_offset_counter)
-						  * 2)), info);
-	  case_offset_counter--;
+          (*info->print_address_func) ((bfd_vma)
+                                       ((short) (insn)
+                                        + (long) (addr
+                                                  - (no_of_case_offsets
+                                                     - case_offset_counter)
+                                                  * 2)), info);
+          case_offset_counter--;
 
-	  /* The default case start (without a "sub" or "add") must be
-	     zero.  */
-	  if (case_offset_counter == 0)
-	    case_offset = 0;
-	}
+          /* The default case start (without a "sub" or "add") must be
+             zero.  */
+          if (case_offset_counter == 0)
+            case_offset = 0;
+        }
       else if (insn == 0)
-	{
-	  /* We're often called to disassemble zeroes.  While this is a
-	     valid "bcc .+2" insn, it is also useless enough and enough
-	     of a nuiscance that we will just output "bcc .+2" for it
-	     and signal it as a noninsn.  */
-	  (*info->fprintf_func) (info->stream,
-				 disdata->distype == cris_dis_v32
-				 ? "bcc ." : "bcc .+2");
-	  info->insn_type = dis_noninsn;
-	  advance += 2;
-	}
+        {
+          /* We're often called to disassemble zeroes.  While this is a
+             valid "bcc .+2" insn, it is also useless enough and enough
+             of a nuiscance that we will just output "bcc .+2" for it
+             and signal it as a noninsn.  */
+          (*info->fprintf_func) (info->stream,
+                                 disdata->distype == cris_dis_v32
+                                 ? "bcc ." : "bcc .+2");
+          info->insn_type = dis_noninsn;
+          advance += 2;
+        }
       else
-	{
-	  const struct cris_opcode *prefix_opcodep = NULL;
-	  unsigned char *prefix_buffer = bufp;
-	  unsigned int prefix_insn = insn;
-	  int prefix_size = 0;
+        {
+          const struct cris_opcode *prefix_opcodep = NULL;
+          unsigned char *prefix_buffer = bufp;
+          unsigned int prefix_insn = insn;
+          int prefix_size = 0;
 
-	  matchedp = get_opcode_entry (insn, NO_CRIS_PREFIX, disdata);
+          matchedp = get_opcode_entry (insn, NO_CRIS_PREFIX, disdata);
 
-	  /* Check if we're supposed to write out prefixes as address
-	     modes and if this was a prefix.  */
-	  if (matchedp != NULL && PARSE_PREFIX && matchedp->args[0] == 'p')
-	    {
-	      /* If it's a prefix, put it into the prefix vars and get the
-		 main insn.  */
-	      prefix_size = bytes_to_skip (prefix_insn, matchedp,
-					   disdata->distype, NULL);
-	      prefix_opcodep = matchedp;
+          /* Check if we're supposed to write out prefixes as address
+             modes and if this was a prefix.  */
+          if (matchedp != NULL && PARSE_PREFIX && matchedp->args[0] == 'p')
+            {
+              /* If it's a prefix, put it into the prefix vars and get the
+                 main insn.  */
+              prefix_size = bytes_to_skip (prefix_insn, matchedp,
+                                           disdata->distype, NULL);
+              prefix_opcodep = matchedp;
 
-	      insn = bufp[prefix_size] + bufp[prefix_size + 1] * 256;
-	      matchedp = get_opcode_entry (insn, prefix_insn, disdata);
+              insn = bufp[prefix_size] + bufp[prefix_size + 1] * 256;
+              matchedp = get_opcode_entry (insn, prefix_insn, disdata);
 
-	      if (matchedp != NULL)
-		{
-		  addr += prefix_size;
-		  bufp += prefix_size;
-		  advance += prefix_size;
-		}
-	      else
-		{
-		  /* The "main" insn wasn't valid, at least not when
-		     prefixed.  Put back things enough to output the
-		     prefix insn only, as a normal insn.  */
-		  matchedp = prefix_opcodep;
-		  insn = prefix_insn;
-		  prefix_opcodep = NULL;
-		}
-	    }
+              if (matchedp != NULL)
+                {
+                  addr += prefix_size;
+                  bufp += prefix_size;
+                  advance += prefix_size;
+                }
+              else
+                {
+                  /* The "main" insn wasn't valid, at least not when
+                     prefixed.  Put back things enough to output the
+                     prefix insn only, as a normal insn.  */
+                  matchedp = prefix_opcodep;
+                  insn = prefix_insn;
+                  prefix_opcodep = NULL;
+                }
+            }
 
-	  if (matchedp == NULL)
-	    {
-	      (*info->fprintf_func) (info->stream, "??0x%x", insn);
-	      advance += 2;
+          if (matchedp == NULL)
+            {
+              (*info->fprintf_func) (info->stream, "??0x%x", insn);
+              advance += 2;
 
-	      info->insn_type = dis_noninsn;
-	    }
-	  else
-	    {
-	      advance
-		+= bytes_to_skip (insn, matchedp, disdata->distype,
-				  prefix_opcodep);
+              info->insn_type = dis_noninsn;
+            }
+          else
+            {
+              advance
+                += bytes_to_skip (insn, matchedp, disdata->distype,
+                                  prefix_opcodep);
 
-	      /* The info_type and assorted fields will be set according
-		 to the operands.   */
-	      print_with_operands (matchedp, insn, bufp, addr, info,
-				   prefix_opcodep, prefix_insn,
-				   prefix_buffer, with_reg_prefix);
-	    }
-	}
+              /* The info_type and assorted fields will be set according
+                 to the operands.   */
+              print_with_operands (matchedp, insn, bufp, addr, info,
+                                   prefix_opcodep, prefix_insn,
+                                   prefix_buffer, with_reg_prefix);
+            }
+        }
     }
   else
     info->insn_type = dis_noninsn;
@@ -2733,24 +2733,24 @@ print_insn_cris_generic (bfd_vma memaddr,
 /* Disassemble, prefixing register names with `$'.  CRIS v0..v10.  */
 static int
 print_insn_cris_with_register_prefix (bfd_vma vma,
-				      disassemble_info *info)
+                                      disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_v0_v10);
+                                   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, true);
 }
 /* Disassemble, prefixing register names with `$'.  CRIS v32.  */
 
 static int
 print_insn_crisv32_with_register_prefix (bfd_vma vma,
-					 disassemble_info *info)
+                                         disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_v32);
+                                   cris_dis_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2760,12 +2760,12 @@ print_insn_crisv32_with_register_prefix (bfd_vma vma,
 
 static int
 print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
-					     disassemble_info *info)
+                                             disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_common_v10_v32);
+                                   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2773,12 +2773,12 @@ print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
 
 static int
 print_insn_cris_without_register_prefix (bfd_vma vma,
-					 disassemble_info *info)
+                                         disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_v0_v10);
+                                   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2786,12 +2786,12 @@ print_insn_cris_without_register_prefix (bfd_vma vma,
 
 static int
 print_insn_crisv32_without_register_prefix (bfd_vma vma,
-					    disassemble_info *info)
+                                            disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_v32);
+                                   cris_dis_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2800,26 +2800,26 @@ print_insn_crisv32_without_register_prefix (bfd_vma vma,
 
 static int
 print_insn_crisv10_v32_without_register_prefix (bfd_vma vma,
-						disassemble_info *info)
+                                                disassemble_info *info)
 {
   struct cris_disasm_data disdata;
   info->private_data = &disdata;
   cris_parse_disassembler_options (&disdata, info->disassembler_options,
-				   cris_dis_common_v10_v32);
+                                   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 #endif
 
 int
 print_insn_crisv10 (bfd_vma vma,
-		    disassemble_info *info)
+                    disassemble_info *info)
 {
   return print_insn_cris_with_register_prefix(vma, info);
 }
 
 int
 print_insn_crisv32 (bfd_vma vma,
-		    disassemble_info *info)
+                    disassemble_info *info)
 {
   return print_insn_crisv32_with_register_prefix(vma, info);
 }
@@ -2841,12 +2841,12 @@ cris_get_disassembler (bfd *abfd)
   if (bfd_get_symbol_leading_char (abfd) == 0)
     {
       if (bfd_get_mach (abfd) == bfd_mach_cris_v32)
-	return print_insn_crisv32_with_register_prefix;
+        return print_insn_crisv32_with_register_prefix;
       if (bfd_get_mach (abfd) == bfd_mach_cris_v10_v32)
-	return print_insn_crisv10_v32_with_register_prefix;
+        return print_insn_crisv10_v32_with_register_prefix;
 
       /* We default to v10.  This may be specifically specified in the
-	 bfd mach, but is also the default setting.  */
+         bfd mach, but is also the default setting.  */
       return print_insn_cris_with_register_prefix;
     }
 
-- 
2.34.1


