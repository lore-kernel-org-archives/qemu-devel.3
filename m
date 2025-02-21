Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E9CC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVmO-0003WH-Ea; Fri, 21 Feb 2025 11:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlVmM-0003Vp-S0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:21:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlVmJ-0008FH-Fy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:21:30 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f265c6cb0so1232399f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740154884; x=1740759684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bU90KehK261iJLWUb+xbCxAymJ1+wCkL78r29Z6a7AI=;
 b=EkTbM1tMvD111pYZbGK9ytvok8Inj6mri9AjDaN/MSOPJz7i+OuI2116bJNh/lWoCZ
 ZFwYlARYxv/J8uDwJvw2zhWRk9elpHR+wWBLPQMmzy1bJcXlbd3xAkb68/ufQ/hiRaaH
 hzMNWMjDQgnPdo+bmAAlAGTw0qDtA2Td+hcILF6TyS8xq7Nox3/gUsJ9WHCrD5A+nTsh
 P50NXwUIY492/ryTY12C+mnQzigmEVvvtjowGsjc95BSjZidzIbJ4X9YKNbyE4GMkSm9
 v7HmlLH4tdf+szXhtpx3s927DdwT+8SNYXYtFNnP+QiwSERwansGu3qdylMWsNgnRT0x
 QuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740154884; x=1740759684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bU90KehK261iJLWUb+xbCxAymJ1+wCkL78r29Z6a7AI=;
 b=wRBB10AXg4F5R/SJ57CkEhLkvDP5m42wtcBNzlLsZwzUKChP9NQTlcgESlZoYLVIbv
 AcGohdTP4sHe6RjcxINnoEa2QpCtbI7fvpDrUMCLSTruD33peOgTvKCYcITxm9aOsOMw
 6YwXqVeeNZQc/+ZBhY/TYl7m21grHzJA3lTROIXvxsh0tSAaG0jlvzAAL8w6W9sun6cs
 /jZ/j+Uq7eWdPqwFJpIFCxskQWLjBY9g0tOR0GUj6u1PnHfAdJ/jVRPwXo/t/A/KeGjE
 YK/QtoyOsbL6UC+aayiQ5mPiZmOEiNRjOWRwrBndi3rGTl2iEbj6nVZajESNlJR4LL62
 ++KA==
X-Gm-Message-State: AOJu0YzSiz+Soq+UhnrvYt/l4HqF6wayjHifIEN3QB20ev9hdVNaQ5yl
 5x1+957y2sYRcFI1z4kaJJDQGHWwgd1vzNKCSCPneen0J90LSCMpWHyzNBic284=
X-Gm-Gg: ASbGncs6ZtCQQXRcFIJv/EMozlMPN45P5pvgRFmHTFMjp7JI4W8K40f7bhWIZ5AltiQ
 K+QE2EnD4SZYfrJsSeqIKNVYPoFgxbVzO6cB1UktDg/0Wh1VjdkxjIr1H5mn7ZqABxT94r4Wlgf
 3Gcg9SD4sEi/vab406vc53hY5x3ttAjkT/V7acG2vIZQxGd3LdvPoikudOVzcoPJN8Cv81m+EdS
 zxaavIbTeXvUJ9aTkHAdyp7iRHcY3+/Uxeh8e+D768WQ1z0wfxL28001M+pr8YKS2XAyK9JaHPe
 YN8VL2u5PNMcvbiz2MSqlTUHH2RvStphMyP23x6Hy6BwBpthDSQoQS/yCmt5Urkdjpmsxw==
X-Google-Smtp-Source: AGHT+IEWF63ukgs6ZLNOKhhGUjhlBgz+KyWTGV4ve24zu4/h/uYyJpMT+NNfuOHYVUvdNPrH2yMHyQ==
X-Received: by 2002:a5d:4bc7:0:b0:38f:338e:3cf0 with SMTP id
 ffacd0b85a97d-38f707aa445mr2065665f8f.32.1740154884388; 
 Fri, 21 Feb 2025 08:21:24 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0367577sm21870275e9.25.2025.02.21.08.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 08:21:23 -0800 (PST)
Message-ID: <74262d5e-a497-4c28-9809-66ac6a549f46@linaro.org>
Date: Fri, 21 Feb 2025 17:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <93307c7c-c29f-4061-94ae-461bf196ff41@linaro.org>
 <CAFEAcA9A018e6FuVuY8YcWw+jHAxLZ5qVQ25P7ym4nE6qWeQAg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9A018e6FuVuY8YcWw+jHAxLZ5qVQ25P7ym4nE6qWeQAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 21/2/25 16:19, Peter Maydell wrote:
> On Fri, 21 Feb 2025 at 14:41, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 17/2/25 13:50, Peter Maydell wrote:
>>
>>> (1) floatx80 behaviours
>>>
>>> Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
>>> use in the xsrqpxp round-to-80-bit-precision operation, and the
>>> Linux-user NWFPE emulation nominally supports it, but these are
>>> minor.) x86 and m68k disagree about some of the corner cases of
>>> floatx80 where the value has the explicit Integer bit wrongly set.  At
>>> the moment the fpu code defaults to "floatx80 behaves like x86", with
>>> TARGET_M68K ifdefs to get the other option.
>>>
>>> The first six patches in this series remove those ifdefs, replacing
>>> them with a floatx80_behaviour field in float_status which can have
>>> various flags set to select the individual behaviours. The default is
>>> "like x86", which allows us to set these only for m68k and not worry
>>> about the minor "technically makes some use of floatx80" cases.
>>
>>
>>> Peter Maydell (10):
>>>     fpu: Make targets specify floatx80 default Inf at runtime
>>>     target/m68k: Avoid using floatx80_infinity global const
>>>     target/i386: Avoid using floatx80_infinity global const
>>
>> Bothering again, we can add the floatx80_default_inf() refactor as the
>> first patch:
> 
> I really think at this point this is just doing extra
> work shuffling code changes between patches for no real benefit.
> The patches aren't super huge and they've already been
> reviewed. I'm OK with splitting out the "add the status
> argument" part as you suggested previously, as that
> makes the patches more reasonably split between "just
> mechanical" and "interesting change" which is not a big
> split to do and could be helpful for potential bisection
> later, but churning the patchset beyond that doesn't
> seem worthwhile to me.

OK, fine then, series fully reviewed!

