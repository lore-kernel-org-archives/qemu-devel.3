Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B998BE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YI-0000tA-6b; Fri, 13 Dec 2024 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XU-0007G2-K8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:22 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XS-0001cI-Gh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso14311815e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111197; x=1734715997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GXSaw+3kLrlZyJ9p0fZlTKT0DF9Yt+Kmo3k1MijYscI=;
 b=zeDx3vyNw4+opz/jn+3FCnHbJZu+L30VEAtZY83pFpzs/KXS9PND50gRi1HuZWo3jf
 /j1a55BQngAFuZ8Muvxtx1t9zBFJk8BI7m19hKQN/bSR9IZ1h/cRpmdccKdSiLUC1C5E
 w6y08m3ylTW9OZQSFeYenXj/J6r7shnSKqvPcjdZ6wFie0nlZz0ELHQ7vbmCQ+4Bt2u6
 t7JjhkJ/3X0EcEKz7NT3yBqvYeUO2BKv8Qe2B0w2/hpdlVK4uvJYDQrqqwsf1+QfTffj
 r2zTw2su3jk4Cd04dUcSm9kj+BD4qzu9v69EiCt7Fw+DZwkcIAV93tH4oSu//NfvhBO0
 Twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111197; x=1734715997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXSaw+3kLrlZyJ9p0fZlTKT0DF9Yt+Kmo3k1MijYscI=;
 b=nKw4JT02KFQovz9ybkMHI6XeqOdyMcO6eirAVBQp5tUt+dhegnr/NUdL8Ie/wf8nb6
 aaedHEF6KR1b05fu0yzhhUkW6tbPfnMXZpWLa9ygzUHf/c8H23tIalo3fZt/35F3e5TA
 0UQTTzXumONUvG4oT/d4a561pCb4sXUIpaNqYCkZURKypz9Q81pqx2w0yoWyZ4oknGZz
 JS54X2mjbLAAYoUsd+tjaflUt1ph6qsUn6qc7l01htLPDMw89h1anAa++twYf7EdLDDh
 B7ml9PV7HFhNJMCvQg8yLb+8qzgP9dHS/eQYXvFP+pIcTnNOjws+avHMTNC2mYVJ7EK2
 2wbw==
X-Gm-Message-State: AOJu0Yz2W13DzFgXjKRiKjZh45cx1L3Gl9SWWIAY2Xygchp7kIh6Oxjp
 Is4UGHHjpOIAfrn4O01DBKs5c78ahzcu2U7ZhNOfyNzARMIdhCTXouQLEvvr4y9lLtEvRbqK6ju
 z
X-Gm-Gg: ASbGnctLFPKA4cCkNkhftQ7eZCny7vKdpuaxniyIIRCp3VSvGQOlDHDKMeTtsVc6Vsq
 /9Lk9YXZRK0n/7cI8jtac0QQfxdmFtY45oqS4VUQZBXumB9j/d+KErrKPeCGoW578eQtAMhYYuA
 MeVo8zvq1HPxRttjxMjb2MA98rfS7KZYKU5uIqa3ouEjFfIfklE23KYMKiueOyvuBdoyxyFI9n/
 6EdfCkifmD17dzhou8yIQWT5QKuokSUhAS4zQu4qt3DQNGINtyeDnu6QmYHow==
X-Google-Smtp-Source: AGHT+IHruGL7kIoPFZR/TAsXdGFXOOsmjmNpZK/5b6p78+2EaWbqE0z4yOsUN1fKrJMQvz7S8++Wmg==
X-Received: by 2002:a05:6000:18a3:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-3888e0bd48fmr2358803f8f.35.1734111196800; 
 Fri, 13 Dec 2024 09:33:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/85] target/arm: Introduce gen_gvec_rev{16,32,64}
Date: Fri, 13 Dec 2024 17:31:46 +0000
Message-Id: <20241213173229.3308926-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-43-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h      |  6 +++
 target/arm/tcg/gengvec.c        | 58 ++++++++++++++++++++++
 target/arm/tcg/translate-neon.c | 88 +++++++--------------------------
 3 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index cb8e1b2586a..342ebedafcb 100644
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
index 85a0b504960..33c0a949581 100644
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
index 50d0bf77531..ca6f5578b4f 100644
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
2.34.1


