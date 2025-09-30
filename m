Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE70CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 00:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3O4i-0001m0-KM; Mon, 29 Sep 2025 20:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3O4d-0001l1-Qd
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:18:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3O4Q-0004bj-DK
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:18:29 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33255011eafso5234353a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759191482; x=1759796282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BV12f1wc/JC+jgi/ad9+u1M3M3aNUHbg78El2ib84jk=;
 b=GzaXGwNGej7YxXZcNZV2TeSqxs1N6n6uv96JztFG3dYh8//MIYaosuf8Rn3w51VCf2
 NpfOiTmAC/FI688n7euQ6BL7KRv9OW5dZNQdkGIY5SO0/lU5K2/vvh98xyBa73mboiNB
 3FmkALmv7e/tA583km1zamsIjt2YudtkZWH1tlaUA/WzX7H7DX9Etrgpc3OXZmoNRK7V
 QTIewUX1BENvIAG6QXp4jv45nfggpDZy5KreXWnY16XTUZXInXCbeXkOrI7EFTmcHvN4
 Vkyat+2/lu1OocWfJtMRS3C05vqRGGKsYdXGBey0ScPAPQc+Nw/PY14Lu6KSZPtQj5U+
 Bmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759191482; x=1759796282;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BV12f1wc/JC+jgi/ad9+u1M3M3aNUHbg78El2ib84jk=;
 b=U16NWkmIdw48Jm/34W56wpZdBeBWAVYp13pN+WmMfySGzdg7hh5C/eQwlbustJVOrp
 SLp/LLbAJltBlq8ojaB7L+c8jZY8IrXfaGgfyA83qcFLh1ucfuI7X9+b8rDvSNT1UTwI
 o4P6weGqHCoyn4tzQg3bCha7vRaClX8i6Ei1hgufplmcVr08lKdZSTHITKVoYuf2kjpF
 cczMW8cyhhB6QqQsy0knHwcwHkXVOvXVaf+jIuuoCkq4FA20YwaCScEH1rIAjEkkkb/G
 kHlr2XNrVJm88d3UFANUM7FOCV3aMGANnZEr2c158uPoUhhrKTFmzKYuBO8RuFiBjjXe
 d0jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV27Lzq5inmOelZ3+jxZNgt9OFQKV+3mX7TMf7nCydkRvBsIJ/Gb5IVGWR3UvHDnQWdg0C3Rq1KbxU@nongnu.org
X-Gm-Message-State: AOJu0Yzr2f5nHDNEJzVmSQntNLBCUycDSWgCjmCNoeG0cRkovy5trarR
 jpnRJ0/VDkuup9mN7Vbr/4dJ93F4m2aPUGxFcmHBfiajzlMfuqKEVYnv0B32wNj+NoU=
X-Gm-Gg: ASbGncsItDlOoanuQrEEQ5enYz8La3IVdJ4goFyXh3893Wugk7m7i8YCU/Ynw/j2C77
 9ELVnBOZVLK46hEIFkTmkukEpM3WSHojF5yOO9cO47cRgv6DVVx8XdNUcJOBKNbrmRMSNieMCdl
 Gc/zhQaBlaG9zmHByXGjIGanUupReqHyRZ8tlbhd+tO006lbZSbR+dg8jaezE41pKeUc6fXra0R
 Yr3bTbC9LCAFGeVRT0nd5Vf2Q09BRpt1sWznqXz2t2AYyYWYEMQLjKujg/gpHd1pdUAymTKUQ6b
 4iuKR/EysWOwoC9/56braAGDZXu1A5DPZLr60ndSTL5XtAtHa1sKsCxryHMJ1JMwMM/W9GhTlVp
 5yqyK1GlPc8Edofn38aqDPOGAJUV2tilhZzXCQZbWLgMAcqGZou8lbVTycaIEZe9Eo88IIa+t/g
 ==
X-Google-Smtp-Source: AGHT+IGjna9mH6a198HGm2dUVHJTxu/3FpLiFD78Hm/Doem7bFdQ+WDPfOZkkmjrPsr7ZVZkd25Yvg==
X-Received: by 2002:a17:90a:e710:b0:32e:ae12:9d32 with SMTP id
 98e67ed59e1d1-3342a22beffmr18396337a91.11.1759191482455; 
 Mon, 29 Sep 2025 17:18:02 -0700 (PDT)
Received: from [192.168.176.6] (51-148-40-14.dsl.zen.co.uk. [51.148.40.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3356179a2acsm10416625a91.8.2025.09.29.17.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:18:02 -0700 (PDT)
Message-ID: <35e27208-6e6d-4d0f-b563-ae86057387b2@linaro.org>
Date: Mon, 29 Sep 2025 17:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] system/memory: Factor address_space_memory_is_io()
 out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250929183254.85478-1-philmd@linaro.org>
 <20250929183254.85478-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929183254.85478-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 11:32, Philippe Mathieu-Daudé wrote:
> Factor address_space_memory_is_io() out of cpu_physical_memory_is_io()
> passing the address space and range length as argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h | 10 ++++++++++
>   system/physmem.c        | 21 ++++++++++++---------
>   2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index aa85fc27a10..6cfa22d7a80 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -3029,6 +3029,16 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
>   bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
>                                   bool is_write, MemTxAttrs attrs);
>   
> +/**
> + * address_space_memory_is_io: check whether an address space range is
> + *                             I/O memory.
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @len: length of the area to be checked
> + */
> +bool address_space_memory_is_io(AddressSpace *as, hwaddr addr, hwaddr len);

I don't think 'len' makes sense.
What are you doing if [addr, addr+len) crosses MemoryRegions?


> +bool address_space_memory_is_io(AddressSpace *as, hwaddr addr, hwaddr len)
> +{
> +    MemoryRegion*mr;

Missing space.

> +
> +    RCU_READ_LOCK_GUARD();
> +    mr = address_space_translate(as, addr, &addr, &len, false,
> +                                 MEMTXATTRS_UNSPECIFIED);

Just pass NULL as the plen parameter.


r~

