Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D74C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdlV-0003eL-FR; Mon, 24 Feb 2025 14:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdkU-0003LF-71
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdkM-0003IK-K2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740423843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVOsqiWv3szwArUox2E2QGqQdQmYHXeikwMQSu314Ok=;
 b=A5cSkfmfsATHQuiah2VoygK0JNpZl5PAPC1sxEH81a5LP3jwlSgB1lNob+GjNo4UyADo22
 1q4XWDDShtQIMx6t6XtQ+07sLOIblJpwf9W/FJ3A6viFpj2vA9N4Jbpq3cl0aaaGP0BAP+
 LiqD7mEUpTivTRKm4z/qHjtxzNjP5F0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-bwRMIE5JM-ug3w4agppQ0w-1; Mon, 24 Feb 2025 14:04:00 -0500
X-MC-Unique: bwRMIE5JM-ug3w4agppQ0w-1
X-Mimecast-MFC-AGG-ID: bwRMIE5JM-ug3w4agppQ0w_1740423839
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2726c0faso5076755f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423839; x=1741028639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVOsqiWv3szwArUox2E2QGqQdQmYHXeikwMQSu314Ok=;
 b=hyNHl9d+LHAkjVggD7H0fvybVoh9GhqZSczbRi/u1fVPFlsz1iUDASoTAGMOHlvdZc
 f1g1TZmZ+n7EGVTUnhiSc+F5d9Hu4W0WVqTFHTJlUlwBShaNG5njhMFQvua5Xh4qbK48
 QCC2wJO3zvwmEeXeuue1EhyXIiMKVOUoaRPvYs5OWVrgKNTTRnMG3xRU6NvjKLaCBZDS
 4zCFipBknnOTow8dUFtQhAFVJ+K7/Jj4QphM4q7OglkQtiv4wNk5nAdn8ZHixGNedAG8
 +M+MipSwW1pCqhw6bqe3JXF1LtUPWiwU0OVntl1s2/uNm8BBElrBl0PzKpFGVi+fZSNl
 LOmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWygSmqVpn92qM/iBihkFz+49rnfEeBWmydc5QiA+io+c34K0ATsRjerkE4TIlKp/XwMlGVpFjuOk+b@nongnu.org
X-Gm-Message-State: AOJu0Yy9k7yo58gntiOxHSgLNZSZtZ77HKg6SVQQl1WCbjZYl5hBLu9A
 fAV8lZgbQWTfc3AP3BJzRUSfJWD7SZe+QjiBzWBEmgfVLVAdrrVniW3pnc02ONa7qKGps/TOxML
 qoLGLEUqrluOhE64VgcB+rfjO/cjonY6/poYabWFo8pXorWh32ADzWF0HZJgv
X-Gm-Gg: ASbGncvbvXejQcVvv5DwuZLKNq9uwVh0HuJAou1T+tI9S1ZFe1wWTQ4GCb3Ikg+q/L1
 GPYCULRU1FtqthGgasGx1WSAmyLvh6uVU9GG0kEQhYNfxAI2YidszUVHqANi+9WBEcNWnolBG1N
 QryY5CRJUgWZXqpvwYkIske/9hbE4swMPvhYFaVNLKxvCxWoYkD5cKktNn/6J2UofBJ2WOfEULo
 dTUBeONwTv0Wdjc1p9FSJudb+5yb3lpN3U1zWWrdlwqRUxoV4QJ+OxiR2cxLbimifk7zYvf6MOx
 nrFySoehBCDbEJIcoGQZx46sRzsqA1Cq5L2AjwWZyfFcSPAL/AUvRBYFyRhmDaA=
X-Received: by 2002:adf:edd0:0:b0:38f:4d20:49f8 with SMTP id
 ffacd0b85a97d-390cc60c02dmr181479f8f.32.1740423838572; 
 Mon, 24 Feb 2025 11:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYwlO/UMTMBpOCo+kI803VOAFe6zbKGgHZRxVB8b4AXEBW0040Qg38V1eGDo7DA0vJ3Y2VOw==
