Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7F6F53D77
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2B8e-0005Xh-Gz; Mon, 16 Mar 2026 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2B8b-0005Ww-DQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:49:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2B8Z-00087G-4j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:49:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b0484a6de4so8726885ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773679789; cv=none;
 d=google.com; s=arc-20240605;
 b=LASz9IP1JY9aM7oq9Pnu5UXgBZvg45elT3TthnmMDhmzLXw3yiD29ZiOh2xrsRrWmt
 FRxIgZCz5nScng1C17upwQEUVqt8YM00dmvmCDgDA0RiIbULb3F1H41/Bb98oqa20qOk
 54HSaJ5h3WA1/CnLF+5ZXI5rGztQ2qtltEsTF72I+UC6dYRhX+bEr9PlQWqO+x/khm5s
 ifqxVoHybygyvovgfsUzBpHNZWt/d2D90cXrdYQTfE4UvcTEvtQpopyBq/I6nczjOd/0
 pDKfpb4dCpkZ0PkRfPnGjNrsM/JHj89IKhR+th1fAfFLWd/oc44e0gRmrsOCr3D3i1H9
 BAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mX2IEpchplLWianILBZdZOhRZQYHCjBimYepcm84tQI=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=fbIaEsbHD+FVrQ0MrtvCSVN8PRjMZ1hCs6bdwsdvRE5evRjtucF3dP+ZPnrb2He0ls
 ADTX2gB9ylZiRrWtlcclbVa3frEcnW8TDWhB3a9CA8u79lnGk93l970E0vO7wRROakOm
 0Lf5euP5FyrF1GDXzm4GsUpYAB1A8xYvbYAovHmiOKxCFWYDcPpOVhOaZjuXBMtfhKM5
 1rQSfOtmgqElZs/Z3e/z0k9fXNjRu/dj7MAc2kprhXCqMFo0dVZb2jurlVbtZcdtmKiq
 Q7IAVDEU8cDABrq907+DyR51vEb2JN+eLKylOOnsA81X9Yoa7IOp16ZCjRhilw1CJWqd
 GVWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773679789; x=1774284589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mX2IEpchplLWianILBZdZOhRZQYHCjBimYepcm84tQI=;
 b=CD8wXCaF4nPZfpnqzYq/x6p/ny+9ZLpvK0dIwXBqIvHk7rDyPQxl5skf70Ez51ChGj
 BQxeaoYbWOthwyiW2mjGGx4GfWIXWKOo70ywsjY1CuRQkrHdL8GHErKGgEbsoKNv53xx
 uzQLBoX0M1rDX2S5oueXt2yPQivjFqv8j4HRYvurmfvAKdFAgQnRxPiQXBeltDg77fpV
 vj3ZUEj1aJ9pE0siuZRIUdtWvU4xAp1SmQYfvsCUE6zaJha4hmOvMhw98MOk+VIRvR24
 bAnQ5+aJB6H2W+2Wj1voLU/PiXjRn0YOqpqrjb8Ee1ET2JTxNpveFvHUiXuwLf6BbMtK
 FrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773679789; x=1774284589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mX2IEpchplLWianILBZdZOhRZQYHCjBimYepcm84tQI=;
 b=Cm+qIL1GO7UEICrq3AVanwTHfDQkkXKavLuszFoTnQNG9G0u4z1ot0LdfIoK289Pe2
 LwtSCi1cX3WJuuWA3cEKoM2z6ggt8/m14bC0aRCLvFy64d1GkoRLLKno5dsrZ3DIi7+n
 gyr9cy+S7VXKm9W0txcETsRe7ZKOvBsFBIYETfgteu1XbducZafIdBYVDyXk5XKuXyuL
 HgM4hpb07hq9BHwBnY3iaF61BTwXAoD1QiU4bkGfD6FSbDw1F7JdsTSwwnh2q5wTGH5G
 /nUCCHIVmF+JS/f/Bi9kUv4cn3ovmGv1dPpELA/JUgIlEi+UVailxTqiyykk6RW2Lz0C
 eASw==
X-Gm-Message-State: AOJu0Yw4eLDHoYpDnF0Tsq5fcS3HCNErrRyNMPCwqce7KFY/efk0SvOn
 t0U+53k+vySgA0Pg0xMgpxgECmCcIX5h800M2nbbP0JXASdsQC/im5wTAv2sOtrZH7lXcOucXoL
 vNjIDAjmqlodEF9eM3mdPKIrOwWZeRRQ=
