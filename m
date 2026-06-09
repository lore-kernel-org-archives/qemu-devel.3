Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A34ECD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWx06-0001Mh-AK; Tue, 09 Jun 2026 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx03-0001LG-19
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx01-0004Ic-5a
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so46517575e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781013610; x=1781618410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KjJGKEpH2qByU3Ess85Ejl8SXkz/f7VS9AteXOnW56c=;
 b=Q9tNFYQVIOOKL6E3DV1UIPli6upb3PjE8YauDaqiO7fa5bbWc29+mJZvoFJmcBxZCt
 jscBA1vdE6dL42++AVEhhgACoL29d+hdzp5i7vhoTKpvSpHoD+xMYm6ndMI3jUf2ORdQ
 P3VL68cniFxTO2hhBoWa0oElhal3FquiG5sFGKDr1xmlsXrw14CnyVrKsU6SumKy1d12
 0Me2ndHcT+IJAr11Fvkdiq+ra8GXOM+TSjd+1ztCf9zJnqRi6+zHX2BEzBztlQhZxV+C
 jx2PsCb2PKypLiEvtCGk4BVfSAS5HRmkozxidO43GqchVO4EP85MCo5tuau3IUnLx4nP
 Blhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013610; x=1781618410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjJGKEpH2qByU3Ess85Ejl8SXkz/f7VS9AteXOnW56c=;
 b=hpjiPXxVqF3fRlQBSBOgrKivWjx0E0AsU9qGI22yB8Dcdzy5fH4mM7FcO5MPIkqZ4b
 lZrlSVZi+R0VQj86YXY5uOHsajvxXHU8JBqZfbLGF8BQyayG83/x/Lm5/pszKdlqPf7O
 2IQ88ZJG1oQ3uLyNSTfBzUlQE75qwoLzxUbmzSSPtPLx1edhJMLvOFlaRwqUaFRlIt2a
 BaVB8kw/rxDjPTDtE72udJLqqmNMgaBwPZBJaOYL4VcDEeDCJHU8IXodxD73yQ3Vy9+j
 +EZ7W3GQSC7VTLnfypHQie+5QzD8yDGIMaVccLWftJC1idq3L+7axrPHAeB2Bx/rsKeL
 QXUw==
X-Gm-Message-State: AOJu0YwhqRjKoAidvBZ4qx0gdkmg8XSdGVanto0G0RxRXS/OqUfYkxMC
 esBkS4UjVnqh+4oKY4dJOqSGuhvlBYznIBK5nC96N0cpeF5oKGCcwKwUb1AT+OXclM8=
X-Gm-Gg: Acq92OHA/eLuFFtXzqygD8XGJhFro6h8t6dAPToO+OSn9T7mFOMI8jn9x2PObYRwslj
 EVXY+cJRd0I5f5X52/LgqwvYPdBlRBfNe4oiUSJ1IEolnITqw84hHOurjNRiHCrqGnPRhKo2Wk2
 Jktwo8+RzjekbHpwT8ByH5Hyf2M1EHL4BU1jlYeOBABd8Q1/3vbrsEioLXmlTnubIhyuJneaxP1
 g04/BDwQgktQQGtht2phxHma8NkYkXgxj8FUWfVpCrgOl4BloGF6E+C5xgd319PNRM4Qp+ODLcK
 fv2epPRCOEjLUMfGyfoYvMK8lgpWnZ0kbOXA14qJ+blv7dTKOmhrCjSGKbuzZAmGmFwtzbJo1Fd
 lrSPg+xPBq40j0BcSy5irzQrnYWmddzoGe/drOacX/Pjgbklr71vKWMJYR95OlYxfcIECwWJglr
 9rfrqWY4vbHlruJZZCAPFddVVCkCM4i65FjsnYDwhw6yS/
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490c2cc27bdmr277704615e9.6.1781013610508; 
 Tue, 09 Jun 2026 07:00:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm554328835e9.3.2026.06.09.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:00:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79DFC5F7C6;
 Tue, 09 Jun 2026 15:00:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/5] target/arm: a few timer fixes while checking FEAT_ECV_POFF
Date: Tue,  9 Jun 2026 15:00:03 +0100
Message-ID: <20260609140008.3206970-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

While I was checking what was needed for FEAT_ECV_POFF I discovered a
few potential correctness issues. We had actually already done the
work for the feature so the final patch is just documentation.

Alex.

Alex Bennée (5):
  target/arm: split evaluation of CNTHCTL timer IRQ masks
  target/arm: trigger timer recalculation when toggling CNTHCTL:ECV
  target/arm: trigger timer recalc on SCR:ECVEN change
  target/arm: trigger timer recalc on HCR:(E2H|TGE) changes
  docs/system: add FEAT_ECV_POFF to the emulation list

 docs/system/arm/emulation.rst |  1 +
 target/arm/helper.c           | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.47.3


