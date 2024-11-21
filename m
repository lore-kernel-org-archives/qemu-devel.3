Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DFCD743C9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEB9x-0000HO-0s; Thu, 21 Nov 2024 12:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEB9v-0000HA-DY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:40:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEB9t-0000Eq-A2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:40:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso13803975e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732210799; x=1732815599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2sajJCAVI00/eeve6fZYEtSX0x+f9KTYrP569Lx+RM0=;
 b=keIiEDCW5qMlexL4ahw1TRgrP8SIAwa3iUEwHPmj1LihYZpUhDZOuxnTR9tIk/wPPU
 k35PgJ3vmjzuSZI1mDuCNk7VX1LdqYpJ7CFFTq30W0gTBZTLq5LHZvSHaGMbJLHk6ahu
 mK/RTxyFmMYh0XQ//WjVvmlVKwM5WQpWUzxcYeZ8l/N3x+C3kCEFino/b2bnG9p7/tEn
 CQhYLf2NQp9N9WseejkKudPmZ6k+Fi6MnbeubjU4IQnJ/nGU+ezByNVs2sOupaiacAbe
 6bhtkFguSDmFAtE37aft3+ZtmZriC2ACWM2dSj+eGqGeCgSm8JZSnYok1a/EdkRtbEdx
 uJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732210799; x=1732815599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2sajJCAVI00/eeve6fZYEtSX0x+f9KTYrP569Lx+RM0=;
 b=EfELm7h1g4qq8u7db1Sxqsa/ne6PPlQUfZWgEIX4WSYSFSo3NNdiuGxOdS1TZxDn1A
 K5VxOEXwQsjbdib99Pw2ydP3iOpxK1TmoboBK7sih5qAJMSmPfWxyZcr3D61b1fBcFOQ
 y2EPwHBjPkeWSzlgNsgpEVJL2voExfKYBDe1IO/zuypnk4J1GsP0gPVvB7ILl+5W/Yfs
 nU37Ka6Q7NYkKwnzkwzi/wiwAM+DMP46r4HM4ZQ44fnKWjW+O46KC6A3H4AoTvSFrVoN
 AXY9ckauKQg19AEg6HNga95psqRyHWkEA/llypGfI0vw6o6zKNonevK6ExEyrLym7AnG
 9R6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxjH/Vd+Kc8CtMg5L1sV1PsNG9FSLs7ixBQqD0mnTfxk6m5AWm5SGyUt6NMjMnjYC92H1JUzv0wQmo@nongnu.org
X-Gm-Message-State: AOJu0YwFygloub5fbgNSE9gHMhLiptG37PHkXdcA4ic4hY0M/qEc3u4m
 PMVcAomWpSzg9CoZpPGHZsF/UAsUeBxhHGYOt5a/rK827QiwC1wtm3yrpyPk020=
X-Gm-Gg: ASbGncul3ZP2VgkFvurH+gI4K5XCLGLA5F3TEdpytpwsOVUC0R7F2kAV3ct7vX4Wh4h
 avq90tgFkJM/0Ykfly42AuNjQUllZ6VBp6sWgWUltBDpAorkZEVZ0jgm6g2B62SqlJF4ZqDCv7z
 AEc+CoFMDxspX55zUwPSZ2mMSwzz/15s3bKSdiiwnH58cTdZvRvQFvNZsWOnicLE/hqea2SwsJ8
 tyeCE/PQVsrqEbSlGm7xwdAH+y0YXlbNWzRRTG2B2wPBePgfQhFmhkcbh3M44N0
X-Google-Smtp-Source: AGHT+IEiTiLwkuQU9HFqSDyMvlFgnWQwjCo87IcRIOU0hdphisR8gbwYoOEOHHi1F337OF+G2/JGJQ==
X-Received: by 2002:a05:6000:1f8a:b0:381:f15a:e91 with SMTP id
 ffacd0b85a97d-382604ec295mr42036f8f.11.1732210799244; 
 Thu, 21 Nov 2024 09:39:59 -0800 (PST)
Received: from [192.168.69.197] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3a47sm119659f8f.73.2024.11.21.09.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:39:58 -0800 (PST)
Message-ID: <69f1456e-cf91-4551-90c2-c949428ea2c4@linaro.org>
Date: Thu, 21 Nov 2024 18:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
 <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 21/11/24 17:24, Xiaoyao Li wrote:
> On 11/11/2024 6:49 PM, David Hildenbrand wrote:
>> On 08.11.24 08:06, Xiaoyao Li wrote:
>>> This series is extracted from TDX QEMU v6[1] series per Paolo's request.
>>>
>>> It is originally motivated by x86 TDX to track CPUID_HT in env- 
>>> >features[]
>>> which requires nr_cores and nr_cores being initialized earlier than in
>>
>> "and nr_threads"
>>
>>> qemu_init_vcpu().
>>>
>>> Initialize of nr_cores and nr_threads earlier in x86's cpu_realizefn()
>>> can make it work for x86 but it's duplicated with the initialization in
>>> qemu_init_vcpu() which are used by all the ARCHes. Since initialize them
>>> earlier also work for other ARCHes, introduce qemu_init_early_vcpu() to
>>> hold the initialization of nr_cores and nr_threads and call it at the
>>> beginning in realizefn() for each ARCH.
>>>
>>> Note, I only tested it for x86 ARCH. Please help test on other ARCHes.
>>
>> [...]
>>
>>>   accel/tcg/user-exec-stub.c |  4 +++
>>>   hw/core/cpu-common.c       |  2 +-
>>>   include/hw/core/cpu.h      |  8 +++++
>>>   system/cpus.c              |  6 +++-
>>>   target/alpha/cpu.c         |  2 ++
>>>   target/arm/cpu.c           |  2 ++
>>>   target/avr/cpu.c           |  2 ++
>>>   target/hexagon/cpu.c       |  2 ++
>>>   target/hppa/cpu.c          |  2 ++
>>>   target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>>>   target/loongarch/cpu.c     |  2 ++
>>>   target/m68k/cpu.c          |  2 ++
>>>   target/microblaze/cpu.c    |  2 ++
>>>   target/mips/cpu.c          |  2 ++
>>>   target/openrisc/cpu.c      |  2 ++
>>>   target/ppc/cpu_init.c      |  2 ++
>>>   target/riscv/cpu.c         |  2 ++
>>>   target/rx/cpu.c            |  2 ++
>>>   target/s390x/cpu.c         |  2 ++
>>>   target/sh4/cpu.c           |  2 ++
>>>   target/sparc/cpu.c         |  2 ++
>>>   target/tricore/cpu.c       |  2 ++
>>>   target/xtensa/cpu.c        |  2 ++
>>>   23 files changed, 85 insertions(+), 32 deletions(-)
>>
>> Hm. It looks like this belongs into the parent realize function. But 
>> the "bad thing" is that we call the parent realize function after we 
>> try realizing the derived CPU.
>>
>> Could it go into cpu_common_initfn()?
>>
> 
> It can, I think.
> 
> I'll move them into cpu_common_initfn() in v2 to avoid touching all the 
> ARCHes.


This seems a x86 issue, it also bugs me:
https://lore.kernel.org/qemu-devel/20231128171239.69b6d7b1@imammedo.users.ipa.redhat.com/

IMO we need to make vCPU creation steps more explicit.


