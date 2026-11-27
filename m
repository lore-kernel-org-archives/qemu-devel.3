Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E2606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mvImsDN3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvxy-0006Rb-Cv; Fri, 27 Nov 2026 08:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWvxw-0006Qi-HJ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:26:16 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWvxu-000408-Hi
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:26:16 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67db3a48dc6so9640674d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:26:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795785973; cv=none;
 d=google.com; s=arc-20260327;
 b=fEgpG1vN8gFQPOfEZTuOJzeBATylgX3oi7cc9Pes0mqa2vkEBS7rRnOR2UbYT6ujPY
 hGK7Lu6D2fj1zRSxvdkfFYCMW6kjcQm29FFSkqivy0tJ+4K2ZyFvuzD2TYYhW8DV1g61
 Nso+6qx7YUPmnFhOfl6X3lCfWDVM3lcJnc2k98+vQPCrXyMEIt/VGiG9RDcGqzbKayc9
 iNx4xzAUHm9DWKleTtqmhOjx68ubFWSTH/q2ZG/x5y3SdmzpQ+T1as3Ovgft1S5iZWhc
 tf/2Knyly2fcZdO4vfEb3ItRRngS8g72wBxdePM5Yen0o8EJ4dB8ojMzGFlwG3YE228H
 jLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vsmx7k1yAMDoJzsyFw3W/UNhFtofo1M8vK+8szgU8Hs=;
 fh=iAFdQNjaq+PfQzNDdUp5K2HXnN6/oF+/yFKew6uDm8A=;
 b=FnDC+AHnRko5pVy3mWrc83RoY0YQK9Qi8la6hPgMA5dk8M3xxvfM8UNRkMQ9yVl/aX
 FCL04DuF2NP33EIPGDjGXyTDAGuMwFDISk2WQcmzGLQzy6VkAJbVJJGE21NqN37DB+ME
 fnsV45hldUltfS8s3EkT3gIZNGid27NMrpJBGcOyW3AFnCboaEzE4HuMpPJxanKWXVtG
 UMujtpzhjsxTW6pbuBjvEymsWcUzZDyZQLbdZRKoJyXpKEOpTnsmCFZKc6jNUGkbMrQY
 uIAvRUvTvJsy5m/0hvWICJvF/oGwCSDBOi1asq111q/gxDMUpI1OivimkUc06koIbgkf
 Ybtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795785973; x=1796390773; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vsmx7k1yAMDoJzsyFw3W/UNhFtofo1M8vK+8szgU8Hs=;
 b=mvImsDN3rIIbwyFu6BWSIlneDtks8UxT6Pn66wPEe5TVe2YCGFz8ULlDFlmpT3XOJ1
 e/1yb9K/9Tr2VHkseFXoqVFotkWsVd7g2mzqyEOHX6pkoIN3fV2PXoEWaRhM9m9VNWx+
 CzZW+up9OIYk2Y2UhPXh95Q9veSZzOxEFzTI4BDTtVlmGQZG95DoXy+67QDwJnAS8rZ6
 PY9/ZwYea7fWgPfVD8HHAQ5LTXVap1hptL27XjFfrzlibB1X8xzyixrKOsN08F+qT43t
 Y14+A6hwLAVZIytnJzfoCcppQafU2NjEdcROJJgog/F+ZyIvycDE4Hm/LZAau27RK1C2
 AY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795785973; x=1796390773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vsmx7k1yAMDoJzsyFw3W/UNhFtofo1M8vK+8szgU8Hs=;
 b=ge5xsrpaBIb3XxBau72U84KX1Pz7ro8uVCXvor9t1q2awxRn3S0ve/rw1gNfpAXEuC
 f/DXKmg2PhOiPkDmCq3o73CEMI4furvt2jbosZoeuZ2sfTskcMbKw2fcnjszFG3Qbfs4
 UmCrMpp6P7Q+DitJCUkvsTCYfWuq72Ps685j65N1AhNmdaWFw4VhOyjJ/uIPAlfFhLPR
 dajLOPQwhCZJX2XWuuDvhdjkQTfVC4AUIZnJTI0iIB9K5VQ3nVaDQttIBElChetKmsJy
 TedhW+YWB47RH8mG2U9k+Yo/ThY/7MluKFDmb9tYhoT3doKFBx0Wto8vKhhXAoGaMtnv
 hv5Q==
