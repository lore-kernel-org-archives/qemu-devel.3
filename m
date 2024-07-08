Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F72C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrej-000135-KL; Mon, 08 Jul 2024 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQreh-00012L-Kw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQreg-0000v9-1F
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720457757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHHOyaRzlEllx6stfHpVMNlHxn8cQlboOUZ0ts9nlwg=;
 b=fHmiNBJIPyOfFMrUzUZFz9NzUZ8Wo49aqMjEnTejpVHXlmGff+F/gi8fgwlvz9RHLBX1pN
 zJX3nl7ICxEUH0hiWKf2cUND/Ca2g5iKdw9ppeB6X3AzIXr2giD+Hxu8XzCTdaGYNgf/BE
 7EUJVWgeW0gDlG7HegSpNKJXM2xAXmA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-EfrLFRFYNPq1jU4lWyk5uQ-1; Mon, 08 Jul 2024 12:55:54 -0400
X-MC-Unique: EfrLFRFYNPq1jU4lWyk5uQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-426653ac6e4so10490865e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720457753; x=1721062553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHHOyaRzlEllx6stfHpVMNlHxn8cQlboOUZ0ts9nlwg=;
 b=p5tYPNkm8KAsZCQ3ya5f+UNCjxC/QI9ILGUzB5YPxtdMXZWH7ym96ukBEBoXrtbHhV
 Kp37J3F1/SMrSui8Y1cONVwNTNlzjs28LhV0vsY+5Ankn1Nxct9wngkrDyxQ0f4K7R8E
 5Eujkiy2zEC59XhfdqXXyUwwAb+BNbSl9sj3iuDMA1ETU4qaKVA4saklJVJRFuCnQYqm
 QZp0tk8Wc36ii5p9j9lrdIw/2UMNutWLMET/Qoh/PKMbcObjEZTUu80cKZn4RKtjjwNh
 /Gm7RaF6qUctSgJXFYsx4rlE0+2OIv8UI6orCq5PG6ZQcjaq8kCe5t5lc1ADj+FQ4C/T
 cTYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIsQ78c3Wck4sGJQCLzl61NJlSn9lGtyw90IshBAGRfCUEKh4oUBYPKl+BicucScmKcBcBiqVCjmSMl84MMdWSxTJ0aLc=
X-Gm-Message-State: AOJu0Yzo9nB69px1666+JjSWMaHzdRFXgex1x4Bz6jBIyfJmtkbrn95h
 fi8etYDM4vxv6LbFtVHJisuhZN2pvzry37UKdoUpgEnRcl4Wt2ZjRuYxZq+pthhCt/2MfGeeLCx
 KWQlv3m+KT1tSGjysMhFnS67FwSSHSYXLZKMhxAHCEookW1OTJph1MXUJBTD/ARwjo4XiOnBkNc
 z1FnitJYKUOZSFgyObI3rrxr6Ac2o=
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id
 5b1f17b1804b1-426706c64b5mr1306845e9.3.1720457753136; 
 Mon, 08 Jul 2024 09:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJEeDTUECd0LJAKKDwn8EDtdvv/0gNzlt2K9djb65+pCMpvW2RE6wTbEekeAcz43FRAXLGukVmR9aIeyj+lyo=
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id
 5b1f17b1804b1-426706c64b5mr1306715e9.3.1720457752711; Mon, 08 Jul 2024
 09:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
In-Reply-To: <ZowUyFX7zcK1FvuG@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 18:55:40 +0200
Message-ID: <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000033ab94061cbf4931"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000033ab94061cbf4931
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 8 lug 2024, 18:33 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> This series is still missing changes to enable build on all targets
> during CI, including cross-compiles, to prove that we're doing the
> correct thing on all our targetted platforms. That's a must have
> before considering it suitable for merge.
>

But we're not=E2=80=94in particular it's still using several features not i=
n all
supported distros.

I also believe we should default to enabling rust toolchain by
> default in configure, and require and explicit --without-rust
> to disable it, *despite* it not technically being a mandatory
> feature....yet.
>

I guess the detection could be done, but actually enabling the build part
needs to wait until the minimum supported version is low enough.

Paolo


> This is to give users a clear message that Rust is likely to
> become a fundamental part of QEMU, so they need to give feedback
> if they hit any problems / have use cases we've not anticipated
> that are problematic wrt Rust.
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

--00000000000033ab94061cbf4931
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 lug 2024, 18:33 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This series i=
s still missing changes to enable build on all targets<br>
during CI, including cross-compiles, to prove that we&#39;re doing the<br>
correct thing on all our targetted platforms. That&#39;s a must have<br>
before considering it suitable for merge.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">But we&#39;re not=E2=80=94in parti=
cular it&#39;s still using several features not in all supported distros.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">I also believe we shoul=
d default to enabling rust toolchain by<br>
default in configure, and require and explicit --without-rust<br>
to disable it, *despite* it not technically being a mandatory<br>
feature....yet.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I guess the detection could be done, but actually enabling t=
he build part needs to wait until the minimum supported version is low enou=
gh.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
This is to give users a clear message that Rust is likely to<br>
become a fundamental part of QEMU, so they need to give feedback<br>
if they hit any problems / have use cases we&#39;ve not anticipated<br>
that are problematic wrt Rust.<br>
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

--00000000000033ab94061cbf4931--


