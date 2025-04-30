Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC458C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAO2-0003De-CN; Wed, 30 Apr 2025 12:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAANy-00038E-Sw
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:34:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAANw-0008Dq-Ux
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:34:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73972a54919so127047b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746030851; x=1746635651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H95H2KWLkf33AFMxI8fXbKPm+i+f2aa5OacAsJH4Org=;
 b=Mt5F9Xt8K/bzdXIJ0Vn4ZNYMlPw6jWFoA+TQ4CLoav7QP8AjtpKSs/r1quVNVZuc9C
 P+fNau6+BcAFriokOBIvEH330K1eFZGvChJVxmBjeM0W9lS5tCW8GkIJHzsqtEsFXE4l
 tcnadRSd8aDsmLnpw5VZaFZlCT4loDoy67Bp9e7WsNz/y2SvtBXLYSnhXdDv7G3JX6em
 z9zomOv1OjfFB/UeFGmFurNT19/D4reSMUndLizHqVcAmst+OaDJVRCbrpfRkM83z7if
 8Hc4jqKRfLbMHIE8u0lQoPunM7ymtdunVtfhCdptRpUNoUJh260S7VSrHqEGf8xiDGAn
 DPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746030851; x=1746635651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H95H2KWLkf33AFMxI8fXbKPm+i+f2aa5OacAsJH4Org=;
 b=V7cYi9WyTTGhP7soLdx0whDzU2S1PKHF3VaWKTc9w3gvSWtt76ZZJXgN780jCWXghj
 TRwqfxmvN7CjQJriiRJulKvcK0ZTPYKUwQLNgntpQL2oR3svSkX4/KPmqiWu3Ahh9mid
 8VmLXFWZvUrE1zr5fn5vuvxC5A3NuDyI41oyGCqxtt9NphPNbqiJwDG8BxRyVxofITfW
 3kNsBOeMlx3H0jxktqW3SZP1uQAAP57EvMi4kkcEpkD5RLamkml6qAlXzHqw9smbh5YG
 7qKhiTSyCPD0x8mGHWDQL2HaMIwg5wgh38sMtcAWqGsICmREcXAJCbA5CU3ltzr4lYf2
 PdkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4LlQ5thhM6OpiYFRjhsjwZkEg8aEQCOj/AOujhn2IEbw84OrReWgT6+c4TplNEbXeXrCF1NroqE2s@nongnu.org
X-Gm-Message-State: AOJu0YyKJZyOmNXOJgjBdQlVoasbt8JC0fdMmmVoSkH9LT6VYLlU3lBN
 GbqESDE1br7vkuXSR2I+Fpb+MNJX7tcY3wRFCyRuD3fXlAJS4IKznscKi1d6cxE=
X-Gm-Gg: ASbGncsLJXIgiDybzGUk6nkUBWP9iqNZajTP+DrpwoC8J7wa/r85I8s34i/bwbFVQot
 MA9MraU0MNVyxNbPqHOt33PvnpxTq1XqXMGgUfBcISuqq32xXa414F0Mhw2mC8Xayg+/vIThJAk
 39b6GwgLcvaV0pSaLV/hygBl5abUDReTgBXgSsmp2BP0BSfPUAIe3Fnle81+YVwVuxUZ2eoJKLS
 HTizelKLQjmODes2eJaEmgyriomQ/KTaQDCkQITm+MWT8t4mnFvKi4zLXYhBQJ98fUchPwbIkdY
 kdEKNj3dRa8UoS+FaFmDOHXFcCo8rp70zRMpeh1CJURnkj+94XMPew==
X-Google-Smtp-Source: AGHT+IHUhl+5YHglIn865fW0T/xp0wxdxQLDc4bERD8wVsdFdcTwH35vu/8j0Um1tasjfdLShAuqog==
X-Received: by 2002:a05:6a00:21c7:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-74038abf64amr5655717b3a.20.1746030851508; 
 Wed, 30 Apr 2025 09:34:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740398f9f9bsm1872861b3a.29.2025.04.30.09.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:34:11 -0700 (PDT)
Message-ID: <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
Date: Wed, 30 Apr 2025 09:34:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
 <aBJJqtzQaTH_xcKK@redhat.com>
 <efbaccd1-9ef2-4aed-88ed-d6a2bcb7902b@linaro.org>
 <aBJP-_KJudesY_Pk@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBJP-_KJudesY_Pk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/30/25 9:29 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 30, 2025 at 09:21:41AM -0700, Pierrick Bouvier wrote:
>> On 4/30/25 9:02 AM, Daniel P. Berrangé wrote:
>>> On Wed, Apr 30, 2025 at 08:48:59AM -0700, Pierrick Bouvier wrote:
>>>> On 4/30/25 8:00 AM, Thomas Huth wrote:
>>>>> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>>>>>> Hi folks,
>>>>>>
>>>>>> $ ninja -C build precache-functional
>>>>>> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
>>>>>> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
>>>>>> Download retries exceeded: skipping asset precache
>>>>>> $ echo $?
>>>>>> 0
>>>>>>
>>>>>> Since we silently skip the asset precaching, how can we identify that an
>>>>>> asset is not available anymore (temporarily or not)?
>>>>>> Should we rely on test itself failing when trying to download again this asset?
>>>>>
>>>>> The current logic fails hard for 404 errors, so if the asset is completely
>>>>> gone, we should notice it. For other error codes, we assume that it is only
>>>>> a temporary server problem that will hopefully be fixed on the server side
>>>>> sooner or later.
>>>>>
>>>>
>>>> Sounds good.
>>>> Should we replicate this semantic when running the test itself?
>>>> It would be more useful to skip it because an asset is missing instead of
>>>> reporting an error, except if it's a 404 error.
>>>
>>> The tests already gracefully skip if one or more required assets
>>> are not available. See the 'setUp' method of QemuBaseTest
>>>
>>>           if not self.assets_available():
>>>               self.skipTest('One or more assets is not available')
>>>
>>>
>>> In the 404 case, the pre-cache step should fail and thus we shouldn't
>>> even get to running the test.
>>>
>>
>> This is not the behaviour I observe (error, with server returning 503) [1],
>> thus my original email.
>>
>> Maybe something is missing in the associated test, or in our test
>> infrastructure?
>>

Or... in my command :)

>> Nothing funky in the command line used, you can reproduce it with:
>> $ rm -rf ~/.cache/qemu build/
>> $ ./configure
>> $ ./build/pyvenv/bin/meson test -C build --setup thorough --suite func-quick
>> --suite func-thorough -t 5 --print-errorlogs func-ppc-ppc_40p
> 
> Oh, you're running meson test directly.
> 
> The behaviour I describe is wrt the official way of running tests via
> 'make check' or 'make check-functional'.
> 
> When you use 'make', we set 'QEMU_TEST_NO_DOWNLOAD=1' when the tests
> themselves are run, so only the 'make precache-functional' will be
> permitted to try downloading.
>

Oh thanks, that's what I was missing!

I'm running meson because the Makefile wrapper does not allow to pass 
any additional parameters, or running specific test.

> With regards,
> Daniel