X-Received: by 2002:adf:edd0:0:b0:38f:4d20:49f8 with SMTP id
 ffacd0b85a97d-390cc60c02dmr181424f8f.32.1740423838117; 
 Mon, 24 Feb 2025 11:03:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d94acsm32874449f8f.75.2025.02.24.11.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 11:03:57 -0800 (PST)
Message-ID: <ac58cbe2-6161-46ed-a65d-c3fba90c1344@redhat.com>
Date: Mon, 24 Feb 2025 20:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/pci: Basic support for PCI power management
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-2-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220224918.2520417-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Alex,

On 2/20/25 11:48 PM, Alex Williamson wrote:
> The memory and IO BARs for devices are only accessible in the D0
> power state.  In other power states the PCI spec defines that the
> device should respond to TLPs and messages with an Unsupported
> Request response.  The closest we can come to emulating this
> behavior is to consider the BARs as unmapped, removing them from
> the address space.
>
> Introduce an interface to register the PM capability such that
> the device power state is considered relative to the BAR mapping
> state.

"the device power state is considered relative to the BAR mapping
state."
I rather understood that you want the BAR mapping state to depend on the power state but maybe I misunderstand the langage here.


>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/pci/pci.c                | 83 ++++++++++++++++++++++++++++++++++++-
>  hw/pci/trace-events         |  2 +
>  include/hw/pci/pci.h        |  3 ++
>  include/hw/pci/pci_device.h |  3 ++
>  4 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2afa423925c5..4f2554dd63ac 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -435,6 +435,74 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
>                           attrs, NULL);
>  }
>  
> +int pci_pm_init(PCIDevice *d, uint8_t offset, Error **errp)
> +{
> +    int cap = pci_add_capability(d, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF, errp);
> +
> +    if (cap < 0) {
> +        return cap;
> +    }
> +
> +    d->pm_cap = cap;
> +    d->cap_present |= QEMU_PCI_CAP_PM;
> +    pci_set_word(d->wmask + cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
> +
> +    return cap;
> +}
> +
> +static uint8_t pci_pm_state(PCIDevice *d)
> +{
> +    uint16_t pmcsr;
> +
> +    if (!(d->cap_present & QEMU_PCI_CAP_PM)) {
> +        return 0;
> +    }
> +
> +    pmcsr = pci_get_word(d->config + d->pm_cap + PCI_PM_CTRL);
> +
> +    return pmcsr & PCI_PM_CTRL_STATE_MASK;
> +}
> +
> +static uint8_t pci_pm_update(PCIDevice *d, uint32_t addr, int l, uint8_t old)
the old/new terminology sounds weird to me. generally when one updates
we pass the new value.
> +{
> +    uint16_t pmc;
> +    uint8_t new;
> +
> +    if (!(d->cap_present & QEMU_PCI_CAP_PM) ||
> +        !range_covers_byte(addr, l, d->pm_cap + PCI_PM_CTRL)) {
> +        return old;
> +    }
> +
> +    new = pci_pm_state(d);
and new sounds to be the current state.

pci_pm_update() does a kind of validation of the current value? 

> +    if (new == old) {
> +        return old;
> +    }
> +
> +    pmc = pci_get_word(d->config + d->pm_cap + PCI_PM_PMC);
> +
> +    /*
> +     * Transitions to D1 & D2 are only allowed if supported.  Devices may
> +     * only transition to higher D-states or to D0.  The write is dropped
> +     * for rejected transitions by restoring the old state.
> +     */
> +    if ((!(pmc & PCI_PM_CAP_D1) && new == 1) ||
> +        (!(pmc & PCI_PM_CAP_D2) && new == 2) ||
> +        (old && new && new < old)) {
> +        pci_word_test_and_clear_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> +                                     PCI_PM_CTRL_STATE_MASK);
> +        pci_word_test_and_set_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> +                                   old);
> +        trace_pci_pm_bad_transition(d->name, pci_dev_bus_num(d),
> +                                    PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
> +                                    old, new);
the trace does not output that the old state is kept. This may be helpful.
> +        return old;
> +    }
> +
> +    trace_pci_pm_transition(d->name, pci_dev_bus_num(d), PCI_SLOT(d->devfn),
> +                            PCI_FUNC(d->devfn), old, new);
> +    return new;
> +}
> +
>  static void pci_reset_regions(PCIDevice *dev)
>  {
>      int r;
> @@ -474,6 +542,11 @@ static void pci_do_device_reset(PCIDevice *dev)
>                                pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
>                                pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
>      dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
> +    /* Default PM state is D0 */
> +    if (dev->cap_present & QEMU_PCI_CAP_PM) {
> +        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
> +                                     PCI_PM_CTRL_STATE_MASK);
> +    }
>      pci_reset_regions(dev);
>      pci_update_mappings(dev);
>  
> @@ -1598,7 +1671,7 @@ static void pci_update_mappings(PCIDevice *d)
>              continue;
>  
>          new_addr = pci_bar_address(d, i, r->type, r->size);
> -        if (!d->enabled) {
> +        if (!d->enabled || pci_pm_state(d)) {
>              new_addr = PCI_BAR_UNMAPPED;
>          }
>  
> @@ -1664,6 +1737,7 @@ uint32_t pci_default_read_config(PCIDevice *d,
>  
>  void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int l)
>  {
> +    uint8_t new_pm_state, old_pm_state = pci_pm_state(d);
>      int i, was_irq_disabled = pci_irq_disabled(d);
>      uint32_t val = val_in;
>  
> @@ -1676,11 +1750,16 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>          d->config[addr + i] = (d->config[addr + i] & ~wmask) | (val & wmask);
>          d->config[addr + i] &= ~(val & w1cmask); /* W1C: Write 1 to Clear */
>      }
> +
IIUC the config is first updated and then we check the validity and
potentially restore the older value.
Couldn't we check the validity before updating d->config?
> +    new_pm_state = pci_pm_update(d, addr, l, old_pm_state);
> +
>      if (ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
>          ranges_overlap(addr, l, PCI_ROM_ADDRESS, 4) ||
>          ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4) ||
> -        range_covers_byte(addr, l, PCI_COMMAND))
> +        range_covers_byte(addr, l, PCI_COMMAND) ||
> +        !!new_pm_state != !!old_pm_state) {
>          pci_update_mappings(d);
Eric
> +    }
>  
>      if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
>          pci_update_irq_disabled(d, was_irq_disabled);
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 19643aa8c6b0..811354f29031 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,6 +1,8 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>  
>  # pci.c
> +pci_pm_bad_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x bad PM transition D%d->D%d"
> +pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x PM transition D%d->D%d"
>  pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>  pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>  pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebde0..c220cc844962 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -216,6 +216,8 @@ enum {
>      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>  #define QEMU_PCIE_EXT_TAG_BITNR 13
>      QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
> +#define QEMU_PCI_CAP_PM_BITNR 14
> +    QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
>  };
>  
>  typedef struct PCIINTxRoute {
> @@ -676,5 +678,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>  void pci_set_enabled(PCIDevice *pci_dev, bool state);
>  void pci_set_power(PCIDevice *pci_dev, bool state);
> +int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
>  
>  #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index add208edfabd..345b12eaac1a 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -105,6 +105,9 @@ struct PCIDevice {
>      /* Capability bits */
>      uint32_t cap_present;
>  
> +    /* Offset of PM capability in config space */
> +    uint8_t pm_cap;
> +
>      /* Offset of MSI-X capability in config space */
>      uint8_t msix_cap;
>  


