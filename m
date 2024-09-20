Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11841CF3964
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 03:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srTuw-0002kk-Qq; Thu, 19 Sep 2024 23:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1srTus-0002kH-0O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 23:02:42 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1srTuo-0005mX-FS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 23:02:41 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-277f19ee2a2so804579fac.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726801356; x=1727406156;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9TiJ9vr1v7J6VArlWxbWN9unErnyIeHgYpn7HAQNF6g=;
 b=3MGI29Ana4mhOVB/po7wSf4tmPTsaYuMpSPop13Pnanr6lqmN6vjj6aO1N5X9UBhBd
 1Ph0Qd021KpdolkmG/RBz+lHVucmGouLNvhjuWTAKxP9Qri9PNrWTl3pbr2D1kpMJIpS
 14mwSTSkebzTMKE9mtXJtTdrjSA7UDhgMFnZb1tkUmQZ0m9NOXE/SAZsj7XikPp+bMth
 j96SETJJraw4YS5/6QMV/k6bAIzmdg2lCrgjQ7LsrnSPYQnhNmDCOZCBO30eeqqAxEhY
 W6/bsrBr5ollyMKp1NO7k6Ig+IUe75DEARXDDe63HchwMADBitoJHkRZt7c9MsYLUZIH
 2XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726801356; x=1727406156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9TiJ9vr1v7J6VArlWxbWN9unErnyIeHgYpn7HAQNF6g=;
 b=Lgb53L/lFTze6qXzOsOdySH+IJ64ue7ceNudzYlYAzMEnP02m9Wa+1wZ9PXxoBFzDw
 clNrJGx1ljxC3HMO/9bIqgRRCF6b+3IpTAv+hKQfDswxWLx8Z6XDHxkX3pP/1CnHGysL
 MaQS2YxMN49+mfbSpAFaj4P8LGcYqARYJ+Ae1vHsL+sAoao6M4DK6FXcaRpla+4StpC/
 vtqhn3HrgyOvjnpnv/XU8pgrsgMM3loMfXPGEeNWloXfva6LdwKEvrYURGvjPOvzn3nz
 k1MDsxGC0s3iHdXSACINz5kJFfJMz9Da+i1I/fz2FqsdTxAX++v3zFzRuQqgvjBpFyx0
 SX9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkvaaqp1dWy62+oh/VuWyoIyzfhOIlaDIOngun/l0LQZ4kEsklF7v+hTLr2oZuguoUVlPLB6+AbDVZ@nongnu.org
X-Gm-Message-State: AOJu0YwfgTLd+Wa93+m04fEnkIgfiaJVexywpmAk8owLk5O4T46z0kTp
 Fpa/Y/AeJ6WfJ3ATd0ZmBI1biQTQhhT3DvQCYsxMU/KnzJSLano96CH8dPkRFWw5TF8E8qhmq2u
 i+MLCjW5m2nRc+XrX+TftjlFzgDoEC8D5xBeAmQ==
X-Google-Smtp-Source: AGHT+IH272Pcn07OQizmIVNFn2j1JtrzpmQl5dvs4kiZw4ajOez9ZuiDcqIov3a0e84C9MLW95qvOVjJzPYgM20sd3w=
X-Received: by 2002:a05:6871:e015:b0:255:2e14:3d9d with SMTP id
 586e51a60fabf-2803cea837amr681912fac.5.1726801355946; Thu, 19 Sep 2024
 20:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
In-Reply-To: <ZuxxOObKqS_G0Ela@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 20 Sep 2024 11:02:20 +0800
Message-ID: <CAK9dgmZ4PCbBhDYhFy_3EgZDzb1oGFGs9pXsOYqz9ke_Sj10yA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006b60c006228445e9"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x29.google.com
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

--0000000000006b60c006228445e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 2:45=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Sep 17, 2024 at 02:48:03PM +0800, Yong Huang wrote:
> > On Tue, Sep 17, 2024 at 5:11=E2=80=AFAM Fabiano Rosas <farosas@suse.de>=
 wrote:
