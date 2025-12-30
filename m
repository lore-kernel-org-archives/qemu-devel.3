Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005ACE9410A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 03:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaQhp-0000jn-W7; Mon, 29 Dec 2025 22:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaQhh-0000iQ-Iz
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 22:47:26 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaQhf-0006Xj-9K
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 22:47:25 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a1388cdac3so89598635ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 19:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767066442; x=1767671242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l06kEuUOEfKX5GBCQSSUum9nX/hParTtb83VUy+Dx0E=;
 b=UvoG3LqAqH0nVHATTfRUTiep/IuhpvepfCyTbncwZP3z6qCpNIcUAE+iHKyXhi9N5E
 AWnNSY9K6VEOoMjDh9Aha1MSo5KIbkPzJNMMPGLRJgczSPjCDWYdj9UGgZcZ//fyQq+a
 acMqE9XA2SUneVoBGtFpbeMx9sd3o4dxib7TdvTHv+WfeJxuBphQl0eZM6bRx9N1pYlA
 4fgI0hx8Ia0JK+uCHtSMUmKzFCX9SP8Q3b4Z6dJkNpd1223F/+LsCbTtGori4DTUWigN
 GLuE9UzJOK/NMFXQSfn8743lsfff3oM8/T9PxmHPsugTam34Xm200lfn+8OqLW2KLzCh
 TbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767066442; x=1767671242;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l06kEuUOEfKX5GBCQSSUum9nX/hParTtb83VUy+Dx0E=;
 b=c2bg0+gi/2niyMMIaCq4yLtGw7dxwOLTY/ux5lN7Bx0VZxMRyMzgmTgukef/aXOEY8
 xSpy+PFP4wKpdWt/UU+plRhRzbIR3neKSWR81brlNPc3fXUW9wK5UJYlZ2RpA64mWnfN
 uIzPpKkOvzkYyk5qZ5IY+A5htjDDugH327od0vLIko6ZOmmVxYmCyAHKTFbPSisLso/5
 x2BUprMYLF25TURCoo9WL4fBNKaYDMkU/OxJBmzqQmLIKKbmemU5DHhCcBSq0r1jk2HX
 FUX9X6PkOI1j8xhsSZuprO9t1vAZi6LYx9bPyVge0J/rNL/c+HEsKfmvM+VVnPpm4lwA
 xrhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLbBc04zuBnl3+FnuVFVZOwp60rlmUQwfrb+j8280pRlbvmjSgftrFWLcB6hgJNIS7KEwg3iltNGC9@nongnu.org
X-Gm-Message-State: AOJu0YwCnEMzClO7/k/Qh+wbVLA6ly/pt5BIIETxTA2lMhGNcotfO2MD
 KC/1vt9cxHy3Lz64WfB4K8Eunkm8nHvEDFpAUm0KkgP+5TlrorcNCYfLA8pXlTL/6qM=
X-Gm-Gg: AY/fxX56yI6bikGd84frDX6sjC6QkRZAuQHi34gj8u9d3WcWMMGOj6cmKYC5I0oaW00
 So3oTGi8/glILa8C4+Lukj0uAT+VeI9ZGakXQ89/XwTG6p6yNeDzeDR4/n942ZLc7dqj4SYZoGL
 XJdUrhqysJbUrYsoktJe4DwgwXC+74Bo5jmM8KEwPjgl1u2UUAFcTTB4ORZk8j1dIxrtfESsgbC
 DaYnqcDdp1tR7czFWJBeP15n3EQtcS6IDXtCBsNmKi5gOjODFWgyXOTorJ7psu/0Iq2W7tl6kXw
 g5JCeqvDj9zP6fSd5Ku8ScJiU2KcB5fwbdApwrGL6uO/FnLQWs1x0HTvAhVgprmDM+rX1H8lqDb
 y/EEJzxt387iKt/Khmt28jo9nA4mJ2OdnF6hE+7LGe+Q602LEscjtyPZb+RmKld1UWOZdTqUYyt
 N6iDKlCyKhXLVfKRy1r0DCTUFrD35gGeWOtuDHrQX1YnAfHhObhTgARfsb44N3yVSpuNs=
