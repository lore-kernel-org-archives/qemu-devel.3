Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57001C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz6-0000h3-Bf; Wed, 05 Jun 2024 17:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyy-0000eC-R0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyn-0003Qa-G0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7025b84c0daso205624b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622132; x=1718226932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwnaX3mRNj652UfeczAgAmblf4E/jxKIUVCTWxHM3qo=;
 b=S1vIL7JEAJTcZ/x3LOBCzySlqO0PRsoew0ttzlspGR7CA9pi0TAFN2XUrVTBPt18K/
 AaNLXVEM/U59jTgxacAibUiGtRCEY6tC7CR05xIQ8Kt/XNO4CLkGHeEo2u0RYFT3FuXX
 nP+IYifC9V/RKwsXCsADMigqPevfUqCrEOT9AvE6UksfX1mPf3NvrMy+VZLYgHW9OFzm
 GXRzucSQz7RWpI7GEH+8zHltTvSRMraOqTHBI84bde1a5a+gQxsGizohx/PhkQOoKedx
 VcYLnUVATrT68vOoaftU2sjeq7xQF6eSy0y9k4OEJUHFw82HadE4ivR+k6he0gV3nExR
 rbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622132; x=1718226932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwnaX3mRNj652UfeczAgAmblf4E/jxKIUVCTWxHM3qo=;
 b=GiukU+YTS7/Rin341XVWqsEVWRZRdhyU0qZJbR6RmbGdEewd/6RdM/hM94vRrAzzZq
 5z1XAeVrT5ylmbDf4JKpm45S2aXcW2l6tKQFr9Vndh69z6eIJtvYD9gUjPrWa48K30SL
 s5sxx919DaBL1v7bzDCYDP3LzvwpzO3Dj0mjUvSx6n9F2/+t+aYVRKTX3SAq3dk5SV8K
 lILi6BuyDPU3oYHGbD4O8qTVFIaep2TODU3l/Y67czXVkwHYPmqEquuvNSDvUZmVDfqk
 G0MnGRxxhZjokiVsAcf0x7KuQV5/yX5tpka2UgQXJtVOFUQGDLIytgO1CkQ/EzvjEfK8
 CtIw==
X-Gm-Message-State: AOJu0YxjA/tWuegpqKk+PZmdKt0g1GJ0hPAZvBTbNx+A/rmY0NYnaO6O
 lKvEX+wp0wpN3WT8ob39xXPxK6VdZyRdUR6UIH6L3NfyvOvryw8FcvqfQo4aUfaOAsHwpP5tMtJ
 m
X-Google-Smtp-Source: AGHT+IGtx2e/Z/dfCCCJ3hw1AMu7LIikjwXSKnwbL6Yxt8g/KfIdwl0dUlziY0hYEvgyCkgI1dFCig==
X-Received: by 2002:a05:6a21:3996:b0:1b2:ae30:95b5 with SMTP id
 adf61e73a8af0-1b2b7154eb3mr4608750637.56.1717622131620; 
 Wed, 05 Jun 2024 14:15:31 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/16] disas/microblaze: Re-indent print_insn_microblaze
Date: Wed,  5 Jun 2024 14:15:15 -0700
Message-Id: <20240605211521.577094-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-16-richard.henderson@linaro.org>
---
 disas/microblaze.c | 263 ++++++++++++++++++++++++---------------------
 1 file changed, 141 insertions(+), 122 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 3473c94164..c729c76585 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -787,134 +787,153 @@ static void print_immval_addr(struct disassemble_info *info, bool immfound,
 }
 
 int 
