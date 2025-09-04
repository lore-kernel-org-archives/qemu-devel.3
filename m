Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B71CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu8fL-0005B3-JU; Thu, 04 Sep 2025 08:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uu8fA-00056o-I1; Thu, 04 Sep 2025 08:02:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uu8f1-0000Z9-Oz; Thu, 04 Sep 2025 08:01:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so727748f8f.3; 
 Thu, 04 Sep 2025 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756987303; x=1757592103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osygFcthNMmW4sfTvrME6q0eT7U8G3EobifkT2HFCr4=;
 b=Jhw5uO45xVnw2h5b0T0ZtW92jefzq3DqmwEnhOy111m2PJHxaaDaD/S0K80Ijteh9L
 uBOx4forQvGm+WXNYVpRhn3SYctI2lX2c9VoZYKg0dfGLZNc6JOvIl0TzwB5q9eawhVQ
 auFQupXeGxFNqRztn4LmOd3VFmIxHEkzLhTVjlI+e2sHKq7CywAgcsYpEu8oX3KCkYRM
 PIwb41p4jEFTmaKKPzLZEku1GrVgr7l4P3Gcif6KAc9slkDiGt2kPK+gW8bgTKK8wAkC
 wZ/aQG73iSjgj01ChZXSAHZt6YIMrhvvpf+e2bYdn35lrPSKXPNRyjPsAjw4NBNkR6jY
 xvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756987303; x=1757592103;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osygFcthNMmW4sfTvrME6q0eT7U8G3EobifkT2HFCr4=;
 b=hlDwTLC7C7C40StaA9eqMRhHHhJywwqJNaHMcKB7Yhct1xsSuye6gzgSOY1jlWZNk0
 jv+zU0djn/D3cTsAK44f0q98em1X2TTRsC58R+I5rcwZFRN0RQKgEpmMkjql0jwbp0zL
 mpSe272NX+FndZFZ1mR0IViKgEPW2D0Qyuc4Zwxw4qlmLbAd5eZqlEn0QHWFQK3wBNEZ
 NgYpgxp/V+IvvJ65vF1Y7osfA/xPlMMFthRwa2mbF1Dg9+q7sFUu8kC1ZDTu9t6LMEIm
 CT9jGvachqY9M9gsIpkO+dHw3+0i8I41rqUabzel+p1Q2am9lXr3zOKm5QIHstShRzKz
 tyGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGS2tSV4ikQcGHhGQnAxweIRTlEvglD9NuZAX3cnsvEhCeE3KicaB08G86wUqBABPGOK1kYvJUyQ==@nongnu.org
X-Gm-Message-State: AOJu0YwulgDggqAij+2O+APXqpva/kpjSoucE7r5ptg7l46q2TDCm7zL
 wYc6IPGn2T3c75hFAQe97T4lqwteTmkcthwwZclHerVpHR47uYBy0m57xvJ41Q==
X-Gm-Gg: ASbGncvlpHDHZ0wop9SNQ7XDqWxnIFNgaxRe6qvWUm/7R4h3DEydmQR/0ghwYqq7kXQ
 s5P5vv40mGYg0iSTiVecRoBl800JzZ81ss0lzeb5A4anoBXOud+xNtDjdCtUVYb/Yu428c9l7fV
 y4HHEdBIcM1UgpMpdJOcF62ZPBIw4y4LnWcbL2sP05yBF0xMUpY0+BK/sHFHacCsI1ZkttA2ux1
 uGrQdVraPkXkC7LjNterd5wQz9fSOUjhD7CU/tDDwiTO4IQ7uE6rinDm/tbCYTRqeYhd8CYrvw0
 qW+dDxvMbKvEIckhAdHWtEdzil3cUQ1zvMQYsHH8hp2ysyoED+eW3+dHPp95f3b8+ppP58vo73c
 VnExybwRZs5LfdFdmDmIsL5/YXxt2
X-Google-Smtp-Source: AGHT+IEt0kOv8NhaM6o0O1e1qqIKykwM+LRYNO+X2/52DofHSMZM2lfsFOxQ46l4s4yS6ZrKcAAJ1w==
X-Received: by 2002:a05:6000:3111:b0:3db:c7aa:2c4a with SMTP id
 ffacd0b85a97d-3dbc7aa304amr6272438f8f.42.1756987302419; 
 Thu, 04 Sep 2025 05:01:42 -0700 (PDT)
Received: from ehlo.thunderbird.net ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d6cf485eb7sm17317283f8f.3.2025.09.04.05.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 05:01:41 -0700 (PDT)
Date: Thu, 04 Sep 2025 12:01:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 00/18] WHPX support for Arm
In-Reply-To: <20250808065419.47415-1-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
Message-ID: <5758AEBA-9E33-4DCA-9B08-0AF91FD03B0E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 8=2E August 2025 06:54:01 UTC schrieb Mohamed Mediouni <mohamed@unpredi=
ctable=2Efr>:
>Link to branch: https://github=2Ecom/mediouni-m/qemu whpx (tag for this s=
ubmission: whpx-v5)
>
>Missing features:
>- PSCI state sync with Hyper-V: notably breaks reboots when multiple core=
s are enabled
>- Interrupt controller save-restore
>- SVE register sync
>
>To do:
>- Switching ITS to off by default when using HVF w/ vGIC or WHPX (will pr=
obably do when both the series are merged)
>- After that, perhaps exit if ITS is explicitly enabled=2E
>
>Note:
>
>"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing=
 list, added here
