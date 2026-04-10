Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F415F36B9C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB5qp-0007AB-Lm; Fri, 10 Apr 2026 03:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB5qk-00079t-G8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB5qh-0002hc-T0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775804413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zRL3Ilz/haqztIcZF0TTIUN59xJoRquekR6jZvaVTgc=;
 b=fuHO91l2JEg7rvtBWrConr6RmewGrVPQnZUonzcjXo5Y+fw/S6uuCJImdfpttLNcF4o+ph
 +9R8BePXAIOrEFUukzXQB49gkJIDV+YCVA/IJ6eETz96hn+IVbZNUxzqtB5r+PNuTd8xwL
 SYBtTgRznRkMggC5Qb23HpjocF937Bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-8xkNiSYnM266GwATEiMHNQ-1; Fri, 10 Apr 2026 03:00:12 -0400
X-MC-Unique: 8xkNiSYnM266GwATEiMHNQ-1
X-Mimecast-MFC-AGG-ID: 8xkNiSYnM266GwATEiMHNQ_1775804411
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488ba9dc026so8409375e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775804411; x=1776409211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zRL3Ilz/haqztIcZF0TTIUN59xJoRquekR6jZvaVTgc=;
 b=YsQGNcr2HymX+mv5yJIO0KxPw9+LGcuel9uTheHFYFNZuL6ntAKJNNKcsw4DTiANC0
 r1IhI3+pNhaYBws+2IrDqFPbBK503W34rhpqStib2GpDvg/sxLnFeiXzTcnyf4UWpPK6
 nwR90raj3IlwkDBFwQlExLyoki6Mf6h/rmFk4KjncJpKwuUh6gHNVzPV2IA856yR0cbZ
 t3YYzlu3iJkyM2QFdAHrpSt7Hg2SOWkcxk1xU4kncHmJeXzilmcV2c7JRfJuBSAJxh+g
 v6AF3B4Cq8hJ4QMVifodl8yj3Yeh3YYo11aFf09FDg7GxCh81vMXdYVIJ7dYnX6nm26S
 VRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775804411; x=1776409211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRL3Ilz/haqztIcZF0TTIUN59xJoRquekR6jZvaVTgc=;
 b=OtWG/tsqaRz6slRD8YAX140ttQ5BHWj8p07C9VLQc4FiuSlKYPDoFtXhCZhD6NNGJX
 tHqtZMYw6xg8R8EKYwR6bZTcDJJ0HgnYdOs2CA8FPzTKom7upwm6HrNGfO8pOydeZezK
 Y6uacezMhXPS/DcSzR8IOx+apZ/i4wB6yql6YbtksAzoF+z7p1O7rAypC8jHc5Cszmhn
 ZKUAkTkxvJAR6OUT2+5upRbS8IRc9RJN8qSGVi7my8gsGK3/xio8uzkgLkiRIf8GlTWf
 k0asJJVHOIm91LlHAgxAOZ5n5+0357D+JzvPppY0LUoqtxd88Cmq7ZW0WxrVFUpXRZva
 9TMw==
X-Gm-Message-State: AOJu0Yw60a5YFSrVOtgIY4EZ3Pw+WqjWQnNcBKGXAd8pv8kVVrPLRlUj
 Bp5MFE6ugqVL58vl4OL9I29iTMAZ6xq4XZ+zyVd0uJ3Tz97GB134b0U8lRGjwM5y6cEE+oUacjR
 f90cJk+4xcgJrjXieWA9Ep/8Yz0qhV2RUwogkDsI4j7Di3D7VWOaJPVsGrkbG9vY14QkUC6ESHD
 l8dSNpUYOZF8WVUiAv8Jj4XFpoTUrLBNZDfA==
