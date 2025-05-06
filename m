Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D6EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 19:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCOCH-0003Od-7y; Tue, 06 May 2025 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCOC6-0003Jv-Hh
 for qemu-devel@nongnu.org; Tue, 06 May 2025 15:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCOC4-0000bl-Aa
 for qemu-devel@nongnu.org; Tue, 06 May 2025 15:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746560586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtE2lHQ8mDhX7LEy0obkPuN4dO6U2V8H+ew0kTsZRAY=;
 b=YLgk4GhahvrUCw+mTEBDFK3zsLaIre93fPNJNE5y6gKba0mezq7qhbB45IM1RXIvTXxoZ4
 fzECQ+WXYh5LfnKOJCBzKGIRONjbejFUTzbG0ypj3tTjw4R7bsl+OQkUJ9y/PUx6C6JWa0
 5E0ReA348UlLNk+8A6kiN6D2en0YxWg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-IDQM8-zePfyY06Iwr1koDA-1; Tue, 06 May 2025 15:43:04 -0400
X-MC-Unique: IDQM8-zePfyY06Iwr1koDA-1
X-Mimecast-MFC-AGG-ID: IDQM8-zePfyY06Iwr1koDA_1746560584
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30aa397f275so361332a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 12:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746560583; x=1747165383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtE2lHQ8mDhX7LEy0obkPuN4dO6U2V8H+ew0kTsZRAY=;
 b=ADyA4zoddo9i5mzT514oFTum+4KvgVhaN1Zc7QVky/XCkk2fprzPhENgYZUXQaHqPg
 elWB2pOkfbaP33hDKh3j2idgIcN7xNxfZ0UZ8uyffcq1pnw5ZS8Hir1KKmbApi+5iwRb
 DA2CFZMwzQr+aN1HMcHDm0lGAaWaTyg7xwhvpruBWaJQiXY3WU+yC6vKs/7hUXjxDMQJ
 KK5dpeVFA/ZJ3BHs+naobMhgcWW4qe72XCpVX7re9JPTggOjUXRU1aqPDpcmSDVXcMQ4
 oCmVrZzA8D4pT+8sJB1tqnXiziOHUD96ohe0NO8G853RTQDph8m1cQ3qFhopMCSQh2ih
 i7Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTpykulA2CQ4RxJsYGL2gQsWbqsp4lQSalv6I40dcme+IkqNsR5XtSSJ38R1rSSbHDd53lystVpIw/@nongnu.org
X-Gm-Message-State: AOJu0YxJOuFCLKhJSYGsE2XJ/dtKVVXCNEL6TzSKDhsxiw5eUjU+T1BI
 DtAuuDfA/YuA1Q07dHAGwULWpSasgxEClMYC/+y+gj2ljZrl4zNE3/bEDBILmsvNw8xfFwhSC7W
 Wx37VroO7eWJnGIgJVUm9B5z/2tDeKRO0l4D+1xHk2BOBKN+WTbzTQzB7N4ipCxci1PfNqLUT78
 xclRFXgGIr4EsgxBPY3PXiztMR2fM=
X-Gm-Gg: ASbGncucx+YrmaF4LBeT0H6+XiVL1ByirOYzZYDVgE2z63zhAQYmyUEcLTLjFmjnW8A
 GNuy8UHtrXx9K11MPbOlByG3XkcmW7Hv5pu0rcR0VDBdCM+uSg4GG3E9hg9Yj2RH2l9Bo9d5nu2
 JvvhMIfClvc2y9wSo49ADlyyWF
X-Received: by 2002:a17:90b:4a82:b0:30a:9316:75a2 with SMTP id
 98e67ed59e1d1-30aac16e25amr984708a91.10.1746560583551; 
 Tue, 06 May 2025 12:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlRYWlOkJ/TJg7Pn3qXSHC/ZRyp74Bmy42K3AcQsE2+50l9QtPVJePWc35t8rwqF3xPHTpvzb4VO1MTXs9o1U=
X-Received: by 2002:a17:90b:4a82:b0:30a:9316:75a2 with SMTP id
 98e67ed59e1d1-30aac16e25amr984681a91.10.1746560583037; Tue, 06 May 2025
 12:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
In-Reply-To: <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 6 May 2025 15:42:49 -0400
X-Gm-Features: ATxdqUGV9t54zVkcy9Oy2T0ei9XfXeKtrqOAUXbjC5S-7OqmFatdYiQBfoUkKyA
Message-ID: <CAFn=p-bSMFVScSNewv_92-3u2FyyN5CYpUkABppazW53CUF-jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Bump sphinx to 8.2.3
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="00000000000021a89a06347cd335"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000021a89a06347cd335
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:19=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com>
wrote:

