Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BFEFD88DD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09GB-00081P-8A; Tue, 10 Mar 2026 22:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09Fx-0007uH-Rh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:25:06 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09Fv-0003Sw-Hy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:25:05 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso8163454a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773195901; cv=none;
 d=google.com; s=arc-20240605;
 b=TzAjyHVURCs7pMcVbDI3Uh9tbKKyPzuDq3XyCz9gTRjhzfAqW+ayIx+9s4wn3QOPFW
 1GbM6+O4HFOp8XqwCJIR7Co+XIuGDE203fo5KC1OEc+afwq/PsiNQaTGyu3zNDO7CJ4H
 2upZuB5S13Bj8YQolfb18ujfqRP0+U6GRDv07PbcJVXbpl64XYZu8dQQzsyxPVRTTv6G
 eggbAFVw+G+rmkegNzaaDgNMDJUqPcLtRA+302JkrKv1yhhf8ZBXWEH6zRchi2HrDn/q
 26dY2mpmSiaz2vFd4nBg2vWju0Ftk+rNJLR6ARiZI3g5zm9qoN9hKoabcAHVYPvvvgbB
 9giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Je33uYuYYh8W4BPU9ischYDV8mwsZmAtrOKmQCbU1Cg=;
 fh=p0o87481X8DMfEQPg4fgutCq5vl5kEb0ZOmB5Rr5lek=;
 b=QKvdzQtfYGhKKYgsyWuDj8UudGiTSc+PsfB9qZVZD8YTQhBKnScdErO84aKryTVy1D
 Fx72/YZwEwoi26FQVHgvGeswhYv96oWkoHDkFNld6yHICo16GCJUBivgbdLBlua4KHR9
 u2Lb+wwM7EidV9462CzCnGno2yEFiGVk1UoHAh7+rMt5O4pd/2omxtFbeGApt58x0TjK
 dl/WdvqBHpuFGICHJC1o8OHPDrhUEZilCjJAEd8i/mPt/GlTI8cXmJALYXGi9+evJlKW
 sbFLIloum6PYmLz8jYvlD0G4MauAXkYR8hqGFpucBWJo9nbkqftfCulWiO3gSz2FFH51
 VVRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773195901; x=1773800701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Je33uYuYYh8W4BPU9ischYDV8mwsZmAtrOKmQCbU1Cg=;
 b=DZ+cWfsgyPGrGqek1Al9ODVuXzg3FeH4awJxQIyceZt9+xoTask6cBTZc5RhkCrcWH
 dkWl5QQ4Zl+nUthRlLFckO/OH1IN9BmfQ7SjvpPcxCcr2CoKCKNAWHxMV4hsORnT46Rl
 zgWLTjmzSVOe4vPSUGbZoJxZECwOg8XrJ1VqQUtCh6UIJWzjjtDS5dTbrKEIhaJc46IV
 VLrYt1t5hHXUMZeZ4GKY7mUgsGHz7qgwDo8iGEi9gN+3nQcvWz3f64Hj6o4/4ITQPXDM
 Pdh4xPbALHYvbU66uc7RcAS5XfIIlIFum1ABDMxjNytuBcqP6cRngBNUStEJ9aG2oLs0
 inSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773195901; x=1773800701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je33uYuYYh8W4BPU9ischYDV8mwsZmAtrOKmQCbU1Cg=;
 b=NdJllSSqtJfpPhqGGLNXrocB2MiBgIQuxsVUXRex819BZUzXQaoZOAwTYB91urS9I9
 nRn2wRXb1bucDmWXixr8w4uxBTXOFP2kHqN8SQYi+GqGQq+CjhrEj+azHDuFMp3eWDhZ
 9CHgfafur6Xp9DGlvh4T+JZ+CZ3tNVNyVOpB/TVe+WtLEZ4yXM/y/+7R+f8ctxZ3stK5
 N7mPssjsnD/h28EA+Xcs4ut05/fZnq5A27l+4UzHOWtKOXYbFKZvPa+mArkgTDK7Y70e
 6jI192ie+SUUkbvD2zvWtHNcmzN5+Tl40jyCs5iqP2HP2on3rczRsTBVAJRFgnflijkv
 AmcA==
X-Gm-Message-State: AOJu0YwReBeFs+athGsxjVYejZcAINpeT1SgUg0ClIjfzwC1wopz6J5r
 c9j1ZHlLwTXq1rP7TxAb/ZrQDJZd/2K4Kf1vK+75GejMOzDQK5SK1Wf3V3yTWDveOXdhgx/nkA+
 OvZDGLZL7DGu1oE0TfLcPc7HTMwc8Hz7Z0/hDSjWJLv/t7+h54EwmImW+Dw==
