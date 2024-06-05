Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58249C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExzB-0000ih-0E; Wed, 05 Jun 2024 17:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyz-0000eE-3Y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyo-0003Qn-08
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70249faa853so185248b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622133; x=1718226933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9TeIKJ5a0Abz4CX9bNs6c78/V1xEablimfS+HQJI64=;
 b=U/AtkR6LtL44ZIdz07E8rh5TmeJ3hn5PwwYE1yb0qSLMdm7Wj32NfZlMzLdCeOoCW5
 zc9AkRkHWgsj48dzn2pp0oV38thP/xwNVRYUYRzGHDjAp5ovUKDv/FjJlLzNsWAGCEec
 wWgMBgnll5Uy5cXlqDZhgrI0rQ2vWYSgwURaTy3r+McUMi338xpreXpq54kesc5/k1aC
 odO3S+jeuwkKOaIJNeO//cZy1JV1aaS1h1mOoZN0IZOXPlpMcteKt+2sKyd+kN7jFnG7
 9/zw7FUSAJsVhfFU453DDydb9SXKGbVt/dqkqlv8T1na2cu3zv6trETIyHo5gGccBfcb
 VNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622133; x=1718226933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9TeIKJ5a0Abz4CX9bNs6c78/V1xEablimfS+HQJI64=;
 b=ADHVFC+QvNvH4iBjdu+FgtPS0LsfKt8KsyPTpbP/TsRljDOQEK4dh1siMOzbqoPTqW
 BgqwAUdFCsL0LpQXXAnLgRiAapaMPbRPVed/6e8YaADOZAgKJZQOeSsDCnzAhsdF5TyD
 VpJSLYi8x6vH0acd86/tYAxzQwdUBd62tpjiW807dvppQNI13TxCUnRpNLyIvqThttxn
 7E8q+mmK4pmjrtyx2X9MvRSVLuHximXohV4UhGhgCO+oeUHTqbUO1+YLS2YEbZXQI7S4
 OEo1X7bGnNCnJ8xZPL6TVQlVF9SVP2ewSasEMz7QWD8o9/ni/CpNK7eX69rzjY69YaWR
 +qhQ==
X-Gm-Message-State: AOJu0YyiMPd2iJgN6RIa5KaXEYkKrxmm7bdIPZhF7bPFLDONOup1iz6u
 Zf4lOFEyos3wqJffR9s9q4MmYuHs86u3nbizSGJYkV+YOXWBZ1QopdGG5Ld2uAm203WetLzQUfD
 K
X-Google-Smtp-Source: AGHT+IFoKfT873pxdQc5pi0rigHKNufip3GH1Bl5sYl7eMIk/BKORpzUDhrPC4KUMghkP8rm3FFptQ==
X-Received: by 2002:a05:6a00:811:b0:702:2f19:659c with SMTP id
 d2e1a72fcca58-703e5a0cec7mr4603508b3a.31.1717622132575; 
 Wed, 05 Jun 2024 14:15:32 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/16] disas/microblaze: Merge op->name output into each fprintf
Date: Wed,  5 Jun 2024 14:15:16 -0700
Message-Id: <20240605211521.577094-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

In the common case, issue one single fprintf.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-17-richard.henderson@linaro.org>
---
 disas/microblaze.c | 80 +++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index c729c76585..a537ac65dd 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -830,54 +830,52 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         return 4;
     }
 
-    fprintf_func (stream, "%s", op->name);
-      
     switch (op->inst_type) {
     case INST_TYPE_RD_R1_R2:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_r2(inst));
         break;
     case INST_TYPE_RD_R1_IMM:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm(inst));
         if (get_int_field_r1(inst) == 0) {
             print_immval_addr(info, immfound, immval, inst, 0);
         }
         break;
     case INST_TYPE_RD_R1_IMM5:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm5(inst));
         break;
     case INST_TYPE_RD_RFSL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_R1_RFSL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_special(inst, op));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_special(inst, op));
         break;
     case INST_TYPE_SPECIAL_R1:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_special(inst, op), get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_special(inst, op), get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst));
         break;
     case INST_TYPE_R1_R2:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R1_IMM:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_imm(inst));
         /*
          * The non-pc relative instructions are returns,
          * which shouldn't have a label printed.
@@ -887,14 +885,15 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_IMM:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_imm(inst));
         print_immval_addr(info, immfound, immval, inst,
                           op->inst_offset_type == INST_PC_OFFSET
                           ? memaddr : 0);
         break;
     case INST_TYPE_IMM:
-        fprintf_func(stream, "\t%s", get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_imm(inst));
         if (op->instr != imm) {
             print_immval_addr(info, immfound, immval, inst,
                               op->inst_offset_type == INST_PC_OFFSET
@@ -902,37 +901,38 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R2:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R2:
-        fprintf_func(stream, "\t%s",
-                     get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_r2(inst));
         break;
     case INST_TYPE_R1:
-        fprintf_func(stream, "\t%s",
-                     get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1_SPECIAL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_RD_IMM15:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_imm15(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_imm15(inst));
         break;
         /* For tuqula instruction */
     case INST_TYPE_RD:
-        fprintf_func(stream, "\t%s",
-                     get_field_rd(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_rd(inst));
         break;
     case INST_TYPE_RFSL:
-        fprintf_func(stream, "\t%s",
-                     get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_rfsl(inst));
         break;
     default:
         /* if the disassembler lags the instruction set */
-        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
+        fprintf_func(stream, "%s\tundecoded operands, inst is 0x%04lx",
+                     op->name, inst);
         break;
     }
     return 4;
-- 
2.34.1


