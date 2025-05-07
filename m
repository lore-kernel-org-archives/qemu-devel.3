Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F5C3ABB6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZO4-0007qJ-V9; Wed, 07 May 2025 03:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCZNv-0007mb-DV
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCZNt-0008MJ-Ai
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746603600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kdTStmI8S3xf59FNCJ7H1BSwv1b6IPx/DwrLy3JB/nU=;
 b=DLwHYFtOCV3uweLvdRJCwoQhz9KzgPPVKRFzxm8XDnMTSdpD6KLfYyY8ZxLxvQnZtdnYAM
 12TxyvN0bVzhnsUwoEBP7QCyJb05DGil13xZ0mupucgPxWkqvhOTPVbSiWofGQc/tkdqjQ
 Qit3/DA/vPRXBVQSu3IOMjKeS9E7rFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-MjF1B2ZEPw6dVrftbe7-dQ-1; Wed, 07 May 2025 03:39:59 -0400
X-MC-Unique: MjF1B2ZEPw6dVrftbe7-dQ-1
X-Mimecast-MFC-AGG-ID: MjF1B2ZEPw6dVrftbe7-dQ_1746603598
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so2634165e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 00:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746603598; x=1747208398;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdTStmI8S3xf59FNCJ7H1BSwv1b6IPx/DwrLy3JB/nU=;
 b=NGMxIRhJSFXqHgo8jjkdM4r60Xfae0Q2MGQc3WB+uiRnUaL4CEC+wNDNVvlQYj0ork
 GiG9F0ig1baltAOUS0KknRL5BVFS2OAMZq6Of9Nnn5aMGbhh4aiz0+n/SsmFXaugb0Ih
 G/Kb/h8bjJ9dTOvYjaEYZR1hzCfMXwwBoZsjz4wvw9uXeSVqF2B65AGWb95qaEP72o5g
 sgcOERqvbwiei+u/SE1HoYQqpyTSR2UH4OU6B8RlWWYZGQvFJrFSPC2EgmisforGyrLW
 dyiewrs0YzBuNQzs5p/3WChD9bF4gbLi4nxJxMFIboEgnA/wcctYL98efqmV7XqPoN01
 qJLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTN/5GWipgBP2lg+cmcmOXNGbr4LWPh2wsgtvXDpoPhrG6v9u1yxNIA8ChW/4PNPv5Q9dYjUmelmTr@nongnu.org
X-Gm-Message-State: AOJu0YzBuIo1i2PhYS+5kgzu0BOe8YeRJoNyRi/L6Aq7YLLLoixjQDKN
 EYMcHiKdCYtGT2txQVpHjL2U/Hjh5rmWECMHEQRQN9uIUqJMqsiGT0tC6wq4hu6wz7Q7GE/ZN3u
 z3ivQ5Li6Logwr2dv6yQawv06ExqV4MobsZw8rbjAEXQ9XfPY5WXi
X-Gm-Gg: ASbGncs4/G/Zle3EGQcefE8nCc5iMq4y5Bike+yiqS6zYACgO+SPoG4WVEIMF/OnrG+
 R+07zfeyPWLEpVOGj9c5JCys/xV7mDAZdevc6vxAwuEnvJ0XT5YHxbj7iH3upN0pejyf6/s/pN+
 FwVyh71Uwal5c9EBgtT6iB9d9i5Vwl6RLXzLh7q5dUzCG8Aw30cqWkJHC+4fpuAQFL9qq+3NcXg
 kRD4uHyOx/YpvCOGMmPHFV4Ffy+CqhoIsV/nx9vaPPv6XmFBJhVpV16/gpymsVh18dcI5cY6HdW
 WPet6djjTtEXYR37W3HUjo5tlqWVn4rjiDUwsJwQljYhU3GipI/j
X-Received: by 2002:a05:600c:64c8:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-441d44a9cb1mr20303385e9.14.1746603597648; 
 Wed, 07 May 2025 00:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEljfmdIFPvXJ6E+lMoOCagyen1p2pwylsWNt7BiRrNUoaLMmat/v5cKqX9Rnjn/layc8fNmA==
X-Received: by 2002:a05:600c:64c8:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-441d44a9cb1mr20302925e9.14.1746603597136; 
 Wed, 07 May 2025 00:39:57 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d43465besm21593595e9.16.2025.05.07.00.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 00:39:56 -0700 (PDT)
