Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2C3E9D826
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xy8-0001iN-V6; Sun, 05 Apr 2026 20:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xy5-0001hY-0o
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:37:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xy1-0003Sk-R4
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:37:27 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35c1d101355so1329797a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775435843; x=1776040643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uLx0kp1NU4WfNi2dCLM7HO1GoEyWIRQUzJJd1yrHSIU=;
 b=XN2/ovAah4s3oQMIPpSkI5HEW4A2jTWepL77KA6JFXkaVNkMrHiqg/UpvnAsK7oXQu
 tCKreesUUWcijzBD8ZwHfb7X7FHBqwRDy5obG7AmxU9d48nHbDPc4BFYBRGuB6Mk+W06
 KN2SDxtu/tVokukBEpVoHycwDb70Tpz4gDmdBesx6k6dACjNaUHwxstdxzLOryVwS3eY
 phqL4ZyREgcvXTQCMCdBV0jdU+gH1Hqz6QKtUM+6eG6GqdZ0e4sHgNasaui1oFikvX/F
 64v0E4lBmnIqiyYWFeb3t0hhsE9SWoW1mZkVFcbG+Ffi3kOmVfjA70oYgkXq5JonXzeQ
 IPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775435843; x=1776040643;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLx0kp1NU4WfNi2dCLM7HO1GoEyWIRQUzJJd1yrHSIU=;
 b=dLrJIrQCSKSzLOioGHvoAHtJxtdfGxXbSfX7qfpN6xhVbsBT+VLXlpLrsnekNfFByK
 8tIgsmiMq01niPwGNpSsfTIBnc1CZyj3P6PwqC7DyDwejiB7/42z3fVSMj/gR1dkGvVT
 hzp5BlFnS/UWA2Zij2DHvqSt7Pz5UgG4leJ9f/5XBwuOelWDsgxOlNNhHOTzYL6CKRSp
 d2V9qMNrqs6YQmdsaPVm5EXJbMbHUg134esEytttQxbutUtdw5xgmwWedYI1HBQO6+KQ
 rVNgryUmU/2OFm0Mc32kUqoZ//WZkcg/KoEPpmIjveMT7vBceSCR0h6V622wJV9Y8ht+
 WyMw==
X-Gm-Message-State: AOJu0YxP31MXtoozIxGx8grxUdvvqC3VWBsCTlBZc1iCpQITn4JNVp+Z
 58gnudqwHJ1lHlcm6tQmOAnwaWWsCnVY8HNHEC/TiPAqgfxmwzIRMxWvY10zJPJKRWMGBqAQ+Kn
 kSWaX
X-Gm-Gg: AeBDievX/erEuHYr5SnXB5VPhKeavT+jW09OZCWzRP7NNBxeZ9/Z8UWWsCBpPJtIU+2
 H8KkSE4f+jbb/ziD+ZEHSXw2Gx8EgxjBpP8gxjfOAqCaV0S+DTF16IZEpBza1D4kDRMeUH7H8T0
 GkSdklRyvku8Lizol5VyqifTg+UkhNpKfis8KBswl9SiQ+A+ILMCuKldrlbyjocwZwPObAxq713
 8EqFSngO/ZZD309wwA8xAFrhzQnFDfv/MKkZdaqwlPBMt+2U05+27X4zidhnI4xPoH8BsGm+g5h
 I8uhzE9zf1iTdwLyXTQus9Q7vxs+8C/dnbVdyleFPflP6rCWk/Hw3LFTUDBYdp649FpQ8ryH0CB
 gBPMrGju4lkKTDjIN68+S+ApW+k4BU5szQXE6cQdcNGLeiVjFoaaeAfoR/1uf9eC2Tv5qAoiBFj
 MCeKJuW5fw030++h54EkEWSg2AA9lQO7uQM4KmZTB9Nf9/gDE8cnmCygIIOlDxU/bIWcs=
X-Received: by 2002:a17:90a:1681:b0:35d:8ea1:62c3 with SMTP id
 98e67ed59e1d1-35de67d6654mr6315178a91.3.1775435842915; 
 Sun, 05 Apr 2026 17:37:22 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de5197472sm4168606a91.1.2026.04.05.17.37.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:37:22 -0700 (PDT)
Message-ID: <0877e0da-c083-4293-bba2-5c1d2e2315b7@linaro.org>
Date: Mon, 6 Apr 2026 10:37:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/35] target/arm: wrap event_register in a union
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-28-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> While the event register is either set or not due to the
> implementation defined nature of bool types we can't set it directly
> from TCG code. By wrapping in a union we can alias a 32 bit value to
> the bool in a future patch.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/cpu.h           | 9 +++++++--
>   hw/intc/armv7m_nvic.c      | 2 +-
>   target/arm/machine.c       | 4 ++--
>   target/arm/tcg/m_helper.c  | 4 ++--
>   target/arm/tcg/op_helper.c | 6 +++---
>   5 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bf6cf74c2e1..9c25b60ae83 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -763,9 +763,14 @@ typedef struct CPUArchState {
>       /*
>        * The event register is shared by all ARM profiles (A/R/M),
>        * so it is stored in the top-level CPU state.
> -     * WFE/SEV handling is currently implemented only for M-profile.
> +     *
> +     * It is treated as a boolean but we need the union so we can set
> +     * it from TCG.
>        */
> -    bool event_register;
> +    union {
> +        bool as_bool;
> +        uint32_t as_uint32;
> +    } event_register;

What are you attempting here?  This smells like a big-endian bug.

TCG is certainly capable of storing to a bool, via tcg_gen_st8_*.


r~


