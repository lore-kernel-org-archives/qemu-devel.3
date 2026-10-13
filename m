Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7646CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGUpx-0000Hb-Il; Tue, 13 Oct 2026 01:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGUpo-0000Ey-R1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 01:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGUpm-0005xQ-WC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 01:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791868433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkwZOKEVoYFPbzRg2a3N45+abdV0p+u1Fj3X5wW/a04=;
 b=JbgCWrh0ROrDHml8++xK6Q6wvmyc3pTHvbQjdjFHVi9ONaN4NDQLbqQQsJZd7oR6LGtlQ6
 SSsl9td5LhmGE9MGX3k7Z77qB69lc3ZLfGiOZUdIvqnsYbhJaxydH3+78JqmxhPwe54QUL
 Zrn3XEWvSsRTikJvaI+3q1bzufMI57U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-EOZn1IyeMPij0bA6n0Zdhg-1; Tue, 13 Oct 2026 05:13:46 +0000
X-MC-Unique: EOZn1IyeMPij0bA6n0Zdhg-1
X-Mimecast-MFC-AGG-ID: EOZn1IyeMPij0bA6n0Zdhg_1791868425
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a17574b5easo19422655e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 22:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791868425; cv=none;
 d=google.com; s=arc-20260327;
 b=spmZ3Km6f9j7bYKb2J1IV5ZZFayCdrZW5lmJaOMH1tj2PUPvmaLQxgm2WrlytjTd2A
 RiKNT3OOPb67H61Yo/xyHqAvGbYemjoP5Ivpal3Gb7840uTOpUxnvR6TF6yGdH5u3hn7
 q+hJGAjk6ZEwG2ELk8ubV5MMo9dSHIXTJ7OqdufMSEM/JLspH7G6vhxUj4Cq87n6iqye
 sEK9b9tcw4f+fxyio/KheDWOKQfldD6hxY/PJJGBkzu0WM218hz4uzk/4iL2re2wta8g
 NnFzfY5wyWeQla8UO3fpr+ROwSP5mHpJwHObB/7vTcv+Lon9QXyI9jclWoizG272ff1w
 2tQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zkwZOKEVoYFPbzRg2a3N45+abdV0p+u1Fj3X5wW/a04=;
 fh=gzxBqhaBPgdqrB6eCSk7FgtTZmZ12Cv5n9hpXT6XUR4=;
 b=dKWgP7Yo/9lnksL5paXrqSusHKJSvL3MdbcOTmN/V2hZXFLcWVza19DyJMLMSYiNWK
 6t+2r5rds3d2+o1UDqAifPgz1k2lnwY0IRLRd1YjtIVI8i8Zg1IvUyoAVW8TZRZIMGUv
 KWjlJamRL9t6vPUUm+QIBEMxXcwJyGwjO3LVEc343T6jGgrj8cuwzZUcg5FHdroLmN34
 RRgMJYluJQVlrvPu9zRXvvBZCQ3XYQ0opE8gBU8NWbh68aPyls/vExoOY7v+edZJ11A4
 mjSKFkhDZ3IRCKbTyZ6DQvVqc4Bh82LYwePXJK6U8f3fW9AgM6ckum0n5r0PzIYQDeUa
 0IPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791868425; x=1792473225; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zkwZOKEVoYFPbzRg2a3N45+abdV0p+u1Fj3X5wW/a04=;
 b=JZi81Rk/EnRBMhpxIqy4FPammRA3FjM4+O4trVUF1nOKTORwdbfoGEz35JIf36eLsM
 UKTsmeVYMaddUQIqZo/vOZxq8zavFUed2oOMcnMnP6cEw5V9F1LkLmjYgFJCVcteTM2V
 KoxvQgJr9aKmPy3LSaADPd2Jxv2kx77do6wsqDHRmh1Jzpe1MTYFEOBtJRt36zJTvoM0
 8IhSOEtXrMb8kqIMePQv8zz2FQpL1cFIfJapLs37fyZVzh90whnCgSGSMogTd1ylqNNm
 Tr5zUqiW44ipDN/zQ+gqxY7SKKMnMtz4GV9RfsqBjDymPkAQbXsmNxZCiOp256NzIcIc
 xGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791868425; x=1792473225;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zkwZOKEVoYFPbzRg2a3N45+abdV0p+u1Fj3X5wW/a04=;
 b=bE0gA8NHYK0n6vEHLZqi3eoUeAE+Dbm6VvTwsDpN6NPRaWVyjo81lGnKEB78Dggpss
 Wt6ywwqP+TMuGa4IevUttUNYvKlK8FcWbAZpwQSoUsguNvDpco8y6nkmc+lyNu0NWFpY
 xBQp5L2TAwbw8uz8euiTk5y8myiqHBYa6ePskf6PeUZv+ZQEcl/r/C06Ax+JCaLR6DK7
 eMeHttwUQIfPT70C6rj86IymOeG32h96WJsenN5rnpVAgtFlse7E2H4/C/SWk1QOjovi
 9v9LpwNLlLLFOpZKh5VsAtpCcrtB4d7iibvAIBPGqVMt/Ev8qYfCrS431ENrBE32GqsG
 pEGQ==
