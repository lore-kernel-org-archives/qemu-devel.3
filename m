Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE916EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPyq-0002rL-M1; Fri, 06 Feb 2026 12:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPyo-0002rC-Tk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:50:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPyn-0005m7-7x
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:50:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a871c8b171so17059855ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770400249; cv=none;
 d=google.com; s=arc-20240605;
 b=iPlLi6w2BHAUXh+rMWrnPjZc6AuEW/7lDmp3q1aqDbWsbIiHJ4MMB1RBueZFGfR0JX
 Fxf2m5KsLk5BYmS3JEHuYuFqYd68f2VD0GOaFOOhNRaKaG5xBiLEqwdEF1YQ9gsmU6Mk
 jocKlF39fE5KVv+bi14hslGPQUS7vxw8JjWmneovKrpjyBZpBeZkKf5N+uDkw5fgrbwr
 9Jc8xuEjXsX/oi19Jxr3GM2ZBHVtIBa3F7XMnVwhlYUmbVpWRZcoQFR0DaL57hbw0sdn
 lgqiehTJ7+GwzwNiEqRqL53QNIHKTCC3GI8/kQaRoU0RFeMN/XgY8s+U/KQDFRSFkn9d
 UD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JEgoD2aT2Hb7YHxCt+wfLHKdug4wrM5FC71EzF+XyJk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=XN+vVp1SM0XPQpL3lUZ33w3PHCBnSJjYLvdsP1nXwB66gBCw+z78AUvpC3SV5xZubh
 r8IilJ4EvMbtO7T4qJ/oJUyLQ+gb8xpuNnEETSOTbmZftDm5+OfZTKHVkC6bT9EJuWh8
 WGWAO6jO9t765xAKtp0wyN0Qpn1Bnd4ALvyDzX6XdpcCYE/51rkBkUuyb+4hRbeuN8p1
 FC5L1fB4eAiZFPhzH+uWYxs7g8rQ3RaOmrm+hZmfCLu/XOB95QcCpvCNzkWY06ruqEkt
 hnCGcM2v4OvXgLQaNkEAc6sAV4czLYcI5DI44qdBOS+ZBEdvlF+xU8xQEfbU2rGDsTmp
 hUvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770400249; x=1771005049;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JEgoD2aT2Hb7YHxCt+wfLHKdug4wrM5FC71EzF+XyJk=;
 b=q6wlzMGUTbHs8/p+ZME4OyCwO7nOkW4qQrBR7e2zW9H9ODxhw2wd4wWk+2N0plqpBA
 AJ2fDYENY1A3UooQWhSpAjEHj3cDqiTPEdpMQLgNkRRgA5Wzw7wHXBHHcIgf5FdirNy1
 qfpyWdA8280eMyH69cD+Ds1Cs9opMpVStxhynVns762+XFJrDXSV2FxHaL9/UJCWTOxB
 31g9ZH2hc5zpTOUbhM5L84v08frda6PTKFcRlKQYqJtHEUnWTTas06ai2fFPXWMMty3l
 QNn4vUovysgLdebCKafpP88Ldk2WIKSkR7puK7S1RM/sJ+sbRf+ohk3o6rue6M5CxsBS
 KQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400249; x=1771005049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEgoD2aT2Hb7YHxCt+wfLHKdug4wrM5FC71EzF+XyJk=;
 b=W0N37axIjXA/UhAciHDJzG09Uoz3iYyGiKQV9DQkCDfCk8/sxziGMuKZ3+w+rFOavi
 S/bU7REpu6Rv4Z7mkxRnPl+vSDX9SHKZN4WexkJ2XFegP4ZV07raig3ECcWeuM5LwZzl
 z6RE4jE8T5Khz8zcoTzMNWVDSrj6msB/x3mjj+WQUFBjaRPAW07H4FUexOpkBbTtobcN
 zFJItxbyVen/83WoPsYY8J45RC2p+C9W/k4T1YuhKQNl0sgKxgtLFL/efoGT2bD94Dml
 pYLJZiMU41khFQ9FXEbO69mkY97kbAe8kJn6SsIJ/wSSlf2yhtA0iiuDdj/iYZcilK0d
 npBg==
