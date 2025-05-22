Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814DDC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5ED-0007ms-0e; Thu, 22 May 2025 08:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uI5E1-0007m3-9s
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uI5Du-0001tJ-W3
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747917626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9A14Jz/ibK8G6TUhTaYWFy+vbzYJQioG3DQE3QC/4I=;
 b=YJCLssACFqpQYnpFXZgD+uvUODWcJKRHC1I3rRAXwEuIQvm1iY1ZBiDoZE7mNpa8PqAcSq
 FwqkVr4k+KNsYKVNCtsSFfniFzDES6nuO6jT2xZL6n7nAj4huPBbYrJPoFcpRYQOVNktdO
 E4bZVmCa4mp/gDSIiB0Wozq1FvEoaKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-d413Ty2ePqaO-Og0ArXckQ-1; Thu, 22 May 2025 08:40:25 -0400
X-MC-Unique: d413Ty2ePqaO-Og0ArXckQ-1
X-Mimecast-MFC-AGG-ID: d413Ty2ePqaO-Og0ArXckQ_1747917624
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a3696a0ce6so2492166f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 05:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747917624; x=1748522424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9A14Jz/ibK8G6TUhTaYWFy+vbzYJQioG3DQE3QC/4I=;
 b=ZDyDVz6qgxVMNjTE/w16RJ2QdaETJlctM0q6ztAhEuY5C2mXXH0ngS5n8qaUl/fwmK
 U58h476S4IPDtaKd7A3FROHG9tlkHKBF6vq4FqUjbKNNUDF5OM97wmdx9vOX0prmfwkW
 kXMNaKxRrpsbOlUAp4tc+IAm8zIexv5YE39Md5Th8y1x+xTMvya8lwUcDMHyuWK4UEcz
 qMFrpfCZXtYKs3s2jtl8DeWwQW74hp7GbMz3HUpWbUPdM/0pr4SmWN9MIJzrxPxmHR+2
 hGexhlsadAzLW5aIQ9nHMB7Nr4wydJAcHhd6GMmAZs7jVzLP2S2taf/NLrSf3JzIO5iH
 Pg5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9l1lnBHX30QGsXBJMFRsoI5CUv3DySufaWfiCMSNmqP8FdcHx5EvL2Q45z66f/Ks4w5NahC65+YnF@nongnu.org
X-Gm-Message-State: AOJu0Yz6AcEYUoVwPhVmVtgnx7mG+d0HcjASSTDPraysPl0tbNWWFI7T
 YZn9D7Cf3jhzGtp22154xL4Ol3nkwRMZKHAtv7yNZAFN3S/hEGPsm+xkk3DstqPznvVLKuclZi+
 9SbNyaWuQJdz3yeUoakO763wgOiHssg61fMwUI8IF2+PyXnkrelNNq6GR
X-Gm-Gg: ASbGncuIo68ZVsWmmKNigkBRdlom6zpfo48FV9m21yjUpr+0mV69reK9LrjQCNg26w0
 FYSBIjA2e5ZMvpPFDrY8LsBtCRbGMEAnanb3J2MQ72hETHPneaiQB/gvfq4di6E0ejdRTeeilBY
 ehpuJ8EcY8INDJrvMfllIiapqUHTbjNnpKrd/wulRJyQACoeEFi24ix6ZtRxaXBndInzO7bYxuT
 Mj5uFbqqibNXZWv8A8Mw7hjmz95Z59UjzhQUoqPkhk9hGVO0ZHIelhJcUM1L/b+ohEC47c0Zt2m
 sJZPkS9U9ULgkCQUw/xroKL/IrRVanIp
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr10656426f8f.24.1747917623262; 
 Thu, 22 May 2025 05:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZv1G9UkiikLXHe1wUhlh+6wF0zgc6FIdzNJ6VmZYZcok1y4GIwDMXoCCs34Q9PnYw7YQhew==
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr10656318f8f.24.1747917622216; 
 Thu, 22 May 2025 05:40:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c002e937sm599393f8f.29.2025.05.22.05.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 05:40:21 -0700 (PDT)
Date: Thu, 22 May 2025 14:40:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Eric Auger <eauger@redhat.com>,
 maz@kernel.org, jean-philippe@linaro.org, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 peterx@redhat.com, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
Message-ID: <20250522144018.3f67adcf@imammedo.users.ipa.redhat.com>
In-Reply-To: <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <b65590b1-8a6f-43e5-b367-732d6305c095@redhat.com>
 <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 21 May 2025 12:06:57 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Salil, Gavin, and folks,
>=20
> On 5/20/25 21:22, Gavin Shan wrote:
> > Hi Salil,
> >=20
> > A kindly ping. vCPU hotplug is an important feature and You has put so =
much
> > energies and amazing efforts to enable the feature from QEMU side, but =
it
> > seems it has been stuck recently. I received many messages from Redhat
> > internal and external to ask if vCPU hotplug has been supported on aarc=
h64
> > in the past. So I'm heading up to check if you have bandwidth to contin=
ue
> > the effort, any kinds of helps are needed, especially from me. =20
>=20
> You can count on me as well, Salil. I'm definitely in a better position n=
ow
> to help you with the technical review of the series, and I can also weigh=
 in
> to help resolve any remaining issues so we can finally get it merged. Don=
't give up! :)
>=20
> My suggestion: go ahead and post what you have now. Just highlight the ma=
in
> points of objection raised in the last review that still need to be addre=
ssed.
>=20
>=20
> > Besides, I'm reluctantly to ask if you're fine for some body else to pi=
ck this
> > up and continue the effort. The credits for all the contributors (Keqia=
n Zhu,
> > Jean Philippe, Miguel Luis and you) will be kept. =20
>=20
> I don=E2=80=99t want to speak for others, but in my view, Salil should id=
eally be the
> one to complete this work =E2=80=94 as you said, he=E2=80=99s already inv=
ested a great deal of
> time and energy into it.
>=20
> It would be tremendously helpful if maintainers could support Salil in br=
inging
> this to completion, kindly guiding him toward the path to get it finalize=
d.

=46rom what I recall, series was stuck in variations the same thing with not =
much
progress towards addressing feedback.

I'd repeat key points I'd like to be addressed:

 1. series tries to reuse hotplug interface,
    however due to lack of such thing in ARM world and unwillingness from A=
RM to spec it out,
    the series hacks around by creating VCPUs half the way, and then juggle
    with it during plug/unplug cycle.
    My take on it, if ARM is not willing to invest in creating CPU hotplug =
