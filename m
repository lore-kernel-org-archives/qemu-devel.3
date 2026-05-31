Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E91CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXhe-0001W4-4C; Sun, 31 May 2026 00:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXhb-0001Vo-Kx
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:23:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXhX-0002Z9-EO
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:23:07 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-842307473b5so536306b3a.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780201380; cv=none;
 d=google.com; s=arc-20240605;
 b=hTI0S8re0hqulIcYA5hBZJhn+AqxIAlZzN4iglu5dHoJnqvEURAEVsuonKfRDtpLia
 ZbRVDwUseu86USuT6JYaqfhvr3CxVU0MSFHKKpqJT9SYYt89xG9T0yrNxUWncv4DZ5H+
 VJGYj20GApwm3yijMdkJe2Zsrw30uYGG1maayNA6UeSGUFA9TtbCGPk7X/TblOKLrR6+
 4QfnghehVdVi7+gjx/pavfuvxnW+p63PkRZd7wkcy9omi9qKHtz5JZx5n+0VykwPaGup
 si9lXC5+1dWfsTDKZZWhFdauEiV9SFy57wmIDP11lpKOVwSORctGIE9JX5ldIAYWDC5r
 KKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RfcuMrXmUJicmsFyoN/Y+8aPCtfUgWJ7PdFZOreAeuE=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=VdNBsMCDV2PNt1JPrb4m1d+j9moL/8HMhQtrGFU9KcMYkhHiP04jUNoCVFQjN0DaQm
 tPGNko7mNVEEgUf1aIKZGo7Tl+tGZLiK8US7HulD8/4gFhz2zAawLpY6Q4fG+/qy3bKU
 Mu4ZVz4ETaYwUEph1v2A3AqjIolDtLkIp4SIab2V/hgqHjP+v1E4JfquECQeEBiNSkoh
 U7RuYVlZ2qLPg5wEHSsyH76lpMyigELyrB3Tr8dI69hXNNUvY2f2kpIks67xhQowidp3
 tMGaxJIyQaqneEu4Z8LSGEM+XmOHcNt2WNrFDOlpUQYF4NFKzakaHp2MFEnW15y4kk+o
 Tr+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780201380; x=1780806180;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RfcuMrXmUJicmsFyoN/Y+8aPCtfUgWJ7PdFZOreAeuE=;
 b=bbAmcN9+yAKACgpb2wKcujm+zLTLp1fAbAqp4vNoeYazN2roGve50KoHqrxVD/ZrvH
 ZjP5TG5O9Q8hpsOu+NmJ+WIEOu7KoZXeQ05R9QK6/0Iff9CmkcfJQNsWy9u3KzUVp+WZ
 NqXibQVDuRghI7tPQKFaz6MCxxI9MwJixt3G53p46v9828e3NMDQJU6oUDC59CSL9h3q
 64EK4D9PvKpVkzdG8cwSIcS1SPLMSf2Cjtbx+WhCiaHM4WKRxdfDhvG7jgOCwrsx8GwA
 Fv2MopxqTWD/G0/hV+2MMpePlg2w6ffFLxc/GCSvGCPdeN3xkxVAeQ4G90+4aMdd3dPT
 F43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780201380; x=1780806180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfcuMrXmUJicmsFyoN/Y+8aPCtfUgWJ7PdFZOreAeuE=;
 b=OyzP5R8Ih3z1v74PttIKharsSbg1/FvKqHcibNMCX1huuIa+iYGgZRK/2lAk2b1+O3
 r4e4gof1fRpUtBmbDgX08H0aPIn+v1YQrx//Xn/KpH4sSVkCKevh/XmKji3JbD6dBXY0
 nhuLK99jn4Rtii5XnNENvwWeDkg/g98tRY7+TVXsVVrnyQjUIqfPtYzScTNwn9oG/CTk
 /LHGBnP9WrPCOxiegfDpw8aZhbPdhfBlqoCwhLGvbaUE/k0gN3+89XIRcEeHRQXlATFR
 B+X1DVzPPhnNW9wB0vnCKYLDdRlhYkCxJ8B2eUSq5HOQuvTupvjfwuTHgtlL8BBGMSqi
 oKMg==
X-Gm-Message-State: AOJu0YxF3PzNZpedbPoTIaQv3DPApgDRIelId0Y2RzaHlyzOgWq3/4fH
 WWTKBTAcTwvvfCHETg3QlQVUQwCE8HrYYMUzCAB4fzebTmOgFhoL0IGPhcAlrA2hCfMplT0U4tU
 zjLFTkmPxvK5GtoJhHPxrlO6Jh1YWhVtgy1tLgwke2A==
