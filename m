Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797C1C35FE4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 06:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqS0j-0004dy-6N; Tue, 17 Sep 2024 02:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS0g-0004dP-GE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:48:26 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS0d-00026y-KC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:48:26 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-710f0415ac8so2997605a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726555701; x=1727160501;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGKo0x8y/Urg5U2kUSiOyJdftvMwPNC5ZvSXQGTbFng=;
 b=DIiAlRSPUpUUwwCvKxPN1BjkW41I0Uc0W3b6BGFiudsf+rxSxHR9qKVxPXGtrw7SwA
 AwSmnyINH3Bso9FmnIG8I2UuHtYBKJA08q94AN+TUxpbiic9IMH86G6vU04Dajx2fKGz
 nW19TzCico18KDc7Xw3bafWQrgYKmo6XpuE7eq+iyH9NqLJb9Y6v9YBm7d2bicTdWzSU
 0elhed5O7pjt46rKRgrjeDQvA2luQV+RZ8VApvwKKeysBShfhdUo7027L4C57QjW3Jnb
 WKS5CpPs8i4AqLzFDnX4MhNsVWfJ1HIVsYACnf7K0yN399uop5o2SKxWl0U9Nm5AfAuW
 QWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726555701; x=1727160501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGKo0x8y/Urg5U2kUSiOyJdftvMwPNC5ZvSXQGTbFng=;
 b=iZEPeNqBHSDKJh/uE058s3z2j2UKVFDjgiyPwhPiWelgw8BsN6wscq//7LeXLLOxtJ
 rVBsdWzbq6tp/zgbszaH6XcmnigY2TlxC9AfySH2d8ybw2blBtf7wwhhfxceXo+pNitA
 1k67dDNUGkdMvQgLHIbIZrT20HIPjJmSlJEQpunWMTjMtVDLOnzDs2JXZY/NoXC07cU5
 em6DEJa0HjuCwex10ENPsz9T0jvsFxENAeXKuK1owXq+hSvUC2J3NF1gV9IKYiKSP8d3
 Cv9L5aV57+FK6XXTuF6wKaTNz8znImvi8PL1F2IL7XZnr9sN59P8EECQV1PAPkO/Grj4
 rHvA==
X-Gm-Message-State: AOJu0YzSDZeCtry+T6F4hgbS/kf5+QTU63gCYHpvQvraXCogNFOr3n5T
 UZAI2KTE48qzrz7mB9tuYpUpfIeY59m4/GcRcibwEw+kPL6SbZDshPWUtaB4erE565ZafGYwgt0
 ubr+BYbbbzNTZg3a1anPxZ+yIdojqQ+auFjFziw==
X-Google-Smtp-Source: AGHT+IEzVLgzq3lWhx9zxnhW1GDSklwB/pRQQo7rYk/r1MkgejNyuLrGvQW5QAa2OexdKU7OYh7OR0qKnDBVp+LEsAE=
X-Received: by 2002:a05:6870:c14e:b0:277:d195:ab88 with SMTP id
 586e51a60fabf-27c3f627623mr10223690fac.32.1726555700205; Mon, 16 Sep 2024
 23:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
In-Reply-To: <87msk7z4l3.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 17 Sep 2024 14:48:03 +0800
Message-ID: <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000032372f06224b13b5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32c.google.com
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

--00000000000032372f06224b13b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 5:11=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > shadow_bmap, iter_bmap and iter_dirty_pages are introduced
> > to satisfy the need for background sync.
> >
> > Meanwhile, introduce enumeration of sync method.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++++++++
> >  migration/ram.c         |  6 ++++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > index 0babd105c0..0e327bc0ae 100644
> > --- a/include/exec/ramblock.h
> > +++ b/include/exec/ramblock.h
> > @@ -24,6 +24,30 @@
> >  #include "qemu/rcu.h"
> >  #include "exec/ramlist.h"
> >
> > +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
> > +
> > +/*
> > + * The old-fashioned sync, which is, in turn, used for CPU
> > + * throttle and memory transfer.
>

Using the traditional sync method, the page sending logic iterates
the "bmap" to transfer dirty pages while the CPU throttle logic
counts the amount of new dirty pages and detects convergence.
There are two uses for "bmap".

Using the modern sync method, "bmap" is used for transfer
dirty pages and "iter_bmap" is used to track new dirty pages.


> I'm not sure I follow what "in turn" is supposed to mean in this
> sentence. Could you clarify?
>

Here I want to express "in sequence".  But failed obviously. :(


>
> > + */
> > +#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)
>
> So ITER is as opposed to background? I'm a bit confused with the terms.
>

Yes.


>
> > +
> > +/*
> > + * The modern sync, which is, in turn, used for CPU throttle
> > + * and memory transfer.
> > + */
> > +#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
> > +
> > +/* The modern sync, which is used for CPU throttle only */
> > +#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)
>
> What's the plan for the "legacy" part? To be removed soon? Do we want to
> remove it now? Maybe better to not use the modern/legacy terms unless we
> want to give the impression that the legacy one is discontinued.
>

