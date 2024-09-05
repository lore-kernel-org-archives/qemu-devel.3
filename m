Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDBECD4F56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 04:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm3tB-0001Is-J1; Thu, 05 Sep 2024 00:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sm3tA-0001Hs-Np
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:14:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sm3t8-0007rj-C3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:14:32 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2054feabfc3so3563775ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725509668; x=1726114468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnO6eqdLfjS7mwn3Pq4zArUO1FvawEc7bBUfHPssT5k=;
 b=TQm7xGo6pSCLUq/WubZeJbT7r0xOiMajePzLLPaoaeNMRvRjxlGLi+ipuUpDKhrIgw
 LaLhO/Q51nyJJIzLwZIGAGwrZcbsdntejPXWd92fv5LL2RHw3TSfyPfNro5K5EDvQZ1D
 q0I3IHLWLhANGtvE2XMkjU980dVsRvaCfFktg/oyNaGN8HyL3JHXcag0JpJyh/9PeUxo
 kovaOIk69lr8I86J9wbHPwFNEoSiJgK/X+AAEYcAtZixM4yly1c2dreM3qjQU64Dk4VE
 5IU7/BfMRpCBMqH/4i0oSrmFzykJXmnEyaC5WnyP13nZ3er3oMX5M8LnRbpMrMkwOQv3
 H9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725509668; x=1726114468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnO6eqdLfjS7mwn3Pq4zArUO1FvawEc7bBUfHPssT5k=;
 b=tbPkOC6X3+9Qb35Sq0ZolLesTsxw5VBB8VKPJ3Hifm2EYeuqxw928l9eZ/2zh3Xo+m
 IIKUKYTCLXEfyccrzFHsVFdzvMfP42iLRixpplMOjpNJXYqH95VFHJF6wEiC6eWGM23d
 3MH9RZSO+yZIEegS8X2VYmWQnU+UAiuRJR2CTcoB6PXIIZXhUTYnsmaR1ZLk/gZKekJi
 l3kJsI2TQMcVrJ2YS3GNtDAp/4WIxdrHF4iElJd2fA8OOxAH5m9CZIEd0Fu+OTLfl6Rm
 O+s4gMFTspYfnfF95bthr+t9NJQ6XWRVpdn3K1SdFpz2fUjUlIdXcjd7GzvJYPy9n52l
 3Ksw==
X-Gm-Message-State: AOJu0Yxl3ig1GgBAB2YsUAFtbEKrGvR5UvEz57eNq3MRMHQvorifDCio
 2QfhE8H3cH28gM4SmFoMWrcwWm/9HhD6PJ/nmcvcih508c2vbiqjfmO3c2YA69JAJZloJb+P9au
 PxQxfKLReMGog5dNQk8tTJN1rWeSknHTZPOjuqg==
X-Google-Smtp-Source: AGHT+IGU6e3jZZLrkV+owXMV/aAqwQwMm01BgOh1TocOfiJEO/E34QgNnnIHzwkR/NOXgmyF6Ck/+y5ZTdilIQEAMyc=
X-Received: by 2002:a17:902:ecca:b0:205:7b1f:cf66 with SMTP id
 d9443c01a7336-2057b1fd228mr105903325ad.35.1725509668165; Wed, 04 Sep 2024
 21:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240903061757.1114957-1-fea.wang@sifive.com>
 <20240903061757.1114957-5-fea.wang@sifive.com>
 <336979c7-4396-4475-9323-5e0523d27b5b@ventanamicro.com>
In-Reply-To: <336979c7-4396-4475-9323-5e0523d27b5b@ventanamicro.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Thu, 5 Sep 2024 12:14:16 +0800
Message-ID: <CAKhCfsf+o2tATzYFdMCe0Ah2Kk7PevN8u7RztyNeDj9t7v-SLA@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/riscv: Check memory access to meet svuket rule
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000d4013b062157869c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d4013b062157869c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your advice.
I will take them after the spec is more finalized.

Sincerely,
Fea

