Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CACC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 17:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukmw8-0001p3-Ah; Sat, 09 Aug 2025 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmw6-0001ls-08
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 13:00:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmw2-0006WH-4W
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 13:00:49 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b429abd429aso1516166a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754758844; x=1755363644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixQgNraBzt43yG3Hmff9feLCBFYhlz8KdrJ9jJlcCo8=;
 b=HgkxSs2/3AdqjqyhIIm2EouKVnMXco3PXn3wsbbKn8DRiaCYyY24FK1JJCoHQZlK5s
 5ntJY5GlYOJvXjbF/D7CoYmJBf8JhVjb9sRRw/hxfPFcKEqJJoOFu38wgte+0kCUdKee
 e5078Nxai9JfeC9rMn+yrjfUPEZomVwZBO7fGhsTNSE8nKqLqwo2C35SUiQ+Ug1G6Xw1
 SxwwnsUCfA0VEm5MquVJmOEwwp1kSt76WobHL+da8ytWkHw0V7OjOKhYdDWzkE/ryOLz
 kT42Jv9po87pEqOGM6NUxJDsdilg4hXEUir4JCFhTgALbHB+qYVuCyVhy3aQjGnhipon
 PuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754758844; x=1755363644;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixQgNraBzt43yG3Hmff9feLCBFYhlz8KdrJ9jJlcCo8=;
 b=o1rjlw+mF0NRMY6uJedRfqjue7cjZl2Wvv1johus4ymvUtP7LUfFA5remUKOrY5275
 KCy3dMh5e9ESJHHbowPx+jb2xa7h2SZQND9ga/OsMHJODAoj8lH2niteygU36tS9gGqR
 YrL+uTlKoZKWhn5rFtXiPZluAG2YssruSySOywxjbXhNHNWRNB2sqlysvCl78raNaWRR
 Q3c8BWwuHRKtpP69JET6PUesG5ueJMxlJQWBLeX2/UH/if5Nqc3Cnn4V07lNBDfzInix
 m08lib/89gJUQUfTfA1YVsrcnxPZXfJEosXU+8id1zLBCQYQlCM0heKHWMVPATbQAxxs
 DABw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqmYIjuLgrz61vns+sltbIStDNorCam+uzlAa7jeL7iSimm7E/KfhIVmbygQQbgoZklGRhtIs4409k@nongnu.org
X-Gm-Message-State: AOJu0YzQLOvo/DPAQbJCFfmV7vvVCUKYO04KBSuAOSuBr8fqhF6Imj/u
 RpcKfRCLrmYYIEabBRXA6BpnS89nBkKiTzYlKXTa6ESk38vfyjn/ksnxCRFj+WpcGaA=
X-Gm-Gg: ASbGncuPcRAITmArjLS0Soxk9unvEjDeVtvTJiCmgAiHMnzk3rsB7qLPHz9f+FJ+oSx
 9j0qavJIrv2Mn3pru520+jkLj92eXNM6IUAXQqC9VGpGyGlKllkzMn2ELzLIX/Jeh/l4iwESqj+
 W2ojRAr8XkYNYXQFgUMeMBKnZELLSmUaXmnvoZVD6glYimkIQ1l7khP83nCJKEvi9jJjdbYKwGi
 ITKiL1GERViw7uvSjvoE08Z8ZT2hFxUTQ1tse9fin4bpKg/M4UQ++vRfkZI1R5UdygX6sSlC1wI
 HinqvL2xdcoZEWmqWIrSU2f/VoRJdk+7sav+KGII5aIrFgk6mqx+ntlkVbZ0h3mVyTCyPjYZWX2
 R5IeUgh6+sG6Szc6YCJTs5mwbabvRNvdL9NP4mw==
X-Google-Smtp-Source: AGHT+IEbJ7NQ9OA+h8EyRZsqHa5e4ZzGya8/10FIk9zy6JMyoA2Qz5S9euveaEVM75hTNj7J0TMbvA==
X-Received: by 2002:a17:902:d4ce:b0:240:2145:e526 with SMTP id
 d9443c01a7336-242c1fd9655mr101663685ad.6.1754758843771; 
 Sat, 09 Aug 2025 10:00:43 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89a3ae8sm232953515ad.144.2025.08.09.10.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 10:00:43 -0700 (PDT)
Message-ID: <fc3faef9-c69b-42da-8e26-9f59d45ee14b@ventanamicro.com>
Date: Sat, 9 Aug 2025 14:00:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] Implements RISC-V WorldGuard extension v0.4
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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

Hey,

Sorry for the late review. Frank told me that this work was left behind.
Somehow it went completely under my radar for months ...

I didn't find some patches - probably because I wasn't directly CC on them
and I've cleanup some mailboxes recently. Feel free to add myself in the CC
for all patches, even if the patch is for a different subsystem - having anyone
taking a look in the patch will help the subsystem maintainer.

I'm not sure how the WorldGuard support is faring in Linux. If you could add
some documentation (patch 18) on the current state of the support, how we
can test the feature and so on, that would be terrific.


Thanks,

Daniel



