Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C6DD5CCAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69Wj-0008LF-7m; Wed, 30 Oct 2024 10:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t69WT-0008I7-7a; Wed, 30 Oct 2024 10:18:11 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t69WQ-0001ap-0S; Wed, 30 Oct 2024 10:18:08 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso5696445a12.2; 
 Wed, 30 Oct 2024 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730297883; x=1730902683; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJmJ20THFnIcC53RQa41yl5zTrD9wJ2uzgCdDYyeOoQ=;
 b=f5K2QYE0rL7Kax3rt2UDguaXbEu9p+vhAzIxsa8VCW8RemXZXxL2q9zhi0wYrDpUTh
 vVMylEQT2Di0B4yuMqFZVe3qPDFEwyWcI4JcziLWWYTstloe+on36LCcaG3cWjI/DHKI
 pjlmwmlGY/DXyaus1PxHbGyDegmOk7xJYpeUzeZDU/eb/kXYKc/HldFbD1KMR7gqLNcy
 fT+t6uMTRVV7RHhCRR5+2o6rduLkB3hxFjgvyw9CsoeGU9nIAvBtOVBQurAegT9R7xoe
 IvgCqC1epznX5W3p/6cN9f5CNjd3bp8oI43KMbdsI6z6A8X7iclFv1gI2szuAeuZjo5l
 gb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730297883; x=1730902683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJmJ20THFnIcC53RQa41yl5zTrD9wJ2uzgCdDYyeOoQ=;
 b=htgT1P5l+UPfiWoObWtWqZf7b/OGchQfHd+Xd6zedk5xc13+efEYrmWB25yRyiZQDl
 3a5jOoWZY/M5p4z/NzzusoOH/CcVQYGoe9+eWYHdxX6Xag7pVal8QHWoM6YIHuqYJdnA
 08qyqltCaD4ZT4vaWhDt7Qq83IKvMMfhIW3QXZExlSvBEJhUbuUiSCcKCdXJxhYwtLRn
 Q5aTn5giwkHBpJSyarfXZMHUNJXCngAOfmheQ6GfN4T2Zqbw8AdweJEiF37Mx6zrMvUR
 6F1IixHA5lYMJijCL0fEYmWkqhi0HOP6z+0S5TMR0XadLEbLhBy6FHztwLDAUJ38CWwb
 3xKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+V/Y7kJzmc7SjzC7Gt9/p9HMGr3jGcqzWSPKfNjX9sUiz/fXfgWPPJNTb/gLFbZ11htPRbLtjZeJPBQ==@nongnu.org,
 AJvYcCWYg0OappymSwu7EqjEj18OqEplhPgh9Bxn+/UhFFnTZJvo+PYUZ4aUq+XXkrF3U6VBzKU9WJaMNbq/@nongnu.org
X-Gm-Message-State: AOJu0YyYhcymk9u9bT7nHFiSvG/rzikhJjYeTtsrOyuluhkl1Gse0ayX
 yHwhas8rTp2vimR+ZphH3xJ+h0N01yyjIax1iqvjjky+DZkN9Nbs/l+OeEmhPhqV1lg5Xxd1Kb1
 zZSTQS0QxASVt1io7NTkRZ0hYkuc=
X-Google-Smtp-Source: AGHT+IGkZuAfHgeIBobVushfP3V0CUbXjcxT2ybe4cdMTshXL0qs6UwIlOU5oWeB8BmVUjyLogzNkaoladtpIwuDM0I=
X-Received: by 2002:a05:6a21:2d05:b0:1d5:10d6:92b9 with SMTP id
 adf61e73a8af0-1d9a840b059mr18278365637.30.1730297882688; Wed, 30 Oct 2024
 07:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.com>
In-Reply-To: <d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Wed, 30 Oct 2024 17:17:49 +0300
Message-ID: <CAFukJ-D081Jta287S5XKtEch3CyzgFxJ-SQGF-VyU4j165DdBw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a7488b0625b25e3d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-pg1-x52a.google.com
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

--000000000000a7488b0625b25e3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Let's try to push it before EOY.
I'm planning to start working on it in the first half of November.
Does that work for you?

Thanks

=D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 20:40, Dan=
iel Henrique Barboza <
dbarboza@ventanamicro.com>:

