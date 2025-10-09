Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E382ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vqF-0006kJ-Gx; Thu, 09 Oct 2025 14:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vq5-0006eV-SK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:09 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vq2-00068J-T7
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:09 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-424da17e309so13285705ab.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036285; x=1760641085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7I9b0fN84UmIfYuhJOvvL9xt4SLepjHkKxYWpxymlTA=;
 b=AnPYQ3UqVTB5YJRdhf1L5BwaHG0tBlI2ZKzbteZu+yKk3rDxN6YEToT9N1IqoZfgvA
 mpna9Brwlago5vUPTkpOw7V4GIrxp82tyHpyQvk+hgIk7DLLwjYinmg/ZJ2fWXNf2IHI
 eMwhsFGyO1+LMAhFZxh9B49tDYnYMkIS1XuC/0GT0Oo5AA0ITxUiTAEMfBdIkzo+kDwP
 tdB4pkKYkVuOxcNwSGVGPIqDOkSlnlpr6ZdUgDEPR1S7xxtZTItB79wxhXrrMP7fuT9K
 n3Hjaqq4SEG2CqZOtPSPGyPFPV7I74ZI7QyE/jNOSuCXxrhKsx5ORPQ6o6meYHFyjU/E
 JXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036285; x=1760641085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7I9b0fN84UmIfYuhJOvvL9xt4SLepjHkKxYWpxymlTA=;
 b=po65xRsqjUbs3k9akhjbFrJJKBiK0Rm30sL1JkmjC6MGSk+rVQ+PxV2rq4/LmOgEFJ
 CMpnFe1yiX0cHZF5TmKaniqK22shPm36t3LUqQxXjKA0x1Wsvtv4LVYJeGQd9uMyOBiE
 iJGmfSYdEKl8jidzviklpREZoIL80DQcmsYKO9R1kOfZMfOQMOyEgpLyuhBcFpEulSsW
 BRycflvVRa255NctQbY7UHYHGdPsvS99VuuLxOB7nsdRciW1WOKRHF9aAFQUYj25k21y
 RbKTcDWuFWdS8iwqSq89sQWTVZ34P4LRzcYGYY0rQXsShSa2jJFTIGJ/Fk8X4gvjNmzD
 rA5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcCH758Wpo6XA9jraNDf3qGMmZ/8l0ZcRua5KCkKsrr1LjIYaZPtV0QD2HZg7noL9kEaBpw+kbEe7@nongnu.org
X-Gm-Message-State: AOJu0YwgmvxE7qHkJg1l8nA1swccIc8U64j2V9sgqKvv4bFs891MSIJs
 f0wHe8wyN2IMK7K1NzjxmivVAzdTH4R2GInewG7IIwtQKt3/FC/gC0NRJjsw+lgWg+qyva/DBPi
 2MAMgfx6LIxmATV25OEVLxlrnopcod8w=
X-Gm-Gg: ASbGncui0w4BpTdSn/9YCwlk2Y5f358KYQMw+tHbHUHqkO62SgPyOon67A8nJE/Ur2H
 8yNKku+ceqvj5IlAffFyPnx6dDkw6ClWaWXHUCfkNnjqfkTExlswQ2yPZgPc1867yn1hXiytvYn
 mghUKgjH+Z/KWGXhl3ZiNzrBEiZLVwhgOIQpbJhHtX7Q0901wM3jNU+VOf1p0xx6JFaKx8G7l/q
 3cL63G/bNB7K1l+TeQWR04KEDi/v/ZvRrurisZwHQ==
X-Google-Smtp-Source: AGHT+IHvJuDe/eLMzXKnYPiaVrsUnvocPq80SB50+YpUy4cUIPKnkskjUb6hH+gNcvKLSnmcy3YAobMky5vjpOtEcxk=
X-Received: by 2002:a92:cda6:0:b0:427:c8d1:bea5 with SMTP id
 e9e14a558f8ab-42f873bed54mr78078455ab.21.1760036284666; Thu, 09 Oct 2025
 11:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-5-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-5-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:57:53 -0400
X-Gm-Features: AS18NWCF6Y0r9ADOAaf3xjZUqPg09aSXJdRHsjHibCral3T6mw6vXKtTgL-r5K4
Message-ID: <CAFubqFvSkXDgpttJLz8dtCtsbWLqfS2BRWP=UZxF81st5_Qn_g@mail.gmail.com>
Subject: Re: [PATCH 04/33] vhost: move protocol_features to vhost_user
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x134.google.com
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