specs and support
    that, neither should do QEMU.

    What ARM has to offer today is, standby CPUs with dynamic power on/off =
feature.
    And that's what QEMU could offer as well. That is not exactly the same =
as x86 impl.
    but it would allow ARM VMs to scale dynamically during runtime, which i=
s one of
    the main goals of CPU hotplug in virt env.

    What QEMU lacks in this area is QAPI/monitor interface to turn off/on d=
evices.
    That's what we should try to implement for standby ARM vcpus.
    It's also a generic enough interface so we can reuse it in PCI subsyste=
m as well.=20

 2. It was claimed that creating VCPUs half way, serves another goal as wel=
l.
    That is boot speed parity with x86, as creating ARM vcpus is expensive
    compared to x86 ones.
    For one, it's forcing undesired design choices on hotplug project, henc=
e delaying it.

    Having ARM guest start as fast as x86 is a good thing and I'm all for i=
t,
    however abusing CPU hotplug for that is not something I'd like to suppo=
rt.

    As it has been implemented so far, series makes ARM VMs boot faster, bu=
t in
    reality, slow vcpu creation is not gone, it's merely moved to a later t=
ime
    (hotplug time).

    Comparing raw numbers here to x86 is also not very fair to ARM (given f=
aster
    hardware and how much time x86 have had to mature and be polished).
    I'd suggest dropping this requirement from CPU hotplug series scope as
    not related .

    My take on this requirement, is that slow ARM VCPU creation should be a=
ddressed
    as separate series focusing on reducing VCPU creation overhead, instead=
 of masking it
    out with hotplug.
    In one of my reviews, I've pointed at low hanging fruits on QEMU side t=
hat can help
    to reduce VCPU creation time. There are probably much more places where=
 it
    can be improved.

In nutshell:
   my ask is drop hotplug idea (from QEMU/hw point of view) and try impleme=
nting
   power on/off feature for ARM CPUs (that's what has been implemented on g=
uest
   kernel side after all).

   If physical CPU hotplug is what is really desired, convince ARM to imple=
ment it
   in kernel, and then QEMU impl. would look very similar to x86&others we
   already have in tree.

>=20
> Cheers,
> Gustavo
>=20
> > Salil, looking forward to hearing from you :-)
> >=20
> > Thanks,
> > Gavin
> >=20
> > On 10/15/24 7:59 PM, Salil Mehta wrote: =20
> >> PROLOGUE
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> To assist in review and set the right expectations from this RFC, plea=
se first
> >> read the sections *APPENDED AT THE END* of this cover letter:
> >>
> >> 1. Important *DISCLAIMER* [Section (X)]
> >> 2. Work presented at KVMForum Conference (slides available) [Section (=
V)F]
> >> 3. Organization of patches [Section (XI)]
> >> 4. References [Section (XII)]
> >> 5. Detailed TODO list of leftover work or work-in-progress [Section (I=
X)]
> >> 6. Repositories [Section (VII)]
> >>
> >> The architecture-agnostic patch set was merged into the mainline durin=
g the
> >> last Qemu cycle. This patch is specific to the ARM architecture and is
> >> compatible with the latest Qemu mainline version.
> >>
> >> SECTIONS [I - XIII] are as follows:
> >>
> >> (I) Summary of `Recent` Key Changes [details in last section (XIV)]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> RFC V4 -> RFC V5
> >>
> >> 1. Dropped patches [PATCH RFC V4 {2,12,19}/33]
> >> 2. Separated architecture agnostic ACPI/migration changes in separate =
patch-set.
> >> =C2=A0=C2=A0=C2=A0 Link: https://lore.kernel.org/qemu-devel/2024101419=
2205.253479-1-salil.mehta@huawei.com/#t
> >> 3. Dropped qemu{present,enabled}_cpu() APIs.
> >> 4. Dropped the `CPUState::disabled` flag
> >>
> >> RFC V3 -> RFC V4
> >>
> >> 1. Fixes for TCG. It has been lightly tested but seem to work!
> >> 2. Migration related fixes [Both KVM & TCG].
> >> 3. Introduction of `gicc_accessble` flag for GICv3 CPU interface
> >> 4. Addressed comments from Gavin Shan (RedHat), Nicholas Piggin (IBM),
> >> =C2=A0=C2=A0=C2=A0 Alex Benn=C3=A9e's & Gustavo Romero (Linaro)
> >> 5. Misc fixes and refatoring.
> >>
> >>
> >> (II) Summary
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This patch set introduces virtual CPU hotplug support for the ARMv8 ar=
chitecture
> >> in QEMU. The idea is to be able to hotplug and hot-unplug vCPUs while =
the guest
> >> VM is running, without requiring a reboot. This does *not* make any as=
sumptions
> >> about the physical CPU hotplug availability within the host system but=
 rather
> >> tries to solve the problem at the virtualizer/QEMU layer. It introduce=
s ACPI CPU
> >> hotplug hooks and event handling to interface with the guest kernel, a=
nd code to
> >> initialize, plug, and unplug CPUs. No changes are required within the =
host
> >> kernel/KVM except the support of hypercall exit handling in the user-s=
pace/Qemu,
> >> which has recently been added to the kernel. Corresponding guest kerne=
l changes
> >> were posted on the mailing list [3] [4] by James Morse (ARM) and have =
been
> >> recently accepted and are now part of v6.11 mainline kernel.
> >>
> >> (III) Motivation
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This allows scaling the guest VM compute capacity on-demand, which wou=
ld be
> >> useful for the following example scenarios:
> >>
> >> 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestr=
ation
> >> =C2=A0=C2=A0=C2=A0 framework that could adjust resource requests (CPU =
and Mem requests) for
> >> =C2=A0=C2=A0=C2=A0 the containers in a pod, based on usage.
> >> 2. Pay-as-you-grow Business Model: Infrastructure providers could allo=
cate and
> >> =C2=A0=C2=A0=C2=A0 restrict the total number of compute resources avai=
lable to the guest VM
> >> =C2=A0=C2=A0=C2=A0 according to the SLA (Service Level Agreement). VM =
owners could request more
> >> =C2=A0=C2=A0=C2=A0 compute to be hot-plugged for some cost.
> >>
> >> For example, Kata Container VM starts with a minimum amount of resourc=
es (i.e.,
> >> hotplug everything approach). Why?
> >>
> >> 1. Allowing faster *boot time* and
> >> 2. Reduction in *memory footprint*
> >>
> >> Kata Container VM can boot with just 1 vCPU, and then later more vCPUs=
 can be
