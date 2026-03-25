Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AA6106B505
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5MpR-0005mI-5d; Wed, 25 Mar 2026 07:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5MpP-0005lH-9A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:55:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5MpN-0002VL-2C
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:55:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so4496381f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774439711; x=1775044511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgN1QpQaNg99quW5VwCOD9JM/GQFv0I2PGMuhS7+sis=;
 b=qBYxO7hd6vFjJJFnR8I2CWWegk9UyZ9c5Ikk/pwjRUJmcc7x65iWUZSCspcqE25iUc
 EDjBWhlR1u5Qu5X/GINA/EC4o2Peni7yWKYBdjx1jJRAfK3Va6Y+3UcUTiMz1jcv6FAc
 MOtykAnp1sqM5kngHgO+cjenaFhf8bTNpE4kyLQuZHY8ZV73LXgv9YVI8rS/hWkkeNLf
 ilcu7pWg3F0e15IIhx18EyRDNIBO0db2dfmOitFmJzyFvixTLqY3xVnLq8LxqQvF3dVm
 OqwZiSkNistgVkOMCa0OHWS0jp7ai9z3O9RwfESF3hChZWg//B2uBsBqxQPkYDtyDLc/
 oSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774439711; x=1775044511;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mgN1QpQaNg99quW5VwCOD9JM/GQFv0I2PGMuhS7+sis=;
 b=klbFGUhrgbDD2dqTmka+UAGvXIRGRR7drbHF2qhQQHNhhpBpaCgPYL/yyV9gdw75T7
 3kCz2l4UxowLXBjLSdh6LP4V0WKaCYIw9ks1i/8ggfnHUhRGHzPeQZ91TOvrf4CC6Alh
 zRmz/5rZTZ3HkaOpFY6lMa2namV09A9MnFfkGAwMb+X5/LAVzmh4vjqAwlPPdi4WPia6
 9XYIHSKXSuzJHg6yk+NEghsO6COokXCLquIiK8q9hvbrZErn6L8ZhAK/s4vDV8InNJvY
 CrlHUPtH7orXeu37qkwxOhLcB3/uWpMxLI6BwBfpkbKsAiNAKC1mbjSoS6Y20UujxfTF
 nxFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7UdPBc/FkZM+Q1DFtCDbk1r4dOSGnHkkbFs7sK+Ba0iqUJlzcik6Gsu85klQ6fr1xrz5PtyaD/0w+@nongnu.org
X-Gm-Message-State: AOJu0YxMk7sIK1zqmdNwPzD/e0LXuCODtPsAuksFJj3E9eESowtXoan5
 q0OL9qmvYfdoPfkfPxS34sHTjd4ObaEsd+Gd4pxvvPVROjdArje6TYD+V8mhJgVADWg=
X-Gm-Gg: ATEYQzwu/8n8aRe/XY3hICAO/7L2EDvq6K52I7bM/gJtWW1B23u7ZOpfA6PC8ZTCGJi
 mBLUttFXmVT+gcIR3IeKhs7UNm8yrliPfjVCSf8XP9vTNleSSHSijQ1xZRunhrzbQFzAbvKhu00
 dnPWIrCcvOLLIWi8dXuzqG63ljtiONscVpF6xxpxa2I0ejouFn3GdPdBZjTZMUaKEEOQgR7/c44
 vPM03jsCbmM90W5AotJPL64JktKndagWG22IzbECT1t1A0HcTGHUOqjEM2thAAx/ADWTzL7k9cI
 fPFisu6KTQgXE5DXjPAdsED8G71AdZfgPFhsSEWw6FnZjqpYyib/S8tAusjRE6TRR6XbkFzHTky
 F0OMnLXBf1H9uwv9yfESiqdjQLc63qzOaQy308fnf6HiGo/9DqQrJvZ0PQcftwYefreN9LgSDG1
 KfzqpRyIYD501DwH31FT5Wl78nl3hRYTq/49vxWAILcfQ3Enx/FPxwNeCPm9u8QmQJdg==
