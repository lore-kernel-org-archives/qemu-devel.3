Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A11CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 12:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxue-0006Mh-HQ; Thu, 07 May 2026 08:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKxuc-0006MF-C8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:33:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKxuZ-0001jL-Qs
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:33:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so11678975e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778157181; x=1778761981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtI/Qwg/QafoL2lal9Xw/KFCmVwmBYPmxmbKF0CMwdU=;
 b=pwPHyoLRlbBMlKDqeQSZDMJLzw6FmRON3FI/23q8l+2o2SVqMFI20CdxTR7begnf+f
 j6mBwrq9/rajutm//7icU6v7IuV50VQseIinYVpv4JRkzb31yAx+60C5VxISf54eKGEj
 uauaL21jVJcLu7pDTDgDU4X0NaEkCiwDhBvx8de18k4Ww9dDLVDlWHfaKaMnkGHvhuIF
 okvwvBIhpakDIcHVSmkNlRJNhy/eM6mfQ9jXDWdf9eESSqjZ2oZ0qgD8w93HFLPFMCes
 JWezQqZJjxH9yHJ4bdEAlbcWiIwdzlDhqDM2al2txRiegSiR4Z4jkIhwCPTR+N4NLJt7
 SkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778157181; x=1778761981;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AtI/Qwg/QafoL2lal9Xw/KFCmVwmBYPmxmbKF0CMwdU=;
 b=fUm67sDgZwRMTiDyTrp9qru+vJ/xKrCRcT/oQXBVRWkkqRv9wgKsZSDM2QvSeF/8Vy
 hq7CcPCt0OSgW1W3OI3clw2ynzYYj/dNjo3avrFZ4mnYLOPciHURhmNvIbJBiN/K+qF8
 2dbY2zjgduinfcva6Y4Annaa8evC21Iw59Ae+do0q8HqADUR5g/2xrXEqMYibDYdwGXJ
 12b0kfdjV9VJTAa94Ab68PIV7Kf6qULYXhzO4O5LDQ1bLblnXANQnX+od382IyWlxXJV
 dSiWeh6x2EaxFkt0cSD40xjfZmdE5Wi+tRpXzkXSsDIV0kqQ1x/cZHxUcnEzQKLrN3ne
 u0xg==
X-Gm-Message-State: AOJu0Yw2uhvRj5uWkMt6BkuPgLp1T4FT2UXU1xRe7xJImubTzX1ZEiP9
 BQRgJ02exsgZbSm9nj4wnvYBGUsjg9uN4YMCVZ+zYUaY84hHHC4s9m2IiXDGRKArQgJDs93LWF1
 hKlQsu3o=
X-Gm-Gg: AeBDiet56xaf7yLYYSvCG6sYjid7sZvzSKl+DD4hdwn9o/r+DPryDVy1stygVabJ+pV
 AtPo1LFqwnbKGe0ZzUoNx1LkE3FzJIkQUjWea1esU1D58j/h9DalIldJrERbP+d/fzA0ptpJLVu
 WRq4W6KUdni/oXsVetU8ieLGAqjOWqaspdxhBkDvPxKPB4nIHYyhuoGbX5iTFfWGrcZEfPVYLkI
 xTy0y4BvDnDlmfsrsTBs0YUf+YGay5md4DfEfE8QfjaJ/q8m6DV+Q0a0sc+XtEKxnFweZ1gkxBQ
 ejeq3mzOhV+WZWhwCQHFOuur5Emc3VDVcDjFuVjwS/k1aTU6P75Q/ZnAXmxZ5IuoF14OKiLRDeL
 4TIX/1Ud87+GI21QT8iG95HIpQrlxcYCMHxzxdY4V+MeV0yK65CucBn2eg6SjLuazgO2rHjHO8Q
 KF/5x4oBr3wFalNM5Zq7nWIRUjWPwV9EpO6A==
X-Received: by 2002:a05:600c:4e0c:b0:48d:46a:6e5b with SMTP id
 5b1f17b1804b1-48e51e19110mr140221295e9.7.1778157181249; 
 Thu, 07 May 2026 05:33:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530d8691sm86634235e9.2.2026.05.07.05.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:33:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 85B625F870;
 Thu, 07 May 2026 13:32:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 08/10] .agents/skills: add qemu-issue-triage agent
 skill
