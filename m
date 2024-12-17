Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEB7E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNSjH-0006A0-QE; Tue, 17 Dec 2024 03:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNSjF-00065n-O6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 03:14:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNSjC-0001e2-6e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 03:14:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so23132735e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 00:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734423288; x=1735028088;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdJKkQlsMfu3bz1p0BouPBSXGz56lGIODgAL1t7qqAc=;
 b=sdQyd9MMyAOsWsj6tJFwPlcnSxb9+acQMEH4KJcgzQfs/uc0dxazXqpQdHppFP68lE
 MmJzQMtm0ik4gRqIuk2VdhrhtTuKLTuQkFW6kTr2vV5iY06ev2yQ73x/bIN1KCnP0IW+
 GRBe6fjeMuNJ3lfML5+I22tDd3pIRNbAZ+Lhenc5V8favMTwtYo+kialG3A/fJ/Y1bv1
 VKi9Kee/xxFezl9I9nxg6hIfI6vusDg1x840d4t12hpqAwlbaLrH0CTDnFk0MrGu7jo2
 PyMaN1LLUoeiPrVWyR6mcUOkWpu4wDYsp9DCsVaq8XPXxIVOOHPJ6QQuSfgr7ciYGSC1
 ncvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734423288; x=1735028088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdJKkQlsMfu3bz1p0BouPBSXGz56lGIODgAL1t7qqAc=;
 b=YN4BU6CGvspji6X/GUAl2PuuUXbnGAhMUw7VtITGYWjWBuRwu8p1DlgiTDWaCrfh1e
 iF68xWWBdxKdeMdcprue1hXUyrWkBw6cwE2RECLtObAbxna184n9XM+TchSgzAS3MKme
 LgrGvfFEzFfj24gXLTkVScdwnXmV/VjR2WK0SNGvPuFOgCFIp/LTqWLKOez8HoYGMVJq
 2b7JjN/ieDM8a+Ey4tQ4ekjmBEqgg4zCR4La8HG20HyLiyAXCXAMD350jz6aWjqqnqvv
 RDovHYsLRAUGfpkUHh1faiGzbrGGYRRqht/PPeX6HPkJZzwl84v5upHCO1RQv/KHt/7t
 ZGmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2VcIC5pX2+QgkTbMwlaNVm7JdLYZHBOH0WotFqqQckEQNH+VQRCxzQAagHva6Lh5SHJuDnuWqmc0T@nongnu.org
X-Gm-Message-State: AOJu0YyeMp1bRh6E7UKfa98U5Yh56tAEZuQOAm+JD/x/Ak9aA7X3GRSP
 VFY2+Gs5qaxRjkIfTFuxDeqFBcNNOgz/gTTWzflv9EGHfsYStxeSnTc4dbE/Zv8=
X-Gm-Gg: ASbGnctZOMa2RoGzaJeYHMiUbxWCnGv/wWmmF7uv5w2jbeL46UH2RMFjNkL3iC1H9w+
 UG0ztFyROwVBbaguNyCEbbgNBhWRHDCFHGSZTkD09tAQ/ya9C4be1ucx8QHiHmpd8XWL4FSjGxY
 r7nmJiAuDfxPxM7BbiFU52emboogEvd59tmbGRPgY5xRwUlMNzDIELO7mXRDY/jRGSB5aGYF1lg
 Uk2ee2M90AEBl1ZocnH7Joz8J01x+WcSwNrPCyIWNUEg2dcWjsgwdEVZ6oTp34EY21wflFuVko7
 8r5fEx6rnMdRml3Ku7mNNkcIYw==
X-Google-Smtp-Source: AGHT+IHddHY6KNzUeIVH6cvrTy/fqU4W7ZXI4ADo4GknB7fcmm+fKydYB8/04z0lXu+0zFyruu1+xA==
X-Received: by 2002:a05:6000:4616:b0:386:1ba1:37dc with SMTP id
 ffacd0b85a97d-3888e0bd631mr10359650f8f.47.1734423287704; 
 Tue, 17 Dec 2024 00:14:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625550523sm164070095e9.7.2024.12.17.00.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 00:14:47 -0800 (PST)
Message-ID: <e85b59d2-a496-48f1-ba20-42190aa9a3ce@rivosinc.com>
Date: Tue, 17 Dec 2024 09:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] target/riscv: Add support for Smdbltrp and
 Ssdbltrp extensions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
 <CAKmqyKMk=8C-viR9Z+ATjxUNfq45krtS+3ccvhEdiKt-nG4Rfw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKMk=8C-viR9Z+ATjxUNfq45krtS+3ccvhEdiKt-nG4Rfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 17/12/2024 04:44, Alistair Francis wrote:
