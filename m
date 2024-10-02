Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EB9CF31B0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwck-00024s-2j; Wed, 02 Oct 2024 06:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwcc-00024W-Iy
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwcQ-000157-6E
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IX7nuUOMUjsGUsuGWGQC7qxPPHIzgyhjeG0CmEToIBA=;
 b=K4IwVfOEcuzOZpJ3WwwZp2YJ9Be6uUYtVnfaZ4oSpI9VVqzzeUBtUsG44yMogt0agfyLa/
 UYgK3nOOXPAMyKxJGxWwUM79M/+Y+H6fLHunfvL6rCC9caJhyybd8lSxTDx5vkFBgbTv7k
 1U9ky9BuMmWjBO8jHVlXvgQBverocsY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-oDXeTEnxOK6fYD4iJXubMA-1; Wed, 02 Oct 2024 06:30:03 -0400
X-MC-Unique: oDXeTEnxOK6fYD4iJXubMA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd4acb55aso3910950f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865002; x=1728469802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IX7nuUOMUjsGUsuGWGQC7qxPPHIzgyhjeG0CmEToIBA=;
 b=b6YnJdWyXCIExIBZ5lntqBfFr4ohfwSP1BhUyMV5veA57qX+4pL8k3Kx9ds5YzGw9U
 Me+KBzOxQGN49iUcav3oSIl0FjVMQAXJJAXv/JMq3m2Y/bYpZ2dlWmdkBbKplsW7D0Tb
 D7Zr6CMflHEx+8w9b3a1U9QweW3Mnw7AiQh0zxQ6cBf/R9GkutyEp+w3uTwST640BAMX
 Ljn59+952AIM+2I/bLlB7F6FhZsnhpcdsgGJgLsoO7v3jOBmPDMdKN6NWHRRQS0QMYTe
 aEXsWbgCcSzRZaOJvOA3RJjxPGJIQ/sRbAl3ST8NimbPlex38nvstbS9B7przxfPBReR
 de/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGcKN9XdVo0WYlkvphfzETJAsYmVSBAcYRbk/wYQi5LuIpvzNt3jFQLQuY3ORw3r1S3yoyh2aTWZpg@nongnu.org
X-Gm-Message-State: AOJu0YzN1woaaTTEX+zChgk1j3unUSzCpJ2TszJzhLQvgtoAJN7jqwi7
 z/nALxj5hmYL/dYSZqNEUoG477by8ry/uTqTdchaZpEtV+PqMzHhUy0s3PNioABmc3t/SQIUhKD
 rmDBdV/9tFXa0k7QWLOm3hDgrfi+nQgG+axrs+T417fTF2Ql8GCBUPvOpcJZPJTo=
X-Received: by 2002:adf:e8d2:0:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-37cfba0a75dmr2123735f8f.46.1727865002103; 
 Wed, 02 Oct 2024 03:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNHj+Ydlo1ab9AYsVb/g4W/+cW521RymdGL3c+NW6xLFsLnIpL5JvZ55g8bXh2LdjTQs6MbA==
X-Received: by 2002:adf:e8d2:0:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-37cfba0a75dmr2123711f8f.46.1727865001658; 
 Wed, 02 Oct 2024 03:30:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575de8fsm13558496f8f.116.2024.10.02.03.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:30:01 -0700 (PDT)
