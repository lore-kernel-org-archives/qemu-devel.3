Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13959C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks9-0006Oa-Kc; Sun, 27 Sep 2026 05:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrO-0002AM-3c
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrM-0008GQ-5p
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:49 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1122815a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500067; x=1791104867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xs07YEujrADw1PNPU75lQ8ZkzdY4KDXERk49bKnQ1bA=;
 b=vVaS2WKQ/7PF+QWY0noHLopLzB6zXLQBj+I99Jfvv8oZgapSROYUn9sGNKEFZgGjKt
 qFmHej78VeYl8ALIUZjVu0agJACUZkQv/E69IcZlL9QEfMCMS2Oo5Qk+yzDroBiRLwoT
 HGcxogt2s6DgwS2DSCAc6zvvwPkBaawowOUcOII3XCkgaOsw21MQuMCFsDdQTeXHAYWN
 ab4RDkqe+5j/CSTna1ZvE6tlrOResnU66CsF9KMJdjoXsEqadka+GQPNrDU7gURqzFA9
 KsirP1OngmazcIe6zbQ611Fvr5fuC9gZY5Ky9Zz+Y/E8UKgSbdzTWFt9rSqgE6Lox374
 YxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500067; x=1791104867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xs07YEujrADw1PNPU75lQ8ZkzdY4KDXERk49bKnQ1bA=;
 b=VBTtc/Fg/bNlFCElfSS0a+GmTuPAdabkFGYZTU62uQGytYgx78bK4p61I5BD+TTMZi
 3Ek6VDC6CJ9vqqSx4SUo2A1h9Y+SoEl0TT0Ay4D3AVavzyPcAyu1eLdnMRa6ojazgeLS
 UZawAkoCCoWy2yBT+Nr06uyZt6EUIU7UP2K6aCY72Wpe4ccgiv0lJ9kM4fz+u9/VEibQ
 Hy2JhwYdW+eWCoD2PcTXX6pKM5nvIB0agrOwAr+eQ07stQiV5I9EFmFOI4VzYOFkCh+9
 itu8gU2KCte2bSNcbzOXoMwKOElqWx93kHMHQH028UegllyVJMHvx9zrit0YNTw907Pc
 UghA==
X-Gm-Message-State: AFq9FYKIkrNMXc7cnUs1YzmEt/lnHD6GMU9MP8gXKuXPrq7umYCCGKW+
 TLpVdKk9KNh4Alvj/ldc1r/GytMxJg6RfDMXTYXrKSVycCLOfbuWhuL28EY4N2Wzgpyye5ex3gy
 qn/K2
X-Gm-Gg: AYBFou3xOU0JlpeLUa9YJ7BCzvaU7CznvF+Qs0oT+/T9y/SRTWdgvEPUEjx922E07eQ
 VRuPnl3glwUvcgI0B/ew2uzMHvoFKdVZMQvlMZDWWRolpMIOYzDbmBk39bU+Zqfe/cuV5abuceZ
 DRFCzxJQxFbreUqVV9r4cbZ4b9bPPi2boymkslzfrDno/ZH4FZY9b4z2Pu3sKCLvtqYlBe+jVk1
 TRRnJ0G1FboY069s3lJ1/jpCetKZvC1epSSz+yW6eP9qAT3/rZmgSuvL8P8Rs3U3nYnrY7UgN1s
 lLnr++hg03xxuSHwU9YTxGLOe/VN+VzXZwxB0tE1rV4mdU1APph8bqPVSyDeHpxr3+f4piMT0aN
 2F2+/nIdriLGgpNz5GzqM8qzNR0jnlKUqrbZZqNbw2g/yfWJxIRLTV2dgVbt/u5SLC6MKJ2gXSz
 4jO70TNEZ2R1SQfHQHsIDQj5N1V2hV1goLRL+djSbUxZHYzjtuaaLJ+B4NkKOa9m2swqYgA5Osv
 ylejEzi0YIBDOAfwvWS1pjBCaRU1jA=
X-Received: by 2002:a17:90a:e7c4:b0:3a0:809b:1972 with SMTP id
 98e67ed59e1d1-3a098ce5e08mr9207497a91.26.1790500066702; 
 Sun, 27 Sep 2026 02:07:46 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 085/101] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Sun, 27 Sep 2026 01:59:55 -0700
Message-ID: <20260927090011.10724-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 tcg/tcg-internal.h           |   6 ++
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 120 ++++++++++-------------------------
 4 files changed, 41 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7971619ba92..d5915ecc1bb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,7 +157,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 09899cb3091..d6ea11d8fcd 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static inline void tcg_gen_op_tti(TCGOpcode opc, TCGType type,
+                                  TCGTemp *t0, TCGTemp *t1, TCGArg a2)
+{
+    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
+}
+
 static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
                                   TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b606aaab128..2ebcf4a0665 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(bswap16, TCGV, TCGV, unsigned)
 DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e593a4d8758..0bf7c2fdff1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -426,6 +426,40 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_bswap16(TCGType type, TCGTemp *dst, TCGTemp *src, unsigned flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
+        tcg_gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        int width = tcg_type_size(type) * 8;
+
+        if (flags & TCG_BSWAP_IZ) {                     /* t0 = ...a */
+            tcg_gen_shri(type, t0, src, 8);
+        } else {
+            tcg_gen_extract(type, t0, src, 8, 8);
+        }
+
+        if (flags & TCG_BSWAP_OS) {
+            tcg_gen_shli(type, t1, src, width - 8);     /* t1 = b... */
+            tcg_gen_sari(type, t1, t1, width - 16);     /* t1 = ssb. */
+        } else if (flags & TCG_BSWAP_OZ) {
+            tcg_gen_ext8u(type, t1, src);               /* t1 = ...b */
+            tcg_gen_shli(type, t1, t1, 8);              /* t1 = ..b. */
+        } else {
+            tcg_gen_shli(type, t1, src, 8);             /* t1 = xab. */
+        }
+
+        tcg_gen_or(type, dst, t0, t1);                  /* ret = ..ba (OZ) */
+                                                        /*     = ssba (OS) */
+                                                        /*     = xaba (0)  */
+    }
+}
+
 void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1297,49 +1331,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
- *
- * Byte pattern: xxab -> yyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-                                            /* arg = ..ab (IZ) xxab (!IZ) */
-        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = ...a (IZ) .xxa (!IZ) */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
-            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
-            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
-        } else {
-            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
-        }
-
-        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ) */
-                                            /*     = ssba (OS) */
-                                            /*     = xaba (no flag) */
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 /*
  * bswap32_i32: 32-bit byte swap on a 32-bit value.
  *
@@ -1498,49 +1489,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
-/*
- * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
- *
- * Byte pattern: xxxxxxxxab -> yyyyyyyyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-                                            /* arg = ......ab or xxxxxxab */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .......a or .xxxxxxa */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... */
-            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b */
-            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. */
-        } else {
-            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxab. */
-        }
-
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (OZ) */
-                                            /*       ssssssba (OS) */
-                                            /*       xxxxxaba (no flag) */
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 /*
  * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
  *
-- 
2.53.0