X-Received: by 2002:a05:6000:2502:b0:43b:6345:8d72 with SMTP id
 ffacd0b85a97d-43b889aebabmr4473393f8f.12.1774439710992; 
 Wed, 25 Mar 2026 04:55:10 -0700 (PDT)
Received: from [192.168.69.229] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd923sm53551412f8f.12.2026.03.25.04.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 04:55:10 -0700 (PDT)
Message-ID: <f3045c88-c64b-45ea-a372-3627cb3b4b01@linaro.org>
Date: Wed, 25 Mar 2026 12:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU requires a 64-bit CPU host architecture?
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
 <fc32bb67-ea52-4244-9ad7-c18db3be339e@tls.msk.ru>
 <acOoVWw3jXfkfion@redhat.com>
 <CAFEAcA-Jzh0Wan9Dh+Pe9S3cHPeexV5mLaD+juXS8L9eMMd43g@mail.gmail.com>
 <d2db3893-7691-4707-8f43-341d09ceac97@linaro.org>
In-Reply-To: <d2db3893-7691-4707-8f43-341d09ceac97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/3/26 12:21, Philippe Mathieu-Daudé wrote:
> On 25/3/26 11:24, Peter Maydell wrote:
>> On Wed, 25 Mar 2026 at 09:19, Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>>
>>> On Wed, Mar 25, 2026 at 11:08:41AM +0300, Michael Tokarev wrote:
>>>> On 20.03.2026 09:45, Michael Tokarev wrote:
>>>>> Hi!
>>>>>
>>>>> Is it intentional that qemu does not build utilities on 32bit hosts
>>>>> anymore?
>>>>
>>>> This is
>>>>
>>>> commit 372ec46b9f1215f48a4717f2b7ed969f65bfadc6
>>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>>> Date:   Thu Dec 18 09:56:27 2025 +1100
>>>>
>>>>      meson: Reject 32-bit hosts
>>>>
>>>>      32-bit hosts have been deprecated since 10.0.
>>>>
>>>> How would one build qemu-img and especially qemu-guest-agent, say,
>>>> on i386 or armhf?
>>>>
>>>> I tried removing this error message from meson.build (in $subject),
>>>> but it fails to build even the qga due to errors in atomic.h, -
>>>> even if these aren't used by qga.
>>>>
>>>> That smells like a bad decision, - to drop qga and qemu-img support
>>>> on 32bit architectures.  Especially qga.
>>>
>>> IMHO dropping the block related tools is reasonable, as if you keep
>>> that, the dependencies that need to remain 32-bit compatible ripple
>>> out across a very large part of the codebase.
>>>
>>> Not having qga though feels like a pretty undesirable consequence,
>>> given our message overall is that we were dropping host support but
>>> keeping 32-bit emulation.
>>
>> Yes, I'm not sure we quite realised that we would be no longer
>> building QGA for 32-bits. How much effort would it be to
>> reinstate that?
> 
>  From the commits in 5053e0a65db...90e2e8ada7c we'd need to (partially)
> revert various of the buildsys ones (meson & configure).

Assuming this buildsys part, ...

> Then we'd need to check if the Stat64 API (90e2e8ada7c) was used by
> the block tools, and if so also revert the atomic64 patches (around
> 997d86a9bb1). If not some (sane) refactor is needed for some core
> components (disentangle qdev from qom due to the atomic uses). Still
> we rely heavily on atomic helpers for threads and co-routines used
> by the block layer (and also to reference the QOM objects...).

... then the single issue in QOM is the object_class_property_init_all()
(due to sysemu GlobalProperty) which can be stubbed, ...

... then the only problem left is what util/qsp.c defines:

- qemu_mutex_lock_func()
- qemu_cond_wait_func()
- qemu_cond_timedwait_func()

If we can provide a 32-bit version of these the qga links (not sure
it makes sense although).

> 
> How / where would we test that (and for how long)?


