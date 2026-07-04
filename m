Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34978C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfwOQ-00010v-Oo; Sat, 04 Jul 2026 05:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfwON-00010O-Kk
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 05:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfwOL-00027Z-5E
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 05:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783156227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=722gIufa3nTIxrmQ9VrgqIFpyomZPIWRmKB7l4eCg74=;
 b=Ks+sUec9wSNreEdCFNUQjGrzO2SiMEcv++YgVkE1G/Vh/odwd1P//n6pv55QILh8oGnWLg
 +motoUZv80MjN9rkBtdffwd9pkPHfM4KjF0tOvLcqrIRHmu0AoHIMdhbh9utr30Q6tffFi
 hXlyM0wy6ckkxwZJa3P7O629UCYyWQA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-8P7KQE3tNgyXsfe6WrxI4Q-1; Sat, 04 Jul 2026 05:10:25 -0400
X-MC-Unique: 8P7KQE3tNgyXsfe6WrxI4Q-1
X-Mimecast-MFC-AGG-ID: 8P7KQE3tNgyXsfe6WrxI4Q_1783156224
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493ce4b7777so8765555e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783156224; x=1783761024; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=722gIufa3nTIxrmQ9VrgqIFpyomZPIWRmKB7l4eCg74=;
 b=FCyoWgS0fwbdLvHUx+CejJ/VcHkoJdQoR3BZ8l1nbA9usyREwhjXP/A1yOAJdrlFVY
 l/gSRitZw94yG5okMh4r/IHm/SzNx/aaRf9xjjTLo5VGJjYq9jKHh3w1HEBiDZPY8s0H
 OcKmJzTWLwaIHAX0TZKjEm46Hdb72hqZ4UfGTkwGAttr2GO8GNAV+H4vu/ul/N0bKDd7
 d5gvKik+ywhgw7HQbGPB87M0XXy+DcIiKM/3F2ssHG1nE6oFG+HpnPD26JYOiG7eXYF+
 UNZTgTKsl/IVh8E+OHAJrkEUL+/u2DMAbJbUeNLxdZU6UebHSFUNXWQkDn0Ps+pMMbkG
 gs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783156224; x=1783761024;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=722gIufa3nTIxrmQ9VrgqIFpyomZPIWRmKB7l4eCg74=;
 b=h0pyLnxE0I1TRcGPkJXGUW7BhoeyCPxuP/tncWCtOTxOlOqgZ8B7cQiBBVWqJZx4nR
 E4O2MAdJwhPy8SyYWkBzoZgh1QJgaROXH2dmtwvPMeWd05h0xO4t2FNO/uR23McWsQim
 tVGwVslMSjhUUr/Jg06gCUtnaownxRwpDLnl27WYB+KV3iVGYf4uWkFr2bP0x5p00tu3
 uE+oIL95JSCViuUbs+/DwT1Qp3R36OqWsqQdveK6SKu7t2LOiF751EA0VFtSxtjPI5+7
 sLjXbZpl15rEgj2Jo7J2DWLMJ+f3zpFQC2p1uYYTUu21pRqEk/lE+z3a/EfP5oa7j4/L
 BpOw==
X-Gm-Message-State: AOJu0YyPjeffKYBXJXEB4Wmz6qxSfWK4pluxD5UEdQ+YMb1Ts3Chrw5M
 rRv/drYjL74aZ3nMZQ1izu0FxivPuLNfE/jG3C3cdUnUa2IbxFgrR9YgK0Q7iroh9l0qVY+6NCd
 5a9zKPA05xuS4zVycfPYMM+ei/7P2/lmYR5Vc/Nxf/se1I4Br21xrL8xMx7clijG8aUo=
