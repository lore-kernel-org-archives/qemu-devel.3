Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82248C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 17:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCido-0004jy-Ti; Wed, 07 May 2025 13:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCidg-0004jX-NC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:33:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCidb-0004Me-67
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:33:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e8461d872so1861545ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746639173; x=1747243973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YnImbLj2YsBt1t8GOwJuiQKft8HLApT5bPaKaAi4Wqc=;
 b=ROXtFWjw6QZdP/6Lp6UxtH/Xx5Y1yZv/r86IXETnbvVgykW7lSJO0EougihoNkeJvZ
 gtA69uaZhHmgZS0DxHnZUbJVisSMbKQm3l+oVEJiqm8J5Php+I/iTFuAKg/aXOYnFsSJ
 Ih07OBauxZTUVXgwIYwOttRlgJQ8h/MHBroFDy9x2HKGrryeE9BU0W5Ct0bHN7KqqwOd
 wDPCZ0AVwWTdtfo15clTPhan47PV+a7ZJIV9UR4V9Eg5naLXSdpYUH2xc+dk/GrrUniD
 nBv3f0sLriAYuX7M0Xqobh5erjeasQhYoFIa00wYcMumNwq/ajsQEsPpINlBRsTYqKgr
 WABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746639173; x=1747243973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnImbLj2YsBt1t8GOwJuiQKft8HLApT5bPaKaAi4Wqc=;
 b=wv01pl+r2rNCMC4aqOyanaxlZguyj2xanL+32Q/3rCLfmoCkhTpWuZHkKg/DEt/pai
 7bGzJiEedvTO4FLZLzKjwYVjpaUt5iYXLRXYxFdTyD5i5JcPlO5Kk7zcM1phB4y3TA3A
 ifZM0o7REOEQa975PgNFIdJU5ySO4jfZRr3Y1010l9bOhN0CoaQqymOZ12GMRVipmxUi
 l0srEi3FAOXu1PEORRvv+6ktyIPwIBEYgHiPmGYbSygYZsvycGnTYCZQPP8AitQ3AW77
 SeGv/rVMRf5SS/Ss8wzvrvg8L6L7Y/Mymld6rzebiIk1zk8L5Z07qqRR5cns2wrsY0iE
 yYjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDUKQNd9vW1PKtpihpXo1O5SCidcSJZBcyK7VpsWJfyRionZ0WoATm3cyRlj5koKXcEEmDLHTrx+m@nongnu.org
X-Gm-Message-State: AOJu0YwD+9QdtINC0r0hyd1He+yprUlL7Shnn6va6Ez4z5wfxVqQtGOt
 b54+9oHASEhwpgiTXBX/PPxKwiKI9fwMDwvBURCHcYYxRkjKc8Q707CQYtgiJcmKJ9EGI/NJCSi
 q
X-Gm-Gg: ASbGnct6FvYi3QRZLdNYqZf7zZq0s+TCnd9Il4oOwP1UJlZeR4PdTDh2ht9YpYqeXwS
 N0RHZVZU7HTHbzaERqP1du1pJ4C7uT+9B126D1WQGgD1bUows1VzlziZSjjD41OouX0Q+c7S1H/
 xdR93ev31FTjPs+jDjMxI9Uqh52oajAIKjufZvte6IgxVSNFwgDTNt+0Cq+uPq6trgqPy3iSJ9a
 G7wPVO5hv1ANG8L84edDr3B9vYqpqdAODxtD0fvqQGf7667QAlu8zvGmmjHVBVnFjxpwIGnO1B3
 AeF1yhwsfyaOQbUSmuk8hU8qldLev+l0dbd6IKo5mW3gIqYCZGNFSovtCKwcJ1wfva3bzaMmTeQ
 uTQYI4V4=
X-Google-Smtp-Source: AGHT+IEspUW/UeDsyECRYbHMQMpPVn9iCAG+/kQPvGdiNKJ1+pqQTXD0YRUM+/hIu3pIpoVyOoDOwA==
X-Received: by 2002:a17:903:945:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22e8a7f907dmr2375485ad.40.1746639172919; 
 Wed, 07 May 2025 10:32:52 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e7404da11sm11339955ad.153.2025.05.07.10.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 10:32:52 -0700 (PDT)
Message-ID: <86fd8b94-005c-4a6c-8871-e2e0faab32e5@linaro.org>
Date: Wed, 7 May 2025 10:32:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue
To: FOSS <foss@percivaleng.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <BN0P110MB1882C48884953FCFBD6CA230C688A@BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <BN0P110MB1882C48884953FCFBD6CA230C688A@BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/7/25 09:38, FOSS wrote:
> Thank you for working on a fix for this! Should we include our functional test as a patch 
> to test for this in the future or do anything else to help with this?

