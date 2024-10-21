Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE7ED15D8C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2sM4-0004j6-De; Mon, 21 Oct 2024 09:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1t2sM2-0004ih-Jp; Mon, 21 Oct 2024 09:21:50 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1t2sM0-0008RJ-OI; Mon, 21 Oct 2024 09:21:50 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a3b6b281d4so18112165ab.0; 
 Mon, 21 Oct 2024 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729516907; x=1730121707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HmTgaSqToFcjIvGflNp2DlgvHU63n+qnYSJY74eq0s=;
 b=juXpGxn0pBuwwiM08VZSbfci5jZOpRHsoDOdbx9/K8YcKienmoDCXugr1zTr8KCJFV
 m19NIXkZ2fVjatSXHciR5hfLxSo/ZE4AHK5Yyauu6S1RDIqBKOncYXc5u8QAtV3dnSI+
 vEj+jIN5ShZxunC+x8luB4N1nOZjajoCcsrm8UqqfkmE31KE5oNAdmkMoE/FsQuq90nv
 TEJ/eD5g7+3ecCMmHHhwctEOOByA0eVod5RZVzYTRieXDsM+HavFH0acFuid3bbGP0FM
 RZTI9ZqHIeZWzOPa3rSaQ4SfM8sODEdBR59BrCg0HGM0GUaN95TTYCfANgF4MS/u0jJ0
 FWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729516907; x=1730121707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HmTgaSqToFcjIvGflNp2DlgvHU63n+qnYSJY74eq0s=;
 b=iKHvgpDRz/wgnW4vtBC1ihLd/r+w6AvswIBoOJiOWzXfQy7ykSBiNeU6Hj/ld2/TuJ
 43oMcKLD9dIv0rcKBkT8KUJ5zbgSCXjgq6UeuamZR99NM689FVQgpmzZLfOwVaiuB+Hu
 w8U/1/3cqeqASorUFgzKBEj6y0KkEcNlWhG6E1+j91UmjlekrG9lXB2ejwJJ0dOkrpBv
 G70q9kjCVYC3/Q7Gvxg6yuRS7oxUwCrb1i+pFSR6hedJ2nkpdfdr18GVujh+gOSc39b5
 UIhmU75mA0jIJu6Khjee2z9zftBYYgBKM1gNGq+C+EbrRlNGNrqkuPQ155Y9qaHdl7VZ
 1LjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1sDnjXD2HhiUyEz4BeDx0lXK9rG3Mdy5qhmnXjx56nhQpVg4fjWiV1Pl316dGL2y8wwvibmVYmZiU@nongnu.org
X-Gm-Message-State: AOJu0Yzg9dB4TmAliRjYh2tWZpIMPQ36gTcUW2MLhtF8aD4wtvZxOLWB
 tzyEqc8kTYZHvGL3HLy3pm+gzJaqzTmflWyNwMMQ08nV8atRsUydOhUsN00QKz8/MeeXsPnwOHN
 QujWSYvJDwrhg2nP7C4tgi2ECKDc=
X-Google-Smtp-Source: AGHT+IEiVh64obXNtrK+rSsV1q/Ds7YIEIkSr5qIXYZyeavWd4IppI+hukE2Bm1Zsw2avEa3oJa9LtEv6wlKsGDgnLE=
X-Received: by 2002:a05:6e02:1a67:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a3f40622cdmr107609785ab.12.1729516906719; Mon, 21 Oct 2024
 06:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241004104123.236457-1-faithilikerun@gmail.com>
 <ZxJynt-0ySt3DG7W@redhat.com>
In-Reply-To: <ZxJynt-0ySt3DG7W@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 21 Oct 2024 15:21:20 +0200
Message-ID: <CAAAx-8KtfoM+gVRzUjCCLY8vEG=5vcoRGcxBzDDG6DArC8L7tA@mail.gmail.com>
Subject: Re: [PATCH v2] block/file-posix: optimize append write
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=faithilikerun@gmail.com; helo=mail-il1-x136.google.com
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