> >
> > > Hyman Huang <yong.huang@smartx.com> writes:
> > >
> > > > shadow_bmap, iter_bmap and iter_dirty_pages are introduced
> > > > to satisfy the need for background sync.
> > > >
> > > > Meanwhile, introduce enumeration of sync method.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  include/exec/ramblock.h | 45
> +++++++++++++++++++++++++++++++++++++++++
> > > >  migration/ram.c         |  6 ++++++
> > > >  2 files changed, 51 insertions(+)
> > > >
> > > > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > > > index 0babd105c0..0e327bc0ae 100644
> > > > --- a/include/exec/ramblock.h
> > > > +++ b/include/exec/ramblock.h
> > > > @@ -24,6 +24,30 @@
> > > >  #include "qemu/rcu.h"
> > > >  #include "exec/ramlist.h"
> > > >
> > > > +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
> > > > +
> > > > +/*
> > > > + * The old-fashioned sync, which is, in turn, used for CPU
> > > > + * throttle and memory transfer.
> > >
> >
> > Using the traditional sync method, the page sending logic iterates
> > the "bmap" to transfer dirty pages while the CPU throttle logic
> > counts the amount of new dirty pages and detects convergence.
> > There are two uses for "bmap".
> >
> > Using the modern sync method, "bmap" is used for transfer
> > dirty pages and "iter_bmap" is used to track new dirty pages.
> >
> >
> > > I'm not sure I follow what "in turn" is supposed to mean in this
> > > sentence. Could you clarify?
> > >
> >
> > Here I want to express "in sequence".  But failed obviously. :(
> >
> >
> > >
> > > > + */
> > > > +#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)
> > >
> > > So ITER is as opposed to background? I'm a bit confused with the term=
s.
> > >
> >
> > Yes.
> >
> >
> > >
> > > > +
> > > > +/*
> > > > + * The modern sync, which is, in turn, used for CPU throttle
> > > > + * and memory transfer.
> > > > + */
> > > > +#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
> > > > +
> > > > +/* The modern sync, which is used for CPU throttle only */
> > > > +#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)
> > >
> > > What's the plan for the "legacy" part? To be removed soon? Do we want
> to
> > > remove it now? Maybe better to not use the modern/legacy terms unless
> we
> > > want to give the impression that the legacy one is discontinued.
> > >
> >
> > The bitmap they utilized to track the dirty page information was the
> > distinction between the "legacy iteration" and the "modern iteration."
> > The "iter_bmap" field is used by the "modern iteration" while the "bmap=
"
> > field is used by the "legacy iteration."
> >
> > Since the refinement is now transparent and there is no API available t=
o
> > change the sync method, I actually want to remove it right now in order
> > to simplify the logic. I'll include it in the next version.
>
> How confident do we think the new way is better than the old?
>
> If it'll be 100% / always better, I agree we can consider removing the ol=
d.
> But is it always better?  At least it consumes much more resources..
>

Yes, it introduces an extra bitmap with respect to the old sync logic.


>
> Otherwise, we can still leave that logic as-is but use a migration proper=
ty
> to turn it on only on new machines I think.
>

OK, that's fine.


>
> Besides, could you explain why the solution needs to be this complex?  My
> previous question was that we sync dirty too less, while auto converge
> relies on dirty information, so that means auto converge can be adjusted
> too unfrequently.
>
> However I wonder whether that can be achieved in a simpler manner by
> e.g. invoke migration_bitmap_sync_precopy() more frequently during
> migration, for example, in ram_save_iterate() - not every time but the
> iterate() is invoked much more frequent, and maybe we can do sync from ti=
me
> to time.
>
> I also don't see why we need a separate thread, plus two new bitmaps, to
> achieve this..  I didn't read in-depth yet, but I thought dirty sync
> requires bql anyway, then I don't yet understand why the two bitmaps are
> required.  If the bitmaps are introduced in the 1st patch, IMO it'll be
> great to explain clearly on why they're needed here.
>
> Thanks,
>
> --
> Peter Xu
>
>

--=20
Best regards

