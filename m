Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F17CD37AB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 17:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slXlB-0001uD-A7; Tue, 03 Sep 2024 13:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slXl7-0001qR-Un
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:56:07 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slXl6-0007wC-6U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:56:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c1963cb6so1959555f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725386162; x=1725990962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WdjLJKg2Ic45CVk94s71tKPC0FGEyFur/YHotqbniPg=;
 b=o+yUDYU3aveuAKO6ooQizHi3wbelczw52TCAQ8ifAilt8CRNuXvTKrQ7sAmtN+EYAQ
 nYvX0En/WYxab5zlZZq/hkArgJlCXV1iEGEDfSBXCrOApVS/EAvDermvyntRjjUYnsnl
 Lm9piX4BLUn5cxUaC4Ub/kMlGTz8BUD2N3boQEZprfzdOa4G3Grgc7VgUjzYrhIUP9MH
 NQ8G2qc7grhrtp9tnk3PseyvV3szBmOz27Iko3Csr6l/RGwZyqHNEcJc4z+0EK4NIHhE
 x3mvvDjK30kfiG9GnlePE1qnc7XX7TyqHzoyFR2BjIg/arc/zIKFS5kTVYljY8v7QsMW
 X0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725386162; x=1725990962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdjLJKg2Ic45CVk94s71tKPC0FGEyFur/YHotqbniPg=;
 b=lPTg6kcogda0V1PMHCIcrB70RONtPz9wJZf2RfFz08fuC1bBjgSt336k5TnzllOHpp
 iM0ChpKjW0Ya2mfEbQ4j77wZH4SRYZ2F6pYO7M1SaXHn7pjRYvJYUNKtP+Y217AjZOrb
 LVj4QBKhJj79ekPSkJbD4ghW2E5xlOE4RpijQUr5gLCAwy13K5xUTl3CTdPeWKPEAkNC
 9sBxtZTmVkgP2+ZRKBMBco0pmb/OsNuwDna3xjO0d6zorggbxIMnhSmjeTrj7ZQxj9vv
 TFsX4icwaYgnqGeMSYizSdAvcDz2iKV/ILmf1xBJMKQbRnEpwIvYVrlwfhug/APiTO/7
 oShg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWSLULm0TQjv0Tm9GA1WCzaJQII86UEPSMa+kXM9N+xWS9caQhn7wF7nZLJaMxdn8rYcUZ1hD9BIty@nongnu.org
X-Gm-Message-State: AOJu0YxBTFt30KiphNay5S7G3GvV+iPJa8P/0Cge0X74qx4TBQRxjiOV
 vakHaXz81Rak8D5TbN9zQgtCRSmn7jmcR+iog3SJ/DGFofnoT7Hl7HptwLjX2ug=
X-Google-Smtp-Source: AGHT+IHABg9lT9FvUlDjsBbYq86Ui16QaqC8brIJL+cBisV3pwrDzuWsJydlAeBw1rHECwXsQ/WR9A==
X-Received: by 2002:adf:e604:0:b0:374:ca43:abff with SMTP id
 ffacd0b85a97d-374ca43ada7mr4876184f8f.26.1725386162398; 
 Tue, 03 Sep 2024 10:56:02 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bb1ea80csm10692788f8f.73.2024.09.03.10.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 10:56:01 -0700 (PDT)
Message-ID: <c4d65b6b-ed7e-46c8-8c4b-fc54e53169f1@linaro.org>
Date: Tue, 3 Sep 2024 19:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
 <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
 <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
 <563f3b75-bf13-4ca7-a995-f2c8ff1b6799@rivosinc.com>
 <7e405b99-50b4-4c87-a9b6-83c90110eca5@linaro.org>
 <313c9a55-4cc8-4beb-a483-c0202665b226@rivosinc.com>
 <b9b574e7-11de-4f04-a84f-40b9ffac986c@linaro.org>
 <ZtcpbNx0SAzzW0Ta@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZtcpbNx0SAzzW0Ta@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/9/24 17:21, Daniel P. Berrangé wrote:
