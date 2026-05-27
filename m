Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB02CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9YB-0007Q7-3m; Wed, 27 May 2026 04:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wS9Y8-0007Nq-Ri
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:23:36 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wS9Y6-0000vT-NZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:23:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so1924350066b.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 01:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779870213; cv=none;
 d=google.com; s=arc-20240605;
 b=ECUjNp4RdZ9Aw2vd8aGwoYLjUobIin75UIVjkzjGMRQ1bZUsRmLvjrtW+rbGHJ1FYL
 6hcjAiP34RcikBwhAfVgcpMbIGk6EKsebYAfV8/TnN9Pv6s3ic6F9S+MsjuG8gFPACO0
 Vg2VScyL5pUr7yr7I3L5NKGUEnhTfFigj3TqYdkfoy0ltU2wmsGm5un4sQBx3MVvTVjj
 zF0fq88kVLygd23tDRl8UzwsTDWiW3o9VAoAI8Oi/aEFys5xp5OXHD1YENXg5RZoQe3P
 NiFGc8PYw0oTU3fPB3i1K/+tWtJTkXjMtG1hXdls700MBGd1MXcgLCjda0eJSnjBre+d
 93fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xiwbDkD+/QsxegCzr7bnMZ2+ZQ8O9sEqNhsRz+DOnn8=;
 fh=tcUClgkt5PEWO4Moxo/Atg2M474lKCCy+6RAAxtuuqI=;
 b=VtfqhPUYKc92ntwGE+Fdkq5r4zaLDw1pz3aK4zDcuhxLq/t5jiFw/iTivBRkzLzhKy
 LgZuj9IxswzMUOEMq9TkShFG7euXMDB+pZWqgnuvK7hHk42TvyUSoa4kbRG7HI8XMnOM
 Cv8ycJNuSrYXYNn/3qmJZwUzLfb+q7LCqoc5ZUkv7W7OBoCkb7LGlmYPGlfVeJ6EF62E
 ht7NeTq0PuT4ni5vhRBmrRoRClHPh/OcNAJ6R8f4BKToeog6N5SCkvV5TlWk5WGR7goy
 mr31LOQNU1B3Y5/LUq/rCchZbxOdODiuJr1pBuP06H6d/iaRgo9xvxql11qMy5t8/21Q
 EXVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779870213; x=1780475013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xiwbDkD+/QsxegCzr7bnMZ2+ZQ8O9sEqNhsRz+DOnn8=;
 b=ltd02cdP1rJJCGj6R7ixAfiKnCF9d9NCLjwY0OgATC3OCb+YafgTPP8PIrgksvqlZI
 ABVuzQYIEglYvJL4qotEjAO2o5rTcxBpHH+mRmwyP6qQYkChepYLvjBjax8GuCmjNLXo
 FvMZJx4fdhAhYkQIR6lb/TExdDMBZeP1SluZ5klX5ygXjpsqqs4vA19b+qrxQi7VKLLz
 xCwMk7n8JedCRIQyPcZoJqGe+vSg4oW/N6ADfTy5BvILFz7qCK/2cQTzV7a93bFivDcI
 OYKwF6n75rJmShNPPtOyDDqXpY51P5EP/7m2mu32iCSjTazK69+xUjkbP7rJoNbn5k0f
 iEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779870213; x=1780475013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiwbDkD+/QsxegCzr7bnMZ2+ZQ8O9sEqNhsRz+DOnn8=;
 b=VY9NzxXT3pVRbJ4ViCPZF52QdM+5VL0KVy7G/ssoFnk5FITECNFrK8vP3Y2+0AInhU
 qr7QvNlu/RyueaGghP4zSBUsbNu7I3mu8+8JPKqGk3KgSCXdKu5alSc8bfjeSxyPl8Z2
 bU43wo258lGebDBMyyyGEGxwRJVdoMTS8cvL/0+aC6S1BkVbMv/i4VPeKCh3cp7RVlc+
 BVpbqo/cwHFCnKhs9PH2SM0gpGU/qKNfi5y2Zb9EL/346M0M+oaHB5RkeTxnTt7Ekg9t
 3pYhIU3Qtb7bfzdOBYDg9ShYjayv2kaVUy5Qa/eH+K01wdpJSduVDNTvayK2fUQlEDQh
 qn2w==
X-Gm-Message-State: AOJu0Yy3XBoMOGbfmPCJEIDeFuuP14INj0TZza2c7UtCSZLVp/+aNFc+
 K0zZK1UfxPFd3K6F5ppRO0LBWY/WqOOmFENlYHf7PQfwMsULHgzDHg1l6sQTDiQhd8ywQdwrECa
 JsrUKuwurll5vZpUYtofH597Z6FAqkVGj0R37/NyDvw==
X-Gm-Gg: Acq92OEohVDBoOhkEoG48U1Y3BFI5WhAkyKHxYZm2TtOISL6ufEOXBsHEq6pe9R2Gu0
 r2isXlFw+ec5v9CfDjYFaEuDJ+JmSVHKbZ0NqYdopVYxCWhGCzjIPkcFhSBgigsdPiB6CU8Jv7A
 CA3RP3/i5UW3lGuIzjGlbXRjYW+mJ6CDXwnqoe+K6DDA0P7R2yVtscF6GJVi2UCGuaM6TriXWUp
 uKlEtYGY779JCSt12raJmhf7s1dmU5VPmGAeAfeBpUEUiCEQXZm3Ui3lgqHSLnI5ySna86rkmVj
 JNVGbJiwlg==
