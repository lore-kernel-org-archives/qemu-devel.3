Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776ADC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQn-0007EE-Me; Wed, 16 Sep 2026 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQk-0006pZ-3Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:06 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQh-000208-Bq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:05 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a368895so575033b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564322; x=1790169122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zCW/5ygdur6frMsyP2rNUp49dE4PnOK3SbCeRUfDNzs=;
 b=ePOjtt7ZUjhWsWo5oAEoFuNGJGuOG6r2GEWUyA70/RKURM7n5fo+sONgJ1yKGrZyso
 qnMvE2EoFFbmI4R2TkVXT2z1Inkl4AGj5xaHMODGwZa9Ao9X8+MPAjPX07JHGGWAR1xu
 kM4Zm5kY7UNvFCaeiy+s4BvycdL9bjenLOEZ1jHN2D7FSI6qn56cL+UJcMYLZr5fMm2J
 Z1TC6pzAEBZUrSmPKd8DCz7Zom1SmBVEZQ1NxuMEV6Sw6GRk2fZzR/0kpZh/I4NsFcne
 ManmNK9ytY/1x+gE8gZOsE93wdW+fLo1ymVaizm17SQnw6vn752eF4TlOqsdLhPrt3Xk
 Wncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564322; x=1790169122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zCW/5ygdur6frMsyP2rNUp49dE4PnOK3SbCeRUfDNzs=;
 b=cLejFt9ZCPkFCn+IrE9ZNlIddOM6Py6mltoLFbPW59EVZ8iVrcwEDHK5uQoaTvoAEL
 ZNQm8xx0sAjC9nmnZ6/8p0s8LGrDk4XreGKsxppPaLQNCbm0C0i04h1sEl0As3IxhZSc
 WmAsJVVL83aR7UYDMIkyN2mx+9d9h+S6oFWV6yK2ZjOQ/rPcyltz1OP346V+s8JjAOzl
 YxTQE/qB4aDpYMXJeksxOAUgq9Rx1rd/LLKm4L3gkEyv9qxPye5DLA2ZORUi13EXGTXl
 MmggFUQITVhQlToRCRSy9MaA4JLRooRumZrILhQK+Jju36bo86ktEdJDax8stD0NZtic
 DOIA==
X-Gm-Message-State: AFuF++nKW/RcUvFBTQbvCLpV0XNV7UR0PwnbQFya3Q3ejjI0fUnt4XaT
 81LzoQ2yfnbgpDeKAgin1fdenx67za3IXCS0UeEC6k9JYNvVeiJRuYWOQaiuQ5yYFJZzgcA2VDf
 2u1QmnZo=
X-Gm-Gg: AYBFou3201u/QIoTmaBXmuwwTiMvpGsqK3f9YnI4mFPbwMKl4CeMrkPWfRfIk8WTBBj
 ByEc0T4Lzw8m8oIjcFphBPL6fejDRoNx0LzQqdV7U5AKABc0oQFi6jaBs5WgLnk/XzckQZaSmPh
 E51N0Hh588nSjLAzJIWzIKumRoZWnlvTL7sWUdhi4i+YPPrix5LrtxbakOD6QWz5SsxI3Ag5JQS
 7rmk5ISsmklIxXXpS/Hj/0eX9vCtUyJ2gRjcqMct4NCwc6O4Hn+/3qFAyJf9UFP3H4Ogar3V6xr
 utOBMl/yw8ufDyU+qu+MM+skikQSBpgNSSzO32wnAqtNIsVLk8n2DO3yD/7MRiborsL89rTjQNu
 CS8IL6j60wfnZ61BtXcWx5aoWKXga4Q3gFVHQ8xXT94ga69Js14alHxelnkA3fIXJPcC6YL+Uin
 lgKjoYkjhlvYquv6/GwumvFN3SFLQVME0aDPcnPjhr9pItJK2nmfwi/qLsosVtztaeUYl7Iy2lv
 bNs8qU=
X-Received: by 2002:a05:6820:4b91:b0:6c0:2513:3ea3 with SMTP id
 006d021491bc7-6c7d21e1150mr2359001eaf.26.1789564321965; 
 Wed, 16 Sep 2026 06:12:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 86/92] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Wed, 16 Sep 2026 03:04:01 -1000
Message-ID: <20260916130409.3382710-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
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
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 129 ++++++++++++-----------------------
 3 files changed, 44 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9d83d70a798..56bc8ce4ace 100644
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
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5e169258ea3..28cfa68db3e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(bswap16, TCGV, TCGV, unsigned)
 DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bc61a4ee3f8..45e158973d7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -109,6 +109,12 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static TCGOp *gen_op_tti(TCGOpcode opc, TCGType type,
+                         TCGTemp *t0, TCGTemp *t1, TCGArg a2)
+{
+    return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
+}
+
 static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
 {
@@ -525,6 +531,43 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_bswap16(TCGType type, TCGTemp *dst,
+                        TCGTemp *src, unsigned flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
+        gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        if (flags & TCG_BSWAP_IZ) {             /* t0 = ...a */
+            gen_shri(type, t0, src, 8);
+        } else {
+            gen_extract(type, t0, src, 8, 8);
+        }
+
+        if (flags & TCG_BSWAP_OS) {
+            gen_shli(type, t1, src, width - 8); /* t1 = b... */
+            gen_sari(type, t1, t1, width - 16); /* t1 = ssb. */
+        } else if (flags & TCG_BSWAP_OZ) {
+            gen_ext8u(type, t1, src);           /* t1 = ...b */
+            gen_shli(type, t1, t1, 8);          /* t1 = ..b. */
+        } else {
+            gen_shli(type, t1, src, 8);         /* t1 = xab. */
+        }
+
+        gen_or(type, dst, t0, t1);          /* ret = ..ba (OZ) */
+                                            /*     = ssba (OS) */
+                                            /*     = xaba (no flag) */
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1446,49 +1489,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
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
@@ -1647,49 +1647,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
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


