Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E42FD2E9DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASk3-0002CZ-Nq; Mon, 11 Nov 2024 06:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tASk1-0002CO-SC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:37:57 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tASjy-0004UF-74
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:37:57 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-28c7f207806so1868269fac.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731325072; x=1731929872;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PVN8CQzRo7VrjPMyF8zaVeN/iybKfoozjAPDrKD2JBw=;
 b=cx5vYYlnSbjpxhErl5viwrFgfJ1pmQ+xyJpk3gNByvGSjJb+TbTPkwhf4c9uhJrHGI
 2h8ILK37zy78D10GOX3LbfRjWILxzlJcEjlFmRgREAxddvxRX7gROanJn6UQbE5Fi725
 fUImtYD70BH7MJ+2EOhlVqLDQnZrtyGy9DOwPLZ36NGe07atV7kcO7vgevoppwxUZYSV
 zY71Pf+EIQue4njrSP5YG92mh9BauO6rU/oR21/ksWvM+4HkCiUIhg9lkAKc6KHalid9
 MjqtfMugxevHd/yQfi6qI/ONLtAAnD/De0LowV576nOtYuT14xOOPsqFHST5aOdqHy/d
 uJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731325072; x=1731929872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVN8CQzRo7VrjPMyF8zaVeN/iybKfoozjAPDrKD2JBw=;
 b=iwP0f4xKzU4+hXOIFfJRNbD5cX2LT9IooK9opKOaESQCBxeY6CRr3RMf0FLFeGUmF7
 IShw+a0efaSDmbdwIdpdr5P0B3a1Q+MhP/6Tq5YQ81Id/78VGuootOVtaS28zopTDvB1
 M4j32qmc2tr8GxRX7Ssi/14cRVIM+mxe0QbqSky0wV2N0V3rzHhEb9O1uq37Cex9jSUl
 zakn/joJlBw+dpRk2mKXzCX+V6HdOWPmPbNcTrkrC+C3rT4sDsGHXT0fBHMPZPFpcSNf
 DPrkY7gywHbrWVkcyTTfZ5R88xZIjpKtAZBiDRvj5u2gY3hKgTciMYv5tPc1OqL2Mj0X
 y4Hg==
X-Gm-Message-State: AOJu0Yynt/ug89nnUfZoG3YclNaqcRxyykvgalBjbyfUfb+IdbJ5oEq8
 n9pgP4UiLyLgBkRwjNni3RdEWP+AE2g5UvJb/DgMEEugBUpu/XU/vOIOzcBeg88MHrtjI7QqM0g
 mBIsC54PIEHCjWLi1RCu6ECd85aoIO516IsJyo6ZM9ji8TqIfI/eD92o/
X-Google-Smtp-Source: AGHT+IFsF70a21WOb1Op36+ZOTJ2iF2jlymtibGR8CY3uXm/E+98zEqQhfGjj4o1J2jzziA++K9Y3UX4Q+DrODAv81g=
X-Received: by 2002:a05:6870:e249:b0:287:a53:935a with SMTP id
 586e51a60fabf-295600bd089mr8607560fac.13.1731325071847; Mon, 11 Nov 2024
 03:37:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
In-Reply-To: <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Nov 2024 19:37:35 +0800
Message-ID: <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e627680626a18743"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2c.google.com
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

--000000000000e627680626a18743
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 6:42=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:

