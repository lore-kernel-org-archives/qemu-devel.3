Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA4CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTCq-0000JP-Bk; Tue, 16 Jun 2026 08:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZTCl-0000Im-UZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZTCj-0002lz-Bo
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781614063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RvrDjji3gQ81LRx3SpCw8TAIahCeB3vPlttodJFLvHY=;
 b=RcoubSKWRLGQWEChNrRmKdxqQ+7UUeJz/fWXNywBsDK0wwgqn4wRNNH21oMRlrZAkaIT36
 FkHbx5yyd7NMOWb4SU0weuGS9bjwudcNX+qhkJQOEHIMUjO+H4SD6av0YZgiTQceW+T77c
 Td+2jqcfgcCHB2zDwdNwmCP9DmvsjkY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-X2uEEMhtP8OSXzsGAfuIwg-1; Tue, 16 Jun 2026 08:47:42 -0400
X-MC-Unique: X2uEEMhtP8OSXzsGAfuIwg-1
X-Mimecast-MFC-AGG-ID: X2uEEMhtP8OSXzsGAfuIwg_1781614061
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4600c8cb13aso3332890f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781614061; x=1782218861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RvrDjji3gQ81LRx3SpCw8TAIahCeB3vPlttodJFLvHY=;
 b=SOsxqIR3UNED1HlaoPonXgQ9Cf4oIqH5uL4TNdpOtMzHtrzY11TusilCAmrxpZZENT
 DAVA41rBZjikf90r6/6Kyn1W2V3gir8lTKd4ILaK4VHXCWBhYA6Ut4gsLu6HomzLWpIf
 xmtptLC1G4hc+kXMmK6F1p/UYYvIBU/1ihGBRGjVzLszv35+VBV2A4QUF6VrBMjQKVuW
 xDUvFRhpM9PvAw+784YzDv0SmZB70WxjaJU1T8VCd4TzwB2UzK4vK7BBm8n8EIJYMHq4
 rWlBcO00DieXIBUeIXVJRrXV6UHNIJUcDcHWS/iCyu4qPHGLc/URRgegtdr0dI+HDhOr
 tbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614061; x=1782218861;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvrDjji3gQ81LRx3SpCw8TAIahCeB3vPlttodJFLvHY=;
 b=EDHAxu6xmJeBpQ7X7DpH9EwUzr+97/KbpPidMH1ZNaqtEXUXIt5hwwsNsuyeh4YfSi
 StoQyQRywAzb05psDP6FOzwnn/ZPwuyzSqnhbZfbZ7i+s1FZFLvjh1IHJCSszeIWLLTv
 7QxVu7erctamXFABwIbRlZG1Xr83rpWbdtGq3511xkaDB8d03hRIifdnfFsm7TPDRh95
 MrMCHBg3ZntH7TXkhNuA74ln4OMeipS3VHphESPrkjdddEGpr1qdbhrNiuFzkZD0x5ni
 SfAB9Q/LlZCm2pBXJmDyGY237L0MuDa7KVjcSDFFCPiKJJvHAnUnKhq2/z3fAvcFNQRv
 5E+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YBYDBi07bSI2cg462ecg7UGERdXyaAyEW37EPLBw4RfCug7oPAY/uFazZl2bj4Io9iyNBAW4j2lkW@nongnu.org
X-Gm-Message-State: AOJu0Yx+Ux31MPIVx2zIrLl1daBdRPqAEMDZ61S7wn2nGDaxDwxRrAy+
 srF8NGAwAIlPe/PNByhV/IUsTbmSqnLVADG+AJP+tFgO/+6FDf7Po5iPNpxhrHJdPB5AnhagBhv
 hgcB6NmSBRJezQIgRQsjYWRE9e2zjVFKd65tF405UhAT/trWHK17mTmfh
X-Gm-Gg: Acq92OFus7/WcEsLTWH16oFOBH0oIWNn8/ao7XFh88uHIPp6m+Xzg824h1Eo7K41sMD
 F3wIoQS/4rcUjCaI9XBmnTZos1yg8kPuicQFElMDhbGspeQfDmb/z3+1+t4LEqRsbCyBBrMH3t6
 mh325K4TPaiWCNUdyzqepJVosiPj53u4iYizQxML54CwVnKk+B8rJ6TTxJKsfqbb3b8YfOK/5wJ
 0dp0HKZg2PJ8UFv6yOScFZj0DchyF6KS+lksMcvweovcfaua6exLIvGJo2xCnF+xJxED9c/obVP
 /eW+QlIfZ0u5FoKMegNYaMlKTnp0HzMPYXGT9BTLFieTW3jAd19AiRyiX0xY0YHwl+pxRnlXwl0
 1KhgXJL4s545+TK2h/PD8P31ohGUKGZrzUMxyIUI94cwI85uuuxl2YW0kmUa4
X-Received: by 2002:a05:600c:c0c3:10b0:490:d079:2919 with SMTP id
 5b1f17b1804b1-490ec4dac1cmr208686275e9.14.1781614061204; 
 Tue, 16 Jun 2026 05:47:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:490:d079:2919 with SMTP id
 5b1f17b1804b1-490ec4dac1cmr208685805e9.14.1781614060669; 
 Tue, 16 Jun 2026 05:47:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f264333sm45676636f8f.4.2026.06.16.05.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:47:40 -0700 (PDT)
