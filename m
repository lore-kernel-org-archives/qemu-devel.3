Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEB9D778B1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 01:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkBB2-0001IH-Fj; Sun, 25 Jan 2026 20:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vkBAz-0001HB-5h
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 20:13:57 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vkBAx-0006KU-7k
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 20:13:56 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so40369695ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 17:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769390033; cv=none;
 d=google.com; s=arc-20240605;
 b=b35TBCRrWEAfSZqhwnqEQiitsGoa3kmtlWTmymntv3wjnhB1uxr6/SCQfumwqMk0eT
 45jZhFkgR18rIpFv4B/+4VCaSeGbiRqkGGkUs5kqD96Sp3Y7M/ZZhgH0Zx99ZM8U4Zap
 Q9SCQ9DmWZsXy+knHVDlJ6kIuNnUWwk+9hAFWSz/YfffWjVVHgnqVBGqrhsK296JMG4z
 n2t2302IaaFbwl+zGBXo0nkJpKVWZOQF1LYL6LKSmmYQNVBz3nsF3fyz51c9cWv7EvtA
 M/vv10Na0MVp9S+B3/MKf5VBt4yikGRbZjSZRyMT6xtqok44zFjS+QS6vPhB8X+qvcJv
 9F3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MgQuywN16k2epSytgAct7soPcgH0sknIhuQVNkg/GGo=;
 fh=l9kAc8cog8K+jGjIkMPx8NI1Qc6aGUnHN6TysZtF34Q=;
 b=LtaAVcI8uMy1RMzHv7dVuA15vDFkmwPGKPskdB1yWji0jvjFptL+GuWcTHsDCclzK0
 DnXpQvHBDm8JC0h3o2dVd1BGv7S4YeL1msbOMBMwMquPedXEHxoL0EPeuhkPRWnFiPFZ
 EBJgznb3wp/TIqGTX9yIi80rZH8qgQp78CAhXB4gZJkLrxXt8d7iLFWYg9gq0uVqjg9w
 6U5l3ln2TBNYL6xXDmv/vax7ytmhOG+xwtNYxBIJE5y9+8o9mEkDit6p3tl0wIYHiL1u
 Y18mwj4D8kNFFPg+yLyD6d2bUSPip7z2YE2tH9BglGFQPayFn2c3a9tqnHgSM4QeWmaY
 QHbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1769390033; x=1769994833;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MgQuywN16k2epSytgAct7soPcgH0sknIhuQVNkg/GGo=;
 b=VxSl1+k0StCSRzDWznKJfxTT9EivoVx9bYsyrLjKef4rHmSAN0lVvk2cQkMT38Aa6W
 e+QITisNFgXC7JwEzJ4Oh/YvLQA0Q3RG6ReKz/v223E4SE8CfxuA5pNhYhF1xSslne09
 rQwuII6QRd5cHbqWi0WFn7nPOGHlEe9LLAveMrs6EqnB3AoGNetoa+JQpU2NU0mmo0La
 I8bq65yl0t9v3rjtDGvlTgIT0gXHC7TOKj5tKW19g6i6uetJUxTpn0fJQFVihsWT07XD
 eSwnH5lQtVWFtpt2NOQ3xC/zTqJXeKsPU0DVAHazTsH0y0+O4hF17KxDyEl3aNlf4cUD
 Ldfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769390033; x=1769994833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgQuywN16k2epSytgAct7soPcgH0sknIhuQVNkg/GGo=;
 b=tYEh71g2W80bhSIvSg6apPoFPPlwQoXQgIAZAJYhaIMPpaE8NIFxKhl5wk15vPhnSH
 Nb27oKinLuOzX5Hjrc9zNkG9V7e2qDUsB/95aSZJF25PWBn88qVyuffYEncccIia3SDk
 nMA1f6yP3I7vkQYsje2wVn0zT2tnkxwJWlXSxqOusM1g3PgM9DBMutijNg7DHWt1ocUY
 2Gmlxgt/68WVHDCBEebEWRpJu2+EoAWxpnKLpCYbaRO4YsV5apbiNUFAGK2HFhKbfNyJ
 SbBaZ/zZiVAkDFi+5JfH1y91Vjn3KNlVi8qwUGbmrCEUhTQRgCxgCEoPhXYW0USVwYKB
 yTwQ==
X-Gm-Message-State: AOJu0YxD9NIw7wqQ54n98iau7t/J4FJYFgYtPZ3EY7M6z+NOEKXc1An2
 yrvQoffpDZOHgmOcy3thE1I8BpQSqIWPZGAQAJQEtdqKKI4QXbY9JIspuhdWiKZtKtnLEWvhZL7
 zBUnmk2HWIMDId3pJVTkwh7xDKQXyGpX6lhlRRIbFhg==
