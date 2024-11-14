Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA7D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfY9-0000a3-1x; Thu, 14 Nov 2024 14:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfY6-0000Yl-Pw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:30:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfY2-00038m-UD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:30:37 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so2770a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731612633; x=1732217433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gClJSDryqyzGW/CDAAQbDzZTo3HzI26hzPRY0qf4Mv0=;
 b=h+AlpjKB3n/PGL3TeckdHteOBT0kZkmLjEE+RvV+bH72Sk2xOD3kYFJFUTlxXRnvTj
 MbFkM+51iq6LToJgMuJtx656OeAOwmT23gxVJxZz0kolf3SVPiD0s0j0GPPouu0Bb2Zq
 fRoRMCdUxGpE++DEykUxtQQIrzSDJqD6V6jmBX9CjHgK2QZcAlXDFLsWTWwl/LR2/Qxc
 RmLMe4ycyc3+CdPj5w/P1Nezq6Iav9/OiqTZeuJGdi0b31huaeEsJzmr5f1eOuyX8lGK
 9Relts5fDUS2UTcp4ToVkSnEQDhlmfhV8Yzgk9BIMwQN4i1SCF0F6p7GklSvUkBY4lzt
 hVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731612633; x=1732217433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gClJSDryqyzGW/CDAAQbDzZTo3HzI26hzPRY0qf4Mv0=;
 b=kiMHYiUcYE/Hfls8d8MIMpoQutyJfmfYevqeLB09LSngydld6Mycv8e524bx+/Xz5t
 Sed3hr+/C1hxHZs9NnWcbrB8/0oKo3T8Z4lETLX9ADBgWHfVwx7m5NDns2XK5ZDVS96T
 Nv96+wxMp/w8lqyxebNZ9sBK28Xoc1K0VFWWENGvjVRJE8mFP3HhA9Yjer3p6IIetJjH
 nd8sh8Qqm9BzHzH4jg5mCnkMBtieTUwW/W6n4GR5u5O3rGSI8WhfOPa8w3RiRBYFeGYK
 FPeZvNpaNO1ap0x7q5psBRG3epnQfit+RLV32M3HulR1xc0TLtY/Ua1q2QL/UoRT0Oej
 wtEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2oQZBBLGNUW3xiK8xCMnN3zq9HthnckLdoS3ypCLz3CXK/mtvMUg+ANIJq7DCko6Mdw+DR71n8s95@nongnu.org
X-Gm-Message-State: AOJu0YxEueBidof7P9R2+waVLaH2t4hGs4JVWJq+0c3Xx0uzgr1gppZE
 OZzghRHjVI1LKvHvAFQInpDdfv//r1xNss+uHyVBJYJUn5JqHj8DGg9DN7jHAHc=
X-Google-Smtp-Source: AGHT+IFXOq4Fs2Vb27gOMb9nqZAFEqOhXZCuLw/R1GnhNPWqeMnpifKuJCSvkvUXl6pvZwUjRkT4yQ==
X-Received: by 2002:a17:90b:350e:b0:2ea:14c4:7b8c with SMTP id
 98e67ed59e1d1-2ea154cd16amr116831a91.5.1731612633174; 
 Thu, 14 Nov 2024 11:30:33 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f9c677sm1684783a91.36.2024.11.14.11.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:30:32 -0800 (PST)
Message-ID: <cb884943-6d0d-46a4-9d6a-f18dda3d7835@linaro.org>
Date: Thu, 14 Nov 2024 11:30:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] exec: Declare tlb_flush*() in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Move CPU TLB related methods to "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cputlb.h                | 187 +++++++++++++++++++++++++++
>   include/exec/exec-all.h              | 183 --------------------------
>   accel/tcg/tcg-accel-ops.c            |   1 +
>   cpu-target.c                         |   1 +
>   hw/intc/armv7m_nvic.c                |   2 +-
>   hw/ppc/spapr_nested.c                |   1 +
>   hw/sh4/sh7750.c                      |   1 +
>   system/watchpoint.c                  |   2 +-
>   target/alpha/helper.c                |   2 +-
>   target/alpha/sys_helper.c            |   2 +-
>   target/arm/helper.c                  |   1 +
>   target/avr/helper.c                  |   2 +-
>   target/hppa/mem_helper.c             |   1 +
>   target/i386/helper.c                 |   1 +
>   target/i386/machine.c                |   2 +-
>   target/i386/tcg/fpu_helper.c         |   2 +-
>   target/i386/tcg/misc_helper.c        |   2 +-
>   target/i386/tcg/sysemu/misc_helper.c |   2 +-
>   target/i386/tcg/sysemu/svm_helper.c  |   2 +-
>   target/loongarch/tcg/csr_helper.c    |   2 +-
>   target/loongarch/tcg/tlb_helper.c    |   2 +-
>   target/m68k/helper.c                 |   2 +-
>   target/microblaze/mmu.c              |   2 +-
>   target/mips/sysemu/cp0.c             |   2 +-
>   target/mips/tcg/sysemu/cp0_helper.c  |   2 +-
>   target/mips/tcg/sysemu/tlb_helper.c  |   2 +-
>   target/openrisc/mmu.c                |   2 +-
>   target/openrisc/sys_helper.c         |   1 +
>   target/ppc/helper_regs.c             |   2 +-
>   target/ppc/misc_helper.c             |   1 +
>   target/ppc/mmu_helper.c              |   1 +
>   target/riscv/cpu_helper.c            |   2 +-
>   target/riscv/csr.c                   |   1 +
>   target/riscv/op_helper.c             |   1 +
>   target/riscv/pmp.c                   |   2 +-
>   target/rx/cpu.c                      |   2 +-
>   target/s390x/gdbstub.c               |   2 +-
>   target/s390x/sigp.c                  |   2 +-
>   target/s390x/tcg/excp_helper.c       |   1 +
>   target/s390x/tcg/mem_helper.c        |   1 +
>   target/s390x/tcg/misc_helper.c       |   1 +
>   target/sh4/helper.c                  |   2 +-
>   target/sparc/ldst_helper.c           |   1 +
>   target/tricore/helper.c              |   2 +-
>   target/xtensa/helper.c               |   2 +-
>   target/xtensa/mmu_helper.c           |   1 +
>   46 files changed, 231 insertions(+), 210 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

