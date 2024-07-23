Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326AAC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHzB-0001vG-Md; Tue, 23 Jul 2024 12:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHz3-0001G0-6d
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:03:27 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHyy-0003DL-Of
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:03:24 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f01993090so3535964e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721750599; x=1722355399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CuoFuE/etZCROEXlIiPDQu1xFLj9jT2GBkXbshljb78=;
 b=OHfU2g8urFNXH4RxXZQa3cRW/0vGfCDZ1Sdzs59W2ZYeP+WHeAGdzB6UvRgcoRpHt1
 Cx+UsYwzZulWf1ZNwjWeICr7gcEw5JVdWliMN1lY+jDnh+GjG1TId2xoXLnO33RCKdbj
 mqRahXlJGxjL7wg72LHCpRRYP1ry5cIN5njyc/GRaKGodgdAC5VoqycE6atJE/7o9khp
 U5jltu0xzqHo49oRHMuGYNiXw826RF2GKOP5k13qv8lUP1JfNX0rwNIxGekIoemTD8mF
 QCtsPTSAss6CAt75GMqSdwzkFSv5v5p1Krh0i7r9BlHYm3ZFAZd2cvRbbG1Lh41NsgOR
 y0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721750599; x=1722355399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CuoFuE/etZCROEXlIiPDQu1xFLj9jT2GBkXbshljb78=;
 b=jOV3xN/0JWpjGN8J5KAfUr4RvVTLpEeOEgUribKYQDf2df18cBCFQ7HhA/kyVlV8E3
 BaRQamZu8hQZQ9qL8e5ZnCDqVAWs76uu99haORV0QQzLK8w7dJcvzSKZhhN5lWlOA0La
 FYUBLp2goHVb30tPncoY2E9TCNXLHQhe88vHTN+ql2rfZUA6vJY6h2n2AE5J/1nkjF0D
 LctNINOaERLOxwYGlApKHy9/jZ6Nqe0II14cbSqAZ+rsccjLb85VxXXwp/zrCvPz24ws
 IyM1BjFOyPMUE6tfxWqX3p+jkmmbrv79Ux1vuCKoyhHmct0dut4vwjeRx3Ru4PX0aQOS
 JH4w==
X-Gm-Message-State: AOJu0YzlP+bhrYYdIcD2aoo0sC4+djLqAgcDkV8MXMj5eEyy7NFBLAtq
 t0M69Y7GW9WknJMN1FRlSTS0tn3r+QIAiI/YxYRPp6e8UVg91ciU25ySMPwOusY=
X-Google-Smtp-Source: AGHT+IGZYYhG9EOBZ7U0v/hugn/01yclQwXYi36SsR1sn6O+a3b5ahzvMKPvzK7iUEFYEJJghTpioA==
X-Received: by 2002:a05:6512:2316:b0:52e:9d28:c28a with SMTP id
 2adb3069b0e04-52fcda31d37mr25040e87.26.1721750598597; 
 Tue, 23 Jul 2024 09:03:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a95530sm196303185e9.45.2024.07.23.09.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 09:03:17 -0700 (PDT)
Message-ID: <1d0069cd-891a-4ce8-8759-375493906f55@linaro.org>
Date: Tue, 23 Jul 2024 18:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
References: <20240723150927.1396456-1-peter.maydell@linaro.org>
 <331c454b-56f1-485b-bc70-c1b433db20f7@linaro.org>
 <CAFEAcA_HoeDYvjVsbkMJqYxEWh5nE1Y9hRLkeOhfVqX8=r=H=g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_HoeDYvjVsbkMJqYxEWh5nE1Y9hRLkeOhfVqX8=r=H=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 23/7/24 17:51, Peter Maydell wrote:
> On Tue, 23 Jul 2024 at 16:44, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 23/7/24 17:09, Peter Maydell wrote:
>>> aio_context_set_thread_pool_params() takes two int64_t arguments to
>>> set the minimum and maximum number of threads in the pool.  We do
>>> some bounds checking on these, but we don't catch the case where the
>>> inputs are negative.  This means that later in the function when we
>>> assign these inputs to the AioContext::thread_pool_min and
>>> ::thread_pool_max fields, which are of type int, the values might
>>> overflow the smaller type.
>>>
>>> A negative number of threads is meaningless, so make
>>> aio_context_set_thread_pool_params() return an error if either min or
>>> max are negative.
>>>
>>> Resolves: Coverity CID 1547605
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    util/async.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/util/async.c b/util/async.c
>>> index 0467890052a..3e3e4fc7126 100644
>>> --- a/util/async.c
>>> +++ b/util/async.c
>>> @@ -746,7 +746,7 @@ void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
>>>                                            int64_t max, Error **errp)
>>>    {
>>>
>>> -    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
>>> +    if (min > max || max <= 0 || min < 0 || min > INT_MAX || max > INT_MAX) {
>>>            error_setg(errp, "bad thread-pool-min/thread-pool-max values");
>>>            return;
>>>        }
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> I don't get the point of using signed min/max here...
> 
> I think this is because those values may originate in a
> QAPI command structure (EventLoopBaseProperties), where
> they are defined as "int" rather than a specifically
> unsigned type. So we carry them around as int64_t until
> they get to here, where we do the validation of whether
> they're sensible or not.

Ah indeed. Probably very old code hard to change now
(QAPI does support unsigned types).


