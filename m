Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E2C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwVv-0003G7-9T; Mon, 17 Feb 2025 03:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwVt-0003FL-HP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:30:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwVr-0002Cb-Jo
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:30:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso27209315e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780997; x=1740385797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ndilR8hiWgR3lwrUlEZ1QNi5yfU5mFdwXjVv7yXnrU=;
 b=PCL+X0DhravlXGPhiCbQAN13j/RDWw0J596Jb5N2WbTNEU9vxDaBV2A4QaukVEJmWe
 wTXKYMv9/125R5depMvreaJJ3aVmVrJ8nGoLckZQmPjsJ1ba1MmjYWuhzTeljtShNR1u
 mTGogyMB9f0AeDf/e3tLkvnYc/nygm9Qb9DXkd7Z/GQGMFU7MLHbyUhaiIHTsTjK2fSE
 YcZzj9DteYcI/J1OOM42SO2+3+wyp6nfb3J9J4iPtD4OWvVbAASq901hCnJ+WG85cUvG
 L3tyHfKxx8/njKZBNOPbq7hhVtMD+UYrwktiWelrUBycstFPsDmszCvNdxpxD1sawMkc
 sPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780997; x=1740385797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ndilR8hiWgR3lwrUlEZ1QNi5yfU5mFdwXjVv7yXnrU=;
 b=s135rzkjO8x3bGdD0wsW7uNfLf9aSbF348hhoDr5gRKDK/USFhrGLLhNe9rSxJnstr
 /TGONXXDMkBa+N1CPlY8mNtTgOHkO16LUQI50uSFXgWS4QNqmlU0RkMSBjEkFaFg1vwT
 1B/v7NVSjgqKBc0zJmva4dfogFhVBoBTMXXMHIBnlx5u1ihawO5XbhZNbSGRTO1AAIvz
 +TXVPBHSUOu3baY7H6xt7mEJinIlGDXOP/LgDmQx62GZnKvhjSdszvQnlrprORR39u+K
 hY+t1uqNoK1qe/dTorU0gW3BYrqLoCZQYdGRM/UtxhKE9q2lMwqyEbXlpWyYxJN/ssMm
 kwFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKYWd+J9duwO4ppPHMhy13AvnBxmvGzlKh5nnAFMa0EFs0MizMRfj0WCC87UolJE01oX0/GFqD59jA@nongnu.org
X-Gm-Message-State: AOJu0YyfShUpn+jIwJ7sQuDvbYz71f2VrO3o2xbI50ZlNO57gxg0es4o
 mSst5aUS8xMSHCl3dk0wdrnuaAU5lFFSKGfkTO+FCpYWRKQfaToVoE3acvlseUAiHiQ2wESshYO
 2
X-Gm-Gg: ASbGnctFdIJAggy1GMIEjPPNNVDObiJ9XvbLfiglG0WEAdUaMaui1MXKqaA8smFrv66
 +bJ1pVyMQ9/SO6aBLKEJF373QaWW7CfSugFn5zuT5Ja5c3oUn1MtS360O7b1m8t5+yKkYuP4qqx
 sSrKRyZ19ha6TNunTyvJsxNsp80qzAXlejCyMEGa6qIJVbU8MBvOGi8xS/bH3yDO87Yt6imRAed
 Byex+H1rsd1hff1Y7RqGuhHLXlFAWOdJsN5SRrTu2s9u/Hgeq6UL/vVngnNPZVJ/xm1POvpxtNq
 S67PI1t7r70W6R1JZV0TfMfBVyM5HQ==
X-Google-Smtp-Source: AGHT+IFu2ku5xdwFrxSOzBVr+k8P5HpShUb1WBKIEZi7ZHQN5GUBO2yhfZ2Op6+P0hYFOFsdouEYOg==
X-Received: by 2002:a05:600c:511a:b0:439:643a:c8c4 with SMTP id
 5b1f17b1804b1-4396e7527cfmr70273735e9.22.1739780996514; 
 Mon, 17 Feb 2025 00:29:56 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b439dsm11458693f8f.8.2025.02.17.00.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:29:56 -0800 (PST)
Message-ID: <3ae1f844-b318-4503-b5e8-4cd6ab82ea86@linaro.org>
Date: Mon, 17 Feb 2025 09:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 051/162] tcg: Merge INDEX_op_remu_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-52-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 5 +----
>   tcg/optimize.c           | 9 +++++----
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 6 ++----
>   tcg/tci.c                | 4 ++--
>   docs/devel/tcg-ops.rst   | 2 +-
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 16 insertions(+), 20 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 55663ff4c3..6f0887f808 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -563,9 +563,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return (int64_t)x % ((int64_t)y ? : 1);
>   
> -    case INDEX_op_remu_i32:
> -        return (uint32_t)x % ((uint32_t)y ? : 1);
> -    case INDEX_op_remu_i64:
> +    case INDEX_op_remu:
> +        if (type == TCG_TYPE_I32) {
> +            return (uint32_t)x % ((uint32_t)y ? : 1);
> +        }
>           return (uint64_t)x % ((uint64_t)y ? : 1);

Or directly:

     return (tcg_target_ulong)x % ((tcg_target_ulong)y ? : 1);

