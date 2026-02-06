Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052D1EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPgt-0002jk-Au; Fri, 06 Feb 2026 12:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPgp-0002jb-Kq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:32:19 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPgm-0002WS-06
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:32:17 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso2073856b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:32:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399134; cv=none;
 d=google.com; s=arc-20240605;
 b=GxaQgpeDqQ5xPzeJrB0W8OLShifm2w/ZHOe7zkZzE9+KYk3Eq2QXGJr859mlZTAiah
 7IOqs+IUnAzc9F5YHYTJ96fL0WLFpkK8kW+Y8hv8Zx2LIMz3CfAxliB/8iM6EAprYgJw
 GcMo4FOtADSx/lqhiA5XRmeRgeqE8hljwifoSZ7rcUinp6z7LkI/g7oHIzexnPOi8d1L
 aw4yH5HMUyg58MtAxgh/1aOeAwZKGxF6yI6IseFANCvsfiJfv7D2Beklm9MIfvN2Jdeu
 TtgoLnEiVRxl02Q4gTYGhIZsfFoINgokdbB50CRb+CH8gSTkiwYq0IFZF76hzJK4XOyZ
 nGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1l3+dd2gNp6aGqliK+roKmCjuMcyiZ6Ry0NFiNhmB1U=;
 fh=vX99oSypppU96q5NuBPJPnj1jnSm3PHdNBfQCXpkGWA=;
 b=Daik5vj1DwXt11of6MStnWcP13xYwp4Jh+FGVaNy/+ozg2KVPkQC5/3VKY87JuUkMp
 QEGYyElGH3r+y0uGk0YtstDyvkC5A85ImA4Ri2aC5ZvgBqdAGcGWBtd/0YiIegUrukZJ
 Gs/6fpvhfVsGxGl9kIu6Eb8EMrjlPqkYni63HsMULv2j9DHlx3wYDaShEEqlCcWB/8+6
 wuMlZDYyVu1FRj3/I+dANtlnvp0/38Eobql7yYcKwz3tXV22xnyxOXiJb7Q/Cvj/Ii4c
 UL7WQJRC8stobB0UjD/g/hfOslyE7DYR0g1plfWtwR7ZcG1OgbRPrIjpVFWtX4/m8Xmc
 rSdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770399134; x=1771003934;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1l3+dd2gNp6aGqliK+roKmCjuMcyiZ6Ry0NFiNhmB1U=;
 b=YDwoZka2z/h1CRdkEb90f1uT7WveZlJ3hbTTzHaCjFaC7kVb70lM2zKahFVWeLxJpA
 djWAqYSTpUB9AJjHpsFIHQmAOGvjl+XA00nPNWj7JyJvCGTNgzyd4Cl9WeZwb256v5j/
 4RJ6MmjRt96JG5gb5LPR8ZZS9ZuBToMMgEBlWvXUZlhzs9SgUdZeLxvdl1oYuV61I39S
 cpn8wd9ZEtYJyOoS9q2tSxlseZlrvcnBiTVzZ8fw3XzY1LfE8bQ70sf1G2p8fFO1yrIq
 Jlt7mfQyiR4fvwO2Nj/W3naVHUaWVrs1ng0EJ7AILHWB6ShAoWD1EHgMrol3/qgRJq4J
 SfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399134; x=1771003934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l3+dd2gNp6aGqliK+roKmCjuMcyiZ6Ry0NFiNhmB1U=;
 b=m9bac4yjF4x8L8l+uCNEMIBpssXL2/n2VO1VfFM2oh5yQX2CcQhXkxIhmCanN9nLYy
 2im+P3zYG2dzGkBiHoIWPypRy45RQcZqc4zIrwKM5M38/U2ra9UKMqprkmBi3yzwyTki
 hf9eDaAb9mBDDBSKxpC5iXgsOKrEvlFTdxCQZQt+vZ5DGHYRLojPVGL5ZJ0z2+90iFAB
 FGixVGuaD+pxbyGuTHcRHfdIX5J+VR39qRv6OpcLXy0o8h48z3KtINI9b/55Z+zzmZWd
 6RmSeLI422SQ7/AEEb+q85MqOjnMo014b8SfU7OY/t57305YL587T1MdtNPSEQLD5mRx
 Np+w==
X-Gm-Message-State: AOJu0Yzu8KdO6MsCqZkQfs23G3kuT+phrrYSCNv3514hqQ1b7gIxxtr5
 4yiQtYWnqCmcs+cd9bCIV9oeC+OnQ7GD9Zr3wKOCLLLQiQrA06xksr1HIXnsc3e3S13TU6t74mO
 C+Ii5Yx5/t6d/58eZplADDkEuGeQT0zrqGPxOMYjAgQ==
X-Gm-Gg: AZuq6aJrKT6OITh3NTmLZajf/jNWDUCvKFZmeWW21+fy4B0oMV3KkWiRxCxSqIR2yy8
 SUHSsVkMUEdW9ViPigMcVa77xLRk+JLcUMqZIGhbg0SiGiYKYKeUEbxSsTG87v1XaOD9Tk1MR4y
 +QbfjUySbEjgKYIfg3YKN6IesTjRQ1Uj7XQYxjrJiCHoTkOJzySiTndX9CA3dKLq8NI3NNZzTql
 esb0XDsei7adiCy4v5eqUAe05Y2piaI0LU/DDu8gMNsD9Oo2VK5Osfpg+zkA3cNt7rWTIY=
