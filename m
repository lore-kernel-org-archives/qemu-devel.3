Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC3CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhL7-00029m-Bk; Fri, 04 Jul 2025 10:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIM-0005JC-K8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIK-0005w2-Nv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:42 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eb6c422828so1284064fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638898; x=1752243698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNZtaHI5O3n0iljnyaa7aMe3WPZsbbr5by4hbzbNhjg=;
 b=HebmlD3DvB+PxKtezevm47UMMlrVzYsCHM8IiyqOQKYwWBwFcxXLS6USWgnshhiQwQ
 qP/RJlmRjD7eqF+UufmVc/JuzKeESe7d69047dGrETWDevVBzW4sL7qK0K4vf+Jb6zP8
 8od8jRo9xC4uCkURQ4YOVxkioXWqYdowpYLfFeAMWkflV8s05FkIZNGe7ZX4rTfbmG3F
 R27p3GdCBKas6+TOQoJX3BHfxo+ZK3Nqt6S2G0LwgOh3thD401m0aQj4swd8mxPQ4d7r
 FyCYJ4Lb5MyojFKbsMASvjlAw6V8dW1s/rf2uXkdjVyS6iJZTZaw6FOipg4owZz4LWDu
 bOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638898; x=1752243698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNZtaHI5O3n0iljnyaa7aMe3WPZsbbr5by4hbzbNhjg=;
 b=V1qxnTnB/ixo0Z+fVrT1QJAASk/PXG1ax6AkB7H07+7q+f6N58F5UEnAjF4Qr1MzJ5
 ArFc8BIuxmQB2YwcjIK2AmYMHwT/Aof+ZG+ykGMjtlw1uT5IY8KQszlONZ4mqthp8b52
 AG0vX3hEJxsVoUoAwDEswA+qzS95EdZgf0aAIrq8o26qp3cd53K4682u+s1IjmLoFRvD
 7fVNK+r+t8n5PG+ihqaYYB7I/mOCXIRnv6sdwZARaNAoHhrJ7WewWFoyiQl/tR0wfQ27
 5GOJoD9W+QadfjCnoGHk9W8oemjDG6pJ3QgbqDmi6Ot4rqTIDsMGCbDh/XLX0qdnmDth
 4/IA==
X-Gm-Message-State: AOJu0Yxtkib+9fy/cQ7/zXAuK6MuZTE4VuS1rUc3R7seci04z/+4YKwL
 /KfjomDoUiBBU6phzavYczzuNcYjsmTnLluwgCw359lgqHWXNYvCJsBrJ6QTjFy3/2xy1vNdpXU
 BBXW2sXg=
X-Gm-Gg: ASbGncsxiYSBxJXxoHKP1TQKGPxN3Ug6j41kzsPBvI99RkoX4719ftyyDDjsYwLFvYD
 drWIgNt9s3qLMbRRhSA6qn9ipIgM9F4ttSMhKPxm547N5pAboABWuapieUgHke6K2qs8/XaB3Oz
 T2UZtKP4J+tf8eMzzu7LG9HaktVS8S3Vh9BnSroszxE6zkZbL0OLm/NufkzvZ35ZrFZZXiVHMR4
 QLPpzhUiy+y8+9rJV05LMkKynjMMv56U0yepMgXEaJFIxIArJZyPBm473p/8LKSMYAlkS1h1xQM
 22wL1Dc4BjfGqV+77kREs8LM1+HffipW5WVAgS5jikwq1JqNANxJ+DHiCmUqpMOReDJRDx8uwL1
 4w4ZOjKXy3BvbxXEyfeQ6IhBqkb8Ht4Zg669EFBIahz7iBOkEDw8mwCGwv4A=
X-Google-Smtp-Source: AGHT+IGSPBGEjjQOexAr4bMXfSiBmvdwmL8clH+5CGkTkENBzy02upJqnEUqo0FN7kJfAc3fZiDU9A==
X-Received: by 2002:a05:6870:8885:b0:2b8:608d:5dd1 with SMTP id
 586e51a60fabf-2f7904b4ac5mr2889471fac.18.1751638898422; 
 Fri, 04 Jul 2025 07:21:38 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 022/108] target/arm: Rename MOVA for translate
