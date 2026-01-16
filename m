Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF44C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkoc-0005Ap-Qc; Fri, 16 Jan 2026 09:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vgkoV-00059C-2B
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:28:36 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vgkoR-0000u2-Jf
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:28:34 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so1086858a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 06:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768573710; cv=none;
 d=google.com; s=arc-20240605;
 b=PQ4HbWgwCAo0u6Ebe06eHDFY1e1IBrxF8ApFrw1Mq3mqZX8BmHYjhDUqydzk2SZzFg
 9xIpM1dQlLtXW4xSnnPhIjpB0GM7iItl4j8X4qFx7OoDvD4/RIPaFTlQAbIftvnV1wqK
 BK4Op4/VeKqCPyQy6hYNJpyyM600zGA27/PGNscFmzjFTKGdc7XdkBQAuPE4o5g/ce50
 Uc01ebgYoSVzbjmcBezrmiOQHb5Y38Kn53oPM2ih70cqGfzi+RIAJZfJcq5EZPGnNr5k
 rmbKWII+d8fudKtr5lF4w/mfANnNMD9wWjWzjGDdUdGNIc1mQhZRgwckUVN5cKxIP5fh
 k5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BE9CLAmxsTk74/6M70xM4GbFuIDKK3r5yK8PKfJbh2s=;
 fh=hbHG7yoZhep0pDV/lEHFVHMBRMXTsama1ZCDzQjL5hk=;
 b=WO8f3s85GgWdr/xVvYj7sYT+x5TIQQNLg0pJNcxhVs98GFc7i2lptfZsnRCWPce4ZS
 E743D8tx+lnBF99HPKGYkS+eCTAkwq3TcxjdXxRUe6RPOUMB8venWD4N3nxowq3EQTfK
 LtRFOu5AssYIkahvDwu+8SyyBjO9JRZdXG/pnujhR+5zDVpUohFxjGMWn/n1G/UeQAeh
 1tuj9IUFr3ylV3pYcxCr6JUuyCoqKoUFMB59udKaVR1JQtI7Z/IOQHOEEkO/GxuLSyyR
 nI9N3TFR5SUuUFMUv9agv30aLNKnoB0nzaoxIoM9OLLB8eWXTjqXkSiy6OUq7Z90LI9e
 wI3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1768573710; x=1769178510;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BE9CLAmxsTk74/6M70xM4GbFuIDKK3r5yK8PKfJbh2s=;
 b=VVG4AeBXqwGoT+9OPWgY1xGZg0+SksO9Yv5BT4C500VrfjqXIK6qRbPvfH6tEGr6Ai
 nIjhIZce1HFPJxgnVHMrZREf5PJsda+saKojR/yHhpsuuUxfxdDCedmK0rPAL+cmA2x+
 a3q0tdOanYT1WBHJzQjgV6uF4SKpRX0jcNa9Wb6wmfEFanSHxAg2gCMy9kBbvrdoqYmY
 6DORPK+bHOC+d7j8jh1tKluhi6Mf2+sOMOaCRQu7laqtIPd9PNnaUn3OV0Xk6jMrxo4t
 5A+nBfOJkrlN/gb65uNa7K1uEY7ZRBzkB/uRU7PcMk6JD4+Kmw9oDQA64xQUiFDehYSR
 ABLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768573710; x=1769178510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BE9CLAmxsTk74/6M70xM4GbFuIDKK3r5yK8PKfJbh2s=;
 b=bIRdVVrFspAC4lPN8WSupcsOc82x7DhSH/NVCHBknhbEg1YCU2jrXJezA7jtLIgNDx
 FumDedE6qj0IRDnuKzlJ4lsexsXi5uOGSzNVMtsZ3QPzXWCx0BeD8E8tzFhTBQ22KhCY
 RDKH0WCLpDSQFDDec9LCVT6pNpSZLSqen1rOWaXqbnr1zTyUdycdUBHxRCLloh7Q0A4B
 WOQTGG6aix138O8JtwXrDw+LpMIYanWEvcQmKerJJCgtjtc81goEa8bRRWfWWZ8rz+nB
 fGYiKwAZZ2Z2uSYhC5kbQ/TE079i+dkwKqykwIXqdPuHj7Z3h+66VAJaldFLyJ9ydkAC
 0liw==
