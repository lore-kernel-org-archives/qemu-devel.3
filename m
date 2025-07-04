Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B59C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOW-0001bM-I6; Fri, 04 Jul 2025 10:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLf-0003pR-Pt
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:08 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLc-0007el-66
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:07 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-60bd30dd387so544817eaf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639102; x=1752243902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgZFObJDubZE1j7sV9iROMi6HrLs2MxVlYNMSaM5isU=;
 b=ohvWpfloYJtXRSvspO9WJFLJjZGM9BXVRB80iwf679SHtnYgkG7JLlUVh18JXLp8DO
 H/dwIcXXreilQnCmgCSXzhMgze/ObDvrcv5cTdWm5dDfi5xf4Pd2b1BSQNGzz2ChTxw8
 U039Hdd0wUaP84t7mY4+WJg483A+W6RtLHe9vELap1QrGBnmR8wGZeN8oDUmzE1NLriJ
 rk3F5ceDzVIe+9OktTvLvWv3MCAWkbu2SOyW6PaQr4sNLEkma+58xJ6pMyIu9OMnVZB6
 Xafv+7ZGxHJfcgWs+t68JUQq9MdhLvGQQvTJGS36TZx2Ij02txc8a9HmFA7CNmkajNGd
 if0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639102; x=1752243902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgZFObJDubZE1j7sV9iROMi6HrLs2MxVlYNMSaM5isU=;
 b=wMN7PapVHoQH62yKoJkg/Ee/XfTVgS67fHqxHZTHqUD3OvdCJw1GPzut/mp/dGg3vp
 7KtO9qk+UTH4nl+q8wIalGfONUgAcoMJWRbjtacOAqKvaooL7xK98cCugwd/a7lUnjrK
 oac+Bg5YrCCtmrbD2Cg4o+wAKIoyWD4lRxwJdxhOoI6cuIH+BaSh1lTV+dClleSEWpKw
 S81QXNxk9yrdOxW6HZxo7n65C00fdZtv0sfVS9A/+VCQBi3UBdDRRvI3BJsC8gWx+D6c
 Q91v7yhsG2uyqyZOIPw3ykuLMO8CbTwVsO9Wkkc0nOY6MHpKicsb4k1wxVch1m7iZSfD
 9nHA==
X-Gm-Message-State: AOJu0YxbqfxQK3jLEUeeDYPXp+roA+rhxOKcvCUyShCAhZ+mn8YyVY6k
 GcC8VBymQMSdqlFbzsabU0jnuIwi+dzakXhj8LMk6FPVl7kXmNoRnbmouD1fiTiTgMMSpgdBtxa
 ngjuepOo=
X-Gm-Gg: ASbGncsnWLogvk3x9gMgX7pA9vIRZXhTRDABCK5Dtkl61tMgErukqWyW3OfW3w1C/GY
 JjFmUum+DHS9YqGHwcSKa2PzvrUG2Oa5R28DscqexGePorK0hGwDIzNIlI3Wpikulf3K32dl9bn
 ZZuWazhT3DiZovYEBgF5zZN7BqHDXYwaK7IMBpF0N9DhYK9sbQqE910HuzDDlUU685heSCzeFln
 P68AbErl2OzDxAmo0jPtgi7y/wRL8roBifq1NcfNQwTGYodTYfFli/TbLTre9Mb/7SA4UD9WTqi
 IajFovh38VklGiSR8xzgye1uEkAaV8KAFoueJTXo1rfL4pWVzvyMbYnzTNCiAgVjIbsCjCEl0d5
 DDkElgOqzIPzu1WWAtsIZ3+cAwmfYZHLW38DopqALg3xFS7hm
X-Google-Smtp-Source: AGHT+IE2de980Git2wBIp9YtUYHWvbV8CCmd8rO+tXlvv8Q3GgssRd0pffKtGID3owgRqYfWHGyhnA==
X-Received: by 2002:a05:6820:188a:b0:611:a921:bfef with SMTP id
 006d021491bc7-6138fdea0f0mr2094778eaf.8.1751639102538; 
 Fri, 04 Jul 2025 07:25:02 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 045/108] target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT,
 USVDOT
Date: Fri,  4 Jul 2025 08:20:08 -0600
Message-ID: <20250704142112.1018902-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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


