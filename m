Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBDBFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 02:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIGvO-0005LY-6k; Wed, 29 Apr 2026 22:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIGvL-0005LG-2X
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 22:14:43 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIGvH-0003za-Vy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 22:14:42 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so304103d50.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 19:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777515277; cv=none;
 d=google.com; s=arc-20240605;
 b=FZx+frflPt2iAKFFlYFcdJoDaSw4anNJ7ewjKrWjIkKg0kgQ98UQTYYRrKt13DB7/7
 MU2tis44Sehclj5RBHo5iJ5CpRfE41D+qUhxU8wsW++p8LcondlGvG/pdG0D9wKEEKIZ
 cvHUe4LyLgfexMiKQiLeaK1Ik6GC4IVh8upzzlhlqRYcvm2eWnSrwmeIh4NvMMzFo1G8
 izHGQ8ifqYmvGYWUd10jMnO7Ry3T5LLvjxyJupM4TCwh9dI5iChb2UxdSB8YwL+zAfPQ
 8rgZ0QnJnoz4GFyfiKrYRpRQJ1yOM67XXk3bTOpWQhubykRAXERkEUbxKzlE1veuWqFT
 R5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h4+mw3m3+xY7GlRwTWRMkoAc4UV19c9LhqEZF6VUHuc=;
 fh=R8QHSoPiV92CH5FxJunRiZO94+70Q2XBiJecrFIDc9s=;
 b=ALnzRNOx0orwzILrQx4dxZZVDSFkwtt8sylJDobV4D06KvoRgWAXfMSopxqXi6iSBz
 JN+IHoBrG+DV01Obuus2L4aCK4QH3hqbon2tygT9GtWm2v+C1T3iWMKTW1MKCO4UaNDH
 qpeGFPFQ/VwMrX7w3H7hmMDq6trKC6fbx0bKe79YYFtQ1+jv4XhmoTX85QTSof4tgJGf
 JA+xYK1ImMBR9v8zfEjMUs1nvECByfKD9MSKz3HyN+/Fygfc5/8skZAiG4PcstaZfdSu
 /3ojQdJZyycopjAl06iPMVcBljQAtCdCL1ZkznCdjaRnrqnx0rhhvREx2qYroM+SIOqY
 qSEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777515277; x=1778120077;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4+mw3m3+xY7GlRwTWRMkoAc4UV19c9LhqEZF6VUHuc=;
 b=k/p8p4SjP8nYzW5swR3dzu0eOF5KUoLY/ZvOy34Uvajew2yZOLcexJlMn6FD5GbePH
 4ncZAYI9jtzFcvWVJUzcYzITBKTAOzWU6qbbvceGgFZBY8YeQ88Ox2QAy+Mz1+V4yNID
 faJjZfDyMyWEdPH/nGEl7HukEMALnYM6Xv1E/G/5Wu7Br7h1aJ/OT1OIr96Mon2kmb2R
 upGag7VKhGuUpdQ+lv+mojlGMh6rwuUYBqsjuKgiXeuZ5AWpqLS5pj/OV88muoQwV+r2
 Y5oUqphmN2Q2I4ljdLObhHVz9IyZcXSIlpJkNo/y5DRX7kvLOW0OfPZyNW1VaGNN+ft5
 jCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777515277; x=1778120077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4+mw3m3+xY7GlRwTWRMkoAc4UV19c9LhqEZF6VUHuc=;
 b=sK5Pg9qG19AGuR7xFnpWsKffTtrAzDE3uXCctQQEVQSTLdLxcOL7Vbhnj5YAKirAHF
 i66mdiGAthDy/ByS3yH0TQtA45JpKRfb8Yql88taK7AgDJWcNaZkWw2XWfZ2qvrURtwG
 zMDXg3XrVRYM83KLb9obIBJTAttRzl0EeQ+Cw0Tle/KnkZXt/HQAwHXh5VfX564I9iMx
 U08cEmxhJinCfz02iprJaR26hUaTMOSv98RuH9YtjD2KF/Uc7entRXZ0mvk4/6SUBYzY
 uP1k5cKoYeV7SEyoJVGDPlU4ncq6p7ZQisRxdlke5jMyvC4PPqjBh0GmoW/fNXlYqxLN
 k7Bw==
