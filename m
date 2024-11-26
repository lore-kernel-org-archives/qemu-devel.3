Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F26D3B980
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtTz-0001Zl-Vg; Tue, 26 Nov 2024 06:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtTy-0001ZV-2e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:11:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtTw-0008Sl-33
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:11:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so11452445e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732619506; x=1733224306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZ8YehwlYQqgDvVWBjKs/WT3NOgYVT5KlC4pXCQnU6c=;
 b=iJWRmwN9D0znhT5BQYULvKh0I4C2yTcy9osheEKvSR//aAIbcldkAtOFm1NgKP1aaF
 p8RTw2HcEUiFpq0BZvSeHnm3UAcqYp5rQalkBK9pB5asIq23s/82eE1lVtP/hkRgPzAK
 a2wbrX7m+GOxrB28gT0yStPZXoevCD5SZ717QIsFWRq+MaztCEa7bM0ip3OfMp7c4DNg
 RSJyA1VdzcGJB/bpzsxq1aqKxDUHYhSIhj9FgtY4/b22PuDjknNxD0I9nRDlQt1o+46n
 GH++tif0TwfE3a1Bs9Vk3++h+9pGz/YE1OcrgqO28GcY/XzUYBKVi2a/3v85DyDhqwIN
 HlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732619506; x=1733224306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZ8YehwlYQqgDvVWBjKs/WT3NOgYVT5KlC4pXCQnU6c=;
 b=PSDVVEAyGL6VeAiLNgItpXkt6YPGGF/38hRIulx0jk2A25NIeK2nIYIjkVGfetyXEJ
 s2cPrZ9dWXsvMJ4F/DgDYzDi0hoV5l2JivHzdpdz0R7yWqPtULIfklXtyDlJ5f9FjM0Z
 YcIPemsYHURZ9RaDhobru8qtuvxvtEKXtOf2FQdMEhW88Yjyffi867xHRUHtJk/asTCL
 xogSQIJsKfwlNlOPe+wsNEFhqyKb3m6YSoX/Mf2wcetYu09c1ZonttpMhLaiwZ+KbEIL
 jb13zrA+7tlcGkr1MtE8UKmtbDlWvjAlFYIT5YHNBV4rKh1Vw7o9KPi15kXZKl7RKmuT
 /RJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg4b5hglp2MVtfJoP31H+9LjM27q3NAs+CnvZUpUDNVwqC9hpXXNmDJ2AGnEVUzrcxqB0YXjqyN68o@nongnu.org
X-Gm-Message-State: AOJu0YxF0vNKfd8AO7BhcuxyTFgiOWrojnOdBjYOeM4Vp/ycB2MK3Pf6
 Tpa8jJJ/cpEQcVVc8mUoJo4ZcpNVnoKYBJybHoV2YPK6bMazMPTrG8HwtbcsHNw=
X-Gm-Gg: ASbGncumwJIM1827kDEOUPsF0E5Y0neq9wkNBxlDYChQpTmL1Wb8pTYMljAQRKaG3oP
 8pwV45R2ommQvd2fztIbzLvhOX3XaT+HQA3CZMVrXfYKo5yZE3ssFGyQtRBWHVKkVJyYA1jIt0r
 fSaDoBg0QfXK8VHcAiLRD6Szsgs0gw/QcGR2fyQESbpz0xIzvToN8GACTHx5JXCxBlq7DX86ElD
 Mqni5GLNQrwGUgMTO9MtCL4PDb6i57ZlJISncQ924nLY/+2l36aTotqvRFp/GweeQ==
X-Google-Smtp-Source: AGHT+IGyLnCZrlsZxf6eXqPyX5Qt8fz83TGPWF58AaIxywoDmYI8YkK6uLUSR6VhqLji2+8FVmBoxw==
X-Received: by 2002:a05:600c:1c25:b0:434:a4fe:cd6d with SMTP id
 5b1f17b1804b1-434a4fecf1cmr26603585e9.12.1732619506056; 
 Tue, 26 Nov 2024 03:11:46 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm224659145e9.43.2024.11.26.03.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 03:11:45 -0800 (PST)
Message-ID: <f3c726b6-403d-462b-9973-eb51a8447f94@linaro.org>
Date: Tue, 26 Nov 2024 12:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Refuse XCode versions < v15.0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241126081054.244365-1-thuth@redhat.com>
 <6f883a0f-3fdb-4326-8262-c0482e30ea32@linaro.org>
 <Z0WTkQYWaNlnGipo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z0WTkQYWaNlnGipo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 26/11/24 10:23, Daniel P. Berrangé wrote:
> On Tue, Nov 26, 2024 at 09:57:15AM +0100, Philippe Mathieu-Daudé wrote:
>> On 26/11/24 09:10, Thomas Huth wrote:
>>> According to our support policy, we only support the two latest
>>> major versions of macOS, and we already removed compatibility code
>>> for older versions. However, it's still possible that people install
>>> an older version of XCode on a recent version of macOS - which won't
>>> be able to compile QEMU anymore, see for example the ticket here:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/issues/2694
>>
>> Wondering about this issue, it is possible to install concurrent
>> XCode versions, which is useful i.e. when you build an application
>> targeting multiple (and older) App Store releases. See:
>> https://xcodereleases.com/
> 
> That's true of any platform. You can get many GCC versions for Debian
> and Fedora too.
> 
>> Maybe we need to clarify our support policy that we only support
>> the XCode released with the 2 latest major macOS versions?
> 
> We implicitly support the XCode versions that are the "default" with
> the latest 2 macOS versions.

Implicit might not be sufficient for users, see #2694.

>>> @@ -315,8 +315,8 @@ foreach lang : all_languages
>>>        # ok
>>>      elif compiler.get_id() == 'clang' and compiler.compiles('''
>>>          #ifdef __apple_build_version__
>>> -      # if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
>>> -      #  error You need at least XCode Clang v12.0 to compile QEMU
>>> +      # if __clang_major__ < 15 || (__clang_major__ == 15 && __clang_minor__ < 0)
>>> +      #  error You need at least XCode Clang v15.0 to compile QEMU
>>>          # endif
>>>          #else
>>>          # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
>>> @@ -325,7 +325,7 @@ foreach lang : all_languages
>>>          #endif''')
>>>        # ok
>>>      else
>>> -    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v12.0) to compile QEMU')
>>> +    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
>>
>> BTW apparently CentOS 8 (which we don't support anymore IIRC)
>> provides Clang 12.0.1, and also Ubuntu 22.04, Alpine 3.16.
>>
>> I wonder if the relation with XCode __apple_build_version__ is
>> always __clang_major__ + 3...
> 
> No, it isn't. It varies all over the place -
> 
> eg
> 
>  From xcode 11.3 to 11.4 they bump from llvm 8.0.0 to 9.0.0, while the
> clang version goes from 11.0.0 to 11.0.3.
> 
>  From xcode 15.4 to 16.0 they from llmvm 16.0.0 to 17.0.6, while the
> clang version goes from 15.0.0 to 16.0.0.
> 
> I can just about interpret a rule they're following, but relating that
> to the upstream clang versions algorithmically is impossible.
> 
>    https://en.wikipedia.org/wiki/Xcode#Toolchain_versions

Doh...

Anyway, for this patch:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


