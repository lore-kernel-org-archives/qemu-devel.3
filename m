Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7921C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEK-0000L7-DC; Fri, 04 Jul 2025 12:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEI-0000En-1O
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEF-0006Cw-Am
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so6457565e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646333; x=1752251133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YmW5HZ3JS47IQPSZ9xTJI9yQuqnhVNqm2P3t1MXaM+8=;
 b=cGEwh1bZ1bqRfedW0lqiaplqBPc4q93F3eybJQvVws3b5Yhhn5h3TAkTUtrM+3o6ia
 iRzGG6lVSh+TKkpyNgQETQ40gSZWN41D96uxSKZ5voxKGeDj34iW8teR/9IChWDIloAl
 oeubKHlBMB1bipJQIXJdvR0PZnA49KUF1ALkBdVf/CKss1/I3iD+P5zwvJ8RwQGkk7Yx
 G6hnP7NqEMPoeF0vyBnzh2qKg3e93MzIxU3zSdtF6Vkf2tlVBkjLzdAxqqaBFGtMAH2Q
 eiiMzdI2ahN7uiNOtH7F46MvIAcGZ1DktzmkZcSpvXY1L/YHcItUpPRoDLV/f7RWBchm
 jKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646333; x=1752251133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmW5HZ3JS47IQPSZ9xTJI9yQuqnhVNqm2P3t1MXaM+8=;
 b=LkTLpS3XZJymj0Ju/H1eXzey434roaJ0n8bUHM2BuWBx8h8ZujgKZBSVp1Pp51LLyU
 ixI2smean8WoxWKpdcLCY+mpuwfPNe6na85tLsDdSNNYe6h7wt5wvRZN3tOs0IlDxiii
 mzsThC2LmdTnQO+xxhP4jboXW5XGYqRE5OFh7KXcncB6Jm2eVHHjcY+pw5aFJxueltZO
 e23SkuhLONTiwoZmlkqPtwXJTkgH8Va0DMXwkMN5xpdoYl2QGQuVuTPGe9R5IJDZGmiZ
 AC2Ba1JoNsrpR36I6uTOpaA/y5BlDM9mi3sjAeSvzcjv8mwubTWuuIxroGd1W0y52tyT
 pVaA==
X-Gm-Message-State: AOJu0YyYds8yhh1VymCxcroAAZ9OeQPTThu/Qd9+RaetYRwO7o0Hp9YG
 xwvuZFS4K1JD+wtn/QKOgvs/LjVC6pe93g8lmaU48NyOl2Ef8izkdG+pXvx5pLMC+is09iriVb7
 F4qQD
X-Gm-Gg: ASbGncsmIxltqOagxbGKqGdwUsjPAvat2Is0ktSdYvp4FfHZO0G9R8m3MOL3WKT7OaE
 R5nwHKS4kl8uw27w+rnZNILJxZLl36YbblRvT4qZOmngQE4y2vl37pb+Yzqd8o/ihFvSMuqopl/
 x+aw/yK3IrMbgB+0rpoB3IIPEev5fTYUJyxrnuVCHHj7NJoJZFKEmMQPl5tnCfu2CDbL4G6IWPY
 8SeU8/rEo3m3ZsLCHsBwhDx85mc4AWV4KhUQyRtjl7UNo2p6s6gl6XneZaGLgiUxhrZlyaRWBy0
 AajOc7Fmo1Edv+NXFKHZ8ws4tcyoH/+75q1HlewnA7LIC0NQb0Poxruxh46bUA+DjD1s
X-Google-Smtp-Source: AGHT+IF6M02ftDQHlj+gpmBzpox+xSVcYph0TJmqn4ne6RJe5l29eyhgPnbNAZEs1cWi817IL1SuPA==
X-Received: by 2002:a05:600c:6295:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-454b76ad2eemr20174585e9.14.1751646333539; 
 Fri, 04 Jul 2025 09:25:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 033/119] target/arm: Split get_tile_rowcol argument tile_index
Date: Fri,  4 Jul 2025 17:23:33 +0100
Message-ID: <20250704162501.249138-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Decode tile number and index offset beforehand and separately.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 46 +++++++++++++++++++++++-----------
 target/arm/tcg/translate-sme.c | 17 +++++--------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 83ca6a9104f..efe369e079b 100644
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
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 797035e2892..e22ec393fd0 100644
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
-- 
2.43.0


