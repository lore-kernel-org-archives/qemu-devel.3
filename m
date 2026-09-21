Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE59C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8av6-0007IK-4r; Mon, 21 Sep 2026 06:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8av3-0007Hs-MD
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:06:41 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8av1-00016b-4C
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:06:41 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469d249c4so2454782b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789985197; cv=none;
 d=google.com; s=arc-20260327;
 b=g8IuOBvaK5SLV/HM0ro6xgeN01wsYAIHLBX8f1pY+YC7wD4xyri66BfqgeRbMrseIN
 7RR1y1ERlz1ONROynQdANGs1eHWyB0EKNcMWqhHCpDW+YFmFOpXez+ey+h2mr3q4gPpr
 PpH76Eu8mpDIPgEkOsIHmb4vB/dAL1McrCdM1GYVZrT4Endnvc6wINvcQmkhhaJDjTZu
 rE+V5gRx5wbAMrOPaWz5w0xgrD/NKTrlZtzrNWFNZ94yR+gZ2y+0dYBo1MBzTaxGtsbt
 419GgM/fiAiyCCDbBwG2gpC2ptR2VlcJ0V2e4WAcecAE6KaIX+PmB4fl5uxd3uPASI3l
 vGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aKzi0k0CEruH+G5VSV9XiTbq/C3mWT7OmGv958n+p8o=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=rrJ9P+jg8MylzK4hJJQY4yAkVPjjPETH2XJ6W1uTJtz4jQi/bD/I33TsWXnYmhmIjY
 85jrYkGybvBceKqTKTtkN7HVaQS6rE8N0h32MSx6PqscNM9OKbwpdL1WlnEJSLIh2Er3
 mOOTDPUpfZKi2WYLUi65bJ13kQ6Z06bj5LNTRyXm1RAwOkaAvdKz+cUiwD+aGi6jvdw3
 +aVBqZEG5+ajjt1v7Ghr2llnF4HxBhHp5B8KhuByDVbJJg74uF7vs1Z6mDx0gx62tkUx
 CA3yMVjvPBtg2utXSEBas43Hs8m0a4rSnw0y3oEBC6wtYLjj5sDytM4Z22sKiKWCr9mm
 iu0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789985197; x=1790589997;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aKzi0k0CEruH+G5VSV9XiTbq/C3mWT7OmGv958n+p8o=;
 b=aoCwJMOC5ivJMQFWA7Cl0hm2EqqP5Tb4IHvAtuqCdpQQtTe4bxXdgStU+XPzfnBU5N
 qOoCsBjPe+n2wiw8tGBWRyapotKA+2UPEpmxol4lWGcjwWIpEwoh6NVQt+CoVSh8B4Ha
 rK/HdD1JeIIWX0e42njQ/DSfhCY8vlyWt3eE/hddnRtx1spnndwyA/wimBibDXfnDObU
 WF5qICYK8kjH9I4CCjMU9AGJ8JK+4tM8W0l/yW7SK53Dlwn9OX2EAjMoMQEyb66zqdwj
 EagJpbWLx0kO0wAuOdKGQs1jqK75mCBiT1qvsm66hOCPjPFci08vp92PejyMBcWRhwQt
 tkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985197; x=1790589997;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aKzi0k0CEruH+G5VSV9XiTbq/C3mWT7OmGv958n+p8o=;
 b=FURlYr7rK7f0qB37R1+Dk15W74wSojHBkzFwOW7+TqVKs6cQAvz1IDCwstYLN6jVb+
 idlKwjNHoGhCDQPF4VUnwuTC2N+3l2M/j7vv2KN+KBREkgJwYxEprvlt6TM6Vjyk6Rj+
 vYlVZQCvfvumQnyFdMXNbtR9EGrNZyPMJ1pLYPwze/lYgoeH+hF1KjESN1VcRDj8nyjw
 rsho/Vg3mNjL0aIs/Y5wJ+jJASoT2jIdKCXa6PcJtcUbkSWugRCQGNFqYbN7ej58jetr
 Dzk3IqpgpKghDvzqRFfO44CTRr0LZUAisa/fb9xBsNwWfp/rV2a46ae3P9Ijh3xQFYyS
 v/xg==
