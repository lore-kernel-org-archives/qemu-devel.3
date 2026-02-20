Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113A1C5ACD1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 16:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtTEy-0000KL-QK; Fri, 20 Feb 2026 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtTEv-0000Ii-Ql
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtTEt-00014S-QA
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771604420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8KSpknMexpW0Mn7JdLExXNga3okHotK6auOFJbwBKY=;
 b=VdEDdGkvjGBuVhVv8MB0pFOijnSLaWd8JzhHK2f1K+vpcOxDyjAcdvvrJg9BjNGw3Umhz3
 XyxHrlOvn29i2ytOPodtrw0q5TexklOR8r9NWOUmp+ev1RrDnjhHhLTpjzUY4b5Bob/8hj
 GopBwG3QnRQbsu/qy8U8GEgXvMvbQQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-QRXyFgSHMAa_9bJmYdXKMg-1; Fri, 20 Feb 2026 11:20:18 -0500
X-MC-Unique: QRXyFgSHMAa_9bJmYdXKMg-1
X-Mimecast-MFC-AGG-ID: QRXyFgSHMAa_9bJmYdXKMg_1771604417
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so25748955e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771604417; x=1772209217; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8KSpknMexpW0Mn7JdLExXNga3okHotK6auOFJbwBKY=;
 b=WnCkuUDkEico0cX0uoG6lJG6pT4I5rtT2br9JjtV5H5F8JYm1pwv4h5jUdXjyc3AcV
 X2VfIXORZeQHKbo6lnTRSuw2YJgx2Tf/rqMy0kyfrob94LRp6EYEfnlXXVxH0g2lyjZv
 NyKq0Sp2eBt0RK8Zz8kblKUHpt7ElGmHpZQvfNIgPvXsJYcuAn5kkKAoDN/wzg8CZb7/
 LJN06ZgAtf0as1uAAT/VF1VdysMC4kxYgzpoQZiFuPUDFR22yrAv25NBecSP04IRoF84
 UAdYYvGF/3qwH1797kVs1Hz+odluZlAMobOgITppLpFSKOQ4cb6bOMu0JLowprf0S5EM
 a0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771604417; x=1772209217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8KSpknMexpW0Mn7JdLExXNga3okHotK6auOFJbwBKY=;
 b=w5zW3ah3TTal8S/RjsefDVnZ6bRQSFcf/Mfefy3+OyIFAf0sClliz17uY6ZBRmTDuE
 UljB0fG6xE8ekrE4CtV+G8K9ZR90l+jYg7J4IE+i+eZkinuRSIyzn+p8GcuhqGM1NtCw
 LOkqUYmgBVanI7UeG/zuyJZL9GX6tPiw1erMYXy02lAeDXmgibyUuXCUQz37HX66FQJO
 2LUQfA1hLos7a+AlKd6cE3KBk3bNHLTS4x2aIq0EJ6pfHS37lARGTqq1I2+tFBzWlsFl
 NOFouMYisiwcVKCM1mj89GOh9Rs7qDJRRFAd4wv9r+2H/CC61++x3AcIbakQblYHiH3Z
 CtSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6HxPZnE+eb0VbO00g61zriEGpOSZ2mqI2ailYZLini0y3jgkFGJ4r4paxyQ4OPy2Btr/WeqMIVdQ6@nongnu.org
X-Gm-Message-State: AOJu0YxgE+8iNJhFswFFqVZg9QGq36zVhEmkwqqpA6RZWcEBSGvh3WMg
 qPw7VlRFeAFPLw2+ny70AgkB+fWe313RiP7jt8AUbL2qnAlUhW12HeQUWzymx6m2/AEngfehBiM
 OeN+rhI8BVm1lUrw2lFod6ZyFX0ARJfsjjXvrFzkLPLQMjwFAKK0KyU2p
X-Gm-Gg: AZuq6aK8NOKD4FJhf6xGYwEMYerasuXduh6sBp6uHeQ37fPor8ZPaU1ocvE9uMEjGZ5
 kHUUx7Go4IXOZxUf1ddiJapa084PDPb1KCglRDeyMhCUFHSD2ZsDenKfxM5FVxvAcYqQ1QG4oXZ
 uSsnowzXdegkMOLQoxVrlu19CwC2dGoSju+n/fFo/MXf84SOxp0BlNO1O+SOfHJTKrvhod8Cclm
 uYgzUWNONzb54+XNnSBPwbr11I2+X6rDE8vPKD9KuDqRTPGYUMu7HL64ILDDoklN05IdCKXeLM5
 PJn8Wjgwv1mg2+4z99b/1F/UJ1FN+dbJ5refqorLcLNs7L6rVlhT87ONwHCtgg7xi8RwM1wQXn+
 DYOav3RQ0zoNnCgXhJA4aa6wVGtnYeHP0TdGZ7f1uisDKVA==
X-Received: by 2002:a05:600c:4fc7:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-483a962e0aamr642355e9.22.1771604417204; 
 Fri, 20 Feb 2026 08:20:17 -0800 (PST)
X-Received: by 2002:a05:600c:4fc7:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-483a962e0aamr641635e9.22.1771604416589; 
 Fri, 20 Feb 2026 08:20:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42cd49fsm28126325e9.5.2026.02.20.08.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:20:15 -0800 (PST)
Date: Fri, 20 Feb 2026 11:20:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 04/23] vhost: move protocol_features to vhost_user
Message-ID: <20260220111948-mutt-send-email-mst@kernel.org>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
 <20260206095258.894504-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206095258.894504-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Feb 06, 2026 at 12:52:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> As comment says: it's only for vhost-user. So, let's move it