--0000000000006b60c006228445e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 20, 20=
24 at 2:45=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Sep 17, 202=
4 at 02:48:03PM +0800, Yong Huang wrote:<br>
&gt; On Tue, Sep 17, 2024 at 5:11=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"m=
ailto:farosas@suse.de" target=3D"_blank">farosas@suse.de</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt; &gt; shadow_bmap, iter_bmap and iter_dirty_pages are introduced<b=
r>
&gt; &gt; &gt; to satisfy the need for background sync.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Meanwhile, introduce enumeration of sync method.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/exec/ramblock.h | 45 +++++++++++++++++++++++++=
++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 ++++++<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 51 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/exec/ramblock.h b/include/exec/ramblock=
.h<br>
&gt; &gt; &gt; index 0babd105c0..0e327bc0ae 100644<br>
&gt; &gt; &gt; --- a/include/exec/ramblock.h<br>
&gt; &gt; &gt; +++ b/include/exec/ramblock.h<br>
&gt; &gt; &gt; @@ -24,6 +24,30 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/rcu.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;exec/ramlist.h&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap =
*/<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * The old-fashioned sync, which is, in turn, used for CPU<=
br>
&gt; &gt; &gt; + * throttle and memory transfer.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Using the traditional sync method, the page sending logic iterates<br>
&gt; the &quot;bmap&quot; to transfer dirty pages while the CPU throttle lo=
gic<br>
&gt; counts the amount of new dirty pages and detects convergence.<br>
&gt; There are two uses for &quot;bmap&quot;.<br>
&gt; <br>
&gt; Using the modern sync method, &quot;bmap&quot; is used for transfer<br=
>
&gt; dirty pages and &quot;iter_bmap&quot; is used to track new dirty pages=
.<br>
&gt; <br>
&gt; <br>
&gt; &gt; I&#39;m not sure I follow what &quot;in turn&quot; is supposed to=
 mean in this<br>
&gt; &gt; sentence. Could you clarify?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Here I want to express &quot;in sequence&quot;.=C2=A0 But failed obvio=
usly. :(<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_LEGACY_ITER=C2=A0 =C2=A0(1U &lt;&lt; 0=
)<br>
&gt; &gt;<br>
&gt; &gt; So ITER is as opposed to background? I&#39;m a bit confused with =
the terms.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * The modern sync, which is, in turn, used for CPU throttl=
e<br>
&gt; &gt; &gt; + * and memory transfer.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_MODERN_ITER=C2=A0 =C2=A0(1U &lt;&lt; 1=
)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* The modern sync, which is used for CPU throttle only */<=
br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_MODERN_BACKGROUND=C2=A0 =C2=A0 (1U &lt=
;&lt; 2)<br>
&gt; &gt;<br>
&gt; &gt; What&#39;s the plan for the &quot;legacy&quot; part? To be remove=
d soon? Do we want to<br>
&gt; &gt; remove it now? Maybe better to not use the modern/legacy terms un=
less we<br>
&gt; &gt; want to give the impression that the legacy one is discontinued.<=
br>
&gt; &gt;<br>
&gt; <br>
&gt; The bitmap they utilized to track the dirty page information was the<b=
r>
&gt; distinction between the &quot;legacy iteration&quot; and the &quot;mod=
ern iteration.&quot;<br>
&gt; The &quot;iter_bmap&quot; field is used by the &quot;modern iteration&=
quot; while the &quot;bmap&quot;<br>
&gt; field is used by the &quot;legacy iteration.&quot;<br>
&gt; <br>
&gt; Since the refinement is now transparent and there is no API available =
to<br>
&gt; change the sync method, I actually want to remove it right now in orde=
r<br>
&gt; to simplify the logic. I&#39;ll include it in the next version.<br>
<br>
How confident do we think the new way is better than the old?<br>
<br>
If it&#39;ll be 100% / always better, I agree we can consider removing the =
old.<br>
But is it always better?=C2=A0 At least it consumes much more resources..<b=
r></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif" class=3D"gmail_default">Yes, it introduces an extra=
 bitmap with respect to the old sync logic.</div></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padd=
ing-left:1ex">
<br>
Otherwise, we can still leave that logic as-is but use a migration property=
<br>
to turn it on only on new machines I think.<br></blockquote><div><br></div>=
<div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">OK, that&#39;s fine.</div></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">
<br>
Besides, could you explain why the solution needs to be this complex?=C2=A0=
 My<br>
previous question was that we sync dirty too less, while auto converge<br>
relies on dirty information, so that means auto converge can be adjusted<br=
>
too unfrequently.<br>
<br>
However I wonder whether that can be achieved in a simpler manner by<br>
e.g. invoke migration_bitmap_sync_precopy() more frequently during<br>
migration, for example, in ram_save_iterate() - not every time but the<br>
iterate() is invoked much more frequent, and maybe we can do sync from time=
<br>
to time.<br>
<br>
I also don&#39;t see why we need a separate thread, plus two new bitmaps, t=
o<br>
achieve this..=C2=A0 I didn&#39;t read in-depth yet, but I thought dirty sy=
nc<br>
requires bql anyway, then I don&#39;t yet understand why the two bitmaps ar=
e<br>
required.=C2=A0 If the bitmaps are introduced in the 1st patch, IMO it&#39;=
ll be<br>
great to explain clearly on why they&#39;re needed here.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000006b60c006228445e9--

