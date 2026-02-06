Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37574ECD9B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voA9T-0002sM-9m; Thu, 05 Feb 2026 19:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voA9R-0002qk-1u
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:56:49 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voA9O-0003FL-QP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:56:48 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a8ff2ca490so8016325ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 16:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770339400; cv=none;
 d=google.com; s=arc-20240605;
 b=dljrITPzXzkv01Vmaa1fMEbRrVcqBKb9e2PKhcT40vg0zCpVYKhxsYMVIp9ZFH54Cz
 5rEkliA/gYxybjeONrMKjrxtRN7gI13qfnIppOaOr14Wy80Gj1n7X53sGCxTu5cVrcme
 1lYTK/zFun6unVJ6/JaENwSXJ42xWr0PjhbzEOmvfK/1/Maiq47dzWBHewllITGzSkWI
 R5SWmUzZJLmsN+SXHiacY2Ix3+wOB7Dv022yqzLBB/nWKrGZUpmISCtaDtWwyDVBabTV
 sjWynVjb8Ypz8zlI6bJ/lVVpfWJ11IwahGWJ4nnoeYRgIJHmZvQ2PP2Jkeh3kOngqq5I
 T1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qgob1d9+8Sg2LXR53DXvH1KFyDaIOJNZFhDePWO7iso=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=C7JkyCmjQ1KeFYq5qOWS9Ke+8kGsRgJVYbJMabs8HYi/zZn8zxxf/6c0JGTkQiE+Dx
 fLKP3hpb8Y9QxrXinqSY4hpkCRz/idbqz/Zyy9LBIy59JvpPqcb3Yhaa9N2bBPMYdLAP
 Me57Dm6DtFVF3gSDhnE+lyIvSUTcxf+42c4YT29cUzaDiCRzXPor+sD2dcTo/wXN9GV2
 ucfHVnMzmombEsoXXU34zkffaankHo34fdTg9F78AwMx+QWqSk18Yl9IpDaHhzoWvivO
 +CqE6fZLK0gAwnuAnIVaP/EazYTA8wyH98u/dv1NcS5w3HWrBA9pL5dHhpTrbxi02I+a
 w5uA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770339400; x=1770944200;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qgob1d9+8Sg2LXR53DXvH1KFyDaIOJNZFhDePWO7iso=;
 b=rUcgntZ7c8HmGx43oLFirN4E7BIDMk7QHNP024XcCFw97RKvb4T9SoTkhEb/nBnnn5
 Y8PhjMuzuiR8TASetM+76Zw4ieyP6Mlga/OjBAJ1ukGROmUf7ixovFUf09A/rgT6yRFa
 WMP80apBgfYJ/hUm5W/A+4eWukowAgvn7Ce+ZiAM/wyV6yWvcZOQqc7jPqZpeZHGLmHz
 2Cu1IZXzKZ6Lg4TbyYaaHlSF3idViFfwfU/NPuOWGuurdEJciKQjnQJg+kONwDOIKTKP
 4uL0294MwMMvB9lV//QC6cf83yNqCuiy942/8Z/xRffsPLLFCyGiqWm6Ypn4DRP6W50g
 UEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770339400; x=1770944200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgob1d9+8Sg2LXR53DXvH1KFyDaIOJNZFhDePWO7iso=;
 b=AABEH5I3+c7+5JLVda3hZGC+Rhjlaw1sh+YgPhtvMz87SN2095CZbcCbwMBMtuk2O0
 Hhni2srGkEwcwsH+Wlq/Ujx1uXXnsvDQ0KjAmNcmjXHrFb9RIF3+54ZxRprQnaDEagRm
 MTuK29lwSSn44+zWr51Ejgzme1z03jDp/MtU0JCbLQwMhVEQty89+v5h91Q6w94OMK0B
 h4yzRsOT/tlenkcQbAOZ5FqlydRlYjnfdEN8dvYoMKsJJVy0ZS+mAu+IEgQVF4H+hgFh
 X0ao9yT+dNF45dog330hE+0/084mm8tsOacihAShZByw09WF1SFlzFt6v0+9wJUHpCY1
 JIZg==
X-Gm-Message-State: AOJu0YxKfUMnAXHmWCLylTE8REp+XM6pznWu3P122WeONEKbKzQfeUBt
 44Lxo4aCxpeU/ks1S5mDXlGyycb9DmNi6XBdrP7zTtpy8r8zcdIxlhTSAl69EJXs8GOVE4fp7rq
 qObvh9vyevjragvxIvcRhA7Jbe2KOJXji7TcxfidNAA==