The bitmap they utilized to track the dirty page information was the
distinction between the "legacy iteration" and the "modern iteration."
The "iter_bmap" field is used by the "modern iteration" while the "bmap"
field is used by the "legacy iteration."

Since the refinement is now transparent and there is no API available to
change the sync method, I actually want to remove it right now in order
to simplify the logic. I'll include it in the next version.


>
> > +
> > +#define RAMBLOCK_SYN_MASK  (0x7)
> > +
> > +typedef enum RAMBlockSynMode {
> > +    RAMBLOCK_SYN_LEGACY, /* Old-fashined mode */
> > +    RAMBLOCK_SYN_MODERN, /* Background-sync-supported mode */
> > +} RAMBlockSynMode;
>
> I'm also wondering wheter we need this enum + the flags or one of them
> would suffice. I'm looking at code like this in the following patches,
> for instance:
>

If we drop the "legacy modern", we can simplify the following
logic too.


> +    if (sync_mode =3D=3D RAMBLOCK_SYN_MODERN) {
> +        if (background) {
> +            flag =3D RAMBLOCK_SYN_MODERN_BACKGROUND;
> +        } else {
> +            flag =3D RAMBLOCK_SYN_MODERN_ITER;
> +        }
> +    }

Couldn't we use LEGACY/BG/ITER?


> > +
> >  struct RAMBlock {
> >      struct rcu_head rcu;
> >      struct MemoryRegion *mr;
> > @@ -89,6 +113,27 @@ struct RAMBlock {
> >       * could not have been valid on the source.
> >       */
> >      ram_addr_t postcopy_length;
> > +
> > +    /*
> > +     * Used to backup the bmap during background sync to see whether
> any dirty
> > +     * pages were sent during that time.
> > +     */
> > +    unsigned long *shadow_bmap;
> > +
> > +    /*
> > +     * The bitmap "bmap," which was initially used for both sync and
> memory
> > +     * transfer, will be replaced by two bitmaps: the previously used
> "bmap"
> > +     * and the recently added "iter_bmap." Only the memory transfer is
> > +     * conducted with the previously used "bmap"; the recently added
> > +     * "iter_bmap" is utilized for dirty bitmap sync.
> > +     */
> > +    unsigned long *iter_bmap;
> > +
> > +    /* Number of new dirty pages during iteration */
> > +    uint64_t iter_dirty_pages;
> > +
> > +    /* If background sync has shown up during iteration */
> > +    bool background_sync_shown_up;
> >  };
> >  #endif
> >  #endif
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 67ca3d5d51..f29faa82d6 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2362,6 +2362,10 @@ static void ram_bitmaps_destroy(void)
> >          block->bmap =3D NULL;
> >          g_free(block->file_bmap);
> >          block->file_bmap =3D NULL;
> > +        g_free(block->shadow_bmap);
> > +        block->shadow_bmap =3D NULL;
> > +        g_free(block->iter_bmap);
> > +        block->iter_bmap =3D NULL;
> >      }
> >  }
> >
> > @@ -2753,6 +2757,8 @@ static void ram_list_init_bitmaps(void)
> >              }
> >              block->clear_bmap_shift =3D shift;
> >              block->clear_bmap =3D bitmap_new(clear_bmap_size(pages,
> shift));
> > +            block->shadow_bmap =3D bitmap_new(pages);
> > +            block->iter_bmap =3D bitmap_new(pages);
> >          }
> >      }
> >  }
>


--=20
Best regards

--00000000000032372f06224b13b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 20=
24 at 5:11=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">=
farosas@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Huang &lt;<a=
 href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.=
com</a>&gt; writes:<br>
<br>
&gt; shadow_bmap, iter_bmap and iter_dirty_pages are introduced<br>
&gt; to satisfy the need for background sync.<br>
&gt;<br>
&gt; Meanwhile, introduce enumeration of sync method.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++++=
+<br>
&gt;=C2=A0 2 files changed, 51 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h<br>
&gt; index 0babd105c0..0e327bc0ae 100644<br>
&gt; --- a/include/exec/ramblock.h<br>
&gt; +++ b/include/exec/ramblock.h<br>
&gt; @@ -24,6 +24,30 @@<br>
&gt;=C2=A0 #include &quot;qemu/rcu.h&quot;<br>
&gt;=C2=A0 #include &quot;exec/ramlist.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The old-fashioned sync, which is, in turn, used for CPU<br>
&gt; + * throttle and memory transfer.<br></blockquote><div><br></div><div =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif">Using the traditional sync method, the page sending logic iterates<=
/div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif">the &quot;bmap&quot; to transfer dirty pages while the CP=
U throttle logic</div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">counts the amount of new dirty pages and=
 detects convergence.</div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif">There are two uses for &quot;bmap&q=
