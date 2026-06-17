Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9665FCD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 22:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZys1-0007Th-OT; Wed, 17 Jun 2026 18:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wZys0-0007TC-2V
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 18:36:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wZyrx-0006Qu-R1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 18:36:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6b3f71648so3978815ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781735783; cv=none;
 d=google.com; s=arc-20240605;
 b=Zg2hBCT6Kuvq1VUeNKiJgIlZsMwJb4pOysed+W1S10HSBOjZPILkQrYTZlTosgWJ7E
 1z59jZktVikEnt2YH3OBU1M5nIugRuhaPAP/yIbTO5hiZB01AFFY9khj9HJdfx1KtROv
 rYE3fMsNbnxVSc653badMGInf6KYNbDBwIjLQVROgxf3BOmIgyCRRBV5fAuwCU/ItJxn
 ztBJQVhTuEk4uctjM7sB6m1yj0Fkp2dOVly5jSkWdGz0Z5i6wDBqPAM2DI6P4tSlQ1N2
 JlV8LspiD3z3j8NOwHE5BwSSzxITTw39tcNXtAaJi15DHzhtbhzyQmCCbLfxBFudyWNT
 Cjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6N0uUPZVhJRRhRnWM0BFrz+yEhsBe1iVoNl9BtQDSxc=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=GUWYTDdpZ9Yd8Mx9Ca/CWXwzGKyOZkZQ1Qxh6p5dppWcJwjRJISrAm6xdMXt4mkNbQ
 xOt9YUy90QwhX9s/VUc/qSR1FwG19STpwdXStuaNavaQfc+FD6Gt+bCVPoUbXLNd4cZs
 QGcJz4hAXS5CBYP8bTS0mlF9HxhSNgX45PV/2Vu/nagJauG+C4iFCGYT3+SX84Vdj5aE
 FvcBzTox/7a0N7Mi9zCgcbxO+NWirKaLJLFQwmymbKjGoDJB0pioH9zK3U0isPfpOnif
 M+jO8ykVRRSn2snVLvIcKvFsS8VJfw62DpVr4ziFfjsYofF9a0YvpEmLE+jFMdosihRq
 ERew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781735783; x=1782340583;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6N0uUPZVhJRRhRnWM0BFrz+yEhsBe1iVoNl9BtQDSxc=;
 b=AgCDbK0IeZvztDmy0/N1AOA6zJmbQRqx7h3s16jTWkqPCVvgWSrbh4Bxbydbe2SOsY
 MLBDNshGXW4g17UG3ikTbyn0HRO4WKcMHNTJKv2rykxgCkQTT5ULhyAjG6kxLVZxJ79B
 Qq5ou+7UqRRHNXC2jHirA3lUozGcq5Ed5/tW0E1idTex0mOtYhBzYX7qmtdJoz2VQXq+
 hTbH61g0sjdq3sp3ww3Uep61cgQYI0dcHiDeZkTchG8cV+M8q4+7xbgtkeeLzsjC5fYn
 Cx8k4lD2Ta9uDws88ZJ7b+cbhich23z0/pK7BW26VfJxnt3KUE5f13Ugjs1ifkDk00/a
 tc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781735783; x=1782340583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6N0uUPZVhJRRhRnWM0BFrz+yEhsBe1iVoNl9BtQDSxc=;
 b=DCKX4xUtYqeZxrI+FfH3HwtGQrRzF8pKv4ja64bhIh2ZrG3xL9NtkVviOWT4aw69ll
 QJFqbe89vEcGSN0B6yaYgk7zYpk+QBUKu36w4pisq8HZGhwKpwjYXXj69lWkUWMrZqVW
 m0e5Xpjzm6c8ApcjwQHw68ZyQ/WjL2vPOPfUIxjxF+3DxSGsl8vcKw5KWNsZWtrhRbsh
 0r4sF9Ikifza2Rzyc4uoQwgCpB21Xi611XcO9Njm3fNJ3hEoPlSVUg5aLtkV2ixGTRnN
 JZrY1RSs3iByDvrMnzoXgNGqertJ792tZ4rgvDkrF4KQijx5ZfWj0ffBlqEnovaY/l8W
 k/1g==
