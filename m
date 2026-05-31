Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB577CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXuu-0003yD-Au; Sun, 31 May 2026 00:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXur-0003wy-NP
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:36:49 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXup-0007XB-HU
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:36:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-842307473b5so540575b3a.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780202206; cv=none;
 d=google.com; s=arc-20240605;
 b=gzdqCzZIzUUIB3Lm7Qozvv05qS7M15DWkIfte2QVyNtg+yhZnRNuDRT0+vCA+ZCu5v
 bgUXBLndgzMggT5dGU47Y26l32odhtMLbosZAslDzeKbRp/OIgUHqMjMjLmgO6Hty81X
 uG5HHamw7pe/FpaC1lP7rgoBzXX+kErK2F4wlK6ZoF6Rp+p1jooZkhjlsS44NyDKc7+W
 X2kWVW3+KDo56Xj/gn0z6qyTmq3DA3H/5LPhOCKf0BHmcrV3Q8ihPq31tIj6ocqlQ1JI
 N2J4Cu8V/lSu+xf/A3taj0InbHkczcUJ69EFYUPjGpE9uSQkP1b39lwgzkjVgybKbBnp
 Vx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=95P1oFw9j6Pl8Zpo1d6Csq0MYkNZU/iQpbi/JvJI8wc=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=FDzS8GZfb8AKo6mbEjD6qbUCKGLl20l9plHN07CUzuRw8xVlzSVzFhK+3O8E1tORVP
 IHcwRk1eC8utBfR84Fyhz0Tuc4ekUxunQzEbqIxLshiL01GlvvTy7AjLgYFxgh9J99Og
 8Mqz75p8cHex/zWKA/S/5jvOZ707BppBQgZjXUoiYQp7B5pSUx7sNtNcVk0J4IAv1bAZ
 L5+/OwOudRU58ZecQcQe9xTSnJyV7Aou6/h1oaQX7qjZisdUMGs7P30/oW5M665m0giD
 DjyuBUplqX4Ns+sijYLLP/Ncs+BHk1eNgr9hZUjq4MA7vgxUVDMhBeFO9JVELb8+HiDn
 Flxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780202206; x=1780807006;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95P1oFw9j6Pl8Zpo1d6Csq0MYkNZU/iQpbi/JvJI8wc=;
 b=CwBXvW7AiAF0OLfCMkBtsNfWbi1xEcGpNoQjAFMkcFi2H/bXv+o3j26EeETarC/TZs
 gAQ4T6o8TD7nsZEsGhY93/hy/8GYUkmxlLHaq+VO5FPjvopdt2EICpSD3pfc2Z+rOw+k
 cb7GN5eVwyxM16XHCijW4+YqhjnyjbCKc0ItOwWMJaGs50w+I+WCYkbbb72qFI9EqINY
 wuTYN+UwiLjiPWAtZ7pG9asLgF24s3XPet/3A+bZWs9Kz2kWW9PYOaK7kX0x02HoDfsz
 TnlJ6uMooXEum7NVI81wcSJuYUuRuQLwbAXWzQtzjJ9xGXngxmMThEERnkdqxQKyzAVX
 785w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780202206; x=1780807006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95P1oFw9j6Pl8Zpo1d6Csq0MYkNZU/iQpbi/JvJI8wc=;
 b=N3RSM/l7tlhk1VTEJi5srb+6ZeuQK9kOTQT/yUktPWTEJqA4+KdJbRz2xo8FAtexza
 YcnZgkkjslRSBeab7WEr9aB/qFX3mBuAqhZQbM0ivF65NKfOZALJck3/hjsnLRDqESaY
 arqJ9rFJYpA0HyqdUxV/cXa7fgDoBMdy6P3nsLX194nZ8ONbCO+OJDOZqGjKPGMcIpr+
 GA49e1jwOjRULLh+GSo8Dzmal4LsLW+plrSE4QqkiwWa3iiHADXY8q1G7Qb1SWzePkbx
 GCuZvPhyTBmOB7DMTJawZId1v/V7BvH72Ib6ZAqSu2yqvfsdTld6zgjRaduLsg4IEryZ
 NXbw==
