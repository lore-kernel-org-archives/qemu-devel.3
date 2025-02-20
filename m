Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF55EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlAZB-0006sw-AI; Thu, 20 Feb 2025 12:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAYy-0006s9-5a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAYw-0006YX-Cy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740073330;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QXKM3+fizOkpG3G/Pzpz9TNVOPpGVyJ4rU6W7kTSzo=;
 b=Jm4uvd8aN6Dw5Qf5NLVdlU3KIut/ggXAcMWh0KBC8BTpVRp5Gqj4YsjrUc6Aclj+Ee43dS
 CHrHkjlF/pIjUEhJlBf8MTGXaF7duJQb2FyLaxdlHpn2/wO8pfR8eUADHH8fkBDr/c8Q+N
 G4NEzfuNcTdfskk0Rt83WtFTzOCBlQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-V5iankd2NWe--OKofiwiNg-1; Thu, 20 Feb 2025 12:42:09 -0500
X-MC-Unique: V5iankd2NWe--OKofiwiNg-1
X-Mimecast-MFC-AGG-ID: V5iankd2NWe--OKofiwiNg_1740073328
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f455a8e43so617352f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 09:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740073328; x=1740678128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QXKM3+fizOkpG3G/Pzpz9TNVOPpGVyJ4rU6W7kTSzo=;
 b=ZQ9I3SHvbSqXMFvIwh2M9njI/NeoBT6+T7KdAY0O9d6VLA4aHxz7ZEgt7n1m8xMvBx
 RmhucNQyKoW1bPcVoJrQhG7067S8X6RftuuFYzQXuzQAmu9PO3CUaXwesP8nCy8D6AQP
 qqyinDZokikm366RcayvzAur+9EKtCamAun6l/uun+W7KUIj9+Q5ADWY/1Gcbn6phmNe
 wb7FjsQiB2htvNNF2/2Sa4fZzPTZ4hJuIAKpdjg58Olcxk5dOGHdqUw2YsiCXO0gmz4v
 EZdtM16BN2OMc0ku1k2yZHUreITv5SZu/gnULCmDV7s759+aGqvtoT0oN+9Zka6wEetx
 GS8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnyvXeWXN/DMoXss/Cu+/2LKc4gxuzCbGqpzJnfuXBnChe9PjydnKUS4oywFpMxZc4WHw0dMU2GkBx@nongnu.org
X-Gm-Message-State: AOJu0YyCoN85s2/XdSZjWhnl+OJS0WqS50uJDKo/ZtE3t4bNFiS8lh06
 TOyH76spOp2TlR/racbQKzRDd5sSToGEJgoEfVqWdyMt4V1kMeFgBSevYepyZPZJTfbhkAv1S2Q
 CiyOb0R3VjlPSR1Pj187KWTC6Z2YPF5QAxT2c4wdaepOdNfTIEQkI
X-Gm-Gg: ASbGnctYKoO7skyiWLxqFA0ptljYE8zxh2IJnLIh7EothYfIuDEpzg15uwC07Sbx1BO
 dQMUrKoOsvWMQvLxB8kVarRzoNUiyXqUI6q1jHTP0eRjWpW+7A/JS3UzE/Jz60/D6uKCbV1becA
 +8V+9ASFitXicUy+Te8xPm3+0zeQ2+Gg9xJs2cuH30cYkxzchLGq2VrD+VL5DdHV9UbPD8e622b
 B90N5m8motvP7Ca1YnnWSPkuZQ2+awuetCLik1LLS+yO1FadLdsa8YykoSyFwaaSuvK7CFk4alA
 crjpexPZOECpI9AKO6sd49WUODqGDkBU1+cFj6FT9I/C50dppfU5
X-Received: by 2002:a5d:6d8c:0:b0:38f:4531:397a with SMTP id
 ffacd0b85a97d-38f6e757a02mr162870f8f.3.1740073327683; 
 Thu, 20 Feb 2025 09:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzjy3xv0SDc2/eG3mk12XntjZ7tbkkAAQIQMv0ZCnpIe02cckuHO6ronIqZ2h9J2t9dWp7ZQ==
X-Received: by 2002:a5d:6d8c:0:b0:38f:4531:397a with SMTP id
 ffacd0b85a97d-38f6e757a02mr162834f8f.3.1740073327229; 
 Thu, 20 Feb 2025 09:42:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7998sm20910035f8f.82.2025.02.20.09.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 09:42:06 -0800 (PST)
Message-ID: <854e0b68-b7aa-44e3-960c-00f3f2d80d44@redhat.com>
Date: Thu, 20 Feb 2025 18:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 02/20] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Zhenzhong,


On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> New added properties include IOMMUFD handle, devid and hwpt_id.
a property generally has an other meaning in qemu (PROP*).

I would rather say you enhance HostIOMMUDeviceIOMMUFD object with 3 new
members, specific to the iommufd BE + 2 new class functions.


> IOMMUFD handle and devid are used to allocate/free ioas and hwpt.
> hwpt_id is used to re-attach IOMMUFD backed device to its default
> VFIO sub-system created hwpt, i.e., when vIOMMU is disabled by
> guest. These properties are initialized in .realize_late() handler.
realize_late does not exist yet
>
> New added handlers include [at|de]tach_hwpt. They are used to
> attach/detach hwpt. VFIO and VDPA have different way to attach
> and detach, so implementation will be in sub-class instead of
> HostIOMMUDeviceIOMMUFD.
this is tricky to follow ...
>
> Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to
> wrap the two handlers.
>
> This is a prerequisite patch for following ones.
would get rid of that sentence as it does not help much
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
>  backends/iommufd.c       | 22 ++++++++++++++++++
>  2 files changed, 72 insertions(+)
>
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 5d02e9d148..a871601df5 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -66,4 +66,54 @@ int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                       uint32_t *entry_num, void *data_ptr);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
> +                    HOST_IOMMU_DEVICE_IOMMUFD)
> +
> +/* Abstract of host IOMMU device with iommufd backend */
specialization/overload of the host IOMMU device for the iommufd BE?
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
> index fc32aad5cb..574f330c27 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -341,6 +341,26 @@ int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
>      return ret;
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
> @@ -379,6 +399,8 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>          .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
> +        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
>          .class_init = hiod_iommufd_class_init,
>          .abstract = true,
>      }
Thanks

Eric


