Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0264D39417
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8G6X-0001Lo-LG; Thu, 02 Apr 2026 07:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8G6U-0001L3-On
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8G6R-000531-DR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775128845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yhMCoroAXsBVzbY97+gJ1hWMhxReOzx2HoLk1FLnWfg=;
 b=ITJHRFw60ESmTTr7R0JlfHBQzXGt1V20mxf/ubnTxnVubjvnYgzka2WimxlM8JaDiA6IP/
 Py1Pz8PKxPcP1xfryhJfsIscikQamBb6Th9JXADwlwgthelh5x3Wwg81a1cavFpPGgFgaw
 SFzt1jUdy1tcBjXsKYAuEq2V9hX1ZGs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-sjpwtkOxOuSrSv7EG1AlXw-1; Thu, 02 Apr 2026 07:20:43 -0400
X-MC-Unique: sjpwtkOxOuSrSv7EG1AlXw-1
X-Mimecast-MFC-AGG-ID: sjpwtkOxOuSrSv7EG1AlXw_1775128842
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cffbe261eso851877f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775128842; x=1775733642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yhMCoroAXsBVzbY97+gJ1hWMhxReOzx2HoLk1FLnWfg=;
 b=AiPNxGF/gc2yNlFP+7cahpNOaq+3yZw2OSHQH2w9gN5LfpOgf2pBnuSwjQCD85Ofhh
 jP4qN5sNDPbgcCVm2LROuPeM6w0MKYfC3T32ahAW4SsNIB6qqlIKFAjSzwnr5n/ajAGL
 sZW7jeJWsBBmYCkTn03LVSvbkCohY4oLcAbiadVwl2RQjfGajLUT7BR97u1mFcuZFhZG
 vXzgfJY30QOGRamkTPxPtiVEU+eGhDkNguZc00Zk43Pe5cyFAttCOZZzr0QSHu7bwyz0
 Zte7qbPy+SrZzeh8+Lu6XUg21qYYj8PO7+FqX+QRMzk977UtpLrXgrIoYXaTonVPGLXh
 EC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775128842; x=1775733642;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhMCoroAXsBVzbY97+gJ1hWMhxReOzx2HoLk1FLnWfg=;
 b=Tnh5L43b5qns8cuwnCMCjzZslpSXyGFnZr8NX+46I9KR4337+oNeFCxTvBfWdzxIw9
 a7w+nP9zE1j+FFsNzkf0JhVi4PgA/Xc+aAq8K4gk75usVaLi1TWW7QzZCHghzDtnT/zL
 6jG6pdeJAcb1R73fLgfCF4un2HTKTdMP2M2fmWN1NTIYF2odzzPc7uqYMVuAqPBTh5hU
 SNjwT5JexQdBOp0aRa1OM2Gm/booiJj2EEmbQoJ90Ixcoj4H3h2lNnGnetGsCjO1zDmb
 y4V/Alko2q9u67i3qbbbpZz+ZDJEU6DJKlmGmpHqvNmyF9kq2w7yc8c+HlFmKMoUopTV
 xa1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB3pu+65l/dPygURMjeo4i8s020ahZLpOwX6FywkHZZVi57I1B7zbHLaPacqko1KyO7bA/sUpfHBnv@nongnu.org
X-Gm-Message-State: AOJu0YyWm9NAjUndK1+qB5WDRvsRKfmHAFx7OdZBpQEKsxowf4STvRXd
 ObabOf2JJ/qu5o79jT3p/4k10H2/7xCbTi7d0Ed9EmmbKk9GlMjKXnKVxImPvnI1WD6dzbZm0Ef
 C0g2DUKYT2zei1vgzhl6EuM5iyJ0skM4tA74usdUAZpSW9vS5wxqNSSkv
