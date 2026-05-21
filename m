Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2195BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2YI-0001je-4J; Thu, 21 May 2026 08:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2Wg-0000y5-MY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2We-0001ci-T7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so67258925e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779366559; x=1779971359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH5hlcFtdcnQevD+hJ39wNb6pHC99dGw7i2XR1TiCJs=;
 b=HMT0T6vUmEu5TDOCS7UZ9lnuM55eRyhXIjS1IxesuuTg/OV8l2nb/lMMnzqG46eQWp
 a+Szctsde/0LIZUrUpy7baQrJxYcKM6JL3lDPbMw+LcDVo9HlmOQ0wUTfgzmCJiL24xI
 8XX/E1m5U2VCDn/BW6XdtoAgu2E8jY51+MhsZlnjKhlUXKPV1ZRVEAGbx6nN28VsS5MT
 ixICat+zi4DKuxDfKTxr243BOv2V23ZLolwVVJcTFcmxRjJYnMYhRlf8/qgvziZiIIFn
 9N5EKGtaB4DkHCPeFpKKA5Aiupo8KLZzdYYnTxJsA0baqUFuW3uWhJT9j7BBgYdnDRao
 Se8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366559; x=1779971359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fH5hlcFtdcnQevD+hJ39wNb6pHC99dGw7i2XR1TiCJs=;
 b=k+Zp1k6Y9o3w5aWGan6huSuK14vYZxnHL+kMM2MGjatPgGneny8rPK3MPU1BOcetC4
 r18WVaeDef18GiZtUHA2cTvHxAs9vm/Z2v1+ze7+Z1WTbyhMc1Is8FBgMVjJL6h16Tlu
 PmaHwGDgyabY4D2u+wZGVC/36uX0UhpRVc5Auk1LFRPTEXPYcCjAgLhzKY1hsnRRKslR
 PNgHvjust1lQqYbW7geX3I/xxCZgqk6qt8p5U0OvzlQGjkHBQ+ft7Dpe8Uj6desQMNQZ
 O9oR0p2oBcWADTM1vN5RtEyFRQhW3HhChNcmBD5Jm264o2nQ0YJtbS7tO9rIFd65CUVq
 NVzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ870mjc2nOdzDe0xEzWv2B+OhFpruT8Tk3jpZccpd8v3UONDolm6v1uF0quI4uM4YuDfEqGhyDcZOrD@nongnu.org
X-Gm-Message-State: AOJu0YxBOxwYKnemLXySQ7BHv15Yh25oBxJf2/g2+8L8y0Svi7moYyox
 BcUKshbcpmyOf05VK3cu3PcE4rWgi8jyC0P7x+x9C7bwZYe+7sqwjCvxxkd3MvqneERNYz/BqJf
 K5t5q
X-Gm-Gg: Acq92OE/j6+bpUbq6qEc8JPO6hzOtvSP41ZyL+5OHCmPV1ew2AYk4tduRUQn88ndDeD
 R5/uUuNKzy8EwjnMYZiPAyyAuv2XufRav0PIiJRduza0Z5d+wgGPLTGmbELDerMuzE7AgbusWBy
 dqvuRcqhm2PJNtpKUal5k8ykMrva+VOhYiamzRHU2eIJE3r3d/UvWta/52STN40YLKf79gG8ISP
 TETZe3KtsKQU8NMfVm5V9Jg/Rv3OJydnCOJ4HeHQ+ZO8OW1d6w0qaPye3qgZpnasp8OEuE9YzgG
 U3w0zLXGoe5d9sYaVr5ZEOPGUvWr/R/Ges2S3N0qGjitbeBmfF9VZa61YY8jawsbNTQar/yNt+Z
 0o2hwAQ9tMJWymFjplD6ZchLMHOvtcMtDBAaZC4t5UpRrSYb0eTLmfEmnkznduAeL/kBImuLVls
 A+ks/ooxFe//uwIxqrmmdeBJZ7SL0fWHYoRxRH9tpZ6j/7Vu1dfXSnnjLaXXnVTxEt1FY6+C76f
 1jlM53OhLkR/cPMO8omibLb3ytBhFs=
X-Received: by 2002:a05:600c:1f89:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-4903607fd11mr35515065e9.15.1779366559242; 
 Thu, 21 May 2026 05:29:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c72c78sm22054245e9.3.2026.05.21.05.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/3] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
Date: Thu, 21 May 2026 13:29:12 +0100
Message-ID: <20260521122913.1565011-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521122913.1565011-1-peter.maydell@linaro.org>
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SVE FCVTLT_hs operation produces a halfprec result, so we should
use the FPST_A64_F16 fpstatus for it.  Getting this wrong means we
will incorrectly set FPCR.IDC for input-denormals when FPCR.AH=1.

We missed this instruction when we updated the halfproc-to-other
conversion insns to use FPST_A64_F16 in commit e07b48995aaa
as part of implementing FEAT_AHP.

Cc: qemu-stable@nongnu.org
Fixes: e07b48995aaa ("target/arm: Use FPST_A64_F16 for halfprec-to-other conversions")a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index bf9f0ae179..59b8c494a8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7827,7 +7827,7 @@ TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
+           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-- 
2.43.0


