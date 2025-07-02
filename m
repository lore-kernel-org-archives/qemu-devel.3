Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgu-0000ps-86; Wed, 02 Jul 2025 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgI-0008Ex-AR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:18 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg0-00018J-MA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:18 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so3907920fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459696; x=1752064496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgZFObJDubZE1j7sV9iROMi6HrLs2MxVlYNMSaM5isU=;
 b=SMqQYvifRn2xKuI4xjQBiUuRZuAH59bn8ivikt6+yLdUYf12OEoTGrz9Tjs6mSWLS2
 4AxcDuC3vhb5cjOv9bnzyzucdRhUwggcFHdkJAOgdTXE0y4tXHP00nhU4jHbytOfTFb/
 jVurcQnHuMMFY/tbJnHbnHS9uafE3uYBGWDN0QNFKP3U8buew6H0C8JB9CmJxoH8/yOB
 J5nTnnNYviJ/mPGmFP9u+yWt+5AB4cW50ntIYAtSn1w2Pqr0khNfFLaGMLbnvPLwsiEK
 bnSEL0if0hmH7a+YYc0chnZJJVdgflRW5xJ2hRyLGbeYqKEM4ZJxahJhzrc4z3Z5zEFP
 tLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459696; x=1752064496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgZFObJDubZE1j7sV9iROMi6HrLs2MxVlYNMSaM5isU=;
 b=bAxPonfwcIfWfkUnQqKsBdUbIvIzxlzGBq9yk+XruxHPUGxgKbFm+IaPwrhkWPMgw5
 Bi9wL/ceoQd2IBEyZcTWJGLymVdfYupZc6pzEDmSqoMyueX8JM3SsQjksR3tw1NSxO8s
 euiqfaeHMIn8vgTGJmCFmET6HOMMK+sCmDPTvC2wUTqHkHpJDoockxYxHTNgAIOdZb4T
 kKf6kiR/kQVBinJj0CH4v0gBU2f3UxqVSpPu/VGe1E5UJE8yJ2HypQF4cSxy4RmHv/s9
 0sipZLf4WDMEkAlYhDRj6GmWnTswHvj1Y1gx7q46O4VHCoeoCehRuBxWnChRbyJx2cYt
 rWoQ==
X-Gm-Message-State: AOJu0YyY0SBh1vbEVeyEzHHCrG/bffM/zQ9+GUvL35KpT4YcVYGF4wu3
 LbZFrzY01PzRDDcPsScf+U99EQmarIZ7mXESSdlBOQPeI5RNohkhfkE/FYyJqMoskB4Rrj6n0Df
 mhDsIqUM=
X-Gm-Gg: ASbGncu7IdfP5eznHlDlEM6mtwuEM5zVTH9p6zkwYMdVr5pVlpWmuNWcxGJJjEBAIfj
 5WiWdHoD8mqq45Lep3+JeYYsfWTXoZHtC+Qn8ZPQRO69asbfY5voCmD0e3KLb6vLOZ6nkZsHPNS
 NdoKcEFuA1o8Qm2ez100DVPEJ8iQ735w3G73eoXJb2Sr0Oh6ZHS47l+x3mzrHDZKwUKt5z38t2h
 WLx6ZYV3t+7bw6eKBMM4Q9Tj4jn0LfTqAgFvffJXtZHMMeTqZEzlWKOBIj+3tX0iVb4lUcLYDsB
 nD9MhTOSGqqy5w+qcpJpqVtLaBFzaCj+kByDZgbC5908BiIugss8LzjZQkI9oETEJOeJuw==
X-Google-Smtp-Source: AGHT+IG2ONIgnr4oDvTcvefs0Y2wkQCj8AfXY+r/jzv/+N5py4bHjaT9bBD4DzVWW0h5eU8b87eplA==
X-Received: by 2002:a05:6871:650e:b0:2ef:eddd:690d with SMTP id
 586e51a60fabf-2f5a8ab9053mr1750299fac.24.1751459696011; 
 Wed, 02 Jul 2025 05:34:56 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 35/97] target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT,
 USVDOT
