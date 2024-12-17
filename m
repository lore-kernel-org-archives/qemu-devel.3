Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F99E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeBa-0006do-EA; Tue, 17 Dec 2024 15:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeBY-0006VM-C5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:28:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeBW-0001sQ-Ht
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:28:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso44683975ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467329; x=1735072129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vV8AZ6bSmuBMtQ/aU1+6OvBpSt9oqBYi07LouR4qVcA=;
 b=mvHpGFPwKahWo4s1W2rxoLE3v4BmvTHSNfRciun8ftS1VSJ1U6BG1XC6NFrRWC1Wun
 o9+8R2/zyaW8edFVueEWEW54/ItmgBbJqcSIOdTqknOAbhcVplsB/ySXj0QhgOsEfdE8
 OhTSdlblzBJgCQCA/H4KB3RQSc2k6QKwvJ9F51Z4r4X3YHCGfEeXZD/iC1ZOGn3xp04i
 6bx16USKMHcRyVgO8XksZ10yv3dcIqHGnRaGb2ujfWRh5MeOWUmagZeDLb6mA2O865Yj
 xD2jTI2YQvsMDa4tTcAsgdiTWnOfZtl7h6ycBC72mgANZgIf4CPaX21VPlpoumRcvomR
 oNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467329; x=1735072129;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vV8AZ6bSmuBMtQ/aU1+6OvBpSt9oqBYi07LouR4qVcA=;
 b=Z2941QlZMCXIQbczvI8orDbsIoBKICz4qPP1b/O6E7xTSPFGVFxlclRIa7UyDq+uLv
 VjIOPhQHw3Aa8WBNKRKjgAchsSLiEvWOnA8t74qsozpMJpMynwjR/z9XgXIeuB8S+syR
 M37RYe8HZj3XsI5kJgZv7fbUqdF7mKo4igyhPUpHbR9gy8qOJOTmEE87VL2du+OnjylM
 lg/2/7PioVY59KO+a0jTpEEvAQ76OZTpDmZVHadOUIWNWjqwqkBCatUdg3hIquAQBabI
 X30yQ0pHUZWiDPz9l0h5YssCm3IaIxXGpUsfL3hAKOU6vXIJYexRvL4IBzfvC0vwQmt/
 fPrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFYY5QcAHG21WvTzIbYgqyu9ps0CVoy69SzJcdPitOU7TRs//ztdBUT0wlrt6KGOChTti8ZKUFeee+@nongnu.org
X-Gm-Message-State: AOJu0YznCqvLpmeeK2izapCggv2Yx04xOpzAhV3BLesKH9+ZzHqlkzcz
 /asP1o/qqSySpHd8CdtlJMNDPr9FnPb+GEeqvWoX2c8dHh3rTDGBZ0WPKVC6k3Y=
X-Gm-Gg: ASbGnctheZAq70f1tm4HTyG3eJhjRXLWJDhh0u7cr+MUNNtLLz3vBMBIhBPiQHZrLrf
 xzEPplbk8pwXezhO6evxOd+1P3FAgliWd0JJI0Px7l7+DV6cjOPd/+Cg1Y+mWr5n85HJ8vadqHp
 /CKNpHsHs8Ii+q5pVRztKX5AxV9WSICXdHBxkFPUp3eAAdHUK096VncdJsk+Gi//F7ET5Q8aJxB
 5mXtIHaDleD+i8GVg1tQs0MAZjjLQSHsEDSumGHFcFBHt2RmtzOUBQtBYy+kEqPlcJLLw==
X-Google-Smtp-Source: AGHT+IGgkVN1Z3ibTJOqP8eAjlXNrTnEsNRO2QcOThJ1oFQUaWMo9aD0lPHJ73AL9NJyyOyjDyzQcA==
X-Received: by 2002:a17:903:18b:b0:216:2a36:5b2a with SMTP id
 d9443c01a7336-218d727dd8cmr2235725ad.47.1734467328874; 
 Tue, 17 Dec 2024 12:28:48 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e50455sm63394565ad.159.2024.12.17.12.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:28:48 -0800 (PST)
Message-ID: <086a7d88-aa7f-4b79-98d3-05b7ebf7b64a@linaro.org>
Date: Tue, 17 Dec 2024 12:28:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/46] tcg/optimize: Use fold_masks_z in fold_neg_no_const
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 924ee165ba..cc3dc91d3f 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2027,14 +2027,9 @@ static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
>   {
>       /* Set to 1 all bits to the left of the rightmost.  */
>       uint64_t z_mask = arg_info(op->args[1])->z_mask;
> -    ctx->z_mask = -(z_mask & -z_mask);
> +    z_mask = -(z_mask & -z_mask);
>   
> -    /*
> -     * Because of fold_sub_to_neg, we want to always return true,
> -     * via finish_folding.
> -     */
> -    finish_folding(ctx, op);
> -    return true;
> +    return fold_masks_z(ctx, op, z_mask);
>   }
>   
>   static bool fold_neg(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


