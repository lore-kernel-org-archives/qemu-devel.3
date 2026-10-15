Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6B2CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHG9s-0006w5-FS; Thu, 15 Oct 2026 03:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG9k-0006vh-O3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHG9f-0003wt-8c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792050331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wEjutYNdeSzA1OExfEH5Uv6Vz9vb+aK3JeSPjrEagp8=;
 b=DbphXUWruZLWAvDYcqaDPCZtYGJleuiqdw/dR0jVAQoKCi2BcQ8qwBIgl9faLF0uvq2F7D
 K34tGzQpqvQJ3yHw+3m2MNOcV7ACbztrHhJpBjjoZyQ56AHqej66zvnhCSy/QyYjADCVPk
 uDkfLL2XboEusCBEuWR7+XjK8dGiWTM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-6rxEPCV2PTuTlnV5GJLMPw-1; Thu, 15 Oct 2026 07:45:26 +0000
X-MC-Unique: 6rxEPCV2PTuTlnV5GJLMPw-1
X-Mimecast-MFC-AGG-ID: 6rxEPCV2PTuTlnV5GJLMPw_1792050323
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48df730c035so145402f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792050323; x=1792655123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wEjutYNdeSzA1OExfEH5Uv6Vz9vb+aK3JeSPjrEagp8=;
 b=H5hmBfPnMUfEDwh3NGRpMaipxNCE7sb3TEARCGKdaaQSsJDK7XlwKhx4pfRFmiPNNt
 Swpwo0XMmr+SBK3Z/QV2JrtwlzPmDBVgNxGdVIYPRk3HLf7YngnEHursDzNEUBLdFflK
 HKmgP4UdfKTe6k3D/KDFsS2g1D+gWsJGGdoX4GOKCZViKYnfloXBzzsD75UR3MhtWK42
 YkI90CyKoNGh2MkTpX57vZekoHuxFZa6Zxf4vymK4gSmW1xz/LMW/8+pujvZYX6ACNFY
 AaR33hgVz5dxXyNAFNnB3gwYI7+jeT4f476YoZicfwLLP8KKOiN9ctf9ydKSLl6s+yMt
 fwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050323; x=1792655123;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wEjutYNdeSzA1OExfEH5Uv6Vz9vb+aK3JeSPjrEagp8=;
 b=SmXL/PSusysXmYpq4U3xAztIkWDA8P14tmbBoUFxBjj+j7boNK7mAYzWLSpSWKtaCy
 DbDJSRjb6s6lfnbRZvkMXHvGKKiRKZTyzIj0zcXmdjnaxL8kRwaFfaobLa2htB0y6VRn
 CRH07Blxj27FxjnTD2PVNgAOdLUWWA9q87mQl37D4qRNt/IjP2TcH/FOKURk3VqhabOR
 cHoPmhWiccl+5zbj0Eke5XMQFFmlZMoKbrZzmzJlHMjSqWE8K3V1uBzidPf1G1Si1QV5
 3l38+00QFaVg8R7W4A3+axC8rCUeMD7aOcJVIBUCCFpVuLWURD6zP/4Xl76MnrvNwUvp
 fHow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJCD/KY5mgegq0JAwQBPI6+K2wQ0WxqLvvoHNtP7GP0eIaUYaNkP+2qHFskrvsaoaz/RmaLtpp5SI5@nongnu.org
X-Gm-Message-State: AFq9FYImD1AHuQ/54SoO1gg7v4LZqz4eL7b0E1Uu43bjzTdEZjlmxGG3
 Ak5M4rThuePruCjQDki83+8c5TbGu8oJsKmKN+OFoY4OGiqWSNV8L1ztbZ7JhlYKxX0Kaziih0M
 ddgKUpLUNau2ydgREQm5vM8i6iXbq2CSjp52FKYrxvFesxkmKqCH6fFUv
