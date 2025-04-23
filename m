Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 05:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Sgz-00088f-7X; Wed, 23 Apr 2025 01:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Sgx-00088P-Vv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:30:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Sgv-0005Yf-LO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:30:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so3193091f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745386235; x=1745991035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XiuMoo/tICCtb7rqzXdXmSZ+kkdTef0btUKotNGoQgM=;
 b=NNV1zfvthpUNZc6iWEtkOJ0rSX4dgdYOqa9fbnUdqmflnqfXzVikBOnsDEAmngocgk
 WzqcY0m9ez9mJ+55HaYk92vO9DOBaRE+tiX6y7oBON98MgBD6gr88A+OZ+MBKT+88iX4
 f1cfGuyDDEBzI57zIq+wqVUaEc8p9KPbYRs3AYnyk5JWesc0QIO3N61YvYXWA4aAOyQ7
 3EXC/9r1MPLUUHmxwV1wyi6XXYiCs1eCuKLxQCnY51dCijF8QscfqK6dnsswMGD6WqXo
 yX9H92TUkVVBH6gS48F2uE9Q//4J5PuQ+yzFJV/HtVJOpaZ/cvV0IzT6iqL8nbKszShw
 IZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745386235; x=1745991035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XiuMoo/tICCtb7rqzXdXmSZ+kkdTef0btUKotNGoQgM=;
 b=uVrTJivFJG3jRI02DR2mHwi/ylRXpSLmzqi9+KBcxgZ6dFU3dsI7I7MmlpDKzcIhUR
 nmx9OXUYlO7AEfMkMppw9KK028cTji4cqQxIVy/oAMSmYT9MdgXqZiZy0uF3YGu0K/e9
 DzWw3weQhRTAUKosDguz0QeBwk2JC5y+HvCvRY36Rr6AkFWBVXK6nDnameWEH374e8qK
 GtCre4ReaT/7tKhE7dip4C/pTqETUk8pQUlZs7G+klD74bgUmiJ9SJw0p0mg/IWWp/LZ
 MGg95fIovmcxjq9MPLASWuctUcoXTYVM0v2whPOWUQZ/42OorV1pPsxYichegVTDXw0D
 FT2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzXNXhNIPzHgiTnUnuvkK9po3GgMT+emw7zwbPxsh6DdbRbT122exoj1sU8o2dfkVxNAnMoqZrsqc+@nongnu.org
X-Gm-Message-State: AOJu0YwVsguxag6We5NbPHiELlvFt9DWSZb17JgwLb9mZLq0VBjjl4Ea
 8uYcIZh3LlZfcKBGyTaCV9lGimoS0L2dukqLDY0vjEPbC6IdnBNOV4SJL248s3s=
X-Gm-Gg: ASbGncs9EYgWvhzm8ZrkG9cdjYtsgOioVJdyhI7Ri15zQytC8XKqwj41IieedaZCnxQ
 jMU+UVoROU/cxFzhkrQ5B6skqdsTc4v5z2z3/1uef6h2flaE+4xkQTvIiiloDk5Vvy+cxK03wXQ
 mIWcaPlAnpQLdNrqOxucne/89a1za93GBrLGv9wa545vHaHm956OweU8Emf6JlxsGuHts7p/C4b
 NFDwVQeBI129rtObHqkvCu1zAsiG7YLfHgyxeID3nle+N3sk/2AEuPlDyG3e0ls5fuxx+kXVouF
 +XfKISq985GjusLq9NB4k/Z2ODzRy+icCwQjbd/Sv1iK4DfjebhbhF9XvEN4ZkdgSX08rAp7foy
 ivK/yQws+
X-Google-Smtp-Source: AGHT+IHtVlDoEGcpJaVMtzEZcRjGUiMaQFYcYkbxUlLD6acivkeJmt7/6m+Zh4jgZ/Ih//N4bkRNkA==
X-Received: by 2002:a05:6000:4021:b0:39c:1a86:e473 with SMTP id
 ffacd0b85a97d-39efbb22a85mr13627480f8f.56.1745386235182; 
 Tue, 22 Apr 2025 22:30:35 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d22esm17639189f8f.52.2025.04.22.22.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 22:30:34 -0700 (PDT)
