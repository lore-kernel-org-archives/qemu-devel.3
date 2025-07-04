Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFK-0003kV-BT; Fri, 04 Jul 2025 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF0-00020N-9s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEw-0006oD-GO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-454ac069223so11372755e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646377; x=1752251177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U4VfuSpPgh8eD33er9pcoaEe3eova8Wr5W+gc9STpFQ=;
 b=bR1TdP48IFHqXCUjKob5dm4r7uWvRALs9K4DGQVe5XtLcuaHfMZt3uMQ8qDAML1BYh
 1uyDgWUQkvS7U6QFntmtdWUgx32Q/BADYdSWhr9wuUriO+oC6I5qvCPCCB9rCJC9oVA7
 iVVwXGkNgQx2mQN534ebjm/rxJAkLHL9ePCpKRUpKM2I439QJdxRHYoWUfBJHvSh4Lbz
 p8NNaSvoz6XyprHI1nri+OPJ5AhSE/Sm0e+y4V+YywSi3D2E4EcW2We44eZ3O//muqs0
 i2A9VqIHSFv6eyT+e4sxdbfjJPGyuoxQPIrwlA+l05C5LOAVTHooU3o3+POuLXa6g8Sc
 lrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646377; x=1752251177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4VfuSpPgh8eD33er9pcoaEe3eova8Wr5W+gc9STpFQ=;
 b=pdd0PcxuzsrcczGzCOS7ei5WQ+ZhdAfJ5mW38B0YusqTdlmBWTAriT5FssYBEpOybM
 2fpMDAK91axXfjMfiNee2XVLwmHHWUK1KnzzzAd/x+EobpXuon5+JT0s23AiFw4rk2OW
 UR9t7VNhEmxgMev+JsIejaXNyE737knzN89emOrFhtlddrw6ZOohDdGFjljIvqjBFUnd
 ox6VPmyjAB2fKSXHBBAshohmJ1sciik6qqr3dl1j74y3VKFcSB5Glxr41vbBRMC78112
 qusmoI3YIfcfyEce+dXShT84dgyTn1LBmkrOAzfIN37dtafczdU3+bKiB+OvUZsiFtCx
 h1eA==
X-Gm-Message-State: AOJu0YwRu9wK6KMOel3+6B74if2lX2CDe3uILWNEq0nFVDagUAyg/voV
 jiYzzpmC4Zejl0TSdEU3V7Vzkp3vsR+wFrzt1khinstiuU8odt4d12xadq0tqF7TKOCtIV63xzG
 7D6Er
X-Gm-Gg: ASbGncteVsObpq32KXgvz6cJRn5XTrIH7I8ucjwLjAWrtiZD+l9+Q5hLX9rRjX7lWDJ
 2+fxiP2fmZEj6IUUatF6tKCjzchm9G5+AFbP55+rCcBarK1g8EghhYmpJ4Bz8fdfgWOa3GEcbw4
 zlFrD3rmYMU4jLvWPqv10JrWFUm7p+ENzNOrL9abYV0UJ9xkRu/r7UZzWqpTrpy3ULvY/R7yiXX
 z4Hslb5Is+qYcxFEt1iEzxeNEImWKkzc9qxV8PGQPp1gtNvWGCh/LRhTWqoFDiqXt2Vy64cWmfz
 dmsi/h2XFtC5uYtO/ebRhr1LJwiSleyVVtUq0sE594cFFq80MXe3F2ZjI7Nb6X5m0r/Q
X-Google-Smtp-Source: AGHT+IF4NKWJw8zYhl8FDuAsr454qC+lMjkBz3JzIbHYVwokjH2eQ97OBeru32hKzWq687vgip6bMg==
X-Received: by 2002:a05:6000:64c:b0:3b4:9909:6fbd with SMTP id
 ffacd0b85a97d-3b499096ff9mr506351f8f.29.1751646376931; 
 Fri, 04 Jul 2025 09:26:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 077/119] target/arm: Implement SME2 ZIP, UZP (two registers)
Date: Fri,  4 Jul 2025 17:24:17 +0100
Message-ID: <20250704162501.249138-78-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Message-id: 20250704142112.1018902-66-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 12 +++++++
 target/arm/tcg/sme.decode      | 12 +++++++
 target/arm/tcg/sme_helper.c    | 62 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 40 ++++++++++++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 97428bcd6b8..06b95da3c38 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -255,6 +255,18 @@ DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sme2_zip2_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_uzp2_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sme2_zip4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_zip4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_zip4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 05d513efbab..c1f73d9f631 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -848,3 +848,15 @@ UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
 UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
 SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
 SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
