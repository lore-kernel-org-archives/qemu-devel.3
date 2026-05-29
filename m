Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EEACD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgc-0001TA-QK; Fri, 29 May 2026 07:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgY-0001R5-QE
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgW-00087q-Dd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so4905845e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055246; x=1780660046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=unbBcxE6HlsS3TB+KG52+c/7q4sg73xuGpBak3EEwpg=;
 b=w+TmkvULFvXiZSdBNLhls8TNT5y7HBbmMS3ZIJgKP8T7VI6+pCZOubacdcsIv0T7Mf
 Pp1nhCjwADRJOpATIDISgLTwAgb+FbvUCudOobCXRKV2ojOyf3Jo33bHwOvrj7kSGDtl
 w8s5vU0VSZ965DN1LAfbl1CUsYs9agelr4NmZbFlVMiZX81JMzxaal04VsyGJs0FMAjx
 db+DQRhEAICDPRC1D2rvkP4HPM8AsFBC0sY7k9MpHF2hVKhj3n/+9WSyiK0N/6w7jkt1
 8SuFJudNhCe9Zg6OqElPDBWjeeSWswd1PFTy5ZLurBUNUyjv8Cu5JkQVttBjning/LTo
 O/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055246; x=1780660046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=unbBcxE6HlsS3TB+KG52+c/7q4sg73xuGpBak3EEwpg=;
 b=V77ghGLqt9Br/A8L1BQqr5PZrlvWwTfip/gCOjpA9t+zCAf4eX7GR2RIAlY4wlgYgM
 /5oQNskVCeHD6SXBJeffR4EmhnT0idMOw2Z+E1ERANpDSkX4EsGT31oGguQklUOSExId
 bXPX9+J8JAaCuF51X7AYBpgaE5uxiLEkRznbaHjLEfUxFfN5910A+gwT25MppslxmB/S
 amgecbzVrH9yfHeqLKyulklFaPuFtFZZg89ZckAxpC1M4cB94nfc1fyL/6nlKH5TzcHQ
 66MglBIZB+RXo0qv03+vUJoAG+hFuvZQQT3A73S4WAxpRADwMo54f62T6FKDwEU6D+fI
 rVdQ==
X-Gm-Message-State: AOJu0YxLIR6ZIDBMu2PR3HVdCBiMV6x2ej4WD1DQU6M35DrlS+K8VQkj
 betrtS2GLfoQYhe3aLw6Sf8IOoHxTpJuipMOItPycPzWMGVfUCcHxkjFHX6jLnlMPSEgLMoYltj
 cRjkE
X-Gm-Gg: Acq92OEUq6WcTJR9atsj6NK7redKtK5tvFDpJS2bOMQIGG5fN43p/55XMfivjgeMMF4
 YxLH3GrtPas0DBrxhm3wYM0Svg8cRhoTA4TKZApKjUd3TcXQMbOkFGzGlOgG/Odl8nuMbZYC1dr
 NTr5U1E2ndj4QrZj5GV94W3RQNOg0WfBatVfL86MOOB/rXCkV2s1Co82NIYlDgVEKLUiZN4JFL7
 EY7dN4ECoe47KmKcxZrCtBCm5sGDZMT1l7c1m+gwIGcVUEOkJ83gvcJiRygqHu3vFqUMVyr32f+
 p7w75OB0fnp1ADYR9jfIDIYUnF7xvBE4PeIsfpPk9oeaaWecDUDe7IlOUmUniUmTmVV5kLvgzbj
 twz5LAFzueSY5hNBQN9WqzjOAhty25rELpQcMDVS5q2jX3jidwn6RiFXOXD5xhZyFjvjV/1RXJJ
 zZuXmmEydMe0KSSKXJTEBkP44OAvN3FolLKwIGZlIMGygXiPx3ViNx+xO7BhpGwvNGyq+ffVIFi
 u+RP/gWdBr3OgUlOfeMKb8+89wTFm1zhc6wByNHYA==
X-Received: by 2002:a05:600c:674a:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-4909c0bc7d9mr49268945e9.22.1780055246562; 
 Fri, 29 May 2026 04:47:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] target/arm: Enable REVD for SVE2.1
Date: Fri, 29 May 2026 12:47:02 +0100
Message-ID: <20260529114723.42040-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220408.235438-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d04ef2dcfc..fb9d379184 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2993,7 +2993,8 @@ TRANS_FEAT(REVH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
 TRANS_FEAT(REVW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
 
-TRANS_FEAT(REVD, aa64_sme, gen_gvec_ool_arg_zpz, gen_helper_sme_revd_q, a, 0)
+TRANS_FEAT(REVD, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
+           gen_helper_sme_revd_q, a, 0)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
            gen_helper_sve_splice, a, a->esz)
-- 
2.43.0


