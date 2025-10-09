Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9ECCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w1u-00047N-K3; Thu, 09 Oct 2025 15:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1n-00042K-ON
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:10:16 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1f-0007cr-Gx
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:10:15 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4291359714eso11721625ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760037006; x=1760641806; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XXAG4qJaVJzvAHG7Wl071NUoI+OPkhlZYvsIxhYEoU=;
 b=N3a4XEtNS7f3HUcoTLCxrYGoZwgEAHl0aYAriZasnqHHPsQ04IrXqwhN2mEj5FXK6T
 IGSIkK+/rypGD7f9AAQ4umqqBH3sBpEtlxeOjBYRFySpknvfSK91FKhP0RLWRUBOFPOn
 IcZg1S6VxMTtRlmivwkf1Yl1yiCYioaxtTpsgsJ5591356ZkHki+3bbNjjBdP263naad
 Q+V72KDIeAYwPhPGfOv8kWEuJMNKO/gS5Zo5+7VrX5rRvuTFPnu9neTu8JxqkJc3wer/
 hAE/YE/YoQuQj6dN3KZWsCqSliBCq1hxjH2Ye2UURlWHmH168rzjkWeyJT27hzPUWJTX
 V0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760037006; x=1760641806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XXAG4qJaVJzvAHG7Wl071NUoI+OPkhlZYvsIxhYEoU=;
 b=ezxJgItRrMGNGF4NaZkohYwE+m9R/XXtvaDftG14CsoRQHMzT/FxhNj00/0RlreGEn
 2B8UX8xFmQAtpNheItuoH40leRaARuilYP+cPj8jHVzFhS9xQKomN+Rd/LBJK1l9URtW
 lhBN8pyOleuL+/w7QkmJ0Z57Bt0Hb2EAFTyOxjT32HJeji9h5s3xI39MtRIKauK8GPzk
 gZjFsODbHDTG72INsJUj/+kbhe0tjrDZ4lnrl2GdVwsSJxTioysdFz58mRuQHehIsM6n
 OT3axgjt5Xp9r0Ly1s7Rjo/u+6tBCda3tkc+1mnjDapD/tTdv2X4LYmgbPxSLwTtG+QI
 EKtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqymJZCbEvdC7RZLpFMDQ3B7GPi6bHMadXiKDsOyjwS0u3xVNsaaSjMIW33s7Dw6D9w+Z62Sq8sOnE@nongnu.org
X-Gm-Message-State: AOJu0YzcwKvtLCJCXIljbv4Ou0Zpho1oPE47ZW71UAn+8FfzdlBobZEX
 jnIZ01QZOzbDSYiaWSqjqPwYypnIPS44uFDAMIdpeYr7/3K01fcy2+jeifIVbaYRBPkYd/MXgC7
 sSgLJRwdP5dMX5pIOZ24rekbfppN1dvVuVL4bBF8=
X-Gm-Gg: ASbGnctK64cp2V8lXlUHzcksRaNvzAEa310EpKOuJ60Fz6nsGe4ZlD8Ij39d3urWyVf
 AP+U9LSwCbvVridAwtHdYvdSAMQFLEfrUTGLsug43yLwRwSl/qP94M8m26wSZQNng6D1xuIfbbR
 +67jAl3f4uskR3qAyxbo9FkuZy0s8LmhvrvPpWgcaJvygSsKfv9dD56MIKVXCzWXlz8rXiyG+UJ
 F61w5zB/PyHoxrXXRQxUBc+vE8QCJ+IxjglsMpDoQ==
X-Google-Smtp-Source: AGHT+IEfDSBB8ceirJ8JbapEVlwMOX7OeZy2vsXkkLRmrU8Wqd049zWi7r7I/lJyx582Lmk0RxpaGlQK03RBbMYlcQE=
X-Received: by 2002:a05:6e02:2143:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-42f8736905dmr96763425ab.11.1760037005816; Thu, 09 Oct 2025
 12:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-32-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-32-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:09:54 -0400
X-Gm-Features: AS18NWDQvU9-VogDObwSes8Xy8VK2jla95vMxWeqAlScSS80efWj76LgGpisiK4
Message-ID: <CAFubqFsL4O=zEbmCEQ9KtBYVOsFjf6tuaur+oU9=1+hRDrPtNw@mail.gmail.com>
Subject: Re: [PATCH 31/33] vhost-user-blk: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A small question here but will review more thoroughly pending feedback
on my overall comments.