> Hi Alexey,
>
>
> Do you have plans to post a new version of this series? Aside from a few
> comments
> it seems like this was almost there.
>
> We might not be able to get it merged in time for this current release
> (code freeze
> is Nov 5th) but we can get it in Alistair's tree for the next release.
>
>
> Thanks,
>
> Daniel
>
> On 5/11/24 7:10 AM, Alexey Baturo wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Hi,
> >
> > It looks like Pointer Masking spec has reached v1.0 and been frozen,
> > rebasing on riscv-to-apply.next branch and resubmitting patches.
> >
> > Thanks.
> >
> > [v8]:
> > Rebasing patches on current qemu branch and resubmitting them.
> >
> >
> > [v7]:
> > I'm terribly sorry, but previous rebase went wrong and somehow I missed
> it.
> > This time I double-checked rebased version.
> > This patch series is properly rebased on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> >
> > [v6]:
> > This patch series is rebased on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> >
> > [v5]:
> > This patch series targets Zjpm v0.8 extension.
> > The spec itself could be found here:
> https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c9=
08cbeb7cf5c5d1d/zjpm-spec.pdf
> > This patch series is updated after the suggested comments:
> > - add "x-" to the extension names to indicate experimental
> >
> > [v4]:
> > Patch series updated after the suggested comments:
> > - removed J-letter extension as it's unused
> > - renamed and fixed function to detect if address should be sign-extend=
ed
> > - zeroed unused context variables and moved computation logic to anothe=
r
> patch
> > - bumped pointer masking version_id and minimum_version_id by 1
> >
> > [v3]:
> > There patches are updated after Richard's comments:
> > - moved new tb flags to the end
> > - used tcg_gen_(s)extract to get the final address
> > - properly handle CONFIG_USER_ONLY
> >
> > [v2]:
> > As per Richard's suggestion I made pmm field part of tb_flags.
> > It allowed to get rid of global variable to store pmlen.
> > Also it allowed to simplify all the machinery around it.
> >
> > [v1]:
> > It looks like Zjpm v0.8 is almost frozen and we don't expect it change
> drastically anymore.
> > Compared to the original implementation with explicit base and mask
> CSRs, we now only have
> > several fixed options for number of masked bits which are set using
> existing CSRs.
> > The changes have been tested with handwritten assembly tests and LLVM
> HWASAN
> > test suite.
> >
> > Alexey Baturo (6):
> >    target/riscv: Remove obsolete pointer masking  extension code.
> >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
> >      of Zjpm v0.8
> >    target/riscv: Add helper functions to calculate current number of
> >      masked bits for pointer masking
> >    target/riscv: Add pointer masking tb flags
> >    target/riscv: Update address modify functions to take into account
> >      pointer masking
> >    target/riscv: Enable updates for pointer masking variables and thus
> >      enable pointer masking extension
> >
> >   target/riscv/cpu.c           |  21 +--
> >   target/riscv/cpu.h           |  46 +++--
> >   target/riscv/cpu_bits.h      |  90 +---------
> >   target/riscv/cpu_cfg.h       |   3 +
> >   target/riscv/cpu_helper.c    |  97 +++++-----
> >   target/riscv/csr.c           | 337 ++--------------------------------=
-
> >   target/riscv/machine.c       |  20 +--
> >   target/riscv/pmp.c           |  13 +-
> >   target/riscv/pmp.h           |  11 +-
> >   target/riscv/tcg/tcg-cpu.c   |   5 +-
> >   target/riscv/translate.c     |  46 ++---
> >   target/riscv/vector_helper.c |  15 +-
> >   12 files changed, 158 insertions(+), 546 deletions(-)
> >
>

--000000000000a7488b0625b25e3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div><br></div><div>Let&#39;s try to push it bef=
ore EOY.</div><div>I&#39;m planning to start working on it in the first hal=
f of November.</div><div>Does that work for you?</div><div><br></div><div>T=
hanks</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">=D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2=
 20:40, Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro=
