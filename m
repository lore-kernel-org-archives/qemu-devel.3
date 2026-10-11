Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD59CA9ECF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFxUH-0003wc-3k; Sun, 11 Oct 2026 13:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xFxU9-0003w0-IV
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 13:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xFxU4-0004L5-Kq
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 13:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791740234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fb0D7N4KiHt/UbpAHk81Z7w4MiF4twkNwq0jr7E3H8M=;
 b=KFp6Qi0HKlRsdIU0Swi7cZ6dchComHakJFvHIYQ6P8MVjjIunnYUYK49JPHgt/xp+AK/NW
 QbSPN+ldhEhLBdFxqitEdOcQtpbAc/5k7+u4+tBdYG1chZGn3XqFAp8VOPasxDgJT7Vgp/
 zFeggPgSI52SNvQDa7yMSUpBk0f8GLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-i5S_rtACMueWsUGFSRoH5A-1; Sun, 11 Oct 2026 17:37:13 +0000
X-MC-Unique: i5S_rtACMueWsUGFSRoH5A-1
X-Mimecast-MFC-AGG-ID: i5S_rtACMueWsUGFSRoH5A_1791740232
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1813fea7dso19332905e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791740232; x=1792345032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fb0D7N4KiHt/UbpAHk81Z7w4MiF4twkNwq0jr7E3H8M=;
 b=Y6qV7pLZ4RiYDU8ejt3YOt84d2jzKcPjUOkdYvNOC4z+Pk2kWtL+iQ1RHhVPISzEfQ
 rdbgxb+HJkgpnvqCCEAhCE5CEFaLBqRGuKF02gWoixRKKGQ3moQ7XLS5FsPsEXy+Cv1D
 zmOaaIWOkDviqHjlvClgg34aOtnhH9UqA7xcsj1gE/U79tBfXH7x6CeLi7vnsVNS4mnq
 w0Hrzg1xfvF71WY+csevoIDNYQlwMAOT9aewBBYVLLvYFur1K9WweH4Es2zcuxFhSxah
 zuFOKPWaPSfyJgH1I++nkhtAOYwsACNs4HSr/SGM+pYGs0nnQbOrh2CGbhWOk/rU0Fk/
 AQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791740232; x=1792345032;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fb0D7N4KiHt/UbpAHk81Z7w4MiF4twkNwq0jr7E3H8M=;
 b=IuJ8girINOKENIZAPaPiO7vbo3L2iPXQXdKYIwpbzYip4FlGD9haH64F98c/7A+DWt
 7B78IMaysc3vjETRk7M4Oha9eCFKFqyGy22cCa8wy/vye94SBGXaY5lq6VpqrdfBa10y
 0b651ZiGSNhIit2JFU5GVQTDyHo4tZWRu+f4gHAKS1twGZEH8CedYl+d63NVTVxxioMb
 ff3hq1mo4NaEEU4ofs4qhFWACFUb5pLMmCtghSTxI1O1sSvMV6wX0+EQ7SROlp/qyAGp
 mSG7W5pesafClD+ZD4fFgsxAcuhRLkSmqtnSVRuT3RiDt0HRTqxO9soHQ0fE3UqkeQpW
 Ec/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkCSqhH0qUe2ZkkAkcTMtladYGptKsfjDZ+aR4E0ybncgQjXqv0NXUsQyujViIKIAlgZV5omtV8aDn@nongnu.org
X-Gm-Message-State: AFq9FYIFFQ7C6Qp2gB+qXcl2riPpyXEZZcFVr2fjyF6CQ3LiSpFDHqAk
 w07029ic3Jpa0DNiqekEpQED8RgcVHgghxyMc0bbRajJ0zzq0iGa96eWH4f5cVNSmEMU2UnkqM/
 zyziNpCR3pngLdXcMPnSgVgZRTNTojBm8tJGdRvNACQ5cl4UI3kmfNmsy
X-Gm-Gg: AYBFou3vlFfhg/VMZ8AQ73LHbL2R/XVrslpni/X6rsRSCCFZA5/pTtB96MJwQ6i0AdP
 G8H89tWqp3w4SiM8utFLm2GLcYpq3pM2MQfkIGnRjW3qwQv+AO5JMUbWeGDG4toqE6MZ2qUrMXf
 jQBvtewc/oT+CwioD7eYBV2yhsbB1u8YKHY8d5/WUfGPCDXpacBeOQTCm2y4MTexj2B2Y4SNCsT
 S19xDw3Z1skjtkkcfesYCqaQiUrhmccuh5wPfA77IrUXA5F+lmRmsYl96SYBlsLGS6eC2+hZNOx
 Y5OaasLaapH/3g+qu/T154jQsYFVTf+SeYwfoBUuSd78w/oz6E/YTLC1EvAfi2YZkFoQq5fskx3
 gMOWSbhxkVRXbcd4MMECDFlYIHKhBrbG2nFPUAddM
X-Received: by 2002:a05:600c:8105:b0:4a1:775b:5eb2 with SMTP id
 5b1f17b1804b1-4a18e48362emr132468955e9.13.1791740231879; 
 Sun, 11 Oct 2026 10:37:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8105:b0:4a1:775b:5eb2 with SMTP id
 5b1f17b1804b1-4a18e48362emr132468585e9.13.1791740231212; 
 Sun, 11 Oct 2026 10:37:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm14554486f8f.37.2026.10.11.10.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 10:37:10 -0700 (PDT)
