Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F69C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQN-00075u-4V; Fri, 12 Apr 2024 03:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-00074g-E3
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQB-0007CG-Ng
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso5267825ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907241; x=1713512041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pu90wwD72TTj1mq3bNLzC0zO16JxlBLO+eSavapzOrI=;
 b=W5raVVAFG3uH/G6LN6F8cS0MOTDvyauQI2tujfTRv6zjTjiAx2LdWdLjVa1I+v8wV0
 film3L0YrhNq42+mwu7s/ddP+teljBQLWDZYP/IXu/2ir0T6UNpNbu9IxMyhBMPxpo1O
 0GZ7fSIaHWCMByLowsqYzXwwBgcDnbWE7yXorcIckdiHwPI04UvCh2bhsvphbDbWUEBf
 TwZHZu63hwQfIlAizKK9svaCLjhgT3ODhkEo+E28bZn0qbsKWNpMdejC/TQk0/qdXqwi
 BB3oU+XArzClJayeFMZ8/kQl8PUQQb4H5ja49QOodQjTO+QAUwu+F+9Pbk/PNa7E8C3B
 wcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907241; x=1713512041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pu90wwD72TTj1mq3bNLzC0zO16JxlBLO+eSavapzOrI=;
 b=FHsfcRuQQRI16qX517Vtaeq4zl2IocOwNkz1rq5zfclWDZONK80hg9WgqkohfhlZHn
 6viBrN5yNrb95oSIx/cVGtFYMjnwTGC1s+Q6DU3gL2o5ENu2c3983deraeBLPoTxDMss
 i0M6ymjedSMBfRaqU4BUq3fE/nVOvCwg4+4oHs31wiasX/BpquZZlRUBDg7sJbf22lIK
 J4LotCm4iPEIBNBSFNk3vsq6Ww0hR27q5a1NBjsEOo1Q4kbn37wjhoHfCYjfgGXPskeR
 0VnD5SAV4qg5NQnh0oMah8MkAJR6YT8ScygIpyrt8grB3PlKT8WvUbUa8xewT34UNgk/
 K5vQ==
X-Gm-Message-State: AOJu0YwY9Kddw25g44O5vyQS5JKEWay1XdDLUvW9+AzBPPk2aOR0SBHo
 9c36KusivELnIbveyNUDxdhATOr0kNjOBSR+KtLlMMSd1TeDp5wFylhY09gpqXW9QideZ+vD/Zm
 s
X-Google-Smtp-Source: AGHT+IFkaO+eeJ8lZa0FyCyIHwfm/5TwixIMefmfIzNbr/j83ITh8P/LkLQmdoGy2gF11Mz1qWfkNw==
X-Received: by 2002:a17:902:d481:b0:1e3:cfc5:589c with SMTP id
 c1-20020a170902d48100b001e3cfc5589cmr1958541plg.28.1712907241263; 
 Fri, 12 Apr 2024 00:34:01 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/27] disas/microblaze: Print registers directly with
 PRIreg
Date: Fri, 12 Apr 2024 00:33:36 -0700
Message-Id: <20240412073346.458116-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


