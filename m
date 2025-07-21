Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ABC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYr-0006xo-IQ; Mon, 21 Jul 2025 09:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYM-0000Ka-6R
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYI-0005Ja-P1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso30305015e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104450; x=1753709250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=60MbsbkAK2zpO61hgALxIWvnCBXQLORY/0j3sPXYAtQ=;
 b=Hj3/tUNADTXx023ExtE/fTWy8eLttOQ5P/gZnxAVYE5tOd37egGbRMCpILDqYIJX0j
 imBxukQyVF6QtzVTVp42dy+B8BMxYwKa2mk8aBROsKBCKD0MaikUtOqAPBJFlRWTSBa6
 ZuOt1c71qMxxrbQPNUSSHKp2G1MTUkkHQqD3jr/CfQT4bnEGT2q6HN1APz8ackJhxfwQ
 6iy7I0YaCEXdjdX3bYbXIu9N1FefxpgDylSxBzqBJ9o9h/zcBlgZGcuu7ug+FIOEVfzj
 g4taKSdI3JscnnkJfTq49vjpccYxCWO+2brvEKAYx10u3MWPIF+c/3ZmTd7ezIe22PAv
 V+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104450; x=1753709250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60MbsbkAK2zpO61hgALxIWvnCBXQLORY/0j3sPXYAtQ=;
 b=IYAcidyYzZjSpVq34rfa/EWFusYbzd09RQBEFWcs8pRIWDZS0LmB0+xuBNjVNFfm6o
 cCSs4ju98w83LF+wWqKUGReCLXl14W/0NiVjNDYqIbSRH6YB6cfZGHFEC6yTAOaimxAm
 sRHLL34D0Ah/Jrinpb0SqBXMvE/Tv6BE+Amempp2GlFPMI/H90Uki9tzahi657Kyka00
 M+qQkOAwLyoWDCMK7xQqb05oBH1GdZ5i98O/gv6LzoMzoWReEoY7bNTznQU4Yq1FKjLE
 YuSoNFCq2/qZRRYvBtX5VON0pp71Yml0V6bMyMlm/bLgjn02dU1t5e7fRmlkkbSp3w+e
 icEA==
X-Gm-Message-State: AOJu0YxMO+Z6SxBIiyQ/EaO5qRAXg5aWtsMl0WuaANXzn3UyzUXVl49n
 8gXjZ3GLKmPK/dw7Btdsa8gWHxT74dxw0nS9fTUWfsXPpshf67YcNh/yyf40cW5QOXKwDvx0Ggo
 iWmTP
X-Gm-Gg: ASbGncu31GchiT+S4asgHTKajxx+wgQhR/mTRIDolLy+S5qKi1Nq0xfUT6zP+GfBcGW
 pL9JZkVbXuoADx5paPfNTqMVSEvdW9LvwwDD/6RpmthW5mj2SMRhJe8Jee3q1+L1fah5vXW4TRl
 BO5I4b2HuGXxkn+rK3rKKDb6P/WSdxW4/SPEFwor2xYt2SfhKDVnkh4Cb1NUbSrkbJ20sEX/mZ9
 3jP33KOAH4C990tVIyZ1pWakGFNXJkDH5gXGvNS6udGM0hKYpmPqrrUCKJ2u95NU+N+ISOKgwjZ
 8pYGXEE2VzAY/8I/1VfyV6snIhMYxSuUSy9NKetYt4UmNmdLqUaBfF1Xhl+nT3Dbx7z6CEka9Zl
 3yayC850n/soi3Nvaa/dj4jaGiurM
X-Google-Smtp-Source: AGHT+IHNTASwYuis8daqtfiH7k0MraeyDtAt/CiVufa+XYBmjqLDAAsOXyhcTeqZmqubRJNvR5IMag==
X-Received: by 2002:adf:b650:0:b0:3b6:136d:55de with SMTP id
 ffacd0b85a97d-3b6136d55efmr10206326f8f.7.1753104450422; 
 Mon, 21 Jul 2025 06:27:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] target/arm: Add BFMUL (indexed)
Date: Mon, 21 Jul 2025 14:27:08 +0100
Message-ID: <20250721132718.2835729-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

FEAT_SVE_B16B16 adds a bfloat16 version of the FMUL insn in the
floating-point multiply (indexed) instruction group. The encoding
is slightly bespoke; in our implementation we use MO_8 to indicate
bfloat16, as with the other B16B16 insns.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-5-peter.maydell@linaro.org
---
 target/arm/tcg/helper.h        | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index d9ca5b7c56e..4da32db9021 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -823,6 +823,8 @@ DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2efd5f57e45..a76f2236f43 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1062,6 +1062,7 @@ FMLS_zzxz       01100100 11 1 ..... 000001 ..... .....  @rrxr_1 esz=3
 ### SVE FP Multiply Indexed Group
 
 # SVE floating-point multiply (indexed)
+FMUL_zzx        01100100 0. 1 ..... 001010 ..... .....   @rrx_3 esz=0
 FMUL_zzx        01100100 0. 1 ..... 001000 ..... .....   @rrx_3 esz=1
 FMUL_zzx        01100100 10 1 ..... 001000 ..... .....   @rrx_2 esz=2
 FMUL_zzx        01100100 11 1 ..... 001000 ..... .....   @rrx_1 esz=3
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 27af3df9a4b..918cf6e1bd4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3907,7 +3907,7 @@ TRANS_FEAT(FMLS_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
  */
 
 static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
-    NULL,                       gen_helper_gvec_fmul_idx_h,
+    gen_helper_gvec_fmul_idx_b16, gen_helper_gvec_fmul_idx_h,
     gen_helper_gvec_fmul_idx_s, gen_helper_gvec_fmul_idx_d,
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 76a9ab0da39..33a136b90a6 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1785,6 +1785,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
 
 #define nop(N, M, S) (M)
 
+DO_FMUL_IDX(gvec_fmul_idx_b16, nop, bfloat16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32_mul, float32, H4)
 DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64_mul, float64, H8)
-- 
2.43.0