X-Gm-Message-State: AOJu0YyYMERuODfjyHsAa/5PkkNtQOyT5I9TaxG3m3sPbgPPmR2vkQ0s
 ZO5mG2A3p4/QexLbcaMs9PlSf3cxu0/KVE8mPc17xReUp6e1ybysHRgBAFfqKWqtSDbU5APcc2q
 v6vsWp7jr/dKy0X5zo2m0v7z/EsSI0ASq6ps3WVNRXg==
X-Gm-Gg: AZuq6aIduOXoN945Sxe3hfHH+uLIqh3+ZWpfnFYLheYeBNLIteBbyR9c19tIlgVqxiO
 pFDXyVn/owu0mRLexKO1Hasr3FwEiaerHrbLppbF3Y9NEsKIJhggET2fT1fyctz8PT14ZARfq+T
 xH7FhgA279EZyATPIAlBv4ijbwSpQylNKZ03swRjFyizTqQFrFhO1qiVBOQcmIz+gyI/fWX39re
 Ap+2k8NgWX6xa9JYGxPEg2NaFqP6jGKH3d7srWw8U4+RKz+Lr8HFt6bakNvCqB15Ynr4H384WqS
 p0/IcQ==
X-Received: by 2002:a17:902:f681:b0:2a9:322e:1964 with SMTP id
 d9443c01a7336-2a9516fb2bbmr36706145ad.31.1770400248695; Fri, 06 Feb 2026
 09:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-16-8d8ff0035372@bsdimp.com>
 <4050ab09-5dde-4ed0-9283-ee306d55e639@linaro.org>
In-Reply-To: <4050ab09-5dde-4ed0-9283-ee306d55e639@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:50:37 -0700
X-Gm-Features: AZwV_QholFlhhO7EUp94QqzFOA35QanX67TFHI8ZWecrgEN9Hz88Eg0_J5ZEnhs
Message-ID: <CANCZdfpdVvOcqkTAhg7iFPyKWv_B=z3ke8JFB+Z-NF+mCELbTw@mail.gmail.com>
Subject: Re: [PATCH 16/24] bsd-user: Add do_bsd_semget implementation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ef259d064a2b6d14"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
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

--000000000000ef259d064a2b6d14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 8:11=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of semget(2) syscall to get System V semaphore set
> > identifier. Converts target IPC flags to host format.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index b722c63437..18520548fb 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -77,6 +77,18 @@ out:
> >       return ret;
> >   }
> >
> > +/*
> > + * System V Semaphores
> > + */
> > +
> > +/* semget(2) */
> > +static inline abi_long do_bsd_semget(abi_long key, int nsems,
> > +        int target_flags)
> > +{
> > +    return get_errno(semget(key, nsems,
> > +                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
> > +}
> > +
> >   /* getdtablesize(2) */
> >   static inline abi_long do_bsd_getdtablesize(void)
> >   {
> >
>
> Doesn't FreeBSD have consistent ipc flags across targets?
> I'm surprised the conversion is necessary.
>

It does, and this could be a simplification, but for now I'm going to leave
in place since there is some other related work someone else is doing I
don't want to get in the way of...

Warner


> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>
>

--000000000000ef259d064a2b6d14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 8:11=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of semget(2) syscall to get System V semaphore set<=
br>
&gt; identifier. Converts target IPC flags to host format.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 12 ++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 12 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index b722c63437..18520548fb 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -77,6 +77,18 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * System V Semaphores<br>
&gt; + */<br>
&gt; +<br>
&gt; +/* semget(2) */<br>
&gt; +static inline abi_long do_bsd_semget(abi_long key, int nsems,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int target_flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return get_errno(semget(key, nsems,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_to_hos=
t_bitmask(target_flags, ipc_flags_tbl)));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* getdtablesize(2) */<br>
&gt;=C2=A0 =C2=A0static inline abi_long do_bsd_getdtablesize(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; <br>
<br>
Doesn&#39;t FreeBSD have consistent ipc flags across targets?<br>
I&#39;m surprised the conversion is necessary.<br></blockquote><div><br></d=
iv><div>It does, and this could be a simplification, but for now I&#39;m go=
ing to leave in place since there is some other related work someone else i=
s doing I don&#39;t want to get in the way of...</div><div><br></div><div>W=
arner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Anyway,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
<br>
</blockquote></div></div>

--000000000000ef259d064a2b6d14--

