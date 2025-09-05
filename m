Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A4ACA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 09:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTCy-0001gC-BB; Fri, 05 Sep 2025 05:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuTCv-0001fa-IP
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuTCq-0007bL-6e
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757066285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsUQ1LMSridGG2fTjqZ7lAQ7dbV+z1PP8SvETu6DOIc=;
 b=hqYskuzgzJal7/wiG8wlc21VoKtGHgh7RQ4t08wqTszcfo1oeuDLoCbvCJuB2KEaAAhcg/
 x/jrTzDqTHecWbCUqukIMliYHgoHRhhQBp+ylrBIb3wekxnO3F0qG5ThmaWew7Na5phlg/
 aPH5jl4sO+HZgDtIISDK3qsBm/EjQoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hUqPQiAPNvqttL76hREveQ-1; Fri, 05 Sep 2025 05:58:03 -0400
X-MC-Unique: hUqPQiAPNvqttL76hREveQ-1
X-Mimecast-MFC-AGG-ID: hUqPQiAPNvqttL76hREveQ_1757066282
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45cb604427fso10225725e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 02:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757066281; x=1757671081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsUQ1LMSridGG2fTjqZ7lAQ7dbV+z1PP8SvETu6DOIc=;
 b=NdiXovpfDbE+rMeXKfyAvOsR+2m8NT1ZWvA/pLfSk4USLKXf0YXeU2rkNwj7RmjIgr
 fgXRTkv2oQOVuYyZGdc+ihAMLtzNC4Ylals7CobwKJZRAd623kX5pXNHFJAqX9IB/3Jo
 qZEeXG20/YFJOzajXJ5l+/ZL1IMk9R+G9Kis0BrX98TvDl9QVTgqWqMF/4ARmmmRc6iA
 aGzVd8TRRRQLp3o3RE+k2E6WBF0B7ZRZ9Vp3orCWOVPf5oyD9U10mLaOJNQiK4zCKjQG
 NhfJi93WFVm1glt+kE5mzkIAdiEfVxkQDrT30l2etb0LyYV+7eBJPpntXRtPycJfS8j8
 ZZkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXxBYS0TRHmRZ1S5tHUy+YJ04k4Ne3Axf18wZvCmRXsQTxuVM2c0gfWytoT7JzyqxHLs+k7UQutOwW@nongnu.org
X-Gm-Message-State: AOJu0Yx0TNXqvytlnXrDQcd/VK3tH6j3nW44tcJqTnrOD0Y1zM9b3ZhU
 KHhRyZ5qa019QNZ1GOO/JzRLJfVEVOBpmD8Y5WCslPqosssSdXwB+niQ6/f4hU3pwx51TrNajc3
 iXsFpcCF+45tWDS/zLd3DaxToU3OlGoKlnTNxrh+z+8/EzcpzSn/iqjb8N/V9DTRpDKI=
X-Gm-Gg: ASbGncuODb74LafPSsPznFVnnWmtucMkoV9Oe9/qMUVhk7ZN6jLyzBp6al7Hx0Dj9qQ
 5t9q8JiK8towIFVh7y4jOcyZ08wLA3XwAuiO2auxNLOWMa03Yb6QfhwYxe4EkyvNT5wphZQDKiq
 J73HnCM744nFrlvn0/B7U7c1Oiw2Dx8zcNHHTlisIc2zOMG+V/XmbfYBkRZHXxdA4TaKGtk5KXo
 3SGH/UxbTanE0HQ5k1zFyu32pP9RP1FXeojN/8efMz7GiQ1RgM3QdMch0PRFe+H5JbnMXb3Nd09
 HG+SAifntNOy0lJ8sH7Rr7O5sO3VUiY/E+Z0NqbbbftaUu5raNRCqGK6cyxKJZO6+xHQii/OM5d
 EKxOk7ic3HhU=
X-Received: by 2002:a05:600c:a47:b0:458:bc3f:6a7b with SMTP id
 5b1f17b1804b1-45b85571260mr174585145e9.18.1757066281319; 
 Fri, 05 Sep 2025 02:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/oQOw6D7kr5zPOJhs/mWByAYxEtGYy4q3TQfvcv9jKGWW7RGVIOjhfqD2NhE89631nD9H6w==
X-Received: by 2002:a05:600c:a47:b0:458:bc3f:6a7b with SMTP id
 5b1f17b1804b1-45b85571260mr174584795e9.18.1757066280887; 
 Fri, 05 Sep 2025 02:58:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9a6ecfafsm164487515e9.21.2025.09.05.02.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 02:58:00 -0700 (PDT)
Message-ID: <2bc9b909-e25b-4b4d-b4db-0cf1d10a339b@redhat.com>
Date: Fri, 5 Sep 2025 11:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/15] hw/arm/smmuv3-accel: Allocate a vDEVICE
 object for device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocate and associate a vDEVICE object for the Guest device
> with the vIOMMU. This will help the kernel to do the
> vSID --> sid translation whenever required (eg: device specific
I am not sure I get this. Do you mean translation between the vSID and
the pSID?

> invalidations).
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  1 +
>  include/system/iommufd.h |  5 +++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 74bf20cfaf..f1584dd775 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -93,6 +93,23 @@ void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
>          return;
>      }
>  
> +    if (!accel_dev->vdev && accel_dev->idev) {
> +        IOMMUFDVdev *vdev;
> +        uint32_t vdev_id;
> +        SMMUViommu *viommu = accel_dev->viommu;
> +
> +        iommufd_backend_alloc_vdev(viommu->core.iommufd, accel_dev->idev->devid,
> +                                   viommu->core.viommu_id, sid, &vdev_id,
> +                                   &error_abort);
error_abort vs error handling
> +        vdev = g_new(IOMMUFDVdev, 1);
> +        vdev->vdev_id = vdev_id;
> +        vdev->dev_id = sid;
> +        accel_dev->vdev = vdev;
> +        host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                              accel_dev->viommu->bypass_hwpt_id,
> +                                              &error_abort);
> +    }
> +
>      ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
>      if (ret) {
>          error_report("failed to find STE for sid 0x%x", sid);
> @@ -287,6 +304,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
>      SMMUv3AccelDevice *accel_dev;
>      SMMUViommu *viommu;
> +    IOMMUFDVdev *vdev;
>      SMMUDevice *sdev;
>  
>      if (!sbus) {
> @@ -310,6 +328,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
>  
>      viommu = s->s_accel->viommu;
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>      if (QLIST_EMPTY(&viommu->device_list)) {
>          iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
>          iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 06e81b630d..21028e60c8 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -40,6 +40,7 @@ typedef struct SMMUv3AccelDevice {
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
> +    IOMMUFDVdev  *vdev;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index b7ad2cf10c..8de559d448 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -44,6 +44,11 @@ typedef struct IOMMUFDViommu {
>      uint32_t viommu_id;
>  } IOMMUFDViommu;
>  
> +typedef struct IOMMUFDVdev {
> +    uint32_t vdev_id;
> +    uint32_t dev_id;
> +} IOMMUFDVdev;
Given the jungle of devices and dev_ids we have, I think we need to have
either proper doc comments explaining what the objects abstracts and role

Thanks

Eric
> +
>  bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>  void iommufd_backend_disconnect(IOMMUFDBackend *be);
>  


