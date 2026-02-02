Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1356E73170
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu7b-0004cZ-R5; Mon, 02 Feb 2026 08:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vmu7Z-0004br-8X
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:37:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vmu7V-0003I3-9A
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770039456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ldoOxczssnmPEciPbjEurlgZVBkcrHKWVV5+M/dwwYg=;
 b=ZXuryQNkHyT1rq6X2yFthFT7yZpGx4JAA5WQQbfWCJAOOFvbKYX395NtGoO7tSIGPrDj9n
 J1xerJIGsWRolBd0KJ+onvR7PZOFCHormhVRmbjz218Mor5eFplKVId50GXxVb0iQKz3J3
 yk7ObLs3t5qgKQbucR8/3O1Y2HB6Jc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-F_I0YmTEMNucnZbSaoQGHQ-1; Mon, 02 Feb 2026 08:37:34 -0500
X-MC-Unique: F_I0YmTEMNucnZbSaoQGHQ-1
X-Mimecast-MFC-AGG-ID: F_I0YmTEMNucnZbSaoQGHQ_1770039453
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435a11575ecso4496404f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770039453; x=1770644253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ldoOxczssnmPEciPbjEurlgZVBkcrHKWVV5+M/dwwYg=;
 b=rDoihfHDLsOrpAcTwkii77Irf3xV3R77IjrE4XCtubUIztEEAbwECI9vVe4E3ope2l
 iykV84vIIN1NjGy0BGl4Kv6zL6dRaSI9iD3N9gVbGguMazAzQHNwnw53ov1qYI6QetUZ
 mRfARs66W6frean5ntqxVjOSR/wCWkSomMkUdtm2BJlWhlqFtwmraVh9DdTmbIgVPMXc
 3uY3qKp8UJ1jU55q1+lU0BxEUfSI2TMZa6m0qroymFJ6QxXMU3FPZmGq6uoplz6br8CT
 ZMvMPV2tZhJf5v51sBjtv9oCYMt/wQ4qTDCOoxfE3IB5ulfbAfW+y+sH4JpD3wOTRGwo
 goJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039453; x=1770644253;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldoOxczssnmPEciPbjEurlgZVBkcrHKWVV5+M/dwwYg=;
 b=L6B5/X3e2WyOin4XkxewWJyqA8bAQO0SMh8utyq2Koou8QmVQs5fvULP1JIy9xacTK
 tB8iJX1iPaRu2XwyMaYcOpIbpQq1idkHgpLNqrKa6qVrC7J/L20P9hN1HQhneOCp0rWp
 CxJkhK0nr+BBlpxR1fKaIegdbgKKV8OYR+EW1UNch761QaPlJ7R6FkExWvBa31jrhfIm
 72ryBKcTjOaIiILcSv+RjlCwAmfK8BgjrA6J+yWZcqyv0uD4+RPWUZLBvSsq6H2+1Z2B
 HCOj/VSa91V69e0f919h64l0C3MAEaDQwQIqBfpLIUTMTb/SiVv205g1PTaiLXSRbPCC
 paQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPeg1APOFCD8XAH2LEKs8gR2Vo/Ldd0rJRsn6XfpBfwJTNVIkEkLh1F9DjpJEJV/W38GPUqoc+KXyt@nongnu.org
X-Gm-Message-State: AOJu0YymeCIxOAJB73sWs26OD4OxiI0REUaBDYlJL+jDHXcuw+Bb3Bjq
 3zBwaOasSTN6v8Q4Ql/BRsDLCtaLc2vC749OXgZ2RL8Bu6dBRw5ZOraFecRTKjE9KQyzpQ+Tlv9
 aUqV7eDmJTg8ZqeOU+2cOJ3x3FLC7Aq/p9HSIfb5+AifXy/xiDUhlclX+qNKqnLY8