Message-ID: <363ad338-7ae3-4dd1-a5ed-c87d76abce52@redhat.com>
Date: Tue, 16 Jun 2026 14:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/pci: Add ats property
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-3-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260615204849.3659647-3-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/15/26 22:48, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
> extended capability in config space but we should not expose it (ats=off,
> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
> the capability so the guest does not see it.
> 
> If ATS is explicitly requested but not supported by the kernel, fail
> device realize.
> 
> This aligns with the kernel's per-device effective ATS reporting and allows
> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
> 
> Introduce a new compat for the changed default for vfio-pci device ATS
> property, from "on" to "auto".
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/vfio/pci.h     |  1 +
>   hw/core/machine.c |  1 +
>   hw/vfio/pci.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..f2934f2d84 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>       bool clear_parent_atomics_on_exit;
>       bool skip_vsc_check;
>       uint16_t vpasid_cap_offset;
> +    OnOffAuto ats;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>       VFIOPCICPR cpr;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4d8b15d99e..c0cdf7c9da 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },
>       { "tpm-crb", "x-allow-chunk-migration", "off" },
> +    { "vfio-pci", "ats", "on" },


This compat "ats=on" for old machine types (11.0 and below) should preserve
the old guest-visible behavior : ATS is always advertised regardless of
kernel capability.

Now, if the kernel is upgraded and reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED,
the VM will now fail to realize the vfio-pci device, fail to boot and the
backward compatibility across machine types is broken ... Tough.

We could argue that the previous behavior was wrong but should be "bug"
compatible too.


So, we could  :

1. ignore,
2. use a compat "ats=auto", which would hide ATS reported unsupported
    in new kernels,
3. add a legacy compat "x-ats-strict=off" property to warn but not fail
    realize, and keep ATS enabled.

In any case, we need a warning at start time.

Ideas ?



>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..0f592ada89 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2546,7 +2546,49 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> +/*
> + * Determine whether ATS capability should be advertised for @vdev, based on
> + * whether it was enabled on the command line and whether it is supported
> + * according to the kernel.
> + *
> + * Store whether ATS capability should be advertised in @ats_needed.
> + *
> + * Returns false only when ats=on is explicitly requested but the kernel
> + * reports it is not supported. Returns true in all other cases.
> + */
> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
> +                                                 bool *ats_needed, Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc;
> +    bool ats_supported;
> +    *ats_needed = false;
> +
> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
> +        return true;
> +    }
> +
> +    *ats_needed = true;
> +    if (!hiod) {
> +        return true;
> +    }
> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc || !hiodc->support_ats) {
> +        return true;
> +    }
> +
> +    ats_supported = hiodc->support_ats(hiod);
> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
> +        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
> +        *ats_needed = false;
> +        return false;
> +    }
> +
> +    *ats_needed = ats_supported;
> +    return true;
> +}
> +
> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
>       bool pasid_cap_added = false;
> @@ -2635,7 +2677,18 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>            */
>           case PCI_EXT_CAP_ID_PASID:
>               pasid_cap_added = true;
> -            /* fallthrough */
> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            break;
> +        case PCI_EXT_CAP_ID_ATS:
> +            /*
> +             * If ATS is requested and supported according to the kernel, add
> +             * the ATS capability. If not supported according to the kernel or
> +             * disabled on the qemu command line, omit the ATS cap.
> +             */
> +            if (ats_needed) {
> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            }
> +            break;
>           default:
>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>           }
> @@ -2657,6 +2710,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> +    bool ats_needed = false;
>   
>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>           !pdev->config[PCI_CAPABILITY_LIST]) {
> @@ -2667,7 +2721,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    vfio_add_ext_cap(vdev);
> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
> +        return false;
> +    }
> +
> +    vfio_add_ext_cap(vdev, ats_needed);
>       return true;
>   }
>   
> @@ -3815,6 +3873,7 @@ static const Property vfio_pci_properties[] = {
>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>                          vpasid_cap_offset, 0),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
>   };
>   
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> @@ -3973,6 +4032,15 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "a vIOMMU. A value of 0 (default) places the capability at the "
>                                             "end of the extended configuration space. The offset must be "
>                                             "4-byte aligned and within the PCIe extended configuration space");
> +   object_class_property_set_description(klass, /* 11.1 */
> +                                          "ats",
> +                                          "Control guest visibility of the ATS PCIe extended capability. "
> +                                          "Valid values are on, off, and auto (default). "
> +                                          "'off' always masks ATS. "
> +                                          "'on' requires ATS support for the device and fails realize if the "
> +                                          "host kernel reports ATS as unavailable for this device. "
> +                                          "'auto' masks ATS only when the host kernel reports "
> +                                          "ATS as unavailable");

if you resend, could you please fix the alignment of the two
object_class_property_set_description block() above.


Thanks,

C.





>   }
>   
>   static const TypeInfo vfio_pci_info = {