The test didn't work for me.  It's probably better to write a stand-alone test case.


r~

> 
> -Percival Engineering
> ------------------------------------------------------------------------------------------
> *From:* Richard Henderson <richard.henderson@linaro.org>
> *Sent:* Sunday, May 4, 2025 8:57 PM
> *To:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> *Cc:* FOSS <foss@percivaleng.com>
> *Subject:* [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue
> [You don't often get email from richard.henderson@linaro.org. Learn why this is important 
> at https://aka.ms/LearnAboutSenderIdentification <https://aka.ms/ 
> LearnAboutSenderIdentification> ]
> 
> As detailed in
> 
> https://usg02.safelinks.protection.office365.us/?url=https%3A%2F%2Flore.kernel.org%2Fqemu- 
> devel%2F174595764300.3422.13156465553505851834-0%40git.sr.ht%2F&data=05%7C02%7Cfoss%40percivaleng.com%7Cbcd8ed34f3e342df86f008dd8b4e40b7%7C7e469936b9c44e65a905faf8e5ffac80%7C0%7C0%7C638819890414363571%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=i%2FTD9xTTxa4eRseMhadW%2FLw3hPMDp2sPDJF%2BzIzjfJw%3D&reserved=0 <https://lore.kernel.org/qemu-devel/174595764300.3422.13156465553505851834-0@git.sr.ht/>
> 
> there's an issue with an unaligned access that falls off
> the end of the last page.  To solve this, we need to know
> about the state of the cpu, so add a new target hook.
> 
> There are arguments to the hook that are currently unused,
> but would appear to come in handy for AArch64 v9.5 FEAT_CPA2,
> which we do not yet implement.
> 
> 
> r~
> 
> 
> Richard Henderson (12):
>    accel/tcg: Add TCGCPUOps.pointer_wrap
>    target: Use cpu_pointer_wrap_notreached for strict align targets
>    target: Use cpu_pointer_wrap_uint32 for 32-bit targets
>    target/arm: Fill in TCGCPUOps.pointer_wrap
>    target/i386: Fill in TCGCPUOps.pointer_wrap
>    target/loongarch: Fill in TCGCPUOps.pointer_wrap
>    target/mips: Fill in TCGCPUOps.pointer_wrap
>    target/ppc: Fill in TCGCPUOps.pointer_wrap
>    target/riscv: Fill in TCGCPUOps.pointer_wrap
>    target/s390x: Fill in TCGCPUOps.pointer_wrap
>    target/sparc: Fill in TCGCPUOps.pointer_wrap
>    accel/tcg: Assert TCGCPUOps.pointer_wrap is set
> 
>   include/accel/tcg/cpu-ops.h | 13 +++++++++++++
>   accel/tcg/cpu-exec.c        |  1 +
>   accel/tcg/cputlb.c          | 22 ++++++++++++++++++++++
>   target/alpha/cpu.c          |  1 +
>   target/arm/cpu.c            | 24 ++++++++++++++++++++++++
>   target/arm/tcg/cpu-v7m.c    |  1 +
>   target/avr/cpu.c            |  6 ++++++
>   target/hppa/cpu.c           |  1 +
>   target/i386/tcg/tcg-cpu.c   |  7 +++++++
>   target/loongarch/cpu.c      |  7 +++++++
>   target/m68k/cpu.c           |  1 +
>   target/microblaze/cpu.c     |  1 +
>   target/mips/cpu.c           |  9 +++++++++
>   target/openrisc/cpu.c       |  1 +
>   target/ppc/cpu_init.c       |  7 +++++++
>   target/riscv/tcg/tcg-cpu.c  | 26 ++++++++++++++++++++++++++
>   target/rx/cpu.c             |  1 +
>   target/s390x/cpu.c          |  9 +++++++++
>   target/sh4/cpu.c            |  1 +
>   target/sparc/cpu.c          | 13 +++++++++++++
>   target/tricore/cpu.c        |  1 +
>   target/xtensa/cpu.c         |  1 +
>   22 files changed, 154 insertions(+)
> 
> --
> 2.43.0
> 
> This electronic message and any files transmitted with it contain confidential and 
> proprietary information, and is intended for use only by the person(s) to whom it is 
> addressed. Any use, distribution, copying or disclosure to any other person is strictly 
> prohibited. If you have received this message in error, please notify the e-mail sender 
> immediately, and delete the original message without making a copy.
> 


