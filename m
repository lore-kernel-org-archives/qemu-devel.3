Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CAFEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQUw-0003Rc-7A; Fri, 06 Feb 2026 13:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voQUu-0003Qy-3e
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:24:04 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voQUs-0005Ic-38
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:24:03 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-354c16d83b2so175574a91.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770402240; cv=none;
 d=google.com; s=arc-20240605;
 b=FN2zPoQ3Hj73OVtHh+2EfyNauHwmRrRUGdLMgOcjKaBm/EQ2KJLuNdM7ulDS5oQvZK
 zZqXMCfh0KPOpeNVPz1FseCm2M8jiwmLsJbA81BE+4m8bhPdalf2QxVWlN5WEE1Tv+z5
 3Dx1haJuIMXP2PA7+fGVFXHjf2nZFwXcF0uyFC+wvA87du25DI6BOIEdFaBdX0eJ/gpT
 H13jwM5YXGbuE0imvLd7eMCUnefDJGO42EQ1mBPBjWQ5oVbXd+rUSYrTgjcJdVvET8cd
 YmEnEVYPAip8G11j14wqzfrREhmqoXUzDAIbdmo1Pyq2CEniGtkdter2HXptk+wSSm4j
 a7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r7fAz8RAfmfVPV61fGVqLgnpA+YrHnbKevnii93h3w4=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=ML47dHeVhrfbSkvnjfOLgaR+0dEwYCF6XjiVn35MVMdp4nsx/zVfwM0e/F6B8tcc6/
 abOcjAXnQMcab06Gj3ORRiWYp/C60ekOupg8w0dwDPWFtCU7CpAFOlmUhOYKsKb4Wl/7
 EblqUF6iLfSktoVQuilfPgZlA6AhTR+ZFTWuqpkgc1yNwjVLnUumDuW+WT2ATr0TCG4r
 CpFLKxgRUnbe+TpiVH39JCFMG2Gx5UWuKAj6rt+ACXK7Qb8AQ9CbgS+AlxzaORPhw6bu
 zC3jvMS5731gowmKQHtCN/fUAgQkluPlf3RSsJQwcwsw/KY4Fhi+s/xBn4YTykY/fEw5
 CXyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770402240; x=1771007040;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7fAz8RAfmfVPV61fGVqLgnpA+YrHnbKevnii93h3w4=;
 b=pWDmFVPPhdGs/bZL49bJ7DW3nizWKUKsDqZ3M3EVJPP+3+ZCHhRhuPl0wlxsSyP6E1
 3I37kNrMUNVEdDJeu0gR0OV7nwznudQR/3MWQpi6BaPgmWXobGK4QUQwr2/hJidhLUix
 ruaBA9Q9QMmFV7qLN5TWhvF/T8IiCwbyNYV2TOK/1DBh3DxYWHcR7ifJTQrTShSYwq7e
 0w9AXVpig+UWNLr7RnO6hfbsTVCBT5EZd0+EhjDNblh0KSjrmMDNjH8kcb0e6NVa+0z4
 bnqyMB2qHz67B9urn2irZgGVLrIUTXc+qauOoGKApAHlzexP4xeIseLJ0cTQP6kkt6IH
 sTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402240; x=1771007040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7fAz8RAfmfVPV61fGVqLgnpA+YrHnbKevnii93h3w4=;
 b=bn0yTvIfddKESVoYF1qdMZnIXOOl+f9uXcueufTn/TWhgXAzmPdGJahEjCsm20CWJp
 TMkrxHvibhtotjXlZ92SIFQS9mcdQask+f0QjOj3u1l/szIhLp6KdyM/HkBrsqoPEFZg
 uB6RTt7WSEXbrhZuj1Z+JMZcyhMJm5cq5SiIY64sgIyI/VoPu7sojPQJCZu3OUm3qREG
 fJGnqL2RaXCymk8DkkMj6wuRnXPtQ4hBRAbMEgMyrDA4XLxKjDhkrLwbOa5QXFCV8GUf
 gWve6Ui18Htsv3imUHfDxjFbGOS0l2qLbnMELScqK5X1xYHSIs8enpbNLIm6f1pnc4Ih
 a+rA==
X-Gm-Message-State: AOJu0YyTJrZIiP8NE6Fj1d164LKuDaOMUjtiJOIIPAS7te1j/FRJYciV
 CxhkugzrYzVaUVh1j6wVy9+xwYrKfwA1vUk4DvASMnOmwwSy8ve9LT9vc24WeWvDG4tx09I6k/k
 PhRut/kNAmlMGVqi3TEE86/UBMdCRSFhwzcJJDKHBXg==
X-Gm-Gg: AZuq6aJHOALQNTxqd2yrxKqcj3nFDzuoCfOz3szsl4LBtS5+tsYBr7J6vOauNL8H7hv
 XGz4w5MnAFBd/5FZalF+Yk0jRPdSYCMxzW33GOusFKIThMG9dm4ORyMV9SvKcZ6Z6VE9quDLdvu
 Jrj92q954IoNaez+wD18My/x0KwQEv5WOcb8EbTKeQ/Ed7xjr9cDwEqQZzHCdIhlLMKR1gVFqN3
 pBn3tYPKctQplQfwLhPh5aIfSk2l93gvSkd/C7+LZ9CiO2CxrV0vVeOc0hYrGh68/sMDRhn19qb
 GkuxUsA=
