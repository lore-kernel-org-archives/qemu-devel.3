Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C88EF06E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpILS-0005CM-7X; Sun, 08 Feb 2026 22:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpILN-0005C2-2r
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:53:49 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpILJ-0006sY-L5
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:53:48 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3562258142fso718762a91.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 19:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770609223; cv=none;
 d=google.com; s=arc-20240605;
 b=WWzf6PaK/xJ6RIxDok6/ft0ZTZp2JoYnpo6gFp2N3W4yq0dh8SGDv40M/fpkfcs4MF
 oSJdkccFq0KIYS5P0UZIbjujSUh/tNHS35VBZEMMbS+AhY4U8dYbITZW3C8baqz+8KDd
 epCT5hZZtuVnpj2sidXZE0l3828QapcIBqnAbb8AHyq0Eb/pCWHGQv+72Q/RydzAbICk
 QR1x0rE3bd6OoZFX2EuitzKdoPwlYAhi8rzthj/oUdBsLzqmLzTgr+ZG5Ib8BHYxOIrZ
 FE1NixkB0T4K20KbmyAyt3m1zXTp82o3ALTQZFdU6RNMYVKPGdMkx0/UbCqPzRHBMnbD
 +fAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LeKTLGELJvh5Nj+yPqXyDeeYVst58EDCdyhxlpXZLAI=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=kec5bMaOaQdtbgTSB6Iw8eFElCbp2AR5Jvucggzt8BBPYMe8/x0m/N0JeZyggjxD3m
 haC6+faf+2OwsByg4YXQONgJHrWmDODyD1fvxpo+1XTdX9icrrMlnCNuGl4xSd8Yfr2t
 VyxwZff/iu6LH1MoHQbLu8EcctlSI8e5GvEFv0BGrRkNDzf+D0/R/QTfmlm9bvVuiuol
 ONxyVGnBJ+6HBnxv8W/qen5uZGJ25v2DFII0nI9WwC4IEc83lu+EatCjduuCj97DorTp
 9AUpB0xn4KPRJh57T+5ealfBX9i1xkXaamWZXKKy1RSiIYaqDmfbUUHnaruhzTXKtLNI
 F1Xw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770609223; x=1771214023;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LeKTLGELJvh5Nj+yPqXyDeeYVst58EDCdyhxlpXZLAI=;
 b=L0Nagq1ODh2i4yyQpjzBJBpCVRAn7cYNscVX8j7CNSaxTdZ/Ew8tyxuY9IDpoxPy5m
 JlA2Us9bSrtYYgDLpaOt2QnKS1QPADiqMjuR+mGl1qeLcQ22sNCcJTlcIhzEnPv+YUHG
 ejNG7zaI25CmxJUIENVNoardLGTyuscnE43iYHzO/aQLUbmEgjFaUBSMCIeioC8Gt8FQ
 8WY9jvIaGdYlwylMy5z8ae1RKtodZ254ZP5l61fDdLBzmVc0+DsGdljryGqVpbAnBsIa
 YpI+mtzNp2ASuzyPRYx17SoN6klwQA8oF+QuKPVVTX0RiCuWRs25niTzYirDsHhJvFdQ
 LPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770609223; x=1771214023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeKTLGELJvh5Nj+yPqXyDeeYVst58EDCdyhxlpXZLAI=;
 b=uEwZpm7hsoJSQelELaKo2/tNhG4/BYf5wQUa03dcCI4zDWsBAaM6wG7mc2PImhEozi
 USfkheH8XptJG8M0iUIwkHI36FD+EOCOb9Ks1Sbxbf83Ml8FUqJOdTusgwCHWHF6/eJx
 4nSroQXDqO9SLnc/mB1nGAmDv033USmmVNZ/3mSXOqKnRC7i3qb/KFQkEsCQ8HlfZLeE
 C1b0/7T5Lgrf2VlsWFz5uJ8FTr8N6TL1XDSs7awVuHibHFPCrS4AAjrUxO+UdK1pjMRa
 F5uZuY3nYQl3us9r10aGdgnXsC3gNiBbTwqTPipNd26qzRviwKZAvhp4N46akq6fCL4D
 oYEA==
X-Gm-Message-State: AOJu0Yz4Hx/6zVo8baaAl8Ym2Jm1n1Q+2uAeeJhR0wDqMaaAbLW6zexW
 THo/u9ifzfGjVnBRzNp/WwQeO9TqZhSj7LSn+5day/eCrulgWfkBqkJc0lgQNFCi1aC8vovRFjT
 e7C0SIfDYv1feDhVa+9gsTMmRFh9TU/00RgqdQAH8lQ==
