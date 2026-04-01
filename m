Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B41061B31
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7mvz-0000p4-IP; Wed, 01 Apr 2026 00:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7mvx-0000oV-LE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:12:01 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7mvu-0001ki-Dz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:12:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d8e548a05so4521120a91.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775016716; x=1775621516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTUvG2bQYKBmkEgKHomLI08q5jTinJyVh+PH1aAcKQw=;
 b=LuJHBu7nJv1v9ZjV6FPmQHbh4BfOgxzNudkxXZ4PVOdljmv8qIOWc1jpgeqsOsAno1
 DIkt75HnYTS4T6Ad9CHICUvZ6jQQjN+hYlZJx0rmcvp55uRlcZD3kD/N5H3RnXDCW9ge
 CVdflZlEe/E6HenhUA9fylgJnnnspO2iETq0QymtDTCDCP9rJ/0pz3qcJkYr6hlQFZ6+
 IWbszcNBIl0JaBVevFM5SaYeiKxUzqQ0QzSs6/gSBaRcRvBEZDP8p/XSfLJF3Wnr3Q6I
 JnkOIx8omw4E0nKlNna48LfK4/wtJONGO31qp8e9E4JUB4a24MQT4A/4fQ+xqSee/Ev+
 vVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775016716; x=1775621516;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTUvG2bQYKBmkEgKHomLI08q5jTinJyVh+PH1aAcKQw=;
 b=GtOoFpjMYwcOf0u9KYK6NDhevAeBOHbL/0KJZWYEfZ/Mknef/hlIGA5vlXrRyHHlrg
 QmtdG9XWun0ZzYVMCVbDDGoo6Ahp0lGsEWtxR/jIOpNBJ8vKdUNu+nVae6OHQgo0G9t4
 P1Hj9uWTKGIpl1YMNgI/mpbeDb49RwkTKCQA8N7gnrJ3bt3AzTzQV1oDheOfiABmKuzo
 oDbij0TyodfOf+frQXoTIZ7/mDpNjZ6JJYBxuPNdAxBLWpuuMCUgcrhy7+urM0xAtWd4
 MfpHSRMvF5JOcl2txgovC6mzXHoZjDRujqP+34DbCn++W1fyxwR8SW38x35KPxXSdnSH
 rDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDDUTiMxRXE3fxikWqOfGtKcoCUGwDUL14ZK6ezC2nRoR4I7+HDSWk6KHLHeZjitOEv9Mnf2/k8Qvd@nongnu.org
X-Gm-Message-State: AOJu0YzDDtSO8Po0SmjJljJPp5GheJfizA7U9DtnlbWY9NS/FQcnNGGn
 QXuZlWlg2dCrRxN5u7jC31nIOrdVDePrCnXjrg3k8HqZQHmpdNZ0cjLUns3mBy6QCUc=
X-Gm-Gg: ATEYQzzk4MFbADMyHsBcfFZt8g+ROx5vrtXNCPZvJI4C360gQDyBOwc2ETgHLgjGKUM
 sCivvfB0+SFxPvxE9osNpfoDMYHoRPrP9MIFSLjPRGD4k4PVcPN3TD3fqD0NicXvbqovKyiy+MU
 usOBLbDS5YbGNOiOHFMBqDgIch07KZZrLWMXcgL+S83k/2AUux5XMsFPjsLcQK7+BjaVzjSTFgi
 da8vna6C9GR5fS2+uDcQpC9SJpBPxVZshpuAUWTIXFea3NHzd1MXp2OPaOoCn2Eqf/ap94nt40Q
 bjoXt3ZXl6Gl2p2b0xIM/k5P0V+aqEk/MAEW4FoQdmBEyTvr1R2OgPNxG2qiL70wYmSf7DPCVv1
 yK4C5to0g0EVq3hO989wVD6cZlJGId9kQuor/g+6UG16B9oQTgEJrSw4bVQIJbmTla/rEQTJQ1J
 n2RXzcJ2a+DuQ29WUDBG9V9Urya6GnGmkyxB0gBd7vH4g9RXGmBmlW/nJRMrsv9GSj98+f7wa/C
 XGwYrIVpwTr3A==
X-Received: by 2002:a17:90b:3d92:b0:35d:a557:e44 with SMTP id
 98e67ed59e1d1-35dc6e7ab5cmr1989326a91.6.1775016716199; 
 Tue, 31 Mar 2026 21:11:56 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-170.dyn.ip.vocus.au.
 [122.150.206.170]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbb883465sm1621007a91.5.2026.03.31.21.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 21:11:55 -0700 (PDT)
Message-ID: <b29dca1f-dde3-4e70-ae08-750d162e1b7d@linaro.org>
Date: Wed, 1 Apr 2026 14:11:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: do_ats_write(): avoid assertion when ptw
 failed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260331092305.2062580-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260331092305.2062580-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/31/26 19:23, Peter Maydell wrote:
> In do_ats_write() we try to assert that the cacheattrs from
> get_phys_addr_for_at() are in the form we expect:
> 
>      /*
>       * ATS operations only do S1 or S1+S2 translations, so we never
>       * have to deal with the ARMCacheAttrs format for S2 only.
>       */
>      assert(!res.cacheattrs.is_s2_format);
> 
> However, the GetPhysAddrResult struct documents that its fields are
> only valid when the page table walk succeeded.  For a two stage page
> table walk which fails during stage two, we will return early from
> get_phys_addr_twostage() and depending on the fault type the
> res.cacheattrs may have been initialized with the stage 2 cache attr
> information in stage 2 format.  In this case we will incorrectly
> assert here.
> 
> Fix the assertion to not look at the res fields if the lookup failed.
> 
> Note for stable backports: the do_ats_write() function is in
> target/arm/helper.c in older QEMU versions, but the change to the
> assert line is the same.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3328
> Fixes: 9f225e607f21 ("target/arm: Postpone interpretation of stage 2 descriptor attribute bits")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a regression, but it's a very safe fix, so this will probably
> get into 11.0.
> 
>   target/arm/tcg/cpregs-at.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
> index 0e8f229aa7..53dd67375d 100644
> --- a/target/arm/tcg/cpregs-at.c
> +++ b/target/arm/tcg/cpregs-at.c
> @@ -37,8 +37,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>       /*
>        * ATS operations only do S1 or S1+S2 translations, so we never
>        * have to deal with the ARMCacheAttrs format for S2 only.
> +     * (Note that res fields are only valid on ptw success.)
>        */
> -    assert(!res.cacheattrs.is_s2_format);
> +    assert(ret || !res.cacheattrs.is_s2_format);
>   
>       if (ret) {
>           /*

The assert could plausibly be moved somewhere !ret is already tested.  E.g. just before 
the only use of cacheattrs.  That said,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

