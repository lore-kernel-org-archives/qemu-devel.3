Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913D7CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAze2-0000rB-Ar; Mon, 20 Oct 2025 19:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzdr-0000q6-JE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:50:22 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzdp-0002jf-9D
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:50:19 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-940e06b4184so102186139f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761004216; x=1761609016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qc6d0Fejx/5V39Ubz2j+y4zGnbVtOL1bnUPsm5G3FPA=;
 b=LiLpSi8Pa3JSWrPXkU/LTpNch5yOPfkVrDvb2io6JxObuTTMwUe2FCl7MYcLRaYQhq
 BKXoaXeSSkaDS6kBCOLB2vAjmyObNJbQtF12GsZ/io2n47s7fTBljYCwPpZ0q4JCZALc
 7a4mhqUoOy/opfPRORtyqBo9vT4hfV+I48DkdzWNkgbxcD1fgeGEkVRLVtU639FOszsO
 1ZR7ii4LopgaYKKibVJasI5PbFbpiFMTldMnyFt787rcT7nuXbfuPVPAGKTxz2Bw09oW
 OzD8W9h61dBsarVOqOsln3+qgTZcZKGUHfa4EdFuFGAD5sScTyl6mUKzZj6slrCx0lfy
 /3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761004216; x=1761609016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qc6d0Fejx/5V39Ubz2j+y4zGnbVtOL1bnUPsm5G3FPA=;
 b=AU3Npe7PbJ1UJWkcltaqwD8HOVSJCite27HtTbazDv+InFJgdDOU6cMT7Dbql2Q54L
 uV0JF7HbzU359+WUU/2K3iqhHkmNeze4CNwG5jMwyKBI/qH8mi243EVoaTWwIbXmxWzQ
 uy4r9w/pn+41kZeykklfQh0ZixoA53Fpbc6BSfn/5wIecI4O/k/RVdgIyKHQ1HxCX4se
 DNrHRV5E+4rNUfpMOihHo/8jpLckIQf60VYM1nsHawOFKZh8Bs1O8d+Qst+QeK4YPYhq
 CobHbwnviz7jAUqJzz3TVedi8p98v5Us4520g1bnxn7DHZEm0SbsCyJvQ5imCrrQAQhu
 a9cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfANJdQ0s3NBZlDMxgU1DlGzuOENlpEJV7OEnwBwCOYYr5UimoDbN2hU7XFwL+FpDYkbhsyte5pm+3@nongnu.org
X-Gm-Message-State: AOJu0YyUZNi96hAerlPhWzswPZn+WwPj2TbPl36wxyo135yroioxT/eR
 q7hBcrtiiYLmjd2eOn0O+h2w30GlfgNq8912XrUHymHwFknie03s1KeGLoWN7BE9i2FVnrckwcW
 xJ8TJ/v+IrQ6nZio1boeFRRHEXoT+Jgk=
X-Gm-Gg: ASbGnctice0O0o2SU/5klNG3SUDgUEUdGYXODD5o9FK9C2w546eYe44Vz0nixkXjREx
 iIScHtEKZeZHMAPpQ78KD5OOl5FHdWToKzP85zhZAc+gY/ADeRPBCDoYFwqMra2DFPnOYjhDoKv
 RZmWXhotO1CQEQ1EZ0AGHnUyl+zuqYiFbRmaT20QpCPcF6X6wY7b6HupOiaP7YGkqjgJgbl0VHI
 2gVrTWGEVWGqywBkDwKa6IAGp6OpiRbkLoXphw5jKbJ4Bcz4IjEbtccsT3gGiE7sIFyly4=
X-Google-Smtp-Source: AGHT+IGNQwsOIhyuLQQe9DWb/KqnfyUXCPOAS30ujarmcQKsf19jG0UsBaSL8FZbj5UbQo01LKx/piBvdJdtfYUqr3A=
X-Received: by 2002:a05:6602:487:b0:93e:3805:4683 with SMTP id
 ca18e2360f4ac-93e7622fc91mr2558113439f.1.1761004215700; Mon, 20 Oct 2025
 16:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-20-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-20-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:50:05 -0400
X-Gm-Features: AS18NWD4olMq9kC630eou0008JEw-IsOs4jXMBG3hNE2QfLeXXWcxKM9oW1SZBc
Message-ID: <CAFubqFse1Q0YhHo6Qmrv7KrqJgjw0Zcx4QhueZh4u0PVjGOBVA@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] vhost: support backend-transfer migration
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

