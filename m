Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E11CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU4Ly-0001z5-E8; Mon, 01 Jun 2026 11:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wU4Lr-0001y8-Mg
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wU4Le-0001t0-6y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780326877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gC0iRGCui2puu7/KqMaDW1x47ih+FRg7O76oqBQZuw=;
 b=XJu02efGMMVplFA9jWj4u1PfTDa6YjeVVA7ZwqqrFBTI4hfPUxyE1VA2mvUvQjZ508bZXb
 lKeRMrgi2IiaYCbq1kJ5KipREEN2zFOPVQUVeGMrNk/oGz7JgCEMCE4blc8QgtZoXSW966
 pbqg+Jql0cXWbRPpyeb9+nIGZ4sg4YE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-EqCLzkuOORCBGlLE5RqGbw-1; Mon, 01 Jun 2026 11:14:35 -0400
X-MC-Unique: EqCLzkuOORCBGlLE5RqGbw-1
X-Mimecast-MFC-AGG-ID: EqCLzkuOORCBGlLE5RqGbw_1780326874
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49049100a40so63708945e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780326874; x=1780931674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gC0iRGCui2puu7/KqMaDW1x47ih+FRg7O76oqBQZuw=;
 b=PMnqiDHEwQ10MUUOJdw+4tZjlmgEs8IJoh52VNurONp/8vY1eZr0sJDx7kViu7k/p5
 4K/4IGzd2vrEUYgu4fFNLN7VNoi3JCvlXosK/X7CCOcGa86uTPHQNoNMAL03zPkT3jeC
 uEoVgk4ncaZQH5wbEtYFY781aq0iYuq9mePTW/5FPaJ5sd0bVXKl//RzNHb6DV/UCeUI
 HqGlAD50grXaUXQj/cznSjjV8/IOKWpM3mn38UizstnWik5oTRU3AAxgfhaXFe5F69fE
 7wnK5w27xSsjusUFEjxMuWAyA91eeXr1NpKPlT7NRAzqsKxoS3LDqE7Nms3XcewOpvj6
 XoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780326874; x=1780931674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9gC0iRGCui2puu7/KqMaDW1x47ih+FRg7O76oqBQZuw=;
 b=ZMHuO1EUmkwNumagQpIIaT0JZe12B2qGE50+EzaRuPkr4L2xGualnPIhV0pgmefnLR
 CU3+ORPw1LluEQP6GTl4H/hzBOvrmVXm+BbeaZ8d2eu0e1/IYCoUJt1tEm760tWqqiLN
 RH1pafaFJVrSLxt07bSiOHuW9QvZqSPUMRJa2pZffV1PsrRYMr3m8LLmePbh+RgoUHFf
 cs5vim+Z9HNjxGby8+UyvwhBJ3l0XgNOjATkFC7oIgvSGuZSAtiOWBxfI4JnW2Z73ScR
 6fJELBqlDJVnoAVZrlrCO9bQpOWU2Xbd0US+9YPS7Fk7juD49qBToeFrlIyQMGhhat/y
 1HJA==
X-Gm-Message-State: AOJu0YwEVhZb15sjkPtCdciJpHouJxLzXjEWIop7S8baZWdLWMHRpbHE
 J72mbUz7QmGEdT1AnAcyAMoWKE2tPukr8HIE5Zqkr+1AirLn/DuqRNCSdjxc53qgXIL72oqLdgU
 vCeTa5+ObErQXvrLAh433zW7WIg9d5j0Gni/wiclKs+gNWbNTkKa/7TVw
