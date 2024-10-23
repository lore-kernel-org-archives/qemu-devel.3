Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E6D2E021
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3WKJ-0006SO-GG; Wed, 23 Oct 2024 04:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t3WK4-0006Me-JJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t3WK0-0002Mj-8O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729670541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUE2sJgPkHy1t+lzNwbZuFuoXZncg/o3AlhH675o2Mw=;
 b=Vrtb9LFr77G2rWtINYHNoVdN3Eli8VVJTATnqJLcr9wdJr8JlVvSAA7LIjk51wPymHTuSY
 EIYDBk6JF5Is1IaNYYmj747pB0vre91/cZYEbWXwUCJ5mWd8zE47cNm02OLv8ttrFUhDfb
 Y7xT9YG6ULNCa5YSUb3dTRNtlpBKcj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-EH1c4RsAOHGHr6yCLyBY8g-1; Wed, 23 Oct 2024 04:02:20 -0400
X-MC-Unique: EH1c4RsAOHGHr6yCLyBY8g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso47930255e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729670539; x=1730275339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUE2sJgPkHy1t+lzNwbZuFuoXZncg/o3AlhH675o2Mw=;
 b=A5tZOYOe3nn4nxqJimCG03bnteS/4e+eYak/oGvhMlCtmpkU7qRJ8cosYJTqNmX50a
 2M2+AI4T9Kywr5jJrRyWi2kKGxn80IqocSop6I4AXzdVhZtasOjGVLwbWkFpc9s3eG0D
 ITaEt5Tn2fnCTmn137Nf2t+fzuaZ2FTO2SRDkh4jZnuTfgSs1XzmlzbaiBwC+d7QR+ZQ
 rormZm82vEqAGslPOJUlRWWHjK5l0yb3jjO1ZunlUp6Fl1ioF2mgn6VEJl80oKV47YGb
 5N4g5Z3VdFNyht+db5STAIHv6elzcbEE4REL/LUv/r71pEVk0MeTI6RNoRZT8S1M3xch
 B7DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeOkcPONrBkg3nOznK3zNTDgpyghkaVIhScXLkcUCPvhA6r4pNBj9VWPlWi/GAesBk3m8uha7l8+xE@nongnu.org
X-Gm-Message-State: AOJu0YyCusbzsO9FHMzbW2mz7r5n4WPkpXwoxu38c+LGWXXzCe64u1JK
 dhTuAGjq3T7jqmbQbicxaRFN3X5EomtBL12qcltY0bQOpRdQDaiACBox+mRdFYbUsdbr2ThVBTK
 14y5UzvNoWXz5VlQK0JFpKbyq4MKkbqXoKheNRqmDgxNEmtjEuACh
X-Received: by 2002:a05:6000:c41:b0:37d:4ebe:164f with SMTP id
 ffacd0b85a97d-37efcf7f0famr1147789f8f.46.1729670538870; 
 Wed, 23 Oct 2024 01:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAUyY3YwEvTcLdZicTwWkSqqzD2mLBhPzATZeuJuvl4qlswEcmSeSI3tS0FnTepNHkWD6npw==
X-Received: by 2002:a05:6000:c41:b0:37d:4ebe:164f with SMTP id
 ffacd0b85a97d-37efcf7f0famr1147754f8f.46.1729670538357; 
 Wed, 23 Oct 2024 01:02:18 -0700 (PDT)
Received: from redhat.com ([2.52.26.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186bdb7b6sm8959935e9.11.2024.10.23.01.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 01:02:17 -0700 (PDT)
Date: Wed, 23 Oct 2024 04:02:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: Add queues before loading them
Message-ID: <20241023040059-mutt-send-email-mst@kernel.org>
References: <20241022-load-v1-1-99df0bff7939@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-load-v1-1-99df0bff7939@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 22, 2024 at 03:49:01PM +0900, Akihiko Odaki wrote:
> Call virtio_net_set_multiqueue() to add queues before loading their
> states. Otherwise the loaded queues will not have handlers and elements
> in them will not be processed.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Jason, your queue?

> ---
>  include/hw/virtio/virtio.h |  2 ++
>  hw/net/virtio-net.c        | 10 ++++++++++
>  hw/virtio/virtio.c         |  7 +++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index f526ecc8fcc0..638691028050 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -210,6 +210,8 @@ struct VirtioDeviceClass {
>      void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
>      int (*start_ioeventfd)(VirtIODevice *vdev);
>      void (*stop_ioeventfd)(VirtIODevice *vdev);
> +    /* Called before loading queues. Useful to add queues before loading. */
> +    int (*pre_load_queues)(VirtIODevice *vdev);
>      /* Saving and loading of a device; trying to deprecate save/load
>       * use vmsd for new devices.
>       */
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index fb84d142ee29..c467ef130016 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3032,6 +3032,15 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
>      virtio_net_set_queue_pairs(n);
>  }
>  
> +static int virtio_net_pre_load_queues(VirtIODevice *vdev)
> +{
> +    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
> +                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
> +                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
> +
> +    return 0;
> +}
> +
>  static int virtio_net_post_load_device(void *opaque, int version_id)
>  {
>      VirtIONet *n = opaque;
> @@ -4025,6 +4034,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
>      vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
>      vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
>      vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
> +    vdc->pre_load_queues = virtio_net_pre_load_queues;
>      vdc->post_load = virtio_net_post_load_virtio;
>      vdc->vmsd = &vmstate_virtio_net_device;
>      vdc->primary_unplug_pending = primary_unplug_pending;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index a26f18908ea5..f12c4aa81eb5 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3255,6 +3255,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>          config_len--;
>      }
>  
> +    if (vdc->pre_load_queues) {
> +        ret = vdc->pre_load_queues(vdev);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      num = qemu_get_be32(f);
>  
>      if (num > VIRTIO_QUEUE_MAX) {
> 
> ---
> base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
> change-id: 20241017-load-fb5544456d28
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


