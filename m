Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04717CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFJ-00067k-0P; Tue, 16 Jun 2026 15:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8V-0004ij-2w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0001CV-UJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so125261f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636860; x=1782241660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sdhhYYWWcr0IknSn1CgIlq95XqkUC12aNgNn4QU2pX4=;
 b=XDHokEhPz/Q5KxTjUxIKGZoXOPUDQNeEM3vbVOjs82uUYguMgOXLqP5GUOr1qh0cF8
 dvWn++hufDVH3IEiTDUh4MvSLyW0gx9MigQDFyZ5LZF1HXVUJmEOMxdFL8u3eyh2AQOi
 KVlCMeSrzg7jH5WCoW6Kz2PrAMCEwd5zI6UubYRIW63icm44XW4L4iefZZnmDn1aZ+0Z
 ymDe9SnlxIer4cvPgS8YQnw/ZufAX6SKcQuBl/qHGF6qE2nti6mSXzaCk7IzwBeRZR4h
 nJYCt0eqBDpADd9YojsH9QwwpoNWORsVkDRVPZAEvD2PmoCwThuX8KOh/3nnzRyEPFVh
 kQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636860; x=1782241660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sdhhYYWWcr0IknSn1CgIlq95XqkUC12aNgNn4QU2pX4=;
 b=Q8/UH3CKuHhlL1Ae9DEiAQs7Ri2m45UPIwg8f/H5eUBO3QAkSlZurpuFBvWL2Z3vaG
 nz+awyXwuU4uxBm/+Fn/mw4cuuxXfFnLlVlycsVm2KIymAnOZiKqUWnHTnaylR1kSR/A
 9N60wyIkTpLF7qVKBU0GRIc1whrlXZVXE6MCVzi1I2vNsLR7qsWFaT+k7/DQGXWfed6C
 xtj7MaeunEtAzE1P78ndX/4iG6GsAuIbWs06gJFZbw5iifXSEFwZuZw3VUTEq/HZ2n7f
 8kl9bi/d0gg8IWawcc56qsXUI6AMf4JXC+rg+HbMMmO2tkrSu6yEN4pLcGSwqZyTKuW4
 2cBw==
X-Gm-Message-State: AOJu0Yw0NGYRXt6Mb7MGJDqGMB1aBbt5w+hLZC2URbRp60dyLW+TPNDk
 Nk69LBP/A2eFAU1vdO43Y+ObI5YM2vD7FsicZKweuEyjC8Dfour1R4rI7LuvFDBXAWPcplR+b72
 1Cq6M
X-Gm-Gg: Acq92OGAJQ5SC5gjMoDXZ3VmvzQIIDrHp30uWDJvfA8l/Ri8ivwp7JEcN+qUOV0R2vV
 f6oNqgRFbl/QkoH20m5mWURGEmNyImSPprujnsW2I7F7VdKi/Q3KHv5Pmva0OHhBFMPzSyRc7YI
 8fL/qTEBQJq4ny5Ub/TRiNwvh40Hu2LSliC2hWbSawb+h+iwnndol3KBsIuXaocqkeemsGwJlTy
 M2nLhNGIZkgxKiesRy8H8lR+mOSLtvihDlEsRwKMYrriDYjnEYizFOZCofHGwQn8SYqhI0WQDb7
 T3hWGpwLOFJr7ECndMNkzhj/8ARgrfYgpBJdOr/rY1bxSJVox7u82SlP6OZfagni5szZ6orYlEf
 Wlo7tKWxudVCyzFmGnsPXOYDG2V/zI21xFXsStEvtPnLm0HXNen+VnpDUu6ZmZMzUf1UQkp/df+
 l+5VlIflpGBRCB48ym6usaFOjEK7TsEwG22tlt/GIPrP3tKltFtfJ9HGfyAlzDQPl+G4KWa9scE
 q3L97AUVT6QSnpTAeLZIphD2ZoK0hKx
X-Received: by 2002:a5d:59ad:0:b0:45e:9304:a4c3 with SMTP id
 ffacd0b85a97d-4622d70775amr1651375f8f.19.1781636860154; 
 Tue, 16 Jun 2026 12:07:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/61] target/arm: Add data argument to do_frint_mode
Date: Tue, 16 Jun 2026 20:06:30 +0100
Message-ID: <20260616190639.3462006-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
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

Prepare for needing a non-zero value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fe78e4dda1..ea936669ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4656,7 +4656,8 @@ TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
-                          ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
+                          ARMFPRounding mode, int data,
+                          gen_helper_gvec_3_ptr *fn)
 {
     unsigned vsz;
     TCGv_i32 tmode;
@@ -4676,22 +4677,22 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
                        pred_full_reg_offset(s, a->pg),
-                       status, vsz, vsz, 0, fn);
+                       status, vsz, vsz, data, fn);
 
     gen_restore_rmode(tmode, status);
     return true;
 }
 
 TRANS_FEAT(FRINTN_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_TIEEVEN, frint_fns[a->esz])
+           FPROUNDING_TIEEVEN, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTP_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_POSINF, frint_fns[a->esz])
+           FPROUNDING_POSINF, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTM_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_NEGINF, frint_fns[a->esz])
+           FPROUNDING_NEGINF, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_ZERO, frint_fns[a->esz])
+           FPROUNDING_ZERO, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_TIEAWAY, frint_fns[a->esz])
+           FPROUNDING_TIEAWAY, 0, frint_fns[a->esz])
 
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
@@ -7998,9 +7999,9 @@ TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
-           FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
+           FPROUNDING_ODD, 0, gen_helper_sve_fcvt_ds)
 TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
-           FPROUNDING_ODD, gen_helper_sve2_fcvtnt_ds)
+           FPROUNDING_ODD, 0, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
-- 
2.43.0


