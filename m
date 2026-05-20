Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhbn-0001pu-6X; Wed, 20 May 2026 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhbZ-0001gK-7u
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:09:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhbW-0001xL-3g
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:08:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2babfd18435so20694035ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779286136; x=1779890936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQRq2mpiaeZaxOV5Iv8VnmEEkNN84wAx6k8GfeMGLy8=;
 b=z2uW//sbI9pqYSExnrB+fkZF3tc5vozqyts8AuuTguvyHdEq124qTc05Frehy7cR9C
 3zgZ1BK97mq8JngQGdsEJXSeIZOlS0Y9j1N9vMCe5rrvhD3hy6p7Q4/XoI81oy+U32s7
 UmVThWTTh/aQSxIJrLqhITCVmhl/o/PMDq65eaeciHzb9ghy89xwPSCwih8FZgFoEB2o
 5SN6cx+6iTMQQbgm8ClMx7PQq71UOIXhMmaZ5PQt/Qx08yuGuVoRaUoLT6kBEwL3LzSD
 uNz+LEyIiExrGLo3wz8PU8HOBupppoeqSLzlEAw4qsDHCKzSG0VJX9VwtPMS1VIqRpoX
 6XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286136; x=1779890936;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQRq2mpiaeZaxOV5Iv8VnmEEkNN84wAx6k8GfeMGLy8=;
 b=Nokx3x+XgtP/RNNPll9wygMgcSDv52N1Za7p3jPISgVl6fbrtYIeo+30yBiXr9Mtrs
 JvrndTqHhHLyGHA3SyNK+wBPx56roZo9TtIMqv7Hj4BRhRdfB6sXlDZ4R1Zu42O+5KGr
 ezVUxGDZ4hxbp66ZejNVrcvt0+2bgWUmJIMAYxRCouTjCxYGXo1BcHuZqQRKMVJWrzzN
 4yUNm1cjJ49hmmpXGH6kOPqapV+EisfNx5CBY4lQTEaEv7Bk0ooealNF6NiqHi79VZER
 2l8g1Lgbfth/INoisvK8hnDlcRkiQ/puZdUNFFWPo00QsQvZF3Wm9mzr9zrYXni97mz3
 ptGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NRsKyCWBoy5fmNX//IM/LHejRNeCNqOCbDdFQFDarZ6fw3XnMXrWgyyEff8ZxCCblk0jcys0KW/Z8@nongnu.org
X-Gm-Message-State: AOJu0YyOIKhATC7ydVHwP8mDWwYWcnynHxESFriVWnjS+rOUtw2vnQPY
 Ky3cdiF72iwgtYFCgEk1Pa21Twh/5ZKoImgliDr3sjF1YXB3hQWjriX3Vpw/GHh7J/E=
X-Gm-Gg: Acq92OGXVnNsS5ybTsDnrCIv1dv8iIbOALUZbsD5Rx0pHP0XLK/opCySho2e5Im4uCb
 qZjMp6nX99h2EUA/FZmwHQOqRDPFh2NXRdrIOF9hW48lrVgIUby2jrMeUL74potktGBLLa1wf42
 x2DhTkQEmBz8lwjqn+KhNdSn9G7GPHRshl/bM7cE6pV1BqN+fdle1tWNISrdq997bPaOMrZZSa5
 QmYSqycfJBBAwwuJK+doAIh/dBxIODnI3WrNhqraMG5ti7doG1rns0/2u49eGQq5V5l8LpLegda
 8/c6K+LSn/XUIHBU7YTqwlbPlGVW2WaM8Zvljxsaqp7ptp2gWEbyg74J0yXEv5LCiKYfbVetjc7
 UUCSe0R+5LrF14Y0PYyKqa6xa//yFOLYcIL8LpeqZ9gtxtGLaV88X3cZlImMWIAuBMJUBrqOPW5
 cKP9e9PbjInlQHH0DuM2CkOC2eR79lRomi7cxx
X-Received: by 2002:a17:903:2b0c:b0:2bd:aafb:d0c7 with SMTP id
 d9443c01a7336-2bdaafbd216mr176011435ad.7.1779286135914; 
 Wed, 20 May 2026 07:08:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5f291sm229662695ad.15.2026.05.20.07.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 07:08:55 -0700 (PDT)
Message-ID: <1eb21dcd-12d0-48a8-9877-f8dcb26fa27c@linaro.org>
Date: Wed, 20 May 2026 07:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/24] target/mips: add Octeon MTP instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-20-philmd@linaro.org>
 <2a725a41-4ea2-4336-afb2-13251f975670@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2a725a41-4ea2-4336-afb2-13251f975670@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/20/26 03:41, Philippe Mathieu-Daudé wrote:
> On 20/5/26 12:18, Philippe Mathieu-Daudé wrote:
>> From: James Hilliard <james.hilliard1@gmail.com>
>>
>> Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
>> partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
>> pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
>> For MTP0, also set P[1] to zero for backward compatibility with
>> Octeon2 VMULU.
>>
>> Legacy single-source encodings have rt encoded as $zero, so the same
>> translator path also preserves the older Octeon behavior.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/octeon.decode      |  4 ++++
>>   target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
>> index 5139543b153..bb0a9f1d99a 100644
>> --- a/target/mips/tcg/octeon.decode
>> +++ b/target/mips/tcg/octeon.decode
>> @@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
>>   MTM1         011100 ..... ..... 00000 00000 001100 @r2
>>   MTM2         011100 ..... ..... 00000 00000 001101 @r2
>> +MTP0         011100 ..... ..... 00000 00000 001001 @r2
>> +MTP1         011100 ..... ..... 00000 00000 001010 @r2
>> +MTP2         011100 ..... ..... 00000 00000 001011 @r2
>> +
>>   &saa         base rt
>>   @saa         ...... base:5 rt:5 ................ &saa
>>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
>> index aae6e9811c8..36d268e09c4 100644
>> --- a/target/mips/tcg/octeon_translate.c
>> +++ b/target/mips/tcg/octeon_translate.c
>> @@ -242,3 +242,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int 
>> index)
>>   TRANS(MTM0, trans_mtm, 0);
>>   TRANS(MTM1, trans_mtm, 1);
>>   TRANS(MTM2, trans_mtm, 2);
>> +
>> +static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
>> +{
>> +    /*
>> +     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
>> +     * from rt.  Legacy one-source forms encode rt as $zero.
>> +     */
>> +    gen_load_gpr(oct_p[index], a->rs);
>> +    gen_load_gpr(oct_p[index + 3], a->rt);
>> +
>> +    /*
>> +     * Octeon3 clears P1 with P0 so that VMULU sequences remain
> 
> I think you meant s/P0/$0/ here. Otherwise:

No. MTP0 writes P0 and clears P1.
Perhaps better as "...clears P1 with a write to P0..."

r~