Overall looks good. Just a nit.

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Thu, Oct 16, 2025 at 7:44=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Introduce vhost_dev.backend_transfer field,
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 121 +++++++++++++++++++++++++++++++++-----
>  include/hw/virtio/vhost.h |   7 +++
>  2 files changed, 113 insertions(+), 15 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 63036f8214..c46203eb9c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1325,6 +1325,8 @@ out:
>      return ret;
>  }
>
> +static void vhost_virtqueue_error_notifier(EventNotifier *n);
> +
>  int vhost_virtqueue_start(struct vhost_dev *dev,
>                            struct VirtIODevice *vdev,
>                            struct vhost_virtqueue *vq,
> @@ -1350,7 +1352,13 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          return r;
>      }
>
> -    vq->num =3D state.num =3D virtio_queue_get_num(vdev, idx);
> +    vq->num =3D virtio_queue_get_num(vdev, idx);
> +
> +    if (dev->backend_transfer) {
> +        return 0;
> +    }
> +
> +    state.num =3D vq->num;
>      r =3D dev->vhost_ops->vhost_set_vring_num(dev, &state);
>      if (r) {
>          VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
> @@ -1428,6 +1436,10 @@ static int do_vhost_virtqueue_stop(struct vhost_de=
v *dev,
>
>      trace_vhost_virtque_stop_in(dev, vdev->name, idx);
>
> +    if (dev->backend_transfer) {
> +        return 0;
> +    }
> +
>      if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return 0;
> @@ -1565,10 +1577,14 @@ fail_call:
>
>  static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>  {
> -    event_notifier_cleanup(&vq->masked_notifier);
> +    if (!vq->dev->backend_transfer) {
> +        event_notifier_cleanup(&vq->masked_notifier);
> +    }
>      if (vq->dev->vhost_ops->vhost_set_vring_err) {
>          event_notifier_set_handler(&vq->error_notifier, NULL);
> -        event_notifier_cleanup(&vq->error_notifier);
> +        if (!vq->dev->backend_transfer) {
> +            event_notifier_cleanup(&vq->error_notifier);
> +        }
>      }
>  }
>
> @@ -1635,6 +1651,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>
>      hdev->vdev =3D NULL;
>      hdev->migration_blocker =3D NULL;
> +    hdev->_features_wait_incoming =3D true;
>      hdev->busyloop_timeout =3D busyloop_timeout;
>
>      for (i =3D 0; i < hdev->nvqs; ++i) {
> @@ -1717,6 +1734,8 @@ int vhost_dev_connect(struct vhost_dev *hdev, Error=
 **errp)
>          goto fail;
>      }
>
> +    hdev->_features_wait_incoming =3D false;
> +
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>          r =3D vhost_virtqueue_connect(hdev->vqs + i, hdev->vq_index + i)=
;
>          if (r < 0) {
> @@ -1808,8 +1827,11 @@ void vhost_dev_disable_notifiers_nvqs(struct vhost=
_dev *hdev,
>       */
>      memory_region_transaction_commit();
>
> -    for (i =3D 0; i < nvqs; ++i) {
> -        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_inde=
x + i);
> +    if (!hdev->backend_transfer) {
> +        for (i =3D 0; i < nvqs; ++i) {
> +            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
> +                                             hdev->vq_index + i);
> +        }
>      }
>      virtio_device_release_ioeventfd(vdev);
>  }
> @@ -1967,6 +1989,11 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>  {
>      const int *bit =3D feature_bits;
>
> +    if (hdev->_features_wait_incoming) {
> +        /* Excessive set is enough for early initialization. */
> +        return;
> +    }
> +
>      while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
>          if (!vhost_dev_has_feature_ex(hdev, *bit)) {
>              virtio_clear_feature_ex(features, *bit);
> @@ -2001,6 +2028,54 @@ const VMStateDescription vmstate_backend_transfer_=
vhost_inflight =3D {
>      }
>  };
>
> +const VMStateDescription vmstate_vhost_virtqueue =3D {
> +    .name =3D "vhost-virtqueue",
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_EVENT_NOTIFIER(error_notifier, struct vhost_virtqueue),
> +        VMSTATE_EVENT_NOTIFIER(masked_notifier, struct vhost_virtqueue),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static int vhost_dev_post_load(void *opaque, int version_id)
> +{
> +    struct vhost_dev *hdev =3D opaque;
> +    Error *err =3D NULL;
> +    int i;
> +
> +    if (!check_memslots(hdev, &err)) {
> +        error_report_err(err);
> +        return -EINVAL;
> +    }
> +
> +    hdev->_features_wait_incoming =3D false;
> +
> +    if (hdev->vhost_ops->vhost_set_vring_err) {
> +        for (i =3D 0; i < hdev->nvqs; ++i) {
> +            event_notifier_set_handler(&hdev->vqs[i].error_notifier,
> +                                       vhost_virtqueue_error_notifier);
> +        }
> +    }
> +

nit: spurious newline

> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_vhost_dev =3D {
> +    .name =3D "vhost-dev",
> +    .post_load =3D vhost_dev_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT64(_features, struct vhost_dev),
> +        VMSTATE_UINT64(max_queues, struct vhost_dev),
> +        VMSTATE_UINT32_EQUAL(nvqs, struct vhost_dev, NULL),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(vqs, struct vhost_dev,
> +                                             nvqs,
> +                                             vmstate_vhost_virtqueue,
> +                                             struct vhost_virtqueue),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bi=
ts,
>                             const uint64_t *features)
>  {
> @@ -2127,19 +2202,24 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtI=
ODevice *vdev, bool vrings)
>      hdev->started =3D true;
>      hdev->vdev =3D vdev;
>
> -    r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> -    if (r < 0) {
> -        goto fail_features;
> +    if (!hdev->backend_transfer) {
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
> +    if (!hdev->backend_transfer) {
> +        r =3D hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
> +            goto fail_mem;
> +        }
>      }
>      for (i =3D 0; i < hdev->nvqs; ++i) {
>          r =3D vhost_virtqueue_start(hdev,
> @@ -2179,13 +2259,13 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtI=
ODevice *vdev, bool vrings)
>          }
>          vhost_dev_elect_mem_logger(hdev, true);
>      }
> -    if (vrings) {
> +    if (vrings && !hdev->backend_transfer) {
>          r =3D vhost_dev_set_vring_enable(hdev, true);
>          if (r) {
>              goto fail_log;
>          }
>      }
> -    if (hdev->vhost_ops->vhost_dev_start) {
> +    if (hdev->vhost_ops->vhost_dev_start && !hdev->backend_transfer) {
>          r =3D hdev->vhost_ops->vhost_dev_start(hdev, true);
>          if (r) {
>              goto fail_start;
> @@ -2207,6 +2287,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>      }
>      vhost_start_config_intr(hdev);
>
> +    hdev->backend_transfer =3D false;
> +
>      trace_vhost_dev_start_out(hdev, vdev->name);
>      return 0;
>  fail_iotlb:
> @@ -2262,9 +2344,18 @@ static int do_vhost_dev_stop(struct vhost_dev *hde=
v, VirtIODevice *vdev,
>      if (hdev->vhost_ops->vhost_dev_start) {
>          hdev->vhost_ops->vhost_dev_start(hdev, false);
>      }
> -    if (vrings) {
> +    if (vrings && !hdev->backend_transfer) {
>          vhost_dev_set_vring_enable(hdev, false);
>      }
> +
> +    if (hdev->backend_transfer) {
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
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 94a0c75fc8..55ad822848 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -105,6 +105,9 @@ struct vhost_dev {
>      VIRTIO_DECLARE_FEATURES(_features);
>      VIRTIO_DECLARE_FEATURES(acked_features);
>
> +    bool _features_wait_incoming;
> +    bool backend_transfer;
> +
>      uint32_t busyloop_timeout;
>      uint64_t max_queues;
>      uint64_t backend_cap;
> @@ -592,4 +595,8 @@ extern const VMStateDescription vmstate_backend_trans=
fer_vhost_inflight;
>      VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
>                             struct vhost_inflight)
>
> +extern const VMStateDescription vmstate_vhost_dev;
> +#define VMSTATE_BACKEND_TRANSFER_VHOST(_field, _state) \
> +    VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_dev, struct vhost_de=
v)
> +
>  #endif
> --
> 2.48.1
>
>

