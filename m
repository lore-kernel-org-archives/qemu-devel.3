Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557A1CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZEl-0005NU-Q6; Tue, 16 Jun 2026 15:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8V-0004ik-Em
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0001Cy-TS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso106920f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636861; x=1782241661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MwaapcHas6wJYffFDMxOfKBoZytTIETCsbZAfwXMMp0=;
 b=fCqm7HAP9NB8qrRp0QhRQNWqQGPP+qsehi45XJf5Kazcqu7jAEGYPO5oFBm6z19W1W
 mtswxTcJC55mANESCQP8vD4ftd2h9RPOGDYFQftFmS58EKi7Tpb5BPu2BsCLhC8WpG16
 c27VB16yMJvGIhpe/uytAzxAI4CT7JrFgWNd6pvpTItRHP+yXAOjgFCz/wq9ITnDK7PL
 le6Z3+uJrFV+6dqrRBN/QLCQSox0gjpsbDo3hpLPdaFJ83aQnOZFA+/yP5YxjlPv+nRg
 b65SPAezJTfpWHhTXWO7M3oytCg1KclFMBaXBmNb5k1GJbz/NL2yHHWYV9crs82N69HK
 697Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636861; x=1782241661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MwaapcHas6wJYffFDMxOfKBoZytTIETCsbZAfwXMMp0=;
 b=pgjRKXsf1ups3tL8cyH3lhN9Apd92M3k+BjFYl2M3MDe7yCzl5F5+XuXyP/MFDdV6G
 2ulG6zYtHQr29PCVGtlkMYtmtmcHB6Ss+zUtYyMMw5fOnoyQl2umoHRZtLAkYsOc8wkt
 It4YbcgHDNKpYMtOwn7jVYTL/xqYGvkldmDLbduywXlb5jT0wYf/pveuhxH668/SfJgm
 hkLUGT4LNKekl8edIhBlBMKE1jCPymzaZ51cP7Yz0R7Z2Mg7Z1/ix6Y7p9Xtrx41aFYx
 xHWaRBbp+NiM88+0EuWVgoPR4T0V1NuYomEdY9vORuTFbQ/Sc4YAQ5iL6b0uZDUC0WNQ
 aGtA==
X-Gm-Message-State: AOJu0Yz7P5rGmLZAQ2V2jfKloUO0qwf15LWHKJJdIVhXtP6lfgxoeO81
 FjnZnFAAgRQv2d4eU+ahUCk1MygxJvr3mT0uEl1I8k0aUszFhKKlubLpslTXonyYq9DLpMVXIti
 UNmuf
X-Gm-Gg: AfdE7ckeF7mx9eGpgM+mdKK/fFgCVXEW62rDO+S2JlZ8b66ykoN5kFlFXDP6Q9dE0GX
 W/xSOPfcVsqKiQODsX0qLUjhz3mmL+cVugT+TWI/F0Pc9yM7JJQs2uXDTwmUsDJA18zX3GOS+m7
 9T6JI96ySPVkiW7f0ak6p1ZY5+VVEyDBe2VxNDoAwz4CErgN3T+231kx6afNVCMTT3lWpW0nZEg
 YUME0LMY1wXfRYZdqraawxK2B+uBrxkWjaVnr1dsg9VTAWt5/pnUWRSgRkN5Mlwm+5KzQMzls40
 PmGgsQjsxBzyiajRs01/gMZCFDwmcsOWj8RP/eOYX+qK3ZepiptxhbCcvIAbgnffjpsPoZh3BY3
 7nfh2XjCUeiRmiF3I0Lv+bddkzEgJANXQfXic98Q4AshR+A5/jPz1dz15Yq6Z61m25Efk6OX4WW
 /sVIbaM4VlfTwL+eHNsnTsNNJY6o8updiWUSMTdv76tLDT5KI4O62SbHYFVuqTGklob10ssQV8z
 qRYI0+bMLhhDyTbSIUKhaNOSxUciIeg
X-Received: by 2002:a05:6000:25c8:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-46268e20762mr46784f8f.3.1781636861008; 
 Tue, 16 Jun 2026 12:07:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/61] target/arm: Implement Floating-point round to integral
 value (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:31 +0100
Message-ID: <20260616190639.3462006-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

This is the various FRINT rounding modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  8 ++++++++
 target/arm/tcg/translate-sve.c | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f1cf7a628d..099cd4e93d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1240,6 +1240,14 @@ FRINTA_m        01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
 FRINTX_m        01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
 FRINTI_m        01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
 
+FRINTN_z        01100100 .. 011 000 100 ... ..... .....         @rd_pg_rn
+FRINTP_z        01100100 .. 011 000 101 ... ..... .....         @rd_pg_rn
+FRINTM_z        01100100 .. 011 000 110 ... ..... .....         @rd_pg_rn
+FRINTZ_z        01100100 .. 011 000 111 ... ..... .....         @rd_pg_rn
+FRINTA_z        01100100 .. 011 001 100 ... ..... .....         @rd_pg_rn
+FRINTX_z        01100100 .. 011 001 110 ... ..... .....         @rd_pg_rn
+FRINTI_z        01100100 .. 011 001 111 ... ..... .....         @rd_pg_rn
+
 # SVE floating-point unary operations
 FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
 FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ea936669ef..64ee1f7752 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4644,6 +4644,9 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
 TRANS_FEAT(FRINTI_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            frint_fns[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FRINTI_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           frint_fns[a->esz], a, 1,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4654,6 +4657,9 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
 TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            frintx_fns[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+TRANS_FEAT(FRINTX_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           frintx_fns[a->esz], a, 1,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, int data,
@@ -4694,6 +4700,17 @@ TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
 TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEAWAY, 0, frint_fns[a->esz])
 
+TRANS_FEAT(FRINTN_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_TIEEVEN, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTP_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_POSINF, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTM_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_NEGINF, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTZ_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_ZERO, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTA_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_TIEAWAY, 1, frint_fns[a->esz])
+
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
-- 
2.43.0


