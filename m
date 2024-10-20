Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C91D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cjW-0005aA-Nl; Sun, 20 Oct 2024 16:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cjT-0005Zp-Lq
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:40:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cjR-0007fa-Tz
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:40:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso3150502a91.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729456856; x=1730061656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SM5a9G+mhGVVM/mmHm9TPrfAIdGF8n2Q9ABiOyT/8ro=;
 b=g0YSJmLWNFN1aUmarQh9W2f25sDfmvlYR/d/L21UTn4Hzq8pRhVv0GpPTahwmSW1WO
 Q+mOWewFm1OVSDnoWQbyEbenb0zdcW5lDWI24XxCHSqOSRcNIgdgzvpayL6CBo21sDRo
 9W+dHgX3Cx7aZqWGfhW2E7PHcy4DCRqWt2J5sKY3nfvGyu1FhGL5WbZjbQiyxVRZWrgZ
 1ex9KoGaI1ZdQr9K7avojeL/AMoCWuMdLjaYgPa5ZkKNc3jTDgfK42oDiG179j8ivDVu
 126haFB2PrZE7kQHnI7HQlwFK2t8EzIFzqhW+laj8ve1jurv42LXFoq930awNSX1TCqr
 jAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729456856; x=1730061656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SM5a9G+mhGVVM/mmHm9TPrfAIdGF8n2Q9ABiOyT/8ro=;
 b=cgCAjzwNFzcn7fQnEpyLVlI414gKcczjcbq2VaI6NFrrGvagoVqqIp0PPSzijMHhHc
 Q0mNLlSLgSfVCqwtE4pC2ZCCG85/UjR1DeCbqRCd6uC2AeSUONPq7g+ehGTtHaoLgoAS
 UnxCxPNaKhTi/xoRdDF3kuvhXBzOMh84edxzTgIjAEe7OxoxB2mxrSFmcdrrOD11/TVO
 sr3RasfQMbCbGEnp9zVO7FtislIV5jDLafK8r+9U9dYa5P0OrOvxt7Och3wU51BxSDyK
 XPNl+1D/uXavXdwwkBG/U0+/LnQSZ8RYuisiaumkrlEF/Pk5+gCGOCjoAjJ0VG2JOBz5
 uuNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3ZD9WQq3E9oOuGZV0bVpoXzK7PH50i8Bhms5bDAzoQ5/OxvCTuPfc6HOYReKXHBhEPVo6czU5u0x@nongnu.org
X-Gm-Message-State: AOJu0YzEFqSmEnI9tUlWAVurWl4p+mb5BmnHguXZsw/yD/326vjkGzo7
 /DQtuWSwpw9t/b5X/KzpACZlKVWoCJ283kwtcDCfrt0YEcP20StDBUA1Le+DxM4=
X-Google-Smtp-Source: AGHT+IG9g4svMEdfkoG8yxSd4qTZEcshxlisf2Cc4nYGCz4UsgvXzsLTCs5qnsH5/ov97TGHPImp5Q==
X-Received: by 2002:a17:90a:17ef:b0:2e1:89aa:65b7 with SMTP id
 98e67ed59e1d1-2e56171dbc8mr10890187a91.9.1729456856262; 
 Sun, 20 Oct 2024 13:40:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad5178ebsm1968351a91.57.2024.10.20.13.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:40:55 -0700 (PDT)
Message-ID: <4ad3279d-1764-4a34-9ac8-3b1650fd1c91@linaro.org>
Date: Sun, 20 Oct 2024 13:40:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/i386: use builtin popcnt or parity to
 compute PF, if available
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> This removes the 256 byte parity table from the executable on
> x86, s390 and RISC-V/zbb hosts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/host-utils.h                | 16 ++++++++++++++++
>   target/i386/tcg/helper-tcg.h             | 12 ++++++++++++
>   target/i386/tcg/cc_helper_template.h.inc | 20 ++++++++++----------
>   target/i386/tcg/cc_helper.c              |  2 ++
>   target/i386/tcg/int_helper.c             |  4 ++--
>   5 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index ead97d354d6..bd4c684e5b5 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -126,6 +126,13 @@ static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
>   }
>   #endif
>   
> +#if defined __POPCNT__ || defined __s390x__|| defined __riscv_zbb
> +#define HAVE_FAST_CTPOP 1
> +#endif
> +#if defined __i386__ || defined __x86_64__ || defined HAVE_FAST_CTPOP
> +#define HAVE_FAST_PARITY8 1
> +#endif

This misses out on a few, and is rather pointless; see below.

> +/*
> + * parity8 - return the parity (1 = odd) of an 8-bit value.
> + * @val: The value to search
> + */
> +static inline int parity8(uint8_t val)
> +{
> +    return __builtin_parity(val);
> +}

This should be pretty darn close to ideal for all hosts.

> +#ifdef HAVE_FAST_PARITY8
> +static inline unsigned int compute_pf(uint8_t x)
> +{
> +    return !parity8(x) * CC_P;
> +}
> +#else
>   extern const uint8_t parity_table[256];
> +static inline unsigned int compute_pf(uint8_t x)
> +{
> +    return parity_table[x];
> +}
> +#endif

All common hosts have either parity or popcount.  I think there's no point keeping the 
other path for some hosts (non-zbb riscv, older sparc64, ?).  They are just as well served 
by pulling in libgcc's implementations.


r~