X-Gm-Message-State: AOJu0YzXI4fyDwKkTR5fuFzv3BXS/N1P0itq/qT/On28IH3rfP8ulPBR
 bo4eJlVopNrmQT11/Zx6GmRrVmo1IBDgE2fFuI8irs3BwwsH7F7W6FvMedZ13auNFFgX8jYLTj5
 C8wXAm3eTqj8x7RlrUQvuMgikgrRvok53eryYd5YZVQ==
X-Gm-Gg: Acq92OEkIGIHfXCfRerBDebWfCKed5PG+y1RApkd9UkHCr8HEyCdNnlh1Zo5xM6BZAg
 MzZmZm1/weKEB8BoZleRRFID998BHOoTW212CBEywx/OtME313FWb0bFVHVHjje/rhJUbfQkYyF
 PkbeG9tTHk+odP2BwQBg4lFMO3ef2nXRMKzU/KV6Z5S/xHbFtQgFKZWXy4tUSnh5n0ZTFcgAPAy
 a4eXZmfYtguG28LMX7BPcpIB7wskL/ZRwNJvevhMVrajHJcLQd7LxgZdoyVfQQO4m6PB2DrKF/n
 I2twwnEU3uJJHS/AnyKRElpNMs+mQnj1FcHlpvmv89Wo1D8=
X-Received: by 2002:a05:6a00:1896:b0:82f:1b42:11d0 with SMTP id
 d2e1a72fcca58-84225782a9bmr5832467b3a.15.1780202205651; Sat, 30 May 2026
 21:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-11-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-11-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:36:34 -0600
X-Gm-Features: AVHnY4JEeNEXg18zfWQaU7Mz3M3zD2LdO0RxCcwzthb2clRMNPHOe490gFBtfKI
Message-ID: <CANCZdfqE=MWrQZeYtSLPs=B3FUW4xRL_ebLyXj4txQ92PzZDUw@mail.gmail.com>
Subject: Re: [PATCH 10/13] common-user: Implement read_self_maps for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="00000000000018b123065315a0fa"
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42e.google.com
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

--00000000000018b123065315a0fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:13=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Use kinfo_getvmmap from -luser.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
>  common-user/meson.build |  5 +++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/common-user/selfmap.c b/common-user/selfmap.c
> index a1b88dee66..151d066801 100644
> --- a/common-user/selfmap.c
> +++ b/common-user/selfmap.c
> @@ -9,6 +9,10 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "user/selfmap.h"
> +#ifdef __FreeBSD__
> +#include <libutil.h>
> +#include <sys/user.h>
> +#endif
>
>  IntervalTreeRoot *read_self_maps(void)
>  {
> @@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)
>      g_strfreev(lines);
>      g_free(maps);
>
> +    return root;
> +#elif defined(__FreeBSD__)
> +    int n =3D 0;
> +    struct kinfo_vmentry *entries =3D kinfo_getvmmap(getpid(), &n);
>

So I had the following to use the sysctl interface. The extra bit is
paranoia
for the general case where we're multi-threaded. I'm not entirely sure it's
needed, but it won't hurt since we free this memory at the end anyway.
It's up to you to see if you think the -lutil addition is better or this
slightly
longer code is better.

    int mib[4] =3D {CTL_KERN, KERN_PROC, KERN_PROC_VMMAP, getpid()};
    size_t len;
    char *buf, *p;

    if (sysctl(mib, 4, NULL, &len, NULL, 0) < 0) {
        return NULL;
    }

    /* Add some slack in case mappings change between calls. */
    len =3D len * 4 / 3;
    buf =3D g_malloc(len);
    if (sysctl(mib, 4, buf, &len, NULL, 0) < 0) {
        g_free(buf);
        return NULL;
    }



