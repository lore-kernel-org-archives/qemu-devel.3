Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971ECC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz4-0000gL-E1; Wed, 05 Jun 2024 17:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyw-0000dR-Km
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyn-0003QR-Fq
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7023b6d810bso199779b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622131; x=1718226931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfrVlKNrjZVUEIrdKdz8B/16XtB8Z0PZL9Z34MyohBI=;
 b=ZK9PEeoEBRpJE7mfuhPf8hFW9pu7yjCaOPwE6xukRk/8YzMsnIURWg2SQ25KTmCSLm
 YgGI2GEcUh9eCINe98uAq7ygAXheTGwwXe8Z4Q2Y9qHKSCnyPzKLEX1YQTlBPIIvb8Y+
 52cdqRIRCOg4hZ7FNP6R6aQUqMXrC3/bBPS8dIm70NNXtcZy4dBPXyUf4N6zSx2gggT0
 uhI4r/moV05BzofMd2QKdxxdtcERXZqQoriPgraZpnqFWVkG7Bbb/5nStFSHaU2wichf
 gDsIlQZgi5puiIust6iP/kUf3xNp4VSqXyEv0kdZOYl6d6iqHyYyzOJibhFel58xByg0
 blzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622131; x=1718226931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfrVlKNrjZVUEIrdKdz8B/16XtB8Z0PZL9Z34MyohBI=;
 b=PcQ3aVcIPgm1OQMp7b/xcjKCiodjslc4stHbd0nrOZ/FZFQhcjorn3Rbo5g2BVQ7v4
 uqOFBsriZAv6h46zG7IjvtDKXdCSEEIeYIMrOdVqtZiL6/KBYzfD9B+20F1CKGWsm3U9
 4arzBGFnfMciBO9vZPp8HN0sGnbeI1Pp6fW9EuP6s6mmWLM6WqacPgGgifEqQaIVgEGd
 fALu6ZzNVh64A+pzy7AdTUCCVi+Xb7I81bXHKT/IUC32bWTcDFAPUyBntPcbLvrZ2hWX
 m9C6kTLlndELKTu97Dg7brAU6JduAHA/6mWpWUbTRuAY820R8IxHm2JdTRCxHD/vm5Fp
 zCtw==
X-Gm-Message-State: AOJu0YxuoCXyGkJrt+Xa1wbP6KD87ydLV9G+0g4I9tZvPBnPkzZhEAQe
 vcXG1mmdg7kMU3ZvM4BjTNkTcpX8J3MhED5J4S5r72hE5liSSVCHyRq7G4uk5K+RRhQRqGCXzGI
 6
X-Google-Smtp-Source: AGHT+IGAMPLv1AQ8+LSrgYOANzyCMYwp4KhN2e14fARvhZdLnkUWQYM7xNb50oYbdwlkVnEGXL7EwA==
X-Received: by 2002:a05:6a20:1590:b0:1af:d153:b76a with SMTP id
 adf61e73a8af0-1b2b6f68b99mr4849695637.18.1717622130797; 
 Wed, 05 Jun 2024 14:15:30 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/16] disas/microblaze: Split out print_immval_addr
Date: Wed,  5 Jun 2024 14:15:14 -0700
Message-Id: <20240605211521.577094-10-richard.henderson@linaro.org>
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

Unify the code blocks that try to print a symbolic address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-15-richard.henderson@linaro.org>
---
 disas/microblaze.c | 89 +++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 49a4c0fd40..3473c94164 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -767,6 +767,24 @@ read_insn_microblaze (bfd_vma memaddr,
   return inst;
 }
 
+static void print_immval_addr(struct disassemble_info *info, bool immfound,
+                              int immval, unsigned inst, int addend)
+{
+    if (info->print_address_func && info->symbol_at_address_func) {
+        if (immfound) {
+            immval |= get_int_field_imm(inst) & 0x0000ffff;
+        } else {
+            immval = (int16_t)get_int_field_imm(inst);
+        }
+        immval += addend;
+        if (immval != 0 && info->symbol_at_address_func(immval, info)) {
+            info->fprintf_func(info->stream, "\t// ");
+            info->print_address_func (immval, info);
+        } else if (addend) {
+            info->fprintf_func(info->stream, "\t// %x", immval);
+        }
+    }
+}
 
 int 
 print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
@@ -821,18 +839,8 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
      break;
         case INST_TYPE_RD_R1_IMM:
 	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
-	  if (info->print_address_func && get_int_field_r1(inst) == 0 && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    }
+	  if (get_int_field_r1(inst) == 0) {
+              print_immval_addr(info, immfound, immval, inst, 0);
 	  }
 	  break;
 	case INST_TYPE_RD_R1_IMM5:
@@ -860,61 +868,22 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
 	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
 	  /* The non-pc relative instructions are returns, which shouldn't 
 	     have a label printed */
-	  if (info->print_address_func && op->inst_offset_type == INST_PC_OFFSET && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    immval += memaddr;
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } else {
-	      fprintf_func (stream, "\t\t// ");
-	      fprintf_func (stream, "%x", immval);
-	    }
+	  if (op->inst_offset_type == INST_PC_OFFSET) {
+              print_immval_addr(info, immfound, immval, inst, memaddr);
 	  }
 	  break;
         case INST_TYPE_RD_IMM:
 	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
-	  if (info->print_address_func && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (op->inst_offset_type == INST_PC_OFFSET)
-	      immval += (int) memaddr;
-	    if (info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } 
-	  }
+          print_immval_addr(info, immfound, immval, inst,
+                            op->inst_offset_type == INST_PC_OFFSET
+                            ? memaddr : 0);
 	  break;
         case INST_TYPE_IMM:
 	  fprintf_func(stream, "\t%s", get_field_imm(inst));
-	  if (info->print_address_func && info->symbol_at_address_func && op->instr != imm) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (op->inst_offset_type == INST_PC_OFFSET)
-	      immval += (int) memaddr;
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } else if (op->inst_offset_type == INST_PC_OFFSET) {
-	      fprintf_func (stream, "\t\t// ");
-	      fprintf_func (stream, "%x", immval);
-	    }
+	  if (op->instr != imm) {
+              print_immval_addr(info, immfound, immval, inst,
+                                op->inst_offset_type == INST_PC_OFFSET
+                                ? memaddr : 0);
 	  }
 	  break;
         case INST_TYPE_RD_R2:
-- 
2.34.1