X-Gm-Gg: AYBFou1R09IxWsKrxBNdqyfwwp6BGOPw6B2Kx0wqIsjQKtKPGEhHVsEMG9F3JUYiOuI
 opmxKTy9Po87QgENDQX6vbW/5cRQsfgg0Bc3ZD1RTx1+FT8VWrC9V6Xw3+KUJ2/xJ33Nsi4Z6fp
 nGj9NaD+fFeIMoUdVipUijoJWuRdIvjD9blLQ0ZOHcoLCRwd5gM7lwRmyF2cPBadK4jknMJYkcb
 BWPkjDDZekQIyoWNh0hZ0KdpAzl0iZGSerlk3eoeKHYodhLequ1AbZdlSkZSBblk0P4SFxg1aTc
 Xnn+2lr1/pOrpTQt2k2o/99NrqQUm+PjvwcDZyk8jSKhkyO0ykpFl73+OrSfnNvnRaSQhSKTroc
 MEyIndTjXvbS4GAdY3lLiZoZk6RAFe64PRNSpPWLq
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr338969025e9.26.1792050322542; 
 Thu, 15 Oct 2026 00:45:22 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr338968485e9.26.1792050321910; 
 Thu, 15 Oct 2026 00:45:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6ddcsm16548804f8f.52.2026.10.15.00.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 00:45:21 -0700 (PDT)
