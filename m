Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE5DCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qQm-00045N-Dz; Thu, 09 Oct 2025 09:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6qQl-00045E-1G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6qQg-0000eQ-6O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760015489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iva/Nb3cWdPry6GZHRxRFXTiqNI2SHYB4OJ+a5fLZHg=;
 b=JhyoDjh2oVwVd3Zvicm8p+Bj2s9a5K2zylu0b9vvHvE8RJH7ZYx2KNTPcPabaqpl8ipPpk
 mlrGWfKXt4CVqA5l3hC1LrDppGylPoBDgQ3AyNKk18aafwipdiULDPUBgEfGsSUzXyep9y
 mIWVisp/hOFac7T7xPcOFyTliohxiYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Hilj0YITN3ug_uPLouZzcw-1; Thu, 09 Oct 2025 09:11:27 -0400
X-MC-Unique: Hilj0YITN3ug_uPLouZzcw-1
X-Mimecast-MFC-AGG-ID: Hilj0YITN3ug_uPLouZzcw_1760015487
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e38957979so4433365e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015486; x=1760620286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iva/Nb3cWdPry6GZHRxRFXTiqNI2SHYB4OJ+a5fLZHg=;
 b=xCUK4PPLCTz99tr4f71OMQEzk8VIFKhWOATLmYjIOkWAua5ApVGsF01R9p2cPIL3yr
 /se1U2XvJtyI41vLvq52S2eRynTgSmzQ52B1w0GRKN7WhuroAUvtE03PXfxfFJ/uWZy8
 UugCUrDMa/zkVbDJRHN6ibaQOxmNy2tokl5gkedfuIg7c4+IWdLBIvMsnrvU/ryU8knV
 oruVW+bm9NgUE1aHWmZbOYJ40Mecj49KrrqUBB8wEF9VblKaMesgWAYAip/gjDsrTQry
 QCKOWo5n42V3g+3hytBMTYSV2Lmly6mlNa6JHF/Z2Q5GjywhDBXTGK5EBrFa9doRy5z3
 nBcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVHLyUfkOZ532QhFZdqQ699rW1ebiO35vmXyykw3DQKhsKf5Qd8nkY8m38ucT5vDwf9EBWvL5uJDRu@nongnu.org
X-Gm-Message-State: AOJu0Ywz3AgtOe6ErZZjiKF8BV3fULYMHXQ8rWkb0td772WETmE0f8jS
 4VXcOJw/OiSdmWKLGgNiaaH1M75km3ZdUthD8Mn1jfjm5V+gPGlxXFhwgNe4xb57y0uQi5DGPbm
 h1TMtmTMxDVojcvaf7UJzbiYZaiPu2iJWL0NdQ0WsZb2y+IPi99bKUlAc
X-Gm-Gg: ASbGncuyCnnT5FbWg+GHcXXT9Gwo/jojWirM0I+eZfyqBQjVne2HiX9v4hP2oJ3J7Ge
 FNE6DNYq/e+5ozJSHb4qLTumqeKXfr2H36Ow++dy1MKpeLu2W93coE0yP0YzBXBcAqbnsUzXKDx
 6DAYLLE7UD2mvgNJFe5y7uCi4oRJvptISwmJ13LsgQMEJwGAurMrFnzUYzEpMIGG1KHnYmPje2I
 J6lnX672aLWuW54cE20lEgfwtRyDS8zv1vDYZZXXuvYMzrkz0tLHIqlnzlsZAgw3zJ7S59jPzIY
 Zr3Q8Yx8Gl+Wy3g3wTPry7xGV8xB6+VSdL/Z
X-Received: by 2002:a05:600c:4751:b0:46e:72df:a812 with SMTP id
 5b1f17b1804b1-46fa9a8641fmr51398155e9.4.1760015486464; 
 Thu, 09 Oct 2025 06:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeo0tKlGmBISyX/f0JRzgPK/1B66zmUIksEEqx32Vk6ZUMaoF9lI2RcApyl8G/x8OWuS0Q0g==
X-Received: by 2002:a05:600c:4751:b0:46e:72df:a812 with SMTP id
 5b1f17b1804b1-46fa9a8641fmr51397555e9.4.1760015485859; 
 Thu, 09 Oct 2025 06:11:25 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb1e0f019sm27231095e9.10.2025.10.09.06.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 06:11:25 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:11:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>, Karl Heubaum
 <karl.heubaum@oracle.com>, "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, <devel@lists.libvirt.org>
Subject: Re: [PATCH RFC V6 03/24] hw/arm/virt: Clamp 'maxcpus' as-per
 machine's vCPU deferred online-capability
Message-ID: <20251009151123.6741ac61@fedora>
In-Reply-To: <4764573F-D108-40BB-AF23-B4B29E40BEF8@oracle.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-4-salil.mehta@opnsrc.net>
 <4764573F-D108-40BB-AF23-B4B29E40BEF8@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 9 Oct 2025 12:32:15 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Hi Salil,
