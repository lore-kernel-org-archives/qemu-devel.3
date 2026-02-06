Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EFAEE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPhH-0002tl-HR; Fri, 06 Feb 2026 12:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPhE-0002sD-FN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:32:45 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPhD-0002Yd-17
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:32:44 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-bde0f62464cso399595a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399161; cv=none;
 d=google.com; s=arc-20240605;
 b=VE/6BFhQ1czrkEanDqIAaYoVuPAICv9SHEQg4rH+ljn0jzpHq9jLquI3iQ4e0ttBMZ
 881lhkvLvFoGvvrRlGizIJYW6wkZFxvx98ul/fzQS+SFbzlaiT9vtYr/CbLlB3T/ltbF
 WjeFvrlzvzjzbc+FZCsnwE1aIuUzupAxW54zgfVTDfT+witxdKrZaPW+Csv8R/Xoz0rZ
 V/yEJpBmFywXC73iCavzm2nozbc+GBAFzME3VsUZ6TifV+V029Yc7eoUsOYrtxOnkU+X
 nGLmA0UJGJlC9vQKypV0VtilppTBXUIlbuE77t/MO3doWO0ubf7rvjMCh7adA1PnWGeO
 n8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x6ZqDbKjHW9lgu/WSPJhugqOaLL9JNOhz+dEBoifdDQ=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=FHy9fcYwqrUaQ9HLZTeJAfTZZAUW5lmK8FfMv1Adubs0L7ox9j9CEAbve9L/TEExQJ
 nZO40fOyCqH4q4tlc4e2KDl6jcTqQNrCXmXT2NKFRXB8ggnMUfPviEv7xLehgUsrii23
 YKk1tLDaww37I5fSkjVS2OJrnkw8JEdiyEEiJL+MGO6sMfWO2dh0aDNuX5l+N2rD3HQF
 todsiPDacI5AaDehGHO1d1dWxxDKuIJbEBpw8e7fOQlyVFDjCZYxMSqzptsm7IbHgNyu
 9Ucck/nWYklIwekeTqloMV3hszz5m4Y/Qvvc3hlzuFIvQcq5JD8PwlokL8ImAC/qX0wo
 I+ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770399161; x=1771003961;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x6ZqDbKjHW9lgu/WSPJhugqOaLL9JNOhz+dEBoifdDQ=;
 b=gEG5FNvMjWVhHs+vjqwuc8SqJWBRLJLi4ssL5ao5Kdp4t+QKCAhGJ46K0l3yGkUOb+
 KJxwu09hgmqnapTWlQjvoDEtMl0mfDGysoH251gpFDvz9Tid2x913MCkRHsH//h2FaRl
 HN6pvC3kKwtptzLUoOp8txLDoMROyM9RxwOXe6Z4xNJniyO0JdvQ6o7gAMLk4CboGXKA
 5fRXuhK26E/b3i9kYLwoWCbHl7QgXIuUwOpAvy+50BRo7tMtgSWrtvZeddu+eFNmlNfL
 e/PD7oFeBptg3UQeUODueUN/JK/3UcmlgvzNg7XZLiacRv/uOFZaPOKLl3RdLX5ddrzd
 VWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399161; x=1771003961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6ZqDbKjHW9lgu/WSPJhugqOaLL9JNOhz+dEBoifdDQ=;
 b=XAo5p3Mtb5F+8yQ8awyA4SwzLlOwm45CR9pv7vXsyoEB99yUifpp2Yq25foY9l21AX
 yHFxjIQeDkxFyuhoQPT42Boqp49Sc/5JLHAC8K/hMZuVEGHLQcAc4OcHi5t+SuWViYfI
 h5/0laiL9pBYMcBJu2dMz6buliR5uvl7W0stz2Vkq/YkX9epZcRV4WSSuYb1eBKiToa1
 /aOsH4FnbYgAQ/CWOgCQeX1GGryOIP7w6svqhCvzKzRiw9QfU8OQl5y2YL1OnZFb/AZL
 T0KytDneovaPdT0OIL9f923ZNRKJZT9pnueosGADG5b+9x7KTBNe/hmx3iYdX0d1uvVr
 FfDQ==
X-Gm-Message-State: AOJu0YxOSaiHj+8y8N4ESv2NNKpghr9vGagV7qHLv4+52q1FV9kj+lBl
 XsJCAmO/p9Sheljv7m7IcT0gtEi6npD99vAqHtLbGO7Faqe43EHI0TLMvasFKSZyyQF85ZAOnDH
 8txcm4PQUMwv6xKCk1itWscBXbJIrn0X23WadQsvs7w==
