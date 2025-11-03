Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213EDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG24S-0001wz-Mb; Mon, 03 Nov 2025 16:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG24Q-0001wl-Dn
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG24K-0003Lc-FH
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762205179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4FFPmkKyWvrvhd/a4HZyN87hkqd3oPoHBBbacK7+as=;
 b=DaRH+abR2kSZEn2rHhRrF0oMTpAoO0vkU+IBPixO4O99LIbaDEBrD1mNZ15edzqmOVnbFL
 1hfFjTLI7R04xnGIw8bLKxu3mkuA3WCHZ3G0cC+GkMUGQhqWtbKMzMAXNUTG1ugHZMIewO
 5v5+kQ9YhowmeSF5DoQLhN/hPbjxvo4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Z62y_qj7NHqOmHfEKHxXAQ-1; Mon, 03 Nov 2025 16:26:17 -0500
X-MC-Unique: Z62y_qj7NHqOmHfEKHxXAQ-1
X-Mimecast-MFC-AGG-ID: Z62y_qj7NHqOmHfEKHxXAQ_1762205177
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c19b5e61so2757630f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762205176; x=1762809976; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W4FFPmkKyWvrvhd/a4HZyN87hkqd3oPoHBBbacK7+as=;
 b=HVkbNFH+mP/QAPITPBBwVIxp3LOXpSn8si3njZNeeWKNdzATtskfAZZ+6mSjWOPkvT
 ll/nq/Y0WDvlgcF0uNDU3iC9UUaXrxPeOdDGO71yDsdUExXIl5mzg7z3UZIQ+6d2q5yQ
 oqXxKWe7x0C2lRdm9WgAnaHb2vu+tz0m70L1CIlsTC6L5jfo5WgVnYv939ry0IzqwZtk
 +2wwFnrlWPU5dT8SGTJFqTDh2/veec7+1dUA13KbKW1TRVXldlH9bERI7VRCG+0GiqkB
 XyE1mOFktAJ1QOaXaSgLeWHfm6llP0QpYhv2cJcwEGwERBwPasLl7AcjjWb6aBejRExq
 ngzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762205176; x=1762809976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4FFPmkKyWvrvhd/a4HZyN87hkqd3oPoHBBbacK7+as=;
 b=sbJ2xwwUL9OrLMiozRMHn40FsPMYuiIlMAlAJYnKf+02fbZQG20G7gwzgmafAmEH3l
 YezK5oicUyn6H4NLBwQA2U+puVTssKDbICeDxglO7eQVtQFRsj3JK0v2gDITpnIbjJ7O
 lJYtOUux/wPsaVjsyt/FUI3X4nP2HyvYkiTidN5h6e+rQKI+56iL7tZNSHlgZEOQJSy9
 WVUwRQQo9vZ+GkwnKYjqIEcxlfScj8pZ+mCfFsWM5youSiXdxvgVV7ZSTIv43Nd7YNQ6
 4oJBfgO5HX44m1fB4M4+wJxTwho8PwCIlKAZ/EFX/lU/NlC7N5t9hdZ8DJycuPPkT6Mf
 S2og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUkhMsx9Epyu081dBcNO36Hy4PlCkO6w7v1f3ZOnkC+xaqpoDEWEuO7K5jn7fZyvYDTGNvuD+DBic@nongnu.org
X-Gm-Message-State: AOJu0Yyfe1OiOM27tz9ZJQE1YCHjUELXizA7IDwWTOpQAVbDesg9lQ+P
 YeTa0xpPJW8vEOpvpzun0gY/UUy18aUm7iF3sxrQADvBUzzI2RVtdGzMPM7LnVAZrhaZlTwZ3Wh
 sMQ6el82NVF7GdA/UNSBM6lC8vmHVUsxAcRBPdc/ll0SEu1BtxE32yDIA
X-Gm-Gg: ASbGncst/b4VtPHNjYDO3x3hfgE6iBal9jdvdpAJvHvzUSe8ODQotrM87UhEeCH993/
 NCBOwP1Hw3iPmwQU5ckp6sLgdRGpXkfUdasCikfI40QY66bnJ+F0fUOj9YQX1yM3qDFIbENCtzk
 uWt06wE1mvFkM3UJKYEdBZEXEPliePx9etP7VsY0lLqhaizzd8tfy0GfcUuH9HVQvdecmxQG9TF
 GdAH1Qy163nEMudvQ+gAMYHvOjawq2Y/WHAdEEY6DOM7s/eJEGc6UGqn5XKcUJ1ooVLz3PW2WCX
 3HaNsFFcNFfx8H7wK+KL5Gh4HH0gFCEJWwJHdbVQEDn2Q8ZjmzcGYpDKWOXc5Bc=
