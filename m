Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E3DD711CF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 00:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWOPa-0001nl-Av; Thu, 18 Dec 2025 19:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vWOPZ-0001nN-CX
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 19:32:01 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vWOPX-00085D-Ba
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 19:32:01 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so2062988a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1766104317; x=1766709117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D0yR8kp7NLsZvgruL0E1sFSbTQ99snQ+XZn9pYrHIDs=;
 b=BRd9gvVT7Jg2QpZfcBEe+EUSfiCo/We5zoCQLkV0GqSzp/WaEcKxj3puJD5NhZ0ewU
 v0vx8deZW1JLap7aQPm9KUbcbte3uvpJMi5OSdGUzYw8MOXedYmZtU1DUN+WmiLU4L7P
 h3sjlrbHKvZdu0Ar+EBg/qLSg5TAq/sLHZj1lLoRMNMxeeP8pTBNri5I5Zx56MWaokJJ
 aQH+Q9YNokVz5qdlD1i8Z9sjeInkKYIC2WRJFH5LnaVvGrm+fUajBl0GcZrVa3edlpKR
 vaiRyh0oW7kq6j5y9lujuT1ThbmzmxvLIuv0NF1vGwMEkCinYpZZv0nVwQINF2jpOdcj
 Hidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766104317; x=1766709117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0yR8kp7NLsZvgruL0E1sFSbTQ99snQ+XZn9pYrHIDs=;
 b=SGGJoDurgUn55RTNceQzJ+y9AV7MPZ6hzqX0nIoaA91kaVgI8W42FqiOMm/fffouN/
 NAJxp8cI7yRjEikLyBhn3MscJi0aMnjfl50myxAV/yFWLtMlDmGZ6lWijXwdirq6EeLo
 HDXXg1taOSbEK7yNX7KFxoJoQkKW+02dYkE6ZqZyMouhAHjd1VB9EzcfLsj0sIl7tAUJ
 IFvysPa7AO2Na+I60fy/c6PV3CK/ev67nA4O2VoCJSO5WM9fst74rwWTDqFCIS1bpV8i
 AR3PSy9YmB3o8IHRUInfaAtLHxnibNWBUAgZ9QyRNt9gvDSdIt0u61OJYoIkwwHyF89m
 9lhQ==
X-Gm-Message-State: AOJu0YzsUZ66/Cwf+kKUcPxhsOVGxmptnPuab4XElgiY5fK/qlm3F15P
 L/280yujbd4Oi+9x0rob1GfgXblqHNsPZqcVb8FCaODMeZccHkekeuU/EgnH89Yr8T5TFPy24Sf
 62kl0gnn1f8vLnGXae684RDCNHNrt2nQfyuLsSKTFlg==
X-Gm-Gg: AY/fxX4pc9l3ienaUGfZtF7PSxUzCHAhR8F+EhGyQmLNh0asLJr8Hioj4YiHdSpgZNi
 WJnBzq+qGISRF5zPl4LV1Alef6vGSGRBDG4V7NDm0fB0HsccowuBggYQrgWuzvNi+MJFOLApx0B
 10HAwA6e5RYzmP12MoK7UZ2LC4lZo3WnedyU68giaUN7CPGFbw4ef64LD3pOCbIaZ6W+PQ6Cgrt
 7lGGXxiCrfsb6cwFi2GkijYkuBpJkhkFWIlYG6EkRLI77bPv57z5sj9hE4RBvVasb7bWoXieA==
X-Google-Smtp-Source: AGHT+IENO4FXuQinuwbx/0KPriy6t2Q+7OPBy3F3g5z2SvK+v5ZAVJhcjsIInd0rgjZxspogpgeWwM317EpGEZoHViQ=
X-Received: by 2002:a17:907:6d06:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b80371d4462mr102453166b.56.1766104317228; Thu, 18 Dec 2025
 16:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20251217063955.1037737-1-frank.chang@sifive.com>
 <477a8f96-de1b-404f-b754-012e6ac32430@ventanamicro.com>
