Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F9FC44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viW3S-0007XR-Iz; Wed, 21 Jan 2026 06:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1viW3Q-0007X3-WF
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:07:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1viW3O-0000qp-JM
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:07:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so304657f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768993632; x=1769598432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvXIcUcFIHl+FOT/5XufFwBd/hO4ZWyaRo3/VOlVw7A=;
 b=TNTjtXGPrgwhOnlyntXQR2sRddGNSKRd9EsvEV8fR4m0AqUL/1z2AMcbdRYmnyMbKK
 61LsJOxL31OvpiNZXozY4vDlXd/N0U05atFsDONhX4lOcGuc83r3vr/M68DTD5MRzHWi
 Ibi2EqTXWhC1+ROPc1l5+aPprAuY/Glf02+xRswR+5hzBjjNxSi9n4hEhujUvMz5B111
 3kT19AF2jtR7cR6ZB55B4WEHuCybf+CHXZSIcBQgJTCyy1S7RZLwQOtms1iIHEyN0l4Q
 nWvcsVT+XP1FdJu/5EJlERn7wM76FLGFw/mg72sxZV7ksQFx09IxSHI0MK3nfKEHmLcb
 S7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768993632; x=1769598432;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvXIcUcFIHl+FOT/5XufFwBd/hO4ZWyaRo3/VOlVw7A=;
 b=hIf8+oHareAiSIcrkQ7QIt93gH+tEIDsu77pgjulp2HA7lY7E40dg10cThs+FZDEze
 UPaZdFeEBJiNHq3oidsR9uE1dYDHIYcfZ/pTOW1RUZsYVRIBG/UaF2rUXcTqBx6PSfrX
 mND0QMsO9UH+fhYviCtBTvfC5j6ooG8eBY5kV5Fj1Ylx8QGJT2AwpdrIZK0s1Q8/x9z6
 9455Wu+K7qt+0g+Kup0JIg0X8GkZRLs+1aZBPbFQPcoZ9vgtGo3zpwBPI5q56cbzMVot
 CM3+++8reFiNwxbAR1lKhIaExyqcC7br1I+k4VOUxbnVtq/IXnRYJ3Uao2oRfudHEkwv
 X4cQ==
X-Gm-Message-State: AOJu0Yz00ACyZVKXzX8BU1jjRQFDznLIsoMvVlWnigqafuJK9ZlOwgo7
 3gbLxqSKLZyfIGa2Jpv8/SMd17c29adXuX4e7a9c273J5+HnqnjqBJKlYG/EMg==
X-Gm-Gg: AZuq6aL2rcP4pevX084a0WgvdMSSGTi6ewOcO2iDqPSKomxitLmCdGZaVEtOwy89eLD
 JoO+stIP2MV9DAuCxYHVQpeW6oL4Bh1lELNXjdMSfuQ5AfSxGtEfkuB/oejWSZTope7QEdSYrvL
 Yf5g9mjrl/Un5Z6MvR2XQd+vENOQ4/gAGWU2w70kTBCDrG9OVV3XQ0OnUAyQME6RGSnaiuf7sS7
 jXYJxFLQUAD+I0/wa15JGCGeRTaif8xNzUEBGLx1gyylTg1vVHz4Qymz0dGZtzj6Kmh5bwmZYl5
 CJFNYTQy5NM/djJR6lZOZ/lqxst+2jufP7HTv52ZQa0VyRcbRkfipHw7YMhFpFUaEbybHxkoD8T
 bDnIUWa7iHuy8ohPEr8iBrjte7N7LQWbVe56CE1wFaIPJoNlKjkH+jeLomGw2DG7Q1USrPhBUW7
 j1CVntFx5bSg9pIuEwbHTAIn27BDzjmpALX9ILZJQ9lAebv3HXH92r5gVgKIEVbKT5mx5uuCl8A
 WWjz2ajjMf9rXy1k74tAIOptSpIIttEuEM=
X-Received: by 2002:a05:6000:240f:b0:435:a370:2d77 with SMTP id
 ffacd0b85a97d-435a3702f2dmr281300f8f.27.1768993631938; 
 Wed, 21 Jan 2026 03:07:11 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2d8a-c300-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:2d8a:c300:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm34639669f8f.19.2026.01.21.03.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 03:07:11 -0800 (PST)