X-Gm-Message-State: AFq9FYI/t+uAM0up7wRCAZLllRsk8B0y6hx4zpNWDHEZECbjSRIaMuUj
 hiApbrOT4mUU/6JLXUrZLQp4lmUpm8nnXXuQyJPmsVWysKJb/930vu99R2NLUqtTfscXaCkmE96
 gkzeEc0C+66J9qDqNKKpHeS6uLIaS4YctrRouA/tqyGbXcHtAoNcwKRQpcIziIX2J6afcsmvMjB
 wxfRP8VqPYq9jo2cvRbvF6MrnNZpiqCwY=
X-Gm-Gg: AYBFou0G1jXaR8pAV/Xn07B1S5NJjKHmeoJK9xAjbxQ9NlLt3HkQERRs/uQh9dyz1+i
 u34heiyJyPsvzn4cXGS/isaIJxu9NJRv/4RAqjaVeprTFbqYgR+yPBrPTUPp5wYFlkQobVpJxS4
 /cW5ZnmmglF7ZEYTttRVbwlmXagank8wH9DT+SgoV8nR4y0N3uXT/cZy2dLbgd5RRbV5SaLbJw6
 OfjNpW0CeJrZqpCw4SpM8ZTrqID2amhcEM0vIU8tgMKRYrsRFVERjtxUJgGow==
X-Received: by 2002:a05:600d:17:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4a196637a39mr134836435e9.34.1791868424755; 
 Mon, 12 Oct 2026 22:13:44 -0700 (PDT)
X-Received: by 2002:a05:600d:17:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4a196637a39mr134836235e9.34.1791868424423; Mon, 12 Oct 2026
 22:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261012134840.1051969-1-alex.bennee@linaro.org>
 <87fqybx97c.fsf@draig.linaro.org>
 <b5d07378-d5c4-4186-aae9-9252a08852fd@redhat.com>
 <87o6cyhi3b.fsf@draig.linaro.org>
In-Reply-To: <87o6cyhi3b.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Oct 2026 07:13:33 +0200
X-Gm-Features: AclHuK_t7Nft2uI56Um5F54ZTnOHDqa4kcfxRI2vWBcNgZ2DLxCxgIdnMOQCppM
Message-ID: <CABgObfY8KzvrDZdpVXEEuRm8iKP7Hi01b6+B=KbMvkNfbXih1Q@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ec2070065db1e0da"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ec2070065db1e0da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 12 ott 2026, 20:47 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>
> > I think wfxt_timer_cb only needs to call cpu_interrupt().
>
> Something like:
>

No, the cpu_interrupt must be unconditional due to the WFIT instruction.
Your patch puts it under qatomic_read(&env->halt_reason) =3D=3D HALT_WFE.

>
> +
> +        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
> +
>          if (cpu->wfxt_timer) {
>              timer_del(cpu->wfxt_timer);
>          }
> -        /* clear the halt reason */
> -        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
>

I was thinking about the ordering before timer_mod, in the
wfe/wfi/wfet/wfit helpers. However it is not relevant if the timer callback
does not check halt_reason.

Paolo

     }
