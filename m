Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D17D609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAkt-0002wJ-1j; Wed, 27 Nov 2024 00:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAkp-0002sy-CN; Wed, 27 Nov 2024 00:38:25 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAkm-0001eT-A0; Wed, 27 Nov 2024 00:38:22 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cfe5da1251so7661711a12.1; 
 Tue, 26 Nov 2024 21:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685898; x=1733290698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8EklJFOhtl3yzHo14MyR4oCu/gPy3s2sKhjutcxFUcQ=;
 b=ilnQYJ0YO34oB3xuySd5O6P7re6pSTBPt2kz7wOvAXhXDvSMhYun7RSv3SCQ9gxNs3
 4HyLYtqojY60Ix9i9pESOqDfxPrtH/A+M06y5ifv04fF47GJdU2nfqFz4vUrhTsilK9b
 XtkmqlbtneA732oDhOLK0fE59HG86DoAyEp6qw7XGilUPlGdbJEP5ZlA6uvslv9U0VQ1
 i//erpsi7pl2BuAqcUw8Yttqnc6pkXw7k599Kp4HEeyYUKnzfPykmOTREFrA+4FSQ32E
 BqU28IjUTndvnvIgcAkTogaCnegy/NTWwKbswGXUjAqm64JoZxPqQcqx3qFKHs2bWn5u
 yqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685898; x=1733290698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8EklJFOhtl3yzHo14MyR4oCu/gPy3s2sKhjutcxFUcQ=;
 b=n4OVg3KzyGut9ii9tEuQkw2O4+kwRWDIfALvkdrjyT+J/Vkx61abfMcXza7R8CVxvl
 5Va9lbTEv+ucDVvyP3AF1ikwEtGwTBxRh4GS7ma2dcyiEq/7j6pHEuyDi9epW0s8t0LR
 IPCxV7cx7No8JZjVY8BN9LCZ23JEwg1b8wVFmOWpyJfow4FTGP5Eh7EQ548jBvW58I3J
 nWr+QYBWdATwuz5hAVYlNTbpjerftQrxS7PQrJYXEE8X08QBNpT7wQxhhOyvWRsZJidK
 Ub2B0jUUGiNVfFH0l60uoGsewIxd0kucnN6avlK00w5Viq/oFfWv3lNqcfnBJAaaeT/E
 fh0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFjjTrx3O5jv7NJrmTIwzXvr9CkZ6JZV4T1nFVBfzvH/BdlHZ0AV9VztDU9ua2T8yPJh5530pxo+R+@nongnu.org,
 AJvYcCXdTpnmcZoPjN0p/bpJz/3YQke4OF5tVbkjapMRRqoBlibxFvdrivbshKSZ8kK5sACrxQW4QAlx76AlSw==@nongnu.org
X-Gm-Message-State: AOJu0Yx8RQCEGEFPg6HUeCow2paKC6DENbyBwHiesxfqoAnXkvxng8yH
 p1UvFTrYoxFWJWdldmaqkOnijaf09HelWO9CvaA1e2GKD++pkkUvXazA9E6vXeQ9GHjJ+I02SMB
 Rx4rsEolB3QoFA8CRGZT2edIsE1zWJUuw
X-Gm-Gg: ASbGncuX+bjuc1yZfjHJu0EPEP3apl90ZH6c7bHymm5dWcAwAFFLxEXbTGlETbLWz4b
 ZZJ2NzFxHSI8nczpkb0XCTIMa8B73AwA=
X-Google-Smtp-Source: AGHT+IE3bTWFac0DAbTAtSfg69AaeBL30Ek9J056qja2imA1RruyUBGip/NzDKbGYEhV/sUs9Hq4k5ugOgCZ0AXim0I=
X-Received: by 2002:a05:6402:274a:b0:5cf:cfa8:d6bd with SMTP id
 4fb4d7f45d1cf-5d080c98d7emr1242343a12.25.1732685898130; Tue, 26 Nov 2024
 21:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
 <f4aa9779-8d69-46ac-9923-3beecf760770@ventanamicro.com>
In-Reply-To: <f4aa9779-8d69-46ac-9923-3beecf760770@ventanamicro.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Wed, 27 Nov 2024 08:38:06 +0300
Message-ID: <CAFukJ-Aa9q27qH0RxzP0QsCgRJE7FJ73GH5x1DMaLiB-NVH83g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Pointer Masking update for Zjpm v1.0
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000772c280627de5f8f"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000772c280627de5f8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the suggestion. I've resubmitted it with the v11 tag and put
some reviewed-bys.

Thanks

=D0=BF=D0=BD, 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 16:3=
7, Daniel Henrique Barboza <
dbarboza@ventanamicro.com>:

> Hi Alexey,
>
>
> I believe this is not the second version of this work. When I asked about
> the
> next versions this was already in v9:
>
>
> https://lore.kernel.org/qemu-riscv/d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@v=
entanamicro.com/
>
> And it had most of the patches already reviewed by Alistair and Richard.
> So this
> would be in fact v11, with a lot of patches already reviewed.
>
> If you could re-send this series as v11, keeping reviewed-by tags from
> code that you
> didn't change from one version to the other, the review will go faster.
>
>
> Thanks,
>
> Daniel
>
> On 11/21/24 3:12 AM, baturo.alexey@gmail.com wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Hi,
> >
> > I've rebased this patch series and addressed Richard's and Daniel's
> comments.
> > Thanks
> >
> > *** BLURB HERE ***
> > [v0]:
> > As Pointer Masking is finally ratified, these patches intend to update
> the existing code to the final version.
> > These patches have been submitted previously and I tried to address all
> the suggestions, but I'd suggest to review them from the clean slate and
> then finally push them to the repo.
> > Thanks.
> >
> > Alexey Baturo (7):
> >    target/riscv: Remove obsolete pointer masking extension code.
> >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
> >      of Zjpm v1.0
> >    target/riscv: Add helper functions to calculate current number of
> >      masked bits for pointer masking
> >    target/riscv: Add pointer masking tb flags
> >    target/riscv: Update address modify functions to take into account
> >      pointer masking
> >    target/riscv: Apply pointer masking for virtualized memory accesses
> >    target/riscv: Enable updates for pointer masking variables and thus
> >      enable pointer masking extension
> >
> >   target/riscv/cpu.c                      |  19 +-
> >   target/riscv/cpu.h                      |  51 ++--
> >   target/riscv/cpu_bits.h                 |  91 +-----
> >   target/riscv/cpu_cfg.h                  |   3 +
> >   target/riscv/cpu_helper.c               | 124 +++++---
> >   target/riscv/csr.c                      | 357 ++---------------------=
-
> >   target/riscv/insn_trans/trans_rvh.c.inc |  11 +
> >   target/riscv/machine.c                  |  17 +-
> >   target/riscv/pmp.c                      |  14 +-
> >   target/riscv/pmp.h                      |   1 +
> >   target/riscv/tcg/tcg-cpu.c              |   5 +-
> >   target/riscv/translate.c                |  51 ++--
> >   target/riscv/vector_helper.c            |  18 +-
> >   13 files changed, 224 insertions(+), 538 deletions(-)
> >
>
>

--000000000000772c280627de5f8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div><br></div><div>Thanks for the suggestion. I=
&#39;ve resubmitted it with the v11 tag and put some reviewed-bys.</div><di=
v><br></div><div>Thanks</div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 25 =D0=BD=
=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 16:37, Daniel Henrique Barb=
oza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.=
com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi =
Alexey,<br>
<br>
<br>
I believe this is not the second version of this work. When I asked about t=
he<br>
next versions this was already in v9:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-riscv/d4241c7b-ae97-4dc1-bc60-5f0ee=
d58d3a5@ventanamicro.com/" rel=3D"noreferrer" target=3D"_blank">https://lor=
e.kernel.org/qemu-riscv/d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.c=
om/</a><br>
<br>
And it had most of the patches already reviewed by Alistair and Richard. So=
 this<br>
would be in fact v11, with a lot of patches already reviewed.<br>
<br>
If you could re-send this series as v11, keeping reviewed-by tags from code=
 that you<br>
didn&#39;t change from one version to the other, the review will go faster.=
<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
On 11/21/24 3:12 AM, <a href=3D"mailto:baturo.alexey@gmail.com" target=3D"_=
blank">baturo.alexey@gmail.com</a> wrote:<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; I&#39;ve rebased this patch series and addressed Richard&#39;s and Dan=
iel&#39;s comments.<br>
&gt; Thanks<br>
&gt; <br>
&gt; *** BLURB HERE ***<br>
&gt; [v0]:<br>
&gt; As Pointer Masking is finally ratified, these patches intend to update=
 the existing code to the final version.<br>
&gt; These patches have been submitted previously and I tried to address al=
l the suggestions, but I&#39;d suggest to review them from the clean slate =
and then finally push them to the repo.<br>
&gt; Thanks.<br>
&gt; <br>
&gt; Alexey Baturo (7):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Remove obsolete pointer masking extension c=
ode.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add new CSR fields for S{sn,mn,m}pm extensi=
ons as part<br>
&gt;=C2=A0 =C2=A0 =C2=A0 of Zjpm v1.0<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add helper functions to calculate current n=
umber of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 masked bits for pointer masking<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add pointer masking tb flags<br>
&gt;=C2=A0 =C2=A0 target/riscv: Update address modify functions to take int=
o account<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pointer masking<br>
&gt;=C2=A0 =C2=A0 target/riscv: Apply pointer masking for virtualized memor=
y accesses<br>
&gt;=C2=A0 =C2=A0 target/riscv: Enable updates for pointer masking variable=
s and thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enable pointer masking extension<br>
&gt; <br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 51 ++--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 91 +-----<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 124 +++++---<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 357 ++----------------------<br>
&gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_rvh.c.inc |=C2=A0 11 +<br>
&gt;=C2=A0 =C2=A0target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 51 ++--<br>
&gt;=C2=A0 =C2=A0target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 18 +-<br>
&gt;=C2=A0 =C2=A013 files changed, 224 insertions(+), 538 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000772c280627de5f8f--