> On Fri, Nov 29, 2024 at 12:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> A double trap typically arises during a sensitive phase in trap handling
>> operations — when an exception or interrupt occurs while the trap
>> handler (the component responsible for managing these events) is in a
>> non-reentrant state. This non-reentrancy usually occurs in the early
>> phase of trap handling, wherein the trap handler has not yet preserved
>> the necessary state to handle and resume from the trap. The occurrence
>> of such event is unlikely but can happen when dealing with hardware
>> errors.
>>
>> This series adds support for Ssdbltrp and Smdbltrp ratified ISA
>> extensions [1]. It is based on the Smrnmi series [5].
>>
>> Ssdbltrp can be tested using qemu[2], opensbi (master branch), linux[3] and
>> kvm-unit-tests[4]. Assuming you have a riscv environment available and
>> configured (CROSS_COMPILE), it can be built for riscv64 using the
>> following instructions:
>>
>> Qemu:
>>   $ git clone https://github.com/rivosinc/qemu.git
>>   $ cd qemu
>>   $ git switch -C dbltrp_v6 dev/cleger/dbltrp_v6
>>   $ mkdir build && cd build
>>   $ ../configure --target-list=riscv64-softmmu
>>   $ make
>>
>> OpenSBI:
>>   $ git clone https://github.com/rivosinc/opensbi.git
>>   $ cd opensbi
>>   $ make O=build PLATFORM_RISCV_XLEN=64 PLATFORM=generic
>>
>> Linux:
>>   $ git clone https://github.com/rivosinc/linux.git
>>   $ cd linux
>>   $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
>>   $ export ARCH=riscv
>>   $ make O=build defconfig
>>   $ ./script/config --file build/.config --enable RISCV_DBLTRP
>>   $ make O=build
>>
>> kvm-unit-tests:
>>   $ git clone https://github.com/clementleger/kvm-unit-tests.git
>>   $ cd kvm-unit-tests
>>   $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
>>   $ ./configure --arch=riscv64 --cross-prefix=$CROSS_COMPILE
>>   $ make
>>
>> You will also need kvmtool in your rootfs.
>>
>> Run with kvm-unit-test test as kernel:
>>   $ qemu-system-riscv64 \
>>     -M virt \
>>     -cpu rv64,ssdbltrp=true,smdbltrp=true \
>>     -nographic \
>>     -serial mon:stdio \
>>     -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
>>     -kernel kvm-unit-tests-dbltrp/riscv/sbi_dbltrp.flat
>>   ...
>>   [OpenSBI boot partially elided]
>>   Boot HART ISA Extensions  : sscofpmf,sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu,ssdbltrp
>>   ...
>>   ##########################################################################
>>   #    kvm-unit-tests
>>   ##########################################################################
>>
>>   PASS: sbi: fwft: FWFT extension probing no error
>>   PASS: sbi: fwft: FWFT extension is present
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value
>>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
>>   PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
>>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
>>   PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
>>   INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
>>
>>   sbi_trap_error: hart0: trap0: double trap handler failed (error -10)
>>
>>   sbi_trap_error: hart0: trap0: mcause=0x0000000000000010 mtval=0x0000000000000000
>>   sbi_trap_error: hart0: trap0: mtval2=0x0000000000000003 mtinst=0x0000000000000000
>>   sbi_trap_error: hart0: trap0: mepc=0x00000000802000d8 mstatus=0x8000000a01006900
>>   sbi_trap_error: hart0: trap0: ra=0x00000000802001fc sp=0x0000000080213e70
>>   sbi_trap_error: hart0: trap0: gp=0x0000000000000000 tp=0x0000000080088000
>>   sbi_trap_error: hart0: trap0: s0=0x0000000080213e80 s1=0x0000000000000001
>>   sbi_trap_error: hart0: trap0: a0=0x0000000080213e80 a1=0x0000000080208193
>>   sbi_trap_error: hart0: trap0: a2=0x000000008020dc20 a3=0x000000000000000f
>>   sbi_trap_error: hart0: trap0: a4=0x0000000080210cd8 a5=0x00000000802110d0
>>   sbi_trap_error: hart0: trap0: a6=0x00000000802136e4 a7=0x0000000046574654
>>   sbi_trap_error: hart0: trap0: s2=0x0000000080210cd9 s3=0x0000000000000000
>>   sbi_trap_error: hart0: trap0: s4=0x0000000000000000 s5=0x0000000000000000
>>   sbi_trap_error: hart0: trap0: s6=0x0000000000000000 s7=0x0000000000000001
>>   sbi_trap_error: hart0: trap0: s8=0x0000000000002000 s9=0x0000000080083700
>>   sbi_trap_error: hart0: trap0: s10=0x0000000000000000 s11=0x0000000000000000
>>   sbi_trap_error: hart0: trap0: t0=0x0000000000000000 t1=0x0000000080213ed8
>>   sbi_trap_error: hart0: trap0: t2=0x0000000000001000 t3=0x0000000080213ee0
>>   sbi_trap_error: hart0: trap0: t4=0x0000000000000000 t5=0x000000008020f8d0
>>   sbi_trap_error: hart0: trap0: t6=0x0000000000000000
>>
>> Run with linux and kvm-unit-test test in kvm (testing VS-mode):
>>   $ qemu-system-riscv64 \
>>     -M virt \
>>     -cpu rv64,ssdbltrp=true,smdbltrp=true \
>>     -nographic \
>>     -serial mon:stdio \
>>     -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
>>     -kernel linux/build/arch/riscv/boot/Image
>>   ...
>>   [Linux boot partially elided]
>>   [    0.735079] riscv-dbltrp: Double trap handling registered
>>   ...
>>
>>   $ lkvm run -k sbi_dbltrp.flat -m 128 -c 2
>>   ##########################################################################
>>   #    kvm-unit-tests
>>   ##########################################################################
>>
>>   PASS: sbi: fwft: FWFT extension probing no error
>>   PASS: sbi: fwft: FWFT extension is present
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value
>>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
>>   PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
>>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
>>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
>>   PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
>>   INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
>>   [   51.939077] Guest double trap
>>   [   51.939323] kvm [93]: VCPU exit error -95
>>   [   51.939683] kvm [93]: SEPC=0x802000d8 SSTATUS=0x200004520 HSTATUS=0x200200180
>>   [   51.939947] kvm [93]: SCAUSE=0x10 STVAL=0x0 HTVAL=0x3 HTINST=0x0
>>   KVM_RUN failed: Operation not supported
>>   $
>>
>> Testing Smbdbltrp can be done using gdb and trigger some trap. For
>> instance, interrupt M-mode firmware at some point, set mstatus.mdt = 1
>> and corrupt some register to generate a NULL pointer exception.
>>
>> Link: https://github.com/riscv/riscv-isa-manual/commit/52a5742d5ab5a0792019033631b2035a493ad981 [1]
>> Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v5 [2]
>> Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [3]
>> Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [4]
>> Link: https://lore.kernel.org/qemu-riscv/20241122032217.3816540-1-frank.chang@sifive.com/T/ [5]
>>
>> ---
>>
>> V6:
>>  - Simplify and fix write_henvcfg() masking by assigning the written
>>    value to henvcfg and mask the value to be written as well as clearing
>>    the upper part of henvcfgh upon writing.
>>  - Rebased on RNMI v9 series.
>>
>> V5:
>>  - Use 0 instead of false to set MSTATUS_MDT in helper_mnret()
>>  - Added explicit comments about henvcfg write mask being tricky.
>>  - Fixed a invalid menvcfg_mask in write_henvcfgh
>>
>> V4:
>>  - Remove DTE from sstatus_v1_10_mask variable and add specific if for
>>    DTE masking where it's used.
>>  - Use mstatus_hs.sdt field rather than setting DTE to 0 in
>>    riscv_do_cpu_interrupt().
>>  - Add a fix for henvcfg value which was incorrectly set after changing
>>    menvcfg
>>  - Remove useless ext_ssdbltrp check in
>>    riscv_env_smode_dbltrp_enabled().
>>  - Remove useless mstatus clear in write_mstatus().
>>  - Add proper handling of SDT writing to vsstatus.
>>  - Add clearing of vsstatus//mstatus SDT field when DTE is disabled.
>>  - Fix wrong value being written for MDT/MIE in write_mstatush().
>>  - Rebased on Frank Snrnmi v7
>>
>> V3:
>>  - Fix spec version from 1.12 to 1.13 for Smdbltrp and Ssdbltrp
>>  - Add better comments for dte/sdt computation in
>>    riscv_cpu_do_interrupt().
>>  - Move some CSR related changes to the CSRs related commits.
>>
>> V2:
>>  - Squashed commits that added ext_s{s|m}dbltrp as suggested by Daniel
>>
>> Clément Léger (9):
>>   target/riscv: fix henvcfg potentially containing stale bits
>>   target/riscv: Add Ssdbltrp CSRs handling
>>   target/riscv: Implement Ssdbltrp sret, mret and mnret behavior
>>   target/riscv: Implement Ssdbltrp exception handling
>>   target/riscv: Add Ssdbltrp ISA extension enable switch
>>   target/riscv: Add Smdbltrp CSRs handling
>>   target/riscv: Implement Smdbltrp sret, mret and mnret behavior
>>   target/riscv: Implement Smdbltrp behavior
>>   target/riscv: Add Smdbltrp ISA extension enable switch
> 
> Do you mind rebasing this on:
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Hi Alistair,

Yes sure, let me do that and I'll send a v7

Thanks,

Clément

> 
> Alistair
> 
>>
>>  target/riscv/cpu.c        |   9 ++-
>>  target/riscv/cpu.h        |   1 +
>>  target/riscv/cpu_bits.h   |   8 +++
>>  target/riscv/cpu_cfg.h    |   2 +
>>  target/riscv/cpu_helper.c | 115 +++++++++++++++++++++++++++++++-------
>>  target/riscv/csr.c        |  95 ++++++++++++++++++++++++++-----
>>  target/riscv/op_helper.c  |  47 +++++++++++++++-
>>  7 files changed, 239 insertions(+), 38 deletions(-)
>>
>> --
>> 2.45.2
>>
>>


