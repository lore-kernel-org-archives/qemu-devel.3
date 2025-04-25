Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57B7C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HcC-0007Se-43; Fri, 25 Apr 2025 07:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8Hc9-0007Pv-4c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:53:05 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8Hc5-0000KM-Fx
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:53:04 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b074d908e56so1469314a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581979; x=1746186779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GcNXf7DIbL50r/3uCyCpmAaenNe2fphdxOkQrVg/xCU=;
 b=dn3aTjHBrwRFDjMEa8kX3RfAJ/NX74bD1oUVa2KEh6ze9dy47lfDpyX2fnEOOuRLOv
 VvJe0ydSqgz8FLPGkGMN2QJAsyIOD9wZqeEPnw0ca6HKMGHYTFDKZN3nTsSbmmxQ6WZX
 mGOP4di/6WEwySL0Fa1h79eDkscXDZfvtK+spBz5kEkWgcD0U0ViuDNpb9PjGbqVhBS0
 8BGiExisIZ8d/Z+D2RxD4um/QrGnbMzl5rKS1cqnvNpHpe4mbLdMI9oUbVnSGRbNY5uo
 TCmRIj66N0BuLxsVKsBnGV+rC+9MrgiIjubGtz471nGReEHUKXWXeRbFYee74hZEZoN5
 axsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581979; x=1746186779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcNXf7DIbL50r/3uCyCpmAaenNe2fphdxOkQrVg/xCU=;
 b=Dwm5WX62bxkuJDdk2UU5OzmOESfTA3PeP81P9F2cm7O4BLFD4aS+cYglt70XWf7Bkw
 P2ZLEn8a6PosUbdGgNjToqPi8OVlHP4hr864gf5XdFf6bWNpy70rGBEPZjmO3z5Mdvau
 WJhi9DSE2+JRFcCK9sX3425byp67yorQT6wtL4g9op1133HjG+Bzm0IGTa2Mkq97BgnJ
 GTQjIkdLKRXz3Y/YzFjXLZjFUW9ZWfh+L73XWSt3h90y+849K6Qx+ZzU8S8gfGSGtdnP
 qwDz9az50sMiy04yYTcRBwqv68Rcahk4jye3qPys2eBvaRkJQHTLkDtalITFwglbnKex
 pwrA==
X-Gm-Message-State: AOJu0Yyb79zTbs3ZnbDGuJ7Tevc1fwK26yfWj8jzt4PpGpyZL27MWuXh
 T3EOBGBRhiUxmU/8vfEX/BQ3b7Wz7Pd9yiznH3esgNisYIuFmEIAP1OVYIb4b5I=
X-Gm-Gg: ASbGncuH0/L9zki3WImJQ0P4+BPJpVYgkukwTyed7PTdy0nz7QZTmIIB0B+UvjpygPz
 95yPlfw7kJW4dWCO7kZJvNFdzs7GVeVMGHp7+WfewxkZvmEdIMcyNA4LcWsZ6J2ck5rSZX89tVN
 ISWuSPVudEe2j0RZ42qPxQtZJTbxlNfUIQPCBWZyfofeFoECG3uPoeEev52quA/suUo1CHLT0EZ
 1JOB7mB8Uy2qFK1e+voXZqsqoCH005nlhA9NpyH//gvqT1PlKWZf47MboSR4bEmSWGHEBKnotjd
 HSGF01QbxvHD4abG3lVnF7ugNA7evnEWUCCwBHojy8q/qEl4GRHVjus=
X-Google-Smtp-Source: AGHT+IEyoA48IDNQZsQl0JUBJq0ml+dEvjssfa61zQcdxPDcjyqmYrIwEZhmJoeUF1aIrU3+oPNuHw==
X-Received: by 2002:a17:90b:3941:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-309f7df9f58mr3508659a91.16.1745581979331; 
 Fri, 25 Apr 2025 04:52:59 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f784a56asm1397820a91.41.2025.04.25.04.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 04:52:58 -0700 (PDT)
Message-ID: <7d5181de-eb42-44b0-80cb-b2f8a3aed47c@ventanamicro.com>
Date: Fri, 25 Apr 2025 08:52:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Conor Dooley <conor@kernel.org>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-2-dbarboza@ventanamicro.com>
 <CACPK8XfF74wHqdBBz=qPLefAD8pKT-0C8e=kfFtTeMH+teF-7A@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CACPK8XfF74wHqdBBz=qPLefAD8pKT-0C8e=kfFtTeMH+teF-7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
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



On 4/24/25 6:51 AM, Joel Stanley wrote:
> On Wed, 23 Apr 2025 at 20:37, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Throughout the code we're accessing the board memmap, most of the time,
>> by accessing it statically via 'virt_memmap'. This static map is also
>> assigned in the machine state in s->memmap.
>>
>> We're also passing it as a variable to some fdt functions, which is
>> unorthodox since we can spare a function argument by accessing it
>> statically or via the machine state.
>>
>> All the current forms are valid but not all of the are scalable. In the
>> future we will version this board, and then all this code will need
>> rework because it should point to the updated memmap. In this case,
>> we'll want to assign the adequate versioned memmap once during init,
>> in s->memmap like it is being done today, and the rest of the code
>> will access the updated map via s->memmap.
> 
> I was writing a patch for a machine and came across the same
> inconsistencies. Nice clean up.
> 
> Some of the device initlisation code could be refactored out to be
> shared by other machines within the riscv directory. Related, parts of
> the device tree creation could belong to the model, instead of to the
> machine, as the properties are a property (!) of the device.


Yes, delegating the FDT creation to the device, instead of having each machine
to create the (mostly) same FDT code over and over again, is something that
I've considering for awhile.

I keep postponing it mainly because I would like to verify with the DT folks if
there's a guarantee that a given device/CPU DT is always the same, i.e. a device
DT is always the same regardless of the machine. I have a guess that that this is
indeed the case but a confirmation would be nice .... Conor, care to comment?


In this refactor we could then create FDTs by passing along a memmap pointer and
a fdt pointer, as you've suggested.


All this said, there's no need to do such FDT refactory all at once. I think I'll
start with the most common devices between RISC-V boards and go from there.

Thanks,

Daniel


> 
> With that in mind we should consider passing the eg. fdt pointer and
> the MemMap pointer instead of machine state, where practical.
> 
>> We're also enforcing the pattern of using s->memmap instead of assigning
>> it to a temp variable 'memmap'. Code is copy/pasted around all the time
>> and being consistent is important.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel


