Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A62ECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBXk-0007Dv-72; Thu, 05 Feb 2026 21:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voBXi-0007Cs-Hy
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:25:58 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voBXg-0000am-DX
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:25:58 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-354a2a7d90fso823900a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:25:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770344754; cv=none;
 d=google.com; s=arc-20240605;
 b=luixO0SOO9in7SNUBYLV+38RcgfB4fOK5NlmIOHB+2THg0kbUuntjE/sAOULz1mEkI
 hnDmfpo0TTXXkTXPUG7HLmS/YtdJfTwgruTIIcYlFsLtIAT+EGb/LkYx3P39KBRVKh/d
 iUgcP4J/6417SPonsgXSTNUElQI+WwxJdNGWaC5Oh+13oWpEVtg6TEqj8ha28Vo7D2rs
 kWqmldw8g2huz1IQqaBqEAKMIKW+dey/SYArJLqWjEK7aR5AvSjX311EEvCSz+XhSF6T
 QlHGCyzt18tOtvI6JJCh/ubM9ThrFhDk7OcrWIz80x9x4N1ggOFV0kAS3xSQTr2XTLx+
 oJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k27QD3WlP3QwcmZNZV4hw70i/PEgZN756LcFyVppqvg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Sasw+ro+mDRK4Rn3CxMlJmigG9kOC2DCH+SVOlt7/b9VKFdwG89L5dQkuvDNCGj+ZA
 UqCkgvuja9NDmMB6HbBHHbZwkkT1cLlXcIEJJGzPBcgoSAk59qexLmxSayzYnCMWVd7b
 Qoj7Evsvi8s7egNCdw9rWsfpglhMZjyxk4kuhDZ4cMMfTMhKN/pxDX8lCrBLDMm8OLeN
 QmYzKoHoPaYX8rVxxUUSs4rPCjNiuoNrRZw3N/Alax3P6O6fnVjw39x+sA1KdvMxsmzC
 OyJgD4f1y0lqypMZEoGxvVRwRaoRHRiGp4e5q89i2VP7G9UnkSFfvQ2FWGdVVq20VFi2
 JtVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770344754; x=1770949554;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k27QD3WlP3QwcmZNZV4hw70i/PEgZN756LcFyVppqvg=;
 b=XqfuO3F0ly/jHQ+hD05lCsSDEhnT47CMWRp8N2i2R9nd0NU8E6YPm8xgd4f0MT1mbJ
 FfrzoR2eQwgqPuySGepEbg+ZcpIKqQT6Lk/zOuCnesiMzwY+8BOe+kftjUc5/TKF3Eb8
 tk7zTC5wtOZkNa4HfkpkxUC4XHYzw7Kwc5qfyNk8dsU/pORMBltL3mLH29pgDt/fTj41
 bY6U24sprRK0TlqSbMXH5AE9SHKnZYC/e9+llLR3T10jfZU/sT0aIhmf+DmpCW7986l0
 SXPIQ5qo01iVyXYi1drbPHEbD6JvFxyQHbh//eRnzGtZpD7OMWmAkRDaNLQpVMtrmQVS
 oGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770344754; x=1770949554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k27QD3WlP3QwcmZNZV4hw70i/PEgZN756LcFyVppqvg=;
 b=UdW64tPeUpwBZJWfk5IMXW4/knL7Re6mDuJZ3zj5UCExDgXbtR+IkL6NxY51eRMW4O
 nfkyk9f/12bz3sBmCgmfvNYxeEAs19H/DUpK4SLGz6Aaa4banhKxxARdQWaKEOXARcmF
 WomW9zgKBjwYExinT/qVCk9rz4JL+4B0wk1vX/al5lnMq3L9IrZT1nVIytkJ3G5YToka
 uwtEibdgk9Xvrwxo0mzAxH6z8dTkIc5NT2iT+It4DC/L1jfBIbLeP2MXj7vOrsJDxkOl
 jw0H5b15d1mWrGsCK3Wj0xEqeEFyZMeeOiJdaVmwCA3gle9uHFERUJTMh76RRb/4j54f
 eAqQ==
X-Gm-Message-State: AOJu0YzhPLnOxUBAHTUV0nK/wmr7gR1FSTF1H9KWukPdAZ19GgkFMU64
 aQfOv4vOEgnbyIsHQDYtDNspXXbhlNKQfty/tbuamRzlSIi63eVD6ZKto/jmnhrQL5Ts6qsQ/HU
 ahrUnZOW0F0vxV80fyLnKnB0rkk5BHRrICuHJBEjCjg==
X-Gm-Gg: AZuq6aJSnb2K9aHLXIeL7cfFy8+dqUnzjKawLjGA8adb7Xap1wpoO9iFsFt+fCoVyNl
 L5RkZk25sXL5YQchg8abKyhJjCVWAS+3GC4FLydvoTx/Fk1f0FJZHj9e6OCbUrxw8oo+R6MdPnP
 iEBiDW07EVbbC9bdpRl4PaEThP9kV11wC898pXbaqwUD1Cnmryuis3qM5NeYfcamZZMQpIZm2pj
 NYJpdoNzymKTJwCh3NQy4ERWGHZ9TicxQ1jK4Ud8NFTPTUlBBMP+Jko77A5PLRTdx5nA6VD/Ssm
 h5YKeA==
