Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6893D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KWY-0001J5-1w; Thu, 17 Oct 2024 03:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KWV-0001Ik-DJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:02:15 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KWS-00031s-Nz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:02:14 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-287b8444ff3so237611fac.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729148531; x=1729753331;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8PgYFe1c0KnR4XqTrPH+isVedqVQdIaxZCPFvlhu5KM=;
 b=N0jz7JcGHC+GT7LST5iBYdEkWiVfQh6Oz5/+RRDZXO42r7KT/nTk7I+c//Bt/0aB46
 mAhD/8SGISyKtxgxSAmE5EcoU4ZN0gpml01rfRCn5Lnj6Ciapmnsy2SSgxmkts/qliyu
 kq6XmVvIE69dwjt69Nr94JE2McaEKoPHudhdzQrYRX1xmKVNrIRrXoLVeWDY1HnFaq+I
 jVtcNSu6zGe+zFTQ+mqnmanKAGFFWwqmkQd55t1WtkYBF9XvPh0YSqtmMllv89YLckaF
 l+UwefL0mPgaSbIpc4EGGKk6N4+YWy8YTRgPJEHED3DvZuQOwG7NNtDna92/4hhprOf/
 ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148531; x=1729753331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8PgYFe1c0KnR4XqTrPH+isVedqVQdIaxZCPFvlhu5KM=;
 b=JMTAo3qwWLWxKY2x7WBMDrUgQ9CNuX5+u1e3tVz20Fuixtby+IJ/wUvATgRWQH8z7H
 Zy426M0/dgrqDpjfCaYTLax48jnNETP5qVmVwyEY2VkL7hDWEKg/51bFYzISSrk3NxoK
 Lz8WKST86VZKedRdS4Ak7FGJC7if7rpTUK2cRxm9TOXs/q770WetMqSt73mAVNa96ztn
 JND4Lfc5VsKISrYeRj2n9ITCEGKCuP9We2aEao7+CJvycTqFWE/wuDwLqIvWw2AxfCMO
 a5QTpK0dlIgoDqMMXFJKyrQcnbLkjANMzQqOZbar35aQvrz6JENfD0e0WYfnOSZLy69b
 DwQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp1m89Y+NNhfX/eObg9GsUFsCKZcLJ/pps3TA4C/TnQ0e1TwxMPK63auWJbUcLM/O71q6s1+c1iIVC@nongnu.org
X-Gm-Message-State: AOJu0YyokYpHAofqYBGRZcDXznfIDX63qwC6+4marP0rpRfd/u0UxiQP
 qIGfGnSWvX4LmU3J6FytmBPgf+lRVyJBC3ZYkipetiF1DdmIr49R8oVbyfpIANCiVP5qnYmJ68U
 HkmctWat43I9beQpEMc/nh98A2AKN9dVonxtQog==
X-Google-Smtp-Source: AGHT+IGek6BHHh+W+Tq6yFjy3EdDC6IACuBx704QOOIrr9b7ne/czxbvKYX/EZhrdyTtUgWcwDmGETv6F8xXVDS4UXg=
X-Received: by 2002:a05:6870:9a9a:b0:277:df58:1647 with SMTP id
 586e51a60fabf-2886e01a9f1mr15421070fac.35.1729148530602; Thu, 17 Oct 2024
 00:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241016160712.962407-1-thuth@redhat.com>
 <Zw_oM-RStF4QhWik@redhat.com>
 <32d9779e-d531-4451-af2c-c76e86f5b921@redhat.com>
In-Reply-To: <32d9779e-d531-4451-af2c-c76e86f5b921@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 15:01:54 +0800
Message-ID: <CAK9dgmbvs9DkUhF=zYfTHpatr=1CjDVR1TQ3kz8b+5tAFtBJww@mail.gmail.com>
Subject: Re: [PATCH] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ee4b9e0624a6c379"
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

