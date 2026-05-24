Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0987FCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 07:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR3FK-0007Kk-E2; Sun, 24 May 2026 03:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR3FI-0007KU-Rr
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR3FF-0008Op-Vk
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779607651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxhD+oPNzxpDNMc3FLT/7Y70luC3EVY6qa2hhkOcukw=;
 b=efK7z89bPd5hRr/8DvaR/8w3vxgj79hg6c7x0cyJCUkFbrTHxAqlFd+VGKAi8d2x/J23OM
 YxtMA17Oyi/w8ZNjgZEDta1obtc4096BzCkiP/TMrCQUKXeCyP+TFLXlpWCuD2VyaFSKRV
 nX44xr3D9y6cajZu537KCt4j+PzdS2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-39AagrcwMbqbmgKhIZsBHg-1; Sun, 24 May 2026 03:27:29 -0400
X-MC-Unique: 39AagrcwMbqbmgKhIZsBHg-1
X-Mimecast-MFC-AGG-ID: 39AagrcwMbqbmgKhIZsBHg_1779607648
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49058e91639so3401065e9.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779607648; x=1780212448; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxhD+oPNzxpDNMc3FLT/7Y70luC3EVY6qa2hhkOcukw=;
 b=W43EXWxeBmnB+nG6zCr4xJpWfaLL+aUYRe2XiwWMvrvVRb+JLwPppaOhgHRl88CDma
 Ww53kcJhYF0pilNgLKAVA/6yW7tYy982RGfEh3n0/L1z2t2CYlzQoBg7dds/bIw7fXFs
 etc/zNETk3zkUORYouQW9CvQ6dvWRHq4Qpz8X7jq0Cal7655oZAblKPA0lTjd4cM+FCW
 2Ydn0sinKzMWQMH0SK6PDA8HhiIGxOWoXMWr04TQV2QVWsedDeLIOIg6C6zK0HVre1+c
 OTB9I9C89lPDw+dz0FCUsWApEopfUv8GcCHnVTlWWqpbofeJ0buRoph5tMlntAk6PQEA
 y/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779607648; x=1780212448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxhD+oPNzxpDNMc3FLT/7Y70luC3EVY6qa2hhkOcukw=;
 b=Nb2l+y7OlbpU1p7tcMcSmA/B6FDjpxyRmixdGnINXEXbY4YLX40MRYQ1NBcM+/2W/9
 FoSmgQMhNIGIy4ud5G5qwppjhD4+CPdGEhJj+ukSUGIZqCH3IDTCJhMGV83RChygCg2v
 7Rvjr1OSy7ZwSRzKt3A+ZeA6mbymIM96Tzhq4R7Yb2Q1YoRxlcfmwHGcbqhsJLHnm5rZ
 hMEfwis/SCMQ0wT7LkPFKR1D8EYDNmb922eaLsFu+K952LHoWALqgzkookMaY2AiEJ4h
 Gcs2sIQJwCQ9jVuEjcCm1YDCM4XgaRmpWm28d/kpu4u78x8nIeEou0MUWnLyELPJ+ico
 XuIg==
X-Gm-Message-State: AOJu0YwoUnDGTesQ8Z8QPzb5r2GsOIPVMATutDWNTeAUoAZMbeo11bUf
 X9NfRgNwogREBAmEvF7WEMjbIxp6SrrOiIqrjZOolKB9xw4pRSifEMwkDAuG7whNs5PUsDJYHiE
 GGC0So+lbpDU/abpnRMdTToavmbAOrX+CwGo4blFR8w52HsuIzHiik1RF
X-Gm-Gg: Acq92OFQgeGWjfeOwX+6IjWMmMjrMjYk/mQzpkR3jfU43YRZ8s2ZXO9J/mt4sTeES1v
 uYqPPMwPVQZbH12B3fz/tSKTp9g+P33eRAE6b5raE5fZFPQ1VPMDltha5Eh5Q2ki23MIrVEfMUb
 PJxqwAEAsLmRAlLRJewPhx+y5umZWwYc0bD20jwzxjlV+U5GB9WJDrA8jF6plt767m0cfdzGCxH
 e16pb/NdAS8HZLIcrJiDjou/dsZ/EIUutZiFu8O7v6YMqk//uGAu48kSDcTGcro67myPDNtjOXl
 f4mFQ4AOOKiiC5aD6RlNK5rY6ajLCkFux5I/cFh1qkjhQhLTxavVtWcQ2Iu9QTQp1Ca3EalJtqR
 Ym2CUiD3qQ0cTh5pulU9mKk9NKiIhbo7Ov5Iam+HZqbM=
