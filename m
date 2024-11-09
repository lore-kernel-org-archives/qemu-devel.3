Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC200D6409D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 02:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9arY-0001DM-KS; Fri, 08 Nov 2024 21:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9arV-0001DB-7o
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 21:06:05 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9arS-0001DR-6K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 21:06:04 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2884a6b897cso1524880fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 18:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731117959; x=1731722759;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GMTuj6EvijwvIgPcz3IYJmkWlsGNYY+ZXQ+e2yxZxGI=;
 b=FliqSWTwIpFdVG1cK+KgNE/Tl3Y4yoJi3um6xgERRLKbjzT8UAXcD5mwddsMwELMD9
 nnutc2UaV7applP3AufOlIIcB1Of62P04A4jGN1PXmCSXD9NOkVQP+XhJvcfvwowQ9ex
 7yV28jwR1hZZIvbgldpSe5l6kxQzYm/meRaoweOS6knaBJRe2yp5ZwP7TcA8Pm/9EMex
 6GCfAUofGcdipsP3nabF05cUVHGAeADZaINsv6XjswYVL9V/nY/5zG/fBHpO4AYJ1o15
 YsZaj6bJt4cYUDGuCVZJzsEjIsYE3vpWshweLDTMIBOjBHw6qjKbvG5UVl+wnGBbEaxs
 7wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731117959; x=1731722759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMTuj6EvijwvIgPcz3IYJmkWlsGNYY+ZXQ+e2yxZxGI=;
 b=Zq6oYbI5B8y24rsxqZzhq7sVa+12Dg7Q5eXsABRGzNvLTLolJa/hhyHVi/f1Ff2taL
 cCVaDPrdx9CwcXcMIJeGuJ+bhbLcf79B2RcZhjMZwQSFcEd362WywGbrrV+Q7nH1l/KD
 9McaYtMGkv9aP9ftQVL2hcTOVrYHdFEJ6ROQq2/DuRHBgOfBpK6cqlgFSjk/09+Znwk5
 nIyE7q4Mfkcpy//JfyfGWHkjl9FrsyhNoGn/AnwYuIdSnXeMp8HDmRDcWBRYx/4Huds+
 tgEiPoxXv+Uz2pSC9BT49b2wsECRQ3raR9fBHTZhBdjirjSRJuY/UqlEE10YO50dmmi/
 5AAQ==
X-Gm-Message-State: AOJu0YyV6mciFz8fKcIoQ2snBeh+XZRx2UzOWUg0NJBmc0TF8MO8Shn2
 /JKlK9yO7R3X0wbZe6aNTgnuHlSlrR3ntaT6gP4eQahufydZ+L6QlIby39PEoxkxcss9xwYoYMn
 p9nrYj4uXTyst37gVN24VCexjkM11Gauy14dBQQ==
X-Google-Smtp-Source: AGHT+IGkr5XVEBLzUUMI2ZK3sQKlXo/SzQSx5LYQxPctC729wdXZdd3GbVozX873tUrBVI2FexKsd0xrZoJV1DRwlJA=
X-Received: by 2002:a05:6870:d14f:b0:287:cb2:c10 with SMTP id
 586e51a60fabf-2955fc11491mr5731726fac.0.1731117958411; Fri, 08 Nov 2024
 18:05:58 -0800 (PST)
MIME-Version: 1.0
References: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
 <ZyzqosT0uE6_G4as@x1n>
 <CAK9dgmZCZp3scJTAGJc=KF9dgaftxD=V3uUADeyyYqFc_yGhkA@mail.gmail.com>
 <Zy4XEjI2JIagxsyB@x1n>
In-Reply-To: <Zy4XEjI2JIagxsyB@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 9 Nov 2024 10:05:42 +0800
Message-ID: <CAK9dgmZSmoydJkFQP5VXfN21etMZc_bNq51R+if08F+NTApN_A@mail.gmail.com>
Subject: Re: [PATCH] migration: Do not perform RAMBlock dirty sync during the
 first iteration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000f9d1260626714e20"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000f9d1260626714e20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 9:50=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Nov 08, 2024 at 02:03:47PM +0800, Yong Huang wrote:
> > On Fri, Nov 8, 2024 at 12:28=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> >
> > > On Thu, Nov 07, 2024 at 05:56:50PM +0800, yong.huang@smartx.com wrote=
:
> > > > From: Hyman Huang <yong.huang@smartx.com>
> > > >
> > > > The first iteration's RAMBlock dirty sync can be omitted because QE=
MU
> > > > always initializes the RAMBlock's bmap to all 1s by default.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  migration/cpu-throttle.c |  2 +-
> > > >  migration/ram.c          | 19 ++++++++++++++++---
> > > >  2 files changed, 17 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > > > index 5179019e33..674dc2004e 100644
> > > > --- a/migration/cpu-throttle.c
> > > > +++ b/migration/cpu-throttle.c
> > > > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
> *opaque)
> > > >       * effect on guest performance, therefore omit it to avoid
> > > >       * paying extra for the sync penalty.
> > > >       */
> > > > -    if (sync_cnt <=3D 1) {
> > > > +    if (!sync_cnt) {
> > > >          goto end;
> > > >      }
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 05ff9eb328..a0123eb93e 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> > > >  {
> > > >      MigrationState *ms =3D migrate_get_current();
> > > >      RAMBlock *block;
> > > > -    unsigned long pages;
> > > > +    unsigned long pages, clear_bmap_pages;
> > > >      uint8_t shift;
> > > >
> > > >      /* Skip setting bitmap if there is no RAM */
> > > > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> > > >
> > > >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > >              pages =3D block->max_length >> TARGET_PAGE_BITS;
> > > > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> > > >              /*
> > > >               * The initial dirty bitmap for migration must be set
> with
> > > all
> > > >               * ones to make sure we'll migrate every guest RAM pag=
e
> to
> > > > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> > > >                  block->file_bmap =3D bitmap_new(pages);
> > > >              }
> > > >              block->clear_bmap_shift =3D shift;
> > > > -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages=
,
> > > shift));
> > > > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> > > > +            /*
> > > > +             * Set clear_bmap to 1 unconditionally, as we always s=
et
> > > bmap
> > > > +             * to all 1s by default.
> > > > +             */
> > > > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> > > >          }
> > > >      }
> > > >  }
> > > > @@ -2771,6 +2777,7 @@ static void
> > > migration_bitmap_clear_discarded_pages(RAMState *rs)
> > > >
> > > >  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
> > > >  {
> > > > +    Error *local_err =3D NULL;
> > > >      bool ret =3D true;
> > > >
> > > >      qemu_mutex_lock_ramlist();
> > > > @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs,
> Error
> > > **errp)
> > > >              if (!ret) {
> > > >                  goto out_unlock;
> > > >              }
> > > > -            migration_bitmap_sync_precopy(false);
> > > > +            /*
> > > > +             * Bypass the RAMBlock dirty sync and still publish th=
e
> > > > +             * notification.
> > >
> > > Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn't
> happen?
> > >
> >
> > Indeed, logically, we should not make the notification.
> >
> > Some features, like VIRTIO_BALLOON_F_FREE_PAGE_HINT, use this
> notification
> > to indirectly detect whether the RAMBlock's bmap has been updated. This
> > allows the
> > free page optimization to begin clearing parts of the bitmap that conta=
in
> > free pages.
> >
> > virtio_balloon_free_page_hint_notify
> > ......
> >     switch (pnd->reason) {
> >     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
> >         virtio_balloon_free_page_stop(dev);
> >         break;
> >     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
> >         if (vdev->vm_running) {
> >             virtio_balloon_free_page_start(dev);
> >             break;
> >         }
> >
> > The free page optimization may miss the first time window to execute if
> we
> > don't
> > send out a notification after starting the migration and initializing t=
he
> > bmap with all 1s.
> >
> > May we change the old behavior of optimization?
>
> I see.
>
> It looks like an abuse to me so far to use AFTER_BITMAP_SYNC as start of
> free page hinting.  There's no guarantee a sync is needed when start
> migration.
>
> I think we may want a pre-requisite patch to enable free page hinting
> during PRECOPY_NOTIFY_SETUP too, like PRECOPY_NOTIFY_AFTER_BITMAP_SYNC.
> That patch (if you agree) will need to copy David Hildenbrand and Wei Wan=
g
> (original author).
>

Agree, I'll try it in the next version.


>
> Thanks,
>
> --
> Peter Xu
>
>
Thanks,
Yong

--=20
Best regards

--000000000000f9d1260626714e20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 8, 202=
4 at 9:50=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pete=
rx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">On Fri, Nov 08, 2024=
 at 02:03:47PM +0800, Yong Huang wrote:<br>
&gt; On Fri, Nov 8, 2024 at 12:28=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto=
:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Thu, Nov 07, 2024 at 05:56:50PM +0800, <a href=3D"mailto:yong.=
huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The first iteration&#39;s RAMBlock dirty sync can be omitted=
 because QEMU<br>
&gt; &gt; &gt; always initializes the RAMBlock&#39;s bmap to all 1s by defa=
ult.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 migration/cpu-throttle.c |=C2=A0 2 +-<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19=
 ++++++++++++++++---<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 17 insertions(+), 4 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-thrott=
le.c<br>
&gt; &gt; &gt; index 5179019e33..674dc2004e 100644<br>
&gt; &gt; &gt; --- a/migration/cpu-throttle.c<br>
&gt; &gt; &gt; +++ b/migration/cpu-throttle.c<br>
&gt; &gt; &gt; @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(=
void *opaque)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* effect on guest performance, the=
refore omit it to avoid<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalt=
y.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!sync_cnt) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; &gt; &gt; index 05ff9eb328..a0123eb93e 100644<br>
&gt; &gt; &gt; --- a/migration/ram.c<br>
&gt; &gt; &gt; +++ b/migration/ram.c<br>
&gt; &gt; &gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void=
)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_curre=
nt();<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t shift;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Skip setting bitmap if there is no RA=
M */<br>
&gt; &gt; &gt; @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void=
)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RAMBLOCK_FOREACH_NOT_IGNOR=
ED(block) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages =3D bl=
ock-&gt;max_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bmap_pages =
=3D clear_bmap_size(pages, shift);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The =
initial dirty bitmap for migration must be set with<br>
&gt; &gt; all<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ones=
 to make sure we&#39;ll migrate every guest RAM page to<br>