> On 11.11.24 11:08, Yong Huang wrote:
> >
> >
> > On Mon, Nov 11, 2024 at 5:27=E2=80=AFPM David Hildenbrand <david@redhat=
.com
> > <mailto:david@redhat.com>> wrote:
> >
> >     On 09.11.24 05:59, Hyman Huang wrote:
> >      > The first iteration's RAMBlock dirty sync can be omitted because
> QEMU
> >      > always initializes the RAMBlock's bmap to all 1s by default.
> >      >
> >      > Signed-off-by: Hyman Huang <yong.huang@smartx.com
> >     <mailto:yong.huang@smartx.com>>
> >      > ---
> >      >   migration/cpu-throttle.c |  2 +-
> >      >   migration/ram.c          | 11 ++++++++---
> >      >   2 files changed, 9 insertions(+), 4 deletions(-)
> >      >
> >      > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> >      > index 5179019e33..674dc2004e 100644
> >      > --- a/migration/cpu-throttle.c
> >      > +++ b/migration/cpu-throttle.c
> >      > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
> >     *opaque)
> >      >        * effect on guest performance, therefore omit it to avoid
> >      >        * paying extra for the sync penalty.
> >      >        */
> >      > -    if (sync_cnt <=3D 1) {
> >      > +    if (!sync_cnt) {
> >      >           goto end;
> >      >       }
> >      >
> >      > diff --git a/migration/ram.c b/migration/ram.c
> >      > index 05ff9eb328..571dba10b7 100644
> >      > --- a/migration/ram.c
> >      > +++ b/migration/ram.c
> >      > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> >      >   {
> >      >       MigrationState *ms =3D migrate_get_current();
> >      >       RAMBlock *block;
> >      > -    unsigned long pages;
> >      > +    unsigned long pages, clear_bmap_pages;
> >      >       uint8_t shift;
> >      >
> >      >       /* Skip setting bitmap if there is no RAM */
> >      > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> >      >
> >      >           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >      >               pages =3D block->max_length >> TARGET_PAGE_BITS;
> >      > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> >      >               /*
> >      >                * The initial dirty bitmap for migration must be
> >     set with all
> >      >                * ones to make sure we'll migrate every guest RAM
> >     page to
> >      > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> >      >                   block->file_bmap =3D bitmap_new(pages);
> >      >               }
> >      >               block->clear_bmap_shift =3D shift;
> >      > -            block->clear_bmap =3D
> >     bitmap_new(clear_bmap_size(pages, shift));
> >      > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> >      > +            /*
> >      > +             * Set clear_bmap to 1 unconditionally, as we alway=
s
> >     set bmap
> >      > +             * to all 1s by default.
> >      > +             */
> >      > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> >      >           }
> >      >       }
> >      >   }
> >      > @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs,
> >     Error **errp)
> >      >               if (!ret) {
> >      >                   goto out_unlock;
> >      >               }
> >      > -            migration_bitmap_sync_precopy(false);
> >      >           }
> >      >       }
> >      >   out_unlock:
> >
> >
> >     For virtio-mem, we rely on the
> migration_bitmap_clear_discarded_pages()
> >     call to clear all bits that correspond to unplugged memory ranges.
> >
> >
> >     If we ommit the sync, we can likely have bits of unplugged ranges
> still
> >     set to "1", meaning we would try migrate them later, although we
> >     shouldn't?
> >
> >
> >
> > IIUC, migration_bitmap_clear_discarded_pagesis still called at the end =
of
> > ram_init_bitmaps no matter if we omit the first sync.
>  > > PRECOPY_NOTIFY_SETUPnotification is sent out at the end of
> > ram_save_setup(ram_list_init_bitmaps),when
> > virtio_balloon_free_page_start() is
> > called,migration_bitmap_clear_discarded_pages() has already completed
> > and the
> > bmap has been correctly cleared.
> >
> > ram_save_setup
> >     -> ram_list_init_bitmaps
> >         -> migration_bitmap_clear_discarded_pages
> >      -> return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
> >
> > You can double check it.
>
> That's not my concern, let me clarify :)
>
>
> Assume in KVM the bitmap is all 1s ("everything dirty").
>
> In current code, we will sync the bitmap once (IIRC, clearing any dirty
> bits from KVM).
>

For the old logic, write-protect and clear dirty bits are all done in
the KVM_GET_DIRTY_LOG API, while with
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 feature enabled, clearing
dirty bits are postponed in the KVM_CLEAR_DIRTY_LOG API, which
is called right before page sending in the migration thread in QEMU.


>
> Then we call migration_bitmap_clear_discarded_pages() to clear all
> "discarded" pages that we shouldn't touch.
>
> When we do the next bitmap sync, we will not get a "1" for discarded
> ranges, and we will never try migrating discarded ranges.
>
>
> With your patch, we're omitting the first sync. Could we possibly get
> discarded ranges reported from KVM as dirty during the "now first" sync
> *after* the migration_bitmap_clear_discarded_pages() call, and try
> migrating discarded ranges?
>
> I did not dive deep into the code, maybe
> migration_bitmap_clear_discarded_pages() ends up clearing the bits in
>

