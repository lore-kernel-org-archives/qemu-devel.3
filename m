Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D72C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLhG-0001mP-NE; Tue, 04 Feb 2025 11:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfLhE-0001lw-KY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfLhC-0001aH-JV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738686160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jPM1lXAGP+RwnNe3KGvidO4XTGPoft9GxE4NGuUMnw8=;
 b=Dsc8A3lr4m9f98GVIbSswbu1gfTBMnMMSjOiK5wXyKHixHW/SXsAYfkffqQH61yb5XKV9V
 ZcvmEMqv4d35ZOljNEzJWFpCG25De6jqWt5qQViUaPCu4+rM5RLVLXcl7M896u8oSPpI49
 W6s2IwWle4z/YmDgaUcOrR5xmpnvVY0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-hrA8qpKzP2WXBK8SYrcPRQ-1; Tue, 04 Feb 2025 11:22:39 -0500
X-MC-Unique: hrA8qpKzP2WXBK8SYrcPRQ-1
X-Mimecast-MFC-AGG-ID: hrA8qpKzP2WXBK8SYrcPRQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46c83bc370bso105067321cf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738686158; x=1739290958;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPM1lXAGP+RwnNe3KGvidO4XTGPoft9GxE4NGuUMnw8=;
 b=xT6HiI8e5hQ651cDZ7xmDX8Ov1ge8EDU+JEbxMsXypHM8tIIh6P0l1fzVjd+Z+1jQl
 LzSwVC89Sji5B25c2hKTNLd4g1BmBAsMjmJwL0fPbHLAh+Pvd9uM0Jgg4si/9y3glaMn
 WhidLpueR3xHDO5rcYcjmt7qtmn9Y4TvcIoiaUmbIEUlLOZ1/cNM2/BtPdJSyFXPw+8q
 fkZEaYaZ+HfTn8jBAgCeeaMtIc8IZFbw99JeoluuIEqUGgKIm3GdsG0uOXdbRcu9c60x
 OG3R3hAL19BeKLOWyKbc5lMvSyl2bxYmk/2mVCPA8cc9TEmgASDlFOi2tD9i9XYDDC1G
 LpMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4KIAl+9cVRMK1S0GhBdCz+tF2cXzkbm23yZRgrIsJ7iXmEJ9Yi1D2GmLMy6Kz5q2CXnQ0Bd1Iy0t7@nongnu.org
X-Gm-Message-State: AOJu0YzuITiUjHlrSWX31CF4DQuM8Q2e9CWiAiVWylADedxg7QBVtbDk
 mEWRftYSj18UqWKhtnN4kBkTigPwn/E6QiTdyupccAqPXsQIdzvcOLMghrxc0tFN5oLI4HFVlXi
 6EZNipIrKPXdlw3RufHSCjedEAlBExkC61YH7ZEy33zSN1O17HzO4
X-Gm-Gg: ASbGncstXSQPP6SUUcIJ2TZ2F4jFMqhptNyicXJEbZLeOK25j0akXMr++wI+AmZOFnw
 5lkgsdp6RTNOLmtSYrNEEdpbr34KCi8Y9wYb7aT/3nKPUUJpkzicEIwtR8PvCLla2EfjLacyzgx
 x9PNq0Te/QWxh3P3ESxpPU5a8WevnkeJ1GEKmxABsLmx3C3PlU82qmfgL/PwHzOjkoRNlMtXYn9
 Mmykl5Uh39nXI8J868iapavR97xSjWPhCe0VZ7O5dbtSWZAnleQc2Dm1SSzEkU92rfCT3hq22bp
 C1ny0cbfkG5sSQ1NH4o6TVF204JHeOgFJRZ5QwBIRfo=