X-Gm-Message-State: APuU4Z+3AXPt6IgDK7G79asODjHOCiH13dM/zq3u81hIXwYdQwgAppuQ
 RLYwjYych8PR5JLCVku2rzyEK612tvUyhrHMHeUx5Ll5Z6l/nNob62mUoOfE+FUZ1NThGWb+Fbo
 k58N/4650rcVkuwn666zoy7zaq66W+QzV3g6Qa4hb8g==
X-Gm-Gg: AZFdTZeA7rsGPG4tHMjUNqAhwAPWowghR2QVJn7Vd5B95mAoAnNRfxWfdTLfmhBNIef
 GeM2WpFqU+QqYtLIHUxdRQsZZxr3mz0rj7GbXsc56z9Jp+XIPl8EzMSmdy5f+G9mTdC52xme7qp
 ciVBLO61BjTapI1xJm0ocRLKnvvz6xhrSfX4e1zTjVz2WqPT18EK/95kfqKwXQM+OUnY59DoasD
 fdWQq30Umn8F5OZn5xn0GDUbLTL/GL5rn0t8lsCrPxhsdkiHhZ//a5+0V5YSB0zaQkVeGDVX6Mr
 cCTIdlX6M8bDP4PCs0ouSyifXICpGbJxQ+gBW5cVI7Ho6EOUyqvtYuXtMMQvlTqh4r/f2638+pC
 MJwxzZHAfKKF7Zd5pLODePfx9ZplSh+KACl/hit8m7Jb1GPW0buKNfLKUPYML+fZtdbkKyzjECR
 zmvRhdOEOcMtRfUTKRI8jCgDNop1nVDLMeCzlY9kY8d2w=
X-Received: by 2002:a05:690e:408d:b0:67d:c305:ca1f with SMTP id
 956f58d0204a3-67df43f32b9mr8198630d50.53.1795785972634; Fri, 27 Nov 2026
 05:26:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106200309.122830-1-den@openvz.org>
 <20261106200309.122830-2-den@openvz.org>
