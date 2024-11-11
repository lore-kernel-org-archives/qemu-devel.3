Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F6D2E9D3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARXf-0004Gm-MU; Mon, 11 Nov 2024 05:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tARXd-0004GW-9P
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:21:05 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tARXZ-0005S4-Gy
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:21:05 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-290d8d53893so1804134fac.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731320459; x=1731925259;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eKnchapAPM/6ZsEUmL/SBntDsB/wvSY3xp+h+VGaBQo=;
 b=Ek2A7FD3uxEJLVuyjZ0cZiDesToJYfz4CifXC4jCCCvULyBUaUYyn2/lvzBt9CHUXA
 SU0yG0JHoKO/hnaktlfVdhhMnrqroK2otF6qHIgMQXmGrPZxQhp+lyMkk33tvK4u6uZD
 Gc+GpO2qRil2tk5pNCsgGAnty2FyVVIJ72PInnIX0FSUZkjcg85QPio5mPKSnGhVqEOV
 I+M3CwBajh0nVpnPT7HSefkbmkTq95bR4QHJhM9FBgsYmoTg1buk2yuNeBj1d1A1GOsQ
 erchpkXaly+/hCAFMcLn3mVF9TDGBrIzPDiiaBvOFamC1t9dUXwlEg0lHhpNtlUoravG
 0QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731320459; x=1731925259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKnchapAPM/6ZsEUmL/SBntDsB/wvSY3xp+h+VGaBQo=;
 b=duue8APozFMHliwKL6wZxPX2B7sOUs2MXCmNTpjOcUs376yW9Qo4MS/VR6OefnoPqU
 zCwaAE0ZggUIMmHMDTpgRNg++a3EWnbVyvWPLMzIBGZSCXSD+2bu7lDuCkKHUYYV0jD0
 zMAXw9lzbO25yBHHhGJlB9XqihZwS2lu4XGF3djWvL/OdIT3St6O+FswOHZVsN2DTFC+
 P7LwxS6wZ44ZHn2RbNb382gY/H8chhfc60W6wjFyi2r0roACnMIArAoRllK4J8zT1eUK
 cT9unBmyLmSoXGDbi6O/ssWxZmtuwZKJy43w6NeAa+Y7O2YBU6myTTQfP+wvHnFolSw0
 eG9Q==
X-Gm-Message-State: AOJu0YycYp9/7WKksgjenJ45l35IYzHHzbnAtIiJCCh0ElRn+zikaxgo
 Pi0bAjxmPzuX08WvvsokHvLLE9BAlVn4GeMgxnY95TC6ZvYLixZP55rt2Dob70ngsD+B6NRO7sq
 mdVbVAztKArhPLIW5rEtfNPEbGfdegTH85ElJXixtypT/afVW7ez/BnCJ
X-Google-Smtp-Source: AGHT+IETyk+zm90kGHISbxZE6IjCgqAtan1kSPR6yt+9EA8oNyh7oU90HkDNCQTUgvF0o+ybffSdLZsKe2nKVMMI9Nc=
X-Received: by 2002:a05:6870:414a:b0:287:29a0:cfe4 with SMTP id
 586e51a60fabf-295602d30e1mr8749290fac.32.1731320458259; Mon, 11 Nov 2024
 02:20:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <DS0PR11MB6373166B09A9A0E9A0646508DC582@DS0PR11MB6373.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB6373166B09A9A0E9A0646508DC582@DS0PR11MB6373.namprd11.prod.outlook.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Nov 2024 18:20:42 +0800
Message-ID: <CAK9dgmZS+6BDiqrhBqRQdXYOd7eWxu-ddBeT+TuJ=WX2CRVN8Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e8495d0626a07454"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x35.google.com
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

--000000000000e8495d0626a07454
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 5:07=E2=80=AFPM Wang, Wei W <wei.w.wang@intel.com> =
wrote:

> On Saturday, November 9, 2024 1:00 PM, Hyman Huang wrote:
> > The first iteration's RAMBlock dirty sync can be omitted because QEMU
> > always initializes the RAMBlock's bmap to all 1s by default.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/cpu-throttle.c |  2 +-
> >  migration/ram.c          | 11 ++++++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c index
> > 5179019e33..674dc2004e 100644
> > --- a/migration/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
> > *opaque)
> >       * effect on guest performance, therefore omit it to avoid
> >       * paying extra for the sync penalty.
> >       */
> > -    if (sync_cnt <=3D 1) {
> > +    if (!sync_cnt) {
> >          goto end;
> >      }
> >
> > diff --git a/migration/ram.c b/migration/ram.c index
> > 05ff9eb328..571dba10b7 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)  {
> >      MigrationState *ms =3D migrate_get_current();
> >      RAMBlock *block;
> > -    unsigned long pages;
> > +    unsigned long pages, clear_bmap_pages;
> >      uint8_t shift;
> >
> >      /* Skip setting bitmap if there is no RAM */ @@ -2736,6 +2736,7 @@
> > static void ram_list_init_bitmaps(void)
> >
> >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >              pages =3D block->max_length >> TARGET_PAGE_BITS;
> > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> >              /*
> >               * The initial dirty bitmap for migration must be set with
> all
> >               * ones to make sure we'll migrate every guest RAM page to
> @@ -
> > 2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
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
> > @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> > **errp)
> >              if (!ret) {
> >                  goto out_unlock;
> >              }
> > -            migration_bitmap_sync_precopy(false);
>
> Would this affect the statistics collected in
> migration_bitmap_sync_precopy(),
> e.g. rs->migration_dirty_pages?
>

For the non-first dirty sync, it does.

For the first dirty sync.

Since the migration_dirty_pages is initialized in
ram_state_init and updated by ram_bytes_total() rather than
migration_bitmap_sync_precopy:

(*rsp)->migration_dirty_pages =3D (*rsp)->ram_bytes_total >> TARGET_PAGE_BI=
TS;

So it does not affect the statistics, please double check that.

Thanks for the comment,

Yong

--=20
Best regards

--000000000000e8495d0626a07454
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 11, 20=
24 at 5:07=E2=80=AFPM Wang, Wei W &lt;<a href=3D"mailto:wei.w.wang@intel.co=
m">wei.w.wang@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Saturda=
y, November 9, 2024 1:00 PM, Hyman Huang wrote:<br>
&gt; The first iteration&#39;s RAMBlock dirty sync can be omitted because Q=
EMU<br>
&gt; always initializes the RAMBlock&#39;s bmap to all 1s by default.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/cpu-throttle.c |=C2=A0 2 +-<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++++-=
--<br>
&gt;=C2=A0 2 files changed, 9 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c index=
<br>
&gt; 5179019e33..674dc2004e 100644<br>
&gt; --- a/migration/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void<br>
&gt; *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* effect on guest performance, therefore omi=
t it to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalty.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 if (!sync_cnt) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; diff --git a/migration/ram.c b/migration/ram.c index<br>
&gt; 05ff9eb328..571dba10b7 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)=C2=A0 {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t shift;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Skip setting bitmap if there is no RAM */ @@ -2=
736,6 +2736,7 @@<br>
&gt; static void ram_list_init_bitmaps(void)<br>
&gt; <br>
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
ure we&#39;ll migrate every guest RAM page to @@ -<br>
&gt; 2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)<br>
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
&gt; @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error=
<br>
&gt; **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out=
_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_sync_preco=
py(false);<br>
<br>
Would this affect the statistics collected in migration_bitmap_sync_precopy=
(),<br>
e.g. rs-&gt;migration_dirty_pages?<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">For the n=
on-first dirty sync, it does.=C2=A0</div><div style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div class=
=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">For the first=
=C2=A0dirty sync.</font></div><div class=3D"gmail_default"><font face=3D"co=
mic sans ms, sans-serif"><br></font></div><div class=3D"gmail_default"><fon=
t face=3D"comic sans ms, sans-serif">Since the migration_dirty_pages is ini=
tialized in</font></div><div class=3D"gmail_default"><font face=3D"comic sa=
ns ms, sans-serif">ram_state_init and updated by ram_bytes_total() rather t=
han</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, s=
ans-serif">migration_bitmap_sync_precopy:</font></div><div class=3D"gmail_d=
efault"><font face=3D"comic sans ms, sans-serif"><br></font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">(*rsp)-&gt;mig=
ration_dirty_pages =3D (*rsp)-&gt;ram_bytes_total &gt;&gt; TARGET_PAGE_BITS=
;</font><br></div><div class=3D"gmail_default"><font face=3D"comic sans ms,=
 sans-serif"><br></font></div><div class=3D"gmail_default"><font face=3D"co=
mic sans ms, sans-serif">So it does not affect the=C2=A0statistics, please =
double check that.</font></div></div><div class=3D"gmail_default"><font fac=
e=3D"comic sans ms, sans-serif"><br></font></div><div class=3D"gmail_defaul=
t"><font face=3D"comic sans ms, sans-serif">Thanks for the comment,</font><=
/div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
<br></font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, =
sans-serif">Yong</font></div><div class=3D"gmail_default"><font face=3D"com=
ic sans ms, sans-serif"><br></font></div><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div></div=
></div>

--000000000000e8495d0626a07454--