Date: Wed, 21 Jan 2026 11:07:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 mohamed@unpredictable.fr
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v16 00/26] WHPX support for Arm
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
Message-ID: <26F1A1BC-1E1E-4277-B8D4-7B586FBE8DDE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 16=2E Januar 2026 13:52:09 UTC schrieb Mohamed Mediouni <mohamed@unpred=
ictable=2Efr>:
>Link to branch: https://github=2Ecom/mediouni-m/qemu whpx (tag for this s=
ubmission: whpx-v17)
>
>Missing features:
>- VM save-restore: interrupt controller state notably
>- SVE register sync: I didn't have the time to test this on pre-release h=
ardware with SVE2 support yet=2E
>So SVE2 is currently masked for VMs when running this=2E
>
>Known bugs:
>- U-Boot still doesn't work (hangs when trying to parse firmware) but EDK=
2 does=2E
>
>Note:
>
>"target/arm/kvm: add constants for new PSCI versions" taken from the mail=
ing list=2E
>
>"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing=
 list, added here
>as part of this series to make it compilable as a whole=2E
>
>And another note:
>
>Seems that unlike HVF there isn't direct correspondence between WHv regis=
ters and the actual register layout,
>so didn't do changes there to a sysreg=2Einc=2E
>
>Updates since v16:

I suppose: s/since/for/

>- Address some last review comments
>- Rebase with the latest origin/staging

Works for me! So, for x86_64:

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Updates since v15:
>- Some last tiny changes addressed=2E
>
>Updates since v14:
>- Working around https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D879=
50
>
>It turns out that we can't avoid default: in case with an enum on GCC wit=
hout warnings,
>although Clang allows that behavior=2E
>
>Updates since v13:
>- Addressing review comments from Akihiko Odaki
>- Squash GICv2 ACPI workaround patch and have it documented as a separate=
 function
>- Rebase with current origin/staging
>
>Updates since v12:
>- Address review comments and make sure that checkpatch shows no errors, =
make test also ran
>- Tested the Windows x86_64 build too in addition to Windows arm64 and ma=
cOS arm64
>- Hopefully the last revision, should be ready to merge=2E
>
>Updates since v11:
>- Address review comments
>- Rebase up to latest staging
>- Switch to assuming Qemu 11=2E0 as the newest machine model
>
>Updates since v10:
>- Bring forward to latest Qemu
>- Fix a typo in the GICv3+GICv2m PR
>
>Updates since v9:
>- Adding partition reset on the reboot side of things=2E=2E=2E
>
>Updates since v8:
>- v9 and v8 were not submitted properly because of my MTA not behaving, s=
orry for that=2E
>- v10 introduces a new argument, -M msi=3D, to handle MSI-X configuration=
 more granularly=2E
>- That surfaced what I think is a bug (?), with vms->its=3D1 on GICv2 con=
figurations=2E=2E=2E or I did understand everything wrong=2E
>- Oopsie due to email provider ratelimiting=2E
>
>Updates since v7:
>- Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the p=
latform vGIC together with ITS"=2E
>Other commits are unchanged=2E
>
>Updates since v6:
>- Rebasing
>- Fixing a bug in the GICv3+GICv2m case for ACPI table generation
>- getting rid of the slots infrastructure for memory management
>- Place the docs commit right after the "cleanly fail on attempt to run G=
ICv3+GICv2m on an unsupported config" one
>as that's what switches ITS to a tristate=2E
>- Fixing a build issue when getting rid of the arch-specific arm64 hvf-st=
ub=2E
>
>Updates since v5:
>- Rebasing
>- Address review comments
>- Rework ITS enablement to a tristate
>- On x86: move away from deprecated APIs to get/set APIC state
>
>Updates since v4:
>- Taking into account review comments
>- Add migration blocker in the vGICv3 code due to missing interrupt contr=
oller save/restore
>- Debug register sync
>
>Updates since v3:
>- Disabling SVE on WHPX
>- Taking into account review comments incl:
>
>- fixing x86 support
>- reduce the amount of __x86_64__ checks in common code to the minimum (w=
inhvemulation)
>which can be reduced even further down the road=2E
>- generalize get_physical_address_range into something common between hvf=
 and whpx
