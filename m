Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83A8D41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmoY-00057d-A1; Tue, 12 Nov 2024 04:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmoS-000554-Tb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:03:52 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmoQ-00069F-I7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:03:52 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so4084249a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402229; x=1732007029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6KNLfmsbfxbZ9kOnlK0s+fdpcvSx4i4/PF4r5XqqMFw=;
 b=ZMdtY7VDJXSmWC9fikwOQ/jg22YETHpFukYQXuaEOV9Zk6xxsX1F7vJndw0zGeKw7x
 NTNXUa9tzGwEHdTYajmdSYfWnoJw1AA73XAatkOlRuNrxKq4ux4GbBDdjFkN1Bh92G8D
 hiNnPjhRkGZRQObh+3gHMi4LCfd0U0k8UnixHdLr6wW8lFPISSnTRgsISIRVoqEf/CiZ
 meG2BZFnvOdWOZpb0F6ya1nJn3CWTYED4w5P2eNmx+DaJJuwg5uplTDQkejtjqs4+9Mf
 gY0lSMhFhtFd8xDfn8BPVn8nnGqtQG72floXXabQvOSEElXtl4+SwhWSaoI/pQQGYeSv
 KLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402229; x=1732007029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KNLfmsbfxbZ9kOnlK0s+fdpcvSx4i4/PF4r5XqqMFw=;
 b=LZl+esGJU4+vHUmu1aTk0HTZWdOIs4Xbmu16YHbWmshu0akawPEn4G1GW7vqpJPzgm
 zFXq3yEuW/WbuGsM4/7e3jZByLh1dfUNbztiMif55DaXRGMIoKTSEjYDxD6QAgmFgkGP
 +YToPIv8JPVHXuLwJ7pdDgvtwMCdg6GfBwr/4uwmnA+JjbnBHL6pJ3RaqS06SGT2qb0P
 gOY0S7h6XABwvqDBcbKiRj14NpvB3YNfOmt3GkaQd/q8DpDgSR2wrIYmXeaEbltxssDh
 DZVgjRaGgMYzlmH97BypsEj3xrAY+6uI0tRv66rx+mB2I1oYG3Gvfdz1hgOaJJJXSeyl
 iOFA==
X-Gm-Message-State: AOJu0YxkHTGjZx7UDmE9UnfA8+1hwf/4GxAX8Dp1gqwPEaXdGv8q9XO5
 WBqPDt5QL2ixbm/RgO9659yq+eU9fgkA4O7gW8sjSCggEDmmqIgefi6sl+b+24qsO7cf8RtHe8a
 bj+zWp9r4A/cYLImedWri7hhGeD53keoCU1gr5w==
X-Google-Smtp-Source: AGHT+IE5vRxzosGS/UgSuQfBMVooikmPnj/Omik8cczYaXUkU6cx9TJeAD0IL76ixzQbQGk6/fdPnqilwGnXR0cUIkk=
X-Received: by 2002:a05:6a20:3948:b0:1d8:a29b:8f6f with SMTP id
 adf61e73a8af0-1dc229440aemr25007734637.16.1731402228631; Tue, 12 Nov 2024
 01:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20241108085239.2927152-1-fea.wang@sifive.com>
 <20241108085239.2927152-5-fea.wang@sifive.com>
 <1293b3ab-6f61-4471-8f46-6abf103a635d@ventanamicro.com>
In-Reply-To: <1293b3ab-6f61-4471-8f46-6abf103a635d@ventanamicro.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Tue, 12 Nov 2024 17:03:37 +0800
Message-ID: <CAKhCfsc=fmbwxxEDWOt8OtaxG3g4j0QJvSkLYYM8jj8hUi1gbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/riscv: Check memory access to meet svuket
 rule
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000cd2d250626b37ece"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x530.google.com
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

--000000000000cd2d250626b37ece
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for refining it.
I fixed some parts and will put them in the V3 patches.

Sincerely,
Fea