Message-ID: <569ca97e-2463-48d7-a05c-abc4b7289658@redhat.com>
Date: Wed, 2 Oct 2024 12:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Remove deadcode
To: dave@treblig.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240918205258.444880-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918205258.444880-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2024 22.52, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> net_hub_port_find is unused since 2018's commit
>    af1a5c3eb4 ("net: Remove the deprecated "vlan" parameter")
> 
> qemu_receive_packet_iov is unused since commit
>    ffbd2dbd8e ("e1000e: Perform software segmentation for loopback")
> 
> in turn it was the last user of qemu_net_queue_receive_iov.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   include/net/net.h   |  4 ----
>   include/net/queue.h |  4 ----
>   net/hub.c           | 25 -------------------------
>   net/net.c           | 10 ----------
>   net/queue.c         | 11 -----------
>   5 files changed, 54 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index c8f679761b..cdd5b109b0 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -172,9 +172,6 @@ ssize_t qemu_sendv_packet_async(NetClientState *nc, const struct iovec *iov,
>                                   int iovcnt, NetPacketSent *sent_cb);
>   ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size);
>   ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size);
> -ssize_t qemu_receive_packet_iov(NetClientState *nc,
> -                                const struct iovec *iov,
> -                                int iovcnt);
>   ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size);
>   ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
>                                  int size, NetPacketSent *sent_cb);
> @@ -307,7 +304,6 @@ void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
>   void netdev_add(QemuOpts *opts, Error **errp);
>   
>   int net_hub_id_for_client(NetClientState *nc, int *id);
> -NetClientState *net_hub_port_find(int hub_id);
>   
>   #define DEFAULT_NETWORK_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifup"
>   #define DEFAULT_NETWORK_DOWN_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifdown"
> diff --git a/include/net/queue.h b/include/net/queue.h
> index 9f2f289d77..2e686b1b61 100644
> --- a/include/net/queue.h
> +++ b/include/net/queue.h
> @@ -59,10 +59,6 @@ ssize_t qemu_net_queue_receive(NetQueue *queue,
>                                  const uint8_t *data,
>                                  size_t size);
>   
> -ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
> -                                   const struct iovec *iov,
> -                                   int iovcnt);
> -
>   ssize_t qemu_net_queue_send(NetQueue *queue,
>                               NetClientState *sender,
>                               unsigned flags,
> diff --git a/net/hub.c b/net/hub.c
> index 4c8a469a50..496a3d3b4b 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -193,31 +193,6 @@ NetClientState *net_hub_add_port(int hub_id, const char *name,
>       return &port->nc;
>   }
>   
> -/**
> - * Find a available port on a hub; otherwise create one new port
> - */
> -NetClientState *net_hub_port_find(int hub_id)
> -{
> -    NetHub *hub;
> -    NetHubPort *port;
> -    NetClientState *nc;
> -
> -    QLIST_FOREACH(hub, &hubs, next) {
> -        if (hub->id == hub_id) {
> -            QLIST_FOREACH(port, &hub->ports, next) {
> -                nc = port->nc.peer;
> -                if (!nc) {
> -                    return &(port->nc);
> -                }
> -            }
> -            break;
> -        }
> -    }
> -
> -    nc = net_hub_add_port(hub_id, NULL, NULL);
> -    return nc;
> -}
> -
>   /**
>    * Print hub configuration
>    */
> diff --git a/net/net.c b/net/net.c
> index fc1125111c..d9b23a8f8c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -750,16 +750,6 @@ ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
>       return qemu_net_queue_receive(nc->incoming_queue, buf, size);
>   }
>   
> -ssize_t qemu_receive_packet_iov(NetClientState *nc, const struct iovec *iov,
> -                                int iovcnt)
> -{
> -    if (!qemu_can_receive_packet(nc)) {
> -        return 0;
> -    }
> -
> -    return qemu_net_queue_receive_iov(nc->incoming_queue, iov, iovcnt);
> -}
> -
>   ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
>   {
>       return qemu_send_packet_async_with_flags(nc, QEMU_NET_PACKET_FLAG_RAW,
> diff --git a/net/queue.c b/net/queue.c
> index c872d51df8..fb33856c18 100644
> --- a/net/queue.c
> +++ b/net/queue.c
> @@ -193,17 +193,6 @@ ssize_t qemu_net_queue_receive(NetQueue *queue,
>       return qemu_net_queue_deliver(queue, NULL, 0, data, size);
>   }
>   
> -ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
> -                                   const struct iovec *iov,
> -                                   int iovcnt)
> -{
> -    if (queue->delivering) {
> -        return 0;
> -    }
> -
> -    return qemu_net_queue_deliver_iov(queue, NULL, 0, iov, iovcnt);
> -}
> -
>   ssize_t qemu_net_queue_send(NetQueue *queue,
>                               NetClientState *sender,
>                               unsigned flags,

Reviewed-by: Thomas Huth <thuth@redhat.com>


