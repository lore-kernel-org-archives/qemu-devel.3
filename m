Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50258C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hlp-0000Ok-WE; Tue, 22 Apr 2025 13:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Hll-0000Ns-Sg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:50:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Hli-0001je-PS
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:50:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73972a54919so5532954b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344249; x=1745949049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5xBjYlTuGsJ7I5J4Q7OylMFs3Nemw9WARDFIwFdP9Gk=;
 b=qf9MnVWcX4xbN+/PniohpQ/S8Sibm0w46DxslZ9LR8dXWpaLZXVqeGhRudUpSflk0V
 Kf2NGtoHqupQEv864MUAA27aYnleVX/SNhAVI4i+XNsoblpARXvUHjSW1XMMmI8l8gs2
 ygRqkUXJlnkoYwXCoTCVkXdrofOu/5GJ82ypd/kuy1bnMJVqIIFFz4N7hFlmWOcXmGji
 ENNIlVoPQUzn6T19emzB7niGu+9HJqi1P442hqca6ycIdSrl5YyOqHZrNFKnPPOR2E46
 rUg3pHLyX7OuFxHTmzVucgw63Vogx/LcnLZqvLXEKzphdMQKK6UWN6bNQTDVTfJf82Z5
 3TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344249; x=1745949049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xBjYlTuGsJ7I5J4Q7OylMFs3Nemw9WARDFIwFdP9Gk=;
 b=rrAgO0Ryo2+ytiStpwRN47fdq8Gt9ui6KM9RKo/FYnhQyOWq9be9RnCYACYD0quuMG
 a0wAiZJ1fWToypAVyZyYDys6UC0ymQB3RL8nY0dQY3DIgwGlcnJ/k0xL3a9PJ22plnSt
 ONZ525yFeG+318n9wwCSsoXMCiczMfWIkEPpuNhxU5+YgLo+laM/09a2PNCEqaKc2buA
 bVEcINt3avMr/JTDFI78f7oPIX4s/jigO/Q29mDRU2mFVQsuB8K1II/Ra/pprnWy81kx
 Que0hyT7wIwmVxzm1zgsbcGrIUtiS6VIDz4x7GG/QCXwg6FHcbcsBDahiLJl0OWElTVM
 whmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPnHXAKQCNb307CeLTItT4aEpbZZxS75/EhPyBOqUfkQ8k2gXSaFSiFI/uLI0O3/Q6iwBB0aQVAIWf@nongnu.org
X-Gm-Message-State: AOJu0YwCT0AJ5/CHknYnk3yX0bNVMvqOukL+cKVf4vYgJWYOCUE3LfbH
 EcIyJJJR6TZ/B54Uuh81KYRYQgtnNRnqyuoCq2tVcKqkSdv20xO/9yHn6DhT0FY=
X-Gm-Gg: ASbGncubG+VuQ9QX3Oq7+JqzdUvYYBqBU6Usftc1UkvXbsNO40ZfzpiW6qzyyf7/V/v
 dd/P9xI8fZG0eAFWQL+dxuYlHNPwuzdv3ziW8nT8z3y2cvinAO3gG/ePurikfqBmI07FjMuyCES
 HilyEa9mg9Kb/HmZJaTCQYUaEo58h3vnWa5oStBuU/cwSfunPyVMFtD50DvEYhAq7T7F9Ok3z1F
 XRFLu3uIQ44NZFXroUkZraHmQ/p/7DWZc+vZcfiYpUCdv7GxB1e4Lyvzqi1zyI1lencS+d3Bj83
 bvNHPKqeENSH17CAubFaHzUS1xL+bAs+CVq53R49LMhnsY/OIj2LIA==
X-Google-Smtp-Source: AGHT+IHzfmf39X0ibsH+rq7G/IK42CQ2aIaE7miLyfaeHLNnOAD8aCN6+ZSwLi1+/Zpp+BJHw9cN6A==
X-Received: by 2002:a05:6a00:e8b:b0:736:41ec:aaad with SMTP id
 d2e1a72fcca58-73dc14b3b4cmr20848937b3a.14.1745344248729; 
 Tue, 22 Apr 2025 10:50:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a57a1sm7643787a12.27.2025.04.22.10.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:50:48 -0700 (PDT)
