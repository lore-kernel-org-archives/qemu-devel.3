Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBBFC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rV-0004Ua-QC; Thu, 17 Sep 2026 00:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qs-0003Xg-Mv
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:03 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qq-0007wF-GW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:02 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc433d52421so218564a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619759; x=1790224559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mycOAsqCVqiTtK5zjSU3Ne/ALHamd86f7BML4GNCBvs=;
 b=ZajRf8Mg69zW/VZpb4maRXkwY/s+agq19N1Zt73JYkekN12k9nrlLzCWo1OPHJwJr5
 Xji+h/DfZVOkY0w7HrgBpAyOAmHocTFFc5QCIhtmZ+C4f4bQJ94XYl5x8nVWgHMifRPl
 rJa7Vsm3+uBk2yCRfeObWXzL2JvmqDohoIHFgEToHNvxo0ryJ3z10Gog4GRA32/qnsZj
 F8G3yqwiI1tdGi2/0+rMFdgBpHLxBbe1iGcyDH+iD1fhC/W9qYNVXtD2hLw4kAl0/o5s
 SzWgnZ8Oz2AVNXlzJXceyiOoeTafW+HzB/Sd2eBA2PdI3lZ3BnA8ENcTei1tMIjDQ1hC
 aqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619759; x=1790224559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mycOAsqCVqiTtK5zjSU3Ne/ALHamd86f7BML4GNCBvs=;
 b=pkWaKo0EtwvawF38CxwOP9FtLM8Zjmg3PNO4N41SPxFfHwfhms4H94fo7tm0ba9iZZ
 UDMTjLCflXGCc3T4zZdZkADV8x0UGf80VdgwIgHCKOMoR/D/S1+endJb1Do6ipajiiB8
 hhr8ate2H0UdWRkR4jjv1m40KM9gUjururKLxXh7jz6pNUUXCtvZ6wsgZXBMJXUiE+Tg
 qK4QOkz2J0vsnfKRCbDVXlOldG3fifqj71ebnD+2lrx8Mti3sPOLLRT5BlWFM7iU0ZSn
 h4D1ujfP5HIYni6tG6pC73NRcIzHgUMebuRl2N64XWnOwlCglfhUDXKgbDwYf7x93xz6
 flyQ==
X-Gm-Message-State: AFuF++nGukmVLD1PHKNsmDVPa3CA0Vi1TesywEYTvU9wd+FMKiWGqa01
 iejmbcfP75LpJ0tQSK/NWjTU+EgELm+eZi+JEQxzcnLXIqPRmuOge57a9Ie+qLF4vXJOIll1TsQ
 8dt80os4=
X-Gm-Gg: AYBFou0oAGqnj4GvgqLAEdmVNRIslKvHmsiTfWTNOMFHZVXgvzd/z/7NKDGdWxx/pjf
 z+fWnFU4vwk1HmVj05X8CS7zUfhVloUw/15W1gRCGvEPJD8sgAvyDct9p1SH7y2Bk9sOzEBqgQE
 Nn/NiAMtMVaCTXEdfoqFnUuj5ByFDmOl4KS73n3r2ZkUY0cKBkB8J3fxZ8pu7vrPLBYTTQf409d
 tyNM4k8zlCAVo8eOyA/jj/Mu+rlJEkXut8pdouJk+5qbcgYwlpK/mCVRPDRK49USlx8vuiU1SUD
 3kADa0YCu5lKFoLozvN1+BdCYcf5+t9mmbUaauEz9Y+0TihuCFSjJ8H1Cz8IOmYzWEI+1KvBLQO
 VJDHBrpVL7GD4lTX2tJeFXx5dDfk4EieA8OA/PsaWG0/rYl6v+EtOMxiS7/mADCdiFyym29OaUY
 e7NsD7gXztA7KkcD57Xqpq0CKAH6yJA3syMdo+1ueZsCzeLkGo+Rv7hX13+BtCknRhIVgqaIlIV
 pz4y4A7KX/t4aLpeA==
X-Received: by 2002:a17:90b:2f4f:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-39e1e3024fdmr12574079a91.9.1789619759007; 
 Wed, 16 Sep 2026 21:35:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 088/101] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Wed, 16 Sep 2026 18:28:10 -1000
Message-ID: <20260917042823.542588-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 tcg/tcg-op.c                 | 127 +++++++++++------------------------
 3 files changed, 42 insertions(+), 88 deletions(-)

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
index fcdee7be963..418750776a5 100644
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
@@ -517,6 +523,41 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
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
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
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
+    }
+}
+
 static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1407,49 +1448,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
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
@@ -1608,49 +1606,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
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


