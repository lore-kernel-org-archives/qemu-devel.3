Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A965BD75E49
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEU3K-0001w5-Sx; Fri, 22 Nov 2024 08:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEU3H-0001vt-Vu
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEU3G-0004m0-1C
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732283424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y/5od7ojm0wmzKfaDCSuhJUyTNJHWyO0M9lVuSQD8k=;
 b=Gvt5JVkgeardqTKXvK+lsaK5fh1vGH/abYsNNyKHpDMnRmH+gU9hGB73IENdytVdGYdm65
 MXZuhueL464wO+XviAmHpuYLIzuyyThsQhfix76FiuaRdSYpiaG/d4kl2WGowg+1m9dNpC
 h0FoMKw/GXOlLB2wMlDmFbiQRXCeWZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-hXBsyBkbPzSkSyhrtZj87g-1; Fri, 22 Nov 2024 08:50:23 -0500
X-MC-Unique: hXBsyBkbPzSkSyhrtZj87g-1
X-Mimecast-MFC-AGG-ID: hXBsyBkbPzSkSyhrtZj87g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-382308d07dfso1056043f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 05:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283422; x=1732888222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y/5od7ojm0wmzKfaDCSuhJUyTNJHWyO0M9lVuSQD8k=;
 b=be8KDh8Mv1XWF5JSlHNRUHAuMw/gAg30zBzI6PcsHmWxyAh1eHPIQawqZzczfQfGs+
 nsPpm8URmDAa8+iYCzrWpKXd1839v6oicDADfS6gwsuTi6rDt1ln0iLExrGCX3S8TxDf
 N0p7x/VSaqIqdAK6QsHd2ktPrHUAVwsPlZcSW/eEbs33PFmqN1dHHPxbuOhYYTUCRpWp
 jQTRC/4bnm99lVSmmmckVjeEkkQ0j/0th3nzryzUQB5yD1uEAOM5rXs+zauskdKL7ed1
 QNeiBdGu2Tk00bDew2Y/LHbWpuL7qL4L7ah+ofdl1ABjCrNfK8JbJkrAMQnqNwtDnU1X
 WgRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvQf6YJIoXnjl4K24/nTZeDZiAntf10UXuTjsXlpvjgbqm/CFWzyqVG34agI0mt38Hmp6lUqkHvC7s@nongnu.org
X-Gm-Message-State: AOJu0YzF181qYXe9a3BxBDYMd0XN8pOhbYYPBAMsR6kb78PgH0vX5VwJ
 2qMLl6BgnmE+tkKzEdd88q0sMakFSoWCty9l9VpnZ9g6EX1NOdV3zDWycBzf/fp+oztMh/8p1cw
 2LaNbysVzGtXiIiixTMJyh86NN+Y7xO5NjmfAaAagcEggkKSOvmb2
X-Gm-Gg: ASbGnct4kUj22ga5pkoOEO31ljMjgqC3dtFyCTEl+jJCJex7z7AojQ+cBT4zoUMTLI/
 6qY1MIwvD7w+tQZIr8VHf7BUn0V34v0Gy8QaqSXFMKEqiGLYBSmcAdpurCDXUO4+9Cc7nPXx5Vu
 6SrRTEs4BHCqjSyQXOS2/QdEWRUrWAHseKumJ/LIerAcCvMFV2BHLgHMQa+T2UabkVuAvG8QyKH
 CUkRoUUUYp1EXG7UB9SuGRXKHuYRij8QszFJGl8UBHqGTWg93BB69RFRnybscbK0STf1zckpkzN
 XBJ9F/wrdMxnXMPZOU8P7A==
X-Received: by 2002:a05:6000:2d01:b0:382:5010:c8c3 with SMTP id
 ffacd0b85a97d-38260b78295mr2112461f8f.28.1732283421854; 
 Fri, 22 Nov 2024 05:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzOIAcJLgL/TnB3oBdwi2/+kzMe4jmqvSrYN1bEpQCrJWcrqv+XLeSkN722GolPkgzfEHATg==
X-Received: by 2002:a05:6000:2d01:b0:382:5010:c8c3 with SMTP id
 ffacd0b85a97d-38260b78295mr2112445f8f.28.1732283421407; 
 Fri, 22 Nov 2024 05:50:21 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faff9cdsm2449481f8f.28.2024.11.22.05.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 05:50:20 -0800 (PST)
