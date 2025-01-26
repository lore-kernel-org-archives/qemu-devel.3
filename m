Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57336C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2iZ-0004gm-Gv; Sun, 26 Jan 2025 08:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2iH-0004d4-LE
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:30:11 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2iG-0004Tu-0p
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:30:09 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21654fdd5daso60127735ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898205; x=1738503005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwzZb4kkYeTAwxBb5+xImh86ZSXTaZnnfQPmSt2IQzE=;
 b=jokcITRCtHltuM7WZlMIwJk9cnKJ4Z+HD7bZuoxPgU97p049EjKz4dW4pBjNHONWFl
 3VWINN/1GNLjVAraGvvhQUN7EpWgbYNvyAUH8uNb3ImVXwatO2chuON7ABIlHSgbCwDy
 o6eGDviroId976FAYF+H+vzIsvNY+Aqh9RCS+e2BAmq5Jh0eIaaMY419xz4avOOkuYuC
 8nwqRBxg+h/AS2nmVdDut1KofTpMAfL2KmX/0Yd0giJMEG6Hsn2Iia5KT76nwR6Fd72b
 kfgnESusQFvFLvkZq9CoPGe4MNjiUILgmFZQzA65kiibmaLx8unSDU0LTpOZP//64KVn
 ckYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898205; x=1738503005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwzZb4kkYeTAwxBb5+xImh86ZSXTaZnnfQPmSt2IQzE=;
 b=msGi0p9SA3A3YR9ua5x1+0FqAHKKytXSzjcB7gd6NNOhVyNrAKdn43me7mUcx9+Ycu
 f6rhxkBYqdvD4F9rnJDBCUa2JFHNQ3GLOEWtuCEvxl6iBqcQ2S4lsU9+paPrsD6SXJsq
 ddrRMslbde+ks1ZVS6E2gEToyB20zjvtm3XKqpFGuPCnvgLEZ6SITjfS9n2cgc7H39S0
 ehhIVn8LQ8l2WO3XVtSoa5lPi1atgibSSVsakNF3gPAE2/Qrl5Z93mTtUN65GPcr/uIF
 YRUiUc9R4o40yBC8yGsvXRA/rK+4HvhGBv6HJxdR3nEAxgBVDzZylUFfSjrmZju2FJsN
 a12Q==
X-Gm-Message-State: AOJu0Yy0TAsz0MN7ZFu+Gr/g4Ev2t71x7t8GtjBDT7JnXmvVvklY2Uyb
 pQ1quQ9s3mcDHm2ufPi8ssFoJnUEKQmbZwq8WoS+3PqQ8TD6DTU2lbme44VNMjBhc8N6FRDvrxP
 H
X-Gm-Gg: ASbGncsyd3VhozGabo1ztoUPk+55E6nFqha6T0RHnSAGyGZr7nf52IMdFma/zur7Xrq
 CitmCRtxKeCR/ZOx+s/UE1cxUlajXBsfJ2XWgU4pjdL9unu2X5FmiK60KNbvdE+FoBQ4Lhi1ZNQ
 WSE8REghDAuKaUgnsuqeUysqjASrHp/ibWSu7C8BtbeMaBaLb91L7krMveMkDSJBovBK+VPLWlx
 dwcDnPdTs6NNZgvuufUhvd2cPSAFAdbvwNW79p+fDz1s6cMrQ4RbL3NiXjiWXn0DTrxckbSnmEp
 55Bf5YOIPulPsmjjF6KYdstLVlWbsjwBLQ==
X-Google-Smtp-Source: AGHT+IEe0S5MuO3GvaQvSVn56uDXqPrnlyj2JjEe46pBWjYy+/4uc3UW3dHsNKebyQegBE5AJw5a+w==
X-Received: by 2002:a05:6a00:4c90:b0:728:ac38:4bee with SMTP id
 d2e1a72fcca58-72daf9ac957mr52032946b3a.2.1737898204773; 
 Sun, 26 Jan 2025 05:30:04 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48ea37e16sm4712289a12.15.2025.01.26.05.30.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:30:04 -0800 (PST)
Message-ID: <4b32b6ef-6cda-4c0a-aafa-0b43c956191c@linaro.org>
Date: Sun, 26 Jan 2025 05:30:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 73/76] target/i386: Detect flush-to-zero after rounding
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-74-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-74-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
> flush outputs to zero when we detect underflow, which is after
> rounding.  Set the detect_ftz flag accordingly.
> 
> This allows us to enable the test in fma.c which checks this
> behaviour.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 8 ++++----
>   tests/tcg/x86_64/fma.c       | 5 -----
>   2 files changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

