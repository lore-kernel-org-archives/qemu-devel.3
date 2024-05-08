Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CB4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cVP-0004L6-AU; Wed, 08 May 2024 04:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cVN-0004Kt-KT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:18:25 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cVL-0004qh-Q0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:18:25 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so1018116266b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715156301; x=1715761101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WrN6DO/QUAWAtwLoL/56YyAMpvxSKjgFx91S3d3we4Q=;
 b=oZYByWGNGEGSRWaAJnkZ5DQmdX1jyd/DtvR8SS/yxdme8BliCpqeGdk0H4NfwC2e+9
 iQX25HYWLXnO9HfTkJXaBEmrLW9UDcF5Y8QerQymIhin+2jxJm6S0q6/jROXKCEP0J3P
 0AbcorJJ2JGmdh/BFaFDe2XplNEdzjJ19brC+rAmzfY/86YuWvHY5x7qQpEj1xp430hD
 FAI+v99fSpDvBbbobBJBsXZp7JIlMFn/hmAiA0rMM11OFdFtq8rzHUJG7VPtY1m6bSHX
 nzq6OnmwsIivIJSLKBOnC4VWJeJ83DpKlXMKbROnOcJr4VqapL6XymCBLju7DhWgzUBw
 +qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156301; x=1715761101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrN6DO/QUAWAtwLoL/56YyAMpvxSKjgFx91S3d3we4Q=;
 b=THKaK2VcXB1kjgTQA4aMtvZBequeMBWOxViSYzDX8EAd9/NvS3PlL3E1MpXFSxS4xD
 hfb+QoSdsnxgN/aFW813h4v7ubhidqAhGNotDJM3rRvbjVoejCF06nk8CnglINztGJ1/
 Qq2K6yoa2RYksTdfavJ6D0/WXegApApTOKIXsDEarPl9YJkjHVuR38iUwyRjJRzeHdoo
 w2MXFWOVMFd0rFV7JR/nH1rvDdZg2h/CXTVYGbwF/9cdPgBD60o3+jjHHBAK04IX3/gZ
 kMHor3Ycdu8O3YLq7Tci8vziezAEC/gjpY98cXFMsUsvBadFVqn30cV/5rRoTSxrPmwW
 mHww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgDN6W9o29O58kSdHcQ3bsBUdOtDVW5PgI3BTVGeKA1+hcZ//VWihVewgQkQrUdm44X0a5KxTstoz5gucE1RkXs1gQGDQ=
X-Gm-Message-State: AOJu0Yxu4fgykKT0qH5s8/LnJZtouP5S8uTUJpeA90MFhgasWakSBh16
 wyPQzp4b2hXtxpJICuTVf3RRRseIJffA5ZoXzU7RHLbW2C7JPrY9BVhjce4QXG0=
X-Google-Smtp-Source: AGHT+IGzr93Q2c4cbaZwBS85AT8eZO6479iUjYMC+8fQ9gP0e1CSD9Zyj3e/BscFnghH5SLNuDKLmg==
X-Received: by 2002:a17:906:f1c1:b0:a55:88b9:dabd with SMTP id
 a640c23a62f3a-a59fb9e5096mr104985566b.63.1715156301379; 
 Wed, 08 May 2024 01:18:21 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 kf6-20020a17090776c600b00a599a97a66fsm6061160ejc.55.2024.05.08.01.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:18:19 -0700 (PDT)
Message-ID: <bbeed431-838c-4c52-b943-c9a39ba0807f@linaro.org>
Date: Wed, 8 May 2024 10:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/33] accel/tcg: Reorg translator_ld*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-5-richard.henderson@linaro.org>
 <aa92898b-860f-482f-b105-40d8b8c16a9e@linaro.org>
 <67e50ffb-b680-473b-aeda-bbab678d37c7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <67e50ffb-b680-473b-aeda-bbab678d37c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 7/5/24 18:49, Richard Henderson wrote:
> On 5/6/24 15:47, Philippe Mathieu-Daudé wrote:
>> On 25/4/24 01:31, Richard Henderson wrote:
>>> Reorg translator_access into translator_ld, with a more
>>> memcpy-ish interface.  If both pages are in ram, do not
>>> go through the caller's slow path.
>>>
>>> Assert that the access is within the two pages that we are
>>> prepared to protect, per TranslationBlock.  Allow access
>>> prior to pc_first, so long as it is within the first page.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   accel/tcg/translator.c | 189 ++++++++++++++++++++++-------------------
>>>   1 file changed, 101 insertions(+), 88 deletions(-)
>>
>>
>>>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, 
>>> vaddr pc)
>>>   {
>>> -    uint64_t ret, plug;
>>> -    void *p = translator_access(env, db, pc, sizeof(ret));
>>> +    uint64_t raw, tgt;
>>> -    if (p) {
>>> -        plugin_insn_append(pc, p, sizeof(ret));
>>> -        return ldq_p(p);
>>> +    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
>>> +        tgt = tswap64(raw);
>>> +    } else {
>>> +        tgt = cpu_ldl_code(env, pc);
>>
>> cpu_ldq_code() ?
> 
> Oops, yes indeed.  Fixed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



