Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB1DC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tavvS-0006Lp-LM; Thu, 23 Jan 2025 07:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tavvM-0006LL-M8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:03:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tavvK-0001Fz-Id
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737633780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9LwXGguhy1/km9SVDrYN0om2Khjd8ZAUNbhyE+/ndc=;
 b=hi18G4xiQX4LxHNf2xib35heVAX4ja+NzBczzicjcBzPhlCp5Mzj6CRsVAhTzE7X6JMrw/
 20FEJK7ZrkXRztovba0Jo4Jff5ZpUwPBwUYrsByxJ3aC7Gtj1E95x1l7qOdpglv4w7mOIS
 6t7nOAKbgp8nAj33lVpeS7GG+H+GZ9I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-0vXsukv7P12wVGRgLJ56kw-1; Thu, 23 Jan 2025 07:02:59 -0500
X-MC-Unique: 0vXsukv7P12wVGRgLJ56kw-1
X-Mimecast-MFC-AGG-ID: 0vXsukv7P12wVGRgLJ56kw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso549412f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 04:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737633778; x=1738238578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9LwXGguhy1/km9SVDrYN0om2Khjd8ZAUNbhyE+/ndc=;
 b=ctCcHGvwnsVCmnbGhgwDZMi2TJD4Jox32aO3Xh7/msa28mVmMJ4fi1uuDFvc7o4GHd
 8Mgtxwb3Ke8xdO0mdKJ7VKW3akC++tt+fCv2VHC79AsnG9L3cadflHzMzB5oKEblnX/O
 SCCtjsxsLXmileqsjtKxMRqCTI+m8gxqmcXFwpcW9APsybcAunXoUvtFdwaKN2Ar5lt5
 W8uBqZx+7EJq7h+9kGRGHh9qjtP0CIW4sY4knBlQVWj4WTH2E1VeDxCW39sYL1hPdhhQ
 TZ2fNaKvs+JfrT4DKKA7gRWHqp5Mcb9FcGpLnr77aia/EnCH9swBMW1y1TLM0Fo71CnG
 oM2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPu52UvtGvQs96N2JmX5dnPcKOhr0+UZR6PFT0k12Q/UmWRe38wPYAGbz3zOfFvKmtnjZudhVFqN0D@nongnu.org
X-Gm-Message-State: AOJu0YwXwdtYFvoi/IhwuaatKvNESC1qYwbrytzHSndg0nXxUSwzFOgU
 NbpWRneri2aBh5N0LzE634kg2kkOz4IRM9KKd28+LnQOu1QkItOY73Sc4/oP4Sb9uR5F2xOcCGp
 r4sx0zn/tZK1bnkWmL4Rz2gCYFxtTBmqagAE9q447Rw8/SlliHcvcryZTWksqjJJ+GuDD04wbhn
 2e4kmRmvFPnefajIPcewQES40lxV0=
X-Gm-Gg: ASbGncu6zU6ZxlMJssXN3UR53sr9mBL6ayKGTYtV53q1J0RMc6H2Js1SDfjIiakwvb+
 q9J+5pE/ZlDiL77A+pSxiN7JvgF2Je3li8q62zePJDryWtp9Hy9B8
X-Received: by 2002:a5d:6d86:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38bf5649261mr24203256f8f.9.1737633777953; 
 Thu, 23 Jan 2025 04:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLygCQr286Eyc081+J24Ve8rPqSNP4bHT4cyNKo08YRf/wZjr0CGhkLGTiF5RVMApwewkE3HbL0j7H9h4pzH4=
X-Received: by 2002:a5d:6d86:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38bf5649261mr24203186f8f.9.1737633777465; Thu, 23 Jan 2025
 04:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20250122120117.1154596-1-anisinha@redhat.com>
 <Z5IBxLeIBPvnJpaQ@intel.com>
