Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D30CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Co-0005S5-Dn; Tue, 23 Jun 2026 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wc5Cd-0005Rc-3O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wc5Ca-0001Mj-7o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782236781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NmFGeSf2AxxWCZuyzTDcyRo2qChFQYlL07kV5yuTq0k=;
 b=THSwGEUZbrzOrwTsuuUNIBZNoB5F1zDm45+dcgLFbFX6yR2ibisFg7xiex9yhCJye6isVi
 BbeTBaevlEidxppl3Lg1szzVqnNRzOP8RhF4/TAAFRpBHUQrpcKNUuxIByODUc6CAvHxUP
 T8qTY3YZW6rWc7A8dZ8zpXwqwJosRNk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-BecbA38tOkWqWZNct57Mug-1; Tue, 23 Jun 2026 13:46:20 -0400
X-MC-Unique: BecbA38tOkWqWZNct57Mug-1
X-Mimecast-MFC-AGG-ID: BecbA38tOkWqWZNct57Mug_1782236779
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49243626f15so1109825e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782236779; x=1782841579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NmFGeSf2AxxWCZuyzTDcyRo2qChFQYlL07kV5yuTq0k=;
 b=CQclkbq1sKtO0qCzKurj6+wGRWFZN+OChNHgqVB5gQWat9rWB5pSnsw+zv30RJwGRH
 T8O7W7hBgJh8hZlwsnU+/eHerOMs+cll/ILRbTiXp0HFOGWIVPTdBeMyTgijIyNLMsk+
 5gsFctHsJAuJ1Fe9laq1/bVis/tyRYPUXCIta+1HAZ0QG8D+nPsLyTh4szKCVVSjIRau
 0VlUp12Jtfyi8gcSrovBucAaDI4JyfA0Afuh9pvE9zp2Rl94TFtJKmkeJl4Nt0v/qLrU
 +DCLnMc3SjATUOuH6aNc6mIcWYPiRs5cQoelC8OeRxuRZlThO5xU8VXhj5/7L/23jDBa
 /eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782236779; x=1782841579;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmFGeSf2AxxWCZuyzTDcyRo2qChFQYlL07kV5yuTq0k=;
 b=cT/ilVIDVZMdojc/s6MmlYZNJIBjDC9WIZYMLi0Eyk7EFwQ6QunIDzXcc0t2a/tuwD
 cpIJFlCSO/nwYkOEXuZC8I/qX23TCclKtDGDiDZ4842QfYcpCi7hsIf1u2vPrfdoBfxn
 m5gpvburK5rd+RO2IjhEq7SdAqtM2SxLzV3/owF+H9JfChz1BHMQk0rxVNYi0NA3Kquu
 phBy8BcwY9LdP7Fox/HGh1E1jkQVHJAjxRkrQvslEFfMXhJ/UiAhVGWuFEjPbZyMOj7m
 94tFZt7MqGKGSmmoUZSPZsqMn+djKmswI4nVxm26OQq3eKA+PRqIxmx5Brj/M/ARIiTd
 4czw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u4rCFgbj9zgQ8ivjES+BTHfF+DnMPJpZ+3jcoAKJpHH6QPmpS3Za9jY5xtX7AKEdg+p8vTpZwb+nW@nongnu.org
X-Gm-Message-State: AOJu0YwT9GOTqyEa0cVAgcSzPFN84Jkza1lVKv68TCGwV26T/gHWNsNx
 w0gPYU7eCIyhOW+Hl9I0RmhCWkUvi0tG+PkvLt2FycqseW7voclinaxZ7xcWzbp/oPwH/nwCqBy
 hlc50iNz99h10jxYvyDz70letbvdaVOng9LaB1qekckwMXq79eSlWlaZV
