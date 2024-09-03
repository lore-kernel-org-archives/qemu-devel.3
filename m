Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B83CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slV3j-0008Q8-Od; Tue, 03 Sep 2024 11:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slV3X-0007fH-Lg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:03:02 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slV3R-0008OU-Vq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:02:55 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f3f68dd44bso57786571fa.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375766; x=1725980566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9sJDSeP2xm/QhbbN6C+oU0hR2HMrMaxbBuidjug6c7c=;
 b=wZHU+05bWrHEXbcj4A0/yUbYAMspejF8IGIoRPokZYTtr1J2b6pg3NyLi4ybuZoEnF
 DYw65V2RnYEGiEzwD2ALxTmkrUsNK17LQ8qcBk4GOWoZssZPo4VqpUfy2/GjVRPNScoC
 n4yEYsC64FqnkVGTq8MXDmhneuk7ifme2l0j3xaBZOIyfPiVvW9rW+B2LtRdPX/MAMmW
 vZXCL5b2xmPWW/MHf0Jxsrijyv2wkjEk+6tw8iiCPYyDMnsA/TC2Hnn/PyvB4+PTKTsd
 I6UTex6s9ojf49afq89ZGEeZ1fixhmBYU7nAzL1WR65HsegWljhYPENcqeGC+OY4EuWr
 s6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375766; x=1725980566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sJDSeP2xm/QhbbN6C+oU0hR2HMrMaxbBuidjug6c7c=;
 b=r7+AtETzWhQVAYa6g6Cy0n0nAttvu5h23nvBv9TGxtgCYcC9v1kp2vKK3zyq1AUOey
 G6oRz71vlRrsR7Pr+NM4qU1KOIud6szJnYXDWT/dsMaYhqM4Jge3HhQ3wuYk0dCvy/zu
 eU8ak1nj4fZqGACouzA8aBBcQ5taeha+1vw8RGYPA3VVbdjS1NVRpyHOgL+zxhxxIvNY
 lwQ8qtuE0dZn6KA/X7bFvJKC19Woaf4mK6evzf5OKs9NmqQ5R5sr+BXaHHj1iVjf7ed1
 Yk7C/ZDZ8XbKRHysVujDy6fPoNrcsmEoXdghb/Bw6ettuass6pQpeNwYlwhQruAu0EP/
 RGbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvImV/vdOyeNymHWV6meW7BBLbslSAgibX2DyFlG4UENr011YIi8Z6tMFUaj4vGcNzckurMRdWgtDO@nongnu.org
X-Gm-Message-State: AOJu0YyazZ0lf76HfVAmbZOWun28wgVtNrRqwQ2WIFihua5GCQS1La13
 ns7J8S5nASwMHmPUTcj4JgZRa4YCBcLsJLTfq5uMCleCsCqGZKUWp60syszvEy4=
X-Google-Smtp-Source: AGHT+IGrdQM3gTGMOoe5Ylo4U3xoLDvXoXQcrEhO3jy5THvQdRHjJ73KGAAclx2B03XhGOL9pUyYmg==
X-Received: by 2002:a05:651c:544:b0:2ef:2f37:345b with SMTP id
 38308e7fff4ca-2f61e0a514emr97871931fa.30.1725375765631; 
 Tue, 03 Sep 2024 08:02:45 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba641dad0sm209842885e9.30.2024.09.03.08.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 08:02:45 -0700 (PDT)
Message-ID: <b9b574e7-11de-4f04-a84f-40b9ffac986c@linaro.org>
Date: Tue, 3 Sep 2024 17:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
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
 <313c9a55-4cc8-4beb-a483-c0202665b226@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <313c9a55-4cc8-4beb-a483-c0202665b226@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 3/9/24 15:37, Clément Léger wrote:
> On 03/09/2024 15:34, Philippe Mathieu-Daudé wrote:
>> On 3/9/24 09:53, Clément Léger wrote:
>>> On 02/09/2024 21:38, Philippe Mathieu-Daudé wrote:
>>>> On 30/8/24 13:57, Clément Léger wrote:
>>>>> On 30/08/2024 13:31, Michael Tokarev wrote:
>>>>>> 30.08.2024 14:14, Clément Léger wrote:
>>>>>>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can
>>>>>>> return
>>>>>>> -1. In that case we should fallback to using the OPEN_MAX define.
>>>>>>> According to "man sysconf", the OPEN_MAX define should be present and
>>>>>>> provided by either unistd.h and/or limits.h so include them for that
>>>>>>> purpose. For other OSes, just assume a maximum of 1024 files
>>>>>>> descriptors
>>>>>>> as a fallback.
>>>>>>>
>>>>>>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>>>>>>> posix")
>>>>>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>>
>>>>>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>>>>>>
>>>>>>> @@ -928,6 +933,13 @@ static void
>>>>>>> qemu_close_all_open_fd_fallback(const
>>>>>>> int *skip, unsigned int nskip,
>>>>>>>      void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>>>>>>      {
>>>>>>>          int open_max = sysconf(_SC_OPEN_MAX);
>>>>>>> +    if (open_max == -1) {
>>>>>>> +#ifdef CONFIG_DARWIN
>>>>>>> +        open_max = OPEN_MAX;
>>>>
>>>> Missing errno check.
>>>
>>> man sysconf states that:
>>>
>>> "On error, -1 is returned and errno is set to indicate the error (for
>>> example, EINVAL, indicating that name is invalid)."
>>>
>>> So it seems checking for -1 is enough no ? Or were you thinking about
>>> something else ?
>>
>> Mine (macOS 14.6) is:
>>
>>   RETURN VALUES
>>       If the call to sysconf() is not successful, -1 is returned and
>>       errno is set appropriately.  Otherwise, if the variable is
>>       associated with functionality that is not supported, -1 is
>>       returned and errno is not modified.  Otherwise, the current
>>       variable value is returned.
> 
> Which seems to imply the same than mine right ? -1 is always returned in
> case of error and errno might or not be set. So checking for -1 seems
> enough to check an error return.

Yes but we can check for the unsupported case. Something like:

     long qemu_sysconf(int name, long unsupported_default)
     {
         int current_errno = errno;
         long retval;

         retval = sysconf(name);
         if (retval == -1) {
             if (errno == current_errno) {
                 return unsupported_default;
             }
             perror("sysconf");
             return -1;
         }
         return retval;
     }

(untested)

> 
>>
>>   STANDARDS
>>       Except for the fact that values returned by sysconf() may change
>>       over the lifetime of the calling process, this function conforms
>>       to IEEE Std 1003.1-1988 (“POSIX.1”).
>>
>>>
>>>>
>>>>>>> +#else
>>>>>>> +        open_max = 1024;
>>>>>>> +#endif
>>>>>>
>>>>>> BTW, Can we PLEASE cap this to 1024 in all cases? :)
>>>>>> (unrelated to this change but still).
>>>>>
>>>>> Hi Michael,
>>>>>
>>>>> Do you mean for all OSes or always using 1024 rather than using the
>>>>> sysconf returned value ?
>>>>
>>>> Alternatively add:
>>>>
>>>>     long qemu_sysconf(int name, long unsupported_default);
>>>>
>>>> which returns value, unsupported_default if not supported, or -1.
>>>
>>> Acked, should this be a global function even if only used in the
>>> qemu_close_all_open_fd() helper yet ?
>>
>> I'm seeing a few more:
>>
>> $ git grep -w sysconf | wc -l
>>        35
>>
>>  From this list a dozen could use qemu_sysconf().
> 
> Acked.
> 
>>
>>>
>>> Thanks,
>>>
>>> Clément


