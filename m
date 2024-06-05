Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574BBC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz2-0000ft-VT; Wed, 05 Jun 2024 17:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExz0-0000ec-J1
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyp-0003R8-31
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-703ed5d37acso209616b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622133; x=1718226933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFxHmpuLno/vzESqMH03QaHYXrgS2cWTQ/a+ozUvhB0=;
 b=DlT8CeQ+dyq7X+YC5B4SShHZnYGNLHkxz/+4350yQ3s2ZRv4xmZes90k03y8nXvl/8
 peBtDh8/w9JZgDULyaFOqcLoVfyHT9fyTiqz9kIT85PZE22qwk9StD+IPwdiLby14vHG
 xiwBM+0Wyk7AUl4gqJYh/0B8XEQUJD0oDKLv2UwlMFuR33KtyEuQIihvKESCpZ4T07Dy
 ILSVYeBbP0qh5pNwTcm/Q5RBOqOuo4CQV19Qi6Ed0zNoG87sjDmVd71Xrc0coKy5aaiC
 kyikqCazANFXho6PHcfx0A56NLGsYl0ndgPhobba4C79kSfdka/vWSAZWV35JX5nFzUT
 Wt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622133; x=1718226933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFxHmpuLno/vzESqMH03QaHYXrgS2cWTQ/a+ozUvhB0=;
 b=E+nl18UnBPoX351zmgC+Aplh6C9Z8CY3aaHmdHDHbMQxArgETLzrRRFHokUQE+fp87
 kKGwRHSZAEqQaLEVoywMTHVADgBwtRi/m0uR+b21qNE1Q8MUsuMm4hSGNRXWzbpQwC7B
 wOvRIaKVUyXtKlqkVLuLz9SNhjFVtIySAxTfC9Eki/Ix5Mg40kYI3FqYuxtg3NQwo8tj
 w31SbtQ8qqyy6QXfUKBNC4IPewgLSNgSFd2rlDThw5xeI+MdjvAwOJwrCYDzH0rfXw3U
 /W7zI/Qrc74Lvh724oqnQpp3OwhZlm6PwgtLTGZ5gUvXU+syHJIrSptc5vHN2iKog+iI
 nprA==
X-Gm-Message-State: AOJu0Ywt0JDrsCBeJPbyUKkj8wqqboNfV+PLHFUSGjLTveoi1Je6YsCz
 XnNAHBst0NXpbHzO/pU64Dn3VJ6HiKnzqJREyGybyngy6ouH29Tket9xnh5ovLH/uiVIIFTdmWT
 f
X-Google-Smtp-Source: AGHT+IG716opgUaVQw5vhxpffJXw5e/HHWMlz45bgNsEo2JZlb0FWyzdxXNvCoY5mx0+j9lux1GJfg==
X-Received: by 2002:a05:6a00:1991:b0:6ed:de70:5ef8 with SMTP id
 d2e1a72fcca58-703e5986e56mr4814896b3a.6.1717622133569; 
 Wed, 05 Jun 2024 14:15:33 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/16] disas/microblaze: Print registers directly with PRIreg
Date: Wed,  5 Jun 2024 14:15:17 -0700
Message-Id: <20240605211521.577094-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use a printf format instead of sprintf into a buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-18-richard.henderson@linaro.org>
---
 disas/microblaze.c | 54 ++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index a537ac65dd..c12968f3b9 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -563,7 +563,7 @@ static const struct op_code_struct {
 };
 
 /* prefix for register names */
-static const char register_prefix[] = "r";
+#define register_prefix "r"
 static const char fsl_register_prefix[] = "rfsl";
 static const char pvr_register_prefix[] = "rpvr";
 
@@ -579,15 +579,16 @@ static const char pvr_register_prefix[] = "rpvr";
 
 #include "disas/dis-asm.h"
 
-#define get_field_rd(instr) get_field(instr, RD_MASK, RD_LOW)
-#define get_field_r1(instr) get_field(instr, RA_MASK, RA_LOW)
-#define get_field_r2(instr) get_field(instr, RB_MASK, RB_LOW)
+#define PRIreg    register_prefix "%ld"
+
+#define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
+#define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
+#define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
 /* Local function prototypes. */
 
-static char * get_field (long instr, long mask, unsigned short low);
 static char * get_field_imm (long instr);
 static char * get_field_imm5 (long instr);
 static char * get_field_rfsl (long instr);
@@ -596,15 +597,6 @@ static char * get_field_imm15 (long instr);
 static char * get_field_unsigned_imm (long instr);
 #endif
 
-static char *
-get_field (long instr, long mask, unsigned short low)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
-           (int)((instr & mask) >> low));
-  return(strdup(tmpstr));
-}
-
 static char *
 get_field_imm (long instr)
 {
@@ -832,12 +824,12 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
 
     switch (op->inst_type) {
     case INST_TYPE_RD_R1_R2:
-        fprintf_func(stream, "%s\t%s, %s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIreg,
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_r2(inst));
         break;
     case INST_TYPE_RD_R1_IMM:
-        fprintf_func(stream, "%s\t%s, %s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm(inst));
         if (get_int_field_r1(inst) == 0) {
@@ -845,36 +837,36 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R1_IMM5:
-        fprintf_func(stream, "%s\t%s, %s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm5(inst));
         break;
     case INST_TYPE_RD_RFSL:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_R1_RFSL:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_special(inst, op));
         break;
     case INST_TYPE_SPECIAL_R1:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t%s, " PRIreg,
                      op->name, get_field_special(inst, op), get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
                      op->name, get_field_rd(inst), get_field_r1(inst));
         break;
     case INST_TYPE_R1_R2:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
                      op->name, get_field_r1(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R1_IMM:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_r1(inst), get_field_imm(inst));
         /*
          * The non-pc relative instructions are returns,
@@ -885,7 +877,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_IMM:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_imm(inst));
         print_immval_addr(info, immfound, immval, inst,
                           op->inst_offset_type == INST_PC_OFFSET
@@ -901,28 +893,28 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R2:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
                      op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R2:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIreg,
                      op->name, get_field_r2(inst));
         break;
     case INST_TYPE_R1:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIreg,
                      op->name, get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1_SPECIAL:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
                      op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_RD_IMM15:
-        fprintf_func(stream, "%s\t%s, %s",
+        fprintf_func(stream, "%s\t" PRIreg ", %s",
                      op->name, get_field_rd(inst), get_field_imm15(inst));
         break;
         /* For tuqula instruction */
     case INST_TYPE_RD:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIreg,
                      op->name, get_field_rd(inst));
         break;
     case INST_TYPE_RFSL:
-- 
2.34.1


