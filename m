Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E10CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8PaO-0006EN-4Z; Mon, 13 Oct 2025 16:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PaE-0006DK-Ga
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:55:54 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PaC-00058f-Oj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:55:54 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-912d4135379so185821539f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760388951; x=1760993751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYLsMujuabucDj/D4IzgtfOlkyq0fID9CmSOmrLBku0=;
 b=aIQ3a9RnCc/YG8J2MvIZhi8yqbZ9ALkNQjQMDstDrSOGoBLhDzitks37gia9QUaQdQ
 1g4HjV0dlMJTjAJN97gMvNnI0IcQQZnQEaw9pk5gFoyxpeSH0Wi/+5ut4ggyCWfYcGcc
 FJX21YdonUVutBw+R1AHaEjorDYHPvc9aHPdlUKPzzoPRcLsTxCiP48MeibAsjOT9GzO
 CfwXv2li4jCOpd+pDRc9X+F6ctlFo2wldkW/aiiXV6n7qANGvaXxFAUx/7DwXuDUXZ4e
 rr2i/hJ2EJmo35bw6Be2kw24iG5iOW+jVuAOWlr+MiS8wosqF3ECAxAEf6eF40I9mL8B
 h4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760388951; x=1760993751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYLsMujuabucDj/D4IzgtfOlkyq0fID9CmSOmrLBku0=;
 b=vF5T44FUT60nIbgNZCulXEfM1KBGcsdeflhp6aRv2PynXwt3qPnjXFyGpXXAtwtH/p
 GEbdZI3x6DZqsPmJaAvIEr7fgiP/EmuWkybvTm83ZcP2OjHUjEz4JyAYlM9JZiHxgKjs
 tH39sCGhVet6eECB1tj7Oe6CFBQXkKWvYdWRkyLwVbQf96i1MhEsQlcdNxh9eFEwL3YI
 F08Q8VZDI2hcvRlGZsQsgZm3wg6fE3z6eZLymWTWTQ/8ics32WQchZIrfJKb8FrwhE9Z
 tEPf3NAwYwveV0khWsnxpPakq83msG/Ot0K2OjixaaqQAEgbIKz1eEtucxYS8KrY8ivp
 G3vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOHxEs8MtwtqFGO4g3ddw2StOzIvnKOmKydatvgafIXKAXGHLs/w6ffmPETz5Cy4kgvCadPWMyCfTB@nongnu.org
X-Gm-Message-State: AOJu0YynwQO0brrgWesv4Pb1uVI1kdWiCnNp516CPAXnkwFI01O1kv5x
 GD+tkcUJvzyGceleXh6S4gMxh8bGxeBbTrPwRRzQKiHJG1rk02diBwwn/J1dMRK8DppmuzxX3GN
 6RygCheClMcgFrTkQqFhKcXokMN7p5AI=
X-Gm-Gg: ASbGncvaYrFfbMbOz0+tdRbRvrE4j8g1yT/5m5oUtlY5fGCHhinVF3RZQ5wkBNUyf6T
 o6vFjPn2XqM6LwjHyz+8xa/6iBs49FskW22Pj53+PEqvBawjHud4l5YjnxP3ceNy7np10YJ2+g2
 Huo5Jipi+kbQpqbGx3u1VqKWHuaMfiQWTxSIetoKgHcXOEZcR/nT8nUhOxhI3FvlCgC7wS80LGx
 LZ9mnZMlrwZMMA7WuCXYxTR/A==
X-Google-Smtp-Source: AGHT+IH6RRdmQz7HlL1FsMJpK5mPkN+j1Bn50JvftlYgAOjGwg8N1f2gbBZIRS3yS/5leNDLSnfPDSwVlCMmympbuPs=
X-Received: by 2002:a05:6e02:1c24:b0:42f:a60a:854c with SMTP id
 e9e14a558f8ab-42fa60a8890mr125551135ab.26.1760388951369; Mon, 13 Oct 2025
 13:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-23-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-23-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:55:40 -0400
X-Gm-Features: AS18NWCI0C-PfzATkMoiuXdpvkaTj1-yZEdqEAAyX1_-gpOZ70XKP09JO4DRmU8
Message-ID: <CAFubqFto6=kuUCNUJ1q41x57FWb=BDDyNGPaEuDKtrHh7Gwucg@mail.gmail.com>
Subject: Re: [PATCH v2 22/23] vhost-user-blk: add some useful trace-points
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/trace-events     | 10 ++++++++++
>  hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index cc9a9f2460..dbaa5ca6cb 100644
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
> +vhost_user_blk_start_in(void *vdev) "vdev %p"
> +vhost_user_blk_start_out(void *vdev) "vdev %p"
> +vhost_user_blk_stop_in(void *vdev) "vdev %p"
> +vhost_user_blk_stop_out(void *vdev) "vdev %p"
> +vhost_user_blk_connect_in(void *vdev) "vdev %p"
> +vhost_user_blk_connect_out(void *vdev) "vdev %p"
> +vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
> +vhost_user_blk_device_realize_out(void *vdev) "vdev %p"
> +
>  # hd-geometry.c
>  hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p=
 LCHS %d %d %d"
>  hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t sec=
s, int trans) "blk %p CHS %u %u %u trans %d"
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index de7a810c93..a5daed4346 100644
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
> +    trace_vhost_user_blk_start_in(vdev);
> +
>      if (!k->set_guest_notifiers) {
>          error_setg(errp, "binding does not support guest notifiers");
>          return -ENOSYS;
> @@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, E=
rror **errp)
>      }
>      s->started_vu =3D true;
>
> +    trace_vhost_user_blk_start_out(vdev);
> +
>      return ret;
>
>  err_guest_notifiers:
> @@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      int ret;
>      bool force_stop =3D false;
>
> +    trace_vhost_user_blk_stop_in(vdev);
> +
>      if (!s->started_vu) {
>          return 0;
>      }
> @@ -233,6 +240,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      }
>
>      vhost_dev_disable_notifiers(&s->dev, vdev);
> +
> +    trace_vhost_user_blk_stop_out(vdev);
> +
>      return ret;
>  }
>
> @@ -340,6 +350,8 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      int ret =3D 0;
>
> +    trace_vhost_user_blk_connect_in(vdev);
> +
>      if (s->connected) {
>          return 0;
>      }
> @@ -365,6 +377,8 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>          ret =3D vhost_user_blk_start(vdev, errp);
>      }
>
> +    trace_vhost_user_blk_connect_out(vdev);
> +
>      return ret;
>  }
>
> @@ -455,6 +469,8 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>      int retries;
>      int i, ret;
>
> +    trace_vhost_user_blk_device_realize_in(vdev);
> +
>      if (!s->chardev.chr) {
>          error_setg(errp, "chardev is mandatory");
>          return;
> @@ -514,6 +530,9 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>      qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
>                               vhost_user_blk_event, NULL, (void *)dev,
>                               NULL, true);
> +
> +    trace_vhost_user_blk_device_realize_out(vdev);
> +
>      return;
>
>  virtio_err:
> --
> 2.48.1
>

