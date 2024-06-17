Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD0AC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5zT-0004cM-Ea; Mon, 17 Jun 2024 02:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5zR-0004bn-EX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:37:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5zP-0005GX-Ia
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:37:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f6fd08e0f2so27825015ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718606234; x=1719211034; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFVoLJ7X2OYIKujX9dD2WqeGSE+k5lfHpQNK/dtVK/A=;
 b=XHvgNPW6Ux+iLmHn88Z7znsFHaaAr69CGmaEuyCxjhjn0kA+M4i/SrCHWqOTPNOqXJ
 UFTjC3al6TZxznzDWn2L5eiUaYMsX+26aKDUiBUm22SB2vlWR88hHfNuFBL0G2+a4QX7
 D47Zh+oDd/W0oCMDHk19wDNPIrZR+IopTt+8KClYDMu8Qx+uOUIdXGN2o6HzJLgJ+bJn
 1nd6c210OQP/mKEDhkpdb6hFkGkL+YZ1EC1KDRywLx8huO5aQ2+DB3w9dhDHdnGUK5An
 J/DgPKkaQ26BK0sWR5xgJuYndgXl3DuvEjXK+dR2hQQGH7ozPTlZ+ZbUW0zDZIsUzAmL
 p5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718606234; x=1719211034;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFVoLJ7X2OYIKujX9dD2WqeGSE+k5lfHpQNK/dtVK/A=;
 b=c0McNKXhbUttkatbyqGXRFPNnvmsS7NaV+A/yJ8XQFZhV0NOk6j5lKNvj7XRXVfuDJ
 OGzCHZIhcqHt/i+P0GSz9JOfiJYcHCIHKIN0C+/LpiHx9A0bEzUjFUYMkxpC8aTbxqBX
 ydLqEnikIljdfNblL1sVGTn6/nBpM0wFGlKqKdPQ/BrT7lsrj22h46Yk4+99qfAKe9MJ
 rhIr4wsgSJpif2d5HtRDKLFUoRVCcqmGyQLzV60im4S9uMCHihgTAEPeX/75FnvLS6CZ
 tVYBlWg7NydBL+oiPY4iYWIsT3ozGbEPBCc4wZn0KLMnlHt0HspPE2nc/q44nC/e5rfI
 59hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPumDF8bU4GP5Nb1zxp31QYYFOl8MaJMHTBCxmik3Qtj9ywEie/TyMW5HlPPtw0j+CVpd9EO0mVfvMjAmw9G8DWtNnVUk=
X-Gm-Message-State: AOJu0YyWuQeG4TPZCp1lzm1VT8L36q6ORkOyINIsjVNA7cgnFYlt5D2o
 eQCnvCDUYaAMc7XRuLpGFB6Fymh2lf7fhh3omQfkQy5f68MAjOONWd9ALrX4xvX0RV6Y20JyrTL
 a
X-Google-Smtp-Source: AGHT+IGYHFf61Kxgyb0MsCB7BZ2eUqlNrSO/Npbb38Wo0Yed3KP0B8AVs+Gr/LEtxY1OvUssYrV7fw==
X-Received: by 2002:a17:903:41c8:b0:1f7:1edf:4404 with SMTP id
 d9443c01a7336-1f8629006d9mr100992345ad.43.1718606233836; 
 Sun, 16 Jun 2024 23:37:13 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee9e3csm73480085ad.169.2024.06.16.23.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 23:37:13 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] target/arm: Make some MTE helpers widely available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-6-gustavo.romero@linaro.org>
 <49457f87-2b07-4e62-98ee-893f57a3ca2a@linaro.org>
 <e1a79665-62c3-5511-b7ad-baf8e72a17b1@linaro.org>
 <18b942c0-ffc9-48c6-aded-cd68fd54384a@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <5baa478d-5e52-2431-0131-1d25c9600e2a@linaro.org>
Date: Mon, 17 Jun 2024 03:37:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <18b942c0-ffc9-48c6-aded-cd68fd54384a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.677,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil,

