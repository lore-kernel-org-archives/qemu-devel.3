Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38FDE69E82
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 18:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIB4w-0001OG-VL; Mon, 02 Dec 2024 13:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIB4v-0001Ny-Bd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:23:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIB4t-0007l9-MT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:23:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so2203991f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733163799; x=1733768599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BLqvomvrOhRVHWAomKgFPlzcG1WvnnH7KNzYDnVq1k=;
 b=ARFvDpZAn+2Vvdqk4xK1M1r+dwZvkmtHLmpHRKCnSmNMV9I26NMJf8Pks3MOHYT6JN
 8bV82wvl6byLwKxQ4IuQa8R2dzdZQjDCvs0iOksaSSfxc5SBS9QIUOeyY4QwIZndoEVn
 W2OI/namy3g0FQwqwA+iJDwnnsETpJQ405aa9wi98/QimorizCbk14cd9FxKxNksaJA4
 bhybY6tjFn+8A5X44qb8blaP91Nq34KvL7Giwy0f2d64JqaiMJNlv1CN9swB7Z+laQy2
 K/vT+q/xRoEmSD95CPR3PB/+7OLvAZ30h+56ea9SCqzJynFXme59AJMP7rejZ4wKIMe4
 R4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733163799; x=1733768599;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9BLqvomvrOhRVHWAomKgFPlzcG1WvnnH7KNzYDnVq1k=;
 b=kRtXpYNWgmumdq1p5d2GG673DglIP+GPhKTJ7gWaYWjnTqfoVA8m5/03bziZn6K7Kh
 tkJcbZQ1HkP22wyEKgchh1RVwnF+jM3BREMZ5Em3nONMVxyRJ5fNLg1sY/aEzsIza7ce
 ZJmNyRTkt6nJw6k/KGfoQCBT2IcNUPiBNwAxTVjyQ5/9HmICBOw2oJr4aigYeS82MddK
 gka0RFj2+gbWSbVl5CD96qr6nHjBdYxPVjUzkvdlSmiYSWMqPbvSqtJ9MACe8Ed17E0p
 fYIvoEM61FjDueowu763hranrKN+muG62zsUm3992MA7RrAgC+QHr/ts8fEGx3grk0se
 6hvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4nMfhWRaqG36qvqta7W6KwxbQaZqt4A9Sa15CPK1JhwjQyUTsa2DJmJyufNLB59fTzcm8uitro1vw@nongnu.org
X-Gm-Message-State: AOJu0Yzk+Kb7l2+IoWBcTfDifYewoDnf5n/y6oPHeqWiY0oN00WTtWrN
 oYDleV+j0O43xP+GC7WsnvMNTIXE3zWky+Scpgud4kLM7rzEywP0yfGsgCRk5Uc=
X-Gm-Gg: ASbGnct1rpqoPOUWjBcEleDrvBA/Z0iliEYgkad0zRTsQM0AueV1Ys4WAnAT0oZ+gMC
 1ARlNAlrN0tX3p35p4tEUfm3y9O9N/mT1xKf8fiTpHeTlGX7AcAinpHiaK8bvIQ2cPhROv+8HKe
 f+vmAforttI1R0NgU6hBvuP86RsWFRsBqRAbMqPl0WUe7RUrJx6uuRPXg+tmqwz50BBDeuEUGvY
 LCAW7+yaqFv59QaqpOKtFC0gDj7+YG0qeyh2aqzEX13IIyH
X-Google-Smtp-Source: AGHT+IG9uq3KCQAuJG1+IYQ5Ic8K44TjqEMsJMjld2Zi35e8jHwkugaShR530KezSDPGomA0+vU6rg==
X-Received: by 2002:a05:6000:401e:b0:385:f89a:401c with SMTP id
 ffacd0b85a97d-385f89a40f4mr2703726f8f.17.1733163799441; 
 Mon, 02 Dec 2024 10:23:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d7f103e0sm11608604f8f.19.2024.12.02.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 10:23:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED1A25F767;
 Mon,  2 Dec 2024 18:23:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  qemu-devel@nongnu.org,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Troy Lee <leetroy@gmail.com>,  Alistair Francis
 <alistair@alistair23.me>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  qemu-arm@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,  Joel Stanley
 <joel@jms.id.au>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
In-Reply-To: <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org> (Pierrick
 Bouvier's message of "Mon, 2 Dec 2024 09:31:24 -0800")
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Dec 2024 18:23:17 +0000
Message-ID: <87ser6c5be.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 12/2/24 02:57, Peter Maydell wrote:
>> On Sun, 1 Dec 2024 at 18:09, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> Hi Marcin,
>>>
>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>>> W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
>>>>> This boot an OP-TEE environment, and launch a nested guest VM inside =
it
>>>>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.bu=
ild
>>>>> index 5c048cfac6d..b975a1560df 100644
>>>>> --- a/tests/functional/meson.build
>>>>> +++ b/tests/functional/meson.build
>>>>> @@ -13,6 +13,8 @@ endif
>>>>>     test_timeouts =3D {
>>>>>       'aarch64_aspeed' : 600,
>>>>>       'aarch64_raspi4' : 480,
>>>>
>>>>> +  'aarch64_rme_virt' : 720,
>>>>
>>>> Took 2974.95s on M1 Pro macbook.
>>>>
>>>>> +  'aarch64_rme_sbsaref' : 720,
>>>>
>>>> This one needed 2288.29s.
>>>>
>>>>>       'aarch64_sbsaref_alpine' : 720,
>>>>
>>>> Have to check cause timed out.
>>>>
>>>>>       'aarch64_sbsaref_freebsd' : 720,
>>>>
>>>> 331.65s
>>>>
>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>
>>>
>>> By any chance, are you running those tests in debug mode?
>>> It seems to me that CI is running functional tests with optimized
>>> builds, so I'm not sure we want to support debug "times" here.
>> We do need to support debug times, because a common developer
>> use case is "doing a debug build, run 'make check-functional'
>> to check whether anything is broken. The debug times also
>> are useful because the CI runners can have highly variable
>> performance -- if a test is slow enough to hit the timeout
>> for a debug build locally, it's probably going to also hit
>> the timeout at least sometimes in CI.
>>=20
>
> I understand the scenario, but given how slow debug builds are, it
> would probably be faster to advise developer to recompile in release
> mode.
> The overall time of compile + test is slower than waiting for debug.
>
> Beyond using a debugger, what is the advantage to compile with -O0?

--enable-debug

  - enables -00 with -g3 for symbols
  - and enables additional checks to validate TCG

You can use --enable-debug-info for just debug info without the overhead.

>
>> thanks
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