> On Tue, Sep 03, 2024 at 05:02:44PM +0200, Philippe Mathieu-Daudé wrote:
>> On 3/9/24 15:37, Clément Léger wrote:
>>> On 03/09/2024 15:34, Philippe Mathieu-Daudé wrote:
>>>> On 3/9/24 09:53, Clément Léger wrote:
>>>>> On 02/09/2024 21:38, Philippe Mathieu-Daudé wrote:
>>>>>> On 30/8/24 13:57, Clément Léger wrote:
>>>>>>> On 30/08/2024 13:31, Michael Tokarev wrote:
>>>>>>>> 30.08.2024 14:14, Clément Léger wrote:
>>>>>>>>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can
>>>>>>>>> return
>>>>>>>>> -1. In that case we should fallback to using the OPEN_MAX define.
>>>>>>>>> According to "man sysconf", the OPEN_MAX define should be present and
>>>>>>>>> provided by either unistd.h and/or limits.h so include them for that
>>>>>>>>> purpose. For other OSes, just assume a maximum of 1024 files
>>>>>>>>> descriptors
>>>>>>>>> as a fallback.
>>>>>>>>>
>>>>>>>>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>>>>>>>>> posix")
>>>>>>>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>>>>
>>>>>>>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>>>>>>>>
>>>>>>>>> @@ -928,6 +933,13 @@ static void
>>>>>>>>> qemu_close_all_open_fd_fallback(const
>>>>>>>>> int *skip, unsigned int nskip,
>>>>>>>>>       void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>>>>>>>>       {
>>>>>>>>>           int open_max = sysconf(_SC_OPEN_MAX);
>>>>>>>>> +    if (open_max == -1) {
>>>>>>>>> +#ifdef CONFIG_DARWIN
>>>>>>>>> +        open_max = OPEN_MAX;
>>>>>>
>>>>>> Missing errno check.
>>>>>
>>>>> man sysconf states that:
>>>>>
>>>>> "On error, -1 is returned and errno is set to indicate the error (for
>>>>> example, EINVAL, indicating that name is invalid)."
>>>>>
>>>>> So it seems checking for -1 is enough no ? Or were you thinking about
>>>>> something else ?
>>>>
>>>> Mine (macOS 14.6) is:
>>>>
>>>>    RETURN VALUES
>>>>        If the call to sysconf() is not successful, -1 is returned and
>>>>        errno is set appropriately.  Otherwise, if the variable is
>>>>        associated with functionality that is not supported, -1 is
>>>>        returned and errno is not modified.  Otherwise, the current
>>>>        variable value is returned.
>>>
>>> Which seems to imply the same than mine right ? -1 is always returned in
>>> case of error and errno might or not be set. So checking for -1 seems
>>> enough to check an error return.
>>
>> Yes but we can check for the unsupported case. Something like:
>>
>>      long qemu_sysconf(int name, long unsupported_default)
>>      {
>>          int current_errno = errno;
>>          long retval;
>>
>>          retval = sysconf(name);
>>          if (retval == -1) {
>>              if (errno == current_errno) {
>>                  return unsupported_default;
>>              }
>>              perror("sysconf");
>>              return -1;
>>          }
>>          return retval;
>>      }
> 
> That looks uncessarily complicated, and IMHO makes it less
> portable. eg consider macOS behaviour:
> 
>   "if the variable is associated with functionality that is
>    not supported, -1 is returned and errno is not modified"
> 
> vs Linux documented behaviour:
> 
>    "If name corresponds to a maximum or minimum limit, and
>     that limit is indeterminate, -1 is returned and errno
>     is  not  changed."
> 
> IMHO we should do what Clément already suggested and set a
> default anytime retval == -1, and ignore errno. There is
> no user benefit from turning errnos into a fatal error
> via perror()

Fine by me.