X-Gm-Gg: AZuq6aKHn88TqGcv0wGH0BMrlHMHt9eQMlQSdKQO5EqXhnwibI6D3d58xQadnvsWN07
 Ddxx8FFUslFzOKGiCzxyPcPruKtWHFc4uVLJ9pdkDrteT2UBnEE5fj3ftnMAeHwzOvKGQAGEBoy
 9/qqg4qdzI3hzuC0yscYLK4GL1T2j5Mu498lUSZ4lRkY4iv0hGJTOx9mNlyE8iMZ7V4nEkbiEhe
 CCXZB1baPlkebuhpe+tKWAEIWsW2uMUtvSu3seOKYHNvvlkpU4e/L4+uqmMSgyqDqn7ITA=
X-Received: by 2002:a17:90b:1d85:b0:343:c3d1:8b9b with SMTP id
 98e67ed59e1d1-354b3e2ee6amr3115673a91.19.1770399161438; Fri, 06 Feb 2026
 09:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-10-8d8ff0035372@bsdimp.com>
 <3522bd10-74d2-4873-b045-9682d2dbf4cc@linaro.org>
In-Reply-To: <3522bd10-74d2-4873-b045-9682d2dbf4cc@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:32:29 -0700
X-Gm-Features: AZwV_QhwveG7COkx6nB35T8uiVz5CaLeEQn2lUGBK_LU09Jv7n75TfrWaaagDAY
Message-ID: <CANCZdfoVtVJAfddWROBJyLdURqhC_Am=hJPZFXZNKjePXk10iA@mail.gmail.com>
Subject: Re: [PATCH 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000020e593064a2b2d6a"
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x533.google.com
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

--00000000000020e593064a2b2d6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:46=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add host_to_target_semid_ds() to convert host struct semid_ds to target
> > format for semctl(2) IPC_STAT operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index 581eb50355..f35f682aa4 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -134,3 +134,23 @@ abi_long target_to_host_semid_ds(struct semid_ds
> *host_sd,
> >       unlock_user_struct(target_sd, target_addr, 0);
> >       return 0;
> >   }
> > +
> > +abi_long host_to_target_semid_ds(abi_ulong target_addr,
> > +        struct semid_ds *host_sd)
> > +{
> > +    struct target_semid_ds *target_sd;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
> > +                                    &host_sd->sem_perm);
> > +    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
> > +    /* target_sd->sem_base =3D h2g((void *)host_sd->sem_base); */
> > +    target_sd->sem_nsems =3D tswap16(host_sd->sem_nsems);
> > +    target_sd->sem_otime =3D tswapal(host_sd->sem_otime);
> > +    target_sd->sem_ctime =3D tswapal(host_sd->sem_ctime);
> > +    unlock_user_struct(target_sd, target_addr, 1);
> > +
> > +    return 0;
> > +}
> >
>
> Probably should use __put_user instead, but this isn't wrong.
>

Agreed.


> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>
>

--00000000000020e593064a2b2d6a
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
&gt; Add host_to_target_semid_ds() to convert host struct semid_ds to targe=
t<br>
&gt; format for semctl(2) IPC_STAT operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 20 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index 581eb50355..f35f682aa4 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -134,3 +134,23 @@ abi_long target_to_host_semid_ds(struct semid_ds =
*host_sd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_user_struct(target_sd, target_addr, 0=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long host_to_target_semid_ds(abi_ulong target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct semid_ds *host_sd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_semid_ds *target_sd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_sd, target_a=
ddr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 host_to_target_ipc_perm__locked(&amp;target_sd-&gt;sem_=
perm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;host_sd-&gt;s=
em_perm);<br>
&gt; +=C2=A0 =C2=A0 /* sem_base is not used by kernel for IPC_STAT/IPC_SET =
*/<br>
&gt; +=C2=A0 =C2=A0 /* target_sd-&gt;sem_base =3D h2g((void *)host_sd-&gt;s=
em_base); */<br>
&gt; +=C2=A0 =C2=A0 target_sd-&gt;sem_nsems =3D tswap16(host_sd-&gt;sem_nse=
ms);<br>
&gt; +=C2=A0 =C2=A0 target_sd-&gt;sem_otime =3D tswapal(host_sd-&gt;sem_oti=
me);<br>
&gt; +=C2=A0 =C2=A0 target_sd-&gt;sem_ctime =3D tswapal(host_sd-&gt;sem_cti=
me);<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_sd, target_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
Probably should use __put_user instead, but this isn&#39;t wrong.<br></bloc=
kquote><div><br></div><div>Agreed.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
<br>
</blockquote></div></div>

--00000000000020e593064a2b2d6a--

