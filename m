Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9E9D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdGW-0006lB-L1; Fri, 19 Dec 2025 11:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWdGT-0006b4-T0
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:23:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWdGS-0006Yi-5t
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766161413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DLcAMyYKR6zCzGKGUwwOKRWx0U8IoAe6ooxRyTL2G6A=;
 b=CPlRUIKz0VMBQfUDKB5vpfnUiJLxO0SqzfhoEI9/jsbhpqx+zskbmKAWvP8Llx59fa3qg/
 hmBhIxu2smoVqi+6dcqj0rFDEWQpd9imnOYdGrjcGvBaEWI2Wez4uYlpGc9cJXTAR49aoY
 Jl851DH/qfOnGp4ue3LeFsCdsHop6lo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-B--YMH9FO56QpyVqA_kCVw-1; Fri, 19 Dec 2025 11:23:32 -0500
X-MC-Unique: B--YMH9FO56QpyVqA_kCVw-1
X-Mimecast-MFC-AGG-ID: B--YMH9FO56QpyVqA_kCVw_1766161411
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so1854456f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766161411; x=1766766211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DLcAMyYKR6zCzGKGUwwOKRWx0U8IoAe6ooxRyTL2G6A=;
 b=anBuWjPCzwdd8RZ5qZKQYczXqseSoh21cVbvL0Wnle4Y7VpimcUNJmBaVEiEZPN2ot
 O8Dp20pvY1at++XR5RZ2ZZEduhqphztAUxvwAJCvEa0SYUViiTaqphH3rAEL8Uvo6sIq
 b3Hav/lg6DsiCZYkdgtvvK4StXOwxro30CLjp9yzVc6peE3bo3H3bcD+YO0Dynw7QDr4
 OTE4WQRIDoP7uwRfZsGf1nKw7W0duKwpou7i/QYNdOKSfRM3V0pS5J/AQojZAomI2i/u
 6yyOuac5GHiP7OFwwvKK1j9Eh5p8ubfrMyF5toZVfZwg1s12lNHvW3hOds/ws+oNckGr
 wA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161411; x=1766766211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLcAMyYKR6zCzGKGUwwOKRWx0U8IoAe6ooxRyTL2G6A=;
 b=srJ8NTnvcCAu4V1AUmpaXuDA5WJs92xQnayVqgS8Gi3CVNuxQf/yw079Q1ghsyTorW
 etSlR/ausLmcI9XrINDJEHBGnc99JnFA8quHngqNjkQ/r86d7uwsz+TvZFlo95xwQTF9
 Grtx4WH4aTFQwUQu+xMR3a62znoSstRmEUuU+mVm9bQOoE4u2qBnP/Kyq/yoF9rwpCbz
 f2pwW3+xPir1ne9Au+gbI3GF+NnXA0+ncCfnBxXvoNfe9tUSaAatWg6S0zAH9JOo6HK5
 ov2v4MKm9B/lu98maNAZe3azw7MUe68vPJ2IW6NPb8BnO7y8LImSW4ITx0hd+DQvtFM7
 3qKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8b+tZYJTiOKqCXd5JyhJF6uOoRBkMbUUN+3AEv1PamPjsHA++a45Y+znueuzwGxRn3f9d2Mg0cLTf@nongnu.org
X-Gm-Message-State: AOJu0Yy9UJocmtVR4U9P64r/l7icnJzobqsjR8nAKNbgJTYAY1LkT6LD
 jA7+wQF4a6IfdHhrCm8l6IBrrne2R4aZki9nJBw4ff7Ci8Q4NWFd6vo+SOfXqEN+yPT4afuVza4
 Ddp1N6JQJzatG1fd73JZNRC1G6ylDmrwa1tlRtAc4DyTOlk4dNvS1bdkp
X-Gm-Gg: AY/fxX5mWH/di347n7uUmdLPQxU3jbpMqTFfbaM9k1VpGsqqyj01LTJF8cjNcukqyGj
 P2/s5syS0aIgDZ6A1ym+LvIFC9iXXvt5s0zG1F4G6vvshvEl46iqlvGCq6JWMd8x5wDZ9DbjYgJ
 HvnqFingw2R9as4rDnn8uQk0bT84C7UslWTowJR9qj+dL9muyvorLm+sOQ2FTowGAQsUYMeP6mQ
 ltr3EnoNf3xr0Ig3JnyUD62I7Dm2glDuERJJN0fJID3/Lbjoxbpd3Jae/Hl6i7LfCxDjtu41YqG
 XrDHWSexbG1eavzVLINfOc2zJ3UwOs60IxrnIjIaGsHKjf78r6LwAfhsHKn1gqG5ds0insbwLGi
 3QarBQmV3LVUS0EaCZcK0+6SctvSONhycNcCL/xeeE/HXUQtg
X-Received: by 2002:a05:6000:178c:b0:431:104:6dd5 with SMTP id
 ffacd0b85a97d-4324e7090c7mr4036641f8f.58.1766161410968; 
 Fri, 19 Dec 2025 08:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMLjFuZ/Zj/4GneNc2pfH6auqIBjiZpw4vqvCodYE45nxy2h+576aNlHLnnuarEc8u8hmflw==
