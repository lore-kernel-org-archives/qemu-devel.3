Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D5BC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z9-00058e-5n; Sat, 21 Jun 2025 19:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z6-00057V-P0
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z4-0004UH-V9
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:56 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b2c4e46a89fso2372039a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549852; x=1751154652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K/KRFheEnFJgkLqHH8Ou/wv5NETcBB8J6PUtxw1iYZg=;
 b=JH6+Z9jnqs4qb+1HSlQI+6Qd1CtLYqNbSQgfh/abC/OuyUw6tlbe1wbBDK7+5ULFm3
 bE0bMH67DIzsbBbEsbG1moq1M9BTMwKGKfv067mpIC5z024cWjXHm4+DaEQxLulQYD3S
 JXgFgoHvtChZS6ByUCU34pwQau/BMBrrj99Uq4dU0WJuaLyH+xcxmP0F70izZA9nhNPu
 NAHh7vo6PMi7wQdpg00zXihNi1Je2ccBNIDRACGcwllM5yjlDZlbZ+r2r0n5DpKzaHlD
 g988fp75iE98Dv5w6OLhgUGUhZjEvm+HE4foYhl4bpGWn2eYPNfXxiPoA65OWnQGEhdT
 52cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549852; x=1751154652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/KRFheEnFJgkLqHH8Ou/wv5NETcBB8J6PUtxw1iYZg=;
 b=CO8ONEqgxbGyhdUZV6cm2FQcGn9RnaZE1R5kKudTrHhlwzmiVnEJGVVT0S2TVrE4BU
 ptixevPoksAjojYloZy8QLIt9pAQYqNfJv6KTyClR7e5kFsPFawx4+VgNkyptV45PLMV
 gH/Slosi0LW/PgDW3dn3DG5rwgVkxvTx68fwlCrqp1AJ8sCjQ8tJC9/4Bv45bsQC4Y/p
 EXhq/itEb32WBi7Y/wbbzTWkK5prBttbOqbTPrJP+LW/0WYAlMgV5ikZPBmuKrk1Iqo4
 LCz7ieTlAar+v6Fo4hE9XM5x58GsjD/oRz0AX3b6HaWPW+QgZBSajVtxABhYYUILUm5L
 Ye8A==
X-Gm-Message-State: AOJu0YzeGMFQsRcl7Hd+VBFhLZZ4/ykjsUHrGJNVkoXOg9tW4sEvhXXO
 avi3aprw/tEk0VXbf0A/LBQZpJVoqJrPcCJHq/4vBZkK24jPJ/7sMyQ8E8uwUX7Dr8Y0KmKeWeq
 wPxiC
X-Gm-Gg: ASbGncti4IgcVYIRx5iEt/mhml4XYV5NFQTWM28LByiSUw9/kNN0MN/2B/YhhIuHjOz
 /3iSrbUC01uNPPA10R96X8s3tzWcoWO1hwmnKFonSa6ITS6ezLw9NEIG7CQH+OV1j06tCtafJmQ
 SnHdUJZNHZNFsQkRE7650zAbumRPPR4ufqjk8Ptd0CFKfuZDTV1wZFrkctKxpJ/y9+g8IGz2502
 hGSpGkzxhsVaIR8qZIXzPROHqO1JtUtwxvJ3pvKnLrvQJmrTTl+5hwAreuMsa8Mbv96c8NU3+e5
 LA2W/yvyjzMcF2KHGTIDnEQ6FiPhCFeZr4RHXVa2F2XpT3hWMc8RmsNONl/WuRUZ6m51FWdQqDX
 +goAV3jOG/hNZSwsc3gLF
X-Google-Smtp-Source: AGHT+IE035fEgDyS/dGyYx5Ms7eU7eZfxcAfsoZkw9au/DB2vnag7M3rdQ1C3p6UAvnucwXr3AO5mw==
X-Received: by 2002:a05:6a20:729b:b0:21d:a9d:ba3b with SMTP id
 adf61e73a8af0-22026fe7577mr12213274637.39.1750549852518; 
 Sat, 21 Jun 2025 16:50:52 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 021/101] target/arm: Split get_tile_rowcol argument
 tile_index
Date: Sat, 21 Jun 2025 16:49:17 -0700
Message-ID: <20250621235037.74091-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Decode tile number and index offset beforehand and separately.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 17 +++++--------
 target/arm/tcg/sme.decode      | 46 +++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 13314c5cd7..bd6095ffb6 100644
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
 
     fn(s, base, 0, svl, a->rn, imm * svl);
     return true;
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


