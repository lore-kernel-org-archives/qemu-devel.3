Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70829C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 08:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUL65-0000HH-9d; Wed, 25 Jun 2025 04:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL60-0000H8-GS
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL5w-0005yo-PS
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750838576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XPRZ8NZtXq84Lj3eCkHVGCwns2gWmotChwcwlCLxAj0=;
 b=GUPgObtXu2lDO7+G4dgSQG/N2ChMhAONpMGPx0a9E34Rb2W9l1Hxcz5biLqlbgCzuTXqHY
 r6XsvCuZ/lUVIIurj4xWFgxeuvrPSekL/+5qRrZ6+Dks4J4uIw67cRej/IL/642hf3wX/y
 fQBAzYxdau6KxbyUglTrcb9hzRH1NnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-qdl5DlDEPEyFKJE69f3I_Q-1; Wed, 25 Jun 2025 04:02:54 -0400
X-MC-Unique: qdl5DlDEPEyFKJE69f3I_Q-1
X-Mimecast-MFC-AGG-ID: qdl5DlDEPEyFKJE69f3I_Q_1750838573
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4536962204aso16366445e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 01:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750838573; x=1751443373;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPRZ8NZtXq84Lj3eCkHVGCwns2gWmotChwcwlCLxAj0=;
 b=azfwZjNOtZvgypkvwvhSBO66hlEqjeomP8cJw208DnfyFDGvupA/2NDzsyKqYwGBOf
 HAen6WIMzWXXFIsRAnn62ZRTdFk5hKRJkizUvuxjQMIUQ5/FVl1H9/WOLrQAeRqakKsf
 ghqXnI0r8JNijKnI3QnHA//Fi9hplhjSRQBzKk0za3xzXKV8Jq2H14tiLR4rm4V1525O
 xiZ9bmkRI7q9cu0pCY4KnmUqwtPvaaauQlY8FCl6C4xPvzPhCY8mgvZa8Zt6cJCZMIJe
 wG3Pbg1wpMsJNVRg3US8XskrA9Tr9iBwpyRVpUq2y0QryByDqaP2sRJnUCSGux98hfsm
 gYlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy7CWL1GYMwFmdNhOMIewpnXVwc8AF8ughcNQHegwf10j/2xn9hTT3Yf0rYyHftnVDRTnrbUZR6CzA@nongnu.org
X-Gm-Message-State: AOJu0Yzi0BL6FfLMgd8iHhwlGl6ouQHKCCaxCx2M5P16ek8osAXwD0BC
 7PLYaJQU1YYiLJt4p9ktSFs/ob001LEnQ/UjPOsDOr8Nl9aoHavscUgIOkj4FaqXELlGEzHp3XT
 hTGy+7mFnoKf8kYAIlfT3wg+yZ9XQpqdCNYn8QWP53/+v17cmVQj1r6egdwhc7IIr
X-Gm-Gg: ASbGncv0aJ7QaU6qYLEx34gzZPqvWXEg4H/m0KKj2T2aG3yNrgahyU8LDJuTwaDAKdc
 jVfBoSKCvq3bIu9SN4QopqAqTjhaihk75vED8vUxvvqFhjY6ntlh4aoqJtRO7H6gNoVOWRvwsa/
 bTHj+WxMU1MEpw42xTHw4QJshUhcgMneiYfVBAEUYlvBDJIB4rJrIK99Xi1WPSEDzxSVrQQLNw2
 2OG6yim53sV8os7eHCxjwsemESyVVvoKgJWzojleA2zSp4CBp5kB33AUXc1Btp1J5Sj95aGoQdp
 sTToHE+1MZzbZUccGrm2dVr+G+wR9nf/5dRLOklSq+3/56t1hcqUigpWDJZA
X-Received: by 2002:a05:600c:4ed1:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-45381b1b782mr17683325e9.29.1750838572823; 
 Wed, 25 Jun 2025 01:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuNuM3aZ/wuI1+2B1thQAwQJ6294DuWvany8+AaB2HF1GovEQNwa20nakAWa2Z/gs7/Qu98A==
