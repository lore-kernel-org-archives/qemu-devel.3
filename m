Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D583CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 23:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwr3b-0001vG-R5; Thu, 11 Sep 2025 19:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uwr3a-0001uT-B6
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 19:50:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uwr3Y-0004rq-MQ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 19:50:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-772488c78bcso1225117b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757634622; x=1758239422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcQGAek4i81asZ4bL6G/L8o9wAK6+elN8NwZki5kqJY=;
 b=mFm5pJAhiS7QpVaIMlVae/bXtXuzb7lc8+y+gidoaFdSqMsAbp8Xf34QgBYcy17Jh5
 8WPL/7rsiWq5ol+0N1xVIxay3bVSNiHfeUQykHt+wmgVn+hOogAeyFuEn8Q/UM4CWTyk
 ZVghceh5WrFQLeHsP6ZyCqsDzdPKv9Xu7ffWHmy3Ubs1lNfOhJ3g7MkHBQYY/uWekqO8
 W4kq9QnHP88QaE7g7RMajfbGot8cRU8Qw3qeEYHs3WXnBiJPHXYj2jdBYl+FGeVkAJAO
 FBLzFZ7W24vfyilsMeosFaZ/jxkM7ZYdEsanACXXH9oLqs5nFA6HRaRXGsGgP7APP39y
 RE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757634622; x=1758239422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcQGAek4i81asZ4bL6G/L8o9wAK6+elN8NwZki5kqJY=;
 b=iqMk19jQjAFjBDxBigrieudeq/gOYmvqHPsWTtd6+HPbQ1S6PqoIbBePZBe5uz5Kcy
 3PlamS5fQ7sRHWagwXVf47iqmwTbu3SWfu/r1PHxEp2zcgOiiVjn62OVy56vLANuX15n
 BCaw7MX508rMj1y4qRC3u5kxG+NiWFnMcEyNvji643/Bzd/7wt+qN08+eggFBRTwR6Ch
 Xg3/nUsM9NyxG+PuozBmRlC/VxuBD0KOqSxAQ295DXVsB9hYpfQb84thVH74odStfhAv
 eAnvN1ItXgRqXmpq7vuMdn3xjDYRe8QBb9l9qqx5P/7a6oZSlVkYEvZiLTptOc2zqAuW
 wOSg==
X-Gm-Message-State: AOJu0YziClsntAFb41jsi6ljztYBpe4P1mFStnzl2rUBM/ZQBfmKM97w
 wu/o5VyVNigDVCP9ekl/0gYUxI1cmjDWv3TEBPA/hDl/30gdoSq+9cXneKT1ABJZw1A=
X-Gm-Gg: ASbGncsCpqlQwofwFlVcDw71bAaZ0qCw4S17W9sNGnrSvzSSG3Cd99eCVEuzBprJSwc
 s1i68iHgUlvFXVkwdCs8nYaWgkQLf6/b4HSdeHS1S2YrgdWVvqOVmV/Ft6Blql09RoUbdJp1tyA
 pZUnjlsZJH8QOsgRoPeZumkDndqwhpup/AjNOf27RHYUiINsNjU1/FJsSfMQoproeeW+kZfBdJx
 ehODWyNSBXVQqc/zDuemYJdiC4vgETPfFOTecmGylUTawPFq+Sn+a1ylJU751ZR01cmHQsolHj1
 KbrI08m2IzGXnJLzg3evOX2tuzKxmWKwjWUWxR0/YqbMmiF1o0cBeygpHRgFES2c65ZqP8iKyDj
 Ewl0ARANxHcWNAZ+RJRl0ygZjbdToS0Vg4Q==
