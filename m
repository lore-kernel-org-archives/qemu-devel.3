Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483C1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf58-0007P8-R8; Tue, 16 Apr 2024 05:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwf4o-0007My-Q2
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:26:12 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwf4l-0001Go-J6
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:26:06 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-369e3c29aedso18639355ab.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713259561; x=1713864361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXVhb8brYlfg9y9PMTKGdC+D/djaL9iRPIqdffYkTz4=;
 b=cgeoMTaqm4OIknRTzqF/ov8XvM+Bfb3gqai/JJdqYeZTPZ27V/Rtgf6paVNsZQOnk+
 a5FCEw5llmpe3tsRlrZXk4KdPIDcBmYh+RiDOrUy+tKdztNinUPPmDgGhl0buuvt5m4R
 t7Lk2gawGr0Fqb3b655A7Hqq606XlMRdu5phKfRKTfM+fe3tMpwoiXW1xmoX/ve4T2Ku
 jVwSaA383Ow6dcjXV57+wqdSql00ca1rZMkbenxHkBHk1AfAdP5MMJB1KGoB+yV4fooH
 0pFTTBuoPG3AAVkEKHa/n74iOudMFzmS0W6LGMECm+0a8EX0r8In453AqItIWQjDAYWi
 Lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713259561; x=1713864361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXVhb8brYlfg9y9PMTKGdC+D/djaL9iRPIqdffYkTz4=;
 b=iQZTZPFEvsQifmg45uk+oqbzOYRpO+8zVwbBC5HTUBIkhqLHiNUFQhT9119CLVZ6X0
 GbryPU5dK8CM1EHIK1Af95dpGJ7zSOIg+bua7muXjPpjxS78ffjWKnCkjIrNjzrggM7F
 CkoPVYvZa5qTb/k3B9L/asqH+1t41x0AB5yJQItYMzoiSQw6EhZhwMvO0ulM+AA/81+6
 lpCdXhXMMvz1DaZ6eT4aKi5KRIkpDbIYZFJopOOGnt/YCftW07t8KHPwx0qF8Nr2imgP
 uQJfYbUuHtvbWXsY6X79X5MTuBzu03BpYSIB2mZ21JU4Aj0LcSXFtjuyXWI4jNbl3Pow
 zaDQ==
X-Gm-Message-State: AOJu0YxRZl2lQ+fOtiSwjhmG5ZhlhLsbTCeafw32gEJRdj8HBI34Zlz1
 yvx3HFisW0G7yd3sI+PlzQ++6Ob/pBzf7nVBVBURVaREEKGI3B+jLbwzhY99SiA=
X-Google-Smtp-Source: AGHT+IGhAbnMJxflCiBtp+4bwFnOlJKhUMcJyLct3XJiZsDnMy/+85DcaL9WkEWUMYSoYRyRiaXxHg==
X-Received: by 2002:a05:6e02:152a:b0:36b:be7:f2d1 with SMTP id
 i10-20020a056e02152a00b0036b0be7f2d1mr12722463ilu.6.1713259561467; 
 Tue, 16 Apr 2024 02:26:01 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a63b54a000000b005dca5caed40sm8431575pgo.81.2024.04.16.02.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 02:26:01 -0700 (PDT)
Message-ID: <b93f13c4-05a9-4772-8ed9-a74b2f5f9cef@ventanamicro.com>
Date: Tue, 16 Apr 2024 06:25:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] target/riscv/kvm: QEMU support for KVM Guest
 Debug on RISC-V
Content-Language: en-US
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org,
 atishp@atishpatra.org
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <846ec319-6026-4b14-b156-9e1f42c6dba1@ventanamicro.com>
 <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x12f.google.com
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



On 4/9/24 06:43, Chao Du wrote:
> Hi Daniel and all,
> 
> The KVM patches have been reviewd and are in the queue.
> https://lore.kernel.org/all/20240402062628.5425-1-duchao@eswincomputing.com/
> 
> Could you please review in the QEMU side ?
> Then I will rebase this series with your comments.
> 
> Some Notes:
> 1. As the first stage, only the software breakpoints is implemented.
> 2. A 'corner case' in which the debug exception is not inserted by the
> debugger, need to be re-injected to the guest. This is not handled yet
> in this series.

Aside from the comments I made in patch 1 w.r.t checks that (perhaps) can be moved
to kvm-all.c, it looks good to me.

Since you're changing kvm-all.c we'll need Paolo to ack the changes in patch 1, so
feel free to wait for him to take a look before sending v2.


Thanks,


Daniel

> 
> Thanks,
> Chao
> 
> 
> On 2023-12-22 22:16, Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
>>
>> Hi,
>>
>> It seems that we still need the kernel KVM side to be sorted out first [1],
>> so I believe we should wait a bit until we can review this RFC. Otherwise we
>> might risk reviewing something that has to be changed later.
>>
>>
>> [1] https://lore.kernel.org/kvm/20231221095002.7404-1-duchao@eswincomputing.com/
>>
>>
>> Thanks,
>>
>> Daniel
>>
>> On 12/21/23 06:49, Chao Du wrote:
>>> This series implements QEMU KVM Guest Debug on RISC-V. Currently, we can
>>> debug RISC-V KVM guest from the host side, with software breakpoints.
>>>
>>> A brief test was done on QEMU RISC-V hypervisor emulator.
>>>
>>> A TODO list which will be added later:
>>> 1. HW breakpoints support
>>> 2. Test cases
>>>
>>> This series is based on QEMU 8.2.0-rc4 and is also available at:
>>> https://github.com/Du-Chao/qemu/tree/riscv_gd_sw
>>>
>>> This is dependent on KVM side changes:
>>> https://github.com/Du-Chao/linux/tree/riscv_gd_sw
>>>
>>> Chao Du (4):
>>>     target/riscv/kvm: add software breakpoints support
>>>     target/riscv/kvm: implement kvm_arch_update_guest_debug()
>>>     target/riscv/kvm: handle the exit with debug reason
>>>     linux-headers: enable KVM GUEST DEBUG for RISC-V
>>>
>>>    accel/kvm/kvm-all.c           |   8 +--
>>>    include/sysemu/kvm.h          |   6 +-
>>>    linux-headers/asm-riscv/kvm.h |   1 +
>>>    target/arm/kvm64.c            |   6 +-
>>>    target/i386/kvm/kvm.c         |   6 +-
>>>    target/mips/kvm.c             |   6 +-
>>>    target/ppc/kvm.c              |   6 +-
>>>    target/riscv/kvm/kvm-cpu.c    | 101 ++++++++++++++++++++++++++++++++++
>>>    target/s390x/kvm/kvm.c        |   6 +-
>>>    9 files changed, 130 insertions(+), 16 deletions(-)
>>>
>>> --
>>> 2.17.1
>>>