Message-ID: <f5e7f82e-4a97-47e1-bcf5-67a9c72d9572@linaro.org>
Date: Tue, 22 Apr 2025 10:50:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
 <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
 <ff7cdc09-f11c-43ae-b1e4-668c39db3efe@linaro.org>
 <3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org>
 <87tt6g91fq.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87tt6g91fq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/21/25 23:04, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
> [...]
> 
>> At this point, I would like to focus on having a first version of TargetInfo API, and not reviewing any other changes, as things may be modified, and they would need to be reviewed again. It's hard to follow the same abstraction done multiple times in multiple series.
>>
>> Regarding your proposal for target_system_arch(), I understand that you tried to reuse the existing SysEmuTarget, which was a good intention.
>> However, I don't think we should use any string compare for this (which qemu_api_parse does). It has several flaws:
> 
> qemu_api_parse()?  Do you mean qapi_enum_parse()?
> 

Yes, sorry for the typo.

>> - The most important one: it can fail (what if -1 is returned?). Enums can be guaranteed and exhaustive at compile time.
>> - It's slower than having the current arch directly known at compile time.
>> As well, since SysEmuTarget is a generated enum, it makes it much harder to follow code IMHO.
>> QAPI requires those things to be defined from a json file for external usage, but it's not a good reason for being forced to use it in all the codebase as the only possible abstraction.
>>
>> To have something fast and infallible, we can adopt this solution:
>>
>> In target_info.h:
>>
>> /* Named TargetArch to not clash with poisoned TARGET_X */
>> typedef enum TargetArch {
>>      TARGET_ARCH_AARCH64,
>>      TARGET_ARCH_ALPHA,
>>      TARGET_ARCH_ARM,
>>      TARGET_ARCH_AVR,
>>      TARGET_ARCH_HPPA,
>>      TARGET_ARCH_I386,
>>      TARGET_ARCH_LOONGARCH64,
>>      TARGET_ARCH_M68K,
>>      TARGET_ARCH_MICROBLAZE,
>>      TARGET_ARCH_MICROBLAZEEL,
>>      TARGET_ARCH_MIPS,
>>      TARGET_ARCH_MIPS64,
>>      TARGET_ARCH_MIPS64EL,
>>      TARGET_ARCH_MIPSEL,
>>      TARGET_ARCH_OR1K,
>>      TARGET_ARCH_PPC,
>>      TARGET_ARCH_PPC64,
>>      TARGET_ARCH_RISCV32,
>>      TARGET_ARCH_RISCV64,
>>      TARGET_ARCH_RX,
>>      TARGET_ARCH_S390X,
>>      TARGET_ARCH_SH4,
>>      TARGET_ARCH_SH4EB,
>>      TARGET_ARCH_SPARC,
>>      TARGET_ARCH_SPARC64,
>>      TARGET_ARCH_TRICORE,
>>      TARGET_ARCH_X86_64,
>>      TARGET_ARCH_XTENSA,
>>      TARGET_ARCH_XTENSAEB,
>> } TargetArch;
> 
> Effectively duplicates generated enum SysEmuTarget.  Can you explain why
> that's useful?
> 

In terms of code, it doesn't change anything. we could reuse SysEmuTarget.
I just think it's more clear to have the enum defined next to the 
structure using it, compared to have this buried in generated code that 
can't be grepped easily.
(git grep SYS_EMU returns nothing, so people have to remember it's 
converted from a Json, and that naming is different).
IMHO, DRY principle should not always be followed blindly when it hurts 
code readability.

That said, my editor is able to find the generated definition as well, 
so I don't really mind reusing SysEmuTarget if we think the code 
readability is not worth the duplication.

However, I think it's a problem to compare strings to find this, when it 
can be set at compile time, in a file that will have to stay target 
specific anyway.

>>
>> typedef struct TargetInfo {
>> ...
>> 	TargetArch target_arch;
>> ...
>> }
>>
>> static inline target_arch() {
>> 	return target_info()->target_arch;
>> }
>>
>> static inline target_aarch64() {
>> 	return target_arch() == TARGET_ARCH_AARCH64;
>> }
>>
>>
>> In target_info-stub.c:
>>
>> #ifdef TARGET_AARCH64
>> # define TARGET_ARCH TARGET_ARCH_AARCH64
>> #elif TARGET_ARCH_ALPHA
>> # define TARGET_ARCH TARGET_ARCH_ALPHA
>> ...
>> #endif
>>
>> static const TargetInfo target_info_stub = {
>>      ...
>>      .target_arch = TARGET_ARCH;
>>      ...
>> }
> 