X-Gm-Gg: AeBDiessJ67/8e1yLbnXVbLySXCjGACCzc3PHNcW9AVp3gSSFPn/yYiXjQQxLcOf83u
 jmiUYbQXTToeK07C3cNcSVmkcAkxoe9B7X89nJSy2ffnlwkrfwBVa/WGN5imk7c9e7d/6+fVLl2
 XAt26cqZSDGbqNjdh1+onX1Tje9yadM/Wc+L9kOGURMPSNKJijcH/nrrEjjE6YOFnYiRPLzn3Ot
 YFtlLBWY8w5rHptpnHK/7qs8R5C43u52Eanj4pi0cEJpK7jiVnlW5XbIoukZX8fzVOYSd6OyO+K
 0S8Vw2D4czzQF/okqZHIfZLrRe/z8DPR8oFtDyJ8Tv8Bg1LZj4Y7pxf0EHihP6/Ix8lBywnoptx
 ZWPY/Z2uuXku2n/rAwaxda7NrP8s0lvVqmy+je6DaJg74hf423Vm1BTDDWEuT
X-Received: by 2002:a05:6000:2409:b0:43d:121c:37b2 with SMTP id
 ffacd0b85a97d-43d15045ea2mr13693074f8f.5.1775128842125; 
 Thu, 02 Apr 2026 04:20:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2409:b0:43d:121c:37b2 with SMTP id
 ffacd0b85a97d-43d15045ea2mr13692978f8f.5.1775128841367; 
 Thu, 02 Apr 2026 04:20:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm6939723f8f.31.2026.04.02.04.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 04:20:40 -0700 (PDT)