Message-ID: <d3d535a0-097d-45ef-b129-38e0c91957e3@linaro.org>
Date: Wed, 23 Apr 2025 07:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] buildsys: Disable 'unguarded-availability-new'
 warnings
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250422171955.11791-1-philmd@linaro.org>
 <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
 <94dabfd0-e104-432d-9793-2f44d361ddc9@linaro.org>
 <64d0d267-aa1f-4f61-b902-dcbbd89420d6@linaro.org>
 <6f4b7802-6245-456d-be21-5c560a88a584@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6f4b7802-6245-456d-be21-5c560a88a584@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Akihiko,

On 23/4/25 07:24, Akihiko Odaki wrote:
> On 2025/04/23 5:31, Pierrick Bouvier wrote:
>> On 4/22/25 12:45, Philippe Mathieu-Daudé wrote:
>>> On 22/4/25 20:36, Pierrick Bouvier wrote:
>>>> On 4/22/25 10:19, Philippe Mathieu-Daudé wrote:
>>>>> When using Visual Studio Code (v1.99.3) and Apple clangd v17.0.0
>>>>> I get:
>>>>>
>>>>>     In file included from ../../qapi/string-output-visitor.c:14:
>>>>>     qemu/include/qemu/cutils.h:144:12: error: 'strchrnul' is only
>>>>> available on macOS 15.4 or newer [-Werror,-Wunguarded-availability- 
>>>>> new]
>>>>>       144 |     return strchrnul(s, c);
>>>>>           |            ^~~~~~~~~
>>>>>     /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/
>>>>> _string.h:198:9: note: 'strchrnul' has been marked as being introduced
>>>>> in macOS 15.4 here, but the deployment target is macOS 15.0.0
>>>>>       198 |         strchrnul(const char *__s, int __c);
>>>>>           |         ^
>>>>>     qemu/include/qemu/cutils.h:144:12: note: enclose 'strchrnul' in a
>>>>> __builtin_available check to silence this warning
>>>>>       144 |     return strchrnul(s, c);
>>>>>           |            ^~~~~~~~~
>>>>>     1 error generated.
>>>>>
>>>>> Disable this -Wunguarded-availability-new warning as a
>>>>> short term band-aid fix.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    meson.build | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/meson.build b/meson.build
>>>>> index 41f68d38069..539368f82b1 100644
>>>>> --- a/meson.build
>>>>> +++ b/meson.build
>>>>> @@ -735,6 +735,7 @@ warn_flags = [
>>>>>      '-Wstrict-prototypes',
>>>>>      '-Wtype-limits',
>>>>>      '-Wundef',
>>>>> +  '-Wunguarded-availability',
>>>>>      '-Wvla',
>>>>>      '-Wwrite-strings',
>>>>> @@ -747,6 +748,7 @@ warn_flags = [
>>>>>      '-Wno-string-plus-int',
>>>>>      '-Wno-tautological-type-limit-compare',
>>>>>      '-Wno-typedef-redefinition',
>>>>> +  '-Wno-unguarded-availability-new',
>>>>>    ]
>>>>>    if host_os != 'darwin'
>>>>
>>>> I solved it the same way locally, but didn't send a patch because I'm
>>>> not sure what happens if the code runs on MacOS < 15.4,
>>>
>>> I'd expect meson to Do The Right Thing and not define HAVE_STRCHRNUL.
>>>
>>
>> The trick is that it compiles with a warning, but meson tests are not 
>> done with -Werror enabled.
>> This might be the proper fix at the moment, if we identify that a 
>> crash happen on MacOS < 15.4. Else, the warning can safely be silenced 
>> as you did.
> 
> We need to take two components into consideration: SDK, which includes 
> header files, and macOS that runs the binary. If you use a SDK that 
> defines strchrnul() to build, the resulting binary will not work on 
> macOS < 15.04. My idea of fixing this properly is as follows:
> - Define the MACOSX_DEPLOYMENT_TARGET environment variable to tell the
>    macOS version you are targeting.

I read a bit about this variable but don't gather its implications.

> - Pass -Werror=unguarded-availability-new to cc.has_function() so that
>    Meson will not define HAVE_STRCHRNUL if strchrnul() is not available
>    on the targeted macOS version.

This was my guess but I couldn't find precedent of -Werror in
cc.has_function() so wasn't sure.

I'd feel better if you are willing to correct fix this :)

Regards,

Phil.

> 
>>
>>>> and I don't have
>>>> such a machine available.
>>>>
>>>> Is the symbol already there?
>>>> Does it crash?
>>>> I guess the warning is here for a good reason.
>>>>
>>>> You can find a lot of issues open in various open source projects with
>>>> this warning (with various fixes) since this update was released.
>>>
>>
> 