X-Received: by 2002:a05:6000:178c:b0:431:104:6dd5 with SMTP id
 ffacd0b85a97d-4324e7090c7mr4036605f8f.58.1766161410439; 
 Fri, 19 Dec 2025 08:23:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm5662528f8f.5.2025.12.19.08.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 08:23:29 -0800 (PST)
Message-ID: <6b359b40-2bad-4cfe-9cf5-4d8319bd3cd5@redhat.com>
Date: Fri, 19 Dec 2025 17:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] vfio: relax the vIOMMU check
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, rohith.s.r@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com
References: <20251218062643.624796-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251218062643.624796-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhenzhong,

On 12/18/25 07:26, Zhenzhong Duan wrote:
> Hi
> 
> This series relax the vIOMMU check and allows live migration with vIOMMU
> without VFs using device dirty tracking. It's rewritten based on first 4
> patches of [1] from Joao.
> 
> Currently what block us is the lack of dirty bitmap query with iommufd
> before unmap. By adding that query and handle some corner case we can
> relax the check.
> 
> Based on vfio-next branch:
> 
> patch1-2: add dirty bitmap query with iommufd
> patch3:   a ranaming cleanup
> patch4-5: unmap_bitmap optimization
> patch6-7: fixes to avoid losing dirty pages
> patch8:   add a blocker if VM memory is really quite large for unmap_bitmap
> patch9:   relax vIOMMU check
> 
> Qemu code can be found at [2], it's based on vfio-next + base nesting series.
> 
> We tested VM live migration (running QAT workload in VM) with QAT device
> passthrough, below matrix configs with guest config 'iommu=pt' and 'iommu=nopt':
> 1.Scalable mode vIOMMU + IOMMUFD cdev mode
> 2.Scalable mode vIOMMU + legacy VFIO mode
> 3.legacy mode vIOMMU + IOMMUFD cdev mode
> 4.legacy mode vIOMMU + legacy VFIO mode
> 
> The QAT workload is a user level app that utilizes VFIO to control QAT device.


FYI,

There is a conflict with :

   [PATCH v9 00/19] intel_iommu: Enable first stage translation for passthrough device

which one should come first ?


Thanks,

C.

> 
> Thanks
> Zhenzhong
> 
> [1] https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/
> [2] https://github.com/yiliu1765/qemu/tree/liuyi/zhenzhong/relax_viommu_check
> 
> Changelog:
> v6:
> - check global_dirty_tracking in vfio_listener_region_del() (Liuyi)
> - add note and update subject of patch7 (Liuyi)
> - check global_dirty_tracking in vtd_address_space_unmap()
> 
> v5:
> - drop the patch checking iommu_dirty_tracking (Avihai, Joao)
> - pass iotlb info to unmap_bitmap when switch out of system AS
> 
> v4:
> - bypass memory size check for device dirty tracking as it's unrelated (Avihai)
> - split vfio_device_dirty_pages_disabled() helper out as a separate patch
> - add a patch to fix minor error on checking vbasedev->iommu_dirty_tracking
> 
> v3:
> - return bitmap query failure to fail migration (Avihai)
> - refine patch7, set IOMMUFD backend 'dirty_pgsizes' and 'max_dirty_bitmap_size' (Cédric)
> - refine patch7, calculate memory limit instead of hardcode 8TB (Liuyi)
> - refine commit log (Cédric, Liuyi)
> 
> v2:
> - add backend_flag parameter to pass DIRTY_BITMAP_NO_CLEAR (Joao, Cédric)
> - add a cleanup patch to rename vfio_dma_unmap_bitmap (Cédric)
> - add blocker if unmap_bitmap limit check fail (Liuyi)
> 
> 
> Joao Martins (1):
>    vfio: Add a backend_flag parameter to
>      vfio_contianer_query_dirty_bitmap()
> 
> Zhenzhong Duan (8):
>    vfio/iommufd: Add framework code to support getting dirty bitmap
>      before unmap
>    vfio/iommufd: Query dirty bitmap before DMA unmap
>    vfio/container-legacy: rename vfio_dma_unmap_bitmap() to
>      vfio_legacy_dma_unmap_get_dirty_bitmap()
>    vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>    intel_iommu: Fix unmap_bitmap failure with legacy VFIO backend
>    vfio/listener: Add missing dirty tracking in region_del
>    vfio/migration: Add migration blocker if VM memory is too large to
>      cause unmap_bitmap failure
>    vfio/migration: Allow live migration with vIOMMU without VFs using
>      device dirty tracking
> 
>   include/hw/vfio/vfio-container.h |  8 +++--
>   include/hw/vfio/vfio-device.h    | 10 ++++++
>   include/system/iommufd.h         |  2 +-
>   backends/iommufd.c               |  5 +--
>   hw/i386/intel_iommu.c            | 42 +++++++++++++++++++++++++
>   hw/vfio-user/container.c         |  5 +--
>   hw/vfio/container-legacy.c       | 15 +++++----
>   hw/vfio/container.c              | 20 ++++++------
>   hw/vfio/device.c                 |  6 ++++
>   hw/vfio/iommufd.c                | 53 +++++++++++++++++++++++++++++---
>   hw/vfio/listener.c               | 28 ++++++++++++++---
>   hw/vfio/migration.c              | 40 ++++++++++++++++++++++--
>   backends/trace-events            |  2 +-
>   hw/vfio/trace-events             |  2 +-
>   14 files changed, 201 insertions(+), 37 deletions(-)
> 