Kevin Wolf <kwolf@redhat.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
> > When the file-posix driver emulates append write, it holds the lock
> > whenever accessing wp, which limits the IO queue depth to one.
> >
> > The write IO flow can be optimized to allow concurrent writes. The lock
> > is held in two cases:
> > 1. Assumed that the write IO succeeds, update the wp before issuing the
> > write.
> > 2. If the write IO fails, report that zone and use the reported value
> > as the current wp.
>
> What happens with the concurrent writes that started later and may not
> have completed yet? Can we really just reset to the reported value
> before all other requests have completed, too?
>
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/file-posix.c | 57 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 38 insertions(+), 19 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 90fa54352c..a65a23cb2c 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2482,18 +2482,46 @@ static int coroutine_fn raw_co_prw(BlockDriverS=
tate *bs, int64_t *offset_ptr,
> >      BDRVRawState *s =3D bs->opaque;
> >      RawPosixAIOData acb;
> >      int ret;
> > -    uint64_t offset =3D *offset_ptr;
> > +    uint64_t end_offset, end_zone, offset =3D *offset_ptr;
> > +    uint64_t *wp;
>
> Without CONFIG_BLKZONED, these are unused variables and break the build.
>
> They are only used in the first CONFIG_BLKZONED block, so you could just
> declare them locally there.

Thanks! Will do.

>
> >
> >      if (fd_open(bs) < 0)
> >          return -EIO;
> >  #if defined(CONFIG_BLKZONED)
> >      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
> >          bs->bl.zoned !=3D BLK_Z_NONE) {
> > -        qemu_co_mutex_lock(&bs->wps->colock);
> > -        if (type & QEMU_AIO_ZONE_APPEND) {
> > -            int index =3D offset / bs->bl.zone_size;
> > -            offset =3D bs->wps->wp[index];
> > +        BlockZoneWps *wps =3D bs->wps;
> > +        int index =3D offset / bs->bl.zone_size;
> > +
> > +        qemu_co_mutex_lock(&wps->colock);
>
> This is preexisting, but what is the reason for using coroutine locks
> here? There doesn't seem to be any code running under the lock that can
> yield, so a normal mutex might be more efficient.

Using coroutine locks is to avoid blocking in coroutines. QemuMutex
blocks the thread when the lock is held instead of yielding.

>
> Hm... Looking a bit closer, get_zones_wp() could probably be a
> coroutine_fn and call hdev_co_ioctl() instead of calling ioctl()
> directly in order to avoid blocking.
>
> > +        wp =3D &wps->wp[index];
>
> Also preexisting, but who guarantees that index is within the bounds? A
> stacked block driver may try to grow the file size.

Right. It needs to be checked if it's over nr_zones.

>
> > +        if (!BDRV_ZT_IS_CONV(*wp)) {
> > +            if (type & QEMU_AIO_WRITE && offset !=3D *wp) {
> > +                error_report("write offset 0x%" PRIx64 " is not equal =
to the wp"
> > +                             " of zone[%d] 0x%" PRIx64 "", offset, ind=
ex, *wp);
>
> We can't error_report() in an I/O path that can be triggered by the
> guest, it could result in unbounded log file growth.

Those error messages show in the err path and are good for debugging
zoned device emulation.

I was wondering if there is a better approach to print errors? Use
error_report_once() to reduce the log?


Sam

>
> > +                qemu_co_mutex_unlock(&wps->colock);
> > +                return -EINVAL;
> > +            }
> > +
> > +            if (type & QEMU_AIO_ZONE_APPEND) {
> > +                offset =3D *wp;
> > +                *offset_ptr =3D offset;
> > +            }
> > +
> > +            end_offset =3D offset + bytes;
> > +            end_zone =3D (index + 1) * bs->bl.zone_size;
> > +            if (end_offset > end_zone) {
> > +                error_report("write exceeds zone boundary with end_off=
set "
> > +                             "%" PRIu64 ", end_zone %" PRIu64 "",
> > +                             end_offset, end_zone);
>
> Same error_report() problem.
>
> > +                qemu_co_mutex_unlock(&wps->colock);
> > +                return -EINVAL;
> > +            }
> > +
> > +            /* Advance the wp */
> > +            *wp =3D end_offset;
> >          }
> > +        qemu_co_mutex_unlock(&bs->wps->colock);
> >      }
> >  #endif
> >
> > @@ -2540,28 +2568,19 @@ out:
> >  #if defined(CONFIG_BLKZONED)
> >      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
> >          bs->bl.zoned !=3D BLK_Z_NONE) {
> > -        BlockZoneWps *wps =3D bs->wps;
> >          if (ret =3D=3D 0) {
> > -            uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
> > -            if (!BDRV_ZT_IS_CONV(*wp)) {
> > -                if (type & QEMU_AIO_ZONE_APPEND) {
> > -                    *offset_ptr =3D *wp;
> > -                    trace_zbd_zone_append_complete(bs, *offset_ptr
> > -                        >> BDRV_SECTOR_BITS);
> > -                }
> > -                /* Advance the wp if needed */
> > -                if (offset + bytes > *wp) {
> > -                    *wp =3D offset + bytes;
> > -                }
> > +            if (type & QEMU_AIO_ZONE_APPEND) {
> > +                trace_zbd_zone_append_complete(bs, *offset_ptr
> > +                    >> BDRV_SECTOR_BITS);
> >              }
> >          } else {
> > +            qemu_co_mutex_lock(&bs->wps->colock);
> >              /*
> >               * write and append write are not allowed to cross zone bo=
undaries
> >               */
> >              update_zones_wp(bs, s->fd, offset, 1);
> > +            qemu_co_mutex_unlock(&bs->wps->colock);
> >          }
> > -
> > -        qemu_co_mutex_unlock(&wps->colock);
> >      }
> >  #endif
> >      return ret;
>
> Kevin
>

