Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7A8FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8li-0005O4-RF; Fri, 24 Apr 2026 01:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8lf-0005NW-4R
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:07:56 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8ld-0006ey-9i
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:07:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66ba9dfe83bso9275847a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 22:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777007270; cv=none;
 d=google.com; s=arc-20240605;
 b=OZX3mSzmvFQwalHcU7e7fIz4G7edevGnIXsCm0CltGHTN9Bo3RN1dyecNfhigwre57
 UiWPn1PqTG4RINmUlibGnd72UXpRyMCTLXqdd5+9TTPBcBZnDF8KOQNEldD9mfETWpa9
 EcYyGiqFOx/Fu5vWMArup73RQ7hCdd29ut1x12XDKxE/6LA2xwKgNhQGh79mvhf4kElY
 jwfafbK/daLDhmclXwILoyMxdbKWcEK5JzLtDIRjFp/ca7Yv4Eq+yABU6bbYH0ZGxYTB
 PIB0To2pXKx/DXRjm9/XcPQ4/VZ/e24nSTRu4XyFrFm72EAROLbLEhoal65SinYXd0pZ
 WUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1nTHzeyrRY4SjAyR28NJRzvjdTFe0c+RgrzVUD7VrCc=;
 fh=7JIyXbSejVylgAatbe8mZ0w4pTm1O86UeNO7WPedyqA=;
 b=WZ0vyLTnHx1nzuH1h8y6w3cnZU7HomyWVwqdIAgXM8k8ZoVgnQKuo21Kjc6xFjeko9
 YHYaJR2OvoF2BJgScug3MpAepKnGws0tvUMi2YG5xnXOV+0e6kQ8KyEwHlWccUCSW9rx
 nbzwTKJ4Sv2yRdK66q561TetHKk4A6APFlA5+A5h71LKUhzKq77LxLPMmpINNojzMZDw
 swzLaKL10TL6ZRu00d97wOXc264DDqAmqxgCJsSfKdm9WIogQPPE9sPPA6CHvLyNtkmQ
 40U7UHWl1gTypA3YX5NuuB9WrvUvS0FdT54oM0HXokHB90otErAyE0AblvfbI98vteq6
 kGeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777007270; x=1777612070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1nTHzeyrRY4SjAyR28NJRzvjdTFe0c+RgrzVUD7VrCc=;
 b=b/9Wt3jW1OBFYmE+qpu/MDNzp4pMMyX98mW20HGn87BDFGrNekVTAC8fVCiipt4RCE
 Mc8szkG25OCTscNoynIX3dg3qgr3Cwro85NaN15yByhEkSqS/GJLtlFAWz6uqToXMfF7
 GTlnzKi3Vuw2fQilCUDPc6lcPMZaKsCoKTQzy1n9VePffpsrLmxkGytJFc5W7pX7pIpd
 N6liRSH0PoIGRXyZOcVBNtTLn/5Qvf8zbkk2FA/6hnPonbqDkFDhpy+R1AVTTSfc5VQW
 xlDkxeqG10Kab4hu3lJoRzceFZVp9nnrn9VyXcOfFnTouROMNIrBKD6p9x9zLKyDupM/
 GV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777007270; x=1777612070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nTHzeyrRY4SjAyR28NJRzvjdTFe0c+RgrzVUD7VrCc=;
 b=msRFvfyMJtRn0dppuOXj5EXJzCsyTrno97hf/WRfuU3GWKC8982xp2Ji566iakor3M
 7B73T1avF4PtNQUcovlNWYPTTO7KzAVMVJlpfSScZGIc2osJy18rhd77HIqWuNMKbAZC
 6xlMZKXgRFX+eCGfmQF6wki8ohz+gjhbOsz5IFw07SlKVHcVVfK0oIVOX4x98QEoUB0Y
 qczLvcrwe3SMt3y5ceCkts9WtLvcqrGi0/whv8u8IAfnCSTuWelq0VB8ezzbio0NC46M
 Q1RzzWUFD3rrzVuItoQAfbGAb7InWxhSAeBs00AMJ7atB5HMJazFbTENd671Lylmy0ig
 eiNg==
