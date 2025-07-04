Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9DC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLq-0003qZ-A2; Fri, 04 Jul 2025 10:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIL-0005Hf-4V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIJ-0005qK-1M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:40 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-60d666804ebso1198981eaf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638897; x=1752243697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGYgwCm9XTJh3Jv7tUzNjmQDxtUUB3eW8c2+NqQ6fB4=;
 b=C4shi1ACYr3AZDxvxj1gB7KJuxxB055i98/W/47IhEtP9yCv4qgyDr88m7zqUBWrhY
 dFHBlykGderhVVzzYsd2CsT4owv7fXYYsxDBOgrQjsF6TY1UolAQCZBJT1qYVCSoHMMa
 B6mDMp4kqnZhLrKdC7y5kFWz3elKBxhwM95IIcMthiCQDiticJXs3gMV1uHlTWG3rym7
 bL4nfSbzjQYTscQW2hQYfB/b43zTxhdS7ZTQ/thtYFPgL6yHWWDqjW5FM+s+YHURzZLB
 X+h8bnrWOZEmKXFSTmeKdRccDp/hCoUgopdSAMsYmepWUCXjHS/aVNehHcd9h+KXfl/J
 5ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638897; x=1752243697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGYgwCm9XTJh3Jv7tUzNjmQDxtUUB3eW8c2+NqQ6fB4=;
 b=MAUp06piY1OCSEDm0scBmvzcajIWhMRuaMo1CsvKpt7Q+kCSJ+TOPVn/UvIqCbxu5Y
 PMMtwCh9dMpWrxeLRR/0gMQiwkxe2Ki/4KWLgLuENKALfkjP9C4a67sVihRr4rfjFnkO
 e3x/VAhj6IRAgxt2NNjFGFaTv4E1MNilOIIcMAQzw5vQ445i3JPBBg9IBfIl0jLvJkX5
 wva1ftKLVyw59V0jjtjSTM0gtdRzrXe/pH5N6/bZuTo1wwjsoZtWEfXQECP6yT0GIUJK
 /+0PJdTbhev0+tAwDbweLc4R1o1sD3Z8akeo05pbdG2q6Lqed7+fXasuYnJtSsgTBUUd
 QVlA==
X-Gm-Message-State: AOJu0YzVDZvuiD20+WSDgAcx/7diSSaqGNOfIVtQZ4TQsQrttGn85QgW
 sISo4ltiskgQAG2/7adyAK8aG9F7aoL6Fy0u2+f/V1Kdb7HCwnV69gEwmcoCseCRKR7BLZOxsZS
 1+J520Yc=
X-Gm-Gg: ASbGncsqMScSksYL0nuNrJvLrxsoqIQXbXvJ4NphJj7Y+CsEJ4BguAIzDkHQo54gxbN
 W4hV2FYeNMEUmd9/2/J5Zd2i5g99ITB+DQjx9Jpz5CViuk/JRHwnZtQPKFHSJ/oQTvkicNsvspH
 1vP9Qlt34KML/LnoLh9mP+gfHfwsri6MNwvLiWQMCzbEbSeilKkLHITL4DfingwrCQrma+hthVR
 gH9Rb1UnvNtaeKifwr1NIwpDZDIy1f42dju84OXhGkOZMuKloOJPsC5X062YWZlXUSxWdJxrCl3
 o15BtEuktKnBA6GvQVAwAUcFJwIQL/h5sKYGsQRLggMuTdvFdBhJ4FyvKKO4fZ/Jo0MshfOnxpx
 Ov4YL5PTouWtoRJYqVSvAfTqRuru7BDaPjYDnOcHeBTood2nuVarnkzQDYcQ=
X-Google-Smtp-Source: AGHT+IFSHi0RvfK3+yVRW1UTA4Vowz2RMZLpC4PI7MFtKTY9ju5ZXR4nUXKxojKoPxrBybSHes9YBg==
X-Received: by 2002:a05:6870:2103:b0:2eb:a2ec:dc02 with SMTP id
 586e51a60fabf-2f7903f154emr2599345fac.11.1751638897229; 
 Fri, 04 Jul 2025 07:21:37 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 021/108] target/arm: Split get_tile_rowcol argument
 tile_index
Date: Fri,  4 Jul 2025 08:19:44 -0600
Message-ID: <20250704142112.1018902-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Decode tile number and index offset beforehand and separately.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 17 +++++--------
 target/arm/tcg/sme.decode      | 46 +++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 797035e289..e22ec393fd 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -41,15 +41,10 @@ static bool sme2_zt0_enabled_check(DisasContext *s)
     return true;
 }
 
-/*
- * Resolve tile.size[index] to a host pointer, where tile and index
- * are always decoded together, dependent on the element size.
- */
+/* Resolve tile.size[rs+imm] to a host pointer. */
 static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
