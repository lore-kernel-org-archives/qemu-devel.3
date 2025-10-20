Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DCCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzG5-0000p1-8c; Mon, 20 Oct 2025 19:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzG3-0000oP-MD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:25:43 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzG1-0008Cf-US
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:25:43 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-93e2d42d9b4so212447939f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002740; x=1761607540; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLylpcrowx3SLiHRXZxqTdOGO2F6oBChzliIaHpwVYk=;
 b=hJ8GrpVy7fUMu7iTI7kcROnjP306OfkuDmMgvzVHSJQOTVnioBy/+cq/w++ekRQlWN
 4msZYYGUvd+fkb262oNIPyz9PFzLAHidC1Z+ny8RZEDabBN8+HyZGgJ2LBtJNkABoGZR
 DpiokAs22bjwflcV1dRQ2pkqNwEufSJ1vcDy1ImM5kFyBpJNRztYPxwIA96kiYm7d9KQ
 h9c/aZWT+R0JcAqOxOAPA4QGxIPBMMP22af91YYDoC/c6rt8B3a81iqANqbD3GJSHWa9
 1a38ltJQHGNmv6j7+Rny4/tyQ3hyiig54ccPwnsKuqwAUuyT9M5KMWqOd4jcuXIOoifb
 y1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002740; x=1761607540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLylpcrowx3SLiHRXZxqTdOGO2F6oBChzliIaHpwVYk=;
 b=no/WbK9n1D33JkZzqvmU8/zSZLb1GWy0Lru0SM6dtBbjQH+MwVHxvbZbIIsuCN+E5d
 pZwyqIIXEh/v0EWDD2e8OZiqZsRzqCfUqVthlTu8sXLmjD3dIXscD9W5uRiLM1D0JeAs
 fm8QLZBdLFxta303lfCZwdIyFp7txol1igGO16kIRB4G5ztFJRO0TCTj66dd26r+r4fe
 L1V1ktAey25Sbsxv3DetyzXmoEvv6jjdh+bjKxpc5XM4rnp0M+thzLY7NUahUDI4vyAo
 27L8vVC510ek605lfxylKyziAummSTXYXNcmBI/fBGEXlZL/nCj5YztVCEDQ4eOAqlmt
 z3Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt1hNricOJ1GycvA5uOPvqg01zfOgcfwnf1XQiYIz4QbEn4vTACNZcjtAaONxn0db1xCtms26Mn+aH@nongnu.org
X-Gm-Message-State: AOJu0Yw+2K+8/HHTkhViOLtegATMLe/mRw5RNdJgqcjyga+93C1bW1M1
 EthSUsgcnxiYMKo4Fh3IA4FSlQ7MGwtC5ET9uiCinEkggjaQ0yIdKPYJzN6ojkATnnr0vxxd6Be
 lO465tIsRV7Fpk0cEMvqwqO1AXAOGUfA=
X-Gm-Gg: ASbGncsy2v4Wrlu3QtusInmzYqUIkd63kNs5X54/xJXUXqigeEbh22jN3XIK6010nR1
 fVyVHkyxXNcEDrmS8vd67qTyzxDKSyvxQ1KmDdkNjNXTytGT5sRzlX3oLwbl0axWVQeHLkZH1Oy
 ic+XwVZhM761VezlX37vd8DhbPhtJCuongRLtlNGGeHZA5uSCfSuzV2kPiIIeDhdTk9OBKKTeEq
 Hxhm+ayDATl0OhjhINngGFqVZjWKwHdn/ykEmeUH0U/8iq6lGx4Pam9jyubR5iXS2sWPew=
X-Google-Smtp-Source: AGHT+IEz5dezCmuy318bjNCsEOkwkU+YZTFKUv0J3+u2mPALIz70kCAJckYhfnW65B+DbRuR3QhBqEgUqfz/Dr+zzDU=
X-Received: by 2002:a05:6e02:2584:b0:430:a4ba:d098 with SMTP id
 e9e14a558f8ab-430c526604amr229759225ab.14.1761002740220; Mon, 20 Oct 2025
 16:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-10-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-10-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:25:29 -0400
X-Gm-Features: AS18NWD-jY_vvZ8VPki7Y5jKewee7CzWH61P3rmok1PWLs3pnXF5x6YKOp73MhY
Message-ID: <CAFubqFtw0k+T4wGLFhFCXbq7ACHAM4swwerZQenRtO0L9tPs5A@mail.gmail.com>
Subject: Re: [PATCH v2 09/25] vhost-user-blk: rename vhost_user_blk_connect to
 vhost_user_blk_init
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Thu, Oct 16, 2025 at 7:44=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The function does both vhost_dev_init() and vhost_dev_connect().
> Following interface of vhost_dev_init(), and preparing to further
> refactoring, let's rename to _init() and add boolean "connect"
> parameter.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/trace-events     |  2 ++
>  hw/block/vhost-user-blk.c | 13 ++++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index dbaa5ca6cb..9f00412a99 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -63,6 +63,8 @@ vhost_user_blk_start_in(void *vdev) "vdev %p"
>  vhost_user_blk_start_out(void *vdev) "vdev %p"
>  vhost_user_blk_stop_in(void *vdev) "vdev %p"
>  vhost_user_blk_stop_out(void *vdev) "vdev %p"
> +vhost_user_blk_init_in(void *vdev) "vdev %p"
> +vhost_user_blk_init_out(void *vdev) "vdev %p"
>  vhost_user_blk_connect_in(void *vdev) "vdev %p"
>  vhost_user_blk_connect_out(void *vdev) "vdev %p"
>  vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index f2ecf81e4d..c31c265a0e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -344,13 +344,16 @@ static void vhost_user_blk_reset(VirtIODevice *vdev=
)
>      vhost_dev_free_inflight(s->inflight);
>  }
>
> -static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
> +static int vhost_user_blk_init(DeviceState *dev, bool connect, Error **e=
rrp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      int ret =3D 0;
>
> -    trace_vhost_user_blk_connect_in(vdev);
> +    trace_vhost_user_blk_init_in(vdev);
> +
> +    /* TODO: implement support for connect=3Dfalse */
> +    assert(connect);
>
>      assert(!s->connected);
>
> @@ -380,7 +383,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>          ret =3D vhost_user_blk_start(vdev, errp);
>      }
>
> -    trace_vhost_user_blk_connect_out(vdev);
> +    trace_vhost_user_blk_init_out(vdev);
>
>      return ret;
>  }
> @@ -415,7 +418,7 @@ static void vhost_user_blk_event(void *opaque, QEMUCh=
rEvent event)
>      switch (event) {
>      case CHR_EVENT_OPENED:
>          if (!s->connected) {
> -            if (vhost_user_blk_connect(dev, &local_err) < 0) {
> +            if (vhost_user_blk_init(dev, true, &local_err) < 0) {
>                  error_report_err(local_err);
>                  qemu_chr_fe_disconnect(&s->chardev);
>                  return;
> @@ -447,7 +450,7 @@ static int vhost_user_blk_realize_connect(VHostUserBl=
k *s, Error **errp)
>          return ret;
>      }
>
> -    ret =3D vhost_user_blk_connect(dev, errp);
> +    ret =3D vhost_user_blk_init(dev, true, errp);
>      if (ret < 0) {
>          qemu_chr_fe_disconnect(&s->chardev);
>          return ret;
> --
> 2.48.1
>
>

