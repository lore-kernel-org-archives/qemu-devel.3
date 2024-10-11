Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26410D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ90-0006t4-0e; Fri, 11 Oct 2024 13:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szJ4e-0000wP-06
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:05:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szHJ7-0004Qn-7v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:11:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b5affde14so12828105ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728659515; x=1729264315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmGOSEDjWEDUD0kIOu9J70N/92NLEceMUdh2BlpenSQ=;
 b=l4zxGXhHK3GY+wxNSmfY+iQdOqHAjOG6u5UyjZwsFtpKvUyg8SNaDYNjLYe1tYFyYb
 WtUrelsTiTycDNCE/9vqhkBZBmPwAvw7wjB7y2V4s2sw4reawVHs0mOE3mguQ9N2vjDX
 KAOhFoHbiglRL0siNzesTb9FRbTj978shV4PjgU6nNouSV4PRUEIkv4EsDR5Mj0QA46y
 ObCF0t1iRxMiEfJV2Sju7tOCbT3gYE1QR4mvS8UN2jHhEtIeGWA1d0lyYvAEzEizFNAa
 VEwm1M4TaUJnTyy2YuwP0vIVc2ccpUqV/9LO2o8dzLc0gcKIAJlZrfuD2ZGn/9dC/wr0
 A9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728659515; x=1729264315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmGOSEDjWEDUD0kIOu9J70N/92NLEceMUdh2BlpenSQ=;
 b=w/14U6l0GuuuGdM33ALn0Ku9DZ7Jfc5pa4g0/0p6EpoDgS6uIx1GVP0nu7pDJUtri6
 0znui8NoSUmswQJ/mTRPrJbaBsJIyu7xoOzWV724vkfOrvngBVUhOMAqkwW2s+eIC81I
 zsWHlC2O45n/H8ru5vA199tIIM87xI3DNRVJ6NeLQvb4SfqpegUhLrh9XX0Vk1opGGv2
 lEHzTXPEFldg06rv8XyqyaF2vjFYB/Bq4FJv/zlOjT9mGcKRhnr7MXDZv/D+pSzHQL9Q
 lfXPIB/r3ZfSQLS2rBa4x7wftp6cLBy09O/K1OKsXgo6Xa8uyUCHtlvP/IJ/4tBrTGbl
 3Eqw==
X-Gm-Message-State: AOJu0YxPEEkZC9l3MM2OyyvipSMVnhLRl4GzrucJeoFagANQyP9gG1oj
 wKJddvZEZTVjvhkxwmsiWw0h3RZkRs4qIP7SxP3utVQWpM4Bh+PUTyIOKJKKt5k=
X-Google-Smtp-Source: AGHT+IGznrzAAuhJforDtc0j/lSBF2rM3N0H2yneKbZhamT/iyk66hWUg/kjjW135ehI61s2t1hwWg==
X-Received: by 2002:a17:902:d2d1:b0:20b:9f77:e8ba with SMTP id
 d9443c01a7336-20ca16cc34fmr46950805ad.56.1728659515490; 
 Fri, 11 Oct 2024 08:11:55 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0e751fsm24426735ad.139.2024.10.11.08.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 08:11:54 -0700 (PDT)
Message-ID: <17b2cfbf-3434-4e30-9c46-47406dc1de4b@linaro.org>
Date: Fri, 11 Oct 2024 12:11:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of bounds
 property values
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, xieyongji@bytedance.com, kwolf@redhat.com,
 hreitz@redhat.com, Coiby.Xu@gmail.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-6-armbru@redhat.com>
 <eed14342-3b79-450c-a617-533d3256a241@linaro.org>
 <878quvg3p6.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878quvg3p6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 16:25, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 10/10/24 12:01, Markus Armbruster wrote:
>>> The error message for a "stepping" value that is out of bounds is a
>>> bit odd:
>>>       $ qemu-system-x86_64 -cpu qemu64,stepping=16
>>>       qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.stepping=16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)
>>> The "can't apply global" part is an unfortunate artifact of -cpu's
>>> implementation.  Left for another day.
>>> The remainder feels overly verbose.  Change it to
>>>       qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=16: parameter 'stepping' can be at most 15
>>> Likewise for "family", "model", and "tsc-frequency".
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    target/i386/cpu.c | 20 +++++++++-----------
>>>    1 file changed, 9 insertions(+), 11 deletions(-)
>>
>>
>>> @@ -5623,16 +5622,15 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
>>>                                       void *opaque, Error **errp)
>>>    {
>>>        X86CPU *cpu = X86_CPU(obj);
>>> -    const int64_t min = 0;
>>>        const int64_t max = INT64_MAX;
>>>        int64_t value;
>>>          if (!visit_type_int(v, name, &value, errp)) {
>>>            return;
>>>        }
>>> -    if (value < min || value > max) {
>>> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
>>> -                   name ? name : "null", value, min, max);
>>> +    if (value < 0 || value > max) {
>>> +        error_setg(errp, "parameter '%s' can be at most %" PRId64,
>>> +                   name ? name : "null", max);
>>
>> Confusing:
>>
>>      qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=-1: parameter 'stepping' can be at most 15
> 
> For better or worse, visit_type_uint64() with the string input visitor
> parses -1 modulo 2^64, i.e. as 2^64-1, just like strtoul() & friends.

Would "parameter 'stepping' must be between 1 and 15" be clearer?