> >> hot-plugged as needed. Reducing the number of vCPUs in VM can in gener=
al
> >> reduce the boot times of the VM esepcially when number of cores are in=
creasing.
> >>
> >> **[UPCOMING]**
> >> I've been working on enhancing the boot times of ARM/VMs using the hot=
plug
> >> infrastructure proposed in this patch set. Stay tuned for upcoming pat=
ches that
> >> leverage this infrastructure to significantly reduce boot times for
> >> *non-hotplug* scenarios. Expect these updates in the next few weeks!
> >>
> >> (IV) Terminology
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This i=
ncludes
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 any cold-booted CPUs plus any=
 CPUs that could be later
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hot-plugged.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Qemu parameter (-smp maxcpu=
s=3DN)
> >> (*) Present CPUs:=C2=A0 Possible CPUs that are ACPI 'present'. These m=
ight or might
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not be ACPI 'enabled'.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Present vCPUs =3D Possible =
vCPUs (Always on ARM Arch)
> >> (*) Enabled CPUs:=C2=A0 Possible CPUs that are ACPI 'present' and 'ena=
bled' and can
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now be =E2=80=98onlined=E2=80=
=99 (PSCI) for use by the Guest Kernel. All cold-
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 booted vCPUs are ACPI 'enable=
d' at boot. Later, using
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_add, more vCPUs can be=
 hotplugged and made ACPI
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'enabled'.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Qemu parameter (-smp cpus=
=3DN). Can be used to specify some
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cold-boot=
ed vCPUs during VM init. Some can be added using the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-device'=
 option.
> >>
> >> (V) Constraints Due to ARMv8 CPU Architecture [+] Other Impediments
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> A. Physical Limitation to Support CPU Hotplug: (Architectural Constrai=
nt)
> >> =C2=A0=C2=A0=C2=A0 1. ARMv8 CPU architecture does not support the conc=
ept of the physical CPU
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hotplug.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. There are many per-CPU compone=
nts like PMU, SVE, MTE, Arch timers, etc.,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 whose behavior =
needs to be clearly defined when the CPU is
> >> =C2=A0=C2=A0=C2=A0=C2=A0 hot(un)plugged. There is no specification for=
 this.
> >>
> >> =C2=A0=C2=A0=C2=A0 2. Other ARM components like GIC, etc., have not be=
en designed to realize
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical CPU hotplug capability a=
s of now. For example,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Every physical CPU has a uniqu=
e GICC (GIC CPU Interface) by construct.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Architecture do=
es not specify what CPU hot(un)plug would mean in
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context to any =
of these.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. CPUs/GICC are physically conne=
cted to unique GICR (GIC Redistributor).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIC Redistribut=
ors are always part of the always-on power domain. Hence,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 they cannot be =
powered off as per specification.
> >>
> >> B. Impediments in Firmware/ACPI (Architectural Constraint)
> >>
> >> =C2=A0=C2=A0=C2=A0 1. Firmware has to expose GICC, GICR, and other per=
-CPU features like PMU,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SVE, MTE, Arch Timers, etc., to t=
he OS. Due to the architectural constraint
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stated in section A1(a), all inte=
rrupt controller structures of
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MADT describing GIC CPU Interface=
s and the GIC Redistributors MUST be
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 presented by firmware to the OSPM=
 during boot time.
> >> =C2=A0=C2=A0=C2=A0 2. Architectures that support CPU hotplug can evalu=
ate the ACPI _MAT method to
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get this kind of information from=
 the firmware even after boot, and the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OSPM has the capability to proces=
s these. ARM kernel uses information in MADT
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt controller structures t=
o identify the number of present CPUs during
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot and hence does not allow to =
change these after boot. The number of
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 present CPUs cannot be changed. I=
t is an architectural constraint!
> >>
> >> C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Co=
nstraint)
> >>
> >> =C2=A0=C2=A0=C2=A0 1. KVM VGIC:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Sizing of various VGIC resourc=
es like memory regions, etc., related to
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the redistribut=
or happens only once and is fixed at the VM init time
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and cannot be c=
hanged later after initialization has happened.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM statically =
configures these resources based on the number of vCPUs
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and the number/=
size of redistributor ranges.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. Association between vCPU and i=
ts VGIC redistributor is fixed at the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM init time wi=
thin the KVM, i.e., when redistributor iodevs gets
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 registered. VGI=
C does not allow to setup/change this association
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after VM initia=
lization has happened. Physically, every CPU/GICC is
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uniquely connec=
ted with its redistributor, and there is no
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 architectural w=
ay to set this up.
> >> =C2=A0=C2=A0=C2=A0 2. KVM vCPUs:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Lack of specification means de=
struction of KVM vCPUs does not exist as
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 there is no ref=
erence to tell what to do with other per-vCPU
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 components like=
 redistributors, arch timer, etc.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. In fact, KVM does not implemen=
t the destruction of vCPUs for any
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 architecture. T=
his is independent of whether the architecture
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 actually suppor=
ts CPU Hotplug feature. For example, even for x86 KVM
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 does not implem=
ent the destruction of vCPUs.
> >>
> >> D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints=
->Arch)
> >>
> >> =C2=A0=C2=A0=C2=A0 1. Qemu CPU Objects MUST be created to initialize a=
ll the Host KVM vCPUs to
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overcome the KVM constraint. KVM =
vCPUs are created and initialized when Qemu
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU Objects are realized. But kee=
ping the QOM CPU objects realized for
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'yet-to-be-plugged' vCPUs can cre=
ate problems when these new vCPUs shall
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be plugged using device_add and a=
 new QOM CPU object shall be created.
