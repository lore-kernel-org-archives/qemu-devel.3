Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC77C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSai7-0004UV-Hd; Fri, 20 Jun 2025 08:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSahy-0004Ts-TF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSahv-0006us-UN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750421937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTidBLUbi/9klXUN/dAGQIidlUPELQGvFavfxGoGihE=;
 b=HO7/3LLdL6ShjqiZV+wOSPCcRb6XOCN5yAsun2aJLCSeuwBf8aBWohVfbd7eOzGGjWorQ+
 aJn/rkkTZ6yDA4FnOG0fyfldMMfOPCn+Pgbpj3KOguJT9lNQd+9OGD3195J6g0r5E4rFUf
 zFYehXMsBV7m2qVCpEyCG1EfLU4c9tA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-9NJ8Yc1WNdC-aC_j16gkVQ-1; Fri, 20 Jun 2025 08:18:56 -0400
X-MC-Unique: 9NJ8Yc1WNdC-aC_j16gkVQ-1
X-Mimecast-MFC-AGG-ID: 9NJ8Yc1WNdC-aC_j16gkVQ_1750421935
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso1009133f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750421935; x=1751026735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTidBLUbi/9klXUN/dAGQIidlUPELQGvFavfxGoGihE=;
 b=uCRY0kUvBm8VdUwjBrv/D1KdytHquJa5wl+t20JvO/6sL3SCV6Q+R0nRtu8XJRqaJE
 x7X3c/KKTBMfPSfvd48eWUnL+nucj/Jj/7zGX4jK26VyXMeraWzztokVpvvV9kyzlJ+n
 uh5YljvRJxLIlsFw59YajkgdARbnntQxq4GQxINDCYrZlk07+X7AWP9//dXcK45PncWP
 xV0yZTXq1iPItsvu5pUIZNkwJmTIXzM3ZRwbqJC9OPREEU9yvTs/su83uyXADevQvLts
 HEm7kzf4PLLg2+1j4vyflHe7C8cjRY9+3ukLXcxED8IIlPSIy73RGnJbmC5MZwxFErtl
 1z4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbB11KFRLJ/j/fiiQmiGM/siFY4oNh3s3u8nHuy696legv8sahFxZuYQJE8jT0NPq9IFpMHGTF1WYm@nongnu.org
X-Gm-Message-State: AOJu0YxGnBkXeKSjJGG/8UtMkTohw3CBO+js+Ne4zOzACmca6tB8UM0H
 6q13gKfAAz99fzoVeI7ofZWdwFT8Rx7XvfWSiJT2Aw8pO/QFzuNJHjb9U7xqzRF2CkWK/70OOa9
 D6Tlsbjd6v09kAJQiZGf6LA2ecj6B2TV6qgy+24CyYIWr/AiJexvR+fil
X-Gm-Gg: ASbGncud7Dar1rsc7Nzs9rLm2+Skt38SMnQt5KJU+Q/FySlAvIgAVcApE+kaxcuZygw
 uPjFIJIIlrv3tqA+Z3nONFi/qBMUdWYfSTRZsKoLlLuuwTVYpCfPwYyp770sUSRND/W6sU5L4ey
 adGu8TC+sa3nRzUoaH1a4mYCkMSWmOB6xmTmH3D5wCnhjdE/jWxmDOebuFkxF2jwF5YtcRFWkJ5
 9vzE0s3aWE3LRLgEr9+ofWcgBJV4AeATFk4mTylCCj/JuFXfZr4IWWTmOO55sNL0liRPMXf+XLk
 uVNlMoXvLt8ATsfZQCwZoKklzOS8K8SZeQUyODpbvDqMGrRBHAWX+IJfEkn6TIDRT+vkBA==
X-Received: by 2002:adf:8b02:0:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3a6d1330d62mr1498566f8f.50.1750421935201; 
 Fri, 20 Jun 2025 05:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuWZZpbvqzztkfD5nsEPE/HxxolcqelM9UmLir3iY9MgcsKtoPbHQS7WTwux1VPvpxOQln9A==
X-Received: by 2002:adf:8b02:0:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3a6d1330d62mr1498543f8f.50.1750421934738; 
 Fri, 20 Jun 2025 05:18:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c19fsm1912705f8f.48.2025.06.20.05.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 05:18:53 -0700 (PDT)
Message-ID: <eab32043-68ee-4970-860c-5e512316cf20@redhat.com>
Date: Fri, 20 Jun 2025 14:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/19] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> Currently we don't support nested translation for passthrough device
> with emulated device under same PCI bridge.

I don't understand the above. Do you want to forbid a configuration
where both a passthrough'ed device and an emulated device would be
downstream to a PCI bridge and protected by nested IOMMU?

If I am not wrong in the path you don't check coexistence of emulated
and passthrough'ed device but simply check whether the host assigned
device is downstream to a PCI bridge. So if I am not wrong this is not
really aligned to the commit msg description.
>
> Reason is for emulated devices, AS should switch to iommu MR, while for
> passthrough devices, it needs the AS stick with the system MR hence be
> able to keep the VFIO container IOAS as a GPA IOAS. To support this, let
> AS switch to iommu MR and have a separate GPA IOAS is needed, but that
> brings a new memory listener which duplicates with VFIO memory listener.
I have difficulties to parse the the above sentence
>
> For trade off, we choose to not support this special scenario because
> PCIE bridge is more popular than PCI bridge now.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1c79efc1cb..9d4adc9458 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4330,9 +4330,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> -static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp)
>  {
> +    HostIOMMUDevice *hiod = vtd_hiod->hiod;
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>      int ret;
>  
> @@ -4359,6 +4360,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>  #ifdef CONFIG_IOMMUFD
>      struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>      struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    PCIBus *bus = vtd_hiod->bus;
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), vtd_hiod->devfn);
>  
>      /* Remaining checks are all stage-1 translation specific */
>      if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> @@ -4381,6 +4384,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>          return false;
>      }
> +
> +    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
> +        error_setg(errp, "Host device under PCI bridge is unsupported "
> +                   "when x-flts=on");
so now the compatibility also comes from the device and not only from
the host IOMMU caps. (refering to my previous comment about
s/device/iommu in error msg)
> +        return false;
> +    }
>  #endif
>  
>      error_setg(errp, "host device is uncompatible with stage-1 translation");
> @@ -4414,7 +4423,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      vtd_hiod->iommu_state = s;
>      vtd_hiod->hiod = hiod;
>  
> -    if (!vtd_check_hiod(s, hiod, errp)) {
> +    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>          g_free(vtd_hiod);
>          vtd_iommu_unlock(s);
>          return false;
Thanks

Eric