X-Received: by 2002:a05:600c:4ed1:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-45381b1b782mr17682595e9.29.1750838572143; 
 Wed, 25 Jun 2025 01:02:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234db3bsm11821515e9.16.2025.06.25.01.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 01:02:51 -0700 (PDT)
Message-ID: <4b2bd5c8-0353-4603-8b66-b0c4b7517c96@redhat.com>
Date: Wed, 25 Jun 2025 10:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] vfio-user: implement message receive
 infrastructure
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
 <20250619133154.264786-4-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250619133154.264786-4-john.levon@nutanix.com>
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
> Add the basic implementation for receiving vfio-user messages from the
> control socket.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   meson.build               |   1 +
>   hw/vfio-user/protocol.h   |  53 +++++
>   hw/vfio-user/proxy.h      |  11 +
>   hw/vfio-user/trace.h      |   1 +
>   hw/vfio-user/pci.c        |  11 +
>   hw/vfio-user/proxy.c      | 409 ++++++++++++++++++++++++++++++++++++++
>   hw/vfio-user/trace-events |   6 +
>   7 files changed, 492 insertions(+)
>   create mode 100644 hw/vfio-user/protocol.h
>   create mode 100644 hw/vfio-user/trace.h
>   create mode 100644 hw/vfio-user/trace-events
> 
> diff --git a/meson.build b/meson.build
> index 34729c2a3d..3d2d8c97dc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3686,6 +3686,7 @@ if have_system
>       'hw/ufs',
>       'hw/usb',
>       'hw/vfio',
> +    'hw/vfio-user',
>       'hw/virtio',
>       'hw/vmapple',
>       'hw/watchdog',
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> new file mode 100644
> index 0000000000..4ddfb5f222
> --- /dev/null
> +++ b/hw/vfio-user/protocol.h
> @@ -0,0 +1,53 @@
> +#ifndef VFIO_USER_PROTOCOL_H
> +#define VFIO_USER_PROTOCOL_H
> +
> +/*
> + * vfio protocol over a UNIX socket.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * Each message has a standard header that describes the command
> + * being sent, which is almost always a VFIO ioctl().
> + *
> + * The header may be followed by command-specific data, such as the
> + * region and offset info for read and write commands.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +typedef struct {
> +    uint16_t id;
> +    uint16_t command;
> +    uint32_t size;
> +    uint32_t flags;
> +    uint32_t error_reply;
> +} VFIOUserHdr;
> +
> +/* VFIOUserHdr commands */
> +enum vfio_user_command {
> +    VFIO_USER_VERSION                   = 1,
> +    VFIO_USER_DMA_MAP                   = 2,
> +    VFIO_USER_DMA_UNMAP                 = 3,
> +    VFIO_USER_DEVICE_GET_INFO           = 4,
> +    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
> +    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
> +    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
> +    VFIO_USER_DEVICE_SET_IRQS           = 8,
> +    VFIO_USER_REGION_READ               = 9,
> +    VFIO_USER_REGION_WRITE              = 10,
> +    VFIO_USER_DMA_READ                  = 11,
> +    VFIO_USER_DMA_WRITE                 = 12,
> +    VFIO_USER_DEVICE_RESET              = 13,
> +    VFIO_USER_DIRTY_PAGES               = 14,
> +    VFIO_USER_MAX,
> +};
> +
> +/* VFIOUserHdr flags */
> +#define VFIO_USER_REQUEST       0x0
> +#define VFIO_USER_REPLY         0x1
> +#define VFIO_USER_TYPE          0xF
> +
> +#define VFIO_USER_NO_REPLY      0x10
> +#define VFIO_USER_ERROR         0x20
> +
> +#endif /* VFIO_USER_PROTOCOL_H */
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index a9bce82239..ff553cad9d 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -12,6 +12,9 @@
>   #include "io/channel.h"
>   #include "io/channel-socket.h"
>   
> +#include "qemu/sockets.h"
> +#include "hw/vfio-user/protocol.h"
> +
>   typedef struct {
>       int send_fds;
>       int recv_fds;
> @@ -28,6 +31,7 @@ enum msg_type {
>   
>   typedef struct VFIOUserMsg {
>       QTAILQ_ENTRY(VFIOUserMsg) next;
> +    VFIOUserHdr *hdr;
>       VFIOUserFDs *fds;
>       uint32_t rsize;
>       uint32_t id;
> @@ -67,13 +71,20 @@ typedef struct VFIOUserProxy {
>       VFIOUserMsgQ incoming;
>       VFIOUserMsgQ outgoing;
>       VFIOUserMsg *last_nowait;
> +    VFIOUserMsg *part_recv;
> +    size_t recv_left;
>       enum proxy_state state;
>   } VFIOUserProxy;
>   
>   /* VFIOProxy flags */
>   #define VFIO_PROXY_CLIENT        0x1
>   
> +typedef struct VFIODevice VFIODevice;
> +
>   VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
>   void vfio_user_disconnect(VFIOUserProxy *proxy);
> +void vfio_user_set_handler(VFIODevice *vbasedev,
> +                           void (*handler)(void *opaque, VFIOUserMsg *msg),
> +                           void *reqarg);
>   
>   #endif /* VFIO_USER_PROXY_H */
> diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
> new file mode 100644
> index 0000000000..574b59aa89
> --- /dev/null
> +++ b/hw/vfio-user/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-hw_vfio_user.h"
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 642421e791..bad2829f5c 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -22,6 +22,16 @@ struct VFIOUserPCIDevice {
>       SocketAddress *socket;
>   };
>   
> +/*
> + * Incoming request message callback.
> + *
> + * Runs off main loop, so BQL held.
> + */
> +static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
> +{
> +
> +}
> +
>   /*
>    * Emulated devices don't use host hot reset
>    */
> @@ -80,6 +90,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>           return;
>       }
>       vbasedev->proxy = proxy;
> +    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
>   
>       /*
>        * vfio-user devices are effectively mdevs (don't use a host iommu).
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index bb436c9db9..31e08cbad3 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -11,15 +11,32 @@
>   
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio-user/proxy.h"
> +#include "hw/vfio-user/trace.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
> +#include "qemu/main-loop.h"
>   #include "system/iothread.h"
>   
>   static IOThread *vfio_user_iothread;
>   
>   static void vfio_user_shutdown(VFIOUserProxy *proxy);
> +static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                                     VFIOUserFDs *fds);
> +static VFIOUserFDs *vfio_user_getfds(int numfds);
> +static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>   
> +static void vfio_user_recv(void *opaque);
> +static int vfio_user_recv_one(VFIOUserProxy *proxy);
> +static void vfio_user_cb(void *opaque);
> +
> +static void vfio_user_request(void *opaque);
> +
> +static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
> +{
> +    hdr->flags |= VFIO_USER_ERROR;
> +    hdr->error_reply = err;
> +}
>   
>   /*
>    * Functions called by main, CPU, or iothread threads
> @@ -32,10 +49,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
>                                      proxy->ctx, NULL, NULL);
>   }
>   
> +static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                                     VFIOUserFDs *fds)
> +{
> +    VFIOUserMsg *msg;
> +
> +    msg = QTAILQ_FIRST(&proxy->free);
> +    if (msg != NULL) {
> +        QTAILQ_REMOVE(&proxy->free, msg, next);
> +    } else {
> +        msg = g_malloc0(sizeof(*msg));
> +        qemu_cond_init(&msg->cv);
> +    }
> +
> +    msg->hdr = hdr;
> +    msg->fds = fds;
> +    return msg;
> +}
> +
> +/*
> + * Recycle a message list entry to the free list.
> + */
> +static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
> +{
> +    if (msg->type == VFIO_MSG_NONE) {
> +        error_printf("vfio_user_recycle - freeing free msg\n");
> +        return;
> +    }
> +
> +    /* free msg buffer if no one is waiting to consume the reply */
> +    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
> +        g_free(msg->hdr);
> +        if (msg->fds != NULL) {
> +            g_free(msg->fds);
> +        }
> +    }
> +
> +    msg->type = VFIO_MSG_NONE;
> +    msg->hdr = NULL;
> +    msg->fds = NULL;
> +    msg->complete = false;
> +    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
> +}
> +
> +static VFIOUserFDs *vfio_user_getfds(int numfds)
> +{
> +    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
> +
> +    fds->fds = (int *)((char *)fds + sizeof(*fds));
> +
> +    return fds;
> +}
> +
>   /*
>    * Functions only called by iothread
>    */
>   
> +/*
> + * Process a received message.
> + */
> +static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
> +                              bool isreply)

