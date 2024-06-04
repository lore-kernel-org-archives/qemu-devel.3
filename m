Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C4DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEaEU-00080x-6m; Tue, 04 Jun 2024 15:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEZBc-0007Ft-Cd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:47:08 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEZBZ-0001jR-Kc
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:47:08 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-62a2424ed01so60507717b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717526823; x=1718131623;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9dzBwmguy3/vQ+kgEZPDQWKkmi1aBtYoWjvo/mZ2H8Y=;
 b=CwrvZj6bqu1xjItaEyz75kZ6Jsx3JRKToLF0k/Aj4NV/9eLBcJraumc+X7ckfsqUG5
 qmQRnVnZnf5NDqMF6V7jm4iqwSsuyZivKbAQwGoilUAeiYwy4XRpdIuwkyQAmTE7fRYH
 D1n3jaeUcNq1SJWxIOUkT68O/x6zLBhkzhggc8IJdW0x6roOAeHpATjoBpl2DC3dsZ5V
 sMVniIfUAPEuvMzSwSVjgSeyqZa+B/85MJbtnTYV47sQqshkc9N0GRCe3UAj4Ben200Q
 jlzEjZ6qpdhzppAQSQw+stpsmnE2ilrMazAwLEgLT4KOqq1lsQjfgP5TAMvsIXbcrV7q
 7Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717526823; x=1718131623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9dzBwmguy3/vQ+kgEZPDQWKkmi1aBtYoWjvo/mZ2H8Y=;
 b=twxGW/E+XXK/0u8mXlhvi03qcToEhOiP7MMABm5HnNONdur80dLnhp2bhG4DtbGR7w
 jbsFQ9aa+7XBLNDvPgO/OF4J4yYcstosifo0bWXcYLA3ynUDo2hMBIcE3M9ySQl7nskF
 +80AFUrJ24W1dalicotGN1zFcQoXeaJFOQrhEzxrZfKQBGECmmbrR6x6dkSamPNJZ18H
 fsZo9kFgF9CNDdEiL10aX1XkO5csTZojnDK5aMEwy1D7+qrq6DXeMTgthXpuBiejo7Ak
 ejpg6sdLAMQjGqtb7QESm3Ber/ZFU0uD5pfx3tfc5BdVMiK0hCeOaP1PMDnMD/OkOz5+
 db5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqwuLq+ZjkybbA/5my+Knte9ykM9lFTZM0jYha/Zemiss4s4P4yN8qZ/krGMyVxVQP9OjQLN9bw/jL6CSqAOYue6xFUdI=
X-Gm-Message-State: AOJu0YzFN3xUBtV9dkP7eJfKCE5t07rZudQqbSZYI1i+PZfAHRMWaTe9
 y4JBj5p5mMM4Lshvxl1V53maZu2BxP9ls9eZj48Umzc4x1J014oUm1NSIdSOP458TQzsw01724K
 1rpXvpdb7sCb9sg4lZvJDjziuaXij8u+6VZYEJg==
X-Google-Smtp-Source: AGHT+IHKV8yohT/ln5XpNOij8EAGJgdpjX5vbS+qVTGwxG/wX2Dr8mU0y6nxhjdcc1/02m+LVivY1R9mWh87cjwxoKw=
X-Received: by 2002:a81:ad0d:0:b0:627:760f:80cc with SMTP id
 00721157ae682-62cbb48dba1mr1879147b3.10.1717526823508; Tue, 04 Jun 2024
 11:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-6-rkanwal@rivosinc.com>
 <71bc36b9-cc17-4036-91b2-e7ddd81f0c07@sifive.com>
In-Reply-To: <71bc36b9-cc17-4036-91b2-e7ddd81f0c07@sifive.com>
From: Beeman Strong <beeman@rivosinc.com>
Date: Tue, 4 Jun 2024 11:46:52 -0700
Message-ID: <CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/riscv: Add CTR sctrclr instruction.
To: Jason Chien <jason.chien@sifive.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, 
 apatel@ventanamicro.com, tech-control-transfer-records@lists.riscv.org
Content-Type: multipart/alternative; boundary="000000000000353ec8061a14e0d0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=beeman@rivosinc.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:54:07 -0400
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

