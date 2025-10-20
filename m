Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23716CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAz97-0004Ux-Cq; Mon, 20 Oct 2025 19:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz92-0004RQ-DV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:18:28 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz8x-0007E4-Eg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:18:25 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-93e8834d80aso120822039f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002302; x=1761607102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uD9NgWe7QaeZ1vpVYzlwaX75YhRS2zcZZ3fO42EUEwo=;
 b=hPtNIZ28lOTkLwPeYWyPbI97h1gikEGaY61JNMz1iaOlV4hrAdBpRBjBV1+xFECktq
 lCdVfG+NuKpfAk7Txry65l27trFkNWz5NQcnJgW0g+tjR1TwPplEdLVxxfnSHNY379Dn
 3sAsICpHjvVN7facbPrbAtNmGxRSz6sfWXfKS5NZvk64X4QddGlcP4mwpHmDUwlc+M49
 q2gFWcILJHKkbJmHe8sulLeS6Q3Eqg4qhRdTxZi2MiqRJHwabg4E/TWRX/0gDb109pNA
 1S6U6k9boOsxahyU6VtooK+nHYgotXQY0g4+8bJroT1Gq31mXBT4VjsajC/TZHy9P8jf
 NpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002302; x=1761607102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uD9NgWe7QaeZ1vpVYzlwaX75YhRS2zcZZ3fO42EUEwo=;
 b=ouOujBU4Var3K690/m39D0siW9dvxn/o0vE14FTll7yWLV3u2xhsay/S/DpmKuBPT0
 Wad50KLpO7uQLXo51OdqL+9Fj4F09olQDve/2aYIo4r8RP1IHaakULRO8n9oCF6+JVRs
 nHDoZ0Heh4eo5rZPVMCf8aEkVyTZuuMJe6+q7+WMicoTLfkdNk2rOe3Qf41tAGruyTWW
 wYDYpGnEwvmsvAofySdFNQ3TJIH3/klUx51peZWfB4oxiaXiLUEyDzE5IssJYDln0h/A
 9akZggkCFYdLinvZJSHHEOeL98aoZ6knB4WHve8dMQIewWwe0qPJKMjnnOPRZBhwYTMF
 uKPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ccvZQ++sdNfhxQ4eAwnjFUEpZtPFqOEJen+Uo17togcfb6XXRkbxshpM5F+7QmuIjwI7+1/2QPGJ@nongnu.org
X-Gm-Message-State: AOJu0YzVXQgme2a44VKun6PuB4f10gAUM9rxIsveUczAyjQthrx8IdqF
 GkuJaTdVK45shVPbXnRe5aPHfgBI6VhmxTmNBfQV6Pfe3JAhO8Zgmz0qRfVx14NTBZahcBEfCJI
 DSb+IwxiHxsXdrEVbUjG/InnSl0XTbXs=
X-Gm-Gg: ASbGncvV2o47nYSihxXEmV3SLhgtkKOmkdmbdwVe4v0KQ7WhGFsJQY4kkHXvSlmZDQI
 LbTPVoFaxwoDMvS/WlJk2oU9zfIGQu3dpyzkgzTISS4H7cm3GZXkFj6Sq5VCJdcpdbpejxM9jlE
 LwP2LtDs7wg7gq+bZVKf2+XaXx5d1nteP4lyPm9ijD5Ut8Pi6ksC5QcMG6ZSJL4ohSLw/JhMOUu
 aPIpmlW13v1E8xzssxDWTSra9S5L02zh5DE6J/E6Yga7R5CdW/Ge4IEBXhi
X-Google-Smtp-Source: AGHT+IFf38z2WjJJwGrFVbwblls+122otctqy+N3P72/tEF8S8TUywIQubSch8tpvCh+5amtE840yiLNufGNfrHgGIE=
X-Received: by 2002:a05:6e02:1d98:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-430c528fc97mr207058375ab.27.1761002301652; Mon, 20 Oct 2025
 16:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-4-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-4-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:18:10 -0400
X-Gm-Features: AS18NWDWklCjOKttDg7N5Mo8EFIFn1KRNoMDnFPRG-00xTACbUpCdF8Ekrm76vw
Message-ID: <CAFubqFsK_c2hGf+4oQzOfAZLOkp-GVMGP0JRF7MpGaagsMaWOQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/25] vhost: rework vhost_virtqueue_init()
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:48=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We are going to split vhost_dev_init() so that the first part will do
> early initialization of QEMU structures, but don't communicate with
> backend, and the second part will do backend communication. We need
> this for future support for backend-transfer migration support for
> vhost-user-blk (backend will not be available in the early
> initialization point).
>
> With this commit, let's split vhost_virtqueue_init(). The whole function
> is mostly about configuring the backend, so this logic will be postponed

nit: "until the backend becomes"

> until backend become available. The only thing to keep in early
> initialization is attaching vhost_dev structure. Let's simply move it to
> vhost_dev_init().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 551d1687fc..1998663461 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1500,9 +1500,9 @@ static void vhost_virtqueue_error_notifier(EventNot=
ifier *n)
>      }
>  }
>
> -static int vhost_virtqueue_init(struct vhost_dev *dev,
> -                                struct vhost_virtqueue *vq, int n)
> +static int vhost_virtqueue_connect(struct vhost_virtqueue *vq, int n)
>  {
> +    struct vhost_dev *dev =3D vq->dev;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, n);
>      struct vhost_vring_file file =3D {
>          .index =3D vhost_vq_index,
> @@ -1519,8 +1519,6 @@ static int vhost_virtqueue_init(struct vhost_dev *d=
ev,
>          goto fail_call;
>      }
>
> -    vq->dev =3D dev;
> -
>      if (dev->vhost_ops->vhost_set_vring_err) {
>          r =3D event_notifier_init(&vq->error_notifier, 0);
>          if (r < 0) {
> @@ -1629,6 +1627,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>      hdev->migration_blocker =3D NULL;
>      hdev->busyloop_timeout =3D busyloop_timeout;
>
> +    for (i =3D 0; i < hdev->nvqs; ++i) {
> +        hdev->vqs[i].dev =3D hdev;
> +    }
> +
>      r =3D vhost_set_backend_type(hdev, backend_type);
>      assert(r >=3D 0);
>
> @@ -1680,7 +1682,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      }
>
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> -        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i);
> +        r =3D vhost_virtqueue_connect(hdev->vqs + i, hdev->vq_index + i)=
;
>          if (r < 0) {
>              error_setg_errno(errp, -r, "Failed to initialize virtqueue %=
d", i);
>              goto fail;
> --
> 2.48.1
>
>