On 6/14/24 9:34 AM, Philippe Mathieu-Daudé wrote:
> On 13/6/24 20:13, Gustavo Romero wrote:
>> Hi Phil!
>>
>> On 6/13/24 2:32 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Gustavo,
>>>
>>> On 13/6/24 19:20, Gustavo Romero wrote:
>>>> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
>>>> available to other subsystems by moving them from mte_helper.c to a new
>>>> header file, mte_helper.h.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> ---
>>>>   target/arm/tcg/mte_helper.c | 184 +------------------------------
>>>>   target/arm/tcg/mte_helper.h | 211 ++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 212 insertions(+), 183 deletions(-)
>>>>   create mode 100644 target/arm/tcg/mte_helper.h
> 
> 
>>>> + */
>>>> +
>>>> +#ifndef TARGET_ARM_MTE_H
>>>> +#define TARGET_ARM_MTE_H
>>>> +
>>>> +#include "exec/exec-all.h"
>>>
>>> Why do you need "exec/exec-all.h"?
>>
>> Otherwise one gets:
>>
>> In file included from ../target/arm/gdbstub.c:30:
>> ../target/arm/tcg/mte_helper.h: In function ‘allocation_tag_mem_probe’:
>> ../target/arm/tcg/mte_helper.h:77:9: error: implicit declaration of function ‘cpu_loop_exit_sigsegv’; did you mean ‘cpu_loop_exit_noexc’? [-Werror=implicit-function-declaration]
>>     77 |         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
>>        |         ^~~~~~~~~~~~~~~~~~~~~
>>        |         cpu_loop_exit_noexc
>> ../target/arm/tcg/mte_helper.h:77:9: error: nested extern declaration of ‘cpu_loop_exit_sigsegv’ [-Werror=nested-externs]
>>
>> Any other idea on how to satisfy it?
> 
> OK, I'll fix once I get my include/exec/ rework merged.
> 
>>>> +#include "exec/ram_addr.h"
>>>> +#include "hw/core/tcg-cpu-ops.h"
>>>> +#include "qemu/log.h"
>>>> +
>>>> +/**
>>>> + * allocation_tag_mem_probe:
>>>> + * @env: the cpu environment
>>>> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
>>>> + * @ptr: the virtual address for which to look up tag memory
>>>> + * @ptr_access: the access to use for the virtual address
>>>> + * @ptr_size: the number of bytes in the normal memory access
>>>> + * @tag_access: the access to use for the tag memory
>>>> + * @probe: true to merely probe, never taking an exception
>>>> + * @ra: the return address for exception handling
>>>> + *
>>>> + * Our tag memory is formatted as a sequence of little-endian nibbles.
>>>> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
>>>> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
>>>> + * for the higher addr.
>>>> + *
>>>> + * Here, resolve the physical address from the virtual address, and return
>>>> + * a pointer to the corresponding tag byte.
>>>> + *
>>>> + * If there is no tag storage corresponding to @ptr, return NULL.
>>>> + *
>>>> + * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
>>>> + * three options:
>>>> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
>>>> + *     accessible, and do not take watchpoint traps. The calling code must
>>>> + *     handle those cases in the right priority compared to MTE traps.
>>>> + * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
>>>> + *     that the page is going to be accessible. We will take watchpoint traps.
>>>> + * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
>>>> + *     traps and watchpoint traps.
>>>> + * (probe = true, ra != 0 is invalid and will assert.)
>>>> + */
>>>> +static inline uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>>>> +                                         uint64_t ptr, MMUAccessType ptr_access,
>>>> +                                         int ptr_size, MMUAccessType tag_access,
>>>> +                                         bool probe, uintptr_t ra)
>>>
>>> Do we really need an inlined function? Since it calls non-inlined
>>> methods, I don't really see the point.
>>
>> inline is just a hint and I think that in general at least the overhead
>> for calling this function is reduced, but it's hard to say what the
>> compile heuristics will do exactly without looking at the compiled code.
> 
> My question is about having the function definition in an header,
> instead of its prototype (and the definition in a .c source file).

Got it. I've moved the definition back to .c file and used only the
protypes in .h. I removed the inline for this function but kept the
inline for {load,store}_tag1 because I understand they can be easily
inline by the compiler. Please see v3.


Cheers,
Gustavo

