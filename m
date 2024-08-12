Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A08C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddCW-0007Va-4j; Mon, 12 Aug 2024 18:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sddCU-0007R5-QV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:07:38 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sddCS-0002ZU-Ha
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:07:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7a115c427f1so3127893a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723500455; x=1724105255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBboSqU+szwUEzyZRoEDmY+PcSklSTLDfjw1jqmoXEo=;
 b=Z4Axuw5bAn3pLqOHZ2p8KYI0wn1Hia8LYbwsWohww1kY2oUE7frU8SGkxLQMCg14lq
 KAv6oDxAx8xxVBvUAaLavFq3m0U3YNZu5TT1nWnHIaYF9wMPxpvQAA2y9XHP2dMswwIO
 xgoLmGARxaYVWQJpFIcrni70OkmO2VTgwuKOAKHpy1+eQj2yRgwVhQJdckXrSeu+5CAi
 vnikdcnpSLAzaEEXQ9ugYfpGj2nYlQg7svDa4BmtkBYaRP+UIwaQz6pxod+EOiyv121n
 RKhyOk7X06YhLi6EidRNQi4cIMIHt7TQmnfLUV4U8P+WfeGwrjGcxhwiATuNHW2ilYjJ
 ebjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723500455; x=1724105255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBboSqU+szwUEzyZRoEDmY+PcSklSTLDfjw1jqmoXEo=;
 b=HFoKLHG5wXgrTnaouz8qbjQfTr0n1+C08f2ovdvb6XFG2o5QwmE+WQz4tQti6PVkz1
 LX7eJwymQ7JSRend3m6Uab+CiTtdmCqnj+t5HSR7/yfaauXxnE5zDmVvMQ/65+IqxFb1
 Md9uDtGDGjoTtU7O2ZMFpxqp+8bPdcji1bwlZb7ciQq7igkawjjRPqsR2zitZVG2UT73
 MDsY/AJtzqPOJ10G4GYjjOAGCmyGFVqgA0rAGS/Ma4dnk6HVMBMs5Obq+uTr/IaCbq0C
 O8iFKzHV7+m7ko7D9N2MADAjYHtYkFgSrygkNob9faPBtuy/QyBiDhpRL+3T94qMfGTy
 o0/Q==
X-Gm-Message-State: AOJu0YwhFF0wMeO9L86zJoEBMf+Yz3y7JU6P/ATfvBAcVTVu9hpE0rf3
 EP0ieKKw1Iwsn3robRtLw8GrHNg/fZ8uxOI8IGZYzwJMOse8dk1hxKgwWSZ+TuA=
X-Google-Smtp-Source: AGHT+IEp1Hq84f9l+rwDqnxG5ZMoaW9TZEXBeAI6S2qxptZ6IQ5oREvRXO3vkv6eVJOLFxAb3ydr/A==
X-Received: by 2002:a17:90a:d357:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2d392513090mr1877526a91.18.1723500454588; 
 Mon, 12 Aug 2024 15:07:34 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fcf275aesm5664304a91.32.2024.08.12.15.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 15:07:34 -0700 (PDT)
Message-ID: <8e0bf252-bc74-4086-872b-a11eb3b0b9ad@linaro.org>
Date: Tue, 13 Aug 2024 08:07:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/arm: Convert handle_vec_simd_shri to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-13-richard.henderson@linaro.org>
 <CAFEAcA_yikLcv2gSc6FVbue+HSFuk4w6oUg8H37jCaRJhtPD=w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_yikLcv2gSc6FVbue+HSFuk4w6oUg8H37jCaRJhtPD=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/12/24 23:14, Peter Maydell wrote:
> On Wed, 17 Jul 2024 at 07:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This includes SSHR, USHR, SSRA, USRA, SRSHR, URSHR, SRSRA, URSRA, SRI.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 109 +++++++++++++++------------------
>>   target/arm/tcg/a64.decode      |  27 +++++++-
>>   2 files changed, 74 insertions(+), 62 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index d0a3450d75..1e482477c5 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -68,6 +68,22 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
>>       return x << LOG2_TAG_GRANULE;
>>   }
>>
>> +/*
>> + * For Advanced SIMD shift by immediate, extract esz from immh.
>> + * The result must be validated by the translator: MO_8 <= x <= MO_64.
>> + */
>> +static int esz_immh(DisasContext *s, int x)
>> +{
>> +    return 32 - clz32(x) - 1;
>> +}
>> +
>> +/* For Advanced SIMD shift by immediate, right shift count. */
>> +static int rcount_immhb(DisasContext *s, int x)
>> +{
>> +    int size = esz_immh(s, x >> 3);
>> +    return (16 << size) - x;
> 
> We need to avoid shift-by-negative-value if esz_immh()
> returns < 0 here, right? (like commit 76916dfa8 did
> for tszimm_esz())

In the interim, I have rewritten this to be more like neon-dp.decode, to decode each 
element size separately.

r~