X-Gm-Gg: AfdE7cm2T6h2JyFC4UB5gnxIGLuvHx8KFDi3Qr7BbENE/2g+JtRKmgoFyESbfY/AHCH
 ddf3m235bQnEcr5cjTROcNpXcjTOIN4bm970pKXWUJj4L5SZ9so1S7nDRu5MnR9a32KbdWi3MZH
 lEa1fC9B3ZEQpu9KKu5MAJEmlXDMi1lkKNL3vu6EiDrC0izf5UyRTllCvsq3qBFimX3Gq2eVydH
 E+oPk85tVBPaAbNTWynDPvVdDe6m2NsKdd/toTakXd0uvSody4T3BFWqon535JXTWLP14itJ54o
 mPnWEU+4VfQ2cNPyEX9GLyKNJPoXgd6HT/Jqr2KeTqKnIwKNwOvBB7qeCdKoD83oerMd4M8AtJZ
 +sBNjJ813xxLNNVieND9hGdEvXGwm6d4APxEDlw4+mjYccVuxuLD5mS8=
X-Received: by 2002:a05:600c:5493:b0:492:1ea2:6258 with SMTP id
 5b1f17b1804b1-49240e7b049mr303327535e9.33.1782236778689; 
 Tue, 23 Jun 2026 10:46:18 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:492:1ea2:6258 with SMTP id
 5b1f17b1804b1-49240e7b049mr303327045e9.33.1782236778207; 
 Tue, 23 Jun 2026 10:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm414179515e9.2.2026.06.23.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:46:17 -0700 (PDT)
Message-ID: <d31857d4-961f-4456-9f88-ed7e9a4a990b@redhat.com>
Date: Tue, 23 Jun 2026 19:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/pci: Add ats property
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
 <20260623023540.836825-3-nathanc@nvidia.com>
 <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/23/26 19:01, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Nathan Chen <nathanc@nvidia.com>
>> Sent: 23 June 2026 03:36
>> To: qemu-devel@nongnu.org
>> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
>> Zhenzhong Duan <zhenzhong.duan@intel.com>; Alex Williamson
>> <alex@shazbot.org>; Cédric Le Goater <clg@redhat.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>
>> Subject: [PATCH v3 2/2] vfio/pci: Add ats property
>>
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>> extended capability in config space but we should not expose it (ats=off,
>> or ats=auto and kernel reports
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>> the capability so the guest does not see it.
>>
>> If ATS is explicitly requested but not supported by the kernel, fail
>> device realize.
>>
>> This aligns with the kernel's per-device effective ATS reporting and allows
>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>
>> Emit a warning when ats=on is requested but the physical device does not
>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.h |  1 +
>>   hw/vfio/pci.c | 88
>> ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 85 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c3a1f53d35..f2934f2d84 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>>       bool clear_parent_atomics_on_exit;
>>       bool skip_vsc_check;
>>       uint16_t vpasid_cap_offset;
>> +    OnOffAuto ats;
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>       VFIOPCICPR cpr;
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9c06b25e63..c0436b4c04 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2546,10 +2546,58 @@ static bool
>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>       return true;
>>   }
>>
>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, based
>> on
>> + * whether it was enabled on the command line and whether it is supported
>> + * according to the kernel.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_needed.
>> + *
>> + * Returns false only when ats=on is explicitly requested but the kernel
>> + * reports it is not supported. Returns true in all other cases.
>> + */
>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>> +                                                 bool *ats_needed, Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc;
>> +    bool ats_supported;
>> +    *ats_needed = false;
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>> +        return true;
>> +    }
>> +
>> +    *ats_needed = true;
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>> +    if (!hiodc || !hiodc->support_ats) {
>> +        return true;
>> +    }
>> +
>> +    ats_supported = hiodc->support_ats(hiod);
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>> +        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
>> +        *ats_needed = false;
>> +        return false;
>> +    }
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_AUTO && !ats_supported) {
>> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
>> +                    "ATS capability will be masked");
>> +    }
> 
> This will be slightly misleading if dev doesn't have the ATS CAP at all.
> Isn't it?  I think, the best place to do this warning is below where we know
> ats_cap_present is set or not.
> 
> Thanks,
> Shameer
> 
>> +
>> +    *ats_needed = ats_supported;
>> +    return true;
>> +}
>> +
>> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> +    bool ats_cap_present = false;
>>       Error *err = NULL;
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>> @@ -2635,7 +2683,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>            */
>>           case PCI_EXT_CAP_ID_PASID:
>>               pasid_cap_added = true;
>> -            /* fallthrough */
>> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            break;
>> +        case PCI_EXT_CAP_ID_ATS:
>> +            ats_cap_present = true;
>> +            /*
>> +             * If ATS is requested and supported according to the kernel, add
>> +             * the ATS capability. If not supported according to the kernel or
>> +             * disabled on the qemu command line, omit the ATS cap.
>> +             */
>> +            if (ats_needed) {
>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            }
>> +            break;
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>> @@ -2646,6 +2706,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>           error_report_err(err);
>>       }
>>
>> +    if (ats_needed && !ats_cap_present) {
>> +        warn_report("vfio-pci: ats=on requested, but host device has no "
>> +                    "ATS extended capability");
>> +    }

