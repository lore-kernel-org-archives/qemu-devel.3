Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7326AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtC7-0001pe-In; Mon, 08 Jul 2024 14:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQtC6-0001od-8j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQtC1-0002Zm-1F
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720463668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g9QNW6kQgFjbHq3dCMxfvOdcBrUjP+72C8z9Q8bMVwQ=;
 b=YGqSwSWcOeeu4t6g2w6YS2t4V+f5zoP8hpQBwUy0V935YcYpDpvWmuDheVi8tjHtOstBod
 dwYmwG908yaotA8A1fYTIDUXFE2T8jUJJ3dznIDeLvlalmoHfECOtcSOUeC9G5tL9BemNT
 BeYMSdli+X/fM+kub/wxsDHuLtGu99k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-tOkTcvZeMranwiRE7-hLgA-1; Mon, 08 Jul 2024 14:34:26 -0400
X-MC-Unique: tOkTcvZeMranwiRE7-hLgA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367a064472aso2830387f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 11:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720463664; x=1721068464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9QNW6kQgFjbHq3dCMxfvOdcBrUjP+72C8z9Q8bMVwQ=;
 b=sDvrvWfaztr1VkXOC3/VhY2oG57x0zWGPVgO3DVdM/12e4GN+Ttzu/sAAZPaJQMomF
 4IYZibLnrxQYP/E3Cdd4OmP14E7LafQX3k1Z4EcNY1o8sBeI4NSlboTkXjjlYNo+ZOTr
 8oFb5cjP4u2+xBW7KID1QZ3u76BT1Jv2nh8ygrbk2Ny4TlAgM8DSND4ro+dSpHrftrIq
 F4r3q0Msei+ZMxU94FcVL0xy4Fc2Q3o3b/L73WY8uoyY8KiIolisdkzRuO3cRZno8oSJ
 BnpxY286LQGDhx/mNx7okeMo1GGttts/ljLuunLJhlcab/MA37mFGgo2cMDtHLDUBhc/
 ZGWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuoZlFI/d2iOAmSgn/ovb1RALF0sSOYrApcJYIulHxpjqIkcTivCNADlVmgac9PKznT5l6fI7jICZu/305VSOGWWvqlUE=
X-Gm-Message-State: AOJu0YyptOYqe28Y9Oyt5uy6BYKqqatXOnbG0CCseLjyYADIkH/UUQea
 O8TAYeOGznkunjsdbwkv4MRQTZnVgy1L9t9MvCHDThifye0rf3zYhWRsmW+SOnsSxujabgEAEjN
 t645vidJeZheFXt6HoFuCX2/2UjbeesAuMz+W01umJq04gZKRI5PyVAgAII+4HwNDDw8p6RsYaN
 B4a4cAoij6txo5a5eXSX4woOR1iao=
X-Received: by 2002:a5d:590a:0:b0:367:8ab0:14b7 with SMTP id
 ffacd0b85a97d-367ceadd960mr245278f8f.68.1720463664703; 
 Mon, 08 Jul 2024 11:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGonNfJ3qScshkxbN0olHmtUYVOmwW8/cyJNjQay+3KJkd1ye7wmoemLsdj4guv9X1u5RCRqIiLuLlAytTWuhU=
X-Received: by 2002:a5d:590a:0:b0:367:8ab0:14b7 with SMTP id
 ffacd0b85a97d-367ceadd960mr245270f8f.68.1720463664336; Mon, 08 Jul 2024
 11:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
In-Reply-To: <Zowd-UxAnPmJSA0G@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 20:34:12 +0200
Message-ID: <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008fe68f061cc0a903"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000008fe68f061cc0a903
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> That's exactly why I suggest its a pre-requisite for merging
> this. Unless we're able to demonstrate that we can enable
> Rust on all our CI platforms, the benefits of Rust will
> not be realized in QEMU, and we'll have never ending debates
> about whether each given feature needs to be in C or Rust.
>

In that case we should develop it on a branch, so that more than one person
can contribute (unlike if we keep iterating on this RFC).

Paolo


>
> > I also believe we should default to enabling rust toolchain by
> > > default in configure, and require and explicit --without-rust
> > > to disable it, *despite* it not technically being a mandatory
> > > feature....yet.
> > >
> >
> > I guess the detection could be done, but actually enabling the build pa=
rt
> > needs to wait until the minimum supported version is low enough.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000008fe68f061cc0a903
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">That&#39;s ex=
actly why I suggest its a pre-requisite for merging<br>
this. Unless we&#39;re able to demonstrate that we can enable<br>
Rust on all our CI platforms, the benefits of Rust will<br>
not be realized in QEMU, and we&#39;ll have never ending debates<br>
about whether each given feature needs to be in C or Rust.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In that case we s=
hould develop it on a branch, so that more than one person can contribute (=
unlike if we keep iterating on this RFC).</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
<br>
&gt; I also believe we should default to enabling rust toolchain by<br>
&gt; &gt; default in configure, and require and explicit --without-rust<br>
&gt; &gt; to disable it, *despite* it not technically being a mandatory<br>
&gt; &gt; feature....yet.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I guess the detection could be done, but actually enabling the build p=
art<br>
&gt; needs to wait until the minimum supported version is low enough.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000008fe68f061cc0a903--


