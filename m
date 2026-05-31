Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9641CD6E4A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 03:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTX2X-0002nb-GT; Sat, 30 May 2026 23:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTX2W-0002nT-8I
 for qemu-devel@nongnu.org; Sat, 30 May 2026 23:40:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTX2T-0004Dq-LZ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 23:40:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso7172995ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 20:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780198835; cv=none;
 d=google.com; s=arc-20240605;
 b=FDijk7dmzyMvUtpGhx6d2QHhi+0D4/l6TjrWXmLARUTzyH9LkDEyOq3nCT8xGZRTIx
 Xfd7K5HDEc/gBpzNCsaOX8kwKlQVeC2zu5WuQPwD/+m1vtfA9pqrhw7z6hiwZ/r4Ttt8
 8PhAmMbUOTkntpsShc4VAy9VkxXIsN8yZLdXrK2CDVi2FhWgVpyWK6J99vG23+l6t66V
 Ww+DOdpNGKArZfEgq571KFMEJIBQ4muDEcHnULodvOE1bnAsf4m5Uw/qoSw5HHP/xdFb
 an3MwVXvnVEeJi1Q9lmBWKzpLcGt2c4XJ64i9jviqb/g8zrnXeUT56Kr6Najchf7p0eT
 VqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YDfqwK/IULEm4XjKiL9W3gcuYgzin+kA8+pzThhmh6c=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=M9sTfhtuUr05AQtkI3DGv9L2pcv4FN5igq29weWdXqRinn8YzkiI78WzapMY3jZZXC
 ZFUAMuai1Sa4HjHVVDHmAkP7muYigap/eiQXMSX21ZCE9eJrPaeio8UVXmSdEBfiNSTD
 sfO18MDhWivQS7W/fR2X+Mq5jkeXtogErBlCBWGm9xfE+ShZigQQfN7u2L3dfUVTg/d1
 TRGS/tmsNfsf5yIHjfORRhX3zq3hoV5mRP1JQtj9fWt4Naxjzf7oYrho93EJGsg5TmdL
 YTScrQ33fcBzZGpve7JkBiousvxrSfao/PUHFATMKRueSRGDjh8j0w/Tnc7sodf8IE2U
 OWMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780198835; x=1780803635;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YDfqwK/IULEm4XjKiL9W3gcuYgzin+kA8+pzThhmh6c=;
 b=aK2F7edh6JsHSiIGGkmX50VmKYQ+gfTEo6qxnZIj/8VLjY+bG0P2saO4+Oyr6uLTqH
 1a5ewAsthDGnBRo/Nxo2PAyQKz7NBbZhuYccKwsPCKWUfirboqCUtFueEcPdGKWB5c5N
 yWuovgm1nv7xHSGso8RjDrFc5Ieuj1kiZstX33QLS+dtjoPCfgyVTUtltq+xPTGy3BZZ
 DjW2lFtl7q1uNlN9IOF/Bt7SfwMgBxmagPuTw7SFkqWHQOuAI7oFCxGwBaRx5ugaruPz
 o8N/rY2pav6ZWlGbkDI1IxO3NEnv9C65opnNtbDD+DXRxKZWzxujue8Wqamuw4d/q+4R
 D2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780198835; x=1780803635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDfqwK/IULEm4XjKiL9W3gcuYgzin+kA8+pzThhmh6c=;
 b=ncLwJGa22Zd+4nMjJf7Rvu/vJiPlHOJ2z7mrqxuLeeAzJIrK9d72wvlslep6qbkUp3
 +GYjql3eJxf+JB1gooB0px+VC9feeERSPQzbCbNk90zTUGmSFzL3b6yFtdKTex8g06d1
 IFm9Fu9v35SFhuv4vJfXRxwsI5U4CWGuMITmg5iABYsKlS+bQUxoKiENdeMRNJAH78wP
 lAY9ArOouwbBnIkOd2FVTJgrdiP164mudMv03oTDDq+TFn51s0+K3nJNGBe5dLHj23Kh
 00e4AOKaSCvkxsFItUjfSEObsl9KJtdkvYDguVKmuvEsP1yS8ydfEXLWDR7KfNIgpW9Y
 JBcg==
