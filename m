Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DD0E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlaA-0000fA-Sv; Thu, 12 Dec 2024 10:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLla7-0000U7-SC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:58:28 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLla5-0000Xz-Dl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:58:27 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2a3a40c69e3so26860fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734019104; x=1734623904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0h1SWbIk0RJP/0juIBtLu1abW/u1bjkCNRchu4OQKw=;
 b=hFq7/r68tsTJxfDe/C1WzKxkrwSywxt4JenXCLmDm0uV7OSVxKqmqP8o5ZFCeLkYJs
 2S13igX4NsB5qzxuZMKijcbAbeCfhG7AhPRTfitqAbkLBM9Al3XLLOXdJTrQmN8/x8TJ
 aMZOzNfZ3oaGJPOTQQ6sBwjD7dyYL1XqrHJcp/wrcRgUby5IninBulCqQ3lKoCW7AnUW
 tvSTuDb+z5sNatJh8TrEbEac2XRUVBpZGeK1st7icU3Weg9CydYjJpZ7QX0W48vtOpME
 4BSB4R3SdIhswtfCWCYbXZgALEQQblFz+QwZbxWtlA4j8rn+JQ4OIqr7psSFGfz6GX9V
 0FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019104; x=1734623904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0h1SWbIk0RJP/0juIBtLu1abW/u1bjkCNRchu4OQKw=;
 b=XQ5tWkpFzCKDD19nqC4zfyOAn8L98lJ8mP4KsAC3y8E4UbqwYcy8pPFZDoXE21S3fe
 uT3jEjITE35HecfppWhbDf+WVu9KQAQIjfjAJrYmlYFEQnow2c4uZKn446GEs+TFhlNN
 3twiL/UunB5nYKzPLTld4xuEpUspwcrsGOrmuP/rw0bPhNxuPIpXvmhqsI6mIJpSReGk
 91o5+7AGEV0t4CVZfsCyr0aAZleApUoyZ7RWxZiknsLBdqsEtbHwE248P9b87Rf1rUYl
 ++nzVbnP+BsN3DRcEwSQW8iWwtIAnTaC7i13ogUlNmdzOBNX9tW3vmjx9acj6sLFtVUz
 rUNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEMVN0R0FCaZJaFWebclZphn39Z66cYK8z2sweQhlOhJ86hSTmnEneOSMf8xVnrCrkG8SF5H++LOyy@nongnu.org
X-Gm-Message-State: AOJu0YwfizqCSbeuo5u2xTSUA55XHMQ0NDgNxfUms4PotbLB2u23nDo5
 szC/BbocZDvvt16Dha+i1tV/Zuc763VS18Bt5L/JBmU9WkalJ1RN6AdawHhyofY=
X-Gm-Gg: ASbGncuHN9n9oS7aZb5HZPbW/QIY6VT0PaJKJqJ8x2Ba7YWpzi5axJ9QMzTXwL/rHRF
 JVyBS7Z4jhUq8Z+lWVX/3Juu2KWH1DWQ8+SC60/dRnxO3GvNQHyP/ZwV8++oGJgLz4wLhpkbVgv
 SdYL6YynNlZ9mwIhk2VwDYpgCqBg3en1U74lIldwai2nQVi6ADujQgcPjHy92fw5V6778//hjMI
 mkhkZ2GvV1JTlxoQNEA0UPp0UzZ9imz9hFNPaZeXdtPVuyagxUHZzB/xne3vfApKBrL5y9qH4c4
 cljRIGU4ZZJyEKzqSfByGT4tMmFO8SQXswM=
X-Google-Smtp-Source: AGHT+IFu1Z6lSQnJBcD1/0Y2gLb/ZX30CSYDKN/S5PzdmyXjK9lVXqMYHMmdKtzoG99jR7p/Y9G9sQ==
X-Received: by 2002:a05:6870:910d:b0:29e:5e7b:dc0f with SMTP id
 586e51a60fabf-2a382755b9bmr2348048fac.38.1734019103750; 
 Thu, 12 Dec 2024 07:58:23 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f569a3868sm4441223fac.45.2024.12.12.07.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:58:23 -0800 (PST)
Message-ID: <23c7d1a0-7558-47d4-8c60-8ffaa14d8c46@linaro.org>
Date: Thu, 12 Dec 2024 09:58:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/11] target/ppc: introduce gen_addr_swizzle_le()
 function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-7-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> This function is used to swizzle the address lines to implement little endian
> accesses as used by older CPUs. Add the address line swizzle to the gen_ld_tl()
> and gen_st_tl() functions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)

Right.  So, this *can't* be split from patch 5.

> +/*
> + * Swizzle the address lines for little endian accesses as used by older
> + * CPUs. The bottom 3 address lines are exlusive-ORed by a constant to

typo for exclusive, though "xor'ed" is probably just as readable.

> + * generate the correct address for a little endian access. For more
> + * information see https://wiki.preterhuman.net/images/f/fc/Endian.pdf
> + */
> +static inline void gen_addr_swizzle_le(TCGv ret, TCGv addr, MemOp op)

Drop the inline.

> +{
> +    MemOp size = op & MO_SIZE;
> +    TCGv aoff = tcg_temp_new();
> +    static int c_swizzle[MO_SIZE] = { 0x7, 0x6, 0x4, 0x0 };
> +
> +    tcg_gen_andi_tl(aoff, addr, (1 << size) - 1);
> +    tcg_gen_andi_tl(ret, addr, ~((1 << size) - 1));
> +    tcg_gen_xori_tl(ret, ret, c_swizzle[size]);
> +    tcg_gen_sub_tl(ret, ret, aoff);
> +}

I believe this is just

     tcg_gen_xori_tl(ret, addr, 8 - memop_size(op));

> @@ -2586,6 +2604,10 @@ static void gen_ld_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
>   {
>       if (!need_addrswizzle_le(ctx)) {
>           tcg_gen_qemu_ld_tl(val, addr, idx, memop);
> +    } else {
> +        TCGv taddr = tcg_temp_new();
> +        gen_addr_swizzle_le(taddr, addr, memop);
> +        tcg_gen_qemu_ld_tl(val, taddr, idx, memop);
>       }
>   }

     if (need) {
         /* BLRM is only found on old ppc32; the only MO_64 should be for the FPU. */
         assert(size < MO_64);
         addr = gen_addr_swizzle_le(...);
     }
     tcg_gen_qemu_ld_tl(...);

You'll need to handle tcg_qemu_ld_i64 as well, and for that MO_64 needs 
tcg_gen_rotli_i64(val, val, 32) after the load / before the store.


r~

