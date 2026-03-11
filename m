Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017AEFD88DD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09I1-0000Jr-Ve; Tue, 10 Mar 2026 22:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09I0-0000J1-Dr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:12 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09Hy-0003r2-Il
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:12 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so1642241266b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773196028; cv=none;
 d=google.com; s=arc-20240605;
 b=LQM484bojiXFwiuoEgP/lESL3J+0xDbNdepCgmeAFnYisiOs8OhbB1Aibmfjw2P6N9
 APP3Y5ka4z4UAs9aGOZdMPjK/bLuCw+Xeydu+Jm4ujHvBgANfT2JaYJ1i3ngXO521I+/
 Ff65nVOnYKYwJCxq7zeQgpGgKDhfpSfc/HTWeUJuRxwOL6hQx2G77UryyG5i6sc8imFf
 FFgBiOa8nGV0KZdIRhViWPgtWZcbXADtfSuAEBhEiv+yLF+Iy5JiFc+Yc0EhYpMoX7/T
 hDv0TySNlxVb9YZZgn+gWV6jzk5rEH8f9Dzw5s/HA1KnXKHQGJLicrb5+rqJ5qT9Pn3g
 27Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BsSL5s0rHRE/r0dYJs7r9MTI92JwLihYWpJCgxLjuLw=;
 fh=b+RKw4yIbJk7fsc36bhqBdaX0+M7/xep84IGejy6EuU=;
 b=gL/Adn+36ezDgBvStiuXQBsBKJSvQP2Mo36hRobVLngkZRU+LpY3BLNIXMEoqlP1dl
 0DfF2iUZuxZFVn8oz7stMfbQK8SgXhW8vlVTMWtwwQs/Ce2wyUsuaoJF76a8EbRH3vBR
 ByyEWWALuWMgpAEtsQJcISZ7faC+EQCKaJBGo+Aa9AzJtNR3kvDvQzvhYLwk83hxoTZU
 XppdD7HZBrcrnwwor68cTxTAZ432EyUSJLpvwvAOrrLKbzvOr1HuzQznXRG0/VBMxolT
 luIJpMp2w70ZEsaDep5IusxLChZ4W571jxmWpohYJRV2MLV0V1BZ7968103YozX0Haxw
 37bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773196028; x=1773800828; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BsSL5s0rHRE/r0dYJs7r9MTI92JwLihYWpJCgxLjuLw=;
 b=gOLhhSlsoVS894X8SEYkoiaaoVRqpTeHUSLC/N+dbij3EbUGnkF5mpwggHHvC10FJO
 OLWHmy0tPm30gWPXtwhx/a9fHHHlQWXryOcUOBKB/0vLHNkt1vVexNp3lIwH37rz4TlX
 zCxDMJHgXLAAb9gOwUy+tv3LGKe5jdtK0vOEDfL5RXossNeLzW89SVNFhgWRT4N/4fZg
 kZQVjmgtmFm0W1fTpJ4KK2OLlL0/bH6iQOMinNZAzcftxoAJotIaBN7nivvA/4olrSsQ
 Z48PvO7icQRChwuYldl+dKDK4uAsnxiYXvQjamUHheF5xbQujkvlzD3UTFizEiw+TtZf
 6Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196028; x=1773800828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsSL5s0rHRE/r0dYJs7r9MTI92JwLihYWpJCgxLjuLw=;
 b=Dd8MHUBgY7hoFsWDCFcY/IFGrwBD3pzr6kHYpHm2sp9pBcFZecm7PurGD380IxP6zv
 wE2uRICw2genVKUWNeUD6n3PB6l5YLNOWnzq3uJDDspl+iczB3oK+CDN1k8AL6qcN6rJ
 NipqKVROnoRQJwGXDortAWCPy2/gf7GQiVJfPx2Rw4nNdZ3APJJbrWHeSXc5R6yGKc50
 9bJVdwSh4/98kEcJk7ASmyKd1ThDLpVyPYSZ52YdDutaf/H6drViJ1U7DMDtWJwxII4j
 bTPCsBQuTW6EO/LJSzfl6SVYULlMT13DB8uVxxwi49z8T+rcfVVhT4GiGIyXvaRb3kQ3
 +Igg==
X-Gm-Message-State: AOJu0YxDrnvt6z7jRSE6kQJTtpacxfN57ns7nshjK+z/L4os/l3D/42f
 /5eS5sshruBjqZs5EQb1hnb4+Jn+jRtCKVz8t8puG1WYwmZLWUmQGpM0PeBnLIbijRBWsBMLta2
 DS3h3sLuv1qRjLvrvFiY0XTXg5lzD0p40VGovvfj6x5+wdbbufPvCq5M=
