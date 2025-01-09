Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqSP-0005ZH-6F; Thu, 09 Jan 2025 06:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqSN-0005Z9-Tn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:12:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqSM-0003Ae-7C
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:12:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so6003095e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736421123; x=1737025923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQOqLqPVsQLkJ7mQzvwXrpD03zDxGNA8vZbt+bDq4DQ=;
 b=rePK94zBxWKtZODaxi/TrF2RpLNoeXWyBOKArgGm44QpcYNEdWzZMDPXQX4Jf8Q9DV
 WRseN4hHaeIn8XpQfgZ/UdQzMTRQPgS2fyfX/2Iex/3GdF1Pz+93sIczHhnnzlzo8hjj
 KfiPEh3pc/oHPBmA9rmmZAEZu+OO+c5GHhca1YSXfI+Gl9xlhCwza2l+5qJauLkM3J/j
 SV5qADeCjCJe0eL/vS0+4bSamkJEWQBWxK+RsRRKda93AkX/8LMVVkTKS/rF8Nd4/j6Q
 9PcgRbybIT+At5heRnpAtyLLWi4GgwJIfLGISGv8JDLNzDiWlid35d3ARFYKMKeKCQy0
 Z4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736421123; x=1737025923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQOqLqPVsQLkJ7mQzvwXrpD03zDxGNA8vZbt+bDq4DQ=;
 b=kqk1iM8Lu6erpvs/Y49a+Nc+rau0/6aLBzSBIQk4pfErMvGe7YcY3s1SwLatg8YrwQ
 7mVmGE/vP/je/Ze3fwOExPIL95ea9MKNSZFYK3OsT4vPBaIqnYCOD8HDMcRJwrUyQFt2
 TzWKl5wi/BAql3dIudjO3+n9e3Twww4xF+8A0GiyHiwOtmwNQQFqapmipfbwZ1Yr16I+
 F7Pqbm3vJ+mXR2DYGFcfHC24PecE+XvL3UOOBgKb0T3CcBqrh845/cXMWy9DK/XJf0KB
 yG99LEELUsYN7dOSnPBZO5NLptbynI+DgW07yJIYZjbs9ACp7m4XzFXEucUeEJAFlHpF
 l4JQ==
X-Gm-Message-State: AOJu0YzT1EctvnNwZyLIjRwFvaNxvaYQWAO9EhjxQw+MDgCEPFOiQsCT
 TJj1p5xazKcc07KjPqOnvrQwnj81ve14AxP/+/V6YI1rYR09IU3U8dPanskWiaY=
X-Gm-Gg: ASbGncsI2eTvjkniuVDzu1OqXIOMtmvuqfTGZ2CF/8dpx26dkIoVk+TzvjZvuvCo1SQ
 ilURzekbarGviTjl2euwACrf4PyjNXgq2yzct4jeaO+DJK1xatvFMTVOgxkSNFzBYYa02r9Ljt5
 SJvHvmFEjqMao0ZHP3ffGBfoyKhWC47NBn1M86ja1gn0tLpRnNdJFGAHgrzkk8zNGoDjMNrhxRe
 GRnJtek2ZEz8zVhkQN7ajCns2HvIpSMVIYmlmJaFBADYol36y2qP8CdcVcldxbmta3+7T+q5rre
 QZJhuxfyfXxiL/ECW7qjGfKQ
X-Google-Smtp-Source: AGHT+IGjLUISPeRuEUnBkBHh/NUTKUmcQd0CT2H2NNeMKrQGq2rMosxhxgBu4YlJJWMsRS1KvlrhpQ==
X-Received: by 2002:a05:600c:314f:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-436e26a1f79mr52271155e9.18.1736421123273; 
 Thu, 09 Jan 2025 03:12:03 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0f69sm51198615e9.13.2025.01.09.03.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:12:02 -0800 (PST)
Message-ID: <03cf1b53-aa42-401e-af3b-e73890984be4@linaro.org>
Date: Thu, 9 Jan 2025 12:12:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] semihosting: Reduce target specific code
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>, Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250103171037.11265-1-philmd@linaro.org>
 <87h669ba39.fsf@draig.linaro.org>
 <14a2173f-e1b4-4290-99e5-c46b4153d800@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <14a2173f-e1b4-4290-99e5-c46b4153d800@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

+Paolo & Marc-André Lureau for chardev backend.

On 8/1/25 23:53, Richard Henderson wrote:
> On 1/8/25 07:26, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> This series makes semihosting config.c and console.c
>>> target agnostic, building them once, removing symbol
>>> collision of the following functions in the single
>>> binary:
>>
>> Queued to semihosting/next, thanks.
>>
>>>   - qemu_semihosting_chardev_init
>>>   - qemu_semihosting_config_options
>>>   - qemu_semihosting_config_opts
>>>   - qemu_semihosting_enable
>>>   - semihosting_arg_fallback
>>>   - semihosting_enabled
>>>   - semihosting_get_argc
>>>   - semihosting_get_target
>>>
>>> This function is still problematic, being built for
>>> each target:
>>>
>>>   - qemu_semihosting_guestfd_init
>>>
>>> Note, it depends on CONFIG_ARM_COMPATIBLE_SEMIHOSTING
>>> which is target specific, so doesn't scale in a
>>> heterogeneous setup like the ZynqMP machine, having
>>> ARM cores with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y and
>>> MicroBlaze ones with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=n.
>>
>> Does MicroBlaze even do semihosting?
>>
>>> I suppose the semihosting API needs rework to consider
>>> the CPUClass? I'll let that investigation for the
>>> maintainer ;)
>>
>> Hmm most of it is already handled as EXCP_SEMIHOST exceptions are dealt
>> with withing the target specific exception handlers.
>> do_common_semihosting could be renamed though - do_armc_semihosting()
>> maybe?
>>
>> If we have the full list of CPUs at qemu_semihosting_chardev_init() time
>> we could then selectively do the bits of qemu_semihosting_guestfd_init()
>> depending on what combination we have. For normal open/read/write stuff
>> I think they could co-exist.
>>
>> Two independent cores could still write to stdout (0) though. Fixing
>> that would need a per-cpu semihosting config.

What I'd expect here is one VC per semihosting context stdout. If we
want to mux, we use the chardev mux.

Anyhow this in particular is not a blocker, it was just an opened
question.

> None of the semihosting stuff is smp safe.
> 
> The assumption in the homogeneous cpu case is that the guest uses it's 
> own mutexes to protect the semihosting calls.  This is obviously more 
> complicated in the heterogeneous case, but it *still* should not be 
> qemu's problem.

FYI the use case requested is $n Hexagon cores writing to $n semihosting
file descriptors, and a user-mode process on an ARM core able to read
each of these FDs.

Regards,

Phil.