X-Gm-Message-State: AOJu0YzKSvpwM2c+y4GDrtIJSZzfpx0ljJnSGJkxmRz0i/auGJbBjsXR
 QlhSbbpc+FYKdqcX4hIaftTs8FZ0W1itROGgG8EZp5mWjn1HuKN4X26zrL6r+aHNniVXKjoG7fA
 Zp2ExNeRWqbhYXkW6OwgqZ0ubL/FQhrjSIHkxK2qfMg==
X-Gm-Gg: AeBDieso256M5907q/XgPHa5VHHqllH415nfZdFVThgcwFCJ6FEn5aydSLRRHpder3m
 74Y+mkfMx8HHmYt5xjcftZkwSb9dJwOHrMuSr3qZz78z2nDbLVIbVbUPKMGqMhGLEJLmCTMZc3p
 HPk4dkGztP89d1KQpatCWjVIuorqRalNJSjpayV2LPgASjUWGBRIIKjkvB8r13nBWGMVSojEoqq
 oVTyS1a+c0zl6ZwwA/3W4sQ/xpcenw61A7X3LuMQTP0B6fu+USOxUiB8dHLX71MkbeVIpSJjDDR
 ckSffuXv9vQSVbq2Ublis1xV/1id
X-Received: by 2002:a05:690e:1912:b0:652:dd57:af1f with SMTP id
 956f58d0204a3-65c18fdbe9amr606975d50.61.1777515276970; Wed, 29 Apr 2026
 19:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
In-Reply-To: <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 20:14:25 -0600
X-Gm-Features: AVHnY4IcoAjwPI-hreAsJJh9gpncW9pfe4tdEnfiOxxQzGw_HO2hA5D8YUDt9Sc
Message-ID: <CANCZdfqBzFG4=h6GXd-a_g_xZW0LgRAf_j9CBn7HWScxfeKDAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] bsd-user: upstream ioctl
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@freebsd.org>,
 Sean Bruno <sbruno@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000aabd5a0650a40616"
Received-SPF: none client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb12f.google.com
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

