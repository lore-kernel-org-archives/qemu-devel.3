Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD4EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 10:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzW8-0007yy-FB; Mon, 19 Aug 2024 06:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sfzW6-0007yS-VE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:21:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sfzW4-0004Hj-VA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:21:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-371afae614aso1198398f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724062894; x=1724667694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jOB+CkfTl3xcwkUejfujHd3cyz1M1rEnG15ZmoqIWJM=;
 b=vu5v1oMTki7fCnlECCu04Mv9OHq7UcJ/AYrhBsiARqMCoCRbGA+ZPm1QBuGuop5erW
 qFy0/IAmSfA/mrbTiYfB21vaARYPBMPRUJTj8CLofONozHU1Rn2ebvPrH/Ex0rAOu7NF
 b+JUb4DvQ56qBkczKrbIj+9ah6Tl0XxrPMxIXjxXU+grVbw0cftUTdI05EvisM5EUYyx
 doQMrTBcSsqWONTQh4GDZD0IsH3irBpeqm9VYLDYzDa7K2fmMNULQy2WniFCZP8yflZL
 snhJql4YGzuAubWl2cGcWH7lhRq1eqeLSyySltH35plp8wb8ZIYJ/lERR6bB4DPaYTMO
 5UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724062894; x=1724667694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOB+CkfTl3xcwkUejfujHd3cyz1M1rEnG15ZmoqIWJM=;
 b=p1dwC+mGbWsW4l6DiddjGLw6NJnxrhLFWVSpqQo5x8wWrIxr2ro5LtwPi788nZQpfC
 ntxucT3FoH4oN5QpEKGj8c1KEWsgMa23qvfS6GC8/dgx5sB1Oou1GM3vrUXZcvR7+3OG
 hRUEMXa/nDXBtuDT+x2/Sc3hssf+Yc1gOSNboGdifZ61lmKg8sB+KG3wLKuVDS+qrikn
 pdF3bwFco36QKioXM9v+1IjQDWjNGCP/5e6kFepRV4awe/IlMtoeq3pqI6MqX4VbGuuy
 okl6wG8FOsX88TP+EpTb5ufDqmeP6JHROfxiqSGKIxe5MOnoaCVKoTcA5ja+N1sCU0Gy
 Ov3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSSnOyUhb6QGWFYlS2loKyiKhum6/uBF1WOUfsqFDmJT25EhMPJ5wqjsmP32Np34h2Gqiho5JMZ4CR4It3+sRWo+W/PZ4=
X-Gm-Message-State: AOJu0YxHgl5FUmFURTPhthhYXuEWlr3FgCbJF/KtaecQJc8HpOHo0tqr
 O3A4kGjakq4SGehSegY8ZyNSPcHu6J4kWmgAG/1YZpNHC7Y1KBfug1zCiVridX4=
X-Google-Smtp-Source: AGHT+IEJnFTV3Ku3lhAwk8eDaTNU+xGbkXq8y/OJ9qDHWIb+oqK39mleAkrLlJ412zNgr38kd8FStg==
X-Received: by 2002:a5d:452b:0:b0:371:8bc4:49 with SMTP id
 ffacd0b85a97d-3719429f78emr7397886f8f.0.1724062894369; 
 Mon, 19 Aug 2024 03:21:34 -0700 (PDT)
Received: from [192.168.166.175] (83.red-95-127-94.dynamicip.rima-tde.net.
 [95.127.94.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aac62sm10090802f8f.101.2024.08.19.03.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 03:21:33 -0700 (PDT)
Message-ID: <7a0fb1db-b3d8-43ef-9eb9-2a7982ec11f5@linaro.org>
Date: Mon, 19 Aug 2024 12:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2
 job
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>
References: <20240816153747.319161-1-thuth@redhat.com>
 <8d07931c-444e-4030-ac7c-b81ad2d3bac4@linaro.org>
 <ac16ccfe-65fa-4de4-95a1-7b2d2379c893@redhat.com>
 <3abd50a8-6add-4406-ba21-ddd0c73965ed@linaro.org>
 <289cb3f1-765b-4d2d-8e31-57dd672fb765@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <289cb3f1-765b-4d2d-8e31-57dd672fb765@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/8/24 07:30, Thomas Huth wrote:
> On 16/08/2024 19.18, Philippe Mathieu-Daudé wrote:
>> On 16/8/24 18:40, Thomas Huth wrote:
>>> On 16/08/2024 18.34, Philippe Mathieu-Daudé wrote:
>>>> On 16/8/24 17:37, Thomas Huth wrote:
>>>>> The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
>>>>> likely due to some changes in the MSYS2 environment. So far nobody has
>>>>> neither a clue what's going wrong here, nor an idea how to fix this
>>>>> (in fact most QEMU developers even don't have a Windows environment
>>>>> available for properly analyzing this problem), so let's disable the
>>>>> qtests here again to get at least the test coverage for the 
>>>>> compilation
>>>>> and unit tests back to the CI.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   .gitlab-ci.d/windows.yml | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>>>>> index a83f23a786..9f3112f010 100644
>>>>> --- a/.gitlab-ci.d/windows.yml
>>>>> +++ b/.gitlab-ci.d/windows.yml
>>>>> @@ -23,6 +23,8 @@ msys2-64bit:
>>>>>       # for this job, because otherwise the build could not 
>>>>> complete within
>>>>>       # the project timeout.
>>>>>       CONFIGURE_ARGS:  --target-list=sparc-softmmu 
>>>>> --without-default-devices -Ddebug=false -Doptimization=0
>>>>> +    # The qtests are broken in the msys2 job on gitlab, so disable 
>>>>> them:
>>>>> +    TEST_ARGS: --no-suite qtest
>>>>
>>>> Then building system emulation is pointless, isn't it?
>>>
>>> We're still running the unit tests and some others.
>>
>> I tried to configure with '--disable-system' and the same tests
>> are run
> 
> ... but you lose *compile-testing* of all of the system files, so what's 
> your point? ... sorry, I don't get it?

I'm wondering why wasting resources and time on our longest job
if the produced binary doesn't run. Anyway, I'm not objecting to
your patch.

