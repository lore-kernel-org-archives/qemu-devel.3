Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCCCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnQX-00047K-LU; Wed, 03 Sep 2025 09:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnQU-000440-N3
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:21:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnQS-0006O1-GU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:21:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61ed9e63056so1142772a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756905682; x=1757510482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ADAKc2JbmgBrNUeA1NsRF9zXXIKSuj2KSOVUAXWLk+I=;
 b=pUTv1YsdAb4p7ytLlYZKnkvd71XEOxbXzUAsiP3TXijg2IumBXWIo6LqyeCm7sOXri
 qtFZu6yuv0kKqtxyceqRjXtySTFdAHTen08hzUmWfTO+Lhty56wlSaWuAc4v0RioAbKA
 15lCbax0J/C3sM/lhOprxIiS4spJiRPSDcxuYCf747uOQ1PzvGPout+RXJ/+B+tTc68z
 K7Z6Tse/tNEBKVIc6t5bZH3IEpCy3+AYxITNRYicGISXT6IX2zanGlra58+CsbxSxmwW
 SdQzUk/Mu0oYT/ysejcRLXCD02N5lwlLsLNcf2WeLWhM7pKEbqCQDR+v1ejiEe7Wyw2D
 5hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905682; x=1757510482;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADAKc2JbmgBrNUeA1NsRF9zXXIKSuj2KSOVUAXWLk+I=;
 b=ZRjY31ZhQPmEYnL00gxQZ10KcwzoQylmDfZQEYXszgK85Fb1KJuozCntDcsBakVJKR
 RaUhuXwybe78DKmFkTyuC+G3nDAjVJGKuaOfFytndl4KX/ogTGWUCBbUSCo8Dv5IOxuX
 W7kNxRSlOf0/CQNRvGQTrDwItFMByUi42ZwVZbikHMKaF40nhPsePlz5HqdSn1KKwlRv
 gh5I1g/N5qbZuDtCmxw/qrzY9EYHIkXDPGz1xsfw2UxO1T+r6S5IIogdYuwSEGaCsWL0
 oPHKsePPk6xvYdp6qlmPLFFlXBXbsYZ5+AaBMunINaEzYXHF+k9BPpDIZd9bjAjJGO8f
 4XKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVizrZI1UIycK6VCG0HTEcAFWoSScnbIAaNRHCgN4DocPOcw/JpbCY5nemHXsd2JXuWaKXLEfAUdFrQ@nongnu.org
X-Gm-Message-State: AOJu0Yxi2/Lt/rYSzWTPlJy0mVlZ0GH/+2A0O3WSI5tmcOF9G/E50D9M
 tmG6jbLRHjH8964sGPGPSh25tqpA/9YRM3AeT79TguTDQtf2URwLJbBnbZTnnNgJ1enbxfNyqdP
 SyY/xBOI=
X-Gm-Gg: ASbGncuaQeD8jUKgkISpHFyn3OSeBejG89Ci2GxznACDCZrL2/loZ13qJbkV8LetK4o
 r66QTeNw4c9eUl5utFGNOwqZgMvmIbKmFJSvqkp41/pRHDLaxHQs/X1y9B1IGP4UJgYvhXAdjiD
 iZCIhWkYbzYjAeYupU7RTLYjs+zTlQi2hieALHZpyUV/0ttZd8ONRQha0zEDgaUc4YDOqiySSr7
 7+XgtgkAVBmZjifg7NnPnX0o1aAA9ZHfnulRgedCE6ZThW8fAkDM2GPprpX6tS8/bu6W84C/njN
 TKUIhFr3bXLBDnA6Aj93EGd/XDHsgOwH41zqNBmGsXrb7YMS2FLqjp4YlbFUQVhc9Z632vblddZ
 oJvG7dOurLFcSWh9teWIk8YJBEEQlSd2yrCh1t5/31lRx7+4BGOS57/UyZbOFXxOwacMRqUOcyo
 X/aILWjw==
X-Google-Smtp-Source: AGHT+IEHTuK75wXkKeAEFQavUrUWql6pX7foE326RxN1MIV7JQQl6SIfXAMXyvdGEXLYn7lFoqcTKA==
X-Received: by 2002:a05:6402:35d5:b0:61c:7090:c7de with SMTP id
 4fb4d7f45d1cf-61ea14e0055mr10652016a12.13.1756905682146; 
 Wed, 03 Sep 2025 06:21:22 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e58aesm11625862a12.36.2025.09.03.06.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:21:21 -0700 (PDT)
Message-ID: <6819c70b-57af-4155-baf1-8e9a6b8cb93b@linaro.org>
Date: Wed, 3 Sep 2025 15:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] target/loongarch: Use loongarch_tlb_search_cb in
 helper_invtlb_page_asid
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-10-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-10-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> With function helper_invtlb_page_asid(), currently it is to search
> TLB entry one by one. Instead STLB can be searched at first with hash
> method, and then search MTLB with one by one method
> 
> Here common API loongarch_tlb_search_cb() is used in function
> helper_invtlb_page_asid()
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 42 +++++++++++++++----------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 620de85a3a..c074c956a2 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -32,6 +32,15 @@ static bool tlb_match_any(int global, int asid, int tlb_asid)
>       return false;
>   }
>   
> +static bool tlb_match_asid(int global, int asid, int tlb_asid)
> +{
> +    if (!global && tlb_asid == asid) {
> +        return true;
> +    }
> +
> +    return false;

return !global && tlb_asid == asid;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

