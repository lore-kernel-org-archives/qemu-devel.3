Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7EEFB7F0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8eB-0000TE-3W; Wed, 25 Feb 2026 01:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vv8e6-0000R5-Mg
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:45:18 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vv8e3-0006mV-1J
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:45:17 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c6e266a3572so2200737a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 22:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772001909; cv=none;
 d=google.com; s=arc-20240605;
 b=NOt6x/pG9OPS5mH6Z48nZIatFQjnYz7ptts8qCg7byyIHjfpDAIayzgLH9hUOWMkn+
 W0RbKQtfuWccZf1Gr/ibi5QenbP0TqmqW5dRmQXNdEKTEhfIgI9qIna+mZf5ltl8Fk9c
 dgoZcAc64lq8Obb/3vZP7/s21LZJDzXhlfAI1PCgXsAxnuSdxBQ7v1b64OJzaRFqRAwX
 2KLXNTZ4JGoXVd0zt6ptM2Bo02jF9MM5E25vXYNov0gnS3wPhqQTRp5NfMeTusW0bzqX
 UvhiXHxek7C+ia1t+Exd56EW8PG57iRtzcWFwhxhtERPRohpIFkToeOyM+FlmbsjqXgV
 Xa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UHirPAWl1EqBbZxJ5Mg6Vu8lvj0fTapqaiO1cYxRG2I=;
 fh=l9Y7gnYhJyQDHhkQXWU1XTclPbcrjMu2/jcrdPcGToU=;
 b=avf3tqJvZ+ALia6fcQEJ4zkM8N/zrOmLO+O5WsGV+fbWr7qv2bCydwJUcoGJfNxNRD
 4puVLRZCh6xQ8lwX3e/F9uo6xoGG/qrlOASL7P2OqYG9rDMeiDn77vEDAK/kTOQIb+V5
 epIk9nNJwiu5F0OrI+TQdRj+N1TFZDlZhQaW7UBgk4UNtBE/U+OBCLRgpuvVP44AAM3K
 x4C0GHzoyYqmcVGJgqa0RsFsNRu0d4Z4qQiDmBWrzMrpEJ3bVC5dPWh+353+/VfmGP/E
 4QVW5HcSdNZTdpVPLAYusggfIz3/tuB+NpQgKjjMHIet4xqjFnEJomBpJiET6D5cl1ZA
 aI9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772001909; x=1772606709;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHirPAWl1EqBbZxJ5Mg6Vu8lvj0fTapqaiO1cYxRG2I=;
 b=WVeYqfGdPCE8t/tJa23MhAEpOWaoofm+wUtpy+aX+I2pbqMPEHBIJ4GPgCcKV95F95
 BP83CrQJ02sFE55tUagK8UTCwHxwXmdmQ71xey6WVZ5i8AMIvKUXUCyyfR2dMQL26T5K
 6beEoD+UBP+jBL5jYmsJC+aANCQndZC/OHra3gmzHzjCHg9W+1b5jUvXPkDj6O8DUqHh
 zYm51Z21Dg6sYWQUVmF2o+D6larO0H15XubBgmFq92/8N01NWW1aqPfkDJS+ximgKN0O
 Gmy2ei0bhCuVSpoY/VF8qfmJOiUGH5O1GUSI5htCzh1Q+Mv/MOgctxZrjb6joX/GIG0R
 FIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772001909; x=1772606709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHirPAWl1EqBbZxJ5Mg6Vu8lvj0fTapqaiO1cYxRG2I=;
 b=BfUvbEbENACKtslYlt8lEcn13tn9bAXHda0/lNWkKGO90OyNXiMcgmy6Phwm+XCPwK
 k+xDRvdc6kE1fBi8iMHg2IIsJ/Rz/gRkLEOwoFNtWk+Kk4xez+LY1XrGIuT5sAQP3gFe
 Cwo+L79lRl1guHJFcKCsDK6HStOgZfAKd2VWx+W8++2CoRQP0ay0w4tRGpOiVBoXHzD8
 B/DJpQOk/vX3fTfYzt0wdnOhglT1QI54dxbXVJ/2RFuS3XEGdg+/tzyXJxWKYa/rDX18
 dh5j+RiAxdXsHhksWat0Toak0y1Ti9L3UxcS0NLe2q1TOj0cJLrWXJiX+5411i2WXXkX
 TbWg==
X-Gm-Message-State: AOJu0Yzu2tm6u0twg7LkAN3sIoWMQ8O6sLUggGLOJbHR7XPVAlk6dP1+
 4I69dKLq0M5WCwg5BMEYkD4NWE1JwQXFmV7J8uoZapwxaZPPMhqfypjblQvxl3Mi05nwxqZdofP
 sgdQs6nwWKa2mjC190TRWMHx6ECNVdBK3nQBTVfio+ESUrkDsztIdprQ=
X-Gm-Gg: ATEYQzySxBeY4ESHCK4nKOgMp0hvLXcXlom6TXwAPrMNXZb+1seqTTlu68d1C2qQJru
 +urNssr4qKPA32TXmIYR7K88OQXKSart/F/huy/CtzatdkLvbOy6kK2w7C6YfXmQV55tzFEgi9g
 CmmCf6VovJ6bsfPmfmu1L8pKzkX6H4jJsDAXHE0DYGW+rIx9oS3PIlWFYLzo+47f4eSlqoOdC8W
 dD6SG+xs7oX/ARh1rb/RKCcLKnyQTRyn8N2deWCqMuWaN4MzplPfx/udOk8n3jEgPE0h/pKOTXN
 O4/7xlw=
