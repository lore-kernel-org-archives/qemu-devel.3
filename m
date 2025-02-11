Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843A8C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6V-0007af-5Z; Tue, 11 Feb 2025 11:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5j-0006bp-Ow
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5i-0003C3-0x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4395560cc13so7520955e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291188; x=1739895988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JP+B22d2Tus+5SJSaHqPrt+ykzpmpk0j57eqo2nsSDo=;
 b=aAjybZvgmCVcifK+wPKT9UgIsPckJjXe36XqcG+UfuXYtav+FLjYOT1FCLfgXuA/UI
 iXAn0u9JTB4sXIX19KUXP6GVwrCCMdgV2vwImrLpbt/nHfcJ48HTcJL3z+VFp4QeiyMv
 w6YTBcE9kyvfH9BHunziogJa/XcQzDor8tlnn9M7Y58HeAVxxeF7H2KjFxdVggCt8rbD
 /prCU8wpIPBw7ACuEKH+LTTYTiby72bLI3LkgUNQbAQTwJtd0grxRUliTXeXcSJ1Ts/H
 ANZBC5jhRMrvQw9hS68AsQvF2dPzYMeRz1c9hYznQqhGa9CFLznaESz9iQ78DhRFg9Be
 4TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291188; x=1739895988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JP+B22d2Tus+5SJSaHqPrt+ykzpmpk0j57eqo2nsSDo=;
 b=Lt8k5SC7A7tzKIReYfUtZCHBH6QW6J5pLmG4l+egy3wKLIh7ghurmFK+w6sd9nqeN5
 fA8n4VxmNL0uLb+ons72uUnLgNbrfij88+eQx7OviOLakfazqcfp6418IHku2SRmKoLl
 mBqo7LSm1tdhVefTMh3QcGBoiB3tvaLVV+423e2H2+BEok0eOi9LAml7w8oC/fEbtwFU
 hNgn1UaMvcb278tXPYlgCPP1vjRhGp4H1AJzY6j+RTR+2sPFcvLMdic+iuNqjOLQp9Jv
 Umz62aGRvICCfgPnyH5pFKMBRqdAvbn/4/bjgWt9UnV0n4g7P5Oav3QnqDUt1eT5lhos
 edJA==
X-Gm-Message-State: AOJu0YxgvbYBOSjBOydKhmFx8gX2xAlcQAnVUtnJ6zd29E61vWEBOn/J
 aap8+HOA+bTjKZFJwdCjPy423lVnarHLxt0KKwNYUICwkmngLQGN/OXwDRR3Xct90YlXRa3vabm
 M
X-Gm-Gg: ASbGncv8HZR+QZm5oMDM1ojDkFJo4vc0I9vm7vtELZ/DZkJ96nTrI/gJyXxIz1zNp90
 ARCU6ZZ8g9g/oFE/3hwwVH6Uhcbtr0d2PBA7rAu2sFr0wrx3qOcYs25s7JK/H++JHacbPdfnBcP
 QSbx18h8muZoDqK/qb55CJV2y197Ctf82i4OKzZSl2Ndo8UKWRmarTzz9aqlLpUB/znHqOuooo2
 JzSUE+rVgDfaYQgnrMpwTWpIlz2fgUJDQ7RXnvAHuEGQJFRGX5QqFpQBwxOtCZh0bUAhqha0/lt
 F8rWgqgTVSSeSS1MTJbB
X-Google-Smtp-Source: AGHT+IEUPnvgcPFxjAv9FuspvJQl0DFLHboVb8hieaMRJCzKaxSIZZIDvP7IsVUkSlXtdsVYk04iUA==
X-Received: by 2002:a05:600c:1e14:b0:439:4d86:98c2 with SMTP id
 5b1f17b1804b1-4394d8699fbmr35217585e9.29.1739291188237; 
 Tue, 11 Feb 2025 08:26:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/68] target/arm: Implement FPCR.AH handling for scalar FABS
 and FABD
Date: Tue, 11 Feb 2025 16:25:17 +0000
Message-Id: <20250211162554.4135349-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FPCR.AH == 1 mandates that taking the absolute value of a NaN should
not change its sign bit.  This means we can no longer use
gen_vfp_abs*() everywhere but must instead generate slightly more
complex code when FPCR.AH is set.

Implement these semantics for scalar FABS and FABD.  This change also
affects all other instructions whose psuedocode calls FPAbs(); we
will extend the change to those instructions in following commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index abd0d916b19..83cfcdc43b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -869,6 +869,43 @@ static void gen_vfp_ah_negd(TCGv_i64 d, TCGv_i64 s)
                         s, chs_s);
 }
 
+/*
+ * These functions implement
+ *  d = floatN_is_any_nan(s) ? s : floatN_abs(s)
+ * which for float32 is
+ *  d = (s & ~(1 << 31)) > 0x7f800000UL) ? s : (s & ~(1 << 31))
+ * and similarly for the other float sizes.
+ */
+static void gen_vfp_ah_absh(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_absh(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7c00),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_abss(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_abss(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7f800000UL),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_absd(TCGv_i64 d, TCGv_i64 s)
+{
+    TCGv_i64 abs_s = tcg_temp_new_i64();
+
+    gen_vfp_absd(abs_s, s);
+    tcg_gen_movcond_i64(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i64(0x7ff0000000000000ULL),
+                        s, abs_s);
+}
+
 static void gen_vfp_maybe_ah_negh(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
 {
     if (dc->fpcr_ah) {
@@ -5392,12 +5429,35 @@ static void gen_fabd_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
     gen_vfp_absd(d, d);
 }
 
+static void gen_fabd_ah_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subh(d, n, m, s);
+    gen_vfp_ah_absh(d, d);
+}
+
+static void gen_fabd_ah_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subs(d, n, m, s);
+    gen_vfp_ah_abss(d, d);
+}
+
+static void gen_fabd_ah_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subd(d, n, m, s);
+    gen_vfp_ah_absd(d, d);
+}
+
 static const FPScalar f_scalar_fabd = {
     gen_fabd_h,
     gen_fabd_s,
     gen_fabd_d,
 };
-TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd, a->rn)
+static const FPScalar f_scalar_ah_fabd = {
+    gen_fabd_ah_h,
+    gen_fabd_ah_s,
+    gen_fabd_ah_d,
+};
+TRANS(FABD_s, do_fp3_scalar_2fn, a, &f_scalar_fabd, &f_scalar_ah_fabd, a->rn)
 
 static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f16,
@@ -8643,7 +8703,12 @@ static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
+static const FPScalar1Int f_scalar_ah_fabs = {
+    gen_vfp_ah_absh,
+    gen_vfp_ah_abss,
+    gen_vfp_ah_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int_2fn, a, &f_scalar_fabs, &f_scalar_ah_fabs)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
-- 
2.34.1