X-Gm-Gg: AZuq6aJCRPBof2CW3Rr2ez4H8Fee+hCjrMRsQt6a1ev9WtLzQzumyO+ZsQnt+MuNlME
 1y1Q2WEQRQC4hTfKImTEFeE6H4PhphdvIAfbcmStF7oThVMZUDK6OJ+w3CnDDW4AC8dgFLbbdkl
 WXu8blzXtQY1Xwx6DCExESGakTi1YG34jBfyW3ocuJTqXll00+zFeGh43/iIzcIipxsRLG4bhdt
 VQaI6Iivs9pcrZ0pWP8w/8570aQUnLq0nsZ4zbvOvWnWPlsE5QIDR6Ha4Isu5qTGyGFlNYkDXyb
 414pCsCwZm1t73guNvt1+2LdR6j3/jdg+Tp6bhQq3CyUtmaCmQ41e9aXZDsl59G4lThJ+U6yORR
 qXorCnSQc7oxEVjK+8zpv1OJU+lrFg3B5BsFDNJnZYuJjRbsO
X-Received: by 2002:a05:600c:82cd:b0:482:ef72:5781 with SMTP id
 5b1f17b1804b1-482ef725c13mr66069955e9.25.1770039453021; 
 Mon, 02 Feb 2026 05:37:33 -0800 (PST)
X-Received: by 2002:a05:600c:82cd:b0:482:ef72:5781 with SMTP id
 5b1f17b1804b1-482ef725c13mr66069605e9.25.1770039452438; 
 Mon, 02 Feb 2026 05:37:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee687sm707684275e9.5.2026.02.02.05.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:37:32 -0800 (PST)
Message-ID: <7a4e3249-be95-4099-b487-2aa6e627d265@redhat.com>
Date: Mon, 2 Feb 2026 14:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
To: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <20260112091641.4d86d8e5@shazbot.org>
 <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52839D25259B76151B3002ABFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB5283A1315E28D8A347AF222EFA9AA@CH0PR12MB5283.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH0PR12MB5283A1315E28D8A347AF222EFA9AA@CH0PR12MB5283.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

On 2/2/26 10:11, Pekovic, Manojlo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Alex,
> 
> Is there any new info on this issue?


Please send a v2 of the patch.

Thanks,

C.

