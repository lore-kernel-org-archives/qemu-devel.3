Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F070BC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRQ8-0007Ue-CX; Thu, 30 Jan 2025 05:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tdRQ5-0007Sh-Vw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:05:10 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tdRQ3-0006Pf-7E
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:05:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso13007625ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738231505; x=1738836305;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JTQ7Ctb+PuV93HaEseMT4Bn9vdhtOnUpnUa7/Oihaz4=;
 b=xzsLWvA+bytm1XDSQv6m/2SpVt3+7TOLMQS0cCtfFgwfweHlfXxcedJTSRyfRCvM0p
 NhtQilVIZj+PQz+wfv2d2e48kSjXfTpiDJluMxZF725LXq8NPMMLdG76LOCdEA9S8l7t
 CVfU/+c0PkmIAJbsGPYyqBKJMSfyKZlFE0jgR5bKjSDMrXGW+Oi1Uvbjrhk/sRgcuoV/
 d0l4jsiRVrqQhjOtz03wqRrzLLUCQk3OTkxej4gwq54jfGCtyHNdkEllUFZaoEm1jLyF
 NYy36+svgV0uR0a9mc9OcQQZD+G7GI5VAvCY/TThzgBum7ceOj8PxVv4flsd0HZfyE5g
 vEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738231505; x=1738836305;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTQ7Ctb+PuV93HaEseMT4Bn9vdhtOnUpnUa7/Oihaz4=;
 b=qnQ2k+UubDV3xIs8bRiG5YqCgVLPr/KvSkWTfUpH5IArDrgcncQ8iZvoCymZwXc2ZX
 es6KQgXlUz7GOQiuMUjItxh3DhSl/RUSQbwG20TYzVbJBpPKjpGNFAySHszLFlzYWyKy
 2uvpRgAHn/dmps+BnE84G0LmLQ5Z0ZqGD7dNiNumBPXNpGVIgWb3Hlcbyhp3v4OwI0L9
 Owy28mxN7TYkXS+OaL+xNWE4YsNtE9oJ0K3w8AP74LbXKfdQHKNz2sMFqIKm63I8rwrx
 CkGNZ/LZuLlzcYYlxj/CagNEWfn1pm0EyA1wA8haxXuXqd0j8nxdpi7L45QUUX8pWD9S
 C6zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJHD8CGdx7AtN0DfgF3SuwaeyN8boofYex3U0S73SNjo4avvThkfgUOc4S6X/ym6rN6AaLCMCnRCw@nongnu.org
X-Gm-Message-State: AOJu0Yz5ZwMnTyR4wyDBfLKiX9LDjex2NUAYYIuCLYMYPMhTfhkUIfvv
 BO9LOrowr0M56mLs5ayEGfCwVMhQXMkHoNtRYQXSxK9GqiKsD0BhvLVA6oFhwTA=
X-Gm-Gg: ASbGncu7StvMCE7FCEmaF8f+awLRrbKr9zwOqxuVLnfEGJp7g5MNmvbxunJlyAxwejy
 lJfBo2UY9UMC5H+m0U5kSqyJjI9+byCB+JBKLoEoXvm2TNne9Xa1UyG9/1lGPrsLnCdMLXph0OB
 6cMoSetRiNhnoZkEZFiW02WqOFWZq0JWwAQhVgyWBL+Ire4nl8J8dQSEdrOQkftlVHGIADYpBQO
 nFPp6PKghbOan16mRU/QAgo7YtqxnA3TWEx68k8sKnLKd/utOxMRCT8+yYepNK8/dJPQurdtq5Z
 BOneU1xT5LKMBJlG6DPrYJPTm6er
X-Google-Smtp-Source: AGHT+IFtNXVd5UHb7j6YP/1STjdmqjGB4ahowVn5owgnxqnbsQrOOXqG9b+OLD8kbaRNAPOa9B6nUA==
X-Received: by 2002:a05:6a00:44ca:b0:725:973f:9d53 with SMTP id
 d2e1a72fcca58-72fd0c65f41mr8346721b3a.15.1738231505264; 
 Thu, 30 Jan 2025 02:05:05 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6427adesm1078575b3a.65.2025.01.30.02.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 02:05:04 -0800 (PST)
