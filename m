Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D421C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 08:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUL9r-00024o-Bn; Wed, 25 Jun 2025 04:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL9p-00024A-6k
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL9l-0000N2-Qh
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750838815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V7HD4BIvNfFxxG0J9SzAgiw9Lng6XkyDB6C6/F1JTDc=;
 b=Q+u9JrYn8nYR2nW/R0yIi0T6mnf/2vfP6Tk3ctGADosoooV0lmyfQMsKulmOY4W8czX9PT
 MhXW8X7YpzR1dvu/MpJkGeM9OeVGJFNBGZGhUxfSitfp4/7tOv579ZcGoUV59XPiZnp8e1
 klY+jW1GeTDnelRnVmM4eIY0elLFmI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-wiqFxR9lOKyBnsiWOUO6ww-1; Wed, 25 Jun 2025 04:06:54 -0400
X-MC-Unique: wiqFxR9lOKyBnsiWOUO6ww-1
X-Mimecast-MFC-AGG-ID: wiqFxR9lOKyBnsiWOUO6ww_1750838813
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4536962204aso16387925e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 01:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750838811; x=1751443611;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7HD4BIvNfFxxG0J9SzAgiw9Lng6XkyDB6C6/F1JTDc=;
 b=wWEIO0X9VBjOATeByoauSWvAWKG/RzTjQ2P0G6gNIPxJSS2KQam/fdRQH9cs1J4765
 8sz67JGD/GhHELUOw6DZfqfsscr5SfB3uU9v9PodUyfAZxOmuf/l6Mzs58CsoA/O9N/i
 rm95nx7F+oz53gptDn3JZFW8PinQC5dAgEblZTi6IEck18Awb7YbRGLvVKh3awaTXtEz
 srdQK4wpj6RmTZY4A2gK+5gQQLbC4Wpldg7pwJvjO8xI1GaSPEOGveNubG7pD+cippwm
 hlm96bvdq4FCIk1D+7yfxJ4xRB/dvpyWXt74v7cD+V/hXjLT6dPcm5XaM/R0W3+3N+Zr
 Hcog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX65cma/L4/QdObcsI4+yWJWXv3mr1qFRXgz9ZzPuGJ0x16QlRIkZDOM+NnXIgCr41lTOAfiqL5uLCL@nongnu.org
X-Gm-Message-State: AOJu0YyD4UB7W8PrgK4Zk6XGHXWpX4XAuqK08U+0MiDk1iT1XbQMaT1/
 /eNItQhsu0FjN69nBcVUA/Wmksc79X+5EOv3nnXmYkrqps/mAL/+yg2h2UQZXeu4hZfj+bNz1lo
 ULybUq54PqkEKs1MBsMjPR/vkhIlX4HSx3FBNPo+LnJ3t6flUCl4cv4Q8
X-Gm-Gg: ASbGncumdGxRnl3q1mYTNgSgcqHB57tM5P+tkqadGwz6f/Gqm6J/VCxP51XXqLfgG0T
 Tz8vYTQzDiuXJZwBnLdyITrpznq3j8kXI8mpsprQBpmKNhO+Y7XsADY+MFjxXwugzwmbGvRwQ6V
 6xiZcPf7feC6HDh1qJeE/j9oGRJMGYa/K+Tl+jnkHVDzjM+zXW+pNLmRMJxKtt2M5OuAHoyfJCm
 mkh2OdIvDmk1Z/3bu6Z8Imk3Bl4SwlUcPQh3dSWki5gImNfa3IN17gaSeCGrNl9GaYh+jsaq2cm
 Ord+3u5WQJDO0F9fCcj6o//7p6D17PEcw0Y46C40CcRVU7Eci2kb2fxxLtXW
X-Received: by 2002:a05:6000:41d1:b0:3a4:d0ed:257b with SMTP id
 ffacd0b85a97d-3a6ed636eb9mr1237539f8f.22.1750838810716; 
 Wed, 25 Jun 2025 01:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEph3pV5dh4DG4BCfkuh/lsUc7TJmad3KXLDUCbQNT/dTQpuzh1iNNB6GtQ7Vs1/Lp+D4+lAw==
X-Received: by 2002:a05:6000:41d1:b0:3a4:d0ed:257b with SMTP id
 ffacd0b85a97d-3a6ed636eb9mr1237496f8f.22.1750838810161; 
 Wed, 25 Jun 2025 01:06:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8109e1asm3858097f8f.84.2025.06.25.01.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 01:06:49 -0700 (PDT)