X-Received: by 2002:a17:90b:2e0f:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-358ae8b23damr14404414a91.16.1772001909504; Tue, 24 Feb 2026
 22:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-3-8ee5ae17056f@bsdimp.com>
 <CALH631=ZoTDp3FzfKVoJ1orqdigPmw9gS8iR0BhKG9J4pVZkNQ@mail.gmail.com>
In-Reply-To: <CALH631=ZoTDp3FzfKVoJ1orqdigPmw9gS8iR0BhKG9J4pVZkNQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 23:44:57 -0700
X-Gm-Features: AaiRm51vwFJGKS2P0ol0q790Hm05mSW5Ls7gOdhJKOOIi8WMlYVN3UAnTJhqkME
Message-ID: <CANCZdfp1bHZgpdup5WViArVGU0J3iJVnCM4W23yxvBcqUMF-fw@mail.gmail.com>
Subject: Re: [PATCH v4 03/24] bsd-user: Add target_semid_ds and
 target_msqid_ds structures
To: Gleb Popov <arrowd@freebsd.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005b8ba3064ba05820"
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x531.google.com
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

--0000000000005b8ba3064ba05820
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 8:32=E2=80=AFAM Gleb Popov <arrowd@freebsd.org> wro=
te:

> On Tue, Feb 24, 2026 at 5:42=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrot=
e:
> >
> > +
> > +/*
> > + * sys/msg.h
> > + */
> > +struct target_msqid_ds {
> > +    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
> > +    abi_ptr     msg_first;  /* first message in the queue */
> > +    abi_ptr     msg_last;   /* last message in the queue */
> > +    abi_ulong   msg_cbytes; /* # of bytes in use on the queue */
> > +    abi_ulong   msg_qnum;   /* number of msgs in the queue */
> > +    abi_ulong   msg_qbytes; /* max # of bytes on the queue */
> > +    int32_t     msg_lspid;  /* pid of last msgsnd() */
> > +    int32_t     msg_lrpid;  /* pid of last msgrcv() */
> > +    target_time_t   msg_stime;  /* time of last msgsnd() */
> > +    target_time_t   msg_rtime;  /* time of last msgrcv() */
> > +    target_time_t   msg_ctime;  /* time of last msgctl() */
> > +};
> > +
> > +struct target_msgbuf {
>
> You might want to put
>
> /*
>  * sys/msgbuf.h
>  */
>
> before the struct target_msgbuf definition, just like it is done for
> struct target_msqid_ds
>

good catch. This was missing in bsd-user's blitz branch, but I'll add it
there too. Since it's trivial, I'm not going to resend unless I need a v5.

Warner

--0000000000005b8ba3064ba05820
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24,=
 2026 at 8:32=E2=80=AFAM Gleb Popov &lt;<a href=3D"mailto:arrowd@freebsd.or=
g">arrowd@freebsd.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Tue, Feb 24, 2026 at 5:42=E2=80=AFPM Warner Losh &l=
t;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt=
; wrote:<br>
&gt;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * sys/msg.h<br>
&gt; + */<br>
&gt; +struct target_msqid_ds {<br>
&gt; +=C2=A0 =C2=A0 struct=C2=A0 target_ipc_perm msg_perm; /* msg queue per=
mission bits */<br>
&gt; +=C2=A0 =C2=A0 abi_ptr=C2=A0 =C2=A0 =C2=A0msg_first;=C2=A0 /* first me=
ssage in the queue */<br>
&gt; +=C2=A0 =C2=A0 abi_ptr=C2=A0 =C2=A0 =C2=A0msg_last;=C2=A0 =C2=A0/* las=
t message in the queue */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0msg_cbytes; /* # of bytes in use =
on the queue */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0msg_qnum;=C2=A0 =C2=A0/* number o=
f msgs in the queue */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0msg_qbytes; /* max # of bytes on =
the queue */<br>
&gt; +=C2=A0 =C2=A0 int32_t=C2=A0 =C2=A0 =C2=A0msg_lspid;=C2=A0 /* pid of l=
ast msgsnd() */<br>
&gt; +=C2=A0 =C2=A0 int32_t=C2=A0 =C2=A0 =C2=A0msg_lrpid;=C2=A0 /* pid of l=
ast msgrcv() */<br>
&gt; +=C2=A0 =C2=A0 target_time_t=C2=A0 =C2=A0msg_stime;=C2=A0 /* time of l=
ast msgsnd() */<br>
&gt; +=C2=A0 =C2=A0 target_time_t=C2=A0 =C2=A0msg_rtime;=C2=A0 /* time of l=
ast msgrcv() */<br>
&gt; +=C2=A0 =C2=A0 target_time_t=C2=A0 =C2=A0msg_ctime;=C2=A0 /* time of l=
ast msgctl() */<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct target_msgbuf {<br>
<br>
You might want to put<br>
<br>
/*<br>
=C2=A0* sys/msgbuf.h<br>
=C2=A0*/<br>
<br>
before the struct target_msgbuf definition, just like it is done for<br>
struct target_msqid_ds<br></blockquote><div><br></div><div>good catch. This=
 was missing in bsd-user&#39;s blitz branch, but I&#39;ll add it there too.=
 Since it&#39;s trivial, I&#39;m not going to resend unless I need a v5.</d=
iv><div><br></div><div>Warner=C2=A0</div></div></div>

--0000000000005b8ba3064ba05820--

