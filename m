Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7868D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfMK-0000tU-5X; Wed, 20 Nov 2024 02:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfM7-0000sZ-Qr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:42:32 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfM4-0005cz-LV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:42:31 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e6005781c0so3400402b6e.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088546; x=1732693346; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gThaZ5PWMmNq57F1QwDfSPO3Ml9ZXrUvQRsJQXDXuHQ=;
 b=cWEk/eWvXd/v0z3RsIq5iZZmfNWV+tJ1bFiFDkWnVLVRsYutUK/bbP7bhWpKIwOA9+
 XTnYi5CzcofBcNTBCDzNNtUr31Rv8Wx/8iRCrfNzgdpNBGLmxWhECtRag90WcXJ7d66z
 TlRpLzeK7uCwfu6PTtSh1Lh8ZU9injGGcrwLYbADn5Kt+IyxEnmwzunAdHWv2D8pMREa
 egnCKN9GjwCWg6io9QBsdKrmzuwFjQu/RfVq0ZhR5nz4pmN1rxXCXjsvJBu/02oVwrvu
 Z0c/aCeUaDlce7U/HWdi1QFa8fPkVGr693NM0KswuWbF5gJKBByQ/jglOt9LAbcpVSvK
 N5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088546; x=1732693346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gThaZ5PWMmNq57F1QwDfSPO3Ml9ZXrUvQRsJQXDXuHQ=;
 b=SYw/HxU6CayOXJ4f6s2g5dBqUNHUyuaDOZ0u8iQaHIGCZjliB+8I18EryLl+Qs8sWh
 rZivGFF9d/c6slGz4i1ExDdmaKNn4XOPQhe82ykPBXHq35BOktLOG5NrXb+QOaXQZaAY
 9zDfGn65hEP3zYXKuDRaAczI/pAD+75WkzzEKvwCb9IWwltjG/bud8HkIbdNN/aqLuwU
 vOjslFJ4a69cDzNrnscwadwl+BKr8n59ek6+GSunca921tuXylgfaa70h2y+QZ/mArrE
 GjJAt0hDYJU9pK3bxjHVNyx8GIQDw0lNxkE29HNalZQwP+0HeC7tYnsPQFfjG/rY9CKW
 D8Jg==
X-Gm-Message-State: AOJu0Yxqrb+Pt9zmZ4rDdEmNaddRP8n+Ftu0RzGIDTkQPvcPvxWihRY7
 I+N0mIPRb3Sxdwgf95T2J5UoffRCvK9MjDjCWeqRIzQ0zazuBxbY44mgxHmjh+TsnfjZb0l5nqK
 SXZ76mDSntepJvpOp1F7V/rJge8RqRszAQMNJcA==
X-Google-Smtp-Source: AGHT+IEbYt9Eta2rnOGMg9nh/koEbpd2oxApMWt7rzDsU3YpvG/Zf6cDgjRNEAro0XcXaFJOBz6KOvTtf/FhG3qbkkw=
X-Received: by 2002:a05:6808:2447:b0:3e7:be26:e38b with SMTP id
 5614622812f47-3e7eb7ccd58mr1871779b6e.32.1732088545926; Tue, 19 Nov 2024
 23:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-5-fea.wang@sifive.com>
 <CAKmqyKOm1Fu28Q0mg1OM--g0wbt89J1SVzufjsYvm7u7-ALmWA@mail.gmail.com>
In-Reply-To: <CAKmqyKOm1Fu28Q0mg1OM--g0wbt89J1SVzufjsYvm7u7-ALmWA@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Wed, 20 Nov 2024 15:42:14 +0800
Message-ID: <CAKhCfsdzjAq_oh0v0Rwtm_FuWeD-ATZEZgiGzFNtUO2bvFy8Cw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] target/riscv: Check memory access to meet svukte
 rule
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000800bf30627534a9b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=fea.wang@sifive.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000800bf30627534a9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the advice.
I will fix them in the next patch version.

Sincerely,
Fea

On Tue, Nov 19, 2024 at 11:33=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com>
wrote:

> On Tue, Nov 12, 2024 at 7:13=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wr=
ote:
> >
> > Follow the Svukte spec, do the memory access address checking
> >
> > 1. Include instruction fetches or explicit memory accesses
> > 2. System run in effective privilege U or VU
> > 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> > instruction is HLV, HLVX, HSV and execute from U mode to VU mode
> > 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> > 5. Raises a page-fault exception corresponding to the original access
> > type.
> >
> > Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 0a3ead69ea..5b29344c4f 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -857,6 +857,61 @@ static int get_physical_address_pmp(CPURISCVState
> *env, int *prot, hwaddr addr,
> >      return TRANSLATE_SUCCESS;
> >  }
> >
> > +/* Returns 'true' if a svukte address check is needed */
> > +static bool do_svukte_check(CPURISCVState *env, bool first_stage,
> > +                             int mode, bool virt)
> > +{
> > +    bool ukte;
> > +
> > +    /* Svukte extension depends on Sv39. */
> > +    if (!(env_archcpu(env)->cfg.ext_svukte ||
> > +        !first_stage ||
> > +        VM_1_10_SV39 !=3D get_field(env->satp, SATP64_MODE))) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * Check hstatus.HUKTE if the effective mode is switched to VU-mod=
e
> by
> > +     * executing HLV/HLVX/HSV in U-mode.
> > +     * For other cases, check senvcfg.UKTE.
> > +     */
> > +    if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
> > +        ukte =3D !!(env->hstatus & HSTATUS_HUKTE);
>
> You should just be able to use get_field() here
>
> > +    } else {
> > +        ukte =3D !!(env->senvcfg & SENVCFG_UKTE);
> > +    }
> > +
> > +    if (!ukte) {
> > +        return false;
>
> and it's probably simpler to remove the ukte variable and just return
> based on the result of get_field()
>
> > +    }
> > +
> > +    /*
> > +     * Svukte extension is qualified only in U or VU-mode.
> > +     *
> > +     * Effective mode can be switched to U or VU-mode by:
> > +     *   - M-mode + mstatus.MPRV=3D1 + mstatus.MPP=3DU-mode.
> > +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=3D0.
> > +     *   - U-mode.
> > +     *   - VU-mode.
> > +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=3D1.
> > +     */
> > +    if (mode !=3D PRV_U) {
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
> > +{
> > +    uint32_t sxl =3D riscv_cpu_sxl(env);
> > +    sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;
>
> I don't think riscv_cpu_sxl() can return 0, do we actually need this chec=
k?
>
> Also this extension isn't defined for RV32
>
> Alistair
>
> > +    uint32_t sxlen =3D 32 * sxl;
> > +    uint64_t high_bit =3D addr & (1UL << (sxlen - 1));
> > +
> > +    return !high_bit;
> > +}
> > +
> >  /*
> >   * get_physical_address - get the physical address for this virtual
> address
> >   *
> > @@ -894,6 +949,7 @@ static int get_physical_address(CPURISCVState *env,
> hwaddr *physical,
> >      MemTxResult res;
> >      MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
> >      int mode =3D mmuidx_priv(mmu_idx);
> > +    bool virt =3D mmuidx_2stage(mmu_idx);
> >      bool use_background =3D false;
> >      hwaddr ppn;
> >      int napot_bits =3D 0;
> > @@ -901,6 +957,11 @@ static int get_physical_address(CPURISCVState *env=
,
> hwaddr *physical,
> >      bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D
> MMU_IDX_SS_WRITE);
> >      bool sstack_page =3D false;
> >
> > +    if (do_svukte_check(env, first_stage, mode, virt) &&
> > +        !check_svukte_addr(env, addr)) {
> > +        return TRANSLATE_FAIL;
> > +    }
> > +
> >      /*
> >       * Check if we should use the background registers for the two
> >       * stage translation. We don't need to check if we actually need
> > --
> > 2.34.1
> >
> >
>

--000000000000800bf30627534a9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the advice.<div>I will fix them in the next pat=
ch version.</div><div><br></div><div>Sincerely,</div><div>Fea</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Nov 19, 2024 at 11:33=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:ali=
stair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Tue, Nov 12, 2024 at 7:13=E2=80=
=AFPM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=3D"_blank"=
>fea.wang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Follow the Svukte spec, do the memory access address checking<br>
&gt;<br>
&gt; 1. Include instruction fetches or explicit memory accesses<br>
&gt; 2. System run in effective privilege U or VU<br>
&gt; 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if<br>
&gt; instruction is HLV, HLVX, HSV and execute from U mode to VU mode<br>
&gt; 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]<br>
&gt; 5. Raises a page-fault exception corresponding to the original access<=
br>
&gt; type.<br>
&gt;<br>
&gt; Ref: <a href=3D"https://github.com/riscv/riscv-isa-manual/pull/1564/fi=
les" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-is=
a-manual/pull/1564/files</a><br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@=
ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=
=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 61 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index 0a3ead69ea..5b29344c4f 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -857,6 +857,61 @@ static int get_physical_address_pmp(CPURISCVState=
 *env, int *prot, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return TRANSLATE_SUCCESS;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/* Returns &#39;true&#39; if a svukte address check is needed */<br>
&gt; +static bool do_svukte_check(CPURISCVState *env, bool first_stage,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mode, bool virt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool ukte;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Svukte extension depends on Sv39. */<br>
&gt; +=C2=A0 =C2=A0 if (!(env_archcpu(env)-&gt;cfg.ext_svukte ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !first_stage ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VM_1_10_SV39 !=3D get_field(env-&gt;satp,=
 SATP64_MODE))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Check hstatus.HUKTE if the effective mode is sw=
itched to VU-mode by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* executing HLV/HLVX/HSV in U-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For other cases, check senvcfg.UKTE.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv =3D=3D PRV_U &amp;&amp; !env-&gt;virt_=
enabled &amp;&amp; virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ukte =3D !!(env-&gt;hstatus &amp; HSTATUS=
_HUKTE);<br>
<br>
You should just be able to use get_field() here<br>
<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ukte =3D !!(env-&gt;senvcfg &amp; SENVCFG=
_UKTE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ukte) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
<br>
and it&#39;s probably simpler to remove the ukte variable and just return<b=
r>
based on the result of get_field()<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Svukte extension is qualified only in U or VU-m=
ode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Effective mode can be switched to U or VU-mode =
by:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0- M-mode + mstatus.MPRV=3D1 + mstat=
us.MPP=3DU-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0- Execute HLV/HLVX/HSV from HS-mode=
 + hstatus.SPVP=3D0.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0- U-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0- VU-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0- Execute HLV/HLVX/HSV from U-mode =
+ hstatus.HU=3D1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (mode !=3D PRV_U) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool check_svukte_addr(CPURISCVState *env, vaddr addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t sxl =3D riscv_cpu_sxl(env);<br>
&gt; +=C2=A0 =C2=A0 sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;<br>
<br>
I don&#39;t think riscv_cpu_sxl() can return 0, do we actually need this ch=
eck?<br>
<br>
Also this extension isn&#39;t defined for RV32<br>
<br>
Alistair<br>
<br>
&gt; +=C2=A0 =C2=A0 uint32_t sxlen =3D 32 * sxl;<br>
&gt; +=C2=A0 =C2=A0 uint64_t high_bit =3D addr &amp; (1UL &lt;&lt; (sxlen -=
 1));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return !high_bit;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* get_physical_address - get the physical address for this=
 virtual address<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -894,6 +949,7 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemTxResult res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mode =3D mmuidx_priv(mmu_idx);<br>
&gt; +=C2=A0 =C2=A0 bool virt =3D mmuidx_2stage(mmu_idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool use_background =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr ppn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int napot_bits =3D 0;<br>
&gt; @@ -901,6 +957,11 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool is_sstack_idx =3D ((mmu_idx &amp; MMU_IDX_SS_=
WRITE) =3D=3D MMU_IDX_SS_WRITE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool sstack_page =3D false;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (do_svukte_check(env, first_stage, mode, virt) &amp;=
&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !check_svukte_addr(env, addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Check if we should use the background regi=
sters for the two<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* stage translation. We don&#39;t need to ch=
eck if we actually need<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000800bf30627534a9b--

