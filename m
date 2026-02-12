Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5BCEDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRm0-0006GB-MW; Thu, 12 Feb 2026 03:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqRly-0006FZ-V8
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqRlw-0001Kj-Bt
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770883799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iPNFVM5K7kmcNeijs/QmTxaZEPuhFkkrDpri17Qs68=;
 b=jG8BAFFZZj+sRvqidlRRxT1U9iGIcRmYuBbC6gXBi6lmAxI1on9g+wugLG0Exxj4ttVsoJ
 DGUIvRCrqJKJ9lPFmtfqWPFf0+ki4W4JtOGxhrJAlPcaBE9n5NhuYnrBT1MHD4nRHtDHmn
 jbQdk104utvjHG6Ud0eFuRyyNqeUn2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-p9NdtV6mNh-CDlJyUaxq8Q-1; Thu, 12 Feb 2026 03:09:57 -0500
X-MC-Unique: p9NdtV6mNh-CDlJyUaxq8Q-1
X-Mimecast-MFC-AGG-ID: p9NdtV6mNh-CDlJyUaxq8Q_1770883797
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806fa4a180so57104475e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 00:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770883797; x=1771488597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iPNFVM5K7kmcNeijs/QmTxaZEPuhFkkrDpri17Qs68=;
 b=u8MMRGf9bjNisZoqH2M3KpEptQTecw0wf8LkPpQBYF+MgqgiQ9NjzvyIo0Ppte9U3p
 1FUvpm6qxc4Pw6VpUbV1ytJLIPGc2D16MButV2bY4tC0KH09tla8WXZyyeUm1oAmG7mI
 DEtQ8uV0x05WURvlYbHRgdiIO2HftdIouzD8mGPzW6c0EivGsu/VgElFSTqlOGh17/o6
 8jADzUMhIqWZ8uu/NmFukya1OamauIQlILoeoSQB8ga/8NKYQ89oZ3EcSXVX495JWGDj
 9xDzL66L0BM534wb4E8qY95I2Oty7g4kBx3rPkv4IPxjXdycWOciWXCSoLjBG6wG9gaa
 A7KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW1f8wQY0RuWtXxTFBHtLfL8HD9HtCrUFz8VNC/1thJp+tmIy6uIxNMaVLalU7ADSR9MX+RZghxuQw@nongnu.org
X-Gm-Message-State: AOJu0YyctLUstWVRmH2634MCKMOJ6txtQuEVQXoXkwYZ052sI+ybTZrW
 spU9EEwQoZ5y9gFM8yxlz5nUUFtozzQ7K3JXBSW2lxQmWbFm1sTfEmRGbWtk6EBhQjkKDqAiE3p
 ivSaPWQkOdUk0ety0XIL9Dtao0nth7JGju+0sxyNZ0cy4OZ88X+DngYy8
X-Gm-Gg: AZuq6aLthrb2/vw7YbOR9R5Jsy2EZNPUTXI2bO8OhEPfPdIo6fEEGg88jnskdQoU9n8
 WMF3+4LbXCTCUmbtXzsq1dNQDQm7HKV12xNLpjTnVMKgYkzZt8QYVbPjKVhct9WXgDgq74xRJ+C
 GiJy8XjLnGM3GvDm3ihph0KDI9SstwzXLhRLSiWZ/61d3WTOrlJWXy17WAvO1VblsChpKIe/gt7
 5mn8/vPHaXnzTRRaiI0OksCqsH8q3QNay0cGSIaVxLSBSmIVzT8O+X879kreUqXkLameyQVZmWp
 wWAqX1vzD1jU1I7KfOBGcZOQFjgESyIyimt3M2H6VJjnLyitxNBYG+/MPIRMjXYyfcUszfWzFOM
 CRVIFV1yUG2NRrAYOXaIJAQYi6ilKVi+UIoB6EwDblMrro8G2aXDf0DXBN31sd/4RukNXwA==
X-Received: by 2002:a05:600c:c165:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-483656c10b1mr20703245e9.10.1770883796593; 
 Thu, 12 Feb 2026 00:09:56 -0800 (PST)
X-Received: by 2002:a05:600c:c165:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-483656c10b1mr20702895e9.10.1770883796038; 
 Thu, 12 Feb 2026 00:09:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a66fcf7sm47489735e9.7.2026.02.12.00.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:09:55 -0800 (PST)
Message-ID: <a5c6b9bd-d505-4917-8ca5-28e703c47ea0@redhat.com>
Date: Thu, 12 Feb 2026 09:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/24] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-3-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-3-skolothumtho@nvidia.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> The updated IOMMUFD VIOMMU_ALLOC uAPI allows userspace to provide a data
> buffer when creating a vIOMMU (e.g. for Tegra241 CMDQV). Extend
> iommufd_backend_alloc_viommu() to pass a user pointer and size to the
> kernel.
>
> Update the caller accordingly.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c       | 4 ++++
>  backends/trace-events    | 2 +-
>  hw/arm/smmuv3-accel.c    | 4 ++--
>  include/system/iommufd.h | 1 +
>  4 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 5daefe505e..8ab26eb786 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -460,6 +460,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>  
>  bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                    uint32_t viommu_type, uint32_t hwpt_id,
> +                                  void *data_ptr, uint32_t data_len,
>                                    uint32_t *out_viommu_id, Error **errp)
>  {
>      int ret;
> @@ -468,11 +469,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>          .type = viommu_type,
>          .dev_id = dev_id,
>          .hwpt_id = hwpt_id,
> +        .data_len = data_len,
> +        .data_uptr = (uintptr_t)data_ptr,
>      };
>  
>      ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
>  
>      trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
> +                                       data_len, (uintptr_t)data_ptr,
>                                         alloc_viommu.out_viommu_id, ret);
>      if (ret) {
>          error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
> diff --git a/backends/trace-events b/backends/trace-events
> index b9365113e7..332888a576 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>  iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
> -iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> +iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t data_len, uint64_t data_ptr, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_len=%u data_ptr=0x%"PRIx64" viommu_id=%u (%d)"
nit: I would put the data_ptr first and then the data length to match
most prevalent pattern. Also use hexa format for the length?

Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>  iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
>  iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
>  
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 14ea4eac37..9036b14601 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -531,8 +531,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>      IOMMUFDViommu *viommu;
>  
>      if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> -                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> -                                      s2_hwpt_id, &viommu_id, errp)) {
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
> +                                      NULL, 0, &viommu_id, errp)) {
>          return false;
>      }
>  
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index e4ca16da70..5ef23ad9e1 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -87,6 +87,7 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  Error **errp);
>  bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                    uint32_t viommu_type, uint32_t hwpt_id,
> +                                  void *data_ptr, uint32_t data_len,
>                                    uint32_t *out_hwpt, Error **errp);
>  
>  bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,