X-Gm-Message-State: AOJu0YyTrJBcRqwAwvTz3C0CkefIl6O759rqnHcqSjFdgroEcIaYS+sG
 kUjeGMpGypeZzkC3inhJoHVZqS+y1P2cwl9vmf5pmVd6cQKCoPMkHYHcsHr5zeG7mqN8vgt+oI7
 6fc5J+2VhZGoFPwPubf0iQ85RKmyEHWX/y9+ka11VDQ==
X-Gm-Gg: AeBDietI/pQLtb1rSXRa3Z58COL7czlbpjatZUhnTr1ClEvY+b6WepRSVX+qFWilOtO
 v43a02VFXq0g9ekjGvS1CoY5zXZlTorU0kOSoQLFEPcFncP8wRnZkk9/Meqrx9oD4RDeJr5N1Py
 q9OI2IGZBk1dkxQu126ChS9GOwp3x0Lt7VgfhcTX7fk7aqqF1ukzEbHErgXY5KhP+uKRapHipjZ
 lPbVuAwV5mF+5Pj3hn+r2dkuTb8n3gT1tnMqfX/evvAKU8P2ZrJTiwQjkS+/VRa9n7oMkJ6cg+w
 ZlemZsLmJX2705vNQ7XS
X-Received: by 2002:aa7:d04a:0:b0:670:f828:bb1c with SMTP id
 4fb4d7f45d1cf-672bfd8b16dmr9826128a12.3.1777007270424; Thu, 23 Apr 2026
 22:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260421075906.2928317-1-frank.chang@sifive.com>
 <20260421075906.2928317-2-frank.chang@sifive.com>
 <CAKmqyKMgOdADSQzuooxx8nKFdXrX9omL2Wsp5ndZzhrRXWoE+Q@mail.gmail.com>
In-Reply-To: <CAKmqyKMgOdADSQzuooxx8nKFdXrX9omL2Wsp5ndZzhrRXWoE+Q@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 24 Apr 2026 13:07:38 +0800
X-Gm-Features: AQROBzDmxwm6e2YwM5n_W3w-kLVQMbvNv6WOkRyMkHQLWiqBzbUqrqWfxz_62JM
Message-ID: <CAE_xrPgTnU+ApXquB=Ckpr0sAMyebsd8zCARp+4k9Pdb-H9X9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv: Update MISA.C for Zc* extensions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000001e055906502dbf40"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52d.google.com
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

--0000000000001e055906502dbf40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 8:02=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Apr 21, 2026 at 6:01=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > MISA.C is set if the following extensions are selected:
> >   * Zca and not F.
> >   * Zca, Zcf and F (but not D) is specified (RV32 only).
> >   * Zca, Zcf and Zcd if D is specified (RV32 only).
> >   * Zca, Zcd if D is specified (RV64 only).
> >
> > Therefore, we need to set MISA.C according to the rules for Zc*
> > extensions.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Max Chou <max.chou@sifive.com>
> > ---
> >  target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index f3f78088956..0f68560bac1 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -1163,6 +1163,37 @@ static void
> riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
> >      }
> >  }
> >
> > +/*
> > + * MISA.C is set if the following extensions are selected:
> > + *   - Zca and not F.
> > + *   - Zca, Zcf and F (but not D) is specified on RV32.
> > + *   - Zca, Zcf and Zcd if D is specified on RV32.
> > + *   - Zca, Zcd if D is specified on RV64.
> > + */
> > +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> > +{
> > +    CPURISCVState *env =3D &cpu->env;
> > +
> > +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> > +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> > +        return;
> > +    }
> > +
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
> > +        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> > +        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
> > +                                   riscv_has_ext(env, RVF))) {
> > +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> > +        return;
> > +    }
> > +
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> > +        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> > +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> > +        return;
> > +    }
> > +}
> > +
> >  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> >  {
> >      CPURISCVState *env =3D &cpu->env;
> > @@ -1170,6 +1201,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU
> *cpu, Error **errp)
> >
> >      riscv_cpu_init_implied_exts_rules();
> >      riscv_cpu_enable_implied_rules(cpu);
> > +    riscv_cpu_update_misa_c(cpu);
>
> What happens if a user has disabled C?
>
> Alistair
>

