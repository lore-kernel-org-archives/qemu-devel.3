Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DCCF6491
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 20:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sueFP-0000XM-0c; Sat, 28 Sep 2024 16:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sueFN-0000Wt-Vy
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:40:58 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sueFL-00035z-Tg
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:40:57 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e0d9b70455so1256906a91.3
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727556054; x=1728160854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eDsK52vhm5hJNurmRTzDLnhdXvFi5iE1BXoXe+ufMfk=;
 b=RKB9S2ZuFP1x8COiQ2WMiSVUbptYSNzc0SspspPtVe3kEtenFtEDdxKPHAy2qciMRs
 LgGmWEPkFh8gpC2Y2R5LWlPmNrOe0ux2H4yj3JJAAEKVG5K2KtxLaCOC4BqGu3YgEo91
 Wwsh9PG4m5YTE2TcxHTV9dBTqDh+j+1zu7xdaNxt9yoycnLwJRbTck4Zzhy6soSk4DW0
 DIEYSUf4Ci+6hbhSTTcTta9XXhfjr2AR0iX7oyocRUWGhwhj8MJcrhqKiR9qjsNs7NtK
 bON/PsHcbsSPSn4pPK1lb5Riw/q8jRAZ9vZlogtbrr4/LRmlElOxEohu7HQ5VigX3oI2
 puxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727556054; x=1728160854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eDsK52vhm5hJNurmRTzDLnhdXvFi5iE1BXoXe+ufMfk=;
 b=gDw0yRYatesjwiLXV0YOLLCN00MkguuKs6Qets4+L315Fz6I3xYP4mkrAB/234MTXQ
 P4ojLSCO9ttIpfnt+t7263uhxV6+MNmDZARpW9M0pM6j+ylc3nc+PeB09UzyciSkXaka
 LEuw/ETj5nLkgXObmY+ulx6PZkkmRVGvkotlZNXrD8UvwiX4M/jFlYAA+BBPBM+TdOVw
 nfEehBau7X+yn1KREl//SMYm2sNduVgt3iAg75IJnDkVsmInhj7jJymXtcEgHNJoijC+
 Pl2xZjIhDSJEc7E7SBQyoLXC2rhgHhbqFCBYoXhs0oYrmYM4BtDknrN9FwgqaKPicrjS
 F7jw==
X-Gm-Message-State: AOJu0Yw+gYI1YcYZDQX81D5kDu8eQQVNf6KFILytyE1S6zGMHlUsBV5f
 tffwZ7UrmiIryUrzqr2+ObqH5HGANUoPL3oVmw9DvIyby5NUOl0Yfnw7kfuDJl4=
X-Google-Smtp-Source: AGHT+IFbCmADtF32Q5kHQN2DMrkA6ZABcgQWe9C951DnuvaEq/XzBK+z6Xqbf0yKF+TzqOTgodbQCw==
X-Received: by 2002:a17:90a:fd84:b0:2e0:a0ab:7fcf with SMTP id
 98e67ed59e1d1-2e0b89d4cfemr8291882a91.12.1727556053826; 
 Sat, 28 Sep 2024 13:40:53 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e085341490sm7219589a91.21.2024.09.28.13.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Sep 2024 13:40:53 -0700 (PDT)
Message-ID: <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
Date: Sat, 28 Sep 2024 17:40:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 9/28/24 8:34 AM, Peter Maydell wrote:
> On Tue, 24 Sept 2024 at 23:18, Alistair Francis <alistair23@gmail.com> wrote:
>>
>> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>>
>>    Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240925-1
>>
>> for you to fetch changes up to 6bfa92c5757fe7a9580e1f6e065076777cae650f:
>>
>>    bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-09-24 12:53:16 +1000)
>>
>> ----------------------------------------------------------------
>> RISC-V PR for 9.2
>>
>> * Add a property to set vl to ceil(AVL/2)
>> * Enable numamem testing for RISC-V
>> * Consider MISA bit choice in implied rule
>> * Fix the za64rs priv spec requirements
>> * Enable Bit Manip for OpenTitan Ibex CPU
>> * Fix the group bit setting of AIA with KVM
>> * Stop timer with infinite timecmp
>> * Add 'fcsr' register to QEMU log as a part of F extension
>> * Fix riscv64 build on musl libc
>> * Add preliminary textra trigger CSR functions
>> * RISC-V IOMMU support
>> * RISC-V bsd-user support
>> * Respect firmware ELF entry point
>> * Add Svvptc extension support
>> * Fix masking of rv32 physical address
>> * Fix linking problem with semihosting disabled
>> * Fix IMSIC interrupt state updates
>>
> 
> This fails the riscv qos-tests on s390x. My guess is that the new
> IOMMU support has endianness bugs and fails on bigendian hosts.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7942189143
> 
> full test log (4MB) at
> https://qemu-project.gitlab.io/-/qemu/-/jobs/7942189143/artifacts/build/meson-logs/testlog.txt
> 
> The assertion failure is
> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)

The root cause is that the qtests I added aren't considering the endianess of the
host. The RISC-V IOMMU is being implemented as LE only and all regs are being
read/written in memory as LE. The qtest read/write helpers must take the qtest
endianess into account. We make this type of handling in other qtest archs like
ppc64.

I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x-all-system
job to verify it, even after setting Cirrus like Thomas taught me a week ago. In
fact I have no 'ubuntu-22-*' jobs available to run.

If there's a way to run these ubuntu s390x tests, let me know. Otherwise I'm inclined
to remove the IOMMU qtests for now until I'm able to verify that they'll work in a
BE host (I'll install a BE VM to verify).

I also saw that you made comments in one of the patches w.r.t license text and other
changes in the base code. I'll get to it.


Thanks,


Daniel



> 
> but there are a lot of virtio errors before that so the
> problem probably happened rather earlier.
> 
> thanks
> -- PMM
> 

