Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EE1ECD9B8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voB9V-0003fq-9y; Thu, 05 Feb 2026 21:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voB9P-0003fS-6h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:00:51 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voB9L-0004mv-H9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:00:49 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35456fcb79cso904258a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770343245; cv=none;
 d=google.com; s=arc-20240605;
 b=VmqKwPej5US/6sOKBs5Le7u7udqn41uYqPtit2sBDiysAf5QZmHo8yLKJc06yo8qib
 UYlkIteeyTr+J1t605h80bNFBSS82vg4fQIMkF/t97x6oLmz9QjrPr1wZHK1iVBfVQxs
 omBCEsu8d/5dAXdgvuct+E5qqgnfNEp7VTmQThlX+6NszpzBwoGy/r8mQQWwr5CTzUvY
 rROlwLNX2WCcr77GdMMsKI43XnkAa7fHP7ELd8cmrNuSpP/Jdziibp4FMjfy5RaLhjHr
 PmLcLLuUsOX7RwlvL4ifCkHtrRV07fZcThRr0lsdYsfZYxgQVxHtZPINtvOXgTx7srtq
 ygFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8kJFz0lMxEmBxgTQEqQ20ibwzW2lRMDCpVHE9If0IgU=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=YiytLRA0WFFrnjNLBF5FsBdYitQKgpZp0I3kvIkJsxzJWjTSclSbRtEErsoQMbQmiz
 w+dGeYiH29Fcbudaql9n1dolT95ufV15tncbCs2JrHHpow3/onHtVcD7YtkPFgJRWeXF
 A+WxXc8yGAE3rZd6YYnm/G8TgWm79NEGe7g72F+wL4FR4R123GixkCaD6z0C/W6Y8mVS
 z5rrdk6xwE0ws2xTezUaY0V6iOi6Ug1soVvIe7RB1eLfjezzqoydca7vIzVB3Bb4NIUS
 11EIBVX7kvSt+LanLMW3ylxJJC6n4fY2Y7rzk9tbAkJfjAWgDRDZwiXyMBeFLEw9EAIC
 eTRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770343245; x=1770948045;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8kJFz0lMxEmBxgTQEqQ20ibwzW2lRMDCpVHE9If0IgU=;
 b=XcCdoUmsw5pZShDkaRfodJd8Ksx5ZNhqsYnqLjMcdZbKpYOayrzYMbFhoH7CUwsDZo
 YX/4bDEJ/75q5vJfz8dG8MQFAYWOEk+OXKkTugriXJz/VkgvojGe++CVVTjuCqDaWxwG
 gblLzO9mKyXrMHVee4y+gnMoOV+lR9m/NMUFfgIOp56/qLsSa9UPKxI/fxSPgNTJRe2Z
 V6W2wyenhQOO5pCfG7MZN/ArqUokuy2TkB/zI+4sjfKSK3LUHxr9rI/pevgtb3YbErNC
 8x6fl41WrG1wv7+xDA63uAXKiQcoxm18y9fAh3Qhy/guge6i/u6IaeykcTLirrJeuOLv
 hMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770343245; x=1770948045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kJFz0lMxEmBxgTQEqQ20ibwzW2lRMDCpVHE9If0IgU=;
 b=wAEWIBS4VGA+p+oeYuHVIPhNdEGPDVZaylpPJSVi4p3WBXdWwuSBjq24Jf6YQVFLd3
 PlxULZQNDhNW6Og0TV04Gvw8tKBILcTOHtdLSlF249vl7xbBekUK3GBEJrhqCbqQDWAJ
 Qyvi2hJYOodtzzMqBIKUoi4tQfzIstqv0Sv6fA+z4wdE4tNGMd12Rn+7DeecJANyQh/H
 sPUL+Vn9aeb7RWEB5jJ1LQ1AEg5fb3BCq03+2rZp6ftBjPsrsfyB297/yyIajEIZzqZF
 qoNlqTTFwJyR02DuwQXxaUJFwGVPChI54SNBWqGP4wRPmo5ywq5TOHmkKeRCHKzaWlR2
 +BTg==
X-Gm-Message-State: AOJu0YxXklrJyLJtY/pam60CzDn5btq+AHJjDlcUREhGJ2D2aCOich/Y
 /S+0VqV/BnnLixjhaDHN08DWZbxiI8f6yH866cGp94ngFPPZ9DWyEO/rzuqSuK5YdlTVdIubCRi
 s7w6nnfYVfZBb4RIoEXaUgXfFbQcI/PrH6CL0e9FOxCvyHFC9VXMTah8=
