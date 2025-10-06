Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A9CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lm1-0002Xe-3i; Mon, 06 Oct 2025 10:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5llt-0002Vt-P7
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5llb-0000bh-Ji
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7Kmk3hdlbhMixDBg6ndzL6lWWgyb647z3h5flv5N0w=;
 b=GLRtDLDNQPdLIgU7ha4rqycY/u2qXMaVViTiJDsqduhwWjqiS+gxhH9atNTBK5P82yFKBz
 CH6wh8Jg/BL8ONbs+FcDhlu9Mha08yJJwzTVtEdUvxrU48prnZ2RNDOa29/zSggONdTeL+
 sseECX3AcoEtW7CYcczdMicdoERfhyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-v5-Q_n5gP_aXKkQoFWa1-Q-1; Mon, 06 Oct 2025 10:00:38 -0400
X-MC-Unique: v5-Q_n5gP_aXKkQoFWa1-Q-1
X-Mimecast-MFC-AGG-ID: v5-Q_n5gP_aXKkQoFWa1-Q_1759759236
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e303235e8so46700995e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759236; x=1760364036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7Kmk3hdlbhMixDBg6ndzL6lWWgyb647z3h5flv5N0w=;
 b=AC9VXnnYxbgH7Ew4rk4iFpEkCEa9NP1VgK8XhsstzU8X2YCON2YTxH/pDi0dduT7T7
 622Pu4JSaLAfkWyKEmVxyaLR30XkW8QcezvXDjqwmGzX2Ue4Bkb7pnI+YdXCqd0Dyax9
 s6sCIo5sfk1BYvYecBM5KrFZRBCEo4iPSWa9H/PnUirE7Q/nWZe7exKrQZH5iFUKfi2e
 0JDz3NtQqgy8zD/MBnLqerXtHhGXHPEN2Zk1vf90CMuQqNDpegNp4QCWvtdX2r/3K/gA
 UfOUWKg3jhwEXxz3rnxZIGlxZY2YHOMa4Ipzva6vAL54k54hlC1m2C2uFaUeeK5BctXt
 y2lQ==
X-Gm-Message-State: AOJu0Yy65Uhe/HbQrEP+VtKn59an/XjqCxxtwK7u96BMHsjRQZuZkVZ4
 wHZ2dyC5G+rc22BUT19gC5zDLXONCE5VP96OJZfJG2aSPviHIQAKeBPSeuN16jig+l46Q1guMx/
 DOlD3cCpmPivuT4fY7qVif11hIHw+evkvc0/CbCaVpzuQMSHtGYkpCVd0
X-Gm-Gg: ASbGncsoY7CmwVwhCuDd/4M2p/gmNS1+sfWEaStjtPAwuKO0uQt18QnhbIGuP9ev3gh
 4rH3af+Ot7Hmdfdw4IBGI2oYxFnILGaCyE9oBQ35s7O++kFeD563HY7o5lHd1lzb/C3n+9VpiX4
 GhPSi7q2IN+1k1h23HhqkdrUpPOngtSiJIIauiSeZVRHHjrHmP5WE+cCCBwD6ulXqq0GdW7lupG
 XkPpvFTpawys6nuqMnfmwKSYadfFAUaNsMSjdtyhRFmlCRKpc0tjK85d0u1ArOG88o57s5OFoda
 wy5DN0LwuS4D3vQrT99126MJufOkxeDUIFe8
X-Received: by 2002:a05:600c:1986:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e711054f4mr86006635e9.15.1759759235301; 
 Mon, 06 Oct 2025 07:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14c/2Z5YCZ7E3j3uv2AmFhpanDP3wRcO5giCYgaOIKW9jhf5liOscU7sPKGtclMBFBrbYKg==
X-Received: by 2002:a05:600c:1986:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e711054f4mr86004435e9.15.1759759232661; 
 Mon, 06 Oct 2025 07:00:32 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8b0sm21081782f8f.18.2025.10.06.07.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 07:00:32 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:00:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like
 Feature for ARMv8+ Arch
Message-ID: <20251006160027.20067fe4@fedora>
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed,  1 Oct 2025 01:01:03 +0000
salil.mehta@opnsrc.net wrote:

> From: Salil Mehta <salil.mehta@huawei.com>
>=20
> [!] Sending again: It looks like mails sent from my official ID are being=
 held
