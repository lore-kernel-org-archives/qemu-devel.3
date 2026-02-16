Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A69E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruPp-0001Z8-ON; Mon, 16 Feb 2026 03:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruPo-0001Yw-LI
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruPn-0003Qr-49
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771232230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CLFf55qeG6lOZnAu1HmnisQTBy55UvuuiTNtZejY2QE=;
 b=B9cqWuWVJvVZHrPq6dCC0vzmIHGwPDAiILiOE3Pb3jj72spn6XHfgkHjmNtmTksGjB55lq
 NPCZVTLGxrnUJNYW+/P2SMMVm5dhlgz/Ta0Mqj5jhbr5r/oIOuBIk6P7OHmhjcUAUxh/SZ
 ZqwF6sja/ftf2X5bmBCeEV2qB+KwFoQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-TblygGreM9eU3COuqz4OQg-1; Mon, 16 Feb 2026 03:57:08 -0500
X-MC-Unique: TblygGreM9eU3COuqz4OQg-1
X-Mimecast-MFC-AGG-ID: TblygGreM9eU3COuqz4OQg_1771232227
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso18819005e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 00:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771232227; x=1771837027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CLFf55qeG6lOZnAu1HmnisQTBy55UvuuiTNtZejY2QE=;
 b=IT9RknjicgOCegdPnsm1tJlrUmh6upDBWFG5KesHDRNmlP7qyCk5OZ2Y6ShCfi+1d1
 3w2N6ekYXQVrAEITODlXO844KO4faxQscl0thGr2dS4A0T92dqxnRz42chjjCkQWIrPr
 fk+bIX4UrTGdVC3K92GWMj4CVNIpJXOPhLSlbmx2jy69u52LwId5tPUbKL9kgM7ugTnW
 5E86kr8N1cvWVmjrO4sQbfSCrr1l29Dkr5GEo+oBHbG5PTSb1s2RPWy5Sn+OFO9fYNhN
 dE2CpYhjM7r+x7NydCVicORZQAlhFQ7M/8YipWfNsXm6moTdgLmk2/1U4WnRp05ngLiS
 FSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771232227; x=1771837027;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLFf55qeG6lOZnAu1HmnisQTBy55UvuuiTNtZejY2QE=;
 b=TdfrXFfoLgSzabqqd5BKU8zLRN3xRvvDbugDgDqoKA+TAmI6h2Vo3pMJCnvvEoGN1a
 XXWTEOeW/qzk44O7rE3wZuJ8WKhgNx7EsIHD1tkYekRzo9bnxT3+iv6vKUGvEmmKT6u5
 LmHcM5ruRmZPmBRHf4kdLpGTMpKHKkZlKqahGJ4pPP+LhS8pBZj+pz19axqBBlHQfnm0
 gXHEjNimVY4JdNM0yFHr61kwaiitnSL0qbyh0mri/2zwW7MrdrSwpW+0P1jhkiZMQ/6i
 8gpscQtqVWOE2oCCbU92E6/GTMp76wF0KBj2monLWRa1eVbrYFMNFM1nP5ktMjWWws3d
 cqpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARFTpACImWrWZ8zQq756QYs9gHSWao6sqDpmkM/E8u+Acks4c+Pb62y09JHY4mqMt9/ukiEUQRpTw@nongnu.org
X-Gm-Message-State: AOJu0YxW0w6H1NWu8d5eUhg80KPbI85WEsCeHJfY8kcTWWRV9PP9bh9b
 tH1eHgPZnAVi6R/2o6vwt124enegGyPXMyV23Yi7/PrlosnOrm1nfKkJWWmkUh+2nr4YO9kFrRV
 2EN/ziVJ9TchdxiY4kfyngzRlpDD0jOI3bNpDIbHPsOIADAx9vzM8l97i
