Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 05:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7SbP-0005dB-M2; Wed, 23 Apr 2025 01:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7SbL-0005co-7c
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:24:51 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7SbI-0004iY-GX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:24:50 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso3970827a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745385886; x=1745990686;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufirOfkdliqMaU38pqUf8/QT7vgRQOrM/Xe54CsjJ94=;
 b=i6z9oYIHAnj/AIcHQs/kpUkNoGe93ADUPwbuJA0XmwlWww9WkmysXEEFMddW8B5wli
 Ze3SxTF29oqUW6RXHjAbcHbX2RBwSwfGDGvjXs7y1kIGJtjcE6sHFA1gJLA4v88pbmgK
 J8BT75a9JnNwO3FAekWlgdGkdJIT4RNOYAKmQItf4WPykidB9RLeh0McWFzgpPoWUkJE
 +F38r1QDpPl6f6r4zsifJMUyrZjfxX85fDBOTMIhjugmK08igZvubiIHP7Qj1geOdRsi
 IszO7zQSrFApnsF3AUky121YBmST/0Zd4mOYCXbWJZM3CBHfb3rAOG1nNk95IPihA2I/
 Vteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745385886; x=1745990686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufirOfkdliqMaU38pqUf8/QT7vgRQOrM/Xe54CsjJ94=;
 b=ozk9Dp4RR6ML8GuYBsQIBLM4pyx6LvAnlwOqgbCXe9UqaGrSXdcyTSZRuJVuiK/l8e
 D5Sv6bVsZ6plz67QnSNB+Wyhe6utJuGEwASE5FIHQ9Jz5Gyac0zDcXir3BcWKjjN1Up5
 TLRext+7Kx9e90zffmuvzohQ1vooCD8iUA84ZSsTJqEykJ9HtXZ+TQIUe5I/XN5JWqYS
 Rdkm6Vu5HCJxjM4mqz9WBNxXvBbiIPNZ/dDwQLPJThyKOGafi5Fu7xcouDYofy0cgi3x
 Ti0/oRsmaKtKmhZKemHmTQOFOrNrykWCNmUX1bgvxhGxdxtYkCELT+aByhLtzpSn4SPI
 jhJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvx8oEZ02GiquEKvPaWJAJymZUFYo0rZfQbgvpQoeNWLPBz1xSnJtSgCoAwl646gTF+//1CUdMM87O@nongnu.org
X-Gm-Message-State: AOJu0Yz9sppQek9L0lH8Cp7/wyfN9ZFKUc7L7NBq1i+c/NMUhIbhhnUz
 UaMKrk2UNp7sXXrAbA6ohRmWoDoFDRI0VA16D9LqCEvHmwCELph37C7dPSWf4bQ=
X-Gm-Gg: ASbGncsnovS1cDSK5jIKvNewiXHBJVuR2eV1N48E3K/+CUWWWNWuNxmkS2ihgj/huvl
 gLc2UdUoXkWkdk8vZ3a0NI1ctn+B3WM2nPjH3JtgHuWHLYPmAemrZ415Fhilpo+6Y4uv0uHd22h
 BY0rF7rLQ43Xm8sIf/ecNJlAVJAGPea6f1+NQAFlBNngrfD6qLMVHIAqxonB1g2+oYwLs3+cloE
 Q+sRzWSsPa8wSE9PGugKEPtUPsEySKrjY0CTUPS302j6IMc17IGXmVHgULMLEu50PNL3+j7MN16
 scEq4qD63qH1bfLFFXd3W/zYFsJ9arOChyoDK3LF7S5Ti1/6WapYIg==
X-Google-Smtp-Source: AGHT+IH9pab+LizGe2fm7t+X1m296ENQgdBJizjOgl1yQAikkORMAsjG0fm8r2a9yrAar7k1Ad+p1g==
X-Received: by 2002:a17:90b:528a:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-3087bb396abmr30397946a91.2.1745385886285; 
 Tue, 22 Apr 2025 22:24:46 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309dfa0ab1fsm630535a91.12.2025.04.22.22.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 22:24:45 -0700 (PDT)
