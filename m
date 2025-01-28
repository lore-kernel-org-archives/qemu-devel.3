Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4314EC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciQy-0005S8-5l; Tue, 28 Jan 2025 05:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciQw-0005R0-Qd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:03:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciQu-0002wO-Pg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:03:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso36022585e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738058579; x=1738663379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z60qyWGx0+ylMj6+7TAkLRu+ztrWeM7Qx7ZmZD7edMk=;
 b=uAlg0Om/h/0LAmJqJZKv4gG/1hlECAnFuSVhsKhc+sG6yjuHPsWE3wKsJzO4HhbJqR
 zcLfDvejlw9CzN3ccTxHID7to/CBr+PC+nqrk3HU0EIB6dt3B0Ero95MvMWf7Rba+CuG
 QODBOSjEL4fIrclCVU27Sq6TQWp7hpOneq+ybu98jrP2JEQP17AaM7PS5+iYhdWehTTv
 LKhC9HfSwJzQhNhbnasuqxxdvxI0cyA6XAbfW5VJTEPaK8vYrcardG0ha5JYdaONeGPX
 +J73LS/vdfVAUcnKDHLA70Vu3wBQ4Q4EG3oG4CjS0CMcNaZo6ujgiMVrkVjsxHevZGhM
 8Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738058579; x=1738663379;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z60qyWGx0+ylMj6+7TAkLRu+ztrWeM7Qx7ZmZD7edMk=;
 b=Wh+d7Fdkar9/UQg6YX0+8petfhbhD7O2vrInRmaeE9g/kvH0tkdNQIDdmPRffYpXXC
 G2TiTp2lsfL2/LlAo0/sjcLbk8U1peH2N3Oq8oDisOY4BFqJjfoWH2IiUFfkF4CXt85L
 Cs+VZWtsx2vGbRvrtQjLVt6GiSYIy/c6rT0IVAafpC1GUJQyao69n6xJwgh/9A24eYxV
 295bvy59Oj3Pcj6b8lng5R8PfATjmRTrDCFiLpwqk3muS7WK7CTjNbYnW0+LVKwQSnqg
 81XrVjguGwH6Yomgx4vTplP7bahLnSmUl91fp2BAwWkE2GUQWOCaoT5Euxr9zi/8O+NS
 E6LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBpvvwHNhmNhznBNTTWD+b+Yg3IAknzpsLPoq7F75bmYAkh36Iz+bD694zv5WzqcE9LtpJOcBnCidS@nongnu.org
X-Gm-Message-State: AOJu0YxRy8YbwiO9oIkL1/8elqYXUNpJD6Wej+pIJknYyEhmFiUiM204
 dIy+3fYTXHDqzV/MNm48NEAxp6thwn1LnhBIFjr5HDca01p8nN/gybV6j88gueA=
X-Gm-Gg: ASbGncsnh4dL1aY9ZB8aUkzmYQn+xq/1UCb4iQD7u5Xc2IYRjdzlEyNMRcez+nm8IBL
 11epAHVCmJ3A/2r4K/S8NzBh6Bvkp9/uvrV58CbBzxpjqWvUU9E8awWTZhW9KnXvs4huKcRLcQF
 r3sxaWwaqCt/4CT/sEb8EEAm2LxWPwUBx7+G+3DbIWmvU3F2QzQD+E2HsalC6Lc2FNBrWXhFleG
 B9BpGa2Y9IDGT0YdWUWwnGkHQIyo1ZKSX6nIq6UVZB8avlzHINKsNxxgyWsnXxNsZs3AqCnmsZR
 FXCPGn8TsXPiFxP9MMxQrAkS07YgySiqjp8ytau9kzIf6cN+6ZfhQVMgbas=
X-Google-Smtp-Source: AGHT+IETpjQI9ShoMBHxFSaPg1nk/m7wKZyC4HbXaSFaa+2PM0VJ75Pk26QWkj84+Fpi4rwGMyFnsg==
X-Received: by 2002:a05:600c:5126:b0:436:1af4:5e07 with SMTP id
 5b1f17b1804b1-438913bdcbcmr334056475e9.1.1738058579002; 
 Tue, 28 Jan 2025 02:02:59 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd5730a6sm161596195e9.35.2025.01.28.02.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 02:02:57 -0800 (PST)
