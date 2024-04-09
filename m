Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A1C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru4zX-0002O9-GJ; Tue, 09 Apr 2024 02:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1ru4zU-0002Lr-AH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:29:56 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1ru4zR-0005jo-Ux
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:29:56 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d6ff0422a2so65049611fa.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1712644191; x=1713248991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YNl4XRMhk+8qgIGEw0ZCW9ZqI2UvIL/DcKOJTTiqdA=;
 b=byMNp06ugngZkKuPmP3UOf6QOdxNzCpiNgpskC+btqbdggN1iL9+mLaFDpv3KbvtPh
 Uvi9iPdjdwzb0ObFFm3aDj33oxNSF3ithITRYNmqSggWOtAd8GGnf5RckwsoYEGtJFMh
 VdiclkkHTYIzckKPWVexXtNyG7ebcMU2zGGZVyLgqqNMyEF3O2oUKqMWxLRnILHJb0D4
 jXYN+79yr4FEacg1wsdyQBUA0UXnS1HiuWaY05gTx83mwTZGskVhRRwqpKsiJs0wdNpV
 T6g9DKPVy8Wt2oVVLplA2RskK8ejizOFkeMZIoO2nLtNmy6BlGpLIi90oCqItwtW4smU
 9KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712644191; x=1713248991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YNl4XRMhk+8qgIGEw0ZCW9ZqI2UvIL/DcKOJTTiqdA=;
 b=pZEYS1rGW1/66DaHKFMDJwYWOgf2DagGnEEV8RPru9lnOG4huIE4bJfKHcgOml2BR5
 y6O8poud7rPNvKWWkbyqfvhcXf5IsJlwPKFQCfnZo0zWWu/VRaeSxT3E/+hfYiitIvep
 YZ1oiz8YVCdyn6lyIj7tzQh8HOgy2aeuu80EgZpeUx8TfRnCuQa0ANItNpDJVIQrykRA
 urQMTUmXDF0lwZ4CraqJ17jNMnUJOrseyBjcUfi8kFrFlppypQS72oZlMjbhgk3XFjG6
 l90/o3aGfGTdwBDvqIGC8TN6eJOnDWfFOoeg8pJppi2+IvWGxvAG+2cCBz03KOZMHHR4
 BJag==
X-Gm-Message-State: AOJu0Yx8PTw7srdpoJ8xYn5t6ANrGI1UEDgA2iMJllztnvn5i62S+vUc
 Z9IUjQ9ltwQSAlWwJoLpwKI1DNbXnANWfeEigN8VBwhyavv3JO1lI9xQ/qFwJQKWPjuUxVKeHyK
 Pj6FpbuHlwBmpbVg+rBSLDju/d5l9JdWq2UhSLmY/f5ih82Nj4FA=
X-Google-Smtp-Source: AGHT+IHZ/rcSCbJ/4NIdfF8Or0Q6OIurnzbRj7E0cULnBUyxDnMiET1+Co+wxFJyFzgFnbXXhh/RWXhrzNsMxAk8UDU=
X-Received: by 2002:a2e:330e:0:b0:2d8:7a75:9452 with SMTP id
 d14-20020a2e330e000000b002d87a759452mr5412982ljc.29.1712644191066; Mon, 08
 Apr 2024 23:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240328022343.6871-1-jason.chien@sifive.com>
 <20240328022343.6871-4-jason.chien@sifive.com>
In-Reply-To: <20240328022343.6871-4-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Tue, 9 Apr 2024 14:29:39 +0800
Message-ID: <CADr__8oVf4r=F6pAkt1KERKoR3HG5ViX_4b+NxC9Zw7r3kDH6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Relax vector register check in RISCV
 gdbstub
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000a2bdd10615a40c1e"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x235.google.com
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

--000000000000a2bdd10615a40c1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:24=E5=AF=AB=E9=81=93=EF=BC=
=9A

> In current implementation, the gdbstub allows reading vector registers
> only if V extension is supported. However, all vector extensions and
> vector crypto extensions have the vector registers and they all depend
> on Zve32x. The gdbstub should check for Zve32x instead.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index be7a02cd90..d0cc5762c2 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -338,7 +338,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
e
> *cs)
>
> gdb_find_static_feature("riscv-32bit-fpu.xml"),
>                                   0);
>      }
> -    if (env->misa_ext & RVV) {
> +    if (cpu->cfg.ext_zve32x) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_vector,
>                                   riscv_gdb_set_vector,
>                                   ricsv_gen_dynamic_vector_feature(cs,
> cs->gdb_num_regs),
> --
> 2.43.2
>
>

--000000000000a2bdd10615a40c1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.<br></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">Jason Chien &lt;<a href=3D"mailto:jason.chien@sif=
ive.com">jason.chien@sifive.com</a>&gt; =E6=96=BC 2024=E5=B9=B43=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:24=E5=AF=AB=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">In curren=
t implementation, the gdbstub allows reading vector registers<br>
only if V extension is supported. However, all vector extensions and<br>
vector crypto extensions have the vector registers and they all depend<br>
on Zve32x. The gdbstub should check for Zve32x instead.<br>
<br>
Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" ta=
rget=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" targ=
et=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=3D"=
_blank">max.chou@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/gdbstub.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c<br>
index be7a02cd90..d0cc5762c2 100644<br>
--- a/target/riscv/gdbstub.c<br>
+++ b/target/riscv/gdbstub.c<br>
@@ -338,7 +338,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState =
*cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_find_static_feature(&quot=
;riscv-32bit-fpu.xml&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (env-&gt;misa_ext &amp; RVV) {<br>
+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32x) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_coprocessor(cs, riscv_gdb_ge=
t_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_gdb_set_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ricsv_gen_dynamic_vector_feat=
ure(cs, cs-&gt;gdb_num_regs),<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div>

--000000000000a2bdd10615a40c1e--

