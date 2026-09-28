Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830ACC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBi6-0001EQ-3Q; Mon, 28 Sep 2026 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1xBBhy-0001A8-UB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:47:56 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1xBBhw-0001kv-L1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:47:54 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99cd5115bso5092867a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603270; cv=none;
 d=google.com; s=arc-20260327;
 b=sU3/7JknWmBIfNJO/9zMzBeQgS6VEhtSZV2cLH165U/AazqIOiEbf1jEBkiKPglX3i
 VHN7aef8XoZJxysKqjHbyZnlXyj7KuDMPhIfRlcPMDjqApBVB4CZEhGYVfzaoo9O2zJM
 N863etWUmk0Wrr5evYrsMWe4TRlXku43BU1W+qPGiLnw+bwNKHlnWqQHDs/gF5XF/7hT
 aiimN8bbVe93uhnfWUTUg0vpGoq1TQyR2sCwSUHoKHFqQnkjFCNFL0VT4bT5zOledh9G
 cuxtM0/tz0x9vM+XY8k+dKU10A10mouEXBzRj3z/c02SFPJZUm5CGjrVwxB36Q+UMRRZ
 dfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=90TS4/HohSKsclD3ZOBgHeLX3Hm2WU4o4xP+PIiuVu4=;
 fh=ktf6Nh0mtAO/Hm67YzfrEaqGSC/t8ysW0OowjWZSxZU=;
 b=VtSbqkELCuSqBRrFSCUGC0bPsjsRI+92fCgGl0Pwc7T26jA4WGJGXnhdFFpHlUwJv1
 +ggfwYleiDm5nGt1i6ErToEaotFvYmtsddX+3ZLJO6U4HvDx0o74GyfMuf1SPcYv0y65
 49nLcjGxgXxi7U+USu1nQH/pHk/3qToZ65j+Hlm8e7eU5t7XRyuCQ1nA30CkOgNICsji
 zEHseI+8Rk/Xm2aKc5COtBfBHlUej8yrFdIj02i46LCStrpLpIyxshetSW6y1EJQ36HL
 Zm8FcAONom67LzcQnV8b3ETnC5DXg0kkw8667h1KK962SkAfVnmqBefoSnT5VUR4N6Oj
 Zsgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1790603270; x=1791208070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=90TS4/HohSKsclD3ZOBgHeLX3Hm2WU4o4xP+PIiuVu4=;
 b=QzWw1sWK7zgA0RLnO154wT6jOEU/XDFb8vYbmUiomQ6gD3JeJDZuXOC8M29KYy7y7A
 6ZDowB80nciEGFVeo8dmG4CpA3Wg2RQyeXeekk4Jb+Eija2wkErOl0CsXFbv3lhbYAou
 H/RLCT7gyV6TlwNLfvidLKdkulJ1U+Q1AZKcCIPZsk3DvkUkv6Wwqt2+moxCS/ObweAt
 r94V9UWxutrYKPiwPM5FIS/c16GoPY9Qo4v9VHd/5OzSin/2y52lZeSgebuxozyYYt/S
 bq+JYu6gF/DIwLdrXNYPI4DRuUtt1MlIGINKbOIRX1UUm+eXvXjWkpZXR8MdKmI6wCxH
 6jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790603270; x=1791208070;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=90TS4/HohSKsclD3ZOBgHeLX3Hm2WU4o4xP+PIiuVu4=;
 b=ETUotdUdBROkeh6LEz0UsZW8s/aqKE4/gPAsK7iCHku2xjS4T5KEYxNl4rwf01EFjG
 yJXjiOFKjjrmx3Oxmpt+Ap+PglcOZPWTmUu7pSNONCvWXRx+ZqHadgyrEBLHi3c4udLu
 g7z1bm8GgR85cvat9F9Nq9oVA7oGRBkvgwGBrJq/IXILNyQAsFT7KISxrRqEhsIPuwwz
 sU7ArrICQzkrdaLtoSNoOXpWOe6GMm/4d6bVI68JssM11U0qLdW33QJo5KdisZWdX3Mb
 nf0bf7grtPEM7S3TYk7pQ9ZPHuWAoa6YvIJRLl3n5RUWrn/sn9xWUzj+5WG4bPqai6xb
 4PYg==
