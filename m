Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DABCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w1Z-0003dI-47; Thu, 09 Oct 2025 15:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1X-0003co-Nc
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:59 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1U-0007Q9-Lm
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:59 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8cf4f90b6f0so118793339f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036995; x=1760641795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRdmiAxMC9hb/2oazKfviEk/Bf6FHDRSiniJpu6uxUU=;
 b=NPyoHtUGKOeEvAGYuK5jdaa/zndM9J3S/XofayJ4tXGFxziSjhvytTEqTepVMKdGIu
 dkZN9GaRb6JqoSs/KvubRYK9z9m5Lw3Y7u3QFZBgB9QqdIxfn7xR1GsgrmNmSBKaN3bA
 o9JKVX/a2mjdTyhWteHA8iVNDKpVhtD1OY4cXSuxhuSSlAVAJmkDZH4vo+7YmPxV1TD9
 PpRSfWeR9slG03YYEMeF8/FSN5qoiKF0YXVLXyjs1H7oKJj28bE6LYNGpWJJXlwg5uJu
 8KDbYmkT7EiWh9d2Iv2Vo428VP69VfWITF3/szPK3z4EGMYj16XO0cIcPUJbq1oAjIuJ
 dikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036995; x=1760641795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRdmiAxMC9hb/2oazKfviEk/Bf6FHDRSiniJpu6uxUU=;
 b=uFFFYbnX+SBUOJ9dFtbnD4DNnZBWGXJD1Wwqlv+sjEARqJs1td7X19t177aNP38XKm
 DvZ50Obv3nFA1KNHJC9GBz6Mk3JK8gh9ZYPvQ6/tE36XPobRzb3dXgu0w6NX7AGa81e7
 qmesOr2MluaXDL0oPdvO6FY2kDg9Uhr0wXZa25DnqRXm4ry0NU/0GK+87DOaha9gq5tP
 yOPdBojurr0L0mJnYthgq4V6IYGUl+s9ULh4jjq8q5u6jMTbGT9ZJdVEjO+FHmrgKWOa
 mxuh2y5uX4x998wh9EekviFqVyFe9daxP7OhNogg+ex/M+MNhxGcRidaF9thLg4v9J85
 YP7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqxct4xrq4jDKSm4BySDW4V7Rkoa97qh1oNw2NqcEn6CXziVwH6PtaGIApn1w+ESJLFSSY3yfVYDT@nongnu.org
X-Gm-Message-State: AOJu0Yywde8sjwJ6maQ8x31S0BqzVRKoDbBzInPWiSFzgHw+TkFTQrQA
 gGJjUddnBBUfM3Ql7Yr+bqOSIkcxmotUwueNzqTpvyP63QezHVS/vUKbwoyv40QmJ/SUNayUuYf
 D4bL0YMQnmyQg+oSjjsgRqK/UWn791uU=
X-Gm-Gg: ASbGncuWOraOrk6oxqWKL/Ax3HUab8/5HgAEIxVEv6a694DfjTfkFuoGSRQR+ttFvBW
 o9i+xtC3z6Cw0GVM17ls8PTOPepQbLr/J1DMjyO0LEBYp99HwZ8meUJKBPjI4F8xlY/P1EQVTaD
 s3p/gzt9v2SGbNJQW+Pa2/AC83paXawVq+PXNgqpYoJtKAPEMDmc8ekBhmyuPSuJXuIy+bUbZUi
 vD4blLcfCj+fM2x8WeACcbzk8XgDQBF/O9O4mV5pQ==
X-Google-Smtp-Source: AGHT+IFhPxd+g3ARscLURGJB7qTaJPbuieMD1du85/jt1Qcaakrvj28c9U5g8UKRRG710Eg5oIUjSWywEgMMXAwiZz8=
X-Received: by 2002:a05:6e02:230a:b0:42f:946f:8eb4 with SMTP id
 e9e14a558f8ab-42f946f904fmr26024575ab.21.1760036995005; Thu, 09 Oct 2025
 12:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-31-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-31-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:09:42 -0400
X-Gm-Features: AS18NWDWquckcsINW_IymQpcNP0qvx_AXXnYYp9K56v7UtGOwCHZMPz5biVoJGo
Message-ID: <CAFubqFs_N0bUF9Gh2y14fX1W0ZwtrJfTomR7Q6sHXNGWMY7QrQ@mail.gmail.com>
Subject: Re: [PATCH 30/33] virtio: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd33.google.com
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

A few nits. Looks like there has been some churn here so this patch
will need to be rebased.

On Wed, Aug 13, 2025 at 1:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Add logic to transfer virtio notifiers through migration channel
> for vhost backend migration case.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-bus.c     |  2 +-
>  hw/virtio/virtio.c         | 74 ++++++++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio.h |  2 ++
>  3 files changed, 75 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index c7e3941b1e..c1848144a2 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -286,7 +286,7 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus,=
 int n, bool assign)
