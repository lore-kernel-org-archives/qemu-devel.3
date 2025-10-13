Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E5CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 18:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Nfm-00082U-5m; Mon, 13 Oct 2025 14:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Nfh-000825-V1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:53:26 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Nff-0007GQ-Tk
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:53:25 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-93b9022d037so182711939f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760381602; x=1760986402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SZKTc5H9XlGxWTcwZ7jv9QcqClCq0Jj9u1/0RIhpwY=;
 b=LHu30093RNyIUyAkzrPhGGmy1kMQsF06XvmpU8nZVEHSJTRzKCwlxYvDNoBokoXTFF
 l3ejm7PsTHCBXpIm5DkH8MNptcbbyQHBIT+TvQFZ2UJ2rtG76HnbmxgciAjWX751snCS
 DyUsI6k1IP/GcUZsexye6GNSediTuh8OVtRwjLWp08zC9g0VR0/0moN36SOqVrpDNk8x
 ip6ecbIOlqsh1GG6WQvPAo6DNyzzqokhZLBfBbtqDzAgiEcmPLxk3Uy2YtlxrnYxIf8H
 /FpC/xlRj9ZMfHaVGoZ2YLfUWOE9OsSzNUGOhWGDt2F9YA2ssnr5GZS88zxNWX+Spyza
 JaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760381602; x=1760986402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SZKTc5H9XlGxWTcwZ7jv9QcqClCq0Jj9u1/0RIhpwY=;
 b=a6xe8+M7WqrM1pDKLSm6llXVLhnh01Bz4I2G3XueKvLln6XpEO0XnURNvYGi0cofVY
 PVm4xoTKx8l+72nKfpTMzHLJUCuoXgETq//bqu4NNh7fG9zDd+n+6ir1XiJ3gPXS9PLO
 xvaNzrKrFLUV7jKResvbDoEsqhKlfUFUmfWwnfhAO320W6IyiPbIrdj75bs7+SBBzdmU
 xZiRTk5DEq+/M6ABf7iHnXWj+HZ/PhTAJnC2a0cCByto3X70JHvlR6n3necptRwt1N8t
 yAxpVApAPs2riCAHjb1pvaqf2Zzco+RbGgFQwdIbdRo/kfRTZNs6AM3tQoCP7glxdRms
 D/4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe3MgV0JmML+xka2qkzxf6V0QidRQr7uo8He1UQG/lpo9g+n2LKIkuadIr2SgDbJC1swqIW89D/RUV@nongnu.org
X-Gm-Message-State: AOJu0YyUWAM6jl7aZ6qEcTptQ2AtpZSFRkWqN9swF44HiOEU++K3wcbd
 it4LKVkdFGykZHTB4vKl0PR27aQTkwjTKf9H9uBz2Mip5wcN/EzXODGF2zeJo7rSj7cZK1QKe4h
 ganIA8XOos5sgg3XSwvMsb/mL3arfAaGvO1942OM=
X-Gm-Gg: ASbGncvOeImaPAj2P5RsPmc/y6n8irNo6EZtCC3/hEm3lLRVVNSEkBt8EgtkqI62Jkt
 el65m5CXR8E9d6z8OU6aCqLJcDxXD41/46Wmtf60yHGcCW9avWOs91AHs8YEWLGm2szxsUjIJNT
 twemeOilqqjLcd9gm6tUguN8gym8DbyYodkHB3XNOm69en+3jEUWK0qMPX2CAvDEQtaIzWsyHS1
 gdxY3ddKgL+C9Q+94DiW7B8I9j5n+K2FRnW
X-Google-Smtp-Source: AGHT+IH+Cerpcw1lS4BEiv/1+mC5IsQq5LtP89/G608ScWgg3Go23sArlPw1EARL4CruxTqSn7ls49fLBYY2q2pNZ+Y=
X-Received: by 2002:a05:6e02:318f:b0:42f:a7ee:4922 with SMTP id
 e9e14a558f8ab-42fa7ee5093mr109800985ab.16.1760381602518; Mon, 13 Oct 2025
 11:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-5-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-5-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 14:53:11 -0400
