Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F3E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkVA-0003n2-Tr; Thu, 12 Dec 2024 09:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkV9-0003mn-QC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:49:15 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkV8-0004kX-5s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:49:15 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f2c51478e5so294512eaf.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734014952; x=1734619752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OhOOctuEVi3CKcWFMNfzaeV7zVApxrf+9Q8ueUwvmEU=;
 b=Fo4o4d3uGIdr1TcWcGPPjzM7T8UM+Mt/Q525pejC93zkJHjaEd9FAYz2VGcuulDWTz
 SBU79TjFs6rp6Jx/VGB+rqbgA8o16fSmCPYHf/FCBNaqURnVNzSiuETio+RQ79yeFCal
 2imyycnfej/oqPfoVksNzVscI+xJAf+z0q8NOI4/4DkS7KQH7nmjTzEz2MQ5AeLGyrSV
 tV6ndqvatAwvzANrn9+6YBLsfVgJLsdgIigqXJZ/0LjxAKWMScclR9qdagQSlcIOiBoR
 fFuwUqHep+Gwcsiv2bTRVOvvEwpeF20n54+vlsnHJYRNdgT+NEG51RllZNN1Ff+bISRg
 7uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014952; x=1734619752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhOOctuEVi3CKcWFMNfzaeV7zVApxrf+9Q8ueUwvmEU=;
 b=ZBRUoLebONvwcJNaGurBHW36/GqXpPYXKVNzsmXi/xEcCc9m8TmsqrIETkjKc0EDKo
 xG0ndVT/MkmF6JRHt5ejJw7/n4IfgTEBc/Y/Lud6qdA5dI6RreYVvU4scApxSgCjFobv
 H19wVqFIgxK4SHHy+4jSF0pucNPw0bAzNYiqGFXDWQdiqz9sIEeXQccLQPNVjnldRNDY
 MSPuQex9O21vxc7kBnpTXcrZr1Xk+BkuustOCaWVhGTgFGJG27J6ozz3kjc8K++vty3J
 5QzdTH3F3MR3NzhoyRBf7uvYx3jS5RQKgmiAt+Up4ScpnXVrmBpw1TchYZg2ETgFuJjE
 VjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYk2jOgtCIV9ZttHADpE0Ds5gTw6EW/UYr4+yGunh3+d+LPJYpt77hxMO9RQ9RaoiATc0cGFSCKsFj@nongnu.org
X-Gm-Message-State: AOJu0YygqH83f4u0AqCSBic6hAWGS7YgqmHBlA+vD5dLIY/hcaBHI/fG
 P1JU2BDWPoxS6RDNUsVfbLUEfMUEGabG1RtQNpghcIFqTBhohIYeWQPEpjXDFao=
X-Gm-Gg: ASbGncsZ7etoLNh1v/wh5hkHhO87nvIaANYX4IJD75gAOZqKgEhMbymmZF/wvaJVBm1
 XBqMz12ok011Ri1zvLel26v73FxtGR1H7CeK7nxgQEuB/CajNkDciHn9GrwrTyUatdV68YnbdBi
 6MAPGq5tBYRYU4dC6PndeNYKnoEflzz5haFa67bbhTlqB631XibJWsNnTpfExwz/f/p9DmCR4Qb
 TC3PFMKgsB906QrtMRCH1/1FiUcfcwp8I1r1Qwn5MrkCzWc6xzudmJHNqdL1csvsc3+KnUbD42I
 PqgRjQCepQA1TBL1IA3hJlKFX3GoiIt5K2I=
X-Google-Smtp-Source: AGHT+IEoGDY1rnheF6O2I89LmIaRWkLZJSo/MMfHrkusD2inQdu99gdNCTQJBqaCLmWeVK6ImuIlkw==
X-Received: by 2002:a05:6820:1c8f:b0:5f2:d799:ab91 with SMTP id
 006d021491bc7-5f3238277a0mr322490eaf.2.1734014952589; 
 Thu, 12 Dec 2024 06:49:12 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2db579309sm770528eaf.16.2024.12.12.06.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:49:12 -0800 (PST)
Message-ID: <592f8ef2-048f-4f2c-a7d1-704371530a0b@linaro.org>
Date: Thu, 12 Dec 2024 08:49:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display: refine upper limit for offset value in assert
 check
To: gerben@altlinux.org, fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, David Meliksetyan <d.meliksetyan@fobos-nt.ru>
References: <20241212114554.517379-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212114554.517379-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 12/12/24 05:45, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Accessing an element of the s->core_registers array
> with a size of 236 (0x3AC) may lead to a buffer overflow,
> as the index 'offset' can exceed the valid range and reach values
> up to 5139 (0x504C >> 2). This change addresses
> a potential vulnerability when writing data.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reported-by: David Meliksetyan <d.meliksetyan@fobos-nt.ru>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   hw/display/xlnx_dp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 6ab2335499..69ccc7ccc2 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -743,6 +743,7 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
>       DPRINTF("core write @%" PRIx64 " = 0x%8.8" PRIX64 "\n", offset, value);
>   
>       offset = offset >> 2;
> +    assert(offset <= (0x3AC >> 2));
>   
>       switch (offset) {
>       /*
> @@ -896,7 +897,6 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
>           xlnx_dp_update_irq(s);
>           break;
>       default:
> -        assert(offset <= (0x504C >> 2));
>           s->core_registers[offset] = value;
>           break;
>       }

Why are you moving the assert?  The switch statement takes care of sorting non-default 
values of offset.

More correct would be to use DP_CORE_REG_ARRAY_SIZE in the assert, along with a comment 
that the io region has been sized exactly to fit core_registers[].


r~