X-Received: by 2002:a17:90b:3c8b:b0:352:e27e:79c5 with SMTP id
 98e67ed59e1d1-354b3cfeca9mr2853786a91.31.1770402240179; Fri, 06 Feb 2026
 10:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-22-8d8ff0035372@bsdimp.com>
 <effcf620-704f-4d17-b3ce-1832742bd4e8@linaro.org>
In-Reply-To: <effcf620-704f-4d17-b3ce-1832742bd4e8@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 11:23:49 -0700
X-Gm-Features: AZwV_QjCjCybYzke750_DpStHYbHx50RkVR-BW6sFCwh-5aLbW8aGPwRYMlU4Zg
Message-ID: <CANCZdfoB-P4Sg7OjWdNt0__oijcqDdO0H_Jn7FhvXwqFkcjyxA@mail.gmail.com>
Subject: Re: [PATCH 22/24] bsd-user: Implement System V semaphore calls
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a2c0c8064a2be42b"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
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

--000000000000a2c0c8064a2be42b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 8:34=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Wire up semget(2) and semop(2) syscalls to get System V semaphore
> > implementation, as well the undocumented __semctl used to implement the
> > bits of the interface in libc.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/freebsd/os-syscall.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-syscall.c
> b/bsd-user/freebsd/os-syscall.c
> > index ca2f6fdb66..6e38007bdd 100644
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -37,6 +37,7 @@
> >   #include "bsd-file.h"
> >   #include "bsd-mem.h"
> >   #include "bsd-proc.h"
> > +#include "bsd-misc.h"
> >
> >   /* BSD dependent syscall shims */
> >   #include "os-stat.h"
> > @@ -879,6 +880,28 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
> >           ret =3D do_bsd_shmdt(arg1);
> >           break;
> >
> > +        /*
> > +         * System V Semaphores
> > +         */
> > +    case TARGET_FREEBSD_NR_semget: /* semget(2) */
> > +        ret =3D do_bsd_semget(arg1, arg2, arg3);
> > +        break;
> > +
> > +    case TARGET_FREEBSD_NR_semop: /* semop(2) */
> > +        ret =3D do_bsd_semop(arg1, arg2, arg3);
> > +        break;
> > +
> > +    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
> > +        /*
> > +         * The semun argument to semctl is passed by value, so
> dereference the
> > +         * ptr argument.
> > +         */
> > +        abi_ulong atptr;
> > +        get_user_ual(atptr, (abi_ulong)arg4);
> > +        ret =3D do_bsd___semctl(arg1, arg2, arg3,
> > +                (union target_semun)(abi_ulong) atptr);
>
> Eh?  Does this really compile, casting an integer to a union?
> Something seems very confused here.
>

It works, but it's kinda nutso code. I wouldn't have thought you could cast
a long to a union...

It's even more nutso inside do_bsd__semctl()! I think that we need to honor
that this is really a pointer to a union and pass that in as such and then
__get/put_user rather than doing the tswap dance twice.

Warner

--000000000000a2c0c8064a2be42b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 8:34=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Wire up semget(2) and semop(2) syscalls to get System V semaphore<br>
&gt; implementation, as well the undocumented __semctl used to implement th=
e<br>
&gt; bits of the interface in libc.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c | 23 +++++++++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A01 file changed, 23 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-sysca=
ll.c<br>
&gt; index ca2f6fdb66..6e38007bdd 100644<br>
&gt; --- a/bsd-user/freebsd/os-syscall.c<br>
&gt; +++ b/bsd-user/freebsd/os-syscall.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;bsd-file.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;bsd-mem.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;bsd-proc.h&quot;<br>
&gt; +#include &quot;bsd-misc.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* BSD dependent syscall shims */<br>
&gt;=C2=A0 =C2=A0#include &quot;os-stat.h&quot;<br>
&gt; @@ -879,6 +880,28 @@ static abi_long freebsd_syscall(void *cpu_env, in=
t num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_shmdt(arg1);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* System V Semaphores<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_semget: /* semget(2) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_semget(arg1, arg2, arg3);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_semop: /* semop(2) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_semop(arg1, arg2, arg3);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocu=
mented */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The semun argument to semctl is p=
assed by value, so dereference the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ptr argument.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong atptr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_user_ual(atptr, (abi_ulong)arg4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd___semctl(arg1, arg2, arg3,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (union target=
_semun)(abi_ulong) atptr);<br>
<br>
Eh?=C2=A0 Does this really compile, casting an integer to a union?<br>
Something seems very confused here.<br></blockquote><div><br></div><div>It =
works, but it&#39;s kinda nutso code. I wouldn&#39;t have thought you could=
 cast a long to a union...</div><div><br></div><div>It&#39;s even more nuts=
o inside do_bsd__semctl()! I think that we need to honor that this is reall=
y a pointer to a union and pass that in as such and then __get/put_user rat=
her than doing the tswap dance twice.</div><div><br></div><div>Warner</div>=
</div></div>

--000000000000a2c0c8064a2be42b--