Date: Fri,  4 Jul 2025 08:19:45 -0600
Message-ID: <20250704142112.1018902-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prepare for more kinds of MOVA from SME2 by renaming the
existing SME1 MOVA to indicate tile to/from vector.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 +++++-----
 target/arm/tcg/sme.decode      | 42 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e22ec393fd..2c8cb24b7c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -151,7 +151,7 @@ static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
     return true;
 }
 
-static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
+static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
         gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
@@ -173,9 +173,6 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     TCGv_i32 t_desc;
     int svl;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
-        return false;
-    }
     if (!sme_smza_enabled_check(s)) {
         return true;
     }
@@ -189,14 +186,14 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 
     if (a->v) {
         /* Vertical slice -- use sme mova helpers. */
-        if (a->to_vec) {
+        if (to_vec) {
             zc_fns[a->esz](t_zr, t_za, t_pg, t_desc);
         } else {
             cz_fns[a->esz](t_za, t_zr, t_pg, t_desc);
         }
     } else {
         /* Horizontal slice -- reuse sve sel helpers. */
-        if (a->to_vec) {
+        if (to_vec) {
             h_fns[a->esz](t_zr, t_za, t_zr, t_pg, t_desc);
         } else {
             h_fns[a->esz](t_za, t_zr, t_za, t_pg, t_desc);
@@ -205,6 +202,9 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
+TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index efe369e079..459b96805f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -27,29 +27,29 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 ### SME Move into/from Array
 
 %mova_rs        13:2 !function=plus_12
-&mova           esz rs pg zr za off v:bool to_vec:bool
+&mova_p         esz rs pg zr za off v:bool
 
-MOVA            11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
-                &mova to_vec=0 rs=%mova_rs esz=0 za=0
-MOVA            11000000 01 00000 0 v:1 .. pg:3 zr:5 0 za:1 off:3  \
-                &mova to_vec=0 rs=%mova_rs esz=1
-MOVA            11000000 10 00000 0 v:1 .. pg:3 zr:5 0 za:2 off:2  \
-                &mova to_vec=0 rs=%mova_rs esz=2
-MOVA            11000000 11 00000 0 v:1 .. pg:3 zr:5 0 za:3 off:1  \
-                &mova to_vec=0 rs=%mova_rs esz=3
-MOVA            11000000 11 00000 1 v:1 .. pg:3 zr:5 0 za:4  \
-                &mova to_vec=0 rs=%mova_rs esz=4 off=0
+MOVA_tz         11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
+                &mova_p rs=%mova_rs esz=0 za=0
+MOVA_tz         11000000 01 00000 0 v:1 .. pg:3 zr:5 0 za:1 off:3  \
+                &mova_p rs=%mova_rs esz=1
+MOVA_tz         11000000 10 00000 0 v:1 .. pg:3 zr:5 0 za:2 off:2  \
+                &mova_p rs=%mova_rs esz=2
+MOVA_tz         11000000 11 00000 0 v:1 .. pg:3 zr:5 0 za:3 off:1  \
+                &mova_p rs=%mova_rs esz=3
+MOVA_tz         11000000 11 00000 1 v:1 .. pg:3 zr:5 0 za:4  \
+                &mova_p rs=%mova_rs esz=4 off=0
 
-MOVA            11000000 00 00001 0 v:1 .. pg:3 0 off:4      zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=0 za=0
-MOVA            11000000 01 00001 0 v:1 .. pg:3 0 za:1 off:3 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=1
-MOVA            11000000 10 00001 0 v:1 .. pg:3 0 za:2 off:2 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=2
-MOVA            11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=3
-MOVA            11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=4 off=0
+MOVA_zt         11000000 00 00001 0 v:1 .. pg:3 0 off:4      zr:5  \
+                &mova_p rs=%mova_rs esz=0 za=0
+MOVA_zt         11000000 01 00001 0 v:1 .. pg:3 0 za:1 off:3 zr:5  \
+                &mova_p rs=%mova_rs esz=1
+MOVA_zt         11000000 10 00001 0 v:1 .. pg:3 0 za:2 off:2 zr:5  \
+                &mova_p rs=%mova_rs esz=2
+MOVA_zt         11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
+                &mova_p rs=%mova_rs esz=3
+MOVA_zt         11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
+                &mova_p rs=%mova_rs esz=4 off=0
 
 ### SME Move into/from ZT0
 
-- 
2.43.0