X-Received: by 2002:a5d:5e8e:0:b0:429:ba48:4d7 with SMTP id
 ffacd0b85a97d-429bd6863cbmr12695010f8f.24.1762205176553; 
 Mon, 03 Nov 2025 13:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6DQCTXt+FvewpkZCfgS/z36oaB0EMT7q/PTONkEJJQsF67MUP07yHk8nvY1GVZP6x9gyKag==
X-Received: by 2002:a5d:5e8e:0:b0:429:ba48:4d7 with SMTP id
 ffacd0b85a97d-429bd6863cbmr12694990f8f.24.1762205175944; 
 Mon, 03 Nov 2025 13:26:15 -0800 (PST)
Received: from redhat.com ([31.187.78.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1a850fsm898682f8f.20.2025.11.03.13.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:26:15 -0800 (PST)
Date: Mon, 3 Nov 2025 16:26:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v3 23/23] vhost: add some useful trace-points
Message-ID: <20251103162429-mutt-send-email-mst@kernel.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-24-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015145808.1112843-24-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 15, 2025 at 05:58:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> ---
>  hw/virtio/trace-events | 12 ++++++++++--
>  hw/virtio/vhost.c      | 20 ++++++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index aa1ffa5e94..c2529814f9 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -9,8 +9,16 @@ vhost_section(const char *name) "%s"
>  vhost_reject_section(const char *name, int d) "%s:%d"
>  vhost_iotlb_miss(void *dev, int step) "%p step %d"
>  vhost_dev_cleanup(void *dev) "%p"
> -vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
> -vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
> +vhost_dev_start_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
> +vhost_dev_start_out(void *dev, const char *name) "%p:%s"
> +vhost_dev_stop_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
> +vhost_dev_stop_out(void *dev, const char *name) "%p:%s"
> +vhost_virtque_start_in(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_start_out(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_stop_in(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_stop_out(void *dev, const char *name, int idx) "%p:%s %d"

virtqueue_ not virtque_

> +vhost_dev_init_in(void *dev) "%p"
> +vhost_dev_init_out(void *dev) "%p"
>  
>  
>  # vhost-user.c
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index fb5c4ba1ca..7ba90c24db 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1333,6 +1333,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
>  
> +    trace_vhost_virtque_start_in(dev, vdev->name, idx);
> +

should be "virtqueue"

>      r = vhost_vrings_map(dev, vdev, vq, idx);
>      if (r <= 0) {
>          return r;
> @@ -1394,6 +1396,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          }
>      }
>  
> +    trace_vhost_virtque_start_out(dev, vdev->name, idx);
> +


same


>      return 0;
>  
>  fail:
> @@ -1412,6 +1416,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
>      };
>      int r = 0;
>  
> +    trace_vhost_virtque_stop_in(dev, vdev->name, idx);
> +

same

>      if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return 0;
> @@ -1445,6 +1451,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
>      }
>  
>      vhost_vrings_unmap(dev, vq, true);
> +
> +    trace_vhost_virtque_stop_out(dev, vdev->name, idx);

same

>      return r;
>  }
>  
> @@ -1616,6 +1624,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>  {
>      int i, r, n_initialized_vqs = 0;
>  
> +    trace_vhost_dev_init_in(hdev);
> +
>      hdev->vdev = NULL;
>      hdev->migration_blocker = NULL;
>  
> @@ -1700,6 +1710,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>          goto fail;
>      }
>  
> +    trace_vhost_dev_init_out(hdev);
> +
>      return 0;
>  
>  fail:
> @@ -2048,7 +2060,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>      /* should only be called after backend is connected */
>      assert(hdev->vhost_ops);
>  
> -    trace_vhost_dev_start(hdev, vdev->name, vrings);
> +    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
>  
>      vdev->vhost_started = true;
>      hdev->started = true;
> @@ -2133,6 +2145,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>          }
>      }
>      vhost_start_config_intr(hdev);
> +
> +    trace_vhost_dev_start_out(hdev, vdev->name);
>      return 0;
>  fail_iotlb:
>      if (vhost_dev_has_iommu(hdev) &&
> @@ -2182,7 +2196,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
>      event_notifier_cleanup(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>  
> -    trace_vhost_dev_stop(hdev, vdev->name, vrings);
> +    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
>  
>      if (hdev->vhost_ops->vhost_dev_start) {
>          hdev->vhost_ops->vhost_dev_start(hdev, false);
> @@ -2212,6 +2226,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
>      hdev->started = false;
>      vdev->vhost_started = false;
>      hdev->vdev = NULL;
> +
> +    trace_vhost_dev_stop_out(hdev, vdev->name);
>      return rc;
>  }
>  
> -- 
> 2.48.1