X-Gm-Message-State: AOJu0Yxjql+xdC198EPCzwu7E+TYGJo2SYwSm1q4XVpaE9Rdocm1trAz
 DTNQGNtkbmHiMQsvfVy9wK3vKvb/3yee+5zGr27bVXgBF+HJjk4qpOXLL02Gv4yzjHEgvJrV8Kl
 aThJMrOXn8hvnC6iQats1XBPI4LzNaFlQOFhcTaVJ8A==
X-Gm-Gg: AY/fxX5QieeRkQC727eaWBR1y6y7FlUlFVyLJWR12938MvyDlpsgptd265pUHrZRB6k
 nRR+9vbNRNVrmkjn4efD64G4tFFFgXMIVqnP3zcoBwtpmifRUPaoL+ZgPGwyASEu/SGvzzcwmE1
 533NPOsdty5CXYus7pK2e5x6xcCE+QNAxuAm5RHxgneD3A4iuvGOsAaKwY/ClJ1gPy0Vc4d8PzB
 WNr3WLMvYBN71xjSV7yzz79k27fuS1mUViRuayv+iZOjMsP/XkKy1y1+UjV1x1FZx44dGyZFnXZ
 Od+VoA==
X-Received: by 2002:a17:90b:2250:b0:34c:a35d:de1b with SMTP id
 98e67ed59e1d1-35272fb9e72mr2956595a91.37.1768573709713; Fri, 16 Jan 2026
 06:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20260116125830.926296-1-peter.maydell@linaro.org>
 <20260116125830.926296-3-peter.maydell@linaro.org>
In-Reply-To: <20260116125830.926296-3-peter.maydell@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 16 Jan 2026 07:28:17 -0700
X-Gm-Features: AZwV_QjOtfiM8-JjOu-y1ukuYzoOECioRf67C7ykyqCaUaM3vQjunrBU6cUf4BQ
Message-ID: <CANCZdfoTuEtVn3CpW9bxQodtkp=HovHF9sb760LXFtR0oyXB+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] bsd-user: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnus.kulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Kyle Evans <kevans@freebsd.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ba14d00648822785"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
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

--000000000000ba14d00648822785
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:58=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes '--git' 'bsd-user' 'bsd-user'
>
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
>
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>   it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>   Drop these, too.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  bsd-user/bsd-mem.h         | 3 ---
>  bsd-user/bsd-proc.c        | 1 -
>  bsd-user/freebsd/os-proc.h | 2 --
>  bsd-user/qemu-bsd.h        | 1 -
>  4 files changed, 7 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

These were the documented includes needed for these APIs. But this cleanup
is fine.
We weren't 100% consistent anyway before.


> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 416d0f8c23..a118e57260 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -49,11 +49,8 @@
>  #ifndef BSD_USER_BSD_MEM_H
>  #define BSD_USER_BSD_MEM_H
>
> -#include <sys/types.h>
>  #include <sys/ipc.h>
> -#include <sys/mman.h>
>  #include <sys/shm.h>
> -#include <fcntl.h>
>
>  #include "qemu-bsd.h"
>  #include "exec/mmap-lock.h"
> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> index ca3c1bf94f..8dcac9608d 100644
> --- a/bsd-user/bsd-proc.c
> +++ b/bsd-user/bsd-proc.c
> @@ -19,7 +19,6 @@
>  #include "qemu/osdep.h"
>
>  #include <sys/param.h>
> -#include <sys/types.h>
>  #include <sys/cpuset.h>
>  #include <sys/resource.h>
>  #include <sys/wait.h>
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 3003c8cb63..cc53215138 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -23,10 +23,8 @@
>  #include <sys/param.h>
>  #include <sys/procctl.h>
>  #include <sys/signal.h>
> -#include <sys/types.h>
>  #include <sys/procdesc.h>
>  #include <sys/wait.h>
> -#include <unistd.h>
>
>  #include "target_arch_cpu.h"
>
> diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> index ffc64bb244..56affcd31d 100644
> --- a/bsd-user/qemu-bsd.h
> +++ b/bsd-user/qemu-bsd.h
> @@ -20,7 +20,6 @@
>  #ifndef QEMU_BSD_H
>  #define QEMU_BSD_H
>
> -#include <sys/types.h>
>  #include <sys/resource.h>
>  #include <sys/ipc.h>
>  #include <sys/msg.h>
> --
> 2.47.3
>
>