X-Gm-Message-State: AFuF++kkPOFjJNvPx4KEHurpwgNy4MfsQ+reQKRiDHOq2OZ7Y7XT8CvS
 zAz7W84cFh7fH9/GErBqid+cXM6mz/w/OpiihsgHBW0zXLE+Anqwk9aX4haZ+YNCwUWFjHtfpH8
 XWee0wC6mPR6ACavmHpBX49jrneJaC2DaHT6SnrZAgQ==
X-Gm-Gg: AYBFou1eeanUeJ1LhnFYgANOyeHe9rHmuTt0N6nv4shTpxzzhoXikffUspqbkwASWxT
 WATWqx06t3pqjeQMtfC9JjuGKNsIHylsBzhIo0ujMVVWl6CjoVceaTT8XvsjCHExqFK5fjbvW5t
 ggjpkFFNN5zIUcAHQkyiQC+uKQSdqEPLKQ8Em1PTj67aEFMOo5mYMN2NERCj+vxPA1TcqB4yzfa
 im8H6CFlIgLnIic1aTqfVawK6mSc2HNkySz3yaUL+YCcGS2Jf99bVOeE7ecZCg6mrCInl0XRGjd
 NOdtZp7V1NzgIUU+jb1ESGRAoj+P/gQgBgNbskPmxppUvGa0jbjIuC8=
X-Received: by 2002:a05:6a00:3a0d:b0:878:37b2:df9e with SMTP id
 d2e1a72fcca58-87837b2f981mr7056441b3a.56.1789985197190; Mon, 21 Sep 2026
 03:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-4-ebfa61049bd7@bsdimp.com>
 <7d368160-4182-4b60-9aea-11121fbff19e@linaro.org>
In-Reply-To: <7d368160-4182-4b60-9aea-11121fbff19e@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:06:25 -0600
X-Gm-Features: AcwNN1Vg799wabYqbbOEes1MmpShoh7VFiw0fELfUtitn3iFdra7ylsbOPawjH8
Message-ID: <CANCZdfpvpB=FWevTc9qja9YPXwNSxxKg-k9r=C0F8tQMzO2u_w@mail.gmail.com>
Subject: Re: [PATCH 04/14] bsd-user: Add gdb for system calls
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d4fea3065bfb67c9"
Received-SPF: none client-ip=2607:f8b0:4864:3b::f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d4fea3065bfb67c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 4:03=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/19/26 19:20, Warner Losh wrote:
> > Mirror what linux-user does around system calls.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/freebsd/os-syscall.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/bsd-user/freebsd/os-syscall.c
> b/bsd-user/freebsd/os-syscall.c
> > index 7e400c89bc..38dc87f745 100644
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -29,7 +29,7 @@
> >   #include <utime.h>
> >   #include <poll.h>
> >
> > -#include "include/gdbstub/syscalls.h"
> > +#include "gdbstub/user.h"
> >
> >   #include "qemu.h"
> >   #include "signal-common.h"
> > @@ -1622,14 +1622,20 @@ abi_long do_freebsd_syscall(CPUArchState *env,
> int num, abi_long arg1,
> >                               abi_long arg5, abi_long arg6, abi_long
> arg7,
> >                               abi_long arg8)
> >   {
> > +    CPUState *cpu =3D env_cpu(env);
> >       abi_long ret;
> >
> >       if (do_strace) {
> >           print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6=
);
> >       }
> >
> > +    gdb_syscall_entry(cpu, num);
> > +
> >       ret =3D freebsd_syscall(env, num, arg1, arg2, arg3, arg4, arg5, a=
rg6,
> >                             arg7, arg8);
> > +
> > +    gdb_syscall_return(cpu, num);
> > +
> >       if (do_strace) {
> >           print_freebsd_syscall_ret(num, ret);
> >       }
> >
>
> This isn't quite the same -- linux now has plugin support:
>
> static void record_syscall_start(CPUState *cpu, int num,
>                                   abi_long arg1, abi_long arg2,
>                                   abi_long arg3, abi_long arg4,
>                                   abi_long arg5, abi_long arg6,
>                                   abi_long arg7, abi_long arg8)
> {
>      qemu_plugin_vcpu_syscall(cpu, num,
>                               arg1, arg2, arg3, arg4,
>                               arg5, arg6, arg7, arg8);
>      gdb_syscall_entry(cpu, num);
> }
>
> static void record_syscall_return(CPUState *cpu, int num, abi_long ret)
> {
>      qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      gdb_syscall_return(cpu, num);
> }
>
> and they're strictly outside strace rather than interleaved.
>

