Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C221C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7SbO-0006k6-VU; Thu, 16 May 2024 00:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7SbL-0006jR-Up
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:20:20 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7SbJ-0005hQ-Lw
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:20:19 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so83912936d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715833216; x=1716438016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ/jA3bmFbCmciIak5rOQa26USAYzwDhaTglCtCSYjM=;
 b=GHwJicIgmW5wuMQQSWO6KGC+EKKcOBkyB9XoiROMhLiXikr2f8JEgwmWvvm6j6n9xo
 avxSjPDGEuB3jBCMt7q9IK9sQTDWRsrpIWfE46e3zgO8740Op+0jpyJmlvF0w51Xc8zy
 kQWCF1clql/pqkgU41eWEH9QUVvPe3oWX4qlujm3ZZEZ/926T8bWNy0wvqJFTZdxL1qR
 uOPWG6aGUTXCNxDcXPgLfVvW79+J1NZlHaVFH6a5oHg2YAFNQupz0dDIq2cFheKSrgJs
 K35pbWO1f0ATafrd8HOdl1ae9KzGPOcRZmkFqmaPJK1d2s6xl8GCH402frni1E6+UTwE
 h3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715833216; x=1716438016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ/jA3bmFbCmciIak5rOQa26USAYzwDhaTglCtCSYjM=;
 b=lo+V5JAWTE8sefxqIsbqpKdvaJ673YRgpA8C7eVu30LwntuoiuYVyvwmaFyPCdw/4k
 FWHfwTFkQnee1wJytluCH/eb970CTrhcgpF6MMKwuidvVbdKCb8lkHuWKvH+gcQf5B/F
 SCL5siA8nyHBasACv6o4c4Ui9TVE2tP8xy8QU++9dpmW337u7tAM2SQvgfNKqAguuQ02
 5M+PAmwkB1S2z+JRiANjUvJ5Xj4As2g+XIl94RdWOv3nsJwp5Wtsey6nzAGGmNM0cifK
 ipoh0KxYWR7JV9eTauwMD0WnWjMMY7bW3iYqdvmARpAn9FyASfKyBTQd/Uu0VOSuxvIC
 lXIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEVzJ3riqTR9/cHmKI4IxN7zeen1zwAlJUdfy/BLsQ41lmfudmxuH0gevNp6hcUWdgjm3G0GP+vS79s6lenBLZBddzno=
X-Gm-Message-State: AOJu0Yy6Oql3xHC3q4a6TXVG5xjijVRhtstqNK1IBsRWofYVyHYSPlPY
 /yMxZVIbm/7R9kYFyi+ezY8g1lXeSYrqEa377dI1f71pKM6QrajQjuTG963cvnNqxm8CNzbs2Zt
 TEfIuXeKP28NlTZS/mNvW5RCz+XYDZKIQl+X50OSZI3x/v/O7dJ1skg==
X-Google-Smtp-Source: AGHT+IHNVPDiFDLj3SwNVYZuMwJ34ReGYZGnY4cld00pPBBUYHFqowhMhc963prlpBArD1xwGThf5GpmoOO0GSiF2yc=
X-Received: by 2002:a05:6214:53c2:b0:6a3:5bb8:12e6 with SMTP id
 6a1803df08f44-6a35bb81689mr33610036d6.61.1715833216626; Wed, 15 May 2024
 21:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240516025753.130171-1-fengli@smartx.com>
 <20240516025753.130171-2-fengli@smartx.com>
In-Reply-To: <20240516025753.130171-2-fengli@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Thu, 16 May 2024 00:20:06 -0400
Message-ID: <CAMDpr=dDL8p_mh5xiemiAF0QBZMWptF_1EN6PtSCc1E2uTdxoQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Revert "vhost-user: fix lost reconnect"
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=raphael@enfabrica.net; helo=mail-qv1-xf32.google.com
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

On Wed, May 15, 2024 at 10:58=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.
>
> Since the current patch cannot completely fix the lost reconnect
> problem, there is a scenario that is not considered:
> - When the virtio-blk driver is removed from the guest os,
>   s->connected has no chance to be set to false, resulting in
>   subsequent reconnection not being executed.
>
> The next patch will completely fix this issue with a better approach.
>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/block/vhost-user-blk.c      |  2 +-
>  hw/scsi/vhost-user-scsi.c      |  3 +--
>  hw/virtio/vhost-user-base.c    |  2 +-
>  hw/virtio/vhost-user.c         | 10 ++--------
>  include/hw/virtio/vhost-user.h |  3 +--
>  5 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9e6bbc6950..41d1ac3a5a 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEMUCh=
rEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &s->chardev, &s->dev,
> -                               vhost_user_blk_disconnect, vhost_user_blk=
_event);
> +                               vhost_user_blk_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a63b1f4948..48a59e020e 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUC=
hrEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> -                               vhost_user_scsi_disconnect,
> -                               vhost_user_scsi_event);
> +                               vhost_user_scsi_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index a83167191e..4b54255682 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent even=
t)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
> -                               vub_disconnect, vub_event);
> +                               vub_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..c929097e87 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2776,7 +2776,6 @@ typedef struct {
>      DeviceState *dev;
>      CharBackend *cd;
>      struct vhost_dev *vhost;
> -    IOEventHandler *event_cb;
>  } VhostAsyncCallback;
>
>  static void vhost_user_async_close_bh(void *opaque)
> @@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opaque=
)
>       */
>      if (vhost->vdev) {
>          data->cb(data->dev);
> -    } else if (data->event_cb) {
> -        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
> -                                 NULL, data->dev, NULL, true);
> -   }
> +    }
>
>      g_free(data);
>  }
> @@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaque)
>   */
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhos=
t,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb)
> +                            vu_async_close_fn cb)
>  {
>      if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>          /*
> @@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
>          data->dev =3D d;
>          data->cd =3D chardev;
>          data->vhost =3D vhost;
> -        data->event_cb =3D event_cb;
>
>          /* Disable any further notifications on the chardev */
>          qemu_chr_fe_set_handlers(chardev,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index d7c09ffd34..324cd8663a 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
>
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhos=
t,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb);
> +                            vu_async_close_fn cb);
>
>  #endif
> --
> 2.45.0
>

