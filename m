Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E80C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 17:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMW0X-0003er-4K; Wed, 26 Jun 2024 13:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW0Q-0003cN-Mc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:00:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW0O-00067c-PU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:00:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3645e9839b3so5240100f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719421223; x=1720026023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6yy8q2jpoHXlXg85ZR/IswxE+kPuXBhTZOVGyO+mIA=;
 b=N9tqXG5oTV9+nT4LW4lFvSnHkvsuHIZB2c4bl2MmdpEfZU+mW8CZQqVqHNFMUYoNLu
 VY1Th76R+R0Nxbn/Kvw5Pvd163OeaDKR1gHiz/b8gn0QOQ4hmP1vses81STKnaXElYiX
 ZuJjKrCJu9uc6Pz1HD9mIKYWi2g5SJsHzr8bTk4jWVYWmJishgacnEtZXIeDSH6hFZRx
 qXlcZpSQluLMQtJZDER/ajLOsE98qeiyxO40OVQtksRe81vjYCJWbKEmZZ75CMiVOrxt
 xhrRMqofTkJq4KHMk7UTTWme/x6RMIXi5TrhhYBEs+WtnseFsBmgl1k3cEE0D6855VaT
 yIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719421223; x=1720026023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6yy8q2jpoHXlXg85ZR/IswxE+kPuXBhTZOVGyO+mIA=;
 b=XGY/sPdGZx4RVv08AT1F0d/EUoeXZJsTqSoTSxI1ebknjOQU+w+636DxLZX6bcZpKC
 T9QCOjwwSGlOp0ph6xMlTrC5C2VvdEo+w4zBXZre5OfnXcQSBXac7QxALd3ChUY82H9O
 IsKFOcV1BrN8LZj6P/vCKmvKDd6fdTO2CrXm9EIdoQz2WoLvYF8tO+ieO5+fpEr3REJx
 LU4thcg4J+eddjSjCIsYRpCYQ7cxrRLPWxmGXbgnE4BNsGjnLHLTbxJ4C9wTO3/06NBx
 h1fdKrjPfy5flLb2QOUFwdQUWwQgy7JJEt/VzbhTo1Fnn24jLpOxNiYpKpTLXgqZL+r1
 /E4w==
X-Gm-Message-State: AOJu0YzaU2ZGdw3fI1cGpzOsHjU4P5r6qqRxLvOqJAhubo+vPPin5Aph
 EglE9LgqFElyoFxnbVxIOtIIzMJQqUEvo4YM6a4OUIt9ZOd2cjGDgIEFKPtiuME=
X-Google-Smtp-Source: AGHT+IHekq5X45p/uxBeKBBUxxp+qRbVObCTDUz7b0tXridZSYxP52Ve467QzaCptI5BxhMcyTmvdw==
X-Received: by 2002:a5d:4712:0:b0:35f:1128:2514 with SMTP id
 ffacd0b85a97d-366e7a0fc96mr6581641f8f.32.1719421222777; 
 Wed, 26 Jun 2024 10:00:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8b27sm16258033f8f.104.2024.06.26.10.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 10:00:22 -0700 (PDT)
Message-ID: <2756549c-867d-43c0-a332-beac708da443@linaro.org>
Date: Wed, 26 Jun 2024 19:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20240626140307.1026816-1-alex.bennee@linaro.org>
 <ZnwjtOxQy1iiRoFh@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZnwjtOxQy1iiRoFh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 26/6/24 16:20, Daniel P. Berrangé wrote:
> On Wed, Jun 26, 2024 at 03:03:07PM +0100, Alex Bennée wrote:
>> Re-enabling the 32 bit host build on i686 showed the recently merged
>> SEV code doesn't take enough care over its types. While the format
>> strings could use more portable types there isn't much we can do about
>> casting uint64_t into a pointer. The easiest solution seems to be just
>> to disable SEV for a 32 bit build. It's highly unlikely anyone would
>> want this functionality anyway.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   target/i386/sev.h       | 2 +-
>>   target/i386/meson.build | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/i386/sev.h b/target/i386/sev.h
>> index 858005a119..b0cb9dd7ed 100644
>> --- a/target/i386/sev.h
>> +++ b/target/i386/sev.h
>> @@ -45,7 +45,7 @@ typedef struct SevKernelLoaderContext {
>>       size_t cmdline_size;
>>   } SevKernelLoaderContext;
>>   
>> -#ifdef CONFIG_SEV
>> +#if defined(CONFIG_SEV) && defined(HOST_X86_64)
>>   bool sev_enabled(void);
>>   bool sev_es_enabled(void);
>>   bool sev_snp_enabled(void);
>> diff --git a/target/i386/meson.build b/target/i386/meson.build
>> index 075117989b..d2a008926c 100644
>> --- a/target/i386/meson.build
>> +++ b/target/i386/meson.build
>> @@ -6,7 +6,7 @@ i386_ss.add(files(
>>     'xsave_helper.c',
>>     'cpu-dump.c',
>>   ))
>> -i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
>> +i386_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('host-cpu.c', 'confidential-guest.c'))
>>   
>>   # x86 cpu type
>>   i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
>> @@ -21,7 +21,7 @@ i386_system_ss.add(files(
>>     'cpu-apic.c',
>>     'cpu-sysemu.c',
>>   ))
>> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
>> +i386_system_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
>>   
>>   i386_user_ss = ss.source_set()
> 
> Instead of changing each usage of CONFIG_SEV, is it better to
> prevent it getting enabled in the first place ?
> 
> eg. move
> 
>    #CONFIG_SEV=n
> 
> From
> 
>    configs/devices/i386-softmmu/default.mak
> 
> to
> 
>    configs/devices/x86_64-softmmu/default.mak
> 
> And then also change
> 
>    hw/i386/Kconfig
> 
> to say
> 
>    config SEV
>        bool
>        select X86_FW_OVMF
>        depends on KVM && X86_64

Both are *targets*, IIUC we want to disable on *hosts*.