> 
> Thanks in advance,
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
> 
> 
> 
> -----Original Message-----
> From: Pekovic, Manojlo
> Sent: Tuesday, January 20, 2026 5:01 PM
> To: 'Alex Williamson' <alex@shazbot.org>; 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
> Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; 'Cédric Le Goater' <clg@redhat.com>
> Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
> 
> Hi Alex,
> 
> Here is the second part of the patch.
> I didn't take into consideration the non-vfio-device in my first patch.
> I fixed it by using standard that I saw in the code for getting vdev in this scenario, hope that it is satisfactory now
> 
> Previously, PCIe Atomic Ops support was only enabled for single function devices due to potential conflicting capabilities between functions.
> This patch enables atomic ops for multifunction devices by finding the common subset of atomic capabilities supported by all functions.
> 
> The implementation checks all functions on the same slot and advertises only the atomic operations supported by all of them, ensuring compatibility across the multifunction device.
> 
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>   hw/vfio/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 6a6c8f1807..a6723063ab 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1931,6 +1931,34 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>       return mask;
>   }
> 
> +/* Returns biggest subset of supported atomic ops of multifunction
> +device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
> +                                                    PCIBus *bus) {
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot = PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn = PCI_DEVFN(slot, fn);
> +        func_dev = pci_find_device(bus, pci_bus_num(bus),
> + target_devfn);
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        func_vdev = VFIO_PCI(func_dev);
> +
> +        common_mask &= vfio_get_atomic_cap(func_vdev);;
> +    }
> +
> +    return common_mask;
> +}
> +
>   static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)  {
>       PCIBus *bus = pci_get_bus(&vdev->pdev); @@ -1941,15 +1969,12 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>       /*
>        * PCIe Atomic Ops completer support is only added automatically for single
>        * function devices downstream of a root port supporting DEVCAP2.  Support
> -     * is added during realize and, if added, removed during device exit.  The
> -     * single function requirement avoids conflicting requirements should a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * is added during realize and, if added, removed during device exit.
>        */
>       if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>           pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>           pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>           return;
>       }
> 
> @@ -1961,8 +1986,18 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>                                PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
>           return;
>       }
> +
> 
> -    mask = vfio_get_atomic_cap(vdev);
> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Only process the through the root function
> +         * We get through here only on function 0,
> +         * through check vdev->pdev.devfn
> +         */
> +        mask = vfio_get_multifunction_atomic_cap(vdev, bus);
> +    } else {
> +        mask = vfio_get_atomic_cap(vdev);
> +    }
> 
>       if (!mask) {
>           return;
> --
> 2.43.0
> 
> 
> Thanks and Best Regards,
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
> 
> 
> 
> -----Original Message-----
> From: Pekovic, Manojlo
> Sent: Tuesday, January 20, 2026 5:00 PM
> To: 'Alex Williamson' <alex@shazbot.org>; qemu-devel@nongnu.org
> Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; Cédric Le Goater <clg@redhat.com>
> Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
> 
> + others, on accident
> 
> 
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
> 
> 
> 
> -----Original Message-----
> From: Pekovic, Manojlo
> Sent: Tuesday, January 20, 2026 4:59 PM
> To: Alex Williamson <alex@shazbot.org>
> Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
> 
> Hi Alex,
> Hope you are good. Sorry for such a late response.
> 
> Appreciate the comments
> 
> I have split up the fix into two patches as you said, and will be sending them into two emails so it's easier for you to check them In this mail, I am sending the helper patch and in the next one the multifunction
> 
> Extract the code that reads and converts VFIO atomic capabilities into a separate helper function. This is a preparatory refactor with no functional change, making the code easier to extend for multifunction device support.
> 
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>   hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 14bcc725c3..6a6c8f1807 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1900,13 +1900,41 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
>       vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);  }
> 
> -static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>   {
>       struct vfio_device_info_cap_pci_atomic_comp *cap;
>       g_autofree struct vfio_device_info *info = NULL;
> +    struct vfio_info_cap_header *hdr;
> +    uint32_t mask = 0;
> +
> +    info = vfio_get_device_info(vdev->vbasedev.fd);
> +    if (!info) {
> +        return mask;
> +    }
> +
> +    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
> +    if (!hdr) {
> +        return mask;
> +    }
> +
> +    cap = (void *)hdr;
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +    }
> +
> +    return mask;
> +}
> +
> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
>       PCIBus *bus = pci_get_bus(&vdev->pdev);
>       PCIDevice *parent = bus->parent_dev;
> -    struct vfio_info_cap_header *hdr;
>       uint32_t mask = 0;
>       uint8_t *pos;
> 
> @@ -1934,26 +1962,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>           return;
>       }
> 
> -    info = vfio_get_device_info(vdev->vbasedev.fd);
> -    if (!info) {
> -        return;
> -    }
> -
> -    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
> -    if (!hdr) {
> -        return;
> -    }
> -
> -    cap = (void *)hdr;
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> -    }
> +    mask = vfio_get_atomic_cap(vdev);
> 
>       if (!mask) {
>           return;
> --
> 2.43.0
> 
> 
> 
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
> 
> 
> 
> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Monday, January 12, 2026 5:17 PM
> To: Pekovic, Manojlo <Manojlo.Pekovic@amd.com>
> Cc: qemu-devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com; Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>
> Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
> 
> On Tue, 9 Dec 2025 14:32:50 +0000
> Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:
> 
>> Previously, PCIe Atomic Ops support was only enabled for single
>> function devices due to potential conflicting capabilities between
>> functions. This patch enables atomic ops for multifunction devices by
>> finding the common subset of atomic capabilities supported by all
>> functions.
>>
>> The implementation checks all functions on the same slot and
>> advertises only the atomic operations supported by all of them,
>> ensuring compatibility across the multifunction device.
>>
>> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
>> ---
>>   hw/vfio/pci.c | 104
>> +++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 77 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
>> 14bcc725c3..9d1faeabff 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
>>       vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
>> }
>>
>> -static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>> +static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>>   {
>> -    struct vfio_device_info_cap_pci_atomic_comp *cap;
>>       g_autofree struct vfio_device_info *info = NULL;
>> +    struct vfio_info_cap_header *hdr;
>> +    struct vfio_device_info_cap_pci_atomic_comp *cap;
>> +    uint32_t mask = 0;
>> +
>> +    info = vfio_get_device_info(vdev->vbasedev.fd);
>> +    if (!info) {
>> +        return mask;
>> +    }
>> +
>> +    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
>> +    if (!hdr) {
>> +        return mask;
>> +    }
>> +
>> +    cap = (void *)hdr;
>> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
>> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
>> +    }
>> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
>> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
>> +    }
>> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
>> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
>> +    }
>> +
>> +    return mask;
>> +}
>> +
>> +/* Returns biggest subset of supported atomic ops of multifunction
>> +device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
>> +                                                    PCIBus *bus) {
>> +    PCIDevice *func_dev;
>> +    VFIOPCIDevice *func_vdev;
>> +    int slot = PCI_SLOT(vdev->pdev.devfn);
>> +    int target_devfn;
>> +    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
>> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
>> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
>> +
>> +    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
>> +        target_devfn = PCI_DEVFN(slot, fn);
>> +        func_dev = pci_find_device(bus, pci_bus_num(bus), target_devfn);
>> +        uint32_t func_mask = 0;
>> +
>> +        if (!func_dev) {
>> +            continue;
>> +        }
>> +
>> +        func_vdev = (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev),
>> +                                                            TYPE_VFIO_PCI);
>> +        if (!func_vdev) {
>> +            continue;
>> +        }
> 
> Why is it justified to continue here?  It at least seems worthy of a comment why we can ignore non-vfio-pci devices relative to the advertised atomic op support.
> 
>> +
>> +        func_mask = vfio_get_atomic_cap(func_vdev);
>> +
>> +        common_mask &= func_mask;
> 
> Factor out func_mask.
> 
>> +    }
>> +
>> +    return common_mask;
>> +}
>> +
>> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
>>       PCIBus *bus = pci_get_bus(&vdev->pdev);
>>       PCIDevice *parent = bus->parent_dev;
>> -    struct vfio_info_cap_header *hdr;
>>       uint32_t mask = 0;
>>       uint8_t *pos;
>>
>>       /*
>>        * PCIe Atomic Ops completer support is only added automatically for single
>>        * function devices downstream of a root port supporting DEVCAP2.  Support
>> -     * is added during realize and, if added, removed during device exit.  The
>> -     * single function requirement avoids conflicting requirements should a
>> -     * slot be composed of multiple devices with differing capabilities.
>> +     * is added during realize and, if added, removed during device exit.
>>        */
>>       if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>>           pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>>           pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
>> -        vdev->pdev.devfn ||
>> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +        vdev->pdev.devfn) {
>>           return;
>>       }
>>
>> @@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>>           return;
>>       }
>>
>> -    info = vfio_get_device_info(vdev->vbasedev.fd);
>> -    if (!info) {
>> -        return;
>> -    }
>> -
>> -    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
>> -    if (!hdr) {
>> -        return;
>> -    }
>> -
>> -    cap = (void *)hdr;
>> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
>> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
>> -    }
>> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
>> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
>> -    }
>> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
>> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> 
> Nit, it would have been cleaner to factor out this helper as a precursor to multifunction support.  Thanks,
> 
> Alex
> 
>> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +        /*
>> +         * Only process the through the root function
>> +         * We get through here only on function 0,
>> +         * through check vdev->pdev.devfn
>> +         */
>> +        mask = vfio_get_multifunction_atomic_cap(vdev, bus);
>> +    } else {
>> +        mask = vfio_get_atomic_cap(vdev);
>>       }
>>
>>       if (!mask) {
> 