This routine could have an 'Error **errp' parameter and avoid the
error_printf() below. Can you fix that please ?

> +{
> +
> +    /*
> +     * Replies signal a waiter, if none just check for errors
> +     * and free the message buffer.
> +     *
> +     * Requests get queued for the BH.
> +     */
> +    if (isreply) {
> +        msg->complete = true;
> +        if (msg->type == VFIO_MSG_WAIT) {
> +            qemu_cond_signal(&msg->cv);
> +        } else {
> +            if (msg->hdr->flags & VFIO_USER_ERROR) {
> +                error_printf("vfio_user_process: error reply on async ");
> +                error_printf("request command %x error %s\n",
> +                             msg->hdr->command,
> +                             strerror(msg->hdr->error_reply));
> +            }
> +            /* youngest nowait msg has been ack'd */
> +            if (proxy->last_nowait == msg) {
> +                proxy->last_nowait = NULL;
> +            }
> +            vfio_user_recycle(proxy, msg);
> +        }
> +    } else {
> +        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
> +        qemu_bh_schedule(proxy->req_bh);
> +    }
> +}
> +
> +/*
> + * Complete a partial message read
> + */
> +static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
> +{
> +    VFIOUserMsg *msg = proxy->part_recv;
> +    size_t msgleft = proxy->recv_left;
> +    bool isreply;
> +    char *data;
> +    int ret;
> +
> +    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
> +    while (msgleft > 0) {
> +        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
> +
> +        /* error or would block */
> +        if (ret <= 0) {
> +            /* try for rest on next iternation */
> +            if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +                proxy->recv_left = msgleft;
> +            }
> +            return ret;
> +        }
> +        trace_vfio_user_recv_read(msg->hdr->id, ret);
> +
> +        msgleft -= ret;
> +        data += ret;
> +    }
> +
> +    /*
> +     * Read complete message, process it.
> +     */
> +    proxy->part_recv = NULL;
> +    proxy->recv_left = 0;
> +    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
> +    vfio_user_process(proxy, msg, isreply);
> +
> +    /* return positive value */
> +    return 1;
> +}
> +
> +static void vfio_user_recv(void *opaque)
> +{
> +    VFIOUserProxy *proxy = opaque;
> +
> +    QEMU_LOCK_GUARD(&proxy->lock);
> +
> +    if (proxy->state == VFIO_PROXY_CONNECTED) {
> +        while (vfio_user_recv_one(proxy) == 0) {
> +            ;> +        }
> +    }
> +}
> +
> +/*
> + * Receive and process one incoming message.
> + *
> + * For replies, find matching outgoing request and wake any waiters.
> + * For requests, queue in incoming list and run request BH.
> + */
> +static int vfio_user_recv_one(VFIOUserProxy *proxy)

