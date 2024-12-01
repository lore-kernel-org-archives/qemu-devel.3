Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A34D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlXI-0001h8-0c; Sun, 01 Dec 2024 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXD-0001eY-7W
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:55 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXB-0004Q2-4q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:54 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea5120dd60so1637571b6e.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065612; x=1733670412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xut5lRThCMYRYvYDz67rU5cp3YfNXt26IykKCx+nZts=;
 b=PD7G+tHkngPZ1CoG1b3fNaOwiUniyR8J+KhBT0Bt6stfztCTgfP6YOqmTxUboG+Uhp
 4JUhY0uYUQsfRmFcTF0jRZjH4xWAadv3Cbh8JEUWNP9NUT492slAWwTzivqYYTdp3PCQ
 wciISrWm3RDIYZQ0JiAxUQVYBBt41D6hFp2sgPRiBGTDoP8a6odU429F7PG52jW0JZhW
 KzkE18IeGFuzfyncHjU5+VbFXtMsInm0Xty4EBlWsT/t6Qr8Gvptsi6IoB2gEhE2TFQp
 Jb7cpoLbl4AFHktSIwGQAiHVcGuyTRF7DmSnre34r60X4IQLLn3vcKAdltYZ/fpU+kdL
 f+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065612; x=1733670412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xut5lRThCMYRYvYDz67rU5cp3YfNXt26IykKCx+nZts=;
 b=O/hKSAlzhmix3ivCQiQCl88/DB5b6A7IZrEGrgzBai/bPhm4nzA+XjNDayq/Qb/+00
 DMsx+lxBUHFY/YwdcmnvYBwWYOFoevQMMqbp6wA+oUPK8GphqVT8ojwsyupC8gqy6hdW
 4f2KHDQhFcm2HE/jO4svaMd9U/Eojtjn5RKu3AJGEcuMBUYbbbdSW/Y+JW2Cl9uKRXqV
 PrGjuXZaNEon7ROlHkftm0WmdOmaOTIZwvTSf/poXRZQCr0uMUOJ+E6uhuO5ikJxp/3I
 8cBonXFrh6sJtNhyLpGKQDRUekHZff0xtFbqX/dWYi6oHyj7YbXPSxHrQmJBALyU8WMm
 rGWQ==
X-Gm-Message-State: AOJu0Yx09G38pkb1j+Ux8n6YSIemuuzSb/lahfBC68uuIWQbUj8Vnnii
 vQDkBeASRyEEr2Kc/IXBZP0ysZb/nbcen4ThhKPu+AX0RCRSoOrExR2gmBaAPzWHocNUECHhUUO
 oVvI=
X-Gm-Gg: ASbGnctRLjhTnuSgw+5pC8Kq8cYvWeUrSB6f2Wok4YBlj339/cm2NmO+WrquPyMf8MX
 4/+2+7Y4vKP/mh4lqnX6Pk2i2nE3h71g1apTL0/xwkspFqo1hX1taooyHDtH5eg0xdwKAiLbLp1
 +ajB/VOQZ2PnBBgH/JGOQUIuk/+ygYrW84fqx82xmnDebpQfu519k5Hhq7VhvHIv4aunt74S2oY
 9g3vubyKNiIpxWMiUeQMpp87cY9NS/EX2y6zfvOq5Nl8PDux/gh0MARjbHLRZRC+7Pe9GELCMlz
 o2QgFC3mJZZfKaeZvpb5IdB62JaXCNAkAdf7
X-Google-Smtp-Source: AGHT+IH8D6HoWwMg76Rneq2nKGs5Zq9g45gA6wy2xmmWsfibI8uQIRrjBt3WNG7u/jZfhayGHl1Hdg==
X-Received: by 2002:a05:6808:1829:b0:3e7:644e:3ca2 with SMTP id
 5614622812f47-3ea6dd4f558mr15695384b6e.29.1733065611972; 
 Sun, 01 Dec 2024 07:06:51 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 38/67] target/arm: Introduce gen_gvec_cnt, gen_gvec_rbit
Date: Sun,  1 Dec 2024 09:05:37 -0600
Message-ID: <20241201150607.12812-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Add gvec interfaces for CNT and RBIT operations.
Use ctpop8 for CNT and revbit+bswap for RBIT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  4 ++--
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
 target/arm/tcg/neon_helper.c    | 21 ---------------------
 target/arm/tcg/translate-a64.c  | 32 +++++++++-----------------------
 target/arm/tcg/translate-neon.c | 16 ++++++++--------
 target/arm/tcg/vec_helper.c     | 24 ++++++++++++++++++++++++
 7 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0a697e752b..167e331a83 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -363,8 +363,8 @@ DEF_HELPER_1(neon_clz_u16, i32, i32)
 DEF_HELPER_1(neon_cls_s8, i32, i32)
 DEF_HELPER_1(neon_cls_s16, i32, i32)
 DEF_HELPER_1(neon_cls_s32, i32, i32)
