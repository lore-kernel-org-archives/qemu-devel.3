Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FADD44D4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dia-0001m6-U9; Wed, 06 Nov 2024 05:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8diW-0001kH-Cj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8diU-0000ee-Qh
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kefeH6aKUzun1FUGsrIji8FqLRoROaKitrZZhyuBM1o=;
 b=hDyfBjq93fCR9Gwycr/rl3jBn44tcuxb7n+RwWxYPzhTZFk2n/sIdsqiT20FNAxrQtABaP
 ELzgQW81CSN2w29MiP53kyTNs8PnWsb999gFfu/X4oLBko6AMOSShcLgjsqdUbESr1QP85
 wawnS0DE3MJ+ZeCL8tmdj/K01X1q/5I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-i35Jj1V0MRGzEZk9Hg45pA-1; Wed, 06 Nov 2024 05:56:48 -0500
X-MC-Unique: i35Jj1V0MRGzEZk9Hg45pA-1
X-Mimecast-MFC-AGG-ID: i35Jj1V0MRGzEZk9Hg45pA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518ae047so4028035e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730890606; x=1731495406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kefeH6aKUzun1FUGsrIji8FqLRoROaKitrZZhyuBM1o=;
 b=BdcDAVIUa0sFuDV81Es2f9Q3Y02J5fcDKfyFlbI2vNsZiaUpYrj69OO7DK2byRER1w
 k3B3KUbxuaGWt4BpO2yxwiJT2s3tuSXr4Cujlp6WENnUYNBIQgeyiDhDBCcG6WyptR40
 7H5hTvL65OTY+vyYzeoJmndYeqN8arIlTx3E5xtZB/6vjCMeN7u//uv+9+ZmmIQqSCCn
 T5y2l0zwQGONZfQil00v7+jwrHhLU0Lbm5KUpumF3IINsALJARvQuZW1tXdluazF1gwq
 WpJiPYknYlLkIPyDaBH/P6SE4GGi82l+PxJ8Q97WpUjKY1WWEVD/GhSqvjM+h4tRUgiA
 89JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPFwcUz9Mj672sfZovNMDWJJpLksWHYuBtOKeumhFlohQ+4gyEQxXJsDmR4Sb4OmeNRZ+uNqZnqaBn@nongnu.org
X-Gm-Message-State: AOJu0Ywmcv1FiLfooskExDZoC1uMEJx3Y4XipCz3pU1/QK9fgtAVneqM
 kA2CknRem20pjdNqGZC3KlEVqjGrzZWvsQUZEizZLbTzFFu2mhQX4FWoYZcqPEogAZS3Nv6H3P8
 w4W8RW5P7pP3lqBvHw0dUz4tTcmn3eyn3d+4RmPDiJeEdGsd62nX8N5WrLKIt
X-Received: by 2002:a05:600c:6987:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432a99a3338mr18437465e9.0.1730890606273; 
 Wed, 06 Nov 2024 02:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHWH3lIN8aEi496M14XEyChWmK+tNPoNZLBkm6Vlh14VxokWF79zLBMZwgBCmeptkd8MPqFA==
X-Received: by 2002:a05:600c:6987:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432a99a3338mr18437215e9.0.1730890605904; 
 Wed, 06 Nov 2024 02:56:45 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa752d2fsm18123585e9.44.2024.11.06.02.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:56:45 -0800 (PST)
Date: Wed, 6 Nov 2024 11:56:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: Zhao Liu <zhao1.liu@intel.com>, Song Gao <gaosong@loongson.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 2/4] hw/loongarch/virt: Implement cpu plug interface
Message-ID: <20241106115644.3c7458b9@imammedo.users.ipa.redhat.com>
In-Reply-To: <6e53ba79-041a-3294-3656-9f5d5c41ad19@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-3-maobibo@loongson.cn>
 <ZyDlDjkO8ewhiE/m@intel.com>
 <6e53ba79-041a-3294-3656-9f5d5c41ad19@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, 30 Oct 2024 09:50:56 +0800
