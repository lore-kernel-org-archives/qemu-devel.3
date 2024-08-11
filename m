Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E098C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 21:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdGKd-0005ZJ-8M; Sun, 11 Aug 2024 17:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGKb-0005Y8-AT
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:42:29 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGKZ-0004YU-9u
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:42:29 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a60850so2898384b6e.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723412545; x=1724017345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hHlB8wm4uDuBLDPxZWHVolkUvDIN49jNPbz56MUNtVI=;
 b=yJ/noGnYB7q3BI/RBYHbQEGGbjOhOBUCV1xRJepwqkoS/ZMvmIy5jseb6MK+eltNb+
 Qm3jGyDPSciV9r41+xGyeNDA/YpoFV7LMV33pqdOIXeeQL5StmwzdP2/W+kbyMXyio/x
 6ihQQFpKkiNp1FlLCViznLZNTOFFGP6jC1phmlVFlFkaYEc33gzrx6Pvu5RM3tWSJdSH
 pFanKHMkL0ki8msRDmAIZpjxB+M2iJIBWCBOah88Lf38DY12WXGuEwYLf9yGmK+vyun3
 Nxc80CjLRtCIeLwk+w6q0hpm9cdEI5feKuHV2N7XWzYH4RzoJU2syAKE3ERuS+hUpSco
 5P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723412545; x=1724017345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hHlB8wm4uDuBLDPxZWHVolkUvDIN49jNPbz56MUNtVI=;
 b=lUSDfXtzsna/IuXTStmoaFJmjoQ6QfIARItB2v/DRX8o7RO2zK7DQEaodKSSYtn5SN
 BmXEOUcXrsui16OQi+WX2I8lSMzoh5LgUfIznMylQlroTa3YrkDpt6h58TCZ2sCC8f2X
 yH4aSRf0NmrGihm/ME8JaH6D8fmP3MP67rvJF3UzgHaODaSJg50DbRhy7j9xXAmvHlPT
 iAlJBmCQHTPL/rk1fH9C1i9SUIYOENLP8V0GnYGg+m3+DarHOvcwou3nGYY6Gh0Q15It
 hp5ySgfZWVm4PBnXLVBvLJM+KvZTXqoS8ooYcdIzBNIwp6/32zMOR3jDIT8l3pktTV6Q
 gCqQ==
X-Gm-Message-State: AOJu0YzAxxYGvbxmXs7LFmjAndlIpRNPpmtFrZH7ydZnTsmsnwpA1WJr
 cV6Uy5cNnDPkhkSa6rIyn4AZ3zj039I0EPL3Jt8R0ydt443rpN/MXD/tTETzbHVakqg37cC5b5J
 MT7Q=
X-Google-Smtp-Source: AGHT+IEywcsT3hIEnCulAYL3KBIMhIMRCEpH4xzQauZSDcVkNnWRPyE77hn/S1duMNdzLEi85HLFxg==
X-Received: by 2002:a05:6808:2998:b0:3d9:2e91:96a5 with SMTP id
 5614622812f47-3dc4168a0eamr9436432b6e.18.1723412545019; 
 Sun, 11 Aug 2024 14:42:25 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bbb39999sm26078895ad.277.2024.08.11.14.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 14:42:24 -0700 (PDT)
Message-ID: <c20b4a89-1774-48ee-9959-19b5d6d2efc3@linaro.org>
Date: Mon, 12 Aug 2024 07:42:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg: Fix overflow in matrix-multiply accumulate
To: qemu-devel@nongnu.org
References: <20240811054341.745674-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240811054341.745674-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/11/24 15:43, Joe Hattori wrote:
> Arm's intrinsic matrix multiply accumulate instructions take two 8-bit
> vector and add up a 32-bit vector. Current emulation causes overflow
> when large 8-bit integers are used. This commit fixes the issue by
> casting the 8-bit integers to 32-bit integers before multiplication.

"Large 8-bit integers"?

0xff * 0xff = 0xfe01.

This in no way overflows "int" on any supported host, which is the type we get via normal 
C arithmetic promotion rules.

So what is this supposed to fix?


r~

> 
> Fixes: 2323c5ffd4b5 ("target/arm: Implement integer matrix multiply accumulate")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>   target/arm/tcg/vec_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 98604d170fd3..e9c33520232a 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -2718,7 +2718,7 @@ static uint32_t do_smmla_b(uint32_t sum, void *vn, void *vm)
>       int8_t *n = vn, *m = vm;
>   
>       for (intptr_t k = 0; k < 8; ++k) {
> -        sum += n[H1(k)] * m[H1(k)];
> +        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
>       }
>       return sum;
>   }
> @@ -2728,7 +2728,7 @@ static uint32_t do_ummla_b(uint32_t sum, void *vn, void *vm)
>       uint8_t *n = vn, *m = vm;
>   
>       for (intptr_t k = 0; k < 8; ++k) {
> -        sum += n[H1(k)] * m[H1(k)];
> +        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
>       }
>       return sum;
>   }
> @@ -2739,7 +2739,7 @@ static uint32_t do_usmmla_b(uint32_t sum, void *vn, void *vm)
>       int8_t *m = vm;
>   
>       for (intptr_t k = 0; k < 8; ++k) {
> -        sum += n[H1(k)] * m[H1(k)];
> +        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
>       }
>       return sum;
>   }