-DEF_HELPER_1(neon_cnt_u8, i32, i32)
-DEF_HELPER_FLAGS_1(neon_rbit_u8, TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_3(gvec_cnt_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rbit_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5c6c24f057..cb8e1b2586 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -582,6 +582,10 @@ void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 834b2961c0..85a0b50496 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2393,3 +2393,19 @@ void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_8);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_cnt_b);
+}
+
+void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_8);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_rbit_b);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 93b2076c64..4e501925de 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -525,27 +525,6 @@ uint32_t HELPER(neon_cls_s32)(uint32_t x)
     return count - 1;
 }
 
-/* Bit count.  */
-uint32_t HELPER(neon_cnt_u8)(uint32_t x)
-{
-    x = (x & 0x55555555) + ((x >>  1) & 0x55555555);
-    x = (x & 0x33333333) + ((x >>  2) & 0x33333333);
-    x = (x & 0x0f0f0f0f) + ((x >>  4) & 0x0f0f0f0f);
-    return x;
-}
-
-/* Reverse bits in each 8 bit word */
-uint32_t HELPER(neon_rbit_u8)(uint32_t x)
-{
-    x =  ((x & 0xf0f0f0f0) >> 4)
-       | ((x & 0x0f0f0f0f) << 4);
-    x =  ((x & 0x88888888) >> 3)
-       | ((x & 0x44444444) >> 1)
-       | ((x & 0x22222222) << 1)
-       | ((x & 0x11111111) << 3);
-    return x;
-}
-
 #define NEON_QDMULH16(dest, src1, src2, round) do { \
     uint32_t tmp = (int32_t)(int16_t) src1 * (int16_t) src2; \
     if ((tmp ^ (tmp << 1)) & SIGNBIT) { \
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 312bf48020..f96b29e5a9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10328,12 +10328,15 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x5:
-        if (u && size == 0) { /* NOT */
+    case 0x5: /* CNT, NOT, RBIT */
+        if (!u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cnt, 0);
+        } else if (size) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_rbit, 0);
+        } else {
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
-            return;
         }
-        break;
+        return;
     case 0x8: /* CMGT, CMGE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
@@ -10378,13 +10381,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     } else {
         int pass;
 
+        assert(size == 2);
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
 
-            if (size == 2) {
+            {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
                 case 0x2f: /* FABS */
@@ -10438,25 +10442,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
-            } else {
-                /* Use helpers for 8 and 16 bit elements */
-                switch (opcode) {
-                case 0x5: /* CNT, RBIT */
-                    /* For these two insns size is part of the opcode specifier
-                     * (handled earlier); they always operate on byte elements.
-                     */
-                    if (u) {
-                        gen_helper_neon_rbit_u8(tcg_res, tcg_op);
-                    } else {
-                        gen_helper_neon_cnt_u8(tcg_res, tcg_op);
-                    }
-                    break;
-                default:
-                case 0x7: /* SQABS, SQNEG */
-                    g_assert_not_reached();
-                }
             }
-
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
         }
     }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 1c89a53272..50d0bf7753 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3131,6 +3131,14 @@ static bool trans_VMVN(DisasContext *s, arg_2misc *a)
     return do_2misc_vec(s, a, tcg_gen_gvec_not);
 }
 
+static bool trans_VCNT(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc_vec(s, a, gen_gvec_cnt);
+}
+
 #define WRAP_2M_3_OOL_FN(WRAPNAME, FUNC, DATA)                          \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
                          uint32_t rm_ofs, uint32_t oprsz,               \
@@ -3229,14 +3237,6 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_rev16);
 }
 
-static bool trans_VCNT(DisasContext *s, arg_2misc *a)
-{
-    if (a->size != 0) {
-        return false;
-    }
-    return do_2misc(s, a, gen_helper_neon_cnt_u8);
-}
-
 static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                        uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e825d501a2..60381258cf 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3072,3 +3072,27 @@ DO_CLAMP(gvec_uclamp_b, uint8_t)
 DO_CLAMP(gvec_uclamp_h, uint16_t)
 DO_CLAMP(gvec_uclamp_s, uint32_t)
 DO_CLAMP(gvec_uclamp_d, uint64_t)
+
+/* Bit count in each 8-bit word. */
+void HELPER(gvec_cnt_b)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ctpop8(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+/* Reverse bits in each 8 bit word */
+void HELPER(gvec_rbit_b)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = revbit64(bswap64(n[i]));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.43.0


