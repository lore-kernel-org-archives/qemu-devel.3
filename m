Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35883D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAGn-0006wk-Ln; Mon, 02 Dec 2024 12:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIAGi-0006tY-SW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:34 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIAGd-0001ad-ET
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:32 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72577d3b026so736317b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160686; x=1733765486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e543963Iyk40iaooUTKu+Y2n2X5t7JEguZc6j9uAx+Q=;
 b=CX9OPcetMU90CXA+CNs8PAoe/htTgEzNBAZcsBbZl/S4XVUhQmy/ZsLNffCii8diPp
 tyQuO+c04rFyOwi+Xq72QE9ddjYL3SMqnKozw6D/0IuBjbURevY0lY355o4UsJeiB4bk
 QFR0nguImXIUc0/4cf41gd+Kq3sg9xFnmtme/isOYdZqmCVyPNJTHnuSLJ8ASSr1Tu+D
 2sq8Fm5oHtRy0cJmuHj6cTudPwMJ6rKDq76TKgwmhd9QekzODmFSpGfsOqz42jrNUR4O
 8jTrnnRwcc3TH4a2FSnlLMQaWWZTf2BTZMghPcQgMPr8xfQc/U6q1tJMof2vxg8jeDl1
 b0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160686; x=1733765486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e543963Iyk40iaooUTKu+Y2n2X5t7JEguZc6j9uAx+Q=;
 b=ALyvtCG1/WPIQQ+clxxIe3z3A4gVqo2BZ4+51nm+w49cAGpomYAf779ht6Vp3EO5eA
 lAgmxx8c3mu1yiiHWtmQOY8bSZR/IwZKPhuvqzkhUdGa5VViK3w2bOsI9omg9p9NZKJ8
 yj55kacbED+ZtUOyHRi5DgGbToia1MQrj5MDjaKDBaHK3ozL6C7lIT3Roj9OJzmzXu9o
 v4VCB1X7fF9xukpdtaLj+hXp2YHjoD20y8q0XZ7dFtKD3vv5NgBX5yf68q334Uqqnh3T
 9QbDr3OFHGyaIrE3jxlXhkjb3Y4XnLJ+Lu5noOzeHuqC9jPw1mBUgMfQI4z77hkskojU
 T5wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa9NU76ai2m3fTsQCWgF72ADXKm2DS8J/FcTUETAk2LOwtVDMpY73YE/HORw3sIMZt74AJivxoHvuF@nongnu.org
X-Gm-Message-State: AOJu0YyRpHrHs4hUqGFx2cAt5XT+CTrIUTjzyPGgnMz0ArJCQTOVh/N5
 dv5DSc9iuCbHQot98hl6AKPo1XmxpvCg8ZQMGP20TCuW1c0uZvV3m5c3gWh8ZnY=
X-Gm-Gg: ASbGnctHHh3J3GbMKSGiCIszC04iRNbJUlw44yHUrfcYnm6wgjUa/qWRR0DnQAUv7rS
 Yl+qSaiRXr0KGgNwOpcTZDZiggAHHxlc1NNda5IWZ3XgluVXL2ct7HBr5a6Nv6fk31SXEEO3qnt
 t4ZM4SYSI20mgGUN2887daMSxBw+XbAcd6V2TcQGyLOdilsdqNoHWtZ+4Qp+D9dV57RXekc1Mjj
 iDXMbtMXuQjp/pyP1Drp5fid3Amp2t0c2gJhIZ7NERxwN+PVHiULp6ssyfdrpVqHPuqnhfZPSOj
 y5jIWhU8qaL7hOTbBEO0IA==
X-Google-Smtp-Source: AGHT+IH5HS+3cVvUEDx40H4OBjMUtQn35Ws6+8Xss5JvJ4eXhh35qNriFf4JcL7hLS9OJLvhr9+D0Q==
X-Received: by 2002:a17:902:f68c:b0:215:a3e3:c868 with SMTP id
 d9443c01a7336-215a3e3cfbfmr40054965ad.30.1733160685693; 
 Mon, 02 Dec 2024 09:31:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2154e1c34a4sm54262065ad.260.2024.12.02.09.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:31:25 -0800 (PST)
Message-ID: <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
Date: Mon, 2 Dec 2024 09:31:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/2/24 02:57, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 18:09, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Hi Marcin,
>>
>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>> W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
>>>> This boot an OP-TEE environment, and launch a nested guest VM inside it
>>>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>>> index 5c048cfac6d..b975a1560df 100644
>>>> --- a/tests/functional/meson.build
>>>> +++ b/tests/functional/meson.build
>>>> @@ -13,6 +13,8 @@ endif
>>>>     test_timeouts = {
>>>>       'aarch64_aspeed' : 600,
>>>>       'aarch64_raspi4' : 480,
>>>
>>>> +  'aarch64_rme_virt' : 720,
>>>
>>> Took 2974.95s on M1 Pro macbook.
>>>
>>>> +  'aarch64_rme_sbsaref' : 720,
>>>
>>> This one needed 2288.29s.
>>>
>>>>       'aarch64_sbsaref_alpine' : 720,
>>>
>>> Have to check cause timed out.
>>>
>>>>       'aarch64_sbsaref_freebsd' : 720,
>>>
>>> 331.65s
>>>
>>> So RME tests probably need longer timeouts or would not run at all.
>>>
>>
>> By any chance, are you running those tests in debug mode?
>> It seems to me that CI is running functional tests with optimized
>> builds, so I'm not sure we want to support debug "times" here.
> 
> We do need to support debug times, because a common developer
> use case is "doing a debug build, run 'make check-functional'
> to check whether anything is broken. The debug times also
> are useful because the CI runners can have highly variable
> performance -- if a test is slow enough to hit the timeout
> for a debug build locally, it's probably going to also hit
> the timeout at least sometimes in CI.
> 

I understand the scenario, but given how slow debug builds are, it would 
probably be faster to advise developer to recompile in release mode.
The overall time of compile + test is slower than waiting for debug.

Beyond using a debugger, what is the advantage to compile with -O0?

> thanks
> -- PMM


