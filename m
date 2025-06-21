Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F3C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82d-0003B2-A8; Sat, 21 Jun 2025 19:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82R-0002Gx-48
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82P-00058l-4d
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1423939b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550060; x=1751154860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OSVV3WollObc7VnRR0yfI2XAxEDOamGWZSaHRKwlBFI=;
 b=bNTrFBcfPm47asxMBL3DNEM1CEw1QgAO5AK9UPypIh49dewMy7ugpz6h0fkCs64FMC
 UJhgcebQIWEAg90O1mZCEG7/P/aUBePT+W/zWZOxGf2CW4qJpZdPicl2F5CcplLUG+xc
 pLINnaHy7zJjtqFgP6UBti7xGu9VdoNYdx+K918sdib6kMTiPCyYkMVpvPdUbPuB9Dm+
 odxnYDHWZOKpOlVyQPpWJzPrCoKmBUtjbH0ozurxfQeCmH7hBDQJ1zns17lYbF/+h4Y/
 WLu1OpTNoYNcm1OMi7bk+Kadan2l0YL99vkEjjVDBAM6ucyZ4H4SwO8BYkStOSxXAlPM
 h83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550060; x=1751154860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSVV3WollObc7VnRR0yfI2XAxEDOamGWZSaHRKwlBFI=;
 b=Oq7DIsuTMA1YxvMdrh7S/koaK/weXWcpDHdXpYBkV2x5ab3+GvGqrWGjM5xA7iJFc1
 ra2fVikDqLBPcaKA78B2VcaacK9FgnSD0iJXZNNGNqxSrFT3EwhP4Xod9EnZR3itG6Or
 ULCKcSxC+KJ+UyyqsMhJnr2Ctwkm2AHEO+BrQmvtzJgCiS8NLL15IYIaeIJxR4m0dAEj
 dxOVezff+1Tt3qp/aBIfjOMszDWKY0aJM04KaEm62QUn15K46ML15ofdGri4kBxUh4HT
 FGKVqq8vq3QG1X9z/2x/UEc0hHjZsaKRgm6hcnqN2VVRK/AHl0k9GcG2EUBP0ne8Re7h
 4DOA==
X-Gm-Message-State: AOJu0YzEm7nRpnFQWuwq4rH9iSV6sLYETFCCtE6iDeudyI1apRvmEBmR
 3b0eQUV+GT0eWulOM5SS/Vc1a0QpDGGu3Wbyii6S5nmNBTqspfsiekLJs+NwNvYLwPWO2lSn58+
 3GqsceXA=
X-Gm-Gg: ASbGncsPJ981nI8/6+mr5hEKfE9RtaSxxLnKr3UIpFnbKwvSMG7Andi+pJ5fOmxmG9D
 nyVYEOvFSb1LaOmyUwn7SIr2Nxe+HZJbdIL/w4iOBHWNZjn4K/lJhOPTUI76Aabw62CtrR4IPah
 1CgRm3xZ46+IoeKG99tUdLQYvuqa8Y9JILiOyjqv491sIwkv0/mleR2RNitixYp4wib29XWlc9R
 pX/qJP3oQdLyJQdm4IAlL2gLmJeI0+avBf46abszoS4fkU4gkLLaKfOQzupOtAJUC1f0vFarFzv
 0ERtlRp7X+tJbZWmPh7zIWGvFIDsZULsA3Q4griG/RgRdpmldmA6DbgOJaQRdC2QbWHTfCnRDWd
 ZQ9q6LEHwWMiIbTVh3+Bl
X-Google-Smtp-Source: AGHT+IGTvgTF3G1D8fi9o8gmvYSVokeLphqw0mLpq/jteAVYG53L5sxsnaFvRYXWFPsUsBHTU/7tRQ==
X-Received: by 2002:a05:6a20:6a25:b0:1f3:418d:91b5 with SMTP id
 adf61e73a8af0-22026f4d03fmr13423908637.24.1750550059780; 
 Sat, 21 Jun 2025 16:54:19 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 064/101] target/arm: Implement SME2 ZIP, UZP (two registers)
Date: Sat, 21 Jun 2025 16:50:00 -0700
Message-ID: <20250621235037.74091-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/arm/tcg/helper-sme.h    | 12 +++++++
 target/arm/tcg/sme_helper.c    | 58 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 37 ++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 +++++++
 4 files changed, 119 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 3e878a2ed3..118cb8a7a4 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -254,6 +254,18 @@ DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index a3ef8770bb..76c8ee0448 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1875,6 +1875,37 @@ void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define ZIP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *n = vn, *m = vm;                                      \
+    if (vd >= vn && vn < vd + 2 * sizeof(ARMVectorReg)) {       \
+        n = memcpy(&scratch[0], vn, oprsz);                     \
+    }                                                           \
+    if (vd >= vm && vm < vd + 2 * sizeof(ARMVectorReg)) {       \
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
@@ -1909,6 +1940,33 @@ ZIP4(sme2_zip4_q, Int128, )
 
 #undef ZIP4
 
+#define UZP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *d0 = vd, *d1 = vd + sizeof(ARMVectorReg);             \
+    if (vd >= vm && vm < vd + 2 * sizeof(ARMVectorReg)) {       \
+        vm = memcpy(&scratch, vm, oprsz);                       \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *s = r ? vm : vn;                                  \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d0[H(p)] = s[H(2 * p + 0)];                         \
+            d1[H(p)] = s[H(2 * p + 1)];                         \
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
index a7deb67d3b..675d27f428 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1431,3 +1431,40 @@ TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
 TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
 TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
 TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
+
+static bool do_zipuzp_2(DisasContext *s, arg_zzz_e *a,
+                        gen_helper_gvec_3 * const fn[5])
+{
+    int svl = streaming_vec_reg_size(s);
+
+    /* MO_128 can fail the size test. */
+    if (svl < (2 << a->esz)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zm),
+                           svl, svl, 0, fn[a->esz]);
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
+
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 1857f3c1a4..dc762e262c 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -847,3 +847,15 @@ UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
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
-- 
2.43.0


