Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C54D3C90B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKlP-00051v-0c; Wed, 10 Dec 2025 09:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKkx-0004z0-P4
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKkv-0006ip-P5
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765375284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4HoKr5PRM6IqB9Pe2m2ThkZpkl+tgY87/UvQdHuFJE=;
 b=h1f4GU8xZFlVgXucHi5DJKgyRDhxRnScv/T4kGpfRBryvD7RedOfDZIxtUA9uvkMmdFoTN
 hhQhXKYwbi5AyaI8r1bWAE7ufwkjRbIhy13p4IPmY1rqm+CpHfxlOSqyXBwlSYUtksEAJe
 +3m0J5Xe8O53H23wqSVfxl2d2MuzL/4=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-zg9TM7vmNKe43VwruCCmAw-1; Wed, 10 Dec 2025 09:01:23 -0500
X-MC-Unique: zg9TM7vmNKe43VwruCCmAw-1
X-Mimecast-MFC-AGG-ID: zg9TM7vmNKe43VwruCCmAw_1765375282
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-11bd7a827fdso1285367c88.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375282; x=1765980082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4HoKr5PRM6IqB9Pe2m2ThkZpkl+tgY87/UvQdHuFJE=;
 b=HF/IUhi7SEyR7mgRFJ38Brqf4qOCr8BE8K6dScEqXxDavN353iN2ZVT1Wz3eUWSmIZ
 FzNLp6phCzV+uYAGfDoiunPkgn5W5bsSyWmFEzrRQuDxGLLqNCh7zu5Gn56guDewOdEy
 3wCg8+jg0LqOA9jqCi6qjsQLiyZdifKJsBZnNdrdt4U54TeZvL1xexugtPiNU4Ew47UY
 l2/eI7kAobDIecf3yfuseDMmmnVwNPpJ599Bn0SjRdb0DJA7W72FovHRaB5Ri7l0JIlh
 Pek1T0qwceJhFdPIa2Fs9lT1BHQLuaA2dtCXaX6xZbEplSG12OyVnnKz2O6fCL/oy1LT
 cVzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyf4b3MbzPx21AfnqaJdRsLPAM2dbsJrU0H1SmSfqBJKPWUUFoeu9HEj6xfhMUkLr+pYhS+Vtmo8mX@nongnu.org
X-Gm-Message-State: AOJu0Yxd5vEaIH3qoAhbOm6Ox9JbVUcOtB3+DFUV2vunXda+ffHD1KeY
 bm8+GOueA+hKazXcto2GbgfNBZAwKL1GIQC1Ca9Ls9qBZLm7Yt5j2ZOQqe52zLkrpvff3Awmg1V
 M1xfYJxoMNhLk9Ijet0IclMuSK7stWpodAK5VRrnfE598K6IltIRddMoF
X-Gm-Gg: ASbGncvHKa+B/CnTPkjhB+cmpBiU3LWBUjVDoB/oP54NK7/cyGhDArkQclOPlq6/agc
 d/M8dr3lSyBu3uqy3AEF18EJX2tvlq9EMS9p+6kjJ995QTSPnS/2f4zu8M6yLAmsGyDSeNm7Cai
 2O8JSKzCDsBouWTMZXgQ3GilYuaB/FqGq2LB0Ymdnu2UWaNsjlf853ZdR51z6I0milNaXurF3qx
 RTW/P25B++17hgzGKBx4ANX6R627vQcjZQaCvkm//p8Mf/MbQyjaCIuN+nQBqxr1Mg8EYFm5T8p
 8GR3PF0khv9Gl1JZPZL1HfIqxNH1nWb8ztYgl7uVKiNXdPvhFttw99cNfqqg7/5buQfzxfZWnT3
 9v3GPIHLyKbFelICwZpKer/qSvYdzDR7HXzkldINN2V8nruJQtDjj6VwLGw==
X-Received: by 2002:a05:7022:428a:b0:119:e569:f85d with SMTP id
 a92af1059eb24-11f251d4afamr3704442c88.20.1765375280354; 
 Wed, 10 Dec 2025 06:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJGb6mohKZQzzo2BRQOKzxIBFIViEkomhufmwGV1MijsEn508YE5x8/y2KorS74cEqQPoDfA==
X-Received: by 2002:a05:7022:428a:b0:119:e569:f85d with SMTP id
 a92af1059eb24-11f251d4afamr3704408c88.20.1765375279674; 
 Wed, 10 Dec 2025 06:01:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f283d4754sm7058722c88.12.2025.12.10.06.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 06:01:19 -0800 (PST)
Message-ID: <1f298b83-bb87-4d96-bb95-7aa5f99d1e0e@redhat.com>
Date: Wed, 10 Dec 2025 15:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/23] intel_iommu_accel: Fail passthrough device under
 PCI bridge if x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-11-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> Currently we don't support nested translation for passthrough device with
> emulated device under same PCI bridge, because they require different address
> space when x-flts=on.
>
> In theory, we do support if devices under same PCI bridge are all passthrough
> devices. But emulated device can be hotplugged under same bridge. To simplify,
> just forbid passthrough device under PCI bridge no matter if there is, or will
> be emulated devices under same bridge. This is acceptable because PCIE bridge
> is more popular than PCI bridge now.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
As this looks like a simple move compared to v7, 
feel free to keep my
Reviewed-by: Eric Auger <eric.auger@redhat.com>
and thanks for the heads up

Eric

> ---
>  hw/i386/intel_iommu_accel.h |  4 ++--
>  hw/i386/intel_iommu.c       |  7 ++++---
>  hw/i386/intel_iommu_accel.c | 12 +++++++++++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index c5274e342c..7ebf137a1a 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -13,11 +13,11 @@
>  #include CONFIG_DEVICES
>  
>  #ifdef CONFIG_VTD_ACCEL
> -bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp);
>  #else
>  static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> -                                        HostIOMMUDevice *hiod,
> +                                        VTDHostIOMMUDevice *vtd_hiod,
>                                          Error **errp)
>  {
>      error_setg(errp,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d3c8a75878..4ebf56a74f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4571,9 +4571,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
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
> @@ -4597,7 +4598,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> -    return vtd_check_hiod_accel(s, hiod, errp);
> +    return vtd_check_hiod_accel(s, vtd_hiod, errp);
>  }
>  
>  static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> @@ -4633,7 +4634,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      vtd_hiod->iommu_state = s;
>      vtd_hiod->hiod = hiod;
>  
> -    if (!vtd_check_hiod(s, hiod, errp)) {
> +    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>          g_free(vtd_hiod);
>          vtd_iommu_unlock(s);
>          return false;
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 6846c6ec4d..ead6c42879 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -12,12 +12,16 @@
>  #include "system/iommufd.h"
>  #include "intel_iommu_internal.h"
>  #include "intel_iommu_accel.h"
> +#include "hw/pci/pci_bus.h"
>  
> -bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp)
>  {
> +    HostIOMMUDevice *hiod = vtd_hiod->hiod;
>      struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>      struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    PCIBus *bus = vtd_hiod->bus;
> +    PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
>  
>      if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>          error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> @@ -36,6 +40,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return false;
>      }
>  
> +    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
> +        error_setg(errp, "Host device downstream to a PCI bridge is "
> +                   "unsupported when x-flts=on");
> +        return false;
> +    }
> +
>      error_setg(errp,
>                 "host IOMMU is incompatible with guest first stage translation");
>      return false;


