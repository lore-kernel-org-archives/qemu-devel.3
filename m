Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ECFC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm65-0006Do-FR; Wed, 24 Apr 2024 19:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5o-0005zw-SN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:00 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5m-0003p8-UM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:00 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2a68a2b3747so337908a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001517; x=1714606317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eL11UZGpeVEq4VOMmX63mOyK3p1fvPoFDCh9Izq0OCE=;
 b=TahMWrxZTdmUjekvsySttKQZaEzULFih/zlDcN8HZhnKEM9WxKzdACMP9vqDqivFsq
 dfh920Kg0D/GBF/KsxRkFdsdiJk72kpMc9slN3N5Z4SJDrVBSQFmhki9dNDQxV+wly3O
 xPd/Tiy08sqo86wevDG15U9xQoNTCefcER4Ziuqb2WxEYabjG6UUtLBEqpcAH/fS69U8
 ByJP3lGMC+hVSim6o7k9DWxRBZbWqHaQ7zAEu59dFuCI5Gl64TSk1YNMvcDjWyh5yE5v
 wP6LywdxA0yzOYs9kdbU1PV8/1sh1O9S61kYBZYixT0HdaoFWp6j+P/AxV5qHYKqGr+Y
 IM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001517; x=1714606317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eL11UZGpeVEq4VOMmX63mOyK3p1fvPoFDCh9Izq0OCE=;
 b=mQEE6gt2KUe+aajAYwsUcTs0GowMHpu71JCrQbQmO1lK8qvf5FHcVEzhs3x1FyNqqG
 bPo3gkzYoD9VqZqIVvZwORtdB+C9//ejmWdBKPYl+FpBIYcmAiEh2TVJT9nSR6pPZInw
 qSPaCO/dIY/JjKcU0qzIWhfJ8Gy8eRljtU8VNyqGsiceIsrKdrcV9DjaWwwwh6ZtSteX
 E8dtZKiql5GjAOYVdltkEmYQOFRoD2L19XOQ2mpwlvTtKcY2RRdhi07lXniMiUFhLCnD
 rcrvcwNMwHVAEr/5v6C3p5FqP6Ce/CStrsT0JQlPI0ZeYtRV2Duc1nDFt3PLfzbNQ45+
 nYug==
X-Gm-Message-State: AOJu0Yy7BCMj330dSZiDE03vtdejBXxsJetjUdXQPjAeaiM1ygd8m7Pk
 UsR+5B7yhv9aCPWMpvn+2BGuBNKXdhszpzNDYpmdJ/Yw0clDOz10hrhRSp9heUHfutmQO9/VTS7
 /
X-Google-Smtp-Source: AGHT+IEOFRG1W/b9cs0KgFSe3VFbqLgFM6nYWfsPIZFIuBpOC3fnByUkUysZWhWNvVo+PT+XDPvQaA==
X-Received: by 2002:a17:90a:778b:b0:2ac:91d9:9fd5 with SMTP id
 v11-20020a17090a778b00b002ac91d99fd5mr3592005pjk.47.1714001517575; 
 Wed, 24 Apr 2024 16:31:57 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 28/33] target/cris: Use cris_fetch in translate_v10.c.inc
Date: Wed, 24 Apr 2024 16:31:26 -0700
Message-Id: <20240424233131.988727-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c         |  1 -
 target/cris/translate_v10.c.inc | 30 +++++++++---------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index bb2d6612ba..a30c67eb07 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -29,7 +29,6 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "mmu.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "crisv32-decode.h"
 #include "qemu/qemu-print.h"
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 73fc27c15d..c15ff47505 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -165,20 +165,7 @@ static int dec10_prep_move_m(CPUCRISState *env, DisasContext *dc,
 
     /* Load [$rs] onto T1.  */
     if (is_imm) {
-        if (memsize != 4) {
-            if (s_ext) {
-                if (memsize == 1)
-                    imm = cpu_ldsb_code(env, dc->pc + 2);
-                else
-                    imm = cpu_ldsw_code(env, dc->pc + 2);
-            } else {
-                if (memsize == 1)
-                    imm = cpu_ldub_code(env, dc->pc + 2);
-                else
-                    imm = cpu_lduw_code(env, dc->pc + 2);
-            }
-        } else
-            imm = cpu_ldl_code(env, dc->pc + 2);
+        imm = cris_fetch(env, dc, dc->pc + 2, memsize, s_ext);
 
         tcg_gen_movi_tl(dst, imm);
 
@@ -929,10 +916,11 @@ static int dec10_dip(CPUCRISState *env, DisasContext *dc)
     LOG_DIS("dip pc=%x opcode=%d r%d r%d\n",
               dc->pc, dc->opcode, dc->src, dc->dst);
     if (dc->src == 15) {
-        imm = cpu_ldl_code(env, dc->pc + 2);
+        imm = cris_fetch(env, dc, dc->pc + 2, 4, 0);
         tcg_gen_movi_tl(cpu_PR[PR_PREFIX], imm);
-        if (dc->postinc)
+        if (dc->postinc) {
             insn_len += 4;
+        }
         tcg_gen_addi_tl(cpu_R[15], cpu_R[15], insn_len - 2);
     } else {
         gen_load(dc, cpu_PR[PR_PREFIX], cpu_R[dc->src], 4, 0);
@@ -1095,10 +1083,10 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
             if (dc->src == 15) {
                 LOG_DIS("jump.%d %d r%d r%d direct\n", size,
                          dc->opcode, dc->src, dc->dst);
-                imm = cpu_ldl_code(env, dc->pc + 2);
-                if (dc->mode == CRISV10_MODE_AUTOINC)
+                imm = cris_fetch(env, dc, dc->pc + 2, size, 0);
+                if (dc->mode == CRISV10_MODE_AUTOINC) {
                     insn_len += size;
-
+                }
                 c = tcg_constant_tl(dc->pc + insn_len);
                 t_gen_mov_preg_TN(dc, dc->dst, c);
                 dc->jmp_pc = imm;
@@ -1164,7 +1152,7 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
         case CRISV10_IND_BCC_M:
 
             cris_cc_mask(dc, 0);
-            simm = cpu_ldsw_code(env, dc->pc + 2);
+            simm = cris_fetch(env, dc, dc->pc + 2, 2, 1);
             simm += 4;
 
             LOG_DIS("bcc_m: b%s %x\n", cc_name(dc->cond), dc->pc + simm);
@@ -1185,7 +1173,7 @@ static unsigned int crisv10_decoder(CPUCRISState *env, DisasContext *dc)
     unsigned int insn_len = 2;
 
     /* Load a halfword onto the instruction register.  */
-    dc->ir = cpu_lduw_code(env, dc->pc);
+    dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
 
     /* Now decode it.  */
     dc->opcode   = EXTRACT_FIELD(dc->ir, 6, 9);
-- 
2.34.1


