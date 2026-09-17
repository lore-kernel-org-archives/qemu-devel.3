Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C62CC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ka-0003Ph-Ei; Thu, 17 Sep 2026 00:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0003EV-EO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:09 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k5-0006pj-NL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:06 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so308357a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619340; x=1790224140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EjC/hgEAHyg4QeR3ltbofy/cVH5NVRwoIGMREd1s2Ew=;
 b=tMJHMKjCgEv+6JUVn1hJnC+hWexvOZm6EK3JVkJlbqRGg1d+PyiOBzDGXfyNvndPrX
 CCO1DMYXuAP9ExMImgbub543YT4Q1r+arm1tkSiI4KkJpsDOjkPXjPadoIG/yYL8M7yj
 3RNDatAIpHt+BE2o4yQdBWGejWRqTBhFT6x+7KS5sbY+g/t9NNV2WUggYEe45Ysils8B
 wZSJrfIvS+BjZprciwKMV3hH9Hn2edoNxdqWg2iorGXsShtFYIVY9dxtohMZbYr9VhXO
 79h9rnZe5XZFK2NrI9zam3HB8AUTXN+xE5M6yRAHWavFeJZuDNxpxikngQGXwIrAa6RC
 K5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619340; x=1790224140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EjC/hgEAHyg4QeR3ltbofy/cVH5NVRwoIGMREd1s2Ew=;
 b=vHFULMw2FE4aEzotIpM0DXGpeZ8zOZDZXmOch7Wo2GElKcOByU2wT20smXmsQT76Fv
 ttK0xbstTQJLcL1+/bS5q66LO5TjvoV2KoR9d7oDp4Q3O+jyh4gDgxeK3mQWlcNdt0og
 xmDJNZJE9NmZiWFJbYkT3CjLbRK7KyJSbvGZ+vNj13SthsQOKuz7Qtbw42ku+/VaTzGk
 e69dp4vCJpYjj4kZ88Y0ESfzz6m6sNsQrADwGS4lT64jnenA6k6lgavoMPwcHsZRmr4L
 FQMfFDF06VOpc2PQ3jsK5x8R0qj51LCFvrLt1v16ZQaTblfwsdPgpk3DCtrJMV6kHBUZ
 /VVg==
X-Gm-Message-State: AFuF++lBTVvsv3xQb17pBPXdJUGhrkWWm7BcCvWtKX3mjib1gNxOIKXi
 2eAjfEvO3H9vy8+1JWhx6J1gFgnucS9OVwP9Iw5+dAuEeeEp85rJhVLBNGMe+RmfqminSlDNiAR
 IVnvWDJs=
X-Gm-Gg: AYBFou1os5hfY0EiyDuRoeguT/JFeuLgH5STUbZqZHg6umHsnnILl/zA8xFIu8R7SGN
 TB6Iq9ruj60GZKh5ZgKRzN9rWf4Aj2zX8ssP8jl4K8BECqkbRDGBENOB6wQSo7IdSxz+JrQ6z9W
 V3jbF997pRqbVKw7ciZRL9RAqXeP4PSLKZJvoUV2tyv3Q/CDpfE58i2/3WaRRBfcyRTUnVpUWdf
 q5dOKMNEXEg0/98/1EKZDWoRM0gKq3GFlSMyFPaBvm/d55bfbHTd9/BzrADq8ErwNnqOxbkXPhW
 cZI3B5JCfYkf624k17AU3PhPp1rLb6kYmH1jAQFDP738oVA1XvDP118pFMH7slpdekYRqiGVBel
 RM2px/U4PKo7443kdXTTRxUPPnbqxXBJtucipLNCewn9JBDpKJNPm5HaS0UOFWF2ZrVpFDiZQQd
 V9oHbQwM4UkAH2b1f0N8LpuFmWrP/2wh2dPNM/amMjcUWlW6nCmwA3Tq/ZDY/UHI08HTsiB93SF
 d/B1qw=
X-Received: by 2002:a17:90b:3e85:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-39e1e55f7ffmr11724461a91.24.1789619340293; 
 Wed, 16 Sep 2026 21:29:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 032/101] tcg: Generic expansion of tcg_gen_not_*
Date: Wed, 16 Sep 2026 18:27:14 -1000
Message-ID: <20260917042823.542588-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 25e8d27a54f..a8dffa7c5cb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -203,8 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -258,7 +256,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8e97c1b37d8..20007c90680 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index db47364ce78..9a2626e9669 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -484,6 +484,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -583,15 +593,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1843,15 +1844,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