X-Received: by 2002:ac8:5916:0:b0:461:7558:892f with SMTP id
 d75a77b69052e-470186dbaafmr58284101cf.15.1738686158648; 
 Tue, 04 Feb 2025 08:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbEcusCDrGmH1arfzvydzxNbmQCswiROwfJ/y0yiHFOMJF8JrXWIogg8iBTuVl877JfZoKXw==
X-Received: by 2002:ac8:5916:0:b0:461:7558:892f with SMTP id
 d75a77b69052e-470186dbaafmr58283661cf.15.1738686158244; 
 Tue, 04 Feb 2025 08:22:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf172362sm60277011cf.52.2025.02.04.08.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 08:22:37 -0800 (PST)
Message-ID: <b17064fb-20d5-4879-a4bf-aa57904b2272@redhat.com>
Date: Tue, 4 Feb 2025 17:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 18/26] vfio/iommufd: define iommufd_cdev_make_hwpt
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/29/25 15:43, Steve Sistare wrote:
> Refactor and define iommufd_cdev_make_hwpt, to be called by CPR in a
> a later patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/iommufd.c | 69 +++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3490a8f..42ba63f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -275,6 +275,41 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +static void iommufd_cdev_set_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
> +{
> +    vbasedev->hwpt = hwpt;
> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +}
> +
> +static VFIOIOASHwpt *iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
> +                                            VFIOIOMMUFDContainer *container,
> +                                            uint32_t hwpt_id)
> +{
> +    VFIOIOASHwpt *hwpt = g_malloc0(sizeof(*hwpt));
> +    uint32_t flags = 0;
> +
> +    /*
> +     * This is quite early and VFIO Migration state isn't yet fully
> +     * initialized, thus rely only on IOMMU hardware capabilities as to
> +     * whether IOMMU dirty tracking is going to be requested. Later
> +     * vfio_migration_realize() may decide to use VF dirty tracking
> +     * instead.
> +     */
> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
> +    hwpt->hwpt_id = hwpt_id;
> +    hwpt->hwpt_flags = flags;
> +    QLIST_INIT(&hwpt->device_list);
> +
> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported |=
> +                                vbasedev->iommu_dirty_tracking;
> +    return hwpt;
> +}
> +
>   static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
> @@ -304,24 +339,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>   
>               return false;
>           } else {
> -            vbasedev->hwpt = hwpt;
> -            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> -            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
> +            iommufd_cdev_set_hwpt(vbasedev, hwpt);
>               return true;
>           }
>       }
>   
> -    /*
> -     * This is quite early and VFIO Migration state isn't yet fully
> -     * initialized, thus rely only on IOMMU hardware capabilities as to
> -     * whether IOMMU dirty tracking is going to be requested. Later
> -     * vfio_migration_realize() may decide to use VF dirty tracking
> -     * instead.
> -     */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> -    }
>

AFAICT, iommufd_backend_alloc_hwpt() below needs the flag value.

Thanks,

C.



>       if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                       container->ioas_id, flags,
>                                       IOMMU_HWPT_DATA_NONE, 0, NULL,
> @@ -329,24 +351,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           return false;
>       }
>   
> -    hwpt = g_malloc0(sizeof(*hwpt));
> -    hwpt->hwpt_id = hwpt_id;
> -    hwpt->hwpt_flags = flags;
> -    QLIST_INIT(&hwpt->device_list);
> -
> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>       if (ret) {
> -        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> -        g_free(hwpt);
> +        iommufd_backend_free_id(container->be, hwpt_id);
>           return false;
>       }
>   
> -    vbasedev->hwpt = hwpt;
> -    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
> -    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> -    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> -    container->bcontainer.dirty_pages_supported |=
> -                                vbasedev->iommu_dirty_tracking;
> +    hwpt = iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id);
> +    iommufd_cdev_set_hwpt(vbasedev, hwpt);
> +
>       if (container->bcontainer.dirty_pages_supported &&
>           !vbasedev->iommu_dirty_tracking) {
>           warn_report("IOMMU instance for device %s doesn't support dirty tracking",