On Wed, Aug 13, 2025 at 12:57=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> As comment says: it's only for vhost-user. So, let's move it
> to corresponding vhost backend realization.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c        |  1 -
>  hw/net/vhost_net.c                |  2 --
>  hw/virtio/vhost-user.c            | 23 ++++++++++++++++++++---
>  hw/virtio/virtio-qmp.c            |  6 ++++--
>  include/hw/virtio/vhost-backend.h |  3 +++
>  include/hw/virtio/vhost.h         |  8 --------
>  6 files changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 943680a23a..3bcdc494d8 100644
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
> index fcee279f0b..ce30b6e197 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -260,9 +260,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *opt=
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
> index 6fa5b8a8bd..abdf47ee7b 100644
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
> @@ -274,7 +283,8 @@ struct scrub_regions {
>
>  static bool vhost_user_has_prot(struct vhost_dev *dev, uint64_t feature)
>  {
> -    return virtio_has_feature(dev->protocol_features, feature);
> +    struct vhost_user *u =3D dev->opaque;
> +    return virtio_has_feature(u->protocol_features, feature);
>  }
>
>  static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *m=
sg)
> @@ -2218,8 +2228,8 @@ static int vhost_user_backend_init(struct vhost_dev=
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
> @@ -3001,6 +3011,12 @@ static int vhost_user_check_device_state(struct vh=
ost_dev *dev, Error **errp)
>      return 0;
>  }
>
> +static void vhost_user_qmp_status(struct vhost_dev *dev, VhostStatus *st=
atus)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    status->protocol_features =3D qmp_decode_protocols(u->protocol_featu=
res);
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> @@ -3041,4 +3057,5 @@ const VhostOps user_ops =3D {
>          .vhost_supports_device_state =3D vhost_user_supports_device_stat=
e,
>          .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
>          .vhost_check_device_state =3D vhost_user_check_device_state,
> +        .vhost_qmp_status =3D vhost_user_qmp_status,
>  };
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index e514a4797e..d55b12f9f3 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -788,12 +788,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char =
*path, Error **errp)
>              qmp_decode_features(vdev->device_id, hdev->features);
>          status->vhost_dev->acked_features =3D
>              qmp_decode_features(vdev->device_id, hdev->acked_features);
> -        status->vhost_dev->protocol_features =3D
> -            qmp_decode_protocols(hdev->protocol_features);
>          status->vhost_dev->max_queues =3D hdev->max_queues;
>          status->vhost_dev->backend_cap =3D hdev->backend_cap;
>          status->vhost_dev->log_enabled =3D hdev->log_enabled;
>          status->vhost_dev->log_size =3D hdev->log_size;
> +
> +        if (hdev->vhost_ops->vhost_qmp_status) {
> +            hdev->vhost_ops->vhost_qmp_status(hdev, status->vhost_dev);
> +        }

Same comment as patch 1/33 - why have it in vhost_ops if it is
vhost_user specific, rather than checking the backend type and calling
a helper?


>      }
>
>      return status;
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index f65fa26298..0785fc764d 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -12,6 +12,7 @@
>  #define VHOST_BACKEND_H
>
>  #include "system/memory.h"
> +#include "qapi/qapi-commands-virtio.h"
>
>  typedef enum VhostBackendType {
>      VHOST_BACKEND_TYPE_NONE =3D 0,
> @@ -160,6 +161,7 @@ typedef int (*vhost_set_device_state_fd_op)(struct vh=
ost_dev *dev,
>                                              int *reply_fd,
>                                              Error **errp);
>  typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error =
**errp);
> +typedef void (*vhost_qmp_status_op)(struct vhost_dev *dev, VhostStatus *=
status);
>
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -216,6 +218,7 @@ typedef struct VhostOps {
>      vhost_supports_device_state_op vhost_supports_device_state;
>      vhost_set_device_state_fd_op vhost_set_device_state_fd;
>      vhost_check_device_state_op vhost_check_device_state;
> +    vhost_qmp_status_op vhost_qmp_status;
>  } VhostOps;
>
>  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 9f9dd2d46d..15bc287a9d 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -104,14 +104,6 @@ struct vhost_dev {
>      uint64_t features;
>      uint64_t acked_features;
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
>