X-Gm-Gg: Acq92OEUNQmRb1JttDC7YxoCEaAxhuP7CFCyc4Hg1cGmydpGTH2CN3vGIofBpEP2EkC
 8TMA8pgd36KCVopf5J+Vz53ESYaa5i1Du8CeW3lBiYiXZm+mCox8qDpmoP96SS+9Yn35cv0ZWnQ
 77daIOkMH7oj1Sdmkctl2NZYGWiMsQ1x4OwNcukkfDGy72dE16pbM1+G84gBR+dDo5KU3mt0Wrl
 pRZYjYDMnC6t/AcqqoEWlo0SEMC1svO/tZRLdy1LAtw8OVHCnruPx/a+YhDyoNTXDu5+qryXU8n
 4YXBaVX656pctLS/amEiF9kV7xy4YctGGLYAYZcwsooInNg=
X-Received: by 2002:a05:6a00:6ca2:b0:82f:623f:e5b3 with SMTP id
 d2e1a72fcca58-842258a1e9fmr5411083b3a.34.1780201379935; Sat, 30 May 2026
 21:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-10-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-10-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:22:48 -0600
X-Gm-Features: AVHnY4LktYw6_0BLwOtEd8Y-YXXa_nEdU_Tq2lGuojLyz3jbq6kRphHqdymcJlw
Message-ID: <CANCZdfr-t73fv=dKzz1iA4ZVjtozydGjwJ74rc6BRyPyWXft3A@mail.gmail.com>
Subject: Re: [PATCH 09/13] common-user: Move selfmap from util
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000e14a030653156ea0"
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x431.google.com
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