Message-ID: <51c4e997-8ae4-43a5-81b7-561c035ba85c@redhat.com>
Date: Wed, 7 May 2025 09:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
 <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
 <aBsISp5UvOLzFhqn@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aBsISp5UvOLzFhqn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/05/2025 09.14, Daniel P. Berrangé wrote:
> On Tue, May 06, 2025 at 07:12:53PM +0200, Thomas Huth wrote:
>> On 06/05/2025 17.31, Pierrick Bouvier wrote:
>>> On 5/6/25 2:33 AM, Daniel P. Berrangé wrote:
>>>> On Mon, May 05, 2025 at 10:46:52AM -0700, Pierrick Bouvier wrote:
>>>>> On 5/5/25 3:32 AM, Thomas Huth wrote:
>>>>>> On 03/05/2025 22.18, Pierrick Bouvier wrote:
>>>>>>> Allows all tests to be visible by default when using meson test
>>>>>>> directly.
>>>>>>>
>>>>>>> This has no impact on make check-* commands, which use SPEED=quick by
>>>>>>> default (see scripts/mtest2make.py).
>>>>>>>
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>> ---
>>>>>>>      meson.build | 5 +++--
>>>>>>>      1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/meson.build b/meson.build
>>>>>>> index f8bf6e7bb66..57ff3f722d8 100644
>>>>>>> --- a/meson.build
>>>>>>> +++ b/meson.build
>>>>>>> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>>>>>>      meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>>>>>>> -add_test_setup('quick', exclude_suites: ['slow',
>>>>>>> 'thorough'], is_default: true,
>>>>>>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>>>>>>>                     env: ['RUST_BACKTRACE=1'])
>>>>>>>      add_test_setup('slow', exclude_suites: ['thorough'],
>>>>>>>                     env: ['G_TEST_SLOW=1', 'SPEED=slow',
>>>>>>> 'RUST_BACKTRACE=1'])
>>>>>>>      add_test_setup('thorough',
>>>>>>> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
>>>>>>> 'RUST_BACKTRACE=1'])
>>>>>>> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
>>>>>>> 'RUST_BACKTRACE=1'],
>>>>>>> +               is_default: true)
>>>>>>
>>>>>> I'd rather not make it the default: The thorough functional
>>>>>> tests download a
>>>>>> lot of assets from the internet, so if someone just runs "meson test"
>>>>>> without further parameters, I think we should not trigger
>>>>>> these downloads in
>>>>>> that case.
>>>>>>
>>>>>
>>>>> $ cat tests/Makefile.include
>>>>> ...
>>>>> check-functional:
>>>>>      @$(NINJA) precache-functional
>>>>>      @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
>>>>> ...
>>>>>
>>>>> What's the rationale to run check-func with SPEED=thorough and
>>>>> QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only quick
>>>>> tests by default?
>>>>
>>>> Are you sure about that ? The precache logic uses custom_target() in
>>>> meson and so does not filters on "suites" used to define quick vs
>>>> thorough tests.
>>>>
>>>
>>> My bad, I missed the "foreach speed : ['quick', 'thorough']" wrapping
>>> all this in tests/functional/meson.build.
>>>
>>>> IOW, precache should always be downloading all assets.
>>>>
>>>
>>> Then I don't understand the previous argument from Thomas to not make
>>> thorough the default: "The thorough functional tests download a
>>> lot of assets from the internet, so if someone just runs "meson test"
>>> without further parameters, I think we should not trigger these
>>> downloads in that case". It's what precache-functional is doing.
>>
>> precache-functional is *only* called when you run "make check-functional",
>> i.e. when you know that you want to run the functional tests that might
>> download assets from the internet. It's not called when you run the normal
>> "make check".
> 
> Are you sure ?  If that's the case it was *not* my intention when i
> added precaching - I thought that "make check"  would call
> "make check-functional" and thus trigger precaching ?

"check-functional" is not part of the normal "check" target - on purpose 
since we don't want to trigger downloads by surprise when people just run 
"make check". That's also why we have separate "functional" CI jobs in the 
gitlab CI, since otherwise this would be handled by the normal "check" jobs 
already.

  Thomas


