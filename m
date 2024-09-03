Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89158CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUG5-0001ps-Jp; Tue, 03 Sep 2024 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1slUG3-0001jw-W1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:11:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1slUG1-0000Nq-Lf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:11:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so1735164f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725372703; x=1725977503;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OR0Kzki753OaWT3b3cPZx5BnYpx6EmwagVBWAchSHz4=;
 b=XHeK84TR9ve5/RRvl0jkoLCUcA2FzbPE1RAzTGFxieTtTOeZVyUWIfCDM8amnJJ736
 isQlsxJ2VfucGmu4H//2syMLzVjGre3Uv5P/4J+KcU6n8AYSDKWIj4zS3AMR4mk9RvIv
 c0qH0BMFKNETCbihXk9C29jZyFOPKUSH9yBo+BTyJozLam9oifgFXMOyMQoLmXq7oN9+
 5eFZ8CGsaAZ5uY2ZtQUH1pU2LQjrm8oSkJJgT/lWXzmTv9lMlOolN02OuwrqAQaXR5oj
 4u1hNdB79WruuelO3ct6MpaVuERt/dIgjxGgE+SdKx5Uz5SSkFLG6KwAjf8BiMEVf2hr
 zesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372703; x=1725977503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OR0Kzki753OaWT3b3cPZx5BnYpx6EmwagVBWAchSHz4=;
 b=RAbzL1jyaEN83jQ/shmCqxyolQmUjg+XoZHqnUupWgT0cn/F+ghdgDsQWUZOBowgYZ
 8x698+4nTKSZ+s4bTgXF/MVR6LTUKJB/m2MreMT8GbKkh1Bqz8aMPkLb2HTQhktDIJPH
 cyAFFqlxppzFfgDzMLPJ7nnm9rG+XvYC3QgFjGg6wDFTUcqVrMBNcGaV7vxYuIceV3jO
 2xhEF+COYztGrYR3V76f3fx2YFDnkmC9a+aIm10aGfNYSWCNXujhyqNM21uPGA0I9AgZ
 jxxxxGG+8SDVs8veJ4cIIlpgpX9jnlDBVSG7+2wzpoUrsZ+w1epHh9SJeHYxzCTz4PSA
 iUFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn2iei+1k9nx0JiVcf33kfvfPAIYzCgxG9pIr3eTlXpmWZOLL1W2LZ7tcz3fUNM6SoCRqKOK1kOrin@nongnu.org
X-Gm-Message-State: AOJu0Yzy+84CkWDPu99tfhiutCNX5x+kXDnedMCblSKUPZ/W+IE9Ezvc
 DYClJXCgDVo3AxBVe+ysCZJbpzGlnjJ57UFfTxKyVWw2h8gH2kSXZ8DIC0GDRo4si1cvTuf/m2x
 n1PU=
X-Google-Smtp-Source: AGHT+IFPTjfn2xnyuzst8PGCHkcef1qDwE5x1hwwblaiGK+bGCeIi83BTu9y1VGqKDBhW3J9+B2LIg==
X-Received: by 2002:a05:6000:1564:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-374ecc8f13cmr2805081f8f.14.1725370638490; 
 Tue, 03 Sep 2024 06:37:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a55fsm14283027f8f.10.2024.09.03.06.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:37:17 -0700 (PDT)
Message-ID: <313c9a55-4cc8-4beb-a483-c0202665b226@rivosinc.com>
Date: Tue, 3 Sep 2024 15:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
 <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
 <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
 <563f3b75-bf13-4ca7-a995-f2c8ff1b6799@rivosinc.com>
 <7e405b99-50b4-4c87-a9b6-83c90110eca5@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <7e405b99-50b4-4c87-a9b6-83c90110eca5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 03/09/2024 15:34, Philippe Mathieu-Daudé wrote:
> On 3/9/24 09:53, Clément Léger wrote:
>> On 02/09/2024 21:38, Philippe Mathieu-Daudé wrote:
>>> On 30/8/24 13:57, Clément Léger wrote:
>>>> On 30/08/2024 13:31, Michael Tokarev wrote:
>>>>> 30.08.2024 14:14, Clément Léger wrote:
>>>>>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can
>>>>>> return
>>>>>> -1. In that case we should fallback to using the OPEN_MAX define.
>>>>>> According to "man sysconf", the OPEN_MAX define should be present and
>>>>>> provided by either unistd.h and/or limits.h so include them for that
>>>>>> purpose. For other OSes, just assume a maximum of 1024 files
>>>>>> descriptors
>>>>>> as a fallback.
>>>>>>
>>>>>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>>>>>> posix")
>>>>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>
>>>>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>>>>>
>>>>>> @@ -928,6 +933,13 @@ static void
>>>>>> qemu_close_all_open_fd_fallback(const
>>>>>> int *skip, unsigned int nskip,
>>>>>>     void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>>>>>     {
>>>>>>         int open_max = sysconf(_SC_OPEN_MAX);
>>>>>> +    if (open_max == -1) {
>>>>>> +#ifdef CONFIG_DARWIN
>>>>>> +        open_max = OPEN_MAX;
>>>
>>> Missing errno check.
>>
>> man sysconf states that:
>>
>> "On error, -1 is returned and errno is set to indicate the error (for
>> example, EINVAL, indicating that name is invalid)."
>>
>> So it seems checking for -1 is enough no ? Or were you thinking about
>> something else ?
> 
> Mine (macOS 14.6) is:
> 
>  RETURN VALUES
>      If the call to sysconf() is not successful, -1 is returned and
>      errno is set appropriately.  Otherwise, if the variable is
>      associated with functionality that is not supported, -1 is
>      returned and errno is not modified.  Otherwise, the current
>      variable value is returned.

Which seems to imply the same than mine right ? -1 is always returned in
case of error and errno might or not be set. So checking for -1 seems
enough to check an error return.

> 
>  STANDARDS
>      Except for the fact that values returned by sysconf() may change
>      over the lifetime of the calling process, this function conforms
>      to IEEE Std 1003.1-1988 (“POSIX.1”).
> 
>>
>>>
>>>>>> +#else
>>>>>> +        open_max = 1024;
>>>>>> +#endif
>>>>>
>>>>> BTW, Can we PLEASE cap this to 1024 in all cases? :)
>>>>> (unrelated to this change but still).
>>>>
>>>> Hi Michael,
>>>>
>>>> Do you mean for all OSes or always using 1024 rather than using the
>>>> sysconf returned value ?
>>>
>>> Alternatively add:
>>>
>>>    long qemu_sysconf(int name, long unsupported_default);
>>>
>>> which returns value, unsupported_default if not supported, or -1.
>>
>> Acked, should this be a global function even if only used in the
>> qemu_close_all_open_fd() helper yet ?
> 
> I'm seeing a few more:
> 
> $ git grep -w sysconf | wc -l
>       35
> 
> From this list a dozen could use qemu_sysconf().

Acked.

> 
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>>>
>>>> In any case, the code now uses close_range() or /proc/self/fd and is
>>>> handling that efficiently.
>>>>
>>>> Thanks,
>>>>
>>>> Clément
>>>>
>>>>>
>>>>> /mjt
>>>>
>>>>
>>>
>>
> 


