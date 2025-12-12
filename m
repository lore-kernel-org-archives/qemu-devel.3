Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C256D59D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6X7-0000bJ-B5; Fri, 12 Dec 2025 12:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6WB-0008Ow-Fu
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:01:24 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6W8-0005gQ-IF
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:01:23 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c76f65feb5so1183190a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558879; x=1766163679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Icu3JHOaMqQk2xCgIvRyRxQGaqf2UrHfFzGWtywqEJo=;
 b=Pn06awi+/OYXhdESgEXUy9XadVjbbJbQleeRsGq9tzPlXUeb9n8Jnhzexzyga01858
 0pQ8342mCn0JiHeXsRFws/VFFTEfnyDt3Z4FNT1sygHdSWFgw8+Sr6B1C06N61cPNHwM
 YGcrqMWwUIVC4awLEpZqnx/dU9wa9+E5gCQqaU6eeASL9LSqyIocshmQRGlv7TwqKNRY
 Gbxi6+AIjR24FBlT3jp43LiyQksvQD1xn1k38UZOgSiR90Tiw+E/98Po6y/kO01Reefi
 G6RfliFA2VlVCyalcb/P8ylS/ldq8Rwg18sfekXd13iT6Ix4nOcbuRKpTzh2AY6zpnP4
 xyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558879; x=1766163679;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Icu3JHOaMqQk2xCgIvRyRxQGaqf2UrHfFzGWtywqEJo=;
 b=d9ZJNMAUApaCGo57NjdEVH4DHhCgZuzd7J0TDldHg5CoJTwjyH0/y0EgD8vtU7i0TV
 Fz5dFdMm6KPLpjRmd6HBXAQZGkfmuSfvbm3640AK7SKbHL9J/+t/mKiFc3N7rMdnx0Z0
 nryYOSCFulPMcp4OgJXHQilgnrvMzjVyjwCPIBRbITfzYr4k3Agr7itrz0/zYmN++vNo
 /gNXItBLobbi8VWqLlTUizFU+6BOOBcOjk6v9d+GONF3Q2UXh+yoYvtCDCSRd9AK8Gme
 gMNUwbkkJBJg5kSu7HGse3uqCdvhWOXcdlUoRiOQ3ogf4FyrIfHrnNc7VJiGxOElla1l
 27xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAHhy3HlZ/lJkItvXlQJGb/quYnECODJnDuBNsQODK7DMwDwbxyJGvBb+iC5a7XdfKDwLXG22E92d6@nongnu.org
X-Gm-Message-State: AOJu0YwHtf3jPeh4gP3wZi/OXiD2nA/L9066ct0kFct8wPoBUnlM82n5
 R313zB3QxLSCvX83969nDBTN++d38rwgc4nl6xQRXL/VYNfVvu9QEyGF9JRI9RhbagU=
X-Gm-Gg: AY/fxX7nmJbrmrpbcsqjHBm7wasSXPDuo8J6vj3zK5yAqAkvbO7Wl+tNog1hdt7JvrN
 iPhbM5wZe2Wv7l8FooP02RNOrC0gId74IJAbhlDqs3iyyaosSzDzjLVwoksgbiQOOQSmOx/23SQ
 cy7wVXEUMJ7sTUeluK+DZIKy/Z7OnjdNHTt8nI8mTl2tIMp+jl9V0H9NaL0RdE7J1WZnI7am9or
 giD5JG4eDF7GParyZWpq+G66uFnXCjfG4legZZkjDvH28Za91vmSx/xecklOd5fUuQ578iKgF02
 uJmreg5TJULJwksnPL1XsgbKBBj0xYkjPek/YA4sjOaWhimcrm7f1ZCPKVeQmMyB2g2RQ0JJxbz
 du/dQrwArGhEi7K64XFtFScZCOJJH+pxAyxvd0joJwx5bLAlXzwhPsscZ+yWB6mtnZrPXli5PgG
 7P+416fkjvxNywoX8t3NZPJ4pOqxff
X-Google-Smtp-Source: AGHT+IG3Qq+ArewAMuQe5KidHxEdYo0gLoSbbPMqFxNqHrroQSyIKJpA4qq84S5uNEByXLRftPWsZg==
X-Received: by 2002:a05:6830:438c:b0:7c7:2cd3:5baa with SMTP id
 46e09a7af769-7cae8398948mr1556541a34.34.1765558878603; 
 Fri, 12 Dec 2025 09:01:18 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe285210sm1308117fac.3.2025.12.12.09.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:01:17 -0800 (PST)
Message-ID: <46a95197-4e21-4dda-8d1d-ea1c4e44c368@linaro.org>
Date: Fri, 12 Dec 2025 11:01:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 20/22] target/ppc: Inline cpu_ldl_data_ra()
 calls in ICBI helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> Inline the cpu_ldl_data_ra() call in preparation of
> removing it. Since the returned value is discarded,
> don't bother to set the access endianness.
> 

Hah!  The previous patch could have used the same comment.
Or maybe moving that hunk here.


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/mem_helper.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index a43726d4223..cff385b6020 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -344,14 +344,18 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
>   
>   void helper_icbi(CPUPPCState *env, target_ulong addr)
>   {
> +    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
> +
>       addr &= ~(env->dcache_line_size - 1);
>       /*
>        * Invalidate one cache line :
>        * PowerPC specification says this is to be treated like a load
>        * (not a fetch) by the MMU. To be sure it will be so,
> -     * do the load "by hand".
> +     * do the load "by hand". As the returned data is not consumed,
> +     * endianness is irrelevant.
>        */
> -    cpu_ldl_data_ra(env, addr, GETPC());
> +    cpu_ldl_mmu(env, addr, oi, GETPC());
>   }
>   
>   void helper_icbiep(CPUPPCState *env, target_ulong addr)


