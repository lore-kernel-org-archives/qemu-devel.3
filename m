Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A12C10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXl1-00008K-DF; Wed, 08 Apr 2026 14:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXky-0008VH-1K
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:36:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAEOs-0004wh-3t
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:56:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso26931015e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775598956; x=1776203756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=neFvve/rUExOH07d37NMYjOGCEocWXfGOtS8mIe395I=;
 b=RqE9+fzFRkT8Jq1JuNd94sxo2vF9HwAxRNjJ9+BVhxYHIz5WnE7miycMPw3mRaGRj9
 cET75DvgFbP6cia2bT0QiLeW/DU2PaM/6RLBOvyEKylpd6gO5+0317SCDIfm58iAI+Xp
 TuVKYOM38q43Tc6m327tczZDCYt7p/2U+Sos6pAmZXp5grQ+d+U8RjDhQ8I7tJbZtfdP
 JGuLSQQvKn9D0i7S+O/FHt5obHa3py29FDjhskA0y/NWCDMQ9NRtBgX6144tvpVr9ANr
 5yEtN2Nhlzbs+ZUorGtGoxfA2O9umFbdS521qBzJag/gVBXaFZzHagBgtrgHWkZ9v1KC
 fSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775598956; x=1776203756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=neFvve/rUExOH07d37NMYjOGCEocWXfGOtS8mIe395I=;
 b=UoAXKe6bGOIRdDUJyUjgGcx3vRtEe/Ae0Tfl1nUyl/ps9aIo0hHUo/V40sPY8CQ3PO
 VSVt9QoR/pTQn8Sv92KgLhH1iDTtnLjfuV0EwwQgOOktjsm01cmOdPfHGDf0Z1T1Z2Vb
 auh+6fMhf0RN7OQG4242Q7WIpBnhGV+yMtyk1skkxVIL9UGVFgri7w7PTlO97WUiXMgY
 v6DuHgZeagFLBxpClNQV9YGYC9d1r12XrWkv+6k6AJfv3+t0DQz7n0/+5hPzMgdtvGax
 1cBPU+9qwDueO5dyq2/ow0Js5MN/1dWa0NsDT8jjcJHrQ3ER3ne3Tv8Q5trQYyLI5cbX
 wmJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEGdIvkTZHXRdq++7mfNT0XfKM/46+zMda3BBOyHQAebK46omHTOZUOZJK7r+bVzRCcB4M/eeaFqB@nongnu.org
X-Gm-Message-State: AOJu0Yw56WiVvRCZTOv9ewNG2D9zRz7s8y7IDbF542WXLx7O0+2oMdBL
 I/D+efE+linsuZY8lH/UK3mP4MJCsU80SMZQRN+yYNbieVS8lxwTtQXzkDkv1C7O6PI=
X-Gm-Gg: AeBDievtztMPX4U4w4NAltl6J9fchh7oVfH9J2uCkaYCZ1sQHRZoSxkLvPqhAtVdp2s
 hghEuSCT4YRAifsU+Rlzv7A7iTHIyfERGgtycFk5CAvLBUWcnMNWzKDzkSUcpDXhoDPFVFA+FTU
 5vSkcgzGm2w8+uuRN3GQgNsPL83Zk9ioT0XYKpk7Im7QDYeAIIlFEXMNn2UwxI1l0QNtdP8SawZ
 w4zT0pdZTwU+IWbCLyDBbbxXcNIr034n2wMnM4zYzDeLWNMFLvSCirb38vxjeNWVm6PiZrEsTbN
 elFkYLT5rz8TBKotLf603iQTDw9ofJPxL91BGhxluxjLVOTG0eEk2uXy1A2j8UNPPbyyCMYIUTt
 15i9YTy8WDGIWGLRSWY4SbR6cYkykXuYjcDht3MO9nfoqkivWNJtX3LThQqo2NuUXaIWJBZTv+C
 pVR84DKroGlfiBRJn11qDRCG5ZRab6CvK59V7/MNnZH2ISRuMzwPED21dR2pmynrlxqQ==
X-Received: by 2002:a05:600c:4483:b0:488:a639:b787 with SMTP id
 5b1f17b1804b1-488a639f138mr108402285e9.11.1775598955741; 
 Tue, 07 Apr 2026 14:55:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488be75215dsm83496455e9.6.2026.04.07.14.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:55:55 -0700 (PDT)
Message-ID: <75339585-19b3-4047-a186-06d21d05bf7b@linaro.org>
Date: Tue, 7 Apr 2026 23:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/21] target/arm/tcg/translate.c: remove MO_TE usage
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-12-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> dc->be_data is already set just above in the same function:
> ```
>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
> ```
> 
> Cc: qemu-stable@nongnu.org

Why Cc stable? This is just removing pointless code, right?

> Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")

This commit doesn't seem to be related.

Do you mean commit 79cabf1f473 ("target/arm: Recover 4 bits from
TBFLAGs")?

     We had completely run out of TBFLAG bits.
     Split A- and M-profile bits into two overlapping buckets.
     This results in 4 free bits.

     We used to initialize all of the a32 and m32 fields in DisasContext
     by assignment, in arm_tr_init_disas_context.  Now we only initialize
     either the a32 or m32 by assignment, because the bits overlap in
     tbflags.  So zero the entire structure in gen_intermediate_code.

Since BE_DATA is in the TBFLAG_ANY set, I don't get why it
is set to MO_TE for M-profile.

At any rate this patch description deserves a better explanation IMHO.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 56ef1e0eb59..4546bbeeeff 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6344,7 +6344,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   
>       if (arm_feature(env, ARM_FEATURE_M)) {
>           dc->vfp_enabled = 1;
> -        dc->be_data = MO_TE;
>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);


