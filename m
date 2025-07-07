Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D512C83F03
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 03:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYcIB-0006gg-A9; Sun, 06 Jul 2025 23:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1uYcI4-0006fU-Qw
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:13:14 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1uYcI0-0006On-V9
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:13:12 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6fadd3ad18eso29659436d6.2
 for <qemu-devel@nongnu.org>; Sun, 06 Jul 2025 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1751857987; x=1752462787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+rs1+bAnCzAXWlRHqSV5A8qHxIhBhZKPZaZqvDN0es=;
 b=YOz/1b5TCmLrLMVNa38+LDEhIfoD8Qx5MoZK8mjXcM0MQuoO/XtfhoSJcr3ucIFxZF
 wyWWXgF9HnBzzE/NPFQYzIDUo0pS/MZePDc1Snu0SxHv0SlwWj41OafZ/xIZsSmEaG49
 DncyL/gni96cuzUEjS1oq4NGvA8nacc/iSGNLmlXe8z6c5AwaQkM1r3cvmSUCIebeXJE
 zC25yjOp4LftoiM/DlHU4SIT8LH1qU7WoPNfPWoJRhNiCGJ8Tq4gpAaYYJE7uCmgY46y
 XPdgvoIi1OL7Ha0rGaaVVxm7AXJIeyXJ7tHodQzNg66DlEOsRnT9NCAaeZbgEgiPWpH4
 rTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751857987; x=1752462787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+rs1+bAnCzAXWlRHqSV5A8qHxIhBhZKPZaZqvDN0es=;
 b=Vbu/mZbJ5aHDelW58SkyDoMOUOiWZeX71L78pyVsyFoIYGoPBbhUQSm5Wk5jSUE+1l
 HJ2gSZXjiLjrWi3vwhzShLo9ZjfUd9w3+i4VzKIlqz2FyK9Pfy7hn4XLfDxpZQ6zwQTh
 +tCljrhfbyJ1DVSnUT7LvvUxwOP9DkLHI3lID0LwGq3hEqsNcmFsv7YZkTRnZPYg7nIo
 jYMzBTbAEFwvdiCvnfQXVg5uXn/GZfJDVT/6KTOf7Zrju3zuKuZnLQljrGmT2XhLKVOD
 Lahcbs4iaTcsOsemULV62bQpKTNTN913X1/VjFVfuZAKQte4eBpoG/pwCxS5UMwYUlDF
 Sf7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc2OAWB5nTAA9FXJZ0YBlQ6GAjvFKonunUAvC71E366dK3DjKsgdpHNaxyLisgS2aWwahhl6zAu6ja@nongnu.org
X-Gm-Message-State: AOJu0YzdBq+YedcJf332xpXzUvZk7r42s28N5hnsDD4NOVd4uSSn1rv+
 ueujW17Ej5jLLo1ZFxzlZeQHP8ALhmVm0maGYGZxvmlqFvqIyNKZazPU8S9xJd+vbiobDRqyuQY
 PiLBXNAWGhyZnsXAI/aaBxB4ezNGJu+w5PhRRAmc1jw==
X-Gm-Gg: ASbGncvJ28R6tnRLLZ9PCDSCPUFRdU0PDUtDBjJcip0N1JXqHpfkJqujW906Fo3UGH0
 t4IU9vBlSLht6iaKZAejN+tMwP6ErjqvcAbsVQJIpj4kpczS6oJkDYVeVOZ0neSg2dsFjVGqI3z
 X1e6XZcMhwgN3B9ndUjT3ySx0N6OmAmXx/n2S/rWKrZPg=
X-Google-Smtp-Source: AGHT+IHf37tNUrF1ad2JjMmiqhOoivtvwUcI3kGejpIdtiy66XYEQ8/ouSOB+BIyya3NIN+gsBedZ1ofDbIoghhmlq8=
X-Received: by 2002:a05:6214:469f:b0:6fd:6fc6:3961 with SMTP id
 6a1803df08f44-702d16a4676mr139694436d6.37.1751857987229; Sun, 06 Jul 2025
 20:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
 <20250609212547.2859224-4-d-tatianin@yandex-team.ru>
In-Reply-To: <20250609212547.2859224-4-d-tatianin@yandex-team.ru>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Sun, 6 Jul 2025 23:12:56 -0400
X-Gm-Features: Ac12FXw3TRJkGXChJ3y2vDcVj4rtANhQZ7YDLIOPnUNyeeC2frSpdUHWQuSwEz0
Message-ID: <CAMDpr=e3S2BB5Kzyzg9v=dMZ1G9vVN5Phm4x0YjpXimeBomaXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost-user-blk: add an option to skip GET_VRING_BASE
 for force shutdown
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=raphael@enfabrica.net; helo=mail-qv1-xf30.google.com
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

I think others should weigh in on the higher level abstractions you're
adding for vhost_user_blk_force_stop() - I don't have a strong
perspective on them. I'm ok with this for vhost-user-blk.

Acked-by: Raphael Norwitz <raphael@enfabrica.net>

On Mon, Jun 9, 2025 at 5:26=E2=80=AFPM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> If we have a server running disk requests that is for whatever reason
> hanging or not able to process any more IO requests but still has some
> in-flight requests previously issued by the guest OS, QEMU will still
> try to drain the vring before shutting down even if it was explicitly
> asked to do a "force shutdown" via SIGTERM or QMP quit. This is not
> useful since the guest is no longer running at this point since it was
> killed by QEMU earlier in the process. At this point, we don't care
> about whatever in-flight IO it might have pending, we just want QEMU
> to shut down.
>
> Add an option called "skip-get-vring-base-on-force-shutdown" to allow
> SIGTERM/QMP quit() to actually act like a "force shutdown" at least
> for vhost-user-blk devices since those require the drain operation
> to shut down gracefully unlike, for example, network devices.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 9 ++++++++-
>  include/hw/virtio/vhost-user-blk.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 0eebbcd80d..c0cc5f6942 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -210,6 +210,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
> +    bool force_stop =3D false;
>
>      if (!s->started_vu) {
>          return 0;
> @@ -220,7 +221,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    ret =3D vhost_dev_stop(&s->dev, vdev, true);
> +    force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
> +                 qemu_force_shutdown_requested();
> +
> +    ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
> +                       vhost_dev_stop(&s->dev, vdev, true);
>
>      if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>          error_report("vhost guest notifier cleanup failed: %d", ret);
> @@ -584,6 +589,8 @@ static const Property vhost_user_blk_properties[] =3D=
 {
>                        VIRTIO_BLK_F_DISCARD, true),
>      DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_feat=
ures,
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
> +    DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserB=
lk,
> +                     skip_get_vring_base_on_force_shutdown, false),
>  };
>
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *da=
ta)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index ea085ee1ed..a10f785672 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -50,6 +50,8 @@ struct VHostUserBlk {
>      bool connected;
>      /* vhost_user_blk_start/vhost_user_blk_stop */
>      bool started_vu;
> +
> +    bool skip_get_vring_base_on_force_shutdown;
>  };
>
>  #endif
> --
> 2.34.1
>