I would add an 'Error **' parameter too ...

> +{
> +    VFIOUserMsg *msg = NULL;
> +    g_autofree int *fdp = NULL;
> +    VFIOUserFDs *reqfds;
> +    VFIOUserHdr hdr;
> +    struct iovec iov = {
> +        .iov_base = &hdr,
> +        .iov_len = sizeof(hdr),
> +    };
> +    bool isreply = false;
> +    int i, ret;
> +    size_t msgleft, numfds = 0;
> +    char *data = NULL;
> +    char *buf = NULL;
> +    Error *local_err = NULL;
> +
> +    /*
> +     * Complete any partial reads
> +     */
> +    if (proxy->part_recv != NULL) {
> +        ret = vfio_user_complete(proxy, &local_err);
> +
> +        /* still not complete, try later */
> +        if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +            return ret;
> +        }
> +
> +        if (ret <= 0) {
> +            goto fatal;
> +        }
> +        /* else fall into reading another msg */
> +    }
> +
> +    /*
> +     * Read header
> +     */
> +    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
> +                                 &local_err);
> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +        return ret;
> +    }
> +
> +    /* read error or other side closed connection */
> +    if (ret <= 0) {
> +        goto fatal;
> +    }
> +
> +    if (ret < sizeof(hdr)) {
> +        error_setg(&local_err, "short read of header");
> +        goto fatal;
> +    }
> +
> +    /*
> +     * Validate header
> +     */
> +    if (hdr.size < sizeof(VFIOUserHdr)) {
> +        error_setg(&local_err, "bad header size");
> +        goto fatal;
> +    }
> +    switch (hdr.flags & VFIO_USER_TYPE) {
> +    case VFIO_USER_REQUEST:
> +        isreply = false;
> +        break;
> +    case VFIO_USER_REPLY:
> +        isreply = true;
> +        break;
> +    default:
> +        error_setg(&local_err, "unknown message type");
> +        goto fatal;
> +    }
> +    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
> +                             hdr.flags);
> +
> +    /*
> +     * For replies, find the matching pending request.
> +     * For requests, reap incoming FDs.
> +     */
> +    if (isreply) {
> +        QTAILQ_FOREACH(msg, &proxy->pending, next) {
> +            if (hdr.id == msg->id) {
> +                break;
> +            }
> +        }
> +        if (msg == NULL) {
> +            error_setg(&local_err, "unexpected reply");
> +            goto err;
> +        }
> +        QTAILQ_REMOVE(&proxy->pending, msg, next);
> +
> +        /*
> +         * Process any received FDs
> +         */
> +        if (numfds != 0) {
> +            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
> +                error_setg(&local_err, "unexpected FDs");
> +                goto err;
> +            }
> +            msg->fds->recv_fds = numfds;
> +            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +        }
> +    } else {
> +        if (numfds != 0) {
> +            reqfds = vfio_user_getfds(numfds);
> +            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
> +        } else {
> +            reqfds = NULL;
> +        }
> +    }
> +
> +    /*
> +     * Put the whole message into a single buffer.
> +     */
> +    if (isreply) {
> +        if (hdr.size > msg->rsize) {
> +            error_setg(&local_err, "reply larger than recv buffer");
> +            goto err;
> +        }
> +        *msg->hdr = hdr;
> +        data = (char *)msg->hdr + sizeof(hdr);
> +    } else {
> +        buf = g_malloc0(hdr.size);
> +        memcpy(buf, &hdr, sizeof(hdr));
> +        data = buf + sizeof(hdr);
> +        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
> +        msg->type = VFIO_MSG_REQ;
> +    }
> +
> +    /*
> +     * Read rest of message.
> +     */
> +    msgleft = hdr.size - sizeof(hdr);
> +    while (msgleft > 0) {
> +        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
> +
> +        /* prepare to complete read on next iternation */
> +        if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +            proxy->part_recv = msg;
> +            proxy->recv_left = msgleft;
> +            return ret;
> +        }
> +
> +        if (ret <= 0) {
> +            goto fatal;
> +        }
> +        trace_vfio_user_recv_read(hdr.id, ret);
> +
> +        msgleft -= ret;
> +        data += ret;
> +    }
> +
> +    vfio_user_process(proxy, msg, isreply);
> +    return 0;
> +
> +    /*
> +     * fatal means the other side closed or we don't trust the stream
> +     * err means this message is corrupt
> +     */
> +fatal:
> +    vfio_user_shutdown(proxy);
> +    proxy->state = VFIO_PROXY_ERROR;
> +
> +    /* set error if server side closed */
> +    if (ret == 0) {
> +        error_setg(&local_err, "server closed socket");
> +    }
> +
> +err:
> +    for (i = 0; i < numfds; i++) {
> +        close(fdp[i]);
> +    }
> +    if (isreply && msg != NULL) {
> +        /* force an error to keep sending thread from hanging */
> +        vfio_user_set_error(msg->hdr, EINVAL);
> +        msg->complete = true;
> +        qemu_cond_signal(&msg->cv);
> +    }
> +    error_prepend(&local_err, "vfio_user_recv_one: ");
> +    error_report_err(local_err);