>      return leave_halt;
>  }
>  #endif
>
>  /*
> - * Unlike almost everything else that messes with the halt_reason and
> - * event_register details the timer callbacks are not in the vCPU
> - * context.
> - *
> - * To prevent races we atomically consume a HALT_WFE and set the event
> - * register. Either way we trigger the an exit event.
> + * Unlike almost everything else that messes with the halt_reason the
> + * timer callbacks are not in the vCPU context so we must use atomics
> + * to check it.
>   */
>  static void arm_wfxt_timer_cb(void *opaque)
>  {
> @@ -903,17 +900,15 @@ static void arm_wfxt_timer_cb(void *opaque)
>      CPUState *cs =3D CPU(cpu);
>      CPUARMState *env =3D &cpu->env;
>
> -    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
> -        qatomic_set(&env->event_register, true);
> +    if (qatomic_read(&env->halt_reason) =3D=3D HALT_WFE) {
> +        /*
> +         * We expect the CPU to be halted; this will cause
> arm_cpu_is_work()
> +         * to return true (so we will come out of halt even with no othe=
r
> +         * pending interrupt), and the TCG accelerator's
> cpu_exec_interrupt()
> +         * function auto-clears the CPU_INTERRUPT_EXITTB flag for us.
> +         */
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
>      }
> -
> -    /*
> -     * We expect the CPU to be halted; this will cause arm_cpu_is_work()
> -     * to return true (so we will come out of halt even with no other
> -     * pending interrupt), and the TCG accelerator's cpu_exec_interrupt(=
)
> -     * function auto-clears the CPU_INTERRUPT_EXITTB flag for us.
> -     */
> -    cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
>  }
>  #endif
> --8<---------------cut here---------------end--------------->8---
>
> ?
>
> >
> > Thanks,
> >
> > Paolo
> >
> > (*) always, even if the halt reason is not HALT_WFE, if only for
> consistency
> >
> > (**) you don't need a lock or acquire/release here, because the timer
> > callback always sees everything that happened before timer_mod().  In
> > a sense, timer_mod() *is* the release operation and starting the
> > callback is the acquire operation.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000ec2070065db1e0da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 12 ott 2026, 20:47 Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br><br>
&gt; I think wfxt_timer_cb only needs to call cpu_interrupt().<br>
<br>
Something like:<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">No, the cpu_interrupt must be unconditional due to the WFIT =
instruction. Your patch puts it under qatomic_read(&amp;env-&gt;halt_reason=
) =3D=3D HALT_WFE.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;cpu-&gt;env.halt_reason, NOT_=
HALTED);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu-&gt;wfxt_timer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_del(cpu-&gt;wfxt_time=
r);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* clear the halt reason */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;cpu-&gt;env.halt_reason, NOT_=
HALTED);<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I was thinking about the ordering before timer_mod, in the wfe/wf=
i/wfet/wfit helpers. However it is not relevant if the timer callback does =
not check halt_reason.</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return leave_halt;<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0/*<br>
- * Unlike almost everything else that messes with the halt_reason and<br>
- * event_register details the timer callbacks are not in the vCPU<br>
- * context.<br>
- *<br>
- * To prevent races we atomically consume a HALT_WFE and set the event<br>
- * register. Either way we trigger the an exit event.<br>
+ * Unlike almost everything else that messes with the halt_reason the<br>
+ * timer callbacks are not in the vCPU context so we must use atomics<br>
+ * to check it.<br>
=C2=A0 */<br>
=C2=A0static void arm_wfxt_timer_cb(void *opaque)<br>
=C2=A0{<br>
@@ -903,17 +900,15 @@ static void arm_wfxt_timer_cb(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D CPU(cpu);<br>
=C2=A0 =C2=A0 =C2=A0CPUARMState *env =3D &amp;cpu-&gt;env;<br>
<br>
-=C2=A0 =C2=A0 if (qatomic_cmpxchg(&amp;env-&gt;halt_reason, HALT_WFE, NOT_=
HALTED)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;env-&gt;event_register, true)=
;<br>
+=C2=A0 =C2=A0 if (qatomic_read(&amp;env-&gt;halt_reason) =3D=3D HALT_WFE) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We expect the CPU to be halted; this w=
ill cause arm_cpu_is_work()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to return true (so we will come out of=
 halt even with no other<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* pending interrupt), and the TCG accele=
rator&#39;s cpu_exec_interrupt()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* function auto-clears the CPU_INTERRUPT=
_EXITTB flag for us.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* We expect the CPU to be halted; this will cause arm_=
cpu_is_work()<br>
-=C2=A0 =C2=A0 =C2=A0* to return true (so we will come out of halt even wit=
h no other<br>
-=C2=A0 =C2=A0 =C2=A0* pending interrupt), and the TCG accelerator&#39;s cp=
u_exec_interrupt()<br>
-=C2=A0 =C2=A0 =C2=A0* function auto-clears the CPU_INTERRUPT_EXITTB flag f=
or us.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);<br>
=C2=A0}<br>
=C2=A0#endif<br>
--8&lt;---------------cut here---------------end---------------&gt;8---<br>
<br>
?<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; (*) always, even if the halt reason is not HALT_WFE, if only for consi=
stency<br>
&gt;<br>
&gt; (**) you don&#39;t need a lock or acquire/release here, because the ti=
mer<br>
&gt; callback always sees everything that happened before timer_mod().=C2=
=A0 In<br>
&gt; a sense, timer_mod() *is* the release operation and starting the<br>
&gt; callback is the acquire operation.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--000000000000ec2070065db1e0da--


