Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077F2E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkIx-00015V-AU; Mon, 06 Jan 2025 05:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkIv-0000zs-UO; Mon, 06 Jan 2025 05:25:50 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkIs-0000Gy-Oy; Mon, 06 Jan 2025 05:25:48 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso22582720a12.2; 
 Mon, 06 Jan 2025 02:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159145; x=1736763945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rOadcJDJQeDZDmNKfXvyeXSGvkJ8Zx69KEbZI8PVVRM=;
 b=PD5n45tkH/XX2vihW0vsl5Qoace8kW+vGodQCuV97V99xKB0ts0uRD7cT4oOqEoo4H
 rKFPYEs7p5eTsw4v7t+9UkrH2zahq4ELYsrslktnXdj7dmxgaT1w4wGN5sV4aKLlF4zb
 N/6E3y7f3vNYZHkjcACSia/FYNiptlHwBJKhR8uh0TtnlyW0i0C8JWwMhY6Iu30GpnZb
 igMXLQ9qZUSHvI+wLpqBgiNTgDrpLUDzWYE/S3csPzkfw/dHsVFG5JFVkxwSr9u6JyxZ
 0rMgr5urdER2zsct/n8KiTASNBGxzJtD8sLT/OCZU2SNwxATJUJUgmWLdOw/jeYeeo0B
 jX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159145; x=1736763945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOadcJDJQeDZDmNKfXvyeXSGvkJ8Zx69KEbZI8PVVRM=;
 b=gt2I05iOENXlbhmwpHUS1/OWp8lgr0EwTpfU2QBy7Of+Bk962NjIJM+SrGMVi3UH7I
 JfoKBkG1n5JasWfTlSZdBOf7zhzR+ab0POMTr39CxvzOduB3A4EXTo1hcbo6G0jU8SSG
 iTKNDGkcmjniInii/3Ej+X9FCrv9eCE6hje6V9UTW0sBiEGSBIs9QbBqIeEcTeoik4Lo
 eHzB6zoDSDvJ+55zvwB6GvpxBI+WtEzaC1D6oLQclDCLy1+744ngQ9EULxjqDm617TfX
 uDDccHj9C+vWqmaqRTgHwv6kh3hzRsuqeZD9mtrgr1KeJDpD66tVy5A3xdk27gV38zjj
 vpXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+uCfigR/qOQ1ETSnmCsnCQqEnVj/npDZpCPfeSSU0CU5duAMefhuC1hkZAOz9JONZwJxHRj/UycDE@nongnu.org,
 AJvYcCV2dOiKzD6kdXt6jEYWCU6lKaNuch659w5+VeY/4plG2OSr7MOfRVi/atgX/ZOoH4Eu3RcC3e6Lm/Fmdg==@nongnu.org
X-Gm-Message-State: AOJu0YwYBJjO6TAZnbMElYtWiA2QTkLsRWwb5Qvilw3LA7Mz940tkusi
 MdFzwhNcaFKNmzoEHbe9/Z9+8DieVHkF1m6EgiOEXbB33pw+sqn02AgEtUQhQtLyTRZzcaX+5/P
 8IowNua8lvXAPcgIx+yGjR2e0xpU=
X-Gm-Gg: ASbGncsA2m/jWONQXUwMz2OjKGO4AFgUYo7cyu146+vIHHQrat/urOzssgtLcXWk7HC
 qhydJ3hm3PpS+i64qgPaWXeQeD8ho11DMvRpAAA==
X-Google-Smtp-Source: AGHT+IE7nK4aUgs5qgFB0DjJwjDjGvH4vz2yv9KoQ6tzCdgOOSgZHKZQEi7D3OCOBJAIKmttmio3Awp1ugYjHEM7QPg=
X-Received: by 2002:a05:6402:3216:b0:5d0:9974:7da2 with SMTP id
 4fb4d7f45d1cf-5d81dda8403mr54195426a12.19.1736159144469; Mon, 06 Jan 2025
 02:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
 <CAKmqyKM8F0ziHKCX9ZeQdqugGM=gesBHiX9sUCwoxVT2ZfMvVA@mail.gmail.com>
