Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7371FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh9r-0006s6-96; Mon, 10 Mar 2025 13:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trh9p-0006qx-84
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trh9m-0005Pv-TI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:16 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff65d88103so6583914a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741628593; x=1742233393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=18EPintEOUagfFPPzsKIXjL17clihVQ97X9UlQXBqUM=;
 b=PiOSbNO1unfCW4mKBbCVFI6eoKrrqXSzHhEpZf3mNqCSMcmDGgTp73lWH2DbeeXSPG
 hQMqgkulU7GPat9vffw548h/I+G9BnU5+eeVZ7rZowYNGj9I46bOg4UwaobgnlgqyyRy
 my6eMqWTJ5h7rRAHoR0nqG8ELkOkH6/pVX4I5Dc3NvolcybM9G3n8wEXZb2MyQM6k+jL
 p5R75kVFF99MI34YVMlrik7GmXbtLeLghttQKvL83ZY6yYnc81h67vlNZbTqo74mV73x
 cCqiJAdn6x5nv0S6gsUdtPFTndBjDV0F6DgNbaf0xbN4rzuUO7ggOiKcw/flImXn1Mju
 03ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628593; x=1742233393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18EPintEOUagfFPPzsKIXjL17clihVQ97X9UlQXBqUM=;
 b=k5TsvJ7XQFhh/k05d/XucLCilqK8KXWRDqyuo5s9E/0n+Xg4TAAsjQ/XATPe5mW7xr
 LKdDGAMJA8nsP+q64mbtLNTSgOUjZzNVz4+1kFzDKBmMFL+dQMR+KL+DgzkF//Nh7VjZ
 mNI077vNFTYZ3RJmSSlVjQNrIS/Pf/qPMbJ9LpYmHDGDQuydKcg2hShRkBMSkJBXBG8E
 sPKJhWy8RGzQho6yYaGq8tijIvetSU+HgofkfafXcAW3610KElojjjbUcurNLLRd7e8X
 GVVZyrcbHsyIkJfLNnc7M4Hg+J7Mp0sleVU2u3ZHpY0sqxdQ/gNmMF+dVXQZVJ2+ZQH6
 sIdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1wIYXvisqNfiPPA95aJIIenL4KtRYxD+FLpr1FtCquZqIRF3EaZxD/0PqmZgHU2H9r7W16WG81Raf@nongnu.org
X-Gm-Message-State: AOJu0YwQoPi7mNrdKoijNy06G4Px0Hb+PoDAJEuTdV/DmK4o92i4h9Qw
 gdzqspZC6MQcMR2bRLKoZfQQBhTRqnAo28v3TglyWnTm4Aa0GjDwo55aES7AkEY=
X-Gm-Gg: ASbGnctjvyUUa28sftxxUQQWQZY9FBLeH/KEm+Vk595+ttsBVONFQ+WKNnK3JqsXJ3H
 KPuUMPMRZQeabCi/N0RG/mttbeZDlPoUBAD4fETOwDvMr5V/bK6oThC1maXWxmS0bhI4ewSg/QM
 w6fN9UOq6TtAtytpWtIwaPbekybWOD7VoRlIe5k07EoKrHUreTzGBtqjP9T4dqNH98WFW1SHOc7
 ayUA+w3Fv/7iizQ4x341Rv/3lAEMLq/HTE4yjyFkGD3s5W6y9vvQ8iQGp6pXI7YuuKErMPEgzt3
 YbpigWupCTHFbj/8q8jRFweaUH/ME8TPxBQ2zQ+RUvbrtbwig2tSrzxWOA3nNAvR++mgFd9DWVm
 frY9U9CD2
X-Google-Smtp-Source: AGHT+IFHpNJK1OC4HESUStmYNr1R1dR+ntipwXFnMrU2MW/illaJLeA3LSHzaTW9TU9ij4oJ1zH6mg==
X-Received: by 2002:a17:90b:38cf:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-2ff7cee84d3mr23032851a91.24.1741628592583; 
 Mon, 10 Mar 2025 10:43:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e75f1f9sm10170747a91.6.2025.03.10.10.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:43:12 -0700 (PDT)
Message-ID: <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
Date: Mon, 10 Mar 2025 10:43:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/memory.c    | 22 +++++++++++++++-------
>   system/meson.build |  2 +-
>   2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0a..b401be8b5f1 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -355,11 +355,11 @@ static void flatview_simplify(FlatView *view)
>   
>   static bool memory_region_big_endian(MemoryRegion *mr)
>   {
> -#if TARGET_BIG_ENDIAN
> -    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
> -#else
> -    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
> -#endif
> +    if (target_words_bigendian()) {
> +        return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
> +    } else {
> +        return mr->ops->endianness == DEVICE_BIG_ENDIAN;
> +    }
>   }

This should use the same expression as for patch 4:

     return (end == DEVICE_NATIVE_ENDIAN
             ? target_words_bigendian()
             : end == DEVICE_BIG_ENDIAN);

Which perhaps ought to be split out to it's own inline function?

>   
>   static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
> @@ -2584,7 +2584,11 @@ void memory_region_add_eventfd(MemoryRegion *mr,
>       unsigned i;
>   
>       if (size) {
> -        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
> +        if (target_words_bigendian()) {
> +            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_BE);
> +        } else {
> +            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_LE);
> +        }

Maybe better as

     MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
     adjust_endianness(mr, &mrfd.data, size_memop(size), mop);


r~

