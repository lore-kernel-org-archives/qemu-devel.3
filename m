Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B379CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHG47-0004wx-HT; Thu, 15 Oct 2026 03:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG42-0004wK-Sv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG41-0003FE-61
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792049984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hKE9CywBX8b0n5l0+v41Om1Ya2NpV1+ARuuDRW3McaU=;
 b=DJdOXLN+rt8bm5PIb4bHibimhqEP5pZWwZmJCfLqXp5VmGk9RbcTMw3wr1X09ysZA8rJ/Q
 GRwqo6wp+/kBNhF2OiqM+7h3tPRTO9DBDKH6Miw23LMkRZ/jdzkJNY8sBl4GFjHgnvqIlz
 yozWw2hdbR8PGcyRXIhODsWHmCx3pA4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ZkGY52PcPiuulnbWi0fUwQ-1; Thu, 15 Oct 2026 07:39:42 +0000
X-MC-Unique: ZkGY52PcPiuulnbWi0fUwQ-1
X-Mimecast-MFC-AGG-ID: ZkGY52PcPiuulnbWi0fUwQ_1792049981
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b028d93c5so3596439f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792049981; x=1792654781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hKE9CywBX8b0n5l0+v41Om1Ya2NpV1+ARuuDRW3McaU=;
 b=GixQWA+a5lXbruaEO59NnPA0T3O8KHVgU+V06UhDH6Gux05WnF2t/hERhtgN1xwAy3
 xIq2aBo8Y9MwXeZCPPyUzRIm7htIg+gSAtm1AYz9a7hYkQS1XDCHAbPC/pMfjy6l+ulK
 liewL5qArxIKpvVid7g8e8CBuUTxD8c6FkSEfoHxhfT2U252XccL+5Y2PMS6WnC+p6c/
 8iEQFj8n8SoyBGYUUB6RLwqDzWR+i709GmLG9oqpA7p/mp3opHFLebh5v54kemTmW/0R
 bJ0lZxGsnV2IlHOoKgGVGUr5B6XMSRfapcBQ2ZFjzBk/h+gxclRRwDdeTzBvolvQC1Ng
 5I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049981; x=1792654781;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hKE9CywBX8b0n5l0+v41Om1Ya2NpV1+ARuuDRW3McaU=;
 b=cHNy4zy4/w9+spFdQBInLeBK2e4/vY90GWX/cXcrmlOygCI1aDBZoiC0YDLFuWLijX
 lbZ13oIbRvL1n4EAWv9YlSaJsJk+mxqfiE9uVuuvqKVKHe0lteLN7//7N8yRSrDrxxiu
 fW03zMmWu1UM2BPN2Qo7tcQqKcGV8qOv8KB8nW4Nb/t4tQP5wlx5M+t0qH4PJQgQP3h0
 QJY0kTKY7HmLI7pxccMetz+ivTy0VnmCiZlWEq5zIAFveUFSXIBRfuCBJtkeywR+63XC
 HEfFETCh4Iy06H/HgOAhHvFnrNjK9taqe8YZocpoyZGyXnNjDlhqzCMzZZ1pZLPwyiih
 Zhkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAFKB8KRLbDNRPoBJXoWsETorfuN3neK8IyR4dpt1xjKv1IqmKHe8lEYVjgPLecTTyh1arhILouhgm@nongnu.org
X-Gm-Message-State: AFq9FYIEIhD8hYOc4WrVSDSohLINBbd+IsFXp60oOeNabl02se7MorEp
 RJCiTiM/2IyfxuG7qBCsmlSqsfVSsaS6Z4/8YvFw7tSe3BZUzpXXq/tnNOZggioinusMwkV4D93
 HHx9QFX8UtsLkfx8aZo/DfpHn/GaSd71bvcEAU759SlslQrGTnU2zNvGx