> to corresponding vhost backend realization.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


breaks build:

https://gitlab.com/mstredhat/qemu/-/jobs/13201554836

builds/mstredhat/qemu/build/../hw/virtio/virtio-qmp.c:830:(.text+0xd60): undefined reference to `vhost_user_qmp_status'


> ---
>  backends/cryptodev-vhost.c     |  1 -
>  hw/block/vhost-user-blk.c      |  6 ++----
>  hw/net/vhost_net.c             |  2 --
>  hw/virtio/vhost-user.c         | 36 +++++++++++++++++++++++++++-------
>  hw/virtio/virtio-qmp.c         |  6 ++++--
>  include/hw/virtio/vhost-user.h |  4 ++++
>  include/hw/virtio/vhost.h      |  8 --------
>  7 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index abdfce33af..c6069f4e5b 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -60,7 +60,6 @@ cryptodev_vhost_init(
>  
>      crypto->cc = options->cc;
>  
> -    crypto->dev.protocol_features = 0;
>      crypto->backend = -1;
>  
>      /* vhost-user needs vq_index to initiate a specific queue pair */
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index dc99de0263..2831f3c053 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -572,10 +572,8 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
>  {
>      struct VHostUserBlk *s = opaque;
>  
> -    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
> -                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
> -
> -    return inflight_migration;
> +    return vhost_user_has_protocol_feature(
> +        &s->dev, VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>  }
>  
>  static const VMStateDescription vmstate_vhost_user_blk_inflight = {
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index fda90e231e..ca19983126 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -265,9 +265,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>              goto fail;
>          }
>          net->backend = r;
> -        net->dev.protocol_features = 0;
>      } else {
> -        net->dev.protocol_features = 0;
>          net->backend = -1;
>  
>          /* vhost-user needs vq_index to initiate a specific queue pair */
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2de82ac466..de8ead3e94 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/virtio-dmabuf.h"
> +#include "hw/virtio/virtio-qmp.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/virtio-crypto.h"
>  #include "hw/virtio/vhost-user.h"
> @@ -264,6 +265,14 @@ struct vhost_user {
>      /* Our current regions */
>      int num_shadow_regions;
>      struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
> +
> +    /**
> +     * @protocol_features: the vhost-user protocol feature set by
> +     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
> +     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
> +     * by the backend (see @features).
> +     */
> +    uint64_t protocol_features;
>  };
>  
>  struct scrub_regions {
> @@ -272,10 +281,13 @@ struct scrub_regions {
>      int fd_idx;
>  };
>  
> -static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
> -                                            uint64_t feature)
> +bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
>  {
> -    return virtio_has_feature(dev->protocol_features, feature);
> +    struct vhost_user *u = dev->opaque;
> +
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
> +
> +    return virtio_has_feature(u->protocol_features, feature);
>  }
>  
>  static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
> @@ -1343,8 +1355,8 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>      int ret;
>      int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num = 0;
> -    bool reply_supported = virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +    bool reply_supported =
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      VhostUserMsg msg = {
>          .hdr.request = request,
>          .hdr.flags = VHOST_USER_VERSION,
> @@ -2244,8 +2256,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>          }
>  
>          /* final set of protocol features */
> -        dev->protocol_features = protocol_features;
> -        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
> +        u->protocol_features = protocol_features;
> +        err = vhost_user_set_protocol_features(dev, u->protocol_features);
>          if (err < 0) {
>              error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
>              return -EPROTO;
> @@ -3036,6 +3048,16 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
>      return 0;
>  }
>  
> +void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
> +{
> +    struct vhost_user *u = dev->opaque;
> +
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
> +
> +    status->vhost_dev->protocol_features =
> +        qmp_decode_protocols(u->protocol_features);
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_backend_init,
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 916972e331..5e42b7b540 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -821,12 +821,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>          status->vhost_dev->acked_features =
>              qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
>  
> -        status->vhost_dev->protocol_features =
> -            qmp_decode_protocols(hdev->protocol_features);
>          status->vhost_dev->max_queues = hdev->max_queues;
>          status->vhost_dev->backend_cap = hdev->backend_cap;
>          status->vhost_dev->log_enabled = hdev->log_enabled;
>          status->vhost_dev->log_size = hdev->log_size;
> +
> +        if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {
> +            vhost_user_qmp_status(hdev, status);
> +        }
>      }
>  
>      return status;
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index 53fe996686..0e576fc538 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -10,6 +10,7 @@
>  
>  #include "chardev/char-fe.h"
>  #include "hw/virtio/virtio.h"
> +#include "qapi/qapi-types-virtio.h"
>  
>  enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ = 0,
> @@ -113,4 +114,7 @@ void vhost_user_async_close(DeviceState *d,
>                              CharFrontend *chardev, struct vhost_dev *vhost,
>                              vu_async_close_fn cb);
>  
> +void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
> +bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature);
> +
>  #endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index e139e05985..4a9bd3effe 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -104,14 +104,6 @@ struct vhost_dev {
>      VIRTIO_DECLARE_FEATURES(features);
>      VIRTIO_DECLARE_FEATURES(acked_features);
>  
> -    /**
> -     * @protocol_features: is the vhost-user only feature set by
> -     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
> -     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
> -     * by the backend (see @features).
> -     */
> -    uint64_t protocol_features;
> -
>      uint64_t max_queues;
>      uint64_t backend_cap;
>      /* @started: is the vhost device started? */
> -- 
> 2.52.0


