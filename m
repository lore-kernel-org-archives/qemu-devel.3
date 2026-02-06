Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6083EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPkT-0004hF-So; Fri, 06 Feb 2026 12:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPkT-0004h7-7X
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:36:05 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPkQ-0002yg-Qs
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:36:04 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3545d66bb3aso468901a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399359; cv=none;
 d=google.com; s=arc-20240605;
 b=HxDv5ilG+9PWOdLh+KmchA5UST9e9czUpLH/iw4pEoCbDg1OXN/ubdKroo4DI1t/Jv
 dSAxOQw0/JrCxJD5fBGS8ZlfkyoKlLkTaZA3iI0l3D2S8U/LwYic8tMRkR5N9GjdsUwm
 dX83mbJmC5CeclkdHn8BiYSG/faUlTPAP43lyrrxep71aE5285yhUKov0g/Ix0bzFGpS
 xMeVcZs8Ql1H2CMv0FwMPR+nwyuc0GoAY8QQcL7wB8kFagsSoSzN9485m4nWV4yruyqw
 De8EnmNBZd/IBiZMEpeWH8BR43AU94R22Pi1A84A8sRBwelrVEAw1yajqIBRD4Ygp8Kv
 Ozvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w/BKo7jvZMk+0j/WApmd1igJXUBVRQa7Ty0AfdP4sRI=;
 fh=vX99oSypppU96q5NuBPJPnj1jnSm3PHdNBfQCXpkGWA=;
 b=bwuY9GAucZcH79Io7WKIPGVtFHwCIP7qxXLXg0b8mJvnEPDjSuR0dSo/qpRvyVMYzq
 LKPNmm4E9F9hL8Fo7kt36861EKN5azELtniQzvqfbeDMFa2VjTeEAWdGT/pWJuIMe0XK
 /KmBod9ftmIs+xiFlMsaR/FW4q4OwbnCtRLboebdxw0ve+JrFc2XqwJC6ZlRM+qWVe3n
 i4YozNaU/6uQhLsc9iBWsVCONmm5ajdUrQrHWdXa/o1WYYeP9h8UDyQj0HkCwPMKRRTs
 lIafmYA052GCGtJUJT9pXsPYvUD3cWUi4b6nThxzqCrvPy7PTrLr6Sk5g7qkY/mMVIRY
 xt3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770399359; x=1771004159;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/BKo7jvZMk+0j/WApmd1igJXUBVRQa7Ty0AfdP4sRI=;
 b=Va5kTtX8zOmTTPVAfUj8YLJZY9YF9gQqgz8sSEcVEtHIFFfRp51GVZmMTP5pTar6Ge
 ktgWhM+Ljjd10qsKePHB8Kc82qzzubwUc9kPOIyxOR9RY0WNHHB1LqJvJBJ9IHxV2g73
 zMcwDeUnrobzBzJiZzvKEcDqBTNYG5sAZLzTo2S6TKWlUHmGA6we4b9uVUZqIHxpVrlB
 58GD3cwE2UPoiCTx4fxx3yCfqXzn3eFtFP7ZA4BDVYTLK6uGygEKbAE695n/TpHVEc0u
 M85w/ReZIPY4uNuNWl5ptz1hWu+kc4y914k/xDLWUszooz6vyFzw5F426CXDOBp3fy0N
 Imgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399359; x=1771004159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/BKo7jvZMk+0j/WApmd1igJXUBVRQa7Ty0AfdP4sRI=;
 b=UlyxB3+ZI52PCJBi2kGK+997zkqSWnUlVtJ3vkFmU95vrZUVz4QHetmWBI9cHwxoxo
 8B/RWTUFhZxC3M/MTEqaRrTxlvHNk4sxVyWIsnLgYehLNit6ogMOOqZ7ew4MlDW/43CL
 N+LrvJP2vTB+IVMtYyHIWtDWzcjv11M+i0ouxn4SyER3cN9CzuQcnB+9ayR51TwHyu2M
 xxBwaMxd/WKwizxLQADqSbYaDg5mRVObMnBt19zqeZkHKsE/9+7KRMy2Xnbrz+7NgTn4
 wlD9Dcum8elLqcsC+2GGqvIckOYO8dWVPaOOKE0UMgJvaMkFuHBvhV0ivfCJ9+RE8918
 /OvQ==
X-Gm-Message-State: AOJu0YwnrYDbXEjJMGvFlgIqrvL2cFxvClbh67wn14iE7SAM7YfM+YKs
 ZJfa0wJfdD4vFK+OCjEQoF52Vz9ldQl2d7YrJDIMZwVzK+mEuuMWpyHhTIlokmBSR1RAVs2g4yF
 rzKFqOMPsvOyo0EUHnxgEv8tgLOGcTwYqNaE3kYuyJQ==
X-Gm-Gg: AZuq6aJLyFjOGQGFkZSxQk9HPMohG+kHhd9E4rMn+sKgPE8m8hCs1o5PBFTBv12EqDM
 up6oor3Mski2EEJ12Gd3JEYVe8dYZ0Mxrb6RPsPTTH51jvSqI2XEedbrOtCy58ZmFvCrUrFy4JU
 EUjyuSsGbFRQMbAcmhRChIKk2DfHZgqDu+9WRL+5e6ya7AKXVe+IhLj6Sl+hzEy/j54VpWhAMoa
 CrPRTinVvNR2/Z6angEIYs5xmDRKx/wDe0dNYA7odHhQtFed5GTgtd+tmjdCSRs+X9MZ/B47ets
 4E0D7Q==
