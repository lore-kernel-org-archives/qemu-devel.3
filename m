Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8998106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nt3-0005vp-JB; Thu, 12 Mar 2026 17:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nsz-0005ve-CU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:48:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nsv-0002ys-1R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:48:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3599126be32so896483a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773352073; cv=none;
 d=google.com; s=arc-20240605;
 b=kCagsd+f+46s4SmjlMtNb6IdJFDwFEhYdE+daTOApONQhVrI8V20E1z/a/LD2I7Rcn
 +1GXyj8WqWF164JiuKE8c3c4+dWKdF5p6pGMKqdGm4DqQMSU3FVDT8dyhzlCjibSysUd
 oTWTimjSz4i8n8/E8AQPrR9TT2trq3S3v1biMakVExmgjP2+11jhOauJpyw1mmTjpSUJ
 fD+94t5cWxj70vyTgxgI8elTMwz2hxzBcWA24U3UZIWXlFWnkKABgktmZrp6MoSOnA74
 PAq3quhS7tUcU4PNWkVT7Hdb/H1g6hXghMZb2o7duxC9+9v0rT9pxAxTAatOOYVnpkV1
 8HWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5rt8Znb4GpiMC5o3uSZNpvPNP4PXdIMHTLtEVuLxQ9A=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=dcCAE5UQ8RGBIq58d7H1PVL6ulBMUGXrrVgZ4yofNLbN3mQwI6PRdCWkR9LOAb4WxZ
 +ZVK7773wMcciTSK3hvxORpMdtO18TGua3M8HalfGDhk87Tz7dgICP0UEM2HkHqGRKjT
 bvwHl6RCh6vZacXoOaBt3L7EBQHqn62Vx1CcZn7K48KqCaqilWg5alyO4WJzEZFjfV9T
 OqDwTzhibYF/XLh/VMdFTAP0ngSx4LNKNYgp+5XvChl4rgfMakHzVMtGhMXCbMq9tK1H
 Z2VGjrBQT8p1k3MJvXx/vxtA771eMd4AWxoJklUgep2/NG8FfJ/T+vQ9lKMRe2RdpqYQ
 /Uvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773352073; x=1773956873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rt8Znb4GpiMC5o3uSZNpvPNP4PXdIMHTLtEVuLxQ9A=;
 b=T6I8JiD72TXgi8fXYbx1L08ysebW2TG6S4Mun7cGqmx4kPS/6cu82mM9dCLKeA+tLJ
 tEWxBSEDUBBmWjZiNbAboE2Z+XEN15yHLRgKhuBytHrMGvDJEbgj+8SfO2qy8+WZRbvo
 IOkPax3t7x+bNoIIgFJtZEFNKYtOlQelZ/3AGItrbJnO5nhoMfEoK+nFGaYRT7/WR8D8
 zwBTK8XIYlmRnm6X9pKeKXFx1fvvs7+tsaFPx9CKS6DQeuTcuPdx+JuX/E8tmKQbVNMg
 nrpNuLTolTnJ3RykoBTAxpKxuGYNMTsnNfwweaJEs51N4DjKQr+fHNh7kcuOUauwDxCm
 IJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773352073; x=1773956873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rt8Znb4GpiMC5o3uSZNpvPNP4PXdIMHTLtEVuLxQ9A=;
 b=FsgcI0NFpjjieLmUkS2EyH5U4dLywq2osEInqKOGl4rDvrgzwOzj1o/VZvBh2H3+p3
 tZVeg0Ad7Ck79tMNtDtIO2tOec8VE9uvYcassGnqmjlt0w/C+gXfqyYBMSaqQwouGQxS
 TsSoPDIBLm+9SS9seSWZmiwTmMUiwKDk6BaQKnBIy+FyE8LScXW3jzJ1qs7cWAMY4j+3
 I5+k19ckaCTUAFK7UubnWX2lj2Am7vfB8ozGuxjy3oop6vkFSBPumbS9O9yTJ6sPJ1sq
 ohSJOAU0C8Bn9Rm9CbkLful/eX+0590I11C3Q6Fp0IZM+RdGibOgfCnfDGoSlU6POLth
 AiWw==
X-Gm-Message-State: AOJu0YyUKSOldsgYl7sWzGFYP6MovGRaQtnO3nobB64tbo+eRuXo4KG/
 +qdrvWTDsbHGC6JN5ra2Liwu89ViG+q5J0j+rBEFO1DiuBxvyqzfKpVBiWkNrEz8s2aL3/FYz2y
 gAdkL131LfJ7F8FOofjenIsuepOF+cRfzyk7/
X-Gm-Gg: ATEYQzydeFaOHRTnhzBsvc7d3fjl/tR7VxC7Y2lhzGNK6Iuh294koN/BkMpRBrGlZRx
 7jOoftiHWMgDtat+wR+q/uTUAs2a5k3ZH2IMMmqNaM1UiLRb2hspQmS9BGxOViXLNvLwC/r+g2v
 G+vqPNkGG00ko2LFZiYu/a/3buG+6LsUMmW78SaUtbdpIBMHbOR5V47x1P9xWdTIHHAOYSPb8wX
 2l8UhHDMBVSlHCF71DKsrZAhmBwcMEJWsfdEVwKMKdrFp3+dSS9Z3HapjXfo5x2rREhkC2CmHZQ
 NkLaNhKqULawJwh54N7cnxeWNrI+zh7ADHDEiqGhFxGTzj5I
