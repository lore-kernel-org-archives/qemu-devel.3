Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3335EF06E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpITS-0006yR-38; Sun, 08 Feb 2026 23:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpITQ-0006yC-Vu
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:02:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpITP-0008A0-BC
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:02:08 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a79ded11a2so26577645ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770609726; cv=none;
 d=google.com; s=arc-20240605;
 b=LeI2ZVJXXUJkFCftxV7cpyyUZ85XJevPPM/gG6dRIZdh0MUXalmeujFH1fJEcpRpC4
 4iND56RgCIyd6J1AWk1oj9blnVdgSDnr9kGZwLvz7OoiF2Nco7Cnf2oc+zWg+L4QABVy
 HeBCJHoVTIwLESc4H7/ds4CeG7GWAsdcEOAlCHNNsgnsfF0axkTh4mhsoC98s7RaaSid
 kNtyNKoOtsA7PmlRYGLsy3RIYkimjfgjQBN5xfANGmGwThueQ40vjr8aH1C7KlQ+OQL2
 wLnCmwHyzxozMDJfRvASs1SuoSwLIX10RlTpdTAegR6yCL43Wcj6Posgu56r7ZYtOpYB
 8Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QQe2eeXVC45RLoDKu/i8rDVlk3oJGCXaVEB28RGsr34=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=WUDJBStTaf7EBxZ1N5FFzUDtwi4CrXARKf0+LPqviP+MpoinJuTH5DhmB6Y+X2EECM
 Xk+motxzspYPyVigS9Ffp2Pc7w8mVMO+h9Q083L+4j4bwPbFNXc6eiLaVZsTnayc52am
 ImtetY9KjlH66gLrknH2vp07c39FTgVpKA7U8/JqQ75EjnF9nRwxGv+7qOi6VBy5mXZj
 lFitwGKJlaU8ZdZ0kfTMF2fQSIBHnddh8PupzN1zIPgSwj6ttMpJw94olz95k40j8lcW
 0YSoRkKzUmzpBT8lkU+jSj1zqRHx2vqlBZVN0g/YeIdlXXu09J1vRZr/XVJcJ9KTpEu+
 RICQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770609726; x=1771214526;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QQe2eeXVC45RLoDKu/i8rDVlk3oJGCXaVEB28RGsr34=;
 b=J60wDuhz5GRhsYbgSOGs69kFuTzJ53rCo0zuResB4bb5ROBF9dPF6I3zk88nKJeqam
 Z78RVcrOETOKddDCh2ya+0DXAUaDbeBD+ASncDHDlLD3EbQnvKXWnrcnZqgmbpNqo3C9
 j0E2uKM2ImZFukEZQ5+o/K4r/X51UyTB6lNWQs2PZcl4QG5WBkuiYg/uAgT7AZkkZzqn
 Caol9ksqIkp7DCEaUhKbCAYEZLQU7/nJgntfvARXUKWNKs39WNVKHEON//dVDGT6/xUA
 AgLfufZFPNbop7y8ogj/AUkv7jVvXoWE3zM/zyBPP2StZyP8RY5Biw95Ts44cnwGHnGu
 25DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770609726; x=1771214526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQe2eeXVC45RLoDKu/i8rDVlk3oJGCXaVEB28RGsr34=;
 b=lmDcdGX2SLdbk+Ye3+TuyInpUrFC/ms9W+p6q1C4ZYnZOarFcMTHgXqk6pnV4OaDXN
 yNMQMg8uUkSaBz36eI11j76/XzRAU1BsYgjmSZtWPI4RGCknDyBWqLUiWaAlyzNri4QX
 V9unzPKnSZVyvbRnZpEfkF0+vlVmDqvAwwdZENGy3gwZ1mrOnENiTjPoNRl1UkfXSAUE
 wfQqEfqFKmj95xhDT/e+LOl8DaBj+3xgtEji2vieox71NkqXlHnOvzqeaSKLvvtDePY6
 rqBd63ccM4lvAKGk77OejFQAu7SOBm9II7Wi9XVSgxC2kyMILniMcLySx3TCNuP/uVot
 XHmA==
X-Gm-Message-State: AOJu0YxxsVmY1B/udY9SyK9WPXbje1VOcOQ3fqV4Y+pPpE7YoTVDRHgB
 MYyo3PLfgRwoYVUUZ/pyGx3RP8HNmugL4Xr7IXnHCeYq5Gt3i8uZa8pcgndruk0II74l1cXsxT1
 Du1yjKjfbigPLmtvooBQQ2inqFFrpvU0j6JKAOzWKmV0h3WilAp2GsJg=