X-Received: by 2002:a17:90b:254a:b0:341:8601:d77a with SMTP id
 98e67ed59e1d1-354b3e4c67amr831277a91.29.1770344754504; Thu, 05 Feb 2026
 18:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-7-8d8ff0035372@bsdimp.com>
 <a7001938-fd6b-470c-88f2-5fb29d603b8c@linaro.org>
In-Reply-To: <a7001938-fd6b-470c-88f2-5fb29d603b8c@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 19:25:43 -0700
X-Gm-Features: AZwV_QhWtyQMVdD4_brJ9As6cdXbRA2n9-3RCjO84CooRcuP_lcwmMlBc3e7Nks
Message-ID: <CANCZdforZT5nJ5VSHYtJ+WA3_OpRsCNPHS=PyRa6KaaEsQmS_Q@mail.gmail.com>
Subject: Re: [PATCH 07/24] bsd-user: Add target_to_host_semarray for semaphore
 operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000038f4bf064a1e82b3"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
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

--00000000000038f4bf064a1e82b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 6:44=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add target_to_host_semarray() to convert target semaphore array to host
> > format for semctl(2) SETALL operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index d2107b2f85..07d8bf1304 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -18,6 +18,11 @@
> >    */
> >   #include "qemu/osdep.h"
> >
> > +#define _WANT_SEMUN
> > +#include <sys/types.h>
> > +#include <sys/ipc.h>
> > +#include <sys/msg.h>
> > +#include <sys/sem.h>
> >   #include <sys/uuid.h>
> >
> >   #include "qemu.h"
> > @@ -44,3 +49,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr,
> struct uuid *host_uuid)
> >       unlock_user_struct(target_uuid, target_addr, 1);
> >       return 0;
> >   }
> > +
> > +abi_long target_to_host_semarray(int semid, unsigned short **host_arra=
y,
> > +        abi_ulong target_addr)
> > +{
> > +    abi_long ret;
> > +    int nsems, i;
> > +    unsigned short *array;
> > +    union semun semun;
> > +    struct semid_ds semid_ds;
> > +
> > +    semun.buf =3D &semid_ds;
> > +    ret =3D semctl(semid, 0, IPC_STAT, semun);
> > +    if (ret =3D=3D -1) {
> > +        return get_errno(ret);
> > +    }
> > +    nsems =3D semid_ds.sem_nsems;
> > +    *host_array =3D (unsigned short *)malloc(nsems * sizeof(unsigned
> short));
>
> g_malloc, or test for allocation failure and return -TARGET_ENOMEM.
>

Oh, right. It's slowly coming back to me to look for things like this.


> > +    array =3D lock_user(VERIFY_READ, target_addr,
> > +        nsems * sizeof(unsigned short), 1);
> > +    if (array =3D=3D NULL) {
> > +        free(*host_array);
> > +        return -TARGET_EFAULT;
> > +    }
> > +    for (i =3D 0; i < nsems; i++) {
> > +        (*host_array)[i] =3D array[i];
>
> __get_user, for endianness issues.
>

Good call. You'll find several of these...

Warner


>
> r~
>
>

--00000000000038f4bf064a1e82b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 6:44=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add target_to_host_semarray() to convert target semaphore array to hos=
t<br>
&gt; format for semctl(2) SETALL operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++=
++<br>
&gt;=C2=A0 =C2=A01 file changed, 35 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index d2107b2f85..07d8bf1304 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -18,6 +18,11 @@<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define _WANT_SEMUN<br>
&gt; +#include &lt;sys/types.h&gt;<br>
&gt; +#include &lt;sys/ipc.h&gt;<br>
&gt; +#include &lt;sys/msg.h&gt;<br>
&gt; +#include &lt;sys/sem.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/uuid.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu.h&quot;<br>
&gt; @@ -44,3 +49,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr,=
 struct uuid *host_uuid)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_user_struct(target_uuid, target_addr,=
 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long target_to_host_semarray(int semid, unsigned short **host_arr=
ay,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int nsems, i;<br>
&gt; +=C2=A0 =C2=A0 unsigned short *array;<br>
&gt; +=C2=A0 =C2=A0 union semun semun;<br>
&gt; +=C2=A0 =C2=A0 struct semid_ds semid_ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 semun.buf =3D &amp;semid_ds;<br>
&gt; +=C2=A0 =C2=A0 ret =3D semctl(semid, 0, IPC_STAT, semun);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno(ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 nsems =3D semid_ds.sem_nsems;<br>
&gt; +=C2=A0 =C2=A0 *host_array =3D (unsigned short *)malloc(nsems * sizeof=
(unsigned short));<br>
<br>
g_malloc, or test for allocation failure and return -TARGET_ENOMEM.<br></bl=
ockquote><div><br></div><div>Oh, right. It&#39;s slowly coming back to me t=
o look for things like this.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 array =3D lock_user(VERIFY_READ, target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nsems * sizeof(unsigned short), 1);<br>
&gt; +=C2=A0 =C2=A0 if (array =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(*host_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nsems; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*host_array)[i] =3D array[i];<br>
<br>
__get_user, for endianness issues.<br></blockquote><div><br></div><div>Good=
 call. You&#39;ll find several of these...</div><div><br></div><div>Warner<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
<br>
</blockquote></div></div>

--00000000000038f4bf064a1e82b3--

