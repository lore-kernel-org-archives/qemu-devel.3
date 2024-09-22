Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA85CF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 04:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssEdz-0002Ez-VL; Sun, 22 Sep 2024 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEdp-0002CM-1a
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:56:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEdn-000150-9d
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:56:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c465578555so2545321a12.3
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 21:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726980969; x=1727585769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I+43gCnSJHdC+IibaLHIJEitf7mAGnDW3pv8c3Ifa6o=;
 b=Z3KHea1N02U3vNVAKepKz7IdrfZQPWgt3izZp9vYTPmkPxd8R+21FOr0EvkObB0XZt
 +xjDja9CcN4jSZPMbJc1msbQC8uuthmnvMNGEV2Q1fKoqq/sKQYTUA+dB6IdPDfcqF25
 YyijBZsYfZfdAZgIBLvOp9he0nzvrQx8DLiH4Gswwsjk9DPBHlZcOtqmK0LbRKG0b51R
 D5fYrVU2gTRD+PyM4taQZQxLo6TQsatuZ2uodLDJWZvT1JAkzuVUR6YNkhJqiQGKPUqE
 5kUDKc9lczZGU6BY5TLCf5s98HBghyZLLOoPEYBiK18JVRBoEw3G8ugMuOqNBVtG+kDn
 LgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726980969; x=1727585769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+43gCnSJHdC+IibaLHIJEitf7mAGnDW3pv8c3Ifa6o=;
 b=N0ZHWXpp9FJsTC2dQTdciKNIFm81ThGwja8GwPwxABF3v8H26SWVOqUm2SqDJUz7Lb
 PO6KbhCJ7NP5ZjYMDY1gwogCx5bva4o2sM7Hhh2933rlCjroticGb5rx2PNA4lPHyo0H
 wYG8fDFiUoYVRLkKzlexZY1XLtzLzfEOuE+KGXVFRyGFY6AHm28aACYqGvX3V5U0R79j
 xJTcFFg3y29fAYWcFnCRe6R/GewAtdfKoBCSt4BPjx6NnxgalLGgeu6rNK19y/jyR0Xe
 s186DEaL25Z9WWzc9oJ90lBIgTnJkhkm0lLypZqbLxrDvjV4AdUkAQsBLoL5sE06lVFM
 tRgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVccpOX+CFYJ2Lm1XJhUNcbUb98002IoP57KUi+rwI3wHS3gd9pSgfC9KYOysbWH44R9ymuULK8555i@nongnu.org
X-Gm-Message-State: AOJu0YwG3Cvcw8qFQPVPlb4bdGCwkP6TBFuTjCQsv0ledP/aJBZAKMvu
 qztIO20O//r6Hr3lTdsZACimf1G70BdkoTvm+UdEryEYlKCrqUve9HFg+3xpL2g=
X-Google-Smtp-Source: AGHT+IHu0UvEHGq68tnqyRSx7/PCHV1M9nQcfUSzYpgsRjZQQoCbEos+f2TlDt3vJlQdnzfhpiCbBA==
X-Received: by 2002:a05:6402:42d5:b0:5c4:64e6:55a5 with SMTP id
 4fb4d7f45d1cf-5c464e65ac1mr4456757a12.13.1726980969290; 
 Sat, 21 Sep 2024 21:56:09 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c46302d647sm2807875a12.32.2024.09.21.21.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2024 21:56:09 -0700 (PDT)
Message-ID: <d8bde67a-8d06-4502-8650-286886b060c4@linaro.org>
Date: Sun, 22 Sep 2024 06:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxvx/stxvx facility check
To: Ilya Leoshkevich <iii@linux.ibm.com>, Claudio Fontana <cfontana@suse.de>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240911141651.6914-1-farosas@suse.de>
 <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
 <bcdc7a95-09de-4a2e-a45c-aa4a539afc06@suse.de>
 <b9231ac0-d4b7-4565-b2aa-5ceff3a7e672@suse.de>
 <d0c4fff589298c113d1eb43de87e7f1fb0fb18c9.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d0c4fff589298c113d1eb43de87e7f1fb0fb18c9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 9/20/24 11:24, Ilya Leoshkevich wrote:
> On Thu, 2024-09-19 at 13:36 +0200, Claudio Fontana wrote:
>> ping, adding Richard.
>>
>> We will need to include this downstream because of the breakage its
>> lack causes.
>> It is already reviewed by me, but some TCG maintainer indicating it
>> will be included in some queue would help,
>>
>> Thanks,
>>
>> Claudio
>>
>> On 9/18/24 17:11, Claudio Fontana wrote:
>>> Adding Ilya FYI.
>>>
>>> Ciao,
>>>
>>> Claudio
>>>
>>> On 9/11/24 18:19, Claudio Fontana wrote:
>>>> On 9/11/24 16:16, Fabiano Rosas wrote:
>>>>> The XT check for the lxvx/stxvx instructions is currently
>>>>> inverted. This was introduced during the move to decodetree.
>>>>>
>>>>>  From the ISA:
>>>>>    Chapter 7. Vector-Scalar Extension Facility
>>>>>    Load VSX Vector Indexed X-form
>>>>>
>>>>>    lxvx XT,RA,RB
>>>>>    if TX=0 & MSR.VSX=0 then VSX_Unavailable()
>>>>>    if TX=1 & MSR.VEC=0 then Vector_Unavailable()
>>>>>    ...
>>>>>    Let XT be the value 32×TX + T.
>>>>>
>>>>> The code currently does the opposite:
>>>>>
>>>>>      if (paired || a->rt >= 32) {
>>>>>          REQUIRE_VSX(ctx);
>>>>>      } else {
>>>>>          REQUIRE_VECTOR(ctx);
>>>>>      }
>>>>>
>>>>> This was already fixed for lxv/stxv at commit "2cc0e449d1
>>>>> (target/ppc:
>>>>> Fix lxv/stxv MSR facility check)", but the indexed forms were
>>>>> missed.
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from
>>>>> legacy to decodtree")
>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> ---
>>>>>   target/ppc/translate/vsx-impl.c.inc | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/target/ppc/translate/vsx-impl.c.inc
>>>>> b/target/ppc/translate/vsx-impl.c.inc
>>>>> index 40a87ddc4a..a869f30e86 100644
>>>>> --- a/target/ppc/translate/vsx-impl.c.inc
>>>>> +++ b/target/ppc/translate/vsx-impl.c.inc
>>>>> @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext
>>>>> *ctx, arg_PLS_D *a,
>>>>>   
>>>>>   static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool
>>>>> store, bool paired)
>>>>>   {
>>>>> -    if (paired || a->rt >= 32) {
>>>>> +    if (paired || a->rt < 32) {
>>>>>           REQUIRE_VSX(ctx);
>>>>>       } else {
>>>>>           REQUIRE_VECTOR(ctx);
>>>>
>>>> Reviewed-by: Claudio Fontana <cfontana@suse.de>
> 
> FWIW
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> But I'm not a maintainer, I guess Richard will need to pick it up.

Queued, thanks.

r~