On Tue, Nov 12, 2024 at 2:32=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 11/8/24 5:52 AM, Fea.Wang wrote:
> > Follow the Svukte spec, do the memory access address checking
> >
> > 1. Include instruction fetches or explicit memory accesses
> > 2. System run in effective privilege U or VU
> > 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> >     instruction is HLV, HLVX, HSV and excute from U mode to VU mode
>
> typo: s/excute/execute
>
> > 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> > 5. Raises a page-fault exception corresponding to the original access
> >     type.
> >
> > Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   target/riscv/cpu_helper.c | 57 ++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 57 insertions(+)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 0a3ead69ea..725c049f7a 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -857,6 +857,57 @@ static int get_physical_address_pmp(CPURISCVState
> *env, int *prot, hwaddr addr,
> >       return TRANSLATE_SUCCESS;
> >   }
> >
> > +/*
> > + * Return 'true' means no need to do svukte check, or need to do svukt=
e
> and the
> > + * address is valid. Return 'false' means need to do svukte check but
> address
> > + * is invalid.
> > + */
>
> I think this function is doing a bit too much while not doing everything
> we need.
> For instance, we're still doing some checks in get_physical_address()
> prior to
> calling it.
>
> I would put all the svukte logic in two functions:
>
> - 'do_svukte_check' would check all dependencies for the svukte check per
> se
> - 'check_svukte_addr' would do the addr check if we need to do a svukte
> check
>
>
> An example:
>
>
>
> /* Returns 'true' if a svukte address check is needed */
> static bool do_svukte_check(CPURISCVState *env, bool first_stage,
>                              int mode, bool virt)
> {
>      bool ukte;
>
>      /* Svukte extension depends on Sv39. */
>      if (!(env_archcpu(env)->cfg.ext_svukte &&
>            first_stage &&
>            VM_1_10_SV39 =3D=3D get_field(env->satp, SATP64_MODE))) {
>          return false;
>      }
>
>      /*
>       * Check hstatus.HUKTE if the effective mode is switched to VU-mode =
by
>       * executing HLV/HLVX/HSV in U-mode.
>       * For other cases, check senvcfg.UKTE.
>       */
>      if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
>          ukte =3D !!(env->hstatus & HSTATUS_HUKTE);
>      } else {
>          ukte =3D !!(env->senvcfg & SENVCFG_UKTE);
>      }
>
>      if (!ukte) {
>          return false;
>      }
>
>      /*
>       * Svukte extension is qualified only in U or VU-mode.
>       *
>       * Effective mode can be switched to U or VU-mode by:
>       *   - M-mode + mstatus.MPRV=3D1 + mstatus.MPP=3DU-mode.
>       *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=3D0.
>       *   - U-mode.
>       *   - VU-mode.
>       *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=3D1.
>       */
>      if (mode !=3D PRV_U) {
>          return false;
>      }
>
>      return true;
> }
>
>
> static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
> {
>      uint32_t sxl =3D riscv_cpu_sxl(env);
>      sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;
>      uint32_t sxlen =3D 32 * sxl;
>      uint64_t high_bit =3D addr & (1UL << (sxlen - 1));
>
>      return !high_bit;
> }
>
>
> And then on get_physical_addr():
>
>
>      if (do_svukte_check(env, first_stage, mode, virt) &&
>          !check_svukte_addr(env, addr)) {
>          return TRANSLATE_FAIL;
>      }
>
>
> Feel free to use these functions (compiled tested only) if you want.
> Thanks,
>
> Daniel
>
>
> > +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,
> > +                               int mode, bool virt)
> > +{
> > +    /*
> > +     * Check hstatus.HUKTE if the effective mode is switched to VU-mod=
e
> by
> > +     * executing HLV/HLVX/HSV in U-mode.
> > +     * For other cases, check senvcfg.UKTE.
> > +     */
> > +    bool ukte;
> > +    if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
> > +        ukte =3D !!(env->hstatus & HSTATUS_HUKTE);
> > +    } else {
> > +        ukte =3D !!(env->senvcfg & SENVCFG_UKTE);
> > +    }
> > +
> > +    if (VM_1_10_SV39 !=3D get_field(env->satp, SATP64_MODE))  {
> > +        /* Svukte extension depends on Sv39. */
> > +        return true;
> > +    }> +
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
> > +        return true;
> > +    }
> > +
> > +    if (!ukte) {
> > +        return true;
> > +    }
> > +
> > +    uint32_t sxl =3D riscv_cpu_sxl(env);
> > +    sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;
> > +    uint32_t sxlen =3D 32 * sxl;
> > +    uint64_t high_bit =3D addr & (1UL << (sxlen - 1));
> > +
> > +    return !high_bit;
> > +}
> > +
> >   /*
> >    * get_physical_address - get the physical address for this virtual
> address
> >    *
> > @@ -894,6 +945,7 @@ static int get_physical_address(CPURISCVState *env,
> hwaddr *physical,
> >       MemTxResult res;
> >       MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
> >       int mode =3D mmuidx_priv(mmu_idx);
> > +    bool virt =3D mmuidx_2stage(mmu_idx);
> >       bool use_background =3D false;
> >       hwaddr ppn;
> >       int napot_bits =3D 0;
> > @@ -901,6 +953,11 @@ static int get_physical_address(CPURISCVState *env=
,
> hwaddr *physical,
> >       bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D
> MMU_IDX_SS_WRITE);
> >       bool sstack_page =3D false;
> >
> > +    if (env_archcpu(env)->cfg.ext_svukte && first_stage &&
> > +        !check_svukte_valid(env, addr, mode, virt)) {
> > +        return TRANSLATE_FAIL;
> > +    }
> > +
> >       /*
> >        * Check if we should use the background registers for the two
> >        * stage translation. We don't need to check if we actually need
>

--000000000000cd2d250626b37ece
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for refining it.<div>I fixed some parts and will=
 put them in the V3 patches.</div><div><br></div><div>Sincerely,<br>Fea</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Nov 12, 2024 at 2:32=E2=80=AFAM Daniel Henrique Barboza &lt;<a hr=
ef=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 11/8/24 5:52 AM, Fea.Wang wrote:<br>
&gt; Follow the Svukte spec, do the memory access address checking<br>
&gt; <br>
&gt; 1. Include instruction fetches or explicit memory accesses<br>
&gt; 2. System run in effective privilege U or VU<br>
&gt; 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if<br>
&gt;=C2=A0 =C2=A0 =C2=A0instruction is HLV, HLVX, HSV and excute from U mod=
e to VU mode<br>
<br>
typo: s/excute/execute<br>
<br>
&gt; 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]<br>
&gt; 5. Raises a page-fault exception corresponding to the original access<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0type.<br>
&gt; <br>
&gt; Ref: <a href=3D"https://github.com/riscv/riscv-isa-manual/pull/1564/fi=
les" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-is=
a-manual/pull/1564/files</a><br>
&gt; <br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=
=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 57 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index 0a3ead69ea..725c049f7a 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -857,6 +857,57 @@ static int get_physical_address_pmp(CPURISCVState=
 *env, int *prot, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return TRANSLATE_SUCCESS;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * Return &#39;true&#39; means no need to do svukte check, or need to=
 do svukte and the<br>
&gt; + * address is valid. Return &#39;false&#39; means need to do svukte c=
heck but address<br>
&gt; + * is invalid.<br>
&gt; + */<br>
<br>
I think this function is doing a bit too much while not doing everything we=
 need.<br>
