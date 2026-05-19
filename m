Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B302CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOJR-0001BJ-Jw; Tue, 19 May 2026 13:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wPOJI-00014r-21
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:32:56 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wPOJB-0004Gg-GD
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:32:47 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so3316502a91.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211962; cv=none;
 d=google.com; s=arc-20240605;
 b=kwwspC9sbcj4JflPrMkXHM8I734ly2RjwVEyf+Bk4IPGbCVQt48Fr7W/6BluCmH0ec
 i9/HlUH3ENGThTJa7ALVW1fY78Js6MItZWIMLUGaf3TeXathcX60fZQK2mkf9E3bMivz
 WqAyrc6Ow50j3gFzKv/2acyiGvq2jG7mrENXFEzVsZkMgaU8pdZuybGheYvJ0JShFEnT
 oBDu+H4VJXJj9UZfer/6HZXnL6xnOgG3MKUmXg3zVjg14DvdVjuhR2a66fR8biMFZEet
 5ZPOvU4eSnFvs9xKzYxJzpK9Im1XGiEGa7AJplwlowqUThkiBAX0icrWWcQClt6BRfSM
 t6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kJrUr1kqqXY79wzU2NASoy/4B2UjG/HxM3yFhNPKGQA=;
 fh=oc95sRJdo3Mjfjp/egrNKP3OkecHKuGbWqKLHs0va7U=;
 b=Wtpb4nQi0995EsSEjDDSrsuIpwqkXEShX+5djmDtBryVCCU2NumIRiCQMgQDRjWexL
 zIfHXc2tAE3EQjIxw228cEWlrvHM6CHWnmEU0Fy5+CAwAm1ZEh3/h4vCEBO9/GcyTpqD
 Mcs+FR17zyFg/xoWhtKs8nxh854pZtj+NtGvLxfqWq6gzBnHD8gfNLowURpZecU35G3p
 xXl364SCXZ5MET/bkKYl7EvquVQ0W33rr2MFxf9kzKcHx32wzllkzwLijIerSlMzWZMs
 4imjPsdqckSipSgLd7qaE23dmIrqhZ+LM6tGXcQxh9mbJ/SifhYEXYzNblPnM/b8G+CB
 bySg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779211962; x=1779816762;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJrUr1kqqXY79wzU2NASoy/4B2UjG/HxM3yFhNPKGQA=;
 b=bckeWp/fX+ijxy8h++H+VIDy36yZUtWMPtnkKI1Zo+4l33nxWP1oXqddvBUvhRjvX9
 S/jzETKVXnLmFCHRmB/yzADaFUtayqVjQR4Wr1mfyoLxP20y5v241gDPmUF51CwKeUUG
 3BQxU0klA2YE6N+k+MLgmUkp/RD3c489JiF0YATf+E4ZYj1mZL8kifMrve7EnUP/AX91
 2XCNMOv1TNPD6L36bVDqRqIwjYGqEJogbFrwIWy+XBGIVbn4xIgwL3SvpVn4m41uVotC
 bFGyR1ZVesOWiwX8KNz+tFQFbPDKa+h2BBI51FJ2ZG6NnErWkF9lrsllJiRe6tPWgt6D
 7glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211962; x=1779816762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJrUr1kqqXY79wzU2NASoy/4B2UjG/HxM3yFhNPKGQA=;
 b=jGNNiG3qfNRCeNEFK+/INgXPGCnNcDpmHOI28A9pMamQKNZTxwybN5IMSH8/sGL7ro
 ujjiENyhljAEVttuTdKNcHJbNeEyXWSWDTen6t0VW4w0Xdeejl6F6NBs4uV9GAm3QOz9
 ryWc03TgV4YFCf+B1NbHL0wRPzmqPTM/1Cbu7/ywmiP52ucJtIweFhPl4Eqg5/43k0eu
 ev6bruTy9H8u2KuJ7w8xfkF+kVo4ULzXFV7aSZT7+6Y5So60aOj3PPGGLtunrFx9b1xh
 DuLUd5OUzuGGcnMiay63Uo8sBH30J+ILZuOpEtIs2QL5ZheH9ejXwBFuM5gOok7UWv+v
 atog==
X-Gm-Message-State: AOJu0YzZWTL/fdhNoYYMCwIX4gk5m4TGwmaoYfhYobdkYSWWKY317kzk
 f4fCy5Z7rYJzmcizJP/0dJnofiArwn9hnw9UDHGjnzSkUKkKk8MM+cuwiKr5BcJTr1caSRyAwpr
 F3j6ZfyBUHUcxeaLvfBetnESc00CyuFgLk03z7sL5SA==
X-Gm-Gg: Acq92OEdLkOyJ+cn4hSo2uxMgH+ZOkGNnW8ooCcdTtYFNO+5SZykj3qMTuD2VhEdmK9
 OjCr7vTLQPCK2JTGdeofF4F99EBiyXxeOOvOSqlb6Xu+oJQDJ5ZcY7mbp+nENDjK7XTMlud+cw4
 0wMDDLp+qLURueLDVWPE1w8KgDoCQ6bFP7KbWB4+8kWQN6qyvdbVcPK/4IUtdPLzfVo+ha+bC+O
 O/Lxiq01RwZapPrxEC+gnRtByzNrq4oqUt2x1LAbmfA4hrCbZJQIQHULwElg5/UxaYQ6WDDJyaE
 6Ny4tac=