X-Google-Smtp-Source: AGHT+IFovmo2y/X1XMedk1ofTpEFBxJC8UsLmWItc6/4ghHl8MOnRAMi08k3XD9LBgybU41AXcwreQ==
X-Received: by 2002:a17:902:fc4f:b0:2a0:d59e:ff67 with SMTP id
 d9443c01a7336-2a2f2a355e3mr348446305ad.38.1767066441485; 
 Mon, 29 Dec 2025 19:47:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c65d71sm290676295ad.17.2025.12.29.19.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 19:47:20 -0800 (PST)
Message-ID: <b833265e-0a90-4696-803f-d98a7c1e3456@linaro.org>
Date: Mon, 29 Dec 2025 19:47:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/28] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x643.google.com
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

On 12/29/25 4:03 PM, Mohamed Mediouni wrote:
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v13)
> 
> Missing features:
> - VM save-restore: interrupt controller state notably
> - SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
> So SVE2 is currently masked for VMs when running this.
> 
> Known bugs:
> - U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.
> 
> Note:
> 
> "target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.
> 
> "accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
> as part of this series to make it compilable as a whole.
> 
> "hw/arm: virt: add GICv2m for the case when ITS is not available" present in both the HVF
> vGIC and this series.
> 
> "hw: arm: virt-acpi-build: add temporary hack to match existing behavior" is
> for ACPI stability but what is the right approach to follow there?
> 
> And another note:
> 
> Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
> so didn't do changes there to a sysreg.inc.
> 
> Updates since v12:
> - Address review comments and make sure that checkpatch shows no errors, make test also ran
> - Tested the Windows x86_64 build too in addition to Windows arm64 and macOS arm64
> - Hopefully the last revision, should be ready to merge.
> 
> Updates since v11:
> - Address review comments
> - Rebase up to latest staging
> - Switch to assuming Qemu 11.0 as the newest machine model
> 
> Updates since v10:
> - Bring forward to latest Qemu
> - Fix a typo in the GICv3+GICv2m PR
> 
> Updates since v9:
> - Adding partition reset on the reboot side of things...
> 
> Updates since v8:
> - v9 and v8 were not submitted properly because of my MTA not behaving, sorry for that.
> - v10 introduces a new argument, -M msi=, to handle MSI-X configuration more granularly.
> - That surfaced what I think is a bug (?), with vms->its=1 on GICv2 configurations... or I did understand everything wrong.
> - Oopsie due to email provider ratelimiting.
> 
> Updates since v7:
> - Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the platform vGIC together with ITS".
> Other commits are unchanged.
> 
> Updates since v6:
> - Rebasing
> - Fixing a bug in the GICv3+GICv2m case for ACPI table generation
> - getting rid of the slots infrastructure for memory management
> - Place the docs commit right after the "cleanly fail on attempt to run GICv3+GICv2m on an unsupported config" one
> as that's what switches ITS to a tristate.
> - Fixing a build issue when getting rid of the arch-specific arm64 hvf-stub.
> 
> Updates since v5:
> - Rebasing
> - Address review comments
> - Rework ITS enablement to a tristate
> - On x86: move away from deprecated APIs to get/set APIC state
> 
> Updates since v4:
> - Taking into account review comments
> - Add migration blocker in the vGICv3 code due to missing interrupt controller save/restore
> - Debug register sync
> 
> Updates since v3:
> - Disabling SVE on WHPX
> - Taking into account review comments incl:
> 
> - fixing x86 support
> - reduce the amount of __x86_64__ checks in common code to the minimum (winhvemulation)
> which can be reduced even further down the road.
> - generalize get_physical_address_range into something common between hvf and whpx
> 
> Updates since v2:
> - Fixed up a rebase screwup for whpx-internal.h
> - Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
> - Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 variant
> 
> Updates since v1:
> - Shutdowns and reboots
> - MPIDR_EL1 register sync
> - Fixing GICD_TYPER_LPIS value
> - IPA size clamping
> - -cpu host now implemented
> 
> Mohamed Mediouni (26):
>    qtest: hw/arm: virt: skip ACPI test for ITS off
>    hw/arm: virt: add GICv2m for the case when ITS is not available
>    tests: data: update AArch64 ACPI tables
>    hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>      together with ITS
>    hw: arm: virt: rework MSI-X configuration
>    hw: arm: virt-acpi-build: add temporary hack to match existing
>      behavior
>    docs: arm: update virt machine model description
>    whpx: Move around files before introducing AArch64 support
>    whpx: reshuffle common code
>    whpx: ifdef out winhvemulation on non-x86_64
>    whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>    hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>    whpx: interrupt controller support
>    whpx: add arm64 support
>    whpx: change memory management logic
>    target/arm: cpu: mark WHPX as supporting PSCI 1.3
>    whpx: arm64: clamp down IPA size
>    hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
>      and HVF
>    whpx: arm64: implement -cpu host
>    target/arm: whpx: instantiate GIC early
>    whpx: arm64: gicv3: add migration blocker
>    whpx: enable arm64 builds
>    whpx: apic: use non-deprecated APIs to control interrupt controller
>      state
>    whpx: arm64: check for physical address width after WHPX availability
>    whpx: arm64: add partition-wide reset on the reboot path
>    MAINTAINERS: update the list of maintained files for WHPX
> 
> Philippe Mathieu-Daudé (1):
>    accel/system: Introduce hwaccel_enabled() helper
> 
> Sebastian Ott (1):
>    target/arm/kvm: add constants for new PSCI versions
> 
>   MAINTAINERS                                   |    6 +
>   accel/hvf/hvf-all.c                           |    7 +-
>   accel/meson.build                             |    1 +
>   accel/stubs/whpx-stub.c                       |    1 +
>   accel/whpx/meson.build                        |    7 +
>   {target/i386 => accel}/whpx/whpx-accel-ops.c  |    6 +-
>   accel/whpx/whpx-common.c                      |  536 +++++++++
>   docs/system/arm/virt.rst                      |   13 +-
>   hw/arm/virt-acpi-build.c                      |   16 +-
>   hw/arm/virt.c                                 |  140 ++-
>   hw/i386/x86-cpu.c                             |    4 +-
>   hw/intc/arm_gicv3_common.c                    |    3 +
>   hw/intc/arm_gicv3_whpx.c                      |  249 ++++
>   hw/intc/meson.build                           |    1 +
>   include/hw/arm/virt.h                         |    8 +-
>   include/hw/core/boards.h                      |    3 +-
>   include/hw/intc/arm_gicv3_common.h            |    3 +
>   include/system/hvf_int.h                      |    5 +
>   include/system/hw_accel.h                     |   13 +
>   .../whpx => include/system}/whpx-accel-ops.h  |    4 +-
>   include/system/whpx-all.h                     |   20 +
>   include/system/whpx-common.h                  |   26 +
>   .../whpx => include/system}/whpx-internal.h   |   25 +-
>   include/system/whpx.h                         |    5 +-
>   meson.build                                   |   20 +-
>   target/arm/cpu.c                              |    3 +
>   target/arm/cpu64.c                            |   17 +-
>   target/arm/hvf-stub.c                         |   20 -
>   target/arm/hvf/hvf.c                          |    6 +-
>   target/arm/hvf_arm.h                          |    3 -
>   target/arm/kvm-consts.h                       |    2 +
>   target/arm/meson.build                        |    2 +-
>   target/arm/whpx/meson.build                   |    5 +
>   target/arm/whpx/whpx-all.c                    | 1020 +++++++++++++++++
>   target/arm/whpx/whpx-stub.c                   |   15 +
>   target/arm/whpx_arm.h                         |   17 +
>   target/i386/cpu-apic.c                        |    2 +-
>   target/i386/hvf/hvf.c                         |   11 +
>   target/i386/whpx/meson.build                  |    1 -
>   target/i386/whpx/whpx-all.c                   |  569 +--------
>   target/i386/whpx/whpx-apic.c                  |   48 +-
>   tests/data/acpi/aarch64/virt/APIC.its_off     |  Bin 164 -> 188 bytes
>   42 files changed, 2215 insertions(+), 648 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
>   create mode 100644 accel/whpx/whpx-common.c
>   create mode 100644 hw/intc/arm_gicv3_whpx.c
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
>   create mode 100644 include/system/whpx-all.h
>   create mode 100644 include/system/whpx-common.h
>   rename {target/i386/whpx => include/system}/whpx-internal.h (88%)
>   delete mode 100644 target/arm/hvf-stub.c
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c
>   create mode 100644 target/arm/whpx/whpx-stub.c
>   create mode 100644 target/arm/whpx_arm.h
> 

Thanks Mohamed.
Looks all good to me, and all checks are passing.
I hope it can be pulled quickly by a maintainer, before this series 
conflicts with any other changes on this area.

Regards,
Pierrick