Message-ID: <6f4b7802-6245-456d-be21-5c560a88a584@daynix.com>
Date: Wed, 23 Apr 2025 14:24:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] buildsys: Disable 'unguarded-availability-new'
 warnings
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250422171955.11791-1-philmd@linaro.org>
 <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
 <94dabfd0-e104-432d-9793-2f44d361ddc9@linaro.org>
 <64d0d267-aa1f-4f61-b902-dcbbd89420d6@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <64d0d267-aa1f-4f61-b902-dcbbd89420d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/04/23 5:31, Pierrick Bouvier wrote:
> On 4/22/25 12:45, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 20:36, Pierrick Bouvier wrote:
>>> On 4/22/25 10:19, Philippe Mathieu-Daudé wrote:
>>>> When using Visual Studio Code (v1.99.3) and Apple clangd v17.0.0
>>>> I get:
>>>>
>>>>     In file included from ../../qapi/string-output-visitor.c:14:
>>>>     qemu/include/qemu/cutils.h:144:12: error: 'strchrnul' is only
>>>> available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]
>>>>       144 |     return strchrnul(s, c);
>>>>           |            ^~~~~~~~~
>>>>     /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/
>>>> _string.h:198:9: note: 'strchrnul' has been marked as being introduced
>>>> in macOS 15.4 here, but the deployment target is macOS 15.0.0
>>>>       198 |         strchrnul(const char *__s, int __c);
>>>>           |         ^
>>>>     qemu/include/qemu/cutils.h:144:12: note: enclose 'strchrnul' in a
>>>> __builtin_available check to silence this warning
>>>>       144 |     return strchrnul(s, c);
>>>>           |            ^~~~~~~~~
>>>>     1 error generated.
>>>>
>>>> Disable this -Wunguarded-availability-new warning as a
>>>> short term band-aid fix.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    meson.build | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 41f68d38069..539368f82b1 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -735,6 +735,7 @@ warn_flags = [
>>>>      '-Wstrict-prototypes',
>>>>      '-Wtype-limits',
>>>>      '-Wundef',
>>>> +  '-Wunguarded-availability',
>>>>      '-Wvla',
>>>>      '-Wwrite-strings',
>>>> @@ -747,6 +748,7 @@ warn_flags = [
>>>>      '-Wno-string-plus-int',
>>>>      '-Wno-tautological-type-limit-compare',
>>>>      '-Wno-typedef-redefinition',
>>>> +  '-Wno-unguarded-availability-new',
>>>>    ]
>>>>    if host_os != 'darwin'
>>>
>>> I solved it the same way locally, but didn't send a patch because I'm
>>> not sure what happens if the code runs on MacOS < 15.4,
>>
>> I'd expect meson to Do The Right Thing and not define HAVE_STRCHRNUL.
>>
> 
> The trick is that it compiles with a warning, but meson tests are not 
> done with -Werror enabled.
> This might be the proper fix at the moment, if we identify that a crash 
> happen on MacOS < 15.4. Else, the warning can safely be silenced as you 
> did.

We need to take two components into consideration: SDK, which includes 
header files, and macOS that runs the binary. If you use a SDK that 
defines strchrnul() to build, the resulting binary will not work on 
macOS < 15.04. My idea of fixing this properly is as follows:
- Define the MACOSX_DEPLOYMENT_TARGET environment variable to tell the
   macOS version you are targeting.
- Pass -Werror=unguarded-availability-new to cc.has_function() so that
   Meson will not define HAVE_STRCHRNUL if strchrnul() is not available
   on the targeted macOS version.

> 
>>> and I don't have
>>> such a machine available.
>>>
>>> Is the symbol already there?
>>> Does it crash?
>>> I guess the warning is here for a good reason.
>>>
>>> You can find a lot of issues open in various open source projects with
>>> this warning (with various fixes) since this update was released.
>>
> 


