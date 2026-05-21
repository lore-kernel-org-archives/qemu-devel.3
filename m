Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F2CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2IX-000687-F8; Thu, 21 May 2026 08:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wQ2IW-00067Y-1I
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wQ2IU-0002OB-1Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779365681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXNppUWZjzZixgllXWLsRSN6CuVhKyJ8oBa42vW/HrQ=;
 b=G5Jpp4q+sSXGcQIM6OvcLKJVEAIQxva4dFJahtGGGbCsmThaiZX6EHPTrloPHb50QO/c6n
 wtbklqFQtaBvl5wKsdl42X4iJGYKb2UZ9pjj0KmOVGzN00BYFmOWohFiN0OFXOLbWMekTy
 +W3ejxLK/1u15Ns3HvVzhOI5TgHv8pY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-fgIEcpL0NJ6Q8yBCzXeaIg-1; Thu, 21 May 2026 08:14:39 -0400
X-MC-Unique: fgIEcpL0NJ6Q8yBCzXeaIg-1
X-Mimecast-MFC-AGG-ID: fgIEcpL0NJ6Q8yBCzXeaIg_1779365678
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so48584425e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779365678; x=1779970478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXNppUWZjzZixgllXWLsRSN6CuVhKyJ8oBa42vW/HrQ=;
 b=ELnJNzutH4T8w5RBYTQV+vsmYS9y1nmQWSVfpx5N7nnxAjKZnaU5P8Jpn7T2IfDAPx
 kH/F3qd4Odp07f5qJ9xacUzaFt87FYqV5XIVhV9tNcB0/gbb5SfDtFlxxACWbIHTg6ZK
 OkARz+nCp0TW/dzegSMdLz/MLI/FmaFmoT7gCTaZ5e9yGsU1FzjX0Upsx6I4+YZjmAb8
 6uWxrzupjMHK5qYUtDL+aZ6GTL/FXMjA08oFXGl0HSUjep76UVUHKa6kMWjbNlT7BJx3
 Noiqz6wENKSPJAGMZOMJY9ojEIkVMO/NEblS1XeOSIA0segyRG0oJkBzpjtqnul8jvs2
 fo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779365678; x=1779970478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VXNppUWZjzZixgllXWLsRSN6CuVhKyJ8oBa42vW/HrQ=;
 b=gG6Q1aI2v39+pxMgG6dLVDy13Xm8eXdxQbAftvlzQV6nQYwQipGQsp5Y6wzPLvFYWB
 x2M3Hg5nUAsMwySl7BGPkEdFR/GUzVemn+ixXWfIgKtnR2/bzRnKH6u8zHL5RkQ2gKar
 pt0yP7zECQn7vMo4FxC6C1tf2Iof/72ntrSUxZm0EqdkKiofZmCS7y1mGo7b2z4M8bmW
 5RX/eS3qlTCkkhfhtgJym8p+fZL2GBIhehnbA2kREDhkqxn3M7Tgf28/ddeLLnS/rIH8
 UKQETFuAyVQaJQt/8BjNQ8/o4mf4zS7+/P//UvkHTMONuLbE2Wc/l0xUCpRbnlXmu3YU
 lEOA==
X-Gm-Message-State: AOJu0YzHmYHfaXTFEcOQBoNKNwtDjwiJ63qqVseqO9RpPAyDHzAyfwIO
 VuSePgV7WB+9WLs8iGwxQUjb5B0iHPQ/tIwEfPZ7+yMcl8+YYgtVjRS3xjHXzRKKUvIkRa9wg0d
 Wg+vAkKdNlZ/CgDIR5/UotaR5LU5ALqb5y51vxFko1igwh4o3ocBOYN/h
