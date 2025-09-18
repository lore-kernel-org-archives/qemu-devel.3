Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC72CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLk4-0005ga-PT; Thu, 18 Sep 2025 17:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzLk2-0005gK-T4
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzLk0-0000do-21
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758229228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NJYGYxUk0m8UlJHacvnsMydm+YghBYEIYa4qLiY7YKU=;
 b=AivDOrtu4sJ4U6ZKqYJYd94JMPfqUJGiP3/M7OX2kWEmdFVrRDC/yWqINipx2LmG1ejlPt
 3HuIPtf/CYvaoVZsAuMt11XYnPnMnNf92O5VNzHDD91iHEgJOXf2gTtEkeuWvp0Uz3Urod
 Pt8Ih0172hWrJrAQotHWRHX9KiGMf4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-DQ3nMvGcPJSUPx631mOfLg-1; Thu, 18 Sep 2025 16:55:49 -0400
X-MC-Unique: DQ3nMvGcPJSUPx631mOfLg-1
X-Mimecast-MFC-AGG-ID: DQ3nMvGcPJSUPx631mOfLg_1758228949
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45f2b0eba08so8397935e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758228949; x=1758833749;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJYGYxUk0m8UlJHacvnsMydm+YghBYEIYa4qLiY7YKU=;
 b=mRYQMibCa78fhfceISltlFa/nGaUppPw4IzDrgUaYbGbg4297461vBJjv2YRuYys45
 JKnY46HVFFtBoyno0XKK1YARoO0eAANdzc6Ieola13iSdV7Z/gSOwUPOOE2+v8NhUoa+
 dJdf4sCAO5k0fjJIooZEid08NXXQlCTINjtw0pDRS/loY3Y1XeVYW2NxVhhZz/zp0Fef
 e1uL/sBNdzVoZcvv03L9JLrmIpDzlVV3XaA6l4MBqQh6I+kfoCfhUkG4G4ZAHAWjFBJ9
 Wq6JIRNjtIc2ASvRCLqnejEFMphA5f4LOFe3X3iN8jRRrnbSaxpCL4Gc0Jqu3dq2scUm
 U59A==
X-Gm-Message-State: AOJu0YzZTqIoEx4GLtGg4ZXe3PntZiTJShd4EgGWfvWIYB6ViM9VQFcW
 eXJjbP+MmBPJ2V70N2VKrO84wjkU0fCGLKrWEref2SaaKphON/wZZgv7KYLApp2vlsdrmEA52gx
 mj4v3rpgnfF2/tTdXukYSz7fmndICbkT6Qlh+j5WZd5nPO7OMBEvz+MyE
X-Gm-Gg: ASbGncvDjLaj+bBf/Ce1UoSHihgSQtNYv40BZBZK1J/Au80vqee2wNg1ZWP/VrNOSjC
 hMayg2vrrEeo/za+rGLEDF7ZBFNxDH4hqeaRafCSpkCnzuMYq076zWl4MlUvSr8iZNknuiIZS65
 8wKntiu/XNOa0TncQYZf+Y0WVOoGYrxqd0eCOs/30gdmLU3A92c7+xialusVz67tpFsAGtWE2tj
 64LlYysPyk4hZ6jyoeSlB5TTV7awWp4yxooZ9H/pnOFr4TCwh04aUye6E7sCoslT4WIY2lM7T0D
 rNbK5bAdNvTGaX9iiFJDbTAD74tIdWLSp5gAD9uj/UvUBpM5xE8ND2EnH7wmFsThZfX1L82oE52
 g8BU=
X-Received: by 2002:a05:600c:3b11:b0:45d:d5fb:185b with SMTP id
 5b1f17b1804b1-467eaf51178mr4548325e9.20.1758228948595; 
 Thu, 18 Sep 2025 13:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrHx1oNJYVRR7aOXk2frw4eAkR23yU5Gtv2Vhxjr0H453QjozveG2HWNZsc1p/ETZ3c6W4Tg==
X-Received: by 2002:a05:600c:3b11:b0:45d:d5fb:185b with SMTP id
 5b1f17b1804b1-467eaf51178mr4548245e9.20.1758228948117; 
 Thu, 18 Sep 2025 13:55:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f16272e4sm64805495e9.9.2025.09.18.13.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 13:55:47 -0700 (PDT)
Message-ID: <cd287f5c-796e-4172-9537-b00991a95391@redhat.com>
Date: Thu, 18 Sep 2025 22:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PATCH] vfio/common: Work around kernel overflow bug
 in DMA unmap
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <154707542737.22183.7160770678781819267.stgit@gimli.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Alex, Peter,

On 1/10/19 00:10, Alex Williamson wrote:
> A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
> adds a test for address space wrap-around in the vfio DMA unmap path.
> Unfortunately due to overflow, the kernel detects an unmap of the last
> page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
> guest with VT-d emulation and guest IOMMU enabled will attempt to make
> such an unmap request during VM system reset, triggering an error:
> 
>    qemu-kvm: VFIO_UNMAP_DMA: -22
>    qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100000) = -22 (Invalid argument)
> 
> Here the IOVA start address (0xfef00000) and the size parameter
> (0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
> kernel fix is queued for the Linux v5.0 release to address this.
> 
> This patch implements a workaround to retry the unmap, excluding the
> final page of the range when we detect an unmap failing which matches
> the requirements for this issue.  This is expected to be a safe and
> complete workaround as the VT-d address space does not extend to the
> full 64-bit space and therefore the last page should never be mapped.
> 
> This workaround can be removed once all kernels with this bug are
> sufficiently deprecated.

Have we waited long enough ? what does "sufficiently deprecated" mean ?
Is it related to the linux stable updates ?

Thanks,

C.


> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Debugged-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/vfio/common.c     |   20 +++++++++++++++++++-
>   hw/vfio/trace-events |    1 +
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c185e5a2e79..820b839057c6 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -220,7 +220,25 @@ static int vfio_dma_unmap(VFIOContainer *container,
>           .size = size,
>       };
>   
> -    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> +    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> +        /*
> +         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> +         * v4.15) where an overflow in its wrap-around check prevents us from
> +         * unmapping the last page of the address space.  Test for the error
> +         * condition and re-try the unmap excluding the last page.  The
> +         * expectation is that we've never mapped the last page anyway and this
> +         * unmap request comes via vIOMMU support which also makes it unlikely
> +         * that this page is used.  This bug was introduced well after type1 v2
> +         * support was introduced, so we shouldn't need to test for v1.  A fix
> +         * is queued for kernel v5.0 so this workaround can be removed once
> +         * affected kernels are sufficiently deprecated.
> +         */
> +        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
> +            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
> +            trace_vfio_dma_unmap_overflow_workaround();
> +            unmap.size -= 1ULL << ctz64(container->pgsizes);
> +            continue;
> +        }
>           error_report("VFIO_UNMAP_DMA: %d", -errno);
>           return -errno;
>       }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a85e8662eadb..a002c6af2dda 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -110,6 +110,7 @@ vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps e
>   vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
> +vfio_dma_unmap_overflow_workaround(void) ""
>   
>   # hw/vfio/platform.c
>   vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> 