X-Gm-Gg: ATEYQzygNi5SfUPj8KIDJW6kj5N3akk4v+NKATPQGfxiKvDXm1Yy8DrO7bsIHFk7XJB
 cwF0hdEwVMU8AF4Z5RmhEvSPApmvE+DOPXZ9j1sC0EqENZQvKGUPPjBpFgu5zUxouIjtRU/ZMw6
 h/DjCLDsmYHDthiLHKxUnG2QPB7msmBdcY2Ud6vt+qLcd1LXGExqrpUZnaAq3otCuqiubN/2rQj
 h7O0K0eXM2/XXgR05OsJdDGJKeEGI+LpJfozqA7olgC0QPwztSV6JdLTY7cZcsjU/V7nh4xU8Br
 hWAPxVxDSQ==
X-Received: by 2002:a05:6402:2551:b0:661:3f3c:400d with SMTP id
 4fb4d7f45d1cf-66319de2bddmr313829a12.26.1773195901354; Tue, 10 Mar 2026
 19:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251219040943.1570449-1-frank.chang@sifive.com>
In-Reply-To: <20251219040943.1570449-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Mar 2026 10:24:50 +0800
X-Gm-Features: AaiRm538gHop36O_gc3rF0nKeyC8ryQfvWOqwMw8wzFNQQCY1upoAabhYVuaDIs
Message-ID: <CAE_xrPikFnjgxPX9kumz818s00z=OODCJ_vdHqQ5mr9vRKQYxQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000d15602064cb657a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52c.google.com
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

--000000000000d15602064cb657a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping

Thanks,
Frank Chang

On Fri, Dec 19, 2025 at 12:09=E2=80=AFPM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> Use designated initializers to initialize riscv_excp_names[] and
> riscv_intr_names[] so that we don't have to explicitly add "reserved"
> items. Also, add the missing trap names: sw_check, hw_error,
> virt_illegal_instruction, semihost, s_guest_external, and
> counter_overflow.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index aa58ba8b99a..ee859093f78 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] =3D {
>  };
>
>  static const char * const riscv_excp_names[] =3D {
> -    "misaligned_fetch",
> -    "fault_fetch",
> -    "illegal_instruction",
> -    "breakpoint",
> -    "misaligned_load",
> -    "fault_load",
> -    "misaligned_store",
> -    "fault_store",
> -    "user_ecall",
> -    "supervisor_ecall",
> -    "hypervisor_ecall",
> -    "machine_ecall",
> -    "exec_page_fault",
> -    "load_page_fault",
> -    "reserved",
> -    "store_page_fault",
> -    "double_trap",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "guest_exec_page_fault",
> -    "guest_load_page_fault",
> -    "reserved",
> -    "guest_store_page_fault",
> +    [RISCV_EXCP_INST_ADDR_MIS] =3D "misaligned_fetch",
> +    [RISCV_EXCP_INST_ACCESS_FAULT] =3D "fault_fetch",
> +    [RISCV_EXCP_ILLEGAL_INST] =3D "illegal_instruction",
> +    [RISCV_EXCP_BREAKPOINT] =3D "breakpoint",
> +    [RISCV_EXCP_LOAD_ADDR_MIS] =3D "misaligned_load",
> +    [RISCV_EXCP_LOAD_ACCESS_FAULT] =3D "fault_load",
> +    [RISCV_EXCP_STORE_AMO_ADDR_MIS] =3D "misaligned_store",
> +    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] =3D "fault_store",
> +    [RISCV_EXCP_U_ECALL] =3D "user_ecall",
> +    [RISCV_EXCP_S_ECALL] =3D "supervisor_ecall",
> +    [RISCV_EXCP_VS_ECALL] =3D "hypervisor_ecall",
> +    [RISCV_EXCP_M_ECALL] =3D "machine_ecall",
> +    [RISCV_EXCP_INST_PAGE_FAULT] =3D "exec_page_fault",
> +    [RISCV_EXCP_LOAD_PAGE_FAULT] =3D "load_page_fault",
> +    [RISCV_EXCP_STORE_PAGE_FAULT] =3D "store_page_fault",
> +    [RISCV_EXCP_DOUBLE_TRAP] =3D "double_trap",
> +    [RISCV_EXCP_SW_CHECK] =3D "sw_check",
> +    [RISCV_EXCP_HW_ERR] =3D "hw_error",
> +    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] =3D "guest_exec_page_fault",
> +    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] =3D "guest_load_page_fault",
> +    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] =3D "virt_illegal_instruction",
> +    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] =3D "guest_store_page_faul=
t",
> +    [RISCV_EXCP_SEMIHOST] =3D "semihost",
>  };
>
>  static const char * const riscv_intr_names[] =3D {
> -    "u_software",
> -    "s_software",
> -    "vs_software",
> -    "m_software",
> -    "u_timer",
> -    "s_timer",
> -    "vs_timer",
> -    "m_timer",
> -    "u_external",
> -    "s_external",
> -    "vs_external",
> -    "m_external",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "reserved"
> +    [IRQ_U_SOFT] =3D "u_software",
> +    [IRQ_S_SOFT] =3D "s_software",
> +    [IRQ_VS_SOFT] =3D "vs_software",
> +    [IRQ_M_SOFT] =3D "m_software",
> +    [IRQ_U_TIMER] =3D "u_timer",
> +    [IRQ_S_TIMER] =3D "s_timer",
> +    [IRQ_VS_TIMER] =3D "vs_timer",
> +    [IRQ_M_TIMER] =3D "m_timer",
> +    [IRQ_U_EXT] =3D "u_external",
> +    [IRQ_S_EXT] =3D "s_external",
> +    [IRQ_VS_EXT] =3D "vs_external",
> +    [IRQ_M_EXT] =3D "m_external",
> +    [IRQ_S_GEXT] =3D "s_guest_external",
> +    [IRQ_PMU_OVF] =3D "counter_overflow",
>  };
>
>  const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
>  {
>      if (async) {
> -        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> -               riscv_intr_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_intr_names)) &&
> riscv_intr_names[cause]) {
> +            return riscv_intr_names[cause];
> +        }
>      } else {
> -        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
> -               riscv_excp_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_excp_names)) &&
> riscv_excp_names[cause]) {
> +            return riscv_excp_names[cause];
> +        }
>      }
> +
> +    return "(unknown)";
>  }
>
>  void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
> --
> 2.43.0
>
>