X-Gm-Gg: Acq92OEULKRusAtowaHfcDrbqxsfL4gWWvEOSiZ9xJ/lhmSBK9SST2KsGBPwDfirebc
 ragETv61Ml2DVs2L5rgxclb9jLVBjhCD5GsCYkaSLJd76Gs0ylTeB7NvR+lj4x0dXNhu3dn2Eze
 +mMakpHEYHqf2pbTAQpdZa/B4voGQthZlIk//EQHbXMU/XaDa4Qdc2vNE2kg62s5uKmwvNEPIBt
 Zmyycjyq0MZwK8gww1OKLFUkd8lHrqTyFalpyflm2q5EdfDf+Wp1ph9xLW2pVOaTloqn6GRcsIM
 42J6SPl+U7lvwAVNjrTo5UGijGjDm4YMqz1x32UoAvFtEVuIpKVas6kKbtfKMnjAux5B2lg4nLY
 7Y7WM9TLpWWdOoKlT
X-Received: by 2002:a05:600c:2b06:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-4903605fe99mr26016165e9.11.1779365678414; 
 Thu, 21 May 2026 05:14:38 -0700 (PDT)
X-Received: by 2002:a05:600c:2b06:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-4903605fe99mr26015775e9.11.1779365677975; 
 Thu, 21 May 2026 05:14:37 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c72c60sm22024175e9.3.2026.05.21.05.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:14:37 -0700 (PDT)
Date: Thu, 21 May 2026 14:14:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/4] hw/arm/virt: Remove the lower bound of HighMem
 IO Regions
Message-ID: <20260521141434.397e9c90@imammedo>
In-Reply-To: <ea0ee6f6-4753-45d4-ac55-a4ccbf6b7cf7@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520-virt-v6-3-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520155152.3652a6e9@imammedo>
 <ea0ee6f6-4753-45d4-ac55-a4ccbf6b7cf7@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On Thu, 21 May 2026 13:43:18 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> On 2026/05/20 22:51, Igor Mammedov wrote:
> > On Wed, 20 May 2026 18:56:32 +0900
> > Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >   
> >> Remove the lower bound of the Highmem IO Regions' addresses for the
> >> latest machine version to increase the chance to fit the regions in the
> >> PA space.
> >>
> >> The lower bound was especially problematic when using virt-install on
> >> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that  
> > 
> > it looks like with this patch everything would move down,
> > with 'small' but, VIRT_HIGH_PCIE_MMIO that still won't fit into M2 PA and
> > will get disabled.
> > Is it intended (perhaps it should be mentioned in patch)  
> 
> Yes. It is another opportunity for improvement, but out of scopoe of 
> this patch.

in this case, I'd just mentionin commit message that this region is not not available,
for particular configuration with implications that stem from this,
as it's not obvious from the patch itself.


other than that LGTM