X-Gm-Message-State: AOJu0YxaxoSm8KWtMVfDkf/ZZWWrnkmqVC5LJKLk/ZpikQql6J2Q4hgF
 TmWXIZ9bsmRFSTcD1dleayzG8CTA9tELZgYTmm4TiXz+gJY+yxclCTwHkAQHwHqPq8/h/Pn7YA5
 2jx73yCMZXxF8MG5Pc9/Sl2IidECoU8ND4cyCUPNi2g==
X-Gm-Gg: Acq92OETUqK3aPtFUy2GIxvDhrGiYR4RnTpdbk9Cw6U1X/ve4Xcst1sC7gjr0uYc6qQ
 i1+VJvQ4GFZlRhCjQ+RKPaeUGB9XqvHFi7CNJ6eJ3As86EixEdgH4g6xk/LrirSKiF5f3fHnyfe
 W60NcJe5BfQ5yAK5tgAtARHQBKRP+YrmrcbNkqmEepBOAu4/R1kyUU5f1CHX4L6DVCjMTW9Yxe1
 B6Xvnk60wTdeteR5/Gg3U0lZxkG43meiQ4THSu+mFBCZjEUJLx4/m2noPX1Ins54eSgUwhn
X-Received: by 2002:a05:6a20:2d23:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3b8b5b28234mr6780494637.6.1781735783582; Wed, 17 Jun 2026
 15:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-11-richard.henderson@linaro.org>
In-Reply-To: <20260616212055.334466-11-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 17 Jun 2026 18:36:10 -0400
X-Gm-Features: AVVi8CcdlLB0OdBrGZ7mF1ld4Zs3iC_4fwTVbGWePtxIu2jQeT_9rec4pXrAZqg
Message-ID: <CANCZdfroTMAEt9t+qMSjYB+tc9KnTq=PhA3N=R-eKq5wsiqCaA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] common-user: Implement read_self_maps for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="00000000000076dde406547ab0da"
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62e.google.com
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

--00000000000076dde406547ab0da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:22=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Use kinfo_getvmmap from -luser.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
>  common-user/meson.build |  5 +++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


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
> +        MapInfo *e =3D g_malloc0(sizeof(*e) + path_len);
> +
> +        e->itree.start =3D k->kve_start;
> +        e->itree.last =3D k->kve_end - 1;
> +
> +        /* ??? The rest of these fields are only used in linux-user. */
>

I'm not sure what this comment means...  Maybe think about making it
clearer. What are these fields?


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
> --
> 2.43.0
>
>
>

--00000000000076dde406547ab0da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 16,=
 2026 at 5:22=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Use kinfo_getvmmap from -lu=
ser.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0common-user/selfmap.c=C2=A0 =C2=A0| 41 ++++++++++++++++++++++++++++++=
++++++++++-<br>
=C2=A0common-user/meson.build |=C2=A0 5 +++++<br>
=C2=A02 files changed, 45 insertions(+), 1 deletion(-)<br></blockquote><div=
><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.c=
om">imp@bsdimp.com</a>&gt;</div><div><span style=3D"background-color:transp=
arent">=C2=A0</span></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
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
amp;n);<br>
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
zeof(k-&gt;kve_path)) + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MapInfo *e =3D g_malloc0(sizeof(*e) + path_len=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.start =3D k-&gt;kve_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;itree.last =3D k-&gt;kve_end - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? The rest of these fields are only used =
in linux-user. */<br></blockquote><div><br></div><div>I&#39;m not sure what=
 this comment means...=C2=A0 Maybe think about making it clearer. What are =
these fields?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
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
+=C2=A0 =C2=A0 free(entries);<br>
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
+endif<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div>

--00000000000076dde406547ab0da--

