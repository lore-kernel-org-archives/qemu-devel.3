Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA0C44536
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCp7-0004P9-32; Tue, 21 Jul 2026 11:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCp5-0004Oe-7F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:55:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCp1-0004wf-8e
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:55:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2caced6038eso70036985ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784649353; x=1785254153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=esfN3+MqvjAs0EJnLFZN7ym+EQDZLXK0XGGmLbAR5L8=;
 b=bmA90sR956ZA4t3mznLlbuDEAokJ2z+6G7NyEkunyZPJ5zciy7KotNAqIGbTyxtAUi
 M9MydDKSR087UO2YfBimRNRQEGAJ6S9mdsdIVrr6KBpRoEXSPAReYywmLU3gZWpVA2pc
 ARbP9mIefsRWPryDGhx9v/ItwqkbgmEAUcdyHDVvP5EH51IcHOlP7Qi2ltHZhCbwzU2Z
 pCmBBvxsESYDwTzgDdfzpH6ogWLoUT4KRDBRoBsOJYQu3L81mu+Iq2bhb0Wi0ZBW3UyK
 2rCTSfi91NEjrxTnzWuDKY5qBQdrc4OG0ukTJztVnlqH4CxDebXN5ofJxtcvcoUIuBSB
 wnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784649353; x=1785254153;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=esfN3+MqvjAs0EJnLFZN7ym+EQDZLXK0XGGmLbAR5L8=;
 b=QJIWDiJDkVOV6wpLEUKCMHfONs+euDMeRfIT2tnuQZKMcWzagMfrIMS+V/HghGRo/d
 WmZWZrc0BOVjT4HDjr8zXnWnDet79jc5Y1K9POxN9cslqeknbva+Ypq84GIU85I1XioL
 0YUsAqQ2eCcMD7gWqQpcbcxn4R3izwgZ6INvsh4jfcZiok+4DU0AtdAv9t1J6eOGXxvH
 natkHC9EtKNJ4BRCuKZcMagNp57nIjUJu1rpmMEEoeGJBsfCe7+Z0xaTdEqLQ/zFcRQI
 WMpaDmloICV2N1NymF0SIIMkdMbFLz5yVxv7yRcx7/LR0BRD6U/zxK1xIo84bphr5Rvu
 x9Vw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiSI4JPI7e+/igngt0mFSVpERTwrq2t0yY9N1Qrr+bIA2CtyW70oGSnUfR2S8hKrGuORgLJvyGJJx8@nongnu.org
X-Gm-Message-State: AOJu0YxcCiwUWTdarrB1w/0Xr7lfTIOMX+VyUWwy/6VasM3gcgvV+IYm
 Bhj3h6HJEHblV1KRlWjAZjoMB+H4WUogWIswbNvrWJ3qZVRnHA6tjYHcjTNBip+1uvc=
X-Gm-Gg: AR+sD122pbg2Uw3RT3TUAPq0VdZbT5jzyzThUOg1THfb+rq0VCN6ViCzwTjYLEGP81E
 HEN4e/q5OOF0RrbyDHv1DS0v2KuOcUGRX9AW1gwnej6T7dLicUsJ8CAG6Jo5Nx3uGz8/ewICD9N
 NYDW8OIdDHWX1jYTqhRTRxlS/Oqzoib0L+SyQKPX2fkFQYvluF9KJSdttNDrbKfgceOQehlyNjQ
 1Xr0Ytk0g3pTCGA74gpi9YxmB0GerXVTJnAGSGBgleSF0EdmBlQ4+LN3BdKKX1HPIK3qjbyeEYh
 nQ0iisFtJzYeyAh2zr5dwKKThkPt72KPL5uCLvLbGztHeeDKtTpFzabKVlgyH3MpEJc+dcYq78z
 JynTZm34HD+AJE+uFinYntkQTtPgcT39G/+NJJte756mT28xeytDojLw9OmZlRVntTUrKG2Sx9i
 PCp/apvG3KHbDheqU=
X-Received: by 2002:a17:902:f706:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cf8dde30a5mr1731355ad.24.1784649352905; 
 Tue, 21 Jul 2026 08:55:52 -0700 (PDT)
Received: from [172.20.2.34] ([32.140.233.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09a9dsm226445eec.19.2026.07.21.08.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:55:52 -0700 (PDT)
Message-ID: <a78e4f8d-6cc8-438e-b970-2f193991f5e5@linaro.org>
Date: Tue, 21 Jul 2026 08:55:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/arm: Split out helpers for creating MTEDESC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-14-richard.henderson@linaro.org>
 <d714d068-874f-44e1-bdc5-0529188af176@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d714d068-874f-44e1-bdc5-0529188af176@oss.qualcomm.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/20/26 01:35, Philippe Mathieu-Daudé wrote:
> On 18/7/26 01:23, Richard Henderson wrote:
>> Assert that align and size values fit in their fields.
>> This results in more fields being filled than some
>> helpers actually use, but uniformity is for the best.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 123 ++++++++++++++++-----------------
>>   1 file changed, 58 insertions(+), 65 deletions(-)
> 
> 
>> +static TCGv_i32 gen_mtedesc_xas(DisasContext *s, bool write, int idx,
>> +                                unsigned align, unsigned size)
>> +{
>> +    int desc = 0;
>> +
>> +    desc = FIELD_DP32(desc, MTEDESC, MIDX, idx);
>> +    desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
>> +    desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
>> +    desc = FIELD_DP32(desc, MTEDESC, WRITE, write);
>> +    desc = FIELD_DP32(desc, MTEDESC, ALIGN, align);
>> +    desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
>> +    desc = FIELD_DP32(desc, MTEDESC, SIZEM1, size - 1);
>> +
>> +    assert(FIELD_EX32(desc, MTEDESC, ALIGN) == align);
>> +    assert(FIELD_EX32(desc, MTEDESC, SIZEM1) == size - 1);
> 
> Why assert? This can't happen...

It's not impossible: this is a bitfield smaller than 'unsigned', and it'll also catch size 
== 0.  The largest use so far is 512 for user-mode DC_ZVA, 9 bits, and we currently 
allocate 18 bits to this field.  It's just about future-proofing.


r~

