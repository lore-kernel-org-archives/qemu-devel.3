Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CC3C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh1I-00086B-7i; Mon, 10 Mar 2025 13:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trh0v-0007yF-A2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:34:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trh0t-0004D0-K8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:34:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso11040335e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741628042; x=1742232842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jg0zWXYpu2fbphozPL2KSpBpp+HWeAhMu4HpmKl0nQ=;
 b=dDkLdE1n+d4HeDbCMj0nBMglNq4f+4qomUJQN2NoHMBHn7VhxgfCbBVM6JvtJCgkTw
 oPHo/sSTC/N/soJ5uDmnbN8viYTMravXPzN6gx+dxUE10r6i9HtYxCAQY8agw9GVBv68
 InlgzomSraCrg9b1wEe/8Z8LobBjMhURwjoCzqtN4eMiv9zvTMkyFDhCbzRci9k1ts5+
 GpoyjsgmMV1s6x+Gg98cX7W3OQU1TjJVFA123VHGTEmnO9C255DEixXZOg1HRyWXij2b
 mYxtviwjVmKgUD6+Xi30VVk4u1iiiMWLMQUBGQqdH6EWPL9ATC9Fu9swT5KrYXOf3uhX
 NfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628042; x=1742232842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jg0zWXYpu2fbphozPL2KSpBpp+HWeAhMu4HpmKl0nQ=;
 b=m4eKjMpkqomRdeh6sw8lDOCYrT8WX9CO2zayVaLcHjtUr8bYaOY+GJqsjTkaeaxRAn
 JXaIGT9tGMx3++HAFHn4YuwfAyv6eTRzY83pmE4Z7F7Ww/3A3E7pV9W6sAfHMUx8Q/aw
 KFpcBBZkBG8qVjZG+3TKOYXvp8CEyodP6W0pQb6UmHJx/otAL3Xz/+WYapmjjSoa46dw
 XkT7CTX2NRIv3/utL/KcI+7MyIfSXFvIJdrU9644KDe2ZhBPypZ4hhqvBF1sFw2qg8Jv
 NJf4bQbtagJkpRLWaInya8lobytjDOGk+DNe7rxJ9FsHp34T0U4JuKcucngvHStBX9fV
 Dpxw==
X-Gm-Message-State: AOJu0YxSZOP6mx6EzBhQqCfwDzqvIpvWXWTVEDc8+IpKY+Hk4BxgrbmN
 fLmIl9wMEq3ftecM6kBuuJ47EYIAXe6qaKyPdoavrhlLfjMhVLYU4xPZMLvfJ2E=
X-Gm-Gg: ASbGncvgciZ5ilV/hhezSzdASH40oWjRKZIyrf32rt4IXUNjZUwHGgdECldbOgTQrFi
 p2iQ1Isav0hbH0Bezoe6sY8UpSGX/3y7XVQp8T/h68snNxSZ0H6m9gnGszAAvY7wlcRUZk+/Z9q
 prnvFUuWZf2G7sSYmWqEWxnMmI5c0QGGAK1Z6y4rWAU3936aRTAVu9sgiV7PGpzjF6TBbix8fSv
 YVMfv5+ni7pCFBNcMA0ae0zPixRnbPWtfWicfdpNtP8EiY5mKqtXPh2SxgCd58srK914g1mPMWL
 GQZgtpdgiyQLiMwFJDvVUk3ZGgwWuIo/LItvBg7yxXa3ly1aEgrPGi7eFx4JdxiwnbkHS9r4pRL
 Oh1BEwj+j14aT
X-Google-Smtp-Source: AGHT+IEmFT8Q1kNOjOurF3cEQKLW5FiA/279ZKfLLUwzO6ifuFugjfhFilQ+aTHbtJZR9XCO0fcyLQ==
X-Received: by 2002:a5d:47cc:0:b0:391:10c5:d1ab with SMTP id
 ffacd0b85a97d-39132d062efmr8377689f8f.5.1741628041579; 
 Mon, 10 Mar 2025 10:34:01 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c106a1asm15550549f8f.100.2025.03.10.10.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:34:01 -0700 (PDT)
Message-ID: <2619b843-1938-438f-8c48-e8b188777f31@linaro.org>
Date: Mon, 10 Mar 2025 18:34:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20250310102950.3752908-1-peter.maydell@linaro.org>
 <4842ddd6-acae-457d-8310-d2463773ee1b@linaro.org>
 <CAFEAcA8-AMhHuZXxQHWmkOcWpT0j97Z_s_dtowC-S1f7WzhttA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8-AMhHuZXxQHWmkOcWpT0j97Z_s_dtowC-S1f7WzhttA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/3/25 14:18, Peter Maydell wrote:
> On Mon, 10 Mar 2025 at 13:15, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 10/3/25 11:29, Peter Maydell wrote:
>>> We want to capture potential Rust backtraces on panics in our test
>>> logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=1 in
>>> the add_test_setup environments, so that all our tests get run with
>>> this environment variable set.
>>>
>>> This makes the setting of that variable in the gitlab CI template
>>> redundant, so we can remove it.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    meson.build                         | 9 ++++++---
>>>    .gitlab-ci.d/buildtest-template.yml | 1 -
>>>    2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 8b9fda4d95e..2f373dc675f 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>>
>>>    meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>>>
>>> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
>>> -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
>>> -add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
>>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
>>> +              env: ['RUST_BACKTRACE=1'])
>>> +add_test_setup('slow', exclude_suites: ['thorough'],
>>> +               env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>>> +add_test_setup('thorough',
>>> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
>>
>> Nitpicking, we can keep sorted:
>>
>>            env: ['G_TEST_SLOW=1', 'RUST_BACKTRACE=1', 'SPEED=thorough'])
> 
> That splits up the two envariables that are controlling the
> "run the slow tests" behaviour, though...

I meant:

add_test_setup('slow', exclude_suites: ['thorough'],
                env: ['G_TEST_SLOW=1', 'RUST_BACKTRACE=1', 'SPEED=slow'])
add_test_setup('thorough',
                env: ['G_TEST_SLOW=1', 'RUST_BACKTRACE=1', 
'SPEED=thorough'])

But just nitpicking, not a big deal ;)