> +    IntervalTreeRoot *root;
> +
> +    if (!entries) {
> +        return NULL;
> +    }
> +    root =3D g_new0(IntervalTreeRoot, 1);
> +
> +    for (int i =3D 0; i < n; ++i) {
> +        struct kinfo_vmentry *k =3D &entries[i];
> +        size_t path_len =3D strnlen(k->kve_path, sizeof(k->kve_path)) + =
1;
>

This is shorter than what I had in blitz.


> +        MapInfo *e =3D g_malloc0(sizeof(*e) + path_len);
>
>
My version did the following only if
      if (kve->kve_type !=3D KVME_TYPE_GUARD &&
            kve->kve_type !=3D KVME_TYPE_DEAD) {

though now I see my version would have been better with the
contrapositive and continue.


> +        e->itree.start =3D k->kve_start;
> +        e->itree.last =3D k->kve_end - 1;
> +
> +        /* ??? The rest of these fields are only used in linux-user. */
> +        e->dev =3D k->kve_vn_fsid_freebsd11;
> +        e->inode =3D k->kve_vn_fileid;
> +        e->offset =3D k->kve_offset;
> +        e->is_read =3D k->kve_protection & KVME_PROT_READ;
> +        e->is_write =3D k->kve_protection & KVME_PROT_WRITE;
> +        e->is_exec =3D k->kve_protection & KVME_PROT_EXEC;
> +        e->is_priv =3D k->kve_flags & KVME_FLAG_COW;
> +        if (path_len) {
> +            e->path =3D memcpy(e + 1, k->kve_path, path_len);
> +        }
> +
> +        interval_tree_insert(&e->itree, root);
> +    }
> +
> +    free(entries);
>

I had g_free() here, but I am a 'cargo cult' glib user...


>      return root;
>  #else
> -    return NULL;
> +# error
>  #endif
>  }
>
> diff --git a/common-user/meson.build b/common-user/meson.build
> index 831a7273fb..5e041de55e 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -10,3 +10,8 @@ user_ss.add(files(
>    'safe-syscall-error.c',
>    'selfmap.c',
>  ))
> +
> +if host_os =3D=3D 'freebsd'
> +  libutil =3D cc.find_library('util', required: true)
> +  user_ss.add(libutil)
> +endif
>

This dependency is likely fine, but as I said in my other mail using the
sysctl obviates the need for this.

And thank you so much for writing this, even though there's a small
collision here. I do very much
appreciate it.

Warner


> --
> 2.43.0
>
>

--00000000000018b123065315a0fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30, 2026=
 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Use kinfo_getv=
mmap from -luser.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0common-user/selfmap.c=C2=A0 =C2=A0| 41 ++++++++++++++++++++++++++++++=
++++++++++-<br>
=C2=A0common-user/meson.build |=C2=A0 5 +++++<br>
=C2=A02 files changed, 45 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/common-user/selfmap.c b/common-user/selfmap.c<br>
index a1b88dee66..151d066801 100644<br>
--- a/common-user/selfmap.c<br>
+++ b/common-user/selfmap.c<br>
@@ -9,6 +9,10 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;user/selfmap.h&quot;<br>
+#ifdef __FreeBSD__<br>
+#include &lt;libutil.h&gt;<br>
+#include &lt;sys/user.h&gt;<br>
+#endif<br>
<br>
=C2=A0IntervalTreeRoot *read_self_maps(void)<br>
=C2=A0{<br>
@@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)<br>
=C2=A0 =C2=A0 =C2=A0g_strfreev(lines);<br>
=C2=A0 =C2=A0 =C2=A0g_free(maps);<br>
<br>
+=C2=A0 =C2=A0 return root;<br>
+#elif defined(__FreeBSD__)<br>
+=C2=A0 =C2=A0 int n =3D 0;<br>
+=C2=A0 =C2=A0 struct kinfo_vmentry *entries =3D kinfo_getvmmap(getpid(), &=
amp;n);<br></blockquote><div><br></div><div>So I had the following to use t=
he sysctl interface. The extra bit is paranoia</div><div>for the general ca=
se where we&#39;re multi-threaded. I&#39;m not entirely sure it&#39;s</div>=
<div>needed, but it won&#39;t hurt since we free this memory at the end any=
way.</div><div>It&#39;s up to you to see if you think the -lutil addition i=
s better or this slightly</div><div>longer code is better.</div><div><br></=
div><div>=C2=A0 =C2=A0 int mib[4] =3D {CTL_KERN, KERN_PROC, KERN_PROC_VMMAP=
, getpid()};<br>=C2=A0 =C2=A0 size_t len;<br>=C2=A0 =C2=A0 char *buf, *p;<b=
r><br>=C2=A0 =C2=A0 if (sysctl(mib, 4, NULL, &amp;len, NULL, 0) &lt; 0) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0=
 =C2=A0 /* Add some slack in case mappings change between calls. */<br>=C2=