> sphinx 5.3.0 fails with Python 3.13.1:
>
> ../docs/meson.build:37: WARNING:
> /home/me/qemu/build/pyvenv/bin/sphinx-build:
> Extension error:
> Could not import extension sphinx.builders.epub3 (exception: No module
> named 'imghdr')
>
> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3
> version of python-sphinx and the readthedoc theme
>
> Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
> sphinx version.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/requirements.txt | 4 ++--
>  pythondeps.toml       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/docs/requirements.txt b/docs/requirements.txt
> index 02583f209aa6..50148c99cbd9 100644
> --- a/docs/requirements.txt
> +++ b/docs/requirements.txt
> @@ -1,5 +1,5 @@
>  # Used by readthedocs.io
>  # Should be in sync with the "installed" key of pythondeps.toml
>
> -sphinx=3D=3D5.3.0
> -sphinx_rtd_theme=3D=3D1.1.1
> +sphinx=3D=3D8.2.3
> +sphinx_rtd_theme=3D=3D3.0.2
>
diff --git a/pythondeps.toml b/pythondeps.toml
> index c03c9df81b5c..4c0da288be6c 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -24,8 +24,8 @@ pycotap =3D { accepted =3D ">=3D1.1.0", installed =3D "=
1.3.1" }
>
>  [docs]
>  # Please keep the installed versions in sync with docs/requirements.txt
> -sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "5.3.0", canary =3D
> "sphinx-build" }
> -sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.1.1" }
> +sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "8.1.3", canary =3D
> "sphinx-build" }
> +sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "3.0.2" }
>

Can we set our suggested version to 6.2.0 instead? This version removed
reliance on 'imghdr' but merely requires Python 3.8+ which is our current
stated minimum.

If Thomas upgrades our minimum Python to 3.9, then we could use something
as new as 7.2.0 which requires 3.9+.

I'd say 8.0.0 is too new (requires 3.10+) and conflicts with our stated
minimums.


>
>  [avocado]
>  # Note that qemu.git/python/ is always implicitly installed.
>
> --
> 2.49.0
>
>

--00000000000021a89a06347cd335
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 5, =
2025 at 8:19=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@d=
aynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">sphinx 5.3.0 fails with Python 3.13.1:<b=
r>
<br>
../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-buil=
d:<br>
Extension error:<br>
Could not import extension sphinx.builders.epub3 (exception: No module name=
d &#39;imghdr&#39;)<br>
<br>
../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 ve=
rsion of python-sphinx and the readthedoc theme<br>
<br>
Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new<br>
sphinx version.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0docs/requirements.txt | 4 ++--<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A02 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/docs/requirements.txt b/docs/requirements.txt<br>
index 02583f209aa6..50148c99cbd9 100644<br>
--- a/docs/requirements.txt<br>
+++ b/docs/requirements.txt<br>
@@ -1,5 +1,5 @@<br>
=C2=A0# Used by <a href=3D"http://readthedocs.io" rel=3D"noreferrer" target=
=3D"_blank">readthedocs.io</a><br>
=C2=A0# Should be in sync with the &quot;installed&quot; key of pythondeps.=
toml<br>
<br>
-sphinx=3D=3D5.3.0<br>
-sphinx_rtd_theme=3D=3D1.1.1<br>
+sphinx=3D=3D8.2.3<br>
+sphinx_rtd_theme=3D=3D3.0.2 <br></blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
diff --git a/pythondeps.toml b/pythondeps.toml<br>
index c03c9df81b5c..4c0da288be6c 100644<br>
--- a/pythondeps.toml<br>
+++ b/pythondeps.toml<br>
@@ -24,8 +24,8 @@ pycotap =3D { accepted =3D &quot;&gt;=3D1.1.0&quot;, inst=
alled =3D &quot;1.3.1&quot; }<br>
<br>
=C2=A0[docs]<br>
=C2=A0# Please keep the installed versions in sync with docs/requirements.t=
xt<br>
-sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, installed =3D &quot;5.=
3.0&quot;, canary =3D &quot;sphinx-build&quot; }<br>
-sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;, installed =3D =
&quot;1.1.1&quot; }<br>
+sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, installed =3D &quot;8.=
1.3&quot;, canary =3D &quot;sphinx-build&quot; }<br>
+sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;, installed =3D =
&quot;3.0.2&quot; }<br></blockquote><div><br></div><div>Can we set our sugg=
ested version to 6.2.0 instead? This version removed reliance on &#39;imghd=
r&#39; but merely requires Python 3.8+ which is our current stated minimum.=
</div><div><br></div><div>If Thomas upgrades our minimum Python to 3.9, the=
n we could use something as new as 7.2.0 which requires 3.9+.</div><div><br=
></div><div>I&#39;d say 8.0.0 is too new (requires 3.10+) and conflicts wit=
h our stated minimums.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
=C2=A0[avocado]<br>
=C2=A0# Note that qemu.git/python/ is always implicitly installed.<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--00000000000021a89a06347cd335--


