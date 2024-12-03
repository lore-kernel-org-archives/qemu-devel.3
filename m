Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3E5E64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUs4-0004aY-3z; Tue, 03 Dec 2024 10:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUs2-0004Wz-04
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:31:26 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUs0-0000Aq-1a
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:31:25 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso1186976266b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733239882; x=1733844682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9G5vw0Q1hHCT+GpjGi54EBWFYEF9GHjKcNrof/uRrvA=;
 b=gR96lEsAeX8R8VeegFrb8kfqBSzPAIMEdoEq0MfLQj69iBBa8Ejbr0fnEP0z0kQ5AK
 /kH8yiJtJjgL7Vx2nkREsRStADsVBtqx4VAinVhEFR3Q57LIs5d135rxkKR1+mLhndLS
 dAvCfihlBwr+vmMYpZxpqQjIVUjZoKWKr9taW8v3kmMRcuii9bWgmspiexBzsnZndq3z
 3vzxl/sz+0l+xApKh0vPfxEacgrGxrsTn/o38FmWDcJGfpL0eqreHwxr4N77+aAfwB1D
 Twnt8jPKTRiws/fmOHXkhybqrt3YhzuhgviuOkLwRA7HRXVdiMEfy4/UMWdRT6q2v4r4
 HACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733239882; x=1733844682;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9G5vw0Q1hHCT+GpjGi54EBWFYEF9GHjKcNrof/uRrvA=;
 b=WsUcEtPSB5Rreqg3dg8RVHO9yGDRaEjh4RfSUpBCGejoFGvBmkInXj2IbrE/Lvt/cM
 7z5ke6m1KMbikVaAcfpNgyxEkON6Gi7AQqr+lWSBVquAhZRRr898GS65LK0s3+3TY1FS
 ZO8UIBzJ4560Oxbrm9aKWvY+8H3r90qkVeV3Nc9wWDlWVyXLGReobVWLk+7zT1FpV99f
 51IZ+j2esH12evuv1lK4Jlmu5I/4oAUAXUIXOCv02KNESy9vgZTtINfDSBeETO8qTE7I
 4QDx3yeB1DleuIILDdbHfnzGHYXF5t8uX894768X6eg8TkebrGLOmJOBU9GYsV97cdYp
 fWSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF/8fy/Nj2A6nRFYNPyP+qo9hWkXerPLOLyez1ff2hyrhwtMO+D3HK1qx9ImxbPRQCOXQ2vFTUp0Kf@nongnu.org
X-Gm-Message-State: AOJu0YwMyIbaRRCwZ9Rew6KgJ3kkpYh2EIMHCwteKsB6fXIeZ8Nswi/U
 rIkT9/dUoCIk3xHcvwguQU1nTLs5Q1omJ/CIy8A6rdfzyabh5y3NgxtABAVMPow=
X-Gm-Gg: ASbGncupRJ12zzlxlpnZqWEAcj4SHEmRGtZ6OclT26xl9GbTq+ahZ4L4mbaLnmaCSQN
 H0KxamT73z9UxzAWAnmxVo7GKmBMafqw5jZ7wolSoohF1SkheJWFQkdnNTH4xtOYXGHTWjqScTl
 HlzGZ+KSeKqBmw2Ze+sxXYFY6kl+8c2OCpMloyvc1p7pUVra+nuiV4WwA2tpETeLZSulo+lf1fI
 rBweOkqEywwCv1nuPYm1ii0yUYZ8hY6QB7s6XwGWpVfbAp6
X-Google-Smtp-Source: AGHT+IGnC4/ZViz2f2iAGo8NiK6ReCBffZCtpUXTfklQifFsxWtQ932Pim7xVgT+Aj7KPxExTb7NjA==
X-Received: by 2002:a17:907:784a:b0:aa5:3c57:c407 with SMTP id
 a640c23a62f3a-aa5f72cb6b8mr312657366b.16.1733239882183; 
 Tue, 03 Dec 2024 07:31:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c1408sm622166466b.15.2024.12.03.07.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 07:31:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 827EA5F89C;
 Tue,  3 Dec 2024 15:31:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Marcin Juszkiewicz
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
In-Reply-To: <b9e375ad-2b71-48a4-8e97-2cdced17ea79@linaro.org> (Gustavo
 Romero's message of "Tue, 3 Dec 2024 12:02:03 -0300")
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
 <b9e375ad-2b71-48a4-8e97-2cdced17ea79@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 15:31:20 +0000
Message-ID: <87bjxsdbqv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 12/2/24 15:23, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 12/2/24 02:57, Peter Maydell wrote:
>>>> On Sun, 1 Dec 2024 at 18:09, Pierrick Bouvier
>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>
>>>>> Hi Marcin,
>>>>>
>>>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>>>>> W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
>>>>>>> This boot an OP-TEE environment, and launch a nested guest VM insid=
e it
>>>>>>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>>>>>>
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>
>>>>>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.=
build
>>>>>>> index 5c048cfac6d..b975a1560df 100644
>>>>>>> --- a/tests/functional/meson.build
>>>>>>> +++ b/tests/functional/meson.build
>>>>>>> @@ -13,6 +13,8 @@ endif
>>>>>>>      test_timeouts =3D {
>>>>>>>        'aarch64_aspeed' : 600,
>>>>>>>        'aarch64_raspi4' : 480,
>>>>>>
>>>>>>> +  'aarch64_rme_virt' : 720,
>>>>>>
>>>>>> Took 2974.95s on M1 Pro macbook.
>>>>>>
>>>>>>> +  'aarch64_rme_sbsaref' : 720,
>>>>>>
>>>>>> This one needed 2288.29s.
>>>>>>
>>>>>>>        'aarch64_sbsaref_alpine' : 720,
>>>>>>
>>>>>> Have to check cause timed out.
>>>>>>
>>>>>>>        'aarch64_sbsaref_freebsd' : 720,
>>>>>>
>>>>>> 331.65s
>>>>>>
>>>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>>>
>>>>>
>>>>> By any chance, are you running those tests in debug mode?
>>>>> It seems to me that CI is running functional tests with optimized
>>>>> builds, so I'm not sure we want to support debug "times" here.
>>>> We do need to support debug times, because a common developer
>>>> use case is "doing a debug build, run 'make check-functional'
>>>> to check whether anything is broken. The debug times also
>>>> are useful because the CI runners can have highly variable
>>>> performance -- if a test is slow enough to hit the timeout
>>>> for a debug build locally, it's probably going to also hit
>>>> the timeout at least sometimes in CI.
>>>>
>>>
>>> I understand the scenario, but given how slow debug builds are, it
>>> would probably be faster to advise developer to recompile in release
>>> mode.
>>> The overall time of compile + test is slower than waiting for debug.
>>>
>>> Beyond using a debugger, what is the advantage to compile with -O0?
>> --enable-debug
>>    - enables -00 with -g3 for symbols
>>    - and enables additional checks to validate TCG
>
> hm, do we ever used -g3 for --enable-debug?
>
> https://gitlab.com/qemu-project/qemu/-/blob/master/configure?ref_type=3Dh=
eads#L749
>
> I'd love to use -g3 instead of only -g for having the macro symbols.

Hmm yeah, I tend to use extra-cflags with it as well.

>
> In my builds I use --extra-cflags=3D"-g3" to have it but would like to dr=
op it.
>
> unless I'm missing some other change in the flags down the lane...
>
>
> Cheers,
> Gustavo
>
>> You can use --enable-debug-info for just debug info without the overhead.
>>=20
>>>
>>>> thanks
>>>> -- PMM
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