X-Gm-Gg: ATEYQzx44tGThyc+hh5ryKDtVV1PrWnA9Cd7C66AWnpyn6q9UKUAFQBlal1Ize3p2Oz
 jQIvgnDVhziyperAy9jQqJOTFTw9Dvgqr6Ev61q7zIbacNk7e/ZBPlLvioBH69Yv44bVG/u5gy4
 t8eTwNGsh15uJMx52k59fqReAJregoKIXqbboexFFNU8YY8d5x79L5KQ4WhZnfSI3cVH+7QH1Bp
 nC8BJXxddlI7LMW7i2VwFn7J3C/0MctN8i0gH2bdvxPhqAc3l/olIIhKt8x4wfnVZS+9sO4AvEz
 jG5arrCZBxdec7f9e+bvwRQLvK+VCj/h36eDCA==
X-Received: by 2002:a17:902:f551:b0:2b0:5075:96d1 with SMTP id
 d9443c01a7336-2b05075974amr57324415ad.24.1773679788619; Mon, 16 Mar 2026
 09:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-19-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-19-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 10:49:36 -0600
X-Gm-Features: AaiRm53H2Ho4MwOtyqmGsUdNDuxnZhnUIZ7m-4-UzApjNy_1PyynyYUWmTmoEf8
Message-ID: <CAATN3Nod_fUbmdgXJefj160D7vW3HbMF-J0P3aG5NqK7kJpsjw@mail.gmail.com>
Subject: Re: [PATCH v3 18/32] target/hexagon: Implement setprio, resched
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000befc71064d2701ef"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000befc71064d2701ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The hardware-assisted scheduler helps manage tasks on the run queue
> and interrupt steering.
>
> This instruction is defined in the Qualcomm Hexagon V71 Programmer's
> Reference
> Manual -
>
> https://docs.qualcomm.com/bundle/publicresource/80-N2040-51_REV_AB_Hexago=
n_V71_ProgrammerS_Reference_Manual.pdf
> See =C2=A711.9.2 SYSTEM MONITOR.
>

This document doesn't have a section 11.9.2.


>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 75 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 9090a5c20ab..36822219b4b 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1575,6 +1575,62 @@ static void hexagon_wait_thread(CPUHexagonState
> *env, uint32_t PC)
>      cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>  }
>
> +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
> +{
> +    uint32_t schedcfg;
> +    uint32_t schedcfg_en;
> +    int int_number;
> +    CPUState *cs;
> +    uint32_t lowest_th_prio =3D 0; /* 0 is highest prio */
> +    uint32_t bestwait_reg;
> +    uint32_t best_prio;
> +
> +    BQL_LOCK_GUARD();
> +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    schedcfg =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
> +                               env->threadId) : 0;
> +    schedcfg_en =3D GET_FIELD(SCHEDCFG_EN, schedcfg);
> +    int_number =3D GET_FIELD(SCHEDCFG_INTNO, schedcfg);
> +
> +    if (!schedcfg_en) {
> +        return;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *thread =3D HEXAGON_CPU(cs);
> +        CPUHexagonState *thread_env =3D &(thread->env);
> +        uint32_t th_prio =3D GET_FIELD(
> +            STID_PRIO, thread_env->t_sreg[HEX_SREG_STID]);
> +        if (!hexagon_thread_is_enabled(thread_env)) {
> +            continue;
> +        }
> +
> +        lowest_th_prio =3D (lowest_th_prio > th_prio)
> +            ? lowest_th_prio
> +            : th_prio;
> +    }
> +
> +    bestwait_reg =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_BESTWAIT,
> +                               env->threadId) : 0;
> +    best_prio =3D GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
> +
> +    /*
> +     * If the lowest priority thread is lower priority than the
> +     * value in the BESTWAIT register, we must raise the reschedule
> +     * interrupt on the lowest priority thread.
> +     */
> +    if (lowest_th_prio > best_prio) {
> +        qemu_log_mask(CPU_LOG_INT,
> +                "%s: raising resched int %d, cur PC 0x" TARGET_FMT_lx
> "\n",
>

Don't use %d


> +                __func__, int_number, env->gpr[HEX_REG_PC]);
> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
>

Is ~0 the correct value here?  Seems like it should be best_prio.


> +        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
> +    }
> +}
> +
>  void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>  {
>      BQL_LOCK_GUARD();
> @@ -1680,8 +1736,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState
> *env, uint32_t reg)
>      g_assert_not_reached();
>  }
>
> +/*
> + * setprio/resched - See the Hexagon V73 Programmer's Reference Manual,
> + * Section 6.4 "Interrupt and Thread Scheduling"
>

Neither the V71 (mentioned above) or V73 PRM contain section 6.4.


> + */
>  void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t pri=
o)
>  {
> +    CPUState *cs;
> +
> +    BQL_LOCK_GUARD();
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env =3D &found_cpu->env;
> +        if (thread =3D=3D found_env->threadId) {
> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio);
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "%s: tid " TARGET_FMT_lx " prio =3D 0x%x\n",
>

Don't use %x


> +                          __func__, found_env->threadId, prio);
> +            resched(env);
> +            return;
> +        }
> +    }
>      g_assert_not_reached();
>  }
>
> --
> 2.34.1
>
>