X-Gm-Gg: AZuq6aLQHxxO1jJKKAe5uRTGo7QEb3rlTlVnmIK8gRokCXgIRZb7yZuzqpJkLXUdS9O
 R1hnVbn3UhraDlVIE8UOUuRlo97a7Hf55/MqKu5EurjuNJyBv22l+pFCkzqJH29I55bWFEfUHNn
 ovZ7tI5hAS3midw4XDut+2hWl528E8szBbz+w5Xu+qoalt/TPm/UKu19qBWua82RIe5wETDOY5B
 yhOxhTffKvaubVB/xAHW108AQRptR/0WicqBq4rjG/DzOmP6jFBXu382I7X19D4auhu18U=
X-Received: by 2002:a17:903:2f4b:b0:2aa:d5ea:4cfb with SMTP id
 d9443c01a7336-2aad5ea4f5cmr39735625ad.9.1770609222842; Sun, 08 Feb 2026
 19:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-18-58e5fcfdb84f@bsdimp.com>
 <4ac81830-4a5a-4a24-bc96-bbc091b817ef@linaro.org>
In-Reply-To: <4ac81830-4a5a-4a24-bc96-bbc091b817ef@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 8 Feb 2026 20:53:31 -0700
X-Gm-Features: AZwV_QgwiDqQCjQTxI4Ci7IsBOTP5xIv-27-TmusJZ8aPpx6AjQ-jHNJ4MJCAo4
Message-ID: <CANCZdfrFJA2TSMoarO9wApz5su8iygVjquPSXgGx+th4tUyqyQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/24] bsd-user: Add do_bsd___semctl implementation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c388ab064a5c1593"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
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

