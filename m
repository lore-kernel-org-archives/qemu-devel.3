Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647F9E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIUb-0007L4-Mj; Mon, 29 Dec 2025 14:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIUO-0007J3-76
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:01:15 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIUI-0001Ny-PO
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:01:07 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso122606485ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767034861; x=1767639661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVPFq1PK5llLQFLjZ+90vWPQ+JVxEZ0MCjapERVy89E=;
 b=xkP5i3D6dk3G1jOte1D0W6RKxys6eDe1nY8+zz9YeZ3E7RQkM/JBwEgNHJhEWH7elp
 TxlcMDyWlCRi2N/mMmi8c/FjhUNiYVqKHAjKbvRwtCtmZGV5okbwQFKsR8S5se8ccDMb
 lFULLyxkOGJyvripiBDl6tN/s7KOdeyRJevQBZB4hF4SbG6q0TZC86Sl0M5zE2IV793W
 GV410m8mmeual8l1jy/7XxvmcUuu+SFusQwvHbgeq1M53qkpZ0KCkDzILnaQgMXj9b3f
 BhKsoor09F9KjYPXPV+XesdvaiNvVz9JTanLQ0AOXNEdOQytZv/TLnoDlRf5FWzaCbTP
 rdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034861; x=1767639661;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVPFq1PK5llLQFLjZ+90vWPQ+JVxEZ0MCjapERVy89E=;
 b=wLTN/RpkV98NKil+nhuHhQbljAhiDOKr6cNB4x4YGNqUmYtQuTMAWpV+2ChV4o0pGb
 bJ5vEpFJXteWe10wWreexmYrE+GHFWGAdnEZNZgZaUKNoE+dRWOyNkIoqAatwVmK0FWC
 Qwpi9W1/Ikw5+SUT8b2fars+mnTYloshW9sOaOWpmxEcgDexNBmzZJnV2GO1MQVdQI4c
 984U/ZD3zREIHFjSxpGU9CGR7VfRFXUKR96676R4imo0fNhzMW+6QxiLvx6J/AQCenXr
 oTkmnOBLvYQfCF5WFISEYBGyQFgm2C1gxh2X7vF0Cz233BV+GBelZ7YAtDMceQdGYuse
 wNPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZXmorMqY6f1wyab/Aq1ekFu8OJv9HYHWS/DC6NGWq/Vayntbi6QZLe8TRb0ZrP1NGmsfY1PeCYJ9I@nongnu.org
X-Gm-Message-State: AOJu0Yxmft0T1QuXWIozVOlZwxo5aByZuxDpbsloUEp/tGMNNLBGW0Jd
 6AE83pXOHjLjl0vLGvWBR0QkrXDmVccI5//jYhWUQAtAufH+pR3VSrdIk0hcojtiO1o=
X-Gm-Gg: AY/fxX6dz4jfQ2E+agJ07RgBLQTYTHvWxHUHqTBZU1L/MzzpeP4k82aF/PfQmyDtt9S
 goqLBTSuT81ZtHbFR2yu+zFsgOm8gdZdSRjTMp5fXnhA/nuetpznz6EEjP8RjPL0JCnB/PXexYQ
 aSIrk7qKHsS3uPqEyF6XJMHtA3EB1gFirZHyGc8ia/Z0evL4Eq+Icu/EC1H6XooN4MREWD1nvIg
 g+4aL9GPkgtz/39uB4bSOHIVIiZeyiINRQkkxvjSkhCyxnRpbHPmrIb5jCYpH9etiMAEqvMRQy+
 sdXpHT5+/EnMoZoiSxjArriqZqBTyyyV/vUCm7VD/y9dp2ePLmGtmAXhhyJapHJ2GTEELwiaOxV
 mg0wqxq9ZCEcE2A3W8xeKk8VFMRcGEL1xzz3n7YpirIDXPJOdE4tHI+QfM1QX8Eh/H9FGGoj6HA
 qiB8LpYKN7cmIpU/FRA6XVgvqm8ofFxwu7RyBwE7GhF7cQ6uMAdxNJPrVb
X-Google-Smtp-Source: AGHT+IEuWNhfWufD2Kkd1yAdad6nVLpvFyGnJLa95A0KqzbFGo2YrmyjLeeEWWd7x7mfeXjPDIk2NA==
X-Received: by 2002:a17:902:d547:b0:2a2:acc5:7a42 with SMTP id
 d9443c01a7336-2a2f2833082mr312196275ad.48.1767034860700; 
 Mon, 29 Dec 2025 11:01:00 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d6e4sm279567595ad.75.2025.12.29.11.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 11:01:00 -0800 (PST)
Message-ID: <05930cad-44dd-43e9-8126-0d1b1b23836f@linaro.org>
Date: Mon, 29 Dec 2025 11:00:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/28] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x642.google.com
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

On 12/28/25 3:53 PM, Mohamed Mediouni wrote:
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v12)
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
> "hw: arm: virt-acpi-build: add temporary hack to match existing behavior" is not proper" is
> for ACPI stability but what is the right approach to follow there?
> 
> And another note:
> 
> Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
> so didn't do changes there to a sysreg.inc.
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
>   accel/whpx/whpx-common.c                      |  540 +++++++++
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
>   42 files changed, 2219 insertions(+), 648 deletions(-)
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

It seems like there are some build failures for mingw x86_64:
https://github.com/pbo-linaro/qemu-ci/actions/runs/20579084208/job/59103016908

../target/i386/whpx/whpx-all.c: In function 'whpx_accel_init':
../target/i386/whpx/whpx-all.c:2190:19: error: 'struct whpx_state' has 
no member named 'kernel_irqchip'; did you mean 'kernel_irqchip_allowed'?
  2190 |             whpx->kernel_irqchip = true;
       |                   ^~~~~~~~~~~~~~
       |                   kernel_irqchip_allowed

You can cross compile for x86_64 from your windows-arm64 machine using:
https://www.qemu.org/docs/master/devel/build-environment.html#build-on-windows-aarch64

Regards,
Pierrick

