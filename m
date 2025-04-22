Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87801C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 09:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79lv-0000kp-MI; Tue, 22 Apr 2025 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79lk-0000eJ-7Y
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 05:18:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79lg-0007ML-Hv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 05:18:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so3901489f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745313494; x=1745918294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WLncodT6X0UfEqGRRKm0DfTeBUkchSS2NhccuBqFXcM=;
 b=EdWBcfjWeTSwzK3t5CX7P+8KMNpD2eNwBPA/AIKsbHvx5dv3biFUlzaz94TgGak4ap
 sjYTQJBP/giV30bDYCONU15LGgWLdO0D+iTHMK4xPP0SNjwX7FBbW77s/9Gq7jXEfo3b
 XWYPwnCPOqFwcBF6xEpURPU7++IRMQoGMPdgcdSPFNOxD0cctGuFBfAENk/6PashPDyV
 5xts6HQepQNVxMk9Qim7dIF03dH1Sahj/ewEy5oBmNIMMfFo1EzYWezgGTAf99uh4v0e
 49z8VrXl5PDJlAwf7u5gUaMgTVuaL3JLcPLSuTa/1u0Q3/UzEedSEcByOfB56E/G4uQh
 3vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745313494; x=1745918294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WLncodT6X0UfEqGRRKm0DfTeBUkchSS2NhccuBqFXcM=;
 b=f+I1hwZoGrA07z7bgrQabYidyZ4h92UwCb9DxZuseEMiBDMOVFUzHhTSY7Y3QtUZTL
 IU6967dUbYTFxiVQMjBThw92zBpH1XADIFohmozZ8sKKylW7xbn2tajXmhW8Nvi0XezH
 DqiJVoSeEOXRSu5vwcTbdZ9NUg23uqpoRHFJOmg9cFEU7VTDpGAXYDdDIvACtEuST7VU
 uCJXqA2OcmKQc2cxSOhH3PaT2O8mPl4YjgtSVMXVwiCU0QN1T9rH/viNTnV+XRRYII3M
 wv3SSPLCtc6gpWqDCT6+bXpvKebTubLfiVReEk0R6SP2ZBN/jfAKpG6k6Wne4cBwRDrd
 25/A==
X-Gm-Message-State: AOJu0Yz11P4f+jr7CBH43Sb+KxGObo72oqwPL22rUJzZDDuITBhD8RDj
 lGUudlvaXjtN9CxTO82vF6q2CLS2kP3OQgTqMg/1tujkkM9Ulz+qPv+rF2FE+K0=
X-Gm-Gg: ASbGncufDYyz+Ah8dVZlo3F393ugukssF43d84vrVD5NErhUUJ9T0uILcoa/6Zy7k4R
 Xs3ZkaKsGvCNlv2Vl4LdGH94Kr+D0Kzx4rgBuNKAju9OdgXGdoE0x6g21QawhhtSQbqenHiUW4z
 phMGMVDEp9eX9i4skTgNXmS8rO2a74246da48TPPsgHLYbuEkvDjOcYBc/OIe5eQtjruQHjISU4
 2vEOSv9PYy/cPg28qnYk+jcAfUbgOpe98q7M/p+jaKTJYgMOgGXUjJY0FA0qLL0CxWPZUKcChu5
 KK/3alIjOV/i8Mi8JKc/EoG81pIvvACJwaXBRfNDWflKZRxg8dzkewunZaQNDtIk4IOC1rbmJ/h
 NQRO+0O4V
X-Google-Smtp-Source: AGHT+IF/OJVLU7n+jeZDxNEONNyw84wOV6rnWGuQqZjTcRl+sxuYRRavkZd+c0hukhMtQF3POTvWxg==
X-Received: by 2002:a05:6000:250f:b0:39c:266c:400a with SMTP id
 ffacd0b85a97d-39efbb021eamr11519777f8f.50.1745313494542; 
 Tue, 22 Apr 2025 02:18:14 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433191sm14764504f8f.31.2025.04.22.02.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 02:18:14 -0700 (PDT)
Message-ID: <a84a1393-9ff7-45e9-b365-63075ca25e81@linaro.org>
Date: Tue, 22 Apr 2025 11:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org> <878qnsagfo.fsf@pond.sub.org>
 <b846a12d-bbe3-4a88-aecd-b62cd57d297d@linaro.org>
 <877c3c7ead.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877c3c7ead.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/4/25 11:10, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 22/4/25 07:55, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> The QAPI-generated 'TargetInfo' structure name is only used
>>>> in a single file. We want to heavily use another structure
>>>> similarly named. Rename the QAPI one, since structure names
>>>> are not part of the public API.
>>>>
>>>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    qapi/machine.json          | 12 ++++++------
>>>>    hw/core/machine-qmp-cmds.c |  4 ++--
>>>>    2 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index a6b8795b09e..3246212f048 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -275,15 +275,15 @@
>>>>   { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>>>>    
>>>>   ##
>>>> -# @TargetInfo:
>>>> +# @BinaryTargetInfo:
>>>>   #
>>>> -# Information describing the QEMU target.
>>>> +# Information describing the QEMU binary target.
>>>
>>> What's "the QEMU binary target"?  The QEMU binary's target?
>>
>> For me 'qemu-system-aarch64' is a QEMU binary,
> 
> Makes sense to me.
> 
>>                                                 but for Pierrick and
>> Richard it is the QEMU target,
> 
> Make about as much sense to me as calling my /usr/bin/gcc "the GNU C
> compiler target", i.e. none.  It's the GNU C compiler targeting x86_64.
> 
>>                                 so I merged both names ¯\_(ツ)_/¯
> 
> If it gets your patch merged...
> 
>> This structure describes the static target configuration built into
>> a binary, i.e. TARGET_NAME=aarch64, TARGET_BIG_ENDIAN=false.
>>
>> For the forthcoming single/heterogeneous binary, we don't have a
>> particular restricted configuration in the binary.
>>
>> What about "Information describing the QEMU target configuration
>> built in a binary."?
> 
> That's better.  Here's my try: "Information on the target configuration
> built into the QEMU binary."
> 
>>>   From the QMP user's point of view, perhaps "the QEMU process's target"
>>> would make more sense.
>>
>> So maybe ProcessTargetInfo is a better structure name.
> 
> QemuTargetInfo would sidestep binary vs. process.

Thank you!

> 
>> For heterogeneous target I suppose we'll return SYS_EMU_TARGET_HETERO
>> and we'll provide new QMP commands, possibly returning array of
>> ProcessTargetInfo.
> 
> [...]
> 