-print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
+print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
 {
-  fprintf_function    fprintf_func = info->fprintf_func;
-  void *              stream = info->stream;
-  unsigned long       inst, prev_inst;
-  const struct op_code_struct *op, *pop;
-  int                 immval = 0;
-  bfd_boolean         immfound = FALSE;
-  static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
-  static int     prev_insn_vma = -1;  /*init the prev insn vma */
-  int            curr_insn_vma = info->buffer_vma;
+    fprintf_function fprintf_func = info->fprintf_func;
+    void *stream = info->stream;
+    unsigned long inst, prev_inst;
+    const struct op_code_struct *op, *pop;
+    int immval = 0;
+    bool immfound = false;
+    static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
+    static int prev_insn_vma = -1;  /*init the prev insn vma */
+    int curr_insn_vma = info->buffer_vma;
 
-  info->bytes_per_chunk = 4;
+    info->bytes_per_chunk = 4;
 
-  inst = read_insn_microblaze (memaddr, info, &op);
-  if (inst == 0) {
-    return -1;
-  }
+    inst = read_insn_microblaze (memaddr, info, &op);
+    if (inst == 0) {
+        return -1;
+    }
   
-  if (prev_insn_vma == curr_insn_vma) {
-  if (memaddr-(info->bytes_per_chunk) == prev_insn_addr) {
-    prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
-    if (prev_inst == 0)
-      return -1;
-    if (pop->instr == imm) {
-      immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
-      immfound = TRUE;
+    if (prev_insn_vma == curr_insn_vma) {
+        if (memaddr - info->bytes_per_chunk == prev_insn_addr) {
+            prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
+            if (prev_inst == 0)
+                return -1;
+            if (pop->instr == imm) {
+                immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
+                immfound = TRUE;
+            }
+            else {
+                immval = 0;
+                immfound = FALSE;
+            }
+        }
     }
-    else {
-      immval = 0;
-      immfound = FALSE;
-    }
-  }
-  }
-  /* make curr insn as prev insn */
-  prev_insn_addr = memaddr;
-  prev_insn_vma = curr_insn_vma;
+    /* make curr insn as prev insn */
+    prev_insn_addr = memaddr;
+    prev_insn_vma = curr_insn_vma;
 
-  if (op->name == 0) {
-    fprintf_func (stream, ".short 0x%04lx", inst);
-  }
-  else
-    {
-      fprintf_func (stream, "%s", op->name);
+    if (op->name == 0) {
+        fprintf_func (stream, ".short 0x%04lx", inst);
+        return 4;
+    }
+
+    fprintf_func (stream, "%s", op->name);
       
-      switch (op->inst_type)
-	{
-  case INST_TYPE_RD_R1_R2:
-     fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_r2(inst));
-     break;
-        case INST_TYPE_RD_R1_IMM:
-	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
-	  if (get_int_field_r1(inst) == 0) {
-              print_immval_addr(info, immfound, immval, inst, 0);
-	  }
-	  break;
-	case INST_TYPE_RD_R1_IMM5:
-	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm5(inst));
-	  break;
-	case INST_TYPE_RD_RFSL:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_rfsl(inst));
-	  break;
-	case INST_TYPE_R1_RFSL:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_rfsl(inst));
-	  break;
-	case INST_TYPE_RD_SPECIAL:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_special(inst, op));
-	  break;
-	case INST_TYPE_SPECIAL_R1:
-	  fprintf_func(stream, "\t%s, %s", get_field_special(inst, op), get_field_r1(inst));
-	  break;
-	case INST_TYPE_RD_R1:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r1(inst));
-	  break;
-	case INST_TYPE_R1_R2:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_r2(inst));
-	  break;
-	case INST_TYPE_R1_IMM:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
-	  /* The non-pc relative instructions are returns, which shouldn't 
-	     have a label printed */
-	  if (op->inst_offset_type == INST_PC_OFFSET) {
-              print_immval_addr(info, immfound, immval, inst, memaddr);
-	  }
-	  break;
-        case INST_TYPE_RD_IMM:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
-          print_immval_addr(info, immfound, immval, inst,
-                            op->inst_offset_type == INST_PC_OFFSET
-                            ? memaddr : 0);
-	  break;
-        case INST_TYPE_IMM:
-	  fprintf_func(stream, "\t%s", get_field_imm(inst));
-	  if (op->instr != imm) {
-              print_immval_addr(info, immfound, immval, inst,
-                                op->inst_offset_type == INST_PC_OFFSET
-                                ? memaddr : 0);
-	  }
-	  break;
-        case INST_TYPE_RD_R2:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
-	  break;
-  case INST_TYPE_R2:
-     fprintf_func(stream, "\t%s", get_field_r2(inst));
-     break;
-  case INST_TYPE_R1:
-     fprintf_func(stream, "\t%s", get_field_r1(inst));
-     break;
-  case INST_TYPE_RD_R1_SPECIAL:
-     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
-     break;
-  case INST_TYPE_RD_IMM15:
-     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm15(inst));
-     break;
-     /* For tuqula instruction */
-  case INST_TYPE_RD:
-     fprintf_func(stream, "\t%s", get_field_rd(inst));
-     break;
-  case INST_TYPE_RFSL:
-     fprintf_func(stream, "\t%s", get_field_rfsl(inst));
-     break;
-  default:
-	  /* if the disassembler lags the instruction set */
-	  fprintf_func (stream, "\tundecoded operands, inst is 0x%04lx", inst);
-	  break;
-	}
+    switch (op->inst_type) {
+    case INST_TYPE_RD_R1_R2:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_r2(inst));
+        break;
+    case INST_TYPE_RD_R1_IMM:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_imm(inst));
+        if (get_int_field_r1(inst) == 0) {
+            print_immval_addr(info, immfound, immval, inst, 0);
+        }
+        break;
+    case INST_TYPE_RD_R1_IMM5:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_imm5(inst));
+        break;
+    case INST_TYPE_RD_RFSL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_rfsl(inst));
+        break;
+    case INST_TYPE_R1_RFSL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_rfsl(inst));
+        break;
+    case INST_TYPE_RD_SPECIAL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_special(inst, op));
+        break;
+    case INST_TYPE_SPECIAL_R1:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_special(inst, op), get_field_r1(inst));
+        break;
+    case INST_TYPE_RD_R1:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r1(inst));
+        break;
+    case INST_TYPE_R1_R2:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_R1_IMM:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_imm(inst));
+        /*
+         * The non-pc relative instructions are returns,
+         * which shouldn't have a label printed.
+         */
+        if (op->inst_offset_type == INST_PC_OFFSET) {
+            print_immval_addr(info, immfound, immval, inst, memaddr);
+        }
+        break;
+    case INST_TYPE_RD_IMM:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_imm(inst));
+        print_immval_addr(info, immfound, immval, inst,
+                          op->inst_offset_type == INST_PC_OFFSET
+                          ? memaddr : 0);
+        break;
+    case INST_TYPE_IMM:
+        fprintf_func(stream, "\t%s", get_field_imm(inst));
+        if (op->instr != imm) {
+            print_immval_addr(info, immfound, immval, inst,
+                              op->inst_offset_type == INST_PC_OFFSET
+                              ? memaddr : 0);
+        }
+        break;
+    case INST_TYPE_RD_R2:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_R2:
+        fprintf_func(stream, "\t%s",
+                     get_field_r2(inst));
+        break;
+    case INST_TYPE_R1:
+        fprintf_func(stream, "\t%s",
+                     get_field_r1(inst));
+        break;
+    case INST_TYPE_RD_R1_SPECIAL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_RD_IMM15:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_imm15(inst));
+        break;
+        /* For tuqula instruction */
+    case INST_TYPE_RD:
+        fprintf_func(stream, "\t%s",
+                     get_field_rd(inst));
+        break;
+    case INST_TYPE_RFSL:
+        fprintf_func(stream, "\t%s",
+                     get_field_rfsl(inst));
+        break;
+    default:
+        /* if the disassembler lags the instruction set */
+        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
+        break;
     }
-  
-  /* Say how many bytes we consumed? */
-  return 4;
+    return 4;
 }
-- 
2.34.1