X-Gm-Features: AS18NWCYW-3K_2GpkkJCzBpsFwkrF0dExKI2aD8g_NtWxyrn6sB-sWxnDXmqz8M
Message-ID: <CAFubqFvJJZ+KU5nx=r4TjZ4P17B8jXpxWD1LYk-Z9opVGAr6sg@mail.gmail.com>
Subject: Re: [PATCH v2 04/23] vhost: move protocol_features to vhost_user
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> As comment says: it's only for vhost-user. So, let's move it
> to corresponding vhost backend realization.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c     |  1 -
>  hw/net/vhost_net.c             |  2 --
>  hw/virtio/vhost-user.c         | 26 +++++++++++++++++++++++---
>  hw/virtio/virtio-qmp.c         |  6 ++++--
>  include/hw/virtio/vhost-user.h |  3 +++
>  include/hw/virtio/vhost.h      |  8 --------
>  6 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index abdfce33af..c6069f4e5b 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -60,7 +60,6 @@ cryptodev_vhost_init(
>
>      crypto->cc =3D options->cc;
>
> -    crypto->dev.protocol_features =3D 0;
>      crypto->backend =3D -1;
>
>      /* vhost-user needs vq_index to initiate a specific queue pair */
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index fda90e231e..ca19983126 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -265,9 +265,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *opt=
ions)
>              goto fail;
>          }
>          net->backend =3D r;
> -        net->dev.protocol_features =3D 0;
>      } else {
> -        net->dev.protocol_features =3D 0;
>          net->backend =3D -1;
>
>          /* vhost-user needs vq_index to initiate a specific queue pair *=
/
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b8231dcbcf..3fd11a3b57 100644
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
> @@ -275,7 +284,8 @@ struct scrub_regions {
>  static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
>                                              uint64_t feature)
>  {
> -    return virtio_has_feature(dev->protocol_features, feature);
> +    struct vhost_user *u =3D dev->opaque;
> +    return virtio_has_feature(u->protocol_features, feature);
>  }
>
>  static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *m=
sg)
> @@ -2229,8 +2239,8 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>          }
>
>          /* final set of protocol features */
> -        dev->protocol_features =3D protocol_features;
> -        err =3D vhost_user_set_protocol_features(dev, dev->protocol_feat=
ures);
> +        u->protocol_features =3D protocol_features;
> +        err =3D vhost_user_set_protocol_features(dev, u->protocol_featur=
es);
>          if (err < 0) {
>              error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
>              return -EPROTO;
> @@ -3021,6 +3031,16 @@ static int vhost_user_check_device_state(struct vh=
ost_dev *dev, Error **errp)
>      return 0;
>  }
>
> +void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
> +
> +    status->vhost_dev->protocol_features =3D
> +        qmp_decode_protocols(u->protocol_features);
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index dd1a38e792..82acb6d232 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -821,12 +821,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char =
*path, Error **errp)
>          status->vhost_dev->acked_features =3D
>              qmp_decode_features(vdev->device_id, hdev->acked_features_ex=
);
>
> -        status->vhost_dev->protocol_features =3D
> -            qmp_decode_protocols(hdev->protocol_features);
>          status->vhost_dev->max_queues =3D hdev->max_queues;
>          status->vhost_dev->backend_cap =3D hdev->backend_cap;
>          status->vhost_dev->log_enabled =3D hdev->log_enabled;
>          status->vhost_dev->log_size =3D hdev->log_size;
> +
> +        if (hdev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER=
) {
> +            vhost_user_qmp_status(hdev, status);
> +        }
>      }
>
>      return status;
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 9a3f238b43..36d96296a3 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -10,6 +10,7 @@
>
>  #include "chardev/char-fe.h"
>  #include "hw/virtio/virtio.h"
> +#include "qapi/qapi-types-virtio.h"
>
>  enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ =3D 0,
> @@ -111,4 +112,6 @@ void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhos=
t,
>                              vu_async_close_fn cb);
>
> +void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
> +
>  #endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 3e69e47833..e308bc4556 100644
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
> 2.48.1
>

