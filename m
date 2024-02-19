Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72C1C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4i6-0006oL-Qg; Mon, 19 Feb 2024 09:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rc4i4-0006iK-JV
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:33:32 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rc4i3-0003gY-1G
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:33:32 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5611e54a92dso5949910a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1708353209; x=1708958009;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4GGVDx/WsONkiteIfjgxwMCsUs5gQkLi7hXggZIMI8=;
 b=sOdw5X+RerPv2agZT24pXOgY5bjOSdyaqRtwaz+yNR5S/OD0vqtJxYzj1LXNa+siBg
 dEhjm1VRXdYipcJbvkkoxDxumiRCyBPFbUc+GHj7G35wxytNkNZPP5dRoq8FpppF7PEN
 Qtayv4kls4mns12S8rYZeiAtsv6itiI8JUHXL38YOcj3ikZmtYloeaNZe6ik9HP4N1fZ
 E5CL9Y1S2henUZyzTHkxKfCf2/N6aeUQq17iT5nciPj3HldAUIXDzNZ9EGiDdKg02LoQ
 omo/J8Ke7ZpmZtJRA43VDoZk45DSJw0VHGpQWOqGe2x31JTK2YofePJhOpmKrjWzHbKY
 SNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353209; x=1708958009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4GGVDx/WsONkiteIfjgxwMCsUs5gQkLi7hXggZIMI8=;
 b=WOdC2SamY+lHdq+eLMwFtEQTaaSS6DIeHwgzVfcqAEhGCZDfizZnW7VjgswzILAuBb
 MZi5zv8SAEwpjovXsNx6S3OvfQQBqrfUKFgtC2KoarCCn/XxLSLpCWnbI+3BVd6PePKC
 +8wz4F/U9qFiulSIGY/aaccIKh8rQoH6cqd+6cdFH6XEkCNLdyTY7qoK77NPUWoqmPEx
 fG1R6Mv2ZX4VszE5hf//1gEGpFVhW7xjsnfOB3GKUEPMH2vuJ4k6foKSxW50EjY6Csle
 1BrzF7nDBILOvQ6qppaUyF/qtNCnj1V5K3/9809p0u6NyPGVZ1jKhsxR4ARv2Fa4R4HA
 uAVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWxR/ATzJn5IEDxwj2wLnrz3n+uLcVSVD63st8JTAaGhq6wUeppthOlnATN64f/Qn+xxHwqTOlRXgdgwp++tU+lNrWWJA=
X-Gm-Message-State: AOJu0YyykJrAY5vSXcLl/8vIT/08xV4Sso7oO22p83mQgIRuO8fzQ5VG
 4lzJ580O5vexFd3qRZO1j27JLBy+Wo8tTB6zRonnuYNoArybhh8E2mkgnQHUsBoDeqtcaBe4/TA
 l68hep4d8BwziLBSO6/6Q4e+aVnohB01M7Bs1uQ==
X-Google-Smtp-Source: AGHT+IGVgwtZuT5n1yLCy3naEBbVLy18MbG7apSBFGWvN1v0oK/7O76nvT/cyJFXGBsq5YyKTlWJHO2w0hOB+Mpnpg0=
X-Received: by 2002:aa7:c519:0:b0:564:5227:99b with SMTP id
 o25-20020aa7c519000000b005645227099bmr2795991edq.1.1708353209409; Mon, 19 Feb
 2024 06:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20240219141628.246823-1-iii@linux.ibm.com>
 <20240219141628.246823-4-iii@linux.ibm.com>
In-Reply-To: <20240219141628.246823-4-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 19 Feb 2024 07:33:27 -0700
Message-ID: <CANCZdfqFQ3QwmO50vUX0Lthx9+uGDS_Tt13zqEueZmky9H2z5A@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] {linux,bsd}-user: Update ts_tid after fork()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000032b50c0611bcfa47"
Received-SPF: none client-ip=2a00:1450:4864:20::52a;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000032b50c0611bcfa47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:22=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> Currently ts_tid contains the parent tid after fork(), which is not
> correct. So far it has not affected anything, but the upcoming
> follow-fork-mode child support relies on the correct value, so fix it.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Warner


> ---
>  bsd-user/main.c   | 1 +
>  linux-user/main.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index e5efb7b8458..72289673a94 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -127,6 +127,7 @@ void fork_end(int child)
>           * state, so we don't need to end_exclusive() here.
>           */
>          qemu_init_cpu_list();
> +        get_task_state(thread_cpu)->ts_tid =3D qemu_get_thread_id();
>          gdbserver_fork(thread_cpu);
>      } else {
>          mmap_fork_end(child);
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 74b2fbb3938..1d53f708354 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -160,6 +160,7 @@ void fork_end(int child)
>              }
>          }
>          qemu_init_cpu_list();
> +        get_task_state(thread_cpu)->ts_tid =3D qemu_get_thread_id();
>          gdbserver_fork(thread_cpu);
>      } else {
>          cpu_list_unlock();
> --
> 2.43.2
>
>

--00000000000032b50c0611bcfa47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 19, 2024 at 7:22=E2=80=AF=
AM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Currently ts_tid contains the parent tid after fork(), which is not<br>
correct. So far it has not affected anything, but the upcoming<br>
follow-fork-mode child support relies on the correct value, so fix it.<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br></blockquote><div><br></div><d=
iv>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdim=
p.com</a>&gt;</div><div><br></div><div>Warner</div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0| 1 +<br>
=C2=A0linux-user/main.c | 1 +<br>
=C2=A02 files changed, 2 insertions(+)<br>
<br>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index e5efb7b8458..72289673a94 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -127,6 +127,7 @@ void fork_end(int child)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * state, so we don&#39;t need to end_exc=
lusive() here.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init_cpu_list();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_task_state(thread_cpu)-&gt;ts_tid =3D qemu=
_get_thread_id();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdbserver_fork(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_fork_end(child);<br>
diff --git a/linux-user/main.c b/linux-user/main.c<br>
index 74b2fbb3938..1d53f708354 100644<br>
--- a/linux-user/main.c<br>
+++ b/linux-user/main.c<br>
@@ -160,6 +160,7 @@ void fork_end(int child)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init_cpu_list();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_task_state(thread_cpu)-&gt;ts_tid =3D qemu=
_get_thread_id();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdbserver_fork(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_list_unlock();<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div></div>

--00000000000032b50c0611bcfa47--