>
>Updates since v2:
>- Fixed up a rebase screwup for whpx-internal=2Eh
>- Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
>- Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 v=
ariant
>
>Updates since v1:
>- Shutdowns and reboots
>- MPIDR_EL1 register sync
>- Fixing GICD_TYPER_LPIS value
>- IPA size clamping
>- -cpu host now implemented
>
>Mohamed Mediouni (24):
>  qtest: hw/arm: virt: skip ACPI test for ITS off
>  hw/arm: virt: add GICv2m for the case when ITS is not available
>  tests: data: update AArch64 ACPI tables
>  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>    together with ITS
>  hw: arm: virt: rework MSI-X configuration
>  docs: arm: update virt machine model description
>  whpx: Move around files before introducing AArch64 support
>  whpx: reshuffle common code
>  whpx: ifdef out winhvemulation on non-x86_64
>  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>  whpx: interrupt controller support
>  whpx: add arm64 support
>  whpx: change memory management logic
>  target/arm: cpu: mark WHPX as supporting PSCI 1=2E3
>  whpx: arm64: clamp down IPA size
>  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
>    and HVF
>  whpx: arm64: implement -cpu host
>  target/arm: whpx: instantiate GIC early
>  whpx: arm64: gicv3: add migration blocker
>  whpx: enable arm64 builds
>  whpx: arm64: check for physical address width after WHPX availability
>  whpx: arm64: add partition-wide reset on the reboot path
>  MAINTAINERS: update the list of maintained files for WHPX
>
>Philippe Mathieu-Daud=C3=A9 (1):
>  accel/system: Introduce hwaccel_enabled() helper
>
>Sebastian Ott (1):
>  target/arm/kvm: add constants for new PSCI versions
>
> MAINTAINERS                                   |   6 +
> accel/hvf/hvf-all=2Ec                           |   7 +-
> accel/meson=2Ebuild                             |   1 +
> accel/stubs/whpx-stub=2Ec                       |   1 +
> accel/whpx/meson=2Ebuild                        |   7 +
> {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec  |   6 +-
> accel/whpx/whpx-common=2Ec                      | 536 ++++++++++
> docs/system/arm/virt=2Erst                      |  13 +-
> hw/arm/virt-acpi-build=2Ec                      |  27 +-
> hw/arm/virt=2Ec                                 | 140 ++-
> hw/i386/x86-cpu=2Ec                             |   4 +-
> hw/intc/arm_gicv3_common=2Ec                    |   3 +
> hw/intc/arm_gicv3_whpx=2Ec                      | 248 +++++
> hw/intc/meson=2Ebuild                           |   1 +
> include/hw/arm/virt=2Eh                         |   8 +-
> include/hw/core/boards=2Eh                      |   3 +-
> include/hw/intc/arm_gicv3_common=2Eh            |   3 +
> include/system/hvf_int=2Eh                      |   4 +
> include/system/hw_accel=2Eh                     |  13 +
> =2E=2E=2E/whpx =3D> include/system}/whpx-accel-ops=2Eh  |   4 +-
> include/system/whpx-all=2Eh                     |  20 +
> include/system/whpx-common=2Eh                  |  26 +
> =2E=2E=2E/whpx =3D> include/system}/whpx-internal=2Eh   |  16 +-
> include/system/whpx=2Eh                         |   5 +-
> meson=2Ebuild                                   |  20 +-
> target/arm/cpu=2Ec                              |   3 +
> target/arm/cpu64=2Ec                            |  17 +-
> target/arm/hvf-stub=2Ec                         |  20 -
> target/arm/hvf/hvf=2Ec                          |   6 +-
> target/arm/hvf_arm=2Eh                          |   3 -
> target/arm/kvm-consts=2Eh                       |   2 +
> target/arm/meson=2Ebuild                        |   2 +-
> target/arm/whpx/meson=2Ebuild                   |   5 +
> target/arm/whpx/whpx-all=2Ec                    | 985 ++++++++++++++++++
> target/arm/whpx/whpx-stub=2Ec                   |  15 +
> target/arm/whpx_arm=2Eh                         |  17 +
> target/i386/cpu-apic=2Ec                        |   2 +-
> target/i386/hvf/hvf=2Ec                         |  11 +
> target/i386/whpx/meson=2Ebuild                  |   1 -
> target/i386/whpx/whpx-all=2Ec                   | 569 +---------
> target/i386/whpx/whpx-apic=2Ec                  |   2 +-
> tests/data/acpi/aarch64/virt/APIC=2Eits_off     | Bin 164 -> 188 bytes
> 42 files changed, 2146 insertions(+), 636 deletions(-)
> create mode 100644 accel/whpx/meson=2Ebuild
> rename {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec (96%)
> create mode 100644 accel/whpx/whpx-common=2Ec
> create mode 100644 hw/intc/arm_gicv3_whpx=2Ec
> rename {target/i386/whpx =3D> include/system}/whpx-accel-ops=2Eh (92%)
> create mode 100644 include/system/whpx-all=2Eh
> create mode 100644 include/system/whpx-common=2Eh
> rename {target/i386/whpx =3D> include/system}/whpx-internal=2Eh (95%)
> delete mode 100644 target/arm/hvf-stub=2Ec
> create mode 100644 target/arm/whpx/meson=2Ebuild
> create mode 100644 target/arm/whpx/whpx-all=2Ec
> create mode 100644 target/arm/whpx/whpx-stub=2Ec
> create mode 100644 target/arm/whpx_arm=2Eh
>