On Wed, Aug 13, 2025 at 12:53=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Opt-out backend initialization code, and instead get the state
> from migration channel (including inflight region).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 185 +++++++++++++++++++++++------
>  include/hw/virtio/vhost-user-blk.h |   2 +
>  migration/options.c                |   7 ++
>  migration/options.h                |   1 +
>  qapi/migration.json                |  15 ++-
>  5 files changed, 169 insertions(+), 41 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index c8bc2c78e6..2e6ef6477e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -17,6 +17,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi-types-run-state.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
> @@ -32,6 +33,11 @@
>  #include "system/system.h"
>  #include "system/runstate.h"
>  #include "trace.h"
> +#include "migration/qemu-file.h"
> +#include "migration/migration.h"
> +#include "migration/options.h"
> +#include "qemu/event_notifier.h"
> +#include <sys/mman.h>
>
>  static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_SIZE_MAX,
> @@ -159,32 +165,35 @@ static int vhost_user_blk_start(VirtIODevice *vdev,=
 Error **errp)
>
>      s->dev.acked_features =3D vdev->guest_features;
>
> -    ret =3D vhost_dev_prepare_inflight(&s->dev, vdev);
> -    if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Error setting inflight format");
> -        goto err_guest_notifiers;
> -    }
> -
> -    if (!s->inflight->addr) {
> -        ret =3D vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflig=
ht);
> +    if (!s->dev.migrating_backend) {
> +        ret =3D vhost_dev_prepare_inflight(&s->dev, vdev);
>          if (ret < 0) {
> -            error_setg_errno(errp, -ret, "Error getting inflight");
> +            error_setg_errno(errp, -ret, "Error setting inflight format"=
);
>              goto err_guest_notifiers;
>          }
> -    }
>
> -    ret =3D vhost_dev_set_inflight(&s->dev, s->inflight);
> -    if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Error setting inflight");
> -        goto err_guest_notifiers;
> -    }
> +        if (!s->inflight->addr) {
> +            ret =3D vhost_dev_get_inflight(&s->dev, s->queue_size, s->in=
flight);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Error getting inflight");
> +                goto err_guest_notifiers;
> +            }
> +        }
>
> -    /* guest_notifier_mask/pending not used yet, so just unmask
> -     * everything here. virtio-pci will do the right thing by
> -     * enabling/disabling irqfd.
> -     */
> -    for (i =3D 0; i < s->dev.nvqs; i++) {
> -        vhost_virtqueue_mask(&s->dev, vdev, i, false);
> +        ret =3D vhost_dev_set_inflight(&s->dev, s->inflight);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Error setting inflight");
> +            goto err_guest_notifiers;
> +        }
> +
> +        /*
> +         * guest_notifier_mask/pending not used yet, so just unmask
> +         * everything here. virtio-pci will do the right thing by
> +         * enabling/disabling irqfd.
> +         */
> +        for (i =3D 0; i < s->dev.nvqs; i++) {
> +            vhost_virtqueue_mask(&s->dev, vdev, i, false);
> +        }
>      }
>
>      s->dev.vq_index_end =3D s->dev.nvqs;
> @@ -231,6 +240,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
>                   qemu_force_shutdown_requested();
>
> +    s->dev.migrating_backend =3D s->dev.migrating_backend ||
> +        (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
> +         migrate_local_vhost_user_blk());
> +
>      ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
>                         vhost_dev_stop(&s->dev, vdev, true);
>
> @@ -343,7 +356,9 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
>      vhost_dev_free_inflight(s->inflight);
>  }
>
> -static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
> +static int vhost_user_blk_connect(DeviceState *dev,
> +                                  bool migrating_backend,
> +                                  Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> @@ -359,6 +374,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      s->dev.nvqs =3D s->num_queues;
>      s->dev.vqs =3D s->vhost_vqs;
>      s->dev.vq_index =3D 0;
> +    s->dev.migrating_backend =3D migrating_backend;
>
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>
> @@ -409,7 +425,7 @@ static void vhost_user_blk_event(void *opaque, QEMUCh=
rEvent event)
>
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        if (vhost_user_blk_connect(dev, &local_err) < 0) {
> +        if (vhost_user_blk_connect(dev, false, &local_err) < 0) {
>              error_report_err(local_err);
>              qemu_chr_fe_disconnect(&s->chardev);
>              return;
> @@ -428,31 +444,37 @@ static void vhost_user_blk_event(void *opaque, QEMU=
ChrEvent event)
>      }
>  }
>
> -static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
> +static int vhost_user_blk_realize_connect(VHostUserBlk *s,
> +                                          bool migrating_backend,
> +                                          Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(s);
>      int ret;
>
>      s->connected =3D false;
>
> -    ret =3D qemu_chr_fe_wait_connected(&s->chardev, errp);
> -    if (ret < 0) {
> -        return ret;
> +    if (!migrating_backend) {
> +        ret =3D qemu_chr_fe_wait_connected(&s->chardev, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
>
> -    ret =3D vhost_user_blk_connect(dev, errp);
> +    ret =3D vhost_user_blk_connect(dev, migrating_backend, errp);
>      if (ret < 0) {
>          qemu_chr_fe_disconnect(&s->chardev);
>          return ret;
>      }
>      assert(s->connected);
>
> -    ret =3D vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> -                               VIRTIO_DEVICE(s)->config_len, errp);
> -    if (ret < 0) {
> -        qemu_chr_fe_disconnect(&s->chardev);
> -        vhost_dev_cleanup(&s->dev);
> -        return ret;
> +    if (!migrating_backend) {
> +        ret =3D vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> +                                   VIRTIO_DEVICE(s)->config_len, errp);
> +        if (ret < 0) {
> +            qemu_chr_fe_disconnect(&s->chardev);
> +            vhost_dev_cleanup(&s->dev);
> +            return ret;
> +        }
>      }
>
>      return 0;
> @@ -469,6 +491,11 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>
>      trace_vhost_user_blk_device_realize();
>
> +    if (s->incoming_backend && !runstate_check(RUN_STATE_INMIGRATE)) {
> +        error_setg(errp, "__yc_local-incoming can be used "
> +                   "only for incoming migration");
> +    }
> +
>      if (!s->chardev.chr) {
>          error_setg(errp, "chardev is mandatory");
>          return;
> @@ -517,7 +544,7 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>              error_report_err(*errp);
>              *errp =3D NULL;
>          }
> -        ret =3D vhost_user_blk_realize_connect(s, errp);
> +        ret =3D vhost_user_blk_realize_connect(s, s->incoming_backend, e=
rrp);
>      } while (ret < 0 && retries--);
>
>      if (ret < 0) {
> @@ -525,9 +552,12 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>      }
>
>      /* we're fully initialized, now we can operate, so add the handler *=
/
> -    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
> -                             vhost_user_blk_event, NULL, (void *)dev,
> -                             NULL, true);
> +    if (!s->incoming_backend) {
> +        qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
> +                                 vhost_user_blk_event, NULL, (void *)dev=
,
> +                                 NULL, true);
> +    }
> +
>      trace_vhost_user_blk_device_realize_finish();
>      return;
>
> @@ -592,6 +622,79 @@ static const VMStateDescription vmstate_vhost_user_b=
lk =3D {
>      },
>  };
>
> +static void vhost_user_blk_save(VirtIODevice *vdev, QEMUFile *f)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    struct vhost_dev *hdev =3D vhost_user_blk_get_vhost(vdev);
> +
> +    if (!hdev->migrating_backend) {
> +        return;
> +    }
> +
> +    qemu_file_put_fd(f, s->inflight->fd);
> +    qemu_put_be64(f, s->inflight->size);
> +    qemu_put_be64(f, s->inflight->offset);
> +    qemu_put_be16(f, s->inflight->queue_size);
> +
> +    vhost_save_backend(hdev, f);
> +}
> +
> +static int vhost_user_blk_load(VirtIODevice *vdev, QEMUFile *f,
> +                                      int version_id)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    struct vhost_dev *hdev =3D vhost_user_blk_get_vhost(vdev);
> +
> +    if (!hdev->migrating_backend) {
> +        return 0;
> +    }
> +
> +    s->inflight->fd =3D qemu_file_get_fd(f);
> +    qemu_get_be64s(f, &s->inflight->size);
> +    qemu_get_be64s(f, &s->inflight->offset);
> +    qemu_get_be16s(f, &s->inflight->queue_size);
> +
> +    s->inflight->addr =3D mmap(0, s->inflight->size, PROT_READ | PROT_WR=
ITE,
> +                             MAP_SHARED, s->inflight->fd, s->inflight->o=
ffset);
> +    if (s->inflight->addr =3D=3D MAP_FAILED) {
> +        return -EINVAL;
> +    }
> +
> +    vhost_load_backend(hdev, f);
> +
> +    return 0;
> +}
> +
> +static int vhost_user_blk_post_load(VirtIODevice *vdev)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    struct vhost_dev *hdev =3D vhost_user_blk_get_vhost(vdev);
> +    DeviceState *dev =3D &s->parent_obj.parent_obj;
> +
> +    if (!hdev->migrating_backend) {
> +        return 0;
> +    }
> +
> +    memcpy(&s->blkcfg, vdev->config, vdev->config_len);
> +
> +    /* we're fully initialized, now we can operate, so add the handler *=
/
> +    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
> +                             vhost_user_blk_event, NULL, (void *)dev,
> +                             NULL, true);
> +
> +    return 0;
> +}
> +
> +static bool vhost_user_blk_skip_migration_log(VirtIODevice *vdev)
> +{
> +    /*
> +     * Note that hdev->migrating_backend is false at this moment,
> +     * as logging is being setup during outging migration setup stage,
> +     * which is far before vm stop.
> +     */
> +    return migrate_local_vhost_user_blk();
> +}
> +
>  static const Property vhost_user_blk_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
>      DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> @@ -605,6 +708,8 @@ static const Property vhost_user_blk_properties[] =3D=
 {
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
>      DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserB=
lk,
>                       skip_get_vring_base_on_force_shutdown, false),
> +    DEFINE_PROP_BOOL("local-incoming", VHostUserBlk,
> +                     incoming_backend, false),
>  };
>
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *da=
ta)
> @@ -624,6 +729,10 @@ static void vhost_user_blk_class_init(ObjectClass *k=
lass, const void *data)
>      vdc->set_status =3D vhost_user_blk_set_status;
>      vdc->reset =3D vhost_user_blk_reset;
>      vdc->get_vhost =3D vhost_user_blk_get_vhost;
> +    vdc->save =3D vhost_user_blk_save;
> +    vdc->load =3D vhost_user_blk_load;
> +    vdc->post_load =3D vhost_user_blk_post_load,
> +    vdc->skip_vhost_migration_log =3D vhost_user_blk_skip_migration_log;
>  }
>
>  static const TypeInfo vhost_user_blk_info =3D {
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index a10f785672..b06f55fd6f 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -52,6 +52,8 @@ struct VHostUserBlk {
>      bool started_vu;
>
>      bool skip_get_vring_base_on_force_shutdown;
> +
> +    bool incoming_backend;
>  };
>
>  #endif
> diff --git a/migration/options.c b/migration/options.c
> index dffb6910f4..11b719c81b 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -269,6 +269,13 @@ bool migrate_local_char_socket(void)
>      return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET];
>  }
>
> +bool migrate_local_vhost_user_blk(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +

Where was MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK added/defined?


> +    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK];
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index 40971f0aa0..5a40ac073d 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -31,6 +31,7 @@ bool migrate_dirty_bitmaps(void);
>  bool migrate_events(void);
>  bool migrate_mapped_ram(void);
>  bool migrate_local_char_socket(void);
> +bool migrate_local_vhost_user_blk(void);
>  bool migrate_ignore_shared(void);
>  bool migrate_late_block_activate(void);
>  bool migrate_multifd(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4f282d168e..ead7f4d17c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -520,11 +520,19 @@
>  # @local-char-socket: Migrate socket chardevs open file descriptors.
>  #     Only may be used when migration channel is unix socket. Only
>  #     involves socket chardevs with "support-local-migration" option
> -#     enabled.  (since 10.2)
> +#     enabled. For target device also @local-incoming option must
> +#     be specified (since 10.2)
> +#
> +# @local-vhost-user-blk: Migrate vhost-user-blk locally, keeping
> +#     backend alive. Open file descriptors and backend-related state are
> +#     migrated. Only may be used when migration channel is unix socket.
> +#     For target device also @local-incoming option must be specified
> +#     (since 10.2)
>  #
>  # Features:
>  #
> -# @unstable: Members @x-colo and @x-ignore-shared are experimental.
> +# @unstable: Members @x-colo, @x-ignore-shared, @local-char-socket,
> +#     @local-vhost-user-blk are experimental.
>  # @deprecated: Member @zero-blocks is deprecated as being part of
>  #     block migration which was already removed.
>  #
> @@ -542,7 +550,8 @@
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>             'dirty-limit', 'mapped-ram',
> -           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ]=
 }
> +           { 'name': 'local-char-socket', 'features': [ 'unstable' ] },
> +           { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] =
} ] }
>
>  ##
>  # @MigrationCapabilityStatus:
> --
> 2.48.1
>
>

