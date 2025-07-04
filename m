Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A88C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXpKM-0007n8-N1; Fri, 04 Jul 2025 18:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXpKL-0007mc-1Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:56:17 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXpKJ-0003Ut-2R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:56:16 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6138aedd718so831311eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751669773; x=1752274573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ou+0WFq2STWCoZpLVCiZpnuZ5I6nDVFyUDgY7umpZLg=;
 b=PJZYdqGuclzXsAl4LnKFEvR9nKvvhj93nM9HwDBn27FRV9NVs0JaLofBT0oWCleeSi
 R8UgJmyMFvxlkDv5aT5Qot7ugZFQ8/WYiV9LkhHpwjn139DvVbTTtQbwBwxMkgjiZwg0
 4f8GhE97wLyO9DpuLwLHEklmoJNk+5SKm4dxiUeRpHC/1cRpMZGiq1W2Te25LFw8+r+u
 +iiUrFyX3nJiHAoodBXTZFVYDEn5qWLv+i/DrR3p686LTH2H94wyEcPnVxFOkGoC+v8O
 2E5zIk9njxSM+74We/xySVDMFlPSYWnBqcZttr4vuvkh+/lIvPnhg/fJ7ZWwYbgQ4nv8
 4Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751669773; x=1752274573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ou+0WFq2STWCoZpLVCiZpnuZ5I6nDVFyUDgY7umpZLg=;
 b=Zi1XY8KXefCn2slw4url871iMRnonJApl/enJMuHDunhAgSEZx0TUHJcPHWRRO841r
 QaitI7hEtprOjSPkfPbeHB+sAwp+slih7eGFj/GibUhTTMSVWMsq0YAaXeRTXUCRMkFP
 SPTzVkhMmfaF+YIe8tRNkkHuyAUUhnUpDbCqJ8MLdfy79jx3rXXMHGUQAzmZ8zS4ZUzd
 74WAe6PQMKU7kATUpxACmrG/kUH5L03oBEvBaOgFCWVQouM9vQPArntiQ32JBZkDoKU7
 kh0Rn/bHVkP0lCHXAFNmMb0itEQM0Q+s29WvtIyHBmt6K3cxeLdiVaTpqBChUFQu0X0c
 tgWQ==
X-Gm-Message-State: AOJu0YwzxhvINwR7Nc4YvyyXPPsnOjFJuFnQhsni2ubMUmLWFGLNKc2Q
 bKKUs8RDCYidz/0tGU8Unn56k6THS3GlikX6wCUSW4eLKxJh+xhzMNyQ+k56yEPyvw0=
X-Gm-Gg: ASbGncu5ggOS4iXsRGKwyk1AbHQX8MfSl+UB66Hgt4Sro+PCIMJX26cY4/DMWF9MHHL
 5BGwcgMeQtysFBWZkQI8hDCxHx8wXnNR21tSflAuM6RkgA+1KlwsRwnAHZ6jNAV9fQrg3JR/vMK
 eFD+I/rMQh6fxD/qoiXKFtMrGQ2ozuw4HLWFWf2Zcp9+kmbBoEXQOpRwT0ZjBeI/EPawcuZwZ8l
 d7Mf5vMcaFZ+Nyei7jD6/ChW6iSsxda71991qZJ+ZKE+UI00CYl1Qha+vlzvVjJmpUD6/bZLUvU
 KoLPfDSeTeAx8iBhLAg2811QUAvihWGe7WVbq8uv7Tgt/BOLuKsyMomFHZLopjRRkouPzDv2xo1
 gKPLDP+ySYiARw6SoVxS7QXQIHCn+tnkuiivnp9m3oWEQqNNSkVY=
X-Google-Smtp-Source: AGHT+IHTawUUsQ6glpnrHxTd7cf6x0AI/Cp0cZaPjYUbdedgO91BKeT6aj2IZmdR7czXYLDweuv4Fg==
X-Received: by 2002:a05:6820:4684:b0:603:f521:ff26 with SMTP id
 006d021491bc7-6138eaf3c4cmr2810056eaf.1.1751669773427; 
 Fri, 04 Jul 2025 15:56:13 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5b8c9fsm422819eaf.34.2025.07.04.15.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 15:56:13 -0700 (PDT)
Message-ID: <af3c8b1b-63e0-43bf-8d9a-6c6bf699fa97@linaro.org>
Date: Fri, 4 Jul 2025 16:56:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WIP-for-10.1 v2 5/5] target/arm: Advertise FEAT_MEC in cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704151431.1033520-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 7/4/25 09:14, Gustavo Romero wrote:
> Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
> first step to fully support FEAT_MEC.
> 
> The FEAT_MEC is an extension to FEAT_RME that implements multiple
> Memory Encryption Contexts (MEC) so the memory in a realm can be
> encrypted and accessing it from the wrong encryption context is not
> possible. An encryption context allow the selection of a memory
> encryption engine.
> 
> At this point, no real memory encryption or obfuscation is supported,
> but software stacks that rely on FEAT_MEC to run should work properly,
> except if they use the new cache management instructions, which will
> be implement in a subsequent commit.

You really need to implement the new cache instruction before exposing this feature.  Like 
other cache instructions, the insn can be a nop.  All you need is the accessfn to trap 
when EL2 and !SS_Realm.

> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 611d7385d8..14f17febe2 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -89,6 +89,7 @@ the following architecture extensions:
>   - FEAT_LSE (Large System Extensions)
>   - FEAT_LSE2 (Large System Extensions v2)
>   - FEAT_LVA (Large Virtual Address space)
> +- FEAT_MEC (Memory Encryption Contexts)

We probably want to document that this is a stub implementation.

>   - FEAT_MixedEnd (Mixed-endian support)
>   - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
>   - FEAT_MOPS (Standardization of memory operations)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index e6a731472f..009618fd9c 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -603,6 +603,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
>       return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr3, ID_AA64MMFR3, MEC);
> +}

This test (updated for master of course) needs to be in the first patch, because you're 
using it in the implementations of SCTLR2 and TCR2.  So patches 2 and 3 don't build alone 
at the moment.

Alternately, implement SCTLR2 + TCR2 without *any* other features which would enable valid 
write bits, and then add the MEC code here.


r~

