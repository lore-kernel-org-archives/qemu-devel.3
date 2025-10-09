Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED604CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vwe-0006HB-Qq; Thu, 09 Oct 2025 15:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vwd-0006Gq-KF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:04:55 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vwX-0006tI-AM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:04:55 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-42e2c336adcso4890995ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036687; x=1760641487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Bg58HkihUUbzA34OgMoSfRqMOeAGUABlUl+Is8LvUA=;
 b=lQVXxgz/8vT427O/PGoZCQU8E6TLcJ9F/3/rrGETrliX+BS3wWzBpZd/6k8EereeLJ
 Y7VPX79K+lbzDUIsaPJZflnRXVK7wAOZ0Ss88AWrlDV28zcFtAptXiZRdoeptCdK4Nef
 JEb3PGAXsbBhVT+5iXx/R70Kt6Ln3PITdhiB1z4RzqJOM4whcJ+wQVy7K5UviP0K9kNZ
 GUClAi41jSuVTUpWB0Y7cFhf4OmwmCjaj5+/poc0fng0e7oGYFTx1d1mBCapuTNVb5b5
 Yh5gDErqJWzw5h9AfHLT1lFtyD44wGTALiJ46WP/xokSTazz/5Rxw279UVTcXvnhcFXO
 YWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036687; x=1760641487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Bg58HkihUUbzA34OgMoSfRqMOeAGUABlUl+Is8LvUA=;
 b=IRqXC1SxvY/ygktki1lfPpW+bhhNYUv8ViB4xIbs+XPiiT0Xmb8vgPYX7rMZC7cDmG
 D9SOvTa/zqn+yGtWgWxZf+NjXgmJmi4ItdoOhs1pvWSnAf2tIJ4GZu49DJ11idStgAhd
 zyXLaB5as+AMoLXLcGcFe6GNXdYYh0U97adekbapnkdz8XMUtzhs0VTl0y3SpbjOl7kt
 ScE94KWbCAVl6tFEPOuaM2LsKg+xgu5HYa59NBu7lGOuUOFqhWWAaBZldxvPIyOZqjQb
 6r+P5krfSs0rHJ7jbpWvdw2Q0Ei1rd9HKWGQVJcx688P9rsseueqi+oXsGBJFvupidp+
 EDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMe5FkUGpoz+rL93FO6wOJ7MBblYzoTwnpJ6R5jI6PDOjz7uegsH4Cwg/ULgjwBWJZbU19tNUMDR9D@nongnu.org
X-Gm-Message-State: AOJu0Yx3XImMxMIHWQ8m11SYjB52oAVWf/pEF2fiYHG80GU1FsS4TlPH
 dipiTVvMCm7qf/DTyBFzrWexHK5Yj7hrjGkWxUDtUy/VPTCymB5VF75uPgbYyR84vSswRSA93VW
 1TtRifo5b7Ezx1tuElVHqNraIBGuan5A=
X-Gm-Gg: ASbGncvd4FXyDppgobwpDPzvnF63TiqNLBilU4M2a+Cr2jnlkHh9IU5tDumft04aqL9
 PxBJ3DepC7IXbz/yuhuvh2oU6c3ZqmQujZVfeur09gSPgab988zNIQj+HjsRqOi7K9U4kPqQw0y
 col8F1jnkbUFH0SbvM0xKsByiMDt4aphqD2aGYg3DWHTmmWYf1gX0ipov7qxqgJmRHi9qY7YqvS
 i9q1u5MupHjxTKSHgGmDmMlmkKhBkZlJqGmU7hXlQ==
X-Google-Smtp-Source: AGHT+IH+35imRfux+MrYHGFxeC/8RmHsDKIEc8S8SFq8Skpn83Q5m4XWSunBAD9QSe8rt0MofThLIHCbkl5DRnng+H4=
X-Received: by 2002:a05:6e02:1847:b0:428:c370:d972 with SMTP id
 e9e14a558f8ab-42f87359880mr70585455ab.7.1760036687180; Thu, 09 Oct 2025
 12:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-17-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-17-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:04:34 -0400
X-Gm-Features: AS18NWApDiGrJlC7m-7l9Pf3h27MjY68v4Fek6DP99wdzoWoedLDoAefYiyghic
Message-ID: <CAFubqFs5OTfvjyNsqS-TiMEXsrMivs2dQWQevpVZChDDykxNUA@mail.gmail.com>
Subject: Re: [PATCH 16/33] vhost: simplify vhost_dev_init() error-path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x130.google.com
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 12:54=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> No reason to rollback setting up busyloop timeout on failure.
> We don't do such rollback for other things we setup in backend.
> Also, look at vhost_net_init() in hw/net/vhost_net.c: we may fail
> after successfully called vhost_dev_init(), and in this case we'll
> just call vhost_dev_cleanup(), which doesn't rollback busyloop
> timeout.
>
> So, let's keep it simple.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f6ee59425f..a3620c82d8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1602,7 +1602,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>                                                       busyloop_timeout);
>              if (r < 0) {
>                  error_setg_errno(errp, -r, "Failed to set busyloop timeo=
ut");
> -                goto fail_busyloop;
> +                goto fail;
>              }
>          }
>      }
> @@ -1642,7 +1642,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      if (hdev->migration_blocker !=3D NULL) {
>          r =3D migrate_add_blocker_normal(&hdev->migration_blocker, errp)=
;
>          if (r < 0) {
> -            goto fail_busyloop;
> +            goto fail;
>          }
>      }
>
> @@ -1674,17 +1674,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *=
opaque,
>                     " than current number of used (%d) and reserved (%d)"
>                     " memory slots for memory devices.", limit, used, res=
erved);
>          r =3D -EINVAL;
> -        goto fail_busyloop;
> +        goto fail;
>      }
>
>      return 0;
>
> -fail_busyloop:
> -    if (busyloop_timeout) {
> -        while (--i >=3D 0) {
> -            vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + =
i, 0);
> -        }
> -    }
>  fail:
>      hdev->nvqs =3D n_initialized_vqs;
>      vhost_dev_cleanup(hdev);
> --
> 2.48.1
>
>