X-Gm-Gg: AfdE7clCltzWYpL/RM6bB9osax00K0Mj4HYrAZ/LMScInwL6ZHKV/bHrMIOxFKqz/S4
 5iGBxqQVv0+JUH8VcjTIjvSAF1ubuFU/fW2c1FucBBogAKDj+oFPQgIMV5Kgo49GPh/qtKAbJMT
 pT1lxVq1ZnS2Tkuxb/tlnhCu1xSsAbOZ10nbK4gRv9PIcnhtQrLVrdp3LCx9N0GNmGRym1G9VcZ
 /vG3detys568NQePbLmHn6K0J/GBLeA3p2NDi6PkYshqqNYWq0MIvV2Hdzt7MpZM4ZShLKVw1ft
 LHvoTOfZy70rqoVkxoCoxLNSgSiMp6nx3LlDA6VJhdhg/0kvZuNNOVflyRuCAVYwVKqz9/Ki5uT
 HCzBnTDNU8/aPwIq0qAh4HksasuvThqbtsUDf+bLa7A==
X-Received: by 2002:a05:600c:a011:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-493d11d3c9emr26800425e9.8.1783156224208; 
 Sat, 04 Jul 2026 02:10:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-493d11d3c9emr26800015e9.8.1783156223644; 
 Sat, 04 Jul 2026 02:10:23 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm254040775e9.1.2026.07.04.02.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:10:23 -0700 (PDT)
Date: Sat, 4 Jul 2026 05:10:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/virtio: propagate vhost_virtqueue_mask() errors from
 start path
Message-ID: <20260704050823-mutt-send-email-mst@kernel.org>
References: <20260604124420.82450-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604124420.82450-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 04, 2026 at 08:44:20PM +0800, Bin Guo wrote:
> vhost_virtqueue_start() unmasks the call notifier by calling
> vhost_virtqueue_mask(), whose vhost_set_vring_call ioctl can fail
> (closed vhost-user socket, kernel ENOMEM, revoked guest_notifier fd)
> but whose void signature throws the error away. vhost_dev_start()
> then reports success while the backend has no valid call eventfd for
> that vq, leaving the guest with a working kick path but no virtqueue
> interrupts -- a half-up state harder to diagnose than a clean failure.
> 
> Make vhost_virtqueue_mask() return int and handle the error in the
> start path via the existing fail_vector unwind. Other callers reach
> the function through VirtioDeviceClass.guest_notifier_mask, whose
> void signature offers no upward error channel; they invoke it as a
> statement and remain source-compatible.
> 
> Resolves a long-standing TODO at the unmask call.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/virtio/vhost.c         | 12 +++++++++---
>  include/hw/virtio/vhost.h |  4 ++--
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index b9dc4ed13b..42e2fc9952 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1351,8 +1351,11 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>       * will do it later.
>       */
>      if (!vdev->use_guest_notifier_mask) {
> -        /* TODO: check and handle errors. */
> -        vhost_virtqueue_mask(dev, vdev, idx, false);
> +        r = vhost_virtqueue_mask(dev, vdev, idx, false);
> +        if (r < 0) {
> +            /* No call eventfd means no interrupts; bail out. */
> +            goto fail_vector;
> +        }
>      }
>  
>      if (k->query_guest_notifiers &&



Can you rebase please? Thanks!

> @@ -1815,7 +1818,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
>  }
>  
>  /* Mask/unmask events from this vq. */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                           bool mask)
>  {
>      struct VirtQueue *vvq = virtio_get_queue(vdev, n);
> @@ -1836,7 +1839,10 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>      r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
>      if (r < 0) {
>          error_report("vhost_set_vring_call failed %d", -r);
> +        return r;
>      }
> +
> +    return 0;
>  }
>  
>  bool vhost_config_pending(struct vhost_dev *hdev)
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 89817bd848..96cc261822 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -317,8 +317,8 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
>  
>  /* Mask/unmask events from this vq.
>   */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> -                          bool mask);
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +                         bool mask);
>  
>  /**
>   * vhost_get_features_ex() - sanitize the extended features set
> -- 
> 2.50.1 (Apple Git-155)