X-Gm-Gg: AZuq6aL2ZK2ffGHfByPGzL6t2ubW5AkiKNlx8cKkYpIsJVKM/wYrS9bU45oCAJBSd57
 HwLls3mFjP3ljvyZfB8hJXZyUlzV6MPMcuNdFkqB4UekpuhFFwtXZcPlvwryDXmzMTDzQI6XZ06
 7YnrQeuXQDlOsBlx2F3SjChW4XiEdSG5oV/US1TRkLBq9FU8es6+wFCPDhkjNMr5x1FoX4VtHl8
 nWZebvljFidIO+UGEFyiY6AbVTn1QmznSaL8uupRu0HyLqFFBbzPGVti3ay8rbzZ8zBRw8=
X-Received: by 2002:a17:90b:3901:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-354b3cae0d0mr866371a91.24.1770343244900; Thu, 05 Feb 2026
 18:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-3-8d8ff0035372@bsdimp.com>
 <973e564e-73a4-4b15-b83e-1aea1b043e47@linaro.org>
In-Reply-To: <973e564e-73a4-4b15-b83e-1aea1b043e47@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 19:00:33 -0700
X-Gm-Features: AZwV_QjmXjY5Zkhhkw-lBWuLJCCJBnpd7U7L6LlRIGTHb-X7aYH4R_hb_2HVm7Q
Message-ID: <CANCZdfr-3_MPadbpp6EVfPkt1zoDsdkp6LyvLZubnnUvh-fEZQ@mail.gmail.com>
Subject: Re: [PATCH 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e3c38064a1e28b2"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
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

--0000000000003e3c38064a1e28b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:15=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > Add the target ABI definitions for System V semaphore and message queue
> > data structures, needed for semctl() and msgctl() syscall emulation.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> >
> > diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> > index cc4b484f3a..98bdf8cc1a 100644
> > --- a/bsd-user/syscall_defs.h
> > +++ b/bsd-user/syscall_defs.h
> > @@ -92,6 +92,39 @@ struct bsd_shm_regions {
> >       abi_long size;
> >   };
> >
> > +/*
> > + * sys/sem.h
> > + */
> > +struct target_semid_ds {
> > +    struct target_ipc_perm sem_perm; /* operation permission struct */
> > +    abi_ulong   sem_base;   /* pointer to first semaphore in set */
>
> While they'll be the same underlying type, abi_ptr is "more correct".
>
> > +    uint16_t    sem_nsems;  /* number of sems in set */
>
> abi_ushort.
>
> > +struct target_msqid_ds {
> > +    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
> > +    abi_ulong   msg_first;  /* first message in the queue */
> > +    abi_ulong   msg_last;   /* last message in the queue */
>
> Both abi_ptr.
>


Nice catch on all of these. Will fix in v2.

Warner

>
> r~
>
>

--0000000000003e3c38064a1e28b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 5:15=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; Add the target ABI definitions for System V semaphore and message queu=
e<br>
&gt; data structures, needed for semctl() and msgctl() syscall emulation.<b=
r>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mikael Urankar &lt;<a href=3D"mailto:mikael.urankar@gma=
il.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A01 file changed, 33 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
&gt; index cc4b484f3a..98bdf8cc1a 100644<br>
&gt; --- a/bsd-user/syscall_defs.h<br>
&gt; +++ b/bsd-user/syscall_defs.h<br>
&gt; @@ -92,6 +92,39 @@ struct bsd_shm_regions {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long size;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * sys/sem.h<br>
&gt; + */<br>
&gt; +struct target_semid_ds {<br>
&gt; +=C2=A0 =C2=A0 struct target_ipc_perm sem_perm; /* operation permissio=
n struct */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0sem_base;=C2=A0 =C2=A0/* pointer =
to first semaphore in set */<br>
<br>
While they&#39;ll be the same underlying type, abi_ptr is &quot;more correc=
t&quot;.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 sem_nsems;=C2=A0 /* number of sem=
s in set */<br>
<br>
abi_ushort.<br>
<br>
&gt; +struct target_msqid_ds {<br>
&gt; +=C2=A0 =C2=A0 struct=C2=A0 target_ipc_perm msg_perm; /* msg queue per=
mission bits */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0msg_first;=C2=A0 /* first message=
 in the queue */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0msg_last;=C2=A0 =C2=A0/* last mes=
sage in the queue */<br>
<br>
Both abi_ptr.<br></blockquote><div><br></div><div><br></div><div>Nice catch=
 on all of these. Will fix in v2.</div><div><br></div><div>Warner=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
<br>
</blockquote></div></div>

--0000000000003e3c38064a1e28b2--

