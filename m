Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70908CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHG45-0004wW-5U; Thu, 15 Oct 2026 03:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG3z-0004vn-Td
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG3y-0003Er-1I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792049980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xVAeqaPsqxRIJaF1GIm8eNcESWB6TOw9nTp4vQ6sYTg=;
 b=TXAhX5YSpPJI/W5a5azmsdTD7s9pqOI7pv78KkKp3Det4wkph/guaMw0RjEufb43Ga3cL8
 NhptQjoaEvKlZcxhhM+GALJFfVwp4h9hnIOE1eK63o4c2M70Wu39uXQQNlfMwalzjWkhGp
 xvGwQ5xOUaL3427tgxuzXI6Ph/ZoZTo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-o6r_LAz6MT-1J_N3Gdio8w-1; Thu, 15 Oct 2026 07:39:34 +0000
X-MC-Unique: o6r_LAz6MT-1J_N3Gdio8w-1
X-Mimecast-MFC-AGG-ID: o6r_LAz6MT-1J_N3Gdio8w_1792049973
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1b11e7837so19397195e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792049973; x=1792654773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xVAeqaPsqxRIJaF1GIm8eNcESWB6TOw9nTp4vQ6sYTg=;
 b=QLbtaOgDyypOzVduAocxEwKNNDacUx5ioOPJdTlhtzH/MZLSOrR1HhETjNkk4EVeID
 hkylXVPcJd21RdOX/VMxzaZk00PXDrFHU/Plp5RRuXw/5q2NKQ1c9RGAyVSwyvWV0q1K
 3IzNszwtHUGBZKdPzXH/jEuCxAIEElr1Nea7e35UwGpq7BfTjicE4CXdsBH9CifVCJS1
 8OlagVVsZ1vMaqwvsM1spnMQEIG48ViXbHbk/vN4VA6ofbcEHTki0Y4Y5W5RZcXN6j/N
 6tQAILGwvqHfVL8htMrCFxkx13tSVGVPcg6Z/5niUsuQbDYB3VyU243r6X+B8BxXtkxA
 Fa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049973; x=1792654773;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xVAeqaPsqxRIJaF1GIm8eNcESWB6TOw9nTp4vQ6sYTg=;
 b=MYTpN5Pb9bDyYv9jKwiDLQ7UuQyzz/vR05QtWAlZtElYHxjqzKnV4BjSKwitcPSVAk
 ZOnpCHlT3TbUbu3zZd7VOiz/z4ts2GJfdIyO0Agb5HtyC4bkI8tLWrkgNqn2vSzH8FWp
 xN7hOgJN2lihwt+dgHuM247qmElis6dIdrADhgjKJqlFY43yK4CGmbztyWN68QOHgXza
 Z35UtXe/A+RdSPXefw8ukkaqMb1Yi/kx6g52fHqFHf0v7Ks3TuLXou2DFNwYp32Nhkwa
 cPexFTS+fbErc9ipMlCB6emgsP1dZikkdIwRTvhKg9MUzhmSfpWDgfkQO+JIGWhoK67b
 JWNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxncgB91XUzIOHVAukok9IpRvwFJsChekZvqPh8zqcqozHLBr6ZDBu5OIcSAy3vdk3QHca4//wBB/FF@nongnu.org
X-Gm-Message-State: AFq9FYIW3DbH9t197qmo2ZEztIDyrUqFBxZ3sH5rHmwRH11LobqtgtTx
 4Irb4njleE5OKaYvvlbsvQiQz4YYaHJfCHppj6SFbXsHFad3R5wyAWlGlcyftz9e0temojWPrnH
 3/vdnHW9WbPJI6dQEm2GGsTGG8ajWUYVuchNJe5ZhdPMZjhKb68bkmtdW
X-Gm-Gg: AYBFou1inK4sUqNn/tGp0PPdgGVYlttjYkdiAfs28KA8R2ES/6kqnmTGL6UG/e2nE7m
 2Z6LXTVXazpH2D/X+vngH86ADnxnwQWaOXM1rWnbUctDXDfkkbHIa0osc4Nw/axMREEUyXktCVZ
 Xr6NFcYvFEW0EFqzRDE5fhBLqODWuFPpJfL8/g5/98ESSr/GyslmE6RjBPAqNbcqAk5B+OxMKad
 LHOapJ/GasTsHf7mJDga6HMiIM2q2/PWgyUaSNDK53CJc0w64ipREZJfMaxJtgKmDGT4ZK2UXzE
 gSD9dyxBWtKcP/dAO6ldnybsxQXiVeVvhpN2Qs1G6qWBIpSaWwjNAFWhCXM4lrhpWxCxbbqMHoC
 PCP48Av/bCcrS2paucUFkn1gqbYwIsJ1KX3bR+yPc