Yes, the migration_bitmap_clear_discarded_pages clear the bits in
KVM in:
ramblock_dirty_bitmap_clear_discarded_pages
    -> dirty_bitmap_clear_section
        -> migration_clear_memory_region_dirty_bitmap_range
            -> migration_clear_memory_region_dirty_bitmap
                -> memory_region_clear_dirty_bitmap
                    -> KVM_CLEAR_DIRTY_LOG ioctl


> KVM, but I recall that there was something special about the first
> bitmap sync.
>
> --
> Cheers,
>
> David / dhildenb
>
>

--=20
Best regards

--000000000000e627680626a18743
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 11, 20=
24 at 6:42=E2=80=AFPM David Hildenbrand &lt;<a href=3D"mailto:david@redhat.=
com">david@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On 11.11.24 =
11:08, Yong Huang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Nov 11, 2024 at 5:27=E2=80=AFPM David Hildenbrand &lt;<a href=
=3D"mailto:david@redhat.com" target=3D"_blank">david@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:david@redhat.com" target=3D"_blank">david=
@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 09.11.24 05:59, Hyman Huang wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The first iteration&#39;s RAMBlock dirty sync=
 can be omitted because QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; always initializes the RAMBlock&#39;s bmap to=
 all 1s by default.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mai=
lto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:yong.huang@smartx.com"=
 target=3D"_blank">yong.huang@smartx.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0migration/cpu-throttle.c |=C2=A0 =
2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 11 ++++++++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 9 insertions(+),=
 4 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/migration/cpu-throttle.c b/migra=
tion/cpu-throttle.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 5179019e33..674dc2004e 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/migration/cpu-throttle.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/migration/cpu-throttle.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -141,7 +141,7 @@ void cpu_throttle_dirty_s=
ync_timer_tick(void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * effect on guest =
performance, therefore omit it to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * paying extra for=
 the sync penalty.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!sync_cnt) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/migration/ram.c b/migration/ram.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 05ff9eb328..571dba10b7 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/migration/ram.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/migration/ram.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2718,7 +2718,7 @@ static void ram_list_in=