X-Received: by 2002:a17:902:c943:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2bd7e927ae1mr232554635ad.29.1779211962023; Tue, 19 May 2026
 10:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-2-6c16fe448301@bsdimp.com>
 <2833f86b-6a86-4459-882c-0a6b71dfd4c8@oss.qualcomm.com>
In-Reply-To: <2833f86b-6a86-4459-882c-0a6b71dfd4c8@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 19 May 2026 11:32:29 -0600
X-Gm-Features: AVHnY4ICqIfK-67-bddD6k0oH9XVTT89gaKobwcbkXAPrIBm-4MqCiKiIKCwI_Q
Message-ID: <CANCZdfpNw4304XicymuDkE74oyKQag5ww=7CrwMiL19np382oA@mail.gmail.com>
Subject: Re: [PATCH v2 02/37] bsd-user: Rename cpu_env to env throughout
 bsd-user
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000fa100f06522f104f"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102a.google.com
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

--000000000000fa100f06522f104f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:05=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 4:27 PM, Warner Losh wrote:
> > Replace 'void *cpu_env' parameters with 'CPUArchState *env' across all
> > bsd-user source files. This improves type safety and aligns with the
> > convention used in the rest of the codebase.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/aarch64/target.h     |  2 +-
> >  bsd-user/arm/target.h         |  2 +-
> >  bsd-user/bsd-file.h           | 28 +++++++++++++--------------
> >  bsd-user/bsd-mem.h            |  4 ++--
> >  bsd-user/bsd-proc.h           |  6 +++---
> >  bsd-user/freebsd/os-proc.c    |  4 ++--
> >  bsd-user/freebsd/os-proc.h    | 26 ++++++++++++-------------
> >  bsd-user/freebsd/os-sys.c     |  4 ++--
> >  bsd-user/freebsd/os-syscall.c | 44
> +++++++++++++++++++++----------------------
> >  bsd-user/i386/target.h        |  2 +-
> >  bsd-user/qemu.h               |  6 +++---
> >  bsd-user/riscv/target.h       |  2 +-
> >  bsd-user/x86_64/target.h      |  2 +-
> >  13 files changed, 66 insertions(+), 66 deletions(-)
> >
>
> ...
>
> > diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> > index b1d4446ff1..62052c70b9 100644
> > --- a/bsd-user/bsd-proc.h
> > +++ b/bsd-user/bsd-proc.h
> > @@ -6,8 +6,8 @@
> >   * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> > -#ifndef BSD_PROC_H_
> > -#define BSD_PROC_H_
> > +#ifndef BSD_PROC_H
> > +#define BSD_PROC_H
> >
>
> Last patch of the series does the opposite change in comment associated
> to endif. We should pick one and stick to it consistently.
>

Ugg. OK. Good eye, I'll see if there's some good standard here. I hit a lot
of conflicts a while
back when the tree was normalized, so I'll make sure I just do that.

Warner

--000000000000fa100f06522f104f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 19,=
 2026 at 9:05=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 4:27 =
PM, Warner Losh wrote:<br>
&gt; Replace &#39;void *cpu_env&#39; parameters with &#39;CPUArchState *env=
&#39; across all<br>
&gt; bsd-user source files. This improves type safety and aligns with the<b=
r>
&gt; convention used in the rest of the codebase.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/aarch64/target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 bsd-user/arm/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +-<br>
&gt;=C2=A0 bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 28=
 +++++++++++++--------------<br>
&gt;=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 ++--<br>
&gt;=C2=A0 bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 +++---<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 26 ++++++++++++-------=
------<br>
&gt;=C2=A0 bsd-user/freebsd/os-sys.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 bsd-user/freebsd/os-syscall.c | 44 +++++++++++++++++++++--------=
--------------<br>
&gt;=C2=A0 bsd-user/i386/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
&gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 +++---<br>
&gt;=C2=A0 bsd-user/riscv/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<b=
r>
&gt;=C2=A0 bsd-user/x86_64/target.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 13 files changed, 66 insertions(+), 66 deletions(-)<br>
&gt; <br>
<br>
...<br>
<br>
&gt; diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
&gt; index b1d4446ff1..62052c70b9 100644<br>
&gt; --- a/bsd-user/bsd-proc.h<br>
&gt; +++ b/bsd-user/bsd-proc.h<br>
&gt; @@ -6,8 +6,8 @@<br>
&gt;=C2=A0 =C2=A0* SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt; -#ifndef BSD_PROC_H_<br>
&gt; -#define BSD_PROC_H_<br>
&gt; +#ifndef BSD_PROC_H<br>
&gt; +#define BSD_PROC_H<br>
&gt;<br>
<br>
Last patch of the series does the opposite change in comment associated<br>
to endif. We should pick one and stick to it consistently.<br></blockquote>=
<div><br></div><div>Ugg. OK. Good eye, I&#39;ll see if there&#39;s some goo=
d standard here. I hit a lot of conflicts a while</div><div>back when the t=
ree was normalized, so I&#39;ll make sure I just do that.</div><div><br></d=
iv><div>Warner=C2=A0</div></div></div>

--000000000000fa100f06522f104f--