"ats=on requested" is wrong here. OnOffAuto_str() could be used instead.

Also, ats_needed is true for "ats=auto" too, and since it's the default
setting, and most devices lack ATS and any modern host kernel support it,
this warning will be emitted for nearly all devices.

How about :

   if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
       warn_report("vfio-pci: ats=on requested, but host device has no "
                   "ATS extended capability");
   }

?

Thanks,

C.


>> +
>>       /* Cleanup chain head ID if necessary */
>>       if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>>           pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>> @@ -2657,6 +2722,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>> +    bool ats_needed = false;
>>
>>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>>           !pdev->config[PCI_CAPABILITY_LIST]) {
>> @@ -2667,7 +2733,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice
>> *vdev, Error **errp)
>>           return false;
>>       }
>>
>> -    vfio_add_ext_cap(vdev);
>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
>> +        return false;
>> +    }
>> +
>> +    vfio_add_ext_cap(vdev, ats_needed);
>>       return true;
>>   }
>>
>> @@ -3815,6 +3885,7 @@ static const Property vfio_pci_properties[] = {
>>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check,
>> true),
>>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>>                          vpasid_cap_offset, 0),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats,
>> ON_OFF_AUTO_AUTO),
>>   };
>>
>>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>> @@ -3966,13 +4037,22 @@ static void vfio_pci_class_init(ObjectClass *klass,
>> const void *data)
>>                                             "destination when doing live "
>>                                             "migration of device state via "
>>                                             "multifd channels");
>> -   object_class_property_set_description(klass, /* 11.0 */
>> +    object_class_property_set_description(klass, /* 11.0 */
>>                                             "x-vpasid-cap-offset",
>>                                             "PCIe extended configuration space offset at which to
>> place a "
>>                                             "synthetic PASID extended capability when PASID is
>> enabled via "
>>                                             "a vIOMMU. A value of 0 (default) places the capability
>> at the "
>>                                             "end of the extended configuration space. The offset
>> must be "
>>                                             "4-byte aligned and within the PCIe extended
>> configuration space");
>> +    object_class_property_set_description(klass, /* 11.1 */
>> +                                          "ats",
>> +                                          "Control guest visibility of the ATS PCIe extended
>> capability. "
>> +                                          "Valid values are on, off, and auto (default). "
>> +                                          "'off' always masks ATS. "
>> +                                          "'on' requires ATS support for the device and fails realize
>> if the "
>> +                                          "host kernel reports ATS as unavailable for this device. "
>> +                                          "'auto' masks ATS only when the host kernel reports "
>> +                                          "ATS as unavailable");
>>   }
>>
>>   static const TypeInfo vfio_pci_info = {
>> --
>> 2.43.0
> 


