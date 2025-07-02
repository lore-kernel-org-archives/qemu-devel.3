Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCABC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfn-0007Zl-FJ; Wed, 02 Jul 2025 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfi-0007Xd-WB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:43 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfV-0000yH-QV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:42 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73afbe1494fso2505813a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459668; x=1752064468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNZtaHI5O3n0iljnyaa7aMe3WPZsbbr5by4hbzbNhjg=;
 b=szkdBUr1EMox6nU4xlpNQAx5wZ5yDTcOgpkknSMzDkQXShm5+xXBzGQSKGY68l/Ooj
 M+yl8Ped0NnDO4zeds+K1F/KNXyzToqQnattMm4k7Wssnn+Aq5xNB66KjVHFbMD9K74r
 zQISkC5UK7VWbEaNCJm5oRLtLk64MpQCxFs6ilcRNznSAO6IAy7GNfa8TkNlx9iB9C6R
 xqbWDl3WLDuKenRLnhC/UQaz4GWxVSuQE/LYdHVcjbHKumBM16+ONRckaRAzuCZN9HQx
 5YgGVgQrkjzFZynAQW5Mx+doXXXg90o+8pF+WRMOI8Px4ROgHmwQKp71lZQ+Lff/ppKc
 AJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459668; x=1752064468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNZtaHI5O3n0iljnyaa7aMe3WPZsbbr5by4hbzbNhjg=;
 b=Jx8DSmFrYOKli1n0B2hhyPDh953clrvl4Xq5AQIsC6ztkN1AKQhJFlD5E6+UFl3Yqy
 PWpr+iUk0n8iJ76BX0JaA9adltL1ADO0naVPasMm1ON2qb+7IZFPahzXWcRg7X4DoxH8
 pW1Y0ZkiS3migRBdZiTfyXCyHhKk2cLElts+ozxXZMA5DK1j40nIUA+spLSZXf1qZNKU
 GYNjkeClUy8PkszV7ShzYZ/PpiIvwCMoF91GRsR+Mzi4krlf0+qu9V5BRcFtOfnxG5oC
 755b9ZqknQW+YBNw4CB45PpuccMBSTHzUhEm75HcK+LL0UZ6j+6FcdOu7MpJEr7f3GFs
 no4w==
X-Gm-Message-State: AOJu0YzJAQkTcje9+2DWdJSUqq+sfzLhbr41MhH4WB4t4+xm7o+/+tfR
 6nLQL51aowRFEPt7OZS+8t86ihpUp7Nho6pxtd8fonvnWqj/w0MgGnqqMLPvIqZW869hHUItyOW
 JhlrOxFQ=
X-Gm-Gg: ASbGncu35Nfyzyp1Xr2aAQ4QTRkgD9OwuzgQAxmniUOvCvdtiR45m7TYz22nanVRRnx
 8nrNP5RG8OzhSsZ1dnbds5R/gIWjuh1sAv4UXu/yZJU0+DO2hEvQQ9ext0fQrk1sZFJi6BR8QgL
 IL8TzvCgIHgI/zWT8Rk6n4bE9i7+caYiqH1z2Z9FITUUco6+QwfvXb1Sj+YQFD4vwJSQU/6kF+E
 LMoYOR3/yhQEo/c+bndgIp+RCRiOggTWIQlBwUqnE3N/K7gvGYF8miTmSob4Xf61kUIVY1LR7OW
 12PwwV34XZF/f2/CFLTL6HK+hAMonhSfdhhfTu1WxwawLci3Oo6kdc12xP4DpcQcFThqgw==
X-Google-Smtp-Source: AGHT+IFcx8e71Sbv+PrWSfd3ZCKV1PMOiT8u90r3wMLXiNDXDXPRC/Sbr58Pze/usq8fGa5m8T8Jsg==
X-Received: by 2002:a05:6830:4427:b0:72b:87bd:ad5b with SMTP id
 46e09a7af769-73b4cd316bdmr2145624a34.4.1751459667839; 
 Wed, 02 Jul 2025 05:34:27 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 12/97] target/arm: Rename MOVA for translate
Date: Wed,  2 Jul 2025 06:32:45 -0600
Message-ID: <20250702123410.761208-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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