X-Gm-Gg: AYBFou2YTrnnqk0elT83Nb1UfwEFLH+EOtKZBQ6orKOGztDGp9i8b/X9ISyJ8BP2vNc
 drYsTJOYOXovEBNCRazX8Dht9APcyys/GJzLSrfiFnjc64pxALNrpbsl13IFPLKIeCmJ0qj2QHm
 c7/C8sq26ziv2+i9wJKhzFqQiPzaI76YKMplq1w9vBmzl8jkTn2ziL+s2fLns1d7Vs+E2B+S3Be
 eqdMLJhgJLostMXc44+2+kGTFsXrgBS9hcdqvzdEZA2My0OBUpaH82LZ0X4OKUl/XqwyrT/fdDg
 YOm6LiF4x8P6+7TfzH+oPa9rJWwJrI1GsuaY7gShZPZc8FMVI39/vbijDN/4pACf7ET1bRoZTmI
 Oc4Uf0FLisQdTGMTsWSdPvFDy+SPl0T/0XnwU3P+0
X-Received: by 2002:a05:6000:4683:b0:48b:5e5:664f with SMTP id
 ffacd0b85a97d-48dbaadddcdmr24951982f8f.18.1792049981274; 
 Thu, 15 Oct 2026 00:39:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4683:b0:48b:5e5:664f with SMTP id
 ffacd0b85a97d-48dbaadddcdmr24951925f8f.18.1792049980591; 
 Thu, 15 Oct 2026 00:39:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df50bd11asm2705748f8f.8.2026.10.15.00.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 00:39:40 -0700 (PDT)
Message-ID: <b13640de-6ecf-4fd7-8d37-0a03976d3912@redhat.com>
Date: Thu, 15 Oct 2026 09:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-4-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261014211041.1087331-4-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/14/26 23:10, Naman Gulati wrote:
> Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
> backends (such as vfio-user) can parse custom sparse mmap capabilities,
> falling back to vfio_default_setup_sparse_mmaps() to process shared
> VFIO mmap capabilities.
> 
> Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>   hw/vfio/vfio-region.h         |  5 +++++
>   include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
>   hw/vfio/device.c              |  1 +
>   hw/vfio/region.c              | 19 ++++++++++++++++---
>   4 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 9f6a5cf7d5..a0c9533f9f 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   
> +struct vfio_region_info;
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp);
> +
>   #endif /* HW_VFIO_REGION_H */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8472420d3f..3136e152f2 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -43,6 +43,7 @@ enum {
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> +typedef struct VFIORegion VFIORegion;
>   typedef struct VFIOMigration VFIOMigration;
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
> @@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
>       int (*get_region_info)(VFIODevice *vdev,
>                              struct vfio_region_info *info, int *fd);
>   
> +    /**
> +     * @setup_sparse_mmaps
> +     *
> +     * Parse sparse mmap capabilities for a region and initialize region->mmaps.
> +     *
> +     * @region: #VFIORegion to set up
> +     * @info: region info struct containing capabilities
> +     * @errp: pointer to Error*, to store an error if it happens
> +     *
> +     * Returns 0 on success, -ENODEV if not sparse, or negative error code.
> +     */
> +    int (*setup_sparse_mmaps)(VFIORegion *region,
> +                              struct vfio_region_info *info,
> +                              Error **errp);
> +
>       /**
>        * @get_irq_info
>        *
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4f11959633..94d6e7ce09 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -662,6 +662,7 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>   
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
> +    .setup_sparse_mmaps = vfio_default_setup_sparse_mmaps,
>       .get_irq_info = vfio_device_io_get_irq_info,
>       .set_irqs = vfio_device_io_set_irqs,
>       .region_read = vfio_device_io_region_read,
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 16efed2fce..94cfb708bf 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
>       return 0;
>   }
>   
> -static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> -                                          struct vfio_region_info *info,
> -                                          Error **errp)
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp)
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_region_info_cap_sparse_mmap *sparse;
> @@ -198,6 +198,19 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   
>       region->nr_mmaps = j;
>       region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
> +    return 0;
> +}
> +
> +static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> +                                          struct vfio_region_info *info,
> +                                          Error **errp)
> +{
> +    int ret, i;
> +
> +    ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
> +    if (ret) {
> +        return ret;
> +    }
>   
>       /*
>        * Sort sparse mmaps by offset to ensure proper handling of gaps

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


