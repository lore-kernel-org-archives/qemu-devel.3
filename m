Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558EFD6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe74-0006U8-4p; Thu, 14 Nov 2024 12:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe6z-0006Sv-RN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:58:34 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe6y-0001na-Ch
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:58:33 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5ebc9bda8c8so462201eaf.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607110; x=1732211910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQFaD4qKSsRLcPddvXBcBcyrmQBGfMWW7+vJuj10OOM=;
 b=XUNpXs85B7VYMUxPjJ0IOmB4Uq61F/QhaNTQU+ATTjJNbbjPWrEiPr4fFE0pF55Kfx
 jnlFfBEkJ/L5ms1uuPkti4HxafOleXqSrJCazcYtnPYswW7+GkLNJqgb36JPnbCCpiM9
 TRHlC2mal+fWUF90NPGMGx6ZPtUl4Fuo0c0jn2pMTJLiwdeG1HICRnW4WwD+MocbOZp4
 XAZfqg1L+20dMZGthZmtiqEU8KrnV72YviHCJ8u8ZLQ6ZwJg6P9H0u3tKgt0kUp6aGS9
 X/nSDp+if2XZ5qx8jcyPgx0+4uu61/Wo9p3X6x1dTjcs0iTCCithTPenIurUJkMezT9p
 AiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607110; x=1732211910;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQFaD4qKSsRLcPddvXBcBcyrmQBGfMWW7+vJuj10OOM=;
 b=BVphB7TUJEs2XrAmcKTClzS4AaH/d+D2rbGXf8Durv2GhVfTwmfR1Wweq2wJK9vkA+
 kesCWku04Y4v7Qs7uXRZAgCFG/VUA+KaF5Oszu2oT5PkClhfwarXEI2dZZ3R7IWW6do0
 wFJc4PDpMvNV6+yiAF0q3lP9kQg7VH4NpyGF9BVQv39UCeW2dqY60jg7jiBJihW+6VLv
 row+oeUbxbxjBbzud19eIAipzF+H44u2vJyePvOQkQATwvJE7S5DGsn88pODkFOWJ+6C
 RYinKR7mVtIY9TO1jBruZ7/KR/5MRx/dOQimzKrI9wTuCfG9fCPThe8Bk+9FpZmoswXn
 PoXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLvkr964nQmbdaM8bEJvgGHkq7hbcCWoGWUSOcpH+oikOVqkuMClcVVBAAxV5q9RjiYh8WwYrMV5W9@nongnu.org
X-Gm-Message-State: AOJu0YyLXMkAcyvr8Mnxuk27aLYjVwIqmnqhe7sdD6KyYDW7v5WLp8Cb
 FP8FBZOQqfu0i1b2rIxiH8tND92FSBcgvCL0jSIn/hxJXavMe4JVPB6wcD1OSXM=
X-Google-Smtp-Source: AGHT+IFx5XPMzVIgfWHPNHunJA/E85GpFVHBWKvsZHE0qdvAq9lqMG3zhkUVi/x/WjM7vDFiGoUMZA==
X-Received: by 2002:a05:6830:6481:b0:715:4a9c:a7f2 with SMTP id
 46e09a7af769-71a6e600cb1mr3053572a34.24.1731607108676; 
 Thu, 14 Nov 2024 09:58:28 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b37f6555sm1386917a12.44.2024.11.14.09.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:58:28 -0800 (PST)
Message-ID: <a9ad20a5-854a-4238-9044-f2ed056d8469@linaro.org>
Date: Thu, 14 Nov 2024 09:58:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/54] accel/tcg: Flush entire tlb when a masked range
 wraps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc31.google.com
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



On 11/14/24 08:00, Richard Henderson wrote:
> We expect masked address spaces to be quite large, e.g. 56 bits
> for AArch64 top-byte-ignore mode.  We do not expect addr+len to
> wrap around, but it is possible with AArch64 guest flush range
> instructions.
> 
> Convert this unlikely case to a full tlb flush.  This can simplify
> the subroutines actually performing the range flush.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5510f40333..31c45a6213 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -802,6 +802,11 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>           tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
>           return;
>       }
> +    /* If addr+len wraps in len bits, fall back to full flush. */
> +    if (bits < TARGET_LONG_BITS && ((addr ^ (addr + len - 1)) >> bits)) {
> +        tlb_flush_by_mmuidx(cpu, idxmap);
> +        return;
> +    }
>   
>       /* This should already be page aligned */
>       d.addr = addr & TARGET_PAGE_MASK;
> @@ -838,6 +843,11 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>           tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
>           return;
>       }
> +    /* If addr+len wraps in len bits, fall back to full flush. */
> +    if (bits < TARGET_LONG_BITS && ((addr ^ (addr + len - 1)) >> bits)) {
> +        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
> +        return;
> +    }
>   
>       /* This should already be page aligned */
>       d.addr = addr & TARGET_PAGE_MASK;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


