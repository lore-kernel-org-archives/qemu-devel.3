Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F46D46C0B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 22:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlDy4-0004nC-59; Wed, 28 Jan 2026 17:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlDy2-0004mB-F0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:24:54 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlDy0-0001NJ-SD
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:24:54 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso259871b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769639091; x=1770243891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yS1nB5F9IrLRljJ2V/Vs5IpjpQX6AMHAKgWofzpFU0s=;
 b=idREaSgVWQBB9qUOQE3k3r2SOfTtuLGqNLBjwfduss9F/1vsWhKnlRI9qIR7sJwi0c
 9lbV7bJZjFXvj6zq/s/K7GGqzhselXc06mk0mBm8ToTrWVUnkkXMYKYpP5/08205qLnQ
 KUOkFS/aQ8OkHKEjxPtLcD5l20KzixhuggIiC51s+6yFKNRwT883OFW6Ynvi6SrhnIK0
 bQZ5LSjacf/H+lgzNFBlJxCSQ74tHj8849EjyGFT4kLXWA/NccMWpNrqQKGnsVAV09YG
 WD20HCz7FMgeFM9sy5V5BDvFyTLCMIEVV6x0uXnHzG0sa2i0OjRQ6kpUxVoCxsC8yahn
 JXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769639091; x=1770243891;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yS1nB5F9IrLRljJ2V/Vs5IpjpQX6AMHAKgWofzpFU0s=;
 b=nzJ0ar+vL+uNUSpNQZf+gG/fJRD2getf9gf2LyY04o+EVftQYvYhuJS7OSzLq7sqwN
 lE/qcOI5YAxUzjKA5yvb+9Mu6GG8oVfIsTwV+kHd5zpqNUjLkYj3koM41yhRg+yYiwsS
 hdvkVROeUJzfAIpAkbPJwq+rIQ+6GgcgkX6LsGBRwCwIMiRFbJCoCVgZ3ovhe9M98/G2
 YfhothsBcUADUm8tOjHjr3Qooz/2Rn1V/YVeBl3sNbvG2AyDucFwPe99laWlL6daT9xv
 H+V4jZs0NyzjZNf0JQZGqC0UELbo3k4GPQJaZafvMCLUz68lGNGZIDpZELVwfbT6BsMc
 LlPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3h1I8X8SpULH4qT3tP8H1OsJl+N/28ylQCiFmS5OaVeQV6PDV3G892B/hKhZMWQGOcYoUNKT2/8qv@nongnu.org
X-Gm-Message-State: AOJu0YxN1zw92d+lj4/a61Pk4DC9CeJimEubeuGEpmYnelG0chGtHFaI
 ZiiEHv2sjLyf4SYzslx0HIYCiTnw9M9zLGFhPKzSf7322LR6jKSgMr0DPFvGXy+T1UI=
X-Gm-Gg: AZuq6aKXAox9GfUFTNfNIOOD7GSC6i55a9HQtgcKXKxuT36aBSF+yOfpM6cnhSz5mhY
 1Gh07+pHFR+5/LEW3JHq6uvBlOIlt/gZXVYTTLostsh95pR0wATm9zzsEsjE4iwM0jz2DITvv+g
 dh+ogbLSaC7N2ju1JrFSviqp6wU8SSRZmQcGURBv7GiIGOeXCynZVlVP6AbITaB0Sya0u0LhDc2
 MQrNmh6ktZw4bvX0NtKjfrFyHuoFvYZ4xBOcadzB4dqy7Fgi/iyvCGZmtHWg4E1FQVfk5ibg6yp
 GRvu7COHx2wPpRXdVpAY7fNYcSSnjwym4DPWtMt7DUVSlRQ/zt42j570fdC6cBJPdOp2L1vK+JY
 VzaN6V/pnj1/xRMp+BvLmxnU3os1RIVYHIMXUP5KrgktPR+HGZ7/YdyDZ0NeC0Gjl8lf+/xb4eb
 yn3XbGFsOIeicTv6rW/jcNgS+n65Dbsw==
X-Received: by 2002:a05:6a00:240a:b0:823:142b:5ea2 with SMTP id
 d2e1a72fcca58-823691923fdmr5936540b3a.19.1769639091184; 
 Wed, 28 Jan 2026 14:24:51 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfd7a2sm3516547b3a.39.2026.01.28.14.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 14:24:50 -0800 (PST)
Message-ID: <d3f15b25-3a59-41df-b3c0-3c62073def11@linaro.org>
Date: Thu, 29 Jan 2026 09:24:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] target/arm: Handle SME-without-SVE on change of EL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260127154813.591744-1-peter.maydell@linaro.org>
 <20260127154813.591744-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127154813.591744-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/28/26 02:48, Peter Maydell wrote:
> aarch64_sve_change_el() currently assumes that SME implies
> SVE, and will return without doing anything if SVE is not
> implemented, skipping a possible requirement to change
> the vector register state because the SME vector length
> has changed. Update it to handle SME also.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a3dd84a2d6..bf3aca18b1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10128,8 +10128,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
>       int old_len, new_len;
>       bool old_a64, new_a64, sm;
>   
> -    /* Nothing to do if no SVE.  */
> -    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +    /* Nothing to do if no SVE or SME.  */
> +    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
>           return;
>       }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

