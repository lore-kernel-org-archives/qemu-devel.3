Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F13EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbQv-0002iH-UP; Thu, 01 May 2025 17:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAbQG-00019v-3H
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:26:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAbQE-0002fC-3Y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:26:23 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3014678689aso1222133a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134779; x=1746739579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHNLSVJxNqeUIWo7DOe5B85qEa3xaCP8N4BLRYQ/8GI=;
 b=boolaVNk32U0PuX0GbdTbzmJu0cWtnCGEuq1iegXJXYFS37/lbALiHNgKgdISbh153
 zH1TLsruPjVrBzPBL85DooE8pIg7HFcPq+O7J0Yb8V4u5xTKuer0+GV33ARx6Bn4n8EP
 5Urukx5BGoQsxzTRmWuV/K97spL9o72b/pA99NQWr53ZsWrsDMhOr/AlH3ypmF3e7X2z
 esGeK+X5qZVWn2jPmbI3uv/kedNDb4UOrQKqbxG4AXcNt3ixw+OpAPFv9ucqC7JW4R61
 nyAz959iqCQXhCoqaboN43gG1rV7p18Mv1iGOsSEG5MVdnc8TuXika8marGeB7wLxqHS
 Qz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134779; x=1746739579;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHNLSVJxNqeUIWo7DOe5B85qEa3xaCP8N4BLRYQ/8GI=;
 b=H05y26ZXYqST2kPbn5i2DRX0bi57ssq5MwOejdl4rOObT0daJxeH9N5PQ6Yt5xXypO
 GCy2htyiFoxkIzBde2y4zH5dj5jjRF8jLWRMdMElEe2/duDFvuunqA1iN5b4aC8ATUA6
 vhyhOjB3WPoF8/vTnkMeGiQYXB0YD1ig/EIwCf4jFHlDqUvsMzdOuqjMf2pRsl2k7XuY
 smuTutw3tasPdymx7wPWK8Ctx8Rzb8BwTX2rWqqzrZ4oU7L2CM75IUh3ElpB53Z7JpDZ
 sx9iN1Lh58TKIxmN9shISF6VOecNVKqQ9fAgEXPF6OGnIY4zsHNIF8FJgzn8UdDIMbDG
 5apA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGG1rS11ssoQxnTPVaFoca8uK81IUNvsI6GWLag8unDMmFbvZ2DkpNnPGJCf2S17dHDDUCGzjxYRo@nongnu.org
X-Gm-Message-State: AOJu0YyN/C/Lb3TiDkba4ijqtLDW5PXIGkaDHIMWRcLvznmci1Ne3CSJ
 gHAfuXRJFLwmW6pmDHmqN4L/pv9YGkFeRpDTrehdItvMY91n0mpgIsmUx1WBk84Ov539Oucrg6u
 B
X-Gm-Gg: ASbGncuq5WnpRVm44YPcmKF6yGzZEhHVhSSKWrATu9pPzRAPfF5Kl7+8kObSR9SWGhC
 7YYQzcVGIxR6OR3ACzZG9NPhMuAWV0WHUX0JcQCHTQH4Y1rdo7je80va+RZv4MNW7rhG5MXzPds
 VOkO8XEc6wZ9OLGp3SLDech7nZ6K7LbVWYy4FnhSJfJVsWa2o90wEQ1lgRX1B6uwoXxGpW0Kduq
 u9OM7FQjQrCYa6PacN/tpTEU/dEssmruzYrpDNe8KlaMYV+nUX1wFS9g9dku68dv6FkjLvjxY8z
 MXfBT0WUTUVHnkWkpz4loGcsLMqXo4+gEv2/Zh/dSosvj4QuIs4HzQ==
X-Google-Smtp-Source: AGHT+IHf0hl6cFwejEjiCi1MtUU8OpQJmbfdywE+7PJQOWqStW82tbuDTIEdfuK2dGMsW40c6011QA==
X-Received: by 2002:a17:90b:5626:b0:2f7:4cce:ae37 with SMTP id
 98e67ed59e1d1-30a4e5c165amr1183572a91.18.1746134779238; 
 Thu, 01 May 2025 14:26:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34778329sm4124069a91.28.2025.05.01.14.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 14:26:18 -0700 (PDT)
Message-ID: <90c34e5a-c98b-4ee1-a176-d747c47b853b@linaro.org>
Date: Thu, 1 May 2025 14:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
 <CAFEAcA-G7exikg_qa7USDvfo0+ZTLUiymfDiqK6wLTZmebv4kQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-G7exikg_qa7USDvfo0+ZTLUiymfDiqK6wLTZmebv4kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 5/1/25 10:56 AM, Peter Maydell wrote:
> On Wed, 30 Apr 2025 at 17:41, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> FWIW, if you want to run a specific test, personally don't use meson
>> or make, as you can just invoke the file directly:
>>
>>   $ QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>>     PYTHONPATH=./python \
>>     ./tests/functional/test_x86_cpu_model_versions.py
> 
> The rune in docs/devel says you also need to:
>   * put tests/functional on the PYTHONPATH too
>   * run from the build tree, not the source tree
>   * run using the python binary in pyvenv/
> 
> So you can do this, but it's pretty clunky; I have to
> look up the runes every time. It would be nice if there
> was a wrapper to do this for you.
> 

I think that meson test command is pretty easy and "standard" (once 
learned, you can apply this to any other project using meson test 
infrastructure), so maybe it's the wrapper we could be interested to 
promote.

If we go this way, two things would be interesting to change:
- enable setup thorough by default, so all tests are visible by default 
(instead of having to dive into tests/meson.build, and understand which 
setup does what). make check-functional can still restrict the setup, 
it's not a problem.
- abort gracefully (without needing an extra env var) when an asset is 
missing and can't be downloaded, with a different error than 404.

With those two changes, "meson test" does all we need, including the 
build, in an intuitive and standard way.

> (Also it doesn't work if the thing you're trying to test
> is "does this test pass within the meson test timeout" :-))
> 
> IIRC there is also a rune for "run a single test within make/meson",
> but I forget what it is and docs/devel/testing/functional.rst
> doesn't mention it.
>

I agree with you that even though it's possible, it's something you need 
to check in the documentation everytime, which is not convenient.

> thanks
> -- PMM