> >> =C2=A0=C2=A0=C2=A0 2. GICV3State and GICV3CPUState objects MUST be siz=
ed over *possible vCPUs*
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 during VM init time while QOM GIC=
V3 Object is realized. This is because
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM VGIC can only be initialized =
once during init time. But every
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GICV3CPUState has an associated Q=
OM CPU Object. Later might correspond to
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vCPU which are 'yet-to-be-plugged=
' (unplugged at init).
> >> =C2=A0=C2=A0=C2=A0 3. How should new QOM CPU objects be connected back=
 to the GICV3CPUState
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 objects and disconnected from it =
in case the CPU is being hot(un)plugged?
> >> =C2=A0=C2=A0=C2=A0 4. How should 'unplugged' or 'yet-to-be-plugged' vC=
PUs be represented in the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOM for which KVM vCPU already ex=
ists? For example, whether to keep,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. No QOM CPU objects Or
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. Unrealized CPU Objects
> >> =C2=A0=C2=A0=C2=A0 5. How should vCPU state be exposed via ACPI to the=
 Guest? Especially for
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the unplugged/yet-to-be-plugged v=
CPUs whose CPU objects might not exist
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 within the QOM but the Guest alwa=
ys expects all possible vCPUs to be
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 identified as ACPI *present* duri=
ng boot.
> >> =C2=A0=C2=A0=C2=A0 6. How should Qemu expose GIC CPU interfaces for th=
e unplugged or
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yet-to-be-plugged vCPUs using ACP=
I MADT Table to the Guest?
> >>
> >> E. Summary of Approach ([+] Workarounds to problems in sections A, B, =
C & D)
> >>
> >> =C2=A0=C2=A0=C2=A0 1. At VM Init, pre-create all the possible vCPUs in=
 the Host KVM i.e., even
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for the vCPUs which are yet-to-be=
-plugged in Qemu but keep them in the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 powered-off state.
> >> =C2=A0=C2=A0=C2=A0 2. After the KVM vCPUs have been initialized in the=
 Host, the KVM vCPU
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 objects corresponding to the unpl=
ugged/yet-to-be-plugged vCPUs are parked
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at the existing per-VM "kvm_parke=
d_vcpus" list in Qemu. (similar to x86)
> >> =C2=A0=C2=A0=C2=A0 3. GICV3State and GICV3CPUState objects are sized o=
ver possible vCPUs during
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM init time i.e., when Qemu GIC =
is realized. This, in turn, sizes KVM VGIC
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resources like memory regions, et=
c., related to the redistributors with the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 number of possible KVM vCPUs. Thi=
s never changes after VM has initialized.
> >> =C2=A0=C2=A0=C2=A0 4. Qemu CPU objects corresponding to unplugged/yet-=
to-be-plugged vCPUs are
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 released post Host KVM CPU and GI=
C/VGIC initialization.
> >> =C2=A0=C2=A0=C2=A0 5. Build ACPI MADT Table with the following updates:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Number of GIC CPU interface en=
tries (=3Dpossible vCPUs)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. Present Boot vCPU as MADT.GICC=
.Enabled=3D1 (Not hot[un]pluggable)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c. Present hot(un)pluggable vCPUs=
 as MADT.GICC.online-capable=3D1
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - MADT.GICC.Ena=
bled=3D0 (Mutually exclusive) [6][7]
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - vCPU can be ACPI enabled+onlined after Gues=
t boots (Firmware Policy)
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - Some issues with above (details in later se=
ctions)
> >> =C2=A0=C2=A0=C2=A0 6. Expose below ACPI Status to Guest kernel:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Always _STA.Present=3D1 (all p=
ossible vCPUs)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. _STA.Enabled=3D1 (plugged vCPU=
s)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c. _STA.Enabled=3D0 (unplugged vC=
PUs)
> >> =C2=A0=C2=A0=C2=A0 7. vCPU hotplug *realizes* new QOM CPU object. The =
following happens:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Realizes, initializes QOM CPU =
Object & spawns Qemu vCPU thread.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. Unparks the existing KVM vCPU =
("kvm_parked_vcpus" list).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Attaches to Q=
OM CPU object.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c. Reinitializes KVM vCPU in the =
Host.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Resets the co=
re and sys regs, sets defaults, etc.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d. Runs KVM vCPU (created with "s=
tart-powered-off").
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - vCPU thread sleeps (waits for vCPU reset vi=
a PSCI).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e. Updates Qemu GIC.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Wires back IR=
Qs related to this vCPU.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - GICV3CPUState=
 association with QOM CPU Object.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f. Updates [6] ACPI _STA.Enabled=
=3D1.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g. Notifies Guest about the new v=
CPU (via ACPI GED interface).
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - Guest checks _STA.Enabled=3D1.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - Guest adds processor (registers CPU with LD=
M) [3].
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h. Plugs the QOM CPU object in th=
e slot.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - slot-number =
=3D cpu-index {socket, cluster, core, thread}.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i. Guest online's vCPU (CPU_ON PS=
CI call over HVC/SMC).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - KVM exits HVC=
/SMC Hypercall [5] to Qemu (Policy Check).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Qemu powers-o=
n KVM vCPU in the Host.
> >> =C2=A0=C2=A0=C2=A0 8. vCPU hot-unplug *unrealizes* QOM CPU Object. The=
 following happens:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. Notifies Guest (via ACPI GED i=
nterface) vCPU hot-unplug event.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Guest offline=
's vCPU (CPU_OFF PSCI call over HVC/SMC).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. KVM exits HVC/SMC Hypercall [5=
] to Qemu (Policy Check).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Qemu powers-o=
ff the KVM vCPU in the Host.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c. Guest signals *Eject* vCPU to =
Qemu.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d. Qemu updates [6] ACPI _STA.Ena=
bled=3D0.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e. Updates GIC.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Un-wires IRQs=
 related to this vCPU.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - GICV3CPUState=
 association with new QOM CPU Object is updated.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f. Unplugs the vCPU.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - Removes from slot.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Parks KVM vCP=