X-Gm-Gg: Acq92OGX5lMUiCjyl+9jN5fnmB9xqQDujxY6KVL4N3u6XjkHaUlk4FRA/QF4mnHAxCU
 jms5jeVOEKgFtHHsZF/AZMC6ispMJ4SI+EQeZs+6cC8qL9qSJJBq6iLDrpsuotYxcxdxwSjzRHb
 DUe0q40zARQbtrxJI5hKk9iFeB5f+LAGEL262UcPQhJylDhBhb+V5VzW+oG1iyMNCNtapEjHWI+
 2i3hWLctkuzXMZdr2JVUiUYB64o7zo3R18EkbwTKv7MZ2hEYjvBdTC97cp6EMYtZ/yWYAf4X3i+
 JgDzzfbLlmGMMjlrE/sOgORE63fvc5VKrdzWuvjcpFyW/EFy7O7fwjuCJ/swfVXk43TFN5mA4j2
 9XUpQyl1ySU+Zu8rT
X-Received: by 2002:a05:600c:8b6c:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490a292fba3mr216687925e9.18.1780326873637; 
 Mon, 01 Jun 2026 08:14:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6c:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490a292fba3mr216686955e9.18.1780326873104; 
 Mon, 01 Jun 2026 08:14:33 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0b896csm195049715e9.1.2026.06.01.08.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:14:32 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:14:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH v7 4/5] hw/arm/virt: Relax the lower bound of HighMem
 MMIO region size
Message-ID: <20260601171430.31933962@imammedo>
In-Reply-To: <b4f0d313-f403-404e-b761-818f0dd8ce08@rsg.ci.i.u-tokyo.ac.jp>
References: <20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
 <20260528-virt-v7-4-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
 <20260529113930.2d455981@imammedo>
 <b4f0d313-f403-404e-b761-818f0dd8ce08@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 1 Jun 2026 17:17:06 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> On 2026/05/29 18:39, Igor Mammedov wrote:
> > On Thu, 28 May 2026 00:05:44 +0900
> > Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >   
> >> Relax the lower bound of the HighMem MMIO region size to make it more
> >> likely that the region fits in the PA space.
> >>
> >> The lower bound was especially problematic on Apple M2. The current
> >> lower bound, 512 GiB, is too big to fit in the limited PA space on the
> >> hardware. That makes the HighMem MMIO region unavailable and limits the
> >> PCIe MMIO space to the base MMIO region. The base MMIO region is not big
> >> enough to contain a large hostmem window configured for virtio-gpu-gl-pci
> >> with DRM native context, for example.
> >>
> >> Relax the lower bound to 64 KiB, matching the memory map comment that
> >> says "devices should generally be placed at multiples of 0x10000, to
> >> accommodate guests using 64K pages." Also, automatically lower the
> >> default HighMem MMIO region size to fit in the PA space for the latest
> >> machine version; the older machine versions retain the previous default
> >> HighMem MMIO region size for compatibility.  
> > 
> > How useful/practical 64K window would be?
> > Should it be reasonably large (like 64Mb or similar), or mirror lower windows size?
> > CCing Gerd,
> > to look at it from firmware POV.  
> 
> Practically it's not useful. I just followed the existing convention 
> described in the comment instead of inventing another lower bound.
> 
> > 
> > wrt 64K magic value, it opencoded in several places. I'd use a macro for that.  
> 
> The new occurrences are:
> - One numeric literal
> - One string literal
> - One documentation
> 
> They cannot be cleanly shared. The existing memory map contains many 
> hardcoded values that are aligned by 64 KiB, but I think they are better 
> to stay as is. For example, the size of VIRT_CXL_HOST can be rewritten 
> as MEMMAP_GRANULARITY * 16 instead of 64 * KiB * 16, but if you do so, 
> that size will vary when changing the granularity, which is probably not 
> what we want. We actually need a fixed value that satisfies the 
> requirement of CXL and is consistent with old versions of the machine.


