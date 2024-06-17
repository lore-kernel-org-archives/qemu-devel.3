Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CCAC2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCL7-0008VQ-F0; Mon, 17 Jun 2024 09:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJCL5-0008VC-MU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJCL4-00008a-5b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718630641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b313t8QGbzWNmuRQH1B7TpBmfxi6fefKIpZa+ZnqFTM=;
 b=LML4WpgNqVHrLA/w2V9+cZNxdHOoqF8c/3ddLOgNxxQE5nwSVAqBXcu2p4ZXY1YcpElHbS
 2oFxMtiwc4WQrGXp4uyMpCzWyRXL+rMgj2JzcwQ8Pa1sBgWjEVKpxdg4VoOUazi9tIH+wM
 gm1rtjzqsrpGJpXnt32QOC1LrwAcxDI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-qCCSgSWLPBWqRvVkL4BtOQ-1; Mon, 17 Jun 2024 09:23:57 -0400
X-MC-Unique: qCCSgSWLPBWqRvVkL4BtOQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52c849a1f64so2680813e87.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 06:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718630636; x=1719235436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b313t8QGbzWNmuRQH1B7TpBmfxi6fefKIpZa+ZnqFTM=;
 b=MlqzzKrn3YZkIGlCGvUXzH0Q1yCPqEZSC9deigncYkOC6oqHbZxq+aVa6ljTu9VSJc
 0L8RyHeQfwHyDOW/LFV4tc+c8Ikc1ffP3SE4inxZKf1llFJB8Vp9MhJnZmLbETzebvjP
 /3AZ09sXmKC1CbSBEI52Wht/Y68m4MPRh4hf5dYxoyt2RC6thD9lcIB24h5azIVEZJIg
 FWlTKT8bY0ks+mcq4mSHJvzi71tEa7qIjJzmYxP9pi3tSB9qoBv5yxQ+KDjlwB1V5hO2
 EtYejrECv3u+M4IH0IZsMBmJCYWL7VY7wlXGMnHCxxUh/tZxzV54DkeGKMnTfR6GUX0t
 +wRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0iNsxCTnHU2jpDUincyVnYa99Q2giUC1wRixcQbGUN/kGGolzGHjTGLd8evwR2VTxg+4SG7oKEv9DYfUektbotBnx2d4=
X-Gm-Message-State: AOJu0Yy7AvjzUt/xE1I/8sjbPWAqZgxU3Mwkeouw5iet1Wk4ScQpgGbY
 cDAX67RNuk/tGIyBiturrimqddj0bw+K+m3jRLueNf1b7xoKMqLIdQLEjwRCEmqOHRXPDHxDy1N
 Tghu/W+1O/m285D0luc1UHWYEvVe+MlsCh0PDhQ7uLa4kysyZEeQT
X-Received: by 2002:ac2:560a:0:b0:52c:8abe:5204 with SMTP id
 2adb3069b0e04-52ca6e6d562mr6347061e87.32.1718630636218; 
 Mon, 17 Jun 2024 06:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1nD0rKkhfmM/x/BPDmBdX3253dypsX7VRJ1XdJnvvyo2Q/6DLpr87jBGoVMHKmt3T1pU8qg==
X-Received: by 2002:ac2:560a:0:b0:52c:8abe:5204 with SMTP id
 2adb3069b0e04-52ca6e6d562mr6347045e87.32.1718630635793; 
 Mon, 17 Jun 2024 06:23:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e9193sm196065245e9.21.2024.06.17.06.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 06:23:55 -0700 (PDT)
Message-ID: <8b8ac158-ffc4-4d2e-aaf5-2893f1b680f7@redhat.com>
Date: Mon, 17 Jun 2024 15:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] HostIOMMUDevice: Introduce get_iova_ranges callback
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240614095402.904691-1-eric.auger@redhat.com>
 <20240614095402.904691-4-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240614095402.904691-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/14/24 11:52 AM, Eric Auger wrote:
> Introduce a new HostIOMMUDevice callback that allows to
> retrieve the usable IOVA ranges.
> 
> Implement this callback in the legacy VFIO and IOMMUFD VFIO
> host iommu devices. This relies on the VFIODevice agent's
> base container iova_ranges resource.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> ---
> 
> v2 -> v3:
> - add g_assert(vdev)
> ---
>   include/sysemu/host_iommu_device.h |  8 ++++++++
>   hw/vfio/container.c                | 16 ++++++++++++++++
>   hw/vfio/iommufd.c                  | 16 ++++++++++++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 3e5f058e7b..40e0fa13ef 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -80,6 +80,14 @@ struct HostIOMMUDeviceClass {
>        * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
>        */
>       int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
> +    /**
> +     * @get_iova_ranges: Return the list of usable iova_ranges along with
> +     * @hiod Host IOMMU device
> +     *
> +     * @hiod: handle to the host IOMMU device
> +     * @errp: error handle
> +     */
> +    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
>   };
>   
>   /*
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index b728b978a2..c48749c089 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1164,12 +1164,28 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>       }
>   }
>   
> +static GList *
> +hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
> +{
> +    VFIODevice *vdev = hiod->agent;
> +    GList *l = NULL;
> +
> +    g_assert(vdev);
> +
> +    if (vdev->bcontainer) {
> +        l = g_list_copy(vdev->bcontainer->iova_ranges);
> +    }
> +
> +    return l;
> +}
> +
>   static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>   {
>       HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
>       hioc->realize = hiod_legacy_vfio_realize;
>       hioc->get_cap = hiod_legacy_vfio_get_cap;
> +    hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
>   };
>   
>   static const TypeInfo types[] = {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index dbdae1adbb..e502081c2a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -645,11 +645,27 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       return true;
>   }
>   
> +static GList *
> +hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
> +{
> +    VFIODevice *vdev = hiod->agent;
> +    GList *l = NULL;
> +
> +    g_assert(vdev);
> +
> +    if (vdev->bcontainer) {
> +        l = g_list_copy(vdev->bcontainer->iova_ranges);
> +    }
> +
> +    return l;
> +}

May be introduce a common vfio_container_get_iova_ranges() to be called from
the get_iova_ranges() handlers ?


Thanks,

C.


>   static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>   {
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
>       hiodc->realize = hiod_iommufd_vfio_realize;
> +    hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>   };
>   
>   static const TypeInfo types[] = {