X-Received: by 2002:a05:600c:5298:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-490428e02d3mr167202455e9.33.1779607648209; 
 Sun, 24 May 2026 00:27:28 -0700 (PDT)
X-Received: by 2002:a05:600c:5298:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-490428e02d3mr167202145e9.33.1779607647720; 
 Sun, 24 May 2026 00:27:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm269326035e9.1.2026.05.24.00.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 00:27:27 -0700 (PDT)
Date: Sun, 24 May 2026 03:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, Alexey Gerasimenko <x1917x@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/4] pc/xen: Xen Q35 support: provide IRQ handling for
 PCI devices
Message-ID: <20260524031521-mutt-send-email-mst@kernel.org>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <20260313164649.794591-2-thierry.escande@vates.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313164649.794591-2-thierry.escande@vates.tech>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 13, 2026 at 04:47:07PM +0000, Thierry Escande wrote:
> From: Alexey Gerasimenko <x1917x@gmail.com>
> 
> This patch introduces support for ICH9 LPC PCI interrupt routing when
> running under Xen. This intercepts writes to the PIRQA-D routing
> registers and propagates routing changes to the Xen device model via
> xen_set_pci_link_route().
> 
> A major difference between i440 and Q35 is the number of PIRQ inputs and
> PIRQ routers (PCI IRQ links in terms of ACPI) available. i440 has 4 PCI
> interrupt links, while Q35 has 8 (PIRQA...PIRQH). Currently Xen has
> support for only 4 PCI links, so we describe only 4 of 8 PCI links in
> ACPI tables. Also, hvmloader disables PIRQ routing for PIRQE..PIRQH by
> writing 80h into corresponding PIRQ[n]_ROUT registers.
> 
> All this PCI interrupt routing stuff largely concerns legacy mechanism
> from PIC era. It's hardly worth to extend number of PCI links supported
> as we normally deal with APIC mode and/or MSI interrupts.
> 
> The only useful thing to do with PIRQE..PIRQH routing currently is to
> check if guest actually attempts to use it for some reason (despite ACPI
> PCI routing information provided). In this case, a warning is reported.
> 
> This has been tested on Linux guests with noapic and pci=nomsi kernel
> parameters set.
> 
> Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
> ---
>  hw/i386/pc_piix.c     |  2 --
>  hw/i386/xen/xen-hvm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/isa/lpc_ich9.c     | 16 +++++++++++++---
>  include/hw/xen/xen.h  |  5 +++++
>  stubs/xen-hw-stub.c   |  4 ++++
>  5 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 4d71e0d51a..a65e09e46c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -66,8 +66,6 @@
>  #include "hw/i386/acpi-build.h"
>  #include "target/i386/cpu.h"
>  
> -#define XEN_IOAPIC_NUM_PIRQS 128ULL
> -
>  static GlobalProperty pc_piix_compat_defaults[] = {
>      { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>      { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 67d3e836eb..2dba289e09 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -18,6 +18,7 @@
>  #include "hw/core/hw-error.h"
>  #include "hw/i386/pc.h"
>  #include "hw/core/irq.h"
> +#include "hw/southbridge/ich9.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/xen/xen-x86.h"
>  #include "qemu/range.h"
> @@ -87,6 +88,43 @@ int xen_set_pci_link_route(uint8_t link, uint8_t irq)
>      return xendevicemodel_set_pci_link_route(xen_dmod, xen_domid, link, irq);
>  }
>  
> +void xen_ich9_pci_write_config_client(PCIDevice *pci_dev, uint32_t address, uint32_t val, int len)
> +{
> +    static bool pirqe_f_warned = false;
> +    int i;
> +
> +    if (ranges_overlap(address, len, ICH9_LPC_PIRQA_ROUT, 4)) {
> +        /* handle PIRQA..PIRQD routing */
> +        /* Scan for updates to PCI link routes (0x60-0x63). */
> +        for (i = 0; i < len; i++) {
> +            uint8_t v = (val >> (8 * i)) & 0xff;
> +            if (v & 0x80) {
> +                v = 0;
> +            }
> +            v &= 0xf;
> +            if (((address + i) >= ICH9_LPC_PIRQA_ROUT) &&
> +                ((address + i) <= ICH9_LPC_PIRQD_ROUT)) {
> +                xen_set_pci_link_route(address + i - ICH9_LPC_PIRQA_ROUT, v);
> +            }
> +        }
> +    } else if (ranges_overlap(address, len, ICH9_LPC_PIRQE_ROUT, 4)) {
> +        while (len--) {
> +            if (range_covers_byte(ICH9_LPC_PIRQE_ROUT, 4, address) &&
> +                (val & 0x80) == 0) {
> +                /* print warning only once */
> +                if (!pirqe_f_warned) {
> +                    pirqe_f_warned = true;
> +                    warn_report("WARNING: guest domain attempted to use PIRQ%c "
> +                                "routing which is not supported for Xen/Q35 currently\n",
> +                                (char)(address - ICH9_LPC_PIRQE_ROUT + 'E'));
> +                    break;
> +                }
> +            }
> +            address++, val >>= 8;
> +        }
> +    }
> +}
> +
>  int xen_is_pirq_msi(uint32_t msi_data)
>  {
>      /* If vector is 0, the msi is remapped into a pirq, passed as
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 51dc680029..8c627f0734 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -46,8 +46,10 @@
>  #include "hw/acpi/ich9_timer.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/core/qdev-properties.h"
> +#include "hw/xen/xen.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
> +#include "system/xen.h"
>  #include "hw/core/cpu.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/cutils.h"
> @@ -569,6 +571,9 @@ static void ich9_lpc_config_write(PCIDevice *d,
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
>      uint32_t rcba_old = pci_get_long(d->config + ICH9_LPC_RCBA);
>  
> +    if (xen_enabled()){

Coding style violation.


> +        xen_ich9_pci_write_config_client(d, addr, val, len);
> +    }
>      pci_default_write_config(d, addr, val, len);
>      if (ranges_overlap(addr, len, ICH9_LPC_PMBASE, 4) ||
>          ranges_overlap(addr, len, ICH9_LPC_ACPI_CTRL, 1)) {
> @@ -762,9 +767,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>      irq = object_property_get_uint(OBJECT(&lpc->rtc), "irq", &error_fatal);
>      isa_connect_gpio_out(ISA_DEVICE(&lpc->rtc), 0, irq);
>  
> -    pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> -    pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> -    pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> +    if (xen_enabled()) {
> +        pci_bus_irqs(pci_bus, xen_intx_set_irq, d, XEN_IOAPIC_NUM_PIRQS);
> +        pci_bus_map_irqs(pci_bus, xen_pci_slot_get_pirq);
> +    } else {
> +        pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> +        pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> +        pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> +    }
>  
>      ich9_lpc_pm_init(lpc);
>  }
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index e94c6e5a31..910289b54d 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -24,6 +24,8 @@
>  #define __XEN_INTERFACE_VERSION__ 0x00040e00
>  #endif
>  
> +#define XEN_IOAPIC_NUM_PIRQS 128ULL
> +
>  /* xen-machine.c */
>  enum xen_mode {
>      XEN_DISABLED = 0, /* xen support disabled (default) */
> @@ -39,6 +41,9 @@ extern bool xen_is_stubdomain;
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>  int xen_set_pci_link_route(uint8_t link, uint8_t irq);
>  void xen_intx_set_irq(void *opaque, int irq_num, int level);
> +void xen_ich9_pci_write_config_client(PCIDevice *pci_dev,
> +                                      uint32_t address, uint32_t val,
> +                                      int len);
>  void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
>  int xen_is_pirq_msi(uint32_t msi_data);
>  
> diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
> index 6cf0e9a4c1..a74209d01e 100644
> --- a/stubs/xen-hw-stub.c
> +++ b/stubs/xen-hw-stub.c
> @@ -24,6 +24,10 @@ int xen_set_pci_link_route(uint8_t link, uint8_t irq)
>      return -1;
>  }
>  
> +void xen_ich9_pci_write_config_client(PCIDevice *pci_dev, uint32_t address, uint32_t val, int len)
> +{
> +}
> +
>  int xen_is_pirq_msi(uint32_t msi_data)
>  {
>      return 0;
> -- 
> 2.51.0
> 
> 
> 
> --
> Thierry Escande | Vates XCP-ng Developer
> 
> XCP-ng & Xen Orchestra - Vates solutions
> 
> web: https://vates.tech