&gt; &gt; &gt; @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(voi=
d)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 block-&gt;file_bmap =3D bitmap_new(pages);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;cl=
ear_bmap_shift =3D shift;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_b=
map =3D bitmap_new(clear_bmap_size(pages,<br>
&gt; &gt; shift));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_b=
map =3D bitmap_new(clear_bmap_pages);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set clear=
_bmap to 1 unconditionally, as we always set<br>
&gt; &gt; bmap<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to all 1s=
 by default.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap_set(block-=
&gt;clear_bmap, 0, clear_bmap_pages);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; @@ -2771,6 +2777,7 @@ static void<br>
&gt; &gt; migration_bitmap_clear_discarded_pages(RAMState *rs)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static bool ram_init_bitmaps(RAMState *rs, Error **err=
p)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ret =3D true;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_ramlist();<br>
&gt; &gt; &gt; @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState=
 *rs, Error<br>
&gt; &gt; **errp)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto out_unlock;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_=
sync_precopy(false);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Bypass th=
e RAMBlock dirty sync and still publish the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* notificat=
ion.<br>
&gt; &gt;<br>
&gt; &gt; Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn&#=
39;t happen?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Indeed, logically, we should not make the notification.<br>
&gt; <br>
&gt; Some features, like VIRTIO_BALLOON_F_FREE_PAGE_HINT, use this notifica=
tion<br>
&gt; to indirectly detect whether the RAMBlock&#39;s bmap has been updated.=
 This<br>
&gt; allows the<br>
&gt; free page optimization to begin clearing parts of the bitmap that cont=
ain<br>
&gt; free pages.<br>
&gt; <br>
&gt; virtio_balloon_free_page_hint_notify<br>
&gt; ......<br>
&gt;=C2=A0 =C2=A0 =C2=A0switch (pnd-&gt;reason) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_balloon_free_page_stop(dev);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vdev-&gt;vm_running) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_balloon_free_pag=
e_start(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; The free page optimization may miss the first time window to execute i=
f we<br>
&gt; don&#39;t<br>
&gt; send out a notification after starting the migration and initializing =
the<br>
&gt; bmap with all 1s.<br>
&gt; <br>
&gt; May we change the old behavior of optimization?<br>
<br>
I see.<br>
<br>
It looks like an abuse to me so far to use AFTER_BITMAP_SYNC as start of<br=
>
free page hinting.=C2=A0 There&#39;s no guarantee a sync is needed when sta=
rt<br>
migration.<br>
<br>
I think we may want a pre-requisite patch to enable free page hinting<br>
during PRECOPY_NOTIFY_SETUP too, like PRECOPY_NOTIFY_AFTER_BITMAP_SYNC.<br>
That patch (if you agree) will need to copy David Hildenbrand and Wei Wang<=
br>
(original author).<br></blockquote><div><br></div><div><div style=3D"font-f=
amily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Agree, =
I&#39;ll try it in the next version.</div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default"><span style=3D"font-=
family:Arial,Helvetica,sans-serif">=C2=A0</span><br></div></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left=
:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,=C2=A0</=
div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif">Yong<br></div></div><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000f9d1260626714e20--

