Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B04C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruxuN-0005S4-F5; Thu, 11 Apr 2024 13:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruxuL-0005Rg-61
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:08:17 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruxuJ-0003EC-7a
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:08:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so67191fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712855292; x=1713460092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hbOI/YT9E0aF1zHmlZtEIv3EiGt2ZE3bgpvsZg56Yyw=;
 b=eWDEtToF0WSbLlTW404ZU849lxFCFFbA26iwFvt/LUVaNQZI1tCUaizFc19bfURDwq
 OqWTR/jDlIvQtdqt8eNO3NUjAR6aojL3VP1QIjbvR9tyWD5tsfNtnq4uV8FKiQe8hvrU
 EpmSM8K5ff/A1lRSpcTFVeeNU/T1KQamXz51BSfQoMDARI7dok1bsq3ruDqSdiQynweR
 oQaE4qKWKctVGYFdj5HzYexV5puGxV7ilOALxE9VuaB0RF7Lb2UiiTDMPSAVhiWFYzDV
 fE2sanVo5vt02UJ8bR6g7sArkeG5kATeu5qQyDSI5R5KosVuBfDAJKBd9GLtAeSmQhcy
 R0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712855292; x=1713460092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hbOI/YT9E0aF1zHmlZtEIv3EiGt2ZE3bgpvsZg56Yyw=;
 b=NaOdI5rHjs+yGD842C0MGI+4eyOhH0eWvOOhOKfPcNLTpvegov7hUTooxUJsM+7D8Y
 uktbOY12if9s4FwMF0SxwUAQ6Nz3bmulBy6dH3d16uQLuNIQkjfiQLkBRw63vzyQ0tk9
 g1sxZ/NBBPyOjafVcMxoE+q//Avw+9k6GNF4c/HZc/MX0WWmcmWr0e30nuuqP+1/pjql
 gvHizpI9EY9EuLvlLV/Qli1962KdgKUQEZntDoQ1fcqx+AEC5dHVUXOiDTbljr8SyIcu
 lE2zIPpZGlJ7mIfbs3Qj9G0ec47As0TibuRb6k2aWO5WAveKUgb9e5nj2aPBx80mENRx
 Vk1w==
X-Gm-Message-State: AOJu0Yw+4xNq1RIOM3/ljYxehy889ia1U6Ihbyb11tdZr9/YFJ1l3JFK
 6l9tHzAi3eOoYaG1DE+AnCSi3ybAHqsl44TlSjM52misfQHaytNGSbzzUZl7viI=
X-Google-Smtp-Source: AGHT+IHD3oRnkxHdd2dpsFAsu2CmiC/Ye4m/10s4Z218aT2TDofJJdRMubznXEq+4WZiVcpUsaiAQQ==
X-Received: by 2002:a05:651c:502:b0:2d8:5e35:6076 with SMTP id
 o2-20020a05651c050200b002d85e356076mr184870ljp.51.1712855292360; 
 Thu, 11 Apr 2024 10:08:12 -0700 (PDT)
Received: from [192.168.120.175] (31.red-95-127-88.dynamicip.rima-tde.net.
 [95.127.88.31]) by smtp.gmail.com with ESMTPSA id
 fm24-20020a05600c0c1800b004166b960469sm2917244wmb.38.2024.04.11.10.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 10:08:11 -0700 (PDT)
Message-ID: <fde8cad1-6308-4890-8054-534bbbde12b5@linaro.org>
Date: Thu, 11 Apr 2024 19:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: fix use of -j without an argument
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, martin@geanix.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <fb8c5aa0-d412-4ac0-b77b-64816d72a996@linaro.org>
 <20240411153804.3849645-1-quic_mathbern@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240411153804.3849645-1-quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 11/4/24 17:38, Matheus Tavares Bernardino wrote:
> Hi, Philippe
> 
> On Thu, 11 Apr 2024 17:29:58 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org> wrote:
>>
>> Hi Matheus,
>>
>> On 11/4/24 17:09, Matheus Tavares Bernardino wrote:
>>> Our Makefile massages the given make arguments to invoke ninja
>>> accordingly. One key difference is that ninja will parallelize by
>>> default, whereas make only does so with -j<n> or -j. The make man page
>>> says that "if the -j option is given without an argument, make will not
>>> limit the number of jobs that can run simultaneously". We use to support
>>> that by replacing -j with "" (empty string) when calling ninja, so that
>>> it would do its auto-parallelization based on the number of CPU cores.
>>>
>>> This was accidentally broken at d1ce2cc95b (Makefile: preserve
>>> --jobserver-auth argument when calling ninja, 2024-04-02),
>>> causing `make -j` to fail:
>>>
>>> $ make -j V=1
>>>     /usr/bin/ninja -v   -j -d keepdepfile all | cat
>>>     make  -C contrib/plugins/ V="1" TARGET_DIR="contrib/plugins/" all
>>>     ninja: fatal: invalid -j parameter
>>>     make: *** [Makefile:161: run-ninja] Error
>>>
>>> Let's fix that and indent the touched code for better readability.
>>>
>>> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>>> ---
>>>    Makefile | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 183756018f..d299c14dab 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -142,8 +142,12 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
>>>    MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
>>>    MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
>>>    NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
>>> -        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
>>> -        -d keepdepfile
>>> +        $(if $(filter -j, $(MAKEFLAGS)) \
>>> +	     ,, \
>>> +	     $(or \
>>> +	          $(filter -l% -j%, $(MAKEFLAGS)), \
>>> +	          $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
>>> +        ) -d keepdepfile
>>>    ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
>>>    ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
>>>    
>>
>> Apparently Martin sent the same patch (although not as nicely
>> indented) and Paolo queued it:
>> https://lore.kernel.org/qemu-devel/20240402081738.1051560-1-martin@geanix.com/
> 
> Actually, this patch is a follow-up to that one, fixing a feature that was
> accidentally broken.

Oops sorry I missed that, I was not expecting this patch to be merged
in 9.0 :/

