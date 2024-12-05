Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E5E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFwi-0002AQ-HJ; Thu, 05 Dec 2024 12:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFwh-0002A2-Dh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:47:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFwf-0000SY-G4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:47:22 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so8541845e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733420840; x=1734025640; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gWaYyAc58MziuRislcGDADqXDO1h6t6v30C5Uq/aXy8=;
 b=E36hNpX6wzn38UDeD8/kTnAw3dBiSw7CT0hinCj0SCoMRC6X3/baIh2Z8kbrhZTW2Z
 /o1jMfbPghcxIJpoejmj+8pF8SrQnEt9+m+0IWSiqXNB9pvexncn4/wxnTSc2y2n1FzF
 7/FGyEJLkOba0SSEHP/MBXWvEsE+tGvTKahkOAioPlLETXjNmZnx8D8OXqEgugaGlelz
 iIgeyJIxPyVZyK+6PIffCTNClER7FlFfnFmqbyNr7Zl734Y3ooZSLJPPOmnWDN1r8KZc
 7r0MQBg/bwqBDd55CAfB3ntN9wu7uJIat9dCW9tgpMsf9Xjt8vPAlp1bfIX7MYryFXpv
 psXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733420840; x=1734025640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWaYyAc58MziuRislcGDADqXDO1h6t6v30C5Uq/aXy8=;
 b=PJqf8/zzVMyyB+XJaxBAy7e8mW+xynVtUEbS9OHRLTXE/dD302WmE2vC9TXJcb6gUA
 JNhqJPofHe1aUnfe1Xzwj2mPzsMpm7dC++dqi+DsZGhu8zE65dGqU5BW/0AmRZy++cs7
 GytzjLeJuZFwsjK5EBFnhE8v5wOJeXTGCTwMLX7vvVuvtQNtpRYUId/rhsKNq2rYr4o9
 WwcHXkiuZtcvTh0fo+/o/6gsn+oeBK6PG4ZRuQoT1eEoZOLPvpsF78+kYhbiyPZvjxuR
 wLcYnFoVEYlBpazSb6I7/elioaU7h+xXoetyHK199lyJmGrLrczohpKP4FEIp79HxqD+
 b4Rw==
X-Gm-Message-State: AOJu0YxQ5Kf9Z0UmWQqz7mXYgjIzZjZCQYU4DaVVfzB+IxmC4pUiVuPe
 LZF5ajHComsskdjvXGBn5U4QOjWrSiXafXWrplJ8su1MytyqpfbEs4Od2cTJ96QaY2eUaNK8AbB
 9y3m0O8yjfAuAhF0sHL7AP2OpB7X4B1yxD0VqPA==
X-Gm-Gg: ASbGncs0qQTdK2QPMrLNnhTjrs0iPnkJjB+mBc8uXogqd6ACPG/XzPjp218fekPIHcD
 rYsSNLp3d5GTiw4Qa3Zt8NhGMGLHo5f63
X-Google-Smtp-Source: AGHT+IHUK7wJ1RBtzMq1Exy46Vt+k4JRKVPvyTk3GCJYbXPuBiLkijIANtHScEcuBT/A9s1ZFU/BnG+EAkZAb1l3Wz4=
X-Received: by 2002:a05:600c:1d1b:b0:434:a5e6:64f6 with SMTP id
 5b1f17b1804b1-434ddeabcf0mr1864845e9.11.1733420839737; Thu, 05 Dec 2024
 09:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-16-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:47:08 +0000
Message-ID: <CAFEAcA-n4-m14bD--=-SYjijjxNZy5DwN73=mpucCnJ9kNt4Lg@mail.gmail.com>
Subject: Re: [PATCH 15/67] target/arm: Convert disas_adc_sbc to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

On Sun, 1 Dec 2024 at 15:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes ADC, SBC, ADCS, SBCS.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 43 +++++++++++++---------------------
>  target/arm/tcg/a64.decode      |  6 +++++
>  2 files changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