Message-ID: <4b2e793f-71f5-4ab8-99d8-4a3c98df5d5b@redhat.com>
Date: Thu, 2 Apr 2026 13:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Rename all the idev and idevc variables to hiod
 and hiodc
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, yi.l.liu@intel.com, qemu-arm@nongnu.org
References: <20260401080354.1347212-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260401080354.1347212-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/1/26 10:03, Zhenzhong Duan wrote:
> We used idev and idevc naming for HostIOMMUDeviceIOMMUFD and corresponding
> class variables which followed the iommufd_device naming in linux kernel.
> 
> This is mixed with the hiod naming for base type HostIOMMUDevice. Rename
> HostIOMMUDeviceIOMMUFD* to hiodi* for consistency in QEMU.
> 
> No functional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/arm/smmuv3-accel.h       |  2 +-
>   include/system/iommufd.h    | 12 ++---
>   backends/iommufd.c          | 26 +++++------
>   hw/arm/smmuv3-accel.c       | 93 +++++++++++++++++++------------------
>   hw/i386/intel_iommu_accel.c | 44 +++++++++---------
>   hw/vfio/container-legacy.c  | 10 ++--
>   hw/vfio/iommufd.c           | 24 +++++-----
>   7 files changed, 107 insertions(+), 104 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dba6c71de5..908a13cbcc 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -34,7 +34,7 @@ typedef struct SMMUS1Hwpt {
>   
>   typedef struct SMMUv3AccelDevice {
>       SMMUDevice sdev;
> -    HostIOMMUDeviceIOMMUFD *idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi;
>       SMMUS1Hwpt *s1_hwpt;
>       IOMMUFDVdev *vdev;
>       QLIST_ENTRY(SMMUv3AccelDevice) next;
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 7062944fe6..2925d116ac 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -136,7 +136,7 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * Mandatory callback.
>        *
> -     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     * @hiodi: host IOMMU device backed by IOMMUFD backend.
>        *
>        * @hwpt_id: ID of IOMMUFD hardware page table.
>        *
> @@ -144,7 +144,7 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t hwpt_id,
>                           Error **errp);
>       /**
>        * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
> @@ -152,17 +152,17 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * Mandatory callback.
>        *
> -     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     * @hiodi: host IOMMU device backed by IOMMUFD backend.
>        *
>        * @errp: pass an Error out when attachment fails.
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, Error **errp);
>   };
>   
> -bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              uint32_t hwpt_id, Error **errp);
> -bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              Error **errp);
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index e1fee16acf..410b044370 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -538,24 +538,24 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>       return true;
>   }
>   
> -bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              uint32_t hwpt_id, Error **errp)
>   {
> -    HostIOMMUDeviceIOMMUFDClass *idevc =
> -        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +    HostIOMMUDeviceIOMMUFDClass *hiodic =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
>   
> -    g_assert(idevc->attach_hwpt);
> -    return idevc->attach_hwpt(idev, hwpt_id, errp);
> +    g_assert(hiodic->attach_hwpt);
> +    return hiodic->attach_hwpt(hiodi, hwpt_id, errp);
>   }
>   
> -bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              Error **errp)
>   {
> -    HostIOMMUDeviceIOMMUFDClass *idevc =
> -        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +    HostIOMMUDeviceIOMMUFDClass *hiodic =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
>   
> -    g_assert(idevc->detach_hwpt);
> -    return idevc->detach_hwpt(idev, errp);
> +    g_assert(hiodic->detach_hwpt);
> +    return hiodic->detach_hwpt(hiodi, errp);
>   }
>   
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> @@ -591,10 +591,10 @@ static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
>   
>   static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>   {
> -    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
> -    hioc->get_cap = hiod_iommufd_get_cap;
> -    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
> +    hiodc->get_cap = hiod_iommufd_get_cap;
> +    hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
>   };
>   
>   static const TypeInfo types[] = {
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 65c2f44880..3630078751 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -129,16 +129,16 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>   }
>   
>   static bool
> -smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
>                              Error **errp)
>   {
>       struct iommu_hw_info_arm_smmuv3 info;
>       uint32_t data_type;
>       uint64_t caps;
>   
> -    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> -                                         &info, sizeof(info), &caps, NULL,
> -                                         errp)) {
> +    if (!iommufd_backend_get_device_info(hiodi->iommufd, hiodi->devid,
> +                                         &data_type, &info, sizeof(info), &caps,
> +                                         NULL, errp)) {
>           return false;
>       }
>   
> @@ -182,15 +182,15 @@ static bool
>   smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
>   {
>       SMMUv3AccelState *accel = accel_dev->s_accel;
> -    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi = accel_dev->hiodi;
>       IOMMUFDVdev *vdev = accel_dev->vdev;
>       uint32_t vdevice_id;
>   
> -    if (!idev || vdev) {
> +    if (!hiodi || vdev) {
>           return true;
>       }
>   
> -    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
> +    if (!iommufd_backend_alloc_vdev(hiodi->iommufd, hiodi->devid,
>                                       accel->viommu->viommu_id, sid,
>                                       &vdevice_id, errp)) {
>               return false;
> @@ -209,7 +209,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
>   {
>       uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
>       uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
> -    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi = accel_dev->hiodi;
>       SMMUv3AccelState *accel = accel_dev->s_accel;
>       struct iommu_hwpt_arm_smmuv3 nested_data = {
>           .ste = {
> @@ -220,7 +220,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
>       uint32_t hwpt_id = 0, flags = 0;
>       SMMUS1Hwpt *s1_hwpt;
>   
> -    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
>                                       accel->viommu->viommu_id, flags,
>                                       IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(nested_data), &nested_data,
> @@ -242,7 +242,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>                              .inval_ste_allowed = true};
>       SMMUv3AccelState *accel = s->s_accel;
>       SMMUv3AccelDevice *accel_dev;
> -    HostIOMMUDeviceIOMMUFD *idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi;
>       uint32_t config, hwpt_id = 0;
>       SMMUS1Hwpt *s1_hwpt = NULL;
>       const char *type;
> @@ -257,7 +257,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>           return true;
>       }
>   
> -    idev = accel_dev->idev;
> +    hiodi = accel_dev->hiodi;
>       if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
>           return false;
>       }
> @@ -300,9 +300,9 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>           return false;
>       }
>   
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
>           if (s1_hwpt) {
> -            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> +            iommufd_backend_free_id(hiodi->iommufd, s1_hwpt->hwpt_id);
>               g_free(s1_hwpt);
>           }
>           return false;
> @@ -310,7 +310,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>   
>       /* Free the previous s1_hwpt */
>       if (accel_dev->s1_hwpt) {
> -        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
> +        iommufd_backend_free_id(hiodi->iommufd, accel_dev->s1_hwpt->hwpt_id);
>           g_free(accel_dev->s1_hwpt);
>       }
>   
> @@ -524,7 +524,7 @@ free_veventq:
>   }
>   
>   static bool
> -smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
>                             Error **errp)
>   {
>       SMMUv3AccelState *accel = s->s_accel;
> @@ -534,11 +534,11 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>       struct iommu_hwpt_arm_smmuv3 abort_data = {
>           .ste = { SMMU_STE_VALID, 0x0ULL },
>       };
> -    uint32_t s2_hwpt_id = idev->hwpt_id;
> +    uint32_t s2_hwpt_id = hiodi->hwpt_id;
>       uint32_t viommu_id, hwpt_id;
>       IOMMUFDViommu *viommu;
>   
> -    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +    if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
>                                         IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
>                                         s2_hwpt_id, &viommu_id, errp)) {
>           return false;
> @@ -547,21 +547,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>       viommu = g_new0(IOMMUFDViommu, 1);
>       viommu->viommu_id = viommu_id;
>       viommu->s2_hwpt_id = s2_hwpt_id;
> -    viommu->iommufd = idev->iommufd;
> +    viommu->iommufd = hiodi->iommufd;
>       accel->viommu = viommu;
>   
>       /*
>        * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
>        * later for guest STEs or GBPAs that require bypass or abort configuration.
>        */
> -    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
> +    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(abort_data), &abort_data,
>                                       &accel->abort_hwpt_id, errp)) {
>           goto free_viommu;
>       }
>   
> -    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
> +    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(bypass_data), &bypass_data,
>                                       &accel->bypass_hwpt_id, errp)) {
> @@ -575,7 +575,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>   
>       /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
>           goto free_veventq;
>       }
>       return true;
> @@ -583,11 +583,11 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>   free_veventq:
>       smmuv3_accel_free_veventq(accel);
>   free_bypass_hwpt:
> -    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
> +    iommufd_backend_free_id(hiodi->iommufd, accel->bypass_hwpt_id);
>   free_abort_hwpt:
> -    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
> +    iommufd_backend_free_id(hiodi->iommufd, accel->abort_hwpt_id);
>   free_viommu:
> -    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
> +    iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
>       g_free(viommu);
>       accel->viommu = NULL;
>       return false;
> @@ -596,20 +596,20 @@ free_viommu:
>   static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                             HostIOMMUDevice *hiod, Error **errp)
>   {
> -    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
>       SMMUState *bs = opaque;
>       SMMUv3State *s = ARM_SMMUV3(bs);
>       SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>       SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>   
> -    if (!idev) {
> +    if (!hiodi) {
>           return true;
>       }
>   
> -    if (accel_dev->idev) {
> -        if (accel_dev->idev != idev) {
> -            error_setg(errp, "Device already has an associated idev 0x%x",
> -                       idev->devid);
> +    if (accel_dev->hiodi) {
> +        if (accel_dev->hiodi != hiodi) {
> +            error_setg(errp, "Device already has an associated hiodi 0x%x",
> +                       hiodi->devid);
>               return false;
>           }
>           return true;
> @@ -619,7 +619,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>        * Check the host SMMUv3 associated with the dev is compatible with the
>        * QEMU SMMUv3 accel.
>        */
> -    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
> +    if (!smmuv3_accel_hw_compatible(s, hiodi, errp)) {
>           return false;
>       }
>   
> @@ -627,17 +627,17 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>           goto done;
>       }
>   
> -    if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
> -        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
> -                          idev->devid);
> +    if (!smmuv3_accel_alloc_viommu(s, hiodi, errp)) {
> +        error_append_hint(errp, "Unable to alloc vIOMMU: hiodi devid 0x%x: ",
> +                          hiodi->devid);
>           return false;
>       }
>   
>   done:
> -    accel_dev->idev = idev;
> +    accel_dev->hiodi = hiodi;
>       accel_dev->s_accel = s->s_accel;
>       QLIST_INSERT_HEAD(&s->s_accel->device_list, accel_dev, next);
> -    trace_smmuv3_accel_set_iommu_device(devfn, idev->devid);
> +    trace_smmuv3_accel_set_iommu_device(devfn, hiodi->devid);
>       return true;
>   }
>   
> @@ -646,7 +646,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>   {
>       SMMUState *bs = opaque;
>       SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
> -    HostIOMMUDeviceIOMMUFD *idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi;
>       SMMUv3AccelDevice *accel_dev;
>       SMMUv3AccelState *accel;
>       IOMMUFDVdev *vdev;
> @@ -662,16 +662,16 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>       }
>   
>       accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> -    idev = accel_dev->idev;
> +    hiodi = accel_dev->hiodi;
>       accel = accel_dev->s_accel;
>       /* Re-attach the default s2 hwpt id */
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
> -        error_report("Unable to attach the default HW pagetable: idev devid "
> -                     "0x%x", idev->devid);
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id, NULL)) {
> +        error_report("Unable to attach the default HW pagetable: hiodi devid "
> +                     "0x%x", hiodi->devid);
>       }
>   
>       if (accel_dev->s1_hwpt) {
> -        iommufd_backend_free_id(accel_dev->idev->iommufd,
> +        iommufd_backend_free_id(accel_dev->hiodi->iommufd,
>                                   accel_dev->s1_hwpt->hwpt_id);
>           g_free(accel_dev->s1_hwpt);
>           accel_dev->s1_hwpt = NULL;
> @@ -684,10 +684,10 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>           accel_dev->vdev = NULL;
>       }
>   
> -    accel_dev->idev = NULL;
> +    accel_dev->hiodi = NULL;
>       accel_dev->s_accel = NULL;
>       QLIST_REMOVE(accel_dev, next);
> -    trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, hiodi->devid);
>   
>       if (QLIST_EMPTY(&accel->device_list)) {
>           smmuv3_accel_free_viommu(accel);
> @@ -879,10 +879,11 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>   
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>       QLIST_FOREACH(accel_dev, &accel->device_list, next) {
> -        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
> +        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi, hwpt_id,
>                                                      &local_err)) {
>               error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
> -                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
> +                              "hiodi devid %u", hwpt_id,
> +                               accel_dev->hiodi->devid);
>               error_report_err(local_err);
>               local_err = NULL;
>               all_ok = false;
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 67d54849f2..ed3793602b 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -69,7 +69,7 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                  VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
>                                  Error **errp)
>   {
> @@ -81,27 +81,27 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>       vtd.addr_width = vtd_pe_get_fs_aw(pe);
>       vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
>   
> -    return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
> -                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
> -                                      &vtd, fs_hwpt_id, errp);
> +    return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
> +                                      hiodi->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
>   }
>   
> -static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                       VTDAddressSpace *vtd_as)
>   {
>       if (!vtd_as->fs_hwpt_id) {
>           return;
>       }
> -    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
> +    iommufd_backend_free_id(hiodi->iommufd, vtd_as->fs_hwpt_id);
>       vtd_as->fs_hwpt_id = 0;
>   }
>   
>   static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>                                         VTDAddressSpace *vtd_as, Error **errp)
>   {
> -    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> -    uint32_t hwpt_id = idev->hwpt_id;
> +    uint32_t hwpt_id = hiodi->hwpt_id;
>       bool ret;
>   
>       /*
> @@ -116,21 +116,21 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        if (!vtd_create_fs_hwpt(hiodi, pe, &hwpt_id, errp)) {
>               return false;
>           }
>       }
>   
> -    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> -    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
> +    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(hiodi->devid, vtd_as->pasid, hwpt_id, ret);
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
> -        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_as->fs_hwpt_id = hwpt_id;
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
> -        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +        iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
>       }
>   
>       return ret;
> @@ -139,27 +139,28 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>   static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>                                         VTDAddressSpace *vtd_as, Error **errp)
>   {
> -    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       IntelIOMMUState *s = vtd_as->iommu_state;
>       uint32_t pasid = vtd_as->pasid;
>       bool ret;
>   
>       if (s->dmar_enabled && s->root_scalable) {
> -        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> -        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
> +        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, errp);
> +        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
>       } else {
>           /*
>            * If DMAR remapping is disabled or guest switches to legacy mode,
>            * we fallback to the default HWPT which contains shadow page table.
>            * So guest DMA could still work.
>            */
> -        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> -        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id,
> +                                                    errp);
> +        trace_vtd_device_reattach_def_hwpt(hiodi->devid, pasid, hiodi->hwpt_id,
>                                              ret);
>       }
>   
>       if (ret) {
> -        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
>       }
>   
>       return ret;
> @@ -211,13 +212,14 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
>       did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>   
>       if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> -        HostIOMMUDeviceIOMMUFD *idev =
> +        HostIOMMUDeviceIOMMUFD *hiodi =
>               HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>           uint32_t entry_num = 1; /* Only implement one request for simplicity */
>           Error *local_err = NULL;
>           struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
>   
> -        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt_id,
> +        if (!iommufd_backend_invalidate_cache(hiodi->iommufd,
> +                                              vtd_as->fs_hwpt_id,
>                                                 IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
>                                                 sizeof(*cache), &entry_num, cache,
>                                                 &local_err)) {
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index 625f151364..d301b27aa6 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -1244,12 +1244,12 @@ static void vfio_iommu_legacy_instance_init(Object *obj)
>   
>   static void hiod_legacy_vfio_class_init(ObjectClass *oc, const void *data)
>   {
> -    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
> -    hioc->realize = hiod_legacy_vfio_realize;
> -    hioc->get_cap = hiod_legacy_vfio_get_cap;
> -    hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
> -    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
> +    hiodc->realize = hiod_legacy_vfio_realize;
> +    hiodc->get_cap = hiod_legacy_vfio_get_cap;
> +    hiodc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
> +    hiodc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
>   };
>   
>   static const TypeInfo types[] = {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3e33dfbb35..399b36aa75 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -917,19 +917,19 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>   };
>   
>   static bool
> -host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              uint32_t hwpt_id, Error **errp)
>   {
> -    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
>       return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>   }
>   
>   static bool
> -host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>                                              Error **errp)
>   {
> -    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
>       return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
>   }
> @@ -938,7 +938,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                         Error **errp)
>   {
>       VFIODevice *vdev = opaque;
> -    HostIOMMUDeviceIOMMUFD *idev;
> +    HostIOMMUDeviceIOMMUFD *hiodi;
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
>       VendorCaps *vendor_caps = &caps->vendor_caps;
>       enum iommu_hw_info_type type;
> @@ -958,10 +958,10 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       caps->hw_caps = hw_caps;
>       caps->max_pasid_log2 = max_pasid_log2;
>   
> -    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> -    idev->iommufd = vdev->iommufd;
> -    idev->devid = vdev->devid;
> -    idev->hwpt_id = vdev->hwpt->hwpt_id;
> +    hiodi = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    hiodi->iommufd = vdev->iommufd;
> +    hiodi->devid = vdev->devid;
> +    hiodi->hwpt_id = vdev->hwpt->hwpt_id;
>   
>       return true;
>   }
> @@ -988,14 +988,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>   static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
>   {
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> -    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
> +    HostIOMMUDeviceIOMMUFDClass *hiodic = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>   
>       hiodc->realize = hiod_iommufd_vfio_realize;
>       hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>       hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
>   
> -    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
> -    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
> +    hiodic->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
> +    hiodic->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
>   };
>   
>   static const TypeInfo types[] = {

Applied to vfio-next.

Thanks,

C.



