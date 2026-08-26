Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C486CC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeX-0000iF-IU; Wed, 26 Aug 2026 13:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe9-0000EC-Sn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe7-0004sR-BD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso151541b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766160; x=1788370960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJ83ukAktt+ErEtZMU9oLoeoJZPG6BepLZk3A1SHS74=;
 b=i+cLOtsaDkMCZaOCX4DzhTDKXF5GG+qREaYJ7al4uRX2e0gMWsXs54w+UYarbVrv14
 mwrkLdQDilg4Bq5GcPjeqbxD6+2TomdiOSa7AVCpB7OSPwOMOm/svUgJ9N/SLB9Xj5S5
 RadQ90gxtW1Aen1/igwz0EcPQaezP5Y82xzgNiDfiK082b85/lX2wGiiU4U+LnMES02R
 fB+hP49SLP7eDhA5CM9Na2cmY0n+QF9zLNoesMhc845ITNRfJ8xLzNZyZWu+JlGjoY5D
 MMFA32JNnfHbiEZJC9mI7HxVPgEfVYNs2nMDO4AsOpbgpwDazR6gNL0W1On1HKyVQ18a
 hFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766160; x=1788370960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BJ83ukAktt+ErEtZMU9oLoeoJZPG6BepLZk3A1SHS74=;
 b=rrkOi1SiSy2O1B1gbBRxrBrXGIxyEcNbXXd+NF9ybo6j/cqaugACmIRQlzTpLZK64J
 RN9ikXQ83X0kRphrzOTKQ9AX17yArXrHbOY3QQei+6qQK8B1PAwNKyOklqsSRHAvUyBW
 fem+869+BnjxZVfHT91Pw7zt+pHo+YTFHkwa7W2IZRleNGfF7y2CYDrC7l/IszIlBSbA
 u1O/pm7HKyDmZKOJTOIiFs5ieCBV1dm0psOdtaFSFuH30XC74FhM3vO22hHBxHDtlnFf
 ns6ebL5kKPdbEL5REeX5K3xjm8TS/r4pss6PUbPCc9/G+n6T5c8WOy3zyWSMf6Eg7/Uk
 6Xug==
X-Gm-Message-State: AFuF++mImgjZ47AR9glorqGhYWAAfCztSUz9CHYyMT+ufZhNzGfN108a
 x0ztjvzURfYYvh+zAyOcThyn5nM9IDwP9Is6m9Mh46Ti5sqIVN9zyGqShH3sE7rGyFaeQCK5z2C
 9RHWD8U4=
X-Gm-Gg: AR+sD13Vh7I/o5jbe92eVYj/dn/z7KZ+3MEpxgLS8p6IuOS54y0y1ulo9hoqY6N3QJ5
 L2mhduaHOrLHbN8sE1JljobY05DWwUpQckbxg5J8GFWco+GgSfYxTtF0qSf1KE1NP97avAyKcvb
 yuWY7iPhFD84O2z/cP4lGyFD7K0tBkyZXo7a6h/uGhWVKDWMGlKglHEgXqrAlmnenHrkttOz7rj
 eN3OwQYopKMg3Ns3zn7K/TuO9CtMNFETgP4rNV+X/Uz61NUg8+wc/0EFphdNnwSfSKtX+5K6O2V
 +Z4SCUK4GDfbWs1n6L8UWIB3o5DZ/uEgIPpYgcc8XfaLDC11NX3/Yjf28VTllD2oN+w5ZYuH3vX
 SHtZ04KNYjP9Z2oN4TdmRPI9V5dGlDD8AvO4oM0coRflaQDwm1ps9veIcs57A4rI4bxiyFWKMmB
 T1IOgdyXv9g73DrGPquSWAhrHui4oZehgV93JL8XyxnSYTvqSlySf1IdrlEB2lCiSalBuJrz4c/
 OJ/VzWGy2WcVhvVnrA=
X-Received: by 2002:a05:6a00:1d89:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-854c648573dmr1011054b3a.1.1787766160240; 
 Wed, 26 Aug 2026 10:42:40 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 22/25] target/arm: Implement AESEMC
Date: Wed, 26 Aug 2026 10:42:09 -0700
Message-ID: <20260826174213.614571-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/crypto_helper.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  2 ++
 target/arm/tcg/sve.decode      |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 1a0e4130aa2..512054d2f5d 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -460,6 +460,7 @@ DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesemc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 05f193b3d17..ae677cdf209 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -193,6 +193,37 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            AESState *ad = (AESState *)(vd + s);
+            AESState *st = (AESState *)(vn + s);
+            AESState t;
+
+            /* Like above: Arm AK comes first; api AK comes last */
+            if (HOST_BIG_ENDIAN) {
+                t.d[0] = st->d[1] ^ rk.d[1];
+                t.d[1] = st->d[0] ^ rk.d[0];
+                aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+                ad->d[0] = t.d[1];
+                ad->d[1] = t.d[0];
+            } else {
+                t.v = st->v ^ rk.v;
+                aesenc_SB_SR_MC_AK(ad, &t, &aes_zero, false);
+            }
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 /*
  * SHA-1 logical functions
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cb1542f3931..64ff2345307 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8346,6 +8346,8 @@ TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aese_idx)
 TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesd_idx)
+TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesemc)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 1ab1b4042b5..5832e0190c6 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1988,6 +1988,9 @@ AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
 AESD_idx        01000101 00 1 .. .10111011 ..... ....0   @aes2_2
 AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
 
+AESEMC          01000101 00 1 .. .11111010 ..... ....0   @aes2_2
+AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.53.0


