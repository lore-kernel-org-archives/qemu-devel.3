Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64345CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzg6-0002YK-Am; Mon, 20 Oct 2025 19:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzg4-0002Xp-T2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:52:36 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzg2-00033s-Ut
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:52:36 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-940276d224dso245592939f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761004354; x=1761609154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsBEIWaTm7ceZpUlIifoUv/Rsz2Vw1Ij8xwfIMBi7f4=;
 b=c1ZJjDHgXE+p4oM/lKVMABvFqxEoJ8wrmOSQqJoO5o9/2WDIEgEh+cZ2joJue6Jlnp
 tUNaWovEE+DV3/Z9AZ8factxYdXeiskueFSvgxqwqTFc7+hS2hRL/EaBJy8IyBb8hmZ+
 zQpj1cJE0lOlTwSn8Vc5Lt0C2wGRaffSiix66ikO2bH0fsCnSQ41rrEbwo+w+t5StkxR
 zMTCo4T8jR1CKX9q5ag1N1f8DBwqwb/C2SkLkIu5/VEFxAZ5hqeKniM0i6tJga/KGM8N
 kVTaaI6x3dw59x6dyTbfNrQ8VEADUYZ1q73jwSu5T9mUFjYGO0Oc6kEgFHy2O2zMJZHW
 mGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761004354; x=1761609154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsBEIWaTm7ceZpUlIifoUv/Rsz2Vw1Ij8xwfIMBi7f4=;
 b=sKVfv3kc3g63mGElTCeFJJ/zo7Ku+TLi8oRMEqwgTweaNGOtyCpGE8vrf0yBuK7InV
 x60kDzDuclw4FcCSE91npBpRHfz5ci8rBb48etgsEsEoBREhUa1x/vse+HEXySeZ6QfE
 5KKg4j9TmF3oWI0RNFUnViVWBqN2aZ2/Ue58qIeoc8Jlvt9wSZ6OmKuOWnDKCMM0Egm1
 zgnT64aF7RnOfU9LoO5/DKoK+ttLCEhVZ3fi6FcGAwrkA+vas8IAA6cznaHwpQrMYXl0
 l5j1Z/uWLO2Mybf0Fnpsu+agzGGrAabweRJXpVSyufRscOJWL4MfhYFMLtrhfj1K9LlE
 QdlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoVEvQUQaEyurDr1/dI42REqFUHMc4s/paRpzZWJyNY0jvfj1jth5KRkrKjLC6yKnnN/iAzsEDsB4X@nongnu.org
X-Gm-Message-State: AOJu0YxU24YJ/qbGtdE7Fm83xTGPyHjxii2AEYfO9B/r9Hz7YT5l0MO6
 rLFfCMungU91KREs4hfYPEPdz4pCH3IjuQXwgfoOVdxH1CMXFmHRLy4K/CjxqrwNTmBQewRrZp3
 2da+n3MvmCaW9cTubMCtH1vHXF3asrqg=
X-Gm-Gg: ASbGncsLiikqmrbjN9jzs8vOgtdbL8KaAHC00Xvjs/9zfCNJCdhq5/Mb8pAxADpcI5M
 H+z3oL0sqq8yaj2LfOXUuELPR0YC4nYrlC21Vhb706z927a1UFCeVlD4R05Ty0HK5cq38Ydk4K+
 djjsWjr2Z1R0n3y387ANXfwjHvQJe+CcZRw0oR/gGrEykPBB7ySdjdTClK0rp7qocIfjfFu3nA/
 y6WCun/HkS8xvyAo0TDQg7hyew1at2IuVF6Kci1u/snyOH66sc/382r2VxI
X-Google-Smtp-Source: AGHT+IEFwIp9m3CFFvHZMIsivdRSYjHljgnvszVZfBCHWS4bG9Bdr+kkX3jY3xrR2JiOB+1BjpOpARlkxHOcjzBsGV8=
X-Received: by 2002:a05:6e02:148d:b0:430:b167:3604 with SMTP id
 e9e14a558f8ab-430c5209bafmr228371255ab.4.1761004353691; Mon, 20 Oct 2025
 16:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-22-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-22-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:52:22 -0400
