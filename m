Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ADACD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgr-0001i0-HO; Fri, 29 May 2026 07:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgn-0001eP-Jm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgl-0008Dy-V0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso64161275e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055262; x=1780660062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/OUB1GP9tck40luMQUBOFZYpEMh4lTb6rVQxTXavNo=;
 b=fYMpal0FLEje7gHCEWK0Xm5p7bD9XtyFc6zDEHM4FxoDfmchaLdXGR4tR6iet3zO61
 EzQQr4ng8uHlUOoKZjANg4atsuocTRPyBBPEHMQlBrICFTjOltOn39eRoU7e9XfiMAxL
 Ap30UhoL2IneHVsT0LD2KHW/j0PQO+vkeUY+M84NqaoKwCxdXWDcnIMrmLc+J6kdk8AS
 lpm9/tkZ8e/GT3hs+AIEkF7L4IM7sZCede2LfxU0S6L/UydY+U5cXWR3EejugVT2zdAN
 F/cCNvVWjq2xYQ3e7uwf5sWAEfslKEGaoxJh0lR/uQAXpYhi0OQjKJ92cwuxhLWjKcBJ
 rQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055262; x=1780660062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t/OUB1GP9tck40luMQUBOFZYpEMh4lTb6rVQxTXavNo=;
 b=NdhYKsVOlzJx5vukT42JjRS4QMUVu0+IhI7l5HCc+++TfXeGNaXF5aLOp2oh7ajsIY
 JmkP6t1POUwgN08X1KbgIi9qmG11vXfQOYsTGEtMG8Rl2A0aLCR79thHwMoRO3ulThCf
 7/yHn8bB/cEGLykga14Ljm0JwLSFxC/UkN8ewZVZJyNd3yZJd1rS9QmrRQmEfI/PPOVe
 5DUKR1QJ/ITHlKXRmDMdDFEUBf2+yGFxSHq7v/mKWzra6cHNe1Cy9utfAfnEuM72WwlX
 JzpuKNbMxaRC4L/g5z5fNr41/wdd5GDpBhM85Bza9ZazGyDEct+jGGn2DBNRFTipirZW
 xkow==
X-Gm-Message-State: AOJu0YwszO3IUIR9uRAcsERtE7oKUECYFmGcgTMye86ZaAbIg1vnC0/S
 /tBJyafZZPHG9QuMsyKykQJShQy/1gqD4u112ikfGFAP28pms0R/DBGXIdIGxF5gFz0N3ZXQCLY
 CNqim
X-Gm-Gg: Acq92OGSM7wdHxUcXr8ZagyHkAf33hFRIoN8B3t5dJcykAHhE3K7RTeXatao3SiscKO
 Vzcbg9jsXC7mmWbauVGdVeRv7yTeNS9onbUIlP4A3X3VpowYHRNsB8UHyC+t9BUdbFiE7zThvgg
 sq77vXvrPKpqGmKbTKClBzOnlgK778AIESVH4u7wY8MLSTGglhYgkOCLq/+Ftvh/a0dwAYVaeFu
 CXmemX1L81gvjTmh7vrKARHhFBG6FTU/BFTHgK1GEUfjVBXJQt2YPGy0aYsE7SsNG5LOf0fQ0g/
 MA7AR+e+lnZHOUn6lXPQb0u7Er0nqqPOR3vhiWnLoVVaMntij6G+Bi3bo02ni+NE+uPGYQltPtM
 KkDTznTcZDxTnQkQ5rDY2gZs7t0UqcyS3+ho+rEg8nBwiDudTAWJU+HhfzyS6TZCKEHlNSmsV8G
 hNWhDSo0EC4myFkSAG4QefyYghkACkF/uCkEPB5ATOg7RxqY0VpeY4HanMv6Undu8a9bsV0qr99
 L+csEiGmsjvIgrY4hi6dBMR9rjiIM0crcMKFQSDeQ==
X-Received: by 2002:a05:600c:3b9f:b0:490:59cc:998e with SMTP id
 5b1f17b1804b1-4909d2e9009mr45635455e9.3.1780055262405; 
 Fri, 29 May 2026 04:47:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] target/arm: SME BFCVT,
 BFCVTN have "Alternate BFloat16 behaviors"
Date: Fri, 29 May 2026 12:47:17 +0100
Message-ID: <20260529114723.42040-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The Arm ARM A1.5.10 notes that some instructions have "Alternate
Bfloat16 behaviors" when FPCR.AH == 1.  We implement these using the
FPST_AH and FPST_AH_F16 fp_status words.  The list includes the SME
BFVCT (single-precision to BFloat16) and BFCVTN, but we forgot to
make those use FPST_AH_F16 when we implemented them. (We get the
ASIMD and SVE insns on the list right.)

Add the missing logic to select the right FPST.

Cc: qemu-stable@nongnu.org
Fixes: 465d36db0e1 ("target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260521180854.1744788-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e2d17de165..82aa14131b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1449,9 +1449,9 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
 }
 
 TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvtn)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
-- 
2.43.0


