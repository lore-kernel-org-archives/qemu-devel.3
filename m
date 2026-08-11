Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpLt-0007DS-KP; Tue, 11 Aug 2026 12:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtpLs-0007Cx-7V
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtpLq-00005J-KM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84847482584so68378b3a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786465757; x=1787070557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTCUsWVvWRYcmkIhnX8+6fEAgNkMrfM97qaYv54fmOc=;
 b=uEHIKmdyuJvoZG7ww3aGmhc1EGZTzuHcSZXCI0SBvw/urOgzkR3QqIMKEVctbmDpcQ
 O86mcNSetFzo7+KXMuohojq6tgyKtBcXWMRkZzmytUFJ/ZW6q9Kdcq+5LJVHMSoBOrsc
 Xv5s6qgVEqE2geaIqbrYtKiMNW/ouTner4GfK0buM32ad3/2vwGzIHzplO+/hZvAz8Ez
 agNNUaqae0HRf6/vCrZQ24KkKKOulwaoQQmPAy6D8L1kInfgNjPn/l/iz7I4gbPOPxhd
 bYCbJneKPgQ9RhF52eUJ/6B4OKiDzgoZmrFL1XGejc/KSEj9agWd1EyLOmCjVwo7mdWH
 3BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786465757; x=1787070557;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTCUsWVvWRYcmkIhnX8+6fEAgNkMrfM97qaYv54fmOc=;
 b=J08m71NYVZQc9De3fPM7T9spB+dUswXEZfJ0hXKew9JF3OTwytwUYIIc9XIpgTvMvo
 HAXZJMgQ5VP1jMIcC4B8gVDjjamTeBl41WJDLGzrbFQhzjj4h+sslOWCcUF7Fwo5ZgO3
 +bCy9vb6h/Xry7LhagvkXi6TJWqgOmhDXeyHTeq4yyNmZTDMXl99Ab8A5DTV1Xt2JOLp
 hkNskDzCvxt2FQj1VF4/fFpfdPkf9jiXcqaWZl3Hv8Np2s7NIS3Bex43TJ5+5qevYcE/
 vHJONmp4S38H/hIk1plHDbv5fMMp/Iov4cujfkFIABN5G0NkA30bWNyKvCtWtY08rtbY
 Sffg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqA1BDUY9BWTwrpg+Z+sZrBjRquezlhta4v7g+wmX5rmEdiVFJcKDeMBCNPEtEfke8fxsP8Y5KIC998@nongnu.org
X-Gm-Message-State: AOJu0YwEjS6JDKqqIRGxlDRbfNfP7tyhwyUWQwKf0u1J8OSL7rN9hfYT
 MIlhK5VMlMCy634nMXhvlWtHQ2MezbvD7L1hVCnhs6WP+BdlGTdD6+uRvVUbLWa1ei4=
X-Gm-Gg: AR+sD13tk1Gp5ijq/bIG4gfWnIbJUx/g7JavTf5lE7iC87GRxpoIX5/0BxRtsTbxk6z
 MXqMxQ5ZOAQGsVxU6ViuykYoTCcva7jOCj7K0D8cSmnizJvOqraevASbnAlx5cSGqjm+YN4gbW6
 oEKCLfjF3MkoLsyd5iIIjlK4PzHiKGq8lcS3bjazlE1pAYpn/2zokgPlx/E7tQtphcCCaZyf4bK
 Eo8KgUtE7+OE7sukhmfvxSCJt4oSxK9WQvjec7591IavC7pxm4VSOOzMNIz+na0826v3blyMbpB
 Tgfs3xzXwQ97o3kHNetcJWuauxEKlDs+IwEPVYhcX+cJ2Z9GQ5aE4RVCRisKN5SwioTtr4CwLre
 ju4Z9HMQF1qezeXgM9OgNw4j9FLbe0M3yzlahtjmfocgwJlcOTzglwBpYhZIx2E0cLBr1z7Rwdz
 3iEpt13nUD5KGe1CAt2xhGCdZYVH4gKwKuxqnXnnIuYr6vQLa05UzxVO9uLdYvTKy2AADLC4fy4
 j+gjIIi4RulPAbHEpalw8AaBgXd
X-Received: by 2002:a05:6a00:130f:b0:84f:3dc2:31c3 with SMTP id
 d2e1a72fcca58-84faff05cfamr1171126b3a.15.1786465756792; 
 Tue, 11 Aug 2026 09:29:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f252dfsm26706b3a.48.2026.08.11.09.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 09:29:16 -0700 (PDT)
Message-ID: <db92e3f8-9f31-40e7-a715-190630cdb88e@linaro.org>
Date: Tue, 11 Aug 2026 09:29:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary
 case
To: yang.yanjun1@sanechips.com.cn, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <202608060749.6767nOjv097972@mse-fl2.zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <202608060749.6767nOjv097972@mse-fl2.zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/6/26 00:47, yang.yanjun1@sanechips.com.cn wrote:
> From: YanjunYang <yang.yanjun1@sanechips.com.cn>
> 
> The trans_WHILE_ptr function incorrectly handles the case where the
> address difference divided by ESIZE results in zero. This happens when
> the address difference is less than ESIZE but greater than zero.
> 
> In this boundary case, the address difference is less than ESIZE, which
> means all elements are safe from conflicts. The previous code would set
> the predicate to all zeros, but the correct behavior is to set all
> elements to one.
> 
> Fix by checking if diff == 0 after the shift and setting diff to tmax
> (all elements true) in this case.
> 
> Fixes the following test cases:
>    whilewr p0.s, x9, x10  ; x9=8, x10=11 => p0=0xffffffff (all ones)
>    whilerw p0.s, x9, x10  ; x9=8, x10=11 => p0=0xffffffff (all ones)
> 
> Signed-off-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
> ---
>   target/arm/tcg/translate-sve.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index fc4cc8c479..33613ebf58 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -3736,6 +3736,10 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
>           tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
>       }
> 
> +    /* If diff == 0, the address difference is less than ESIZE,
> +       so all elements are safe from conflicts. */
> +    tcg_gen_movcond_i64(TCG_COND_EQ, diff, diff, tcg_constant_i64(0), tmax, diff);
> +
>       /* Bound to the maximum.  */
>       tcg_gen_umin_i64(diff, diff, tmax);
> 

For whilerw, we should replace the preceding test, which for some reason compares op0 == 
op1 directly instead of diff == 0 after the division.

For whilewr, we need 65-bit arithmetic for the straightforward solution, which I think 
means we need two comparisons, including this one.  Possibly clearer as

     diff = unsigned_saturating_sub(op1, op0)
     diff = diff >> esz
     diff = diff ? diff : max
     diff = umin(diff, max)

where unsigned_saturating_sub(x, y) -> umax(x, y) - y

Less clear, but possibly more efficient,

     diff = umin(diff - 1, max - 1) + 1;

instead of the direct comparison against 0.

I'll prepare a patch.  Thanks for the report.


r~