>as part of this series to make it compilable as a whole=2E
>
>"hw/arm: virt: add GICv2m for the case when ITS is not available" present=
 in both the HVF
>vGIC and this series=2E
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
>Mohamed Mediouni (17):
>  hw/arm: virt: add GICv2m for the case when ITS is not available
>  whpx: Move around files before introducing AArch64 support
>  whpx: reshuffle common code
>  whpx: ifdef out winhvemulation on non-x86_64
>  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>  whpx: interrupt controller support
>  whpx: add arm64 support
>  whpx: copy over memory management logic from hvf
>  target/arm: cpu: mark WHPX as supporting PSCI 1=2E1
>  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>    together with ITS
>  whpx: arm64: clamp down IPA size
>  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
>    and HVF
>  whpx: arm64: implement -cpu host
>  target/arm: whpx: instantiate GIC early
>  whpx: arm64: gicv3: add migration blocker
>  MAINTAINERS: Add myself as a maintainer for WHPX
>
>Philippe Mathieu-Daud=C3=A9 (1):
>  accel/system: Introduce hwaccel_enabled() helper
>
> MAINTAINERS                                   |    9 +-
> accel/hvf/hvf-all=2Ec                           |    7 +-
> accel/meson=2Ebuild                             |    1 +
> accel/whpx/meson=2Ebuild                        |    7 +
> {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec  |    6 +-
> accel/whpx/whpx-common=2Ec                      |  666 +++++++++++
> hw/arm/virt-acpi-build=2Ec                      |    4 +-
> hw/arm/virt=2Ec                                 |   34 +-
> hw/i386/x86-cpu=2Ec                             |    4 +-
> hw/intc/arm_gicv3_common=2Ec                    |    3 +
> hw/intc/arm_gicv3_whpx=2Ec                      |  272 +++++
> hw/intc/meson=2Ebuild                           |    1 +
> include/hw/arm/virt=2Eh                         |    2 +
> include/hw/boards=2Eh                           |    3 +-
> include/hw/intc/arm_gicv3_common=2Eh            |    3 +
> include/system/hvf_int=2Eh                      |    2 +
> include/system/hw_accel=2Eh                     |   13 +
> =2E=2E=2E/whpx =3D> include/system}/whpx-accel-ops=2Eh  |    4 +-
> include/system/whpx-all=2Eh                     |   20 +
> include/system/whpx-common=2Eh                  |   26 +
> =2E=2E=2E/whpx =3D> include/system}/whpx-internal=2Eh   |   14 +-
> include/system/whpx=2Eh                         |    4 +-
> meson=2Ebuild                                   |   21 +-
> target/arm/cpu=2Ec                              |    3 +-
> target/arm/cpu64=2Ec                            |   19 +-
> target/arm/hvf-stub=2Ec                         |   20 -
> target/arm/hvf/hvf=2Ec                          |    6 +-
> target/arm/hvf_arm=2Eh                          |    3 -
> target/arm/meson=2Ebuild                        |    2 +-
> target/arm/whpx/meson=2Ebuild                   |    5 +
> target/arm/whpx/whpx-all=2Ec                    | 1025 +++++++++++++++++
> target/arm/whpx/whpx-stub=2Ec                   |   15 +
> target/arm/whpx_arm=2Eh                         |   17 +
> target/i386/cpu-apic=2Ec                        |    2 +-
> target/i386/hvf/hvf=2Ec                         |   11 +
> target/i386/whpx/meson=2Ebuild                  |    1 -
> target/i386/whpx/whpx-all=2Ec                   |  569 +--------
> target/i386/whpx/whpx-apic=2Ec                  |    2 +-
> 38 files changed, 2207 insertions(+), 619 deletions(-)
> create mode 100644 accel/whpx/meson=2Ebuild
> rename {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec (96%)
> create mode 100644 accel/whpx/whpx-common=2Ec
> create mode 100644 hw/intc/arm_gicv3_whpx=2Ec
> rename {target/i386/whpx =3D> include/system}/whpx-accel-ops=2Eh (92%)
> create mode 100644 include/system/whpx-all=2Eh
> create mode 100644 include/system/whpx-common=2Eh
> rename {target/i386/whpx =3D> include/system}/whpx-internal=2Eh (96%)
> delete mode 100644 target/arm/hvf-stub=2Ec
> create mode 100644 target/arm/whpx/meson=2Ebuild
> create mode 100644 target/arm/whpx/whpx-all=2Ec
> create mode 100644 target/arm/whpx/whpx-stub=2Ec
> create mode 100644 target/arm/whpx_arm=2Eh
>

Ran this branch for a couple of days on x86_64 without any issues=2E So, f=
or the x86_64 refactorings:

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>


