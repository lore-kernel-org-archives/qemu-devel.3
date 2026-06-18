Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C41CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJHC-0008Gn-Fd; Thu, 18 Jun 2026 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJHA-0008GA-4Y
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:23:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJH7-0001Cj-MU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:23:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8422f148dfcso888017b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781814224; cv=none;
 d=google.com; s=arc-20240605;
 b=KclRZTqfr9YM277CnDNJvbbXA42MkhyRQ8W5RItfJtUBW8N06cmNnSM1vLuoN+IVCq
 AS/P99t2FkeYh5DoRtm2WRZPZnKjSYd1AoY4u0UtU0nZVuUBjx8J5Qb9xzej4E8dEAsu
 XUDNOpawJ5Wd5WPtidJe+obB2ai3eCJylgvxBN6FQyFv9JqqWrY2gtAAFocNLylAaCwD
 MUEYkMO7sVikqqkLAvufELnvd4WPXAsHha+GBkTsJSLnZJ85GI7wRvRvVZAVs53KTAhd
 zwQ1ZcL4ayxL0OVDjWYFgK8bja006QnZFvjXPn0LLQgGAFaR0cO6Op4Kc3ySsuqDIu7K
 dNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9LKXKJpnlEP4OoplkjLvQjaW4AUPylhCJfZcqJzFYJY=;
 fh=1Fo9iMu8Tg5cE/DAMwfCY4PkzGYqE14v0af6By613Wo=;
 b=CH5uYo9h8abrCBtvpjbfSpX5Qm1QdGcWoixHAw/65VdC6Ls3B2drN5gq37IcT0L4ez
 VLH8PzzXZEbv/cB8wzrNmOb5dj7AYqqKk1njbn2fmxsBk4BmXMuDXEA+pLrNhAsG4r98
 aKwgty+rj6AoZt3bPJEZYIxQUXdQV/AmGDHeabZsciI2u6g6DI73FKyTmWUf1ydrt02Y
 Gc/ocBSNzPjl7AepHOzjvRgIQ2xlBzX11omri8yuG1jplluftOG/6JV0LLJ4rIfuR23C
 SzyEADNCcmPsa+b2vj2tG5uSAz9Pemb8JvHS8S++YEhXYdKVGfd2BEWot92uBXjQr5xE
 M2+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781814224; x=1782419024;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LKXKJpnlEP4OoplkjLvQjaW4AUPylhCJfZcqJzFYJY=;
 b=TeDQ5SQNxu3v8dWhxc0gcicCcZGV40ubQve6aVQwEg6tRBqA1TaXr0JoLEscGhlHtf
 2m+0HMmH4v1LxT20CNytbuHvxKbVsnkNipdN5+r3YCN60sPMQE6lyMegHYGv4tiYh/ci
 BxViPI4XLm3VJRIhEqmc8aM8VeBcGRArlkySvM+N5/zRd8mOMtvSLcPc0IefNl/zTfrV
 fiD7I+KdGxgT0kEMvofM3RKjcjQEGVnnIy8QCd9I+JoL9Y67YxaLqGigFIHNEEjqtMZz
 fpi7Pc5hSJwAFizPIdInc7Hif+KlCXrpeO10b3FrdWPGNAV7yS6WP+mMO0tW5b1UrdlC
 GO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781814224; x=1782419024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LKXKJpnlEP4OoplkjLvQjaW4AUPylhCJfZcqJzFYJY=;
 b=rTfN2rGW2XD5oAnTDcoFPzqwrwHnKjDTUSnytA6sCssxCKaz5pi+NBfMNTqmJ5q48O
 tGd4K3Nmv3GgCLVTHi7qm7RyzLcRSgikFQ9PvuYuIf5vCq7o5y/hPCeOSs3HxOEYTvPy
 3WVEzP4iHgWJPJZeYPoLJ9cwmc2i10+Ak2YsBjEad/FeeRyxQ+iD64WJ14lbX6DNP2h+
 03NmYAfl6idJ4deYrzkCqlp83rwYo3PPDOg94i4WrTPJSE9t6n2YA31WOPOGkkVhreBG
 e6zz8sr9NhYhIyMb/J3Q7aSjVp8i8ZMUGq6zhr44SWrwlIcpd8glmpIxO96py+I+PxWU
 RqAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lim5PNrssiD+KKrPScIh5zVTieO5teADrTLg06mSGFT3lzJPMSvpa65N8CkWWLrLqnnPDD5t84Pio@nongnu.org