X-Received: by 2002:a05:6a20:4328:b0:393:625:ef20 with SMTP id
 adf61e73a8af0-393acfad4f2mr3735237637.4.1770399133962; Fri, 06 Feb 2026
 09:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-11-8d8ff0035372@bsdimp.com>
 <b5484b2f-34c0-45ce-9b5b-11a74986a16f@linaro.org>
In-Reply-To: <b5484b2f-34c0-45ce-9b5b-11a74986a16f@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:32:02 -0700
X-Gm-Features: AZwV_Qgn6Ni9LmgnvyakwyIh6evr46hzjFSvaxev4YylIxsYp5GM39sCffr_5kE
Message-ID: <CANCZdfpg8mmCstnBMX-sAi202rWwNbGF-+VP5H5R59uvZL08qA@mail.gmail.com>
Subject: Re: [PATCH 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>, 
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@freebsd.org>, 
 Mikael Urankar <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007d9fc7064a2b2b95"
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x436.google.com
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

--0000000000007d9fc7064a2b2b95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:45=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
> > format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
> > rather than directly accessing kernel-only members. Handles FreeBSD
> > 64-bit time_t except on i386.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
> > Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> > Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index f35f682aa4..e7031c5264 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -154,3 +154,36 @@ abi_long host_to_target_semid_ds(abi_ulong
> target_addr,
> >
> >       return 0;
> >   }
> > +
> > +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
> > +        abi_ulong target_addr)
> > +{
> > +    struct target_msqid_ds *target_md;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    memset(host_md, 0, sizeof(struct msqid_ds));
> > +    target_to_host_ipc_perm__locked(&host_md->msg_perm,
> > +                                    &target_md->msg_perm);
> > +
> > +    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in
> kernel. */
> > +    host_md->msg_cbytes =3D tswapal(target_md->msg_cbytes);
> > +    host_md->msg_qnum =3D tswapal(target_md->msg_qnum);
> > +    host_md->msg_qbytes =3D tswapal(target_md->msg_qbytes);
> > +    host_md->msg_lspid =3D tswapal(target_md->msg_lspid);
> > +    host_md->msg_lrpid =3D tswapal(target_md->msg_lrpid);
> > +#if defined(TARGET_I386)
> > +    host_md->msg_stime =3D tswap32(target_md->msg_stime);
> > +    host_md->msg_rtime =3D tswap32(target_md->msg_rtime);
> > +    host_md->msg_ctime =3D tswap32(target_md->msg_ctime);
> > +#else
> > +    host_md->msg_stime =3D tswap64(target_md->msg_stime);
> > +    host_md->msg_rtime =3D tswap64(target_md->msg_rtime);
> > +    host_md->msg_ctime =3D tswap64(target_md->msg_ctime);
> > +#endif
> > +    unlock_user_struct(target_md, target_addr, 0);
> > +
> > +    return 0;
> > +}
> >
>
> Use __get_user and you won't need the ifdef, since the size of the type i=
s
> then
> automatically handled.
>

Agreed.

Warner

--0000000000007d9fc7064a2b2b95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 7:45=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add target_to_host_msqid_ds() to convert target struct msqid_ds to hos=
t<br>
&gt; format for msgctl(2) IPC_SET operations. Uses memset to zero the struc=
t<br>
&gt; rather than directly accessing kernel-only members. Handles FreeBSD<br=
>
&gt; 64-bit time_t except on i386.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Brooks Davis &lt;<a href=3D"mailto:brooks@one-eyed-alie=
n.net" target=3D"_blank">brooks@one-eyed-alien.net</a>&gt;<br>
&gt; Signed-off-by: Sean Bruno &lt;sbruno@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mikael Urankar &lt;<a href=3D"mailto:mikael.urankar@gma=
il.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A01 file changed, 33 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index f35f682aa4..e7031c5264 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -154,3 +154,36 @@ abi_long host_to_target_semid_ds(abi_ulong target=
_addr,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_msqid_ds *target_md;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_md, target_ad=
dr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(host_md, 0, sizeof(struct msqid_ds));<br>
&gt; +=C2=A0 =C2=A0 target_to_host_ipc_perm__locked(&amp;host_md-&gt;msg_pe=
rm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;target_md-&gt=
;msg_perm);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* msg_first and msg_last are not used by IPC_SET/IPC_S=
TAT in kernel. */<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_cbytes =3D tswapal(target_md-&gt;msg_cb=
ytes);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_qnum =3D tswapal(target_md-&gt;msg_qnum=
);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_qbytes =3D tswapal(target_md-&gt;msg_qb=
ytes);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_lspid =3D tswapal(target_md-&gt;msg_lsp=
id);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_lrpid =3D tswapal(target_md-&gt;msg_lrp=
id);<br>
&gt; +#if defined(TARGET_I386)<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_stime =3D tswap32(target_md-&gt;msg_sti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_rtime =3D tswap32(target_md-&gt;msg_rti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_ctime =3D tswap32(target_md-&gt;msg_cti=
me);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_stime =3D tswap64(target_md-&gt;msg_sti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_rtime =3D tswap64(target_md-&gt;msg_rti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_md-&gt;msg_ctime =3D tswap64(target_md-&gt;msg_cti=
me);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_md, target_addr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
Use __get_user and you won&#39;t need the ifdef, since the size of the type=
 is then <br>
automatically handled.<br></blockquote><div><br></div><div>Agreed.</div><di=
v><br></div><div>Warner=C2=A0</div></div></div>

--0000000000007d9fc7064a2b2b95--