For instance, we&#39;re still doing some checks in get_physical_address() p=
rior to<br>
calling it.<br>
<br>
I would put all the svukte logic in two functions:<br>
<br>
- &#39;do_svukte_check&#39; would check all dependencies for the svukte che=
ck per se<br>
- &#39;check_svukte_addr&#39; would do the addr check if we need to do a sv=
ukte check<br>
<br>
<br>
An example:<br>
<br>
<br>
<br>
/* Returns &#39;true&#39; if a svukte address check is needed */<br>
static bool do_svukte_check(CPURISCVState *env, bool first_stage,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mode, bool virt)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0bool ukte;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Svukte extension depends on Sv39. */<br>
=C2=A0 =C2=A0 =C2=A0if (!(env_archcpu(env)-&gt;cfg.ext_svukte &amp;&amp;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first_stage &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM_1_10_SV39 =3D=3D get_field(env-=
&gt;satp, SATP64_MODE))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Check hstatus.HUKTE if the effective mode is switche=
d to VU-mode by<br>
=C2=A0 =C2=A0 =C2=A0 * executing HLV/HLVX/HSV in U-mode.<br>
=C2=A0 =C2=A0 =C2=A0 * For other cases, check senvcfg.UKTE.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (env-&gt;priv =3D=3D PRV_U &amp;&amp; !env-&gt;virt_=
enabled &amp;&amp; virt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ukte =3D !!(env-&gt;hstatus &amp; HSTATUS=
_HUKTE);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ukte =3D !!(env-&gt;senvcfg &amp; SENVCFG=
_UKTE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!ukte) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Svukte extension is qualified only in U or VU-mode.<=
br>
=C2=A0 =C2=A0 =C2=A0 *<br>
=C2=A0 =C2=A0 =C2=A0 * Effective mode can be switched to U or VU-mode by:<b=
r>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- M-mode + mstatus.MPRV=3D1 + mstatus.MP=
P=3DU-mode.<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- Execute HLV/HLVX/HSV from HS-mode + hs=
tatus.SPVP=3D0.<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- U-mode.<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- VU-mode.<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0- Execute HLV/HLVX/HSV from U-mode + hst=
atus.HU=3D1.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (mode !=3D PRV_U) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
}<br>
<br>
<br>
static bool check_svukte_addr(CPURISCVState *env, vaddr addr)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t sxl =3D riscv_cpu_sxl(env);<br>
=C2=A0 =C2=A0 =C2=A0sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t sxlen =3D 32 * sxl;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t high_bit =3D addr &amp; (1UL &lt;&lt; (sxlen -=
 1));<br>
<br>
=C2=A0 =C2=A0 =C2=A0return !high_bit;<br>
}<br>
<br>
<br>
And then on get_physical_addr():<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (do_svukte_check(env, first_stage, mode, virt) &amp;=
&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!check_svukte_addr(env, addr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRANSLATE_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
Feel free to use these functions (compiled tested only) if you want. Thanks=
,<br>
<br>
Daniel<br>
<br>
<br>
&gt; +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mode, bool virt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Check hstatus.HUKTE if the effective mode is sw=
itched to VU-mode by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* executing HLV/HLVX/HSV in U-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For other cases, check senvcfg.UKTE.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool ukte;<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv =3D=3D PRV_U &amp;&amp; !env-&gt;virt_=
enabled &amp;&amp; virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ukte =3D !!(env-&gt;hstatus &amp; HSTATUS=
_HUKTE);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ukte =3D !!(env-&gt;senvcfg &amp; SENVCFG=
_UKTE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (VM_1_10_SV39 !=3D get_field(env-&gt;satp, SATP64_MO=
DE))=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Svukte extension depends on Sv39. */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }&gt; +<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ukte) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t sxl =3D riscv_cpu_sxl(env);<br>
&gt; +=C2=A0 =C2=A0 sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;<br>
&gt; +=C2=A0 =C2=A0 uint32_t sxlen =3D 32 * sxl;<br>
&gt; +=C2=A0 =C2=A0 uint64_t high_bit =3D addr &amp; (1UL &lt;&lt; (sxlen -=
 1));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return !high_bit;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * get_physical_address - get the physical address for thi=
s virtual address<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; @@ -894,6 +945,7 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxResult res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int mode =3D mmuidx_priv(mmu_idx);<br>
&gt; +=C2=A0 =C2=A0 bool virt =3D mmuidx_2stage(mmu_idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_background =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr ppn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int napot_bits =3D 0;<br>
&gt; @@ -901,6 +953,11 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_sstack_idx =3D ((mmu_idx &amp; MMU_I=
DX_SS_WRITE) =3D=3D MMU_IDX_SS_WRITE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool sstack_page =3D false;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (env_archcpu(env)-&gt;cfg.ext_svukte &amp;&amp; firs=
t_stage &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !check_svukte_valid(env, addr, mode, virt=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Check if we should use the background reg=
isters for the two<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * stage translation. We don&#39;t need to c=
heck if we actually need<br>
</blockquote></div>

--000000000000cd2d250626b37ece--

