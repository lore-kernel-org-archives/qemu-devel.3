Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440ACC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGj-0007Cs-UF; Tue, 06 May 2025 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCKGI-0006Jh-Jc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:31:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCKGE-0002IW-Oc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:31:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2241053582dso90069195ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746545469; x=1747150269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vv4zdKiLL1zuO/WYVUemEt/x+NwYhTVaTgOKeyQbBWw=;
 b=ApSpQiPUljMBU/VQPzOiBIVxacy1j/yKil9m6Jua083m1dO2YJQ/sb13ynugFRDTsm
 +9JUlhFRTjhflNtGyFOZb1M1Ye7tpxSeuRTRTY0ON/txeornBvoyw7XbRx1i53nnrs3u
 NKXeasX+42xagOJNvw6D+iv9Tl8bPCdCbDNvrgHGmcJCstmfyWH3ZGpP2QF9lyLDddP0
 mNDc3LXCa5pwvJVDz72muKsLl9FSdXKFGazq+hzKRNxMUCaRzMCh1h3Z9EsRyn+INa07
 rAyfmjG381IYjfAhjxVwBeee0DNl7QOsEwCL2wdhYUw+4uOLRf7t9OpA/BlNxC+jb1rB
 RqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545469; x=1747150269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vv4zdKiLL1zuO/WYVUemEt/x+NwYhTVaTgOKeyQbBWw=;
 b=Yq0MrP1LmWql1qixr/L7usEi1WfMFy2mUNfxtbieX82ChzcNJAcJ4+adfFKi4G+eDY
 Rtk5o0uvXVv9GXvm7Y++aWfHfbk/wjKgdXPMVgBOPivg8Ol5AaqD5DNZxX5VdiUDYY5h
 swkUUVMqvzt+77DcxSufzvFRIzZciIBk6OAayMnlyuPD/U0G8qATmzexUqPnZBOLjLHE
 iX1H+izlTWDWgX7TZZxI/Kvo5eHAbACYbp3vi3NTlMXs9HS7DSxMvMY3+XzNZdgdzPzx
 zOKVnt92p29AvHr1I+GzprrgPg+ZY9RTYZNp2gbBOvZ5Nd3lqnUVyM96MA7zzdY7q6W1
 GrYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMJD1+b2c7FR8PZf8BOYR4BbJimZ52/Dj2mZU3COB+n/+cMwwdD1HutYRZud0UswsyoUbZu7Xm1MIH@nongnu.org
X-Gm-Message-State: AOJu0Yx+nsFm8kwPue1IaNo0wSq+5WvjgBHMMh1be+Mo/vadjHrrmL33
 fcIPDhf2Vu6EWz87rECNzhDeyeAjklSgM8YxS0aI0V74JQyLOpnCxF4Jv4rKh9U=
X-Gm-Gg: ASbGncuN3Ux0o/rm5ZQRTvc7eiz8PqnhvJ1KvQZJe0Kiy+J3Jv+TJ01ARq4zF1SLYBI
 1ydCgZ2dJ7AEzTztde/EJUjsI3vDjMWZq9+VKemDiIEz8dWUzZAxwJ7wCMJcWmNaKuFHV5mATMu
 O1N3xrAVgsZSEDxSK2mTYop3Mrff3++2eztHegt1SFj0wFraY2rmE3t4syxTz6CPut5IIP31kMw
 PpbSNafWlOZzl9zusFFgfXkvgOHkodJv4wYRSS3D8wntBG3+VqlmxmYsxuCBMlcOqDlyCls065W
 TV6CtUvkwfQ4TcJhVBY0RyZQ6kwi6lTsZjn584zNFQf8rLwgjRK+kA==
X-Google-Smtp-Source: AGHT+IFEr+f9kmmUEKGS9lPeuY7rpKcN8zZ4qtqFvcesbfTCGNMm62UjXSCaWiLNobx6od0QyQiAJg==
X-Received: by 2002:a17:902:d4cc:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-22e32ba6cf8mr46674685ad.26.1746545468644; 
 Tue, 06 May 2025 08:31:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eae74sm75602855ad.29.2025.05.06.08.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 08:31:08 -0700 (PDT)
Message-ID: <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
Date: Tue, 6 May 2025 08:31:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBnXXC3ldqErl8ub@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/6/25 2:33 AM, Daniel P. Berrangé wrote:
> On Mon, May 05, 2025 at 10:46:52AM -0700, Pierrick Bouvier wrote:
>> On 5/5/25 3:32 AM, Thomas Huth wrote:
>>> On 03/05/2025 22.18, Pierrick Bouvier wrote:
>>>> Allows all tests to be visible by default when using meson test
>>>> directly.
>>>>
>>>> This has no impact on make check-* commands, which use SPEED=quick by
>>>> default (see scripts/mtest2make.py).
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     meson.build | 5 +++--
>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index f8bf6e7bb66..57ff3f722d8 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>>>     meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>>>> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
>>>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>>>>                    env: ['RUST_BACKTRACE=1'])
>>>>     add_test_setup('slow', exclude_suites: ['thorough'],
>>>>                    env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>>>>     add_test_setup('thorough',
>>>> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
>>>> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
>>>> +               is_default: true)
>>>
>>> I'd rather not make it the default: The thorough functional tests download a
>>> lot of assets from the internet, so if someone just runs "meson test"
>>> without further parameters, I think we should not trigger these downloads in
>>> that case.
>>>
>>
>> $ cat tests/Makefile.include
>> ...
>> check-functional:
>> 	@$(NINJA) precache-functional
>> 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
>> ...
>>
>> What's the rationale to run check-func with SPEED=thorough and
>> QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only quick
>> tests by default?
> 
> Are you sure about that ? The precache logic uses custom_target() in
> meson and so does not filters on "suites" used to define quick vs
> thorough tests.
> 

My bad, I missed the "foreach speed : ['quick', 'thorough']" wrapping 
all this in tests/functional/meson.build.

> IOW, precache should always be downloading all assets.
> 

Then I don't understand the previous argument from Thomas to not make 
thorough the default: "The thorough functional tests download a
lot of assets from the internet, so if someone just runs "meson test"
without further parameters, I think we should not trigger these 
downloads in that case". It's what precache-functional is doing.

>> Either we should remove SPEED=thorough, or download all tests by default.
>>
>>>     Thomas
>>>
>>
> 
> With regards,
> Daniel