... and let the caller vfio_user_recv() do the error reporting. Minor.


Thanks,

C.



> +    return -1;
> +}
> +
>   static void vfio_user_cb(void *opaque)
>   {
>       VFIOUserProxy *proxy = opaque;
> @@ -51,6 +398,53 @@ static void vfio_user_cb(void *opaque)
>    * Functions called by main or CPU threads
>    */
>   
> +/*
> + * Process incoming requests.
> + *
> + * The bus-specific callback has the form:
> + *    request(opaque, msg)
> + * where 'opaque' was specified in vfio_user_set_handler
> + * and 'msg' is the inbound message.
> + *
> + * The callback is responsible for disposing of the message buffer,
> + * usually by re-using it when calling vfio_send_reply or vfio_send_error,
> + * both of which free their message buffer when the reply is sent.
> + *
> + * If the callback uses a new buffer, it needs to free the old one.
> + */
> +static void vfio_user_request(void *opaque)
> +{
> +    VFIOUserProxy *proxy = opaque;
> +    VFIOUserMsgQ new, free;
> +    VFIOUserMsg *msg, *m1;
> +
> +    /* reap all incoming */
> +    QTAILQ_INIT(&new);
> +    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
> +        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
> +            QTAILQ_REMOVE(&proxy->incoming, msg, next);
> +            QTAILQ_INSERT_TAIL(&new, msg, next);
> +        }
> +    }
> +
> +    /* process list */
> +    QTAILQ_INIT(&free);
> +    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
> +        QTAILQ_REMOVE(&new, msg, next);
> +        trace_vfio_user_recv_request(msg->hdr->command);
> +        proxy->request(proxy->req_arg, msg);
> +        QTAILQ_INSERT_HEAD(&free, msg, next);
> +    }
> +
> +    /* free list */
> +    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
> +        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
> +            vfio_user_recycle(proxy, msg);
> +        }
> +    }
> +}
> +
> +
>   static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
>       QLIST_HEAD_INITIALIZER(vfio_user_sockets);
>   
> @@ -89,6 +483,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>       }
>   
>       proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
> +    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
>   
>       QTAILQ_INIT(&proxy->outgoing);
>       QTAILQ_INIT(&proxy->incoming);
> @@ -99,6 +494,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>       return proxy;
>   }
>   
> +void vfio_user_set_handler(VFIODevice *vbasedev,
> +                           void (*handler)(void *opaque, VFIOUserMsg *msg),
> +                           void *req_arg)
> +{
> +    VFIOUserProxy *proxy = vbasedev->proxy;
> +
> +    proxy->request = handler;
> +    proxy->req_arg = req_arg;
> +    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
> +                                   vfio_user_recv, NULL, NULL, proxy);
> +}
> +
>   void vfio_user_disconnect(VFIOUserProxy *proxy)
>   {
>       VFIOUserMsg *r1, *r2;
> @@ -114,6 +521,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>       }
>       object_unref(OBJECT(proxy->ioc));
>       proxy->ioc = NULL;
> +    qemu_bh_delete(proxy->req_bh);
> +    proxy->req_bh = NULL;
>   
>       proxy->state = VFIO_PROXY_CLOSING;
>       QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
> diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
> new file mode 100644
> index 0000000000..89d6c11c4c
> --- /dev/null
> +++ b/hw/vfio-user/trace-events
> @@ -0,0 +1,6 @@
> +# See docs/devel/tracing.rst for syntax documentation.
> +
> +# common.c
> +vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
> +vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
> +vfio_user_recv_request(uint16_t cmd) " command 0x%x"