Message-ID: <c2284c0c-22a9-4420-8674-89e2ff2b2a2e@redhat.com>
Date: Wed, 25 Jun 2025 10:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <20250619133154.264786-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250619133154.264786-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/19/25 15:31, John Levon wrote:
> Add support for getting basic device information.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/device.h     | 20 ++++++++++++++++
>   hw/vfio-user/protocol.h   | 12 ++++++++++
>   hw/vfio-user/proxy.h      |  7 ++++++
>   hw/vfio-user/container.c  | 10 +++++++-
>   hw/vfio-user/device.c     | 48 +++++++++++++++++++++++++++++++++++++++
>   hw/vfio-user/proxy.c      | 12 ++++------
>   hw/vfio-user/meson.build  |  1 +
>   hw/vfio-user/trace-events |  1 +
>   8 files changed, 102 insertions(+), 9 deletions(-)
>   create mode 100644 hw/vfio-user/device.h
>   create mode 100644 hw/vfio-user/device.c
> 
> diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
> new file mode 100644
> index 0000000000..d6f2b56066
> --- /dev/null
> +++ b/hw/vfio-user/device.h
> @@ -0,0 +1,20 @@
> +#ifndef VFIO_USER_DEVICE_H
> +#define VFIO_USER_DEVICE_H
> +
> +/*
> + * vfio protocol over a UNIX socket device handling.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "linux/vfio.h"
> +
> +#include "hw/vfio-user/proxy.h"
> +
> +int vfio_user_get_device_info(VFIOUserProxy *proxy,
> +                              struct vfio_device_info *info);
> +
> +#endif /* VFIO_USER_DEVICE_H */
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index 2d52d0fb10..e0bba68739 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -112,4 +112,16 @@ typedef struct {
>    */
>   #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
>   
> +/*
> + * VFIO_USER_DEVICE_GET_INFO
> + * imported from struct vfio_device_info
> + */
> +typedef struct {
> +    VFIOUserHdr hdr;
> +    uint32_t argsz;
> +    uint32_t flags;
> +    uint32_t num_regions;
> +    uint32_t num_irqs;
> +} VFIOUserDeviceInfo;
> +
>   #endif /* VFIO_USER_PROTOCOL_H */
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index 5bc890a0f5..bd5860e9b8 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -12,7 +12,9 @@
>   #include "io/channel.h"
>   #include "io/channel-socket.h"
>   
> +#include "qemu/queue.h"
>   #include "qemu/sockets.h"
> +#include "qemu/thread.h"
>   #include "hw/vfio-user/protocol.h"
>   
>   typedef struct {
> @@ -96,4 +98,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
>                              void *reqarg);
>   bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
>   
> +void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> +                           uint32_t size, uint32_t flags);
> +void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                         VFIOUserFDs *fds, int rsize);
> +
>   #endif /* VFIO_USER_PROXY_H */
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index 2367332177..664cdf044f 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -11,6 +11,7 @@
>   #include "qemu/osdep.h"
>   
>   #include "hw/vfio-user/container.h"
> +#include "hw/vfio-user/device.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-listener.h"
> @@ -140,7 +141,14 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
>   static bool vfio_user_device_get(VFIOUserContainer *container,
>                                    VFIODevice *vbasedev, Error **errp)
>   {
> -    struct vfio_device_info info = { 0 };
> +    struct vfio_device_info info = { .argsz = sizeof(info) };
> +    int ret;
> +
> +    ret = vfio_user_get_device_info(vbasedev->proxy, &info);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "get info failure");
> +        return ret;
> +    }
>   
>       vbasedev->fd = -1;
>   
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> new file mode 100644
> index 0000000000..4998019b30
> --- /dev/null
> +++ b/hw/vfio-user/device.c
> @@ -0,0 +1,48 @@
> +/*
> + * vfio protocol over a UNIX socket device handling.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +
> +#include "hw/vfio-user/device.h"
> +#include "hw/vfio-user/trace.h"
> +
> +/*
> + * These are to defend against a malign server trying
> + * to force us to run out of memory.
> + */
> +#define VFIO_USER_MAX_REGIONS   100
> +#define VFIO_USER_MAX_IRQS      50
> +
> +int vfio_user_get_device_info(VFIOUserProxy *proxy,
> +                              struct vfio_device_info *info)
> +{
> +    VFIOUserDeviceInfo msg;
> +    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
> +
> +    memset(&msg, 0, sizeof(msg));
> +    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
> +    msg.argsz = argsz;
> +
> +    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
> +    if (msg.hdr.flags & VFIO_USER_ERROR) {
> +        return -msg.hdr.error_reply;
> +    }
> +    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
> +
> +    memcpy(info, &msg.argsz, argsz);
> +
> +    /* defend against a malicious server */
> +    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
> +        info->num_irqs > VFIO_USER_MAX_IRQS) {
> +        error_printf("%s: invalid reply\n", __func__);


The error could be reported to the caller.


Thanks,

C.


> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 0887d0aa1a..c6b6628505 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -39,10 +39,6 @@ static void vfio_user_cb(void *opaque);
>   
>   static void vfio_user_request(void *opaque);
>   static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
> -static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> -                                VFIOUserFDs *fds, int rsize);
> -static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> -                                  uint32_t size, uint32_t flags);
>   
>   static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
>   {
> @@ -610,8 +606,8 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
>       return 0;
>   }
>   
> -static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> -                                VFIOUserFDs *fds, int rsize)
> +void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                         VFIOUserFDs *fds, int rsize)
>   {
>       VFIOUserMsg *msg;
>       int ret;
> @@ -782,8 +778,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>       g_free(proxy);
>   }
>   
> -static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> -                                  uint32_t size, uint32_t flags)
> +void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> +                           uint32_t size, uint32_t flags)
>   {
>       static uint16_t next_id;
>   
> diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
> index cb958d0aa3..54af0da585 100644
> --- a/hw/vfio-user/meson.build
> +++ b/hw/vfio-user/meson.build
> @@ -1,6 +1,7 @@
>   vfio_user_ss = ss.source_set()
>   vfio_user_ss.add(files(
>     'container.c',
> +  'device.c',
>     'pci.c',
>     'proxy.c',
>   ))
> diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
> index 7a3645024f..6b06a3ed82 100644
> --- a/hw/vfio-user/trace-events
> +++ b/hw/vfio-user/trace-events
> @@ -6,3 +6,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
>   vfio_user_recv_request(uint16_t cmd) " command 0x%x"
>   vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
>   vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
> +vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"