X-Gm-Message-State: AOJu0Yx6lY0fXb5nKiXUW+Ao6nnHq05YBwfXecuxQGKR3K+10+8sMyUJ
 0uikdwxmOfG9/HPZLiB8LDaVZRC4JJ+0ZS9akKkuxaIYPyC8+ojcathZuAO01QBISv+Y85r/u9m
 VRGWwDkpRKwkh3lxN+0WUZOWiVm2FthK8KhbfJc44vg==
X-Gm-Gg: AfdE7clVS2h2mEU+l6kbbLe796GdNT0H7zWE5U2qLp3B6owg6ES7YVquAnnlWZK3H/7
 3C2NWvjWbExrGO92Yh11z6t9HvSTx1kuQPwUvmp6Jug1A56kpZZZihO10UwIU33/51OKzM79H3n
 vVPIGL9s4t53k64s4R2YjCkhizB5i1jb7a9AukMzbl3Zt5neRdiVKZPhGyyFfRVIT2U1ZvT6l2H
 SCoO9DwQGPWIKSk8R6wUwuW7Qe5yUBnNCUKl//pivHlEuWTFQEeeww/T0vra1w3Zuc/LrYkqYQ=
X-Received: by 2002:a05:6a00:10c6:b0:842:8500:95f1 with SMTP id
 d2e1a72fcca58-845508ccfd0mr473840b3a.40.1781814224242; Thu, 18 Jun 2026
 13:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-11-richard.henderson@linaro.org>
 <768aa959-290f-46c8-aa6f-e724592831c9@oss.qualcomm.com>
In-Reply-To: <768aa959-290f-46c8-aa6f-e724592831c9@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 18 Jun 2026 16:23:32 -0400
X-Gm-Features: AVVi8Cc07U0Y-osZafFF7Ls8kYA1la2Qha69F6aKM1-zXL2yzz_8FP5euVjD5T8
Message-ID: <CANCZdfrT3-C7s4jTDYBircgjiEexRdw4_txGedB9b55G27j90g@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] common-user: Implement read_self_maps for FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="000000000000e45d4206548cf329"
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x429.google.com
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

--000000000000e45d4206548cf329
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> On 18/6/26 21:55, Richard Henderson wrote:
> > Reviewed-by: Helge Deller <deller@gmx.de>
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++=
-
> >   common-user/meson.build |  5 +++++
> >   2 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/common-user/selfmap.c b/common-user/selfmap.c
> > index a1b88dee66..151d066801 100644
> > --- a/common-user/selfmap.c
> > +++ b/common-user/selfmap.c
> > @@ -9,6 +9,10 @@
> >   #include "qemu/osdep.h"
> >   #include "qemu/cutils.h"
> >   #include "user/selfmap.h"
> > +#ifdef __FreeBSD__
> > +#include <libutil.h>
>
> Out of curiosity, what is libutil for?
>

kinfo_getvmmap

My rewrite grabbed the data from the sysctl directly and didn't need this
wrapper.

Warner