--000000000000aabd5a0650a40616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 4:52=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 4/29/2026 7:45 AM, Warner Losh wrote:
> > Again with the help of claude, harvest the ioctl changes from
> > bsd-user blitz branch. These are a bit messy, since ioctls tend
> > to be a bit messy. Ideally, all this would be generated, but
> > that code isn't ready yet, so we go with what we have.
> >
> > Please note: All style complaints are false positives. The > 80
> > character ones are fine: these files are semi-generated from upstream
> > and fixing them makes syncing harder. Harder syncing in code that's
> > basically boilerplate is worse than lines that are too long for
> > definitions people are never going to read.
> >
> > The two errors:
> > =E2=97=8F b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and te=
rmios
> conversion
> >   =E2=97=8F checkpatch.pl: 197: ERROR: Macros with complex values shoul=
d be
> enclosed in parenthesis
> >   =E2=97=8F checkpatch.pl: 198: ERROR: Macros with complex values shoul=
d be
> enclosed in parenthesis
> > are impossible to fix: they are what they need to be for the macro
> > tricks that are being used. One cannot add parenthesis and have correct
> > code.
> >
> > This is largerly unchanged from v1, which didn't get any reviews.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > Changes in v2:
> > - rebase forward, minor tweaks for blitz branch evolution
> > - Link to v1:
> https://lore.kernel.org/qemu-devel/20260412-ioctl-v1-0-1d998a460560@bsdim=
p.com
> >
> > ---
> > Stacey D. Son (10):
> >       bsd-user: Add FreeBSD tty ioctl definitions
> >       bsd-user: Add FreeBSD file I/O ioctl definitions
> >       bsd-user: Add FreeBSD socket ioctl definitions
> >       bsd-user: Add FreeBSD cryptodev ioctl definitions
> >       bsd-user: Add FreeBSD disk ioctl definitions
> >       bsd-user: Add FreeBSD IPv6 ioctl definitions
> >       bsd-user: Add FreeBSD ioctl type definitions
> >       bsd-user: Add FreeBSD ioctl command table
> >       bsd-user: Add bsd-ioctl.h header
> >       bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
> >
> > Warner Losh (7):
> >       bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
> >       bsd-user: Add log_unsupported_ioctl function
> >       bsd-user: Add do_ioctl_unsupported function
> >       bsd-user: Add target_to_host_sockaddr_in6 function
> >       bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
> >       bsd-user: Add do_bsd_ioctl main function
> >       bsd-user: Add init_bsd_ioctl function
> >
> >  bsd-user/bsd-ioctl.c                  | 438
> ++++++++++++++++++++++++++++++++++
> >  bsd-user/bsd-ioctl.h                  |  14 ++
> >  bsd-user/freebsd/os-ioctl-cmds.h      | 151 ++++++++++++
> >  bsd-user/freebsd/os-ioctl-cryptodev.h |  74 ++++++
> >  bsd-user/freebsd/os-ioctl-disk.h      |  41 ++++
> >  bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
> >  bsd-user/freebsd/os-ioctl-in6_var.h   | 217 +++++++++++++++++
> >  bsd-user/freebsd/os-ioctl-sockio.h    | 240 +++++++++++++++++++
> >  bsd-user/freebsd/os-ioctl-ttycom.h    | 237 ++++++++++++++++++
> >  bsd-user/freebsd/os-ioctl-types.h     | 104 ++++++++
> >  bsd-user/syscall_defs.h               |  10 +
> >  11 files changed, 1560 insertions(+)
> > ---
> > base-commit: becd22fdc2a071783d9e04421526633772b3b98c
> > change-id: 20260411-ioctl-68c80a77ad32
> > prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
> > prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b
> >
> > Best regards,
>
> Hi Warner,
>
> a few checkpatch warnings:
> https://github.com/p-b-o/qemu-ci/actions/runs/25116258138/job/73604077805


There's two sets of warnings. The thunk.c warnings are irrelevant: thunk.c
is
a verbaitm copy of linux-user/thunk.c since that was how I was told to
share it.
It shows up in the CI as the first commit, but it's an already reviewed
patch. Those
won't be fixed because it's inefficnet to reformat code I'm verbatim
copying.
The inclusion of this patch is the series is an artifact of b4 and having
this
series be based on that prior series I've not put into a pull request yet.

The other warnings are documented in this message and are false positives.
The macros can't be written in any way other than how they are written.

Warner


>
> Regards,
> Pierrick
>

--000000000000aabd5a0650a40616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29,=
 2026 at 4:52=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/29/2026 7:45 =