In-Reply-To: <Z5IBxLeIBPvnJpaQ@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 23 Jan 2025 17:32:46 +0530
X-Gm-Features: AbW1kvYQEtjl7UjeM6THfK-WGU0Yx_B0T-zptoRhwNdX6jyShDPRCCagXuMqSFo
Message-ID: <CAK3XEhO=k7e+xhCaJcthvry1nEH1hE=Q=Qe8taM2SR5xjZR7zw@mail.gmail.com>
Subject: Re: [PATCH v4] hw/i386/cpu: remove default_cpu_version and simplify
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, imammedo@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Thu, Jan 23, 2025 at 1:56=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Ani,
>
> [snip]
>
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -114,7 +114,10 @@ void init_topo_info(X86CPUTopoInfo *topo_info, con=
st X86MachineState *x86ms);
> >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >                                      unsigned int cpu_index);
> >
> > -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> > +void x86_cpus_init(X86MachineState *pcms);
> > +#ifndef I386_CPU_H
> > +void x86_cpu_set_legacy_version(void);
> > +#endif
> >  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
> >  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >                        DeviceState *dev, Error **errp);
>
> [snip]
>
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
>
> ...
>
> > +#ifndef HW_I386_X86_H
> > +void x86_cpu_set_legacy_version(void);
> > +#endif
> >  #ifndef CONFIG_USER_ONLY
> >
> >  void do_cpu_sipi(X86CPU *cpu);
>
> I see your problem: Due to the complex reference relationships, you have
> to check the header files and make declarations twice.

yeah nothing that  I did try was working except when I was checking
explicitly if a header has been included in that path already.

>
> What about the following solution?
>
>  * Declare pc_init_cpus() in pc.h and define it in pc.c (including cpu.h
>    in pc.c).
>  * Only declare x86_cpu_set_legacy_version() in cpu.h.

yeah this is something I wondered but did not try in the end.

>
> An example would be like:
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b46975c8a4db..9e8b5fa33596 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -61,6 +61,7 @@
>  #include "hw/i386/kvm/xen_xenstore.h"
>  #include "hw/mem/memory-device.h"
>  #include "e820_memory_layout.h"
> +#include "target/i386/cpu.h"
>  #include "trace.h"
>  #include "sev.h"
>  #include CONFIG_DEVICES
> @@ -615,6 +616,19 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, in=
t level)
>      }
>  }
>
> +void pc_init_cpus(MachineState *ms)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> +    PCMachineState *pcms =3D PC_MACHINE(ms);
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +
> +    if (pcmc->no_versioned_cpu_model) {
> +        /* use legacy cpu as it does not support versions */
> +        x86_cpu_set_legacy_version();
> +    }
> +    x86_cpus_init(x86ms);
> +}
> +
>  static
>  void pc_machine_done(Notifier *notifier, void *data)
>  {
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 34106bb52db8..dc0ca5bcb2a5 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -130,19 +130,6 @@ struct PCMachineClass {
>  #define TYPE_PC_MACHINE "generic-pc-machine"
>  OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
>
> -static inline void pc_init_cpus(MachineState *ms)
> -{
> -    X86MachineState *x86ms =3D X86_MACHINE(ms);
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -
> -    if (pcmc->no_versioned_cpu_model) {
> -        /* use legacy cpu as it does not support versions */
> -        x86_cpu_set_legacy_version();
> -    }
> -    x86_cpus_init(x86ms);
> -}
> -
>  /* ioapic.c */
>
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
> @@ -150,6 +137,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_ena=
bled);
>  /* pc.c */
>
>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
> +void pc_init_cpus(MachineState *ms);
>
>  #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
>  #define PCI_HOST_PROP_PCI_MEM          "pci-mem"
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 41236d2a8081..2d2b987fa135 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -115,9 +115,6 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *=
x86ms,
>                                      unsigned int cpu_index);
>
>  void x86_cpus_init(X86MachineState *pcms);
> -#ifndef I386_CPU_H
> -void x86_cpu_set_legacy_version(void);
> -#endif
>  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
>  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                        DeviceState *dev, Error **errp);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 9c0ce2adafe7..bdbe54b26f60 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2686,10 +2686,8 @@ typedef int X86CPUVersion;
>   * Currently, this is only used by microvm.
>   */
>  void x86_cpu_uses_lastest_version(void);
> -
> -#ifndef HW_I386_X86_H
>  void x86_cpu_set_legacy_version(void);
> -#endif
> +
>  #ifndef CONFIG_USER_ONLY
>
>  void do_cpu_sipi(X86CPU *cpu);
>
> ---
>
> The change can be applied on this patch I think. If you like this
> approach, you can try if the pipeline is happy with it.

yes it works. Thanks for the suggestion. Pipeline passes.

>
> Regards,
> Zhao
>
>


