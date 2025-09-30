Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D2ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 00:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3O4p-0001na-3F; Mon, 29 Sep 2025 20:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3O4m-0001mz-Vr
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:18:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3O4b-0004hC-J3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:18:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7833765433cso3138459b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759191502; x=1759796302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l+kw+U1dLkjGpWApy8j0jNKtvldUJFrrDP6f0QfDaOA=;
 b=gh9Yzu8TpH27aZH5kxPo1uSbc0pAVrFt7Nm+NN6aUbXMtcMP/U+2CFDcP2gnjVg+Fr
 eGuE0qOT2v2MEcBCuGji6ppWQF9X8D8oT6lsjrCoYLyxgxTbXdERKtSlgQeGZIngpkIg
 WR4gZ9Nb5vS9pjLncvW8xrbuseLVD+aTSG0Uzyfn+KgnMfxxkAJRe0MSzFwmqMXy9GNU
 JcCqaau3yifGaDoxbXqpcnL+S/9/r7clJHcyQu5kJeuoXwweLVL+i/W8BS8miqZlsOlg
 2usfHbgbh83L34amY15S4EPGwwoMCGL9ed88D+hgOF60YRWXd4ganlqYhOGYnf0nsf7f
 7C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759191502; x=1759796302;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+kw+U1dLkjGpWApy8j0jNKtvldUJFrrDP6f0QfDaOA=;
 b=CluHZeC0HBvzSp1aIzdOQ1D/RJvIvcwPFqKEk9+RWOJblDYwvxqMz2Cl1BPndZN6Hn
 jb1/HrmbDL6NifaORfej86TV47GN46yrRVaffNzx15XjXoh0YbL+9dFGC4ZjnD4J5pQc
 4LRZlXMe7CGcihdHabEUYFZGc6eccdYclp+wRwcu4xsmWt24Xom0VUfSKCkF5A+t3FI0
 jQd8K/JJNNezDVhmM28T2S4HklxGtzL7PWG/2tS+i8foE3jeUHkMglilt7fR+81cRF65
 ADmtF3X5qn/5SCSP/4mayItTBRK4onOlCRCyESNH0ViI5VG4x4jygxcviuoAGCcyzY3H
 KV4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFIUX84f2di7cto6Z4NB12P9iTx20+XA8csfhULyj83VuL81cj/YNwd840WO98nvwVqdc9TNCy/51Q@nongnu.org
X-Gm-Message-State: AOJu0YyyioMWEk/ykH1C93F09niTFSDrwEbqnDnoL3+2aI2eKeXv11EC
 0KpDY3hmjPssmeVUuCAKECVrsOofmYlkggxFI/HLi3j7RJMhUKm5MNBMTjCGXjoIFhQ=
X-Gm-Gg: ASbGnctoXlv2pei6h3lgmLOqrrPvNCjg5ZxZMiHtj8G9csrSnqvgaFCaaF058acWagb
 l4wnQJsJKl730xXdeHzVovuE3zvFcmcVlXMJftLpg+Cwl/eLIkRrQ7WOTbTD3sbWuO/xfWxbe3e
 iQgeG4MYDEe0ZH9yd/wikT5iIikhtT3T/Dp/y3vRNBIcMDRW173nkomT9mQ5uxLUgjzLd9T9nS4
 d3t6INexYataNahJmL4a/k+5n5o2bAP7Z85097U9DiAdFRvsnGJEk9q/9xcb4ghlPrQpSSrkqxX
 PBFBB6viDKrGFa9uWfSW2xNbxLuKlbfC1Hndvgfgu23vxG0IDXDzdT/ODXk1v27mIONVC6U0CbG
 Xb85XdXRacfJbi3LpWq3iTrPmFIMA/R8kffQyEs5VmIv8DWDEpCdiZ15sDqfkdMQ=
X-Google-Smtp-Source: AGHT+IG2uc/JWrceIWUg3XMESdyhBVvleYABZPtcqoylHNmk+WvGlnksU+gMMDrcYvP/d8q+2nBrcw==
X-Received: by 2002:a05:6a21:6da3:b0:2b5:9c2:c593 with SMTP id
 adf61e73a8af0-2e7c4412524mr23804605637.5.1759191502186; 
 Mon, 29 Sep 2025 17:18:22 -0700 (PDT)
Received: from [192.168.176.6] (51-148-40-14.dsl.zen.co.uk. [51.148.40.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c557493asm12237213a12.25.2025.09.29.17.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:18:21 -0700 (PDT)
Message-ID: <a513793e-87a0-45fa-9a9b-d33b756c0557@linaro.org>
Date: Mon, 29 Sep 2025 17:18:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250929183254.85478-1-philmd@linaro.org>
 <20250929183254.85478-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929183254.85478-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> Update the documentation after commit 3c8133f9737 ("Rename
> cpu_physical_memory_write_rom() to address_space_write_rom()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/loads-stores.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 9471bac8599..f9b565da57a 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -474,7 +474,7 @@ This function is intended for use by the GDB stub and similar code.
>   It takes a virtual address, converts it to a physical address via
>   an MMU lookup using the current settings of the specified CPU,
>   and then performs the access (using ``address_space_rw`` for
> -reads or ``cpu_physical_memory_write_rom`` for writes).
> +reads or ``address_space_write_rom`` for writes).
>   This means that if the access is a write to a ROM then this
>   function will modify the contents (whereas a normal guest CPU access
>   would ignore the write attempt).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

