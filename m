Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10206D2C120
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L8J-0003jx-JM; Tue, 05 Nov 2024 10:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8L81-0003e8-Tf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:05:58 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8L7z-0001JJ-Rp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:05:57 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720e94d36c8so2400015b3a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730819154; x=1731423954;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nxoPZ/PLfR0CxBnpRxg9qeXwoydXNu6P1p+5V3e/iJ4=;
 b=2c7E6PHG5+QqKt96RmCPUtPsSb9L+AXkxXelnZYvxAYkVvdVhnQTFv6fKZEzdAahJo
 TvWVgr5X285MzNWJc/CmZwONbRW4FtVfYpTOwx11ZD1U3stwHf32quR6vwzCnMehTUY4
 u34blNnHCS0eQJSOQOE1Z16LZ+KvpCjqfP08TzpS492NWFyf+ui3l98RhjvA7I0upJED
 s3kzMowPNaAsLepLyZ4YIf30/S2qoQJskc7hBoOtd7cZcaejyE6liM76Bsh9hxzR8pnU
 FQaoN776kYYNGU9YT7hVqq8tLjSR88HKiRJzBhSw5E2o8bojqk5M5jQzDj5n8SFg2M/t
 ckRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819154; x=1731423954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxoPZ/PLfR0CxBnpRxg9qeXwoydXNu6P1p+5V3e/iJ4=;
 b=Fm2doVgwXqOkLtqAs+yi2KZWPlIQhL2sGp0VSSywEwBulOVa7jEeO8yJOuBtulN33A
 1KM7fMq4wtoqiR5eT5UXAAt7IHCmCirCPAkBel5ZwoIHRGpCgQhPGmFVZUk5SDomwg+i
 JGfcfGmTFNqwQRmBX4zsZFKi25+YFImG61gpR9J+R8mwW28MWX0WItjulQK9Brt86fEX
 C//AmSkeBdVgZafi1i5127pYqLIDNCtvB++m0tl1/r63rglzjoyayda9XKnOKApizrH/
 rnAsLFM7qzwtfQQbAGY8SXlJHYTK2qiMWma1Whosi9zSE/PPURLst7CE2UH2Ij5SRnwy
 HGig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXON05NaNHcnJGWx0hjm3ugc2BAx/iJ1QSvCVRXxCtPCnxlXTz5/vV/HOMTPdhfyMjMo2CVhwtJWuf5@nongnu.org
X-Gm-Message-State: AOJu0Yw2KdCBMKkyvbL+TXsyi03n0X7BXn0dBQCZtaBGN3jFqzkucJ9R
 /El4C3bX6l4BaykaQVOi52bwPTgK8gff8sjGZAVZfcysqXdHiVWl/HZZmWeGaTbeRMIZaHBjclQ
 UF82qFprjagcgBK4m2yI/Lg7PDaOLiu1IM76Hpg==
X-Google-Smtp-Source: AGHT+IHO/8rYW+5/Gegd5A9ks2CrJGorw02T5cAdhys3xDzypSSbtuMPJqiTij/7VobAU5TeZtP01NC5AoCr+RIfL4I=
X-Received: by 2002:a05:6a21:6d9f:b0:1db:d6e4:d1d9 with SMTP id
 adf61e73a8af0-1dbd6e4d46dmr13319075637.1.1730819154303; Tue, 05 Nov 2024
 07:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-4-iii@linux.ibm.com>
In-Reply-To: <20241024200031.80327-4-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 Nov 2024 08:05:43 -0700
Message-ID: <CANCZdfqJd+5F5efvAGNYACoiNdUdSmy3F0hVR=dDFzFmpWbswQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] user: Introduce user/signal.h
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dd016906262bbc80"
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x433.google.com
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

--000000000000dd016906262bbc80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> gdbstub needs target_to_host_signal(), so move its declaration to a
> public header.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/signal-common.h   |  1 -
>  bsd-user/signal.c          |  1 +
>  include/user/signal.h      | 23 +++++++++++++++++++++++
>  linux-user/signal-common.h |  1 -
>  linux-user/signal.c        |  1 +
>  linux-user/syscall.c       |  1 +
>  6 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 include/user/signal.h
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
> index 77d7c7a78b7..4e634e04a30 100644
> --- a/bsd-user/signal-common.h
> +++ b/bsd-user/signal-common.h
> @@ -42,7 +42,6 @@ void process_pending_signals(CPUArchState *env);
>  void queue_signal(CPUArchState *env, int sig, int si_type,
>                    target_siginfo_t *info);
>  void signal_init(void);
> -int target_to_host_signal(int sig);
>  void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
>
>  /*
> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index da49b9bffc1..a2b11a97131 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -22,6 +22,7 @@
>  #include "qemu/log.h"
>  #include "qemu.h"
>  #include "exec/page-protection.h"
> +#include "user/signal.h"
>  #include "user/tswap-target.h"
>  #include "gdbstub/user.h"
>  #include "signal-common.h"
> diff --git a/include/user/signal.h b/include/user/signal.h
> new file mode 100644
> index 00000000000..19b6b9e5ddc
> --- /dev/null
> +++ b/include/user/signal.h
> @@ -0,0 +1,23 @@
> +/*
> + * Signal-related declarations.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef USER_SIGNAL_H
> +#define USER_SIGNAL_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#error Cannot include this header from system emulation
> +#endif
> +
> +/**
> + * target_to_host_signal:
> + * @sig: target signal.
> + *
> + * On success, return the host signal between 0 (inclusive) and NSIG
> + * (exclusive) corresponding to the target signal @sig. Return any other
> value
> + * on failure.
> + */
> +int target_to_host_signal(int sig);
> +
> +#endif
> diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
> index f4cbe6185e1..f82185ec0f5 100644
> --- a/linux-user/signal-common.h
> +++ b/linux-user/signal-common.h
> @@ -61,7 +61,6 @@ void queue_signal(CPUArchState *env, int sig, int
> si_type,
>                    target_siginfo_t *info);
>  void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t
> *info);
>  void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t
> *tinfo);
> -int target_to_host_signal(int sig);
>  int host_to_target_signal(int sig);
>  long do_sigreturn(CPUArchState *env);
>  long do_rt_sigreturn(CPUArchState *env);
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 63ac2df53b7..84bb8a34808 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -33,6 +33,7 @@
>  #include "signal-common.h"
>  #include "host-signal.h"
>  #include "user/safe-syscall.h"
> +#include "user/signal.h"
>  #include "tcg/tcg.h"
>
>  /* target_siginfo_t must fit in gdbstub's siginfo save area. */
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d1b0f7c5bbc..0a3c4d5a946 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -136,6 +136,7 @@
>  #include "loader.h"
>  #include "user-mmap.h"
>  #include "user/safe-syscall.h"
> +#include "user/signal.h"
>  #include "qemu/guest-random.h"
>  #include "qemu/selfmap.h"
>  #include "user/syscall-trace.h"
> --
> 2.47.0
>
>

