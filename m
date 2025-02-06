Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CFC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80b-0007S9-Ir; Thu, 06 Feb 2025 14:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80E-0007EV-Sk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:36 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80C-0000XG-KO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:34 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f464b9a27so13843335ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871851; x=1739476651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WImFZeGU0X+I930mpRsWt2LMEJMVri2j0hLyX6dOT8=;
 b=UAT+TIjd91XZ2GdWFRtmYlcZJyNu0Hi+B1NnpGpACSMWldY5o+Z7oNB3RN/wld5H3m
 inrXTrGQ74AL6o87enJYdtN6noSnTGKVU9GkxKSYzJY7NUjY7T7WQrCuLkNWJEiR+1eC
 gESbhVHxZS5l2ecOCkN5Fjh1qNw9GAu9k+m4qHiwYnrb+tkIMFlo05kkQrl8IaGNNITK
 DhfWNvF7pp4WVIIi7SWg4M7enjuVuL9sv7JBgvLq7OEP3MRYvDSFwGDsAdiWNPNI6okk
 sQfloTiF77setQZsqL+/UeiiDj+fI/w54wEH3lwMACV+JXZamjd3GPYMq6BBPMz61Bc8
 x8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871851; x=1739476651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WImFZeGU0X+I930mpRsWt2LMEJMVri2j0hLyX6dOT8=;
 b=JTTWqPg8KY/iJWmyi5cft/p7FC9uJraPUiVggaNTYGc15MsY+tOXEf+FtWA6QTWJeZ
 S7P5JtFSoF9nBdCdET84uWquj2IG/ot2BYCC1BnIwVIs+KUDHFgXq/7TL/58NiT6mBlp
 fivK1vb4OPqOypj+2yP7GnZtTXuwnoPGmTyA1vq0wvA9K8ji1yi9CBbdjQgcBwqk9hNA
 H1OkSWYPPr83wLhXeFFELa9gEqUwEdadI17XV+HhbDyK+vpYz1Ac4bg1/rxg+nP3wFIb
 DISOiQYdHLqJvXS0qxdyxrM2SgJj3Zeq6BaDGbWntYU9HiipQvOdqyZptDBmyv1JRZsm
 4wAg==
X-Gm-Message-State: AOJu0YyeQtsIaOI+/6pwlaAxidsVz/CPMrF9QGA6WH+MgZvJexK0QY7v
 Y+Chn+Hg7xuwEyuj2jd9pC3LaSaTeZ8NbPQZJ1xo0ZgPrXZAaC1GqXPid6AnrikqsPfWjv0kQpl
 c
X-Gm-Gg: ASbGncu5b5cpUjT7pAL/7cAAvcZ/lFGsFAOA4UqXlL1V4UURcupRr5H94MWttFKpsj4
 dGX6g8nZiUDVxWo8YOgdwQtWUaXVH2ana9aa1PZ12hiSnKUsEZBFAysnnFu94MU/g+DWLt3qrRN
 jCgLod3HvPE5Tv9qSZYM4nKOtZ1p/zQRdCZ5l1D9xdS8qydQm59CXJlxsML2u1uQsdnpfLxXck8
 UQP5BIGcQpzFQj6EXPhVzCAoUAIg9jgc6HirJgn/Svcz0RrLsM/CNYWp9uHZOlTmPPoNgg8uuLQ
 sFwA94IgsV6MpxszFbTyX4nVSbx7kDBI6HSp9NtgKr7Dylo=
X-Google-Smtp-Source: AGHT+IHv2Qxgqw1nkL761bTFdGMa2AfjwJiKuhVA0we6IF1SN8An/NzcEYUT9YmQ0MalSWob3PFvmA==
X-Received: by 2002:a05:6a00:4fc7:b0:72d:3c4d:c1ea with SMTP id
 d2e1a72fcca58-7305d449c1cmr925590b3a.7.1738871851212; 
 Thu, 06 Feb 2025 11:57:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/61] target/arm: Implement SME2 MOVA to/from tile,
 multiple registers
Date: Thu,  6 Feb 2025 11:56:34 -0800
Message-ID: <20250206195715.2150758-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  9 +++++
 target/arm/tcg/sme_helper.c    | 64 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 56 +++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 37 ++++++++++++++++++++
 4 files changed, 166 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 858d69188f..8246ce774c 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -33,6 +33,15 @@ DEF_HELPER_FLAGS_4(sme_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_cz_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sme2_mova_cz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 45f6cdfcb4..ee81bece12 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -206,6 +206,50 @@ void HELPER(sme_mova_zc_q)(void *vd, void *za, void *vg, uint32_t desc)
 
 #undef DO_MOVA_Z
 
+void HELPER(sme2_mova_zc_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint8_t *src = vsrc;
+    uint8_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc);
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint16_t *src = vsrc;
+    uint16_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 2;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint32_t *src = vsrc;
+    uint32_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 4;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint64_t *src = vsrc;
+    uint64_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 8;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
 /*
  * Clear elements in a tile slice comprising len bytes.
  */
@@ -314,6 +358,26 @@ static void copy_vertical_q(void *vdst, const void *vsrc, size_t len)
     }
 }
 
