Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02246D2E9D0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARLu-0001VQ-Pg; Mon, 11 Nov 2024 05:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tARLT-0000Kz-NK
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:08:32 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tARLQ-0003Wf-VW
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:08:31 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71808b6246bso2429023a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731319707; x=1731924507;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/bk/6VUuBNBsouZT4BNvSy09HfvlKVWAh7uW1CF9uM=;
 b=JykgsXiTZxq7Mtz9I0bI9fcNGLUru9NMq4kAN5IvthXOhtZSWfo0JZykk9LWAjhNWv
 kGZxL5RCLxUD4uCsR13I1dV4ROmR0t7lw+qBavdFteECQ5TcfqR3ypuUSQXLq6QsupRs
 1fdqeBXylQsLIAT8xtywe9skuEbq853MHvaNTC2bS7NWDF5ZIgGsyJn0G67fyaOt4zf/
 jbtNAGNaTz5Zf8MS+7PR2Dyz5NLupdR9dfFlqJ1/TCMuW2VRPHDcSSZgiYpIzSaMKp8w
 NH/0P4UVEj3JzSLMToJHnf6yspa6SQQWZACUhV7O1CLJVwk5CGnFWamheslhjmv7VO46
 xVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731319707; x=1731924507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/bk/6VUuBNBsouZT4BNvSy09HfvlKVWAh7uW1CF9uM=;
 b=UTlbhzIIhrsAmo23fE4Hw5ry+1sMRub7ZKf/32/io6dVacscXlVtBhl1WVyQz4HzIR
 gFLMSWlAZK4RZoQPwBBWWswFApNKGnUbEqKpyJg76hSw5qqQ0TSOT1vDDa1r550mBfBa
 CNc2mpphLaTBCdSBNfFRB64c+QhaUaGBjHy4qAwndYr6pBp6JUOPW+Xbhnex1fSNHQh5
 qL3bpPaiGRJn097Lh3CDjGDCyFLZLS5rcLCCOoUOFHIk4UCPYvaRimN89vSI30Zh0kF5
 ejoT+0Xr6DQWiwYg5rlh8UUuMBEVfU8g3oZAQqOCLET8SiTPK0q0+pb827Oh5RYN/rqu
 em0g==
X-Gm-Message-State: AOJu0YxopOpobWJ5JPH7tNLTbkVgOyTdDKhkH7BsTeEnNVYb0x31JtoK
 Df2nzQ+IujLKqiJlMGPM3AaRPUjvHSR3tjk39pedQrdomWl5KAObXIW6HXL3NqltfkH8qeaUpp5
 d3DaoeytNiNO6W3GkrjwcPTF1Rcfm9TERATtOEA==
X-Google-Smtp-Source: AGHT+IH2FdslTAb/j+VEENCv1KBBhB/8qtblYVVk6GzPbMgwSzfJp3Wz7dk2USxx62pc2kKJatTJKLJvlRRCOpqM5mc=
X-Received: by 2002:a05:6870:230a:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-29560065134mr9790890fac.12.1731319706249; Mon, 11 Nov 2024
 02:08:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
In-Reply-To: <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Nov 2024 18:08:10 +0800
Message-ID: <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000157f490626a0482d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x335.google.com
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

--000000000000157f490626a0482d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 5:27=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:

> On 09.11.24 05:59, Hyman Huang wrote:
> > The first iteration's RAMBlock dirty sync can be omitted because QEMU
> > always initializes the RAMBlock's bmap to all 1s by default.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >   migration/cpu-throttle.c |  2 +-
> >   migration/ram.c          | 11 ++++++++---
> >   2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > index 5179019e33..674dc2004e 100644
> > --- a/migration/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaqu=
e)
> >        * effect on guest performance, therefore omit it to avoid
> >        * paying extra for the sync penalty.
> >        */
> > -    if (sync_cnt <=3D 1) {
> > +    if (!sync_cnt) {
> >           goto end;
> >       }
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 05ff9eb328..571dba10b7 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> >   {
> >       MigrationState *ms =3D migrate_get_current();
> >       RAMBlock *block;
> > -    unsigned long pages;
> > +    unsigned long pages, clear_bmap_pages;
> >       uint8_t shift;
> >
> >       /* Skip setting bitmap if there is no RAM */
> > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> >
> >           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >               pages =3D block->max_length >> TARGET_PAGE_BITS;
> > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> >               /*
> >                * The initial dirty bitmap for migration must be set wit=
h
> all
> >                * ones to make sure we'll migrate every guest RAM page t=
o
> > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> >                   block->file_bmap =3D bitmap_new(pages);
> >               }
> >               block->clear_bmap_shift =3D shift;
> > -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages,
> shift));
> > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> > +            /*
> > +             * Set clear_bmap to 1 unconditionally, as we always set
> bmap
> > +             * to all 1s by default.
> > +             */
> > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> >           }
> >       }
> >   }
> > @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> **errp)
> >               if (!ret) {
> >                   goto out_unlock;
> >               }
> > -            migration_bitmap_sync_precopy(false);
> >           }
> >       }
> >   out_unlock:
>
>
> For virtio-mem, we rely on the migration_bitmap_clear_discarded_pages()
> call to clear all bits that correspond to unplugged memory ranges.


