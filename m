Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2666BD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlaV-0008E9-Ns; Sun, 01 Dec 2024 10:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaA-0007e2-QZ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:09:59 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHla8-00056e-SB
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:09:58 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1dbf0d060so1350306eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065796; x=1733670596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o04bLSv2q1PvfR5//65eUEba72rJczaN8PbMw/ixLT4=;
 b=ZmuSTpp/Pe0nFHHR/F5G6rRFW4mkN1i4A4MHdNPlbg+fRsI1w412u9jfsqsjHM2B8c
 HDWbc3SgksAVPq4Ofe193LEHS4KG8mA0mPOLQ8oLQunGzGjy+j4gArqO/zwO1tJCqeWT
 9cUhzJFib4+vcnK2k1vMN/CfRW99+JSbhB7DGvpUrl+Jlcv6OL/ap4V5eThT5vGWoPDK
 jxBdGaU1w+6c3HxwJiGLm9g14xxJD+YwG5bQ9nQfvN7URmsUi1sEW/sagAurev5LIksd
 ysqO2yeDZwzHWnZTXKPT8CjA4GL3wfqZYoj+BeGsy2oH2RL+Eu/e8nFGhQ8zimpu13Qd
 MSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065796; x=1733670596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o04bLSv2q1PvfR5//65eUEba72rJczaN8PbMw/ixLT4=;
 b=s9gLE+Ij+K67BfFuStzZdYbZ4SPgkVRWOT+Qp+WBAyqxJDNF2D8Ni6hvJ6+Va8Da1a
 InasCV0ab5vmvaAVwVli56kTVASRmUWF51kFaUt0SCkHj3TdSMntI5RHHQ9x6dHeMyT0
 f5MItywIInI4hTaPiddU5KbshXBNi7Yj8QwvoOQR6FGYwf99nmTYEV9o3f6znnoDl8je
 vsF3Q5VIySqoByCh1EV6ARQNC05ZKd5TNl7HAnCnkmfiaJPmHZ7TRHC8LFBzN+Vp7f1k
 UZHLZ8crGe1lQH7zulW0xhdppQvgESstj5Z5yT+XG163WSUZa4JaJaAogq+j/GxPtWjZ
 rnUA==
X-Gm-Message-State: AOJu0YyzFqoMyPeJaJPX/AHv7a+2tDj/tAonnP3Z6bzXYvCixFnoRD2A
 cVWolJEms0xWd+P6xhEBqF+VirHmdQcpGnU50fp3hPtaqO3lz/W/VOpAXzKm7cDOzl1RtRFXaDG
 H6Go=
X-Gm-Gg: ASbGncugHaGWvNP5JJkFl1X/1QdFavYdpA0xm0uCqJaM//jstP6k5DbGMQuBmTpDyEu
 3YD7ZHuVtpa39qlPAJOsDB6kISzybEBhqlrcFDkEm6QhFWhEs9s0AzX4QJC9xm4zQYi3rM/s0hd
 8ImgctvOr5D1/dvoSFq/tO6h2N546+gLsJxKhRWtYPby9zrcEnSaq31N4M/HJNA6OjU23eCig3F
 k+iwk2pRm23QbsnHcxa/BkuSbUYJgQhZrf5rccusTGbDwe+wHpMQ+TtbfVhzAxypZu3vdjthKYv
 D6mJN4panG2gOK8wVlqflgXN+RqmmMJcaTB8
X-Google-Smtp-Source: AGHT+IHKISE3e2BCadAB2EsKD9reP7HjxSpKOMIEBMwCbsVZBL9k44wg8TnRpWUfnwo+PHtQ/E/c1Q==
X-Received: by 2002:a05:6820:1f07:b0:5eb:821c:df23 with SMTP id
 006d021491bc7-5f20a07815cmr14006496eaf.2.1733065795781; 
 Sun, 01 Dec 2024 07:09:55 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:09:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 41/67] target/arm: Introduce gen_gvec_rev{16,32,64}
