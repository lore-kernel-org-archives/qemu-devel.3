Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F24C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5E-0001WU-1m; Sat, 12 Sep 2026 06:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L52-0000Tk-UN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:33 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4y-0008PU-Jb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:32 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so585282a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209327; x=1789814127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zEfXwy2yvC5ex/Yq7PmgQwT81kyrdLrcqCUkVwnf4RA=;
 b=fhCY953qR2MEaDFRlTsa5GLe/sbrnfLN+UITwyvMXrhUin+PA4KP7Ls1A6j6K1nRCV
 ha3vgSKNwVRYc/3/x7gYOd6jMYUu7S0rmpDvjmOUdtJAenaIYGwX4FuTIJWYyTf3cCLq
 ZpV2YKV1VSqaubbelhGEYV4J8k9mZWMkCsLnkmnEUwaK2VFop9iojkA/O9m+fW7R+e1g
 DDkcCukITF6pEeE3QYg1PGDPklOPaActvu+aLMBxVomq4OCN3g6ZOHWhcO8chlD/f+1T
 dgoNaBbmxf2+pEvYKNLxtli/d5xJWnkFoFiOgHaeP4JKQT5UmZfWpO6g7HBL+d0RBGMx
 ul6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209327; x=1789814127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zEfXwy2yvC5ex/Yq7PmgQwT81kyrdLrcqCUkVwnf4RA=;
 b=hERQFG9ZCnkdZWShAztOzm0746Nbs9ll3ATEgD/39teDSq/f5xpuLF5S+kTw8odA/V
 jV7vPv7sarE3hnLmfoRTrjNIH4zRUMmXC9FmFjATgcI2v0e9l8HDpxEnJ6yWMpTEMub1
 NsN9etKWsO3Q2MNtib9DEaoNqy75ytgZAqSUTk69NLgV+nkNje8nLqUvTwhwKbslrW2A
 coXOYIiqN6m46YQ9O8ISYDEdd2g5qUHyXqTbuP3/ey1RrQFhmzXeEWUDcdKFkvR309n5
 R+7R8B3p+3LFp9v3+nJTfPUHPH6hWxMWd+bVpqN6HGbCCV+OPykokT/5AQkpOEsMZWTr
 5xug==
X-Gm-Message-State: AFuF++mEcEoHF9rb17kGB009s7Qi8BMb/Kv8LzVoUndaey3NAgjNfacj
 ZZ2jZxdD+QhmD+9/IuJB+gs7yIV71qAvKEICETUEJk1isG/eCM5wyM4b8pB8XFp135ff1hPUCQ2
 YQpffIZw=
X-Gm-Gg: AYBFou3CRedL33Ul/vn5hP9LB0gl7C89cSLmMUBxPxiJsYajisgQTBjDY8swyMOG+FY
 bNvwH2jl6Dt8KJQviw+5BYKJAb36Aqq6Qxw0jYO/ulW5889kkf/LjlGTFea14AvOdOUWbCUOsFC
 k887DX/Usl+aF3eYixigTdOrhb7G8+AAGONmhfi4wJmAEmWHx0acxklW3kMc1Qvs9HfkfYEAzEH
 SSCbzl18J8V7KVGtPVw2YhKGiRkgF+4xlR57BZ2p5AY4gsbCMdkhLQNr0iDkMpV4ijA+zGzY30W
 ZsxGFWPYk22tWtSm/j0cNMk1h9oCoSAJBa8rzbGE4JkHrWosdt08Y7mp5pcnOsGrK6xpco6xDoI
 gsg4hi8GppVGNSoY37iHJ/Wbr7nBa6BcN1PWMpH315qCcL8CDCv0gD/cebapTaRdYISSwwG64hm
 ZWs/i0UnCA0aroALy8Mq+5eW3DLEyFijyzl+Qn0sjEi+eoMtQXAcZ89hZTvntTlkoPPwncledzl
 2P9QPw=
X-Received: by 2002:a17:90b:28d0:b0:398:9bd4:d18 with SMTP id
 98e67ed59e1d1-39d9c3f2ba7mr15791409a91.23.1789209327084; 
 Sat, 12 Sep 2026 03:35:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/82] tcg: Generic expansion of tcg_gen_extract_*
Date: Sat, 12 Sep 2026 00:31:04 -1000
Message-ID: <20260912103126.598030-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |   8 +-
 include/tcg/tcg-op-def2.h.inc |   1 +
 tcg/tcg-op.c                  | 141 +++++++++++++---------------------
 3 files changed, 60 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eae8bbd129d..0a37a8edb60 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,6 +126,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, \
                                         TCGV d, TCGV e, TCGV f);
 
+#define DEF_RRUU(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, unsigned c, unsigned d);
+
 #define DEF_RRRUU(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, \
                                         unsigned d, unsigned e);
@@ -143,14 +146,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRUU
 #undef DEF_RRRUU
 
 /* 32 bit ops */
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
@@ -198,8 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 415d10b9fe9..24db95e294d 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -51,3 +51,4 @@ DEF_RRR(shr)
 DEF_RRR(sub)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
+DEF_RRUU(extract)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 61700f0d620..d196c36fc4f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -360,6 +360,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, \
                                 TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_RRUU(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
+                                unsigned, unsigned);
+
 #define DEF_RRRUU(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *, \
                                 unsigned, unsigned);
@@ -377,6 +381,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRUU
 #undef DEF_RRRUU
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
@@ -651,6 +656,50 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                        unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+    uint64_t mask;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_shri(type, dst, src, width - len);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (ofs == 0) {
+        gen_andi(type, dst, src, mask);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        gen_shri(type, dst, dst, ofs);
+        return;
+    }
+
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        gen_shri(type, dst, src, ofs);
+        gen_andi(type, dst, dst, mask);
+    } else {
+        gen_shli(type, dst, src, width - len - ofs);
+        gen_shri(type, dst, dst, width - len);
+    }
+}
+
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
@@ -1062,6 +1111,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                         TCGV d, TCGV e, TCGV f)         \
     { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), TTMP(d), TTMP(e), TTMP(f)); }
 
+#define DEF_RRUU(NAME)                                                  \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b,             \
+                                            unsigned c, unsigned d)     \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), c, d); }
+
 #define DEF_RRRUU(NAME)                                                 \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
                                             unsigned d, unsigned e)     \
@@ -1080,6 +1134,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRUU
 #undef DEF_RRRUU
 
 /* 32 bit ops */
@@ -1102,49 +1157,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint32_t mask;
-
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_shri_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i32(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-        tcg_gen_shri_i32(ret, ret, 32 - len);
-    }
-}
-
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len)
 {
@@ -1849,49 +1861,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint64_t mask;
-
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_shri_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i64(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-        tcg_gen_shri_i64(ret, ret, 64 - len);
-    }
-}
-
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


