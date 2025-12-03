Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4969D1268A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 00:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQasB-00061w-Ex; Tue, 02 Dec 2025 19:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQas2-00060S-9w
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:37:27 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQas0-0008KD-OX
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:37:26 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-450c6f5ff81so249653b6e.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764722243; x=1765327043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFbIRYzg0PoDkus5nhu8oIy0zYz4pPTQiebimv4dkms=;
 b=nikAo0EGTuNiiMZ5yuSgT8Rb91l5RNbffEJOTyEZyok6WrMmf973zqOi8HY4PFV1vx
 7UyClZ2GRTR+llEaTMx785M3r5a4SYI0zowzzRvtGSJ4CERMkEi29EBR+paimC1D4Lvz
 bM2msniMpDH8g1OeE1NfXGGO8JljrAI+nrwDYI2/at5I+q5EyYHSN8ca2/gxOHSBJA75
 KDUm7QRogctJNSGG8r/I6m19ZOH00B0aGn9mtQjCX+wxOhgAR/rH+8Yshi+oWbBOS9nW
 hyUBMb8ZL4iejybyDAMnJvENIYmExFJnhJ6WxLmSspBIh1/d2sF2MInsiHBREs6iaUnR
 Xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764722243; x=1765327043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFbIRYzg0PoDkus5nhu8oIy0zYz4pPTQiebimv4dkms=;
 b=tz6l6t4Hqc5xKDA0DUFcr8kgsDdz8YK35gTmgCLYBhenoDBRUyS0QC7bWiIT12zVwV
 LfmxJqNpVP5xdRbtWN5wcqlaCTk21DugAm3DDo0CFY2YVloMVo7vB8LtG+Gbb43fCLue
 kL9LpbBm5iOMjQgwk0Lahtmg13D5565EtNXhkSTohmoDkaW9PSgDS0H0QYcMKDwUSpfV
 xFKNgvKd9ipn48Y3ajcKJIel/T52QPmkOveq0YqXk7x7Nc67uuvh2cUfI/S45Cm8GUqG
 sOTT9HjSnYF9pbcfPT82jdx7xQy5qArLRg7N+S+RiAgDzBww6sfd3ysHtUURd/wJe32M
 Rdpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+bQYxnzJVLrVa5MM9FjUHnKOaor/V8vD9sY6rCMnn+GcmZGqoNtEFDlyGaDvPp87obN6KysKFUqz@nongnu.org
X-Gm-Message-State: AOJu0YyTglRO4MFeZWURRKDGVNKO1+eJBiy0KTMBJ/5JTd2/XRktYGrG
 SVefiM6LEJrr20ibZ53HvR0eCMUbA0tDp5YH0HXdS1pL+8LYix0qgrOzb3oT8/1mzmY=
X-Gm-Gg: ASbGnctFu5Fw4Dy6kZOHD5eq9bSk8HFrVHv5/LqeYkwJRe5YKNhyapUoq77ynf0/pOT
 enUUfYaPI3+t+IE7AGslNjZWuozyOrsHu63wZFIBKVpRiHilzcKixOFF+KFrUEC9G1Ll3MEm/BS
 8buR9BrzQJmCxaxsettClNbgSt43vZzUW70lEmlH/sxoTFPsypoPMQp4mIoH2QlKPGCGH6JWDBa
 FI18DnXBd3hVdUK1kZ1Oc+6ByqqHczRfkVojrKCS87FBsfN0VMiKSG61J/nsJpeE0aZhDSpyOrI
 U3Tq/FIRC/DoM6qyaJymjhYm+bn6iEugLjusYpd0j5e3UbY5RM4doxfAasTO/HTBjtkIDnZ1ap7
 WSIgE3b2kpmpTvC9DIwXlvuYnFuztRsX4/zY8drOJNKkuiYEcYNH7hhNR7sZxC135/WU2W+7FSt
 ter6hqnXL4iVS9JVQWsJiu1/RGTA==