X-Gm-Message-State: AFq9FYJAfGKug3/lbuD8F8eAiVXxF+D5X0zYw8czvW8GzyARxft8DvhO
 j7Dl4lmZl2g70BvfHzhmS3lmSoPKitfQJQP/Ob0mMS6VvcRRuYnY9wRm1vPbndz2bDwfoaZJ1Eg
 2hQ7JNpHbNxsUiETpGpGuu68Mm/3GZtYB9cXaLApR
X-Gm-Gg: AYBFou3VPjNGROLZpLYHNAC/Td0rHDpTtJn73Dj/p3GkvQbaJnyeHzW3QhxD+2amsB1
 tKW9E5/AuQpLPS6wRMfQOJwPnWxtUklAjWedTO7PQpKtAbVa3qGSK2fUP+a3AC07OiYgMO/dPsv
 hTOLQRmpK0/jDOZybfcTyd2dzEr1aAjJYzaAC7G8EMCBoWD+CDihcA44Yei8aAUK8JCe/ZmXWs0
 PoRBHtknOPf0ciKvgg3ImmXsHeiG8OW6BrKZMsM1UDAWaZIDvqce5IPX5RRLllKJAlPt1gX6oGw
 phxWZ+i74YM+O/Swci8d0D4SZs1ae/SDfaQqnLxSFVkI4A3gLCRndJA=
X-Received: by 2002:a05:6402:4588:b0:6aa:13c1:2c88 with SMTP id
 4fb4d7f45d1cf-6aae8f7690cmr7002818a12.44.1790603270201; Mon, 28 Sep 2026
 06:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260803072853.2920007-1-dtalexundeer@yandex-team.ru>
 <20260803072853.2920007-2-dtalexundeer@yandex-team.ru>
