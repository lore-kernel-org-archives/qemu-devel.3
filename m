Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5B7C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1m-0005IY-Pz; Sat, 12 Sep 2026 06:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1L-0004nT-1z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:43 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1I-0007Ga-IG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:42 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso390320a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209099; x=1789813899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/SFZuTeAPrA6auR79QdWvqOdZrR/3pSEhp41MoYX9B0=;
 b=EYL0OmhLeXB0ZcPscFYimH/y2x0b2fGObs7Vjr5Kw7AILWQXC7ngOO1dbAU81RThW5
 ZmwHpw2yOHEw/IFmU0sIHpor/Cmrbkw6VJzZophFT9JGiGiWOXw+SkEXuyKzVZy5yfOX
 DIuq8LOZRr7Vn8154H7QnH/e9vNICg9V7pA9hdJHuVwCbTgCM7zqsqUdueToNyf91i4n
 hw+ppJQNnEglx0SOIJqPbpE6sQU27rj+moNw0EHfa2HMr/RPxLA0SoXw7sC7RDEX8MQJ
 pEema4FuelFTDMkhfnQXmUeza3peHraFhR6wdQizSj4rOQCgsr+ap0sH7jRV21pkIGNS
 dVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209099; x=1789813899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/SFZuTeAPrA6auR79QdWvqOdZrR/3pSEhp41MoYX9B0=;
 b=etWdo6rh4s2g4W4566iSigWnp79LvxkNfS1qtqx81mztkn78eqkCvoxFcrU8a0xItB
 WcyI32taru2ZZzU+EWosPCKcvARIJW7l5SPkCkpIBXd5lgzek1hGwu/uu3BEtUt5ChnK
 iJWuxqgZaCLE3mO3jGRgWg6JixXceedOoB/Ko+0tmSZMpYSaa7YOW332k379XWdjWTmF
 hPOcNvn1BX2SX8CrLtg+xzz/GIuHHUVVSnmZpPIbgvRKSb+gx6ZpRrDTqLVnKu5Aftvg
 1auDeLBYvxSZUgBAQbN8BrZgBJsDUrQgM7lKG6PlIr9PBkOyTkgjOh41XIwm6yNbheSb
 AT1A==
X-Gm-Message-State: AFuF++lGcHMF5HlzXPRLwZZkYnrBliQItawWwYmm6Vpq3+piXakJc83I
 O3Ph9Z0b3C68utllQFj1IOr8fMZtnzD0YmI5ZqGcew8VfLQhJTw//sPlMfn4+RfnPrsojO4yQei
 GHh4W
X-Gm-Gg: AYBFou1nGmx5TJsPw4wumKBh2qRiH5QoWiRnNNDdzAF5P3nj3IObIMke1e+c79mW9ic
 IjfQiz8mn2JIUcaI617Fa64H7WDijt4TI4V8lbsRUWv4RvL7znSd0lnDUM8nuAwNEsEHWPrA05m
 nMDkAU9yxLw+F5aObCIaCZyOBkQVP/Q/eneA6gG6bZxcHVogoDI2Nkb11JYz72VqjqnJPQPHZpA
 2mG3laZhPn/P1/+gbTJAWTNlABL5IjpDgvJ8Tcyf17Hdu9A3NWxAoopeDA5gru2McZ8AB31qULQ
 k4sLr2ncWoCfXkpVUOTdjvnUEr22JE+CHVtIOymDQubP+R0hsmQdUPNUgKQL7SJyDMZFN1SNK5r
 zhQKtyHC03siIeAbSEtjcp7cyaKZjrzhXuwdSicbJENIC3EqFLM35heYYJ5E8tXpgdBUIPRHhRp
 8jR8yOYWKtgfhf8ZByoaF2z7pa+4dP+CdgaePjQiZTwTw0gsF5K9ME0x5cmkK5YNwKeaeorYXh7
 MWEFCgZaeqYMZvMBQ==
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39d9c3a1fc2mr15158432a91.24.1789209099223; 
 Sat, 12 Sep 2026 03:31:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/82] tcg: Generic expansion of tcg_gen_subfi_*
Date: Sat, 12 Sep 2026 00:30:15 -1000
Message-ID: <20260912103126.598030-12-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  6 ++++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 36 +++++++++++++++++------------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e6607f48592..35288a19a79 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -107,6 +107,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RRI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TINT c);
 
+#define DEF_RIR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b, TCGV c);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -114,10 +117,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_RRR
 #undef DEF_RI
 #undef DEF_RRI
+#undef DEF_RIR
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -216,7 +219,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 52b0ebd7ecd..a739c198a56 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -2,6 +2,7 @@
 
 DEF_R(discard)
 DEF_RI(movi)
+DEF_RIR(subfi)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 354fbe07fa7..5e971d8bf54 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -335,6 +335,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RRI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, int64_t);
 
+#define DEF_RIR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t, TCGTemp *);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -342,6 +345,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_RRR
 #undef DEF_RI
 #undef DEF_RRI
+#undef DEF_RIR
 
 /*
  * Generic expansions for templated operations.
@@ -395,6 +399,15 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
+static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
+{
+    if (src1 == 0) {
+        gen_neg(type, dst, src2);
+    } else {
+        gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
+    }
+}
+
 /*
  * Templated operations.
  */
@@ -419,6 +432,10 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TINT c)         \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b), c); }
 
+#define DEF_RIR(NAME)                                                   \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b, TCGV c)         \
+    { gen_##NAME(TYPE, TTMP(a), b, TTMP(c)); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -426,18 +443,10 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RRR
 #undef DEF_RI
 #undef DEF_RRI
+#undef DEF_RIR
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
-    } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
-    }
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1546,15 +1555,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