Date: Fri, 22 Nov 2024 14:50:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 6/6] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
Message-ID: <20241122145020.74d52161@imammedo.users.ipa.redhat.com>
In-Reply-To: <2ecae20c-d354-5cb7-0972-f0fdc2c568c2@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-7-maobibo@loongson.cn>
 <20241118180306.6b8019c4@imammedo.users.ipa.redhat.com>
 <2ecae20c-d354-5cb7-0972-f0fdc2c568c2@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 19 Nov 2024 18:18:27 +0800
bibo mao <maobibo@loongson.cn> wrote:

> On 2024/11/19 =E4=B8=8A=E5=8D=881:03, Igor Mammedov wrote:
> > On Tue, 12 Nov 2024 10:17:38 +0800
> > Bibo Mao <maobibo@loongson.cn> wrote:
> >  =20
> >> On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
> >> hot-added CPUs, there is socket-id/core-id/thread-id property set,
> >> arch_id can be caculated from these properties. So that cpu slot can be
> >> searched from its arch_id.
> >>
> >> Also change num-cpu property of extioi and ipi from smp.cpus to
> >> smp.max_cpus
> >>
> >> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   hw/loongarch/virt.c | 68 +++++++++++++++++++++++++++++++++++++++----=
--
> >>   1 file changed, 59 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> >> index b49b15c0f6..5f81673368 100644
> >> --- a/hw/loongarch/virt.c
> >> +++ b/hw/loongarch/virt.c
> >> @@ -890,7 +890,7 @@ static void virt_irq_init(LoongArchVirtMachineStat=
e *lvms)
> >>  =20
> >>       /* Create IPI device */
> >>       ipi =3D qdev_new(TYPE_LOONGARCH_IPI);
> >> -    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
> >> +    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
> >>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> >>       lvms->ipi =3D ipi;
> >>  =20
> >> @@ -905,7 +905,7 @@ static void virt_irq_init(LoongArchVirtMachineStat=
e *lvms)
> >>  =20
> >>       /* Create EXTIOI device */
> >>       extioi =3D qdev_new(TYPE_LOONGARCH_EXTIOI);
> >> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> >> +    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
> >>       if (virt_is_veiointc_enabled(lvms)) {
> >>           qdev_prop_set_bit(extioi, "has-virtualization-extension", tr=
ue);
> >>       }
> >> @@ -1369,11 +1369,15 @@ static void virt_get_topo_from_index(MachineSt=
ate *ms,
> >>   }
> >>  =20
> >>   /* Find cpu slot in machine->possible_cpus by arch_id */
> >> -static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
> >> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id, i=
nt *index)
> >>   {
> >>       int n;
> >>       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >>           if (ms->possible_cpus->cpus[n].arch_id =3D=3D arch_id) {
> >> +            if (index) {
> >> +                *index =3D n;
> >> +            }
> >> +
> >>               return &ms->possible_cpus->cpus[n];
> >>           }
> >>       }
> >> @@ -1386,10 +1390,12 @@ static void virt_cpu_pre_plug(HotplugHandler *=
hotplug_dev,
> >>   {
> >>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(hotpl=
ug_dev);
> >>       MachineState *ms =3D MACHINE(OBJECT(hotplug_dev));
> >> +    CPUState *cs =3D CPU(dev);
> >>       LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> >>       CPUArchId *cpu_slot;
> >>       Error *local_err =3D NULL;
> >> -    int arch_id;
> >> +    LoongArchCPUTopo topo;
> >> +    int arch_id, index;
> >>  =20
> >>       /* sanity check the cpu */
> >>       if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> >> @@ -1408,12 +1414,45 @@ static void virt_cpu_pre_plug(HotplugHandler *=
hotplug_dev,
> >>        }
> >>  =20
> >>       if (cpu->phy_id =3D=3D UNSET_PHY_ID) { =20
> >  =20
> >> -        error_setg(&local_err, "CPU hotplug not supported");
> >> -        goto out;
> >> +        if ((cpu->thread_id < 0) || (cpu->thread_id >=3D ms->smp.thre=
ads)) {
> >> +            error_setg(&local_err,
> >> +                       "Invalid thread-id %u specified, must be in ra=
nge 1:%u",
> >> +                       cpu->thread_id, ms->smp.threads - 1);
> >> +            goto out;
> >> +        }
> >> +
> >> +        if ((cpu->core_id < 0) || (cpu->core_id >=3D ms->smp.cores)) {
> >> +            error_setg(&local_err,
> >> +                       "Invalid core-id %u specified, must be in rang=
e 1:%u",
> >> +                       cpu->core_id, ms->smp.cores - 1);
> >> +            goto out;
> >> +        }
> >> +
> >> +        if ((cpu->socket_id < 0) || (cpu->socket_id >=3D ms->smp.sock=
ets)) {
> >> +            error_setg(&local_err,
> >> +                       "Invalid socket-id %u specified, must be in ra=
nge 1:%u",
> >> +                       cpu->socket_id, ms->smp.sockets - 1);
> >> +            goto out;
> >> +        }
> >> +
> >> +        topo.socket_id =3D cpu->socket_id;
> >> +        topo.core_id =3D cpu->core_id;
> >> +        topo.thread_id =3D cpu->thread_id;
> >> +        arch_id =3D  virt_get_arch_id_from_topo(ms, &topo);
> >> +        cpu_slot =3D virt_find_cpu_slot(ms, arch_id, &index);
> >> +        if (CPU(cpu_slot->cpu)) {
> >> +            error_setg(&local_err,
> >> +                       "cpu(id%d=3D%d:%d:%d) with arch-id %" PRIu64 "=
 exists",
> >> +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
> >> +                       cpu->thread_id, cpu_slot->arch_id);
> >> +            goto out;
> >> +        }
> >> +        cpu->phy_id =3D arch_id;
> >> +        cs->cpu_index =3D index; =20
> > this whole branch applies to cold-plugged CPUs as well, especially
> > if both (hot/cold plugged CPUs are getting wired with help of pre_plug)
> > So this hunk should be introduced somewhere earlier in series,
> > and than I'd likely won't need (cpu->phy_id =3D=3D UNSET_PHY_ID) check =
to begin with.
> >=20
> > the only difference vs cold-plug would be need to call acpi_ged plug ha=
ndler,
> > like you are dong below in virt_cpu_plug =20
> Sure, will check acpi_ged plug handler for cold-plug/hot-plug CPU.
>=20
> >  =20
> >>       } else {
> >>           /* For cold-add cpu, find cpu slot from arch_id */
> >>           arch_id =3D cpu->phy_id;
> >> -        cpu_slot =3D virt_find_cpu_slot(ms, arch_id);
> >> +        cpu_slot =3D virt_find_cpu_slot(ms, arch_id, NULL);
> >>       }
> >>  =20
> >>       numa_cpu_pre_plug(cpu_slot, dev, &local_err);
> >> @@ -1468,7 +1507,7 @@ static void virt_cpu_unplug(HotplugHandler *hotp=
lug_dev,
> >>           return;
> >>       }
> >>  =20
> >> -    cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> >> +    cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
> >>       cpu_slot->cpu =3D NULL;
> >>       return;
> >>   }
> >> @@ -1477,14 +1516,24 @@ static void virt_cpu_plug(HotplugHandler *hotp=
lug_dev,
> >>                                   DeviceState *dev, Error **errp)
> >>   {
> >>       CPUArchId *cpu_slot;
> >> +    Error *local_err =3D NULL;
> >>       LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> >>       MachineState *ms =3D MACHINE(hotplug_dev);
> >>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(hotpl=
ug_dev);
> >>  =20
> >>       /* Connect irq to cpu, including ipi and extioi irqchip */
> >>       virt_init_cpu_irq(ms, CPU(cpu));
> >> -    cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> >> +    cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
> >>       cpu_slot->cpu =3D CPU(dev);
> >> +
> >> +    if (lvms->acpi_ged) { =20
> > Why do you need check, can machine be created without acpi_ged? =20
> There is no NULL check with macro HOTPLUG_HANDLER() for cold-plug cpu.
> Now machine is created with acpi_ged always, in later will add noapic=20
> option support.

you've probably meant '-noacpi',
anyways right now acpi_ged is always present, so make this patch unconditio=
nal.

If later on you find a use-case for '-noacpi' and add it,
then introduce condition at that time.

>=20
> Regards
> Bibo Mao
>=20
> >  =20
> >> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &l=
ocal_err);
> >> +        if (local_err) {
> >> +            error_propagate(errp, local_err);
> >> +            return;
> >> +        }
> >> +    }
> >> +
> >>       return;
> >>   }
> >>  =20
> >> @@ -1667,6 +1716,7 @@ static void virt_class_init(ObjectClass *oc, voi=
d *data)
> >>       mc->numa_mem_supported =3D true;
> >>       mc->auto_enable_numa_with_memhp =3D true;
> >>       mc->auto_enable_numa_with_memdev =3D true;
> >> +    mc->has_hotpluggable_cpus =3D true;
> >>       mc->get_hotplug_handler =3D virt_get_hotplug_handler;
> >>       mc->default_nic =3D "virtio-net-pci";
> >>       hc->plug =3D virt_device_plug_cb; =20
>=20


