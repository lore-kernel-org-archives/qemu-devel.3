Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13F1C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNxi-0008EM-Er; Wed, 12 Mar 2025 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNxc-00088v-1i
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNxa-0001Bf-3Q
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741793128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rW+zj2edgGhgvM5O8G2t42DNKGJdQnzrsKNbBJcSZtk=;
 b=E7QT3XSncV9CvDe7vAK3CWXXRB90ZrwdQtgOvw45N4yhfQFTw/fjpl06M5WfIrrxbOzknP
 fLsgxSzgSlfF/Kjas+bQ5lNlj7um3ggZXGcyYxZpCePEcosa+P0eSvlbVnPMdXHq+ZMuG7
 zA0W7Sc5UuBofgqUqkzuBQiljMun72s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Pa3pJVfeOpivaEwOGaLFUQ-1; Wed, 12 Mar 2025 11:25:27 -0400
X-MC-Unique: Pa3pJVfeOpivaEwOGaLFUQ-1
X-Mimecast-MFC-AGG-ID: Pa3pJVfeOpivaEwOGaLFUQ_1741793126
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8f9450b19so21067736d6.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741793126; x=1742397926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW+zj2edgGhgvM5O8G2t42DNKGJdQnzrsKNbBJcSZtk=;
 b=FhsE48WcYPhjQVVNhmhPi1Xyfsr13sHKmP4FyzusGlQfaetJWZMonCIXrxLv2w+Iz6
 SYFmracfH2tJgvU19h3zAJpHZkZXKtK0L+KB7Yc6T/d7tbICVX3mUxgoNNNLIgsSjsg7
 02nUold+/9T98X1fIc7wmgzipzTI/ZL8G6vKbzBMDugIuxfbscETkqnDVPmRWMqEALBB
 JWwan+zVt0QBQj30WGhc7QrUAHjzTRpzo/KoRt0L0iY3jRXPIk3MzQU18e0268qjKzIS
 PJnVstA4hOFCnOsfxPV7kmxfiAo8Sn4FH+A+x57+ydzELMAfd/thXlOV5dqb3axStqnY
 MiTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/IywDmXc9HsLOBVNXgqRxNMqCy880Nj+zX7zAZLo4OkS2mbpWLH+rDdXuSkYR4WlqEBWfbrjp0msz@nongnu.org
X-Gm-Message-State: AOJu0Yytkd6jCwqdaEI87TI7joqQZSLhRYMuIoFTnR7WEI5K3ea64t3g
 mIi8V8wy6GAHwVuIXWBBkNbi9ULSoiOwfWkcXBroaRawlEpHUoIJ+aeBsF1Omt5Z8vaV0ZXp0fr
 IFRlHXXpU0c0f2KM3j6TLfG5s1Mt6Wkejaff9tKpzzvMA6J48TapGd3RPwUPZ
X-Gm-Gg: ASbGnct5nj8kf3X1tVGbDJZfdrGWE2OgNAemhdHem9pm9wV5VVCYy5m5/fhGCsWRtnW
 2IlFaDFs4L4BdOLroRh9xU0lX2Wh6wH0gYLpYuntXgbUUxs4Hu1tVowci5JjI4L/jsDYYnasMip
 A1QFizRJ/gpG4cr/4bhai6uo/ywyd+xJ8XxBRuZF4WOjs6He72iO92Z3Kgdwgu+pgTZ1NTJcOvl
 ZLIg2xmjH4s4UKba1XdEKyklQdZ7rkbogL7p9l5JWeZ7yxNfbGiXFCJ7c152qnltB+5YhOnq2hT
 BbQino9EiqtOiQdXmdV3b5M80TWxR0YsIwAx1JDm1ICpPWqMTmk0uTwxT74g8vI=
X-Received: by 2002:a05:6214:224e:b0:6e8:9053:825e with SMTP id
 6a1803df08f44-6eadb56a10bmr662446d6.17.1741793125879; 
 Wed, 12 Mar 2025 08:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyFNmpwj+AcMLtUivIqr5uhtj0+sqlpUCXVtQY9Qg01nqXZtcUxt9gI8B17qi0+7U2LiIRZA==
X-Received: by 2002:a05:6214:224e:b0:6e8:9053:825e with SMTP id
 6a1803df08f44-6eadb56a10bmr661996d6.17.1741793125574; 
 Wed, 12 Mar 2025 08:25:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c3dfsm85973996d6.7.2025.03.12.08.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 08:25:24 -0700 (PDT)
Message-ID: <0574747f-7fee-4657-9a74-2d6f6f46c2c0@redhat.com>
Date: Wed, 12 Mar 2025 16:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/20] backends/iommufd: Introduce
 iommufd_vdev_alloc
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-3-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


Hi Shameer,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add a helper to allocate an iommufd device's virtual device (in the user
> space) per a viommu instance.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  backends/iommufd.c       | 26 ++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h |  4 ++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 3fac08c96e..3511dd32ab 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -366,6 +366,32 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>      return true;
>  }
>  
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_vdevice_alloc alloc_vdev = {
> +        .size = sizeof(alloc_vdev),
> +        .viommu_id = viommu_id,
> +        .dev_id = dev_id,
> +        .virt_id = virt_id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
> +
> +    trace_iommufd_backend_alloc_vdev(fd, dev_id, viommu_id, virt_id,
> +                                     alloc_vdev.out_vdevice_id, ret);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
> +        return false;
> +    }
> +
> +    *out_vdev_id = alloc_vdev.out_vdevice_id;
> +    return true;
> +}
> +
>  bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                             uint32_t hwpt_id, Error **errp)
>  {
> diff --git a/backends/trace-events b/backends/trace-events
> index a835827540..86c8f89e8a 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -20,3 +20,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>  iommufd_backend_invalidate_cache(int iommufd, uint32_t hwpt_id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d hwpt_id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
>  iommufd_backend_alloc_viommu(int iommufd, uint32_t type, uint32_t dev_id, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> +iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 7e5507f2db..53920bae5b 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -59,6 +59,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                    uint32_t viommu_type, uint32_t hwpt_id,
>                                    uint32_t *out_hwpt, Error **errp);
>  
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp);
> +
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,


