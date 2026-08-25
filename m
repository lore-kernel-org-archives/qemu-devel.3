Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77D9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysoR-00082w-2n; Tue, 25 Aug 2026 11:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wysoP-0007xi-Dp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wysoM-0006Mi-3p
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787670696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=02a0V/83WElGosN9Y9QuqvubTtRcEy8zNS9xa2+kyb8=;
 b=LC87HA00uMMEbrhzEfxJ4zJ8yFOPWyOkhaB5zCt/3V60ItKHliAY0hjT87iw+Ma21PylDq
 wdxpkGlGy41TcNziUTufWoevgWzJSaUkhYbpyqz0sL/bRMFEgfmYtpDh8bN6ioRI0oHO3S
 8NR5tZJuEOTbxhzcPQ/enCFahBdW9BI=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-qfQaq1DqM6awmNvU3iOKDw-1; Tue, 25 Aug 2026 11:11:32 -0400
X-MC-Unique: qfQaq1DqM6awmNvU3iOKDw-1
X-Mimecast-MFC-AGG-ID: qfQaq1DqM6awmNvU3iOKDw_1787670692
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66988049306so6298058d50.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787670692; cv=none;
 d=google.com; s=arc-20260327;
 b=MnrnF68UxUv+j120HCLl73U3/pyBVbyYzQg0TZr8dMuW5X/cp/lQ/baf7W7QsbCNU2
 J5p84+r6alu1C2wkS/4hAgVvF0KCPS1nCKzDCAUZCUyqDBEYkew71PUc/qiYXHmzuV8C
 0KhgZetNUwNO39Hk1am6COvt1Rq4+yv00qCbzBWY3xzZ4ZB5HdjEg5UaYw4HD63IWJUo
 U2ZmmIDbc0UBjTkwvpT9xpD8DY510xgVI77lNdinKCPMvzcZclfhUi8J0mN3siyVQa8q
 3sTsXF7cXVG+pePPLM0Pq192gVqZ1bHt7UWQUHkVVjiZ8fL/IoypY3fj58f/58K4/uSZ
 cIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=02a0V/83WElGosN9Y9QuqvubTtRcEy8zNS9xa2+kyb8=;
 fh=dNOU0ocCnvN5kDKQFHF16npSNEF2i+iSEogTzCN9ncU=;
 b=Szzk+zUm0TjW9uU1diq7TPSquOos6wmUtdw91TPnIz0BCn7w2kI9jbOpyeKIsudtIz
 9yJsRhY7Wa9zmlVQYBSVW/AenG5m9qCNTbkSl/26ZyPeakGa4MHVwLX6KT6//XL4M/Bj
 1gAZXSBDNgt3+81CrCnwQU9lGLXTkRvCcweJBB3ynRlSx2aknhV3qtlE+5Dpsg8X9xkQ
 Cd66YfT3deI++3r9aYaycWisAIGfJF3pG9P6Og6TtRpxTrtR4pAOBQgaTTYnLU63ntjF
 yK6uonRkqZbdKrIlODAArkWrIwXy+NTGOOvRmGljBL1pcpkF17jqO9PkDoAVnY5IE9Kd
 b5dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787670692; x=1788275492; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=02a0V/83WElGosN9Y9QuqvubTtRcEy8zNS9xa2+kyb8=;
 b=U7p6sgs063/V/RuPAUgZoDy9IpZ0OH1x3r56xd9EPFgWdw3rszaIVDJAEyXbukV/Uf
 3z43MmbsJRZMjwbKLAZyzM26OpyyNyE93O73/cv0eMYD2Rg6LHVY/9R7NnweQyieuwsL
 DfeD/uxH6wNwhM/89HZvQvsz2sp6avQ5WbuBIjxc1H+6OIQlgxtJo0SQ9SxwMh2Dag9N
 FhWXRCZWfa5AfxWmNNIBnUtValkZ8n8sV3FpzXDYGq4islH0tR4u93y0eWJ17njP0RNc
 V4MX5KlDbRkA7Wnk3PjZ6bdsgJYrbnrWo81IBROnw96dTniDU9GNjiqqJHzLGLksOSFh
 S5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787670692; x=1788275492;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=02a0V/83WElGosN9Y9QuqvubTtRcEy8zNS9xa2+kyb8=;
 b=PUwSVpgJzZc6C2wjzkF24BgdBPjI9YEcbhQ1m7d4JMW13QTZjkaW+Flnm+vMUikXWv
 JU6L0rs2g/W2P0oV2ChKjVOaNfYqEwmtT3I2b0L/OntVpMdKkxy4kSrGgxhz96XoCFBc
 Iu9M2dqTa5cm25neg7Ont8Egx682gc3W471W9k/fyI3cobxQt7yni5Bf5euk+tYGgpQG
 8vO2sRxQKOv0YTUudy/hXergLyuZi/MlDFgAsmlxUiX3T/WyRBUYpUl0hGtz98oxbQ4r
 iEi2M+RFuqwCrDwB6kE7pvZQiH0XwiuAv1SZvqmp6RanIfKptc3qjH9GzoyxdLJ+wD77
 Pr0w==