X-Gm-Features: AS18NWCIHvhLizJOzaW6RbJnKCGiBFJc9hqfQNouasD_FEZSGxb5A7O0acC57X8
Message-ID: <CAFubqFtv_o45M50-vLdtjg8nry44A0c1ANa5qrHmoO0K4ggU2A@mail.gmail.com>
Subject: Re: [PATCH v2 21/25] virtio: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd34.google.com
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


On Thu, Oct 16, 2025 at 7:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Add logic to transfer virtio notifiers through migration channel
> for vhost backend migration case.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-bus.c     |  2 +-
>  hw/virtio/virtio.c         | 73 ++++++++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio.h |  2 ++
>  3 files changed, 74 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 9b545acda3..577693b6c9 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -291,7 +291,7 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus,=
 int n, bool assign)
>          return -ENOSYS;
>      }
>
> -    if (assign) {
> +    if (assign && !virtio_is_vhost_backend_transfer(vdev)) {
>          r =3D event_notifier_init(notifier, 1);
>          if (r < 0) {
>              error_report("%s: unable to init event notifier: %s (%d)",
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4184aff75c..bf361811d0 100644
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
> @@ -3032,6 +3033,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      uint32_t guest_features_lo =3D (vdev->guest_features & 0xffffffff);
>      int i;
>      Error *local_err =3D NULL;
> +    bool migrating_backend =3D virtio_is_vhost_backend_transfer(vdev);
>
>      if (k->save_config) {
>          k->save_config(qbus->parent, f);
> @@ -3065,11 +3067,23 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
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
> @@ -3295,6 +3309,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id)
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>      Error *local_err =3D NULL;
> +    bool migrating_backend =3D virtio_is_vhost_backend_transfer(vdev);
>
>      /*
>       * We poison the endianness to ensure it does not get used before
> @@ -3364,6 +3379,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
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
> @@ -3377,6 +3399,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          }
>      }
>
> +    if (migrating_backend) {
> +        event_notifier_init_fd(&vdev->config_notifier, qemu_file_get_fd(=
f));
> +    }
> +
>      virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
>
>      if (vdc->load !=3D NULL) {
> @@ -3394,6 +3420,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
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
>      ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
>      if (ret) {
> @@ -3447,6 +3486,18 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>                  continue;
>              }
>
> +            if (migrating_backend) {
> +                /*
> +                 * Indices are not synced prior to backend migration (as=
 we
> +                 * don't stop vrings by GET_VRING_BASE). No reason to sy=
nc them
> +                 * now, and do any checks.
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
> @@ -3815,8 +3866,9 @@ int virtio_queue_set_guest_notifier(VirtIODevice *v=
dev, int n, bool assign,
>      EventNotifierHandler *read_fn =3D is_config ?
>          virtio_config_guest_notifier_read :
>          virtio_queue_guest_notifier_read;
> +    bool migrating_backend =3D virtio_is_vhost_backend_transfer(vdev);
>
> -    if (assign) {
> +    if (assign && !migrating_backend) {
>          int r =3D event_notifier_init(notifier, 0);
>          if (r < 0) {
>              return r;
> @@ -3826,7 +3878,7 @@ int virtio_queue_set_guest_notifier(VirtIODevice *v=
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
> @@ -4445,6 +4497,23 @@ done:
>      return element;
>  }
>
> +bool virtio_is_vhost_backend_transfer(VirtIODevice *vdev)
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
> +    return hdev->backend_transfer;
> +}
> +
>  static const TypeInfo virtio_device_info =3D {
>      .name =3D TYPE_VIRTIO_DEVICE,
>      .parent =3D TYPE_DEVICE,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 620ee4e389..8e2d3019cd 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -242,6 +242,8 @@ struct VirtioDeviceClass {
>      bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
>  };
>
> +bool virtio_is_vhost_backend_transfer(VirtIODevice *vdev);
> +
>  void virtio_instance_init_common(Object *proxy_obj, void *data,
>                                   size_t vdev_size, const char *vdev_name=
);
>
> --
> 2.48.1
>
>