X-Gm-Gg: AZuq6aL6t3VTCAl1sZP+hfS5HdPBLhD9PZIYiVHxaFvWWimQ8ic1VHgT3DPYQ7y+bsV
 NRFlbSkEQMHDTpEpRr+A2vh6UrzHxVBHPPfbc4iqs0pwl+04RBIqfbDeCVqJFZDYT23wI0n5F6j
 G9Q8MBXmZ0d17JGuwuI1hgr2L3HElUScrEbCTVzhWQ85L79VRZ3rlywl7fxuflMQxtRyVnrS9rS
 wqe/avCYmRqQfHO8HBchgmoGHXJ9NHov2h7gvD7NvtZfWeLD7xLqITueZH+1/DtRG9dt0tbMEjv
 LXBxjZyWJeLGhatIA9OhDG03Jw==
X-Received: by 2002:a17:903:2ac3:b0:29e:e925:1abb with SMTP id
 d9443c01a7336-2a84524ba96mr29660055ad.27.1769390033348; Sun, 25 Jan 2026
 17:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20260125223651.798234-1-cingel.marian@gmail.com>
In-Reply-To: <20260125223651.798234-1-cingel.marian@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 25 Jan 2026 18:13:42 -0700
X-Gm-Features: AZwV_QiUsyeqnAuPV5dCtG6MGlnZodDF08C_5oIoiTbz6AkYCQc3_GJM7rVRRko
Message-ID: <CANCZdfo2wvcVXA05encSyf4PrahpHKsyh-Vg+fT7NYpUz6c42A@mail.gmail.com>
Subject: Re: [PATCH] meson: FreeBSD: make inotify dependency optional
To: Marian Cingel <cingel.marian@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000683a97064940388b"
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x634.google.com
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

--000000000000683a97064940388b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026, 3:43=E2=80=AFPM Marian Cingel <cingel.marian@gmail.co=
m> wrote:

>  - 'libinitofy' is not a base package, therefore installed to /usr/local
>  - 'find_library' invokes clang, which by default *does not* search
>    '/usr/local/lib', so even when libinotify.so is present in system,
>    the detection does not work and 'configure' reports an error.
>  - tested on FreeBSD-15
>

Shouldn't we not use inotify at all on 15 now that FreeBSD has a native
inotify?

Warner

Signed-off-by: Marian Cingel <cingel.marian@gmail.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index a84f14258b..ac1c02d7da 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2661,7 +2661,7 @@ have_inotify_init1 =3D
> cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
>  inotify =3D not_found
>  if (have_inotify_init or have_inotify_init1) and host_os =3D=3D 'freebsd=
'
>    # libinotify-kqueue
> -  inotify =3D cc.find_library('inotify')
> +  inotify =3D cc.find_library('inotify', required: false)
>    if have_inotify_init
>      have_inotify_init =3D inotify.found()
>    endif
> --
> 2.43.0
>
>
>

--000000000000683a97064940388b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 25, 2026, 3:43=E2=80=
=AFPM Marian Cingel &lt;<a href=3D"mailto:cingel.marian@gmail.com">cingel.m=
arian@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=C2=
=A0- &#39;libinitofy&#39; is not a base package, therefore installed to /us=
r/local<br>
=C2=A0- &#39;find_library&#39; invokes clang, which by default *does not* s=
earch<br>
=C2=A0 =C2=A0&#39;/usr/local/lib&#39;, so even when libinotify.so is presen=
t in system,<br>
=C2=A0 =C2=A0the detection does not work and &#39;configure&#39; reports an=
 error.<br>
=C2=A0- tested on FreeBSD-15<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Shouldn&#39;t we not use inotify at all on 15 n=
ow that FreeBSD has a native inotify?</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Warner</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
Signed-off-by: Marian Cingel &lt;<a href=3D"mailto:cingel.marian@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">cingel.marian@gmail.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index a84f14258b..ac1c02d7da 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2661,7 +2661,7 @@ have_inotify_init1 =3D cc.has_header_symbol(&#39;sys/=
inotify.h&#39;, &#39;inotify_init1&#39;)<br>
=C2=A0inotify =3D not_found<br>
=C2=A0if (have_inotify_init or have_inotify_init1) and host_os =3D=3D &#39;=
freebsd&#39;<br>
=C2=A0 =C2=A0# libinotify-kqueue<br>
-=C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
+=C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;, required: false)<br>
=C2=A0 =C2=A0if have_inotify_init<br>
=C2=A0 =C2=A0 =C2=A0have_inotify_init =3D inotify.found()<br>
=C2=A0 =C2=A0endif<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000683a97064940388b--