> somewhere. Hence, I am using my other email address. Sorry for any inconv=
enience
> this may have caused.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (I) Prologue
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This patch series adds support for a virtual CPU hotplug-like feature (in=
 terms
> of usage) to Armv8+ platforms. Administrators are able to dynamically sca=
le the
> compute capacity on demand by adding or removing vCPUs. The interface is =
similar
> in look-and-feel to the vCPU hotplug feature supported on x86 platforms. =
While
> this series for Arm platforms shares the end goal with x86, it is impleme=
nted
> differently because of inherent differences in the CPU architecture and t=
he
> constraints it imposes.
>=20
> In this implementation, the meaning of "CPU hotplug" is as described in t=
he Arm
> Power State Coordination Interface (PSCI) specification (DEN0022F.b, =C2=
=A74.3 "CPU
> hotplug and secondary CPU boot", =C2=A75.5, 5.6). This definition has not=
 changed.
> On Arm platforms, the guest kernel itself can request CPU onlining or off=
lining
> using PSCI calls (via SMC/HVC), since the CPU_ON and CPU_OFF functions ar=
e part
> of the standard PSCI interface exposed to the non-secure world.
>=20
> This patch series instead adds the infrastructure required to implement
> administrative policy control in QEMU/VMM (as privileged software) along =
with
> the ability to convey changes via ACPI to the guest kernel. This ensures =
the
> guest is notified of compute capacity changes that result from per-vCPU
> administrative policy. This is conceptually similar to the traditional CPU
> hotplug mechanism that x86 follows. It allows or denies guest-initiated P=
SCI
> CPU_ON/OFF requests by enabling or disabling an already ACPI-described and
> present vCPU via HMP/QMP 'device_set' (a new interface), making it (un)av=
ailable
> to the guest kernel. This provides the look-and-feel of vCPU hotplug thro=
ugh
> ACPI _STA.Enabled toggling, while keeping all vCPUs enumerated in ACPI ta=
bles at
> boot.
>=20
> Unlike x86, where vCPUs can become not-present after boot and the kernel =
(maybe
> because architecture allows this?) tolerates some level of dynamic topolo=
gy
> changes, the Arm CPU Architecture requires that the number of vCPUs and t=
heir
> associated redistributors remain fixed once the system has booted. Conseq=
uently,
> the Arm host kernel and guest kernel do not tolerate removal or addition =
of CPU
> objects after boot.
>=20
> Offline vCPUs remain described to guest firmware and OSPM, and can be bro=
ught
> online later by toggling the ACPI _STA Enabled bit. This model aligns with
> ACPI 6.5 (Table 5.37, GICC CPU Interface Flags), which introduced the "On=
line
> Capable" bit to signal processors that can be enabled at runtime. It is a=
lso
> consistent with the Arm GIC Architecture Specification (IHI0069H, =C2=A71=
1.1), which
> defines CPU interface power domain behavior.
>=20
> Corresponding kernel changes from James Morse (ARM) have already been acc=
epted
> and are part of the mainline Linux kernel since 6.11 release.

Series a bit of tangled up, I'd suggest splitting it in 3 separate
series that would follow up each other, to make it more digestible
and that should simplify/speedup review and merging processes.

here is suggested order (1 and 2 could be swapped or done in parallel):

1: introduce power state infrastructure (hw one as opposed to administrativ=
e one)
   and apply it to ARM vcpus.
   (on completion guest should be able to power up/down cores using exiting
    linux interfaces (which I'd guess end up in calling PSCI))

2. Instead of complicating =E2=80=98-smp=E2=80=99 semantics and as conseque=
nce trying to deal
    with complications it causes (-deviceset CLI option),
    I=E2=80=99d suggest to make =E2=80=98-device arm-cpu=E2=80=99 work, tha=
t way
    =E2=80=98-smp=E2=80=99 semantics stay the same
    and you don=E2=80=99t have to invent -deviceset CLI option to fixup bui=
lt in CPUs.

    What I see in this series has a number of problems wrt to above:
    2.1: -smp creates anonymous vcpus that aren=E2=80=99t supposed to be ma=
naged by user,
         as opposed to devices created by -device, which must have user ass=
igned  =E2=80=98id=E2=80=99
         if they are to be managed by the user.
    2.2. to workaround that, series adds to =E2=80=98-deviceset/device-set=
=E2=80=99 that lets
         pattern match vcpus by some subset of device properties. Thus viol=
ating #1 point.

    Above can be solved by using existing =E2=80=98-device=E2=80=99 that wo=
uld allow to set
    initial power state during vcpu creation time and let user assign =E2=
=80=98id=E2=80=99
    if one wishes to manage that vcpu later on.
    That alleviates the need for -deviceset accessing anonymous vcpus.
    And remaining device-set QMP command would have user provided =E2=80=98=
id=E2=80=99 to address
    managed vcpus.
    i.e. UI will be consistent with what we do in x86/s390/spapr cases,
    as well as with any other devices that supports '-device'

3. As the last would come series to support administrative power state poli=
cy
   aka =E2=80=98hotplug-like=E2=80=99 feature (incl. device-set QMP command=
).


Also:
Looking at previous reviews, lazy-realize issue still hasn=E2=80=99t been d=
ropped.
It=E2=80=99s a hack to workaround slowness of VCPU creation code and
I still maintain the opinion that it doesn't fit this series.
(it actually gets in the way of the =E2=80=98hotplug-like=E2=80=99 feature,
negatively influencing/complicating this series).

If faster vcpu creation times are needed, fix relevant code instead of
covering it up with a hack. (in previous reviews I've even pointed to
some low hanging fruits that can speed it up).
Anyways speed up optimizations should be a separate series and
shouldn't be conflated with this series at all.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (II) Summary of `Recent` Key Changes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> RFC V5 -> RFC V6
>=20
> (*) KeyChange: Introduced new infrastructure to handle administrative Pow=
erState
>     transitions (enable-to-disable & vice-versa) as-per Policy.
> (*) Stopped using the existing vCPU Hotplug infrastructure code
> (*) Replaced 'device_add/-device' with new 'device_set/-deviceset' interf=
ace
> (*) Introduced '-smp disabledcpus=3DN' parameter for Qemu CLI
> (*) Dropped 'info hotpluggable'. Added 'info cpus-powerstate' command
> (*) Introduced DeviceState::admin_power_state property=3D{enabled,disable=
d,removed} states
> (*) Introduced new 'PowerStateHandlder' abstract interface with powerstat=
e hooks.
> (*) Dropped destruction of disabled vCPU objects post cpu init.
> (*) Dropped vCPU Hotplug ACPI support introduced ACPI/GED specifcally for=
 ARM type vCPUs
> (*) Dropped GIC IRQ unwiring support once VM is initialized.
> (*) Dropped vCPU unrealization support. Retained lazy realization of disa=
bled vCPUs(boot time).
> (*) All vCPU objects exist for lifetime of VM.
> (*) Introduced a separate ACPI CPU/OSPM interface to handle device check,=
 eject
>     request etc. to intimate gues kernel about change in policy.
> (*) Introduced new concept of *userspace parking* of 'disabled' KVM vCPUs=
=20

=E2=80=98Parking=E2=80=99 was KVM concept due to inability to destroy VCPUs=
 on KVM side.
Please do not use/propagate/expose it to newer code (unless it's KVM relate=
d).
In absence of lazy-realize it's likely not needed, as parking is only
related to unrealize in KVM context.

> (*) We do not migrate disabled vCPUs

I=E2=80=99d migrate disabled vcpus as well (at least power state), while it=
 would consume time,
It would be in line with what we do with other present devices.
We can always reduce what we migrate later on as a patch on top if necessar=
y.

> (*) Mitigation to pause_all_vcpus() problem. Caching the ICC_CTLR_EL1 in =
Qemu
> (*) Stopped reconciling (for now) vCPU config at destination VM during Mi=
gration

I guess that concludes my review of this revision.

PS:
I don't think that per patch review at this state would make much sense
as the things patches do are all mixed up and some of that should go away,
drastically changing next revision.
But given the series is complete rewrite, it's expected and allows
to identify how to ammend the following series.


> Dropped Due to change in vCPU handling approach:
>=20
> [PATCH RFC V5 03/30] hw/arm/virt: Move setting of common vCPU properties =
in a function
> [PATCH RFC V5 04/30] arm/virt, target/arm: Machine init time change commo=
n to vCPU {cold|hot}-plug
> [PATCH RFC V5 09/30] arm/acpi: Enable ACPI support for vCPU hotplug
> [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible vC=
PUs after init
> [PATCH RFC V5 14/30] hw/acpi: Make _MAT method optional
> [PATCH RFC V5 16/30] target/arm: Force ARM vCPU *present* status ACPI *pe=
rsistent*
> [PATCH RFC V5 18/30] arm/virt: Changes to (un)wire GICC<->vCPU IRQs durin=
g hot-(un)plug
> [PATCH RFC V5 22/30] target/arm/cpu: Check if hotplugged ARM vCPU's FEAT =
match existing
> [PATCH RFC V5 24/30] target/arm: Add support to *unrealize* ARMCPU during=
 vCPU Hot-unplug
> [PATCH RFC V5 25/30] tcg/mttcg: Introduce MTTCG thread unregistration leg
> [PATCH RFC V5 30/30] hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *=
Enabled*
>=20
> Modified or Code reused in other patches:
>=20
> [PATCH RFC V5 19/30] hw/arm, gicv3: Changes to notify GICv3 CPU state wit=
h vCPU hot-(un)plug event
> [PATCH RFC V5 17/30] arm/virt: Add/update basic hot-(un)plug framework
> [PATCH RFC V5 20/30] hw/arm: Changes required for reset and to support ne=
xt boot
> [PATCH RFC V5 21/30] arm/virt: Update the guest(via GED) about vCPU hot-(=
un)plug events
>=20
> ---------------------------------
> [!] Expectations From This RFC v6
> ---------------------------------
>=20
> Please refer to the DISCLAIMER in Section (XI) for the correct expectatio=
ns from
> this version of the RFC
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (II) Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Adds virtual CPU hot-plug-like support for ARMv8+ Arch in QEMU. Allows vC=
PUs to
> be brought online or offline after VM boot, similar to x86 arch, while ke=
eping
> all CPU resources provisioned and described at startup. Enables scaling g=
uest VM
> compute capacity on demand, useful in several scenarios:
>=20
> 1. Vertical Pod Autoscaling [9][10] in the cloud: As part of an orchestra=
tion
>    framework, resource requests (CPU and memory) for containers in a pod =
can be
>    adjusted dynamically based on usage.
>=20
> 2. Pay-as-you-grow business model: Infrastructure providers may allocate =
and
>    restrict the total compute resources available to a guest VM according=
 to
>    the SLA (Service Level Agreement). VM owners can then request addition=
al
>    CPUs to be hot-plugged at extra cost.
>=20
> In Kubernetes environments, workloads such as Kata Container VMs often ad=
opt
> a "hot-plug everything" model: start with the minimum resources and add v=
CPUs
> later as needed. For example, a VM may boot with just one vCPU, then scal=
e up
> once the workload is provisioned. This approach provides:
>=20
> 1. Faster boot times, and
> 2. Lower memory footprint.
>=20
> vCPU hot-plug is therefore one of the steps toward realizing the broader
> "hot-plug everything" objective. Other hot-plug mechanisms already exist =
on ARM,
> such as ACPI-based memory hot-plug and PCIe device hot-plug, and are supp=
orted
> in both QEMU and the Linux guest. Extending vCPU hot-plug in this series =
aligns
> with those efforts and fills the remaining gap.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (III) Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The ARM architecture does not support physical CPU hot-plug and lacks a
> specification describing the behavior of per-CPU components (e.g. GIC CPU
> interface, redistributors, PMUs, timers) when such events occur. As a res=
ult,
> both host and guest kernels are intolerant to changes in the number of CP=
Us
> enumerated by firmware and described by ACPI at boot time.
>=20
> We need to respect these architectural constraints and the kernel limitat=
ions
> they impose, namely the inability to tolerate changes in the number of CP=
Us
> enumerated by firmware once the system has booted, and create a practical
> solution with workarounds in the VMM/QEMU.
>=20
> This patch set implements a non-intrusive solution by provisioning all vC=
PU
> resources during VM initialization and exposing them via ACPI to the guest
> kernel. The resources remain fixed, while the effect of hot-plug is achie=
ved by
> toggling ACPI CPU status (enabled) bits to bring vCPUs online or offline.
>=20
> -----------
> Terminology
> -----------
>=20
> (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This incl=
udes
>                    any 'present' & 'enabled' CPUs plus any CPUs that are
>                    'present' but are 'disabled' at boottime.
>                    - Qemu parameter (-smp cpus=3DN1, disabled=3DN2)
>                    - Possible vCPUs =3D N1 + N2
> (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might or =
might
>                    not be ACPI 'enabled'.=20
> (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled' an=
d can
>                    now be =E2=80=98onlined=E2=80=99 (PSCI) for use by the=
 Guest Kernel. All cold-
>                    booted vCPUs are ACPI 'enabled' at boot. Later, using
>                    'device_set/-deviceset', more vCPUs can be ACPI 'enabl=
ed'.
>=20
>=20
> Below are further details of the constraints:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (IV) Constraints Due to ARMv8+ CPU Architecture
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>=20
>    1. ARMv8 CPU architecture does not support the concept of the physical=
 CPU
>       hotplug.=20
>       a. There are many per-CPU components like PMU, SVE, MTE, Arch timer=
s, etc.,
>          whose behavior needs to be clearly defined when the CPU is
>          hot(un)plugged. Current specification does not define this nor a=
re any
>          immediate plans from ARM to extend support for such a feature.
>    2. Other ARM components like GIC, etc., have not been designed to real=
ize
>       physical CPU hotplug capability as of now. For example,
>       a. Every physical CPU has a unique GICC (GIC CPU Interface) by cons=
truct.
>          Architecture does not specify what CPU hot(un)plug would mean in
>          context to any of these.
>       b. CPUs/GICC are physically connected to unique GICR (GIC Redistrib=
utor).
>          GIC Redistributors are always part of the always-on power domain=
. Hence,
>          they cannot be powered off as per specification.
>=20
> B. Limitation in Firmware/ACPI (Architectural Constraint)
>=20
>    1. Firmware has to expose GICC, GICR, and other per-CPU features like =
PMU,
>       SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural co=
nstraint
>       stated in section A1(a), all interrupt controller structures of
>       MADT describing GIC CPU Interfaces and the GIC Redistributors MUST =
be
>       presented by firmware to the OSPM during boot time.
>    2. Architectures that support CPU hotplug can evaluate the ACPI _MAT m=
ethod
>       to get this kind of information from the firmware even after boot, =
and the
>       OSPM has the capability to process these. ARM kernel uses informati=
on in
>       MADT interrupt controller structures to identify the number of pres=
ent CPUs
>       during boot and hence does not allow to change these after boot. Th=
e number
>       of present CPUs cannot be changed. It is an architectural constrain=
t!
>=20
> C. Limitations in KVM to Support Virtual CPU Hotplug (Architectural Const=
raint)
>=20
>    1. KVM VGIC:
>       a. Sizing of various VGIC resources like memory regions, etc., rela=
ted to
>          the redistributor happens only once and is fixed at the VM init =
time
>          and cannot be changed later after initialization has happened.
>          KVM statically configures these resources based on the number of=
 vCPUs
>          and the number/size of redistributor ranges.
>       b. Association between vCPU and its VGIC redistributor is fixed at =
the
>          VM init time within the KVM, i.e., when redistributor iodevs gets
>          registered. VGIC does not allow to setup/change this association
>          after VM initialization has happened. Physically, every CPU/GICC=
 is
>          uniquely connected with its redistributor, and there is no
>          architectural way to set this up.
>    2. KVM vCPUs:
>       a. Lack of specification means destruction of KVM vCPUs does not ex=
ist as
>          there is no reference to tell what to do with other per-vCPU
>          components like redistributors, arch timer, etc.
>       b. In fact, KVM does not implement the destruction of vCPUs for any
>          architecture. This is independent of whether the architecture
>          actually supports CPU Hotplug feature. For example, even for x86=
 KVM
>          does not implement the destruction of vCPUs.
>=20
> D. Considerations in Qemu due to ARM CPU Architecture & related KVM Const=
raints:
>=20
>    1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCP=
Us to
>       overcome the KVM constraint. KVM vCPUs are created and initialized =
when
>       Qemu CPU Objects are realized.
>    2. The 'GICV3State' and 'GICV3CPUState' objects must be sized for all =
possible
>       vCPUs at VM initialization, when the QOM GICv3 object is realized. =
This is
>       required because the KVM VGIC can only be initialized once, and the=
 number
>       of redistributors, their per-vCPU interfaces, and associated data
>       structures or I/O device regions are all fixed at VM init time.
>    3. How should new QOM CPU objects be connected back to the 'GICV3CPUSt=
ate'
>       objects and disconnected from it in case the CPU is being hot(un)pl=
ugged?
>    4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented =
in the
>       QOM for which KVM vCPU already exists? For example, whether to keep,
>        a. No QOM CPU objects Or
>        b. Unrealized CPU Objects
>    5. How should vCPU state be exposed via ACPI to the Guest? Especially =
for
>       the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not e=
xist
>       within the QOM but the Guest always expects all possible vCPUs to be
>       identified as ACPI *present* during boot.
>    6. How should Qemu expose GIC CPU interfaces for the unplugged or
>       yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?
>=20
> E. How are the above questions addressed in this QEMU implementation?
>=20
>    1. Respect the limitations imposed by the Arm architecture in KVM, ACP=
I, and
>       the guest kernel. This requires always keeping the vCPU count const=
ant.
>    2. Implement a workaround in QEMU by keeping all vCPUs present and tog=
gling
>       the ACPI _STA.Enabled bit to realize a vCPU hotplug-like effect.
>    3. Never destroy vCPU objects once initialized, since they hold the AR=
MCPU
>       state that is set up once during VM initialization.
>    4. Size other per-vCPU components, such as the VGIC CPU interface and
>       redistributors, for the maximum number of vCPUs possible during the=
 VM=E2=80=99s
>       lifetime.
>    5. Exit HVC/SMC KVM hypercalls (triggered by PSCI CPU_ON/OFF) to user =
space
>       for policy checks that allow or deny the guest kernel=E2=80=99s pow=
er-on/off
>       request.
>    6. Disabled vCPUs remain parked in user space and are never migrated.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
> (V) Summary of Flow =20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
>=20
> ------------------- =20
> vCPU Initialization =20
> ------------------- =20
>    1. Keep all vCPUs always enumerated and present (enabled/disabled) in =
the
>       guest kernel, host KVM, and QEMU with topology fixed. =20
>    2. Realize hotplug-like functionality by toggling the ACPI _STA.Enable=
d bit
>       for each vCPU. =20
>    3. Never destroy a vCPU. vCPU objects and threads remain alive through=
out the
>       VM lifetime once created. No un-realization handling code is requir=
ed.
>       Threads may be realized lazily for disabled vCPUs. =20
>    4. At VM init, pre-create all possible vCPUs in KVM, including those n=
ot yet
>       enabled in QEMU, but keep them in the PSCI powered-off state. =20
>    5. Park disabled vCPU threads in user space to avoid KVM lock contenti=
on.
>       This means 'CPUState::halted=3D1'; 'CPUState::stopped=3D1'; and 'CP=
UState::parked=3D1' (new). =20
> ------------------- =20
> VGIC Initialization =20
> ------------------- =20
>    6. Size 'GICv3State' and 'GICv3CPUState' objects over possible vCPUs a=
t VM
>       init time when the QEMU GIC is realized. This also sizes KVM VGIC
>       resources such  as redistributor regions. This sizing never changes=
 after
>       VM init.
> ------------------- =20
> ACPI Initialization =20
> ------------------- =20
>    7. Build the ACPI MADT table with updates: =20
>       a. Number of GIC CPU interface entries =3D possible vCPUs. =20
>       b. Boot vCPU as MADT.GICC.Enabled=3D1 (not hot[un]pluggable). =20
>       c. Hot[un]pluggable vCPUs as MADT.GICC.online-capable=3D1 and =20
>          MADT.GICC.Enabled=3D0 (mutually exclusive). These vCPUs can be e=
nabled
>          and onlined after guest boot (firmware policy). =20
>    8. Expose ACPI _STA status to the guest kernel: =20
>       a. Always _STA.Present=3D1 (all possible vCPUs). =20
>       b. _STA.Enabled=3D1 (enabled vCPUs =3D plugged). =20
>       c. _STA.Enabled=3D0 (disabled vCPUs =3D unplugged). =20
> --------------------------------------------------------------- =20
> vCPU Administrative *First* Enable [=3D vCPU Hotplug-like Action] =20
> --------------------------------------------------------------- =20
>    9. The first administrative enable of a vCPU leads to deferred realiza=
tion of
>       the QEMU vCPU object initialized at VM init: =20
>       a. Realizes the vCPU object and spawns the QEMU vCPU thread. =20
>       b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list). =20
>       c. Reinitializes the KVM vCPU in the host (reset core/sys regs, set
>          defaults).=20
>       d. Runs the KVM vCPU (created with 'start-powered-off'). Thread wai=
ts for
>          PSCI.
>       e. Marks QEMU 'GICv3CPUState' interface accessible. =20
>       f. Updates ACPI _STA.Enabled=3D1. =20
>       g. Notifies guest (GED Device-Check). Guest sees Enabled=3D1 and re=
gisters
>          CPU.=20
>       h. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC). =20
>          - KVM exits to QEMU (policy check). =20
>          - If allowed, QEMU calls `cpu_reset()` and powers on the vCPU in=
 KVM.
> 	 - KVM wakes vCPU thread out of sleep and puts vCPUMP state to RUNNABLE=
=20
> ----------------------------------------------------------- =20
> vCPU Administrative Disable [=3D vCPU Hot-unplug-like Action] =20
> ----------------------------------------------------------- =20
>   10. Administrative disable does not un-realize the QOM CPU object or de=
stroy
>       the vCPU thread. Instead: =20
>       a. Notifies guest (GED Eject Request). Guest offlines vCPU (CPU_OFF=
 PSCI).
>       b. KVM exits to QEMU (policy check).=20
>          - QEMU powers off vCPU in KVM and
> 	 - KVM puts vCPUMP state to STOPPED & sleeps on RCUWait
>       c. Guest signals eject after quiescing vCPU. =20
>       d. QEMU updates ACPI _STA.Enabled=3D0. =20
>       e. Marks QEMU 'GICv3CPUState' interface inaccessible. =20
>       f. Parks the vCPU thread in user space (unblocks from KVM to avoid =
vCPU
>          lock contention): =20
>          - Unregisters VMSD from migration. =20
>          - Removes vCPU from present/active lists. =20
>          - Pauses the vCPU (`cpu_pause`). =20
>          - Kicks vCPU thread to user space ('CPUState::parked=3D1'). =20
>       g. Guest sees ACPI _STA.Enabled=3D0 and removes CPU (unregisters fr=
om LDM).
> -------------------------------------------------------------------- =20
> vCPU Administrative *Subsequent* Enable [=3D vCPU Hotplug-like Action] =20
> -------------------------------------------------------------------- =20
>   11. A subsequent administrative enable does not realize objects or spaw=
n a new
>       thread. Instead: =20
>       a. Unparks the vCPU thread in user space: =20
>          - Re-registers VMSD for migration. =20
>          - Adds back to present/active lists. =20
>          - Resumes the vCPU (`cpu_resume`). =20
>          - Clears parked flag ('CPUState::parked=3D0'). =20
>       b. Marks QEMU 'GICv3CPUState' interface accessible again. =20
>       c. Updates ACPI _STA.Enabled=3D1. =20
>       d. Notifies guest (GED Device-Check). Guest sees Enabled=3D1 and re=
gisters
>          CPU.
>       e. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC). =20
>          - KVM exits to QEMU (policy check). =20
>          - QEMU sets power-state=3DPSCI_ON, calls `cpu_reset()`, and powe=
rs on
> 	   vCPU. =20
>          - KVM changes MP state to RUNNABLE. =20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VI) Work Presented at KVM Forum Conferences
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Details of the above work have been presented at KVMForum2020 and KVMForu=
m2023
> conferences. Slides & video are available at the links below:
> a. KVMForum 2023
>    - Challenges Revisited in Supporting Virt CPU Hotplug on architectures=
 that don't Support CPU Hotplug (like ARM64).
>      https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>      https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_V=
irt_CPU_Hotplug_-__ii0iNb3.pdf
>      https://www.youtube.com/watch?v=3Dhyrw4j2D6I0&t=3D23970s
>      https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
> b. KVMForum 2020
>    - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (l=
ike ARM64) - Salil Mehta, Huawei.
>      https://kvmforum2020.sched.com/event/eE4m
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VII) Commands Used
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> A. Qemu launch commands to init the machine (with 6 possible vCPUs):
>=20
> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \
> -cpu host -smp cpus=3D4,disabled=3D2 \
> -m 300M \
> -kernel Image \
> -initrd rootfs.cpio.gz \
> -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2 acp=
i=3Dforce" \
> -nographic \
> -bios QEMU_EFI.fd \
>=20
> B. Administrative '[En,Dis]able' [akin to 'Hot-(un)plug'] related command=
s:
>=20
> # Hot(un)plug a host vCPU (accel=3Dkvm):
> (qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Denable
> (qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Ddisab=
le
>=20
> # Hot(un)plug a vCPU (accel=3Dtcg):
> (qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=
=3Denable
> (qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=
=3Ddisable
>=20
> Sample output on guest after boot:
>=20
>     $ cat /sys/devices/system/cpu/possible
>     0-5
>     $ cat /sys/devices/system/cpu/present
>     0-5
>     $ cat /sys/devices/system/cpu/enabled
>     0-3
>     $ cat /sys/devices/system/cpu/online
>     0-1
>     $ cat /sys/devices/system/cpu/offline
>     2-5
>=20
> Sample output on guest after 'enabling'[=3D'hotplug'] & 'online' of vCPU=
=3D4:
>=20
>     $ echo 1 > /sys/devices/system/cpu/cpu4/online
>=20
>     $ cat /sys/devices/system/cpu/possible
>     0-5
>     $ cat /sys/devices/system/cpu/present
>     0-5
>     $ cat /sys/devices/system/cpu/enabled
>     0-4
>     $ cat /sys/devices/system/cpu/online
>     0-1,4
>     $ cat /sys/devices/system/cpu/offline
>     2-3,5
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VIII) Repositories
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
>     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6
> (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
>     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-{v1,v2,v=
3,v4,v5}
> (*) `Accepted` Qemu Architecture Agnostic patch is present here:
>     https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.a=
rch.agnostic.v16/
> (*) All Kernel changes are already part of mainline v6.11
> (*) Original Guest Kernel changes (by James Morse, ARM) are available her=
e:
>     https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtu=
al_cpu_hotplug/rfc/v2
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> (IX) KNOWN ISSUES & THINGS TO DO
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. TCG currently faces some hang issues due to unhandled cases. We aim to=
 fix
>    these within the next one to two weeks.
> 2. Comprehensive testing is ongoing. This is fresh code, and we expect to
>    complete testing within two weeks.
> 3. QEMU documentation (.rst) still needs to be updated.
> 4. Migration has been lightly tested but is working as expected.
> 5. Mitigation to avoid `pause_all_vcpus` needs broader community discussi=
on. An
>    alternative change has been prepared in KVM, which maintains a shadow =
of
>    `ICC_CTLR_EL1` to reduce lock contention when using KVM device IOCTLs.=
 This
>    avoids synchronization issues if the register value changes during VM =
runtime.
>    While not mandatory, this enhancement would provide a more comprehensi=
ve fix
>    than the current QEMU assumption that the relevant fields are invarian=
t or
>    pseudo-static. An RFC for this KVM change will be floated within a wee=
k.
> 6. Mitigation of parking disabled vCPU threads in user space, to avoid bl=
ocking
>    them inside KVM, needs review by the wider community to ensure no hidd=
en
>    issues are introduced.
> 7. A discussion (if needed) on why `device_set` was chosen instead of `qo=
m-set`
>    for administrative state control.
> 8. CPU_SUSPEND/Standy related handling (if required)
> 9. HVF and qtest are not supported or done yet.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> (X) ORGANIZATION OF PATCHES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
>  [Patch 1-2, 22-23] New HMP/QMP interface ('device_set') related changes
>     (*) New ('DeviceState::admin_power_state') property; Enabled/Disabled=
 States and handling
>     (*) New Qemu CLI parameter ('-smp CPUS, disabled=3DN') handling
>     (*) Logic to find the existing object not part of the QOM
>  [Patch 3-5, 10] logic required during machine init.
>     (*) Some validation checks.
>     (*) Introduces core-id,socket-id,cluster-id property and some util fu=
nctions required later.
>     (*) Logic to setup lazy realization of the QOM vCPUs=20
>     (*) Logic to pre-create vCPUs in the KVM host kernel.
>  [Patch 6-7, 8-9] logic required to size the GICv3 State
>     (*) GIC initialization pre-sized with possible vCPUs.=20
>     (*) Introduction of the GICv3 CPU Interface `accessibility` property =
& accessors
>     (*) Refactoring to make KVM & TCG 'GICv3CPUState' initialization comm=
on.
>     (*) Changes in GICv3 post/pre-load function for migration=20
>  [Patch 11,14-16,19] logic related to ACPI at machine init time.
>     (*) ACPI CPU OSPM interface for ACPI _STA.Enable/Disable handling =20
>     (*) ACPI GED framework to cater to CPU DeviceCheck/Eject Events.
>     (*) ACPI DSDT, MADT changes.
>  [Patch 12-13, 17] Qdev, Virt Machine, PowerState Handler Changes
>     (*) Changes to introduce 'PowerStateHandler' and its abstract interfa=
ce.
>     (*) Qdev changes to handle the administrative enabling/disabling of d=
evice
>     (*) Virt Machine implementation of 'PowerStateHandler' Hooks
>     (*) vCPU thread user-space parking and unparking logic.
>  [Patch 18,20-21,24] Misc.
>     (*) Handling of SMCC Hypercall Exits by KVM to Qemu for PSCI.
>     (*) Mitigation to avoid using 'pause_all_vcpus' during ICC_CTLR_EL1 r=
eset.
>     (*) Mitigation when TCG 'TB Code Cache' is found saturated
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XI) DISCLAIMER
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This patch-set is the culmination of over four years of ongoing effort to=
 bring
> a vCPU hotplug-like feature to the Arm platform. The work has already led=
 to
> changes in the ACPI specification and the Linux kernel, and this series n=
ow
> introduces the missing piece within QEMU.
>=20
> The transition from RFC v5 to RFC v6 resulted in a shift of approach, bas=
ed on
> maintainer feedback, and required substantial code to be re-written. This=
 is
> *not* production-level code and may still contain bugs. Comprehensive tes=
ting is
> in progress on HiSilicon Kunpeng920 SoCs, Oracle servers, and Ampere plat=
forms.
> We expect to fix outstanding issues in the coming month and, subject to n=
o major
> concerns from maintainers about the chosen approach, a near-stable, non-R=
FC
> version will be posted soon.
>=20
> This work largely follows the direction of prior community discussions ov=
er the
> years [see refs below], including mailing list threads, Linaro Open Discu=
ssions,
> and sessions at KVM Forum. This RFC is intended to validate the overall a=
pproach
> outlined here and to gather community feedback before moving forward with=
 a
> formal patch series.
>=20
> [The concept being presented has been found to work!]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XII) Change Log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> RFC V4 -> RFC V5:
> -----------------
> 1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* sta=
tus ACPI *persistent*"
>    - Seperated the architecture agnostic ACPI changes required to support=
 vCPU Hotplug
>      Link: https://lore.kernel.org/qemu-devel/20241014192205.253479-1-sal=
il.mehta@huawei.com/#t
> 2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility for p=
ossible vCPUs"
>    - Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin (Redhat=
), Miguel(Oracle), Igor(Redhat)
> 3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH RF=
C V4 01/33]
> 3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::num_=
smp_cpus` flag
>    - All `GICv3CPUState' between [num_smp_cpus,num_cpus) are marked as 'i=
naccessible` during gicv3_common_realize()
>    - qemu_enabled_cpu() not required - removed!
>    - removed usage of `CPUState::disabled` from virt.c and hw/cpu64.c
> 4. Removed virt_cpu_properties() and introduced property `mp-affinity` ge=
t accessor
> 5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before *disa=
bled* vCPU Objects are destroyed"
>=20
> RFC V3 -> RFC V4:
> -----------------
> 1. Addressed Nicholas Piggin's (IBM) comments
>    - Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu.h
>      https://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.=
com/
>    - Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]=20
>      https://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.=
com/
>    - Converted CPUState::acpi_persistent into Property. Improved the cove=
r note
>      https://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.=
com/
>    - Fixed teh cover note of the[PATCH ] and clearly mentioned about KVMP=
arking
>      https://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.=
com/=20
> 2. Addressed Gavin Shan's (RedHat) comments:
>    - Introduced the ARM Extensions check. [Looks like I missed the PMU ch=
eck :( ]
>      https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df296=
8ae@redhat.com/
>    - Moved create_gpio() along with create_ged()
>      https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49=
029@redhat.com/
>    - Improved the logic of the GIC creation and initialization
>      https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35=
e70@redhat.com/
>    - Removed redundant !dev->realized checks in cpu_hotunplug(_request)
>      https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb0=
74a@redhat.com/
> 3. Addresses Alex Benn=C3=A9e's + Gustavo Romero (Linaro) comments
>    - Fixed the TCG support and now it works for all the cases including m=
igration.
>      https://lore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/
>    - Fixed the cpu_address_space_destroy() compilation failuer in user-mo=
de
>      https://lore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/
> 4. Fixed crash in .post_gicv3() during migration with asymmetrically *ena=
bled*
>      vCPUs at destination VM
>=20
> RFC V2 -> RFC V3:
> -----------------
> 1. Miscellaneous:
>    - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
> 2. Addressed Gavin Shan's (RedHat) comments:
>    - Made CPU property accessors inline.
>      https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1=
c58@redhat.com/
>    - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
>    - Dropped the patch as it was not required after init logic was refact=
ored.
>      https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1b=
e97@redhat.com/
>    - Fixed the range check for the core during vCPU Plug.
>      https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a931=
1af@redhat.com/
>    - Added has_hotpluggable_vcpus check to make build_cpus_aml() conditio=
nal.
>      https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb=
0f2@redhat.com/
>    - Fixed the states initialization in cpu_hotplug_hw_init() to accommod=
ate previous refactoring.
>      https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74=
f1c@redhat.com/
>    - Fixed typos.
>      https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df213=
66b@redhat.com/
>    - Removed the unnecessary 'goto fail'.
>      https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8=
a7d@redhat.com/#t
>    - Added check for hotpluggable vCPUs in the _OSC method.
>      https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL=
3kIW0AhmSqbspazwixAHVSi6c@z/
> 3. Addressed Shaoqin Huang's (Intel) comments:
>    - Fixed the compilation break due to the absence of a call to virt_cpu=
_properties() missing
>      along with its definition.
>      https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf99=
50b@redhat.com/
> 4. Addressed Jonathan Cameron's (Huawei) comments:
>    - Gated the 'disabled vcpu message' for GIC version < 3.
>      https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.co=
m/
>=20
> RFC V1 -> RFC V2:
> -----------------
> 1. Addressed James Morse's (ARM) requirement as per Linaro Open Discussio=
n:
>    - Exposed all possible vCPUs as always ACPI _STA.present and available=
 during boot time.
>    - Added the _OSC handling as required by James's patches.
>    - Introduction of 'online-capable' bit handling in the flag of MADT GI=
CC.
>    - SMCC Hypercall Exit handling in Qemu.
> 2. Addressed Marc Zyngier's comment:
>    - Fixed the note about GIC CPU Interface in the cover letter.
> 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis (Orac=
le) during testing:
>    - Live/Pseudo Migration crashes.
> 4. Others:
>    - Introduced the concept of persistent vCPU at QOM.
>    - Introduced wrapper APIs of present, possible, and persistent.
>    - Change at ACPI hotplug H/W init leg accommodating initializing is_pr=
esent and is_enabled states.
>    - Check to avoid unplugging cold-booted vCPUs.
>    - Disabled hotplugging with TCG/HVF/QTEST.
>    - Introduced CPU Topology, {socket, cluster, core, thread}-id property.
>    - Extract virt CPU properties as a common virt_vcpu_properties() funct=
ion.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XIII) ACKNOWLEDGEMENTS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I would like to thank the following people for various discussions with m=
e over
> different channels during development:
>=20
> Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will Dea=
con (Google),=20
> Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi (Li=
naro),=20
> Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),=20
> Igor Mammedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),=20
> Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),=20
> Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum (Hu=
awei),=20
> Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),=20
> Zengtao/Prime (Huawei), Nicholas Piggin (IBM), Alex Benn=C3=A9e(Linaro) a=
nd all those
> whom I have missed!
>=20
> Many thanks to the following people for their current or past contributio=
ns:
>=20
> 1. James Morse (ARM)
>    (Current Kernel part of vCPU Hotplug Support on AARCH64)
> 2. Jean-Philippe Brucker (Linaro)
>    (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V1)
> 3. Keqian Zhu (Huawei)
>    (Co-developed Qemu prototype)
> 4. Xiongfeng Wang (Huawei)
>    (Co-developed an earlier kernel prototype with me)
> 5. Vishnu Pajjuri (Ampere)
>    (Verification on Ampere ARM64 Platforms + fixes)
> 6. Miguel Luis (Oracle)
>    (Verification on Oracle ARM64 Platforms + fixes)
> 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
>    (Helping in upstreaming James Morse's Kernel patches).
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XIV) REFERENCES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta=
@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil=
.mehta@huawei.com/
> [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.=
com/
> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@lin=
ux.dev/
> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706
> [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.ht=
ml#gic-cpu-interface-gicc-structure
> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpoda=
utoscaler
> [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autosc=
aler.html
> [11] https://lkml.org/lkml/2019/7/10/235
> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
> [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op=
-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
> [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op=
-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@l=
inaro.org/
> [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.co=
m/=20
> [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.h=
tml#gicc-cpu-interface-flags
> [21] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.meht=
a@huawei.com/
> [22] https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.meh=
ta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
> [23] RFC V3: https://lore.kernel.org/qemu-devel/20240613233639.202896-1-s=
alil.mehta@huawei.com/#t
>=20
> Author Salil Mehta (1):
>   target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during PSCI_CPU=
_{ON,OFF}
>=20
> Jean-Philippe Brucker (1):
>   target/arm/kvm: Write vCPU's state back to KVM on cold-reset
>=20
> Salil Mehta (22):
>   hw/core: Introduce administrative power-state property and its accessors
>   hw/core, qemu-options.hx: Introduce 'disabledcpus' SMP parameter
>   hw/arm/virt: Clamp 'maxcpus' as-per machine's vCPU deferred online-capa=
bility
>   arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id pro=
perty
>   arm/virt,kvm: Pre-create KVM vCPUs for 'disabled' QOM vCPUs at machine =
init
>   arm/virt,gicv3: Pre-size GIC with possible vCPUs at machine init
>   arm/gicv3: Refactor CPU interface init for shared TCG/KVM use
>   arm/virt, gicv3: Guard CPU interface access for admin disabled vCPUs
>   hw/intc/arm_gicv3_common: Migrate & check 'GICv3CPUState' accessibility=
 mismatch
>   arm/virt: Init PMU at host for all present vCPUs
>   hw/arm/acpi: MADT change to size the guest with possible vCPUs
>   hw/core: Introduce generic device power-state handler interface
>   qdev: make admin power state changes trigger platform transitions via A=
CPI
>   arm/acpi: Introduce dedicated CPU OSPM interface for ARM-like platforms
>   acpi/ged: Notify OSPM of CPU administrative state changes via GED
>   arm/virt/acpi: Update ACPI DSDT Tbl to include 'Online-Capable' CPUs AML
>   hw/arm/virt,acpi/ged: Add PowerStateHandler hooks for runtime CPU state=
 changes
>   target/arm/cpu: Add the Accessor hook to fetch ARM CPU arch-id
>   hw/intc/arm-gicv3-kvm: Pause all vCPUs & cache ICC_CTLR_EL1 for userspa=
ce PSCI CPU_ON
>   monitor,qdev: Introduce 'device_set' to change admin state of existing =
devices
>   monitor,qapi: add 'info cpus-powerstate' and QMP query (Admin + Oper st=
ates)
>   tcg: Defer TB flush for 'lazy realized' vCPUs on first region alloc
>=20
>  accel/kvm/kvm-all.c                    |   2 +-
>  accel/tcg/tcg-accel-ops-mttcg.c        |   2 +-
>  accel/tcg/tcg-accel-ops-rr.c           |   2 +-
>  cpu-common.c                           |   4 +-
>  hmp-commands-info.hx                   |  32 ++
>  hmp-commands.hx                        |  30 +
>  hw/acpi/Kconfig                        |   3 +
>  hw/acpi/acpi-cpu-ospm-interface-stub.c |  41 ++
>  hw/acpi/cpu_ospm_interface.c           | 747 +++++++++++++++++++++++++
>  hw/acpi/generic_event_device.c         |  91 +++
>  hw/acpi/meson.build                    |   2 +
>  hw/acpi/trace-events                   |  17 +
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |  75 ++-
>  hw/arm/virt.c                          | 573 +++++++++++++++++--
>  hw/core/cpu-common.c                   |  12 +
>  hw/core/machine-hmp-cmds.c             |  62 ++
>  hw/core/machine-qmp-cmds.c             | 107 ++++
>  hw/core/machine-smp.c                  |  24 +-
>  hw/core/machine.c                      |  28 +
>  hw/core/meson.build                    |   1 +
>  hw/core/powerstate.c                   | 100 ++++
>  hw/core/qdev.c                         | 197 +++++++
>  hw/intc/arm_gicv3.c                    |   1 +
>  hw/intc/arm_gicv3_common.c             |  64 ++-
>  hw/intc/arm_gicv3_cpuif.c              | 270 ++++-----
>  hw/intc/arm_gicv3_cpuif_common.c       |  58 ++
>  hw/intc/arm_gicv3_kvm.c                | 123 +++-
>  hw/intc/gicv3_internal.h               |   1 +
>  include/hw/acpi/acpi_dev_interface.h   |   1 +
>  include/hw/acpi/cpu_ospm_interface.h   |  78 +++
>  include/hw/acpi/generic_event_device.h |   6 +
>  include/hw/arm/virt.h                  |  42 +-
>  include/hw/boards.h                    |  37 ++
>  include/hw/core/cpu.h                  |  71 +++
>  include/hw/intc/arm_gicv3_common.h     |  65 +++
>  include/hw/powerstate.h                | 177 ++++++
>  include/hw/qdev-core.h                 | 151 +++++
>  include/monitor/hmp.h                  |   3 +
>  include/monitor/qdev.h                 |  30 +
>  include/system/kvm.h                   |   8 +
>  include/system/system.h                |   1 +
>  include/tcg/startup.h                  |   6 +
>  include/tcg/tcg.h                      |   1 +
>  qapi/machine.json                      |  90 +++
>  qemu-options.hx                        | 129 ++++-
>  stubs/meson.build                      |   1 +
>  stubs/powerstate-stubs.c               |  47 ++
>  system/cpus.c                          |   4 +-
>  system/qdev-monitor.c                  | 139 ++++-
>  system/vl.c                            |  42 ++
>  target/arm/arm-powerctl.c              |  29 +-
>  target/arm/cpu.c                       |  14 +
>  target/arm/cpu.h                       |   5 +
>  target/arm/helper.c                    |   2 +-
>  target/arm/internals.h                 |   2 +-
>  target/arm/kvm.c                       | 140 ++++-
>  target/arm/kvm_arm.h                   |  25 +
>  target/arm/meson.build                 |   1 +
>  target/arm/{tcg =3D> }/psci.c            |   9 +
>  target/arm/tcg/meson.build             |   4 -
>  tcg/region.c                           |  16 +
>  tcg/tcg.c                              |  19 +-
>  63 files changed, 3800 insertions(+), 265 deletions(-)
>  create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c
>  create mode 100644 hw/acpi/cpu_ospm_interface.c
>  create mode 100644 hw/core/powerstate.c
>  create mode 100644 include/hw/acpi/cpu_ospm_interface.h
>  create mode 100644 include/hw/powerstate.h
>  create mode 100644 stubs/powerstate-stubs.c
>  rename target/arm/{tcg =3D> }/psci.c (96%)
>=20