X-Gm-Message-State: AOJu0YwPWDrrJTlJh0/w+D2CO/UWVjcXfRAGUtGgebM1qRWvWnTj710E
 7bwhvXoq6AcJMU0K1GoVc3a6/dI+rad1veeA6futy+lhRtYtcbzc6TN97bvQBun6oEcTR5yz9XD
 TloYEslYcmIQFU5/ZROvBceysMoV0CbGFngE6J30+xg==
X-Gm-Gg: Acq92OHqQKAEDA6rCC0WUy3LpSopgE638w3VwjAp/KVsFyOtJxgHHNZZrAWx5Xi7GZJ
 As+vx8aZXvtsTu5dTlINLwWwIJXblebC/dnvw2Wos37FfiR7ueNoZQyBPD6WjA6J7YNqh5KoGnG
 pU5ys2/57zg9x4L5D67SLPuqI+BFySzPGBhG+CVQ3SkXf4fd1amcF19RiKbkChKCTsY5wgVc4Qx
 QXAq182mZu1qbkoKRyyQchjkNTw2PyCPFh7HyDkGLp/EbMC+KmvFgb1UFIO68sx4tacCrdZ5BNV
 NuuN00RgfgjIALaTG3im/K0tOwSOT1G2DUCT9xcKz/GhDig=
X-Received: by 2002:a17:903:1207:b0:2bd:3bfd:7512 with SMTP id
 d9443c01a7336-2bf368468ddmr67677745ad.29.1780198835211; Sat, 30 May 2026
 20:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-11-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-11-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 21:40:24 -0600
X-Gm-Features: AVHnY4Iip-78k1v3TLww3Lkrl6_gGCs3n_dDnOkhXgrwpnSas8JPMuY4PsdDhV4
Message-ID: <CANCZdfqqNMaK3SRHQ9NpYNFvOdoOaFzu8-zEWPueZ1nMvS1ZFw@mail.gmail.com>
Subject: Re: [PATCH 10/13] common-user: Implement read_self_maps for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="00000000000033dc21065314d70d"
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x631.google.com
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

--00000000000033dc21065314d70d
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
>

I have an implementation of this in bltiz. I'll compare the two. Do you wan=
t
me to send that to the list, or can you look at
https://github.com/qemu-bsd-user/qemu-bsd-user/commit/a19b96e7719d570d9a8b6=
05f2e89d59750110990
and
https://github.com/qemu-bsd-user/qemu-bsd-user/commit/f6708d9cd0ee6e3d950ce=
2adc9a36ecd9b3eb7cc
to see what I've done. It works, and I think it's right. I used the sysctl
interface directly rather than the
kinfo_getvmmap to avoid the libutil dependency, but maybe that's not a big
concern.

I'll go over the rest of this series in a bit. This one caught my eye when
catching up on email.

Warner

--00000000000033dc21065314d70d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
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
+endif<br></blockquote><div><br></div><div>I have an implementation of this=
 in bltiz.=C2=A0I&#39;ll compare the two. Do you want</div><div>me to send =
that to the list, or can you look at</div><div><a href=3D"https://github.co=
m/qemu-bsd-user/qemu-bsd-user/commit/a19b96e7719d570d9a8b605f2e89d597501109=
90">https://github.com/qemu-bsd-user/qemu-bsd-user/commit/a19b96e7719d570d9=
a8b605f2e89d59750110990</a></div><div>and</div><div><a href=3D"https://gith=
ub.com/qemu-bsd-user/qemu-bsd-user/commit/f6708d9cd0ee6e3d950ce2adc9a36ecd9=
b3eb7cc">https://github.com/qemu-bsd-user/qemu-bsd-user/commit/f6708d9cd0ee=
6e3d950ce2adc9a36ecd9b3eb7cc</a></div><div>to see what I&#39;ve done. It wo=
rks, and I think it&#39;s right. I used the sysctl interface directly rathe=
r than the</div><div>kinfo_getvmmap to avoid the libutil dependency, but ma=
ybe that&#39;s not a big concern.</div><div><br></div><div>I&#39;ll go over=
 the rest of this series in a bit. This one caught my eye when catching up =
on email.</div><div><br></div><div>Warner</div></div></div>

--00000000000033dc21065314d70d--

