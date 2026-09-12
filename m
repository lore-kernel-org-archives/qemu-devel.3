Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFD8C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5O-0002c4-77; Sat, 12 Sep 2026 06:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L57-0000n1-53
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:37 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L55-0008S7-E9
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:36 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso392092a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209334; x=1789814134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dReCs6a/7zx4llAzY52vfCEC3/VaC4cw11nYAiX5JUw=;
 b=XgE4+STy7k1CMjVSJtNdLyUX3ucZggFCg3cfUCRQyII2+bgHGu9taj0bSKLoKCw3r0
 TKOaJ+ckNVGl5Vlh1/vhLJgh3Lsd0Glcim0uwD/xnp7Qew5WoF2+HPvX+Kenl+Kx+1jN
 XpJRpXZhphroL9yfj/TxT40LM12+eV3mSdxBNcqtZA1egaBbZrNpNSCwMgRkdSKVKWG6
 f5pq0z0v4tC6P5PyBA/r2wp96881jMSqnEzSc4bJXo9KhT8+2XtmI+j79QRtn5/f2UYV
 jqc8a/TINQMqXo1l4i599cSFoHz4tdAl9A7iPKv+H3d9wuCDgXCiYqQ3cUy8+GpeI5T2
 V9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209334; x=1789814134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dReCs6a/7zx4llAzY52vfCEC3/VaC4cw11nYAiX5JUw=;
 b=WGV94gP8be9TrRNNQGy9Wj3eQDX4SiAj22M29pLJVK593r9t+oOiL25VuGH11n2DU6
 fSPOmUDkJnkmItf9OGlxcwiEdS+JWe6otpklI5iAG3fN2NT9RfZKrI0ufUZWmV7uh3Yo
 YWq7+jTSw/6ayYS1eGHIwLneMMkYNPefEl9yxXw+tP8FfJKzUwAaXYut42/g/LhNbZKe
 Kmu9n60K+hgCn7ILeJ8gygTwo8bnwS3Sg2upUL8/4HfijHyegktwDUTM3B7k/N0Z73qa
 HPFddIh7Fv3uLyxii4nws9PEKyxqvr3cyYvYp9FesTXQSEDyg22Nra3wCP6czCsoAUjV
 0RfA==
X-Gm-Message-State: AFuF++nfcHiZTbPtX5Gm/5XZ12M7JGZmKoIYErsyuU8Ucn0EkWo05hzp
 c4bPTVIc8nK0QEm3S3zNqlaCKrEujOW//0bx4jYBe22xez/dFgGPqT+kmAkhu3EpRxjBUFJ6CIE
 E/oTBsHs=
X-Gm-Gg: AYBFou1ByLTy4fvOg+WL3jpKx07rQDJtkYMwGBNlCkHFgk92dyFcgIWpoLFl0mrxzo8
 XPdMjkqkLZUAZ13UeZ1MqRb7r9NZNXwJfR1qt5pZ+IooeUMUd+z8V6qtzR44CNABgM4V6PgWCh/
 nYNDwngUZgVWszNW6CbBnqMLnqdKm1qMvkYy4S7DjblmwK8XngzHBKd0GYNIKdmCsNz8iJOeKAE
 QhTviWqeodZvJgyJOmg01LQQ71+d59+wvLVkQgbcxIExHPuTty8EH/BxZWokw/RqjB8fwu5C7v8
 99nrQRJQCTwqEu2v6YN+eFJ3uN95bdY4dNGa98q8lmF8O5KhQ2G699G0FRyZCFMhyBCwv6KQgG+
 3vf/DJ29/gu1Mh7rDO+4o/pNCOLLiofVI704nZXsDdFBgCOO1Ocb2YCBJxOBu7qndLCcxwTjb2P
 YTB3AdlwwMYlqClS6q7L5DasuLKfRboZYQ8yWnICQoZ0E39h4JOHY/V2jJImWXK+DIV8wP807NT
 OTGu00=
X-Received: by 2002:a17:90b:4fc5:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39d9c227639mr15361419a91.18.1789209333870; 
 Sat, 12 Sep 2026 03:35:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/82] tcg: Generic expansion of tcg_gen_ext_*
Date: Sat, 12 Sep 2026 00:31:11 -1000
Message-ID: <20260912103126.598030-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

Move from tcg-op-ldst.c and compute the width of the
extract instead of using a switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 54 -----------------------------------------------
 tcg/tcg-op.c      | 21 ++++++++++++++++++
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..031c5ce926b 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -760,60 +760,6 @@ void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i32(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i32(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i32(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i32(ret, val);
-        break;
-    case MO_UL:
-    case MO_SL:
-        tcg_gen_mov_i32(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i64(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i64(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i64(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i64(ret, val);
-        break;
-    case MO_SL:
-        tcg_gen_ext32s_i64(ret, val);
-        break;
-    case MO_UL:
-        tcg_gen_ext32u_i64(ret, val);
-        break;
-    case MO_UQ:
-    case MO_SQ:
-        tcg_gen_mov_i64(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 typedef void (*gen_atomic_cx_i32)(TCGv_i32, TCGv_env, TCGv_i64,
                                   TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void (*gen_atomic_cx_i64)(TCGv_i64, TCGv_env, TCGv_i64,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f0ab8e643d8..5c6e3a75224 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1186,6 +1186,17 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RRUU
 #undef DEF_RRRUU
 
+static void gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
+{
+    unsigned width = memop_size(mop) * 8;
+
+    if (mop & MO_SIGN) {
+        gen_sextract(type, dst, src, 0, width);
+    } else {
+        gen_extract(type, dst, src, 0, width);
+    }
+}
+
 /* 32 bit ops */
 
 /*
@@ -1207,6 +1218,16 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     }
 }
 
+void tcg_gen_ext_i32(TCGv_i32 dst, TCGv_i32 src, MemOp mop)
+{
+    gen_ext(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mop);
+}
+
+void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
+{
+    gen_ext(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mop);
+}
+
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-- 
2.53.0