In-Reply-To: <477a8f96-de1b-404f-b754-012e6ac32430@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 19 Dec 2025 08:31:45 +0800
X-Gm-Features: AQt7F2qQBLFsqOjGcKANbxT328_mSkZVhuJTMShNtGe4qg8dRVmrCFB3lWP641s
Message-ID: <CAE_xrPjqmgRvsHm5JuWafVz_jeNW8sEwu89i7m=5JxqYapbhjQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="00000000000077067a0646433473"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52e.google.com
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

--00000000000077067a0646433473
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Dec 18, 2025 at 9:05=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 12/17/25 3:39 AM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Use designated initializers to initialize riscv_excp_names[] and
> > riscv_intr_names[] so that we don't have to explicitly add "reserved"
> > items.
>
> You also added entries that were missing before in both arrays (sw_check,
> hw_error, semihost, counter_overflow ...). Not sure if it's worth sending=
 a
> v2 just to amend the commit msg though.
>

Sure, I can do that.

Regards,
Frank Chang


>
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Max Chou <max.chou@sifive.com>
> > ---
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
> >   target/riscv/cpu.c | 89 +++++++++++++++++++++++----------------------=
-
> >   1 file changed, 45 insertions(+), 44 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index aa58ba8b99a..ee859093f78 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] =3D {
> >   };
> >
> >   static const char * const riscv_excp_names[] =3D {
> > -    "misaligned_fetch",
> > -    "fault_fetch",
> > -    "illegal_instruction",
> > -    "breakpoint",
> > -    "misaligned_load",
> > -    "fault_load",
> > -    "misaligned_store",
> > -    "fault_store",
> > -    "user_ecall",
> > -    "supervisor_ecall",
> > -    "hypervisor_ecall",
> > -    "machine_ecall",
> > -    "exec_page_fault",
> > -    "load_page_fault",
> > -    "reserved",
> > -    "store_page_fault",
> > -    "double_trap",
> > -    "reserved",
> > -    "reserved",
> > -    "reserved",
> > -    "guest_exec_page_fault",
> > -    "guest_load_page_fault",
> > -    "reserved",
> > -    "guest_store_page_fault",
> > +    [RISCV_EXCP_INST_ADDR_MIS] =3D "misaligned_fetch",
> > +    [RISCV_EXCP_INST_ACCESS_FAULT] =3D "fault_fetch",
> > +    [RISCV_EXCP_ILLEGAL_INST] =3D "illegal_instruction",
> > +    [RISCV_EXCP_BREAKPOINT] =3D "breakpoint",
> > +    [RISCV_EXCP_LOAD_ADDR_MIS] =3D "misaligned_load",
> > +    [RISCV_EXCP_LOAD_ACCESS_FAULT] =3D "fault_load",
> > +    [RISCV_EXCP_STORE_AMO_ADDR_MIS] =3D "misaligned_store",
> > +    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] =3D "fault_store",
> > +    [RISCV_EXCP_U_ECALL] =3D "user_ecall",
> > +    [RISCV_EXCP_S_ECALL] =3D "supervisor_ecall",
> > +    [RISCV_EXCP_VS_ECALL] =3D "hypervisor_ecall",
> > +    [RISCV_EXCP_M_ECALL] =3D "machine_ecall",
> > +    [RISCV_EXCP_INST_PAGE_FAULT] =3D "exec_page_fault",
> > +    [RISCV_EXCP_LOAD_PAGE_FAULT] =3D "load_page_fault",
> > +    [RISCV_EXCP_STORE_PAGE_FAULT] =3D "store_page_fault",
> > +    [RISCV_EXCP_DOUBLE_TRAP] =3D "double_trap",
> > +    [RISCV_EXCP_SW_CHECK] =3D "sw_check",
> > +    [RISCV_EXCP_HW_ERR] =3D "hw_error",
> > +    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] =3D "guest_exec_page_fault",
> > +    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] =3D "guest_load_page_fault",
> > +    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] =3D "virt_illegal_instruction"=
,
> > +    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] =3D
> "guest_store_page_fault",
> > +    [RISCV_EXCP_SEMIHOST] =3D "semihost",
> >   };
> >
> >   static const char * const riscv_intr_names[] =3D {
> > -    "u_software",
> > -    "s_software",
> > -    "vs_software",
> > -    "m_software",
> > -    "u_timer",
> > -    "s_timer",
> > -    "vs_timer",
> > -    "m_timer",
> > -    "u_external",
> > -    "s_external",
> > -    "vs_external",
> > -    "m_external",
> > -    "reserved",
> > -    "reserved",
> > -    "reserved",
> > -    "reserved"
> > +    [IRQ_U_SOFT] =3D "u_software",
> > +    [IRQ_S_SOFT] =3D "s_software",
> > +    [IRQ_VS_SOFT] =3D "vs_software",
> > +    [IRQ_M_SOFT] =3D "m_software",
> > +    [IRQ_U_TIMER] =3D "u_timer",
> > +    [IRQ_S_TIMER] =3D "s_timer",
> > +    [IRQ_VS_TIMER] =3D "vs_timer",
> > +    [IRQ_M_TIMER] =3D "m_timer",
> > +    [IRQ_U_EXT] =3D "u_external",
> > +    [IRQ_S_EXT] =3D "s_external",
> > +    [IRQ_VS_EXT] =3D "vs_external",
> > +    [IRQ_M_EXT] =3D "m_external",
> > +    [IRQ_S_GEXT] =3D "s_guest_external",
> > +    [IRQ_PMU_OVF] =3D "counter_overflow",
> >   };
> >
> >   const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
> >   {
> >       if (async) {
> > -        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> > -               riscv_intr_names[cause] : "(unknown)";
> > +        if ((cause < ARRAY_SIZE(riscv_intr_names)) &&
> riscv_intr_names[cause]) {
> > +            return riscv_intr_names[cause];
> > +        }
> >       } else {
> > -        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
> > -               riscv_excp_names[cause] : "(unknown)";
> > +        if ((cause < ARRAY_SIZE(riscv_excp_names)) &&
> riscv_excp_names[cause]) {
> > +            return riscv_excp_names[cause];
> > +        }
> >       }
> > +
> > +    return "(unknown)";
> >   }
> >
> >   void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
>
>