--000000000000dd016906262bbc80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 24, 2024 at 2:00=E2=80=AF=
PM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">gdbstub needs target_to_host_signal(), so move its declaration to a<br>
public header.<br>
<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/signal-common.h=C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0include/user/signal.h=C2=A0 =C2=A0 =C2=A0 | 23 ++++++++++++++++++++++=
+<br>
=C2=A0linux-user/signal-common.h |=C2=A0 1 -<br>
=C2=A0linux-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A06 files changed, 26 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 include/user/signal.h<br></blockquote><div><br></d=
iv><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@=
bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h<br>
index 77d7c7a78b7..4e634e04a30 100644<br>
--- a/bsd-user/signal-common.h<br>
+++ b/bsd-user/signal-common.h<br>
@@ -42,7 +42,6 @@ void process_pending_signals(CPUArchState *env);<br>
=C2=A0void queue_signal(CPUArchState *env, int sig, int si_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_siginfo_t *info);<br>
=C2=A0void signal_init(void);<br>
-int target_to_host_signal(int sig);<br>
=C2=A0void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);<br=
>
<br>
=C2=A0/*<br>
diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
index da49b9bffc1..a2b11a97131 100644<br>
--- a/bsd-user/signal.c<br>
+++ b/bsd-user/signal.c<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu.h&quot;<br>
=C2=A0#include &quot;exec/page-protection.h&quot;<br>
+#include &quot;user/signal.h&quot;<br>
=C2=A0#include &quot;user/tswap-target.h&quot;<br>
=C2=A0#include &quot;gdbstub/user.h&quot;<br>
=C2=A0#include &quot;signal-common.h&quot;<br>
diff --git a/include/user/signal.h b/include/user/signal.h<br>
new file mode 100644<br>
index 00000000000..19b6b9e5ddc<br>
--- /dev/null<br>
+++ b/include/user/signal.h<br>
@@ -0,0 +1,23 @@<br>
+/*<br>
+ * Signal-related declarations.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+#ifndef USER_SIGNAL_H<br>
+#define USER_SIGNAL_H<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+#error Cannot include this header from system emulation<br>
+#endif<br>
+<br>
+/**<br>
+ * target_to_host_signal:<br>
+ * @sig: target signal.<br>
+ *<br>
+ * On success, return the host signal between 0 (inclusive) and NSIG<br>
+ * (exclusive) corresponding to the target signal @sig. Return any other v=
alue<br>
+ * on failure.<br>
+ */<br>
+int target_to_host_signal(int sig);<br>
+<br>
+#endif<br>
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h<br>
index f4cbe6185e1..f82185ec0f5 100644<br>
--- a/linux-user/signal-common.h<br>
+++ b/linux-user/signal-common.h<br>
@@ -61,7 +61,6 @@ void queue_signal(CPUArchState *env, int sig, int si_type=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_siginfo_t *info);<br>
=C2=A0void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t =
*info);<br>
=C2=A0void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *=
tinfo);<br>
-int target_to_host_signal(int sig);<br>
=C2=A0int host_to_target_signal(int sig);<br>
=C2=A0long do_sigreturn(CPUArchState *env);<br>
=C2=A0long do_rt_sigreturn(CPUArchState *env);<br>
diff --git a/linux-user/signal.c b/linux-user/signal.c<br>
index 63ac2df53b7..84bb8a34808 100644<br>
--- a/linux-user/signal.c<br>
+++ b/linux-user/signal.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &quot;signal-common.h&quot;<br>
=C2=A0#include &quot;host-signal.h&quot;<br>
=C2=A0#include &quot;user/safe-syscall.h&quot;<br>
+#include &quot;user/signal.h&quot;<br>
=C2=A0#include &quot;tcg/tcg.h&quot;<br>
<br>
=C2=A0/* target_siginfo_t must fit in gdbstub&#39;s siginfo save area. */<b=
r>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index d1b0f7c5bbc..0a3c4d5a946 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -136,6 +136,7 @@<br>
=C2=A0#include &quot;loader.h&quot;<br>
=C2=A0#include &quot;user-mmap.h&quot;<br>
=C2=A0#include &quot;user/safe-syscall.h&quot;<br>
+#include &quot;user/signal.h&quot;<br>
=C2=A0#include &quot;qemu/guest-random.h&quot;<br>
=C2=A0#include &quot;qemu/selfmap.h&quot;<br>
=C2=A0#include &quot;user/syscall-trace.h&quot;<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div></div>

--000000000000dd016906262bbc80--