--000000000000353ec8061a14e0d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:19=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:

>
> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=
=81=93:
> > CTR extension adds a new instruction sctrclr to quickly
> > clear the recorded entries buffer.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >   target/riscv/cpu.h                             |  1 +
> >   target/riscv/cpu_helper.c                      |  7 +++++++
> >   target/riscv/insn32.decode                     |  1 +
> >   target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++++++
> >   target/riscv/op_helper.c                       |  5 +++++
> >   5 files changed, 24 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index a294a5372a..fade71aa09 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env,
> target_ulong newpriv, bool virt_en);
> >   void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
> >   void riscv_ctr_add_entry(CPURISCVState *env, target_long src,
> target_long dst,
> >                            uint64_t type, target_ulong prev_priv, bool
> prev_virt);
> > +void riscv_ctr_clear(CPURISCVState *env);
> >
> >   void riscv_translate_init(void);
> >   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index e064a7306e..45502f50a7 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_t
> freeze_mask)
> >       }
> >   }
> >
> > +void riscv_ctr_clear(CPURISCVState *env)
> > +{
> > +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
> > +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
> > +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
> > +}
> > +
> >   static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
> >   {
> >       switch (priv) {
> > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> > index 9cb1a1b4ec..d3d38c7c68 100644
> > --- a/target/riscv/insn32.decode
> > +++ b/target/riscv/insn32.decode
> > @@ -107,6 +107,7 @@
> >   # *** Privileged Instructions ***
> >   ecall       000000000000     00000 000 00000 1110011
> >   ebreak      000000000001     00000 000 00000 1110011
> > +sctrclr     000100000100     00000 000 00000 1110011
> >   uret        0000000    00010 00000 000 00000 1110011
> >   sret        0001000    00010 00000 000 00000 1110011
> >   mret        0011000    00010 00000 000 00000 1110011
> > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc
> b/target/riscv/insn_trans/trans_privileged.c.inc
> > index 339d659151..dd9da8651f 100644
> > --- a/target/riscv/insn_trans/trans_privileged.c.inc
> > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> > @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx,
> arg_ebreak *a)
> >       return true;
> >   }
> >
> > +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
> > +{
> > +#ifndef CONFIG_USER_ONLY
> If both of smctr and ssctr are not enabled, it is an illegal instruction.
> > +    gen_helper_ctr_clear(tcg_env);
> > +    return true;
> > +#else
> > +    return false;
> > +#endif
> > +}
> > +
> >   static bool trans_uret(DisasContext *ctx, arg_uret *a)
> >   {
> >       return false;
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index c8053d9c2f..89423c04b3 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env,
> target_ulong src, target_ulong dest,
> >       }
> >   }
> >
> > +void helper_ctr_clear(CPURISCVState *env)
> > +{
>
> There should be some checks here.
> The spec states:
> SCTRCLR raises an illegal-instruction exception in U-mode, and a
> virtual-instruction exception in VU-mode, unless CTR state enable access
> restrictions apply.
>
> I don't quite understand "unless CTR state enable access restrictions
> apply" though.
>

The next sentence says "See Chapter 5", which states that execution of
SCTRCLR raises an illegal instruction exception if mstateen0.CTR=3D0 and th=
e
priv mode is not M-mode, and it raises a virtual instruction exception if
mstateen0.CTR=3D0 && hstateen0.CTR=3D1 and the priv mode is VS-mode.


>
> > +    riscv_ctr_clear(env);
> > +}
> > +
> >   void helper_wfi(CPURISCVState *env)
> >   {
> >       CPUState *cs =3D env_cpu(env);
>

--000000000000353ec8061a14e0d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 10:19=E2=80=AF=
AM Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com">jason.chien@si=
five.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=81=
=93:<br>
&gt; CTR extension adds a new instruction sctrclr to quickly<br>
&gt; clear the recorded entries buffer.<br>
&gt;<br>
&gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.c=
om" target=3D"_blank">rkanwal@rivosinc.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++=
++++<br>
&gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A05 files changed, 24 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index a294a5372a..fade71aa09 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target=
_ulong newpriv, bool virt_en);<br>
&gt;=C2=A0 =C2=A0void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_=
mask);<br>
&gt;=C2=A0 =C2=A0void riscv_ctr_add_entry(CPURISCVState *env, target_long s=
rc, target_long dst,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t type, target_ulong prev_priv, bool pre=
v_virt);<br>
&gt; +void riscv_ctr_clear(CPURISCVState *env);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void riscv_translate_init(void);<br>
&gt;=C2=A0 =C2=A0G_NORETURN void riscv_raise_exception(CPURISCVState *env,<=
br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index e064a7306e..45502f50a7 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_=
t freeze_mask)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +void riscv_ctr_clear(CPURISCVState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_src, 0x0, sizeof(env-&gt;ctr_src));<=
br>
&gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_dst, 0x0, sizeof(env-&gt;ctr_dst));<=
br>
&gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_data, 0x0, sizeof(env-&gt;ctr_data))=
;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, =
bool virt)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (priv) {<br>
&gt; diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode<b=
r>
&gt; index 9cb1a1b4ec..d3d38c7c68 100644<br>
&gt; --- a/target/riscv/insn32.decode<br>
&gt; +++ b/target/riscv/insn32.decode<br>
&gt; @@ -107,6 +107,7 @@<br>
&gt;=C2=A0 =C2=A0# *** Privileged Instructions ***<br>
&gt;=C2=A0 =C2=A0ecall=C2=A0 =C2=A0 =C2=A0 =C2=A0000000000000=C2=A0 =C2=A0 =
=C2=A000000 000 00000 1110011<br>
&gt;=C2=A0 =C2=A0ebreak=C2=A0 =C2=A0 =C2=A0 000000000001=C2=A0 =C2=A0 =C2=
=A000000 000 00000 1110011<br>
&gt; +sctrclr=C2=A0 =C2=A0 =C2=A0000100000100=C2=A0 =C2=A0 =C2=A000000 000 =
00000 1110011<br>
&gt;=C2=A0 =C2=A0uret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000=C2=A0 =C2=A0 00010=
 00000 000 00000 1110011<br>
&gt;=C2=A0 =C2=A0sret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0001000=C2=A0 =C2=A0 00010=
 00000 000 00000 1110011<br>
&gt;=C2=A0 =C2=A0mret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0011000=C2=A0 =C2=A0 00010=
 00000 000 00000 1110011<br>
&gt; diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/r=
iscv/insn_trans/trans_privileged.c.inc<br>
&gt; index 339d659151..dd9da8651f 100644<br>
&gt; --- a/target/riscv/insn_trans/trans_privileged.c.inc<br>
&gt; +++ b/target/riscv/insn_trans/trans_privileged.c.inc<br>
&gt; @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebr=
eak *a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)<br>
&gt; +{<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
If both of smctr and ssctr are not enabled, it is an illegal instruction.<b=
r>
&gt; +=C2=A0 =C2=A0 gen_helper_ctr_clear(tcg_env);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static bool trans_uret(DisasContext *ctx, arg_uret *a)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c<br>
&gt; index c8053d9c2f..89423c04b3 100644<br>
&gt; --- a/target/riscv/op_helper.c<br>
&gt; +++ b/target/riscv/op_helper.c<br>
&gt; @@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env, target=
_ulong src, target_ulong dest,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +void helper_ctr_clear(CPURISCVState *env)<br>
&gt; +{<br>
<br>
There should be some checks here.<br>
The spec states:<br>
SCTRCLR raises an illegal-instruction exception in U-mode, and a <br>
virtual-instruction exception in VU-mode, unless CTR state enable access <b=
r>
restrictions apply.<br>
<br>
I don&#39;t quite understand &quot;unless CTR state enable access restricti=
ons <br>
apply&quot; though.<br></blockquote><div><br></div><div>The next sentence s=
ays &quot;See Chapter 5&quot;, which states that execution of SCTRCLR raise=
s an illegal instruction exception if mstateen0.CTR=3D0 and the priv mode i=
s not M-mode, and it raises a virtual instruction exception if mstateen0.CT=
R=3D0 &amp;&amp; hstateen0.CTR=3D1 and the priv mode is VS-mode.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 riscv_ctr_clear(env);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void helper_wfi(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
</blockquote></div></div>

--000000000000353ec8061a14e0d0--

