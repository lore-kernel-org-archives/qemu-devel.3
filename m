Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49480C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYd-0002VO-0o; Mon, 21 Jul 2025 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYM-0000Kd-7h
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYI-0005K6-Pi
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so2478847f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104452; x=1753709252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xNYbFXcxNOECXlHwPuWcDJo9Biyy1bfORUt4orh1o4E=;
 b=l4vk+cEsEqIZ2S457k7FBkttRUnM2EU6w4YQaDBdOG80OHxV+WqlFoIY+fG0yIfoM3
 iWkqQVRUWtZn0sK5Wz/wFDhH1FDTvlg1FlM9NVlTEEgNi45Hn5E286g7pFTbU9tZeIKG
 CZKk7E15wWNtf5r7/9XWimvIlwYZe+GD2ZAR68g40TtShmP5XKei19n4HYyxPpqDG0RC
 Unsuuh6HX1RZHWdDa19WNWBHWU7NNknAhV1eSGiS4edeuqYabUW5/zWUs5oCnzXG7Te6
 mEcqqi94Gtc84vWeYVeMuWU+3V11A9Te/O0qvg6NKSskLEASKkFCI0cZi99b7WcZHtUT
 w++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104452; x=1753709252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNYbFXcxNOECXlHwPuWcDJo9Biyy1bfORUt4orh1o4E=;
 b=nK2LdcssvORgYnMCtEIN2EGEXS/aUBUF56dY/GGUPjJs2lsyqIh629ueT4uMM8XKbC
 TgCosyHHCkAemYGcI7yIZfd4KVTTlq538VdQmtbAAQIu7SG+oCQUiFHsfSIC3N01xGV8
 ksrU+yta5rjZlDZwVZOb1y3oQFB9wfSfPNhWqaquAY7mNRc6QqDQS3mrJRcrrLWtIvKQ
 e3zeqfCAbuWh4Z08uOEggFJd+ZrSFWOqsyjwBW/oTKQinF6C7lP3TXnCq8fCSoFUaI0u
 Qzo6ZZ8V4fC3XrKDqFXSkKHM5+/d9ZjHSwpvqf8LvsFgoMYElvN73ADm5jh60FpdN35v
 j55g==
X-Gm-Message-State: AOJu0YwR8dT9Zm9izOlCTe8mpkTTSUXNOvGYxN/lLpSWz6mr5Y3QEcY1
 Z2lb/zHOejJGEqrABN/8B5GoljjBTvtkaJIXi7IIYgqeclve50zzTYhaWW5phrLaysSzgEO/Bdf
 uvaJP
X-Gm-Gg: ASbGncsNiOX9A+VTahoBjcEyG6uKDryFjsVJMXHq8FbXVsBT0r4aXjVvmgf3cbq70jn
 8v02u+1aSmNNNB6nML7CdFmJEQr2vubDDsEK2uJC6nk/LAWRq8udQnrLccGt1VeUmJCjQSEmkja
 NQuJSopiWcUHtPqyN8o/NVSG8E6RbtKKlSUGGHeqb85fhVvheejSuDG6HyRW0TqR5cYuiATbcbc
 UWWwynzzyTwkKaqP3NowuIGbY8wntafVb00ucR1AToJsgQmz0/6O94ddLWO30QdiMmDXf2cQe37
 YggETOH6qdEX0lYRl7iVc5ZaWyluAaz8hfG7jlQzyRVl3ctz8zl9ckx9rwsJFfhBswnDbDqHhbq
 CKeDfozymj0jC8rDMkHP46IFrI/Qf
X-Google-Smtp-Source: AGHT+IFvh7fryo/JjaR8I7d0aTCBNorihQ1DcVZwbS1BiBbkA9cfddWhIYnmvArW5qkHNH5eY+ekMA==
X-Received: by 2002:a05:6000:4716:b0:3b4:98f6:dd77 with SMTP id
 ffacd0b85a97d-3b61b217fd7mr10000732f8f.36.1753104452335; 
 Mon, 21 Jul 2025 06:27:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] target/arm: Add BFMLA, BFMLS (indexed)
Date: Mon, 21 Jul 2025 14:27:10 +0100
Message-ID: <20250721132718.2835729-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

FEAT_SVE_B16B16 adds bfloat16 versions of the FMLA and FMLS insns in
the SVE floating-point multiply-add (indexed) insn group.  Implement
these.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-7-peter.maydell@linaro.org
---
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a76f2236f43..a77b725c876 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1052,9 +1052,11 @@ FCMLA_zzxz      01100100 11 1 index:1 rm:4 0001 rot:2 rn:5 rd:5 \
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
+FMLA_zzxz       01100100 0. 1 ..... 000010 ..... .....  @rrxr_3 esz=0
 FMLA_zzxz       01100100 0. 1 ..... 000000 ..... .....  @rrxr_3 esz=1
 FMLA_zzxz       01100100 10 1 ..... 000000 ..... .....  @rrxr_2 esz=2
 FMLA_zzxz       01100100 11 1 ..... 000000 ..... .....  @rrxr_1 esz=3
+FMLS_zzxz       01100100 0. 1 ..... 000011 ..... .....  @rrxr_3 esz=0
 FMLS_zzxz       01100100 0. 1 ..... 000001 ..... .....  @rrxr_3 esz=1
 FMLS_zzxz       01100100 10 1 ..... 000001 ..... .....  @rrxr_2 esz=2
 FMLS_zzxz       01100100 11 1 ..... 000001 ..... .....  @rrxr_1 esz=3
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 37ecbc2b7c0..fc76624b5a1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3883,24 +3883,31 @@ DO_SVE2_RRXR_ROT(CDOT_zzxw_d, gen_helper_sve2_cdot_idx_d)
  *** SVE Floating Point Multiply-Add Indexed Group
  */
 
+static bool do_fmla_zzxz(DisasContext *s, arg_rrxr_esz *a,
+                         gen_helper_gvec_4_ptr *fn)
+{
+    /* These insns use MO_8 to encode BFloat16 */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
+    return gen_gvec_fpst_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index,
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 static gen_helper_gvec_4_ptr * const fmla_idx_fns[4] = {
-    NULL,                       gen_helper_gvec_fmla_idx_h,
+    gen_helper_gvec_bfmla_idx, gen_helper_gvec_fmla_idx_h,
     gen_helper_gvec_fmla_idx_s, gen_helper_gvec_fmla_idx_d
 };
-TRANS_FEAT(FMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
-           fmla_idx_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->index,
-           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FMLA_zzxz, aa64_sve, do_fmla_zzxz, a, fmla_idx_fns[a->esz])
 
 static gen_helper_gvec_4_ptr * const fmls_idx_fns[4][2] = {
-    { NULL, NULL },
+    { gen_helper_gvec_bfmls_idx, gen_helper_gvec_ah_bfmls_idx },
     { gen_helper_gvec_fmls_idx_h, gen_helper_gvec_ah_fmls_idx_h },
     { gen_helper_gvec_fmls_idx_s, gen_helper_gvec_ah_fmls_idx_s },
     { gen_helper_gvec_fmls_idx_d, gen_helper_gvec_ah_fmls_idx_d },
 };
-TRANS_FEAT(FMLS_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
-           fmls_idx_fns[a->esz][s->fpcr_ah],
-           a->rd, a->rn, a->rm, a->ra, a->index,
-           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FMLS_zzxz, aa64_sve, do_fmla_zzxz, a,
+           fmls_idx_fns[a->esz][s->fpcr_ah])
 
 /*
  *** SVE Floating Point Multiply Indexed Group
-- 
2.43.0


