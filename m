Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7458EC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg9-000774-W1; Mon, 29 Jun 2026 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tK-QJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfS-0007MI-Q4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4629051c946so1754560f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734448; x=1783339248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IjwWu1oFD742Ucz+wBaNtnlf+Rf41P6eRaJtFOYmwCc=;
 b=WUvP2XAETTBtKld6JFjVhr8inP3jSSKmQYc4Wz88NHq8/+pBE+hbe9O7WO5TMyseaM
 PiGoIBLBSbpL5Z5BFwkWxvFJx6cK3mzSsISW/csNbJ1T3H+sgjSeYQ4nqwYEaGIXtx3p
 dF6rdTDUKxv4121WKMmgYZMHuq4MXKSeSVC31lLi+la25zbbfSS58deJU0zyNFy3qfNR
 EAKDuVbXNkgVAybrfv2jap1zkBw5TXzc2XaYC1MNkqnHlyrZnqjKhBzf+bufDcOkppy0
 d/hWY5mq2nEX8HUJDyfayDThvKkbMVQUZJtLcEseNQ66x4OVak3B+VUPEH43fLv23GPr
 dxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734448; x=1783339248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IjwWu1oFD742Ucz+wBaNtnlf+Rf41P6eRaJtFOYmwCc=;
 b=QHyWxbFZd1xvP77AgYtQfDslwkxIrZ1dlDCpSCQGKFmodWRZheZI6gnNXCnIx7PcFy
 eFDfKN22JxoHyZhA9f0cF7YZMjmZblL+/Z94oKPx34f0C0eRo6GqCPUjPyk/kWqR2WJ5
 ZhgiTQvcykEFm+YUGs8UsFjgKNN+MSVCfohf7BbKlOpnbqXAVixLjihj38MfjGkFCNCE
 ZGQ65rIEulvOA/lDKxMhIn6vPO9VH7HOTuVJ/toIKT1bmp0QpqVvUi/VTQuQlKZnrEVM
 hnyhFrV20jIjg8ambFT/M8i1AFDiA4Vvcw06Upu4rN/Zdpc7DwjmGBKGHmxxNwkoXdjK
 Mw3Q==
X-Gm-Message-State: AOJu0YyYHSQUNf4PzKRI931sPwK9bLMitJIqmxfggtvQIxxrySa95QoO
 81aGNn2AROIDiiV5799CvFchggZMVh5zdVKr+/7TnxLTDxiZu4g+sg4H90Atkko92sNDQ4acKH+
 MbB5I
X-Gm-Gg: AfdE7cnNMMnrVlJm2mMI3XqjCE238bRVJOyLs4tU3QTuMWvb7j2QotOY+tLEJy+IYsq
 9Ed+Pwmmvb0eje2QKAzkKA5wSWynVLRf5/w72HpCoh9gDhgSKu8bGAXaXiBfjZKGKflic62WKoY
 1nIM6OTyfB1NVmQq+q3WSkxDWyE7FA+AFW749yJwwQ6DvOr2YIXNYOIasyyXXAd9pFFX2lxCaPs
 9cLjSBTFiGHTijPvfNmEMeYLgkQfJXTODPgK7c0Xn67Z8abNmmRC/62OmXS/izRG5UBUZPs7uG8
 pPAtYfW9GdBXfEYJYixj60JQAzpgQ7qEiEMtuNIen3TwpZDccIY7x+ZpLpBYeJTz+g884LLt2vl
 DeonXsHZ0kdE6uAM9BFKNswyBsMQTKmypKd5dXXVm9Jp2Qai4aNGtt36c2JXX2Ced29CO4uoEha
 a95g+SE/ea/iD7G+XAe/amptYN3Z/cVTdJ0iIYZCnqFwuNiqVqgYzf5DfyW8ALn0t+h3rX7cSWw
 roze7rurf3uSt5LfGIuxxZ4PVxmSxuW
X-Received: by 2002:a5d:6e51:0:b0:474:f3b6:537 with SMTP id
 ffacd0b85a97d-474f3b605f5mr412038f8f.14.1782734447299; 
 Mon, 29 Jun 2026 05:00:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/54] target/arm: Implement FMLALL (multiple and single vector)
Date: Mon, 29 Jun 2026 12:59:50 +0100
Message-ID: <20260629120032.1645265-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618041517.573469-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  4 +++
 target/arm/tcg/translate-sme.c | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e668293efd..4956995924 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -445,6 +445,10 @@ FMLS_n1_h       11000001 001 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_s       11000001 001 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_d       11000001 011 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 
+FMLALL_n1_b     11000001 001 1 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+FMLALL_n1_b     11000001 001 0 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=2
+FMLALL_n1_b     11000001 001 1 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 63c6e2c9b1..30487c34a0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1059,6 +1059,47 @@ static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
     return true;
 }
 
+static bool do_azz_acc_fp8(DisasContext *s, int nreg, int nsel,
+                           int rv, int off, int zn, int zm,
+                           int data, int shsel, bool multi,
+                           gen_helper_gvec_3_ptr *fn)
+{
+    /*
+     * TODO: Could plausibly reuse do_azz_acc_fp, after the fpmr check,
+     * but the fp8 helpers were written without a separate addend operand.
+     */
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg, nsel);
+        TCGv_ptr t;
+
+        t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, tcg_env, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
+
 static bool do_fmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
@@ -1071,6 +1112,14 @@ TRANS_FEAT(FMLSL_n1, aa64_sme2, do_fmlal, a, true, false)
 TRANS_FEAT(FMLAL_nn, aa64_sme2, do_fmlal, a, false, true)
 TRANS_FEAT(FMLSL_nn, aa64_sme2, do_fmlal, a, true, true)
 
+static bool do_fmlall_fp8(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fmla_sb);
+}
+
+TRANS_FEAT(FMLALL_n1_b, aa64_sme_f8f32, do_fmlall_fp8, a, false)
+
 static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
-- 
2.43.0