> > +#include <sys/user.h>
> > +#endif
> >
> >   IntervalTreeRoot *read_self_maps(void)
> >   {
> > @@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)
> >       g_strfreev(lines);
> >       g_free(maps);
> >
> > +    return root;
> > +#elif defined(__FreeBSD__)
> > +    int n =3D 0;
> > +    struct kinfo_vmentry *entries =3D kinfo_getvmmap(getpid(), &n);
> > +    IntervalTreeRoot *root;
> > +
> > +    if (!entries) {
> > +        return NULL;
> > +    }
> > +    root =3D g_new0(IntervalTreeRoot, 1);
> > +
> > +    for (int i =3D 0; i < n; ++i) {
> > +        struct kinfo_vmentry *k =3D &entries[i];
> > +        size_t path_len =3D strnlen(k->kve_path, sizeof(k->kve_path)) =
+ 1;
> > +        MapInfo *e =3D g_malloc0(sizeof(*e) + path_len);
> > +
> > +        e->itree.start =3D k->kve_start;
> > +        e->itree.last =3D k->kve_end - 1;
> > +
> > +        /* ??? The rest of these fields are only used in linux-user. *=
/
> > +        e->dev =3D k->kve_vn_fsid_freebsd11;
> > +        e->inode =3D k->kve_vn_fileid;
> > +        e->offset =3D k->kve_offset;
> > +        e->is_read =3D k->kve_protection & KVME_PROT_READ;
> > +        e->is_write =3D k->kve_protection & KVME_PROT_WRITE;
> > +        e->is_exec =3D k->kve_protection & KVME_PROT_EXEC;
> > +        e->is_priv =3D k->kve_flags & KVME_FLAG_COW;
> > +        if (path_len) {
> > +            e->path =3D memcpy(e + 1, k->kve_path, path_len);
> > +        }
> > +
> > +        interval_tree_insert(&e->itree, root);
> > +    }
> > +
> > +    free(entries);
> >       return root;
> >   #else
> > -    return NULL;
> > +# error
> >   #endif
> >   }
> >
> > diff --git a/common-user/meson.build b/common-user/meson.build
> > index 831a7273fb..5e041de55e 100644
> > --- a/common-user/meson.build
> > +++ b/common-user/meson.build
> > @@ -10,3 +10,8 @@ user_ss.add(files(
> >     'safe-syscall-error.c',
> >     'selfmap.c',
> >   ))
> > +
> > +if host_os =3D=3D 'freebsd'
> > +  libutil =3D cc.find_library('util', required: true)
> > +  user_ss.add(libutil)
> > +endif
>
>

--000000000000e45d4206548cf329
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18,=
 2026 at 4:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 18/6/26 21:55, Richard H=
enderson wrote:<br>
&gt; Reviewed-by: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" target=
=3D"_blank">deller@gmx.de</a>&gt;<br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0common-user/selfmap.c=C2=A0 =C2=A0| 41 +++++++++++++++++++=
+++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0common-user/meson.build |=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A02 files changed, 45 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/common-user/selfmap.c b/common-user/selfmap.c<br>
&gt; index a1b88dee66..151d066801 100644<br>
&gt; --- a/common-user/selfmap.c<br>
&gt; +++ b/common-user/selfmap.c<br>
&gt; @@ -9,6 +9,10 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;user/selfmap.h&quot;<br>
&gt; +#ifdef __FreeBSD__<br>
&gt; +#include &lt;libutil.h&gt;<br>
<br>
Out of curiosity, what is libutil for?<br></blockquote><div><br></div><div>=
kinfo_getvmmap</div><div><br></div><div>My rewrite grabbed the data from th=
e sysctl directly and didn&#39;t need this wrapper.</div><div><br></div><di=
v>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; +#include &lt;sys/user.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0IntervalTreeRoot *read_self_maps(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_strfreev(lines);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(maps);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 return root;<br>
&gt; +#elif defined(__FreeBSD__)<br>
&gt; +=C2=A0 =C2=A0 int n =3D 0;<br>
&gt; +=C2=A0 =C2=A0 struct kinfo_vmentry *entries =3D kinfo_getvmmap(getpid=
(), &amp;n);<br>
&gt; +=C2=A0 =C2=A0 IntervalTreeRoot *root;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!entries) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 root =3D g_new0(IntervalTreeRoot, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; n; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kinfo_vmentry *k =3D &amp;entries[=
i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t path_len =3D strnlen(k-&gt;kve_pat=
h, sizeof(k-&gt;kve_path)) + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MapInfo *e =3D g_malloc0(sizeof(*e) + pat=
h_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.start =3D k-&gt;kve_start;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.last =3D k-&gt;kve_end - 1;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? The rest of these fields are only =
used in linux-user. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;dev =3D k-&gt;kve_vn_fsid_freebsd11=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;inode =3D k-&gt;kve_vn_fileid;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;offset =3D k-&gt;kve_offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_read =3D k-&gt;kve_protection &a=
mp; KVME_PROT_READ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_write =3D k-&gt;kve_protection &=
amp; KVME_PROT_WRITE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_exec =3D k-&gt;kve_protection &a=
mp; KVME_PROT_EXEC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_priv =3D k-&gt;kve_flags &amp; K=
VME_FLAG_COW;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (path_len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;path =3D memcpy(e + 1=
, k-&gt;kve_path, path_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 interval_tree_insert(&amp;e-&gt;itree, ro=
ot);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 free(entries);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return root;<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt; -=C2=A0 =C2=A0 return NULL;<br>
&gt; +# error<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/common-user/meson.build b/common-user/meson.build<br>
&gt; index 831a7273fb..5e041de55e 100644<br>
&gt; --- a/common-user/meson.build<br>
&gt; +++ b/common-user/meson.build<br>
&gt; @@ -10,3 +10,8 @@ user_ss.add(files(<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;safe-syscall-error.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;selfmap.c&#39;,<br>
&gt;=C2=A0 =C2=A0))<br>
&gt; +<br>
&gt; +if host_os =3D=3D &#39;freebsd&#39;<br>
&gt; +=C2=A0 libutil =3D cc.find_library(&#39;util&#39;, required: true)<br=
>
&gt; +=C2=A0 user_ss.add(libutil)<br>
&gt; +endif<br>
<br>
</blockquote></div></div>

--000000000000e45d4206548cf329--