On 4/17/25 7:52 AM, Jim Shu wrote:
> This patchset implements Smwg/Smwgd/Sswg CPU extension and wgChecker
> device defined in WorldGuard spec v0.4.
> 
> The WG v0.4 spec could be found here:
> https://lists.riscv.org/g/security/attachment/711/0/worldguard_rvia_spec-v0.4.pdf
> 
> To enable WG in QEMU, pass "wg=on" as machine parameter to virt machine.
> It enables both WG CPU CSRs to apply WID of CPU and wgCheckers on
> the DRAM, FLASH, and UART to protect these resources.
> 
> This patchset contains 5 parts:
> 
> 1. Commit  1 ~ 2: Bugfix of IOMMUMemoryRegion
> 2. Commit  3 ~ 4: Extend IOMMUMemoryRegion and MemTxAttr for WG support
> 3. Commit  5 ~ 13: Add WG global device and CPU extensions
> 4. Commit 14 ~ 17: Add WG checker device
> 5. Commit 18: Add WG support to the virt machine
> 
> QEMU code can be found at [1]
> 
> [1] https://github.com/cwshu/qemu/tree/riscv-wg-v2
> 
> Changed since v1:
> - Remove the assertion of 4k sections limitation. Remove
>    iotlb_to_section() and rename 'xlat_section' to 'xlat'.
> - Fix RST issue and typo in virt machine doc
> 
> Changed since RFCv1:
> - Rebase to latest QEMU (v10.0.0-rc3)
> - Add the description of HW config and CPU option of WG in the
>    virt machine documentation
> - Expose CPU options of WG after WG CPU code has been implemented
> - Change 'mwid' and 'mwidlist' options to experimental options
> - Change 'world_id' to unsigned int type + bit field.
> 
> Jim Shu (18):
>    accel/tcg: Store section pointer in CPUTLBEntryFull
>    system/physmem: Remove the assertion of page-aligned section number
>    accel/tcg: memory access from CPU will pass access_type to IOMMU
>    exec: Add RISC-V WorldGuard WID to MemTxAttrs
>    hw/misc: riscv_worldguard: Add RISC-V WorldGuard global config
>    target/riscv: Add CPU options of WorldGuard CPU extension
>    target/riscv: Add hard-coded CPU state of WG extension
>    target/riscv: Add defines for WorldGuard CSRs
>    target/riscv: Allow global WG config to set WG CPU callbacks
>    target/riscv: Implement WorldGuard CSRs
>    target/riscv: Add WID to MemTxAttrs of CPU memory transactions
>    target/riscv: Expose CPU options of WorldGuard
>    hw/misc: riscv_worldguard: Add API to enable WG extension of CPU
>    hw/misc: riscv_wgchecker: Implement RISC-V WorldGuard Checker
>    hw/misc: riscv_wgchecker: Implement wgchecker slot registers
>    hw/misc: riscv_wgchecker: Implement correct block-access behavior
>    hw/misc: riscv_wgchecker: Check the slot settings in translate
>    hw/riscv: virt: Add WorldGuard support
> 
>   accel/tcg/cputlb.c                   |   49 +-
>   docs/system/riscv/virt.rst           |   20 +
>   hw/misc/Kconfig                      |    3 +
>   hw/misc/meson.build                  |    1 +
>   hw/misc/riscv_wgchecker.c            | 1160 ++++++++++++++++++++++++++
>   hw/misc/riscv_worldguard.c           |  272 ++++++
>   hw/misc/trace-events                 |    9 +
>   hw/riscv/Kconfig                     |    1 +
>   hw/riscv/virt.c                      |  163 +++-
>   include/exec/cputlb.h                |   13 +-
>   include/exec/exec-all.h              |   18 +-
>   include/exec/memattrs.h              |    8 +-
>   include/hw/core/cpu.h                |   12 +-
>   include/hw/misc/riscv_worldguard.h   |  123 +++
>   include/hw/riscv/virt.h              |   15 +-
>   system/physmem.c                     |   39 +-
>   target/alpha/helper.c                |    2 +-
>   target/avr/helper.c                  |    2 +-
>   target/hppa/mem_helper.c             |    1 -
>   target/i386/tcg/system/excp_helper.c |    3 +-
>   target/loongarch/tcg/tlb_helper.c    |    2 +-
>   target/m68k/helper.c                 |   10 +-
>   target/microblaze/helper.c           |    8 +-
>   target/mips/tcg/system/tlb_helper.c  |    4 +-
>   target/openrisc/mmu.c                |    2 +-
>   target/ppc/mmu_helper.c              |    2 +-
>   target/riscv/cpu.c                   |   17 +-
>   target/riscv/cpu.h                   |   12 +
>   target/riscv/cpu_bits.h              |    5 +
>   target/riscv/cpu_cfg.h               |    5 +
>   target/riscv/cpu_helper.c            |   69 +-
>   target/riscv/csr.c                   |  107 +++
>   target/riscv/tcg/tcg-cpu.c           |   11 +
>   target/rx/cpu.c                      |    3 +-
>   target/s390x/tcg/excp_helper.c       |    2 +-
>   target/sh4/helper.c                  |    2 +-
>   target/sparc/mmu_helper.c            |    6 +-
>   target/tricore/helper.c              |    2 +-
>   target/xtensa/helper.c               |    3 +-
>   39 files changed, 2074 insertions(+), 112 deletions(-)
>   create mode 100644 hw/misc/riscv_wgchecker.c
>   create mode 100644 hw/misc/riscv_worldguard.c
>   create mode 100644 include/hw/misc/riscv_worldguard.h
> 


