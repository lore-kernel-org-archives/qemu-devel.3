Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD1BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vzu-0000yo-VB; Thu, 09 Oct 2025 15:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzt-0000tE-JJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:17 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzq-0007I5-Q2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:17 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-428551be643so10647785ab.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036893; x=1760641693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TES5Uk47HAGmPj2IwfQVftKKhI5oHrfzF2VZM9BcykA=;
 b=hZJU5m0VPUs1J9ZlbJf1U7Zg9sROnlf2rqaB7zBq/HbFmgViYXrL44GeTrafOuJ5yz
 mvyxRVbwP7kaWzZeCfvUaVb1347a4JXq9Fr7UQ3ycUOFVwgV35LuvOMHOjkIMEJrxWa6
 CvrKV+zRm2NoYgBalmEDlX4qUCs/l81agcfmvU+bMIrEr5FrCySlqEboTaziORkhPxF5
 ASPiJI8pJaCh50ZQbLXD9b1Fz1P2KpgHIhe35PXnXidVPKFPXi5xZB0Wal0n3V+iJxWp
 GVCrMWgZph8Z7lh0PEcMIjKKuuPbc9ZgaHGHjT7fDo0iGSyCmf6OCeIKKLdtTR+WajOL
 sa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036893; x=1760641693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TES5Uk47HAGmPj2IwfQVftKKhI5oHrfzF2VZM9BcykA=;
 b=SRDByIAs1fhICAG4ycMRH0zPyJ8d5Zg1tRP/JzXAGsjXbdcTACXZR/88dSui38jjCv
 DebVqur8f0vfEg5/o+HzmaB8aMYNG3O+KdZxt+AmDo/CABUnImxUJT7KdnWPRSNWTWnr
 r/HvRMlhSNg/Ydp/Jqfwm0nhBGwe0Mh/zvn+qdZ8JrI21dbdvndzpPJOZbUex66edGqs
 rxDRRqaYz9ae1SPGrdd/qx5lYZCeZU2zcGrN3UkQyRDdrKt1dGYZXZiJCicRzEOZtpCn
 FJQEMCqO80btZkdmHC7/tvxE89R/ZdIYqa8aqccJKh7hJnP+Hm3hO89l8LXwaGA7pMBW
 73vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5N1zUhxB3qFWpaew/jaBIyoCg2DQndlm6II4VW6jJZaoKGz0OWDLaCHEi2J6FJ/N5l9IU1aX7nMo@nongnu.org
X-Gm-Message-State: AOJu0YxKUEEqtxXSJDOrt5vBvWRVEeAOzXPtPBCRJILacDtBeFHVwgsN
 EFVXpCx4RDonWw6IrJ3OXGf9zLbcmt/grZMOZUo0FxPBeTZoKQu02rLhkt+EUYLmNQl/rXiiOmn
 D66eO5NmrXsXV1yJsdsh3blNP78vCkVY=
X-Gm-Gg: ASbGncu+8b31w+6PKv+wpC+E6+c/dIxedtNh3IZbezhgAipo57Lwl+KCWg5B2xGiKo8
 98bQRWNKEO+mOD6NRbc4dM2nA4De0DbYA8HNuH3XWbVZ+/+qkf87pKvCqYx1Kl8rNFgObnhMmd6
 72wXPoMh03TY5EDXl6bb2HE4kJaxsd2zVfXlLjVaepP1ajIvaZW8MqFRsdSPG6fZxdzxHunokTu
 +ZoW23KpIHwKrI28pSBU+PuBRYx9qw=
X-Google-Smtp-Source: AGHT+IE9hweEoTU8m180oyoAa5svNebzIlHNsOMDOZEAUdgo0vY81Yd1NkWR2AYiiVwaoYgHjhjX3NZtESA5iFtx1Uw=
X-Received: by 2002:a05:6e02:19ca:b0:425:8c47:13fb with SMTP id
 e9e14a558f8ab-42f873d1c2dmr87879635ab.17.1760036892849; Thu, 09 Oct 2025
 12:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-23-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-23-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:07:59 -0400