=A0 =C2=A0 len =3D len * 4 / 3;<br>=C2=A0 =C2=A0 buf =3D g_malloc(len);<br>=
=C2=A0 =C2=A0 if (sysctl(mib, 4, buf, &amp;len, NULL, 0) &lt; 0) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 NULL;<br>=C2=A0 =C2=A0 }<br><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 IntervalTreeRoot *root;<br>
+<br>
+=C2=A0 =C2=A0 if (!entries) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 root =3D g_new0(IntervalTreeRoot, 1);<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; n; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kinfo_vmentry *k =3D &amp;entries[i];<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t path_len =3D strnlen(k-&gt;kve_path, si=
zeof(k-&gt;kve_path)) + 1;<br></blockquote><div><br></div><div>This is shor=
ter than what I had in blitz.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MapInfo *e =3D g_malloc0(sizeof(*e) + path_len=
);<br><br></blockquote><div><br></div><div>My version did the following onl=
y if</div><div>=C2=A0 =C2=A0 =C2=A0 if (kve-&gt;kve_type !=3D KVME_TYPE_GUA=
RD &amp;&amp;</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kve-&gt;kve_ty=
pe !=3D KVME_TYPE_DEAD) {<br><div><br></div><div>though now I see my versio=
n would have been better with the</div><div>contrapositive and continue.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.start =3D k-&gt;kve_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.last =3D k-&gt;kve_end - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? The rest of these fields are only used =
in linux-user. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;dev =3D k-&gt;kve_vn_fsid_freebsd11;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;inode =3D k-&gt;kve_vn_fileid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;offset =3D k-&gt;kve_offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_read =3D k-&gt;kve_protection &amp; K=
VME_PROT_READ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_write =3D k-&gt;kve_protection &amp; =
KVME_PROT_WRITE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_exec =3D k-&gt;kve_protection &amp; K=
VME_PROT_EXEC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;is_priv =3D k-&gt;kve_flags &amp; KVME_F=
LAG_COW;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (path_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;path =3D memcpy(e + 1, k-&=
gt;kve_path, path_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 interval_tree_insert(&amp;e-&gt;itree, root);<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(entries);<br></blockquote><div><br></div><div>I had g_f=
ree() here, but I am a &#39;cargo cult&#39; glib user...</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return root;<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 return NULL;<br>
+# error<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
diff --git a/common-user/meson.build b/common-user/meson.build<br>
index 831a7273fb..5e041de55e 100644<br>
--- a/common-user/meson.build<br>
+++ b/common-user/meson.build<br>
@@ -10,3 +10,8 @@ user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;safe-syscall-error.c&#39;,<br>
=C2=A0 =C2=A0&#39;selfmap.c&#39;,<br>
=C2=A0))<br>
+<br>
+if host_os =3D=3D &#39;freebsd&#39;<br>
+=C2=A0 libutil =3D cc.find_library(&#39;util&#39;, required: true)<br>
+=C2=A0 user_ss.add(libutil)<br>
+endif<br></blockquote><div><br></div><div>This dependency is likely fine, =
but as I said in my other mail using the sysctl obviates the need for this.=
</div><div><br></div><div>And thank you so much for writing this, even thou=
gh there&#39;s a small collision here. I do very much</div><div>appreciate =
it.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>
</div>

--00000000000018b123065315a0fa--