--00000000000077067a0646433473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Daniel,<div><br></div></div><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Dec 18, 2025 at 9:05=E2=80=AFPM Daniel Henrique Barboza &lt;<a hr=
ef=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 12/17/25 3:39 AM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_b=
lank">frank.chang@sifive.com</a> wrote:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; <br>
&gt; Use designated initializers to initialize riscv_excp_names[] and<br>
&gt; riscv_intr_names[] so that we don&#39;t have to explicitly add &quot;r=
eserved&quot;<br>
&gt; items.<br>
<br>
You also added entries that were missing before in both arrays (sw_check,<b=
r>
hw_error, semihost, counter_overflow ...). Not sure if it&#39;s worth sendi=
ng a<br>
v2 just to amend the commit msg though.<br></blockquote><div><br></div><div=
><div>Sure, I can=C2=A0do that.</div><div><br></div><div>Regards,</div><div=
>Frank Chang</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" targe=
t=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; ---<br>
Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza@o=
ss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>&gt;<=
br>
<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 45 insertions(+), 44 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index aa58ba8b99a..ee859093f78 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] =3D {<br=
>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const char * const riscv_excp_names[] =3D {<br>
&gt; -=C2=A0 =C2=A0 &quot;misaligned_fetch&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;fault_fetch&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;illegal_instruction&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;breakpoint&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;misaligned_load&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;fault_load&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;misaligned_store&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;fault_store&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;user_ecall&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;supervisor_ecall&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;hypervisor_ecall&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;machine_ecall&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;exec_page_fault&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;load_page_fault&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;store_page_fault&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;double_trap&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;guest_exec_page_fault&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;guest_load_page_fault&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;guest_store_page_fault&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_INST_ADDR_MIS] =3D &quot;misaligned_fetch&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_INST_ACCESS_FAULT] =3D &quot;fault_fetch&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_ILLEGAL_INST] =3D &quot;illegal_instruction=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_BREAKPOINT] =3D &quot;breakpoint&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_ADDR_MIS] =3D &quot;misaligned_load&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_ACCESS_FAULT] =3D &quot;fault_load&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_STORE_AMO_ADDR_MIS] =3D &quot;misaligned_st=
ore&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] =3D &quot;fault_sto=
re&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_U_ECALL] =3D &quot;user_ecall&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_S_ECALL] =3D &quot;supervisor_ecall&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_VS_ECALL] =3D &quot;hypervisor_ecall&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_M_ECALL] =3D &quot;machine_ecall&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_INST_PAGE_FAULT] =3D &quot;exec_page_fault&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_PAGE_FAULT] =3D &quot;load_page_fault&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_STORE_PAGE_FAULT] =3D &quot;store_page_faul=
t&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_DOUBLE_TRAP] =3D &quot;double_trap&quot;,<b=
r>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_SW_CHECK] =3D &quot;sw_check&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_HW_ERR] =3D &quot;hw_error&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_INST_GUEST_PAGE_FAULT] =3D &quot;guest_exec=
_page_fault&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] =3D &quot;guest_lo=
ad_page_fault&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] =3D &quot;virt_ille=
gal_instruction&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] =3D &quot;gue=
st_store_page_fault&quot;,<br>
&gt; +=C2=A0 =C2=A0 [RISCV_EXCP_SEMIHOST] =3D &quot;semihost&quot;,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const char * const riscv_intr_names[] =3D {<br>
&gt; -=C2=A0 =C2=A0 &quot;u_software&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;s_software&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;vs_software&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;m_software&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;u_timer&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;s_timer&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;vs_timer&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;m_timer&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;u_external&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;s_external&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;vs_external&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;m_external&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;reserved&quot;<br>
&gt; +=C2=A0 =C2=A0 [IRQ_U_SOFT] =3D &quot;u_software&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_S_SOFT] =3D &quot;s_software&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_VS_SOFT] =3D &quot;vs_software&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_M_SOFT] =3D &quot;m_software&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_U_TIMER] =3D &quot;u_timer&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_S_TIMER] =3D &quot;s_timer&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_VS_TIMER] =3D &quot;vs_timer&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_M_TIMER] =3D &quot;m_timer&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_U_EXT] =3D &quot;u_external&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_S_EXT] =3D &quot;s_external&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_VS_EXT] =3D &quot;vs_external&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_M_EXT] =3D &quot;m_external&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_S_GEXT] =3D &quot;s_guest_external&quot;,<br>
&gt; +=C2=A0 =C2=A0 [IRQ_PMU_OVF] =3D &quot;counter_overflow&quot;,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0const char *riscv_cpu_get_trap_name(target_ulong cause, bo=
ol async)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (async) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (cause &lt; ARRAY_SIZE(riscv_intr_=
names)) ?<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_intr_nam=
es[cause] : &quot;(unknown)&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((cause &lt; ARRAY_SIZE(riscv_intr_nam=
es)) &amp;&amp; riscv_intr_names[cause]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return riscv_intr_names[cau=
se];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (cause &lt; ARRAY_SIZE(riscv_excp_=
names)) ?<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_excp_nam=
es[cause] : &quot;(unknown)&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((cause &lt; ARRAY_SIZE(riscv_excp_nam=
es)) &amp;&amp; riscv_excp_names[cause]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return riscv_excp_names[cau=
se];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return &quot;(unknown)&quot;;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t e=
xt)<br>
<br>
</blockquote></div></div>

--00000000000077067a0646433473--