In-Reply-To: <afxMiS7Y5RIXPLUz@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 7 May 2026 09:25:45 +0100")
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-9-alex.bennee@linaro.org>
 <afxMiS7Y5RIXPLUz@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 07 May 2026 13:32:59 +0100
Message-ID: <87zf2bl7r8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 05, 2026 at 06:01:03PM +0100, Alex Benn=C3=A9e wrote:
>> While triaging the issue tracker I wondered if this would be a
>> suitable job for an AI agent. Unfortunately the OSS program doesn't
>> give any credits to run agents in gitlab. However I do have access to
>> models from my editor and ECA so I built one and tested it on a few
>> issues.
>>=20
>> Obviously this can't apply as is because it probably encodes too much
>> of my local setup (using pass for API keys) and uses the ECA as my
>> preferred coding agent. I assume at some point there will be agreement
>> between all the agents where skill live.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ..snip..
>
>> diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt
>> b/.agents/skills/qemu-issue-triage/assets/labels.txt
>> new file mode 100644
>> index 00000000000..d329f34183d
>> --- /dev/null
>> +++ b/.agents/skills/qemu-issue-triage/assets/labels.txt
>
> Seeing our labels listed like this triggers my urge to "tidy" :-)
>
> Don't take anything below to be a complaint / blocker about this patch.
> This patch is fine in so much as it faithfully represents the mess we
> have created in gitlab.
>
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +ACPI                       Power Management related (ACPI / SMBIOS / HE=
ST / GHES)
>> +Audio Audio devices; both backend (host audio) and frontend (guest
>> audio)
>
> Mixing frontend and backend is a bad idea in general IMHO.
>
> I feel like we should also have an explicit label for each backend, for
> both audio and every other backend type.

Backend: chardev
Backend: audio
?

I suspect the block backends are special enough they should stay part of
block: - what other backends do we have?

>
>> +Audit Tooling A group for bugs and issues found via automated
>> tooling such as fuzzing, sanitizers or AI
>> +Audit Tooling::AI For bugs found with AI assisted tools such as
>> Mythos and other similar things
>> +Audit Tooling::Fuzzer Issues found via fuzzing. For security
>> issues, please consult
>> https://www.qemu.org/contribute/security-process/
>> +Audit Tooling::Sanitizer For issues found using sanitizers such as
>> asan, lsan and tsan
>
> Labels with "::" are mutually exculsive, which is possibly not
> what we want here ?  Should the first thing be 'Audit Tooling::Other'
> instead of unqualified ?

I've added that, as well as Audit Tooling::Static Analysis for Coverity.

>
>> +Bite Sized Candidates for first contributions; see also
>> https://wiki.qemu.org/Contribute/BiteSizedTasks
>> +Build System               configure, make, Meson, ninja, gcc, clang, c=
cache, etc.
>> +CI                         Continuous Integration; gitlab, travis, patc=
hew, etc.
>> +CLI                        Command Line Interface
>> +Chardev                    Character device backends and related issues
>
> We should have per-backend labels
>
>> +Closed::Duplicate There is already another ticket that is about the
>> same issue
>> +Closed::Fixed              The issue was fixed. Yay!
>> +Closed::Invalid            This issue was not really a problem
>> +Closed::NotOurBug This is a bug, but not a bug in QEMU. Please
>> report it and/or include a link to the report.
>> +Closed::NotReproducible    This issue was not reproducible
>> +Closed::UnbackedFeature    Nobody was willing to work on this feature r=
equest
>> +Closed::WontFix The issue was acknowledged, but the fix would be
>> too complex, too expensive, or would introduce other problems.
>> +Cryptography
>> +Documentation Sphinx documentation, man pages, the wiki, --help
>> output, etc.
>> +GDB                        Issues relating to using GDB via the gdbstub
>> +GUI Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
>> +GUI::Cocoa                 Cocoa
>> +GUI::DBus                  DBus
>> +GUI::GTK
>> +GUI::SDL                   SDL
>> +GUI::SPICE                 SPICE
>
> spice is duplicated later

Prompt: "find all the issues with the "spice" label and label them with the=
 GUI::SPICE label instead"

the result was:

  general: relabling spice issues (5 steps, 13.5K / 1M) =E2=9C=85 1m 26s

  I have successfully relabeled all GitLab issues in the `qemu-project/qemu=
` repository by replacing the "spice" label with the "GUI::SPICE" label.

  ### Summary of Actions:
  - **Total Issues Updated**: 21 (including both open and closed issues).
  - **Relabeling**: Removed the `spice` label and applied the `GUI::SPICE` =