.com">dbarboza@ventanamicro.com</a>&gt;:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi Alexey,<br>
<br>
<br>
Do you have plans to post a new version of this series? Aside from a few co=
mments<br>
it seems like this was almost there.<br>
<br>
We might not be able to get it merged in time for this current release (cod=
e freeze<br>
is Nov 5th) but we can get it in Alistair&#39;s tree for the next release.<=
br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
On 5/11/24 7:10 AM, Alexey Baturo wrote:<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; It looks like Pointer Masking spec has reached v1.0 and been frozen,<b=
r>
&gt; rebasing on riscv-to-apply.next branch and resubmitting patches.<br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; [v8]:<br>
&gt; Rebasing patches on current qemu branch and resubmitting them.<br>
&gt; <br>
&gt; <br>
&gt; [v7]:<br>
&gt; I&#39;m terribly sorry, but previous rebase went wrong and somehow I m=
issed it.<br>
&gt; This time I double-checked rebased version.<br>
&gt; This patch series is properly rebased on <a href=3D"https://github.com=
/alistair23/qemu/tree/riscv-to-apply.next" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/alistair23/qemu/tree/riscv-to-apply.next</a><br>
&gt; <br>
&gt; [v6]:<br>
&gt; This patch series is rebased on <a href=3D"https://github.com/alistair=
23/qemu/tree/riscv-to-apply.next" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/alistair23/qemu/tree/riscv-to-apply.next</a><br>
&gt; <br>
&gt; [v5]:<br>
&gt; This patch series targets Zjpm v0.8 extension.<br>
&gt; The spec itself could be found here: <a href=3D"https://github.com/ris=
cv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spe=
c.pdf" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-=
j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf</a>=
<br>
&gt; This patch series is updated after the suggested comments:<br>
&gt; - add &quot;x-&quot; to the extension names to indicate experimental<b=
r>
&gt; <br>
&gt; [v4]:<br>
&gt; Patch series updated after the suggested comments:<br>
&gt; - removed J-letter extension as it&#39;s unused<br>
&gt; - renamed and fixed function to detect if address should be sign-exten=
ded<br>
&gt; - zeroed unused context variables and moved computation logic to anoth=
er patch<br>
&gt; - bumped pointer masking version_id and minimum_version_id by 1<br>
&gt; <br>
&gt; [v3]:<br>
&gt; There patches are updated after Richard&#39;s comments:<br>
&gt; - moved new tb flags to the end<br>
&gt; - used tcg_gen_(s)extract to get the final address<br>
&gt; - properly handle CONFIG_USER_ONLY<br>
&gt; <br>
&gt; [v2]:<br>
&gt; As per Richard&#39;s suggestion I made pmm field part of tb_flags.<br>
&gt; It allowed to get rid of global variable to store pmlen.<br>
&gt; Also it allowed to simplify all the machinery around it.<br>
&gt; <br>
&gt; [v1]:<br>
&gt; It looks like Zjpm v0.8 is almost frozen and we don&#39;t expect it ch=
ange drastically anymore.<br>
&gt; Compared to the original implementation with explicit base and mask CS=
Rs, we now only have<br>
&gt; several fixed options for number of masked bits which are set using ex=
isting CSRs.<br>
&gt; The changes have been tested with handwritten assembly tests and LLVM =
HWASAN<br>
&gt; test suite.<br>
&gt; <br>
&gt; Alexey Baturo (6):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Remove obsolete pointer masking=C2=A0 exten=
sion code.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add new CSR fields for S{sn,mn,m}pm extensi=
ons as part<br>
&gt;=C2=A0 =C2=A0 =C2=A0 of Zjpm v0.8<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add helper functions to calculate current n=
umber of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 masked bits for pointer masking<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add pointer masking tb flags<br>
&gt;=C2=A0 =C2=A0 target/riscv: Update address modify functions to take int=
o account<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pointer masking<br>
&gt;=C2=A0 =C2=A0 target/riscv: Enable updates for pointer masking variable=
s and thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enable pointer masking extension<br>
&gt; <br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 21 +--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 46 +++--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 90 +--=
-------<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A03 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 |=C2=A0 97 +++++---=
--<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 337 ++---------------------------------<br>
&gt;=C2=A0 =C2=A0target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
0 +--<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 13 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 11 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<=
br>
&gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 46 ++-=
--<br>
&gt;=C2=A0 =C2=A0target/riscv/vector_helper.c |=C2=A0 15 +-<br>
&gt;=C2=A0 =C2=A012 files changed, 158 insertions(+), 546 deletions(-)<br>
&gt; <br>
</blockquote></div>

--000000000000a7488b0625b25e3d--

