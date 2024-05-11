Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93871C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5juw-0005Pm-Mb; Sat, 11 May 2024 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5jut-0005PW-S0
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:25:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5jur-0004WN-Cf
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:25:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42011507a54so532255e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715423116; x=1716027916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Yw+RCkrMhvgEQ4P1y1hz6/frcot4zxegiBq0jdmrC0=;
 b=WiRPsBWRr4Vo0geQYHRou5ymh1QMGX3UjZKC/iR6sKLZ7xlpneS7K8SJIgg0lLV/4+
 o10i0bapnUd6BFpN05OGWyB/HzwwTmL0j1febynzBAjN3Mm1Youy4eRmKxS5en98RSYJ
 KTFo3SCZfgY++YMnHvIUz0NAv0Jc9+WhNrbFfowzn4lfMwETSGevQ6/LeEHf08PLJ3aT
 nms+8xMM9S3qONYY0HAENqksld5SeAyZey4gWGaCEooyxUsWZZ2jMSRYijHyU2Si9uP4
 4byugzw+wXQetut7H4dFCncyA8AzgO3/WTHdZmmPupyJaiHnFEiiLw8/7K5hPk5ySMme
 bVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715423116; x=1716027916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Yw+RCkrMhvgEQ4P1y1hz6/frcot4zxegiBq0jdmrC0=;
 b=EYYwA5TXsR36QsPT42lAHZWv4aqYQh5kbKuD//buohtH9GpZvCNkPUreRcyQ857uZz
 ABmRjNhofyt/drR+X3AkUdgCGFgmP0S9FXZ+qFroh6bDUw7EYgR1CD2jS2MkBp4FBD+X
 bejVdtgQt8z/4fyIvu4EHvjqol0WIUGDSW1mwar/uu3io9ao+FlTS6QVYnbcjn3SuaNw
 9YBDI2K1Hv6TFkIuG3r5XwPPDJhvK1pTyJZsDus2OesrEY/Z1t7RuZF0Cs1Lp+9INQI/
 izc/gMe2zjZOAAnGO8B/9bi6dpF69/L9F8jEsACouLBvp/Cas/0V1/lIXavMLWD9IkFN
 876g==
X-Gm-Message-State: AOJu0YyS1FFQhtz5nI0aeUMIvyqaUf5gUJ2oazqDl/ZVCtBlQtaiPXRT
 KIBszFV14E7Wn4eGmWyDVJ22BFOFB3a1xu3E4Dv/bQDuBhsIor2Zs0T2+IIl2zQ=
X-Google-Smtp-Source: AGHT+IGYV2c6TvS2dDh3wHcLCmMIpysLBfFBNlOpGf9199fDwOSpYCnUTYn6NYuc13WodvYe9hoBcw==
X-Received: by 2002:a05:600c:3112:b0:41b:e55c:8dc1 with SMTP id
 5b1f17b1804b1-41fbd1b2e40mr62102725e9.20.1715423115831; 
 Sat, 11 May 2024 03:25:15 -0700 (PDT)
Received: from [192.168.51.227] ([195.76.196.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbff7sm6604468f8f.101.2024.05.11.03.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 03:25:15 -0700 (PDT)
Message-ID: <8b84b9ae-fda6-49c2-90dd-40d8660561c5@linaro.org>
Date: Sat, 11 May 2024 12:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
 <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
 <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/11/24 12:11, Dario Binacchi wrote:
> Gentle ping.

Gentle reminder that I strongly suspect that your buildroot is corrupt.
There *should* be a <fenv.h> present.


r~

> 
> Thanks,
> Dario
> 
> On Wed, May 1, 2024 at 4:17 PM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>>
>> Hello Richard,
>>
>> On Wed, May 1, 2024 at 3:31 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 5/1/24 05:18, Dario Binacchi wrote:
>>>> Hello Richard,
>>>>
>>>> On Tue, Apr 30, 2024 at 8:15 PM Richard Henderson
>>>> <richard.henderson@linaro.org> wrote:
>>>>>
>>>>> On 4/30/24 09:47, Dario Binacchi wrote:
>>>>>> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
>>>>>> always provided by the libc (uClibc). The patch disables its compilation
>>>>>> in case the header is not available.
>>>>>
>>>>> Since uclibc has had fenv.h since 2008, are you sure this isn't simply a case of a corrupt
>>>>> installation?
>>>>
>>>>>
>>>>>
>>>>> r~
>>>>
>>>> It's not an issue of corrupted installation but rather of compilation:
>>>
>>> Installation of your cross-compiler or buildroot, I mean.
>>>
>>>>
>>>> ../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or directory
>>>>      15 | #include <fenv.h>
>>>>         |          ^~~~~~~~
>>>> compilation terminated.
>>>
>>> Yes, yes.  However, <fenv.h> is present in uclibc-ng, and has been since 2008.
>>> So *why* is fenv.h not present?
>>
>> I found the fenv.h files here:
>> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c++/11.3.0/tr1/fenv.h
>> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c++/11.3.0/fenv.h
>>
>> But the compiler expects them in:
>> out/emulator/host/i686-buildroot-linux-uclibc/sysroot/usr/include/
>>
>> So, I think that the fenv support has not been enabled in uClibc
>> configuration of Buildroot.
>>
>> Thanks and regards,
>> Dario
>>
>>>
>>>
>>> r~
>>
>>
>>
>> --
>>
>> Dario Binacchi
>>
>> Senior Embedded Linux Developer
>>
>> dario.binacchi@amarulasolutions.com
>>
>> __________________________________
>>
>>
>> Amarula Solutions SRL
>>
>> Via Le Canevare 30, 31100 Treviso, Veneto, IT
>>
>> T. +39 042 243 5310
>> info@amarulasolutions.com
>>
>> www.amarulasolutions.com
> 
> 
> 


