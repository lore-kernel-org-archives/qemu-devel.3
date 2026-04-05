Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0D2E9D824
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 22:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9VqF-0001Dk-1I; Sun, 05 Apr 2026 18:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9VqB-0001Bj-Cj
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 18:21:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Vq9-0002YW-FA
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 18:21:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so34455305ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775427665; x=1776032465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDnf2SJO90njtTbvx50IACrtTZSCicmu+7MqgccZO/k=;
 b=F/WS2JFTLTITOnqnPpWJA7+N8QeLLodv8J+81gCVaC0raWTvOyV6xW9qhSnfNa6J46
 x0fytIDEWh4v1YXfu+az/YGJ0Cp+3TPhGJZW9hqbMXyA4LzAMwOnHMbyGjT5+n1dMni4
 rQIdspQwTayF0BnVEJuxP+mXbt+eH6AUk7OR1QRgJNQ5UWHQzdWMrY/JDaVh4l/aLdWt
 DgnpzvFUFouPglbjeUwuhdkZJTLwXggcJqkk3/GH5Kmp2kzb7x8LoFGxBqbrRRHOH5jv
 lr4FOmXKmhL9rnixaE1Cl/8P829yJ5wYVhzvk/E8yP6inTAM7BaAy4gxRC5G26dlQJfF
 UBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775427665; x=1776032465;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDnf2SJO90njtTbvx50IACrtTZSCicmu+7MqgccZO/k=;
 b=OMCi7G0R6TVN6uhoJhutW6PjF3rXlkxwOoxLG9C98B5YazfHSN894nkh53YrPd0/0h
 6wsCzpEagk0iZd7b3NYdw7eDNX8N6FvR9JouYFXUOjENDcerrxm2pKrxw2NHw23i8Sxs
 aEwqA8iGpddgYfNlK476bHF4QGrhUEZL2iAyQEmBo10Haa0z5naAVkc8gY1mzI46HM5w
 P98UpjAh/Utyqh1E7s+2KMFeLiZuUW5/Dphok4yYbQSIfMDhFndDNl49mGD+bgh/KHCA
 W94eoUEtZmVFBNB8lFLtuMUQH3GWAVvi9IMRECdeo1ox1S+yUoyxgChsB7k5lVjDnVg5
 dfBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr1UZbsdnQ+x5Pokkl2drku04PhkovLntJ8CRd5pkB935IvFfM7u04cIdB7sMSv3dHlK1EoyHSFgzB@nongnu.org
X-Gm-Message-State: AOJu0YwMMOpViDjEV2y18GYMEdxE385dKO1ZmEziwud8Vs6AojofLg6F
 jK6Jv8se5Xlx48/ymmTS5chmd2EqQ14q5YEJozJfz2OvgXOxKUS8VGaQcSLAXacQnM8=
X-Gm-Gg: AeBDiesBKe/o9DKaxh5S20Kj20TcYce49HJEXGTyMVjIckint5KCVc9k1Qg1SkGTI3X
 P8QKMgECOBUUfMyYwYQwAwz9WBJ4OlUEjospIDiV3khC8zJpEgJ0FnbzIbiel/8c7FKeE6zdEQU
 RktMczHrLSCVnHrFhi52ZBu1P9LFyHorqP+EPSPgu+ScapZv/3dsYASimCpmECcfBrms5u5EahQ
 t/aqvNwweHd8NBCEzTbNxfMbPnfgG+0bmeFmUPYAeBkXX7GU1ZwVhmuAM2oEDzjgrEt+UR85z7R
 5qI0G47/8ykOCq2J2ZwMyZTcI4VGTTj0BcfyndeQbKMROIosaPANiVdm1ynXx9Zi2WBJM5l08bQ
 iikRj7WQ0ljMpkLLMmLP5j3USJYps0uudmbDCPHXhRx++h0Gv1Wm03ZS4DymAcpDoKBk3tmJvwn
 k9I4/HYfsTeT6C0LyVnC7ZXFGAKfDj2++sG7lo5uNEre8aIS4OXe4EFfayfqGA6JjZ8J4=
X-Received: by 2002:a17:903:2c6:b0:2b0:be79:e521 with SMTP id
 d9443c01a7336-2b277e7eb3emr121049475ad.26.1775427665251; 
 Sun, 05 Apr 2026 15:21:05 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979530sm115962095ad.46.2026.04.05.15.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 15:21:04 -0700 (PDT)
Message-ID: <c8c705a1-851f-4c75-9ad6-82a12b9b7ea1@linaro.org>
Date: Mon, 6 Apr 2026 08:20:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] target/arm: ldg on canonical tag loads the tag
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-7-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-7-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/10/26 08:59, Gabriel Brookman wrote:
> According to ARM ARM, section "Memory Tagging Region Types", loading
> tags from canonically tagged regions should use the canonical tags, not
> allocation tags.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index b54fbd11c0..07797aecf9 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -313,6 +313,11 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
>       /* Load if page supports tags. */
>       if (mem) {
>           rtag = load_tag1(ptr, mem);
> +    } else {
> +        uint64_t bit55 = extract64(ptr, 55, 1);
> +        if (canonical_tagging_enabled(env, bit55)) {
> +            rtag = 0xF * bit55;
> +        }
>       }

Rather than look up MTX again, just pass it down from the translator with a new argument.

> @@ -472,6 +479,34 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
>   
>       /* The tag is squashed to zero if the page does not support tags.  */
>       if (!tag_mem) {
> +        /* Load canonical value if mtx is set (untagged memory region) */
> +        if (canonical_tagging_enabled(env, bit55)) {

Likewise.

> +            switch (gm_bs) {
> +            case 3:
> +                /* 32 bytes -> 2 tags -> 8 result bits */
> +                ret = -(uint8_t)bit55;
> +                break;
> +            case 4:
> +                /* 64 bytes -> 4 tags -> 16 result bits */
> +                ret = -(uint16_t)bit55;
> +                break;

This doesn't do what you expect, because uint8_t and uint16_t promote to int.

   ret = (uint8_t)-bit55;

will promote bool to int, negate, then truncate to {0, 0xff}.
Whether or not that's better than

   ret = bit55 ? 0xff : 0;

I don't know off-hand.


r~