In-Reply-To: <CAKmqyKM8F0ziHKCX9ZeQdqugGM=gesBHiX9sUCwoxVT2ZfMvVA@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Mon, 6 Jan 2025 13:25:33 +0300
Message-ID: <CAFukJ-C2jk9JVBkdMBr7P0ykAToCJch9O5OFhZbPUmtcsjRt+Q@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] Pointer Masking update for Zjpm v1.0
To: Alistair Francis <alistair23@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000146cbb062b070d93"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x535.google.com
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

--000000000000146cbb062b070d93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

I rebased these patches against riscv-to-apply.next and resubmitted them.

Thanks

=D0=BF=D0=BD, 6 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 06:36, Alis=
tair Francis <alistair23@gmail.com>:

> On Tue, Dec 17, 2024 at 6:57=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
> >
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Hi,
> >
> > Rebased and addressed Alistair's comments on code style.
> >
> > Thanks
> >
> > [v13]:
> > Rebased and addressed Daniel's comments about the return type of the
> helper.
> >
> > Thanks
> >
> > [v12]:
> > Rebased and addressed Richard's comments about proper masking
> virtualized accesses.
> >
> > Thanks
> >
> > [v11]:
> > As suggested on the mailing list by Daniel, I'm resubmitting this serie=
s
> and keeping the original versioning number.
> > So that makes this one v11 and previous - v10.
> > Also I applied previously issues reviewed-by tags on some of the patche=
s
> that were present in v9 series, but only for the code, that didn't change
> much.
> > For the others I'd really like to have them reviewed as there were a lo=
t
> of comments on v9 series.
> > Also rebased on the current upstream.
> >
> > Thanks
> >
> > [v10]:
> > I've rebased this patch series and addressed Richard's and Daniel's
> comments.
> > Thanks
> >
> > [v0]:
> > As Pointer Masking is finally ratified, these patches intend to update
> the existing code to the final version.
> > These patches have been submitted previously and I tried to address all
> the suggestions, but I'd suggest to review them from the clean slate and
> then finally push them to the repo.
> > Thanks.
> >
> > Alexey Baturo (7):
> >   target/riscv: Remove obsolete pointer masking extension code.
> >   target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
> >     of Zjpm v1.0
> >   target/riscv: Add helper functions to calculate current number of
> >     masked bits for pointer masking
> >   target/riscv: Add pointer masking tb flags
> >   target/riscv: Update address modify functions to take into account
> >     pointer masking
> >   target/riscv: Apply pointer masking for virtualized memory accesses
> >   target/riscv: Enable updates for pointer masking variables and thus
> >     enable pointer masking extension
>
> This is all reviewed, but doesn't apply to
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> unfortunatley. Do you mind rebasing and hopefully this should then be
> merged :)
>
> Alistair
>
> >
> >  target/riscv/cpu.c           |  19 +-
> >  target/riscv/cpu.h           |  50 ++---
> >  target/riscv/cpu_bits.h      |  91 +--------
> >  target/riscv/cpu_cfg.h       |   3 +
> >  target/riscv/cpu_helper.c    | 128 +++++++++----
> >  target/riscv/csr.c           | 357 +++--------------------------------
> >  target/riscv/internals.h     |  54 ++++++
> >  target/riscv/machine.c       |  17 +-
> >  target/riscv/op_helper.c     |  16 +-
> >  target/riscv/pmp.c           |  14 +-
> >  target/riscv/pmp.h           |   1 +
> >  target/riscv/tcg/tcg-cpu.c   |   5 +-
> >  target/riscv/translate.c     |  47 ++---
> >  target/riscv/vector_helper.c |   5 -
> >  14 files changed, 257 insertions(+), 550 deletions(-)
> >
> > --
> > 2.39.5
> >
>

