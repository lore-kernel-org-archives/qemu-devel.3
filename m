Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A0D5E13F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I6e-000848-MV; Fri, 08 Nov 2024 01:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9I6L-0007nB-Nq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 01:04:13 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9I6H-0008Gt-Lx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 01:04:09 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ebc04d4777so951479eaf.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 22:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731045844; x=1731650644;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BMyM0hMWZCc1ait7PW8XxMUAlNesfct3gT/4DVGislE=;
 b=DFTUNgG5aa7/sNoe270putsifOu96OIE0E4Yi17xscsNJ9x7wstWCkl9UdgtFhbMzO
 Zg0zEYxVUHSXOJKDiu72ud3UhCAzXdkDa0Z4qnP1oCtNmsmrqwhw/um6WOc+ueH5sNxV
 FPdH2FUsxD3S1Mw1GTVvS74kcbThLxopFj8RfriIkC4mOf+rxXCHBKYoaeGEqUMeJELP
 wbJsokBrxP6Gt4gvEVa6HHreqmdjKrnResRzTq26k/mIScD4UWYz6cr203QuSZQAGkAy
 jBPye4eaKGH9mrD8pXNPqlqt+4yh0Rd6LpN6SvRVFp7OIxihxMx87qdziKclS8CSX59U
 7Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045844; x=1731650644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMyM0hMWZCc1ait7PW8XxMUAlNesfct3gT/4DVGislE=;
 b=ALRVrpyc5uT8yiFQKyDeG7l74dr0xORrlDH0nD3zqA9D5vG/CX1DtsQJ3auoH8GhZQ
 vxFF+YeLbdXUWlgvWkSrN/hlJu5b8toPyfiUqOr1wM9QeO1i3xgwhM8u3UvhjIKqMmRw
 Oy3h2Gjw78wVdH1SrpMpOvcLlEEH+lW8ScSS+J/BlCozkI8/JoEkyVWd2Y6KWQycKYoX
 4g8kaHc+XGYAAcdZ5zyLvxNp9S9VWkkPLVgS8U4umKz652f2icku/XctOxSyWtOQoif2
 GEjFIkpSTkEela/QFU+5yya5kpRo41QOyji5y+DKRxFUCSlOhOfrVMk//YOI/GFzGZjs
 e/Fw==
X-Gm-Message-State: AOJu0YzEp1+uhVCk02JVOPALXJONPdkWkqyCl1cTyBn2pze2jmK+keXX
 dKs+0HIA9BI4YEAZyEsOHqvgnByw8tShKD7TnUD07y7ET1I7UZLIXkp4JsrhVZt4TU+DYGwpiPy
 ClzWFSolMTp5WmWmHTeZjYp5BReoDLAi9bvicSA==
X-Google-Smtp-Source: AGHT+IGsnZFD5vco9JcwHyQLVV646jruU5t8qBpWEUqsQ7NFK06B2rRKqkBL9gi1FBACbP5zsmvodkIHOjYfYJ57KDc=
X-Received: by 2002:a05:6870:310f:b0:277:caf7:3631 with SMTP id
 586e51a60fabf-29560032e88mr1516653fac.5.1731045843495; Thu, 07 Nov 2024
 22:04:03 -0800 (PST)
MIME-Version: 1.0
References: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
 <ZyzqosT0uE6_G4as@x1n>
In-Reply-To: <ZyzqosT0uE6_G4as@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 8 Nov 2024 14:03:47 +0800
Message-ID: <CAK9dgmZCZp3scJTAGJc=KF9dgaftxD=V3uUADeyyYqFc_yGhkA@mail.gmail.com>
Subject: Re: [PATCH] migration: Do not perform RAMBlock dirty sync during the
 first iteration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000009789d006266084e8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TRACKER_ID=0.1 autolearn=no autolearn_force=no
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

