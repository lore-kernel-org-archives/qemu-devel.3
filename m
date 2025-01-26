Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Rn-0003f1-0D; Sun, 26 Jan 2025 08:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Rl-0003e7-GW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:13:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Rk-0002Fa-23
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:13:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21680814d42so57486175ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897183; x=1738501983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ga1llZB5nkrNIzd8QiY0xhK+9uln/kuJjiiv2Jz8wQ=;
 b=VsT/MU1C8/5VgI/yqL1+5TpqW4V4jP1t7GVEKxCvPMM5JJbZzGoDjJjR8pFKhVYXvv
 b/fnyTeg+KB2GA/2xHsrertpVaMbmJpdhF7OAr7QGi8HepWzKm/630UjSe7h9xQjMM0l
 UCDJYylNeuOciDj4q4I6V5hk+VjHXM8xeQ+cpN2pNXSMTZfrJsCJplJdi5N5Bo7AaeCs
 uEv5KAI7hUTBnH4+01viqrezC5U6CRfzFlx5rgWs0If7Dcz4qKtNvSN5CcQ8W1PqVATV
 icZ33Xu1Fw/08noCgzUtThNFs7td4XZ5A8g1OWpaalLWhVA25uH8FKb3fq8Tzw8rAdC5
 qebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897183; x=1738501983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ga1llZB5nkrNIzd8QiY0xhK+9uln/kuJjiiv2Jz8wQ=;
 b=u/6RJ36bJmqDVCLikRMwxtbYFfmL5eQnvuCiTTX1IqMYer0ODNmlz9QaUyuAx1DyfZ
 DB3GL/Qvz2WJ3LNP8lbIfqud7hCg99gbOhb0jXLOUmaQkqMHueG7fq0fncJhpKzFqSAc
 2uNacRLo4gb3Iop+eRRiaxsz6W0V+qxOCpDXBJX4MAle0UpUkWCZOv6YpjoHI+KdBGkZ
 ZOvQKjNtxea1qeT9LOioKLB/qV92o5eo+Esal0Wd0FILoYwo3OWAmBVke0HEojKl1L54
 LPy1gvBGlaaLFg1L6fMiKZ6MsL3l0gLYbGoyJRpYD2QuoM95dA6iMeOLG09/zKAz6f0d
 xWZg==
X-Gm-Message-State: AOJu0YyrX8tjq/97V3xA4FPWN0538zi3R67BYV/pBEbACy1wBObwJEoh
 S6ToHuHNk/JwEqDiyHBo3rWsGwJARXBR33+RiPahQg9w+0uaLhtiols4hnRPS1PvbPsaWmto2df
 j
X-Gm-Gg: ASbGncu8uycy7UZFeeu21sqGPMSR9+U3BIJ6bv3gsPdexV3mef14XpVNFGZkofOGKnO
 tS3X2Tr/7700TAbyisoiscU9q/lILZ92/IsOOWirO/l/n6Tp5fS4Le256R2NG7Ym+RDd52Rnjuf
 1YUJTfTIxSAxbIsj/U7D2RDDVZvqBiYlHWt7FfWlRgW1UN+w5BfHE3GpcF6o39toSR9Au/yce7t
 qTf88LznkK2Qkc4dUqM9w24CkqE/UokcEaTI/RMeFoZuT4v79JAQ6NhNPyUKq1uLyRv6KeFXKm0
 GdDQGLt7xJkTXKM8Hte/PGY=
X-Google-Smtp-Source: AGHT+IGzii8aWojJgWvdpWcUguckXCox+742jdxAQa4IIvjK0ULL38rxDZ3s0QohpR80dA0MU6wwmQ==
X-Received: by 2002:a05:6a21:6d9d:b0:1e0:d934:6189 with SMTP id
 adf61e73a8af0-1eb2159bf7amr64592052637.31.1737897182725; 
 Sun, 26 Jan 2025 05:13:02 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c505sm5342452b3a.141.2025.01.26.05.13.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:13:02 -0800 (PST)
Message-ID: <3327ce80-2c29-4535-a125-dd196be73f8b@linaro.org>
Date: Sun, 26 Jan 2025 05:13:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/76] target/arm: Handle FPCR.AH in FMLSL
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-61-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-61-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> Honour the FPCR.AH "don't negate the sign of a NaN" semantics in
> FMLSL. We pass in the value of FPCR.AH in the SIMD data field, and
> use this to determine whether we should suppress the negation for
> NaN inputs.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c |  4 ++--
>   target/arm/tcg/vec_helper.c    | 28 ++++++++++++++++++++++++----
>   2 files changed, 26 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

