Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F548C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zA-00059G-54; Sat, 21 Jun 2025 19:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z7-000588-Ot
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z5-0004Uc-8L
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so3492378b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549854; x=1751154654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4w8vJYvfpYmQm+8iFOLOJ3iZnYr8Sg7T2hm6jk//0Vw=;
 b=l2j2TSGMN+8ujJgRbPsz8HdbM5mKaj4WgQvRvcXbTaXbmGp2xAbsA4ECLZayUT5yo5
 V1pE49YP2+jGHTFOKApopvIo6RIU8iRfFw/6rB+Xn7bAjdObOwpzILkgN6SSi2NiGqaB
 RO6GhYFcMQYMbxNPpszgX0Sh9oP9Moj2B9kg8njFClJn23z0PuBdFELJzAWl+Yvkpc7J
 2fTg+HsbS2bfGGHQAn7j9uGZ8Ht8OlDMPxqk46499nzH9s1CZrdG2HgCUCiv41PSONLf
 bMLDNWtCIMnx8PD1Z5wkl02WCufF3DGbRmr7fnAYwe1wiBEZ4V/Jb8xvmZSr81bFMlAZ
 l44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549854; x=1751154654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4w8vJYvfpYmQm+8iFOLOJ3iZnYr8Sg7T2hm6jk//0Vw=;
 b=biLVGX9Mfqt4Uzpwq3+B3n+dWLDQNR7zMM4XS9oDt6Z/w0PAB3Q3E+VPbaVltUoj14
 wXngo/dS2ty0PxTQExr9ehdnia/DpqNe7MD6mzjvbngwDy6fewq727U2IxNrkZAsMgJQ
 lYnomHRllcXspL1AD4nyXbMzoW/0AUjI1bAhFPAbIiaurWMNGUHMk395k8wJgipTev6e
 aZH0ff3m2/SOPNjEGDmzihui7P60oEDPcdzmLLFx14+pdjoTJHdFuvIbb4pYVntBQrvn
 x21NoDQ12ePvoKrg9cG4QXAnoFSD3jbAwC9W+/HQ2KiTiKkUYoe0D1xPPFyRcPcs/Tg3
 NdTg==
X-Gm-Message-State: AOJu0YwpCTiAlecH5dIFpWVW5oaA/4Ua3SzwWIIYBYTjWYTN7v0ss3xa
 GoBjbjIygUP2zUNqiH8tzpX/7UUMF3e72Koz8HMvv4RAkkAoz+tkfBR82/RrRtAF7ZIzfsK6o5G
 VjKIi
X-Gm-Gg: ASbGncu0KiorpJN9bf2ZVPZDbflNSeUmMLRHOG/5+eomFy+msxJqxorgD8y0U/+0Jts
 8R4oh+PTZvtjUbkaW5tqxX5BrpBQUfEqKyTiXdJ3Z4nkj58KpnejVMSUqcsd3VH422Ej315duqR
 PXZrOplCBuhhNBYytrGfDMQB+IpomZtF+0F71JVt93QOzlci4rDGC+Dk+lM+lq9VwOS8yJRVgFZ
 mSQFzssgHvmxNKk9Wvz5aUBF+ih9UFG8ILZdMZs9Fd64tmJ+GOzREsCuYOYUuwHskgJVhIQUtTt
 ga7rbCHuDycBPTS3Qrh/iTKkxFzVT/41qvc3Q+q+e6jRFUWloHVTMRo5s0l2UeDoFIL14Cj72jt
 cf7rEbwFzp7rnhds92sTU
X-Google-Smtp-Source: AGHT+IEwe8b5jnnzCvywwv/NfTJXhq3xPSB9fajBFKNNH+93WY6OSzCH5yvz6HSftRuzLGfLMP5tuw==
X-Received: by 2002:a05:6a00:2d0c:b0:73f:f816:dd78 with SMTP id
 d2e1a72fcca58-7490d6317aemr10467795b3a.15.1750549853745; 
 Sat, 21 Jun 2025 16:50:53 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 023/101] target/arm: Implement SME2 MOVA to/from tile,
 multiple registers
Date: Sat, 21 Jun 2025 16:49:19 -0700
Message-ID: <20250621235037.74091-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
index 6e212aec49..bae48aa7d6 100644
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