U ("kvm_parked_vcpus" list).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Unrealizes QO=
M CPU Object & joins back Qemu vCPU thread.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 - Destroys QOM CPU object.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g. Guest checks ACPI _STA.Enabled=
=3D0.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Removes proce=
ssor (unregisters CPU with LDM) [3].
> >>
> >> F. Work Presented at KVM Forum Conferences:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Details of the above work have been presented at KVMForum2020 and KVMF=
orum2023
> >> conferences. Slides & video are available at the links below:
> >> a. KVMForum 2023
> >> =C2=A0=C2=A0=C2=A0 - Challenges Revisited in Supporting Virt CPU Hotpl=
ug on architectures that don't Support CPU Hotplug (like ARM64).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://kvm-forum.qemu.org/2023/KVM-for=
um-cpu-hotplug_7OJ1YyJ.pdf
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://kvm-forum.qemu.org/2023/Challen=
ges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://www.youtube.com/watch?v=3Dhyrw4=
j2D6I0&t=3D23970s
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://kvm-forum.qemu.org/2023/talk/9S=
MPDQ/
> >> b. KVMForum 2020
> >> =C2=A0=C2=A0=C2=A0 - Challenges in Supporting Virtual CPU Hotplug on S=
oC Based Systems (like ARM64) - Salil Mehta, Huawei.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://kvmforum2020.sched.com/event/eE=
4m
> >>
> >> (VI) Commands Used
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> A. Qemu launch commands to init the machine:
> >>
> >> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \
> >> -cpu host -smp cpus=3D4,maxcpus=3D6 \
> >> -m 300M \
> >> -kernel Image \
> >> -initrd rootfs.cpio.gz \
> >> -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2 =
acpi=3Dforce" \
> >> -nographic \
> >> -bios QEMU_EFI.fd \
> >>
> >> B. Hot-(un)plug related commands:
> >>
> >> # Hotplug a host vCPU (accel=3Dkvm):
> >> $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4
> >>
> >> # Hotplug a vCPU (accel=3Dtcg):
> >> $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4
> >>
> >> # Delete the vCPU:
> >> $ device_del core4
> >>
> >> Sample output on guest after boot:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/possible
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-5
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/present
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-5
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/enabled
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-3
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/online
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-1
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/offline
> >> =C2=A0=C2=A0=C2=A0=C2=A0 2-
> >>
> >> Sample output on guest after hotplug of vCPU=3D4:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/possible
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-5
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/present
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-5
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/enabled
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-4
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/online
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0-1,4
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ cat /sys/devices/system/cpu/offline
> >> =C2=A0=C2=A0=C2=A0=C2=A0 2-3,5
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Note: vCPU=3D4 was explicitly 'onlined' after=
 hot-plug
> >> =C2=A0=C2=A0=C2=A0=C2=A0 $ echo 1 > /sys/devices/system/cpu/cpu4/online
> >>
> >> (VII) Latest Repository
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> (*) Latest Qemu RFC V5 (Architecture Specific) patch set:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/salil-mehta/qemu.git virt-=
cpuhp-armv8/rfc-v5
> >> (*) Latest Architecture Agnostic ACPI changes patch-set:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/2024101419=
2205.253479-1-salil.mehta@huawei.com/#t
> >> (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/salil-mehta/qemu.git virt-=
cpuhp-armv8/rfc-{v1,v2,v3,v4}
> >> (*) `Accepted` Qemu Architecture Agnostic patch is present here:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/salil-mehta/qemu/commits/v=
irt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/
> >> (*) All Kernel changes are already part of mainline v6.11
> >> (*) Original Guest Kernel changes (by James Morse, ARM) are available =
here:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/g=
it/morse/linux.git virtual_cpu_hotplug/rfc/v2
> >>
> >>
> >> (VIII) KNOWN ISSUES
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> 1. HVF and qtest are not supported yet.
> >> 2. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-ca=
pable are
> >> =C2=A0=C2=A0=C2=A0 mutually exclusive, i.e., as per the change [6], a =
vCPU cannot be both
> >> =C2=A0=C2=A0=C2=A0 GICC.Enabled and GICC.online-capable. This means:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ Link: https://bugzilla.tianocor=
e.org/show_bug.cgi?id=3D3706 ]
> >> =C2=A0=C2=A0=C2=A0 a. If we have to support hot-unplug of the cold-boo=
ted vCPUs, then these MUST
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be specified as GICC.online-capab=
le in the MADT Table during boot by the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware/Qemu. But this requireme=
nt conflicts with the requirement to
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support new Qemu changes with leg=
acy OS that don't understand
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MADT.GICC.online-capable Bit. Leg=
acy OS during boot time will ignore this
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit, and hence these vCPUs will n=
ot appear on such OS. This is unexpected
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 behavior.
> >> =C2=A0=C2=A0=C2=A0 b. In case we decide to specify vCPUs as MADT.GICC.=
Enabled and try to unplug
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 these cold-booted vCPUs from OS (=
which in actuality should be blocked by
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 returning error at Qemu), then fe=
atures like 'kexec' will break.
> >> =C2=A0=C2=A0=C2=A0 c. As I understand, removal of the cold-booted vCPU=
s is a required feature
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and x86 world allows it.
> >> =C2=A0=C2=A0=C2=A0 d. Hence, either we need a specification change to =
make the MADT.GICC.Enabled
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and MADT.GICC.online-capable Bits=
 NOT mutually exclusive or NOT support
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the removal of cold-booted vCPUs.=
 In the latter case, a check can be introduced
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to bar the users from unplugging =
vCPUs, which were cold-booted, using QMP
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commands. (Needs discussion!)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Please check the patch part of th=
is patch set:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hw/arm/virt: Expose cold-booted =
CPUs as MADT GICC Enabled].
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NOTE: This is definitely not a bl=
ocker!
> >>
> >>
> >> (IX) THINGS TO DO
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> 1. TCG is now in working state but would need extensive testing to rol=
l out
> >> =C2=A0=C2=A0=C2=A0 any corner cases. Any help related to this will be =
appreciated!
> >> 2. Comprehensive Testing is in progress. (Positive feedback from Oracl=
e & Ampere)
> >> 3. Qemu Documentation (.rst) needs to be updated.
> >> 4. The `is_enabled` and `is_present` ACPI states are now common to all=
 architectures
> >> =C2=A0=C2=A0=C2=A0 and should work seemlessely but needs thorough test=
ing with other architectures.
> >> 5. Migration has been lightly tested but has been found working.
> >> 6. A missing check for PMU state for the hotplugged vCPUs (Reported by=
: Gavin Shan)
> >> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/28f3107f-0267-41=
12-b0ca-da59df2968ae@redhat.com/
> >> 7. Need help in Testing with ARM hardware extensions like SVE/SME
> >>
> >>
> >>
> >> Best regards,
> >> Salil.
> >>
> >> (X) DISCLAIMER
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This work is an attempt to present a proof-of-concept of the ARM64 vCP=
U hotplug
> >> implementation to the community. This is *not* production-level code a=
nd might
> >> have bugs. Comprehensive testing is being done on HiSilicon Kunpeng920=
 SoC,
> >> Oracle, and Ampere servers. We are nearing stable code and a non-RFC
> >> version shall be floated soon.
> >>
> >> This work is *mostly* in the lines of the discussions that have happen=
ed in the
> >> previous years [see refs below] across different channels like the mai=
ling list,
> >> Linaro Open Discussions platform, and various conferences like KVMForu=
m, etc. This
> >> RFC is being used as a way to verify the idea mentioned in this cover =
letter and
> >> to get community views. Once this has been agreed upon, a formal patch=
 shall be