Date: Sun,  1 Dec 2024 09:05:40 -0600
Message-ID: <20241201150607.12812-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  6 +++
 target/arm/tcg/gengvec.c        | 58 ++++++++++++++++++++++
 target/arm/tcg/translate-neon.c | 88 +++++++--------------------------
 3 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index cb8e1b2586..342ebedafc 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -586,6 +586,12 @@ void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_rev16(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_rev32(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_rev64(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 85a0b50496..33c0a94958 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2409,3 +2409,61 @@ void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
                        gen_helper_gvec_rbit_b);
 }
+
+void gen_gvec_rev16(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_8);
+    tcg_gen_gvec_rotli(MO_16, rd_ofs, rn_ofs, 8, opr_sz, max_sz);
+}
+
+static void gen_bswap32_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    tcg_gen_bswap64_i64(d, n);
+    tcg_gen_rotli_i64(d, d, 32);
+}
+
+void gen_gvec_rev32(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g = {
+        .fni8 = gen_bswap32_i64,
+        .fni4 = tcg_gen_bswap32_i32,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .vece = MO_32
+    };
+
+    switch (vece) {
+    case MO_16:
+        tcg_gen_gvec_rotli(MO_32, rd_ofs, rn_ofs, 16, opr_sz, max_sz);
+        break;
+    case MO_8:
+        tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void gen_gvec_rev64(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g[] = {
+        { .fni8 = tcg_gen_bswap64_i64,
+          .vece = MO_64 },
+        { .fni8 = tcg_gen_hswap_i64,
+          .vece = MO_64 },
+    };
+
+    switch (vece) {
+    case MO_32:
+        tcg_gen_gvec_rotli(MO_64, rd_ofs, rn_ofs, 32, opr_sz, max_sz);
+        break;
+    case MO_8:
+    case MO_16:
+        tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 50d0bf7753..ca6f5578b4 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -2565,58 +2565,6 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
     return true;
 }
 
-static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
-{
-    int pass, half;
-    TCGv_i32 tmp[2];
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vd | a->vm) & a->q) {
-        return false;
-    }
-
-    if (a->size == 3) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    tmp[0] = tcg_temp_new_i32();
-    tmp[1] = tcg_temp_new_i32();
-
-    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
-        for (half = 0; half < 2; half++) {
-            read_neon_element32(tmp[half], a->vm, pass * 2 + half, MO_32);
-            switch (a->size) {
-            case 0:
-                tcg_gen_bswap32_i32(tmp[half], tmp[half]);
-                break;
-            case 1:
-                gen_swap_half(tmp[half], tmp[half]);
-                break;
-            case 2:
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        }
-        write_neon_element32(tmp[1], a->vd, pass * 2, MO_32);
-        write_neon_element32(tmp[0], a->vd, pass * 2 + 1, MO_32);
-    }
-    return true;
-}
-
 static bool do_2misc_pairwise(DisasContext *s, arg_2misc *a,
                               NeonGenWidenFn *widenfn,
                               NeonGenTwo64OpFn *opfn,
@@ -3122,6 +3070,7 @@ DO_2MISC_VEC(VCGE0, gen_gvec_cge0)
 DO_2MISC_VEC(VCLT0, gen_gvec_clt0)
 DO_2MISC_VEC(VCLS, gen_gvec_cls)
 DO_2MISC_VEC(VCLZ, gen_gvec_clz)
+DO_2MISC_VEC(VREV64, gen_gvec_rev64)
 
 static bool trans_VMVN(DisasContext *s, arg_2misc *a)
 {
@@ -3139,6 +3088,22 @@ static bool trans_VCNT(DisasContext *s, arg_2misc *a)
     return do_2misc_vec(s, a, gen_gvec_cnt);
 }
 
+static bool trans_VREV16(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc_vec(s, a, gen_gvec_rev16);
+}
+
+static bool trans_VREV32(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0 && a->size != 1) {
+        return false;
+    }
+    return do_2misc_vec(s, a, gen_gvec_rev32);
+}
+
 #define WRAP_2M_3_OOL_FN(WRAPNAME, FUNC, DATA)                          \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
                          uint32_t rm_ofs, uint32_t oprsz,               \
@@ -3218,25 +3183,6 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
     return true;
 }
 
-static bool trans_VREV32(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenOneOpFn * const fn[] = {
-        tcg_gen_bswap32_i32,
-        gen_swap_half,
-        NULL,
-        NULL,
-    };
-    return do_2misc(s, a, fn[a->size]);
-}
-
-static bool trans_VREV16(DisasContext *s, arg_2misc *a)
-{
-    if (a->size != 0) {
-        return false;
-    }
-    return do_2misc(s, a, gen_rev16);
-}
-
 static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                        uint32_t oprsz, uint32_t maxsz)
 {
-- 
2.43.0