X-Gm-Gg: AZuq6aJcJ+q6ccnM3r47N5bXS1/4Cv+ns40frEycZA1kfN8jvIVww/XtMh6ptthnX+Q
 Vkbs+MuNMNx88g1bymjNKuqTJ3U8M1csvVf4vHh4jKU16rYPcM+83wTqblm4sRueaMB6IVmllnV
 3mpNqsOl8p9BHysKss6Wl7PQ8j78NJGW//4DrgAsWOQsMDMMajyJTC+azjcKzgoXXnXKj9qgRFH
 P8kQN7OGGJKxx632jERtOXl4qjv1b/z/wsBofnRcRp/5C6oG5om+yLJL8svnzibzZp8XhE=
X-Received: by 2002:a17:903:3c4d:b0:2a9:327f:a8ff with SMTP id
 d9443c01a7336-2a9516fb4abmr8502085ad.33.1770339400563; Thu, 05 Feb 2026
 16:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-5-8d8ff0035372@bsdimp.com>
 <a688dd34-a37e-46f1-8739-e01105ee4dc8@linaro.org>
In-Reply-To: <a688dd34-a37e-46f1-8739-e01105ee4dc8@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 17:56:29 -0700
X-Gm-Features: AZwV_Qg-XD2ocd6t0lr7vP2ckCnmPwnv2TiugoMRH-43XwH5J2AvYOKyqiANE-s
Message-ID: <CANCZdfrXi1CeHh0XrG0mY2C-dbukQ5evM1YA+gj3M3QxCj-38Q@mail.gmail.com>
Subject: Re: [PATCH 05/24] bsd-user: Add function declarations for bsd-misc.c
 conversions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000001a4e71064a1d43a3"
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x632.google.com
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

--0000000000001a4e71064a1d43a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:17=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > Add function declarations for BSD System V IPC and UUID conversion
> > routines that will be implemented in bsd-misc.c.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/qemu-bsd.h | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> > index 56affcd31d..b98d1d76b2 100644
> > --- a/bsd-user/qemu-bsd.h
> > +++ b/bsd-user/qemu-bsd.h
> > @@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds
> *host_sd,
> >   abi_long host_to_target_shmid_ds(abi_ulong target_addr,
> >           struct shmid_ds *host_sd);
> >
> > +/* bsd-misc.c */
> > +abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid
> *host_uuid);
> > +abi_long target_to_host_semarray(int semid, unsigned short **host_arra=
y,
> > +        abi_ulong target_addr);
> > +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> > +        unsigned short **host_array);
> > +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
> > +        abi_ulong target_addr);
> > +abi_long host_to_target_semid_ds(abi_ulong target_addr,
> > +        struct semid_ds *host_sd);
> > +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
> > +        abi_ulong target_addr);
> > +abi_long host_to_target_msqid_ds(abi_ulong target_addr,
> > +        struct msqid_ds *host_md);
> > +
> >   #endif /* QEMU_BSD_H */
> >
>
> Normally, the declarations should be added with the definition. But I
> won't insist that
> you split this into the 6 following patches that add the definitions.
>

Thanks! I'll adjust for the subsequent patch chains. I still have huge
diffs:

 131 files changed, 5141 insertions(+), 587 deletions(-)

But it was down from a high of I think 13k.


> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>

--0000000000001a4e71064a1d43a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 5:17=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; Add function declarations for BSD System V IPC and UUID conversion<br>
&gt; routines that will be implemented in bsd-misc.c.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/qemu-bsd.h | 15 +++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 15 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h<br>
&gt; index 56affcd31d..b98d1d76b2 100644<br>
&gt; --- a/bsd-user/qemu-bsd.h<br>
&gt; +++ b/bsd-user/qemu-bsd.h<br>
&gt; @@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *h=
ost_sd,<br>
&gt;=C2=A0 =C2=A0abi_long host_to_target_shmid_ds(abi_ulong target_addr,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct shmid_ds *host_sd);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* bsd-misc.c */<br>
&gt; +abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host=
_uuid);<br>
&gt; +abi_long target_to_host_semarray(int semid, unsigned short **host_arr=
ay,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr);<br>
&gt; +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short **host_array);<br>
&gt; +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr);<br>
&gt; +abi_long host_to_target_semid_ds(abi_ulong target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct semid_ds *host_sd);<br>
&gt; +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr);<br>
&gt; +abi_long host_to_target_msqid_ds(abi_ulong target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct msqid_ds *host_md);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_BSD_H */<br>
&gt; <br>
<br>
Normally, the declarations should be added with the definition. But I won&#=
39;t insist that <br>
you split this into the 6 following patches that add the definitions.<br></=
blockquote><div><br></div><div>Thanks! I&#39;ll adjust for the subsequent p=
atch chains. I still have huge diffs:</div><div><br></div><div>=C2=A0131 fi=
les changed, 5141 insertions(+), 587 deletions(-)</div><div><br></div><div>=
But it was down from a high of I think 13k.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000001a4e71064a1d43a3--