label to each identified issue.
  - **Verification**: Confirmed that `glab issue list --label spice` now re=
turns no results, while `glab issue list --label "GUI::SPICE"` includes all=
 updated issues.

  ### Updated Issues:
  The following 21 issues were updated:=20
  `3148`, `3070`, `2860`, `2667`, `2639`, `2561`, `2411`, `2335`, `2282`, `=
2071`, `1926`, `1829`, `1778`, `1777`, `1553`, `1549`, `1431`, `1426`, `128=
5`, `681`, `232`.

about 0.08p in inference costs.

>
>> +GUI::VNC
>
> I'd probably suggest "ui" as the prefix to match the dir / subsystem
> name.
>
> Also probably use ":" instead of "::" as there could be cases where
> a bug affects multiple UIs.
>
>> +Guest Agent Issues related to the qemu-guest-agent binary.
>> https://wiki.qemu.org/Features/GuestAgent
>> +Hard

I think there is 1 bug that is Hard.

>> +Launchpad                  Issues migrated from Launchpad
>> +Migration
>
> Surprised we don't want more categories here
>
>> +Modules
>> +Networking
>> +Python                     Python library issues (./python/)
>> +QAPI/QMP                   QEMU API / QEMU Machine Protocol, HMP and CL=
I, etc.
>> +QOM                        QEMU Object Model
>> +Regression
>> +Security
>> +Semihosting Semihosting calls provide a simple ABI for early
>> bring-up of embedded devices and provide a way to output to the
>> console and do basic file i/o while being debugged
>> +Softfloat                  QEMU's FPU emulation code (TCG only)
>> +Stable::can't fix The bug was reported on a stable branch but the
>> fix is too invasive for backporting
>> +Stable::obsolete The bug was reported on a stable branch that is
>> not maintained anymore
>> +Stable::to backport The bug was reported on a stable branch and
>> needs to be backported on the next release from the branch
>> +Storage                    Block subsystem, Storage devices, etc.
>> +TCG plugins                Anything related to the TCG plugins feature
>
> Perhaps accel:tcg:plugins ?
>

Plugins currently implies accel:tcg but I'm not sure it is directly
accelerator related. Some of the run-loop hooks are TCG agnostic.

>> +TestCase                   The report includes a testcase
>> +Tests qtests, iotests, acceptance tests, VM tests, docker tests,
>> and more.
>> +USB
>> +VFIO
>
> This annoying sorting of all uppercase, then all lowercase is
> present in the gitlab UI too
>
> https://gitlab.com/qemu-project/qemu/-/labels
>
> We should probalby be universally lowercase, so that sorting is
> sensible.
>
>> +accel: HAX                 Intel's Hardware Accelerated Execution Manag=
er (HAXM)
>> +accel: HVF                 Apple Hypervisor Framework
>> +accel: KVM                 Linux Kernel-based Virtual Machine
>> +accel: TCG                 QEMU Tiny Code Generator
>> +accel: WHPX                Microsoft Windows Hypervisor Platform (WHPX)
>> +accel: Xen                 Xen Hypervisor
>
> We're inconsistent in whether we use a space after ":". Here we do,
> below we don't.
>
>> +block:9p                   The 9p network file system
>> +block:NVMe
>
> These two are not like the others under 'block:'. 'NVMe' is frontend devi=
ce,
> and 9p is a filesystem. I'd assume 'block:' applies to block/*.c
>
>> +block:curl
>> +block:nbd
>> +block:nfs                  Issues related to the NFS backend
>> +block:qcow2
>> +block:ssh
>> +block:vmdk
>
> Probably want a "block:core" for stuff not specific to one of the listed
> backends.

I'll let the block guys fix this up.

>
>> +bsd-user
>> +device: PCI
>> +device: TPM                Trusted Platform Module (TPM) devices
>> +device:graphics Issues relating to display device emulation, or
>> rendering in general. See also "GUI".
>> +device:input               Keyboards, Mice, Touchscreens, HIDs, etc.
>> +device:iommu               IOMMU and SMMU
>> +device:pflash              Parallel NOR flashes emulation
>> +device:sdmmc               SD or (e)MMC cards emulation
>> +device:virtio virtio-related issues.
>> https://www.linux-kvm.org/page/Virtio
>> +device:watchdog
>
> Here we sometimes have a space after : and sometimes don't
>
>
>> +efi                        EFI firmware related issues
>> +flaky-ci                   For test cases that are flaky when run under=
 our CI