it_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationState *ms =
=3D migrate_get_current();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bma=
p_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t shift;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Skip setting bit=
map if there is no RAM */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2736,6 +2736,7 @@ static void ram_list_in=
it_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RAMBL=
OCK_FOREACH_NOT_IGNORED(block) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pages =3D block-&gt;max_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cl=
ear_bmap_pages =3D clear_bmap_size(pages, shift);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * The initial dirty bitmap for migration must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0set with all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * ones to make sure we&#39;ll migrate every guest RAM<br>
&gt;=C2=A0 =C2=A0 =C2=A0page to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2751,7 +2752,12 @@ static void ram_list_i=
nit_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;file_bmap =3D bitmap_new(pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0block-&gt;clear_bmap_shift =3D shift;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=
ock-&gt;clear_bmap =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0bitmap_new(clear_bmap_size(pages, shift));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=
ock-&gt;clear_bmap =3D bitmap_new(clear_bmap_pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* Set clear_bmap to 1 unconditionally, as we always<br>
&gt;=C2=A0 =C2=A0 =C2=A0set bmap<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* to all 1s by default.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bi=
tmap_set(block-&gt;clear_bmap, 0, clear_bmap_pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2783,7 +2789,6 @@ static bool ram_init_bi=
tmaps(RAMState *rs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mi=
gration_bitmap_sync_precopy(false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0out_unlock:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0For virtio-mem, we rely on the migration_bitmap_cle=
ar_discarded_pages()<br>
&gt;=C2=A0 =C2=A0 =C2=A0call to clear all bits that correspond to unplugged=
 memory ranges. <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If we ommit the sync, we can likely have bits of un=
plugged ranges still<br>
&gt;=C2=A0 =C2=A0 =C2=A0set to &quot;1&quot;, meaning we would try migrate =
them later, although we<br>
&gt;=C2=A0 =C2=A0 =C2=A0shouldn&#39;t?<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; IIUC, migration_bitmap_clear_discarded_pagesis still called at the end=
 of<br>
&gt; ram_init_bitmaps no matter if we omit the first sync.<br>
=C2=A0&gt; &gt; PRECOPY_NOTIFY_SETUPnotification is sent out at the end of<=
br>
&gt; ram_save_setup(ram_list_init_bitmaps),when <br>
&gt; virtio_balloon_free_page_start() is<br>
&gt; called,migration_bitmap_clear_discarded_pages() has already completed =
<br>
&gt; and the<br>
&gt; bmap has been correctly cleared.<br>
&gt; <br>
&gt; ram_save_setup<br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; ram_list_init_bitmaps<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;=C2=A0migration_bitmap_clear_dis=
carded_pages<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; return precopy_notify(PRECOPY_NOTIFY_SETUP, =
errp);<br>
&gt; <br>
&gt; You can double check it.<br>
<br>
That&#39;s not my concern, let me clarify :)<br>
<br>
<br>
Assume in KVM the bitmap is all 1s (&quot;everything dirty&quot;).<br>
<br>
In current code, we will sync the bitmap once (IIRC, clearing any dirty <br=
>
bits from KVM).<br></blockquote><div><br></div><div><div class=3D"gmail_def=
ault"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">For =
th</span><font face=3D"comic sans ms, sans-serif">e old logic, write-protec=
t and clear dirty bits are all done in</font></div><div class=3D"gmail_defa=
ult"><font face=3D"comic sans ms, sans-serif">the=C2=A0<span style=3D"color=
:rgb(53,55,68);font-size:10pt;white-space:pre-wrap">KVM_GET_DIRTY_LOG API, =
while with=C2=A0</span></font></div><div class=3D"gmail_default"><span styl=
e=3D"color:rgb(53,55,68);font-size:10pt;white-space:pre-wrap"><font face=3D=
"comic sans ms, sans-serif">KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 feature enabl=
ed, clearing</font></span></div><div class=3D"gmail_default"><span style=3D=
"color:rgb(53,55,68);font-size:10pt;white-space:pre-wrap"><font face=3D"com=
ic sans ms, sans-serif">dirty bits are postponed in the </font></span><span=
 style=3D"color:rgb(53,55,68);font-size:10pt;white-space:pre-wrap"><font fa=
ce=3D"comic sans ms, sans-serif">KVM_CLEAR_DIRTY_LOG API, which</font></spa=
n></div></div><div class=3D"gmail_default"><span style=3D"color:rgb(53,55,6=
8);font-size:10pt;white-space:pre-wrap"><font face=3D"comic sans ms, sans-s=
erif">is called right before page sending in the migration thread in QEMU.<=
/font></span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Then we call migration_bitmap_clear_discarded_pages() to clear all <br>
&quot;discarded&quot; pages that we shouldn&#39;t touch.<br>
<br>
When we do the next bitmap sync, we will not get a &quot;1&quot; for discar=
ded <br>
ranges, and we will never try migrating discarded ranges.<br>
<br>
<br>
With your patch, we&#39;re omitting the first sync. Could we possibly get <=
br>
discarded ranges reported from KVM as dirty during the &quot;now first&quot=
; sync <br>
*after* the migration_bitmap_clear_discarded_pages() call, and try <br>
migrating discarded ranges?<br>
<br>
I did not dive deep into the code, maybe <br>migration_bitmap_clear_discard=
ed_pages() ends up clearing the bits in <br></blockquote><div><br></div><di=
v><div class=3D"gmail_default"><span style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif">Yes, t</span><font face=3D"comic sans ms, sans-serif">=
he=C2=A0migration_bitmap_clear_discarded_pages clear the bits in</font></di=
v><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">KVM=
 in:</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, =
sans-serif">ramblock_dirty_bitmap_clear_discarded_pages<br></font></div><di=
v class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =
=C2=A0 -&gt;=C2=A0dirty_bitmap_clear_section</font></div><div class=3D"gmai=
l_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 -&gt;=C2=A0migration_clear_memory_region_dirty_bitmap_range</font></=
div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt;=C2=A0migration_clear_memory=
_region_dirty_bitmap</font></div><div class=3D"gmail_default"><font face=3D=
"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -&gt;=C2=A0memory_region_clear_dirty_bitmap</font></div><div cla=
ss=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt;=C2=A0<span s=
tyle=3D"color:rgb(53,55,68);font-size:13.333333px;white-space:pre-wrap">KVM=
_CLEAR_DIRTY_LOG ioctl</span></font></div></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">
KVM, but I recall that there was something special about the first <br>
bitmap sync.<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000e627680626a18743--

