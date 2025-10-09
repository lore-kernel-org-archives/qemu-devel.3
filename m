Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55533CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w19-0003Ua-QI; Thu, 09 Oct 2025 15:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w19-0003UL-4h
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:35 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w15-0007OK-M9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:34 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-4248b34fc8eso14703695ab.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036968; x=1760641768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLtUXK4Zx1aCscfZz1UfEKrSxr5pnDsltg2o4iFpxT8=;
 b=WcEtGGiHrRwWFMpUH3QSrIJBtSMubqIiJUn5MfqyrRACwdKrJ+90tcSrMTCcMnhG1b
 aGUE0YejUMXLDfrhySacdzgnhWXAfIdjig7LFYfoQndki9dC/H+46WoDLOtV18hgoH4Y
 +FBnSCJyP3oLGB3RdMLpE9U210Q8XFAZhParzrw/JOmCt33j/4yx1heVzc9zVmAAtpj0
 b3vmOs0Qgr8zA85WTLxjVKiq4TE50VRj+uOOpmIx8HKpGVDlbIvqkCYCPFiu0HPxbLo3
 DKP9qtOt1e3a/Mmufkwp3rK6fAxSxSdYs358d9PG1YjgwJtdgGhFyT6URZzMcR3Df61h
 2K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036968; x=1760641768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLtUXK4Zx1aCscfZz1UfEKrSxr5pnDsltg2o4iFpxT8=;
 b=CT3MR+md9RE4SOCY3++DOfe9bTJqiNQehy439WghZp1aEvXgUvNrzzspivgCNIHcgB
 j/N6Qps0YNPi3TLLaDc+0A6osofDrZsFYLgd48uDLjt6VJoEwZR7tiguuq1y+4unx3bZ
 hzq7YgdYllYaWXW23Hfym6Rq2kPi291KLIoJrWNqBY2tEyh/hUAEDz/wjSK8ZmpoOqc8
 3r4EhJxoiGt0N5Gcpw3wrTRZvklyCfyXnSn00DROyfNVzCCgTPlXKYhLPP86e1nmqwgs
 ZD8RfMs4zr4/PvQrzUIjCxk2gTHV4srd23Y36jnkb5wf0XF29R2OpUxBv7lyQXptGcLo
 LdMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKwCI6bpkX1kaS2aipoZGNpwKsoOTSRDfJ8GvmYuinCC+XS/cGnuYBtzPLsHscMHe7GuTuME8d4JfM@nongnu.org
X-Gm-Message-State: AOJu0YwUg6MF7RQPpYDo9m2+tpa7MK3hxNxV4MfPlAQKtBISIrKIrgpQ
 iCLCbbyPyfTa0WUzZaCuyZoccqotYDSyczALrA7av1wpnL/uzGrqYoob9fwMSX25HiLRY3VXfei
 nGUomEt62wIe08hlDewLTPktVOFyvGjA=
X-Gm-Gg: ASbGncv/TtFpDUBwAayXrpw/JpkWxZTQfbFJnnPulnADJo2SjVPS2VueXf4ZKwoBhSc
 4U+5KtKJuY7kxnpWz7NSR0mrrGBa0vgolRYm1rZtYQpiZG07ShlQtXhFIH40Bk1xV413DJPc2Bv
 j2QLvZ7EL05XdXNfqWcvK4jktPrAR8qBUZO932Zbu0SPc5Sk7v0l9efdMFd5lM1B+3/CeL1fx2K
 P4mVRCD6PCa3L+lKYOX5ECGY0SLNdXw2eq+goM1IQ==
X-Google-Smtp-Source: AGHT+IEISxSYZVQ5ArCGvtXz5q7gZTHChB2dwC/WF4mPNgV8sgYzPhlmq/LAVglyVb5peHoCOAJZU6BaVnNaCoSUIvE=
X-Received: by 2002:a05:6e02:2143:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-42f8736905dmr96733795ab.11.1760036967476; Thu, 09 Oct 2025
 12:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-29-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-29-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:09:15 -0400
X-Gm-Features: AS18NWDTYTzq0HsMIQGKr-_MR-cKOlT_5thgMfYVdOCckElCFCnb-DY4KUPilMA
Message-ID: <CAFubqFsw63R8H6nH4ZvJVexgHnfeO6+M+yQo2y7Bw1VoFsgY2g@mail.gmail.com>
Subject: Re: [PATCH 28/33] vhost: introduce backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x136.google.com
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