In-Reply-To: <20261106200309.122830-2-den@openvz.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 13:26:00 +0000
X-Gm-Features: Aa3M54paZucIx-SicJwGux3Pi1x5wS0v4NBhjqf4JIag-jH-yphl6gny487R6Ys
Message-ID: <CAFEAcA-LUijuaEYrzet2Zz8E3qZ_8ZJjWONKpYsrRYt1OR7YJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix abort in virtio_net_set_queue_pairs()
 on a deleted tap
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 20:03, Denis V. Lunev <den@openvz.org> wrote:
>
> From: Denis V. Lunev <den@openvz.org>
>
> Once the tap device behind a multiqueue netdev is deleted on the host,
> the queue fds QEMU holds are no longer bound to any device and
> TUNSETQUEUE fails with EINVAL, for attach and detach alike. Management
> can delete the device under a running VM, e.g. OpenStack unplugs the
> VIF of an instance it is deleting. The next
> VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET from the guest then kills QEMU:
>
>   could not enable queue
>   virtio_net_set_queue_pairs: Assertion `!r' failed.
>
> A guest reset aborts the same way through set_features(): clearing the
> features detaches the extra queues and the detach fails too.
>
> Commit a1708203b583 ("net/tap-linux.c: avoid abort when setting invalid
> fd") removed the earlier abort on the same path in
> tap_set_vnet_hdr_len(); this is the next one.
>
> tap_fd_enable() and tap_fd_disable() already report the error. Walk the
> remaining queues anyway, return the failure and let the callers decide:
> - the control command restores the previous number of queue pairs and
>   returns VIRTIO_NET_ERR, so the device matches the guest, which keeps
>   its old setting on error. The rollback cannot fail in turn: tap
>   tracks which queues are attached and skips the ioctl for a queue
>   whose attach or detach already failed;
> - post-load fails the migration, so the source keeps running instead
>   of the destination aborting;
> - set_features() has no way to report it and carries on with a dead
>   link, as a single queue NIC on a deleted tap already does.
>
> The test attaches its own copy of the second queue fd before the guest
> asks for two queue pairs, so the attach from QEMU fails with EINVAL on
> a live device. Creating the tap needs CAP_NET_ADMIN, so the test is
> skipped without it.
>
> Fixes: fed699f9ca6a ("virtio-net: multiqueue support")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowangio@gmail.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/net/virtio-net.c           |  25 +++++---
>  tests/qtest/virtio-net-test.c | 104 ++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+), 7 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 54e42cfec9..82e3c22ca3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -766,24 +766,27 @@ static int peer_detach(VirtIONet *n, int index)
>      return tap_disable(nc->peer);
>  }
>
> -static void virtio_net_set_queue_pairs(VirtIONet *n)
> +static int virtio_net_set_queue_pairs(VirtIONet *n)
>  {
>      int i;
>      int r;
> +    int ret = 0;
>
>      if (n->nic->peer_deleted) {
> -        return;
> +        return 0;
>      }
>
>      for (i = 0; i < n->max_queue_pairs; i++) {
>          if (i < n->curr_queue_pairs) {
>              r = peer_attach(n, i);
> -            assert(!r);
>          } else {
>              r = peer_detach(n, i);
> -            assert(!r);
> +        }
> +        if (r < 0) {
> +            ret = r;
>          }
>      }
> +    return ret;
>  }

This operates on all the peers from curr_queue_pairs to
max_queue_pairs, eventually returning a value that effectively
means either "everything was OK" or else "at least one thing
failed but you can't tell which".

>  static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
> @@ -1499,7 +1502,7 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
>                                  struct iovec *iov, unsigned int iov_cnt)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(n);
> -    uint16_t queue_pairs;
> +    uint16_t queue_pairs, old_queue_pairs;
>      NetClientState *nc = qemu_get_queue(n->nic);
>
>      virtio_net_disable_rss(n);
> @@ -1532,6 +1535,7 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
>          return VIRTIO_NET_ERR;
>      }
>
> +    old_queue_pairs = n->curr_queue_pairs;
>      n->curr_queue_pairs = queue_pairs;
>      if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>          /*
> @@ -1543,7 +1547,12 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
>      /* stop the backend before changing the number of queue_pairs to avoid handling a
>       * disabled queue */
>      virtio_net_set_status(vdev, vdev->status);
> -    virtio_net_set_queue_pairs(n);
> +    if (virtio_net_set_queue_pairs(n) < 0) {
> +        n->curr_queue_pairs = old_queue_pairs;
> +        virtio_net_set_status(vdev, vdev->status);
> +        virtio_net_set_queue_pairs(n);
> +        return VIRTIO_NET_ERR;
> +    }

Here if we get back a failure indication we assume we can just
roll back to the old_queue_pairs value. But if one of the
operations failed but not all of them then that seems like it
might have bad consquences. If we were trying to reduce the number
then we might have detached a peer we're now going to try to use
again without reattaching it, and if we were trying to increase
the number then we might have attached a peer that we've now
forgotten that we attached.

>      return VIRTIO_NET_OK;
>  }
> @@ -3298,7 +3307,9 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>       */
>      n->saved_guest_offloads = n->curr_guest_offloads;
>
> -    virtio_net_set_queue_pairs(n);
> +    if (virtio_net_set_queue_pairs(n) < 0) {
> +        return -EINVAL;
> +    }

Is there anything we need to undo in this error case ?

>      /* Find the first multicast entry in the saved MAC filter */
>      for (i = 0; i < n->mac_table.in_use; i++) {

-- PMM