X-Google-Smtp-Source: AGHT+IHrxqYkbC2JUsHaN0b2hx+2PL+gmS18n2lRi+YGUsqDJwJHLcuQUWzyv6XXk8XOeh41/tHXZg==
X-Received: by 2002:a05:6a00:17a5:b0:770:48cf:83f5 with SMTP id
 d2e1a72fcca58-77612095a9cmr1249840b3a.14.1757634622222; 
 Thu, 11 Sep 2025 16:50:22 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.55.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607b347f8sm3287493b3a.82.2025.09.11.16.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 16:50:21 -0700 (PDT)
Message-ID: <9aa2f190-0bd7-4c54-b2a2-cdd67ec7023c@linaro.org>
Date: Thu, 11 Sep 2025 20:50:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-6-gustavo.romero@linaro.org>
 <aL6e8PyjsfK0Wx70@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aL6e8PyjsfK0Wx70@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel!

On 9/8/25 06:16, Daniel P. Berrangé wrote:
> On Thu, Sep 04, 2025 at 03:46:40PM +0000, Gustavo Romero wrote:
>> This commit removes Avocado as a dependency for running the
>> reverse_debugging test.
>>
>> The main benefit, beyond eliminating an extra dependency, is that there
>> is no longer any need to handle GDB packets manually. This removes the
>> need for ad-hoc functions dealing with endianness and arch-specific
>> register numbers, making the test easier to read. The timeout variable
>> is also removed, since Meson now manages timeouts automatically.
>>
>> The reverse_debugging test is now executed through a runner, because it
>> requires GDB in addition to QMP. The runner is responsible for invoking
>> GDB with the appropriate arguments and for passing the test script to
>> GDB.
>>
>> Since the test now runs inside GDB, its output, particularly from
>> 'stepi' commands, which cannot be disabled, interleaves with the TAP
>> output from unittest. To avoid this conflict, the test no longer uses
>> Meson’s 'tap' protocol and instead relies on the simpler 'exitcode'
>> protocol.
>>
>> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
>> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
>> before running 'make check-functional' or 'meson test [...]'.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/functional/aarch64/meson.build          |   7 +-
>>   .../functional/aarch64/test_reverse_debug.py  |  15 +-
>>   tests/functional/ppc64/meson.build            |   7 +-
>>   tests/functional/ppc64/test_reverse_debug.py  |  17 +-
>>   tests/functional/reverse_debugging.py         | 175 +++++++++---------
>>   tests/functional/x86_64/meson.build           |   7 +-
>>   tests/functional/x86_64/test_reverse_debug.py |  21 +--
>>   7 files changed, 131 insertions(+), 118 deletions(-)
>>
>> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
>> index 04846c6eb1..4f3168dd55 100644
>> --- a/tests/functional/aarch64/meson.build
>> +++ b/tests/functional/aarch64/meson.build
>> @@ -32,7 +32,6 @@ tests_aarch64_system_thorough = [
>>     'raspi3',
>>     'raspi4',
>>     'replay',
>> -  'reverse_debug',
>>     'rme_virt',
>>     'rme_sbsaref',
>>     'sbsaref',
>> @@ -46,3 +45,9 @@ tests_aarch64_system_thorough = [
>>     'xen',
>>     'xlnx_versal',
>>   ]
>> +
>> +if is_variable('gdb_runner')
>> +tests_aarch64_system_thorough_with_runner = [
>> +    ['reverse_debug', gdb_runner, 'exitcode'],
>> +]
>> +endif
> 
> Why do you need to replace the of 'tap' with 'exitcode' for this script ?
> 
> I don't like the idea that a subset of our functional tests are not using
> the TAP protocol.

Unfortunately, the GDB Python API seems to be broken regarding being able
to redirect GDB's output to a file (as it's possible to do via GDB's prompt)
so we can't redirect the printed addresses that are printed after each "stepi"
command in the test script. As a consequence Meson's TAP gets confused with
it and fails the test. Since I could not find any directive in QEMU functional
tests that forbid using the classic exitcode, I used it, at least while
the GDB redirect is not fixed.

Why don't you like it?


Cheers,
Gustavo

