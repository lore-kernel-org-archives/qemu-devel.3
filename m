Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1250CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEp-0001Qm-Oj; Fri, 04 Jul 2025 12:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEd-0000qA-Gq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEb-0006Pd-HK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so927243f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646356; x=1752251156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=alK3uxpB9fD9dcl1bRliEs1QlpejJNntl6nN63sqGLs=;
 b=ttj8B0A4qQkZn/KldiS0TmMFGLPLzsd/ILX1JgvA9b/OKf5dn74gBnrkOt7SO4j58G
 31Ejjz0DIOMmiES89X6pWNqyjEsT7loK8IKhb6RYdOsnhT/ndAFJMZ3ENobJOSSL5Lfo
 JEoES9+rj5raReb70qwzGTYEBVOjHXhGnYp+FNUzu/0UxnLZdTAWol8MjrgjURAEJ3Ck
 MNep6okbIh1+JJQH54064te+OFSrXsE//ns9BznjxpfLZ7xVIbQoPlQwLvMnvOxWYU1J
 0lWJSG+4xqbRs2tZUDptA96IfE0uYl3ODUIEpiqqVJFI1jWv/sIjB7dAXbo1+r+Ek/1L
 v0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646356; x=1752251156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alK3uxpB9fD9dcl1bRliEs1QlpejJNntl6nN63sqGLs=;
 b=X77J677KXcHU2dHztPHkqRnwocDGpF5/SbMKfB6HXCUUwhzTucm9YpThoZrxAdyv3G
 4pMI/1LpJopm3iAReITlYKgWtgc2hedGlP7GQuuoRnrfNyD8beqhDxkHCznsFOXh6bg8
 4RjeM9FDt2shv+6KBhkoEadDO5tSGlt03H/d/TVPn4pKXkINLV7b4xxuTxciPSuCvWGq
 eMkA6XYxl+Yf1XC3FWZ/w2xEZ3o7fc89iDKH/ZOvFOfkv+RR1g5iYwVC4+acAbK/KQaW
 yxe9FcoK1xbOix0MvpJctHjViqwpgycM29o/rQUxpvg3NVdPSHVwzaSSborGb4AHUPvx
 yBKQ==
X-Gm-Message-State: AOJu0Yw/NeWuurybTNWu0fpckIOnPBCyNTbLtQ1JsoTqlYbQX50+jmtk
 jYbfTa1BKC3IouXGBCz+5Brif/2E2x01vpmedahKtuo1NJMLbPn0Ln0mIxEPe/krJ0X77c2bMfC
 XDVMb
X-Gm-Gg: ASbGncupS5Lm+hWu5hZcR/bUKJ2QCmEOzCedddDvwOky7/b0zPtF0UzVyqae9FfLRVL
 B9D0TM8B/ExcQcGLqc4ReIomNVXwAxp/c17iXfEeU8hAr8/Wb4EAxE6LAHw4ZMNyJs22Pz0c5G5
 0HgI4E/C1VCibBrT9VGlYAcslZSOcoUu23Uu3CBPpVahcG2vJz+PWTxBu/XHvD2xuMqyaNqdzKV
 O2p6/cJpQO4Adx2qJBD8LsMLSA7vzWLRB2wBr77AkNdM3RaFF5lszXl9NkExgaFBdgtf06+ScRT
 LW7Xgo0+JOfLGnIzSLYx7VmCq+F0TvaFDNjRmxIvR64ruHsmbebiOJ0GwRWH4UmHD8yy
X-Google-Smtp-Source: AGHT+IFv4i2Ik8lMNjZmYQr72FzULwRzHPlDbIz9oaPpSmtF0GO1SEBDxp22lqN5mKXXqt4PEOUnwQ==
X-Received: by 2002:a05:6000:4207:b0:3a4:ef33:e60 with SMTP id
 ffacd0b85a97d-3b49661d63fmr2444101f8f.40.1751646356020; 
 Fri, 04 Jul 2025 09:25:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 057/119] target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
Date: Fri,  4 Jul 2025 17:23:57 +0100
Message-ID: <20250704162501.249138-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
Message-id: 20250704142112.1018902-46-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 11 +++++++++
 target/arm/tcg/sme.decode      | 11 +++++++++
 target/arm/tcg/sme_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8f5a1b3c908..464877516b6 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 338637decd6..4146744a466 100644
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8b458654612..f5242d99bed 100644
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
index 341f4495e92..b88f439ef9d 100644
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
-- 
2.43.0