>          return -ENOSYS;
>      }
>
> -    if (assign) {
> +    if (assign && !virtio_is_vhost_migrating_backend(vdev)) {
>          r =3D event_notifier_init(notifier, 1);
>          if (r < 0) {
>              error_report("%s: unable to init event notifier: %s (%d)",
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 10891f0e0c..87c243edad 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -26,6 +26,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/vhost.h"
>  #include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"
>  #include "qemu/atomic.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/qdev-properties.h"
> @@ -2992,6 +2993,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>      uint32_t guest_features_lo =3D (vdev->guest_features & 0xffffffff);
>      int i;
> +    bool migrating_backend =3D virtio_is_vhost_migrating_backend(vdev);
>
>      if (k->save_config) {
>          k->save_config(qbus->parent, f);
> @@ -3025,11 +3027,23 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>           */
>          qemu_put_be64(f, vdev->vq[i].vring.desc);
>          qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
> +
> +        if (migrating_backend) {
> +            qemu_file_put_fd(f,
> +                             event_notifier_get_fd(&vdev->vq[i].host_not=
ifier));
> +            qemu_file_put_fd(
> +                f, event_notifier_get_fd(&vdev->vq[i].guest_notifier));
> +        }
> +
>          if (k->save_queue) {
>              k->save_queue(qbus->parent, i, f);
>          }
>      }
>
> +    if (migrating_backend) {
> +        qemu_file_put_fd(f, event_notifier_get_fd(&vdev->config_notifier=
));
> +    }
> +
>      if (vdc->save !=3D NULL) {
>          vdc->save(vdev, f);
>      }
> @@ -3235,6 +3249,8 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id)
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> +    Error *local_err =3D NULL;
> +    bool migrating_backend =3D virtio_is_vhost_migrating_backend(vdev);
>
>      /*
>       * We poison the endianness to ensure it does not get used before
> @@ -3304,6 +3320,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          vdev->vq[i].signalled_used_valid =3D false;
>          vdev->vq[i].notification =3D true;
>
> +        if (migrating_backend) {
> +            event_notifier_init_fd(&vdev->vq[i].host_notifier,
> +                                   qemu_file_get_fd(f));
> +            event_notifier_init_fd(&vdev->vq[i].guest_notifier,
> +                                   qemu_file_get_fd(f));
> +        }
> +
>          if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) {
>              error_report("VQ %d address 0x0 "
>                           "inconsistent with Host index 0x%x",
> @@ -3317,6 +3340,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          }
>      }
>
> +    if (migrating_backend) {

nit: spurious spaces after &vdev->config_notifier

> +        event_notifier_init_fd(&vdev->config_notifier   , qemu_file_get_=
fd(f));
> +    }
> +
>      virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
>
>      if (vdc->load !=3D NULL) {
> @@ -3333,6 +3360,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          }
>      }
>
> +    if (migrating_backend) {
> +        /*
> +         * On vhost backend migration, device do load host_features from
> +         * migration stream. So update host_features.
> +         */
> +        vdev->host_features =3D vdc->get_features(vdev, vdev->host_featu=
res,
> +                                                &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +    }
> +
>      /* Subsections */
>      ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
>      if (ret) {
> @@ -3394,6 +3434,18 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>                  continue;
>              }
>
> +            if (migrating_backend) {
> +                /*

"prior to backend migration"?



> +                 * Indices are not synced prior backend migration (as we=
 don't
> +                 * stop vrings by GET_VRING_BASE). No reason to sync the=
m now,
> +                 * and do any checks.
> +                 */
> +                vdev->vq[i].used_idx =3D 0;
> +                vdev->vq[i].shadow_avail_idx =3D 0;
> +                vdev->vq[i].inuse =3D 0;
> +                continue;
> +            }
> +
>              nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
>              /* Check it isn't doing strange things with descriptor numbe=
rs. */
>              if (nheads > vdev->vq[i].vring.num) {
> @@ -3762,8 +3814,9 @@ int virtio_queue_set_guest_notifier(VirtIODevice *v=
dev, int n, bool assign,
>      EventNotifierHandler *read_fn =3D is_config ?
>          virtio_config_guest_notifier_read :
>          virtio_queue_guest_notifier_read;
> +    bool migrating_backend =3D virtio_is_vhost_migrating_backend(vdev);
>
> -    if (assign) {
> +    if (assign && !migrating_backend) {
>          int r =3D event_notifier_init(notifier, 0);
>          if (r < 0) {
>              return r;
> @@ -3773,7 +3826,7 @@ int virtio_queue_set_guest_notifier(VirtIODevice *v=
dev, int n, bool assign,
>      event_notifier_set_handler(notifier,
>                                 (assign && !with_irqfd) ? read_fn : NULL)=
;
>
> -    if (!assign) {
> +    if (!assign && !migrating_backend) {
>          /* Test and clear notifier before closing it,*/
>          /* in case poll callback didn't have time to run. */
>          read_fn(notifier);
> @@ -4392,6 +4445,23 @@ done:
>      return element;
>  }
>
> +bool virtio_is_vhost_migrating_backend(VirtIODevice *vdev)
> +{
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> +    struct vhost_dev *hdev;
> +
> +    if (!vdc->get_vhost) {
> +        return false;
> +    }
> +
> +    hdev =3D vdc->get_vhost(vdev);
> +    if (!hdev) {
> +        return false;
> +    }
> +
> +    return hdev->migrating_backend;
> +}
> +
>  static const TypeInfo virtio_device_info =3D {
>      .name =3D TYPE_VIRTIO_DEVICE,
>      .parent =3D TYPE_DEVICE,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 9a4a0a94aa..f94a7e5895 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -238,6 +238,8 @@ struct VirtioDeviceClass {
>      bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
>  };
>
> +bool virtio_is_vhost_migrating_backend(VirtIODevice *vdev);
> +
>  void virtio_instance_init_common(Object *proxy_obj, void *data,
>                                   size_t vdev_size, const char *vdev_name=
);
>
> --
> 2.48.1
>
>

