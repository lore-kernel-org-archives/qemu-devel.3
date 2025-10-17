Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E0CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jai-0005FN-31; Fri, 17 Oct 2025 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v9jaf-0005Ep-Qk
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:29:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v9jaa-0007BJ-Vf
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:29:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27ee41e0798so29584105ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760704174; x=1761308974; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vWmqt1v+3Y70kkV26yKBlbKyQnGOSAk1SbH8gXltSZw=;
 b=ENnI6Y5Xv33+dzBImnJh1BabdxdmXHS6g7YxTO3GeexGh1MYmt1YhorzqdlVhWE/jI
 SOy2eotMFqliziF/eoJoD9EzD7K0DEHOUjjwEVcHgAzHCrg1ej3GmdnQnytrxMLrU+H4
 rYk5w3pWCO3WEoQS8AZOoYWUgizHR99lQlqW7ZwSscabi58+mr+bbxdaYOBoxSnZ8tRn
 F4ivh6gFvsLTZNu7h/zSedbaUwltnzf8DEFdRJeivOJRVV0TqR6YdoPaZ8NZU1+0wkyd
 VjQN1bfxglUbor0o6TjvRp/rtmh/sbWNPuYp681MUtvpGD5LEbgi3UBJJZ+usFoKwfHR
 Byww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704174; x=1761308974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vWmqt1v+3Y70kkV26yKBlbKyQnGOSAk1SbH8gXltSZw=;
 b=iKouVN09Q+h2ypId4R2oGTjn2woOYSJ16eEhA6CvQiA5r8NRdlJzHsm8bRmeSgZrhG
 MvvejbeB+DMpjgvEw2MwTljWG7sMSGb8OjnMotJAHHktH7pA3GNTh0pTVfV1dBRDNY7Q
 IjoRnuVQFBQFkAbzqYM8QnVjmPQwQNbAqzRREdaY2rPNI7c/med2Enfr8hkhvKNam+kJ
 2cKThaWz266XoJAnFsMNNBgChUkEHtE0jctcEDW7+/mdd+qOWIYdPzsntvNxfxQ52jPl
 ULLztBteKfKArxe8kfLX8kAW5Xy8AVVIEVCBZEjEFbNk+dAbdcFnfKfCRsjFiAF+dwnT
 xVdA==
X-Gm-Message-State: AOJu0YwMTJy2OvEdOpQfoR9KJEPo7M/V3F8NPxnKiNw3VKBZlIcLfx1j
 RhbcSWW9gX40BqhnKeRDOB0R6jA7KE1Nqs0cgVtDk0dsAO8qk4SGhvGT7P8jV98ZdeIrxLFL6ir
 6WtwcOaJQ3kWVubzzDeKXGhcNq1jsUEEgvfM3KeSo6Q==
X-Gm-Gg: ASbGncvXVa1vVaacqi33kwoT+F4Za9mV9Ag5E2j0lXv2w4m6EUPnFNQeqqapjaOPvKV
 xbd+Bd5QR1RNN9kGJ6yhzd+ZBhowiTd8ytX2ajcuz7AOQeJLaa3UtayEdMS5e7ZINzsI1D9QYdS
 uB64aAIRn9s3W8Gb9uyk9Hy/y1Wmyw2F/Z11yzVCuP5GGeoYyXcj+CKCM9mTxAvKa51NWQ1PHxK
 03hEo7JQvi7K95ownPTCZ8JWhbRrdfy8lQLjanig4jJ7J/oBJII+bz2pP5ziz0=
X-Google-Smtp-Source: AGHT+IFduCMWpL1q4Zg37yWLeXaZxniYoNGc6Sniy2fuJGLwbBqrGSXic0Kso1C+am+bP2YxVnVdkgNpask7IaR6lwY=
X-Received: by 2002:a17:902:c947:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-290cbb49e26mr54097705ad.42.1760704174317; Fri, 17 Oct 2025
 05:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251014082338.87618-1-jay.chang@sifive.com>
 <20251014082338.87618-3-jay.chang@sifive.com>
 <CAKmqyKOxwPbJSimJH+Qx+aXP1dunQwamCWaObWMXfgA6+UJuqQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOxwPbJSimJH+Qx+aXP1dunQwamCWaObWMXfgA6+UJuqQ@mail.gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Fri, 17 Oct 2025 20:29:23 +0800
