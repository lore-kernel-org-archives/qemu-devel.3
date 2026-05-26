Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C43CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoa-00040T-E0; Tue, 26 May 2026 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmv-0001Yh-IJ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmu-0001VL-1J
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so6328818f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805783; x=1780410583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4baddaOThhvVypa+zR9C68Esb7J0JFElIMpjqOxSFIQ=;
 b=b2B/Pv8s4+/lG2AqzKxS/wr9jWdVF0+8pkMUJv/w69kd9TiWdzOJq7cbHO1OcR4TbC
 Wc3JpRDy1Sm7FAHcBTdovgufroaBCGVMJ6KhehVuUc72aJ3rsvV7FmRC8q2afOCjN/Fi
 DkYQghBYEEUTGcP6dciyNbK0CWBdfrejKDdhmo7Gpfne7Iq2j+bv5ymXeK6zZJPUndI7
 U3L17V8YZs7L4Ow1uIUlybPh09MVNThVHIaY0NkjNJ4rcB4umEMJTUOz5Rc2QycgBIy8
 riP22OsjyL1ISqFOpiFOcYSFwdPfEYtsofqA85ZUvOVPWC9bYa0q6uAUuCf9lnpa5kMB
 Vfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805783; x=1780410583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4baddaOThhvVypa+zR9C68Esb7J0JFElIMpjqOxSFIQ=;
 b=I37QiW3Z8iyehLz1xiOnEZTkATDHFNtCSycQ7JHwz3dC1TGopMJp5IHVCbl1t/+uf6
 Y6BEgcsmvC7gnygFe71yMX9pv9DHtVjS4zua79bX2zcftQXY6At/Xw8QQrl3PffOjF7M
 1ot+/f54ybdMw5zzpoRl4YyLj3G7vCafNVypXsSHrPT5Tst2uUsRTKbu94NhzqAAZRZM
 VOxrFR9Rfb/SRJvdMRfuKvn9+6dVESFwYmCIZG5Pw4CUKBRGARDqzZ3kGlFlWiJdxtob
 /+3fE05ZKRALt5q9FnoN6NKdT5jptZbgD6JtbvybOTYpRdgD8mVAn5fH5SNUxuz+W6Jz
 4JgA==
X-Gm-Message-State: AOJu0Yyu7m8QwRs7wocKoMOVxPg0MBndOhSjJq4aGp/axzas3+aNW59r
 x/AAs6F02Fv2yzPfXstu5PhgyI6jGzH6GaMSgHMoTcyXSBH4fsVobZpg32cf5fBPfrG+3mdIdMf
 vkDZq
X-Gm-Gg: Acq92OFSXliTobMDx8rR4jHZmYuMUwfo7MMBB3mKzb2VSyIv4Z9DWFEtfkUThFZ2qI4
 KC3pMVhQ2YdeVZhuzfiMo/mEAYZoNoleFNDoB/j5MmHk6WHMng6vOTZZI+ysPVa8us2hDQPYEtK
 JySBWqcNhUWSz89n4kGYR4CAf4PCOCVC6jX5tz+1i8rVKlI+KiPzkgmZ0YXL8R7j4dFYjBr5Bav
 hnFdeYrEi6cQaYA1wb901tWPNCiHnXPjrGoiPpkjodIGb0ZwbLcXpKvSIYPz8A8Tkl/8g86ms3T
 1QLHBUvkkuv8+/c+eKAJvcWZcB3JbsWSPqgvwFWA9pOg9AiPkal7W2rTsxHV0QiokHzfBEVoafP
 cNWNMTM4Kin5Ek7gpYVW+Oz+5ddYP1vy0sl2SzMkxaiyugIVaEn9tOvQwvtAtKqYz7e4OjGuInq
 tawUMsyxp8j+P3eQ6T7plSz4RSVZe0CxU5qrpfuyffkx2KzYmt/EfwSvbq0spFDPUCVxibUohyl
 pg+K3pW7gHuZ5g7zedoPviYMOLiRN8=
X-Received: by 2002:a5d:5f54:0:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-45eb38a6779mr33499011f8f.21.1779805782537; 
 Tue, 26 May 2026 07:29:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/54] target/arm: Implement FSCALE for SME
Date: Tue, 26 May 2026 15:28:48 +0100
Message-ID: <20260526142850.2326589-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sme.decode      |  6 ++++++
 target/arm/tcg/translate-sme.c | 15 +++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1fde3e9231..f9c979d20b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1622,6 +1622,11 @@ static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9dec7318a4..ee874be1a6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -250,6 +250,9 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -291,6 +294,9 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a67501226f..e2d17de165 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -707,9 +707,12 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
 {
     int esz = a->esz, n, dn, vsz, mofs;
     bool overlap = false;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     /* These insns use MO_8 to encode BFloat16. */
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
@@ -719,7 +722,6 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
@@ -831,6 +833,15 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
 };
 TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
+    NULL,
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
-- 
2.43.0


