Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C06CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGkf-0001NI-Qi; Tue, 21 Oct 2025 14:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBGka-0001Mt-Jp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:06:25 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBGkY-0008Kl-Rf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:06:24 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-430d0d37fd7so896515ab.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761069981; x=1761674781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sufgHMdCMhpSWkImek1HLx/zIK/9XVZ1Oufl0EUUyXY=;
 b=HhMRIR7CnvC0XARdzt/r08fvHnVeZdpTIutwwKw12H62MCmsLG1hq2skJIqsggdtLJ
 dLPBWHxNwm5OkOdV0n6w7g+im6vP1YOoPiotrp00wc9O5b/BFraa3TJ5gD1tfAAj21Hv
 l5YtGaArRfe9fWFs0uiAjbXXyq1pBmJsumg+i40F+LZ/QpejS7pgSUiM48ku/tJXJrkN
 K1dMB7z8BbMwt2Rp7um7PeBb3lGMimBkMkEst/oN+QggFlIzUNWrq1TluaJuesXLMYP8
 hL5ebIJhQoMbzpTkuazveHydgqrzUyFayTkfjLnO+fh9CsxJY1n9COHwGaXqseSahkvY
 J+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069981; x=1761674781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sufgHMdCMhpSWkImek1HLx/zIK/9XVZ1Oufl0EUUyXY=;
 b=S598duyeVsaTn7+LItjv8sLUtMwZ9xDmVFvCfk4vG/amfOulTekW8AHlG/aZVpWydd
 o6xaUPHam+TTaluNh7A8pb/Pt74McEeS0avuYZUx1YzlYMSXGUilebMDfACHvpSvFD2L
 W7aGBG/nPNCAV3dTPFwIZBQb1gVPsu7hLu6Zp81LpUXLNtwmgGm8SGxRWGujsN6fMkjw
 It9iCIbyWi7tYpVkIyT+rxOpQubcva5Apj8DOG0NLYigNnQrQBa+YVSDOXQCI8BhAbaS
 nCGzChwcceN5/5c4sNd6a4QwbgITmUOXtvWGqY/O4JVBdGeQc6gPLp4Ve4biNWMxPitX
 1Cwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWIZ2o46hGfuNx1i/P3lbu0eHDoYOMe/FmDnjDsapT3CrVcPJNFlp0owK3m0I+5OXklAwVhqJy/coh@nongnu.org
X-Gm-Message-State: AOJu0Yx/AXKdVhGxg3OU1E3QoUOEGmyfjhV0Mrwd9t35Rx8hFR5MULuk
 ECmgkR+6ugUtz0jfD0xEngfg72eaN0EJ8FM5NrZ2TchqXCRDE2mmMQ+Ez0rni2gg8auIUlpJhfS
 a2GZlp0SBiwVqoGjUUj2B3BJl9M5OdVA=
X-Gm-Gg: ASbGncvM+97xfBB51wga2hNCbSLBI65YIbLp1ejmXqMK3rhp04cYepx7r0d39MfdxF7
 ukKHjSt0/ss3BtCa/uZzZcNzEJDzaJ65tF2gUizBaY8aiEldyNv4y7QdonSG/uZQFmDjn71oFEs
 wfSxMXJX8uzI2mCY5SNXpDhSZJvIeeIegQOaW4572nQHsQRtzPaCGYrLhQTGV+ITm4Hisizv/Cd
 dQBX0JqQjYSrzwEv5e1K/YokausfyLyaJlzBcPyvd7+Q+P/IG5LJ22HGxAafJw8+lSG+VY=
X-Google-Smtp-Source: AGHT+IG7AwPiaN+L2hlh2ryT/irzWtao5CVgocGktgREFGsHXyVbsU9/ie3AlNvyjuzB27NvFsIkKlLh+LoKiDUz5ZQ=
X-Received: by 2002:a92:cd8f:0:b0:430:b004:3d5c with SMTP id
 e9e14a558f8ab-431d309940bmr11408305ab.9.1761069981014; Tue, 21 Oct 2025
 11:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-13-vsementsov@yandex-team.ru>
 <CAFubqFsKOJwD8w_jNRCuyTVs=LytbYF+ZsKTP986g-An-6Pbdw@mail.gmail.com>
 <a9afaaef-08a9-44cb-b401-b5b3bac1bff4@yandex-team.ru>