--000000000000ee4b9e0624a6c379
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:40=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 16/10/2024 18.22, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:
> >> The linker on OpenBSD complains:
> >>
> >>   ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...)=
:
> >>   warning: strcpy() is almost always misused, please use strlcpy()
> >
> > Is that the only place it complains ?  We use 'strcpy' in almost
> > 100 places across the codebase....
>
> There are only a fistful of other warnings. I guess most of the spots are
> turned into inlined code by the compiler, so the linker never sees those
> other occurrences.
>
> >> It's currently not a real problem in this case since both arrays
> >> have the same size (256 bytes). But just in case somebody changes
> >> the size of the source array in the future, let's better play safe
> >> and use g_strlcpy() here instead.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   migration/dirtyrate.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index 233acb0855..090c76e934 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *bloc=
k,
> >>       info->ramblock_pages =3D qemu_ram_get_used_length(block) >>
> >>                              qemu_target_page_bits();
> >>       info->ramblock_addr =3D qemu_ram_get_host_addr(block);
> >> -    strcpy(info->idstr, qemu_ram_get_idstr(block));
> >> +    g_strlcpy(info->idstr, qemu_ram_get_idstr(block),
> sizeof(info->idstr));
> >>   }
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> >
> > Is it worth also adding
> >
> >    G_STATIC_ASSERT(sizeof((struct RamblockDirtyInfo){}.idstr) =3D=3D
> >                    sizeof((struct RAMBlock){}.idstr));
> >
> > at the top of this file, since both of these fields are expected to
> > be the same size by this code, to avoid truncation.
>
> ... or alternatively check the return value of g_strlcpy() ? ... but that
> wouldn't work if pstrcpy() if we switch to that function instead.
>
> I don't mind either way - Peter, Fabiano, Hyman, what's your opinion here=
?
>
>   Thomas
>
>
Since RamblockDirtyInfo is only used in dirtyrate.c,  I'm inclined to just
check the return value of g_strlcpy to avoid DoS attack, and fix this
warning case by case.

Thanks,

Yong

--=20
Best regards

--000000000000ee4b9e0624a6c379
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 20=
24 at 1:40=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">t=
huth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On 16/10/2024 18.2=
2, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:<br>
&gt;&gt; The linker on OpenBSD complains:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0ld: warning: dirtyrate.c:447 (../src/migration/dirtyra=
te.c:447)(...):<br>
&gt;&gt;=C2=A0 =C2=A0warning: strcpy() is almost always misused, please use=
 strlcpy()<br>
&gt; <br>
&gt; Is that the only place it complains ?=C2=A0 We use &#39;strcpy&#39; in=
 almost<br>
&gt; 100 places across the codebase....<br>
<br>
There are only a fistful of other warnings. I guess most of the spots are <=
br>
turned into inlined code by the compiler, so the linker never sees those <b=
r>
other occurrences.<br>
<br>
&gt;&gt; It&#39;s currently not a real problem in this case since both arra=
ys<br>
&gt;&gt; have the same size (256 bytes). But just in case somebody changes<=
br>
&gt;&gt; the size of the source array in the future, let&#39;s better play =
safe<br>
&gt;&gt; and use g_strlcpy() here instead.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com"=
 target=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0migration/dirtyrate.c | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
&gt;&gt; index 233acb0855..090c76e934 100644<br>
&gt;&gt; --- a/migration/dirtyrate.c<br>
&gt;&gt; +++ b/migration/dirtyrate.c<br>
&gt;&gt; @@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *=
block,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;ramblock_pages =3D qemu_ram_get=
_used_length(block) &gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_target_page_bits();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;ramblock_addr =3D qemu_ram_get_=
host_addr(block);<br>
&gt;&gt; -=C2=A0 =C2=A0 strcpy(info-&gt;idstr, qemu_ram_get_idstr(block));<=
br>
&gt;&gt; +=C2=A0 =C2=A0 g_strlcpy(info-&gt;idstr, qemu_ram_get_idstr(block)=
, sizeof(info-&gt;idstr));<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; Is it worth also adding<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 G_STATIC_ASSERT(sizeof((struct RamblockDirtyInfo){}.idstr=
) =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
izeof((struct RAMBlock){}.idstr));<br>
&gt; <br>
&gt; at the top of this file, since both of these fields are expected to<br=
>
&gt; be the same size by this code, to avoid truncation.<br>
<br>
... or alternatively check the return value of g_strlcpy() ? ... but that <=
br>
wouldn&#39;t work if pstrcpy() if we switch to that function instead.<br>
<br>
I don&#39;t mind either way - Peter, Fabiano, Hyman, what&#39;s your opinio=
n here?<br>
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default"><fon=
t face=3D"comic sans ms, sans-serif">Since=C2=A0RamblockDirtyInfo is only u=
sed in dirtyrate.c,=C2=A0</font><span style=3D"font-family:Arial,Helvetica,=
sans-serif">=C2=A0I</span><font face=3D"comic sans ms, sans-serif">&#39;m i=
nclined to just</font></div><div class=3D"gmail_default"><font face=3D"comi=
c sans ms, sans-serif">check the return value of g_strlcpy to=C2=A0avoid=C2=
=A0DoS attack, and fix=C2=A0this</font></div><div class=3D"gmail_default"><=
font face=3D"comic sans ms, sans-serif">warning=C2=A0</font><span style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">case by case.</span></div=
></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmail_default"><sp=
an style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</span=
></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmail_default"><sp=
an style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</span></=
div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comi=
c sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000ee4b9e0624a6c379--