X-Gm-Message-State: AFuF++k1wkBmGTwG6Vahua8W0rQ0yE0bWdFVMkf8GRrGBESqJliauO/Y
 3GtawBxGgaWA7irodthBKcTPk+0zJ0GwlxAGtfSpSQ7ZSTcI8A6OYLOq2PGP/9Cn/fr4eHUBrbQ
 PhmEaZt9Lecz+HO4kJ73dFFyxA5rHEtkPGmnn/laRzXosMkaf4ft4dxqOYFarpISQHBfQegOA3q
 8ClP3lEKkH1WfOOyPGDUcVQE0nLKlvN1Y=
X-Gm-Gg: AR+sD11ApRubPw+qEOF1/nozQtONB/Ja922NxN4zdWcFP80OTg7JWEmjRE9p/Cn1lJQ
 t0nEHL4UbEWJrwn32VGjtVaQrgzxLV9rp+uSbzxCB2LaDEbCtdfyNj0uqyIFyGhWIg6nYjNcBPM
 cE1Hyei4JPV9YkUZ2DQhug+0UvwDRNyyZebttJuAMIxopPTlX8vzS0uJgIQB6uEVtw9YCHuTVkH
 z+9LSMNMfMvneiv
X-Received: by 2002:a53:a5d1:0:b0:66c:76e6:2d01 with SMTP id
 956f58d0204a3-66d14a21801mr1907044d50.9.1787670692055; 
 Tue, 25 Aug 2026 08:11:32 -0700 (PDT)
X-Received: by 2002:a53:a5d1:0:b0:66c:76e6:2d01 with SMTP id
 956f58d0204a3-66d14a21801mr1907032d50.9.1787670691494; Tue, 25 Aug 2026
 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-4-jsnow@redhat.com>
 <ao138LdpZIV1REPu@redhat.com>
In-Reply-To: <ao138LdpZIV1REPu@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Aug 2026 11:11:20 -0400
X-Gm-Features: AcwNN1XSQBzQYx11lrrXuBgU8AiS52a8bLrioo9xE1GyP3eBdk35FnV4G5eRftg
Message-ID: <CAFn=p-amk6iLSjTUobJzLVDp7wc6V3NTE=szydpta35HFQuBAA@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] tests: update netbsd dependencies
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Kyle Evans <kevans@freebsd.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000008b2c250659e08471"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000008b2c250659e08471
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, 7:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Tue, Aug 25, 2026 at 01:14:28AM -0400, John Snow wrote:
> > NetBSD appears to need 'bison' explicitly installed now.
> >
> > I am still seeing some intermittant failures in the tests for ide-test
> > and qos-test, but those are mysteries for another day.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/vm/netbsd | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> and a reminder that we'd benefit from adding NetBSD to
> libvirt-ci mappings too, so we can remove the manual
> package listing.
>

I'll look into it. Is it possible to mock this up using the qemu local
mappings.yml before I try to submit code to libvirt-ci?

I guess I can just check out the submodule and hack up what I need to and
go that route.

IIRC there's a category called pkgs in libvirt-ci, and we'd just need a new
one for "pkgsrc" and an os target named (checking canon capitalization...)
"NetBSD" and that'll pretty much handle it.


> >
> > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > index b365045066c..45afe675e17 100755
> > --- a/tests/vm/netbsd
> > +++ b/tests/vm/netbsd
> > @@ -39,6 +39,7 @@ class NetBSDVM(basevm.BaseVM):
> >          "gmake",
> >          "gsed",
> >          "gettext-tools",
> > +        "bison",
> >
> >          # libs: basic
> >          "dtc",
> > --
> > 2.55.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000008b2c250659e08471
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2026, 7:09=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, Aug 25, 2026 at 01:14:28AM -0400, John Snow wrote:<br>
&gt; NetBSD appears to need &#39;bison&#39; explicitly installed now.<br>
&gt; <br>
&gt; I am still seeing some intermittant failures in the tests for ide-test=
<br>
&gt; and qos-test, but those are mysteries for another day.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/vm/netbsd | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
<br>
<br>
and a reminder that we&#39;d benefit from adding NetBSD to<br>
libvirt-ci mappings too, so we can remove the manual<br>
package listing.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">I&#39;ll look into it. Is it possible to mock this up using=
 the qemu local mappings.yml before I try to submit code to libvirt-ci?</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I guess I can just check ou=
t the submodule and hack up what I need to and go that route.</div><div dir=
=3D"auto"></div><div dir=3D"auto"><br></div><div dir=3D"auto">IIRC there&#3=
9;s a category called pkgs in libvirt-ci, and we&#39;d just need a new one =
for &quot;pkgsrc&quot; and an os target named (checking canon capitalizatio=
n...) &quot;NetBSD&quot; and that&#39;ll pretty much handle it.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; diff --git a/tests/vm/netbsd b/tests/vm/netbsd<br>
&gt; index b365045066c..45afe675e17 100755<br>
&gt; --- a/tests/vm/netbsd<br>
&gt; +++ b/tests/vm/netbsd<br>
&gt; @@ -39,6 +39,7 @@ class NetBSDVM(basevm.BaseVM):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gmake&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gsed&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gettext-tools&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bison&quot;,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # libs: basic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dtc&quot;,<br>
&gt; -- <br>
&gt; 2.55.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000008b2c250659e08471--


