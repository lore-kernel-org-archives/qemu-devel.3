Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C3BC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOhV-00017j-KH; Thu, 20 Mar 2025 18:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOhU-00017E-Bz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:49:20 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOhM-0004JV-HO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:49:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22403cbb47fso25713005ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742510949; x=1743115749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DUl0JJOAWC6Np6+7L2wwmwznYFQPYtStKsZfNLj2wV0=;
 b=nkFfh1tmG1g+PJp4q2R7ZsvIZHJdBNYaRFc5BcpQEuOcZZ9efK+ISQ8H+98knFvoBQ
 j/Db/Mcsd9qOuSSesFjK59yp0EoXgj7vbdiBOkNf3I7OzpDbD+Rqkj9KRn+IdjPam0jJ
 7Mx+gy9kj6yHrNftppDQ4v0bYWQLLQTY5JZufF7T7DCwdvR/XWxuJUu5zWvSpQed+Mg2
 qsuDB9Lx0i6tF3f53jl3iYcfZdUn88H4sQx0dIVuO6Ub6sv3MfsWN4JwduLcoUbp3Glq
 HdsllF6Yp3fJM2NIXl4/s9rKJkK2zSq1f+5H4YkNxShMwlhUFGnbAlL10v76RgV2Jsjf
 fJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742510949; x=1743115749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUl0JJOAWC6Np6+7L2wwmwznYFQPYtStKsZfNLj2wV0=;
 b=qDmNNpUcTzIi07hReTy2HDEa9RJxuxu74Wmg+diLf+FB7EBBjVAvYY5Rv4Cy6ulQDS
 8P24Zz1sduhwUJKzAMk7NE7Dr3xV4DhiT/DNcHJFSrLXZ2UIKxtAhOaiNOEQUQs2n5v8
 QXS0y/0Mdv+jPdbxj1J3L4OIzfSdbM38HIlCfqY0H6EB4p4KcgJSFIdqYZOumE7EAFBh
 EfjhmJ5g7H3LCW4J7shhXK+PX4GllTHIwki+MUPKMNFMghTOmHNIFVmm3GcxHkJinjCK
 vsv/9qH2OeyvMnTuJ4vB5qh6xv7xdMF76/ydNqKuTLyigVSDxOUYagoc/VOPT8Hljjm0
 xv+w==
X-Gm-Message-State: AOJu0Yy6fJldwLyL3UNzWG0FUbk5prUapqe0ZT5zASmR2u0PET80iFOg
 u4RsCGBh9v3nC1pnLWL524taRSHhQ+aq612LVBsKcLRSq7y8ZLbJm5OqZQ4oWe/ei7WVFWQvBMA
 R
X-Gm-Gg: ASbGncvo+M2MmvdxJuxDhVEWNSyd0T7Tdv+gYXPQZ3+H73xXF65LTsWMeij5J2wRkOr
 xcc7TGUKBSy/+kV0TGbVg59o5AaKArqYwYvEHsbFq/BZQLoxkropYTvatI2PMmjniPOWm2FTphG
 hkq8+gcpt0ESuPrnTo3vXVhHPYnnUXcX5rQMMXXUXCu4pQBX3me3IIaM8xybfBFveWmujEgPKT6
 /TG7/N8QeqnGVlJu1URVGUfQR2dQUcoTXVjfF0pHyiAvZqXtb6NSzw3CWgilQUcuQYV6nHa+X0L
 RJkiDAkzdU5sZ70bOEAmZxqgdgLDTvZIAPPtqobTDHHO+UA+Gsa7hpAoMg==
X-Google-Smtp-Source: AGHT+IE8LLmohCWT2OM79Ks/Gq6iUQEWxb5HMBUe5lAqyFpMafS7tISb53AHsVvLi0PowRFtPDy4Pg==
X-Received: by 2002:a17:903:40cb:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-22780c5570dmr16516475ad.9.1742510948798; 
 Thu, 20 Mar 2025 15:49:08 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da2eesm3395725ad.172.2025.03.20.15.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 15:49:07 -0700 (PDT)
