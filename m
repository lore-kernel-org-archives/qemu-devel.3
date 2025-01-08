Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD925E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVewA-00047I-UA; Wed, 08 Jan 2025 17:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVew9-000479-FH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:54:05 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVew7-0004Dt-QS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:54:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2167141dfa1so5215715ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736376842; x=1736981642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GecFoJwbyxAr4Wifp+1guymnsZt+zqVyk3XNCvgyVMo=;
 b=AjRey2BZC/dW0eate0lV16Evej4wQw0jOdYEwNzsMfnyadZSVH/yrO1V29QiCzSKS/
 RW+94IN73fGgMHK2kisD+CxmSbJPU2bXedu4Nivq78ZubFVnAfWTOhJYL1EcuVs1i9mF
 aABA5pt2NR6S59NZ5cyYCMojW/MjX4qqe9S/r46Yl8xPjoFLaxbXDnq6dqcbVkn1F9vy
 1y9E5d5gmv7D/EYcnoiu2fEpcwiuGniD8niTIWUgwrz03KZM9kilv3Njsdfj+Iu2KNUM
 afO9Blj9zWdvi8boaRJ+qxyuj2/cHu6Rgw7VasWaBslpqnuI+lUpP65UcAmWmOorpA2i
 sGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736376842; x=1736981642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GecFoJwbyxAr4Wifp+1guymnsZt+zqVyk3XNCvgyVMo=;
 b=uITqzgPO9Owfm9DS1bOBAOZl2ZWycPkiHCc6NsSjMuR9eEQNg304ZrCwy7FfdE5DOg
 r1Y8Mq3BQQeR70i07iHR5yJkPkD9wKxs9iXXVRTmxu+LppCFvScPE1iZXcrIHR1bMNpz
 sUPXDEAZ4vgRZsGG1A7jQQrOjuU+HCZrcbHV+GqKOn0R64FudqeGzDnpF2wkb1Qe9YIk
 Zp3dD2ld9+gwnJKbeb936queIKZtbBrMdhKUmXCFrwuESxGchrNjECpLE6agAP/6mMH1
 0GnnNHK5qMxVrQA9B8C3U2o9OdGe2c8XOXDM7ZQGEYdTOJdc4VFroEbxh9KjW2C46YTK
 cYwg==
X-Gm-Message-State: AOJu0YwJ2X2dMofyz97UCnGGRXuvZ03ABTHHz29JQvXg+EaECLNT55yR
 8Ytb7dUTLUQ9u+ILmVsLGX9/7AytaCtqcDA7AH0X0ZP3bAQdYLyM1NPVm2x37ip6sifCGIO05Lp
 L
X-Gm-Gg: ASbGncsH3qsNmJGOBAGzfmfzDhAPOVMpV514OvZS3e0ERW8ttnjU5smfWO2MP6ZmJvL
 QXdUA1G5cvsSmo8dBbX8/yBJo2bI4dGPJiFzJmVquToWReXMnReuZGuTTvnWF0VPs5UuXj47HkL
 OZ8IWfmqx57naxWXfOJxJYety62dG+r1Vxy+xblpPbzZMkfmkRz8CKhxc3Tql3bqv2t957pVqn1
 Eqhc5Jx0GqhmqviwTETdTmyo8CDMg5bgzAIbdpE+fdLdfLssVy+uKuMYqFFTBz8ZIlwTnD379or
 gA5qjOtJ+41zERgf0PHAd36TOE78eP4=
X-Google-Smtp-Source: AGHT+IFrKPLhlymyMkRzFpTEt7zjelxMcjVX18jvAXqfIW6NryFT52yaPj5P07XvKOpo90sClv1Aig==
X-Received: by 2002:a17:902:fb0c:b0:215:7e49:8202 with SMTP id
 d9443c01a7336-21a8d68dd9cmr14421295ad.13.1736376840587; 
 Wed, 08 Jan 2025 14:54:00 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f5dc5sm331894015ad.210.2025.01.08.14.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:54:00 -0800 (PST)
Message-ID: <14a2173f-e1b4-4290-99e5-c46b4153d800@linaro.org>
Date: Wed, 8 Jan 2025 14:53:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] semihosting: Reduce target specific code
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>, Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103171037.11265-1-philmd@linaro.org>
 <87h669ba39.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87h669ba39.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/8/25 07:26, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> This series makes semihosting config.c and console.c
>> target agnostic, building them once, removing symbol
>> collision of the following functions in the single
>> binary:
> 
> Queued to semihosting/next, thanks.
> 
>>   - qemu_semihosting_chardev_init
>>   - qemu_semihosting_config_options
>>   - qemu_semihosting_config_opts
>>   - qemu_semihosting_enable
>>   - semihosting_arg_fallback
>>   - semihosting_enabled
>>   - semihosting_get_argc
>>   - semihosting_get_target
>>
>> This function is still problematic, being built for
>> each target:
>>
>>   - qemu_semihosting_guestfd_init
>>
>> Note, it depends on CONFIG_ARM_COMPATIBLE_SEMIHOSTING
>> which is target specific, so doesn't scale in a
>> heterogeneous setup like the ZynqMP machine, having
>> ARM cores with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y and
>> MicroBlaze ones with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=n.
> 
> Does MicroBlaze even do semihosting?
> 
>> I suppose the semihosting API needs rework to consider
>> the CPUClass? I'll let that investigation for the
>> maintainer ;)
> 
> Hmm most of it is already handled as EXCP_SEMIHOST exceptions are dealt
> with withing the target specific exception handlers.
> do_common_semihosting could be renamed though - do_armc_semihosting()
> maybe?
> 
> If we have the full list of CPUs at qemu_semihosting_chardev_init() time
> we could then selectively do the bits of qemu_semihosting_guestfd_init()
> depending on what combination we have. For normal open/read/write stuff
> I think they could co-exist.
> 
> Two independent cores could still write to stdout (0) though. Fixing
> that would need a per-cpu semihosting config.

None of the semihosting stuff is smp safe.

The assumption in the homogeneous cpu case is that the guest uses it's own mutexes to 
protect the semihosting calls.  This is obviously more complicated in the heterogeneous 
case, but it *still* should not be qemu's problem.


r~