OK. I'm  going to drop this from the list, but create
https://github.com/qemu-bsd-user/qemu-bsd-user/issues/72
to track it and resubmit once I've had a chance to refactor it.

Warner

--000000000000d4fea3065bfb67c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 20,=
 2026 at 4:03=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 9/19/26 19:20, Warner Lo=
sh wrote:<br>
&gt; Mirror what linux-user does around system calls.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c | 8 +++++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-sysca=
ll.c<br>
&gt; index 7e400c89bc..38dc87f745 100644<br>
&gt; --- a/bsd-user/freebsd/os-syscall.c<br>
&gt; +++ b/bsd-user/freebsd/os-syscall.c<br>
&gt; @@ -29,7 +29,7 @@<br>
&gt;=C2=A0 =C2=A0#include &lt;utime.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;poll.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#include &quot;include/gdbstub/syscalls.h&quot;<br>
&gt; +#include &quot;gdbstub/user.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;signal-common.h&quot;<br>
&gt; @@ -1622,14 +1622,20 @@ abi_long do_freebsd_syscall(CPUArchState *env,=
 int num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg5, abi_long arg6, abi_=
long arg7,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg8)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cpu =3D env_cpu(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long ret;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (do_strace) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_freebsd_syscall(num, arg=
1, arg2, arg3, arg4, arg5, arg6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 gdb_syscall_entry(cpu, num);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D freebsd_syscall(env, num, arg1, arg2=
, arg3, arg4, arg5, arg6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg7, arg8);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gdb_syscall_return(cpu, num);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (do_strace) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_freebsd_syscall_ret(num,=
 ret);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
<br>
This isn&#39;t quite the same -- linux now has plugin support:<br>
<br>
static void record_syscall_start(CPUState *cpu, int num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg1, abi_long arg2,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3, abi_long arg4,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg5, abi_long arg6,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg7, abi_long arg8)=
<br>
{<br>
=C2=A0 =C2=A0 =C2=A0qemu_plugin_vcpu_syscall(cpu, num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg1, arg2, arg3, arg4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg5, arg6, arg7, arg8);<br>
=C2=A0 =C2=A0 =C2=A0gdb_syscall_entry(cpu, num);<br>
}<br>
<br>
static void record_syscall_return(CPUState *cpu, int num, abi_long ret)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0qemu_plugin_vcpu_syscall_ret(cpu, num, ret);<br>
=C2=A0 =C2=A0 =C2=A0gdb_syscall_return(cpu, num);<br>
}<br>
<br>
and they&#39;re strictly outside strace rather than interleaved.<br></block=
quote><div><br></div><div>OK. I&#39;m=C2=A0 going to drop this from the lis=
t, but create=C2=A0<a href=3D"https://github.com/qemu-bsd-user/qemu-bsd-use=
r/issues/72">https://github.com/qemu-bsd-user/qemu-bsd-user/issues/72</a></=
div><div>to track it and resubmit once I&#39;ve had a chance to refactor it=
.</div><div><br></div><div>Warner</div></div></div>

--000000000000d4fea3065bfb67c9--