Message-ID: <2f5703db-5ee4-4790-9301-e81ee7d79279@linaro.org>
Date: Thu, 20 Mar 2025 15:49:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/30] single-binary: start make hw/arm/ common
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> This series focuses on removing compilation units duplication in hw/arm. We
> start with this architecture because it should not be too hard to transform it,
> and should give us some good hints on the difficulties we'll meet later.
> 
> We first start by making changes in global headers to be able to not rely on
> specific target defines. In particular, we completely remove cpu-all.h.
> We then focus on removing those defines from target/arm/cpu.h.
> 
>  From there, we modify build system to create a new hw common library (per base
> architecture, "arm" in this case), instead of compiling the same files for every
> target.
> 
> Finally, we can declare hw/arm/boot.c, and most of the boards as common as a
> first step for this part.
> 
> - Based-on: 20250317183417.285700-1-pierrick.bouvier@linaro.org
> ("[PATCH v6 00/18] make system memory API available for common code")
> https://lore.kernel.org/qemu-devel/20250317183417.285700-1-pierrick.bouvier@linaro.org/
> - Based-on: 20250318213209.2579218-1-richard.henderson@linaro.org
> ("[PATCH v2 00/42] accel/tcg, codebase: Build once patches")
> https://lore.kernel.org/qemu-devel/20250318213209.2579218-1-richard.henderson@linaro.org
> 
> v2:
> - rebase on top of Richard series
> - add target include in hw_common lib
> - hw_common_lib uses -DCOMPILE_SYSTEM_VS_USER introduced by Richard series
> - remove cpu-all header
> - remove BSWAP_NEEDED define
> - new tlb-flags header
> - Cleanup i386 KVM_HAVE_MCE_INJECTION definition + move KVM_HAVE_MCE_INJECTION
> - remove comment about cs_base in target/arm/cpu.h
> - updated commit message about registers visibility between aarch32/aarch64
> - tried remove ifdefs in target/arm/helper.c but this resulted in more a ugly
>    result. So just comment calls for now, as we'll clean this file later.
> - make most of the boards in hw/arm common
> 
> Pierrick Bouvier (30):
>    exec/cpu-all: remove BSWAP_NEEDED
>    exec/cpu-all: extract tlb flags defines to exec/tlb-flags.h
>    exec/cpu-all: move cpu_copy to linux-user/qemu.h
>    include/exec/cpu-all: move compile time check for CPUArchState to
>      cpu-target.c
>    exec/cpu-all: remove system/memory include
>    exec/cpu-all: remove exec/page-protection include
>    exec/cpu-all: remove tswap include
>    exec/cpu-all: remove exec/cpu-interrupt include
>    exec/cpu-all: remove exec/cpu-defs include
>    exec/cpu-all: remove exec/target_page include
>    exec/cpu-all: remove hw/core/cpu.h include
>    accel/tcg: fix missing includes for TCG_GUEST_DEFAULT_MO
>    accel/tcg: fix missing includes for TARGET_HAS_PRECISE_SMC
>    exec/cpu-all: remove cpu include
>    exec/cpu-all: transfer exec/cpu-common include to cpu.h headers
>    exec/cpu-all: remove this header
>    exec/target_page: runtime defintion for TARGET_PAGE_BITS_MIN
>    accel/kvm: move KVM_HAVE_MCE_INJECTION define to kvm-all.c
>    exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
>    target/arm/cpu: always define kvm related registers
>    target/arm/cpu: flags2 is always uint64_t
>    target/arm/cpu: define same set of registers for aarch32 and aarch64
>    target/arm/cpu: remove inline stubs for aarch32 emulation
>    meson: add common hw files
>    hw/arm/boot: make compilation unit hw common
>    hw/arm/armv7m: prepare compilation unit to be common
>    hw/arm/digic_boards: prepare compilation unit to be common
>    hw/arm/xlnx-zynqmp: prepare compilation unit to be common
>    hw/arm/xlnx-versal: prepare compilation unit to be common
>    hw/arm: make most of the compilation units common
> 
>   meson.build                             |  37 +++++++-
>   accel/tcg/internal-target.h             |   1 +
>   accel/tcg/tb-internal.h                 |   1 -
>   hw/s390x/ipl.h                          |   2 +
>   include/exec/cpu_ldst.h                 |   1 +
>   include/exec/exec-all.h                 |   1 +
>   include/exec/poison.h                   |   4 +
>   include/exec/target_page.h              |   3 +
>   include/exec/{cpu-all.h => tlb-flags.h} |  38 +-------
>   include/hw/core/cpu.h                   |   2 +-
>   include/qemu/bswap.h                    |   2 +-
>   include/system/kvm.h                    |   2 -
>   linux-user/qemu.h                       |   3 +
>   linux-user/sparc/target_syscall.h       |   2 +
>   linux-user/syscall_defs.h               |   2 +-
>   target/alpha/cpu.h                      |   4 +-
>   target/arm/cpu.h                        |  40 ++------
>   target/arm/internals.h                  |   1 +
>   target/avr/cpu.h                        |   4 +-
>   target/hexagon/cpu.h                    |   3 +-
>   target/hppa/cpu.h                       |   5 +-
>   target/i386/cpu.h                       |   5 +-
>   target/i386/hvf/vmx.h                   |   1 +
>   target/loongarch/cpu.h                  |   4 +-
>   target/m68k/cpu.h                       |   4 +-
>   target/microblaze/cpu.h                 |   4 +-
>   target/mips/cpu.h                       |   4 +-
>   target/openrisc/cpu.h                   |   4 +-
>   target/ppc/cpu.h                        |   4 +-
>   target/ppc/mmu-hash32.h                 |   2 +
>   target/ppc/mmu-hash64.h                 |   2 +
>   target/riscv/cpu.h                      |   4 +-
>   target/rx/cpu.h                         |   4 +-
>   target/s390x/cpu.h                      |   4 +-
>   target/sh4/cpu.h                        |   4 +-
>   target/sparc/cpu.h                      |   4 +-
>   target/tricore/cpu.h                    |   3 +-
>   target/xtensa/cpu.h                     |   4 +-
>   accel/kvm/kvm-all.c                     |   5 +
>   accel/tcg/cpu-exec.c                    |   3 +-
>   accel/tcg/cputlb.c                      |   1 +
>   accel/tcg/tb-maint.c                    |   1 +
>   accel/tcg/translate-all.c               |   1 +
>   accel/tcg/user-exec.c                   |   2 +
>   bsd-user/elfload.c                      |   6 +-
>   cpu-target.c                            |   5 +
>   hw/alpha/dp264.c                        |   1 +
>   hw/alpha/typhoon.c                      |   1 +
>   hw/arm/armv7m.c                         |  12 ++-
>   hw/arm/boot.c                           |   2 +
>   hw/arm/digic_boards.c                   |   2 +-
>   hw/arm/smmuv3.c                         |   1 +
>   hw/arm/xlnx-versal.c                    |   2 -
>   hw/arm/xlnx-zynqmp.c                    |   2 -
>   hw/hppa/machine.c                       |   1 +
>   hw/i386/multiboot.c                     |   1 +
>   hw/i386/pc.c                            |   1 +
>   hw/i386/pc_sysfw_ovmf.c                 |   1 +
>   hw/i386/vapic.c                         |   1 +
>   hw/loongarch/virt.c                     |   1 +
>   hw/m68k/next-cube.c                     |   1 +
>   hw/m68k/q800.c                          |   1 +
>   hw/m68k/virt.c                          |   1 +
>   hw/openrisc/boot.c                      |   1 +
>   hw/pci-host/astro.c                     |   1 +
>   hw/ppc/e500.c                           |   1 +
>   hw/ppc/mac_newworld.c                   |   5 +-
>   hw/ppc/mac_oldworld.c                   |   5 +-
>   hw/ppc/ppc.c                            |   1 +
>   hw/ppc/ppc_booke.c                      |   1 +
>   hw/ppc/prep.c                           |   1 +
>   hw/ppc/spapr_hcall.c                    |   1 +
>   hw/ppc/spapr_ovec.c                     |   1 +
>   hw/riscv/riscv-iommu-pci.c              |   1 +
>   hw/riscv/riscv-iommu.c                  |   1 +
>   hw/s390x/s390-pci-bus.c                 |   1 +
>   hw/s390x/s390-pci-inst.c                |   1 +
>   hw/s390x/s390-skeys.c                   |   1 +
>   hw/sparc/sun4m.c                        |   7 +-
>   hw/sparc64/sun4u.c                      |   7 +-
>   hw/xtensa/pic_cpu.c                     |   1 +
>   linux-user/elfload.c                    |   8 +-
>   monitor/hmp-cmds-target.c               |   1 +
>   semihosting/uaccess.c                   |   2 +-
>   target/alpha/helper.c                   |   2 +
>   target/arm/gdbstub64.c                  |   1 +
>   target/arm/helper.c                     |   6 ++
>   target/arm/hvf/hvf.c                    |   1 +
>   target/arm/ptw.c                        |   1 +
>   target/arm/tcg/helper-a64.c             |   1 +
>   target/arm/tcg/hflags.c                 |   4 +-
>   target/arm/tcg/mte_helper.c             |   1 +
>   target/arm/tcg/sve_helper.c             |   1 +
>   target/arm/tcg/tlb-insns.c              |   1 +
>   target/avr/helper.c                     |   2 +
>   target/hexagon/translate.c              |   1 +
>   target/i386/arch_memory_mapping.c       |   1 +
>   target/i386/helper.c                    |   2 +
>   target/i386/hvf/hvf.c                   |   1 +
>   target/i386/kvm/hyperv.c                |   1 +
>   target/i386/kvm/kvm.c                   |   1 +
>   target/i386/kvm/xen-emu.c               |   1 +
>   target/i386/sev.c                       |   1 +
>   target/i386/tcg/system/excp_helper.c    |   2 +
>   target/i386/tcg/system/misc_helper.c    |   1 +
>   target/i386/tcg/system/tcg-cpu.c        |   1 +
>   target/i386/xsave_helper.c              |   1 +
>   target/loongarch/cpu_helper.c           |   1 +
>   target/loongarch/tcg/translate.c        |   1 +
>   target/m68k/helper.c                    |   1 +
>   target/microblaze/helper.c              |   1 +
>   target/microblaze/mmu.c                 |   1 +
>   target/mips/tcg/system/cp0_helper.c     |   1 +
>   target/mips/tcg/translate.c             |   1 +
>   target/openrisc/mmu.c                   |   1 +
>   target/ppc/excp_helper.c                |   1 +
>   target/ppc/mmu-book3s-v3.c              |   1 +
>   target/ppc/mmu-hash64.c                 |   1 +
>   target/ppc/mmu-radix64.c                |   1 +
>   target/riscv/cpu_helper.c               |   1 +
>   target/riscv/op_helper.c                |   1 +
>   target/riscv/pmp.c                      |   1 +
>   target/riscv/vector_helper.c            |   2 +
>   target/rx/cpu.c                         |   1 +
>   target/s390x/helper.c                   |   1 +
>   target/s390x/ioinst.c                   |   1 +
>   target/s390x/tcg/mem_helper.c           |   1 +
>   target/sparc/ldst_helper.c              |   1 +
>   target/sparc/mmu_helper.c               |   2 +
>   target/tricore/helper.c                 |   1 +
>   target/xtensa/helper.c                  |   1 +
>   target/xtensa/mmu_helper.c              |   1 +
>   target/xtensa/op_helper.c               |   1 +
>   target/xtensa/xtensa-semi.c             |   1 +
>   tcg/tcg-op-ldst.c                       |   2 +-
>   hw/arm/meson.build                      | 117 ++++++++++++------------
>   136 files changed, 302 insertions(+), 205 deletions(-)
>   rename include/exec/{cpu-all.h => tlb-flags.h} (78%)
> 

This series has been built for:
- Linux x64 and arm64 host
- MacOS x64 and arm64 host
- Windows x64 host
All tests have been ran on linux x64 host.
https://github.com/pbo-linaro/qemu/actions/runs/13977201084/