X-Gm-Gg: AZuq6aImVR3Nou/tLnn3t5DztAnJpbMZ96rNK5dv1QCPgmlM7qb8xtd7xjBcBnWCSOH
 dcLRA3kzWZrPdShFV5tG/JmDgz/s6N08rBvkcznNfXJsd8WvRlRZCZ/ibUkZgOT0W94bUS0sS+g
 QbHm0g32C/RWz6D8V03Wu7z1tgkVhIGJqh+NSTqTf4gfNI8+FYQjyAXt9P27ZcDCtJVvYtXXPOB
 2JfKqxMuPOTepIdv8NKMkgRXGtRnR/W4C/a0d7EXTLYEh/Ie7s1CeyOJeXZfLtI9q9pl1qThx7X
 R0G5ErsG0oy+cYtEzXbVyiS4U38jLKtUAVAneYRmQrSAQxP39K6jvuZbCpc++i8l/f37UYnel7x
 C2fj+b4AXDxiW+PK4D2mtlGaPJFd11Xv3dt0y5InfRvnUkA8HNhtImXDTRPMT
X-Received: by 2002:a05:600c:8486:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-48373a1b533mr155345545e9.12.1771232226861; 
 Mon, 16 Feb 2026 00:57:06 -0800 (PST)
X-Received: by 2002:a05:600c:8486:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-48373a1b533mr155345265e9.12.1771232226427; 
 Mon, 16 Feb 2026 00:57:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d78cfsm644747945e9.1.2026.02.16.00.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 00:57:06 -0800 (PST)
Message-ID: <cb4cd08a-81c1-4027-bb41-c02426ba0f71@redhat.com>
Date: Mon, 16 Feb 2026 09:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] vfio: Add Error ** parameter to vfio_region_setup()
To: ankita@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, alex@shazbot.org
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, kjaju@nvidia.com,
 qemu-devel@nongnu.org
References: <20260215084950.4657-1-ankita@nvidia.com>
 <20260215084950.4657-3-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260215084950.4657-3-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/15/26 09:49, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Add an Error **errp parameter to vfio_region_setup() to allow
> proper error handling instead of just returning error codes.
> 
> The function sets errors via error_setg_errno() when failures
> occur.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/vfio/display.c     | 2 +-
>   hw/vfio/pci.c         | 3 +--
>   hw/vfio/region.c      | 5 ++++-
>   hw/vfio/vfio-region.h | 2 +-
>   4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index faacd9019a..bb9015804c 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -449,7 +449,7 @@ static void vfio_display_region_update(void *opaque)
>           ret = vfio_region_setup(OBJECT(vdev), &vdev->vbasedev,
>                                   &dpy->region.buffer,
>                                   plane.region_index,
> -                                "display");
> +                                "display", NULL);
>           if (ret != 0) {
>               error_report("%s: vfio_region_setup(%d): %s",
>                            __func__, plane.region_index, strerror(-ret));
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 36d8fbe872..c89f3fbea3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3056,11 +3056,10 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
>   
>           ret = vfio_region_setup(OBJECT(vdev), vbasedev,
> -                                &vdev->bars[i].region, i, name);
> +                                &vdev->bars[i].region, i, name, errp);
>           g_free(name);
>   
>           if (ret) {
> -            error_setg_errno(errp, -ret, "failed to get region %d info", i);
>               return false;
>           }
>   
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 177494c379..b83b09fa2f 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -227,13 +227,14 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   }
>   
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
> -                      int index, const char *name)
> +                      int index, const char *name, Error **errp)
>   {
>       struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, index, &info);
>       if (ret) {
> +        error_setg_errno(errp, -ret, "failed to get region %d info", index);
>           return ret;
>       }
>   
> @@ -260,6 +261,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                   region->mmaps[0].offset = 0;
>                   region->mmaps[0].size = region->size;
>               } else if (ret) {
> +                error_setg_errno(errp, -ret, "failed to setup region %d",
> +                                 index);

vfio_setup_region_sparse_mmaps() could take an 'errp' parameter
instead.

Thanks,

C.

>                   return ret;
>               }
>           }
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index ede6e0c8f9..9b21d4ee5b 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -38,7 +38,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>   uint64_t vfio_region_read(void *opaque,
>                             hwaddr addr, unsigned size);
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
> -                      int index, const char *name);
> +                      int index, const char *name, Error **errp);
>   int vfio_region_mmap(VFIORegion *region);
>   void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>   void vfio_region_unmap(VFIORegion *region);