+
+&zzz_e          zd zn zm esz
+
+ZIP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 0    \
+                &zzz_e zd=%zd_ax2
+ZIP_2           11000001 00    1 zm:5 110101 zn:5 .... 0    \
+                &zzz_e zd=%zd_ax2 esz=4
+
+UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
+                &zzz_e zd=%zd_ax2
+UZP_2           11000001 00    1 zm:5 110101 zn:5 .... 1    \
+                &zzz_e zd=%zd_ax2 esz=4
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2e95fe38cdd..cf0e655bdd8 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1933,6 +1933,37 @@ void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define ZIP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *n = vn, *m = vm;                                      \
+    if (vectors_overlap(vd, 2, vn, 1)) {                        \
+        n = memcpy(&scratch[0], vn, oprsz);                     \
+    }                                                           \
+    if (vectors_overlap(vd, 2, vm, 1)) {                        \
+        m = memcpy(&scratch[1], vm, oprsz);                     \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *d = vd + r * sizeof(ARMVectorReg);                \
+        size_t base = r * pairs;                                \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d[H(2 * p + 0)] = n[base + H(p)];                   \
+            d[H(2 * p + 1)] = m[base + H(p)];                   \
+        }                                                       \
+    }                                                           \
+}
+
+ZIP2(sme2_zip2_b, uint8_t, H1)
+ZIP2(sme2_zip2_h, uint16_t, H2)
+ZIP2(sme2_zip2_s, uint32_t, H4)
+ZIP2(sme2_zip2_d, uint64_t, )
+ZIP2(sme2_zip2_q, Int128, )
+
+#undef ZIP2
+
 #define ZIP4(NAME, TYPE, H)                                     \
 void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
 {                                                               \
@@ -1967,6 +1998,37 @@ ZIP4(sme2_zip4_q, Int128, )
 
 #undef ZIP4
 
+#define UZP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *d0 = vd, *d1 = vd + sizeof(ARMVectorReg);             \
+    if (vectors_overlap(vd, 2, vn, 1)) {                        \
+        vn = memcpy(&scratch[0], vn, oprsz);                    \
+    }                                                           \
+    if (vectors_overlap(vd, 2, vm, 1)) {                        \
+        vm = memcpy(&scratch[1], vm, oprsz);                    \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *s = r ? vm : vn;                                  \
+        size_t base = r * pairs;                                \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d0[base + H(p)] = s[H(2 * p + 0)];                  \
+            d1[base + H(p)] = s[H(2 * p + 1)];                  \
+        }                                                       \
+    }                                                           \
+}
+
+UZP2(sme2_uzp2_b, uint8_t, H1)
+UZP2(sme2_uzp2_h, uint16_t, H2)
+UZP2(sme2_uzp2_s, uint32_t, H4)
+UZP2(sme2_uzp2_d, uint64_t, )
+UZP2(sme2_uzp2_q, Int128, )
+
+#undef UZP2
+
 #define UZP4(NAME, TYPE, H)                                     \
 void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
 {                                                               \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d413efd20e7..d52ccf2ac55 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1507,3 +1507,43 @@ TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
 TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
 TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
 TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
+
+static bool do_zipuzp_2(DisasContext *s, arg_zzz_e *a,
+                        gen_helper_gvec_3 * const fn[5])
+{
+    int bytes_per_op = 2 << a->esz;
+
+    /* MO_128 can fail the size test. */
+    if (s->max_svl < bytes_per_op) {
+        unallocated_encoding(s);
+    } else if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        if (svl < bytes_per_op) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                               vec_full_reg_offset(s, a->zn),
+                               vec_full_reg_offset(s, a->zm),
+                               svl, svl, 0, fn[a->esz]);
+        }
+    }
+    return true;
+}
+
+static gen_helper_gvec_3 * const zip2_fns[] = {
+    gen_helper_sme2_zip2_b,
+    gen_helper_sme2_zip2_h,
+    gen_helper_sme2_zip2_s,
+    gen_helper_sme2_zip2_d,
+    gen_helper_sme2_zip2_q,
+};
+TRANS_FEAT(ZIP_2, aa64_sme2, do_zipuzp_2, a, zip2_fns)
+
+static gen_helper_gvec_3 * const uzp2_fns[] = {
+    gen_helper_sme2_uzp2_b,
+    gen_helper_sme2_uzp2_h,
+    gen_helper_sme2_uzp2_s,
+    gen_helper_sme2_uzp2_d,
+    gen_helper_sme2_uzp2_q,
+};
+TRANS_FEAT(UZP_2, aa64_sme2, do_zipuzp_2, a, uzp2_fns)
-- 
2.43.0