Message-ID: <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
Date: Tue, 28 Jan 2025 11:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
Content-Language: en-US
In-Reply-To: <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 28/1/25 11:01, Philippe Mathieu-Daudé wrote:
> On 28/1/25 10:27, Daniel P. Berrangé wrote:
>> On Tue, Jan 28, 2025 at 10:17:33AM +0100, Philippe Mathieu-Daudé wrote:
>>> On 28/1/25 10:02, Alex Bennée wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> On 28/01/2025 01.42, Richard Henderson wrote:
>>>>>> Time for our biennial attempt to kill ancient hosts.
>>>>>> I've been re-working the tcg code generator a bit over the holidays.
>>>>>> One place that screams for a bit of cleanup is with 64-bit guest
>>>>>> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
>>>>>> have to handle such silliness at all.
>>>>>> Two years after Thomas' last attempt,
>>>>>>      https://lore.kernel.org/qemu-devel/20230130114428.1297295-1- 
>>>>>> thuth@redhat.com/
>>>>>> which resulted only in deprecation of i686 host for system
>>>>>> emulation.
>>>>>> By itself, this just isn't enough for large-scale cleanups.
>>>>>> I'll note that we've separately deprecated mips32, set to expire
>>>>>> with the end of Debian bookworm, set to enter LTS in June 2026.
>>>>>> I'll note that there is *already* no Debian support for ppc32,
>>>>>> and that I am currently unable to cross-compile that host at all.
>>>>>
>>>>> IIRC the biggest pushback that I got two years ago was with regards to
>>>>> 32-bit arm: The recommended version of Raspberry Pi OS is still
>>>>> 32-bit:
>>>>>
>>>>>    https://lore.kernel.org/qemu-devel/ 
>>>>> F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/
>>>>>
>>>>> And looking at https://www.raspberrypi.com/software/operating-systems/
>>>>> this still seems to be the case...
>>>>>
>>>>> So I guess the main question is now: Would it be ok to kill support
>>>>> for 32-bit Raspberry Pi OS nowadays?
>>>>
>>>> I would argue yes for a few reasons.
>>>>
>>>>     - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can 
>>>> work
>>>>       with a 64 bit OS.
>>>>
>>>>     - It's not like the versions shipping in bullseye and bookworm will
>>>>       stop working.
>>>>
>>>>     - Even if we deprecate now there will likely be one more Debian
>>>>       release cycle that gets 32 bit host support.
>>>>
>>>>>> Showing my hand a bit, I am willing to limit deprecation to
>>>>>> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
>>>>>> unconditional support for TCG_TYPE_I64 would remove a *lot* of
>>>>>> 32-bit fallback code.
>>>>
>>>> I support going the whole hog. I would be curious what use cases still
>>>> exist for an up to date 32-on-32 QEMU based emulation?
>>>
>>> Current maintainers don't have spare time to support the 32-on-32
>>> emulation. If there is interest in the community for such niche,
>>> someone needs to step forward, willing to maintain it.
>>
>> I'm not sure that's the case here.
>>
>> 32-on-32 is already effectively unmaintained, so we're not suffering
>> in terms of keeping the 32-on-32 code reliable.
>>
>> We're suffering from the complexity that 32-on-32 code places on the
>> rest of the XX-on-64 code that we do care about.
>>
>> IOW if someone volunteered to maintain 32-on-32 that's not actually
>> solving the complexity problem, just perpetuating it.
>>
>> The current maintainers only interested in XX-on-64 will still suffer
>> ongoing burden from the code complexity caused by 32-on-32 merely
>> existing.
>>
>> So again lets be clear...
>>
>> Either we...
>>
>>   * ...want to kill 32-on-32 code to reduce the complexity on the
>>     main XX-on-64 codebase regardless of interest in 32-on-32
>>
>> Or
>>
>>   * ...want to kill 32-on-32 code because it is buggy due to lack
>>     of maintainers, but would welcome someone to step forward to
>>     maintain it
>>
>> It sounded like we were wanting the former, not the latter.
> 
> Yes, we want to former. But as Thomas pointed out, last time
> someone showed up, and while the maintainers weren't willing to
> keep 32-on-32 [*], they kept maintaining it at the price of restricting
> XX-on-64.
> 
> [*] back then we proved system emulation XX-on-32 wasn't really useful
> anymore, and user emulation 64-on-32 was partly broken, so only
> 32-on-32 user emulation was functional.

So it seems reasonable to deprecate and ask interested 32-on-32 user
emulation users to use QEMU 10.1 release.

