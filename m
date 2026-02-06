Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB854EE6B40
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPdZ-0001iQ-Vs; Fri, 06 Feb 2026 12:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPdO-0001i3-9r
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:28:47 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPdI-0000sF-Vz
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:28:43 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354c19bf64bso152847a91.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770398913; cv=none;
 d=google.com; s=arc-20240605;
 b=D6Rybnoujjz0W9ZACUewf4RZLmuS1cuB3Up2bSakCr44Dxjsr5nYU6550/Z+qfplL7
 UMdoqOIctt33ihy/JusgNiP/WHW7+JrHhLB9qGbaHJjSLnfSbH4RxMMc7wnSnIqQ6YvN
 GwFhrZNA4zW3ZYbwLUAO1XZgBPRLEtXq+uAw417u1VIa1ABNwmq2erefx9HTrT40/yRO
 NBQp0kF08+ADJkApnddroAxfCWn9kKdHs5DmXg9g/nexSfiPQChViWVeViX55UBcmw/g
 ZVpZ+9kQ/M8xc3JWXXVgd+zPdcVKrIzvu6mt+NYD6/jnaP+84TMLx7/GqUq9Sbn5E5Lq
 F38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d+gQYo8eWPzDeESGhOSToUPAzvMq8Lxxbgo/y80lfeY=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=N+sloITcaY7L2MGCK5GTX027KPyxxckyxuZRYIvQDQPt9KA2jtafEZZ5yPPvzcr02R
 GjrG5Kww2cR1AXDkQBsMSOCx/nA/KCYVyba1NwWXvaOuVMmZP6bfBbT/AxbvfS4f/NY1
 fautzU1H8A1dEaY6YbYPhZAjddL54o/slW2/cFei7D+9CAGLCwiioWeFyPECLpHWc0aZ
 s9E7Vko0zCvatN1+PRKdz+C/YZj26TFEXK5fbOTxm+8hvphCB51skajOyAvGgmYdvGR5
 fsi2NmZjPdgPjZCpbMVFr+FwRZLkF70EwFHVvPlYFad8YWBkBo1dAilgw+BPDzzeC4ad
 PPTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770398913; x=1771003713;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d+gQYo8eWPzDeESGhOSToUPAzvMq8Lxxbgo/y80lfeY=;
 b=eLqwhpDqShH/fhAwZq13dCVqN4XzYgY678MyNPZ73RdGEvlzIPseu84jlTZKY4j2OS
 +m4ZHGGuZXhmy4/ilzyiXWZgYbtTYP2y3ZoumY6aAz74B4XybkPa2ENGG6K53gSdE5M7
 pUHHHHBvXEkOMT7xohkhs0Yl8DKEAyeAviLPlZ+Qqndp5SFEBpn7f1n1oeQ6gqnR1o6S
 9B59NNj9QNzJSnYwCIQeasUKwbs2Dr1ES6mMwxePeClot42WpBqYCtu2GengYjXNMQbc
 cVkv9lqAxtbFoaumhKTxA11p3kk9Woyhaxvy+xbjSQauZeXd5IFRANrt75JWaAgWQVoH
 SBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770398913; x=1771003713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+gQYo8eWPzDeESGhOSToUPAzvMq8Lxxbgo/y80lfeY=;
 b=enqK8wSfoL1sHTuKWerqtQv61s/DEwlWhsAGNpRi+dGYp3atVhvkWHahBxKcHrxpwe
 00NB1Dn7j4YNoFWMaOf4RWH1Ud7tWlfDRulDHTGeY2cmzsaY+7DAFjmSGNu9F84yyve8
 MNUW9Ze706OqHH1WfTh4YFpcyKlHHtbgJSV9/szn+71OF2QzEvT/iqhmUFW2Wayy9QB1
 OC4yrD+P6BefQVaKdxqhqnVhOzpmwzWvo6qZlIcpycQgulsQ4sF/ldPh1XVvn/c+DJ+K
 OBy+/lfnt2E9xFi51v3XSCtVnRAnIPTe5eJL67VfRVfWudhbhBqCMFowXKHNqRBvQXOC
 foCg==
X-Gm-Message-State: AOJu0Yznv/+j7kSfUPGGZA1DabAL9RLu8japgjNVAN+h+wV+dOodsf8W
 UYbfM9dF1uqZcsSMcZx7ZB7T0dzepuIdmf0/bz5gahJSNX4QhGiXbs/yZza+VFMgzk+DHqj3wW8
 k3f47g0zu412/MhAFTdLN9JTtLk35I0B/e+fB0eJj8Q==
