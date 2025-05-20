Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F1DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGmA-0002oK-1E; Tue, 20 May 2025 02:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGm8-0002mD-C3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGm6-00071J-8t
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747723708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TXCENeLhgQUuZpnmRSrDFgMWlN+VjlmCtmxnpOUV5HE=;
 b=ElwrAEs/mYq+8JvKuLVnP3OzMLFUd884lz3kJT5BrSJYCEO7rm6nrHwYSoR1g323mnGyAB
 iVLOhd0tRLfc6D2QPcPnBrFdEOruyAeADyG1QEZE89lpkOah+jB/CHBEQDEFzEovKM9EBl
 p5iRcBZpC5SCxoLkHyajtIjhKp6/x0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FRxrtrFvNBiSWs2dG_SmZQ-1; Tue, 20 May 2025 02:48:27 -0400
X-MC-Unique: FRxrtrFvNBiSWs2dG_SmZQ-1
X-Mimecast-MFC-AGG-ID: FRxrtrFvNBiSWs2dG_SmZQ_1747723706
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso782169f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 23:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747723706; x=1748328506;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXCENeLhgQUuZpnmRSrDFgMWlN+VjlmCtmxnpOUV5HE=;
 b=jNsMHwkyFQioHHe50G7Ln/1SiyazQJs8191uQhH7MYWoYTy/DWOhxQ2MqkalZZ5QBF
 axst/D4dKEk8PdTHfbfOm11zp4QgWwrIMEGytpOpwaLvg0f9gvZGOzWYYy42HOB1FvnD
 97LXnfXbOgej3L4A42i1wctRXKzLkJPpMWnvSjSWEmjcqgk5G2IPmEk0kEE6zwpQCQ1I
 jTVepkzVyGOH2iwWJQz+M52TkCROMcJG+G3gp45mp45hRzoU5SzIzV1tdoseCfck0Sxb
 pbUQEJUbJPhtoescEEdPK9i+xhMxowxH/LT5dYyqTBNAeedp8D70f56dbIEAcTjZLTLF
 Pk0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd+XhniapMh3Q/GuUeNGnL9qbej8gdCHc8H5r+hvmV3wOzSRjLxGVdcx32eF/C3LLr6K45ioeTu1z3@nongnu.org
X-Gm-Message-State: AOJu0YzAiNOc3T0tRX7u9JvyHuem/LB9seJvCVMx0g+kng8051z0Sy9T
 fs2RzI8Jaz067GvUUb0vYLmxN8hpyodUUbvc4SNGzyasvNnW6nP5fC00bPTNwF63IyysHs/HKn0
 cVj12IAzB3GUfhta55jM9o1S/omdDdr6v9CTk6SUehCbe/C3dl+oJ2Lw1
X-Gm-Gg: ASbGnctu4Ey3VilWHq1Nm7cn8S4fJUS8QTqzE7cRwPMfkjYmXlqVwdnHJG4xpxYTDdf
 Vw42cjGzHDgz5fE9TMoFiQb11RYu0zAHg9chmh73PXTrtTb5HunSj6d/3+/CcylDN3LYG8hlYK4
 wc/Rp4X+IQDeVPF+fo0zPAZ5M4iVWvxcsoxFsUuyDeuAWSIwdjp4o4Vr/nKkiq1LbrwMao0STls
 7+YnExAirIU2wrzgDgJ1QHWPvQP8t+Rgk2WmIuZeNDk7FFum/fct0F0n/ZY6BsD0FXBkVIkXYDZ
 4w2pCMjNFyZvi6Atj1CiglWk9M4+EeE+acRUAaUfNvb4rDeiMw==
X-Received: by 2002:a5d:5848:0:b0:3a0:b1ff:8542 with SMTP id
 ffacd0b85a97d-3a35c834d4dmr14922655f8f.8.1747723705907; 
 Mon, 19 May 2025 23:48:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH91KknVjcsHsTQpiolmNdbCNk1G9S1rozbO+9l9j6lDMBf7v49xjFUgPS0b8ay/4MmOS2wg==
X-Received: by 2002:a5d:5848:0:b0:3a0:b1ff:8542 with SMTP id
 ffacd0b85a97d-3a35c834d4dmr14922629f8f.8.1747723705523; 
 Mon, 19 May 2025 23:48:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a365bc0b5esm11592343f8f.9.2025.05.19.23.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 23:48:25 -0700 (PDT)
Message-ID: <bf1d2c34-3995-49ad-a259-2c4f7380b2fc@redhat.com>
Date: Tue, 20 May 2025 08:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 15/42] vfio-pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-16-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-16-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR, and do not complain if the
> kernel's PCI config space changes for non-emulated bits between the
> vmstate save and load, which can happen due to ongoing interrupt activity.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              |  6 ++++++
>   include/hw/vfio/vfio-cpr.h |  2 ++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 0e59612..6ea8e9f 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -8,6 +8,8 @@
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/pci.h"
> +#include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
>   
> @@ -37,3 +39,32 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>   {
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
> +
> +/*
> + * The kernel may change non-emulated config bits.  Exclude them from the
> + * changed-bits check in get_pci_config_device.
> + */
> +static int vfio_cpr_pci_pre_load(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int size = MIN(pci_config_size(pdev), vdev->config_size);
> +    int i;
> +
> +    for (i = 0; i < size; i++) {
> +        pdev->cmask[i] &= vdev->emulated_config_bits[i];
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vfio_cpr_pci_vmstate = {
> +    .name = "vfio-cpr-pci",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .pre_load = vfio_cpr_pci_pre_load,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a1bfdfe..4aa83b1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3344,6 +3344,11 @@ static void vfio_pci_reset(DeviceState *dev)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>   
> +    /* Do not reset the device during qemu_system_reset prior to cpr load */
> +    if (vdev->vbasedev.cpr.reused) {
> +        return;
> +    }
> +

hw/pci/pci.c does :

     if (cpr_is_incoming()) {
         return;
     }

So, to be consistent, I think VFIO should do the same.


Thanks,

C.




>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
>       vfio_pci_pre_reset(vdev);
> @@ -3513,6 +3518,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif
> +    dc->vmsd = &vfio_cpr_pci_vmstate;
>       dc->desc = "VFIO-based PCI device assignment";
>       pdc->realize = vfio_realize;
>   
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index d6d22f2..e93600f 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -49,4 +49,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>   bool vfio_cpr_ram_discard_register_listener(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +extern const VMStateDescription vfio_cpr_pci_vmstate;
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */


