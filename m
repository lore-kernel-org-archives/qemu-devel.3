Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D0CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzhs-0004yM-Uz; Mon, 20 Oct 2025 19:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzhq-0004s2-GF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:54:27 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzhk-0003Ah-Eh
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:54:25 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-93e7e87c21bso348201239f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761004451; x=1761609251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLCFbH5UK489ri+sOARFv/fd0ar57JPXIiELvV1Tvpo=;
 b=kv7QFDy6boEpGhXnZ+33CEFXKEL/ly5UWo1Ia1sQLQSUQxBAyqrld51Rjy/5S+mZOI
 vakqBANbw+7C6TVToJ5rZwJzNZBXFUHWiwkSU4hdt2626wwhc+52uMz5MYVBxL6YT5dT
 SWA3NweR9v24+UskTqu/dFjZMIsLbdwH6o6q8mHIAHTZaW2/Z3hUYIKHqKZgpfV24sXY
 2ffne4NR7FDyRurFGHAQprdq6HwsJn3/Sh5MAcfmhTadaH5KqwQ2/LschahbunxUKUJR
 DqFSq14b9OfdQ6crA4TKUlOh7uVkdd10KC3JUlJ9Dsh3apRGSm1+ec0X0bmwaJIO6PK2
 VDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761004451; x=1761609251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLCFbH5UK489ri+sOARFv/fd0ar57JPXIiELvV1Tvpo=;
 b=sg22oVu+iEJDkMz0Cp2oADRTLP/FT9JvOFQgTjX9neY6zXGJFxaPuSs7/191hhAM1q
 /20HW07R8BIaqVX6JaO2qnKWrtktFZsOEIocMU5ulVh6VZYbaia0FQXt1xA/SvYbubsJ
 eYtftrz9CmKggQVq1ibQr8Q/0XxnMxJm+tg0GrcTPn6IOZCXSUqGrivp4z1Pxs3JZhfi
 OnuBIWiuOATL6yuYeFV4S33gcoPuvZX3WJ5IcwBVu0aO5lT1GpPCH8qONz85Ja5+MlJP
 Ch5YHXsqUg6sdQBE8xVqaSV/tod1+TjRpx+hU5sffE4vphpGZJZuoRvr2GzTbwKLrZ5m
 /4ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5fPCNKWy+MoG4JocldnnSNhdFP2bh/P5CJyMYnaz4BgBPiYs0UpEfUjIQyuVi8R/+IMnVLz3NRfDi@nongnu.org
X-Gm-Message-State: AOJu0Yx/Fzc/B7XO726V2TqZmGRcwofo2crlYndLR0RSsaFAqZc6D1AY
 u0gkMijgl2x4Y0OM2FDYoN+Xy6jABKcVxT+PV4QGf3rcH6dZcVHPCY6GT/Zf0GK6KW5EWihhz9g
 WfAQjsgAbZE82mE10xFbeJKDnMl3BJvo=
X-Gm-Gg: ASbGncssyPZJTRaCt01gAVej4h1bbyMiAnzq0JbCF6cO6F4tGZ5Ne7zh7JCQkP2X3Oj
 g2DjlAGyO1Z7cVpTo2vPRATzb26S9f1cc+MFKh/c45Z/FW+IYIlSmhmMA8D8FLrVvyofJZRLLxp
 xS8ArT/6X9Jsk9Gn9MC1ClVQ/8ue7sdgbNx2tlWfzkQ33fSgXAOL+4PVb9U5NE2RyatLpOgUd7Y
 C2HJlb+2JYKDREl2pjyrSMTjrkG75QzG7bYg4EkfWFqwROtFxLTShMIkvCzxe3xIW96GcKHtPvv
 aiPCag==
X-Google-Smtp-Source: AGHT+IEZZOtj3oZDkzEvVxmyj5AFU03NkRcm5YmSU+Wdu7XUTMrQ9h2ANdzY7DeYtWr6w7RxwrTU2glj2PViZILk6hg=
X-Received: by 2002:a05:6e02:156c:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-430c524e127mr218776855ab.7.1761004450643; Mon, 20 Oct 2025
 16:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-25-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-25-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:53:59 -0400
X-Gm-Features: AS18NWDz1nNSgqwBjsk5uWbLIhFLDbJLAUK9RFgbi1zrLSzzUAbSE2nWiJfzLrw
Message-ID: <CAFubqFsNxUxg5c=4j2D3RFHT-E=EvLfjvJ4jV7HYu0mZE+WTPw@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] vhost-user-blk: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Overall looks ok. A couple comments