>=20
> > On 1 Oct 2025, at 01:01, salil.mehta@opnsrc.net wrote:
> >=20
> > From: Salil Mehta <salil.mehta@huawei.com>
> >=20
> > To support a vCPU hot-add=E2=80=93like model on ARM, the virt machine m=
ay be setup with
> > more CPUs than are active at boot. These additional CPUs are fully real=
ized in
> > KVM and listed in ACPI tables from the start, but begin in a disabled s=
tate.
> > They can later be brought online or taken offline under host or platfor=
m policy
> > control. The CPU topology is fixed at VM creation time and cannot change
> > dynamically on ARM. Therefore, we must determine precisely the 'maxcpus=
' value
> > that applies for the full lifetime of the VM.
> >=20
> > On ARM, this deferred online-capable model is only valid if:
> >  - The GIC version is 3 or higher, and
> >  - Each non-boot CPU=E2=80=99s GIC CPU Interface is marked =E2=80=9Conl=
ine-capable=E2=80=9D in its
> >    ACPI GICC structure (UEFI ACPI Specification 6.5, =C2=A75.2.12.14, T=
able 5.37
> >    =E2=80=9CGICC CPU Interface Flags=E2=80=9D), and
> >  - The chosen accelerator supports safe deferred CPU online:
> >      * TCG with multi-threaded TCG (MTTCG) enabled
> >      * KVM (on supported hosts)
> >      * Not HVF or QTest
> >=20
> > This patch sizes the machine=E2=80=99s max-possible CPUs during VM init:
> >  - If all conditions are satisfied, retain the full set of CPUs corresp=
onding
> >    to (`-smp cpus` + `-smp disabledcpus`), allowing the additional (ini=
tially
> >    disabled) CPUs to participate in later policy-driven online.
> >  - Otherwise, clamp the max-possible CPUs to the boot-enabled count
> >    (`-smp disabledcpus=3D0` equivalent) to avoid advertising CPUs the g=
uest can
> >    never use.
> >=20
> > A new MachineClass flag, `has_online_capable_cpus`, records whether the=
 machine
> > supports deferred vCPU online. This is usable by other machine types as=
 well. =20
>=20
>=20
> By the definition of
>=20
>  * @has_hotpluggable_cpus:
>  *    If true, board supports CPUs creation with -device/device_add.
>=20
>  in include/hw/boards.h

It should be fine to rename it to has_pluggable_cpus.

But we should add support to arm/virt for -device/device_add cpu_foo,
to avoid awkward -device-set and mangling of -smp.

device_add in arm/virt case probably should be limited non hotplug usecase.

> seems one could take advantage of MachineClass's has_hotpluggable_cpus va=
riable
> instead of creating a new has_online_capable_cpus one.
> (Again, IMHO =E2=80=98online capable=E2=80=99 is ACPI nomenclature and do=
esn=E2=80=99t need to be brought
> in MachineClass=E2=80=99s)

the issue with has_hotpluggable_cpus might be QMP ABI,
where libvirt migh use it to figure out if certain command are supported.

CCing libvirt to check if that would break something.

