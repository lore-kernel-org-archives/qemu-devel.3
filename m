Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36986F3383D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Vbx-0007Yw-6f; Tue, 17 Mar 2026 10:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2Vbv-0007YZ-LD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2Vbt-0007p6-4z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773758487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONrfxkr/5XfbhzzS/IH+e+8yed/LtBVSQzWZjKjGt/Y=;
 b=e1QGyys1e5lG4Sy1RO9b+dzEOPBcPS/Rqj2Mplku0o0cWLYrA6+hkHI5RqM05E1jNhNTxC
 fT7/7tjlzv3b7e1KthT9IhL7xq1vbBsbeOfGjSj4qeNFLnRemhi8xmAjtFMFClQtzXS81u
 uDVYQwiIP9H2pvDQIM3gv/LbxqUvwxM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-bvmJ8K55Mje1WD9XN4vbdg-1; Tue, 17 Mar 2026 10:41:25 -0400
X-MC-Unique: bvmJ8K55Mje1WD9XN4vbdg-1
X-Mimecast-MFC-AGG-ID: bvmJ8K55Mje1WD9XN4vbdg_1773758485
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509159f57e0so65413941cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773758485; x=1774363285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ONrfxkr/5XfbhzzS/IH+e+8yed/LtBVSQzWZjKjGt/Y=;
 b=ZxJtAMPOZOzKY/255OnZAytBlVTxYzfi4uNFBeCseWDX090+qyK5cVSERpP4rHFI+f
 GGRSlOwI/OCI+YfN9c7TWlb7azrQ1WF4eqkFU4VNnOZgsZRj/4jTCxO0oAjdspcN2swF
 WOfOs++0B88x6sZJdClv+I2wqdyoDNmAj/byj7a09LJ645tnBa2Xr9LTIK/hrcbypFGL
 z6TNubTNDe6bcuBo83LYGUi72/ibUNwQvhxhACwk0+rwmCRPYTwXvC41nqp4dvCM5jwA
 fgb+N5UNPuAQXM4iX+bXqmz+qtnugdwMk9h2arxCqkYrBMa/S68+XgjEtLDSfVjXWl6n
 kinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758485; x=1774363285;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONrfxkr/5XfbhzzS/IH+e+8yed/LtBVSQzWZjKjGt/Y=;
 b=DgS134O24BCsTd8dZfR3BJF+M1tJYfsp/sl44eQA2GrU7WyNYpKe+fWgKL3BQquTIW
 X67qzMjGlT3Wlu+xCJBRRyYdZMiQKHP9sFeXROZTs6Kexsaoclq+xUHAnXJuZkCZ1qwD
 5+uFNKoAXRDfwbh1t3D9R+l0xaMSl1+/dzP+aualdw9kpluXCsuzgBaXVP86GKNsTyjX
 AS4cUdzfXeGRtvr5a/GFI6ThXS1BbuWQjGZYTGaaV2kF4jfHB2lZwFdeYCbmPKkXrnBS
 I0Ns6k/IV9p2s9Dg/Bhn5gOggnujkqV+uCJPcolFVzUjGl6DNTdhIgam0k5ZjJKL6eFq
 wD8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCDKBua+uOF+2IbFVu5VLs7PQIjOISuZD+VTFS5zyDna6sUHIyam0FFXpWvzt3SyeUZZhnHQUQTwpZ@nongnu.org
X-Gm-Message-State: AOJu0Yxsq8aZhmw/F3qALohXz7m0JHICvmMdOHq59dnXSRVIhRtaCyzh
 LsXluyHC5OL9sCjG+qwLfKoyjkcJWawfCzVfRKzICVI+sb6bY2ZJLh6gnOnSOiq8Mf5+O4COPNd
 K5zkeakMJKJlEPBv2lC/NdZWVb2EWEdhKJEoLLf4qW/rPAHBvCMsQnP5m
X-Gm-Gg: ATEYQzxm6hSiILyJlSy9rzdws2cH8sW9dUpJRoNuB1ybdgtYhfHFvqTBzTvjf+Oz5TF
 g/z+XSdZ8H9UgNEJ6huH9EfFCbVRXAp16M4jTcemPDR+p2kRVBOA/InU9a1///PbSPY1rQSxFcV
 4uB6lD5h8S4jfVgc+eY19ReJxD80h4DWy1lqQ6JZWmOd+KYaGWXMMuLbXlFctDGd/1qS+8xKMth
 AkWw8dOEv0l8q0B8T4pQRmVuzYtXjpcNo6XypVNiDi3F0K65Kd3vpXtWleMttEincMoErbc6cVk
 wijvPkeeDlw/L32Zly+fWU1P+KMwu/6jkzfdD48AdFvqYyWLJVQR1JviOxCh18jYoEcvRTJQrPh
 MEjRuoYePy4jPIQumm5kZhKJVpm6pRhbqgnEqtiuopioG223QuJrzLqAKlgSn
X-Received: by 2002:ac8:545:0:b0:509:96d6:ca0d with SMTP id
 d75a77b69052e-509986b0075mr32363551cf.38.1773758484611; 
 Tue, 17 Mar 2026 07:41:24 -0700 (PDT)
X-Received: by 2002:ac8:545:0:b0:509:96d6:ca0d with SMTP id
 d75a77b69052e-509986b0075mr32363301cf.38.1773758484247; 
 Tue, 17 Mar 2026 07:41:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b1348a5dbsm21411cf.1.2026.03.17.07.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:41:23 -0700 (PDT)
Message-ID: <2f048542-173e-4b93-ba4e-f7ce75788f73@redhat.com>
Date: Tue, 17 Mar 2026 15:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] vfio/region: Add a helper to get region index
 from memory region
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-7-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260311025340.1335673-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/11/26 03:50, Vivek Kasireddy wrote:
> Having a way to figure out the region index (or bar) associated
> with a memory region is helpful in various scenarios. For example,
> this capability can be useful in retrieving the region info needed
> for mapping a part of a VFIO region or creating a dmabuf.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/region.c              | 14 ++++++++++++++
>   include/hw/vfio/vfio-device.h | 10 ++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 47fdc2df34..4cb92216ef 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -539,3 +539,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
>       trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
>                                           enabled);
>   }
> +
> +int vfio_get_region_index_from_mr(MemoryRegion *mr)


I think you can move this routine as a static in device.c now. No need
to export a service.

Thanks,

C.

> +{
> +    VFIORegion *region;
> +
> +    while (mr->container) {
> +        if (mr->ops == &vfio_region_ops) {
> +            region = mr->opaque;
> +            return region->nr;
> +        }
> +        mr = mr->container;
> +    }
> +    return -1;
> +}
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 828a31c006..596c7f5a10 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -308,6 +308,16 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
>   
>   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_irq_info *info);
> +
> +/**
> + * Return the region index associated with a given MemoryRegion. The index
> + * can be useful in retrieving region info.
> + *
> + * @mr: MemoryRegion to use
> + *
> + * Returns the region index or -1 on error.
> + */
> +int vfio_get_region_index_from_mr(MemoryRegion *mr);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */


