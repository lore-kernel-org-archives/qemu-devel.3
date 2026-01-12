Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA4C9EC9A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJMY-0003Vu-Ih; Mon, 12 Jan 2026 09:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfJMM-0003K2-AE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfJMJ-00021T-5R
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768229849;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MJ7u+G8s9lVs8w5hv+FIzeJcnkYeYWliICTSz7UkUo=;
 b=iAvTVsCRIEJNAYvU3JpeV6cBnCdDZjXTXDlhTKJQQ8cE6jE2Kl71IcPH/DQeqXqzwzv35t
 o80QNy95fCzrioeES7hcAZC6ae5MRXkqi0tEcprocygZXTaBHCo930COHwTcJGuvHfD1S0
 iA9X5dftx7IFYeYwkD0qxPepSgjQ8i0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-ImOOP8uWMcGZa4GikbcW7g-1; Mon, 12 Jan 2026 09:57:28 -0500
X-MC-Unique: ImOOP8uWMcGZa4GikbcW7g-1
X-Mimecast-MFC-AGG-ID: ImOOP8uWMcGZa4GikbcW7g_1768229847
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so40153775e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229847; x=1768834647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MJ7u+G8s9lVs8w5hv+FIzeJcnkYeYWliICTSz7UkUo=;
 b=lSRVB+S97xp2UKFhYs+5lr0tiWlSIET2fJlg0Q4Hyzh9JHmRoG6+fkkZCIjK0Kvvlc
 28K+JX1yguxsnD50toPVpM3ctazavdKlefLZx20/JKit9o5MVJEik5R6pFPJ4pY4RFDH
 P4BKwBOyjJ8XrzSFDDMe5E9B+K+DWLPlXIrG1c44+VlYIdogmVF6FOmNWsWZ7hidzp+7
 d9JQ6JrY728YB39Ulvxx6zdaIAQ1rnG4nOdNT2akSSwXfIF0WPZb8Ab0hfuZkhJOMMho
 LHi5hybF8EWjFcj0zawH9L9wNxufPz1mdogGsKwtaSHAE0fw/OEFoQEvOYsKPEaJ3yl/
 mHHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEZ5kcnPqGLFcGwmKFHepZX5PTiWaabh0+xB8Pk2SOsRyF+I6Pt+keyIPy2DUgts24tOV9U5TCw5oi@nongnu.org
X-Gm-Message-State: AOJu0YyeckxvAAz0Lo9kvLR3Yf4hO/LZfLsHjur4jOZJqukxrUimBUBk
 1Aai2opgAW48fsJBajV/RKz9POV8l0WIGWcSyx/88KrIQVXP97Rrp34Tnq8Xg03xlv4IIHnLX1+
 MdNsX1hGhL6B2gS7TQjICE62+QpmauwjtNHELf+zGwqMlVQPHNayd3M4d
X-Gm-Gg: AY/fxX4Jw3/raTw1y0BL55KF0QxPlbOLmDewHixxn9WL7xMHKbW2UjAJgeWWwlh4K4F
 yw6IvhA1OS/lQAaso91rJxg1B5ca43Xf4CB3r4X3th3uSG2wntE8zyOVxVmX2tn46r4ooTA+CIl
 fjlxj7IpqNnMS0foq15z2SgUJUewAB/oyY/ocqkljfnSdt2BJjjPdj+ftegMV3KnDAtjSCnbQIH
 wtTpPAB46uWUZju+h/AoGFShCDwu6QVL0NbtUoN0cBtRU0Mrx6WxFLm+Oezu7o850KKEG3c9yJe
 KYkZs/VFZ94bG1bev45x9sU7nj3Zz4BWbRGz5mjelX2XHjffuIuQIkUV8eAfFpHV10QKYwBoQTP
 Gh+Y7Bm9xYJOWRsX45kr/iLgZ5u0tkfcYdgI/LaAvpYIXtgp6pj84IWCL0g==
X-Received: by 2002:a05:600c:1991:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d84b4119amr189914125e9.32.1768229846792; 
 Mon, 12 Jan 2026 06:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlIIYNEMoom08idoZMhyOKCG4KhEPaG55aAntO7VvYDMN89d3ry1WvIBnxCNicNTe92cTpcQ==
X-Received: by 2002:a05:600c:1991:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d84b4119amr189913805e9.32.1768229846347; 
 Mon, 12 Jan 2026 06:57:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8719e695sm130679535e9.17.2026.01.12.06.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:57:25 -0800 (PST)
Message-ID: <87cc30d4-53e6-4fff-8784-7fd847cc3ba8@redhat.com>
Date: Mon, 12 Jan 2026 15:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/16] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-5-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
> a vIOMMU instance. This allows user space to access HW-accelerated MMIO
> pages provided by the vIOMMU.
>
> The caller is responsible for unmapping the returned region.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  backends/iommufd.c       | 24 ++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h |  4 ++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index a644763239..015e5249d6 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -575,6 +575,30 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
>      return true;
>  }
>  
> +/*
> + * Helper to mmap HW MMIO regions exposed via iommufd for a vIOMMU instance.
> + * The caller is responsible for unmapping the mapped region.
> + */
> +bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                 uint64_t size, off_t offset, void **out_ptr,
> +                                 Error **errp)
> +{
> +    g_assert(viommu_id);
> +    g_assert(out_ptr);
> +
> +    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
> +                   offset);
> +    if (*out_ptr == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "failed to mmap (size=0x%" PRIx64
> +                         " offset=0x%" PRIx64 ") for viommu (id=%d)",
> +                         size, offset, viommu_id);
> +        return false;
> +    }
> +
> +    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
> +    return true;
> +}
> +
>  bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                             uint32_t hwpt_id, Error **errp)
>  {
> diff --git a/backends/trace-events b/backends/trace-events
> index a22ad30e55..046f453caa 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -25,3 +25,4 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
>  iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
>  iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
>  iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t vqueue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t vqueue_id, int ret) " iommufd=%d viommu_id=%u vqueue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" vqueue_id=%u (%d)"
> +iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 9b8602a558..e3905c9a40 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -110,6 +110,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
>                                      uint64_t addr, uint64_t length,
>                                      uint32_t *out_hw_queue_id, Error **errp);
>  
> +bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                 uint64_t size, off_t offset, void **out_ptr,
> +                                 Error **errp);
> +
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,


