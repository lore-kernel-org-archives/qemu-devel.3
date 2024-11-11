Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8675DD2E9D8
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASNc-0005yt-Ug; Mon, 11 Nov 2024 06:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tASNa-0005yd-GL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:14:46 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tASNW-0002C4-GS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:14:46 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so770131fac.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731323680; x=1731928480;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z37lAcdLR9TQ1V9LdGE3OM5mZI8e7o1tkl5/ikaBBmQ=;
 b=x5LOMOL9uDJnxOo/Hv67z4dSrkJU7iHVH7jLKgswyaQfVxnKIXdSOa0KzhmXPFb4tK
 /rs58KlClzMKuCcDrA4vh6kuCI3zG5Z7YCDW3ZNt4l7LxsJbbGAXS4hEaqrzYe6fzrt4
 3K6imvLA+ZhL4cyjvA644QDipNv1K+0VAriiqUaNcBlWd1Lt57cvsUGinQeGgaRMDEcU
 RfPsYr2uC3QfzncG0v5is0r+m0NyGXSLq2xwr686bBQW3oS0Kjht8AuMS8J13VXmzIM9
 BFm9dR1alYP+QdCe80jnwQh4X+RGVy3UUossVrazCnMrzKDW8JZvJFZLAnur0UcUQcFl
 Wenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731323680; x=1731928480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z37lAcdLR9TQ1V9LdGE3OM5mZI8e7o1tkl5/ikaBBmQ=;
 b=dlJqXlL66kGZrzdTj3SZrSQRNsznVoPtDbU3TkJBXs0EFo0r6c2UMrNjihKXPY1nDH
 fxtzYDQROJVPYeWqXRuOskI6HOb2PblW2srm/tleL4yP11P3EffRhe/6mWq/LsSqnTZ9
 SAty6PUTJAYbwvbPLcJsBm185bT8crLsmm8pD92Xc1myh3/lC4vWLrPxJcXPyXG7c0r3
 G5RvcpfvA36cH/fi/X+1Ixnm6lCtUwmL+XuUYKwxChWC4vDxtXMj7hHWjbdvc+eGdgGh
 FSbq4PPZk7ifMHSTUSa/gpEm90YBR5lshDbaG3ZRHIz+x8nMbQdqnzJZpzYCff3lIPoT
 1Xmw==
X-Gm-Message-State: AOJu0Yzl0icG7TrAn1qDwjBlbN75aBqi+riZKkldi26fRkZibUyXVqqS
 QugsyldsuOZHFjSCkGlw93mVZ7Qe9RAIj3h2u9jb+dyaGXFblvKAXufIoTGvjNfAzY3pGgoTo2F
 gDuLFTZhxm7WzdM74jurDEsaeKOcVBwn2KoNu9g==
X-Google-Smtp-Source: AGHT+IEJYf+ze21ShUHZAAE61Am/FVVW8VljWo61Cv0ztnZ9opnm6oXWdxKE6nYn57zc1JVvb9eXPOxEcLZGwIcYhC0=
X-Received: by 2002:a05:6870:d14f:b0:287:cb2:c10 with SMTP id
 586e51a60fabf-2955fc11491mr10423052fac.0.1731323679592; Mon, 11 Nov 2024
 03:14:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
In-Reply-To: <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Nov 2024 19:14:23 +0800
Message-ID: <CAK9dgmahjOou_mcXqAe_4SwiR7n6czs-_=bDgp-+OpFJuTo_Xg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e9ed820626a13461"
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x34.google.com
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

--000000000000e9ed820626a13461
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

--000000000000e9ed820626a13461
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
bits from KVM).<br>
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
I did not dive deep into the code, maybe <br>
migration_bitmap_clear_discarded_pages() ends up clearing the bits in <br>
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

--000000000000e9ed820626a13461--