> If we ommit the sync, we can likely have bits of unplugged ranges still
> set to "1", meaning we would try migrate them later, although we shouldn'=
t?
>


IIUC, migration_bitmap_clear_discarded_pages is still called at the end of
ram_init_bitmaps no matter if we omit the first sync.

PRECOPY_NOTIFY_SETUP notification is sent out at the end of
ram_save_setup(ram_list_init_bitmaps), when
virtio_balloon_free_page_start() is
called, migration_bitmap_clear_discarded_pages() has already completed and
the
bmap has been correctly cleared.

ram_save_setup
   -> ram_list_init_bitmaps
       -> migration_bitmap_clear_discarded_pages
    -> return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);

You can double check it.


>
> Or is that handled differently?
>
> --
> Cheers,
>
> David / dhildenb
>
>
Thanks for the comments,

Yong

--=20
Best regards

--000000000000157f490626a0482d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Nov 11, 2024 at 5:27=E2=80=AFPM David Hildenbrand &lt;<a href=3D"mai=
lto:david@redhat.com" target=3D"_blank">david@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,=
204);padding-left:1ex">On 09.11.24 05:59, Hyman Huang wrote:<br>
&gt; The first iteration&#39;s RAMBlock dirty sync can be omitted because Q=
EMU<br>
&gt; always initializes the RAMBlock&#39;s bmap to all 1s by default.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0migration/cpu-throttle.c |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++=
+++++---<br>
&gt;=C2=A0 =C2=A02 files changed, 9 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c<br>
&gt; index 5179019e33..674dc2004e 100644<br>
&gt; --- a/migration/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaq=
ue)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * effect on guest performance, therefore om=
it it to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * paying extra for the sync penalty.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 if (!sync_cnt) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 05ff9eb328..571dba10b7 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationState *ms =3D migrate_get_current()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
&gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t shift;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Skip setting bitmap if there is no RAM */=
<br>
&gt; @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RAMBLOCK_FOREACH_NOT_IGNORED(b=
lock) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages =3D block-=
&gt;max_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bmap_pages =3D clear_=
bmap_size(pages, shift);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The initial d=
irty bitmap for migration must be set with all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ones to make =
sure we&#39;ll migrate every guest RAM page to<br>
&gt; @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bl=
ock-&gt;file_bmap =3D bitmap_new(pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;clear_=
bmap_shift =3D shift;<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to out_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_sync_preco=
py(false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0out_unlock:<br>
<br>
<br>
For virtio-mem, we rely on the migration_bitmap_clear_discarded_pages() <br=
>
call to clear all bits that correspond to unplugged memory ranges.=C2=A0</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex">
<br>
If we ommit the sync, we can likely have bits of unplugged ranges still <br=
>
set to &quot;1&quot;, meaning we would try migrate them later, although we =
shouldn&#39;t?<br></blockquote><div><br></div><div><font face=3D"comic sans=
 ms, sans-serif"><br></font></div><div><font face=3D"comic sans ms, sans-se=
rif"><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">IIUC,=C2=A0</span>migration_bitmap_clear_discarded_pages=
</font><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif"> is still called at the end of</span></div><div><span =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif">ram_init_bitmaps no matter=C2=A0</span><span class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">if we omit the=
 first sync.</span></div><div><span style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif"><br></span></div><div><span style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">PRECOPY_NOTIFY_SETUP</span><span class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"> n=
otification is sent=C2=A0</span><span class=3D"gmail_default" style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif">out at the end of=C2=A0</span=
></div><div><span class=3D"gmail_default" style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif">ram_save_setu</span><span class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">p(</span><span =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">ram_list_init_bi=
tmaps),<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif">=C2=A0</span></span><span style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif">when virtio_balloon_free_page_start() is</sp=
an></div><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">called,<span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">=C2=A0</span></span><span style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">migration_bitmap_clear_discarded_pages()=
 has already completed and th</span><span class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">e</span></div><div><font =
face=3D"comic sans ms, sans-serif">bmap has been correctly cleared.</font><=
/div><div><font face=3D"comic sans ms, sans-serif"><br></font></div><font f=
ace=3D"comic sans ms, sans-serif">r<span class=3D"gmail_default">am_save_se=
tup</span></font></div><div class=3D"gmail_quote"><font face=3D"comic sans =
ms, sans-serif"><span class=3D"gmail_default"> =C2=A0 =C2=A0-&gt;=C2=A0</sp=
an>ram_list_init_bitmaps</font></div><div class=3D"gmail_quote"><div class=
=3D"gmail_default"><font face=3D"comic sans ms, sans-serif"> =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-&gt;=C2=A0migration_bitmap_clear_discarded_pages</font></div>=
<div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=
=A0 =C2=A0 -&gt; return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);</font><=
br></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-ser=
if"><br></font></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">You can double check it.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,=
204);padding-left:1ex">
<br>
Or is that handled differently?<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks fo=
r the comments,</div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div></div><d=
iv><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic san=
s ms, sans-serif">Best regards</font></div></div></div>
</div>

--000000000000157f490626a0482d--