X-Received: by 2002:a17:90b:1807:b0:356:2872:9c53 with SMTP id
 98e67ed59e1d1-35a21eb7a43mr961547a91.14.1773352073437; Thu, 12 Mar 2026
 14:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-7-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:47:42 -0600
X-Gm-Features: AaiRm52V70y2darlulh6YmPN-eSVADKtVC4s8ocmFJdHPyfkF6063iqUeqhf43s
Message-ID: <CAATN3NrJkxqOt5WbwXu3u83GobPg6Rai=jjmB_HcVtdUgPShqQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/32] target/hexagon: Implement wait helper
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000662711064cdab4e0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1032.google.com
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

--000000000000662711064cdab4e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 51 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 161c7eaf31f..6dfc1269809 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1484,9 +1484,56 @@ void HELPER(stop)(CPUHexagonState *env)
>      hexagon_stop_thread(env);
>  }
>
> -void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
> +static void set_wait_mode(CPUHexagonState *env)
>  {
> -    g_assert_not_reached();
> +    g_assert(bql_locked());
> +
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    const uint32_t modectl =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
> +                               env->threadId) : 0;
> +    uint32_t thread_wait_mask =3D GET_FIELD(MODECTL_W, modectl);
> +    thread_wait_mask |=3D 0x1 << env->threadId;
> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask)=
;
>

Do you want to set modectl when cpu->globalregs is false?


> +}
> +
> +static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
> +{
> +    g_assert(bql_locked());
> +
> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
> +        (env->k0_lock_state !=3D HEX_LOCK_UNLOCKED ||
> +         env->tlb_lock_state !=3D HEX_LOCK_UNLOCKED)) {
> +        qemu_log("WARNING: executing wait() with acquired lock"
> +                 "may lead to deadlock\n");
> +    }
> +    g_assert(get_exe_mode(env) !=3D HEX_EXE_MODE_WAIT);
> +
> +    CPUState *cs =3D env_cpu(env);
> +    /*
> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
> +     * and is critical for our stability
> +     */
> +    if ((cs->exception_index !=3D HEX_EVENT_NONE) ||
> +        (cpu_has_work(cs))) {
> +        qemu_log_mask(CPU_LOG_INT,
> +            "%s: thread %d skipping WAIT mode, have some work\n",
>

Don't use %d


> +            __func__, env->threadId);
> +        return;
> +    }
> +    set_wait_mode(env);
> +    env->wait_next_pc =3D PC + 4;
> +
> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +}
> +
> +void HELPER(wait)(CPUHexagonState *env, uint32_t PC)

+{
> +    BQL_LOCK_GUARD();
> +
> +    if (!fIN_DEBUG_MODE(env->threadId)) {
> +        hexagon_wait_thread(env, PC);
> +    }
>  }
>
>  void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
> --
> 2.34.1
>

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000662711064cdab4e0
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
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/op_helper.c | 51 ++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 49 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index 161c7eaf31f..6dfc1269809 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -1484,9 +1484,56 @@ void HELPER(stop)(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0hexagon_stop_thread(env);<br>
=C2=A0}<br>
<br>
-void HELPER(wait)(CPUHexagonState *env, target_ulong PC)<br>
+static void set_wait_mode(CPUHexagonState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 const uint32_t modectl =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_MODECTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 uint32_t thread_wait_mask =3D GET_FIELD(MODECTL_W, modectl);=
<br>
+=C2=A0 =C2=A0 thread_wait_mask |=3D 0x1 &lt;&lt; env-&gt;threadId;<br>
+=C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wa=
it_mask);<br></blockquote><div><br></div><div>Do you want to set modectl=C2=
=A0when cpu-&gt;globalregs=C2=A0is false?</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 if (qemu_loglevel_mask(LOG_GUEST_ERROR) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;k0_lock_state !=3D HEX_LOCK_UNLOCKED =
||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_state !=3D HEX_LOCK_UNL=
OCKED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;WARNING: executing wait() with =
acquired lock&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;may le=
ad to deadlock\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_assert(get_exe_mode(env) !=3D HEX_EXE_MODE_WAIT);<br>
+<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The addtion of cpu_has_work is borrowed from arm&#39=
;s wfi helper<br>
+=C2=A0 =C2=A0 =C2=A0* and is critical for our stability<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if ((cs-&gt;exception_index !=3D HEX_EVENT_NONE) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (cpu_has_work(cs))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: thread %d skipping WAI=
T mode, have some work\n&quot;,<br></blockquote><div><br></div><div>Don&#39=
;t use %d</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, env-&gt;threadId);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 set_wait_mode(env);<br>
+=C2=A0 =C2=A0 env-&gt;wait_next_pc =3D PC + 4;<br>
+<br>
+=C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
+}<br>
+<br>
+void HELPER(wait)(CPUHexagonState *env, uint32_t PC)</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+<br>
+=C2=A0 =C2=A0 if (!fIN_DEBUG_MODE(env-&gt;threadId)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_wait_thread(env, PC);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void HELPER(resume)(CPUHexagonState *env, uint32_t mask)<br>
-- <br>
2.34.1<br></blockquote><div><br></div><div>Otherwise</div><div>Reviewed-by:=
 Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimp=
son@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000662711064cdab4e0--