--000000000000e14a030653156ea0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:13=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This interface is only used for user-only.  It's more usefully
> placed within common-user than util.  Temporarily add stub
> implementation for bsd-user.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/{qemu =3D> user}/selfmap.h | 0
>  {util =3D> common-user}/selfmap.c  | 6 +++++-
>  linux-user/elfload.c             | 2 +-
>  linux-user/syscall.c             | 2 +-
>  common-user/meson.build          | 1 +
>  util/meson.build                 | 4 ----
>  6 files changed, 8 insertions(+), 7 deletions(-)
>  rename include/{qemu =3D> user}/selfmap.h (100%)
>  rename {util =3D> common-user}/selfmap.c (97%)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/include/qemu/selfmap.h b/include/user/selfmap.h
> similarity index 100%
> rename from include/qemu/selfmap.h
> rename to include/user/selfmap.h
> diff --git a/util/selfmap.c b/common-user/selfmap.c
> similarity index 97%
> rename from util/selfmap.c
> rename to common-user/selfmap.c
> index 483cb617e2..a1b88dee66 100644
> --- a/util/selfmap.c
> +++ b/common-user/selfmap.c
> @@ -8,10 +8,11 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> -#include "qemu/selfmap.h"
> +#include "user/selfmap.h"
>
>  IntervalTreeRoot *read_self_maps(void)
>  {
> +#ifdef __linux__
>      IntervalTreeRoot *root;
>      gchar *maps, **lines;
>      guint i, nlines;
> @@ -80,6 +81,9 @@ IntervalTreeRoot *read_self_maps(void)
>      g_free(maps);
>
>      return root;
> +#else
> +    return NULL;
> +#endif
>  }
>
>  /**
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 93ab2661e3..0450aa13d8 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -25,7 +25,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
>  #include "qemu/units.h"
> -#include "qemu/selfmap.h"
> +#include "user/selfmap.h"
>  #include "qemu/lockable.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7d7a7b489c..448f80b29b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -141,7 +141,7 @@
>  #include "user/safe-syscall.h"
>  #include "user/signal.h"
>  #include "qemu/guest-random.h"
> -#include "qemu/selfmap.h"
> +#include "user/selfmap.h"
>  #include "special-errno.h"
>  #include "qapi/error.h"
>  #include "fd-trans.h"
> diff --git a/common-user/meson.build b/common-user/meson.build
> index f9e2e83f9a..831a7273fb 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -8,4 +8,5 @@ user_ss.add(files(
>    'mmap-min-addr.c',
>    'safe-syscall.S',
>    'safe-syscall-error.c',
> +  'selfmap.c',
>  ))
> diff --git a/util/meson.build b/util/meson.build
> index e29cbd948a..fa174c07a5 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -67,10 +67,6 @@ util_ss.add(files('memalign.c'))
>  util_ss.add(files('interval-tree.c'))
>  util_ss.add(files('lockcnt.c'))
>
> -if have_user
> -  util_ss.add(files('selfmap.c'))
> -endif
> -
>  if have_system
>    util_ss.add(files('crc-ccitt.c'))
>    util_ss.add(when: gio, if_true: files('dbus.c'))
> --
> 2.43.0
>
>

--000000000000e14a030653156ea0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">This interface is only used=
 for user-only.=C2=A0 It&#39;s more usefully<br>
placed within common-user than util.=C2=A0 Temporarily add stub<br>
implementation for bsd-user.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/{qemu =3D&gt; user}/selfmap.h | 0<br>
=C2=A0{util =3D&gt; common-user}/selfmap.c=C2=A0 | 6 +++++-<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 2 +-<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 2 +-<br>
=C2=A0common-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 4 ----<br>
=C2=A06 files changed, 8 insertions(+), 7 deletions(-)<br>
=C2=A0rename include/{qemu =3D&gt; user}/selfmap.h (100%)<br>
=C2=A0rename {util =3D&gt; common-user}/selfmap.c (97%)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner=C2=A0Losh &lt;<a href=3D"mailto:imp@bs=
dimp.com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
diff --git a/include/qemu/selfmap.h b/include/user/selfmap.h<br>
similarity index 100%<br>
rename from include/qemu/selfmap.h<br>
rename to include/user/selfmap.h<br>
diff --git a/util/selfmap.c b/common-user/selfmap.c<br>
similarity index 97%<br>
rename from util/selfmap.c<br>
rename to common-user/selfmap.c<br>
index 483cb617e2..a1b88dee66 100644<br>
--- a/util/selfmap.c<br>
+++ b/common-user/selfmap.c<br>
@@ -8,10 +8,11 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
-#include &quot;qemu/selfmap.h&quot;<br>
+#include &quot;user/selfmap.h&quot;<br>
<br>
=C2=A0IntervalTreeRoot *read_self_maps(void)<br>
=C2=A0{<br>
+#ifdef __linux__<br>
=C2=A0 =C2=A0 =C2=A0IntervalTreeRoot *root;<br>
=C2=A0 =C2=A0 =C2=A0gchar *maps, **lines;<br>
=C2=A0 =C2=A0 =C2=A0guint i, nlines;<br>
@@ -80,6 +81,9 @@ IntervalTreeRoot *read_self_maps(void)<br>
=C2=A0 =C2=A0 =C2=A0g_free(maps);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return root;<br>
+#else<br>
+=C2=A0 =C2=A0 return NULL;<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 93ab2661e3..0450aa13d8 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -25,7 +25,7 @@<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;qemu/guest-random.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
-#include &quot;qemu/selfmap.h&quot;<br>
+#include &quot;user/selfmap.h&quot;<br>
=C2=A0#include &quot;qemu/lockable.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index 7d7a7b489c..448f80b29b 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -141,7 +141,7 @@<br>
=C2=A0#include &quot;user/safe-syscall.h&quot;<br>
=C2=A0#include &quot;user/signal.h&quot;<br>
=C2=A0#include &quot;qemu/guest-random.h&quot;<br>
-#include &quot;qemu/selfmap.h&quot;<br>
+#include &quot;user/selfmap.h&quot;<br>
=C2=A0#include &quot;special-errno.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;fd-trans.h&quot;<br>
diff --git a/common-user/meson.build b/common-user/meson.build<br>
index f9e2e83f9a..831a7273fb 100644<br>
--- a/common-user/meson.build<br>
+++ b/common-user/meson.build<br>
@@ -8,4 +8,5 @@ user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;mmap-min-addr.c&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall.S&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall-error.c&#39;,<br>
+=C2=A0 &#39;selfmap.c&#39;,<br>
=C2=A0))<br>
diff --git a/util/meson.build b/util/meson.build<br>
index e29cbd948a..fa174c07a5 100644<br>
--- a/util/meson.build<br>
+++ b/util/meson.build<br>
@@ -67,10 +67,6 @@ util_ss.add(files(&#39;memalign.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;interval-tree.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;lockcnt.c&#39;))<br>
<br>
-if have_user<br>
-=C2=A0 util_ss.add(files(&#39;selfmap.c&#39;))<br>
-endif<br>
-<br>
=C2=A0if have_system<br>
=C2=A0 =C2=A0util_ss.add(files(&#39;crc-ccitt.c&#39;))<br>
=C2=A0 =C2=A0util_ss.add(when: gio, if_true: files(&#39;dbus.c&#39;))<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000e14a030653156ea0--

