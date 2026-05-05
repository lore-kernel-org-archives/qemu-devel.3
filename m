Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C7FCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEez-0005r4-E3; Tue, 05 May 2026 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKEex-0005qR-Oz
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:13:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKEeu-0002v0-Dv
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:13:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so50029025e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777983230; x=1778588030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GktE6iKByJ63u11NbLxGQ3p0GJSW59bp8WOZW8wHKEg=;
 b=ebq2CWXz8gNV8KcVsZcCAJbwVJ37frmAPhw7nOqF5hBstdB3hmsS/KDmQZrZwZPMEx
 g2jScpDB9iS90vCIOEkDoqgwo6vQM8u1nRaOPrBjQWlIzDPOIf9RgeoHId+fmU+0K8zk
 igKl/ieznd7U1KgMSTso/2RHnNmdeM0RBpR64sh/4JwfLHhT0vq6RzWTDbxhxWq35y3V
 gwIcSo7aTq211d5bywW7fOPK4zq9/1GlsK0fo7W0dnMM4LUxayArM/qAXoRv8sV5KgEI
 Y2eQe4DxydwBI94kAMHYtOuTV9CgoUN5bhiPvM0JKdZHksh1DNPGiKlWM/FR5SVf/ezR
 7w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983230; x=1778588030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GktE6iKByJ63u11NbLxGQ3p0GJSW59bp8WOZW8wHKEg=;
 b=rs3EMjFltTyLUopR6BhAwG96zKc0EJ2UNSm4bqX7+zw5ev8RyUbO0TB2Y6ArBvPrh3
 hXvU1ah8wiDZcmr/vIvrU0QHoRUfdJBZEFoqWithien9l1eHjMgFIcwouVicdLCY+SXm
 9cWumZYDPsvtxLO7FlTBNYRUEyPYmQ1vFsXFKxAJhanMwWRPrP807QoQVX28StPnxiik
 +Dn1uvfu9NLvAA6JHWSoRMWMhMxqnFruk9VloFMOBEQoU/CstosycRI0m3Sz6neryF3p
 132OiuALdbpM1EUnO1GPdjGl9ueuNQfzWdImTfMtFQZnr0X6vd0mUl4dOrQPT5Ywoze6
 NzJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2Se489J3LrO05dkQQE8xO9XlzyJD3jPbWyLPsN6AmDqgvPBRtHn80k7jAYj3n2UIoSyCN80L5u0g6@nongnu.org
X-Gm-Message-State: AOJu0YzPncQqs93KsZFUnN5fggGTIOQYuUFo/bH53uzYaRhpEdxpg5fQ
 /qHkZ1GXHnwXIB1L7P6TVNva02m2u7cIX1BcBoukYNQbaqNlYvneyoOT8GZDnZ9fMXU=
X-Gm-Gg: AeBDievCf2+TAxd2UpFQkdOXFSPzLhOgLQF7zh2gsI2l+7LkIqZCZi4kZrA3x/kR8Jv
 PmKXeRkOeGMDFI1+GY3QJ+OBc9/ZtcW7LWy5/aeEyu/pFjbgD2gukNpCHoenqhu11O+YzOMsyrP
 IYRmXe68STnan/fv50FQjNpqJtqrIstynknXffsHl31lsLFNSfkKP6YiVUuZRaAGlDIoNB3t7+C
 3DAgbymmO5QPub1EMzRXZQm13gZnwnw80iJQ8GeRE20uH/ycZLSCjRxRZ3JJZi3NqFxfYSllEux
 LhN+JEtXKHLtse2JRfKozEYtnwEIubnnJf1lZrNcFvCfXYOROqAcWGUtW6tYNewqMys58NPOXmM
 /DZH1oT5QZ84Tt7W6914PRXsym6cupudvPZEGeX6wfQ4NMt+9ci3ALD7WJc/zJI082ZP+Gx8/Oj
 XSVJMJXxznWOIH9voixUsOS4ukKL5t/5HBTRbKK2AEIGxgApdtufb1kKudvziR3UW4A4VTuk2E3
 TEi
X-Received: by 2002:a05:600c:a11:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48d187d95d2mr48042535e9.11.1777983230319; 
 Tue, 05 May 2026 05:13:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d149d49acsm27297795e9.1.2026.05.05.05.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:13:49 -0700 (PDT)