--000000000000ba14d00648822785
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 16,=
 2026 at 5:58=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">This commit was created with scripts/cl=
ean-includes:<br>
=C2=A0./scripts/clean-includes &#39;--git&#39; &#39;bsd-user&#39; &#39;bsd-=
user&#39;<br>
<br>
All .c should include qemu/osdep.h first.=C2=A0 The script performs three<b=
r>
related cleanups:<br>
<br>
* Ensure .c files include qemu/osdep.h first.<br>
* Including it in a .h is redundant, since the .c=C2=A0 already includes<br=
>
=C2=A0 it.=C2=A0 Drop such inclusions.<br>
* Likewise, including headers qemu/osdep.h includes is redundant.<br>
=C2=A0 Drop these, too.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 ---<br>
=C2=A0bsd-user/bsd-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0bsd-user/freebsd/os-proc.h | 2 --<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A04 files changed, 7 deletions(-)<br></blockquote><div><br></div><div>R=
eviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.co=
m</a>&gt;</div><div><br></div><div>These were the documented includes neede=
d for these=C2=A0APIs. But this cleanup is fine.</div><div>We weren&#39;t 1=
00% consistent anyway before.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index 416d0f8c23..a118e57260 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -49,11 +49,8 @@<br>
=C2=A0#ifndef BSD_USER_BSD_MEM_H<br>
=C2=A0#define BSD_USER_BSD_MEM_H<br>
<br>
-#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/ipc.h&gt;<br>
-#include &lt;sys/mman.h&gt;<br>
=C2=A0#include &lt;sys/shm.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
<br>
=C2=A0#include &quot;qemu-bsd.h&quot;<br>
=C2=A0#include &quot;exec/mmap-lock.h&quot;<br>
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
index ca3c1bf94f..8dcac9608d 100644<br>
--- a/bsd-user/bsd-proc.c<br>
+++ b/bsd-user/bsd-proc.c<br>
@@ -19,7 +19,6 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
<br>
=C2=A0#include &lt;sys/param.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/cpuset.h&gt;<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
=C2=A0#include &lt;sys/wait.h&gt;<br>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
index 3003c8cb63..cc53215138 100644<br>
--- a/bsd-user/freebsd/os-proc.h<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -23,10 +23,8 @@<br>
=C2=A0#include &lt;sys/param.h&gt;<br>
=C2=A0#include &lt;sys/procctl.h&gt;<br>
=C2=A0#include &lt;sys/signal.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/procdesc.h&gt;<br>
=C2=A0#include &lt;sys/wait.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
<br>
=C2=A0#include &quot;target_arch_cpu.h&quot;<br>
<br>
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h<br>
index ffc64bb244..56affcd31d 100644<br>
--- a/bsd-user/qemu-bsd.h<br>
+++ b/bsd-user/qemu-bsd.h<br>
@@ -20,7 +20,6 @@<br>
=C2=A0#ifndef QEMU_BSD_H<br>
=C2=A0#define QEMU_BSD_H<br>
<br>
-#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
=C2=A0#include &lt;sys/ipc.h&gt;<br>
=C2=A0#include &lt;sys/msg.h&gt;<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--000000000000ba14d00648822785--

