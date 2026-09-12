Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4AC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L4x-0008TY-3l; Sat, 12 Sep 2026 06:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4p-00083X-EJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4k-00087f-4F
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8558c0b26a8so1320121b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209311; x=1789814111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ssxBxFFyxI004t8G7Dvnez7uUFPErstqKq+QmQwdfYA=;
 b=oDiBP9OQxZxPdMpkycwwAEaKoCR7nsGfikHljK3TNPhJHmR0BC5g8dGTgz0FYgOZPI
 VEL2e5lxbVDTmU1WXNQ/yBQ6khbzu7FTUBgUcaZNYU7SRMcBARRL4P4VSeeRbhZ6At2m
 ry/62WVAiYrkm962cxYS390mbkds33CWWenJzqk0UDZ9uTOrfH0EhOsfgUugT66mguzz
 WuLWUrU4VOm15EE0Cpg79V5VhnkjhUWwwX+lLs3QUtsxQQ14w2redfBlpdpHWlNQC5Vq
 +2JLdErFo3654Z5fH/3tKrbzOSTlm0fBiPpAdyikd0C+THyhnOyTMNUdJXn8qNbXY1Sg
 aM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209311; x=1789814111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ssxBxFFyxI004t8G7Dvnez7uUFPErstqKq+QmQwdfYA=;
 b=GlA51nxPD6z9LgZfwpaaZ7DnKWaspMmLhitLI8gEmn90wvA//ishIv4IdGAeaChGH4
 VgLMigypzxTP11sSWyR26AnPwR8BjFlTDI3a9KvWWAKKgdn8qHaKhmUuqQia9sT7OOA5
 T6GttBWlEcihgz8VvPpEopPfXmAVsUqYC8T7wh7Ug3M5KwjflCPcrUBo1kgJJ98MJnVn
 NwyGKInwCDflPmTlVosucjftHg2KTA+EZRNmaODxffTG3SjCXPVVYl5zUWB5ifhqn/73
 nn6GRrb7q1S8EK4rnPuflxhWH5ceEpLGOwRtZ2cF8Na0RY4NOD/xdlzMnkreaDO4+4aj
 77Sw==
X-Gm-Message-State: AFuF++nJQ9Hh1dG8aKFha1vDE8VrBatwxoTJOeTa35eO8maXjyjkPaX7
 HjbFFDeKdhdDMbGmaASPgE83EBgRzTbfiOkQj72ZL9u2SUxynP27gpwW/mvIOD9L+yNSbXZKIi4
 UmP8hu7M=
X-Gm-Gg: AYBFou1/iqeMLgmJP6ji47Bkb6BT8+8WTB0K08ZXsRi2ugc81gXviCueeRl84JM+gL5
 xy3TIfsmBwWBADCvj/unIEQIyk9Z3rE1a2CfKEv3Y6aIIoz82tervjcqkkT162+QrdcTFqTmEIq
 kJRDrwDvZklry+A8o/3kSIFQ4fH1LybIzIMnVkSf8wkXMkNGucR96uyA/lSUbvuApGIwuEQ8oYY
 GjOefWKASYA6tmtU2tBdSUx8jyUi7JIgriZF4RaoEsuHvUiCKmw/8XkYBP3iDV/2FM7gh0TukKD
 4bPF84OKkr9QajouiL3HJR9tKO0vM+0cvIGv/E2ayHy/uuviPSmRJDV1bBav8ibGWJpiFmc3mRt
 L8rkJzTYCpgg4YFxenWh3Xy562QZk6NWr2WRu8vEnItYT7hw0CQe+oZbyrpxLSZ0BL7QLVu/PGP
 jDcVwYZVtSdExHued1nS7WGTXXxwAJp9iiRR/ATF8yOt/C33MFc8jCm1qJPEFTT+Xub0gNMqURi
 sT+Y1I=
X-Received: by 2002:a05:6a21:113:b0:3da:7140:da35 with SMTP id
 adf61e73a8af0-3daed331022mr14859165637.15.1789209310710; 
 Sat, 12 Sep 2026 03:35:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/82] tcg: Generic expansion of tcg_gen_movcond_*
Date: Sat, 12 Sep 2026 00:30:47 -1000
Message-ID: <20260912103126.598030-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
---
 include/tcg/tcg-op-common.h   |  9 +++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 71 +++++++++++++++--------------------
 3 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4223229c78b..04fe772c1e0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -122,6 +122,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_CRRI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TINT d);
 
+#define DEF_CRRRRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, \
+                                        TCGV d, TCGV e, TCGV f);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -134,6 +138,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_CRIL
 #undef DEF_CRRR
 #undef DEF_CRRI
+#undef DEF_CRRRRR
 
 /* 32 bit ops */
 
@@ -157,8 +162,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -220,8 +223,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index bc27e1b2af6..cbaaba72ffa 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -6,6 +6,7 @@ DEF_CRRI(setcondi)
 DEF_CRRL(brcond)
 DEF_CRRR(negsetcond)
 DEF_CRRR(setcond)
+DEF_CRRRRR(movcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 14139fa5784..6145a171665 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,14 @@ static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                        temp_arg(t3), temp_arg(t4));
 }
 
+static TCGOp *gen_op_ttttti(TCGOpcode opc, TCGType type,
+                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                            TCGTemp *t3, TCGTemp *t4, TCGArg a5)
+{
+    return tcg_gen_op6(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                       temp_arg(t3), temp_arg(t4), a5);
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -256,22 +264,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGv_i32 a4,
-                                 TCGv_i32 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
-}
-
-static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGv_i64 a4,
-                                 TCGv_i64 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -356,6 +348,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_CRRI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, int64_t);
 
+#define DEF_CRRRRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, \
+                                TCGTemp *, TCGTemp *, TCGTemp *);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -368,6 +364,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRIL
 #undef DEF_CRRR
 #undef DEF_CRRI
+#undef DEF_CRRRRR
 
 /*
  * Generic expansions for templated operations.
@@ -507,6 +504,18 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_movcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *c1, TCGTemp *c2, TCGTemp *v1, TCGTemp *v2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_mov(type, dst, v1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_mov(type, dst, v2);
+    } else {
+        gen_op_ttttti(INDEX_op_movcond, type, dst, c1, c2, v1, v2, cond);
+    }
+}
+
 static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
@@ -793,6 +802,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TINT d) \
     { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), d); }
 
+#define DEF_CRRRRR(NAME)                                                \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c,      \
+                                        TCGV d, TCGV e, TCGV f)         \
+    { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), TTMP(d), TTMP(e), TTMP(f)); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -805,6 +819,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_CRIL
 #undef DEF_CRRR
 #undef DEF_CRRI
+#undef DEF_CRRRRR
 
 /* 32 bit ops */
 
@@ -1117,18 +1132,6 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     }
 }
 
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i32(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i32(ret, v2);
-    } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -2042,18 +2045,6 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     }
 }
 
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i64(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i64(ret, v2);
-    } else {
-        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