-                                int tile_index, bool vertical)
+                                int tile, int imm, bool vertical)
 {
-    int tile = tile_index >> (4 - esz);
-    int index = esz == MO_128 ? 0 : extract32(tile_index, 0, 4 - esz);
     int pos, len, offset;
     TCGv_i32 tmp;
     TCGv_ptr addr;
@@ -57,7 +52,7 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
-    tcg_gen_addi_i32(tmp, tmp, index);
+    tcg_gen_addi_i32(tmp, tmp, imm);
 
     /* Prepare a power-of-two modulo via extraction of @len bits. */
     len = ctz32(streaming_vec_reg_size(s)) - esz;
@@ -185,7 +180,7 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za_imm, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
     t_zr = vec_full_reg_ptr(s, a->zr);
     t_pg = pred_full_reg_ptr(s, a->pg);
 
@@ -264,7 +259,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za_imm, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
     t_pg = pred_full_reg_ptr(s, a->pg);
     addr = tcg_temp_new_i64();
 
@@ -295,7 +290,7 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
     }
 
     /* ZA[n] equates to ZA0H.B[n]. */
-    base = get_tile_rowcol(s, MO_8, a->rv, imm, false);
+    base = get_tile_rowcol(s, MO_8, a->rv, 0, imm, false);
 
     fn(s, base, 0, svl, a->rn, imm * svl,
        s->align_mem ? MO_ALIGN_16 : MO_UNALN);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 83ca6a9104..efe369e079 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -27,17 +27,29 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 ### SME Move into/from Array
 
 %mova_rs        13:2 !function=plus_12
-&mova           esz rs pg zr za_imm v:bool to_vec:bool
+&mova           esz rs pg zr za off v:bool to_vec:bool
 
-MOVA            11000000 esz:2 00000 0 v:1 .. pg:3 zr:5 0 za_imm:4  \
-                &mova to_vec=0 rs=%mova_rs
-MOVA            11000000 11    00000 1 v:1 .. pg:3 zr:5 0 za_imm:4  \
-                &mova to_vec=0 rs=%mova_rs esz=4
+MOVA            11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
+                &mova to_vec=0 rs=%mova_rs esz=0 za=0
+MOVA            11000000 01 00000 0 v:1 .. pg:3 zr:5 0 za:1 off:3  \
+                &mova to_vec=0 rs=%mova_rs esz=1
+MOVA            11000000 10 00000 0 v:1 .. pg:3 zr:5 0 za:2 off:2  \
+                &mova to_vec=0 rs=%mova_rs esz=2
+MOVA            11000000 11 00000 0 v:1 .. pg:3 zr:5 0 za:3 off:1  \
+                &mova to_vec=0 rs=%mova_rs esz=3
+MOVA            11000000 11 00000 1 v:1 .. pg:3 zr:5 0 za:4  \
+                &mova to_vec=0 rs=%mova_rs esz=4 off=0
 
-MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
-                &mova to_vec=1 rs=%mova_rs
-MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=4
+MOVA            11000000 00 00001 0 v:1 .. pg:3 0 off:4      zr:5  \
+                &mova to_vec=1 rs=%mova_rs esz=0 za=0
+MOVA            11000000 01 00001 0 v:1 .. pg:3 0 za:1 off:3 zr:5  \
+                &mova to_vec=1 rs=%mova_rs esz=1
+MOVA            11000000 10 00001 0 v:1 .. pg:3 0 za:2 off:2 zr:5  \
+                &mova to_vec=1 rs=%mova_rs esz=2
+MOVA            11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
+                &mova to_vec=1 rs=%mova_rs esz=3
+MOVA            11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
+                &mova to_vec=1 rs=%mova_rs esz=4 off=0
 
 ### SME Move into/from ZT0
 
@@ -46,12 +58,18 @@ MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
 
 ### SME Memory
 
-&ldst           esz rs pg rn rm za_imm v:bool st:bool
+&ldst           esz rs pg rn rm za off v:bool st:bool
 
-LDST1           1110000 0 esz:2 st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
-                &ldst rs=%mova_rs
-LDST1           1110000 111     st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
-                &ldst esz=4 rs=%mova_rs
+LDST1           1110000 0 00 st:1 rm:5 v:1 .. pg:3 rn:5 0 off:4  \
+                &ldst rs=%mova_rs esz=0 za=0
+LDST1           1110000 0 01 st:1 rm:5 v:1 .. pg:3 rn:5 0 za:1 off:3  \
+                &ldst rs=%mova_rs esz=1
+LDST1           1110000 0 10 st:1 rm:5 v:1 .. pg:3 rn:5 0 za:2 off:2  \
+                &ldst rs=%mova_rs esz=2
+LDST1           1110000 0 11 st:1 rm:5 v:1 .. pg:3 rn:5 0 za:3 off:1  \
+                &ldst rs=%mova_rs esz=3
+LDST1           1110000 1 11 st:1 rm:5 v:1 .. pg:3 rn:5 0 za:4  \
+                &ldst rs=%mova_rs esz=4 off=0
 
 &ldstr          rv rn imm
 @ldstr          ....... ... . ...... .. ... rn:5 . imm:4 \
-- 
2.43.0