Message-ID: <50b6b89b-abb2-48ee-83b2-0a61ae218e09@daynix.com>
Date: Thu, 30 Jan 2025 19:05:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
Content-Language: en-US
In-Reply-To: <20241212085207.1439501-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/12/12 17:52, Nicholas Piggin wrote:
> To prepare to support another USB PCI Host Controller, make some PCI
> configuration dynamic.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/hcd-xhci-pci.h |  9 ++++++
>   hw/usb/hcd-xhci-nec.c | 10 +++++++
>   hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-------
>   3 files changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> index 08f70ce97cc..213076aabf6 100644
> --- a/hw/usb/hcd-xhci-pci.h
> +++ b/hw/usb/hcd-xhci-pci.h
> @@ -40,6 +40,15 @@ typedef struct XHCIPciState {
>       XHCIState xhci;
>       OnOffAuto msi;
>       OnOffAuto msix;
> +    uint8_t cache_line_size;
> +    uint8_t pm_cap_off;
> +    uint8_t pcie_cap_off;
> +    uint8_t msi_cap_off;
> +    uint8_t msix_cap_off;
> +    int msix_bar_nr;
> +    uint64_t msix_bar_size;
> +    uint32_t msix_table_off;
> +    uint32_t msix_pba_off;

Let's make these class variables so that they won't be duplicated for 
each instance.

>   } XHCIPciState;
>   
>   #endif
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> index 0e61c6c4f06..6ac1dc7764c 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)
>   
>       pci->xhci.numintrs = nec->intrs;
>       pci->xhci.numslots = nec->slots;
> +
> +    pci->cache_line_size = 0x10;
> +    pci->pm_cap_off = 0;
> +    pci->pcie_cap_off = 0xa0;
> +    pci->msi_cap_off = 0x70;
> +    pci->msix_cap_off = 0x90;
> +    pci->msix_bar_nr = 0;
> +    pci->msix_bar_size = 0;
> +    pci->msix_table_off = 0x3000;
> +    pci->msix_pba_off = 0x3800;
>   }
>   
>   static void nec_xhci_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index a039f5778a6..948d75b7379 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -32,8 +32,9 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   
> -#define OFF_MSIX_TABLE  0x3000
> -#define OFF_MSIX_PBA    0x3800
> +#define MSIX_BAR_SIZE   0x800000
> +#define OFF_MSIX_TABLE  0x0000
> +#define OFF_MSIX_PBA    0x1000
>   
>   static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
>   {
> @@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
>      return 0;
>   }
>   
> +static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offset,
> +                                      Error **errp)
> +{
> +    int err;
> +
> +    err = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> +                             PCI_PM_SIZEOF, errp);
> +    if (err < 0) {
> +        return err;
> +    }
> +
> +    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
> +                 PCI_PM_CAP_VER_1_2 |
> +                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
> +                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
> +                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
> +    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
> +    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_NO_SOFT_RESET);
> +    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_STATE_MASK);
> +
> +    return 0;
> +}
> +
>   static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>   {
>       int ret;
> @@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>   
>       dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
>       dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
> -    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
> +    dev->config[PCI_CACHE_LINE_SIZE] = s->cache_line_size;
>       dev->config[0x60] = 0x30; /* release number */
>   
>       object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
> @@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>           s->xhci.nec_quirks = true;
>       }
>   
> +    if (s->pm_cap_off) {
> +        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
> +            error_propagate(errp, err);

Pass errp to xhci_pci_add_pm_capability() and avoid error_propagate().
include/qapi/error.h has more explanation.

> +            return;
> +        }
> +    }
> +
>       if (s->msi != ON_OFF_AUTO_OFF) {
> -        ret = msi_init(dev, 0x70, s->xhci.numintrs, true, false, &err);
> +        ret = msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
> +                       true, false, &err);
>           /*
>            * Any error other than -ENOTSUP(board's MSI support is broken)
>            * is a programming error
> @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>           /* With msi=auto, we fall back to MSI off silently */
>           error_free(err);
>       }
> +
>       pci_register_bar(dev, 0,
>                        PCI_BASE_ADDRESS_SPACE_MEMORY |
>                        PCI_BASE_ADDRESS_MEM_TYPE_64,
>                        &s->xhci.mem);
>   
>       if (pci_bus_is_express(pci_get_bus(dev))) {
> -        ret = pcie_endpoint_cap_init(dev, 0xa0);
> +        ret = pcie_endpoint_cap_init(dev, s->pcie_cap_off);
>           assert(ret > 0);
>       }
>   
>       if (s->msix != ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors, and should fail when msix=on */
> -        msix_init(dev, s->xhci.numintrs,
> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> -                  0x90, NULL);
> +        MemoryRegion *msix_bar = &s->xhci.mem;
> +        if (s->msix_bar_nr != 0) {
> +            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
> +                               "xhci-msix", s->msix_bar_size);
> +            msix_bar = &dev->msix_exclusive_bar;
> +        }
> +
> +        ret = msix_init(dev, s->xhci.numintrs,
> +                        msix_bar, s->msix_bar_nr, s->msix_table_off,
> +                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
> +                        s->msix_cap_off, errp);
> +        if (ret) {
> +            return;
> +        }
> +
> +        pci_register_bar(dev, s->msix_bar_nr,
> +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                         msix_bar);
>       }
>       s->xhci.as = pci_get_address_space(dev);
>   }