X-Gm-Features: AS18NWBhqiY1TLSPMZ3EsQjBVu_Qbs11jxqqzUae6H9yc2EFcLDkA6kBGIkf14k
Message-ID: <CACNNAjMw2NaTN1Q3wGK3wRW1xO4hOSptD5bNYriJeh1aV7Boeg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/riscv: Make PMP CSRs conform to WARL
 constraints
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000dd70e0064159e28c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62a.google.com
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

--000000000000dd70e0064159e28c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ll change UL to ULL.

As for the second point, according to the spec:

=E2=80=9CAlthough changing pmpcfgA[1] affects the value read from pmpaddr, =
it does
not affect the underlying value stored in that register.=E2=80=9D

If we modify the value at write time instead of masking on read, it could
cause issues during software context switches.
For example, if pmpaddr is programmed in NAPOT mode and software switches
to TOR mode for context save/restore (i.e., read pmpaddr =E2=86=92 write pm=
paddr in
TOR mode =E2=86=92 switch back to NAPOT), the NAPOT granularity bits pmpadd=
r[G-2:0]
would be lost because pmpaddr[G-1:0] reads as all zeros in TOR/OFF mode.
This behavior would be incorrect.

On Fri, Oct 17, 2025 at 9:02=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Oct 14, 2025 at 6:25=E2=80=AFPM Jay Chang <jay.chang@sifive.com> =
wrote:
> >
> > This patch ensure pmpcfg and pmpaddr comply with WARL constraints.
> >
> > When the PMP granularity is greater than 4 bytes, NA4 mode is not valid
> > per the spec and will be silently ignored.
> >
> > According to the spec, changing pmpcfg.A only affects the "read" value
> > of pmpaddr. When G > 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] read
> > as all ones. When G > 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-1:0]
> > read as all zeros. This allows software to read back the correct
> > granularity value.
> >
> > In addition, when updating the PMP address rule in TOR mode,
> > the start and end addresses of the PMP region should be aligned
> > to the PMP granularity. (The current SPEC only state in TOR mode
> > that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.)
> >
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 72f1372a49..a15265c8d2 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVState
> *env, uint8_t val)
> >          g_assert_not_reached();
> >      }
> >  }
> > +/*
> > + * Calculate PMP granularity value 'g'
> > + *
> > + * The granularity value 'g' is defined as log2(granularity) - 2, wher=
e
> > + * granularity is the minimum alignment requirement for PMP regions in
> bytes.
> > + */
> > +static inline int pmp_get_granularity_g(CPURISCVState *env)
> > +{
> > +    return __builtin_ctz(riscv_cpu_cfg(env)->pmp_granularity >> 2);
> > +}
> > +
> >
> >  /*
> >   * Count the number of active rules.
> > @@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env,
> uint32_t pmp_index, uint8_t val)
> >              qemu_log_mask(LOG_GUEST_ERROR,
> >                            "ignoring pmpcfg write - invalid\n");
> >          } else {
> > +            uint8_t a_field =3D pmp_get_a_field(val);
> > +            /*
> > +             * When granularity g >=3D 1 (i.e., granularity > 4 bytes)=
,
> > +             * the NA4 (Naturally Aligned 4-byte) mode is not selectab=
le
> > +             */
> > +            if ((riscv_cpu_cfg(env)->pmp_granularity >
> > +                MIN_RISCV_PMP_GRANULARITY) && (a_field =3D=3D
> PMP_AMATCH_NA4)) {
> > +                    return false;
> > +            }
> >              env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
> >              pmp_update_rule_addr(env, pmp_index);
> >              return true;
> > @@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env,
> uint32_t pmp_index)
> >      target_ulong prev_addr =3D 0u;
> >      hwaddr sa =3D 0u;
> >      hwaddr ea =3D 0u;
> > +    int g =3D pmp_get_granularity_g(env);
> >
> >      if (pmp_index >=3D 1u) {
> >          prev_addr =3D env->pmp_state.pmp[pmp_index - 1].addr_reg;
> > @@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env,
> uint32_t pmp_index)
> >          break;
> >
> >      case PMP_AMATCH_TOR:
> > +        /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching
> logic. */
> > +        if (g >=3D 1) {
> > +            prev_addr &=3D ~((1UL << g) - 1UL);
> > +            this_addr &=3D ~((1UL << g) - 1UL);
> > +        }
> >          if (prev_addr >=3D this_addr) {
> >              sa =3D ea =3D 0u;
> >              break;
> > @@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >
> >  /*
> >   * Handle a read from a pmpaddr CSR
> > + * Change A field of pmpcfg affects the read value of pmpaddr
> >   */
> >  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
> >  {
> > @@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env,
> uint32_t addr_index)
> >
> >      if (addr_index < pmp_regions) {
> >          val =3D env->pmp_state.pmp[addr_index].addr_reg;
> > +        int g =3D pmp_get_granularity_g(env);
> > +        switch
> (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
> > +        case PMP_AMATCH_OFF:
> > +            /* fallthrough */
> > +        case PMP_AMATCH_TOR:
> > +            /* Bit [g-1:0] read all zero */
> > +            if (g >=3D 1 && g < TARGET_LONG_BITS) {
> > +                val &=3D ~((1UL << g) - 1UL);
> > +            }
> > +            break;
> > +        case PMP_AMATCH_NAPOT:
> > +            /* Bit [g-2:0] read all one */
> > +            if (g >=3D 2 && g < TARGET_LONG_BITS) {
> > +                val |=3D ((1UL << (g - 1)) - 1UL);
> > +            }
>
> ULL instead of UL?
>
> Also should we just ensure a valid value is written? Instead of
> writing something invalid and then masking the read
>
> Alistair
>
> > +            break;
> > +        default:
> > +            break;
> > +        }
> >          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
> >      } else {
> >          qemu_log_mask(LOG_GUEST_ERROR,
> > --
> > 2.48.1
> >
> >
>

--000000000000dd70e0064159e28c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>I=E2=80=99ll change <code>UL</code> to=
 <code>ULL</code>.</p>
<p>As for the second point, according to the spec:</p>
<blockquote>
<p>=E2=80=9CAlthough changing pmpcfgA[1] affects the value read from pmpadd=
r, it does not affect the underlying value stored in that register.=E2=80=
=9D</p>
</blockquote>
<p>If we modify the value at write time instead of masking on read, it coul=
d cause issues during software context switches.<br>
For example, if <code>pmpaddr</code> is programmed in NAPOT mode and softwa=
re switches to TOR mode for context save/restore (i.e., read <code>pmpaddr<=
/code> =E2=86=92 write <code>pmpaddr</code> in TOR mode =E2=86=92 switch ba=
ck to NAPOT), the NAPOT granularity bits <code>pmpaddr[G-2:0]</code> would =
be lost because <code>pmpaddr[G-1:0]</code> reads as all zeros in TOR/OFF m=
ode. This behavior would be incorrect.</p></div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct=
 17, 2025 at 9:02=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistai=
r23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Tue, Oct 14, 2025 at 6:25=E2=80=AFPM =
Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" target=3D"_blank">jay=
.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch ensure pmpcfg and pmpaddr comply with WARL constraints.<br>
&gt;<br>
&gt; When the PMP granularity is greater than 4 bytes, NA4 mode is not vali=
d<br>
&gt; per the spec and will be silently ignored.<br>
&gt;<br>
&gt; According to the spec, changing pmpcfg.A only affects the &quot;read&q=
uot; value<br>
&gt; of pmpaddr. When G &gt; 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] r=
ead<br>
&gt; as all ones. When G &gt; 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-=
1:0]<br>
&gt; read as all zeros. This allows software to read back the correct<br>
&gt; granularity value.<br>
&gt;<br>
&gt; In addition, when updating the PMP address rule in TOR mode,<br>
&gt; the start and end addresses of the PMP region should be aligned<br>
&gt; to the PMP granularity. (The current SPEC only state in TOR mode<br>
&gt; that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.=
)<br>
&gt;<br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=
=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 46 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index 72f1372a49..a15265c8d2 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVStat=
e *env, uint8_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; +/*<br>
&gt; + * Calculate PMP granularity value &#39;g&#39;<br>
&gt; + *<br>
&gt; + * The granularity value &#39;g&#39; is defined as log2(granularity) =
- 2, where<br>
&gt; + * granularity is the minimum alignment requirement for PMP regions i=
n bytes.<br>
&gt; + */<br>
&gt; +static inline int pmp_get_granularity_g(CPURISCVState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return __builtin_ctz(riscv_cpu_cfg(env)-&gt;pmp_granula=
rity &gt;&gt; 2);<br>
&gt; +}<br>
&gt; +<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Count the number of active rules.<br>
&gt; @@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uin=
t32_t pmp_index, uint8_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUES=
T_ERROR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpcfg write - invalid\n&quot;);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t a_field =3D pmp_get=
_a_field(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When granularity g =
&gt;=3D 1 (i.e., granularity &gt; 4 bytes),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the NA4 (Naturally =
Aligned 4-byte) mode is not selectable<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((riscv_cpu_cfg(env)-&gt=
;pmp_granularity &gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIN_RISCV_PMP=
_GRANULARITY) &amp;&amp; (a_field =3D=3D PMP_AMATCH_NA4)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pmp_state.pmp[=
pmp_index].cfg_reg =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_update_rule_addr(e=
nv, pmp_index);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; @@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint=
32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong prev_addr =3D 0u;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr sa =3D 0u;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr ea =3D 0u;<br>
&gt; +=C2=A0 =C2=A0 int g =3D pmp_get_granularity_g(env);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (pmp_index &gt;=3D 1u) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_addr =3D env-&gt;pmp_state.pmp[=
pmp_index - 1].addr_reg;<br>
&gt; @@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uin=
t32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PMP_AMATCH_TOR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Bits pmpaddr[G-1:0] do not affect the =
TOR address-matching logic. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g &gt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_addr &amp;=3D ~((1UL &=
lt;&lt; g) - 1UL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 this_addr &amp;=3D ~((1UL &=
lt;&lt; g) - 1UL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_addr &gt;=3D this_addr) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =3D ea =3D 0u;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; @@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Handle a read from a pmpaddr CSR<br>
&gt; + * Change A field of pmpcfg affects the read value of pmpaddr<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_=
index)<br>
&gt;=C2=A0 {<br>
&gt; @@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env,=
 uint32_t addr_index)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (addr_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;pmp_state.pmp[addr_i=
ndex].addr_reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int g =3D pmp_get_granularity_g(env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (pmp_get_a_field(env-&gt;pmp_state=
.pmp[addr_index].cfg_reg)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PMP_AMATCH_OFF:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PMP_AMATCH_TOR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Bit [g-1:0] read all zer=
o */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g &gt;=3D 1 &amp;&amp; =
g &lt; TARGET_LONG_BITS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D =
~((1UL &lt;&lt; g) - 1UL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PMP_AMATCH_NAPOT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Bit [g-2:0] read all one=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g &gt;=3D 2 &amp;&amp; =
g &lt; TARGET_LONG_BITS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D ((1U=
L &lt;&lt; (g - 1)) - 1UL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
ULL instead of UL?<br>
<br>
Also should we just ensure a valid value is written? Instead of<br>
writing something invalid and then masking the read<br>
<br>
Alistair<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_pmpaddr_csr_read(env-&gt;mhart=
id, addr_index, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; --<br>
&gt; 2.48.1<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000dd70e0064159e28c--

