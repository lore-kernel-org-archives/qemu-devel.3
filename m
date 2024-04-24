Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679B5C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 01:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzRT3-0005Y6-2w; Tue, 23 Apr 2024 21:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rzRSy-0005Xq-3z
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 21:30:32 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rzRSv-00070N-2o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 21:30:31 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso4970237a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713922105; x=1714526905;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HvzGrA+pxrw/v+UCmdez8eqSK9SA32+kLNEJ0Eo9KI8=;
 b=gTTHKiu5aAGOVJZLguqWWqj6zV+zKS25oNBA8NOIAcR2bjjL40Nh6WoKEzujPMeS8H
 0mUEvCpT6ypNVMzcE/ssIghBw/3rw5FDnBqYpRRoo6OvwfdtmPniSuo6f1rLGtJfJ1A0
 bDTBPoqML1gGrQS4LNKfOUc4M/Jr4aXCmSYnVrppVhANtYE8TaPYbe5lYD76KrqbW7X/
 OMoPtZSH04DtZ2p2VATNBS6tqT6D00QhTX+vzVGS6+vgHVbyoq7N/9ZJfjoRwoCmVru9
 4KxDtnwUt4sMVsXNL9SUMn07cllOYaA3SDiL2L7JausD3e3zdB9lLBCBzs4YfhT2IU6S
 kpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713922105; x=1714526905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HvzGrA+pxrw/v+UCmdez8eqSK9SA32+kLNEJ0Eo9KI8=;
 b=lWggXvh27kQSYlFOQb3pNdrIOEc/NKUtkbGcC/bRsll/CYxcXz07qA9ZNCuZdqYVU0
 giVp3eV6+i/vLTvkKtGnhsI7g4H4iGEiijH7wbVUM1HSqwI+fiPUc+7aubiy6iXIgw0B
 YLUVGRXOZvj76OLQRBmigeqF2KXmWPIqOdssoV4SWhJ/E1OGZiIFzqkVHjV2h0VSxraR
 /1ZYcC/tceLdv56BEyaNszhb3kpcxL52TrXNvI5GGAPF68+5VCPsQ828xplz1yZ0+63F
 zlMWHbRspC5JkxCqW3lqNl2ENTRMR94OmPhOFXj291ozAPzlotYzGLy8H6nfutDkI1XG
 lSPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVMu27QtbGESRHAoSyHebNStk9C3sJYKOT4RkYoqgJ2XNQdjJ+qd8K586PmIZoWs4/UvLxCAu7pxAr3QQVzf7EFqnAwT4=
X-Gm-Message-State: AOJu0Yzw+tIyr6BGd4vtOUZgQvuui//eHpPjDGv0Vn6WQJagipGM/GPp
 Vsg7hLBFLCIB2dN2GsDumHndIwhF+8UkGz+OoABMIfz3MjuXIDf+podoVLVR8obdWtURvEWegVM
 bTVpU49t2/EpF1RIV5paPpUwR0e8toYefMF4jGg==
X-Google-Smtp-Source: AGHT+IHtW1UzPZucOoQQ+MTQgrpXLmZczRDZNWSu2dj50IOaBLkC0NdKi6i42ply3TTi695rUzQSctc7XqFFfr3VU+g=
X-Received: by 2002:a05:6a20:1044:b0:1a7:4b3f:a66c with SMTP id
 gt4-20020a056a20104400b001a74b3fa66cmr961078pzc.49.1713922104380; Tue, 23 Apr
 2024 18:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
 <20240423091306.754432-2-mii@sfc.wide.ad.jp> <Zie5Fr3m9BquVpp3@x1n>
In-Reply-To: <Zie5Fr3m9BquVpp3@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 24 Apr 2024 09:28:08 +0800
Message-ID: <CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
To: Peter Xu <peterx@redhat.com>
Cc: Masato Imai <mii@sfc.wide.ad.jp>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000346eba0616cd96de"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52e.google.com
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

--000000000000346eba0616cd96de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 9:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Apr 23, 2024 at 09:13:08AM +0000, Masato Imai wrote:
> > When the KVM acceleration parameter is not set, executing calc_dirty_ra=
te
> > with the -r or -b option results in a segmentation fault due to accessi=
ng
> > a null kvm_state pointer in the kvm_dirty_ring_enabled function.
> > This commit adds a check for kvm_enabled to prevent segmentation faults=
.
> >
> > Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
> > ---
> >  migration/dirtyrate.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > index 1d2e85746f..2a7df52519 100644
> > --- a/migration/dirtyrate.c
> > +++ b/migration/dirtyrate.c
> > @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,
> >       * dirty ring mode only works when kvm dirty ring is enabled.
> >       * on the contrary, dirty bitmap mode is not.
> >       */
> > +    if (!kvm_enabled() &&
> > +        (mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
> > +         mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
> > +        error_setg(errp, "mode %s requires kvm to be enabled.",
> > +                         DirtyRateMeasureMode_str(mode));
> > +        return;
> > +    }
>
> Logically dirty bitmap should work with tcg.  So the other option is to l=
et
> kvm_dirty_ring_enabled() check kvm_state too and return false if
> kvm_state=3D=3DNULL?
>

Agree, better solution


> >      if (((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
> >          !kvm_dirty_ring_enabled()) ||
> >          ((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
> > --
> > 2.34.1
> >
>
> --
> Peter Xu
>
>
Thanks,
Yong


--=20
Best regards

--000000000000346eba0616cd96de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 23, 20=
24 at 9:35=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Apr 23, 202=
4 at 09:13:08AM +0000, Masato Imai wrote:<br>
&gt; When the KVM acceleration parameter is not set, executing calc_dirty_r=
ate<br>
&gt; with the -r or -b option results in a segmentation fault due to access=
ing<br>
&gt; a null kvm_state pointer in the kvm_dirty_ring_enabled function.<br>
&gt; This commit adds a check for kvm_enabled to prevent segmentation fault=
s.<br>
&gt; <br>
&gt; Signed-off-by: Masato Imai &lt;<a href=3D"mailto:mii@sfc.wide.ad.jp" t=
arget=3D"_blank">mii@sfc.wide.ad.jp</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/dirtyrate.c | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
&gt; index 1d2e85746f..2a7df52519 100644<br>
&gt; --- a/migration/dirtyrate.c<br>
&gt; +++ b/migration/dirtyrate.c<br>
&gt; @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* dirty ring mode only works when kvm dirty =
ring is enabled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* on the contrary, dirty bitmap mode is not.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (!kvm_enabled() &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRT=
Y_RING ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D=3D DIRTY_RATE_MEASURE_MODE=
_DIRTY_BITMAP)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;mode %s requires k=
vm to be enabled.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0DirtyRateMeasureMode_str(mode));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Logically dirty bitmap should work with tcg.=C2=A0 So the other option is t=
o let<br>
kvm_dirty_ring_enabled() check kvm_state too and return false if<br>
kvm_state=3D=3DNULL?<br></blockquote><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Agree=
, better solution</div></div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RI=
NG) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !kvm_dirty_ring_enabled()) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((mode =3D=3D DIRTY_RATE_MEASURE_MOD=
E_DIRTY_BITMAP) &amp;&amp;<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yo=
ng</div><br clear=3D"all"><div><br></div><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div></div=
></div>

--000000000000346eba0616cd96de--