> >> posted to the mailing list for review.
> >>
> >> [The concept being presented has been found to work!]
> >>
> >> (XI) ORGANIZATION OF PATCHES
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> A. ARM Architecture *specific* patches:
> >>
> >> =C2=A0=C2=A0=C2=A0 [Patch 1-8, 11, 12, 30] logic required during machi=
ne init.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Some validation checks.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Introduces core-id property and some util=
 functions required later.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Logic to pre-create vCPUs.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Introduction of the GICv3 CPU Interface `=
accessibility` interface
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) GIC initialization pre-sized with possibl=
e vCPUs.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Some refactoring to have common hot and c=
old plug logic together.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Release of disabled QOM CPU objects in po=
st_cpu_init().
> >> =C2=A0=C2=A0=C2=A0 [Patch 9-10, 13-15] logic related to ACPI at machin=
e init time.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Changes required to Enable ACPI for CPU h=
otplug.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Initialization of ACPI GED framework to c=
ater to CPU Hotplug Events.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) ACPI DSDT, MADT/MAT changes.
> >> =C2=A0=C2=A0=C2=A0 [Patch 17-29] logic required during vCPU hot-(un)pl=
ug.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Basic framework changes to support vCPU h=
ot-(un)plug.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) ACPI GED changes for hot-(un)plug hooks.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Wire-unwire the IRQs.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) GIC notification logic on receiving vCPU =
hot(un)plug event.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) ARMCPU unrealize logic.
> >> =C2=A0=C2=A0=C2=A0=C2=A0 (*) Handling of SMCC Hypercall Exits by KVM t=
o Qemu.
> >> =C2=A0=C2=A0=C2=A0 [Patch 33] Disable unplug of cold-booted vCPUs
> >>
> >> (XII) REFERENCES
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.me=
hta@huawei.com/
> >> [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-sa=
lil.mehta@huawei.com/
> >> [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@a=
rm.com/
> >> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.=
com/
> >> [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@=
linux.dev/
> >> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706
> >> [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model=
.html#gic-cpu-interface-gicc-structure
> >> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> >> [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalp=
odautoscaler
> >> [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-aut=
oscaler.html
> >> [11] https://lkml.org/lkml/2019/7/10/235
> >> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.h=
tml
> >> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.ht=
ml
> >> [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions=
@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> >> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.=
html
> >> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.ht=
ml
> >> [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions=
@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> >> [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philipp=
e@linaro.org/
> >> [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm=
.com/
> >> [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Mode=
l.html#gicc-cpu-interface-flags
> >> [21] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.m=
ehta@huawei.com/
> >> [22] https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.=
mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
> >> [23] RFC V3: https://lore.kernel.org/qemu-devel/20240613233639.202896-=
1-salil.mehta@huawei.com/#t
> >>
> >> (XIII) ACKNOWLEDGEMENTS
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> I would like to thank the following people for various discussions wit=
h me over different channels during development:
> >>
> >> Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will =
Deacon (Google),
> >> Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi =
(Linaro),
> >> Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),
> >> Igor Mamedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),
> >> Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),
> >> Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum =
(Huawei),
> >> Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),
> >> Zengtao/Prime (Huawei), Nicholas Piggin (IBM) and all those whom I hav=
e missed!
> >>
> >> Many thanks to the following people for their current or past contribu=
tions:
> >>
> >> 1. James Morse (ARM)
> >> =C2=A0=C2=A0=C2=A0 (Current Kernel part of vCPU Hotplug Support on AAR=
CH64)
> >> 2. Jean-Philippe Brucker (Linaro)
> >> =C2=A0=C2=A0=C2=A0 (Prototyped one of the earlier PSCI-based POC [17][=
18] based on RFC V1)
> >> 3. Keqian Zhu (Huawei)
> >> =C2=A0=C2=A0=C2=A0 (Co-developed Qemu prototype)
> >> 4. Xiongfeng Wang (Huawei)
> >> =C2=A0=C2=A0=C2=A0 (Co-developed an earlier kernel prototype with me)
> >> 5. Vishnu Pajjuri (Ampere)
> >> =C2=A0=C2=A0=C2=A0 (Verification on Ampere ARM64 Platforms + fixes)
> >> 6. Miguel Luis (Oracle)
> >> =C2=A0=C2=A0=C2=A0 (Verification on Oracle ARM64 Platforms + fixes)
> >> 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
> >> =C2=A0=C2=A0=C2=A0 (Helping in upstreaming James Morse's Kernel patche=
s).
> >>
> >> (XIV) Change Log:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> RFC V4 -> RFC V5:
> >> -----------------
> >> 1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* =
status ACPI *persistent*"
> >> =C2=A0=C2=A0=C2=A0 - Seperated the architecture agnostic ACPI changes =
required to support vCPU Hotplug
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link: https://lore.kernel.org/qemu-deve=
l/20241014192205.253479-1-salil.mehta@huawei.com/#t
> >> 2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility fo=
r possible vCPUs"
> >> =C2=A0=C2=A0=C2=A0 - Dropped qemu{present,enabled}_cpu() APIs. Comment=
ed by Gavin (Redhat), Miguel(Oracle), Igor(Redhat)
> >> 3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH=
 RFC V4 01/33]
> >> 3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::n=
um_smp_cpus` flag
> >> =C2=A0=C2=A0=C2=A0 - All `GICv3CPUState' between [num_smp_cpus,num_cpu=
s) are marked as 'inaccessible` during gicv3_common_realize()
> >> =C2=A0=C2=A0=C2=A0 - qemu_enabled_cpu() not required - removed!
> >> =C2=A0=C2=A0=C2=A0 - removed usage of `CPUState::disabled` from virt.c=
 and hw/cpu64.c
> >> 4. Removed virt_cpu_properties() and introduced property `mp-affinity`=
 get accessor
> >> 5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before *d=
isabled* vCPU Objects are destroyed"
> >>
> >> RFC V3 -> RFC V4:
> >> -----------------
> >> 1. Addressed Nicholas Piggin's (IBM) comments
> >> =C2=A0=C2=A0=C2=A0 - Moved qemu_get_cpu_archid() as a ACPI helper inli=
ne acpi/cpu.h
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/D2GF=
CLH11HGJ.1IJGANHQ9ZQRL@gmail.com/
> >> =C2=A0=C2=A0=C2=A0 - Introduced new macro CPU_FOREACH_POSSIBLE() in [P=
ATCH 12/33]
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/D2GF=
9A9AJO02.1G1G8UEXA5AOD@gmail.com/
> >> =C2=A0=C2=A0=C2=A0 - Converted CPUState::acpi_persistent into Property=
. Improved the cover note
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/D2H6=
2RK48KT7.2BTQEZUOEGG4L@gmail.com/
> >> =C2=A0=C2=A0=C2=A0 - Fixed teh cover note of the[PATCH ] and clearly m=
entioned about KVMParking
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/D2GF=
OGQC3HYO.2LKOV306JIU98@gmail.com/
> >> 2. Addressed Gavin Shan's (RedHat) comments:
> >> =C2=A0=C2=A0=C2=A0 - Introduced the ARM Extensions check. [Looks like =
I missed the PMU check :( ]
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/28f3=
107f-0267-4112-b0ca-da59df2968ae@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Moved create_gpio() along with create_ged()
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/143a=
d7d2-8f45-4428-bed3-891203a49029@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Improved the logic of the GIC creation and initia=
lization
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/9b75=
82f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Removed redundant !dev->realized checks in cpu_ho=
tunplug(_request)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/64e9=
feaa-8df2-4108-9e73-c72517fb074a@redhat.com/
> >> 3. Addresses Alex Benn=C3=A9e's + Gustavo Romero (Linaro) comments
> >> =C2=A0=C2=A0=C2=A0 - Fixed the TCG support and now it works for all th=
e cases including migration.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/87bk=
1b3azm.fsf@draig.linaro.org/
> >> =C2=A0=C2=A0=C2=A0 - Fixed the cpu_address_space_destroy() compilation=
 failuer in user-mode
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/87v8=
00wkb1.fsf@draig.linaro.org/
> >> 4. Fixed crash in .post_gicv3() during migration with asymmetrically *=
enabled*
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vCPUs at destination VM
> >>
> >> RFC V2 -> RFC V3:
> >> -----------------
> >> 1. Miscellaneous:
> >> =C2=A0=C2=A0=C2=A0 - Split the RFC V2 into arch-agnostic and arch-spec=
ific patch sets.
> >> 2. Addressed Gavin Shan's (RedHat) comments:
> >> =C2=A0=C2=A0=C2=A0 - Made CPU property accessors inline.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/6cd2=
8639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37,=
 22/37].
> >> =C2=A0=C2=A0=C2=A0 - Dropped the patch as it was not required after in=
it logic was refactored.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/4fb2=
eef9-6742-1eeb-721a-b3db04b1be97@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Fixed the range check for the core during vCPU Pl=
ug.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/1c5f=
a24c-6bf3-750f-4f22-087e4a9311af@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Added has_hotpluggable_vcpus check to make build_=
cpus_aml() conditional.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/8323=
42cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Fixed the states initialization in cpu_hotplug_hw=
_init() to accommodate previous refactoring.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/da5e=
5609-1883-8650-c7d8-6868c7b74f1c@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Fixed typos.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/eb1a=
c571-7844-55e6-15e7-3dd7df21366b@redhat.com/
> >> =C2=A0=C2=A0=C2=A0 - Removed the unnecessary 'goto fail'.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/4d89=
80ac-f402-60d4-fe52-787815af8a7d@redhat.com/#t
> >> =C2=A0=C2=A0=C2=A0 - Added check for hotpluggable vCPUs in the _OSC me=
thod.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/2023=
1017001326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/
> >> 3. Addressed Shaoqin Huang's (Intel) comments:
> >> =C2=A0=C2=A0=C2=A0 - Fixed the compilation break due to the absence of=
 a call to virt_cpu_properties() missing
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 along with its definition.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/3632=
ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com/
> >> 4. Addressed Jonathan Cameron's (Huawei) comments:
> >> =C2=A0=C2=A0=C2=A0 - Gated the 'disabled vcpu message' for GIC version=
 < 3.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/qemu-devel/2024=
0116155911.00004fe1@Huawei.com/
> >>
> >> RFC V1 -> RFC V2:
> >> -----------------
> >> 1. Addressed James Morse's (ARM) requirement as per Linaro Open Discus=
sion:
> >> =C2=A0=C2=A0=C2=A0 - Exposed all possible vCPUs as always ACPI _STA.pr=
esent and available during boot time.
> >> =C2=A0=C2=A0=C2=A0 - Added the _OSC handling as required by James's pa=
tches.
> >> =C2=A0=C2=A0=C2=A0 - Introduction of 'online-capable' bit handling in =
the flag of MADT GICC.
> >> =C2=A0=C2=A0=C2=A0 - SMCC Hypercall Exit handling in Qemu.
> >> 2. Addressed Marc Zyngier's comment:
> >> =C2=A0=C2=A0=C2=A0 - Fixed the note about GIC CPU Interface in the cov=
er letter.
> >> 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis (O=
racle) during testing:
> >> =C2=A0=C2=A0=C2=A0 - Live/Pseudo Migration crashes.
> >> 4. Others:
> >> =C2=A0=C2=A0=C2=A0 - Introduced the concept of persistent vCPU at QOM.
> >> =C2=A0=C2=A0=C2=A0 - Introduced wrapper APIs of present, possible, and=
 persistent.
> >> =C2=A0=C2=A0=C2=A0 - Change at ACPI hotplug H/W init leg accommodating=
 initializing is_present and is_enabled states.
> >> =C2=A0=C2=A0=C2=A0 - Check to avoid unplugging cold-booted vCPUs.
> >> =C2=A0=C2=A0=C2=A0 - Disabled hotplugging with TCG/HVF/QTEST.
> >> =C2=A0=C2=A0=C2=A0 - Introduced CPU Topology, {socket, cluster, core, =
thread}-id property.
> >> =C2=A0=C2=A0=C2=A0 - Extract virt CPU properties as a common virt_vcpu=
_properties() function.
> >>
> >> Author Salil Mehta (1):
> >> =C2=A0=C2=A0 target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM d=
uring
> >> =C2=A0=C2=A0=C2=A0=C2=A0 PSCI_CPU_{ON,OFF}
> >>
> >> Jean-Philippe Brucker (2):
> >> =C2=A0=C2=A0 hw/acpi: Make _MAT method optional
> >> =C2=A0=C2=A0 target/arm/kvm: Write vCPU's state back to KVM on cold-re=
set
> >>
> >> Miguel Luis (1):
> >> =C2=A0=C2=A0 tcg/mttcg: Introduce MTTCG thread unregistration leg
> >>
> >> Salil Mehta (26):
> >> =C2=A0=C2=A0 arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,=
thread}-id
> >> =C2=A0=C2=A0=C2=A0=C2=A0 property
> >> =C2=A0=C2=A0 hw/arm/virt: Disable vCPU hotplug for *unsupported* Accel=
 or GIC Type
> >> =C2=A0=C2=A0 hw/arm/virt: Move setting of common vCPU properties in a =
function
> >> =C2=A0=C2=A0 arm/virt,target/arm: Machine init time change common to v=
CPU
> >> =C2=A0=C2=A0=C2=A0=C2=A0 {cold|hot}-plug
> >> =C2=A0=C2=A0 arm/virt,kvm: Pre-create KVM vCPUs for all unplugged QOM =
vCPUs
> >> =C2=A0=C2=A0=C2=A0=C2=A0 @machine init
> >> =C2=A0=C2=A0 arm/virt,gicv3: Changes to pre-size GIC with possible vCP=
Us @machine
> >> =C2=A0=C2=A0=C2=A0=C2=A0 init
> >> =C2=A0=C2=A0 arm/virt,gicv3: Introduce GICv3 CPU Interface *accessibil=
ity* flag and
> >> =C2=A0=C2=A0=C2=A0=C2=A0 checks
> >> =C2=A0=C2=A0 hw/intc/arm-gicv3*: Changes required to (re)init the GICv=
3 vCPU
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Interface
> >> =C2=A0=C2=A0 arm/acpi: Enable ACPI support for vCPU hotplug
> >> =C2=A0=C2=A0 arm/virt: Enhance GED framework to handle vCPU hotplug ev=
ents
> >> =C2=A0=C2=A0 arm/virt: Init PMU at host for all possible vCPUs
> >> =C2=A0=C2=A0 arm/virt: Release objects for *disabled* possible vCPUs a=
fter init
> >> =C2=A0=C2=A0 arm/virt/acpi: Update ACPI DSDT Tbl to include CPUs AML w=
ith hotplug
> >> =C2=A0=C2=A0=C2=A0=C2=A0 support
> >> =C2=A0=C2=A0 hw/arm/acpi: MADT Tbl change to size the guest with possi=
ble vCPUs
> >> =C2=A0=C2=A0 target/arm: Force ARM vCPU *present* status ACPI *persist=
ent*
> >> =C2=A0=C2=A0 arm/virt: Add/update basic hot-(un)plug framework
> >> =C2=A0=C2=A0 arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot=
-(un)plug
> >> =C2=A0=C2=A0 hw/arm,gicv3: Changes to notify GICv3 CPU state with vCPU=
 hot-(un)plug
> >> =C2=A0=C2=A0=C2=A0=C2=A0 event
> >> =C2=A0=C2=A0 hw/arm: Changes required for reset and to support next bo=
ot
> >> =C2=A0=C2=A0 arm/virt: Update the guest(via GED) about vCPU hot-(un)pl=
ug events
> >> =C2=A0=C2=A0 target/arm/cpu: Check if hotplugged ARM vCPU's FEAT match=
 existing
> >> =C2=A0=C2=A0 tcg: Update tcg_register_thread() leg to handle region al=
loc for
> >> =C2=A0=C2=A0=C2=A0=C2=A0 hotplugged vCPU
> >> =C2=A0=C2=A0 target/arm: Add support to *unrealize* ARMCPU during vCPU=
 Hot-unplug
> >> =C2=A0=C2=A0 hw/intc/arm_gicv3_common: Add GICv3CPUState 'accessible' =
flag
> >> =C2=A0=C2=A0=C2=A0=C2=A0 migration handling
> >> =C2=A0=C2=A0 hw/intc/arm_gicv3_kvm: Pause all vCPU to ensure locking i=
n KVM of
> >> =C2=A0=C2=A0=C2=A0=C2=A0 resetting vCPU
> >> =C2=A0=C2=A0 hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *Enabl=
ed*
> >>
> >> =C2=A0 accel/tcg/tcg-accel-ops-mttcg.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 3 +-
> >> =C2=A0 accel/tcg/tcg-accel-ops-rr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> >> =C2=A0 cpu-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 +
> >> =C2=A0 hw/acpi/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 9 +-
> >> =C2=A0 hw/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> >> =C2=A0 hw/arm/boot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> >> =C2=A0 hw/arm/virt-acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 69 ++-
> >> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 840 +++++++++++++++++++++++------
> >> =C2=A0 hw/core/gpio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
> >> =C2=A0 hw/intc/arm_gicv3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 hw/intc/arm_gicv3_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 99 +++-
> >> =C2=A0 hw/intc/arm_gicv3_cpuif.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 253 ++++-----
> >> =C2=A0 hw/intc/arm_gicv3_cpuif_common.c=C2=A0=C2=A0 |=C2=A0 13 +
> >> =C2=A0 hw/intc/arm_gicv3_kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 40 +-
> >> =C2=A0 hw/intc/gicv3_internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 include/hw/acpi/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> >> =C2=A0 include/hw/arm/boot.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> >> =C2=A0 include/hw/arm/virt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 64 ++-
> >> =C2=A0 include/hw/core/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +
> >> =C2=A0 include/hw/intc/arm_gicv3_common.h |=C2=A0 61 +++
> >> =C2=A0 include/hw/qdev-core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> >> =C2=A0 include/tcg/startup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> >> =C2=A0 include/tcg/tcg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 system/physmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +-
> >> =C2=A0 target/arm/arm-powerctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +-
> >> =C2=A0 target/arm/cpu-qom.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +-
> >> =C2=A0 target/arm/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 178 +++++-
> >> =C2=A0 target/arm/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> >> =C2=A0 target/arm/cpu64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> >> =C2=A0 target/arm/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> >> =C2=A0 target/arm/helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 +-
> >> =C2=A0 target/arm/internals.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
> >> =C2=A0 target/arm/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 146 ++++-
> >> =C2=A0 target/arm/kvm_arm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 +
> >> =C2=A0 target/arm/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 target/arm/{tcg =3D> }/psci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +
> >> =C2=A0 target/arm/tcg/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 -
> >> =C2=A0 tcg/region.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 14 +
> >> =C2=A0 tcg/tcg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 46 +-
> >> =C2=A0 39 files changed, 1714 insertions(+), 364 deletions(-)
> >> =C2=A0 rename target/arm/{tcg =3D> }/psci.c (97%)
> >> =20
> >  =20
>=20


