Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB74AC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 18:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5q1z-0006ft-Jy; Fri, 18 Apr 2025 14:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5q1k-0006aK-Nj
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 14:01:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5q1i-0004GY-IK
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 14:01:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so1840783b3a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744999279; x=1745604079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M4zY/Ds5LfB7OiX/gC1AZ7I3FvReIcgKuD6RX9w7QxI=;
 b=NnY2YT953pBAYz3LdUS9gVlBYB9yfokuglqVLpGu8etz6Fuu6i8rkyQLb3tdYTfyRP
 0xvftAY7BNmcVAbUc1x5XhPUEeDLpZClSld2wkwPIRB9rc4z2MDOVd+/HSwgPfUPtknM
 CtyW65eqzr8HBySyj4eLZG534Iu89GjXH+Ceii4bF6N301thXPu/lQ7oDBiZwe4vvzPM
 eUL1Nk0d6cQUYVTYKtImxQI7uaTIH5VGoTOs+m4uV+wtFPbm5ryYbTQaofkzynoRHuoc
 E6QYYLrCbkkaV1/sZfSLT8Unx2hfVENWs4e7gtenn3tHSi/qAB7nx+fcUhy2Q3ulXVIB
 rmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744999279; x=1745604079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4zY/Ds5LfB7OiX/gC1AZ7I3FvReIcgKuD6RX9w7QxI=;
 b=ULmhyA4UcFZD+dukcpN6NiboTk0MCrqnoFlA26QzSnfPJ42UdGFcamm6e/YlTOR8ro
 PvEpEaC+zmR41JWs8IubxUBW4VCx2Tpa3o9vd+EKTDJilVpU3mGhzZLMrxyIdBYyHtR/
 b9zWQ1+q37YtyxtlZuvKhtWKu60h8xp/uhIKgpvU4QmdIpVXwiA9RIUehntpfFvmAYdS
 f4pZ6+SeQifj2KOpHPc52y0+rCzUDU94VHimYXof+12GzGVT7YBpszGe/PDFNRaZ2rya
 LsMz2oG1HgylnDa/nzwjJtrvv4B6eZe+5PpFZh3Gexbxk4B6Oq0h79wpTv4BKmnH6CxD
 RBnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyX4m3/+gtedCB5VOl+GIvng4SM6Ygop7BwwtSzT2LzQD091fc0UZk4liK7EzUEqWpiYWIXjaC1V4v@nongnu.org
X-Gm-Message-State: AOJu0YySLEuc/xIS4zEnrienvr3ulYm9yYIH4haP4aP5H6z3+o/PhjZo
 d3kk9x6JoxeATtlAKkb2EcygyOcsBvAdPdTkIwztLOk6Bn0Pusiw3PFzA0jZ0ZY=
X-Gm-Gg: ASbGncuuWSCkwMKc1iM8bO7z5pqmOD7707d/a+8AXtrjFtuXzQGIWl4GvkHePsH6Z9w
 9Aineo6fIkq5JakTLtx7S9q0R+yjcZJtM6j/5HuMwmFxihKt5bPOgvQNkdmm60q+TM2ms3IAWhW
 NJY0u9w7txKFs7HsWGbad5xxwNo9CK7mSj1vfhhMffdkgWx/y0mSrdnFp+2Ctx7boY1rnRQWUFx
 zY1Wh1tKHnPMAatjPdej5uRPmBUdcszUikTtKJYAYYXN1NDlPvF9mHGiZhxEgAVKGbdUX63skOC
 nM16PGGEzYlf/+HWt7jnQbFGTyun48jDd/M1+JMQ8+kqkLlz/ck2UXb7NfJszh8DfukUM4eAN1O
 3Y1ulG14=
X-Google-Smtp-Source: AGHT+IEhXP5NhLDU3JpUQPgCqbyvr3kR++u6PwlhtVfRqrIXpYbcSbcZpsijRe2+xPeuj/VUJO2OqQ==
X-Received: by 2002:a05:6a21:318c:b0:1f3:194b:30b0 with SMTP id
 adf61e73a8af0-203cbc252femr5237381637.5.1744999279436; 
 Fri, 18 Apr 2025 11:01:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db148137esm1638471a12.65.2025.04.18.11.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 11:01:18 -0700 (PDT)
Message-ID: <3cb8d51b-ed9c-4faf-8cb1-05125c8a025b@linaro.org>
Date: Fri, 18 Apr 2025 11:01:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] gdbstub/helpers: Evaluate TARGET_BIG_ENDIAN at
 compile time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/17/25 06:10, Philippe Mathieu-Daudé wrote:
> Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
> time via #ifdef'ry, do it in C at compile time
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 6f7cc48adcb..c33d5dfca3e 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -56,17 +56,10 @@ static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
>                                    uint64_t val_lo)
>   {
>       uint64_t to_quad;
> -#if TARGET_BIG_ENDIAN
> -    to_quad = tswap64(val_hi);
> +    to_quad = tswap64(TARGET_BIG_ENDIAN ? val_hi : val_lo);
>       g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -    to_quad = tswap64(val_lo);
> +    to_quad = tswap64(TARGET_BIG_ENDIAN ? val_lo : val_hi);
>       g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -#else
> -    to_quad = tswap64(val_lo);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -    to_quad = tswap64(val_hi);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -#endif
>       return 16;
>   }
>   

I'm not keen on using both TARGET_BIG_ENDIAN and tswap.
I think this ought to be

     uint64_t v0, v1;

     if (TARGET_BIG_ENDIAN) {
         v0 = cpu_to_be64(val_hi);
         v1 = cpu_to_be64(val_lo);
     } else {
         v0 = cpu_to_le64(val_lo);
         v1 = cpu_to_le64(val_hi);
     }
     g_byte_array_append(buf, (uint8_t *)&v0, 8);
     g_byte_array_append(buf, (uint8_t *)&v1, 8);


r~