X-Gm-Gg: AZuq6aIUsqhQ0fc2yuqEGSK+xwYmBhylNFL9cWQqMkhcjyImXP2BkUps72ui6ueqem3
 m4pomJzNNSXqIlFztwu1gp8JhYwhbnSOdrjT0jBOZFAD05CiNQILESzmWA6muJpTWAP+nnTEJWB
 2jsEzYt2YdSkiIoapa2+uhPEYlt7O50nNgDcBb5JtEYFrmdd3Tb/b5IVm/dU3+c84bJeHv76afH
 UHM7BNhecqRC2vOzjwrLDKb/MTFrl+xX/sxIp0bxyEHNnCRbcGSyDszvm+dhyfnd93RYYw=
X-Received: by 2002:a17:90b:2701:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-3549bade66fmr6851365a91.2.1770398913243; Fri, 06 Feb 2026
 09:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-9-8d8ff0035372@bsdimp.com>
 <76a0a345-b974-45ad-af4f-dd6d5701d999@linaro.org>
In-Reply-To: <76a0a345-b974-45ad-af4f-dd6d5701d999@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:28:22 -0700
X-Gm-Features: AZwV_QgntKA0FLQZB9jCQvbqFM1V3oDBdtuKqPa69wmyZhmiSMS2g6VvUFfF8hg
Message-ID: <CANCZdfoFGHQEDP9dE6tewVxns5rWXW+VYb7M_6qcz_tAgB_LKw@mail.gmail.com>
Subject: Re: [PATCH 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000055b8a1064a2b1e42"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
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

--00000000000055b8a1064a2b1e42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:25=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add target_to_host_semid_ds() to convert target struct semid_ds to host
> > format for semctl(2) IPC_SET operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index 7bdf65450a..581eb50355 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -111,3 +111,26 @@ abi_long host_to_target_semarray(int semid,
> abi_ulong target_addr,
> >       unlock_user(array, target_addr, 1);
> >       return 0;
> >   }
> > +
> > +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
> > +        abi_ulong target_addr)
> > +{
> > +    struct target_semid_ds *target_sd;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    target_to_host_ipc_perm__locked(&(host_sd->sem_perm),
> &target_sd->sem_perm);
>
> Drop the useless parens following &.
>
> > +    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
> > +    /* host_sd->sem_base  =3D g2h_untagged(target_sd->sem_base); */
> > +    host_sd->sem_nsems =3D tswap16(target_sd->sem_nsems);
> > +#if defined(TARGET_I386)
> > +    host_sd->sem_otime =3D tswap32(target_sd->sem_otime);
> > +    host_sd->sem_ctime =3D tswap32(target_sd->sem_ctime);
> > +#else
> > +    host_sd->sem_otime =3D tswap64(target_sd->sem_otime);
> > +    host_sd->sem_ctime =3D tswap64(target_sd->sem_ctime);
> > +#endif
> > +    unlock_user_struct(target_sd, target_addr, 0);
> > +    return 0;
> > +}
> >
>
> Use __get_user and you won't need the ifdef, since the size of the type i=
s
> then
> automatically handled.
>

Agreed. Will update.

Warner

--00000000000055b8a1064a2b1e42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 7:25=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add target_to_host_semid_ds() to convert target struct semid_ds to hos=
t<br>
&gt; format for semctl(2) IPC_SET operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mikael Urankar &lt;<a href=3D"mailto:mikael.urankar@gma=
il.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 23 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 23 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index 7bdf65450a..581eb50355 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -111,3 +111,26 @@ abi_long host_to_target_semarray(int semid, abi_u=
long target_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_user(array, target_addr, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_semid_ds *target_sd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_sd, target_ad=
dr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 target_to_host_ipc_perm__locked(&amp;(host_sd-&gt;sem_p=
erm), &amp;target_sd-&gt;sem_perm);<br>
<br>
Drop the useless parens following &amp;.<br>
<br>
&gt; +=C2=A0 =C2=A0 /* sem_base is not used by kernel for IPC_STAT/IPC_SET =
*/<br>
&gt; +=C2=A0 =C2=A0 /* host_sd-&gt;sem_base=C2=A0 =3D g2h_untagged(target_s=
d-&gt;sem_base); */<br>
&gt; +=C2=A0 =C2=A0 host_sd-&gt;sem_nsems =3D tswap16(target_sd-&gt;sem_nse=
ms);<br>
&gt; +#if defined(TARGET_I386)<br>
&gt; +=C2=A0 =C2=A0 host_sd-&gt;sem_otime =3D tswap32(target_sd-&gt;sem_oti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_sd-&gt;sem_ctime =3D tswap32(target_sd-&gt;sem_cti=
me);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 host_sd-&gt;sem_otime =3D tswap64(target_sd-&gt;sem_oti=
me);<br>
&gt; +=C2=A0 =C2=A0 host_sd-&gt;sem_ctime =3D tswap64(target_sd-&gt;sem_cti=
me);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_sd, target_addr, 0);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
Use __get_user and you won&#39;t need the ifdef, since the size of the type=
 is then <br>
automatically handled.<br></blockquote><div><br></div><div>Agreed. Will upd=
ate.</div><div><br></div><div>Warner</div></div></div>

--00000000000055b8a1064a2b1e42--

