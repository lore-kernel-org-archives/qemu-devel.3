Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A534C9EC77
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGMJ-0007K5-Gf; Mon, 12 Jan 2026 06:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfGMB-0007FX-Uw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfGMA-0004fZ-4C
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768218308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=68FKbIRYPA5moLbkgPsZxgaBLh7tBsg1Fb25YY+NDyg=;
 b=IXfBRMSVTPmiWMe2CBSmmpfeS6ZSqpRyN17EA7EsFyA9jW0natA4j57k1cSdqQNBe0clcJ
 TIZtL6ywrBbnp4NYSFIkzqSb2hrwoKzx7I+EIaurhRxGhy9FNiWzcdT/WGMDMVcOgLDcrE
 a2g3OBvVWfSdBJRu8zC1qDkB/mRocuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-GLMRz0LsMje1atGujmOHlA-1; Mon, 12 Jan 2026 06:45:06 -0500
X-MC-Unique: GLMRz0LsMje1atGujmOHlA-1
X-Mimecast-MFC-AGG-ID: GLMRz0LsMje1atGujmOHlA_1768218306
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so3600032f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768218305; x=1768823105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=68FKbIRYPA5moLbkgPsZxgaBLh7tBsg1Fb25YY+NDyg=;
 b=GiXaJTASD010LEyilbrEtKRiIq9gHKbRuBtw4+jbUD2t59fmrplF5lTgn+7GXVDxIf
 PnTRCADwxJjhcccUt4nw1adIoS5lTUejfW/vqSMVECnsO9oDBtcwdGKovvhQhAMO0u/N
 KR+ns7tViLW5bBRCv1Pw7fxqYz+PW6NTNVqFKhBdjLaU7+c/c7qBYYS1lwblwOPW5Jt3
 SRlRVNnK4j0S/U92psjztsDfqHeHRzlMzQOG6Nr/Zo6KQlevQnD7grmVXwtzoXHZjy4X
 5tDiyhwUfDjEWcLxPYTD1rZGlCncBMs43et2cik7O039CReVUTRAegQ7YsHcgzMAwLzw
 EQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768218305; x=1768823105;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68FKbIRYPA5moLbkgPsZxgaBLh7tBsg1Fb25YY+NDyg=;
 b=HwOjmDdJoTzBmEi2lbpv9gx5f8iYe8ETn7o8uj3fFC+nTEnFAV3QzkP4DIzquhtmZR
 Ha/NOPT5L1+I+vC+tdGWOv4fJNfqnuhP+XhSKcsgSsh5DHqLm9WFHVNf6k0HvUtD+6qt
 xMU0HgepVzM4eqHgPbDqeHsS5NJfNQBF73et6yU225heFOMbGI8x0/Lf8xWZd0qVAQze
 qLUnZcLGqm6dcUHMwWvn73tryy15hMWqzrRVTGAzk3f88kvebLFXuxIqnRBjBGyqZCiV
 xgljalpGwHyU3PoU5L7llINQo+++olLCRzs/O1wqwje7ErqyPbxT56+bi08GXSCR5b3w
 3WLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeb4vgTkog9ea1uqnR+u0aw93vhXl8kIA2RiB+xShyGsq2BfTvgubB61lYRB2e27P6HkVkMQNKZscD@nongnu.org
X-Gm-Message-State: AOJu0YydPgLubrIn+ZTml+tIZvKtwE7Ite2vCLxSHYxspdub5Lz/lmEK
 uKF5QzF/rP8Nm5eI46m/wGKkls0n2q4TDBC1KhOtctKi/uQyOzUaaHBmgvhltCkGe8eeWuc9WfI
 njW3tJyKGEWa9eyoYR4o1K8Q8xX839SP4P+XUducxA3yBlCaWHZAuHCC1