Hi Alistair,

I've added the warning message when user disables RVC explicitly,
but RVC is mandated by Zca/Zcf/Zcd extensions in the next patchset:
https://lore.kernel.org/qemu-devel/20260424050509.3935180-1-frank.chang@sif=
ive.com/

Regards,
Frank Chang


>
> >
> >      riscv_cpu_validate_misa_priv(env, &local_err);
> >      if (local_err !=3D NULL) {
> > --
> > 2.43.0
> >
> >
>

--0000000000001e055906502dbf40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 22,=
 2026 at 8:02=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistair23@=
gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Apr 21, 2026 at 6:01=E2=80=AFPM &l=
t;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@s=
ifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; MISA.C is set if the following extensions are selected:<br>
&gt;=C2=A0 =C2=A0* Zca and not F.<br>
&gt;=C2=A0 =C2=A0* Zca, Zcf and F (but not D) is specified (RV32 only).<br>
&gt;=C2=A0 =C2=A0* Zca, Zcf and Zcd if D is specified (RV32 only).<br>
&gt;=C2=A0 =C2=A0* Zca, Zcd if D is specified (RV64 only).<br>
&gt;<br>
&gt; Therefore, we need to set MISA.C according to the rules for Zc*<br>
&gt; extensions.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" targe=
t=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++=
<br>
&gt;=C2=A0 1 file changed, 32 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index f3f78088956..0f68560bac1 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -1163,6 +1163,37 @@ static void riscv_cpu_enable_implied_rules(RISC=
VCPU *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/*<br>
&gt; + * MISA.C is set if the following extensions are selected:<br>
&gt; + *=C2=A0 =C2=A0- Zca and not F.<br>
&gt; + *=C2=A0 =C2=A0- Zca, Zcf and F (but not D) is specified on RV32.<br>
&gt; + *=C2=A0 =C2=A0- Zca, Zcf and Zcd if D is specified on RV32.<br>
&gt; + *=C2=A0 =C2=A0- Zca, Zcd if D is specified on RV64.<br>
&gt; + */<br>
&gt; +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zca &amp;&amp; !riscv_has_ext(env, =
RVF)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_=
ext | RVC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zca &amp;&amp; cpu-&gt;cf=
g.ext_zcf &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (riscv_has_ext(env, RVD) ? cpu-&gt;cfg.ex=
t_zcd :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_has_ext(env, =
RVF))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_=
ext | RVC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zca &amp;&amp; cpu-&gt;cf=
g.ext_zcd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_=
ext | RVC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp=
)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; @@ -1170,6 +1201,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *c=
pu, Error **errp)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 riscv_cpu_init_implied_exts_rules();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 riscv_cpu_enable_implied_rules(cpu);<br>
&gt; +=C2=A0 =C2=A0 riscv_cpu_update_misa_c(cpu);<br>
<br>
What happens if a user has disabled C?<br>
<br>
Alistair<br></blockquote><div><br></div><div>Hi Alistair,</div><div><br></d=
iv><div>I&#39;ve added the warning <span class=3D"Asgive ng" style=3D"borde=
r-style:none;background:none">message when user disables RVC explicitly,</s=
pan></div><div><span class=3D"Q6ibn ng" style=3D"border-style:none;backgrou=
nd:none">but</span> RVC is mandated by=C2=A0Zca/Zcf/Zcd extensions in the n=
ext patchset:</div><div><a href=3D"https://lore.kernel.org/qemu-devel/20260=
424050509.3935180-1-frank.chang@sifive.com/">https://lore.kernel.org/qemu-d=
evel/20260424050509.3935180-1-frank.chang@sifive.com/</a></div><div><br></d=
iv><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 riscv_cpu_validate_misa_priv(env, &amp;local_err);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000001e055906502dbf40--