>> +gitlab
>
> So should we be using "CI" or "gitlab" for CI issues :)
>
> Probably we should have:
>
>   ci:gitlab
>   ci:flaky
>
>> +guest: AIX
>> +guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
>> +guest: Linux               Guest OS is Linux/Linux-based
>> +guest: Windows             Microsoft Windows guest
>> +guest: macOS               Apple macOS / Darwin as  guest OS
>> +guest: os2
>> +host: aarch64              Bugs reproducible on AArch64 hosts
>> +host: arm                  Bugs reproducible on ARM hosts
>> +host: loongarch64          Bugs reproducible on LoongArch64 hosts.
>> +host: mips                 Bugs reproducible on MIPS hosts
>> +host: ppc                  Bugs reproducible on Power hosts
>> +host: riscv                Bugs reproducible on RISC-V hosts
>> +host: s390                 Bugs reproducible on s390 hosts
>> +host: sparc64              Bugs specific to Sparc64 hosts
>> +host: x86                  Bugs reproducible on x86 hosts
>> +host:32bit These are mostly TCG related bugs where we sometimes
>> struggle with emulating larger guests, especially atomic and address
>> space issues.
>
> More space inconsistency
>
>> +hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as=
 host OSes
>> +hostos: Linux Linux-based host operating systems (Fedora,
>> RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
>> +hostos: Windows            Microsoft Windows host OS
>> +hostos: macOS              Apple macOS / Darwin as a host OS
>> +icount issues relating to icount, deterministic execution and
>> record/replay functionality
>
> Perhaps accel:tcg:icount  ?
>
>> +kind: Not user visible
>
> What's this for, and why : instead of :: ?

No idea - is this the mechanism we use to hide live security issues?

>
>> +kind::Bug                  Bug or defect in functionality.
>> +kind::Feature Request      Feature request or new functionality.
>> +kind::Task                 Research, investigations, and miscellaneous =
issues.
>> +libvfio-user
>> +linux-user
>> +qemu-img
>
> Should we have a "tools:qemu-img", and "tools:...." for everything
> else too ?
>
>> +spice
>
> Redundant with 'GUI::SPICE"
>
>> +sysadmin
>
> Any idea what this is supposed to refer to ?

there is one issue where CI runs fail on some runners and not others. I
added some flavour text.

>
>> +target: alpha              DEC Alpha [alpha]
>> +target: arm                Arm AArch32 or AArch64 [arm, aarch64]
>> +target: avr                Atmel AVR [avr]
>> +target: hexagon            Qualcomm Hexagon [hexagon]
>> +target: hppa Hewlett-Packard Precision Architecture; HP/HP, PA-RISC
>> [hppa]
>> +target: i386               Intel/AMD x86 [i386, x86_64]
>> +target: loongarch          loongarch64 target architecture
>> +target: m68k               Motorola 68000 [m68k]
>> +target: microblaze         Xilinx MicroBlaze [microblaze, microblazeel]
>> +target: mips               MIPS [mips, mipsel, mips64, mips64el]
>> +target: nios2              Altera Nios II [nios2]
>> +target: openrisc           OpenRISC [or1k]
>> +target: ppc                IBM Power Architecture, PowerPC [ppc, ppc64,=
 ppc64le]
>> +target: riscv              RISC-V [riscv32, riscv64]
>> +target: rx                 Renesas RX [rx]
>> +target: s390x              IBM Z, SystemZ, zSeries [s390x]
>> +target: sh4                Renesas SuperH [sh4, sh4eb]
>> +target: sparc              Sun Microsystems SPARC [sparc, sparc64]
>> +target: tricore            Infineon TriCore [tricore]
>> +target: xtensa             Tensilica Xtensa [xtensa, xtensaeb]
>> +workflow::Confirmed        Bugs that have been confirmed and reproduced.
>> +workflow::In Progress      Someone is working on this issue.
>> +workflow::Needs Info       Issue has insufficient information to verify.
>> +workflow::Patch available  A patch is available
>> +workflow::Triaged          Issue has been triaged and given a topic lab=
el.
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

