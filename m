Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05AAC79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 00:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4T45-0007BO-OP; Wed, 09 Sep 2026 20:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4T43-0007At-K7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:54:55 -0400
Received: from mail-lr2-x02.google.com ([2a00:1450:4864:38::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4T3z-0005tr-MR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:54:55 -0400
Received: by mail-lr2-x02.google.com with SMTP id
 38308e7fff4ca-3a4f7261b56so6290751fa.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 17:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789001689; cv=none;
 d=google.com; s=arc-20260327;
 b=nz3WLCoX4yEoFnNkTHePGzc8R2pcTWtXGbU7K03o6vPEV2jmgXDhnkex1X1Wetl1Gc
 0MCUxwNvCcdtGoxo0nkQ/Ya0YZoO2ubiYxPeYR/pcp96vk9iaBLonaDSAx1IJwzzONa1
 b5mFjWcWog1x23XzdJTBGL11+E8LHsXmZKPNoaWBJdb96UBlEmjpSWobdiIWGvd+srd3
 5rZKaGNBvuJYaYCG0MD4lJMWbmmO9I7eH0kfTTlfP6XIbTBciHretusguvB/I0wjgWhQ
 Ee9jy3hgV5/DkqjZPv13nzRSDn1ulqkpqcx3L1Mpvyu4tOuyz1WDROEs1pQHUFBAOGeZ
 mx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UZR3kTQP/ZuSqEKmlQyM/dZDQ34Jcu5Z0hqt/BqZEwA=;
 fh=pFsgHbrA9XZUxjTl2xiot6f6z6CIHHgMCC6pVt5iyIo=;
 b=kPEMlkna/JqBYRLfnjrE2x4dU02Q8xNseDZf7eS1cIIW0VTCnxLfN7iOrHLoPNJF2M
 vrT7CT97by9vzvQ+p69pXrqTjsQ8p/jZQoTe0ZVPtAtBX7Qd3Y7ghWZSqR+Ju/F+DEdQ
 WvStkj6t2En/56OTMS+S9snWQjGGKnXanA+sK8C7t46GAUGWRMmLvVB86Ps4EgNRurGB
 8kxpDWLx/7YJ1MJ3xiTxrFAt7WXAEzkVuPQoAZDiWNgGLXRqhL5A02ra5qPiYsPaRWQc
 G7qXUqn5830HukdIp92dsODohVaK8rNAvP0laKn0HIt1B9D7HM87RW4P6lfohLol1cUu
 x6ZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789001689; x=1789606489; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UZR3kTQP/ZuSqEKmlQyM/dZDQ34Jcu5Z0hqt/BqZEwA=;
 b=odm1Wij4SaT/mIvY/VVXgYKRe7exghXBVC1ZtMAg+UtFEOBwI0teBISkh43oAZqDei
 kNOSspHvnFTMJn0+iqBcDwAmIOVYCC+4EYl9KO7sDr8liGZb1vJAWE7V2k44Tk6cjoUJ
 EP7Gka+iKlXv+Z0IHyShJARSWtPgTsPa2W9mq0eoyT8zLkmQwEKgBXm8EKcFviimGoh0
 rNhD4up8LKu9Yq+2bh44TWjV1+cvrmShNq37v4iqgdeXhtasbqhgUe8DqkdqHajTkCop
 RPwz3yQnijvFja/7+JdhIxUfadg//drrOqI11VwP3PKUXUK7J6ahi3s6RXsEz1ak5mcG
 JQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789001689; x=1789606489;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UZR3kTQP/ZuSqEKmlQyM/dZDQ34Jcu5Z0hqt/BqZEwA=;
 b=UcYT6VE53TCQdyIK+XQKIbYHqJeGS4eFu9VQU3TJqV6Uh7tNBCUxcoUpkSLysNTWiS
 RgE5WzqbNnr7XN43RGVa4LUdlX/gAPjKtCmaYpSWipmkAxZJp8YnAtjpf7pmD87g/J7P
 l3SRzjLVZ0+Or4ZZhiIxPHICR+Bg59avD1yZ9dYJLHj6m/jRtobO0sOQWBxu+z3qk85W
 w88SmxWA+qT2wvTH1rEgwMOZ+Xk4GKlft8zP2sRU+av4GHIFjNEATC4UuADd9+aGhMRx
 WNT9hHze9S7ON2NWjYXp/qegMxDYBkIZiKqKTngo2GzRR6RS+wLloMEzanHu9YZRyqt8
 wa7A==
X-Gm-Message-State: AFuF++miYsMdkGM/sFLvCpWzWRKpVI46NnoLRU/VNA+QTBsSf7l+t61P
 p7sdVC9zqYWGJQuRu8maxwekQ60SWkN4buxZL0suG4bKJRcnmOYCGG/gN6EVVL5VcxH7qijEwkw
 JJUgQH1ecExzmKb+5xLKVi7brxUX1las=
X-Gm-Gg: AYBFou2fRvg4+RB5qkhyT2wdJtqw1AGAgKe4Y1pYmqI/5Lu3r0uDCe65jmbh+iXz3Fo
 iiMxWY4VhhnXCz1F9TPmmBSb0aLSfEL25RjRR7t7C3lJExz9YVdPyn4R1iqPcahPuPJ0K8Qx1YR
 eUicmm/NzGn4ungGDg6AxqmtV9agqHX+vEiRqkv21HaMue77qGjm5Q4S6UHHsuJd2eKB4r39e9X
 mTSX6Mf/5R+pmkDkoH1XWyZi39z2ImmB5PuF0HiJ501oTKBcXWKhk/PEP6wcia3fHLvIo9a/Eiy
 WszGJwElEgMHMvP2r6EA66fOeR4uVTf/Hi0pRpP7dzmWr8muu7LvbD0oFTyRDdJYuO4+b9jVpDA
 Sm5sb6BfNeSwhDg==
X-Received: by 2002:a05:6512:6881:10b0:5b6:1a7c:aa22 with SMTP id
 2adb3069b0e04-5b61a7cacf7mr3644004e87.58.1789001688242; Wed, 09 Sep 2026
 17:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260908022744.20333-1-fritchleybohrer@gmail.com>
 <71246cae-21b4-4725-aa83-e1afcf338bbd@oss.qualcomm.com>
In-Reply-To: <71246cae-21b4-4725-aa83-e1afcf338bbd@oss.qualcomm.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Thu, 10 Sep 2026 08:54:33 +0800
X-Gm-Features: AcwNN1UYQ4TpFsrhO-NMz-EqoxSOKN99BY1w4pDMseGpSwe4CTDdEES5D0JAnqU
Message-ID: <CAN4PorWjFn6ZZ93CEsNPhciqtJCod=cLE4XQpCANoJOxG=nxpA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: stop translating after WFI
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: multipart/alternative; boundary="0000000000002160d9065b166a01"
Received-SPF: pass client-ip=2a00:1450:4864:38::2;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002160d9065b166a01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, thanks!

On Thu, Sep 10, 2026 at 4:00=E2=80=AFAM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

>
>
> On 9/7/2026 11:27 PM, Zephyr Li wrote:
> > helper_wfi() never returns to translated code: it either raises an
> > exception or exits the CPU loop after marking the CPU as halted. Howeve=
r,
> > trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
> > following WFI can be included in the same TB.
> >
> > With icount enabled, this makes the following instruction part of the
> TB's
> > instruction count when WFI exits, causing minstret to be incremented on=
ce
> > too many. Set DISAS_NORETURN after emitting the helper.
> >
> > Add a TCG test for both reported cases: WFI waking for a locally enable=
d
> > pending interrupt with mstatus.MIE clear, and WFI taking a timer
> interrupt.
> >
> > Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
> > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > ---
>
> Code LGTM.  We just need to use the meson stuff for the new
> test-minstret-wfi.S
> test.  Otherwise 'check-tcg' won't execute it.
>
>
> Thanks,
> Daniel
>
> >   .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
> >   tests/tcg/riscv64/Makefile.softmmu-target     |   4 +
> >   tests/tcg/riscv64/test-minstret-wfi.S         | 100 +++++++++++++++++=
+
> >   3 files changed, 105 insertions(+)
> >   create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S
> >
> > diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> > index a8eaccef67..ebbbb01179 100644
> > --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> > +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> > @@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a=
)
> >       decode_save_opc(ctx, 0);
> >       gen_update_pc(ctx, ctx->cur_insn_len);
> >       gen_helper_wfi(tcg_env);
> > +    ctx->base.is_jmp =3D DISAS_NORETURN;
> >       return true;
> >   #else
> >       return false;
> > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> b/tests/tcg/riscv64/Makefile.softmmu-target
> > index 6a219c306c..96a3ab32c9 100644
> > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > @@ -28,6 +28,10 @@ EXTRA_RUNS +=3D run-test-minstret-ecall
> >   run-test-minstret-ecall: test-minstret-ecall
> >       $(call run-test, $<, $(QEMU) -icount shift=3D1 $(QEMU_OPTS)$<)
> >
> > +EXTRA_RUNS +=3D run-test-minstret-wfi
> > +run-test-minstret-wfi: test-minstret-wfi
> > +     $(call run-test, $<, $(QEMU) -icount shift=3D1 $(QEMU_OPTS)$<)
> > +
> >   EXTRA_RUNS +=3D run-plugin-doubletrap
> >   run-plugin-doubletrap: doubletrap
> >       $(call run-test, $<, \
> > diff --git a/tests/tcg/riscv64/test-minstret-wfi.S
> b/tests/tcg/riscv64/test-minstret-wfi.S
> > new file mode 100644
> > index 0000000000..0fd0158d5b
> > --- /dev/null
> > +++ b/tests/tcg/riscv64/test-minstret-wfi.S
> > @@ -0,0 +1,100 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +     .option norvc
> > +
> > +     .text
> > +     .global _start
> > +_start:
> > +     lla     t0, trap
> > +     csrw    mtvec, t0
> > +     li      s3, 0
> > +
> > +     /*
> > +      * A pending, locally enabled interrupt wakes WFI even with MIE
> > +      * clear.
> > +      */
> > +     li      t0, 0x8         /* MIE_MSIE */
> > +     csrw    mie, t0
> > +     csrci   mstatus, 0x8    /* MSTATUS_MIE */
> > +     li      t0, 0x2000000   /* MSIP0 */
> > +     li      t1, 1
> > +     sw      t1, 0(t0)
> > +
> > +     /*
> > +      * The first CSR read and WFI retire before the second read
> obtains s1,
> > +      * so the expected difference is two.
> > +      */
> > +     csrr    s0, minstret
> > +     wfi
> > +     csrr    s1, minstret
> > +     sub     s1, s1, s0
> > +     li      t1, 2
> > +     beq     s1, t1, 1f
> > +     ori     s3, s3, 1
> > +1:
> > +
> > +     /* Clear the software interrupt before testing the trap path. */
> > +     sw      zero, 0(t0)
> > +     csrw    mie, zero
> > +
> > +     /* Schedule a timer interrupt far enough ahead to reach WFI first=
.
> */
> > +     li      t0, 0x200bff8   /* MTIME */
> > +     ld      t1, 0(t0)
> > +     addi    t1, t1, 100
> > +     li      t0, 0x2004000   /* MTIMECMP0 */
> > +     sd      t1, 0(t0)
> > +     li      t0, 0x80                /* MIE_MTIE */
> > +     csrw    mie, t0
> > +     csrsi   mstatus, 0x8    /* MSTATUS_MIE */
> > +
> > +     /*
> > +      * The first CSR read and WFI retire before the trap handler
> obtains s1,
> > +      * so the expected difference is again two.
> > +      */
> > +     li      s2, 1
> > +     csrr    s0, minstret
> > +     wfi
> > +     beqz    s2, 1f
> > +     ori     s3, s3, 2
> > +1:
> > +     bnez    s3, fail
> > +     li      a0, 0
> > +     j       _exit
> > +
> > +fail:
> > +     mv      a0, s3
> > +
> > +_exit:
> > +     lla     a1, semiargs
> > +     li      t0, 0x20026     /* ADP_Stopped_ApplicationExit */
> > +     sd      t0, 0(a1)
> > +     sd      a0, 8(a1)
> > +     li      a0, 0x20        /* TARGET_SYS_EXIT_EXTENDED */
> > +
> > +     /* Semihosting call sequence */
> > +     .balign 16
> > +     slli    zero, zero, 0x1f
> > +     ebreak
> > +     srai    zero, zero, 0x7
> > +     j       .
> > +
> > +     .balign 4
> > +trap:
> > +     /* Read minstret before retiring an instruction in the handler. *=
/
> > +     csrr    s1, minstret
> > +     sub     s1, s1, s0
> > +     addi    s1, s1, -2
> > +     snez    s2, s1
> > +
> > +     /* Disable the timer interrupt before returning past WFI. */
> > +     li      t0, 0x2004000   /* MTIMECMP0 */
> > +     li      t1, -1
> > +     sd      t1, 0(t0)
> > +     li      t0, 0x80                /* MIE_MTIE */
> > +     csrc    mie, t0
> > +     mret
> > +
> > +     .data
> > +     .balign 16
> > +semiargs:
> > +     .space  16
>
>

--0000000000002160d9065b166a01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Got it, thanks!=C2=A0</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10,=
 2026 at 4:00=E2=80=AFAM Daniel Henrique Barboza &lt;<a href=3D"mailto:dani=
el.barboza@oss.qualcomm.com">daniel.barboza@oss.qualcomm.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 9/7/2026 11:27 PM, Zephyr Li wrote:<br>
&gt; helper_wfi() never returns to translated code: it either raises an<br>
&gt; exception or exits the CPU loop after marking the CPU as halted. Howev=
er,<br>
&gt; trans_wfi() leaves the translation state as DISAS_NEXT, so instruction=
s<br>
&gt; following WFI can be included in the same TB.<br>
&gt; <br>
&gt; With icount enabled, this makes the following instruction part of the =
TB&#39;s<br>
&gt; instruction count when WFI exits, causing minstret to be incremented o=
nce<br>
&gt; too many. Set DISAS_NORETURN after emitting the helper.<br>
&gt; <br>
&gt; Add a TCG test for both reported cases: WFI waking for a locally enabl=
ed<br>
&gt; pending interrupt with mstatus.MIE clear, and WFI taking a timer inter=
rupt.<br>
&gt; <br>
&gt; Fixes: 55c2a12cbcd3 (&quot;RISC-V TCG Code Generation&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/4230" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/work_items/4230</a><br>
&gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gmail.c=
om" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
Code LGTM.=C2=A0 We just need to use the meson stuff for the new test-minst=
ret-wfi.S<br>
test.=C2=A0 Otherwise &#39;check-tcg&#39; won&#39;t execute it.<br>
<br>
<br>
Thanks,<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0.../tcg/insn_trans/trans_privileged.c.inc=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0tests/tcg/riscv64/Makefile.softmmu-target=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0tests/tcg/riscv64/test-minstret-wfi.S=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 100 ++++++++++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 105 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S<b=
r>
&gt; <br>
&gt; diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/targ=
et/riscv/tcg/insn_trans/trans_privileged.c.inc<br>
&gt; index a8eaccef67..ebbbb01179 100644<br>
&gt; --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc<br>
&gt; +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc<br>
&gt; @@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *=
a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_save_opc(ctx, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gen_update_pc(ctx, ctx-&gt;cur_insn_len);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_wfi(tcg_env);<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;base.is_jmp =3D DISAS_NORETURN;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/ris=
cv64/Makefile.softmmu-target<br>
&gt; index 6a219c306c..96a3ab32c9 100644<br>
&gt; --- a/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; +++ b/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; @@ -28,6 +28,10 @@ EXTRA_RUNS +=3D run-test-minstret-ecall<br>
&gt;=C2=A0 =C2=A0run-test-minstret-ecall: test-minstret-ecall<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $&lt;, $(QEMU) -icount shif=
t=3D1 $(QEMU_OPTS)$&lt;)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +EXTRA_RUNS +=3D run-test-minstret-wfi<br>
&gt; +run-test-minstret-wfi: test-minstret-wfi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(call run-test, $&lt;, $(QEMU) -icount shift=3D1=
 $(QEMU_OPTS)$&lt;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0EXTRA_RUNS +=3D run-plugin-doubletrap<br>
&gt;=C2=A0 =C2=A0run-plugin-doubletrap: doubletrap<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $&lt;, \<br>
&gt; diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64=
/test-minstret-wfi.S<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..0fd0158d5b<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/tcg/riscv64/test-minstret-wfi.S<br>
&gt; @@ -0,0 +1,100 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.option norvc<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.global _start<br>
&gt; +_start:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lla=C2=A0 =C2=A0 =C2=A0t0, trap<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrw=C2=A0 =C2=A0 mtvec, t0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 s3, 0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * A pending, locally enabled interrupt wakes WFI=
 even with MIE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * clear.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x8=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* MIE_MSIE */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrw=C2=A0 =C2=A0 mie, t0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrci=C2=A0 =C2=A0mstatus, 0x8=C2=A0 =C2=A0 /* MS=
TATUS_MIE */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x2000000=C2=A0 =C2=A0=
/* MSIP0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t1, 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sw=C2=A0 =C2=A0 =C2=A0 t1, 0(t0)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The first CSR read and WFI retire before the s=
econd read obtains s1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * so the expected difference is two.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrr=C2=A0 =C2=A0 s0, minstret<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wfi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrr=C2=A0 =C2=A0 s1, minstret<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sub=C2=A0 =C2=A0 =C2=A0s1, s1, s0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t1, 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0beq=C2=A0 =C2=A0 =C2=A0s1, t1, 1f<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ori=C2=A0 =C2=A0 =C2=A0s3, s3, 1<br>
&gt; +1:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Clear the software interrupt before testing th=
e trap path. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sw=C2=A0 =C2=A0 =C2=A0 zero, 0(t0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrw=C2=A0 =C2=A0 mie, zero<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Schedule a timer interrupt far enough ahead to=
 reach WFI first. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x200bff8=C2=A0 =C2=A0=
/* MTIME */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ld=C2=A0 =C2=A0 =C2=A0 t1, 0(t0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addi=C2=A0 =C2=A0 t1, t1, 100<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x2004000=C2=A0 =C2=A0=
/* MTIMECMP0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 t1, 0(t0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x80=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MIE_MTIE */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrw=C2=A0 =C2=A0 mie, t0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrsi=C2=A0 =C2=A0mstatus, 0x8=C2=A0 =C2=A0 /* MS=
TATUS_MIE */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The first CSR read and WFI retire before the t=
rap handler obtains s1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * so the expected difference is again two.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 s2, 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrr=C2=A0 =C2=A0 s0, minstret<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wfi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0beqz=C2=A0 =C2=A0 s2, 1f<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ori=C2=A0 =C2=A0 =C2=A0s3, s3, 2<br>
&gt; +1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnez=C2=A0 =C2=A0 s3, fail<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0_exit<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mv=C2=A0 =C2=A0 =C2=A0 a0, s3<br>
&gt; +<br>
&gt; +_exit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lla=C2=A0 =C2=A0 =C2=A0a1, semiargs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x20026=C2=A0 =C2=A0 =
=C2=A0/* ADP_Stopped_ApplicationExit */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 t0, 0(a1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 a0, 8(a1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 0x20=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* TARGET_SYS_EXIT_EXTENDED */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Semihosting call sequence */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.balign 16<br>
&gt; +=C2=A0 =C2=A0 =C2=A0slli=C2=A0 =C2=A0 zero, zero, 0x1f<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebreak<br>
&gt; +=C2=A0 =C2=A0 =C2=A0srai=C2=A0 =C2=A0 zero, zero, 0x7<br>
&gt; +=C2=A0 =C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.balign 4<br>
&gt; +trap:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Read minstret before retiring an instruction i=
n the handler. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrr=C2=A0 =C2=A0 s1, minstret<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sub=C2=A0 =C2=A0 =C2=A0s1, s1, s0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addi=C2=A0 =C2=A0 s1, s1, -2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0snez=C2=A0 =C2=A0 s2, s1<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable the timer interrupt before returning p=
ast WFI. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x2004000=C2=A0 =C2=A0=
/* MTIMECMP0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t1, -1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 t1, 0(t0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x80=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MIE_MTIE */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csrc=C2=A0 =C2=A0 mie, t0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mret<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.data<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.balign 16<br>
&gt; +semiargs:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.space=C2=A0 16<br>
<br>
</blockquote></div>

--0000000000002160d9065b166a01--

