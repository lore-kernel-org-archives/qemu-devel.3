Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7EBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w1G-0003X6-EC; Thu, 09 Oct 2025 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1F-0003VN-39
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:41 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w1C-0007PP-Kx
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:09:40 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-92aee734485so52412939f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036976; x=1760641776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8X37u7lrCUJ9h9Iqm9Xbut2vhy3JqBf630j4O+SF2g=;
 b=QQ1MkF94IFdS/dNXv00O9I4GTUJKefgArvUg94obCMzT0YAiCxhI9XNew/GLUc7Ikv
 97j6j1CzQwHuc2CXJvNakRJvO1VCTbgj//C7z/+9txu5h+UaHZ0r2BGLobKGr/aHDWNP
 U3EsEY92zIHVCgrsaynKkNKXCPHKIH71IvSsjIAe4hsbeWPSvnnzftQccnmgnp8gGt7e
 d/mLTKn3q/JRCytBgHVPmnLUPmNwlm39F7cpngZqMgddavzlrmPhpj++qhgKOCl21nkz
 JA0EwhpxqQb5ItjZZOg476YrcqYYPmdSS05dv51EmIz7HYyVQyAy750JJ0cbGqaFd/k+
 zp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036976; x=1760641776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8X37u7lrCUJ9h9Iqm9Xbut2vhy3JqBf630j4O+SF2g=;
 b=YsnjWq5Uxl9cxAkNI8bDU4mJNtkBIf0+N7eVdnE0tL71krqT6Dy8PrFk7huRSwKgzQ
 hkckAgsfVxLEMk3SXooiZCL8Jt0nACTOFI31EZJ9jvDkXqgcrKeZq/5doyaOC5je1ZfE
 vQNiCUijqdsR1/3Ebl/uXhm+R7UWB0ygYTk0pI8/W8A/FxQ8d0gGGXPBFXAleRvrVEdq
 quQ5xITaANSXp6b+RznupyIibD9FpC9qLjClJytIi7f/XKO5hipRYChZhUdrJntAicNy
 9SvILkdcOXPQSLBPT0H0J5NJboWbsEw5Mq35TtwZJu0vRU6ketBRixi9wBf4BS0Qd3B/
 755g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6+phyYz16QfVUDwVXYP1U6xhVKI1xL1S7F+BdCU5FWXYOqs1K0mpNgTqamOBJN0lOtPSQ3C43Cjs@nongnu.org
X-Gm-Message-State: AOJu0YwbXnANOwoVIXrpCJM61AcU++XBr9aMR56UKGCJxsptniuElQOl
 piv/fxi7WCAhe67MQ8qLYN7xWWwN0j+/SNjWWxJhU/ZR6JE4nYt9fJE2OP/IzEBWsdg0Cj+88ms
 9jgDus4SJ9hx2j5xjlHYpy914d5KODIQ=
X-Gm-Gg: ASbGncsmN9aLovI4GKRCsbjohwjQy/WX/Hk1clb1HHKfmbTQPCJBNzd5fpyVviErCDy
 ckyiWjLV7r5XyuWg2Y8jzkWxcWbZQd+JrUMXkHaW87rkIPLont5+8EcMm41tD8HwvzAbvGfvF/H
 fCKkTHKQDPu+2NLTszTN/jqEY8KaC0Zqjw7J4n2QjhzAocWt704bmsLYId38s6u5oQzH/wzbyHw
 hQYD0BEyDceQPEgmTaxZGDaW2Xa6Ns=
X-Google-Smtp-Source: AGHT+IHhFh0yuV4CwuEh/eeqXNrjZ6uncTZmRRRU0sJX9o7r7Cqwk3X1+8EySSuoOyuKOvbGLKkvKL4p6DKu82IUIII=
X-Received: by 2002:a05:6e02:380e:b0:42d:8b1c:572e with SMTP id
 e9e14a558f8ab-42f872ca190mr76168855ab.0.1760036976064; Thu, 09 Oct 2025
 12:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-30-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-30-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:09:24 -0400