Message-ID: <dc540970-bad4-4883-b4d1-9e206de8a73c@linaro.org>
Date: Tue, 5 May 2026 14:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] .eca: add an issue triager agent skill
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20260501165812.2212713-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260501165812.2212713-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/5/26 18:58, Alex Bennée wrote:
> While triaging the issue tracker I wondered if this would be a
> suitable job for an AI agent. Unfortunately the OSS program doesn't
> give any credits to run agents in gitlab. However I do have access to
> models from my editor and ECA so I built one and tested it on a few
> issues.
> 
> Obviously this can't apply as is because it probably encodes too much
> of my local setup (using pass for API keys) and uses the ECA as my
> preferred coding agent. I assume at some point there will be agreement
> between all the agents where skill live.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---


> +accel: HAX                 Intel's Hardware Accelerated Execution Manager (HAXM)
> +accel: HVF                 Apple Hypervisor Framework
> +accel: KVM                 Linux Kernel-based Virtual Machine
> +accel: TCG                 QEMU Tiny Code Generator
> +accel: WHPX                Microsoft Windows Hypervisor Platform (WHPX)
> +accel: Xen                 Xen Hypervisor
> +block:9p                   The 9p network file system
> +block:NVMe
> +block:curl
> +block:nbd
> +block:nfs                  Issues related to the NFS backend
> +block:qcow2
> +block:ssh
> +block:vmdk
> +bsd-user
> +device: PCI
> +device: TPM                Trusted Platform Module (TPM) devices
> +device:graphics            Issues relating to display device emulation, or rendering in general. See also "GUI".
> +device:input               Keyboards, Mice, Touchscreens, HIDs, etc.
> +device:iommu               IOMMU and SMMU
> +device:pflash              Parallel NOR flashes emulation
> +device:sdmmc               SD or (e)MMC cards emulation
> +device:virtio              virtio-related issues. https://www.linux-kvm.org/page/Virtio
> +device:watchdog
> +efi                        EFI firmware related issues
> +flaky-ci                   For test cases that are flaky when run under our CI
> +gitlab
> +guest: AIX
> +guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
> +guest: Linux               Guest OS is Linux/Linux-based
> +guest: Windows             Microsoft Windows guest
> +guest: macOS               Apple macOS / Darwin as  guest OS
> +guest: os2
> +host: aarch64              Bugs reproducible on AArch64 hosts
> +host: arm                  Bugs reproducible on ARM hosts
> +host: loongarch64          Bugs reproducible on LoongArch64 hosts.
> +host: mips                 Bugs reproducible on MIPS hosts
> +host: ppc                  Bugs reproducible on Power hosts
> +host: riscv                Bugs reproducible on RISC-V hosts
> +host: s390                 Bugs reproducible on s390 hosts
> +host: sparc64              Bugs specific to Sparc64 hosts
> +host: x86                  Bugs reproducible on x86 hosts
> +host:32bit                 These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.
> +hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
> +hostos: Linux              Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
> +hostos: Windows            Microsoft Windows host OS
> +hostos: macOS              Apple macOS / Darwin as a host OS
> +icount                     issues relating to icount, deterministic execution and record/replay functionality
> +kind: Not user visible
> +kind::Bug                  Bug or defect in functionality.
> +kind::Feature Request      Feature request or new functionality.
> +kind::Task                 Research, investigations, and miscellaneous issues.
> +libvfio-user
> +linux-user
> +qemu-img
> +spice
> +sysadmin
> +target: alpha              DEC Alpha [alpha]
> +target: arm                Arm AArch32 or AArch64 [arm, aarch64]
> +target: avr                Atmel AVR [avr]
> +target: hexagon            Qualcomm Hexagon [hexagon]
> +target: hppa               Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
> +target: i386               Intel/AMD x86 [i386, x86_64]
> +target: loongarch          loongarch64 target architecture
> +target: m68k               Motorola 68000 [m68k]
> +target: microblaze         Xilinx MicroBlaze [microblaze, microblazeel]
> +target: mips               MIPS [mips, mipsel, mips64, mips64el]
> +target: nios2              Altera Nios II [nios2]
> +target: openrisc           OpenRISC [or1k]
> +target: ppc                IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
> +target: riscv              RISC-V [riscv32, riscv64]
> +target: rx                 Renesas RX [rx]
> +target: s390x              IBM Z, SystemZ, zSeries [s390x]
> +target: sh4                Renesas SuperH [sh4, sh4eb]
> +target: sparc              Sun Microsystems SPARC [sparc, sparc64]
> +target: tricore            Infineon TriCore [tricore]
> +target: xtensa             Tensilica Xtensa [xtensa, xtensaeb]
> +workflow::Confirmed        Bugs that have been confirmed and reproduced.
> +workflow::In Progress      Someone is working on this issue.
> +workflow::Needs Info       Issue has insufficient information to verify.
> +workflow::Patch available  A patch is available
> +workflow::Triaged          Issue has been triaged and given a topic label.

Some of these labels do not match the case of GitLab ones,
resulting in new (duplicated) labels being created there.