AM, Warner Losh wrote:<br>
&gt; Again with the help of claude, harvest the ioctl changes from<br>
&gt; bsd-user blitz branch. These are a bit messy, since ioctls tend<br>
&gt; to be a bit messy. Ideally, all this would be generated, but<br>
&gt; that code isn&#39;t ready yet, so we go with what we have.<br>
&gt; <br>
&gt; Please note: All style complaints are false positives. The &gt; 80<br>
&gt; character ones are fine: these files are semi-generated from upstream<=
br>
&gt; and fixing them makes syncing harder. Harder syncing in code that&#39;=
s<br>
&gt; basically boilerplate is worse than lines that are too long for<br>
&gt; definitions people are never going to read.<br>
&gt; <br>
&gt; The two errors:<br>
&gt; =E2=97=8F b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and t=
ermios conversion<br>
&gt;=C2=A0 =C2=A0=E2=97=8F <a href=3D"http://checkpatch.pl" rel=3D"noreferr=
er" target=3D"_blank">checkpatch.pl</a>: 197: ERROR: Macros with complex va=
lues should be enclosed in parenthesis<br>
&gt;=C2=A0 =C2=A0=E2=97=8F <a href=3D"http://checkpatch.pl" rel=3D"noreferr=
er" target=3D"_blank">checkpatch.pl</a>: 198: ERROR: Macros with complex va=
lues should be enclosed in parenthesis<br>
&gt; are impossible to fix: they are what they need to be for the macro<br>
&gt; tricks that are being used. One cannot add parenthesis and have correc=
t<br>
&gt; code.<br>
&gt; <br>
&gt; This is largerly unchanged from v1, which didn&#39;t get any reviews.<=
br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - rebase forward, minor tweaks for blitz branch evolution<br>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260412-i=
octl-v1-0-1d998a460560@bsdimp.com" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20260412-ioctl-v1-0-1d998a460560@bsdimp.com=
</a><br>
&gt; <br>
&gt; ---<br>
&gt; Stacey D. Son (10):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD tty ioctl definitions<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD file I/O ioctl definit=
ions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD socket ioctl definitio=
ns<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD cryptodev ioctl defini=
tions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD disk ioctl definitions=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD IPv6 ioctl definitions=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD ioctl type definitions=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD ioctl command table<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-ioctl.h header<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add target_sockaddr and safe_ioctl=
 to syscall_defs.h<br>
&gt; <br>
&gt; Warner Losh (7):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-ioctl.c infrastructure and=
 termios conversion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add log_unsupported_ioctl function=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_ioctl_unsupported function<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add target_to_host_sockaddr_in6 fu=
nction<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_ioctl_in6_ifreq_sockaddr_in=
t function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_bsd_ioctl main function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add init_bsd_ioctl function<br>
&gt; <br>
&gt;=C2=A0 bsd-user/bsd-ioctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 438 ++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 bsd-user/bsd-ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 ++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-cmds.h=C2=A0 =C2=A0 =C2=A0 | 151 +++++=
+++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-cryptodev.h |=C2=A0 74 ++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-disk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 41 =
++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-filio.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 34 =
+++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-in6_var.h=C2=A0 =C2=A0| 217 ++++++++++=
+++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-sockio.h=C2=A0 =C2=A0 | 240 ++++++++++=
+++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-ttycom.h=C2=A0 =C2=A0 | 237 ++++++++++=
++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-ioctl-types.h=C2=A0 =C2=A0 =C2=A0| 104 +++++=
+++<br>
&gt;=C2=A0 bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 10 +<br>
&gt;=C2=A0 11 files changed, 1560 insertions(+)<br>
&gt; ---<br>
&gt; base-commit: becd22fdc2a071783d9e04421526633772b3b98c<br>
&gt; change-id: 20260411-ioctl-68c80a77ad32<br>
&gt; prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2<br>
&gt; prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b<br>
&gt; <br>
&gt; Best regards,<br>
<br>
Hi Warner,<br>
<br>
a few checkpatch warnings:<br>
<a href=3D"https://github.com/p-b-o/qemu-ci/actions/runs/25116258138/job/73=
604077805" rel=3D"noreferrer" target=3D"_blank">https://github.com/p-b-o/qe=
mu-ci/actions/runs/25116258138/job/73604077805</a></blockquote><div><br></d=
iv><div>There&#39;s two sets of warnings. The thunk.c warnings are irreleva=
nt: thunk.c is</div><div>a verbaitm copy of linux-user/thunk.c since that w=
as how I was told to share it.</div><div>It shows up in the CI as the first=
 commit, but it&#39;s an already reviewed patch. Those</div><div>won&#39;t =
be fixed because it&#39;s inefficnet to reformat code I&#39;m verbatim copy=
ing.</div><div>The inclusion of this patch is the series is=C2=A0an artifac=
t of b4 and having this</div><div>series be based on that prior series I&#3=
9;ve not put into a pull request yet.</div><div><br></div><div>The other wa=
rnings are documented in this message and are false positives.</div><div>Th=
e macros can&#39;t be written in any way other than how they are written.</=
div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--000000000000aabd5a0650a40616--