>=20
> Variable which would be initialized in machvirt_init on an assignment bas=
ed on
> GIC version and/or wether there's inactive CPUs and proceed from there an=
yways,
> making the default assignment in machine_virt_class_init superfluous.
>=20
> We're at hw/arm/virt and we know these CPUs are administratively power st=
ate
> coordinated so admin_power_state_supported can still be set there in the
> presence of inactive CPUs.
>=20
> Thanks
> Miguel
>=20
> >=20
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> > hw/arm/virt.c       | 84 ++++++++++++++++++++++++++++++---------------
> > include/hw/boards.h |  1 +
> > 2 files changed, 57 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ef6be3660f..76f21bd56a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2168,8 +2168,7 @@ static void machvirt_init(MachineState *machine)
> >     bool has_ged =3D !vmc->no_ged;
> >     unsigned int smp_cpus =3D machine->smp.cpus;
> >     unsigned int max_cpus =3D machine->smp.max_cpus;
> > -
> > -    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> > +    DeviceClass *dc;
> >=20
> >     /*
> >      * In accelerated mode, the memory map is computed earlier in kvm_t=
ype()
> > @@ -2186,7 +2185,7 @@ static void machvirt_init(MachineState *machine)
> >          * we are about to deal with. Once this is done, get rid of
> >          * the object.
> >          */
> > -        cpuobj =3D object_new(possible_cpus->cpus[0].type);
> > +        cpuobj =3D object_new(machine->cpu_type);
> >         armcpu =3D ARM_CPU(cpuobj);
> >=20
> >         pa_bits =3D arm_pamax(armcpu);
> > @@ -2201,6 +2200,57 @@ static void machvirt_init(MachineState *machine)
> >      */
> >     finalize_gic_version(vms);
> >=20
> > +    /*
> > +     * The maximum number of CPUs depends on the GIC version, or on how
> > +     * many redistributors we can fit into the memory map (which in tu=
rn
> > +     * depends on whether this is a GICv3 or v4).
> > +     */
> > +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> > +        virt_max_cpus =3D GIC_NCPU;
> > +    } else {
> > +        virt_max_cpus =3D virt_redist_capacity(vms, VIRT_GIC_REDIST);
> > +        if (vms->highmem_redists) {
> > +            virt_max_cpus +=3D virt_redist_capacity(vms, VIRT_HIGH_GIC=
_REDIST2);
> > +        }
> > +    }
> > +
> > +    if ((tcg_enabled() && !qemu_tcg_mttcg_enabled()) || hvf_enabled() =
||
> > +        qtest_enabled() || vms->gic_version =3D=3D VIRT_GIC_VERSION_2)=
 {
> > +        max_cpus =3D machine->smp.max_cpus =3D smp_cpus;
> > +        if (mc->has_online_capable_cpus) {
> > +            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> > +                warn_report("GICv2 does not support online-capable CPU=
s");
> > +            }
> > +            mc->has_online_capable_cpus =3D false;
> > +        }
> > +    }
> > +
> > +    if (mc->has_online_capable_cpus) {
> > +        max_cpus =3D smp_cpus + machine->smp.disabledcpus;
> > +        machine->smp.max_cpus =3D max_cpus;
> > +    }
> > +
> > +    if (max_cpus > virt_max_cpus) {
> > +        error_report("Number of SMP CPUs requested (%d) exceeds max CP=
Us "
> > +                     "supported by machine 'mach-virt' (%d)",
> > +                     max_cpus, virt_max_cpus);
> > +        if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && !vms->highmem_=
redists) {
> > +            error_printf("Try 'highmem-redists=3Don' for more CPUs\n");
> > +        }
> > +
> > +        exit(1);
> > +    }
> > +
> > +    dc =3D DEVICE_CLASS(object_class_by_name(machine->cpu_type));
> > +    if (!dc) {
> > +        error_report("CPU type '%s' not registered", machine->cpu_type=
);
> > +        exit(1);
> > +    }
> > +    dc->admin_power_state_supported =3D mc->has_online_capable_cpus;
> > +
> > +    /* uses smp.max_cpus to initialize all possible vCPUs */
> > +    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> > +
> >     if (vms->secure) {
> >         /*
> >          * The Secure view of the world is the same as the NonSecure,
> > @@ -2235,31 +2285,6 @@ static void machvirt_init(MachineState *machine)
> >         vms->psci_conduit =3D QEMU_PSCI_CONDUIT_HVC;
> >     }
> >=20
> > -    /*
> > -     * The maximum number of CPUs depends on the GIC version, or on how
> > -     * many redistributors we can fit into the memory map (which in tu=
rn
> > -     * depends on whether this is a GICv3 or v4).
> > -     */
> > -    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> > -        virt_max_cpus =3D GIC_NCPU;
> > -    } else {
> > -        virt_max_cpus =3D virt_redist_capacity(vms, VIRT_GIC_REDIST);
> > -        if (vms->highmem_redists) {
> > -            virt_max_cpus +=3D virt_redist_capacity(vms, VIRT_HIGH_GIC=
_REDIST2);
> > -        }
> > -    }
> > -
> > -    if (max_cpus > virt_max_cpus) {
> > -        error_report("Number of SMP CPUs requested (%d) exceeds max CP=
Us "
> > -                     "supported by machine 'mach-virt' (%d)",
> > -                     max_cpus, virt_max_cpus);
> > -        if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && !vms->highmem_=
redists) {
> > -            error_printf("Try 'highmem-redists=3Don' for more CPUs\n");
> > -        }
> > -
> > -        exit(1);
> > -    }
> > -
> >     if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
> >         error_report("mach-virt: %s does not support providing "
> >                      "Security extensions (TrustZone) to the guest CPU",
> > @@ -3245,6 +3270,9 @@ static void virt_machine_class_init(ObjectClass *=
oc, const void *data)
> >     hc->plug =3D virt_machine_device_plug_cb;
> >     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> >     hc->unplug =3D virt_machine_device_unplug_cb;
> > +
> > +    mc->has_online_capable_cpus =3D true;
> > +
> >     mc->nvdimm_supported =3D true;
> >     mc->smp_props.clusters_supported =3D true;
> >     mc->auto_enable_numa_with_memhp =3D true;
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 2b182d7817..b27c2326a2 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -302,6 +302,7 @@ struct MachineClass {
> >     bool rom_file_has_mr;
> >     int minimum_page_bits;
> >     bool has_hotpluggable_cpus;
> > +    bool has_online_capable_cpus;
> >     bool ignore_memory_transaction_failures;
> >     int numa_mem_align_shift;
> >     const char * const *valid_cpu_types;
> > --=20
> > 2.34.1
> >  =20
>=20