X-Gm-Gg: AZuq6aKgiZD6KaAucMJjkUIIrMsVvyay+KAoEDUnzMSZhqZLiXH8xAlzK951G+uE2vR
 3LZZzQfoni43QfgO1WCzmC6dKB4v2+uu8v0dvB3WhyWQIpbKDm3aLRtlqjpFELNZvKh7LJl8f0g
 396WwStnZnd4f7B2pUHNF0L2maLwcNRB1YFhtUzEkHLelPaX4b+jLc/Ek/3rChdrb2UhWyNKj2P
 OoUL7pfsg+H3ay0hx/ny1WtNuyzy6bJn8DGw/fC5TnwDsa/495+5tWCEJ/4Fz1l9eNPhDU=
X-Received: by 2002:a17:903:228e:b0:2a2:d2e8:9f25 with SMTP id
 d9443c01a7336-2a9516d582cmr92079625ad.33.1770609725664; Sun, 08 Feb 2026
 20:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-8-58e5fcfdb84f@bsdimp.com>
 <1ab8eb64-c546-4faa-a0b7-09a30c40b2f2@linaro.org>
In-Reply-To: <1ab8eb64-c546-4faa-a0b7-09a30c40b2f2@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 8 Feb 2026 21:01:54 -0700
X-Gm-Features: AZwV_Qj4bAWA84DZ5HPsl-7kt8SOrUx_ZsXx88Mn6_bm7VOBvPbkTiMLXaA_xS0
Message-ID: <CANCZdfq7Sr9K3TR_pj9QYEKmMDbLj+mMGteW24weR933pw+Z5w@mail.gmail.com>
Subject: Re: [PATCH v2 08/24] bsd-user: Add host_to_target_semarray for
 semaphore operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bc0026064a5c3355"
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

--000000000000bc0026064a5c3355
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 6:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/9/26 05:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add host_to_target_semarray() to convert host semaphore array to target
> > format for semctl(2) GETALL operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index d9eb87db80..677cb49d27 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -79,3 +79,36 @@ abi_long target_to_host_semarray(int semid, unsigned
> short **host_array,
> >
> >       return 0;
> >   }
> > +
> > +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> > +        unsigned short **host_arrayp)
> > +{
> > +    g_autofree unsigned short *host_array =3D *host_arrayp;
>
> Good, but...
>
> > +    abi_long ret;
> > +    int nsems, i;
> > +    unsigned short *array;
> > +    union semun semun;
> > +    struct semid_ds semid_ds;
> > +
> > +    semun.buf =3D &semid_ds;
> > +
> > +    ret =3D semctl(semid, 0, IPC_STAT, semun);
> > +    if (ret =3D=3D -1) {
> > +        free(host_array);
> > +        return get_errno(ret);
> > +    }
> > +
> > +    nsems =3D semid_ds.sem_nsems;
> > +    array =3D (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
> > +        nsems * sizeof(unsigned short), 0);
> > +    if (array =3D=3D NULL) {
> > +        free(host_array);
>
> forgot to remove the explict free.
>
> > +        return -TARGET_EFAULT;
> > +    }
> > +    for (i =3D 0; i < nsems; i++) {
> > +        __put_user(array[i], host_array + i);
> > +    }
> > +    free(host_array);
>
> again.
>

Doh! Thanks!


> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
> > +    unlock_user(array, target_addr, 1);
> > +    return 0;
> > +}
> >
>
>
>

--000000000000bc0026064a5c3355
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 8, =
2026 at 6:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/9/26 05:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add host_to_target_semarray() to convert host semaphore array to targe=
t<br>
&gt; format for semctl(2) GETALL operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A01 file changed, 33 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index d9eb87db80..677cb49d27 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -79,3 +79,36 @@ abi_long target_to_host_semarray(int semid, unsigne=
d short **host_array,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short **host_arrayp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autofree unsigned short *host_array =3D *host_arrayp;=
<br>
<br>
Good, but...<br>
<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int nsems, i;<br>
&gt; +=C2=A0 =C2=A0 unsigned short *array;<br>
&gt; +=C2=A0 =C2=A0 union semun semun;<br>
&gt; +=C2=A0 =C2=A0 struct semid_ds semid_ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 semun.buf =3D &amp;semid_ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D semctl(semid, 0, IPC_STAT, semun);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(host_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno(ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nsems =3D semid_ds.sem_nsems;<br>
&gt; +=C2=A0 =C2=A0 array =3D (unsigned short *)lock_user(VERIFY_WRITE, tar=
get_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nsems * sizeof(unsigned short), 0);<br>
&gt; +=C2=A0 =C2=A0 if (array =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(host_array);<br>
<br>
forgot to remove the explict free.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nsems; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(array[i], host_array + i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 free(host_array);<br>
<br>
again.<br></blockquote><div><br></div><div>Doh! Thanks!</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
&gt; +=C2=A0 =C2=A0 unlock_user(array, target_addr, 1);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
<br>
</blockquote></div></div>

--000000000000bc0026064a5c3355--