--000000000000befc71064d2701ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The hardware-assisted scheduler helps manage tasks on the run queue<br>
and interrupt steering.<br>
<br>
This instruction is defined in the Qualcomm Hexagon V71 Programmer&#39;s Re=
ference<br>
Manual -<br>
<a href=3D"https://docs.qualcomm.com/bundle/publicresource/80-N2040-51_REV_=
AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf" rel=3D"noreferrer" target=
=3D"_blank">https://docs.qualcomm.com/bundle/publicresource/80-N2040-51_REV=
_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf</a><br>
See =C2=A711.9.2 SYSTEM MONITOR.<br></blockquote><div><br></div><div>This d=
ocument doesn&#39;t have a section 11.9.2.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/op_helper.c | 75 +++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 75 insertions(+)<br>
<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index 9090a5c20ab..36822219b4b 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -1575,6 +1575,62 @@ static void hexagon_wait_thread(CPUHexagonState *env=
, uint32_t PC)<br>
=C2=A0 =C2=A0 =C2=A0cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
=C2=A0}<br>
<br>
+static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t schedcfg;<br>
+=C2=A0 =C2=A0 uint32_t schedcfg_en;<br>
+=C2=A0 =C2=A0 int int_number;<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+=C2=A0 =C2=A0 uint32_t lowest_th_prio =3D 0; /* 0 is highest prio */<br>
+=C2=A0 =C2=A0 uint32_t bestwait_reg;<br>
+=C2=A0 =C2=A0 uint32_t best_prio;<br>
+<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot;%s: check resched\n&quot;, =
__func__);<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 schedcfg =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_SCHEDCFG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 schedcfg_en =3D GET_FIELD(SCHEDCFG_EN, schedcfg);<br>
+=C2=A0 =C2=A0 int_number =3D GET_FIELD(SCHEDCFG_INTNO, schedcfg);<br>
+<br>
+=C2=A0 =C2=A0 if (!schedcfg_en) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *thread =3D HEXAGON_CPU(cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *thread_env =3D &amp;(thread-&=
gt;env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t th_prio =3D GET_FIELD(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STID_PRIO, thread_env-&gt;t_sreg=
[HEX_SREG_STID]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!hexagon_thread_is_enabled(thread_env)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lowest_th_prio =3D (lowest_th_prio &gt; th_pri=
o)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? lowest_th_prio<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : th_prio;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 bestwait_reg =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_BESTWAIT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 best_prio =3D GET_FIELD(BESTWAIT_PRIO, bestwait_reg);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If the lowest priority thread is lower priority than=
 the<br>
+=C2=A0 =C2=A0 =C2=A0* value in the BESTWAIT register, we must raise the re=
schedule<br>
+=C2=A0 =C2=A0 =C2=A0* interrupt on the lowest priority thread.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (lowest_th_prio &gt; best_prio) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: raising =
resched int %d, cur PC 0x&quot; TARGET_FMT_lx &quot;\n&quot;,<br></blockquo=
te><div><br></div><div>Don&#39;t use %d</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, int_numb=
er, env-&gt;gpr[HEX_REG_PC]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTW=
AIT_PRIO, ~0);<br></blockquote><div><br></div><div>Is ~0 the correct value =
here?=C2=A0 Seems like it should be best_prio.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_raise_interrupts(env, 1 &lt;&lt; int_numbe=
r, CPU_INTERRUPT_SWI);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0void HELPER(wait)(CPUHexagonState *env, uint32_t PC)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BQL_LOCK_GUARD();<br>
@@ -1680,8 +1736,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env=
, uint32_t reg)<br>
=C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0}<br>
<br>
+/*<br>
+ * setprio/resched - See the Hexagon V73 Programmer&#39;s Reference Manual=
,<br>
+ * Section 6.4 &quot;Interrupt and Thread Scheduling&quot;<br></blockquote=
><div><br></div><div>Neither the V71 (mentioned above) or V73 PRM contain s=
ection 6.4.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+ */<br>
=C2=A0void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t =
prio)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *found_env =3D &amp;found_cpu-=
&gt;env;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (thread =3D=3D found_env-&gt;threadId) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SET_SYSTEM_FIELD(found_env, HEX_=
SREG_STID, STID_PRIO, prio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;%s: tid &quot; TARGET_FMT_lx &quot; prio =3D 0x%x\n=
&quot;,<br></blockquote><div><br></div><div>Don&#39;t use %x</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, found_env-&gt;threadId, prio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resched(env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000befc71064d2701ef--

