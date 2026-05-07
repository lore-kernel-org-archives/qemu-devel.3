Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC18CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKteR-00031x-QI; Thu, 07 May 2026 04:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKteP-00030N-Bx
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKteN-0003Zs-2J
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778140802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DFHuAzHuHC/RV/b9RSwDaDzOls4ZsC207cGRB3v6t1A=;
 b=ZwGffC6tWhjdJ5fX5gL7tBvD6Amjir1Vjd/xi20oZTScqzeOCPnuJL4kXv6FFBy5cSI/OD
 N5CMPr4vxqTI2VCe4ewETcwTLyvMEjP3HEVdxS9re6jeY3XihcaIWunVlzvxIG74hE5p/H
 wcZ+sU+J+dy2Ozewufc/Z6fszmGQYOE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-I0qL_ACVPOGuYgj745b_sw-1; Thu, 07 May 2026 04:00:00 -0400
X-MC-Unique: I0qL_ACVPOGuYgj745b_sw-1
X-Mimecast-MFC-AGG-ID: I0qL_ACVPOGuYgj745b_sw_1778140799
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4411a1f9601so434177f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778140799; x=1778745599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DFHuAzHuHC/RV/b9RSwDaDzOls4ZsC207cGRB3v6t1A=;
 b=bajliVJvVtMujwDoSrI2kVhLkQRoMUavAKRkIr8iERESAm5e0SqHhK5jAZtj+mcGba
 iKwPV61EoBx8l8pPEWkJdRlBv+NDjhEMWFsQmTq5uze7085GrTcmYfJx94ol0uCZyL0G
 EAcPrwWZmWX3XZMZh/9xkOabzYyiNS+tMQUPd6blJ+4o0Y6AV/WwPUFXw+lIvI/ZIbfN
 hnrKT8Hd3OYI0s7qtvTL16xbPMvZ5bkoWIBgxbngZUFwrHayFPbFL4mLryTNe+d3z9qS
 iuxrOsGFso1/9PfKtxCSaUI3ZuHJZo+JQ2K0Iimiubk8We/cFASOb03njOdEgMWn0lUU
 qOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140799; x=1778745599;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFHuAzHuHC/RV/b9RSwDaDzOls4ZsC207cGRB3v6t1A=;
 b=MiyO+3NeK9oK66vHQjpreP1C5fctjL5ocjIKymvWuQZIMuyCxEVSLGxTjcY+uTC7iV
 qlqvqeJcODd7z1mFkjer2eV5IapBBMHTanDWtPqVgh0aqHPyxqF1vqlqxEA5faXHWAzy
 o3fblK8xk143dY6AxKZ4/uRm1C+xMaOJC+l3GplZEWX+Mk0ANjrAldPE+evcGfn7A0ZF
 8aDLC55FAln5pOy/tOnBsHrctcqOTbU0vn91sgkam43N1MNPpPPsv2paFlZu+DjUtHpc
 v+DFEWcyZa6tgkdp0ai7aS3yT9z1L+4DNoMbe2vJpKHmzAsjiaqd/ev2n+GmcgaHzpkT
 l5eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o7nKZ/koG3RtSXY7TmLIekXcH+UT8+Aq615/B+bIk6EYgY2B4jYBo1W5kHi++DAKZqBKxq6A6Pg0m@nongnu.org
X-Gm-Message-State: AOJu0Yx8v4MHl3UaIOtcausX+kngePDkZCSYmx86GhYDAMq+IxXGgwS5
 l58rVwGeTPxCcM28qUkwp08nCnoGgmAx2ZdbBNX/7em1TABaLTB4Brg1Q+paxESfF/+pb2hOr4R
 qdErxgqYizFe/iAI3tz3MB6EjHumDp/senUJPB2uobcYSQoLthTIV6z0l