X-Received: by 2002:a17:907:7352:b0:bd4:f854:27b5 with SMTP id
 a640c23a62f3a-bdd23df2e6fmr918170266b.9.1779870212618; Wed, 27 May 2026
 01:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-3-frank.chang@sifive.com>
 <CAKmqyKNvZQ2XEAgwCDpOHVfV_NPnmMBD+ZV2q5dRAhoaKcpvug@mail.gmail.com>
In-Reply-To: <CAKmqyKNvZQ2XEAgwCDpOHVfV_NPnmMBD+ZV2q5dRAhoaKcpvug@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 27 May 2026 16:23:21 +0800
X-Gm-Features: AVHnY4K8doIL7iDQDnWxEObC0znn2nOP4Dh5LR4jxH-hDqFF-k7jZ4bJf_TFQ_o
Message-ID: <CAE_xrPh=Bcq8f3Jho0tcZWzJ4zxrNuKPtONW7fgKAvKKadOzCg@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] target/riscv: Add Smrnmi CSRs
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000c50ecb0652c853cc"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c50ecb0652c853cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On Wed, May 27, 2026 at 8:57=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Tommy Wu <tommy.wu@sifive.com>
> >
> > The Smrnmi extension adds the 'mnscratch', 'mnepc', 'mncause',
> > 'mnstatus' CSRs.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c      |  5 +++
> >  target/riscv/cpu.h      |  7 ++++
> >  target/riscv/cpu_bits.h | 11 ++++++
> >  target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 105 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 58bb5196a8..c5d5c2f7df 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj,
> ResetType type)
> >          riscv_trigger_reset_hold(env);
> >      }
> >
> > +    if (cpu->cfg.ext_smrnmi) {
> > +        env->rnmip =3D 0;
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, fals=
e);
> > +    }
> > +
> >      if (kvm_enabled()) {
> >          kvm_riscv_reset_vcpu(cpu);
> >      }
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 284b112821..a2cb471b3c 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -486,6 +486,13 @@ struct CPUArchState {
> >      uint64_t kvm_timer_state;
> >      uint64_t kvm_timer_frequency;
> >  #endif /* CONFIG_KVM */
> > +
> > +    /* RNMI */
> > +    target_ulong mnscratch;
> > +    target_ulong mnepc;
> > +    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
> > +    target_ulong mnstatus;
> > +    target_ulong rnmip;
>
> These have been added to the wrong part of the struct, they should be
> above the comment
>
> /* Fields from here on are preserved across CPU reset. */
>
> Can you fix this up please?
>

Sure, I can submit a patchset to move these fields above this line.

BTW, do we have a plan to support resetting the registers on CPU reset,
similar to other architectures?
E.g., For ARM, it has struct {} end_reset_fields, and the registers are
reset to 0 on CPU reset:
https://github.com/qemu/qemu/blob/master/target/arm/cpu.c#L320

Regards,
Frank Chang


>
> Alistair
>

--000000000000c50ecb0652c853cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Alistair,<div><br></div></div><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, May 27, 2026 at 8:57=E2=80=AFAM Alistair Francis &lt;<a href=3D=
"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 31, 2024 at 1=
:28=E2=80=AFPM &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_bla=
nk">frank.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" target=3D"_b=
lank">tommy.wu@sifive.com</a>&gt;<br>
&gt;<br>
&gt; The Smrnmi extension adds the &#39;mnscratch&#39;, &#39;mnepc&#39;, &#=
39;mncause&#39;,<br>
&gt; &#39;mnstatus&#39; CSRs.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" tar=
get=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@w=
dc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++<br>
&gt;=C2=A0 target/riscv/cpu_bits.h | 11 ++++++<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 | 82 ++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 105 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 58bb5196a8..c5d5c2f7df 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj, R=
esetType type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_trigger_reset_hold(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_smrnmi) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rnmip =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mnstatus =3D set_field(env-&gt;mn=
status, MNSTATUS_NMIE, false);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (kvm_enabled()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_riscv_reset_vcpu(cpu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 284b112821..a2cb471b3c 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -486,6 +486,13 @@ struct CPUArchState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t kvm_timer_state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t kvm_timer_frequency;<br>
&gt;=C2=A0 #endif /* CONFIG_KVM */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* RNMI */<br>
&gt; +=C2=A0 =C2=A0 target_ulong mnscratch;<br>
&gt; +=C2=A0 =C2=A0 target_ulong mnepc;<br>
&gt; +=C2=A0 =C2=A0 target_ulong mncause; /* mncause without bit XLEN-1 set=
 to 1 */<br>
&gt; +=C2=A0 =C2=A0 target_ulong mnstatus;<br>
&gt; +=C2=A0 =C2=A0 target_ulong rnmip;<br>
<br>
These have been added to the wrong part of the struct, they should be<br>
above the comment<br>
<br>
/* Fields from here on are preserved across CPU reset. */<br>
<br>
Can you fix this up please?<br></blockquote><div><br></div><div>Sure, I can=
 submit a patchset to move these fields above this line.</div><div><br></di=
v><div>BTW, do we have a plan to support resetting the registers <span clas=
s=3D"Q6ibn ng" style=3D"border-style:none;background:none">on</span> CPU re=
set, similar to other architectures?</div><div>E.g., For <span class=3D"Asg=
ive ng" style=3D"border-style:none;background:none">ARM,</span> it has stru=
ct {} end_reset_fields, and the registers are reset to 0 on CPU reset:</div=
><div><a href=3D"https://github.com/qemu/qemu/blob/master/target/arm/cpu.c#=
L320">https://github.com/qemu/qemu/blob/master/target/arm/cpu.c#L320</a></d=
iv><div><br></div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
</blockquote></div></div>

--000000000000c50ecb0652c853cc--

