Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F408ECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vpO-00065L-RG; Thu, 09 Oct 2025 14:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vpN-00064c-Cz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:25 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vpK-0005uh-O7
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:24 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-9399ddb3ffeso122440539f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036241; x=1760641041; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4kgJHEVN28xN/a6mKPj/fL0ylQPiEwow6Rn/98Zmxw=;
 b=EWKLep0LcQiqkkBjraR9kfCn2+bJlbpw62vz2/FF3GJyenwJyDhmVAXgE/brpczsFK
 l3lMoXJERiM+FUBVG6EN/kZ36zfL+8k5oS/JI5B3jQefg4tZFikuRtr1Fg8JIeHbMBN5
 ESvpeQSAsGJaWOe/y7zBXlM34CEkYNA7/VeqlmA/MhmyAWHSQvUy6x8qzT90K0TJJFkS
 JU2214cw1ZcykJNU9AQ5zzo0XmS8dNO6Ayy/C/sI+ZHGRTLzyNTKUyW4bJdUmEesJlrO
 MHrKv2MnVjJboeXcKodUDp7wiwxBI41zr7h4OanidpXznjT5+1YM3RSSGAbEgvUpyL3e
 0eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036241; x=1760641041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4kgJHEVN28xN/a6mKPj/fL0ylQPiEwow6Rn/98Zmxw=;
 b=TAYvO6yqUkustNzS/htrxaw68tXFToQXFKLTNg3fvKepfhp7UriPCeejYIlBmiN54a
 T7gyqD+mM2FObJkM6EvKqKW4SPqX4+n3i8gz8DhzNNaGQwnKkqKsXc+Y0jX3y+KuZ+bk
 KGQit2YMv3BUdA9skcU7tYliIEm0fup4l9grVi1gcZ2oNJJ6LqAp0IGjm3vnaHwRd/jT
 7c3hUkFmyaE02TZzTaWCg5rDOI9APTcDUUwbk0/xyNB5WbcDtoE3g/a22LEH+z5Vxp0c
 oVZGlOQgxivP/LfB9K0xmQpqrFgZZkj8DyWqSKaBp+o2qinWpkN/WOWN5NEIumWkeYnc
 u/sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ULZtN+vZEUzHC5erhSb2HD3cWSaF4tGmytrLYhodVSliy5SxpGczSs4SmtMxL9Q9QhhvG+P1DYxY@nongnu.org
X-Gm-Message-State: AOJu0YwfKG70a/9GR+z2GVZideEkvNGeZ8Rlzi4xC5CZHay1asjVUnjR
 CG5lcHaEPaeurWrkCdm4x8yZxqhaDCUCnoc06U7QHKqoNEtZsdswm1HXCKXGdelTPY91+Fnf1YC
 i2C1MIF5gECHVgFta6g4UwPc0sefhscg=
X-Gm-Gg: ASbGncurQhK83zSIOp9eCFV+aWXBjssO7VotuVl2HzfgchP7rv+Z6LIWeRR05z/Rx5G
 vhWH8kelJvtKqF3//XodRMieqs5jfMO3HWdcwicTkYomBO8aYacIj2nVciU4AXYaCgsJW/165l7
 ZS6jj/36b8pxN7uRHoURllxOAO7WhiKy1e75fJ1PD/HBl97uWI+luWkpQGw2c3U+ReOOFUnoInG
 ALBsMll2Sj8lty27wstqbfAw1fhLxbd5wLHKd6juw==
X-Google-Smtp-Source: AGHT+IHXOVmEntpJDf2aMnbBhRu+4YhhlGPcVbxanoPkv1Rtsa0aAPPYO+ho6XULGPA/2vcb1/Ri81Yf+hT/77ZSA4Q=
X-Received: by 2002:a05:6e02:19ca:b0:42d:8b1c:5740 with SMTP id
 e9e14a558f8ab-42f87346594mr73368695ab.5.1760036240902; Thu, 09 Oct 2025
 11:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-3-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-3-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:57:09 -0400