> 
> > 
> >   
> >> require sufficient space in the ECAM region. However, the Highmem ECAM
> >> region did not fit in the limited PA space on the hardware, and the ECAM
> >> region size was limited to 16 MiB. If virt-install had added more than
> >> 16 devices to the root bridge, the region overflowed, which prevented
> >> edk2-stable202505 from scanning PCI devices, including the boot disk,
> >> causing boot failures.
> >>
> >> Ideally, a virtual machine with more than 16 devices added to the root
> >> bridge should just work so that users and management layers do not have
> >> to care whether they use constrained hardware.
> >>
> >> The base address of the Highmem IO Regions was fixed when commit
> >> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
> >> regions") added the first Highmem IO Region. Later, commit 957e32cffa57
> >> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
> >> allowed moving the Highmem IO Regions to higher addresses to accommodate
> >> RAM more than 255 GiB, but the lower bound remained to keep the legacy
> >> memory map.
> >>
> >> Remove the lower bound for the latest machine version to accommodate
> >> more devices with the root bridge. Keeping the lower bound for the old
> >> machine versions ensures the compatibility is still maintained.
> >>
> >> The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is also
> >> updated.
> >>
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>   include/hw/arm/virt.h                |  1 +
> >>   hw/arm/virt.c                        | 17 +++++++++++------
> >>   tests/qtest/libqos/generic-pcihost.c |  2 +-
> >>   3 files changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> >> index 3ba33b4bd274..6c8ba8f3185b 100644
> >> --- a/include/hw/arm/virt.h
> >> +++ b/include/hw/arm/virt.h
> >> @@ -142,6 +142,7 @@ typedef enum VirtGICType {
> >>   
> >>   struct VirtMachineClass {
> >>       MachineClass parent;
> >> +    hwaddr min_highmem_base;
> >>       bool no_tcg_its;
> >>       bool no_highmem_compact;
> >>       bool no_kvm_steal_time;
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index b090233893c5..78a85a966ad7 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -229,8 +229,7 @@ static const MemMapEntry base_memmap[] = {
> >>    * Highmem IO Regions: This memory map is floating, located after the RAM.
> >>    * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
> >>    * top of the RAM, so that its base get the same alignment as the size,
> >> - * ie. a 512GiB entry will be aligned on a 512GiB boundary. If there is
> >> - * less than 256GiB of RAM, the floating area starts at the 256GiB mark.
> >> + * ie. a 512GiB entry will be aligned on a 512GiB boundary.
> >>    * Note the extended_memmap is sized so that it eventually also includes the
> >>    * base_memmap entries (VIRT_HIGH_GIC_REDIST2 index is greater than the last
> >>    * index of base_memmap).
> >> @@ -2479,6 +2478,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
> >>   static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
> >>   {
> >>       MachineState *ms = MACHINE(vms);
> >> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> >>       hwaddr base, device_memory_base, device_memory_size, memtop;
> >>       int i;
> >>   
> >> @@ -2505,8 +2505,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
> >>       /*
> >>        * We compute the base of the high IO region depending on the
> >>        * amount of initial and device memory. The device memory start/size
> >> -     * is aligned on 1GiB. We never put the high IO region below 256GiB
> >> -     * so that if maxram_size is < 255GiB we keep the legacy memory map.
> >> +     * is aligned on 1GiB.
> >>        * The device region size assumes 1GiB page max alignment per slot.
> >>        */
> >>       device_memory_base =
> >> @@ -2524,8 +2523,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
> >>           error_report("maxmem/slots too huge");
> >>           exit(EXIT_FAILURE);
> >>       }
> >> -    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
> >> -        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
> >> +    if (base < vmc->min_highmem_base) {
> >> +        base = vmc->min_highmem_base;
> >>       }
> >>   
> >>       /* We know for sure that at least the memory fits in the PA space */
> >> @@ -4367,6 +4366,12 @@ static void virt_machine_11_0_options(MachineClass *mc)
> >>       virt_machine_11_1_options(mc);
> >>       compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
> >>       vmc->hvf_no_kernel_irqchip_default = true;
> >> +
> >> +    /*
> >> +     * Do not put the high IO region below 256GiB so that if maxram_size is
> >> +     * < 255GiB we keep the legacy memory map.
> >> +     */
> >> +    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
> >>   }
> >>   DEFINE_VIRT_MACHINE(11, 0)
> >>   
> >> diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
> >> index b77617524cac..287e8445ec5b 100644
> >> --- a/tests/qtest/libqos/generic-pcihost.c
> >> +++ b/tests/qtest/libqos/generic-pcihost.c
> >> @@ -210,7 +210,7 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
> >>       qpci->bus.pio_limit = 0x10000;
> >>       qpci->bus.mmio_alloc_ptr = 0x10000000;
> >>       qpci->bus.mmio_limit = 0x2eff0000;
> >> -    qpci->ecam_alloc_ptr = 0x4010000000;
> >> +    qpci->ecam_alloc_ptr = 0x90000000;
> >>   
> >>       qpci->obj.get_driver = qpci_generic_get_driver;
> >>   }
> >>  
> >   
> 