--000000000000146cbb062b070d93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<div><br></div><div>I rebased these patches ag=
ainst riscv-to-apply.next and resubmitted them.</div><div><br></div><div>Th=
anks</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 6 =D1=8F=D0=BD=D0=B2. 2025=E2=
=80=AF=D0=B3. =D0=B2 06:36, Alistair Francis &lt;<a href=3D"mailto:alistair=
23@gmail.com">alistair23@gmail.com</a>&gt;:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Tue, Dec 17, 2024 at 6:57=E2=80=AFPM &lt;<a =
href=3D"mailto:baturo.alexey@gmail.com" target=3D"_blank">baturo.alexey@gma=
il.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Rebased and addressed Alistair&#39;s comments on code style.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; [v13]:<br>
&gt; Rebased and addressed Daniel&#39;s comments about the return type of t=
he helper.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; [v12]:<br>
&gt; Rebased and addressed Richard&#39;s comments about proper masking virt=
ualized accesses.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; [v11]:<br>
&gt; As suggested on the mailing list by Daniel, I&#39;m resubmitting this =
series and keeping the original versioning number.<br>
&gt; So that makes this one v11 and previous - v10.<br>
&gt; Also I applied previously issues reviewed-by tags on some of the patch=
es that were present in v9 series, but only for the code, that didn&#39;t c=
hange much.<br>
&gt; For the others I&#39;d really like to have them reviewed as there were=
 a lot of comments on v9 series.<br>
&gt; Also rebased on the current upstream.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; [v10]:<br>
&gt; I&#39;ve rebased this patch series and addressed Richard&#39;s and Dan=
iel&#39;s comments.<br>
&gt; Thanks<br>
&gt;<br>
&gt; [v0]:<br>
&gt; As Pointer Masking is finally ratified, these patches intend to update=
 the existing code to the final version.<br>
&gt; These patches have been submitted previously and I tried to address al=
l the suggestions, but I&#39;d suggest to review them from the clean slate =
and then finally push them to the repo.<br>
&gt; Thanks.<br>
&gt;<br>
&gt; Alexey Baturo (7):<br>
&gt;=C2=A0 =C2=A0target/riscv: Remove obsolete pointer masking extension co=
de.<br>
&gt;=C2=A0 =C2=A0target/riscv: Add new CSR fields for S{sn,mn,m}pm extensio=
ns as part<br>
&gt;=C2=A0 =C2=A0 =C2=A0of Zjpm v1.0<br>
&gt;=C2=A0 =C2=A0target/riscv: Add helper functions to calculate current nu=
mber of<br>
&gt;=C2=A0 =C2=A0 =C2=A0masked bits for pointer masking<br>
&gt;=C2=A0 =C2=A0target/riscv: Add pointer masking tb flags<br>
&gt;=C2=A0 =C2=A0target/riscv: Update address modify functions to take into=
 account<br>
&gt;=C2=A0 =C2=A0 =C2=A0pointer masking<br>
&gt;=C2=A0 =C2=A0target/riscv: Apply pointer masking for virtualized memory=
 accesses<br>
&gt;=C2=A0 =C2=A0target/riscv: Enable updates for pointer masking variables=
 and thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0enable pointer masking extension<br>
<br>
This is all reviewed, but doesn&#39;t apply to<br>
<a href=3D"https://github.com/alistair23/qemu/tree/riscv-to-apply.next" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/alistair23/qemu/tree/r=
iscv-to-apply.next</a><br>
unfortunatley. Do you mind rebasing and hopefully this should then be<br>
merged :)<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 19 +-<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 50 ++---<br>
&gt;=C2=A0 target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 91 +--------=
<br>
&gt;=C2=A0 target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03=
 +<br>
&gt;=C2=A0 target/riscv/cpu_helper.c=C2=A0 =C2=A0 | 128 +++++++++----<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 357=
 +++--------------------------------<br>
&gt;=C2=A0 target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 54 ++++++<br=
>
&gt;=C2=A0 target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<b=
r>
&gt;=C2=A0 target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
&gt;=C2=A0 target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 14 +-<br>
&gt;=C2=A0 target/riscv/pmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 +<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 47 ++---<br>
&gt;=C2=A0 target/riscv/vector_helper.c |=C2=A0 =C2=A05 -<br>
&gt;=C2=A0 14 files changed, 257 insertions(+), 550 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.39.5<br>
&gt;<br>
</blockquote></div>

--000000000000146cbb062b070d93--