X-Gm-Features: AS18NWBeW4SB9WwD-RD3OKGb4u_2BwC1j1ZgpCOYvd9PIV5nh5OqPUiT_wXWn_k
Message-ID: <CAFubqFv181ds4PWE3SNfHV_C7T76_=xJzSkNOowx+_Fe9_uy3A@mail.gmail.com>
Subject: Re: [PATCH 02/33] vhost: drop backend_features field
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 1:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.
>
> The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
> and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
> vhoust-user-net). But we can simply recalculte these two flags inplace
> from hdev->features, and from net-client for
> VHOST_NET_F_VIRTIO_NET_HDR.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c   |  1 -
>  hw/net/vhost_net.c          | 16 ++++++++--------
>  hw/scsi/vhost-scsi.c        |  1 -
>  hw/scsi/vhost-user-scsi.c   |  1 -
>  hw/virtio/vdpa-dev.c        |  1 -
>  hw/virtio/vhost-user.c      | 19 +++++++++----------
>  hw/virtio/virtio-hmp-cmds.c |  2 --
>  hw/virtio/virtio-qmp.c      |  2 --
>  include/hw/virtio/vhost.h   |  7 -------
>  qapi/virtio.json            |  3 ---
>  10 files changed, 17 insertions(+), 36 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index c0cc5f6942..de7a810c93 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -348,7 +348,6 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      s->dev.nvqs =3D s->num_queues;
>      s->dev.vqs =3D s->vhost_vqs;
>      s->dev.vq_index =3D 0;
> -    s->dev.backend_features =3D 0;
>
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 540492b37d..fcee279f0b 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -53,7 +53,10 @@ int vhost_net_set_config(struct vhost_net *net, const =
uint8_t *data,
>
>  void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
>  {
> -    net->dev.acked_features =3D net->dev.backend_features;
> +    net->dev.acked_features =3D
> +        (qemu_has_vnet_hdr(net->nc) ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NE=
T_HDR))
> +         | (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES)=
);
> +
>      vhost_ack_features(&net->dev, net->feature_bits, features);
>  }
>
> @@ -256,12 +259,9 @@ struct vhost_net *vhost_net_init(VhostNetOptions *op=
tions)
>          if (r < 0) {
>              goto fail;
>          }
> -        net->dev.backend_features =3D qemu_has_vnet_hdr(options->net_bac=
kend)
> -            ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
>          net->backend =3D r;
>          net->dev.protocol_features =3D 0;
>      } else {
> -        net->dev.backend_features =3D 0;
>          net->dev.protocol_features =3D 0;
>          net->backend =3D -1;
>
> @@ -281,10 +281,10 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>                                 sizeof(struct virtio_net_hdr_mrg_rxbuf)))=
 {
>              net->dev.features &=3D ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
>          }
> -        if (~net->dev.features & net->dev.backend_features) {
> -            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
> -                   " for backend\n",
> -                   (uint64_t)(~net->dev.features & net->dev.backend_feat=
ures));
> +        if (!qemu_has_vnet_hdr(options->net_backend) &&
> +            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR)))=
 {
> +            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend=
\n",
> +                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET=
_HDR));
>              goto fail;
>          }
>      }
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index cdf405b0f8..d694a25fe2 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -276,7 +276,6 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
>      vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
>      vsc->dev.vqs =3D vqs;
>      vsc->dev.vq_index =3D 0;
> -    vsc->dev.backend_features =3D 0;
>
>      ret =3D vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
>                           VHOST_BACKEND_TYPE_KERNEL, 0, errp);
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 25f2d894e7..0c80a271d8 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -159,7 +159,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, =
Error **errp)
>      vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
>      vsc->dev.vqs =3D s->vhost_vqs;
>      vsc->dev.vq_index =3D 0;
> -    vsc->dev.backend_features =3D 0;
>
>      ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE=
_USER, 0,
>                           errp);
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index d1da40afc8..3c0eed3e8e 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -104,7 +104,6 @@ static void vhost_vdpa_device_realize(DeviceState *de=
v, Error **errp)
>      v->dev.vqs =3D vqs;
>      v->dev.vq_index =3D 0;
>      v->dev.vq_index_end =3D v->dev.nvqs;
> -    v->dev.backend_features =3D 0;
>      v->started =3D false;
>
>      ret =3D vhost_vdpa_get_iova_range(v->vhostfd, &iova_range);
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1b2879a90c..cf6f53801d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1232,7 +1232,7 @@ static int vhost_user_set_vring_base(struct vhost_d=
ev *dev,
>
>  static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
>  {
> -    return virtio_has_feature(dev->backend_features,
> +    return virtio_has_feature(dev->features,
>                                VHOST_USER_F_PROTOCOL_FEATURES);
>  }
>
> @@ -1449,14 +1449,15 @@ static int vhost_user_set_features(struct vhost_d=
ev *dev,
>      int ret;
>
>      /*
> -     * We need to include any extra backend only feature bits that
> -     * might be needed by our device. Currently this includes the
> -     * VHOST_USER_F_PROTOCOL_FEATURES bit for enabling protocol
> -     * features.
> +     * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
> +     * specific.
>       */
> -    ret =3D vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES,
> -                              features | dev->backend_features,
> -                              log_enabled);
> +    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES=
)) {
> +        features |=3D 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
> +    }
> +
> +    ret =3D vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
> +                             log_enabled);
>
>      if (virtio_has_feature(dev->protocol_features,
>                             VHOST_USER_PROTOCOL_F_STATUS)) {
> @@ -2187,8 +2188,6 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>              (dev->config_ops && dev->config_ops->vhost_dev_config_notifi=
er);
>          uint64_t protocol_features;
>
> -        dev->backend_features |=3D 1ULL << VHOST_USER_F_PROTOCOL_FEATURE=
S;
> -
>          err =3D vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES=
,
>                                   &protocol_features);
>          if (err < 0) {
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 7d8677bcf0..024904915d 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -175,8 +175,6 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdi=
ct)
>          hmp_virtio_dump_features(mon, s->vhost_dev->features);
>          monitor_printf(mon, "    Acked features:\n");
>          hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> -        monitor_printf(mon, "    Backend features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
>          monitor_printf(mon, "    Protocol features:\n");
>          hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
>      }
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 3b6377cf0d..e514a4797e 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -788,8 +788,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *p=
ath, Error **errp)
>              qmp_decode_features(vdev->device_id, hdev->features);
>          status->vhost_dev->acked_features =3D
>              qmp_decode_features(vdev->device_id, hdev->acked_features);
> -        status->vhost_dev->backend_features =3D
> -            qmp_decode_features(vdev->device_id, hdev->backend_features)=
;
>          status->vhost_dev->protocol_features =3D
>              qmp_decode_protocols(hdev->protocol_features);
>          status->vhost_dev->max_queues =3D hdev->max_queues;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 66be6afc88..9f9dd2d46d 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -100,16 +100,9 @@ struct vhost_dev {
>       *
>       * @features: available features provided by the backend
>       * @acked_features: final negotiated features with front-end driver
> -     *
> -     * @backend_features: this is used in a couple of places to either
> -     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
> -     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
> -     * future use should be discouraged and the variable retired as
> -     * its easy to confuse with the VirtIO backend_features.
>       */
>      uint64_t features;
>      uint64_t acked_features;
> -    uint64_t backend_features;
>
>      /**
>       * @protocol_features: is the vhost-user only feature set by
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..0aae77340d 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -85,8 +85,6 @@
>  #
>  # @acked-features: vhost_dev acked_features
>  #
> -# @backend-features: vhost_dev backend_features
> -#
>  # @protocol-features: vhost_dev protocol_features
>  #
>  # @max-queues: vhost_dev max_queues
> @@ -106,7 +104,6 @@
>              'vq-index': 'int',
>              'features': 'VirtioDeviceFeatures',
>              'acked-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
>              'protocol-features': 'VhostDeviceProtocols',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',
> --
> 2.48.1
>
>