X-Received: by 2002:a05:600c:4f42:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a18e3ecfc8mr436500225e9.0.1792049973379; 
 Thu, 15 Oct 2026 00:39:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4f42:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a18e3ecfc8mr436497625e9.0.1792049971395; 
 Thu, 15 Oct 2026 00:39:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdbb4a30sm48595685e9.15.2026.10.15.00.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 00:39:30 -0700 (PDT)
Message-ID: <4fb67f68-a2d9-4101-b667-4d59067e2256@redhat.com>
Date: Thu, 15 Oct 2026 09:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-3-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261014211041.1087331-3-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Allow each sparse mmap subregion to specify its own file descriptor and
> file offset for the mmap call.
> 
> Add 'fd' (set to -1 when the region fd should be used) and 'fd_offset'
> to VFIOMmap, and update vfio_region_mmap() to use them.
> 
> Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>   hw/vfio/vfio-region.h |  4 +++-
>   hw/vfio/pci.c         |  2 ++
>   hw/vfio/region.c      | 26 +++++++++++++++++++-------
>   3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 58b236f113..9f6a5cf7d5 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -14,8 +14,10 @@
>   typedef struct VFIOMmap {
>       MemoryRegion mem;
>       void *mmap;
> -    off_t offset;
> +    off_t offset;       /* offset within the region */
>       size_t size;
> +    int fd;             /* per-mmap fd, or -1 to use the region fd */
> +    uint64_t fd_offset; /* offset within fd for the mmap call */
>   } VFIOMmap;
>   
>   typedef struct VFIODevice VFIODevice;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f069..f851082114 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1623,6 +1623,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>                                     vdev->msix->table_bar, 0, 0);
>           } else {
>               region->mmaps[0].offset = end;
> +            region->mmaps[0].fd_offset += end;
>               region->mmaps[0].size = region->size - end;
>               trace_vfio_msix_fixup(vdev->vbasedev.name,
>                                 vdev->msix->table_bar, region->mmaps[0].offset,
> @@ -1649,6 +1650,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>                                 region->mmaps[0].offset + region->mmaps[0].size);
>   
>           region->mmaps[1].offset = end;
> +        region->mmaps[1].fd_offset += end;
>           region->mmaps[1].size = region->size - end;
>           trace_vfio_msix_fixup(vdev->vbasedev.name,
>                                 vdev->msix->table_bar, region->mmaps[1].offset,
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 54ad11a6c8..16efed2fce 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -189,6 +189,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                               sparse->areas[i].size - 1);
>               region->mmaps[j].offset = sparse->areas[i].offset;
>               region->mmaps[j].size = sparse->areas[i].size;
> +            region->mmaps[j].fd = -1;
> +            region->mmaps[j].fd_offset = region->fd_offset +
> +                                         sparse->areas[i].offset;
>               j++;
>           }
>       }
> @@ -262,6 +265,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                   region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
>                   region->mmaps[0].offset = 0;
>                   region->mmaps[0].size = region->size;
> +                region->mmaps[0].fd = -1;
> +                region->mmaps[0].fd_offset = region->fd_offset;
>               } else if (ret) {
>                   return ret;
>               }
> @@ -354,7 +359,6 @@ int vfio_region_mmap(VFIORegion *region)
>       off_t map_offset = 0;
>       size_t align;
>       char *name;
> -    int fd;
>   
>       if (!region->mem || !region->nr_mmaps) {
>           return 0;
> @@ -391,8 +395,6 @@ int vfio_region_mmap(VFIORegion *region)
>           return ret;
>       }
>   
> -    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
> -
>       map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
>       munmap(map_base, map_align - map_base);
>       munmap(map_align + region->size,
> @@ -404,12 +406,22 @@ int vfio_region_mmap(VFIORegion *region)
>        * offsets being in ascending order.
>        */
>       for (i = 0; i < region->nr_mmaps; i++) {
> +        int fd = region->mmaps[i].fd;
> +
> +        if (fd < 0) {
> +            fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
> +        }
> +        if (fd < 0) {
> +            ret = -EINVAL;
> +            munmap(map_align + map_offset, region->size - map_offset);
> +            goto no_mmap;
> +        }
> +
>           munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
>           region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
>                                        region->mmaps[i].size, prot,
>                                        MAP_SHARED | MAP_FIXED, fd,
> -                                     region->fd_offset +
> -                                     region->mmaps[i].offset);
> +                                     region->mmaps[i].fd_offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {
>               ret = -errno;
>               /*
> @@ -454,8 +466,8 @@ int vfio_region_mmap(VFIORegion *region)
>   
>   no_mmap:
>       trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
> -                                 region->fd_offset + region->mmaps[i].offset,
> -                                 region->fd_offset + region->mmaps[i].offset +
> +                                 region->mmaps[i].fd_offset,
> +                                 region->mmaps[i].fd_offset +
>                                    region->mmaps[i].size - 1, ret);
>   
>       region->mmaps[i].mmap = NULL;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


