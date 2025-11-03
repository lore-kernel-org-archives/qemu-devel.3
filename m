Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxis-0000h3-RT; Mon, 03 Nov 2025 11:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxip-0000f4-VI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxic-0003GJ-3b
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762188462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9O4n0Hm8ZskZKgQ5JkXtPVdE9CicG8evPBOYIRjg9g4=;
 b=DE/Gg9KJYZClttJ0OzSpKbMOGSXop6WnMrhoZ14fROQp1SiwTbJPnpCZGRsYA9KtRgnuys
 BdBQhqXrm/NHGAqhpA2ky5BrTE0fwFPJgM4Jo3wP6l9R6vTemYEoQGLJZyz1WhxX9enyqs
 8Gi33RSKa515Sr8pIckovNhRbEBeOqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-61xOlzlsOLum2Q3kJcrvoQ-1; Mon, 03 Nov 2025 11:47:41 -0500
X-MC-Unique: 61xOlzlsOLum2Q3kJcrvoQ-1
X-Mimecast-MFC-AGG-ID: 61xOlzlsOLum2Q3kJcrvoQ_1762188460
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477113a50fcso34180885e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188460; x=1762793260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9O4n0Hm8ZskZKgQ5JkXtPVdE9CicG8evPBOYIRjg9g4=;
 b=EaidGmGdX/jotEFCPaKZVQ4Bw0fyLGV2/mLCQ5IatymUqM2MoFo6gJIADg7Ohu0WaX
 E92wsbGClzIOdL5CFP/DcM7DbDi/RxFKVC4MbHSbMi/DOuosoi5zn9KRqsoncWE7Tw9I
 Qi35aUTVEZDuxsiGMecTVblWwwFMgxL85SeduJWlwRIbTcgw3Lzi2o7O6aff+6AR7bPf
 XFCSy5Ogi6u46KHx3c5h5gi7MoFXZst7iyAr0z5MhiUqcODlzYEGx5N4ot9Xqe5/Xu5s
 k1qSKsISIvzzYpSv9uCyToShHM0pV55SahlBUg5To5hJ+jIlGLRaZxp/1RzFtbOapd1h
 B5+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnmIDdZLPZqFtdORUaKk75OYcOefCpw1W+I0hvp5NZ0WcxgmK77uTUITtiNs4kpz90NcoylCxhn2hU@nongnu.org
X-Gm-Message-State: AOJu0YwxgBGXoJfZNqPu9FJSLayvC3t6Ed52LyQAHOdXsf8rwjUMYgLd
 x/U46bcUI6nH4ULVihNIBUmcCUPiRlh7FXyHTNVO4jTaK8nOFxVrJ0uUz92WIklNDW+IR6j7NUk
 RKLWu9nPvw5NoQNCAIFCT4KsVjKW7CpdygrFmVqFfP0oDtblvmbsVBeng
X-Gm-Gg: ASbGncu9B1lrwXcvWiNdsW3DV8aJtzFtpTnL5kzB5CvEuVhQ5Wu4Ow0lKkHm48eo5Hg
 SNxC+tQ6DBL3TB7onBspXCwUhLKp9eMXyPGz9+paXsuKLLtDKUalSeAe0vRpW7wUF9QLtQZKVan
 ToANu7aWfpJnHvmRK5c9Etp7/CVGYwhjgMsYUDU3hypnaDiABA98KBN/HXPal9+6somAf7oyfdf
 FHM39J7Cun88FnCX0Sv3S4/rjMyuqQcO6VySKeNxwa5iHezFa0Z4vpt26XSgFys2k7XFyLdZTtL
 riNbXD3ods4IQgTbZXU9Yt+sbEf3G7NGq0YyytkNIi+vf5BzlF/TWfLxfvRpfbCQbmQALKR8q5N
 9dZkSDvsRmm71kuq/fDa4KL0wCa7LZ95fPwcvheGjEgdzAA==
X-Received: by 2002:a05:600c:3511:b0:477:a9e:859b with SMTP id
 5b1f17b1804b1-4773089c496mr115167125e9.24.1762188459967; 
 Mon, 03 Nov 2025 08:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/PQZUNF3OfMNlzOoRYYLS3cw7PJUVrbCmb5CN2GZgJxaQEQd1VQUcjs6ayi9LPJWkNNBM2g==
X-Received: by 2002:a05:600c:3511:b0:477:a9e:859b with SMTP id
 5b1f17b1804b1-4773089c496mr115166785e9.24.1762188459562; 
 Mon, 03 Nov 2025 08:47:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fd280fbsm93350085e9.5.2025.11.03.08.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 08:47:39 -0800 (PST)
Message-ID: <61cdd31d-3053-4ecd-87a9-0520ed9161d4@redhat.com>
Date: Mon, 3 Nov 2025 17:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/32] hw/pci/pci: Add optional
 supports_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-9-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Introduce an optional supports_address_space() callback in PCIIOMMUOps to
> allow a vIOMMU implementation to reject devices that should not be attached
> to it.
>
> Currently, get_address_space() is the first and mandatory callback into the
> vIOMMU layer, which always returns an address space. For certain setups, such
> as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
> emulated endpoint devices is undesirable as it may impact the behavior or
> performance of VFIO passthrough devices, for example, by triggering
> unnecessary invalidations on the host IOMMU.
>
> The new callback allows a vIOMMU to check and reject unsupported devices
> early during PCI device registration.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Looks a reasonable solution to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  hw/pci/pci.c         | 20 ++++++++++++++++++++
>  include/hw/pci/pci.h | 17 +++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 9693d7f10c..fa9cf5dab2 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -135,6 +135,21 @@ static void pci_set_master(PCIDevice *d, bool enable)
>      d->is_master = enable; /* cache the status */
>  }
>  
> +static bool
> +pci_device_supports_iommu_address_space(PCIDevice *dev, Error **errp)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus && iommu_bus->iommu_ops->supports_address_space) {
> +        return iommu_bus->iommu_ops->supports_address_space(bus,
> +                                iommu_bus->iommu_opaque, devfn, errp);
> +    }
> +    return true;
> +}
> +
>  static void pci_init_bus_master(PCIDevice *pci_dev)
>  {
>      AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
> @@ -1413,6 +1428,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->config_write = config_write;
>      bus->devices[devfn] = pci_dev;
>      pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (!pci_device_supports_iommu_address_space(pci_dev, errp)) {
> +        do_pci_unregister_device(pci_dev);
> +        bus->devices[devfn] = NULL;
> +        return NULL;
> +    }
>      if (phase_check(PHASE_MACHINE_READY)) {
>          pci_init_bus_master(pci_dev);
>      }
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index cf99b5bb68..dfeba8c9bd 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -417,6 +417,23 @@ typedef struct IOMMUPRINotifier {
>   * framework for a set of devices on a PCI bus.
>   */
>  typedef struct PCIIOMMUOps {
> +    /**
> +     * @supports_address_space: Optional pre-check to determine if a PCI
> +     * device can have an IOMMU address space.
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number.
> +     *
> +     * @errp: pass an Error out only when return false
> +     *
> +     * Returns: true if the device can be associated with an IOMMU address
> +     * space, false otherwise with errp set.
> +     */
> +    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
> +                                   Error **errp);
>      /**
>       * @get_address_space: get the address space for a set of devices
>       * on a PCI bus.