X-Google-Smtp-Source: AGHT+IFtA6hqn415X0KzI1PELzTVajiK1MUx24zpa9Kj9sb9PCCgu3qpIOYsfojUWz+MjJ+vVQClRg==
X-Received: by 2002:a05:6808:1915:b0:43f:68b:acb3 with SMTP id
 5614622812f47-4536d71a2c5mr289504b6e.17.1764722243410; 
 Tue, 02 Dec 2025 16:37:23 -0800 (PST)
Received: from [10.27.3.244] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933ced474sm4953639eaf.13.2025.12.02.16.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 16:37:23 -0800 (PST)
Message-ID: <18424c93-6a81-43dd-bd81-3e0526ceb0f8@linaro.org>
Date: Tue, 2 Dec 2025 16:37:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.2?] qemu/atomic: Silence -Wuninitialized
 warnings on macOS AArch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20251202183439.33259-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251202183439.33259-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/2/25 10:34, Philippe Mathieu-Daudé wrote:
> Silence warning when building on macOS AArch64:
> 
>    C compiler for the host machine: clang (clang 17.0.0 "Apple clang version 17.0.0 (clang-1700.4.4.1)")
>    Host machine cpu: aarch64
>    ...
>    In file included from ../../tcg/tcg.c:41:
>    In file included from include/tcg/tcg-op-common.h:12:
>    In file included from include/exec/helper-proto-common.h:10:
>    In file included from include/qemu/atomic128.h:62:
>    host/include/aarch64/host/atomic128-cas.h.inc:72:22: warning: variable 'tmpl' is uninitialized when used here [-Wuninitialized]
>       72 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
>          |                      ^~~~
>    host/include/aarch64/host/atomic128-cas.h.inc:61:30: note: initialize the variable 'tmpl' to silence this warning
>       61 |     uint64_t oldl, oldh, tmpl, tmph;
>          |                              ^
>          |                               = 0
>    host/include/aarch64/host/atomic128-cas.h.inc:72:40: warning: variable 'tmph' is uninitialized when used here [-Wuninitialized]
>       72 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
>          |                                        ^~~~
>    host/include/aarch64/host/atomic128-cas.h.inc:61:36: note: initialize the variable 'tmph' to silence this warning
>       61 |     uint64_t oldl, oldh, tmpl, tmph;
>          |                                    ^
>          |                                     = 0
>    host/include/aarch64/host/atomic128-cas.h.inc:92:22: warning: variable 'tmpl' is uninitialized when used here [-Wuninitialized]
>       92 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
>          |                      ^~~~
>    host/include/aarch64/host/atomic128-cas.h.inc:81:30: note: initialize the variable 'tmpl' to silence this warning
>       81 |     uint64_t oldl, oldh, tmpl, tmph;
>          |                              ^
>          |                               = 0
>    host/include/aarch64/host/atomic128-cas.h.inc:92:40: warning: variable 'tmph' is uninitialized when used here [-Wuninitialized]
>       92 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
>          |                                        ^~~~
>    host/include/aarch64/host/atomic128-cas.h.inc:81:36: note: initialize the variable 'tmph' to silence this warning
>       81 |     uint64_t oldl, oldh, tmpl, tmph;
>          |                                    ^
>          |                                     = 0
>    4 warnings generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   host/include/aarch64/host/atomic128-cas.h.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
> index aec27df1820..1334f467871 100644
> --- a/host/include/aarch64/host/atomic128-cas.h.inc
> +++ b/host/include/aarch64/host/atomic128-cas.h.inc
> @@ -58,7 +58,7 @@ static inline Int128 atomic16_xchg(Int128 *ptr, Int128 new)
>   static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
>   {
>       uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
> -    uint64_t oldl, oldh, tmpl, tmph;
> +    uint64_t oldl, oldh, tmpl = 0, tmph = 0;
>       uint32_t tmp;
>   
>       asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
> @@ -78,7 +78,7 @@ static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
>   static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
>   {
>       uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
> -    uint64_t oldl, oldh, tmpl, tmph;
> +    uint64_t oldl, oldh, tmpl = 0, tmph = 0;
>       uint32_t tmp;
>   
>       asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"

The warnings are correct and the assembly is wrong.
These should be outputs, not inputs.
Will fix.


r~