Message-ID: <033a5368-7463-4c62-915b-0b03d226f267@redhat.com>
Date: Sun, 11 Oct 2026 19:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261009175314.1823347-1-namangulati@google.com>
 <20261009175314.1823347-5-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261009175314.1823347-5-namangulati@google.com>
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

On 10/9/26 19:53, Naman Gulati wrote:
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
>   hw/vfio-user/protocol.h |  35 +++++++++++---
>   hw/vfio-user/proxy.h    |   2 +
>   hw/vfio-user/device.c   | 102 +++++++++++++++++++++++++++++++++++++---
>   hw/vfio-user/proxy.c    |  46 ++++++++++++++++--
>   4 files changed, 168 insertions(+), 17 deletions(-)
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
> index 1a01e748cd..5c63c83a7c 100644
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
>   
> -    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
> +    ret = vfio_user_get_region_info(vbasedev->proxy, info, &user_fds);
>       if (ret) {
>           return ret;
>       }
> @@ -225,10 +230,29 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>       if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
>           (info->cap_offset < sizeof(*info)
>            || info->cap_offset + sizeof(struct vfio_info_cap_header) > info->argsz)) {
> -        return -EINVAL;
> +        ret = -EINVAL;
> +    } else if (vfio_get_region_info_cap(info,
> +                                        VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS)) {
> +        if (info->index < VFIO_USER_MAX_REGIONS && user_fds.recv_fds > 0) {
> +            VFIOUserFDs *saved = vfio_user_getfds(user_fds.recv_fds);
> +
> +            saved->recv_fds = user_fds.recv_fds;
> +            memcpy(saved->fds, fds, user_fds.recv_fds * sizeof(int));
> +            vfio_user_free_fds(vbasedev->proxy->region_fds[info->index]);
> +            vbasedev->proxy->region_fds[info->index] = saved;
> +            return 0;
> +        }

Shouldn't there be :

           ret = -EINVAL;

?


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
> @@ -518,12 +542,76 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>   /*
>    * Socket-based io_ops
>    */
> +static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
> +                                                  struct vfio_region_info *info,
> +                                                  Error **errp)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds;
> +    VFIOUserFDs *user_fds = NULL;
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
> +    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
> +                                         region->nr, sparse_fds->nr_areas);
> +
> +    if (region->nr < VFIO_USER_MAX_REGIONS) {
> +        user_fds = region->vbasedev->proxy->region_fds[region->nr];
> +    }
> +    if (!user_fds || user_fds->recv_fds > sparse_fds->nr_areas) {
> +        error_setg(errp, "%s: invalid fd count %d for %u sparse mmap areas "
> +                   "in region %d", __func__,
> +                   user_fds ? user_fds->recv_fds : 0,
> +                   sparse_fds->nr_areas, region->nr);
> +        return -EINVAL;
> +    }
> +
> +    region->mmaps = g_new0(VFIOMmap, sparse_fds->nr_areas);
> +
> +    for (i = 0; i < sparse_fds->nr_areas; i++) {
> +        struct vfio_region_sparse_mmap_fd_area *area = &sparse_fds->areas[i];
> +
> +        if (area->size == 0 || area->offset > region->size ||
> +            area->size > region->size - area->offset ||
> +            area->fd_index >= user_fds->recv_fds) {
> +            error_setg(errp, "%s: invalid sparse mmap area %d in region %d",
> +                       __func__, i, region->nr);
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
> index 197aee07bf..44e2a839b0 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -363,6 +363,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           }
>   
>           memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +    } else if (msg->fds != NULL) {
> +        msg->fds->recv_fds = 0;
>       }
>   
>       /*
> @@ -740,6 +742,10 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
>   
>       qemu_mutex_unlock(&proxy->lock);
>   
> +    if (!ok && fds != NULL) {
> +        fds->recv_fds = 0;
> +    }
> +
>       return ok;
>   }
>   
> @@ -867,17 +873,30 @@ void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
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
> @@ -967,6 +986,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
>   void vfio_user_disconnect(VFIOUserProxy *proxy)
>   {
>       VFIOUserMsg *r1, *r2;
> +    int i;
>   
>       qemu_mutex_lock(&proxy->lock);
>   
> @@ -1027,6 +1047,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
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
> @@ -1214,6 +1238,18 @@ static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
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
> @@ -1221,6 +1257,7 @@ static struct cap_entry caps_cap[] = {
>       { VFIO_USER_CAP_MAP_MAX, check_max_dma },
>       { VFIO_USER_CAP_MIGR, check_migr },
>       { VFIO_USER_CAP_MULTI, check_multi },
> +    { VFIO_USER_CAP_SPARSE_MMAP_FDS, check_sparse_mmap_fds },
>       { NULL }
>   };
>   
> @@ -1280,6 +1317,7 @@ static GString *caps_json(void)
>       qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
>       qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
>       qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
> +    qdict_put_bool(capdict, VFIO_USER_CAP_SPARSE_MMAP_FDS, true);
>   
>       qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
>   