ok, I guess I'm hair splitting at this point

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> Regards,
> Akihiko Odaki
> 
> >   
> >>
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> ---
> >>   docs/system/arm/virt.rst |  2 +-
> >>   include/hw/arm/virt.h    |  1 +
> >>   hw/arm/virt.c            | 22 ++++++++++++++--------
> >>   3 files changed, 16 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> >> index f811e662d68d..c8284ce2fa0e 100644
> >> --- a/docs/system/arm/virt.rst
> >> +++ b/docs/system/arm/virt.rst
> >> @@ -149,7 +149,7 @@ highmem-mmio
> >>   
> >>   highmem-mmio-size
> >>     Set the high memory region size for PCI MMIO. Must be a power of 2 and
> >> -  greater than or equal to the default size (512G).
> >> +  greater than or equal to 64 KiB.
> >>   
> >>   gic-version
> >>     Specify the version of the Generic Interrupt Controller (GIC) to provide.
> >> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> >> index 6c8ba8f3185b..7aa289d3936f 100644
> >> --- a/include/hw/arm/virt.h
> >> +++ b/include/hw/arm/virt.h
> >> @@ -143,6 +143,7 @@ typedef enum VirtGICType {
> >>   struct VirtMachineClass {
> >>       MachineClass parent;
> >>       hwaddr min_highmem_base;
> >> +    hwaddr high_pcie_mmio_size;
> >>       bool no_tcg_its;
> >>       bool no_highmem_compact;
> >>       bool no_kvm_steal_time;
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 78a85a966ad7..dd97b0dd6a42 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -222,8 +222,7 @@ static const MemMapEntry base_memmap[] = {
> >>   };
> >>   
> >>   /* Update the docs for highmem-mmio-size when changing this default */
> >> -#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
> >> -#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
> >> +#define MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE (512 * GiB)
> >>   
> >>   /*
> >>    * Highmem IO Regions: This memory map is floating, located after the RAM.
> >> @@ -249,7 +248,7 @@ static MemMapEntry extended_memmap[] = {
> >>       [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
> >>       [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> >>       /* Second PCIe window */
> >> -    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
> >> +    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 0 },
> >>       /* Any CXL Fixed memory windows come here */
> >>   };
> >>   
> >> @@ -2448,9 +2447,14 @@ static void virt_set_high_memmap(VirtMachineState *vms,
> >>   
> >>       for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
> >>           region_enabled = virt_get_high_memmap_enabled(vms, i);
> >> -        region_base = ROUND_UP(base, extended_memmap[i].size);
> >>           region_size = extended_memmap[i].size;
> >>   
> >> +        if (i == VIRT_HIGH_PCIE_MMIO && !region_size) {
> >> +            region_size = CLAMP(pow2floor(BIT_ULL(pa_bits) - base),
> >> +                                64 * KiB, MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE);
> >> +        }
> >> +
> >> +        region_base = ROUND_UP(base, region_size);
> >>           vms->memmap[i].base = region_base;
> >>           vms->memmap[i].size = region_size;
> >>   
> >> @@ -3340,11 +3344,9 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
> >>           return;
> >>       }
> >>   
> >> -    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
> >> -        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
> >> +    if (size < 64 * KiB) {
> >>           error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
> >> -                         "than the default (%s)", sz);
> >> -        g_free(sz);
> >> +                         "than 64 KiB");
> >>           return;
> >>       }
> >>   
> >> @@ -4271,6 +4273,8 @@ static void virt_instance_init(Object *obj)
> >>       VirtMachineState *vms = VIRT_MACHINE(obj);
> >>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> >>   
> >> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = vmc->high_pcie_mmio_size;
> >> +
> >>       /* EL3 is disabled by default on virt: this makes us consistent
> >>        * between KVM and TCG for this board, and it also allows us to
> >>        * boot UEFI blobs which assume no TrustZone support.
> >> @@ -4372,6 +4376,8 @@ static void virt_machine_11_0_options(MachineClass *mc)
> >>        * < 255GiB we keep the legacy memory map.
> >>        */
> >>       vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
> >> +
> >> +    vmc->high_pcie_mmio_size = MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE;
> >>   }
> >>   DEFINE_VIRT_MACHINE(11, 0)
> >>   
> >>  
> >   
> 


