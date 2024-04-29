Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B081C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GDl-0000U7-8V; Sun, 28 Apr 2024 21:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1s1GDi-0000Tg-0S
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:54:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1s1GDe-0005ZP-PZ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:54:17 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-60585faa69fso2529621a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1714355530; x=1714960330;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhKxOU9CLIx5HvZQWdAKl0KiNK+hUmB9271xKsKexQk=;
 b=eSJLIadj+DAm5tIhmsuYYU8JgMHzYPfPFG55wKqpn5P3X+CJScc0dYihOTHd/vJfO5
 r9QN40QYH0P3J/rRvaLzxykKtMa+F8yJSumdIAn8PwFo/QrdqgcC7kMfMstnwvvSaU4P
 7BH7KEVghjpdaJPseifzRkKMm8eDuC1W/Sey8CKsk9m4lU2Eh8f75zTG4bVq44Vl4uVx
 7xbzK6tZrc9dZEEyHsvJWikM17ICHWvVmPWzSESCJt/KqMyA3x2tyjUzOWMWy3KYqgWX
 GzEr0xHSsxyYnanicph2En3ZHfALLdH7tAoG76S/cZRo8jsh55i5qUasyTUTEJBz20ZZ
 d4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714355530; x=1714960330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhKxOU9CLIx5HvZQWdAKl0KiNK+hUmB9271xKsKexQk=;
 b=bzWHG63MWawoIDWfZDoGC06faLhVKSzmylst0v9hEr0e7kk2AtezNorAE+RyVxXkhZ
 pmC8cHQRGnThda66fSH00VxcoPBHiej41rmhtARbq+s1/NjRQO5Lt4hD26TRzcBu2yRs
 s75EqCYUV5u4pb+wtdxoP8c1fa/VwrDBLWwiah4TzbWE9g0Ih74BBW7OIy+z+/xIRJ2e
 fZGTcSkOqR/eYFoTDDat3tvDnbL3ANqeT7tY3QAz+2rf5+AICTS9xJCTkuYANB4ZcVDQ
 qXrSKtWC/AwXcbmYaNP4lT1h0nEIZU9kwnRYGhHsUszUm3souS3TSmhUoPuVx6R0yyMS
 K+CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO7qR4+qqQNl4BgMfWJEfas5nTZfYE/lYdUh/aOx6QQxl4122pg+UF9rwfysmew5dbT2HkFkn5mr9DNNcs8QlVnWeQbb0=
X-Gm-Message-State: AOJu0Yzz57zALP5XjUX9aZ4v3TXNfWexKG+bowJSEFUpLu8Mbw0U8HYM
 eP3S7JuSpo1Om/XizSTohgUPtS+B94NM9aIZ6PbImQNr0B1XL+BydM5msJrs/qFOOn3VPicmdWf
 n2IdyePmR32rIG7+IY93GzrYUs+fe2GgrvjPgRODL+soywafuSJ9a3NsL
X-Google-Smtp-Source: AGHT+IERJcEHnjhYqfT25f1KrJhpCOmOi4w5WD9/8VhCc/+5wHi5nsVjegrJbwOX47X1vH7bxXq9/P4AnpJHzzUq498=
X-Received: by 2002:a17:90b:400d:b0:2b0:e497:56f2 with SMTP id
 ie13-20020a17090b400d00b002b0e49756f2mr7028033pjb.10.1714355530039; Sun, 28
 Apr 2024 18:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
 <20240423091306.754432-2-mii@sfc.wide.ad.jp> <Zie5Fr3m9BquVpp3@x1n>
 <CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com>
 <9fa52b09-c0ad-4ff4-bd62-cd7b654bd65e@sfc.wide.ad.jp>
 <e5926adb-deb0-4b32-9543-ea453b44d785@fujitsu.com>
In-Reply-To: <e5926adb-deb0-4b32-9543-ea453b44d785@fujitsu.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 29 Apr 2024 09:51:53 +0800
Message-ID: <CAK9dgmasctJC+8HTHXiyy3cPhg9FsT_uGe_LAFKb_dCcfMciRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: mii <mii@sfc.wide.ad.jp>, Peter Xu <peterx@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000631b3f06173280ed"
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000631b3f06173280ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:17=E2=80=AFPM Zhijian Li (Fujitsu) <lizhijian@fuj=
itsu.com>
wrote:

>
>
> On 24/04/2024 12:52, mii wrote:
> >
> > On 2024/04/24 10:28, Yong Huang wrote:
> >>
> >>
> >> On Tue, Apr 23, 2024 at 9:35=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> >>
> >>     On Tue, Apr 23, 2024 at 09:13:08AM +0000, Masato Imai wrote:
> >>     > When the KVM acceleration parameter is not set, executing
> calc_dirty_rate
> >>     > with the -r or -b option results in a segmentation fault due to
> accessing
> >>     > a null kvm_state pointer in the kvm_dirty_ring_enabled function.
> >>     > This commit adds a check for kvm_enabled to prevent segmentation
> faults.
> >>     >
> >>     > Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
> >>     > ---
> >>     >  migration/dirtyrate.c | 7 +++++++
> >>     >  1 file changed, 7 insertions(+)
> >>     >
> >>     > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >>     > index 1d2e85746f..2a7df52519 100644
> >>     > --- a/migration/dirtyrate.c
> >>     > +++ b/migration/dirtyrate.c
> >>     > @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,
> >>     >       * dirty ring mode only works when kvm dirty ring is enable=
d.
> >>     >       * on the contrary, dirty bitmap mode is not.
> >>     >       */
> >>     > +    if (!kvm_enabled() &&
> >>     > +        (mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
> >>     > +         mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
> >>     > +        error_setg(errp, "mode %s requires kvm to be enabled.",
> >>     > +  DirtyRateMeasureMode_str(mode));
> >>     > +        return;
> >>     > +    }
> >>
> >>     Logically dirty bitmap should work with tcg.  So the other option
> is to let
> >>     kvm_dirty_ring_enabled() check kvm_state too and return false if
> >>     kvm_state=3D=3DNULL?
> >>
> >>
> >> Agree, better solution
> >>
> >>
> >>     >      if (((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
> >>     >          !kvm_dirty_ring_enabled()) ||
> >>     >          ((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
> >>     > --
> >>     > 2.34.1
> >>     >
> >>
> >>     --
> >>     Peter Xu
> >>
> >>
> >> Thanks,
> >> Yong
> >>
> >>
> >> --
> >> Best regards
> >
> > Thank you for the review. I agree with that solution.
> >
> > Update will be like:
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 931f74256e..0f8499365d 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2312,6 +2312,9 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
> >
> >   bool kvm_dirty_ring_enabled(void)
> >   {
>
>
> How about,
>
>         return kvm_state && vm_state->kvm_dirty_ring_size;
>

Hi, Masato Imai, would you like to continue this patch with version 3
as suggested?


>
>
> Thanks
> Zhijian
>
>
> > +    if (kvm_state =3D=3D NULL) {
> > +        return false;
> > +    }
> >       return kvm_state->kvm_dirty_ring_size ? true : false;
> >   }
> >


Thanks,
Yong


--=20
Best regards

--000000000000631b3f06173280ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 24, 20=
24 at 3:17=E2=80=AFPM Zhijian Li (Fujitsu) &lt;<a href=3D"mailto:lizhijian@=
fujitsu.com">lizhijian@fujitsu.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
><br>
<br>
On 24/04/2024 12:52, mii wrote:<br>
&gt; <br>
&gt; On 2024/04/24 10:28, Yong Huang wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Apr 23, 2024 at 9:35=E2=80=AFPM Peter Xu &lt;<a href=3D"ma=
ilto:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Apr 23, 2024 at 09:13:08AM +0000, Masat=
o Imai wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; When the KVM acceleration parameter is not=
 set, executing calc_dirty_rate<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; with the -r or -b option results in a segm=
entation fault due to accessing<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; a null kvm_state pointer in the kvm_dirty_=
ring_enabled function.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; This commit adds a check for kvm_enabled t=
o prevent segmentation faults.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Masato Imai &lt;<a href=3D"=
mailto:mii@sfc.wide.ad.jp" target=3D"_blank">mii@sfc.wide.ad.jp</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 migration/dirtyrate.c | 7 +++++++<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/migration/dirtyrate.c b/migra=
tion/dirtyrate.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 1d2e85746f..2a7df52519 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/migration/dirtyrate.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/migration/dirtyrate.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -799,6 +799,13 @@ void qmp_calc_dirty_r=
ate(int64_t calc_time,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* dirty ring mod=
e only works when kvm dirty ring is enabled.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* on the contrar=
y, dirty bitmap mode is not.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 if (!kvm_enabled() &amp;&am=
p;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (mode =3D=3D =
DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =
=3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;mode %s requires kvm to be enabled.&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + =C2=A0DirtyRateMeasureMode_str(mode));<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Logically dirty bitmap should work with tcg.=C2=
=A0 So the other option is to let<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0kvm_dirty_ring_enabled() check kvm_state too an=
d return false if<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0kvm_state=3D=3DNULL?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Agree, better solution<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 if (((mode =3D=3D DIRT=
Y_RATE_MEASURE_MODE_DIRTY_RING) &amp;&amp;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !kvm_dir=
ty_ring_enabled()) ||<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((mode =
=3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &amp;&amp;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.34.1<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Peter Xu<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Yong<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; -- <br>
&gt;&gt; Best regards<br>
&gt; <br>
&gt; Thank you for the review. I agree with that solution.<br>
&gt; <br>
&gt; Update will be like:<br>
&gt; <br>
&gt; diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
&gt; index 931f74256e..0f8499365d 100644<br>
&gt; --- a/accel/kvm/kvm-all.c<br>
&gt; +++ b/accel/kvm/kvm-all.c<br>
&gt; @@ -2312,6 +2312,9 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0bool kvm_dirty_ring_enabled(void)<br>
&gt;=C2=A0 =C2=A0{<br>
<br>
<br>
How about,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return kvm_state &amp;&amp; vm_state-&gt;kvm_di=
rty_ring_size;<br></blockquote><div><br></div><div><div class=3D"gmail_defa=
ult"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Hi</s=
pan><font face=3D"comic sans ms, sans-serif">,=C2=A0Masato Imai, would you =
like to continue this patch with version=C2=A03=C2=A0</font></div><div clas=
s=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif">as suggested?</span></div></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>
<br>
<br>
Thanks<br>
Zhijian<br>
<br>
<br>
&gt; +=C2=A0=C2=A0=C2=A0 if (kvm_state =3D=3D NULL) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 return kvm_state-&gt;kvm_dirty_ring_siz=
e ? true : false;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; </blockquote></div><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">Yong</div><br clear=3D"all"><div><br></div><span class=3D"gmail_signat=
ure_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></di=
v></div></div>

--000000000000631b3f06173280ed--

