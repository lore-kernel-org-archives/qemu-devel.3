Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1052DCD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgmA-0007Fm-6X; Fri, 05 Apr 2024 06:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglR-0006Ak-0v
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:41 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglP-0004pO-CG
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:40 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-22eccfeee22so366406fac.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312738; x=1712917538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4IwNemI6HQ9b33EE9N7v7S1E8PqRebn39PS5dqy4+w=;
 b=CUN+1If8puxEiRtWUI3UESzwVOu6NvggSPDX0cGRxtN/4pYq+W9C8Bdgpw5fn+O+Vf
 v2V/GCf7hKJJQ4MRYkVMTrkmpnKNdSCgjDnht3xrF+nRnypG8dyE5Smsw9DnAdxieZ0i
 8F+BsaayO56sHN2hM9JwsLZa4OjlZ9k0MbldA7KkIi58PDALD+NnoR3NIN/5xOh/2jBC
 Obo5stbr8xq13QnAUQLp+kdr+ZEsFZbQVtE+Z3hOUG4KtJNXbXX21Irohj3UjxP52qb/
 ofFbzUhelEK4c4bkziU5zCl64KQtST+c2d3mb5YMuNG4EzyAdgv50PcupPIYmhM3mcPg
 YHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312738; x=1712917538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4IwNemI6HQ9b33EE9N7v7S1E8PqRebn39PS5dqy4+w=;
 b=rwwpw8Lc9dCcNZcUtCT+kdB4zsw3X9SkOyovEwHkl+pVhr57rWqPStd8VVKxSz88zO
 /GgXrTdoHyaTobpQgd+EvnojUOq0tpgYDzBDbhm3k8U55uyDCL6Oy0aUKL+kWQH8Oti+
 fPRsVfuXnLEQ8TX/tBpOIxXuIHWFKvKia42Ndl86VbobXSVyJBuAe58vj/DNzvAcSREN
 Ivp/wO6pgK9KByrTc0nrQkKADDi60NOWPmpUhdtVZiiIAv6+dKSvn12e0+wLLmyfVr2i
 nMuGCKDLRhd9yFghrmv7el2P002LDStgGSbsFS2JK9PgdUeFaXVt7Uak8SR6I/wC/x9h
 0zvg==
X-Gm-Message-State: AOJu0YxNGLkGeNhbnmW0YOya5I9Vn6UdBDnZHUtydjqfIbqnr+m//Bph
 aClQb1TcwGpI8t/FXuVxHTx0AGwiupn+jQFjFdK1vFgk3gsJqujFV6eFsW0siaA+mmp5aJQXHcA
 E
X-Google-Smtp-Source: AGHT+IGkWCRz3TtEv0zBQuzJvjRsQGC4J5flFwlV6CepGl19U8VBMBv+Rh4/BDP2j+bGivuiZK4KDQ==
X-Received: by 2002:a05:6870:9613:b0:22e:cfee:320c with SMTP id
 d19-20020a056870961300b0022ecfee320cmr1044638oaq.57.1712312738271; 
 Fri, 05 Apr 2024 03:25:38 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 28/32] target/cris: Use cris_fetch in translate_v10.c.inc
Date: Fri,  5 Apr 2024 00:24:55 -1000
Message-Id: <20240405102459.462551-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com> 
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