+void HELPER(sme2_mova_cz_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_b(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_h(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_s(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_d(vdst, vsrc, simd_oprsz(desc));
+}
+
 /*
  * Host and TLB primitives for vertical tile slice addressing.
  */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 908c3e8dd6..eed9345651 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -205,6 +205,62 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
 TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
 
+static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
+{
+    static gen_helper_gvec_2 * const cz_fns[] = {
+        gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
+        gen_helper_sme2_mova_cz_s, gen_helper_sme2_mova_cz_d,
+    };
+    static gen_helper_gvec_2 * const zc_fns[] = {
+        gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
+        gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
+    };
+    TCGv_ptr t_za;
+    int svl;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    svl = streaming_vec_reg_size(s);
+    if (svl == 16 && n == 4 && a->esz == MO_64) {
+        unallocated_encoding(s);
+        return true;
+    }
+
+    if (a->v) {
+        TCGv_i32 t_desc = tcg_constant_i32(simd_desc(svl, svl, 0));
+
+        for (int i = 0; i < n; ++i) {
+            TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
+            t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
+                                   a->off * n + i, a->v);
+            if (to_vec) {
+                zc_fns[a->esz](t_zr, t_za, t_desc);
+            } else {
+                cz_fns[a->esz](t_za, t_zr, t_desc);
+            }
+        }
+    } else {
+        for (int i = 0; i < n; ++i) {
+            int zr_ofs = vec_full_reg_offset(s, a->zr * n + i);
+            t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
+                                   a->off * n + i, a->v);
+            if (to_vec) {
+                tcg_gen_gvec_mov_var(MO_8, tcg_env, zr_ofs, t_za, 0, svl, svl);
+            } else {
+                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, zr_ofs, svl, svl);
+            }
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false)
+TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
+TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
+TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 459b96805f..5eca5f4acf 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -28,6 +28,7 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 
 %mova_rs        13:2 !function=plus_12
 &mova_p         esz rs pg zr za off v:bool
+&mova_t         esz rs zr za off v:bool
 
 MOVA_tz         11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
                 &mova_p rs=%mova_rs esz=0 za=0
@@ -51,6 +52,42 @@ MOVA_zt         11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
 MOVA_zt         11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
                 &mova_p rs=%mova_rs esz=4 off=0
 
+MOVA_tz2        11000000 00 00010 0 v:1 .. 000  zr:4 0 00      off:3  \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_tz2        11000000 01 00010 0 v:1 .. 000  zr:4 0 00 za:1 off:2  \
+                &mova_t rs=%mova_rs esz=1
+MOVA_tz2        11000000 10 00010 0 v:1 .. 000  zr:4 0 00 za:2 off:1  \
+                &mova_t rs=%mova_rs esz=2
+MOVA_tz2        11000000 11 00010 0 v:1 .. 000  zr:4 0 00 za:3        \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_zt2        11000000 00 00011 0 v:1 .. 000 00      off:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_zt2        11000000 01 00011 0 v:1 .. 000 00 za:1 off:2 zr:4 0 \
+                &mova_t rs=%mova_rs esz=1
+MOVA_zt2        11000000 10 00011 0 v:1 .. 000 00 za:2 off:1 zr:4 0 \
+                &mova_t rs=%mova_rs esz=2
+MOVA_zt2        11000000 11 00011 0 v:1 .. 000 00 za:3       zr:4 0 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_tz4        11000000 00 00010 0 v:1 .. 001 zr:3 00 000      off:2  \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_tz4        11000000 01 00010 0 v:1 .. 001 zr:3 00 000 za:1 off:1  \
+                &mova_t rs=%mova_rs esz=1
+MOVA_tz4        11000000 10 00010 0 v:1 .. 001 zr:3 00 000 za:2        \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVA_tz4        11000000 11 00010 0 v:1 .. 001 zr:3 00 00 za:3         \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_zt4        11000000 00 00011 0 v:1 .. 001 000      off:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_zt4        11000000 01 00011 0 v:1 .. 001 000 za:1 off:1 zr:3 00 \
+                &mova_t rs=%mova_rs esz=1
+MOVA_zt4        11000000 10 00011 0 v:1 .. 001 000 za:2       zr:3 00 \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVA_zt4        11000000 11 00011 0 v:1 .. 001 00 za:3        zr:3 00 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
-- 
2.43.0


