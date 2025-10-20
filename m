Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907ACCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzEi-0008A9-Gd; Mon, 20 Oct 2025 19:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzEf-000834-Tv
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:24:17 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzEb-0007ww-7Z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:24:14 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-93e2c9821fcso429309439f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002652; x=1761607452; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w22TRU42ecEcxOFEqrS0eubFdFOwhubRTQPU2aD4/dA=;
 b=eT5ei2DYtxZKk7MMaY1vgmgGxraY2jzNhMgKWD1apivhFTBNX2WPzcUPgsHpo6X8Kg
 gcG8l6Est5QvLiPENFG9/1oknwlQU7AR4X3z49Mz7gsRg6l0TXl7jkuJ42DaYi9dtXeO
 ezjDCs5h9sspndz8IxJuLYv2f3h8PIGRWzltjWf0Tw24DfO9+AmgpRHvbk1KvN7OUNqQ
 ZOYntI0ndB7CF9r1RxqLJhwNvbYeAZwZ7ycIBSPqg+rMxv0mW0chmObhHpiXWzXE3gsT
 HafnWk8MTbU5wo9rloWdklPyf+dbDN8G5qU8MuOUrUjGBABsyhbKSyOeek6RM+5hwOrI
 +t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002652; x=1761607452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w22TRU42ecEcxOFEqrS0eubFdFOwhubRTQPU2aD4/dA=;
 b=UIz1i0IZbwaMl8z7PFq7P1SImUISfmHHwfzp0KCXZi0KZwCTzIuxzqna64KiPS0baP
 EGAYXvCzGiMQZKyaEv/lQnfBEwWTmqCO+7m0gnV171EZFbfrje8ClbpBUdSw/LKelKRO
 zbIs0p3V7wOSYl/zSe3YaLjgRpWrL7BNbCjwqI7Ig51VvMYhsNk1sBhl4+V5Tzwf+VI9
 q+XFnMKaxm7GnKeyQrEtH6Oyi+RXFoPvJ4vfy6JblDz9Cv7ak5VINsNOc4jbA77ehT8u
 gbZ+fjUzyn3USdCWkcZMqxOGfnAGxTiiPr0m88t6++xR+19ImIOKWTXhCpsj+1iDIVI+
 gAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbqt4FRC8xAziGKuFTOmwvSlSI0kYuLi2q9wDxKmZi3aBpAsYweTtjQQ3dYhP7ZwP1QOaVbK9NhNwO@nongnu.org
X-Gm-Message-State: AOJu0Yz2C/KQejuYCCrPa6GTrWGFoLW3/3vw27GGl4ls9GrfT0LN1XZq
 DR8eLkCsDjGNGDnngFr3ZaSHNrEjnGwQeGwNl1XbdjSJxw+p5tsZS70TwpryPDJz0atc40YRIeA
 kvWIGFIYNFGZuSXrhSD4uAnBIbUrnMmg=
X-Gm-Gg: ASbGncuE1ZlFy01hIPfpdc12pQ9MAYC39EjJTwUlN7bRlCB+xAHBAoEByQRQdb/P7Mn
 tSnRROE1i1SibQFSdfxVhza0K0YQb+eTuxvI1sB+BR4quosraCnU8bBYKmvCTuip6NFm02Tlh4+
 kN9Xw/f3YHjH1m4QBs6dqcDvuwyuMB9iD7Qh4jPoWByjAelOJOgj9EVNtvoBFb9g8yem25UHRcY
 CaLrY7AD/6Io5Zj/Sd6Ils7W0lD0oOBDuVv3tmuTplh38xvPp8IjR2Ql/Y7
X-Google-Smtp-Source: AGHT+IHF7n99kBtbVrEHZR8qpz9MzAENtZ3BCIYmGhYVqhSVQFLlgMtNu4je4hnymcfTuxqbuSQEOxEdYotnIFE3kug=
X-Received: by 2002:a05:6602:6d14:b0:940:d327:8fd6 with SMTP id
 ca18e2360f4ac-940d3279111mr1224510739f.7.1761002652089; Mon, 20 Oct 2025
 16:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-9-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-9-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:24:01 -0400
X-Gm-Features: AS18NWAVokgPPkWcRJ8-Ol8PuWinUuZAqxMLcAuQoMik9cu8Wlk2e7sNIO1Mavo
Message-ID: <CAFubqFuqgRQCg8TTwnAK7j2PMjgdQjWoEhpYFmD22NS9oeMdHg@mail.gmail.com>
Subject: Re: [PATCH v2 08/25] vhost-user-blk: vhost_user_blk_connect(): call
 vhost_dev_connect()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd33.google.com
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

On Thu, Oct 16, 2025 at 7:46=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Call vhost_dev_connect() directly, to simplify further refactoring.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 57214a69cd..f2ecf81e4d 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -363,7 +363,12 @@ static int vhost_user_blk_connect(DeviceState *dev, =
Error **errp)
>
>      s->vhost_user.supports_config =3D true;
>      ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0,
> -                         true, errp);
> +                         false, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D vhost_dev_connect(&s->dev, errp);
>      if (ret < 0) {
>          return ret;
>      }
> --
> 2.48.1
>
>

