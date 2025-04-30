Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB91C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAZr-0002aC-Rt; Wed, 30 Apr 2025 12:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAZl-0002Z4-SY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:46:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAZk-0001g6-17
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:46:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e033a3a07so595575ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031582; x=1746636382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wtrc4ygT7q8F8q5lIAW/1Ea+oIy07adL0+KYew1ctmg=;
 b=QifHSMgprbLXkiOiHdl/87dlVd/HLgHrji4UEM1hmW1RxXgTMFNddTxJKcI4r2q1+5
 Dw16sAw/148NQ0+jV5SYAsuirHqjIYvlw2SFxHOZilsWlA9bNb7046NGsYmFDYIQgK3o
 t/TK5Lme+O1s1NTxfMu26mXt11hkSX69G+COLXanrq59FMsH375VyWpQBLpgrfpuKE2z
 s9EHkPNiKIPnGZoYlyhWESI6A3edqq/yV1BcNVC+xmLr+w5bXVhO55jCjatV24t8yo/P
 V503LHb+eoP4QLuDX9AoRxkqCjNHXLgMG22gtSpNN2M8OzzLvdKfpnoplHWvuAyS/iE1
 SReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031582; x=1746636382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wtrc4ygT7q8F8q5lIAW/1Ea+oIy07adL0+KYew1ctmg=;
 b=Cf0dez8wcynrqiJmtqh/3P+954D6C4tp7T35IGhlKPq9Hcjz32VvMNE+icZyth0PD+
 ifs37gFHmnEc5JFUp7YxH1hPdGmOvgCOlXECWyJzt9S/+olPJdYuVWwihjn/YYUNWabc
 EjYa7IBDuElyq2Dm8uZDH4O77OlMh1xGi3X666ESlKtb5NA1453QQdIJD2VNslHGI/hi
 CwYnYYs+hR0vxN6mQ+wMqer3fTvS/zddZmT8Zn/IKkficlDjIOva99AUXilUBodslTWi
 7IE88jBmZ8Weyhn1QAYh07uw/jD0DZbOXIogG3Azrd/LKDGkfSbXSBzNz3YUfKfF/6Pz
 mQZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzSRWWAEYEjuy+HKbtCneDhb6uYw7f3j9yvIxbe6mKGXr2vbyA2slQylMGheAupV2O7ZLmh0+DCV3N@nongnu.org
X-Gm-Message-State: AOJu0YxNghpaxCsS68LwYPMMzu+h63QkQ9QP61zrDG/Fd9eV1e9l5Ilo
 bMcVQRlLQ+iaRRZ3xhZ8XVWKjxzH2wveVhl3B967IGS9N52UwUaI3I8hmwifwpY=
X-Gm-Gg: ASbGncvRij7MccldrFbffZu5ph6bruLhKGiecT/kknsMBpoCL0m73vfHRKOjjN6+Lql
 4L5int8CJP5VKJujTcTLzr+Ctr8CTDtJwUPLHv+st8E6G1qRX7v5/MMWvmSmWwQOMTfpG6/svXH
 UjgPuN0d7s4K/9iwumd3Z/p7vheTl4jErHaKltFiZZrAAaNdV+ZtPng3H9hI3Fg5e2C4wh7OA7M
 g6+3S6FrjDH0i3snxl8IwLSvxxTnRkbYIASLf9eeVP/qLyC8yZ2j/JebNXyIV+DBPUK6N5GPXWN
 2c2gHU+zhQVnCTIXQ9eRBlrwyjkVgwFhRlz2QPxqchnlTvXLOG4EMw==
X-Google-Smtp-Source: AGHT+IH0DZ42ogynD1mHlWblEveySolww4U47dDwqAJwEiv8VcjQEMTCnSoVFCfbLel/XdibLOldkA==
X-Received: by 2002:a17:903:1aae:b0:223:3ef1:a30a with SMTP id
 d9443c01a7336-22df35bf1e6mr56796235ad.45.1746031582462; 
 Wed, 30 Apr 2025 09:46:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe4desm124622555ad.70.2025.04.30.09.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:46:22 -0700 (PDT)