X-Gm-Features: AS18NWDRVwGgkMkLT-6_DrTbDvnDB9lD8rYUL0u2sQ_VDKmvWLJCxDBYOkJp4Os
Message-ID: <CAFubqFvT4ivi3mWX8R2CL8Lu5XTyyo67f9KGFMCGT3Qo1F9SZQ@mail.gmail.com>
Subject: Re: [PATCH 22/33] vhost-user-blk: add some useful trace-points
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x129.google.com
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

On Wed, Aug 13, 2025 at 1:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/trace-events     | 10 ++++++++++
>  hw/block/vhost-user-blk.c | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index cc9a9f2460..3b5fd2a599 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -58,6 +58,16 @@ virtio_blk_handle_zone_mgmt(void *vdev, void *req, uin=
t8_t op, int64_t sector, i
>  virtio_blk_handle_zone_reset_all(void *vdev, void *req, int64_t sector, =
int64_t len) "vdev %p req %p sector 0x%" PRIx64 " cap 0x%" PRIx64 ""
>  virtio_blk_handle_zone_append(void *vdev, void *req, int64_t sector) "vd=
ev %p req %p, append sector 0x%" PRIx64 ""
>
> +# vhost-user-blk.c
> +vhost_user_blk_start(void) ""
> +vhost_user_blk_start_finish(void) ""
> +vhost_user_blk_stop(void) ""
> +vhost_user_blk_stop_finish(void) ""
> +vhost_user_blk_connect(void) ""
> +vhost_user_blk_connect_finish(void) ""
> +vhost_user_blk_device_realize(void) ""
> +vhost_user_blk_device_realize_finish(void) ""

Should we also trace the VirtIODevice/vdev pointer like in virtio-blk.c?


> +
>  # hd-geometry.c
>  hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p=
 LCHS %d %d %d"
>  hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t sec=
s, int trans) "blk %p CHS %u %u %u trans %d"
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index de7a810c93..c8bc2c78e6 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -31,6 +31,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "system/system.h"
>  #include "system/runstate.h"
> +#include "trace.h"
>
>  static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_SIZE_MAX,
> @@ -137,6 +138,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, E=
rror **errp)
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int i, ret;
>
> +    trace_vhost_user_blk_start();
> +
>      if (!k->set_guest_notifiers) {
>          error_setg(errp, "binding does not support guest notifiers");
>          return -ENOSYS;
> @@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, E=
rror **errp)
>      }
>      s->started_vu =3D true;
>
> +    trace_vhost_user_blk_start_finish();
> +
>      return ret;
>
>  err_guest_notifiers:
> @@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      int ret;
>      bool force_stop =3D false;
>
> +    trace_vhost_user_blk_stop();
> +
>      if (!s->started_vu) {
>          return 0;
>      }
> @@ -233,6 +240,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      }
>
>      vhost_dev_disable_notifiers(&s->dev, vdev);
> +
> +    trace_vhost_user_blk_stop_finish();
>      return ret;
>  }
>
> @@ -340,6 +349,8 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      int ret =3D 0;
>
> +    trace_vhost_user_blk_connect();
> +
>      if (s->connected) {
>          return 0;
>      }
> @@ -365,6 +376,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>          ret =3D vhost_user_blk_start(vdev, errp);
>      }
>
> +    trace_vhost_user_blk_connect_finish();
>      return ret;
>  }
>
> @@ -455,6 +467,8 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>      int retries;
>      int i, ret;
>
> +    trace_vhost_user_blk_device_realize();
> +
>      if (!s->chardev.chr) {
>          error_setg(errp, "chardev is mandatory");
>          return;
> @@ -514,6 +528,7 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>      qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
>                               vhost_user_blk_event, NULL, (void *)dev,
>                               NULL, true);
> +    trace_vhost_user_blk_device_realize_finish();
>      return;
>
>  virtio_err:
> --
> 2.48.1
>
>