On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 9/3/24 3:17 AM, Fea.Wang wrote:
> > Follow the Svukte spec, do the memory access address checking
> >
> > 1. Include instruction fetches or explicit memory accesses
> > 2. System run in effective privilege U or VU
> > 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> >     instruction is HLV, HLVX, HSV and excute from U mode to VU mode
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
> >   target/riscv/cpu_helper.c | 55 ++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 395a1d9140..db65ed14b9 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -777,6 +777,54 @@ static int get_physical_address_pmp(CPURISCVState
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
> > +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,
> > +                               int mode, bool virt)
> > +{
> > +    if (VM_1_10_SV39 !=3D get_field(env->satp, SATP64_MODE))  {
> > +        /* Svukte extension depends on Sv39. */
> > +        return true;
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
> > +        return true;
> > +    }
> > +
> > +    /*
> > +     * Check hstatus.HUKTE if the effective mode is switched to VU-mod=
e
> by
> > +     * executing HLV/HLVX/HSV in U-mode.
> > +     * For other cases, check senvcfg.UKTE.
> > +     */
> > +    bool ukte =3D (env->priv =3D=3D PRV_U && !env->virt_enabled && vir=
t) ?
> > +                                           !!(env->hstatus &
> HSTATUS_HUKTE) :
> > +                                           !!(env->senvcfg &
> SENVCFG_UKTE);
>
> I would move the 'bool ukte' to the start of the function, and would avoi=
d
> the
> ternary to make the code a bit more readable:
>
>        if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
>            ukte =3D !!(env->hstatus & HSTATUS_HUKTE);
>        } else {
>            ukte =3D !!(env->senvcfg & SENVCFG_UKTE);
>        }
>
>
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
> > @@ -814,11 +862,18 @@ static int get_physical_address(CPURISCVState
> *env, hwaddr *physical,
> >       MemTxResult res;
> >       MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
> >       int mode =3D mmuidx_priv(mmu_idx);
> > +    bool virt =3D mmuidx_2stage(mmu_idx);
> >       bool use_background =3D false;
> >       hwaddr ppn;
> >       int napot_bits =3D 0;
> >       target_ulong napot_mask;
> >
> > +    if (first_stage) {
> > +        if (!check_svukte_valid(env, addr, mode, virt)) {
> > +            return TRANSLATE_FAIL;
> > +        }
> > +    }
> > +
>
> We can avoid the nested 'if':
>
> > +    if (first_stage && !check_svukte_valid(env, addr, mode, virt)) {
> > +        return TRANSLATE_FAIL;
> > +    }
>
>
> I would also add a check for ext_svukte before doing any checks. If we
> don't have
> the ext enabled we can skip everything:
>
>
> > +    if (env_archcpu(env)->cfg.ext_svukte && first_stage &&
> > +        !check_svukte_valid(env, addr, mode, virt)) {
> > +        return TRANSLATE_FAIL;
> > +    }
>
>
>
> Thanks,
>
> Daniel
>
>
> >       /*
> >        * Check if we should use the background registers for the two
> >        * stage translation. We don't need to check if we actually need
>

--000000000000d4013b062157869c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Thank you for your advice.<br>I will take them af=
ter the spec is more finalized.</div><div><br></div><div>Sincerely,<br>Fea<=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Daniel Henrique Barboza &lt;<a =
href=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 9/3/24 3:17 AM, Fea.Wang wrote:<br>
&gt; Follow the Svukte spec, do the memory access address checking<br>
&gt; <br>
&gt; 1. Include instruction fetches or explicit memory accesses<br>
&gt; 2. System run in effective privilege U or VU<br>
&gt; 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if<br>
&gt;=C2=A0 =C2=A0 =C2=A0instruction is HLV, HLVX, HSV and excute from U mod=
e to VU mode<br>
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
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 55 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index 395a1d9140..db65ed14b9 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -777,6 +777,54 @@ static int get_physical_address_pmp(CPURISCVState=
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
&gt; +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mode, bool virt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (VM_1_10_SV39 !=3D get_field(env-&gt;satp, SATP64_MO=
DE))=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Svukte extension depends on Sv39. */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Check hstatus.HUKTE if the effective mode is sw=
itched to VU-mode by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* executing HLV/HLVX/HSV in U-mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For other cases, check senvcfg.UKTE.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool ukte =3D (env-&gt;priv =3D=3D PRV_U &amp;&amp; !en=
v-&gt;virt_enabled &amp;&amp; virt) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0!!(env-&gt;hstatus &amp; HSTATUS_HUKTE) :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0!!(env-&gt;senvcfg &amp; SENVCFG_UKTE);<br>
<br>
I would move the &#39;bool ukte&#39; to the start of the function, and woul=
d avoid the<br>
ternary to make the code a bit more readable:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;priv =3D=3D PRV_U &amp;&amp; !env-&g=
t;virt_enabled &amp;&amp; virt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ukte =3D !!(env-&gt;hstatus &amp; =
HSTATUS_HUKTE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ukte =3D !!(env-&gt;senvcfg &amp; =
SENVCFG_UKTE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
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
&gt; @@ -814,11 +862,18 @@ static int get_physical_address(CPURISCVState *e=
nv, hwaddr *physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxResult res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int mode =3D mmuidx_priv(mmu_idx);<br>
&gt; +=C2=A0 =C2=A0 bool virt =3D mmuidx_2stage(mmu_idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_background =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr ppn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int napot_bits =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong napot_mask;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (first_stage) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_svukte_valid(env, addr, mode, =
virt)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
We can avoid the nested &#39;if&#39;:<br>
<br>
&gt; +=C2=A0 =C2=A0 if (first_stage &amp;&amp; !check_svukte_valid(env, add=
r, mode, virt)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
<br>
I would also add a check for ext_svukte before doing any checks. If we don&=
#39;t have<br>
the ext enabled we can skip everything:<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 if (env_archcpu(env)-&gt;cfg.ext_svukte &amp;&amp; firs=
t_stage &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !check_svukte_valid(env, addr, mode, virt=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Check if we should use the background reg=
isters for the two<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * stage translation. We don&#39;t need to c=
heck if we actually need<br>
</blockquote></div>

--000000000000d4013b062157869c--