Message-ID: <0f19272b-d30c-42c9-b9af-01e3f49890e7@redhat.com>
Date: Thu, 15 Oct 2026 09:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-5-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261014211041.1087331-5-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Add client support for capability VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> (capability ID 0x8001) in vfio-user, and advertise support via the
> "sparse_mmap_fds" capability in VFIO_USER_VERSION.
> 
> Update vfio_user_device_io_get_region_info() to receive multiple file
> descriptors passed in SCM_RIGHTS ancillary data for a region, store them
> in VFIOUserProxy, and implement setup_sparse_mmaps in
> vfio_user_device_io_ops_sock to validate and populate per-area file
> descriptors and fd_offset values.
> 
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>   hw/vfio-user/protocol.h |  35 ++++++++++--
>   hw/vfio-user/proxy.h    |   2 +
>   hw/vfio-user/device.c   | 121 +++++++++++++++++++++++++++++++++++++---
>   hw/vfio-user/proxy.c    |  52 +++++++++++++++--
>   4 files changed, 193 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index c478d1353f..b823689254 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -15,6 +15,8 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> +#define VFIO_USER_MAX_REGIONS 100
> +
>   typedef struct {
>       uint16_t id;
>       uint16_t command;
> @@ -69,12 +71,13 @@ typedef struct {
>   #define VFIO_USER_CAP           "capabilities"
>   
>   /* "capabilities" members */
> -#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
> -#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
> -#define VFIO_USER_CAP_PGSIZES   "pgsizes"
> -#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
> -#define VFIO_USER_CAP_MIGR      "migration"
> -#define VFIO_USER_CAP_MULTI     "write_multiple"
> +#define VFIO_USER_CAP_MAX_FDS           "max_msg_fds"
> +#define VFIO_USER_CAP_MAX_XFER          "max_data_xfer_size"
> +#define VFIO_USER_CAP_PGSIZES           "pgsizes"
> +#define VFIO_USER_CAP_MAP_MAX           "max_dma_maps"
> +#define VFIO_USER_CAP_MIGR              "migration"
> +#define VFIO_USER_CAP_MULTI             "write_multiple"
> +#define VFIO_USER_CAP_SPARSE_MMAP_FDS   "sparse_mmap_fds"
>   
>   /* "migration" members */
>   #define VFIO_USER_CAP_PGSIZE            "pgsize"
> @@ -166,6 +169,26 @@ typedef struct {
>       uint64_t offset;
>   } VFIOUserRegionInfo;
>   
> +/*
> + * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> + */
> +#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 0x8001
> +
> +struct vfio_region_sparse_mmap_fd_area {
> +    uint64_t offset;
> +    uint64_t fd_offset;
> +    uint64_t size;
> +    uint32_t fd_index;
> +    uint32_t pad;
> +};
> +
> +struct vfio_region_info_cap_sparse_mmap_fds {
> +    struct vfio_info_cap_header header;
> +    uint32_t nr_areas;
> +    uint32_t reserved;
> +    struct vfio_region_sparse_mmap_fd_area areas[];
> +};
> +
>   /*
>    * VFIO_USER_DEVICE_GET_IRQ_INFO
>    * imported from struct vfio_irq_info
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index 7b97460cc5..4b9834a436 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
>       AioContext *ctx;
>       QEMUBH *req_bh;
>       bool async_ops;
> +    VFIOUserFDs *region_fds[VFIO_USER_MAX_REGIONS];
>   
>       /*
>        * above only changed when BQL is held
> @@ -111,6 +112,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
>   
>   VFIOUserFDs *vfio_user_getfds(int numfds);
>   void vfio_user_putfds(VFIOUserMsg *msg);
> +void vfio_user_free_fds(VFIOUserFDs *fds);
>   
>   void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
>   
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 1a01e748cd..4fbf536a04 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -14,12 +14,14 @@
>   
>   #include "hw/vfio-user/device.h"
>   #include "hw/vfio-user/trace.h"
> +#include "hw/vfio/vfio-region.h"
> +#include "hw/vfio/vfio-helpers.h"
> +#include "hw/vfio/trace.h"
>   
>   /*
>    * These are to defend against a malign server trying
>    * to force us to run out of memory.
>    */
> -#define VFIO_USER_MAX_REGIONS   100
>   #define VFIO_USER_MAX_IRQS      50
>   
>   bool vfio_user_get_device_info(VFIOUserProxy *proxy,
> @@ -209,14 +211,17 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>                                                  struct vfio_region_info *info,
>                                                  int *fd)
>   {
> -    VFIOUserFDs fds = { 0, 1, fd};
> -    int ret;
> +    int fds[VFIO_USER_MAX_MAX_FDS];
> +    VFIOUserFDs user_fds = { 0, VFIO_USER_MAX_MAX_FDS, fds };
> +    int i, ret;
> +
> +    *fd = -1;
>   
>       if (info->index > vbasedev->num_initial_regions) {
>           return -EINVAL;
>       }

info->index is validated above

> -    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
> +    ret = vfio_user_get_region_info(vbasedev->proxy, info, &user_fds);


info is modified by vfio_user_get_region_info() :

   memcpy(info, &msgp->argsz, info->argsz);

without revalidation of the udpated fields and ...

>       if (ret) {
>           return ret;
>       }
> @@ -225,10 +230,30 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>       if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
>           (info->cap_offset < sizeof(*info)
>            || info->cap_offset + sizeof(struct vfio_info_cap_header) > info->argsz)) {
> -        return -EINVAL;
> +        ret = -EINVAL;
> +    } else if (vfio_get_region_info_cap(info,
> +                                        VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS)) {
> +        if (user_fds.recv_fds > 0) {
> +            VFIOUserFDs *saved = vfio_user_getfds(user_fds.recv_fds);
> +
> +            saved->recv_fds = user_fds.recv_fds;
> +            memcpy(saved->fds, fds, user_fds.recv_fds * sizeof(int));
> +            vfio_user_free_fds(vbasedev->proxy->region_fds[info->index]);
> +            vbasedev->proxy->region_fds[info->index] = saved;

info->index could be bogus. This is a pre-existing flaw. Would
be good to fix.

Thanks,

C.

> +            return 0;
> +        }
> +        ret = -EINVAL;
> +    } else if (user_fds.recv_fds > 0) {
> +        *fd = fds[0];
> +        fds[0] = -1;
>       }
>   
> -    return 0;
> +    for (i = 0; i < user_fds.recv_fds; i++) {
> +        if (fds[i] >= 0) {
> +            close(fds[i]);
> +        }
> +    }
> +    return ret;
>   }
>   
>   static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
> @@ -518,12 +543,94 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>   /*
>    * Socket-based io_ops
>    */
> +static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
> +                                                  struct vfio_region_info *info,
> +                                                  Error **errp)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds;
> +    VFIOUserFDs *user_fds;
> +    size_t cap_offset;
> +    int i;
> +
> +    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
> +    if (!hdr) {
> +        return vfio_default_setup_sparse_mmaps(region, info, errp);
> +    }
> +
> +    if (vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP)) {
> +        error_setg(errp, "%s: region %d cannot specify both "
> +                   "SPARSE_MMAP and SPARSE_MMAP_FDS", __func__, region->nr);
> +        return -EINVAL;
> +    }
> +
> +    sparse_fds = container_of(hdr, struct vfio_region_info_cap_sparse_mmap_fds,
> +                              header);
> +
> +    cap_offset = (uintptr_t)hdr - (uintptr_t)info;
> +    if (cap_offset > info->argsz ||
> +        info->argsz - cap_offset < sizeof(*sparse_fds) ||
> +        sparse_fds->nr_areas >
> +            (info->argsz - cap_offset - sizeof(*sparse_fds)) /
> +            sizeof(sparse_fds->areas[0])) {
> +        error_setg(errp, "%s: invalid nr_areas %u in region %d",
> +                   __func__, sparse_fds->nr_areas, region->nr);
> +        return -EINVAL;
> +    }
> +
> +    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
> +                                         region->nr, sparse_fds->nr_areas);
> +
> +    user_fds = region->vbasedev->proxy->region_fds[region->nr];
> +    if (!user_fds || user_fds->recv_fds > sparse_fds->nr_areas) {
> +        error_setg(errp, "%s: invalid fd count %d for %u sparse mmap areas "
> +                   "in region %d", __func__,
> +                   user_fds ? user_fds->recv_fds : 0,
> +                   sparse_fds->nr_areas, region->nr);
> +        return -EINVAL;
> +    }
> +
> +    region->mmaps = g_try_new0(VFIOMmap, sparse_fds->nr_areas);
> +    if (!region->mmaps) {
> +        error_setg(errp, "%s: failed to allocate %u mmaps for region %d",
> +                   __func__, sparse_fds->nr_areas, region->nr);
> +        return -ENOMEM;
> +    }
> +
> +    for (i = 0; i < sparse_fds->nr_areas; i++) {
> +        struct vfio_region_sparse_mmap_fd_area *area = &sparse_fds->areas[i];
> +
> +        if (area->size == 0 || area->offset > region->size ||
> +            area->size > region->size - area->offset ||
> +            area->fd_index >= user_fds->recv_fds) {
> +            error_setg(errp, "%s: invalid sparse mmap area %d in region %d "
> +                       "(offset=0x%"PRIx64" size=0x%"PRIx64
> +                       " fd_offset=0x%"PRIx64" fd_index=%u)",
> +                       __func__, i, region->nr, area->offset, area->size,
> +                       area->fd_offset, area->fd_index);
> +            g_free(region->mmaps);
> +            region->mmaps = NULL;
> +            return -EINVAL;
> +        }
> +
> +        trace_vfio_region_sparse_mmap_entry(i, area->offset,
> +                                            area->offset + area->size - 1);
> +        region->mmaps[i].offset = area->offset;
> +        region->mmaps[i].fd_offset = area->fd_offset;
> +        region->mmaps[i].size = area->size;
> +        region->mmaps[i].fd = user_fds->fds[area->fd_index];
> +    }
> +
> +    region->nr_mmaps = sparse_fds->nr_areas;
> +    return 0;
> +}
> +
>   VFIODeviceIOOps vfio_user_device_io_ops_sock = {
>       .device_feature = vfio_user_device_io_device_feature,
>       .get_region_info = vfio_user_device_io_get_region_info,
> +    .setup_sparse_mmaps = vfio_user_device_io_setup_sparse_mmaps,
>       .get_irq_info = vfio_user_device_io_get_irq_info,
>       .set_irqs = vfio_user_device_io_set_irqs,
>       .region_read = vfio_user_device_io_region_read,
>       .region_write = vfio_user_device_io_region_write,
> -
>   };
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 197aee07bf..ba29085321 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -363,6 +363,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           }
>   
>           memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +    } else if (msg->fds != NULL) {
> +        /*
> +         * recv_fds holds the capacity of msg->fds->fds on entry; reset it
> +         * to 0 when the reply carries no FDs so the caller knows none were
> +         * received.
> +         */
> +        msg->fds->recv_fds = 0;
>       }
>   
>       /*
> @@ -740,6 +747,11 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
>   
>       qemu_mutex_unlock(&proxy->lock);
>   
> +    if (!ok && fds != NULL) {
> +        /* No reply was received; report 0 received FDs to the caller. */
> +        fds->recv_fds = 0;
> +    }
> +
>       return ok;
>   }
>   
> @@ -867,17 +879,30 @@ void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
>   }
>   
>   /*
> - * Close FDs erroneously received in an incoming request.
> + * Close and free received FDs.
>    */
> -void vfio_user_putfds(VFIOUserMsg *msg)
> +void vfio_user_free_fds(VFIOUserFDs *fds)
>   {
> -    VFIOUserFDs *fds = msg->fds;
>       int i;
>   
> +    if (!fds) {
> +        return;
> +    }
> +
>       for (i = 0; i < fds->recv_fds; i++) {
> -        close(fds->fds[i]);
> +        if (fds->fds[i] >= 0) {
> +            close(fds->fds[i]);
> +        }
>       }
>       g_free(fds);
> +}
> +
> +/*
> + * Close FDs erroneously received in an incoming request.
> + */
> +void vfio_user_putfds(VFIOUserMsg *msg)
> +{
> +    vfio_user_free_fds(msg->fds);
>       msg->fds = NULL;
>   }
>   
> @@ -967,6 +992,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
>   void vfio_user_disconnect(VFIOUserProxy *proxy)
>   {
>       VFIOUserMsg *r1, *r2;
> +    int i;
>   
>       qemu_mutex_lock(&proxy->lock);
>   
> @@ -1027,6 +1053,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>           vfio_user_iothread = NULL;
>       }
>   
> +    for (i = 0; i < VFIO_USER_MAX_REGIONS; i++) {
> +        vfio_user_free_fds(proxy->region_fds[i]);
> +    }
> +
>       g_free(proxy->sockname);
>       g_free(proxy);
>   }
> @@ -1214,6 +1244,18 @@ static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
>       return true;
>   }
>   
> +static bool check_sparse_mmap_fds(VFIOUserProxy *proxy, QObject *qobj,
> +                                  Error **errp)
> +{
> +    QBool *qb = qobject_to(QBool, qobj);
> +
> +    if (qb == NULL) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_SPARSE_MMAP_FDS);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static struct cap_entry caps_cap[] = {
>       { VFIO_USER_CAP_MAX_FDS, check_max_fds },
>       { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
> @@ -1221,6 +1263,7 @@ static struct cap_entry caps_cap[] = {
>       { VFIO_USER_CAP_MAP_MAX, check_max_dma },
>       { VFIO_USER_CAP_MIGR, check_migr },
>       { VFIO_USER_CAP_MULTI, check_multi },
> +    { VFIO_USER_CAP_SPARSE_MMAP_FDS, check_sparse_mmap_fds },
>       { NULL }
>   };
>   
> @@ -1280,6 +1323,7 @@ static GString *caps_json(void)
>       qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
>       qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
>       qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
> +    qdict_put_bool(capdict, VFIO_USER_CAP_SPARSE_MMAP_FDS, true);
>   
>       qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
>   


