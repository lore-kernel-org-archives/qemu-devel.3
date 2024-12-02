Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5DFD78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIACk-0002Xw-J8; Mon, 02 Dec 2024 12:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIACi-0002XP-QD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:27:24 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIACh-0000j8-3j
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:27:24 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea47869282so2531037b6e.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160441; x=1733765241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5b6/rz6Ca7iJlwgOO67C5whDovpu20F+mg40rfD/cI=;
 b=EXKVnZmFwBtP9Ktnl6S0Vk/w6zV/zM45y2Q+4p8QoPmTCRYrhbDEnXg9j4a4Qv1GwX
 nJ/O3sbEz8xapkKQhETtQRyl1Mvs1qdgD1gE4S6qDOZPkAp71DTwZe6a7JZeSBicO4c2
 Ynk55wEw2MFcsWFlksycTZXYyS7x3VLlxpq/WzrxAzSNSjvsTrrdrSlstvGMAfQV55VQ
 alu3klpW4ee6osOPpopBocip6NM2hATCcB4agTba0eRWts+i8xjN5Jt2yxP25m9ypOj2
 49+AdqHunI2kol6CB+JNBfQjaVfTnDr3GgoWeIp7bKrbEH4Q7bhUc0Y0WdNQbEBiy8yQ
 hCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160441; x=1733765241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5b6/rz6Ca7iJlwgOO67C5whDovpu20F+mg40rfD/cI=;
 b=j0jsK0zNFItSJ+/lJwOHl3/r18TwNVfNjIKSCkf+0KDLHJnhxhPI6r5enuGf32kz7P
 vvByeOYeDxzK9BJHHGScSzdcnszHnSOpGN1jqcPmdLY4tk3xOiOG587OuXmdduNIV6hq
 anvdRUk8XQvhR1fw57Ibee3kBVItuFlpOQqPMZIpkKrciyHQkBep6MdEzusySLvNCMfR
 vEQjGsWl3qIo4wu+KM1IIC9HYj+CU89FRRFclT1fnQDmlIDxIu7db5h0Fj2Boab0IdRD
 Ym33Jg26ykgfGxkEbdukgFbdLNkQvmdBzK28csth2sbNvH9+CBF+D9M6m6huJUmmalbF
 sE6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEmIng/yS42vfMgLKxDBbtJMY0IqnlCM03hx6UH/IAzc2q70PrKvfk8b7A5Z821BzqWmxaifBHkfLO@nongnu.org
X-Gm-Message-State: AOJu0Yz+NkN8ALVuZVYIMqA3csQs5YnCc2Afr/zrOQpkV/KzoYchg43n
 fi/Ecerva41qxbflwarcUSHtvwrpFbj3SYA6sbNtdOQMK9bWkRCOfiKTgU/5F30Ex53vuM1KSOK
 /1no=
X-Gm-Gg: ASbGnctGkpT/gOz+IeOxdgbJpb6Yn9phYx74uOdeRX1tjNNRpvjvrS92eCN/R2mGsOl
 d0beLWPmrHipkcLyFLM7r0CoPHI4kLxFAEhZC0REw7irk520qibfImcHBOmRSGJzgYi11ujvL8y
 zIa3HfBaP1vt/85AwOqT1KseTjDw/9N9cn4S9sIe5okAYzY+osEzg0wp4X6crHebq8AQalFjGsP
 pwN9TNm9EPSiRtufHZAIneqgugt0SQwMII2OMpfa2BmY2lZNqp3alBwlY/66HmfU8zsXmU=
X-Google-Smtp-Source: AGHT+IFmgEZNb41ZUNXE4787TWBtpzhw0SgnNTA6neHg3hsrtOFCH5s264d66gAjExOISNXtkCxoBw==
X-Received: by 2002:a05:6808:2e97:b0:3ea:3e03:1f78 with SMTP id
 5614622812f47-3ea813cfa1cmr11646745b6e.2.1733160440424; 
 Mon, 02 Dec 2024 09:27:20 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8610196asm2362537b6e.29.2024.12.02.09.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:27:19 -0800 (PST)
Message-ID: <d676966c-9402-4338-88b3-6ef00a40a2c4@linaro.org>
Date: Mon, 2 Dec 2024 11:27:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 36/54] target/microblaze: Set default NaN
 pattern explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-37-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-37-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly, and remove the ifdef from
> parts64_default_nan().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c        | 2 ++
>   fpu/softfloat-specialize.c.inc | 3 +--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 710eb1146c1..0e1e22d1e8e 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -207,6 +207,8 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
>        * this architecture.
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
> +    /* Default NaN: sign bit set, most significant frac bit set */
> +    set_float_default_nan_pattern(0b11000000, &env->fp_status);
>   
>   #if defined(CONFIG_USER_ONLY)
>       /* start in user mode with interrupts enabled.  */
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index b1ec534983c..d77404f0c47 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -139,8 +139,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
>   #if defined(TARGET_SPARC) || defined(TARGET_M68K)
>           /* Sign bit clear, all frac bits set */
>           dnan_pattern = 0b01111111;
> -#elif defined(TARGET_I386) || defined(TARGET_X86_64)    \
> -    || defined(TARGET_MICROBLAZE)
> +#elif defined(TARGET_I386) || defined(TARGET_X86_64)
>           /* Sign bit set, most significant frac bit set */
>           dnan_pattern = 0b11000000;
>   #elif defined(TARGET_HPPA)