In-Reply-To: <a9afaaef-08a9-44cb-b401-b5b3bac1bff4@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 21 Oct 2025 14:06:09 -0400
X-Gm-Features: AS18NWAa9VPDXW8jrBcsCWFh_vHDpp1r1dXj5laE7vDWzVcrQKZre1hTwNSwbw0
Message-ID: <CAFubqFvQY_FN2yTJz_Yyf0AVhjFjPXfE5ndn3o6OhDP375mn9w@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] vhost-user-blk: move first vhost_user_blk_init()
 to _realize()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x135.google.com
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

ACK on your point. One more question about setting s->connected =3D false.

On Tue, Oct 21, 2025 at 12:29=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 21.10.25 02:35, Raphael Norwitz wrote:
> > On Thu, Oct 16, 2025 at 7:48=E2=80=AFAM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> We'll need to postpone further connecting/reconnecting logic to the
> >> later point to support backend-transfer migration for vhost-user-blk.
> >> For now, move first call to vhost_user_blk_init() to _realize() (this
> >> call will not be postponed). To support this, we also have to move
> >> re-initialization to vhost_user_blk_realize_connect_loop().
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru=
>
> >> ---
> >>   hw/block/vhost-user-blk.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> >> index 36e32229ad..af4a97b8e4 100644
> >> --- a/hw/block/vhost-user-blk.c
> >> +++ b/hw/block/vhost-user-blk.c
> >> @@ -464,14 +464,12 @@ static int vhost_user_blk_realize_connect(VHostU=
serBlk *s, Error **errp)
> >>       DeviceState *dev =3D DEVICE(s);
> >>       int ret;
> >>
> >> -    s->connected =3D false;
> >> -
> >>       ret =3D qemu_chr_fe_wait_connected(&s->chardev, errp);
> >>       if (ret < 0) {
> >>           return ret;
> >>       }
> >>
> >> -    ret =3D vhost_user_blk_init(dev, true, errp);
> >> +    ret =3D vhost_user_blk_connect(dev, errp);
> >>       if (ret < 0) {
> >>           qemu_chr_fe_disconnect(&s->chardev);
> >>           return ret;
> >> @@ -501,7 +499,16 @@ static int vhost_user_blk_realize_connect_loop(VH=
ostUserBlk *s, Error **errp)
> >>               error_prepend(errp, "Reconnecting after error: ");
> >>               error_report_err(*errp);
> >>               *errp =3D NULL;
> >> +

Having removed setting s->connected =3D false from
vhost_user_blk_realize_connect() we will now only set s->connected =3D
false here in the if (*errp) {} error path. Shouldn't we also set
s->connected =3D false outside the error path here or in
vhost_user_blk_device_realize()?

> >> +            s->connected =3D false;
> >> +
> >> +            ret =3D vhost_user_blk_init(dev, false, errp);
> >> +            if (ret < 0) {
> >> +                /* No reason to retry initialization */
> >> +                return ret;
> >> +            }
> >>           }
> >> +
> >>           ret =3D vhost_user_blk_realize_connect(s, errp);
> >>       } while (ret < 0 && retries--);
> >>
> >> @@ -566,6 +573,10 @@ static void vhost_user_blk_device_realize(DeviceS=
tate *dev, Error **errp)
> >>       s->inflight =3D g_new0(struct vhost_inflight, 1);
> >>       s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
> >>
> >
> > Why call vhost_user_blk_init() here if we call it in
> > host_user_blk_realize_connect_loop()?
>
> To be able to postpone the whole realize-connect-loop to the later
> point (not in realize) in further commits.
>
> So this first init will stay in realize, for early initialization of the =
device.
>

Makes sense - I missed that vhost_user_blk_init() is only called in
the error path.

> >
> >> +    if (vhost_user_blk_init(dev, false, errp) < 0) {
> >> +        goto fail;
> >> +    }
> >> +
> >>       if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
> >>           goto fail;
> >>       }
> >> --
> >> 2.48.1
> >>
> >>
>
>
> --
> Best regards,
> Vladimir