Date: Wed,  2 Jul 2025 06:33:08 -0600
Message-ID: <20250702123410.761208-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 11 +++++++++
 target/arm/tcg/sme_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 11 +++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8f5a1b3c90..464877516b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -180,3 +180,14 @@ DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme2_fvdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_suvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_usvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8b45865461..f5242d99be 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1416,3 +1416,45 @@ DEF_IMOP_16x2_32(umopa2_s, uint16_t, uint16_t)
 
 DEF_IMOPH(sme2, smopa2, s)
 DEF_IMOPH(sme2, umopa2, s)
+
+#define DO_VDOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD, HN) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)            \
+{                                                                         \
+    intptr_t svl = simd_oprsz(desc);                                      \
+    intptr_t elements = svl / sizeof(TYPED);                              \
+    intptr_t eltperseg = 16 / sizeof(TYPED);                              \
+    intptr_t nreg = sizeof(TYPED) / sizeof(TYPEN);                        \
+    intptr_t vstride = (svl / nreg) * sizeof(ARMVectorReg);               \
+    intptr_t zstride = sizeof(ARMVectorReg) / sizeof(TYPEN);              \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);                   \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m = vm;                                                        \
+    for (intptr_t r = 0; r < nreg; r++) {                                 \
+        TYPED *d = vd + r * vstride;                                      \
+        for (intptr_t seg = 0; seg < elements; seg += eltperseg) {        \
+            intptr_t s = seg + idx;                                       \
+            for (intptr_t e = seg; e < seg + eltperseg; e++) {            \
+                TYPED sum = d[HD(e)];                                     \
+                for (intptr_t i = 0; i < nreg; i++) {                     \
+                    TYPED nn = n[i * zstride + HN(nreg * e + r)];         \
+                    TYPED mm = m[HN(nreg * s + i)];                       \
+                    sum += nn * mm;                                       \
+                }                                                         \
+                d[HD(e)] = sum;                                           \
+            }                                                             \
+        }                                                                 \
+    }                                                                     \
+}
+
+DO_VDOT_IDX(sme2_svdot_idx_4b, int32_t, int8_t, int8_t, H4, H1)
+DO_VDOT_IDX(sme2_uvdot_idx_4b, uint32_t, uint8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_suvdot_idx_4b, int32_t, int8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_usvdot_idx_4b, int32_t, uint8_t, int8_t, H4, H1)
+
+DO_VDOT_IDX(sme2_svdot_idx_4h, int64_t, int16_t, int16_t, H8, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_4h, uint64_t, uint16_t, uint16_t, H8, H2)
+
+DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
+
+#undef DO_VDOT_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 341f4495e9..b88f439ef9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1047,3 +1047,26 @@ TRANS_FEAT(SDOT_nx_4b, aa64_sme2, do_dot_nx, a, gen_helper_gvec_sdot_idx_4b)
 TRANS_FEAT(UDOT_nx_4b, aa64_sme2, do_dot_nx, a, gen_helper_gvec_udot_idx_4b)
 TRANS_FEAT(SDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_sdot_idx_4h)
 TRANS_FEAT(UDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_udot_idx_4h)
+
+static bool do_vdot_nx(DisasContext *s, arg_azx_n *a, gen_helper_gvec_3 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        fn(get_zarray(s, a->rv, a->off, a->n, 0),
+           vec_full_reg_ptr(s, a->zn),
+           vec_full_reg_ptr(s, a->zm),
+           tcg_constant_i32(simd_desc(svl, svl, a->idx)));
+    }
+    return true;
+}
+
+TRANS_FEAT(SVDOT_nx_2h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_svdot_idx_2h)
+TRANS_FEAT(SVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4b)
+TRANS_FEAT(SVDOT_nx_4h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4h)
+
+TRANS_FEAT(UVDOT_nx_2h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_2h)
+TRANS_FEAT(UVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4b)
+TRANS_FEAT(UVDOT_nx_4h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
+
+TRANS_FEAT(SUVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
+TRANS_FEAT(USVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 338637decd..4146744a46 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -438,3 +438,14 @@ USDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 01 ...   @azx_4x1_i2_o3
 
 SUDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 11 ...   @azx_2x1_i2_o3
 SUDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 11 ...   @azx_4x1_i2_o3
+
+SVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 00 ...   @azx_2x1_i2_o3
+SVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 00 ...   @azx_4x1_i2_o3
+SVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 01 ...   @azx_4x1_i1_o3
+
+UVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 10 ...   @azx_2x1_i2_o3
+UVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 10 ...   @azx_4x1_i2_o3
+UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
+
+SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
+USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
-- 
2.43.0


