Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4B9C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYg2-0003ij-C3; Tue, 06 Feb 2024 22:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXYg0-0003iI-Bx
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:32:44 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXYfy-00011t-KR
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:32:44 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51165a488baso182358e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1707276759; x=1707881559; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H+7mfik/qsuw26YTNv+4TvESFtvaUC1lE+jZpdxOzls=;
 b=fijRlVxV98ItqS9Lz+LqPkY3HKo/X/UGhVbi32fSXspjKQnVbvZbg5z+eS/hvxEswm
 K8emz4dpcA2d1JrV6384DSvrhqm07S8vVuDSWiq5xMf+Id6k/TWXo9JHscxZnVqa3sNJ
 Iwl0rq9djCWD+89beMVK6/xfzzC5DzNwiCJ6/U/q64uUzSaYhrNQ8PfbFxx2NYfe134p
 0JhRtnqwOPw0QCcZI1KEAKjj1M02sXxfZ+lmJmz35Hmkh7Nvx3E03w2IibsXRuxKZS43
 zjHl13SVyf213ILVktqSrw4KWSEcDzO7DWGJPtKJrP6wdFLe13Ufm1TFvRmt/ay1FEIR
 JgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707276759; x=1707881559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+7mfik/qsuw26YTNv+4TvESFtvaUC1lE+jZpdxOzls=;
 b=Gh2jmIarZNEyP7uM8+PzqiCF505jVnU8/CwJCKg4Wl+LLP1vhCFhO2SWRNihCZtGF3
 4Epf1wQNiPoqUvxYbFdLQGPVsidnIDfwCIse3FYMD62fpoOKVuHN7L0DZHyMR2HqjB/e
 cwaOq+I3DrGau0p1csH9YIVYr1sXGpzt3kevRLtAVaP3CvxvmHqXmYw1s+zeucTt54vg
 PFbTHzrfgoaUMy4InAAn78gaZ+Ac41e+5hd7CiI8VKL6MM81fpdZi/uwkELAvM4I2CM4
 So0xlE6FqTEZnBfIJYvrYfxm+p0aqM6ebUdIaG2Wro6EMhfMjjqjh/sOeqpxAnfq1sKO
 zU+g==
X-Gm-Message-State: AOJu0Yy/HdlYPs6y/IEtdyoSQ1mqsTAEccKtZKVh4qGZBz5hwCzqr3r4
 k+lamoxsf/vldwqZiy2311qfM+D1wFeXTHRY/vriSR1XFRSIT8ys276JToZNv9+J61rQheG0Ec8
 mvkQyrxnCgWolyK4Migi0y+2zq/Is5b/wdrM5fw==
X-Google-Smtp-Source: AGHT+IEUdmb6+p590P7Mry4Ht6TF87xhmUv4ge9FUaS15f1pCfZ4xEEK8oELgmznHbJcHmDevI64owvK8UpVyhqXSMQ=
X-Received: by 2002:a05:651c:624:b0:2d0:a56f:95b5 with SMTP id
 k36-20020a05651c062400b002d0a56f95b5mr2547187lje.37.1707276759421; Tue, 06
 Feb 2024 19:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20240206131911.10998-1-jason.chien@sifive.com>
 <162e0b5c-ed98-4e84-af6e-9fdaea0dcc04@linaro.org>
In-Reply-To: <162e0b5c-ed98-4e84-af6e-9fdaea0dcc04@linaro.org>
From: Jason Chien <jason.chien@sifive.com>
Date: Wed, 7 Feb 2024 11:33:51 +0800
Message-ID: <CADr__8rwLz7=FvkCwncRy4fGsHYxe0BXEstB_1o_P14p37ZmYA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Update $pc after linking to $ra in
 trans_cm_jalt()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Content-Type: multipart/alternative; boundary="000000000000c7739a0610c258c6"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=jason.chien@sifive.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c7739a0610c258c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right. I'll send patch v2 shortly. Thank you for the reply.

Richard Henderson <richard.henderson@linaro.org> =E6=96=BC 2024=E5=B9=B42=
=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:24=E5=AF=AB=E9=
=81=93=EF=BC=9A

> On 2/6/24 23:18, Jason Chien wrote:
> > The original implementation sets $pc to the address read from the jump
> > vector table first and links $ra with the address of the next instructi=
on
> > after the updated $pc. After jumping to the updated $pc and executing t=
he
> > next ret instruction, the program jumps to $ra, which is in the same
> > function currently executing, which results in an infinite loop.
> > This commit reverses the two action. Firstly, $ra is updated with the
> > address of the next instruction after $pc, and sets $pc to the address
> > read from the jump vector table.
>
> This is unlikely to be correct in the case the vector table read faults,
> leaving $ra updated.
>
> I guess this got broken with CF_PCREL.  Anyway, the solution is to use a
> temporary...
>
> > -    /*
> > -     * Update pc to current for the non-unwinding exception
> > -     * that might come from cpu_ld*_code() in the helper.
> > -     */
> > -    gen_update_pc(ctx, 0);
> > -    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
>
> ... here and then ...
>
> > @@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx,
> arg_cm_jalt *a)
> >           gen_set_gpr(ctx, xRA, succ_pc);
> >       }
> >
>
> ... copy the temp to cpu_pc here.
>
> >       tcg_gen_lookup_and_goto_ptr();
> >       ctx->base.is_jmp =3D DISAS_NORETURN;
> >       return true;
>
>
>
> r~
>

--000000000000c7739a0610c258c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You are=C2=A0right. I&#39;ll send patch v2 shortly. Thank =
you for the reply.=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; =E6=96=BC 2024=E5=
=B9=B42=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:24=E5=AF=
=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 2/6/24 23:18, Jason Chien wrote:<br>
&gt; The original implementation sets $pc to the address read from the jump=
<br>
&gt; vector table first and links $ra with the address of the next instruct=
ion<br>
&gt; after the updated $pc. After jumping to the updated $pc and executing =
the<br>
&gt; next ret instruction, the program jumps to $ra, which is in the same<b=
r>
&gt; function currently executing, which results in an infinite loop.<br>
&gt; This commit reverses the two action. Firstly, $ra is updated with the<=
br>
&gt; address of the next instruction after $pc, and sets $pc to the address=
<br>
&gt; read from the jump vector table.<br>
<br>
This is unlikely to be correct in the case the vector table read faults,<br=
>
leaving $ra updated.<br>
<br>
I guess this got broken with CF_PCREL.=C2=A0 Anyway, the solution is to use=
 a temporary...<br>
<br>
&gt; -=C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* Update pc to current for the non-unwinding exce=
ption<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* that might come from cpu_ld*_code() in the help=
er.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 gen_update_pc(ctx, 0);<br>
&gt; -=C2=A0 =C2=A0 gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a-=
&gt;index));<br>
<br>
... here and then ...<br>
<br>
&gt; @@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_=
cm_jalt *a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_set_gpr(ctx, xRA, succ_pc)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
... copy the temp to cpu_pc here.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_lookup_and_goto_ptr();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;base.is_jmp =3D DISAS_NORETURN;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000c7739a0610c258c6--