On Thu, Oct 16, 2025 at 7:49=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Opt-out backend initialization code, and instead get the state
> from migration channel (including inflight region).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 129 ++++++++++++++++++++++++-----
>  include/hw/virtio/vhost-user-blk.h |   2 +
>  include/hw/virtio/vhost.h          |   3 +-
>  3 files changed, 111 insertions(+), 23 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index ffdd600526..a8fd90480a 100644
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
> @@ -31,7 +32,13 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "system/system.h"
>  #include "system/runstate.h"
> +#include "chardev/char-backend-transfer.h"
>  #include "trace.h"
> +#include "migration/qemu-file.h"
> +#include "migration/migration.h"
> +#include "migration/options.h"
> +#include "qemu/event_notifier.h"
> +#include <sys/mman.h>
>
>  static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_SIZE_MAX,
> @@ -160,32 +167,35 @@ static int vhost_user_blk_start(VirtIODevice *vdev,=
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
> +    if (!s->dev.backend_transfer) {
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
> @@ -232,6 +242,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
>                   qemu_force_shutdown_requested();
>
> +    s->dev.backend_transfer =3D s->dev.backend_transfer ||
> +        (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
> +         migrate_local_vhost_user_blk());
> +
>      ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
>                         vhost_dev_stop(&s->dev, vdev, true);
>
> @@ -391,6 +405,7 @@ static int vhost_user_blk_connect(DeviceState *dev,
>      trace_vhost_user_blk_connect_in(vdev);
>
>      assert(!s->connected);
> +    assert(!s->dev.backend_transfer);
>
>      ret =3D vhost_dev_connect(&s->dev, errp);
>      if (ret < 0) {
> @@ -464,6 +479,9 @@ static int vhost_user_blk_realize_connect(VHostUserBl=
k *s, Error **errp)
>      DeviceState *dev =3D DEVICE(s);
>      int ret;
>
> +    assert(!s->connected);
> +    assert(!s->dev.backend_transfer);
> +
>      ret =3D qemu_chr_fe_wait_connected(&s->chardev, errp);
>      if (ret < 0) {
>          return ret;
> @@ -642,7 +660,13 @@ static bool vhost_user_blk_pre_incoming(void *opaque=
, Error **errp)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(opaque);
>
> -    return vhost_user_blk_realize_connect(s, errp) =3D=3D 0;
> +    s->dev.backend_transfer =3D migrate_local_vhost_user_blk();
> +
> +    if (!s->dev.backend_transfer) {
> +        return vhost_user_blk_realize_connect_loop(s, errp) >=3D 0;
> +    }
> +
> +    return true;
>  }
>
>  static const VMStateDescription vmstate_vhost_user_blk =3D {
> @@ -656,6 +680,64 @@ static const VMStateDescription vmstate_vhost_user_b=
lk =3D {
>      },
>  };
>

Rename vhost_user_blk_needed()?

> +static bool vhost_user_needed(void *opaque)
> +{
> +    return migrate_local_vhost_user_blk();
> +}
> +
> +static const VMStateDescription vmstate_vhost_user_blk_device =3D {
> +    .name =3D "vhost-user-blk-device",
> +    .version_id =3D 1,
> +    .needed =3D vhost_user_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_BACKEND_TRANSFER_CHARDEV(chardev, VHostUserBlk),
> +        VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(inflight, VHostUserBlk),
> +        VMSTATE_BACKEND_TRANSFER_VHOST_USER(dev, VHostUserBlk),
> +        VMSTATE_BACKEND_TRANSFER_VHOST(dev, VHostUserBlk),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static int vhost_user_blk_post_load(VirtIODevice *vdev)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    struct vhost_dev *hdev =3D vhost_user_blk_get_vhost(vdev);
> +    DeviceState *dev =3D &s->parent_obj.parent_obj;
> +
> +    if (!hdev->backend_transfer) {
> +        return 0;
> +    }
> +
> +    s->connected =3D true;
> +
> +    memcpy(&s->blkcfg, vdev->config, vdev->config_len);
> +
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        int ret;
> +        ret =3D vhost_user_blk_start(vdev, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
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
>      DEFINE_PROP_CHR_NO_CONNECT("chardev", VHostUserBlk, chardev),
>      DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> @@ -688,6 +770,9 @@ static void vhost_user_blk_class_init(ObjectClass *kl=
ass, const void *data)
>      vdc->set_status =3D vhost_user_blk_set_status;
>      vdc->reset =3D vhost_user_blk_reset;
>      vdc->get_vhost =3D vhost_user_blk_get_vhost;
> +    vdc->vmsd =3D &vmstate_vhost_user_blk_device;
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

Why do we need incoming_backend? Looks like it is unused.


> +
> +    bool incoming_backend;
>  };
>
>  #endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 55ad822848..13ca2c319f 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -592,7 +592,8 @@ static inline int vhost_load_backend_state(struct vho=
st_dev *dev, QEMUFile *f,
>
>  extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
>  #define VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(_field, _state) \
> -    VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
> +    VMSTATE_STRUCT_POINTER(_field, _state, \
> +                           vmstate_backend_transfer_vhost_inflight, \
>                             struct vhost_inflight)
>
>  extern const VMStateDescription vmstate_vhost_dev;
> --
> 2.48.1
>
>

