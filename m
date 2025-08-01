Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928D0C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhxJQ-0000rz-2m; Fri, 01 Aug 2025 17:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhwvm-000173-3r
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:04:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhwvh-00035t-7Y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:04:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23fe9a5e5e8so10164685ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754082279; x=1754687079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vLLVa28ZSNDA75YaBt2dq51k4h/LacoFqf499FBFDsM=;
 b=kRKJqWgh3KdHX1jQq7dX2ndUdzke0Zzu+BWs+YW6jBmOV5G4VsmHzseAkm3c+zgX/J
 eNKh3ImLr0Yt0+mUyrApaSiPH+6q6Mtl2MGUnr1i9TFop4u+RZ0rO31eG1MHRdMDnpIm
 h6ccsUF+TwaaMKl1TmKWKIU//gdjMfIiPQogp1NbeRcJHi9gbTq77CsSxe9AK13ko7WE
 2bJ9vXZnz7aVfJVKRLROMR2eSvIqQTTGZPXlBr+Z/02iT6+LzkkisoQE4ikQqiUwoCE4
 Ij/nJlbH3b5TN0otgMh2LlIXW6GO9HeWFBOg8jJ9ETZeQH8xFS9FQO2LDrTemxP4q9Ji
 rTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754082279; x=1754687079;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLLVa28ZSNDA75YaBt2dq51k4h/LacoFqf499FBFDsM=;
 b=s58vLS6/Eiqr9smVvGOHy6Z4TY4oFpaLwQ/MY7U1S9M9GURaOpRRDakf9bSst98+fQ
 5GuGXoH4xEVAENUI9QGlr9AQPcJ/1jebPfdBPc1ydw1Px3ekWyhDb1P65NtL3Q1EbwOV
 b+h1paHOuNOSu87LgGLmVwi25cXTdOAf6x7831w9h17/nbp16/jJCqfjF9DdAHbJuNBo
 WyD19mAevUaPbEksCp9j4cGutwE3dK82jK0MtsEZadWxk9p91E940Rh+u25L+isMOLEG
 gIiahbPJL0RY0ui19irehOForoWCosYJbWwswylLb+qlPj4RuRaXkkTf7DbQzFYFxfIb
 w+Tw==
X-Gm-Message-State: AOJu0Yw2IrAoWICsyRnDB9I/JphPM0Rni1l6NycMTqQp0A4RIju7jLLr
 Sb78xuCIs5qnWs/3ftom1FkrzoLDytkoGXJ8xGrsncMdw2FHAmB5tmtJYBwy+ybFtdE=
X-Gm-Gg: ASbGncs7EYDAPED/UQHMTquPeOEMUcxQuc8eJPRD/CXsDyNeRbtZU9patmU2fNIxdB1
 2qRFBuNQrgJjwlyq1dHqb2RqZ35p5/QA1rLytN+dXVDDMk5BXdnCINmDqYggjlh/4HsB+2ROiNG
 kZ3HOkmJ1Keh93qSDOv34K7/A3Sn/+k39wQaExITH8ABeqH1tn8TzDg2LoeIS7UiSzvVLZFMpDP
 WtJOz8TxI4gmzArEtd5AFfa5Gd42egUx1XpBpAPreFIG7gdehyoZ1wwzk759DO5W/9wnfizqZoU
 HAB4qXiYFmCE4by4EOrTeWIVN2GuDAcMXOCPomjLk0uUWXcz9bS1gb8SM//KwaRHnVmLAzI30/E
 Dz/5Kbe3ZpZkoGERdV2Urm8SyR4bxD16QR3vvG88e
X-Google-Smtp-Source: AGHT+IHFwvsZ2YiTOql8VTpdmb9d1DpNll5q5cdLnU1TGZ/6rd64OnvfqDiSELUpOSQ85wJtS5vFeg==
X-Received: by 2002:a17:903:2284:b0:23f:ecf6:463b with SMTP id
 d9443c01a7336-24247060100mr13189725ad.45.1754082279248; 
 Fri, 01 Aug 2025 14:04:39 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b43dsm50920725ad.136.2025.08.01.14.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 14:04:37 -0700 (PDT)
Message-ID: <a9103100-e494-4654-8c42-97ebd210660b@linaro.org>
Date: Sat, 2 Aug 2025 07:04:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/89] linux-user: Unify init of semihosting fields in
 TaskState
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-22-richard.henderson@linaro.org>
 <CAFEAcA-GObaf6Sf2preS42Cd1HueRkjuKgE1_=ofe-ZrcJ3=Dg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-GObaf6Sf2preS42Cd1HueRkjuKgE1_=ofe-ZrcJ3=Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/2/25 02:05, Peter Maydell wrote:
> On Wed, 30 Jul 2025 at 01:48, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Initialize all 3 fields in main(), rather than in 4 different
>> target-specific functions.  Adjust the ifdef to be function
>> rather than target specific.  Include stack_base in the ifdef.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/qemu.h             |  4 ++--
>>   linux-user/aarch64/cpu_loop.c |  8 --------
>>   linux-user/arm/cpu_loop.c     | 37 +++++++++++++++--------------------
>>   linux-user/m68k/cpu_loop.c    |  9 ---------
>>   linux-user/main.c             |  5 +++++
>>   linux-user/riscv/cpu_loop.c   |  5 -----
>>   6 files changed, 23 insertions(+), 45 deletions(-)
>>
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index 6c97ab221f..dff7767bc8 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -122,12 +122,12 @@ struct TaskState {
>>   #ifdef TARGET_M68K
>>       abi_ulong tp_value;
>>   #endif
>> -#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
>> +#ifdef CONFIG_SEMIHOSTING
>>       /* Extra fields for semihosted binaries.  */
>>       abi_ulong heap_base;
>>       abi_ulong heap_limit;
>> -#endif
>>       abi_ulong stack_base;
>> +#endif
>>       int used; /* non zero if used */
>>       struct image_info *info;
>>       struct linux_binprm *bprm;
> 
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index 68972f00a1..4def4be1c1 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -1050,6 +1050,11 @@ int main(int argc, char **argv, char **envp)
>>
>>   #ifdef CONFIG_SEMIHOSTING
>>       qemu_semihosting_guestfd_init();
>> +
>> +    ts->stack_base = info->start_stack;
>> +    ts->heap_base = info->brk;
>> +    /* This will be filled in on the first SYS_HEAPINFO call.  */
>> +    ts->heap_limit = 0;
>>   #endif
> 
> Do we need to hide the struct fields and their initialization
> behind an ifdef at all? We allocate our TaskState structs on
> the heap so we don't care too much about their size, and
> the init code here is trivial.

I guess not.  A comment about "this is to support semihosting" would do as well.

Looking again, these ts->heap_* fields look actively wrong, because the real values are in

   static abi_ulong target_brk, initial_target_brk;

in syscall.c.

The original thread's stack_base can always be had via ts->info->start_stack.  I guess the 
semihosting api has no concept of threads and per-thread stacks.


r~