X-Gm-Gg: ATEYQzwIEYtGUeJ1zAyOTOXrKmwzqaEV5WibOgItwOKJcr4G2GeYPw8ji9h+6RcaMEz
 c5lyqNooO3IiqA5nS2hZZTgcooL4SdOIDTdjXaF8CzOX1lcsGyS41bf5z9RPzr/kHgjWJNkMpYu
 YppvPqhLxmtDvt2QOC4Er+x5OSOa1gL47bHNTWT7EszW6HK1XUsejdG1tgMEysxDILz/VcFqXKx
 1s5bxHdPGeNiHwEIFmld763QgHODJXy9NYIHMz24elFFB+Qx2A+/co9LyMUepJ0f5M3ULeeLbzu
 BN8OZgx31g==
X-Received: by 2002:a17:907:3e99:b0:b96:df8c:42cb with SMTP id
 a640c23a62f3a-b972e534dcbmr33849366b.46.1773196028272; Tue, 10 Mar 2026
 19:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251128022302.970294-1-frank.chang@sifive.com>
 <20251128022302.970294-2-frank.chang@sifive.com>
In-Reply-To: <20251128022302.970294-2-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Mar 2026 10:26:57 +0800
X-Gm-Features: AaiRm51Ov94gyvq6fRhVgYf_jwAKKN03ElzDM5vC8Q8XFweJTHdR2sNjuFIW4wI
Message-ID: <CAE_xrPh7f9gNZ03otROrbwVKF2EB4-gu5QihQCyWjbmo4VRgaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Update MISA.C for Zc* extensions
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="00000000000061f91d064cb65f0a"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x62d.google.com
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

--00000000000061f91d064cb65f0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping

Thanks~

On Fri, Nov 28, 2025 at 10:23=E2=80=AFAM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.C is set if the following extensions are selected:
>   * Zca and not F.
>   * Zca, Zcf and F (but not D) is specified (RV32 only).
>   * Zca, Zcf and Zcd if D is specified (RV32 only).
>   * Zca, Zcd if D is specified (RV64 only).
>
> Therefore, we need to set MISA.C according to the rules for Zc*
> extensions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 440626ddfad..752eee32289 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1150,6 +1150,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCP=
U
> *cpu)
>      }
>  }
>
> +/*
> + * MISA.C is set if the following extensions are selected:
> + *   - Zca and not F.
> + *   - Zca, Zcf and F (but not D) is specified on RV32.
> + *   - Zca, Zcf and Zcd if D is specified on RV32.
> + *   - Zca, Zcd if D is specified on RV64.
> + */
> +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> +        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
> +                                   riscv_has_ext(env, RVF))) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1157,6 +1188,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,
> Error **errp)
>
>      riscv_cpu_init_implied_exts_rules();
>      riscv_cpu_enable_implied_rules(cpu);
> +    riscv_cpu_update_misa_c(cpu);
>
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
> --
> 2.43.0
>
>

--00000000000061f91d064cb65f0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle ping<div><br></div><div>Thanks~</div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Nov 28, 2025 at 10:23=E2=80=AFAM &lt;<a href=3D"mailto:fran=
k.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">From: Frank Chang &lt;<a href=3D"=
mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>=
&gt;<br>
<br>
MISA.C is set if the following extensions are selected:<br>
=C2=A0 * Zca and not F.<br>
=C2=A0 * Zca, Zcf and F (but not D) is specified (RV32 only).<br>
=C2=A0 * Zca, Zcf and Zcd if D is specified (RV32 only).<br>
=C2=A0 * Zca, Zcd if D is specified (RV64 only).<br>
<br>
Therefore, we need to set MISA.C according to the rules for Zc*<br>
extensions.<br>
<br>
Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=3D"=
_blank">max.chou@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 32 insertions(+)<br>
<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index 440626ddfad..752eee32289 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -1150,6 +1150,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU =
*cpu)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+/*<br>
+ * MISA.C is set if the following extensions are selected:<br>
+ *=C2=A0 =C2=A0- Zca and not F.<br>
+ *=C2=A0 =C2=A0- Zca, Zcf and F (but not D) is specified on RV32.<br>
+ *=C2=A0 =C2=A0- Zca, Zcf and Zcd if D is specified on RV32.<br>
+ *=C2=A0 =C2=A0- Zca, Zcd if D is specified on RV64.<br>
+ */<br>
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)<br>
+{<br>
+=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zca &amp;&amp; !riscv_has_ext(env, RVF))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_ext |=
 RVC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zca &amp;&amp; cpu-&gt;cfg.ext=
_zcf &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (riscv_has_ext(env, RVD) ? cpu-&gt;cfg.ext_zcd=
 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_has_ext(env, RVF)=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_ext |=
 RVC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zca &amp;&amp; cpu-&gt;cfg.ext=
_zcd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-&gt;misa_ext |=
 RVC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
@@ -1157,6 +1188,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, E=
rror **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0riscv_cpu_init_implied_exts_rules();<br>
=C2=A0 =C2=A0 =C2=A0riscv_cpu_enable_implied_rules(cpu);<br>
+=C2=A0 =C2=A0 riscv_cpu_update_misa_c(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0riscv_cpu_validate_misa_priv(env, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err !=3D NULL) {<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--00000000000061f91d064cb65f0a--

