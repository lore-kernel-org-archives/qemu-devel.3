Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0734BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQkS-0005pQ-AA; Tue, 03 Jun 2025 08:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQjs-0005Z2-Oa
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQjl-0006s1-Bq
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748953642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB1CeO8WX8EoIILv63fOP7y0DzjOgdSpkvGu+e6yDTg=;
 b=TgHLctOya+ahXM/SvRdoN+yb3Mk4JjXZ5nZIeYW05GPqwY/zvB4SCO7wVlxjPhwciRgfGJ
 66PsRc3LTAgfUaRLPsI2aqlsxrmdCfnKY3549bcroEy4MtrIAPPz8kQHA06HdGgnnEkhj8
 NV8Qy8t2nIM6fJ+VHJeU1vFdsEnw/go=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-11iWeTi0NmazjT185yB-hA-1; Tue, 03 Jun 2025 08:27:21 -0400
X-MC-Unique: 11iWeTi0NmazjT185yB-hA-1
X-Mimecast-MFC-AGG-ID: 11iWeTi0NmazjT185yB-hA_1748953640
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4517abcba41so19301005e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748953640; x=1749558440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LB1CeO8WX8EoIILv63fOP7y0DzjOgdSpkvGu+e6yDTg=;
 b=EZgj8erHDZLSDq7fj8pSg4SVTxzOJr9e1Huttk27SnNKSPaPzRqrh8MUFuxjJJb38q
 Kted9YkJVLGQg5pkppV3dR9GAEFcMlA1IG2uFK2vbgZxz/fQUnVy8m0v+kop6S3vRez6
 wsnoZoYOPBUAV6chyMJnk/BXIsQmW4kk7ksjhyC27BeIZABitJM6mJtnxmPLDQI1tk/y
 /s6Lb+DyBykm1KhE4abBFroq55mGUvpZP0Ix6/uTrxE6n+T8kkfqph1R6Mpsp8rEnl0l
 xsTw12FH6oMo0ReWWZHnhO4HEIGtzHQwP2tpwPvEXrHU6Knmr2HQ6josL5vu4c2wofgS
 fdZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiqefNmMZM02T+1zMx0Ho96gndmnYrZ8D5H1v4BLDSPcBUPDd/qgGmZzRQYeVg/t6EpTqb6Ort6nFA@nongnu.org
X-Gm-Message-State: AOJu0YzZTaw90zOA8esu+1Eev4gtUzaESY6xhcq68oeVO08jJNWJYXG9
 ZrmL2MwST2WeqDlve0I+13HdzyblKqEZWcr24VUbGlkbbRijuraHcCSzGSmKCr1m+ePPu1ZfCj4
 Zol62mO4QzbW63Npqs9L00GCnSQJYgSrD1CcMcKQvPWslbGSHIa5TYGn3
X-Gm-Gg: ASbGncv0AT3Ibj566WZvZxvjCs5BR9hu9QwCpUT0MoLu5SGBkvDHtnID1dwM8xYIBX7
 vFYlLVWs2vj70Dw7ftrfC6mKAELiAYlc/6d5+pewfOUjjqDddlbBTwak8nogoW/Bz67tdLAni+y
 beMOe2SpekLaAD1MpLczz7eNnb7qByhV0AjbAXlaabONozUDbRFl87ns1SoU2MD+Gm5lQvN1AvZ
 YD/PSV0Kc7tJZ2QWjfJ4NwKP9BU5F1V41R3hjBHCFEFitR7Qa7cyIwt2prAJzNgRJSzps28Gmsv
 QosPgshkY8Jh3awoTRC/uP55D5TfMJci7T6C8LMR/PGM1K9v2bpdKRDUBdU=