X-Gm-Features: AS18NWDBVu4Tw0uLVWqJB3s4Ho6WcPildJMILzl7itgxOgi0Z5arUi19NZyHD4Q
Message-ID: <CAFubqFv6U4MhU4Wjxz2oxodvVHG5eea4knvVrMW+6HY58oC0fg@mail.gmail.com>
Subject: Re: [PATCH 29/33] vhost-user: support backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd29.google.com
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

Just a naming nit.

On Wed, Aug 13, 2025 at 12:54=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> In case of local backend migration, skip backend-related
> initialization, but instead get the state from migration
> channel (including secondary channel file descriptor).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 3979582975..f220af270e 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -28,6 +28,8 @@
>  #include "system/runstate.h"
>  #include "system/cryptodev.h"
>  #include "migration/postcopy-ram.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"
>  #include "trace.h"
>  #include "system/ramblock.h"
>
> @@ -2273,6 +2275,10 @@ static int vhost_user_backend_init(struct vhost_de=
v *dev, void *opaque,
>      u->dev =3D dev;
>      dev->opaque =3D u;
>
> +    if (dev->migrating_backend) {
> +        goto out;
> +    }
> +
>      err =3D vhost_user_get_features(dev, &features);
>      if (err < 0) {
>          error_setg_errno(errp, -err, "vhost_backend_init failed");
> @@ -2387,6 +2393,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>          }
>      }
>

Maybe call the goto target migrating_backend_out or something else to
indicate what it's for.


> +out:
>      u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
>      postcopy_add_notifier(&u->postcopy_notifier);
>
> @@ -2936,6 +2943,10 @@ void vhost_user_async_close(DeviceState *d,
>
>  static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>  {
> +    if (dev->migrating_backend) {
> +        return 0;
> +    }
> +
>      if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
>          return 0;
>      }
> @@ -3105,6 +3116,55 @@ static void vhost_user_qmp_status(struct vhost_dev=
 *dev, VhostStatus *status)
>      status->protocol_features =3D qmp_decode_protocols(u->protocol_featu=
res);
>  }
>
> +static void vhost_user_save(struct vhost_dev *dev, QEMUFile *f)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    bool has_backend_channel =3D !!u->backend_sioc;
> +    qemu_put_be64(f, u->protocol_features);
> +    qemu_put_be32(f, u->user->memory_slots);
> +
> +    qemu_put_byte(f, has_backend_channel);
> +    if (u->backend_sioc) {
> +        qemu_file_put_fd(f, u->backend_sioc->fd);
> +    }
> +}
> +
> +static int vhost_user_load(struct vhost_dev *dev, QEMUFile *f)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    uint8_t has_backend_channel;
> +    uint32_t memory_slots;
> +
> +    qemu_get_be64s(f, &u->protocol_features);
> +    qemu_get_be32s(f, &memory_slots);
> +    qemu_get_8s(f, &has_backend_channel);
> +
> +    u->user->memory_slots =3D memory_slots;
> +
> +    if (has_backend_channel) {
> +        int fd =3D qemu_file_get_fd(f);
> +        Error *local_err =3D NULL;
> +
> +        u->backend_sioc =3D qio_channel_socket_new_fd(fd, &local_err);
> +        if (!u->backend_sioc) {
> +            error_report_err(local_err);
> +            return -ECONNREFUSED;
> +        }
> +        u->backend_src =3D qio_channel_add_watch_source(
> +            QIO_CHANNEL(u->backend_sioc), G_IO_IN | G_IO_HUP,
> +            backend_read, dev, NULL, NULL);
> +    }
> +
> +    if (dev->migration_blocker =3D=3D NULL &&
> +        !vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
> +        error_setg(&dev->migration_blocker,
> +                   "Migration disabled: vhost-user backend lacks "
> +                   "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
> +    }
> +
> +    return 0;
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> @@ -3146,4 +3206,6 @@ const VhostOps user_ops =3D {
>          .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
>          .vhost_check_device_state =3D vhost_user_check_device_state,
>          .vhost_qmp_status =3D vhost_user_qmp_status,
> +        .vhost_save_backend =3D vhost_user_save,
> +        .vhost_load_backend =3D vhost_user_load,
>  };
> --
> 2.48.1
>
>