uot;.</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Using the modern sync method=
, &quot;bmap&quot; is used for transfer</div><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">dirty pages and &=
quot;iter_bmap&quot; is used to track new dirty pages.</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex">
<br>
I&#39;m not sure I follow what &quot;in turn&quot; is supposed to mean in t=
his<br>
sentence. Could you clarify?<br></blockquote><div><br></div><div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">Here I want to express &quot;in sequence&quot;.=C2=A0 But failed obvious=
ly. :(</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; + */<br>
&gt; +#define RAMBLOCK_SYN_LEGACY_ITER=C2=A0 =C2=A0(1U &lt;&lt; 0)<br>
<br>
So ITER is as opposed to background? I&#39;m a bit confused with the terms.=
<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif" class=3D"gmail_default">Yes.=C2=A0</div></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(=
204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The modern sync, which is, in turn, used for CPU throttle<br>
&gt; + * and memory transfer.<br>
&gt; + */<br>
&gt; +#define RAMBLOCK_SYN_MODERN_ITER=C2=A0 =C2=A0(1U &lt;&lt; 1)<br>
&gt; +<br>
&gt; +/* The modern sync, which is used for CPU throttle only */<br>
&gt; +#define RAMBLOCK_SYN_MODERN_BACKGROUND=C2=A0 =C2=A0 (1U &lt;&lt; 2)<b=
r>
<br>
What&#39;s the plan for the &quot;legacy&quot; part? To be removed soon? Do=
 we want to<br>
remove it now? Maybe better to not use the modern/legacy terms unless we<br=
>
want to give the impression that the legacy one is discontinued.<br></block=
quote><div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quo=
t;,sans-serif" class=3D"gmail_default">The bitmap they utilized to track th=
e dirty page information was the</div><div style=3D"font-family:&quot;comic=
 sans ms&quot;,sans-serif" class=3D"gmail_default">distinction between the =
&quot;legacy iteration&quot; and the &quot;modern iteration.&quot;</div><di=
v style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail=
_default">The &quot;iter_bmap&quot; field is used by the &quot;modern itera=
tion&quot; while the &quot;bmap&quot;</div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default">field is used by th=
e &quot;legacy iteration.&quot;<br></div><div style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">Since the refinement is now transparent and there is no API available to=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">change the sync method, I actually want to remove it rig=
ht now in order</div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">to simplify the logic. I&#39;ll include i=
t in the next version.</div></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +#define RAMBLOCK_SYN_MASK=C2=A0 (0x7)<br>
&gt; +<br>
&gt; +typedef enum RAMBlockSynMode {<br>
&gt; +=C2=A0 =C2=A0 RAMBLOCK_SYN_LEGACY, /* Old-fashined mode */<br>
&gt; +=C2=A0 =C2=A0 RAMBLOCK_SYN_MODERN, /* Background-sync-supported mode =
*/<br>
&gt; +} RAMBlockSynMode;<br>
<br>
I&#39;m also wondering wheter we need this enum + the flags or one of them<=
br>
would suffice. I&#39;m looking at code like this in the following patches,<=
br>
for instance:<br></blockquote><div><br></div><div><span style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif">If we drop the &quot;legacy modern&=
quot;, we can simplify <span class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif"></span>t<span class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">he following</sp=
an></span></div><div><span style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif"><span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">logic</span>=C2=A0too.</span>=C2=A0<span class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><=
/span><br></div><div><span class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif"><br></span></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
+=C2=A0 =C2=A0 if (sync_mode =3D=3D RAMBLOCK_SYN_MODERN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (background) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D RAMBLOCK_SYN_MODERN_BAC=
KGROUND;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D RAMBLOCK_SYN_MODERN_ITE=
R;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-=
left-color:rgb(204,204,204);padding-left:1ex">
Couldn&#39;t we use LEGACY/BG/ITER?</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 struct RAMBlock {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct rcu_head rcu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct MemoryRegion *mr;<br>
&gt; @@ -89,6 +113,27 @@ struct RAMBlock {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* could not have been valid on the source.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ram_addr_t postcopy_length;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Used to backup the bmap during background sync =
to see whether any dirty<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* pages were sent during that time.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 unsigned long *shadow_bmap;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The bitmap &quot;bmap,&quot; which was initiall=
y used for both sync and memory<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* transfer, will be replaced by two bitmaps: the =
previously used &quot;bmap&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and the recently added &quot;iter_bmap.&quot; O=
nly the memory transfer is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* conducted with the previously used &quot;bmap&q=
uot;; the recently added<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* &quot;iter_bmap&quot; is utilized for dirty bit=
map sync.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 unsigned long *iter_bmap;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Number of new dirty pages during iteration */<br>
&gt; +=C2=A0 =C2=A0 uint64_t iter_dirty_pages;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* If background sync has shown up during iteration */<=
br>
&gt; +=C2=A0 =C2=A0 bool background_sync_shown_up;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 67ca3d5d51..f29faa82d6 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2362,6 +2362,10 @@ static void ram_bitmaps_destroy(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;bmap =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(block-&gt;file_bmap);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;file_bmap =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(block-&gt;shadow_bmap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;shadow_bmap =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(block-&gt;iter_bmap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;iter_bmap =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -2753,6 +2757,8 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap_s=
hift =3D shift;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap =
=3D bitmap_new(clear_bmap_size(pages, shift));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;shadow_bmap =3D b=
itmap_new(pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;iter_bmap =3D bit=
map_new(pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000032372f06224b13b5--