maobibo <maobibo@loongson.cn> wrote:

> Hi Zhao,
>=20
> On 2024/10/29 =E4=B8=8B=E5=8D=889:37, Zhao Liu wrote:
> > (CC Igor since I want to refer his comment on hotplug design.)
> >=20
> > Hi Bibo,
> >=20
> > I have some comments about your hotplug design.
> >=20
> > [snip]
> >  =20
> >> +static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >> +                              DeviceState *dev, Error **errp)
> >> +{
> >> +    LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(hotplu=
g_dev);
> >> +    MachineState *ms =3D MACHINE(OBJECT(hotplug_dev));
> >> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> >> +    CPUState *cs =3D CPU(dev);
> >> +    CPUArchId *cpu_slot;
> >> +    Error *local_err =3D NULL;
> >> +    LoongArchCPUTopo topo;
> >> +    int arch_id, index =3D 0; =20
> >=20
> > [snip]
> >  =20
> >> +    if (cpu->phy_id =3D=3D UNSET_PHY_ID) {
> >> +        error_setg(&local_err, "CPU hotplug not supported");
> >> +        goto out;
> >> +    } else {
> >> +        /*
> >> +         * For non hot-add cpu, topo property is not set. And only ph=
ysical id
> >> +         * property is set, setup topo information from physical id.
> >> +         *
> >> +         * Supposing arch_id is equal to cpu slot index
> >> +         */
> >> +        arch_id =3D cpu->phy_id;
> >> +        virt_get_topo_from_index(ms, &topo, arch_id);
> >> +        cpu->socket_id =3D topo.socket_id;
> >> +        cpu->core_id   =3D topo.core_id;
> >> +        cpu->thread_id =3D topo.thread_id;
> >> +        cpu_slot =3D virt_find_cpu_slot(ms, arch_id, &index);
> >> +    } =20
> >=20
> > It seems you want to use "phy_id" (instead of topology IDs as for now)
> > as the parameter to plug CPU. And IIUC in previous patch, "phy_id" is
> > essentially the CPU index.
> >=20
> > Igor has previously commented [1] on ARM's hotplug design that the
> > current QEMU should use the topology-id (socket-id/core-id/thread-id) as
> > the parameters, not the CPU index or the x86-like apic id.
> >=20
> > So I think his comment can apply on loongarch, too. =20
> Yes, I agree. This piece of code is for cold-plug CPUs which is added=20
> during VM power-on stage, not hot-plugged cpu. For hot-plugged cpu,=20
> value of cpu->phy_id is UNSET_PHY_ID.
>=20
> Topology-id (socket-id/core-id/thread-id) is not set for cold-plug CPUs.
> For cold-plug CPUs topology-id is calculated from archid.

that's basically copying what x86 does.

When possible_cpus are initialized, it has all topo info.
So instead of copying bad example of acpid_id, I'd suggest
in a loop that creates cold-plugged cpus, fetch topo ids
from possible_cpus[] and set them instead of phy_id.

>=20
> Regards
> Bibo
>=20
> >=20
> >  From my own understanding, the CPU index lacks topological intuition,
> > and the APIC ID for x86 is even worse, as its sometimes even
> > discontinuous. Requiring the user to specify topology ids would allow
> > for clearer localization to CPU slots.
> >=20
> > [1]: https://lore.kernel.org/qemu-devel/20240812101556.1a395712@imammed=
o.users.ipa.redhat.com/
> >  =20
> >> +    /*
> >> +     * update cpu_index calculation method since it is easily used as=
 index
> >> +     * with possible_cpus array by function virt_cpu_index_to_props
> >> +     */
> >> +    cs->cpu_index =3D index;
> >> +    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
> >> +    return ;
> >> +
> >> +out:
> >> +    error_propagate(errp, local_err);
> >> +}
> >> + =20
> >=20
> > Thanks,
> > Zhao
> >  =20
>=20