In-Reply-To: <20260803072853.2920007-2-dtalexundeer@yandex-team.ru>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 28 Sep 2026 15:47:39 +0200
X-Gm-Features: AclHuK_6mZnFAdrL08_eUQ1NOgUZoTHvSagXzvzVgNbWK2CHJ9nVrFDbnTdFXBk
Message-ID: <CAJ307Eg_8167wGsjDnGoy08tnCe9SVwP9XSHwRSvFa7nCd4rYw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] vhost-user: add skip_drain param to
 do_vhost_virtqueue_stop
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Jason Wang <jasowangio@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>, virtio-fs@lists.linux.dev, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=chigot@adacore.com; helo=mail-ed2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 3, 2026 at 9:30=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> Currently do_vhost_virtqueue_stop always sends GET_VRING_BASE to the
> back-end, which requires the back-end to drain all in-flight I/O before
> stopping the vring.
>
> Add a skip_drain parameter to do_vhost_virtqueue_stop and propagate it
> up through vhost_virtqueue_stop, vhost_dev_stop and their callers.
> The parameter will be used in a follow-up commit to send a new protocol
> message that instructs the back-end to suspend in-flight I/O immediately
> instead of draining it.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c     |  2 +-
>  backends/vhost-user.c          |  2 +-
>  hw/block/vhost-user-blk.c      |  2 +-
>  hw/net/vhost_net.c             |  9 +++++----
>  hw/scsi/vhost-scsi-common.c    |  2 +-
>  hw/virtio/vdpa-dev.c           |  2 +-
>  hw/virtio/vhost-user-base.c    |  2 +-
>  hw/virtio/vhost-user-fs.c      |  2 +-
>  hw/virtio/vhost-user-scmi.c    |  2 +-
>  hw/virtio/vhost-vsock-common.c |  2 +-
>  hw/virtio/vhost.c              | 28 +++++++++++++++++++---------
>  include/hw/virtio/vhost.h      |  7 +++++--
>  12 files changed, 38 insertions(+), 24 deletions(-)
>
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index c6069f4e5b..f1ca6bcd4e 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -109,7 +109,7 @@ static void
>  cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
>                                   VirtIODevice *dev)
>  {
> -    vhost_dev_stop(&crypto->dev, dev, false);
> +    vhost_dev_stop(&crypto->dev, dev, false, false);
>      vhost_dev_disable_notifiers(&crypto->dev, dev);
>  }
>
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index 380d825023..0423c2d4ec 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -108,7 +108,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(&b->dev, b->vdev, true);
> +    ret =3D vhost_dev_stop(&b->dev, b->vdev, true, false);
>
>      if (k->set_guest_notifiers &&
>          (err =3D k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false=
)) < 0) {
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index b2e46eb3f9..e3b873af7c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -232,7 +232,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>                   qemu_force_shutdown_requested();
>
>      ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
> -                       vhost_dev_stop(&s->dev, vdev, true);
> +                       vhost_dev_stop(&s->dev, vdev, true, false);
>
>      err =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>      if (err < 0) {
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 323d117735..6e05c995f1 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -384,7 +384,7 @@ fail:
>      if (net->nc->info->poll) {
>          net->nc->info->poll(net->nc, true);
>      }
> -    vhost_dev_stop(&net->dev, dev, false);
> +    vhost_dev_stop(&net->dev, dev, false, false);
>  fail_start:
>      return r;
>  }
> @@ -403,7 +403,7 @@ static void vhost_net_stop_one(struct vhost_net *net,
>      if (net->nc->info->poll) {
>          net->nc->info->poll(net->nc, true);
>      }
> -    vhost_dev_stop(&net->dev, dev, false);
> +    vhost_dev_stop(&net->dev, dev, false, false);
>      if (net->nc->info->stop) {
>          net->nc->info->stop(net->nc);
>      }
> @@ -636,7 +636,8 @@ void vhost_net_virtqueue_reset(VirtIODevice *vdev, Ne=
tClientState *nc,
>      vhost_virtqueue_stop(&net->dev,
>                           vdev,
>                           net->dev.vqs + idx,
> -                         net->dev.vq_index + idx);
> +                         net->dev.vq_index + idx,
> +                         false);
>  }
>
>  int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
> @@ -686,7 +687,7 @@ err_start:
>          assert(ret >=3D 0);
>      }
>
> -    vhost_dev_stop(&net->dev, vdev, false);
> +    vhost_dev_stop(&net->dev, vdev, false, false);
>
>      return r;
>  }
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index e19800a0bc..e546a6dc75 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -108,7 +108,7 @@ int vhost_scsi_common_stop(VHostSCSICommon *vsc)
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret =3D 0;
>
> -    ret =3D vhost_dev_stop(&vsc->dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vsc->dev, vdev, true, false);
>
>      if (k->set_guest_notifiers) {
>          int r =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, fa=
lse);
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 94188d37bb..b86d0b664a 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -300,7 +300,7 @@ static void vhost_vdpa_device_stop(VirtIODevice *vdev=
)
>          return;
>      }
>
> -    vhost_dev_stop(&s->dev, vdev, false);
> +    vhost_dev_stop(&s->dev, vdev, false, false);
>
>      ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>      if (ret < 0) {
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 39b5e637fc..abeae1a064 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -78,7 +78,7 @@ static int vub_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(&vub->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vub->vhost_dev, vdev, true, false);
>
>      err =3D k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, fa=
lse);
>      if (err < 0) {
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 209993918a..0d8842817a 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -111,7 +111,7 @@ static int vuf_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(&fs->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&fs->vhost_dev, vdev, true, false);
>
>      err =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, fal=
se);
>      if (err < 0) {
> diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
> index 9470f68c1f..9fa65d7d8b 100644
> --- a/hw/virtio/vhost-user-scmi.c
> +++ b/hw/virtio/vhost-user-scmi.c
> @@ -101,7 +101,7 @@ static int vu_scmi_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(vhost_dev, vdev, true, false);
>
>      err =3D k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false)=
;
>      if (err < 0) {
> diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-commo=
n.c
> index b79f4c9ce6..4ef037627b 100644
> --- a/hw/virtio/vhost-vsock-common.c
> +++ b/hw/virtio/vhost-vsock-common.c
> @@ -106,7 +106,7 @@ int vhost_vsock_common_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(&vvc->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vvc->vhost_dev, vdev, true, false);
>
>      err =3D k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, fa=
lse);
>      if (err < 0) {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..2a62550222 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -23,6 +23,7 @@
>  #include "qemu/log.h"
>  #include "standard-headers/linux/vhost_types.h"
>  #include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/vhost-user.h"
>  #include "hw/mem/memory-device.h"
>  #include "migration/blocker.h"
>  #include "migration/qemu-file-types.h"
> @@ -1496,8 +1497,13 @@ fail:
>  static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
>                                     struct VirtIODevice *vdev,
>                                     struct vhost_virtqueue *vq,
> -                                   unsigned idx, bool force)
> +                                   unsigned idx, bool force,
> +                                   bool skip_drain)
>  {
> +    if (skip_drain) {
> +        assert(vhost_user_has_protocol_feature(dev,
> +               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
> +    }

FYI, with only `--disable-vhost-user` configuration, this line
triggers a link error:
  | undefined reference to `vhost_user_has_protocol_feature'

Disabling all vhosts (so vhost-user, vhost-vdpa and vhost-kernel) was
enough to fix it.

Cl=C3=A9ment

>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_state state =3D {
>          .index =3D vhost_vq_index,
> @@ -1547,9 +1553,10 @@ static int do_vhost_virtqueue_stop(struct vhost_de=
v *dev,
>  int vhost_virtqueue_stop(struct vhost_dev *dev,
>                           struct VirtIODevice *vdev,
>                           struct vhost_virtqueue *vq,
> -                         unsigned idx)
> +                         unsigned idx,
> +                         bool skip_drain)
>  {
> -    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false);
> +    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false, skip_drain=
);
>  }
>
>  static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
> @@ -2302,7 +2309,8 @@ fail_vq:
>          vhost_virtqueue_stop(hdev,
>                               vdev,
>                               hdev->vqs + i,
> -                             hdev->vq_index + i);
> +                             hdev->vq_index + i,
> +                             false);
>      }
>
>  fail_mem:
> @@ -2317,7 +2325,7 @@ fail_features:
>
>  /* Host notifiers must be enabled at this point. */
>  static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
> -                             bool vrings, bool force)
> +                             bool vrings, bool force, bool skip_drain)
>  {
>      int i;
>      int rc =3D 0;
> @@ -2344,7 +2352,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev=
, VirtIODevice *vdev,
>                                        vdev,
>                                        hdev->vqs + i,
>                                        hdev->vq_index + i,
> -                                      force);
> +                                      force,
> +                                      skip_drain);
>      }
>      if (hdev->vhost_ops->vhost_reset_status) {
>          hdev->vhost_ops->vhost_reset_status(hdev);
> @@ -2366,15 +2375,16 @@ static int do_vhost_dev_stop(struct vhost_dev *hd=
ev, VirtIODevice *vdev,
>      return rc;
>  }
>
> -int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrin=
gs)
> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrin=
gs,
> +                   bool skip_drain)
>  {
> -    return do_vhost_dev_stop(hdev, vdev, vrings, false);
> +    return do_vhost_dev_stop(hdev, vdev, vrings, false, skip_drain);
>  }
>
>  int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
>                           bool vrings)
>  {
> -    return do_vhost_dev_stop(hdev, vdev, vrings, true);
> +    return do_vhost_dev_stop(hdev, vdev, vrings, true, false);
>  }
>
>  int vhost_net_set_backend(struct vhost_dev *hdev,
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 684bafcaad..33b88f95ea 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -228,6 +228,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODev=
ice *vdev, bool vrings);
>   * @hdev: common vhost_dev structure
>   * @vdev: the VirtIODevice structure
>   * @vrings: true to have vrings disabled in this call
> + * @skip_drain: true to notice back-end to skip draining all in-flight r=
equests
>   *
>   * Stop the vhost device. After the device is stopped the notifiers
>   * can be disabled (@vhost_dev_disable_notifiers) and the device can
> @@ -235,7 +236,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODev=
ice *vdev, bool vrings);
>   *
>   * Return: 0 on success, !=3D 0 on error when stopping dev.
>   */
> -int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrin=
gs);
> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrin=
gs,
> +                   bool skip_drain);
>
>  /**
>   * vhost_dev_force_stop() - force stop the vhost device
> @@ -393,7 +395,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, ui=
nt64_t iova, int write);
>  int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vd=
ev,
>                            struct vhost_virtqueue *vq, unsigned idx);
>  int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vde=
v,
> -                         struct vhost_virtqueue *vq, unsigned idx);
> +                         struct vhost_virtqueue *vq, unsigned idx,
> +                         bool skip_drain);
>
>  void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight);
> --
> 2.34.1
>
>

