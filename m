Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D892C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79SH-0005EV-Be; Wed, 15 May 2024 03:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79S9-0004zk-02
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0001dX-3N
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso48855545e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759587; x=1716364387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eL11UZGpeVEq4VOMmX63mOyK3p1fvPoFDCh9Izq0OCE=;
 b=YqW1ne0wbfEmTAQ6YGipyOh40h3jYChNGgRhu+GhMQRvEpTVQDW2mxy/8hxYmmZNKf
 11ysBKHCwSLo3rkiuEN1/gh8jhOZSlCUM+OLtbck4Fpasoi2d+OqQlLwUPB2PPmyU6fK
 1jWrr8G5WtIuyWiZ3GvaLZq+e1BUOnfyOIF8+dAlqgOTLgBrYFRn4D4KUM7HSu3I1t1t
 p7isAXYXhtU2rpULsw1hhoi5bRWZQnjkN01OUwKOeiMifqZZqM/xSuQk44kXpH7DlfI6
 aW1KDhpnbDNVtf560UXXl+ivVuNLOIXaf1Tw1i1I9i86MgdN220dlSvGR7ZCgUCiLTk6
 AATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759587; x=1716364387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eL11UZGpeVEq4VOMmX63mOyK3p1fvPoFDCh9Izq0OCE=;
 b=D02rpOmMD86Pp6pnvmlil87dWm/9tNVFRFeSAYwbDArYdx/8R1VSVcOVBUiahQnQG6
 N6zoOVdhNx5+3b+JiKC/a3gL0uFd/UVfzgr2atH/8rIjbx2F30vHi98LILBbOVfq3TLP
 SZhooZYwLK9yMrtagByO8glmPnaJBAIID8e3QYJoQPaClc2oWKzRwZ/U5V6HHN6gb0UO
 D/NXGePrI6b4gFZXI+foHRarwFxKcJs0ScVsgkorpJE/2t1IEsV7kg4MlBph/aNV1bo5
 7gRlKZqkDI1qW2WAucUaomFCA0DuIX9bfqJ0UaPTidtt6tvH6K3gieof4ig55hfnagth
 L1rQ==
X-Gm-Message-State: AOJu0Yzh8QEPJNxrli1+F+J7OyDXWwQvKiKZAZwK3GKRdVqL2vznRAMJ
 tniluRRKtP1gNkW+XJ7MJXHp23mwsmk1Pvk6i3Ic990u/pAc1+StYTpj88fvj5EPJWwmRAnaaeg
 3abI=
X-Google-Smtp-Source: AGHT+IFWfjLXa9LYDR5qQr8r+P6kEXiByx6F3yXEGMlFhXPunmGheVa47iBiiQ8Xmr+FcQDvAyd7yA==
X-Received: by 2002:a7b:cbc2:0:b0:41a:225f:becc with SMTP id
 5b1f17b1804b1-41feaa44406mr139063775e9.21.1715759587325; 
 Wed, 15 May 2024 00:53:07 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/34] target/cris: Use cris_fetch in translate_v10.c.inc
Date: Wed, 15 May 2024 09:52:41 +0200
Message-Id: <20240515075247.68024-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