--0000000000009789d006266084e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:28=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Nov 07, 2024 at 05:56:50PM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > The first iteration's RAMBlock dirty sync can be omitted because QEMU
> > always initializes the RAMBlock's bmap to all 1s by default.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/cpu-throttle.c |  2 +-
> >  migration/ram.c          | 19 ++++++++++++++++---
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > index 5179019e33..674dc2004e 100644
> > --- a/migration/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaqu=
e)
> >       * effect on guest performance, therefore omit it to avoid
> >       * paying extra for the sync penalty.
> >       */
> > -    if (sync_cnt <=3D 1) {
> > +    if (!sync_cnt) {
> >          goto end;
> >      }
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 05ff9eb328..a0123eb93e 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> >  {
> >      MigrationState *ms =3D migrate_get_current();
> >      RAMBlock *block;
> > -    unsigned long pages;
> > +    unsigned long pages, clear_bmap_pages;
> >      uint8_t shift;
> >
> >      /* Skip setting bitmap if there is no RAM */
> > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> >
> >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >              pages =3D block->max_length >> TARGET_PAGE_BITS;
> > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> >              /*
> >               * The initial dirty bitmap for migration must be set with
> all
> >               * ones to make sure we'll migrate every guest RAM page to
> > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> >                  block->file_bmap =3D bitmap_new(pages);
> >              }
> >              block->clear_bmap_shift =3D shift;
> > -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages,
> shift));
> > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> > +            /*
> > +             * Set clear_bmap to 1 unconditionally, as we always set
> bmap
> > +             * to all 1s by default.
> > +             */
> > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> >          }
> >      }
> >  }
> > @@ -2771,6 +2777,7 @@ static void
> migration_bitmap_clear_discarded_pages(RAMState *rs)
> >
> >  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
> >  {
> > +    Error *local_err =3D NULL;
> >      bool ret =3D true;
> >
> >      qemu_mutex_lock_ramlist();
> > @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> **errp)
> >              if (!ret) {
> >                  goto out_unlock;
> >              }
> > -            migration_bitmap_sync_precopy(false);
> > +            /*
> > +             * Bypass the RAMBlock dirty sync and still publish the
> > +             * notification.
>
> Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn't happen?
>

Indeed, logically, we should not make the notification.

Some features, like VIRTIO_BALLOON_F_FREE_PAGE_HINT, use this notification
to indirectly detect whether the RAMBlock's bmap has been updated. This
allows the
free page optimization to begin clearing parts of the bitmap that contain
free pages.

virtio_balloon_free_page_hint_notify
......
    switch (pnd->reason) {
    case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
        virtio_balloon_free_page_stop(dev);
        break;
    case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
        if (vdev->vm_running) {
            virtio_balloon_free_page_start(dev);
            break;
        }

The free page optimization may miss the first time window to execute if we
don't
send out a notification after starting the migration and initializing the
bmap with all 1s.

May we change the old behavior of optimization?


> > +             */
> > +            if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
> &local_err)) {
> > +                error_report_err(local_err);
> > +            }
> >          }
> >      }
> >  out_unlock:
> > --
> > 2.27.0
> >
>
> --
> Peter Xu
>
>

--=20
Best regards

--0000000000009789d006266084e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, Nov 8, 2024 at 12:28=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peter=
x@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">On Thu, Nov 07, 2024 at 05:56:50PM +0800, <a href=3D"mailto=
:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<=
br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; The first iteration&#39;s RAMBlock dirty sync can be omitted because Q=
EMU<br>
&gt; always initializes the RAMBlock&#39;s bmap to all 1s by default.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/cpu-throttle.c |=C2=A0 2 +-<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19 +++++++++=
+++++++---<br>
&gt;=C2=A0 2 files changed, 17 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c<br>
&gt; index 5179019e33..674dc2004e 100644<br>
&gt; --- a/migration/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaq=
ue)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* effect on guest performance, therefore omi=
t it to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalty.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 if (!sync_cnt) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 05ff9eb328..a0123eb93e 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t shift;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Skip setting bitmap if there is no RAM */<br>
&gt; @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RAMBLOCK_FOREACH_NOT_IGNORED(block) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages =3D block-&gt;ma=
x_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bmap_pages =3D clear_=
bmap_size(pages, shift);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The initial di=
rty bitmap for migration must be set with all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ones to make s=
ure we&#39;ll migrate every guest RAM page to<br>
&gt; @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&g=
t;file_bmap =3D bitmap_new(pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap_s=
hift =3D shift;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap =3D bi=
tmap_new(clear_bmap_size(pages, shift));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap =3D bi=
tmap_new(clear_bmap_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set clear_bmap to 1=
 unconditionally, as we always set bmap<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to all 1s by defaul=
t.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap_set(block-&gt;clear_=
bmap, 0, clear_bmap_pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; @@ -2771,6 +2777,7 @@ static void migration_bitmap_clear_discarded_pag=
es(RAMState *rs)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static bool ram_init_bitmaps(RAMState *rs, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ret =3D true;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_ramlist();<br>
&gt; @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out=
_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_sync_preco=
py(false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Bypass the RAMBlock=
 dirty sync and still publish the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* notification.<br>
<br>
Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn&#39;t happe=
n?<br></blockquote><div><br></div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default">Indeed, logically, we should=
 not make the notification.</div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Some f=
eatures, like VIRTIO_BALLOON_F_FREE_PAGE_HINT, use this notification</div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default">to indirectly detect whether the RAMBlock&#39;s bmap has been u=
pdated. This allows the</div><div style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif" class=3D"gmail_default">free page optimization to begin c=
learing parts of the bitmap that contain free pages.<br></div><div style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">=
<br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default">virtio_balloon_free_page_hint_notify<br></div><div s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_de=
fault">......</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">=C2=A0 =C2=A0 switch (pnd-&gt;reason) {<br>=
=C2=A0 =C2=A0 case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 virtio_balloon_free_page_stop(dev);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>=C2=A0 =C2=A0 case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (vdev-&gt;vm_running) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 virtio_balloon_free_page_start(dev);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br=
></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" clas=
s=3D"gmail_default">The free page optimization may miss the first time wind=
ow to execute if we don&#39;t</div><div style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif" class=3D"gmail_default">send out a notification aft=
er starting the migration and initializing the bmap with all 1s.<br></div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif" class=3D"gmail_default">May we change the old behavior of optimi=
zation?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-l=
eft-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (precopy_notify(PRECOPY_=
NOTIFY_AFTER_BITMAP_SYNC, &amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_=
err(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 out_unlock:<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>
</div>

--0000000000009789d006266084e8--

