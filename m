Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78053D1A639
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDpH-0001YK-1s; Fri, 09 Jan 2026 09:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDp5-0001Qx-NX
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDp3-0001pE-SH
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UUYpM6q8wUb5clLgoqR5B9eRC+4MlHn/Jf0w7C1V7FE=;
 b=F9Z09RWN3QMgkRjtxDTk9OVjU+TIivxyHY7Jrg2jSPpl83vWqZFF+L68Yc/vCNa7/zGVkX
 ikcca8JDIjTJwOh8vUWSC8Bi9WSzHQpybMJDNIWryLug7UJRA2gixTUhFq4GmOqBEdNU+3
 fN1yLn6a5EHgiuWSs7luzVYQmvmQK78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-5bG41JXPO-CP8kEOj_zqTw-1; Fri, 09 Jan 2026 09:50:39 -0500
X-MC-Unique: 5bG41JXPO-CP8kEOj_zqTw-1
X-Mimecast-MFC-AGG-ID: 5bG41JXPO-CP8kEOj_zqTw_1767970238
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso41838955e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970238; x=1768575038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UUYpM6q8wUb5clLgoqR5B9eRC+4MlHn/Jf0w7C1V7FE=;
 b=q9PS2fktfWwzuySUuLdZBJX7heuJkRDWouFKkEv8oQCh3pRryGqaum5Ng0l4rjRtDb
 JbkuUurT+yoDFdHk82goxg1zFxvwMFXMC4WgX/4EN2nvNNuJR9oI2IIKmwBEfCjThj2k
 gefhpU5yYsgiLzbrX/MQTvIGgu6AMtd3+dUCZGGrsM0IH3DP8aTR71iFRAdpvip7HBhb
 2HeudG/I53jcWn9C2pR+zZS2c+EhhLwmpZ5ILdqSikRlDXW7zXymmvErhQ5mmRFtNw4i
 4kgXMSf3X7HjLGR+QZDcnRGrZ70Tds2OZyYXf2NFg8oP8n5DtEhlj2xKTXkGCd0TXB61
 eQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970238; x=1768575038;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUYpM6q8wUb5clLgoqR5B9eRC+4MlHn/Jf0w7C1V7FE=;
 b=YedTR+UEPkFNXf3/KCdtQWgXWPvTLUCCRQ72ndv0U2qFBy12CyOWd6EtjIYiSsMLVf
 gzlkJ/iSk6nLRG2LKTtisDUd9gSZwi7InMP8TpXL+K8UlAy+i8sGF0X7yHLPV+Q45eE+
 RnVNIiR+0ZcMBH8udP6oBfB5ZbksktERJ8cDNR0MQ7+NSzBzLcLC+qODSbArZw6f+e1c
 ny9mBgVjzfmO6hduEEM6clcIJ9mXR6Xypjj7XUnP5C8OwEa00mmGOk1zsi5AqplVIVaE
 iPWMgxc7cLT+//42hNtYtEStvsArHKLE7kMC6msSnFSKnRzX2VhT3RaiqMyo0I88f5TZ
 SPlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdyyVi9+nAr5UkAFLgzvryPS9PA2Vdb+9i9JKsf1UkZwStlMj8tylaKk77+m4HPxz0DblnWaVGnbym@nongnu.org
X-Gm-Message-State: AOJu0Yx0IL1rlzMbr3VSQylg16XEFZt67s/I6EuuV4HR9i4j8YU4nUqI
 N4ZdLxHH+JQXOcz9+TV9HsOxGW6DTmA5Z+UvJ+XphVOAYlXw6U9wkqh3sPjVyzL1dqI9z42PQ+i
 0WiPZ2A4iXLxb5QtsnDkDo/eyWyc/XdpIfZFAesKit48OA6RFPAtxk7X7
X-Gm-Gg: AY/fxX4Dh7wWXYVUCxUqmwOfN2vqCKSRuySk+d1V7vgwKTlC/fsJa7p4S5euZdyKOHd
 dPoLcxo44WGe8X53hPQGwxC6sBoGWOMJ4xwGdHCxntCGOejYZbHzz14T+ePtOUmaeBwYQ286cFt
 FE0eY32EtbWi/OM4R20ktYuiAUAzfNc5RqYbZoiKr/hu5hxs/UqoQgOuS8NGuy2dFzbMFFO4Ygk
 FhQ/CSnXq4EdYh5p0eHr7IkrdoKBqqENqH61Hk9UdeZ0KxB9U4laRtNsPO8kiaTtOjpDDj2SfwQ
 8Zk1oxVxOm7AiURqWTB4THbusRobfBFWr4H7uXNyZLQsta6F3rTzQ6mj1noPkxnaXuxdUoSMnTS
 6RjQcrUPxbF5N5qRGNAscIYAVgxBxI0ThRcyEGqnKOgWx1Tdd
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr117250955e9.35.1767970238437; 
 Fri, 09 Jan 2026 06:50:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMV0CdRnrx1aFBM8tYjuJ9i62PzUeQpEfivCZq8K1ORHPOwijWzDam9gigd1WKuM5X0g0CYg==
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr117250605e9.35.1767970238010; 
 Fri, 09 Jan 2026 06:50:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm206551395e9.8.2026.01.09.06.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:50:37 -0800 (PST)
Message-ID: <ccfcc058-a76e-4852-9c6b-961d8aef4c71@redhat.com>
Date: Fri, 9 Jan 2026 15:50:36 +0100
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


Applied to vfio-next.

Thanks,

C.