X-Gm-Gg: AeBDietqxhQiUZnRL+qcxSIO+ge112exc/RYlX+2+qPiqCtGTBJK3P73qYc2ya/rrvz
 +LzHf9hKXvRmZb/I+y2o+9hfzyHr1dhATzyXyrI82/886QzhAwfxZ3ToblYUfnnzwbEEZ8pJjdv
 cccChOB5ySqgdnCEwDdfnyjhsikjUqlTPulPWbGSMwePZ9+VAa5p/Qr7+K+45qalKcAvwG+jhXH
 NbJsCJ4lInpr8AUwIeou16kB2Ky/VcVI68n1Y0CEzMz9q9SBCAbwoc/Qa6xHjDspWWAekVgMZY2
 Jns48vcDa5PVm8Ddlz7fq/tp2kFl85MNvrgV9fWb9vV8b2D5WFv0vl8BaxX4xEFuj+GjZwilc3k
 iMyj5kRANEq5/cu12sC66gLbqDJSBVcMZTZHLtY/VUyWUBD29LwWVxBi/c882t/6U7RMjuFw9XX
 FZR31jrA==
X-Received: by 2002:a05:6000:250c:b0:44f:f4de:a844 with SMTP id
 ffacd0b85a97d-4515d2e6ef0mr11593429f8f.37.1778140798829; 
 Thu, 07 May 2026 00:59:58 -0700 (PDT)
X-Received: by 2002:a05:6000:250c:b0:44f:f4de:a844 with SMTP id
 ffacd0b85a97d-4515d2e6ef0mr11593339f8f.37.1778140798265; 
 Thu, 07 May 2026 00:59:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e7c0sm16637938f8f.3.2026.05.07.00.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:59:57 -0700 (PDT)
Message-ID: <7653a2e9-b747-4c29-a5db-d231130e383a@redhat.com>
Date: Thu, 7 May 2026 09:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-11-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505081423.28326-11-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Avihai,

On 5/5/26 10:14, Avihai Horon wrote:
> vfio_migration_init() already has many failure points and a new one will
> be added in next patch.
> 
> Add Error ** parameter to vfio_migration_init() to report a detailed
> error message through it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 243624b5fe..b7e929274a 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1038,7 +1038,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>   }
>   
> -static int vfio_migration_init(VFIODevice *vbasedev)
> +static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>       Object *obj;
> @@ -1047,23 +1047,38 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       g_autofree char *path = NULL, *oid = NULL;
>       uint64_t mig_flags = 0;
>       VMChangeStateHandler *prepare_cb;
> +    g_autofree char *error_prefix =
> +        g_strdup_printf("%s: VFIO migration init failed:", vbasedev->name);

We have error_prepend() for this purpose.

Thanks,

C.

>   
>       if (!vbasedev->ops->vfio_get_object) {
> +        error_setg(errp, "%s no vfio_get_object handler", error_prefix);
>           return -EINVAL;
>       }
>   
>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>       if (!obj) {
> +        error_setg(errp, "%s failed to get object", error_prefix);
>           return -EINVAL;
>       }
>   
>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>       if (ret) {
> +        if (ret == -ENOTTY) {
> +            error_setg_errno(errp, -ret,
> +                             "%s migration is not supported in kernel",
> +                             error_prefix);
> +        } else {
> +            error_setg_errno(errp, -ret, "%s failed to query migration flags",
> +                             error_prefix);
> +        }
> +
>           return ret;
>       }
>   
>       /* Basic migration functionality must be supported */
>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
> +        error_setg(errp, "%s VFIO_MIGRATION_STOP_COPY is not supported",
> +                   error_prefix);
>           return -EOPNOTSUPP;
>       }
>   
> @@ -1261,18 +1276,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    ret = vfio_migration_init(vbasedev);
> +    ret = vfio_migration_init(vbasedev, &err);
>       if (ret) {
> -        if (ret == -ENOTTY) {
> -            error_setg(&err, "%s: VFIO migration is not supported in kernel",
> -                       vbasedev->name);
> -        } else {
> -            error_setg(&err,
> -                       "%s: Migration couldn't be initialized for VFIO device, "
> -                       "err: %d (%s)",
> -                       vbasedev->name, ret, strerror(-ret));
> -        }
> -
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   