--000000000000d15602064cb657a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle ping<div><br></div><div>Thanks,</div><div>Frank Cha=
ng</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Dec 19, 2025 at 12:09=E2=80=AFPM &lt;=
<a href=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Frank=
 Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">fran=
k.chang@sifive.com</a>&gt;<br>
<br>
Use designated initializers to initialize riscv_excp_names[] and<br>
riscv_intr_names[] so that we don&#39;t have to explicitly add &quot;reserv=
ed&quot;<br>
items. Also, add the missing trap names: sw_check, hw_error,<br>
virt_illegal_instruction, semihost, s_guest_external, and<br>
counter_overflow.<br>
<br>
Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=3D"=
_blank">max.chou@sifive.com</a>&gt;<br>
Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza@o=
ss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>&gt;<=
br>
---<br>
=C2=A0target/riscv/cpu.c | 89 +++++++++++++++++++++++----------------------=
-<br>
=C2=A01 file changed, 45 insertions(+), 44 deletions(-)<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index aa58ba8b99a..ee859093f78 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] =3D {<br>
=C2=A0};<br>
<br>
=C2=A0static const char * const riscv_excp_names[] =3D {<br>
-=C2=A0 =C2=A0 &quot;misaligned_fetch&quot;,<br>
-=C2=A0 =C2=A0 &quot;fault_fetch&quot;,<br>
-=C2=A0 =C2=A0 &quot;illegal_instruction&quot;,<br>
-=C2=A0 =C2=A0 &quot;breakpoint&quot;,<br>
-=C2=A0 =C2=A0 &quot;misaligned_load&quot;,<br>
-=C2=A0 =C2=A0 &quot;fault_load&quot;,<br>
-=C2=A0 =C2=A0 &quot;misaligned_store&quot;,<br>
-=C2=A0 =C2=A0 &quot;fault_store&quot;,<br>
-=C2=A0 =C2=A0 &quot;user_ecall&quot;,<br>
-=C2=A0 =C2=A0 &quot;supervisor_ecall&quot;,<br>
-=C2=A0 =C2=A0 &quot;hypervisor_ecall&quot;,<br>
-=C2=A0 =C2=A0 &quot;machine_ecall&quot;,<br>
-=C2=A0 =C2=A0 &quot;exec_page_fault&quot;,<br>
-=C2=A0 =C2=A0 &quot;load_page_fault&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;store_page_fault&quot;,<br>
-=C2=A0 =C2=A0 &quot;double_trap&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;guest_exec_page_fault&quot;,<br>
-=C2=A0 =C2=A0 &quot;guest_load_page_fault&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;guest_store_page_fault&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_INST_ADDR_MIS] =3D &quot;misaligned_fetch&quot;,=
<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_INST_ACCESS_FAULT] =3D &quot;fault_fetch&quot;,<=
br>
+=C2=A0 =C2=A0 [RISCV_EXCP_ILLEGAL_INST] =3D &quot;illegal_instruction&quot=
;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_BREAKPOINT] =3D &quot;breakpoint&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_ADDR_MIS] =3D &quot;misaligned_load&quot;,<=
br>
+=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_ACCESS_FAULT] =3D &quot;fault_load&quot;,<b=
r>
+=C2=A0 =C2=A0 [RISCV_EXCP_STORE_AMO_ADDR_MIS] =3D &quot;misaligned_store&q=
uot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] =3D &quot;fault_store&qu=
ot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_U_ECALL] =3D &quot;user_ecall&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_S_ECALL] =3D &quot;supervisor_ecall&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_VS_ECALL] =3D &quot;hypervisor_ecall&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_M_ECALL] =3D &quot;machine_ecall&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_INST_PAGE_FAULT] =3D &quot;exec_page_fault&quot;=
,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_PAGE_FAULT] =3D &quot;load_page_fault&quot;=
,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_STORE_PAGE_FAULT] =3D &quot;store_page_fault&quo=
t;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_DOUBLE_TRAP] =3D &quot;double_trap&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_SW_CHECK] =3D &quot;sw_check&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_HW_ERR] =3D &quot;hw_error&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_INST_GUEST_PAGE_FAULT] =3D &quot;guest_exec_page=
_fault&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] =3D &quot;guest_load_pa=
ge_fault&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] =3D &quot;virt_illegal_i=
nstruction&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] =3D &quot;guest_st=
ore_page_fault&quot;,<br>
+=C2=A0 =C2=A0 [RISCV_EXCP_SEMIHOST] =3D &quot;semihost&quot;,<br>
=C2=A0};<br>
<br>
=C2=A0static const char * const riscv_intr_names[] =3D {<br>
-=C2=A0 =C2=A0 &quot;u_software&quot;,<br>
-=C2=A0 =C2=A0 &quot;s_software&quot;,<br>
-=C2=A0 =C2=A0 &quot;vs_software&quot;,<br>
-=C2=A0 =C2=A0 &quot;m_software&quot;,<br>
-=C2=A0 =C2=A0 &quot;u_timer&quot;,<br>
-=C2=A0 =C2=A0 &quot;s_timer&quot;,<br>
-=C2=A0 =C2=A0 &quot;vs_timer&quot;,<br>
-=C2=A0 =C2=A0 &quot;m_timer&quot;,<br>
-=C2=A0 =C2=A0 &quot;u_external&quot;,<br>
-=C2=A0 =C2=A0 &quot;s_external&quot;,<br>
-=C2=A0 =C2=A0 &quot;vs_external&quot;,<br>
-=C2=A0 =C2=A0 &quot;m_external&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;,<br>
-=C2=A0 =C2=A0 &quot;reserved&quot;<br>
+=C2=A0 =C2=A0 [IRQ_U_SOFT] =3D &quot;u_software&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_S_SOFT] =3D &quot;s_software&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_VS_SOFT] =3D &quot;vs_software&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_M_SOFT] =3D &quot;m_software&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_U_TIMER] =3D &quot;u_timer&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_S_TIMER] =3D &quot;s_timer&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_VS_TIMER] =3D &quot;vs_timer&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_M_TIMER] =3D &quot;m_timer&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_U_EXT] =3D &quot;u_external&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_S_EXT] =3D &quot;s_external&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_VS_EXT] =3D &quot;vs_external&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_M_EXT] =3D &quot;m_external&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_S_GEXT] =3D &quot;s_guest_external&quot;,<br>
+=C2=A0 =C2=A0 [IRQ_PMU_OVF] =3D &quot;counter_overflow&quot;,<br>
=C2=A0};<br>
<br>
=C2=A0const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (async) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (cause &lt; ARRAY_SIZE(riscv_intr_names=
)) ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_intr_names[ca=
use] : &quot;(unknown)&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((cause &lt; ARRAY_SIZE(riscv_intr_names)) =
&amp;&amp; riscv_intr_names[cause]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return riscv_intr_names[cause];<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (cause &lt; ARRAY_SIZE(riscv_excp_names=
)) ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_excp_names[ca=
use] : &quot;(unknown)&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((cause &lt; ARRAY_SIZE(riscv_excp_names)) =
&amp;&amp; riscv_excp_names[cause]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return riscv_excp_names[cause];<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return &quot;(unknown)&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000d15602064cb657a0--