A few suggestions here. Overall, it looks sane to me.

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Normally on migration we stop and destroy connection with
> vhost (vhost-user-blk server, or kernel vhost) on source
> and reinitialize it on target.
>
> With this commit we start to implement vhost backend migration,
> i.e. we don't stop the connection and operation of vhost. Instead,
> we pass backend-related state, including open file descriptors
> to target process. Of course, it's possible only for local
> migration, and migration channel should be a unix socket.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c                 | 184 +++++++++++++++++++++++++-----
>  include/hw/virtio/vhost-backend.h |   5 +
>  include/hw/virtio/vhost.h         |   6 +
>  3 files changed, 167 insertions(+), 28 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 0427fc29b2..80371a2653 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -26,8 +26,10 @@
>  #include "hw/mem/memory-device.h"
>  #include "migration/blocker.h"
>  #include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"
>  #include "system/dma.h"
>  #include "trace.h"
> +#include <stdint.h>
>
>  /* enabled until disconnected backend stabilizes */
>  #define _VHOST_DEBUG 1
> @@ -1321,6 +1323,8 @@ out:
>      return ret;
>  }
>
> +static void vhost_virtqueue_error_notifier(EventNotifier *n);
> +
>  int vhost_virtqueue_start(struct vhost_dev *dev,
>                            struct VirtIODevice *vdev,
>                            struct vhost_virtqueue *vq,
> @@ -1346,7 +1350,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          return r;
>      }
>
> -    vq->num =3D state.num =3D virtio_queue_get_num(vdev, idx);
> +    vq->num =3D virtio_queue_get_num(vdev, idx);
> +
> +    if (dev->migrating_backend) {
> +        if (dev->vhost_ops->vhost_set_vring_err) {
> +            event_notifier_set_handler(&vq->error_notifier,
> +                                       vhost_virtqueue_error_notifier);
> +        }
> +        return 0;
> +    }
> +
> +    state.num =3D vq->num;
>      r =3D dev->vhost_ops->vhost_set_vring_num(dev, &state);
>      if (r) {
>          VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
> @@ -1424,6 +1438,10 @@ static int do_vhost_virtqueue_stop(struct vhost_de=
v *dev,
>
>      trace_vhost_virtque_stop(vdev->name, idx);
>
> +    if (dev->migrating_backend) {
> +        return 0;
> +    }
> +
>      if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return 0;
> @@ -1514,7 +1532,15 @@ static int vhost_virtqueue_init(struct vhost_dev *=
dev,
>      struct vhost_vring_file file =3D {
>          .index =3D vhost_vq_index,
>      };
> -    int r =3D event_notifier_init(&vq->masked_notifier, 0);
> +    int r;
> +
> +    vq->dev =3D dev;
> +
> +    if (dev->migrating_backend) {
> +        return 0;
> +    }
> +
> +    r =3D event_notifier_init(&vq->masked_notifier, 0);
>      if (r < 0) {
>          return r;
>      }
> @@ -1526,8 +1552,6 @@ static int vhost_virtqueue_init(struct vhost_dev *d=
ev,
>          goto fail_call;
>      }
>
> -    vq->dev =3D dev;
> -
>      if (dev->vhost_ops->vhost_set_vring_err) {
>          r =3D event_notifier_init(&vq->error_notifier, 0);
>          if (r < 0) {
> @@ -1564,10 +1588,14 @@ fail_call:
>
>  static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>  {
> -    event_notifier_cleanup(&vq->masked_notifier);
> +    if (!vq->dev->migrating_backend) {
> +        event_notifier_cleanup(&vq->masked_notifier);
> +    }
>      if (vq->dev->vhost_ops->vhost_set_vring_err) {
>          event_notifier_set_handler(&vq->error_notifier, NULL);
> -        event_notifier_cleanup(&vq->error_notifier);
> +        if (!vq->dev->migrating_backend) {
> +            event_notifier_cleanup(&vq->error_notifier);
> +        }
>      }
>  }
>
> @@ -1624,21 +1652,30 @@ int vhost_dev_init(struct vhost_dev *hdev, void *=
opaque,
>      r =3D vhost_set_backend_type(hdev, backend_type);
>      assert(r >=3D 0);
>
> -    r =3D hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
> -    if (r < 0) {
> -        goto fail;
> +    if (hdev->migrating_backend) {
> +        /* backend must support detached state */

Probably better to error_report() or something other than a raw assert?

> +        assert(hdev->vhost_ops->vhost_save_backend);
> +        assert(hdev->vhost_ops->vhost_load_backend);
> +        hdev->_features_wait_incoming =3D true;
>      }
>
> -    r =3D hdev->vhost_ops->vhost_set_owner(hdev);
> +    r =3D hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
>      if (r < 0) {
> -        error_setg_errno(errp, -r, "vhost_set_owner failed");
>          goto fail;
>      }
>
> -    r =3D hdev->vhost_ops->vhost_get_features(hdev, &hdev->_features);
> -    if (r < 0) {
> -        error_setg_errno(errp, -r, "vhost_get_features failed");
> -        goto fail;
> +    if (!hdev->migrating_backend) {
> +        r =3D hdev->vhost_ops->vhost_set_owner(hdev);
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "vhost_set_owner failed");
> +            goto fail;
> +        }
> +
> +        r =3D hdev->vhost_ops->vhost_get_features(hdev, &hdev->_features=
);
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "vhost_get_features failed");
> +            goto fail;
> +        }
>      }
>
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> @@ -1670,7 +1707,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          .region_del =3D vhost_iommu_region_del,
>      };
>
> -    if (hdev->migration_blocker =3D=3D NULL) {
> +    if (!hdev->migrating_backend && hdev->migration_blocker =3D=3D NULL)=
 {
>          if (!vhost_dev_has_feature(hdev, VHOST_F_LOG_ALL)) {
>              error_setg(&hdev->migration_blocker,
>                         "Migration disabled: vhost lacks VHOST_F_LOG_ALL =
feature.");
> @@ -1697,7 +1734,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>
> -    if (!check_memslots(hdev, errp)) {
> +    if (!hdev->migrating_backend && !check_memslots(hdev, errp)) {
>          r =3D -EINVAL;
>          goto fail;
>      }
> @@ -1765,8 +1802,11 @@ void vhost_dev_disable_notifiers_nvqs(struct vhost=
_dev *hdev,
>       */
>      memory_region_transaction_commit();
>
> -    for (i =3D 0; i < nvqs; ++i) {
> -        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_inde=
x + i);
> +    if (!hdev->migrating_backend) {
> +        for (i =3D 0; i < nvqs; ++i) {
> +            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
> +                                             hdev->vq_index + i);
> +        }
>      }
>      virtio_device_release_ioeventfd(vdev);
>  }
> @@ -1920,6 +1960,12 @@ uint64_t vhost_get_features(struct vhost_dev *hdev=
, const int *feature_bits,
>                              uint64_t features)
>  {
>      const int *bit =3D feature_bits;
> +

Should this be

    if (hdev->_features_wait_incoming && hdev->migrating_backend) {

to not impact existing flows?

> +    if (hdev->_features_wait_incoming) {
> +        /* Excessive set is enough for early initialization. */
> +        return features;
> +    }
> +
>      while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
>          uint64_t bit_mask =3D (1ULL << *bit);
>          if (!vhost_dev_has_feature(hdev, *bit)) {
> @@ -1930,6 +1976,66 @@ uint64_t vhost_get_features(struct vhost_dev *hdev=
, const int *feature_bits,
>      return features;
>  }
>
> +void vhost_save_backend(struct vhost_dev *hdev, QEMUFile *f)
> +{
> +    int i;
> +
> +    assert(hdev->migrating_backend);
> +
> +    if (hdev->vhost_ops->vhost_save_backend) {
> +        hdev->vhost_ops->vhost_save_backend(hdev, f);
> +    }
> +
> +    qemu_put_be64(f, hdev->_features);
> +    qemu_put_be64(f, hdev->max_queues);
> +    qemu_put_be64(f, hdev->nvqs);
> +
> +    for (i =3D 0; i < hdev->nvqs; i++) {
> +        qemu_file_put_fd(f,
> +                         event_notifier_get_fd(&hdev->vqs[i].error_notif=
ier));
> +        qemu_file_put_fd(f,
> +                         event_notifier_get_fd(&hdev->vqs[i].masked_noti=
fier));
> +    }
> +}
> +
> +int vhost_load_backend(struct vhost_dev *hdev, QEMUFile *f)
> +{
> +    int i;
> +    Error *err =3D NULL;
> +    uint64_t nvqs;
> +
> +    assert(hdev->migrating_backend);
> +
> +    if (hdev->vhost_ops->vhost_load_backend) {
> +        hdev->vhost_ops->vhost_load_backend(hdev, f);
> +    }
> +
> +    qemu_get_be64s(f, &hdev->_features);
> +    qemu_get_be64s(f, &hdev->max_queues);
> +    qemu_get_be64s(f, &nvqs);
> +
> +    if (nvqs !=3D hdev->nvqs) {
> +        error_report("%s: number of virt queues mismatch", __func__);
> +        return -EINVAL;
> +    }
> +
> +    for (i =3D 0; i < hdev->nvqs; i++) {
> +        event_notifier_init_fd(&hdev->vqs[i].error_notifier,
> +                               qemu_file_get_fd(f));
> +        event_notifier_init_fd(&hdev->vqs[i].masked_notifier,
> +                               qemu_file_get_fd(f));
> +    }
> +
> +    if (!check_memslots(hdev, &err)) {
> +        error_report_err(err);
> +        return -EINVAL;
> +    }
> +
> +    hdev->_features_wait_incoming =3D false;
> +
> +    return 0;
> +}
> +
>  void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                          uint64_t features)
>  {
> @@ -2075,19 +2181,24 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtI=
ODevice *vdev, bool vrings)
>      hdev->started =3D true;
>      hdev->vdev =3D vdev;
>
> -    r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> -    if (r < 0) {
> -        goto fail_features;
> +    if (!hdev->migrating_backend) {
> +        r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> +        if (r < 0) {
> +            warn_report("%s %d", __func__, __LINE__);
> +            goto fail_features;
> +        }
>      }
>
>      if (vhost_dev_has_iommu(hdev)) {
>          memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
>      }
>
> -    r =3D hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
> -    if (r < 0) {
> -        VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
> -        goto fail_mem;
> +    if (!hdev->migrating_backend) {
> +        r =3D hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
> +            goto fail_mem;
> +        }
>      }
>      for (i =3D 0; i < hdev->nvqs; ++i) {
>          r =3D vhost_virtqueue_start(hdev,
> @@ -2127,7 +2238,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>          }
>          vhost_dev_elect_mem_logger(hdev, true);
>      }
> -    if (vrings) {
> +    if (vrings && !hdev->migrating_backend) {
>          r =3D vhost_dev_set_vring_enable(hdev, true);
>          if (r) {
>              goto fail_log;
> @@ -2155,6 +2266,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>      }
>      vhost_start_config_intr(hdev);
>
> +    hdev->migrating_backend =3D false;
> +
>      trace_vhost_dev_start_finish(vdev->name);
>      return 0;
>  fail_iotlb:
> @@ -2204,14 +2317,29 @@ static int do_vhost_dev_stop(struct vhost_dev *hd=
ev, VirtIODevice *vdev,
>      event_notifier_cleanup(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>
> +    if (hdev->migrating_backend) {

Ditto - no raw assert()?


> +        /* backend must support detached state */
> +        assert(hdev->vhost_ops->vhost_save_backend);
> +        assert(hdev->vhost_ops->vhost_load_backend);
> +    }
> +
>      trace_vhost_dev_stop(hdev, vdev->name, vrings);
>
>      if (hdev->vhost_ops->vhost_dev_start) {
>          hdev->vhost_ops->vhost_dev_start(hdev, false);
>      }
> -    if (vrings) {
> +    if (vrings && !hdev->migrating_backend) {
>          vhost_dev_set_vring_enable(hdev, false);
>      }
> +
> +    if (hdev->migrating_backend) {
> +        for (i =3D 0; i < hdev->nvqs; ++i) {
> +            struct vhost_virtqueue *vq =3D hdev->vqs + i;
> +
> +            event_notifier_set_handler(&vq->error_notifier, NULL);
> +        }
> +    }
> +
>      for (i =3D 0; i < hdev->nvqs; ++i) {
>          rc |=3D do_vhost_virtqueue_stop(hdev,
>                                        vdev,
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index 0785fc764d..66627c6a56 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -163,6 +163,9 @@ typedef int (*vhost_set_device_state_fd_op)(struct vh=
ost_dev *dev,
>  typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error =
**errp);
>  typedef void (*vhost_qmp_status_op)(struct vhost_dev *dev, VhostStatus *=
status);
>
> +typedef void (*vhost_detached_save_op)(struct vhost_dev *dev, QEMUFile *=
f);
> +typedef int (*vhost_detached_load_op)(struct vhost_dev *dev, QEMUFile *f=
);
> +
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
>      vhost_backend_init vhost_backend_init;
> @@ -219,6 +222,8 @@ typedef struct VhostOps {
>      vhost_set_device_state_fd_op vhost_set_device_state_fd;
>      vhost_check_device_state_op vhost_check_device_state;
>      vhost_qmp_status_op vhost_qmp_status;
> +    vhost_detached_save_op vhost_save_backend;
> +    vhost_detached_load_op vhost_load_backend;
>  } VhostOps;
>
>  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 8a4c8c3502..330374aca2 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -103,6 +103,10 @@ struct vhost_dev {
>       * @acked_features: final negotiated features with front-end driver
>       */
>      uint64_t _features;
> +    bool _features_wait_incoming;
> +
> +    bool migrating_backend;
> +
>      uint64_t acked_features;
>
>      uint64_t max_queues;
> @@ -318,6 +322,8 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, Vir=
tIODevice *vdev, int n,
>   */
>  uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_b=
its,
>                              uint64_t features);
> +void vhost_save_backend(struct vhost_dev *hdev, QEMUFile *f);
> +int vhost_load_backend(struct vhost_dev *hdev, QEMUFile *f);
>
>  /**
>   * vhost_ack_features() - set vhost acked_features
> --
> 2.48.1
>
>