X-Gm-Gg: AeBDieuZz8pQNNTPJSLuk675O8f3cRa/dHJzq+CTsKo391yIEx7F7Er24kI6vBWkhxm
 DXHWF4aEwh8E417VCzKUm1epB4s3fiKZWklXPMJCa2VcwLF3HbQySKrrD6spBzdOk97ab2CfQWV
 rihQqOTbpM+DvG4EY1NwcT1hydgzISqRjGSiPwFUXRFIz24hoj4JWPRhvIJPROpyaJccKdeYN9c
 931psQNyFJnksjNwG7PzQDhOujFfZGRvBDYdqZ7Wt1AwJmjd6QyXTuoEt9zp4Li+oMkrGRjZEQh
 e96uzz5t3SlUyYwZPAsylSg5X+ifN/trKQLGEqBS/94YpDFUPhfUk9qo8usiQEXvh5v3lwz+g7f
 HEzdPwaSy+5/b0Aj44sKDQT/A6AnUfmD7MiYM3pJN6CmGB/1fgMzUKUtjFg==
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-488d685b577mr16997255e9.21.1775804410336; 
 Fri, 10 Apr 2026 00:00:10 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-488d685b577mr16994955e9.21.1775804408243; 
 Fri, 10 Apr 2026 00:00:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ef00sm59512955e9.5.2026.04.10.00.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:00:07 -0700 (PDT)
Message-ID: <f0d95915-f8f6-4c37-a211-5313d48ba120@redhat.com>
Date: Fri, 10 Apr 2026 09:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Add VFIO I/O backend capability flags for feature
 support
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, John Levon <john.levon@nutanix.com>
References: <20260409114312.1704062-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260409114312.1704062-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/9/26 13:43, Cédric Le Goater wrote:
> Different VFIO I/O backends support different features. For example,
> the kernel VFIO backend supports DMA-BUF creation, while vfio-user
> does not. Currently, this is handled by attempting the operation and
> checking for -ENOTTY, which can lead to misleading warnings when a
> feature is simply not supported by a particular backend.
> 
> Introduce a capability flags mechanism in VFIODeviceIOOps that allows
> backends to explicitly advertise which features they support. Callers
> can check these capabilities before attempting operations, avoiding
> spurious errors and warnings.
> 
> Cc: John Levon <john.levon@nutanix.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-device.h | 13 +++++++++++++
>   hw/vfio/device.c              |  2 ++
>   hw/vfio/region.c              |  5 +++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index a95c5bf50302a7394582dcc493d96aef00b47dc8..380a55d6e5ea280c8f44016c7a8a1dcb8f4c00fe 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -172,12 +172,25 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   
>   #ifdef CONFIG_LINUX
> +/*
> + * VFIO backend I/O operation capabilities
> + */
> +#define VFIO_IO_CAP_DMA_BUF        (1ULL << 0)
> +
>   /*
>    * How devices communicate with the server.  The default option is through
>    * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
>    * process.
>    */
>   struct VFIODeviceIOOps {
> +    /**
> +     * @capabilities
> +     *
> +     * Bitmask of VFIO_IO_CAP_* flags indicating which features this
> +     * backend supports.
> +     */
> +    uint64_t capabilities;
> +
>       /**
>        * @device_feature
>        *
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 8f7ae919a55dd9e08bdd072eee33f5b46a91aa2a..3ffd69a579b8ac135ef729d3d836c8545e36786b 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -648,6 +648,8 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>   }
>   
>   static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
> +    .capabilities = VFIO_IO_CAP_DMA_BUF,
> +
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
>       .get_irq_info = vfio_device_io_get_irq_info,
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 47fdc2df349b65c6be6c9605b7a38a4e367f0475..0342ca712acd0ad846685115c29432c15aa966a0 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -293,6 +293,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
>       size_t total_size;
>       int i, ret;
>   
> +    /* Check if backend supports DMA-BUF creation */
> +    if (!(vbasedev->io_ops->capabilities & VFIO_IO_CAP_DMA_BUF)) {
> +        return true;
> +    }
> +
>       total_size = sizeof(*feature) + sizeof(*dma_buf) +
>                    sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
>       feature = g_malloc0(total_size);

Applied to vfio-next.

Thanks,

C.