--000000000000c388ab064a5c1593
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 7:17=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/9/26 05:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of __semctl(2) syscall for System V semaphore contro=
l
> > operations. Handles command translation, endianness conversion for
> GETVAL/
> > SETVAL, and array/structure conversions for
> GETALL/SETALL/IPC_STAT/IPC_SET.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 115
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 115 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index cba0b2ec92..d3ce01a2a3 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -106,6 +106,121 @@ static inline abi_long do_bsd_semop(int semid,
> abi_long ptr, unsigned nsops)
> >       return semop(semid, sops, nsops);
> >   }
> >
> > +/* __semctl(2) */
> > +static inline abi_long do_bsd___semctl(int semid, int semnum, int
> target_cmd,
> > +                                       abi_ptr un_ptr)
> > +{
> > +    void *target_un;
> > +    union semun arg;
> > +    struct semid_ds dsarg;
> > +    unsigned short *array =3D NULL;
> > +    int host_cmd;
> > +    abi_long ret =3D 0;
> > +    abi_long err;
> > +    abi_ulong target_array, target_buffer;
> > +
> > +    switch (target_cmd) {
> > +    case TARGET_GETVAL:
> > +        host_cmd =3D GETVAL;
> > +        break;
> > +
> > +    case TARGET_SETVAL:
> > +        host_cmd =3D SETVAL;
> > +        break;
> > +
> > +    case TARGET_GETALL:
> > +        host_cmd =3D GETALL;
> > +        break;
> > +
> > +    case TARGET_SETALL:
> > +        host_cmd =3D SETALL;
> > +        break;
> > +
> > +    case TARGET_IPC_STAT:
> > +        host_cmd =3D IPC_STAT;
> > +        break;
> > +
> > +    case TARGET_IPC_SET:
> > +        host_cmd =3D IPC_SET;
> > +        break;
> > +
> > +    case TARGET_IPC_RMID:
> > +        host_cmd =3D IPC_RMID;
> > +        break;
> > +
> > +    case TARGET_GETPID:
> > +        host_cmd =3D GETPID;
> > +        break;
> > +
> > +    case TARGET_GETNCNT:
> > +        host_cmd =3D GETNCNT;
> > +        break;
> > +
> > +    case TARGET_GETZCNT:
> > +        host_cmd =3D GETZCNT;
> > +        break;
> > +
> > +    default:
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    /*
> > +     * Unlike Linux and the semctl system call, we take a pointer
> > +     * to the union arg here.
> > +     */
> > +    target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(union
> target_semun), 0);
>
> Missing an unlock.
>

Oh! Right you are... I'm surprised we don't have the annotated so clang
tells me
when I make a mistake like this....  Fixed in v3.

Warner


> r~
>
> > +
> > +    switch (host_cmd) {
> > +    case GETVAL:
> > +    case SETVAL:
> > +        __get_user(arg.val, (abi_int *)target_un);
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        break;
> > +
> > +    case GETALL:
> > +    case SETALL:
> > +        __get_user(target_array, (abi_ulong *)target_un);
> > +        err =3D target_to_host_semarray(semid, &array, target_array);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        arg.array =3D array;
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        err =3D host_to_target_semarray(semid, target_array, &array);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        break;
> > +
> > +    case IPC_STAT:
> > +    case IPC_SET:
> > +        __get_user(target_buffer, (abi_ulong *)target_un);
> > +        err =3D target_to_host_semid_ds(&dsarg, target_buffer);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        arg.buf =3D &dsarg;
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        err =3D host_to_target_semid_ds(target_buffer, &dsarg);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        break;
> > +
> > +    case IPC_RMID:
> > +    case GETPID:
> > +    case GETNCNT:
> > +    case GETZCNT:
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, NULL));
> > +        break;
> > +
> > +    default:
> > +        ret =3D -TARGET_EINVAL;
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
> >   /* getdtablesize(2) */
> >   static inline abi_long do_bsd_getdtablesize(void)
> >   {
> >
>
>
>

--000000000000c388ab064a5c1593
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 8, =
2026 at 7:17=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/9/26 05:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of __semctl(2) syscall for System V semaphore contr=
ol<br>
&gt; operations. Handles command translation, endianness conversion for GET=
VAL/<br>
&gt; SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC=
_SET.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 115 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 115 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index cba0b2ec92..d3ce01a2a3 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -106,6 +106,121 @@ static inline abi_long do_bsd_semop(int semid, a=
bi_long ptr, unsigned nsops)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return semop(semid, sops, nsops);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* __semctl(2) */<br>
&gt; +static inline abi_long do_bsd___semctl(int semid, int semnum, int tar=
get_cmd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_p=
tr un_ptr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *target_un;<br>
&gt; +=C2=A0 =C2=A0 union semun arg;<br>
&gt; +=C2=A0 =C2=A0 struct semid_ds dsarg;<br>
&gt; +=C2=A0 =C2=A0 unsigned short *array =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int host_cmd;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 abi_long err;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong target_array, target_buffer;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (target_cmd) {<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETALL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETALL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_STAT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_STAT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_SET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_SET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_RMID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_RMID;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETPID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETPID;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETNCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETNCNT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETZCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETZCNT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Unlike Linux and the semctl system call, we tak=
e a pointer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to the union arg here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(uni=
on target_semun), 0);<br>
<br>
Missing an unlock.<br></blockquote><div><br></div><div>Oh! Right you are...=
 I&#39;m surprised we don&#39;t have the annotated so clang tells me</div><=
div>when I make a mistake like this....=C2=A0 Fixed in v3.</div><div><br></=
div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
r~<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (host_cmd) {<br>
&gt; +=C2=A0 =C2=A0 case GETVAL:<br>
&gt; +=C2=A0 =C2=A0 case SETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(arg.val, (abi_int *)target_un)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case GETALL:<br>
&gt; +=C2=A0 =C2=A0 case SETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_array, (abi_ulong *)tar=
get_un);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semarray(semid, &a=
mp;array, target_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.array =3D array;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semarray(semid, ta=
rget_array, &amp;array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPC_STAT:<br>
&gt; +=C2=A0 =C2=A0 case IPC_SET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_buffer, (abi_ulong *)ta=
rget_un);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semid_ds(&amp;dsar=
g, target_buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.buf =3D &amp;dsarg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semid_ds(target_bu=
ffer, &amp;dsarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPC_RMID:<br>
&gt; +=C2=A0 =C2=A0 case GETPID:<br>
&gt; +=C2=A0 =C2=A0 case GETNCNT:<br>
&gt; +=C2=A0 =C2=A0 case GETZCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, NULL));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* getdtablesize(2) */<br>
&gt;=C2=A0 =C2=A0static inline abi_long do_bsd_getdtablesize(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; <br>
<br>
<br>
</blockquote></div></div>

--000000000000c388ab064a5c1593--