Message-ID: <b2869e87-9452-4e45-9ca4-babc1bf309e1@linaro.org>
Date: Wed, 30 Apr 2025 09:46:21 -0700
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
 <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
 <aBJSX6kcYQVM2hp7@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBJSX6kcYQVM2hp7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/30/25 9:39 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 30, 2025 at 09:34:10AM -0700, Pierrick Bouvier wrote:
>> On 4/30/25 9:29 AM, Daniel P. Berrangé wrote:
>>> On Wed, Apr 30, 2025 at 09:21:41AM -0700, Pierrick Bouvier wrote:
>>>> On 4/30/25 9:02 AM, Daniel P. Berrangé wrote:
>>>>> On Wed, Apr 30, 2025 at 08:48:59AM -0700, Pierrick Bouvier wrote:
>>>>>> On 4/30/25 8:00 AM, Thomas Huth wrote:
>>>>>>> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>>>>>>>> Hi folks,
>>>>>>>>
>>>>>>>> $ ninja -C build precache-functional
>>>>>>>> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
>>>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>>>> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
>>>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>>>> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
>>>>>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>>>>>> gzimg/armv7.img.gz: HTTP error 503
>>>>>>>> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
>>>>>>>> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
>>>>>>>> Download retries exceeded: skipping asset precache
>>>>>>>> $ echo $?
>>>>>>>> 0
>>>>>>>>
>>>>>>>> Since we silently skip the asset precaching, how can we identify that an
>>>>>>>> asset is not available anymore (temporarily or not)?
>>>>>>>> Should we rely on test itself failing when trying to download again this asset?
>>>>>>>
>>>>>>> The current logic fails hard for 404 errors, so if the asset is completely
>>>>>>> gone, we should notice it. For other error codes, we assume that it is only
>>>>>>> a temporary server problem that will hopefully be fixed on the server side
>>>>>>> sooner or later.
>>>>>>>
>>>>>>
>>>>>> Sounds good.
>>>>>> Should we replicate this semantic when running the test itself?
>>>>>> It would be more useful to skip it because an asset is missing instead of
>>>>>> reporting an error, except if it's a 404 error.
>>>>>
>>>>> The tests already gracefully skip if one or more required assets
>>>>> are not available. See the 'setUp' method of QemuBaseTest
>>>>>
>>>>>            if not self.assets_available():
>>>>>                self.skipTest('One or more assets is not available')
>>>>>
>>>>>
>>>>> In the 404 case, the pre-cache step should fail and thus we shouldn't
>>>>> even get to running the test.
>>>>>
>>>>
>>>> This is not the behaviour I observe (error, with server returning 503) [1],
>>>> thus my original email.
>>>>
>>>> Maybe something is missing in the associated test, or in our test
>>>> infrastructure?
>>>>
>>
>> Or... in my command :)
>>
>>>> Nothing funky in the command line used, you can reproduce it with:
>>>> $ rm -rf ~/.cache/qemu build/
>>>> $ ./configure
>>>> $ ./build/pyvenv/bin/meson test -C build --setup thorough --suite func-quick
>>>> --suite func-thorough -t 5 --print-errorlogs func-ppc-ppc_40p
>>>
>>> Oh, you're running meson test directly.
>>>
>>> The behaviour I describe is wrt the official way of running tests via
>>> 'make check' or 'make check-functional'.
>>>
>>> When you use 'make', we set 'QEMU_TEST_NO_DOWNLOAD=1' when the tests
>>> themselves are run, so only the 'make precache-functional' will be
>>> permitted to try downloading.
>>>
>>
>> Oh thanks, that's what I was missing!
>>
>> I'm running meson because the Makefile wrapper does not allow to pass any
>> additional parameters, or running specific test.
> 
> FWIW, if you want to run a specific test, personally don't use meson
> or make, as you can just invoke the file directly:
> 
>   $ QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>     PYTHONPATH=./python \
>     ./tests/functional/test_x86_cpu_model_versions.py
>
> This was the key feature I wanted when we replaced avocado, as debugging
> tests without a harness getting in the way is much simpler
>

Sounds good, thanks Daniel.

I usually find meson easier to run, since it will build the code also, 
and allow to list all tests easily. I just think the behaviour of 
missing assets relying on precache-functional is a bit awkward (it would 
be more intuitive to gracefully skip the test without needing a special 
env var), but since I'm running an undocumented workflow, I won't insist.

Thanks for all the information.

> With regards,
> Daniel

Regards,
Pierrick