X-Received: by 2002:a17:90b:3a4b:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-354b3e2ee5fmr2833835a91.24.1770399359137; Fri, 06 Feb 2026
 09:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-12-8d8ff0035372@bsdimp.com>
 <e7e0033b-af4c-49ed-97ae-3ec87546c6ea@linaro.org>
In-Reply-To: <e7e0033b-af4c-49ed-97ae-3ec87546c6ea@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:35:47 -0700
X-Gm-Features: AZwV_QhZnD8EvyylwRlyW5Wfb1hxVGl4CBN7Mp4-2OqbAiI_eZe0Wgko9baZirM
Message-ID: <CANCZdfrdE=0rpGs+10Q4Vreyooo8gaT_RS9S0BA45-LhFc2CMA@mail.gmail.com>
Subject: Re: [PATCH 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
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
Content-Type: multipart/alternative; boundary="000000000000e98857064a2b3834"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

--000000000000e98857064a2b3834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:46=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
> > format for msgctl(2) IPC_STAT operations.
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
> > index e7031c5264..03773e2620 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -187,3 +187,36 @@ abi_long target_to_host_msqid_ds(struct msqid_ds
> *host_md,
> >
> >       return 0;
> >   }
> > +
> > +abi_long host_to_target_msqid_ds(abi_ulong target_addr,
> > +        struct msqid_ds *host_md)
> > +{
> > +    struct target_msqid_ds *target_md;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    memset(target_md, 0, sizeof(struct target_msqid_ds));
> > +    host_to_target_ipc_perm__locked(&target_md->msg_perm,
> > +                                    &host_md->msg_perm);
> > +
> > +    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in
> kernel. */
> > +    target_md->msg_cbytes =3D tswapal(host_md->msg_cbytes);
> > +    target_md->msg_qnum =3D tswapal(host_md->msg_qnum);
> > +    target_md->msg_qbytes =3D tswapal(host_md->msg_qbytes);
> > +    target_md->msg_lspid =3D tswapal(host_md->msg_lspid);
> > +    target_md->msg_lrpid =3D tswapal(host_md->msg_lrpid);
> > +#if defined(TARGET_I386)
> > +    target_md->msg_stime =3D tswap32(host_md->msg_stime);
> > +    target_md->msg_rtime =3D tswap32(host_md->msg_rtime);
> > +    target_md->msg_ctime =3D tswap32(host_md->msg_ctime);
> > +#else
> > +    target_md->msg_stime =3D tswap64(host_md->msg_stime);
> > +    target_md->msg_rtime =3D tswap64(host_md->msg_rtime);
> > +    target_md->msg_ctime =3D tswap64(host_md->msg_ctime);
> > +#endif
> > +    unlock_user_struct(target_md, target_addr, 1);
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

agreed,

Warner

--000000000000e98857064a2b3834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 7:46=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add host_to_target_msqid_ds() to convert host struct msqid_ds to targe=
t<br>
&gt; format for msgctl(2) IPC_STAT operations.<br>
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
&gt; index e7031c5264..03773e2620 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -187,3 +187,36 @@ abi_long target_to_host_msqid_ds(struct msqid_ds =
*host_md,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long host_to_target_msqid_ds(abi_ulong target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct msqid_ds *host_md)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_msqid_ds *target_md;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_md, target_a=
ddr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(target_md, 0, sizeof(struct target_msqid_ds));<b=
r>
&gt; +=C2=A0 =C2=A0 host_to_target_ipc_perm__locked(&amp;target_md-&gt;msg_=
perm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;host_md-&gt;m=
sg_perm);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* msg_first and msg_last are not used by IPC_SET/IPC_S=
TAT in kernel. */<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_cbytes =3D tswapal(host_md-&gt;msg_cb=
ytes);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_qnum =3D tswapal(host_md-&gt;msg_qnum=
);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_qbytes =3D tswapal(host_md-&gt;msg_qb=
ytes);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_lspid =3D tswapal(host_md-&gt;msg_lsp=
id);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_lrpid =3D tswapal(host_md-&gt;msg_lrp=
id);<br>
&gt; +#if defined(TARGET_I386)<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_stime =3D tswap32(host_md-&gt;msg_sti=
me);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_rtime =3D tswap32(host_md-&gt;msg_rti=
me);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_ctime =3D tswap32(host_md-&gt;msg_cti=
me);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_stime =3D tswap64(host_md-&gt;msg_sti=
me);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_rtime =3D tswap64(host_md-&gt;msg_rti=
me);<br>
&gt; +=C2=A0 =C2=A0 target_md-&gt;msg_ctime =3D tswap64(host_md-&gt;msg_cti=
me);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_md, target_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
Use __get_user and you won&#39;t need the ifdef, since the size of the type=
 is then <br>
automatically handled.<br></blockquote><div><br></div><div>agreed,</div><di=
v><br></div><div>Warner=C2=A0</div></div></div>

--000000000000e98857064a2b3834--