X-Received: by 2002:a05:6000:381:b0:3a4:eb0c:4087 with SMTP id
 ffacd0b85a97d-3a4f89c006dmr13007200f8f.25.1748953640078; 
 Tue, 03 Jun 2025 05:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETZbUN0S9NE/IuSZLzj7vNmm0h2lDeO5Y2aHvIW+BiisCJ602er0FYpITSZJYdpIb7fRw+Mw==
X-Received: by 2002:a05:6000:381:b0:3a4:eb0c:4087 with SMTP id
 ffacd0b85a97d-3a4f89c006dmr13007178f8f.25.1748953639581; 
 Tue, 03 Jun 2025 05:27:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a182dsm17995632f8f.100.2025.06.03.05.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 05:27:18 -0700 (PDT)
Message-ID: <1740b944-962f-4280-8d04-70fbcc8eb828@redhat.com>
Date: Tue, 3 Jun 2025 14:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530093512.3959484-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/30/25 11:35 AM, Zhenzhong Duan wrote:
> Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
> to the iommufd BE + 2 new class functions.
>
> IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
> and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
> re-attach IOMMUFD backed device to its default VFIO sub-system created
> hwpt, i.e., when vIOMMU is disabled by guest. These properties are
> initialized in hiod::realize() after attachment.
>
> 2 new class functions are [at|de]tach_hwpt(). They are used to
> attach/detach hwpt. VFIO and VDPA can have different implementions,
> so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD,
> e.g., in HostIOMMUDeviceIOMMUFDVFIO.
>
> Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to wrap the
> two functions.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
>  backends/iommufd.c       | 22 ++++++++++++++++++
>  hw/vfio/iommufd.c        |  6 +++++
>  3 files changed, 78 insertions(+)
>
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 83ab8e1e4c..283861b924 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -67,4 +67,54 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                        Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
> +                    HOST_IOMMU_DEVICE_IOMMUFD)
> +
> +/* Overload of the host IOMMU device for the iommufd backend */
> +struct HostIOMMUDeviceIOMMUFD {
> +    HostIOMMUDevice parent_obj;
> +
> +    IOMMUFDBackend *iommufd;
> +    uint32_t devid;
> +    uint32_t hwpt_id;
> +};
> +
> +struct HostIOMMUDeviceIOMMUFDClass {
> +    HostIOMMUDeviceClass parent_class;
> +
> +    /**
> +     * @attach_hwpt: attach host IOMMU device to IOMMUFD hardware page table.
> +     * VFIO and VDPA device can have different implementation.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     *
> +     * @hwpt_id: ID of IOMMUFD hardware page table.
> +     *
> +     * @errp: pass an Error out when attachment fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
> +                        Error **errp);
> +    /**
> +     * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
> +     * VFIO and VDPA device can have different implementation.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     *
> +     * @errp: pass an Error out when attachment fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +};
> +
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp);
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp);
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 8bcdb60fe7..c2c47abf7e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -347,6 +347,26 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>      return !ret;
>  }
>  
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFDClass *idevc =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +
> +    g_assert(idevc->attach_hwpt);
> +    return idevc->attach_hwpt(idev, hwpt_id, errp);
> +}
> +
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFDClass *idevc =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +
> +    g_assert(idevc->detach_hwpt);
> +    return idevc->detach_hwpt(idev, errp);
> +}
> +
>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
> @@ -385,6 +405,8 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>          .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
> +        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
>          .class_init = hiod_iommufd_class_init,
>          .abstract = true,
>      }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index af1c7ab10a..5fde2b633a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -814,6 +814,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                        Error **errp)
>  {
>      VFIODevice *vdev = opaque;
> +    HostIOMMUDeviceIOMMUFD *idev;
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>      enum iommu_hw_info_type type;
>      union {
> @@ -833,6 +834,11 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      caps->type = type;
>      caps->hw_caps = hw_caps;
>  
> +    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    idev->iommufd = vdev->iommufd;
> +    idev->devid = vdev->devid;
> +    idev->hwpt_id = vdev->hwpt->hwpt_id;
> +
>      return true;
>  }
>  


