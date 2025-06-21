Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A07C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z9-00058a-54; Sat, 21 Jun 2025 19:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z6-00057A-6k
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z4-0004UR-I5
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so3591777b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549853; x=1751154653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+nEPeXRYzzj0xJOq25EhVbIb2paARNmPIuoc84/gBhk=;
 b=c+gbAeCWvzvkZMD1cfEIyJgMPzqwoQIPAyYBowvtZj9VFnfHfcQ45PRTj720cTaIw4
 Cjp6I8WWKxqpoVOUOh+Dz4aIfyUlN62l24J4onvlmAp7FtAjgQvsNcAZTaUoC5b9SDcn
 ocMrKFkrMRr5JnvbxSDCA+RyF7hI/lyxdjsMbAw3/50i4N32Q/OwhO443/lL9YQMCNkU
 IRmmsPr1bVTeiju/mC73CNHpql7XXymC6/yDNGQOBapQhkCf5VV+fWfw44JcyFL20py9
 Yd5/DvhxnRBv5FS8Bb41SL+Sq6r7Sy+F0IcwLYISt+GEdwXsR/YYUCaLMMhYXrKm8vil
 qLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549853; x=1751154653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nEPeXRYzzj0xJOq25EhVbIb2paARNmPIuoc84/gBhk=;
 b=I/OfuTmWHbp5vJgDltoqJoxaTEj8YfvcJMSAhI/68lJbDeCXZHATNt90HAem4JtqUi
 E42i1iRwqlHS5Lno4YSrfeLrkTAi1HvM9tau4TU2VQvQtj5sdqta7Grrlq0weaPF9kht
 oClq6suQwDxYfx6F4hsVRzP3l59LTnY/QAqSpJQW2wsR48k3mo97QXih3SDid8gGK/wy
 CND82yREHFnuVUj0og5cmpVtlLPgbRihNWRsboBukLwnJtdU6E6qYTUyFIsur/5Y3kUX
 qPrg+rTdx4h/GC8ceYAx0YLiW2jPAHzMAO4V2rklyzSzSq0tgfTqUkKgDBG/Q2gGMqGW
 tHkw==
X-Gm-Message-State: AOJu0YwUqCa4HufSBis8w4EuVNNC6EVtyMsmtuyj8N/Y7fizqeQMQBqh
 kVisfQSLO8FB5CVSCmMKAfWpeyWF9Vpy8GgAUo5Tw4KU8tFfYfywb3hhmjUmvJvo0ckPKz04Ni0
 AoYym
X-Gm-Gg: ASbGnctUYEbt9Aqs2y1jQGD1zqHa5QUv5QSMG7nErEB+A+ukk4rcQBYEebleZv5pmcj
 LKTjVI/8TjliN5eotAhzYBUqAu8zZTVjPSGhwMdWguSsShQXbnU86n2bk0QPgVI6WdDn6SuuK5W
 40Ttl+zcnNJNkvJK3ngbDxVibzHy8OXVrri8Wg9W7dKYoaXOVwvvOdJN4sKUQQ3kY/zuSV918a1
 WHKdTgSi8quGH7Qi64xFSOr86P9WZmyYCxTRfkpJIJ2ne+BzN7I+p2XiBqvFRJDxs8WleNeqXFh
 GkzoXi6oecnI+yKiIQnNFXoo/1IDM2bhgucyDbR+S4WnVkB1YMrzvAA+FR3HvILXpPWISRPD9Z7
 KXXY7ijHlZhznRD6Vc2KV
X-Google-Smtp-Source: AGHT+IEUGoqRBB0TAdyz22a6cIl3w8f+aPZhc3UG3nDjhx/rubavRDrOSwZT5wWsnLyIZjyobtTIug==
X-Received: by 2002:a05:6a00:3d53:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-7490d786d8cmr10125245b3a.16.1750549853153; 
 Sat, 21 Jun 2025 16:50:53 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 022/101] target/arm: Rename MOVA for translate
Date: Sat, 21 Jun 2025 16:49:18 -0700
Message-ID: <20250621235037.74091-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 +++++-----
 target/arm/tcg/sme.decode      | 42 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index bd6095ffb6..908c3e8dd6 100644
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


