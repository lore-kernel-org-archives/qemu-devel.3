Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1967BFB5175
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9sNM-0004Vg-IJ; Mon, 06 Apr 2026 18:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9sNL-0004SD-EL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:24:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9sNJ-0007r1-RA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:24:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82ce49785a0so1813501b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775514292; x=1776119092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6lciqJHhtCqsiSVE/OGhsgpeVxIed/vEA11CKzs+d7g=;
 b=REsKWHhq4xFxibVn3lVxN3iZ4h+8RKIzk7gx0cXpq+l7ns5p9GbRGvDlZJhJkJhvMJ
 uivXkXNKgXyHljHa8LulIgELFJ3u4hzG0l4jZ98OGi1do1Rv98iEDKGPSGrFyai4YO+p
 N6ZCtQnZ2mBtK14UTtM6r1ieLended1s9Fw7EDZNnFDn7R9qo2ejqWAmL6YhjVNfvcA8
 dFXnHB5w8Dx0ZhN16vBg++SidxnRGVJtKqwuBCtN/UL74eW9uEddLJN1mIEhbYQ7yUyb
 S3JcqD18WPOKU8X0YgPO77DNUmQAW2S/wTqpTlE9YZOJpX/gkA1KvdkA7eYuF4QtXqcN
 +QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775514292; x=1776119092;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lciqJHhtCqsiSVE/OGhsgpeVxIed/vEA11CKzs+d7g=;
 b=rEKFNF2hqElzRbnLGVeAWhWvB7yLhAZ+OkVAMcK5/M2gHNfAWRif0HMWM92tfhbDvv
 arZKwHoncUinx9UGiFRadRF6TckTJb/VuZrpvlnE12ARTdvHj5TBKoZQ74oztL586vrr
 LIiH04DMCNx9g3f661aKuYb/MPckY9pj0u81rIgZiF8x8tTx7umGK0ZcXO0YS6cNu8Vd
 s1n3/coKnxX2uSfh1YdLnb5VZjROBuIHNEe91S79CW4YaFEVfa+n3TioFwAyk4tjtuFX
 LK7vARPOTcgfoB0GGyZ+Ir4UEzZzfNtJVugb8s6/xb9JZwoFr4r81bhwgefz0m1Q1OVF
 iyNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNN0hgZLXt67dGNRD6Rj75jHvdpQHZmX+ozyuw6aTcSNBc419qwIJjEZPHdgnxAtEbedH+vFBck1CZ@nongnu.org
X-Gm-Message-State: AOJu0YwZvDTc7f6CRz0p6vXruGc7TsXXmAT5gifSqqqSYF6P26BlZHkD
 JBxn6+93qt6sqzPdf1LORpzaTYMb7FQp1u9NInl3cfeF6c0XVn/69Qk8Ew0FGT3g0AY=
X-Gm-Gg: AeBDiev0gYGcj0t2MsYEgyaa+2O6B+I7iqDH/ULDdm/Z8b5yUH9Zn8YZ0Dt1pR6isZ9
 klYlC0Bp5Vhlgaq07aTMWhePBbBYdmyKNWgDIGLW9Y4/ztkzUZ45Ycu/K7OlVbHQEPDDTY4kD31
 B+91/qe1VlVsc1ug0FUlk9As5cHDp5a/HBGGB7V6pM8dBKAda9AfUnt9bp6fafKYWNzqQAwdOYg
 yt7rnbXVnMX9WvZ+OpfLwj/Sd5XzuXe9PpUUvCccG06P3iiTAKPa7p+k3dm3vJy6/fN8cFGA/nL
 O4hy83RHX9rWd75EZkB0TL6wwkWlV6q7oRnCSQbq9pYCugx4DWR4XGKscI0kDgiq0t1gTLSeJwq
 MN9reVcDcHAld39uI+a9GtDnNueVRuJ0vskKDOrkCLn+AHT7+H7SNM5dceHqKQCaCawgR8ozXEp
 OzGf7O9sbF09t/b4fa4FzLW2oO84dXA3fYU8ZAMNiI7hSm480A52ohSCgulGue3V241R8=
X-Received: by 2002:a05:6a00:301f:b0:824:a1c9:8a30 with SMTP id
 d2e1a72fcca58-82d0da8f3f1mr14316858b3a.23.1775514292223; 
 Mon, 06 Apr 2026 15:24:52 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c4126bsm14882233b3a.36.2026.04.06.15.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:24:51 -0700 (PDT)
Message-ID: <c73bee03-82f8-4529-9db1-7857a049f59d@linaro.org>
Date: Tue, 7 Apr 2026 08:24:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/20] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-18-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 7fcf0656630..68f050746d4 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6279,6 +6279,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>       }
>   }
>   
> +static MemOp arm_memop_endian_swap(bool sctlr_b)
> +{
> +    MemOp t = target_big_endian() ? MO_BE : MO_LE;
> +    bool do_swap = bswap_code(sctlr_b);
> +    return t ^ (do_swap * MO_BSWAP);
> +}

This and bswap_code can be vastly simplified.

The complications date to when code access could only be done matching TARGET_BIG_ENDIAN. 
Now, of course, we can directly specify the endianness, so we should.

This should be as simple as "sctlr_b ? MO_BE : MO_LE".

I think there should be no need for CONFIG_USER_ONLY tests.  I'm not sure what's still 
different between user and system modes there.  Unfortunately, testing of BE32 might be 
impossible at this point due to armv4be dropping off support lists.


r~

