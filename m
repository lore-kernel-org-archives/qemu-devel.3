Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CC1C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5I-00026j-OQ; Sat, 12 Sep 2026 06:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L53-0000Ws-Vp
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L51-0008QD-G1
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso13723185ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209330; x=1789814130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yn7R7w3Tj0CaaudcdY/pBR/VH6O1LVkvIKXD5S3MhaY=;
 b=WPPkFXEs3vnbvmAHeYsar+vNEhSPQjwM4DF3Pf4PJR4BMHtXWmavHSRZmdjzxhmI7A
 RLYa/KC7ibqT6zNvQ8rZ361wFyBV9nMiT/2bKfYZK0YDtcOiWjwUKwWBU/gxAzKpx4nY
 f1a2jAKw+G2C0FnUSp2WcDFIM97GZgElGf1YWjh3UzudS8sjU31Ixth+APn+RFy/bFK6
 zs0ohUnqYE7pjwEa3dF/Y3lYhX/lGRNnVQ7zpGLIptM5pJTMEqvFHSj11TZTzTmsRko0
 evj2seDT/vYyy+CLy8pkH4pQPCdpAZ/ZyQ5BEyONNHZCTHPXY4WgAM7k2KGFEYTRb66X
 xAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209330; x=1789814130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yn7R7w3Tj0CaaudcdY/pBR/VH6O1LVkvIKXD5S3MhaY=;
 b=kYM38Dr039nvilSfWQoaK3jcLlm/hzHEmI5aBiSby1i0T82qXJe2SAM2OUOCz/QaSz
 eCk69L5zJJpjrgMbvGQrKFegZZJ7R843hV8u90FyjJA9PnyOfapWaQfQks+3lACADpHz
 /ouSE7EZ428CMNUu9l9qlJWMagKZHGEsbMF+xldCOWWYwqJq0wiAyK7H4inguVTGZ3yx
 9Anpa9x81nezkDcvVyT9/JF+YIKOWvqWiH5aayaERuKPVIsECu7GxYEVXF2bMoinqrPf
 Jtof6Ivj3O7DcEoIbuFo56L2Yzz5MMOQGYcFz5PDZ/dCwcGunYmny3JOXHgsIgGRBRot
 /L4Q==
X-Gm-Message-State: AFuF++lP2AfzNp2gVDRmsabtHMKSBNlWK7BHMTIdzPEynUWXyi1jXICp
 nNUz1nsyJi8fHQ5p2YdDbAg5ZvKJJQ/XhQtYcO+A31WIVeQSjGJ8V7uH6nOWUPbLAQ/LJBv4tEe
 6Zzi8pD4=
X-Gm-Gg: AYBFou1KCAQIkEJKkbMZpWSXzFPhroC0wx/YuPmmUNFcDzPJ7NUnxYS+fBE6Qsjp2dK
 2BvgQm6zRE379TPNEZyVfhfNlCIRz+C0q6ZggER2JAsJ0jmtUr9kw/uPivof2TbitjzwkzQVgwa
 FVRBh37FvHr+mnQhbEpc4kM8JuseBFem38uHsPgyYkDh6aSNmTNQu0vaPQjaTV3/IiMypsvIHcG
 0BZ44A05SIuWCjh2WHEJQzKjswjICi9eeSyHzCvmCh279YbwO46XZTiRsSmsgv1zr1DGuKsEq8P
 nAVnZgXQl5cC3ayDUx3M9zWiUNCkSvrsKGkqWcLAyccjEDc2dZq5DZngL8oZBJ9SIYXTRPlZPP6
 gsq7hxXAHg/aEma3BczM8PwkirxKFDA9eX6oHSJv/QOyglW3BPhq2ukwOCetEWbcz/GkzyIY4aD
 9Uz+BZP7By3+HSPmBmNfROpt3V9vh9OTVx7qQJudNE3F93Svb9WPgfHP5bZiO3fV9KNt4ksXw0E
 iqHgNc=
X-Received: by 2002:a17:903:8c5:b0:2da:eb8f:b4e4 with SMTP id
 d9443c01a7336-2dd2a1dd9e4mr133774025ad.7.1789209329907; 
 Sat, 12 Sep 2026 03:35:29 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 63/82] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Sat, 12 Sep 2026 00:31:07 -1000
Message-ID: <20260912103126.598030-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bd98d2bec41..1851577860e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -162,7 +162,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -206,7 +205,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 15d20872088..9174fd3db63 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -12,6 +12,7 @@ DEF_RI(movi)
 DEF_RIR(subfi)
 DEF_RR(clrsb)
 DEF_RR(ctpop)
+DEF_RR(ext8s)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RR(not)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b19244e6de4..756492548df 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -648,6 +648,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_sextract(type, dst, src, 0, 8);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1314,11 +1319,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1620,11 +1620,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0


