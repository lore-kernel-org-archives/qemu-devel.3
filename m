Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14886CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUiM-0002Vi-U0; Thu, 14 Aug 2025 05:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUiJ-0002VP-7P
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:57:39 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUiH-0001JG-8W
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:57:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b471746a879so421417a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755165454; x=1755770254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2CecmyLvApD+cI95csrHAn+C/vC7pTWdJq16QdlJzQY=;
 b=V8BAPl350KPsdD8eUFwStrq2OqUk1FDbaesxgAbEfrt9wRStjWhlGH91HCIKbvbUJB
 RdL+IGwbPEsfMuSjLkutfL77QGuKuzSlYpew8AzGM5ApnliVomXHvpBlfPM2zNGsPR9a
 4Y/cc8rx4dL6Y4zx6+pYNVHZuy+CJMqMg7+s8NDOusCwjfOxLp8R76u/pVik8bI9aPGr
 JKcSbwexijQB7PxZzjaXHMhU7sWKnpQjPTZwRoEv3STnE3NWdNL95SQP4y51o9TZOpq4
 zoUEFDxMyyK+A71whksR9PeZzCdGuoCrmw5SzVJ05yG86FinSQD1TMEtvrujttKtwPa7
 5uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755165454; x=1755770254;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2CecmyLvApD+cI95csrHAn+C/vC7pTWdJq16QdlJzQY=;
 b=sg/KD4aIRIQmHfGROGa/2GYY/yNq6BuJy41PnCpfmobeQsY06R60Cvh2ejro/zvxSt
 tC7HlvIPoPoffIxvEXkQ4iK2HfZ9uzqQ186mbTWA6H3BgBhdcj0hsX37gqj9sjxIaVqu
 HxQ6g/8jX6T4Y8fReHP0ePfD3Qfbd8hBNYzb9VcmNFwQS+eTFwMHft/qACxuobgppdyo
 wmDP3Qkwu3wjZKspAAtskMtaW3qovaY4LtfDAscw7DIkDKfJGjX7R5DhaiyAYs5RQl0q
 8mk+aDzlBSdccOl5UMpRmnV+2DvNLbkPkuW6pX5aS52wOf6vN9snxHjVAGSyrVQxLSjN
 OxbQ==
X-Gm-Message-State: AOJu0YwiATw4k8jKHsv8jRcX+Ko7Vm5x1DraBAmY7q8G/wE4iv3ACt3R
 awYLNmCAPw20H47R9HBW2L4Hq4aNcSIXmlbUXpiOqBdyxQ6YLqsIE6Ys7NZXyYq1gDdmd5Y5QYM
 oUkB/yBg=
X-Gm-Gg: ASbGncsRghuIBGM+jpUpufaIAT0lUCukwlxL21esu7iGa+aZCyOhOm9EfZEXZEqWQMb
 lZgP+m6UlxhCUQ8Il0m3Q38ORqQHM2w6sCwfG0jCigUWUbk6BRhi/umGCnpWPh9EG63HLYb2JQk
 7TnB2IQ+XeZXUHGVmFYhH0nan1rAauJjrtjtZi9Io6/rMsMA3FBnrvPg2NyqH+hUMjx01C/3pv3
 FmRs0o70VFi1X7XNWu4027IlJv623MWYxBJ5JqisBuZXJTOFGUUAZib+jG6VRcu0aZ8QwNAhxkp
 F7mMLHrxee05jKp5IrMfSnbPCYHzZ98TED7SM0j6KVp1FzDDxo4N3JqDOnVDJq+1/od8TgBnWQo
 4QP0rPuj0nOzIkZbEZmDONBvKiM3jZ32oZP4RJzSVW+v/4e2avJN4ldjcXzEXDF0Q56EsT29htP
 YCTX/QlNewAw6uzfDOLcnw93p8xc1Y23iydV89zxjnZR6/u1XeOm+mg8vXem8V2Lbu
X-Google-Smtp-Source: AGHT+IFDWDgdrkCh9bQpyXofdUi4bdfP6XPmhd4PsYD3hdQCqoFfnA3plwX9/BMUOIk/AIkxLmXvtA==
X-Received: by 2002:a17:90b:3d8c:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-3232787da7bmr3887215a91.0.1755165454219; 
 Thu, 14 Aug 2025 02:57:34 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7?
 (19r3hzjy9klp0jf5b7z5.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100bbb9sm1298749a91.15.2025.08.14.02.57.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 02:57:33 -0700 (PDT)
Message-ID: <bc3d404d-1c93-4799-b4bf-b4c05f1ac2fa@linaro.org>
Date: Thu, 14 Aug 2025 19:57:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
To: qemu-devel@nongnu.org
References: <20250814070650.78657-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/14/25 17:06, Philippe Mathieu-Daudé wrote:
> We weren't parsing MIPS ASE in the ELF header, so couldn't
> automatically pick an appropriate CPU.
> 
> Since we'll have a rc4, I propose these sensible patches
> for 10.1, but both ASEs are available since 15 years in QEMU,
> so this isn't something broken since the latest release, and
> I don't mind holding it for 10.2.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>    elf: Add EF_MIPS_ARCH_ASE definitions
>    linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
>    linux-user/mips: Select M14Kc CPU to run microMIPS binaries
> 
>   include/elf.h                | 7 +++++++
>   linux-user/mips/target_elf.h | 6 ++++++
>   2 files changed, 13 insertions(+)
> 

Does mips16 or micromips apply to mips64 as well?
If so, we're missing changes to linux-user/mips64/target_elf.h.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