X-Gm-Gg: AY/fxX7DGRfe4Y+yQ5WaB0VTxSuLRRF5hX57Qv6i7aO1OBla96wEZ+9HoiBYhWKmIme
 9b2R4nPhZsz+7f9FrM9khNKenItSX0Hz4yg7R0sVoCsJ4D1Qv/SLqyApMDvNHKaQk8IKysXNFhc
 VwbMjZXXESG4VZmJMMkttggw6dc4dWQawSAVTgKrTBTvT/5wwJKFZcEAQ0GL/7ozI2A19ofk959
 mVh1ok4ra10GZXaCu7x/et09VYWNKnvtJnVbzWPJcQ2dAHRclADQsm5fSgYeI/zGcudSEyvdk0D
 Fpfv4P4Pfpn1bHssXtIY/smuSw39XEVRclwfVXMdll7BaOBl9JEtgzRgNHFK7NSmfWQL7hnrxmn
 peiNpRewlXxJDPUEYrDR1n5gZC6tOWQgoeOYxf89WFg7gSuCp
X-Received: by 2002:a05:6000:1449:b0:430:fd9f:e705 with SMTP id
 ffacd0b85a97d-432c3787561mr21610255f8f.27.1768218305412; 
 Mon, 12 Jan 2026 03:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvZaLF4t/QXrnLZls7jOh7oifonI1qS39UeTvcHlYhoOW1QGx24WtBNKA8GxgjhoD8c4XoyA==
X-Received: by 2002:a05:6000:1449:b0:430:fd9f:e705 with SMTP id
 ffacd0b85a97d-432c3787561mr21610214f8f.27.1768218304924; 
 Mon, 12 Jan 2026 03:45:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa78sm38725179f8f.6.2026.01.12.03.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 03:45:04 -0800 (PST)
Message-ID: <30913bca-0c73-4448-82e2-02e1ea42cf09@redhat.com>
Date: Mon, 12 Jan 2026 12:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/36] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 alex@shazbot.org, nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-2-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260111195508.106943-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/11/26 20:52, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add a helper to allocate an iommufd device's virtual device (in the user
> space) per a viommu instance.
> 
> While at it, introduce a struct IOMMUFDVdev for later use by vendor
> IOMMU implementations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c       | 27 +++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   include/system/iommufd.h | 12 ++++++++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 3d4a4ae736..e68a2c934f 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -472,6 +472,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>       return true;
>   }
>   
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp)
> +{
> +    int ret;
> +    struct iommu_vdevice_alloc alloc_vdev = {
> +        .size = sizeof(alloc_vdev),
> +        .viommu_id = viommu_id,
> +        .dev_id = dev_id,
> +        .virt_id = virt_id,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
> +
> +    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
> +                                     alloc_vdev.out_vdevice_id, ret);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
> +        return false;
> +    }
> +
> +    g_assert(out_vdev_id);
> +    *out_vdev_id = alloc_vdev.out_vdevice_id;
> +    return true;
> +}
> +
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                              uint32_t hwpt_id, Error **errp)
>   {
> diff --git a/backends/trace-events b/backends/trace-events
> index 01c2d9bde9..8408dc8701 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>   iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> +iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index c0d7c50f7e..67c42f78a3 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
>       uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
>   } IOMMUFDViommu;
>   
> +/*
> + * Virtual device object for a physical device bind to a vIOMMU.
> + */
> +typedef struct IOMMUFDVdev {
> +    uint32_t vdevice_id; /* object handle for vDevice */
> +    uint32_t virt_id;  /* virtual device ID */
> +} IOMMUFDVdev;
> +
>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>   void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   
> @@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                     uint32_t viommu_type, uint32_t hwpt_id,
>                                     uint32_t *out_hwpt, Error **errp);
>   
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp);
> +
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                           bool start, Error **errp);
>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,

It looks like we are missing patch :

  "backends/iommufd: Introduce iommufd_backend_alloc_viommu"

I took the one from v6.

Thanks,

C.


