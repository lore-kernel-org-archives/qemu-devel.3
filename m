Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001E5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfX18-00020w-Kn; Fri, 03 Jul 2026 02:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danlam@g.hmc.edu>) id 1wfX17-00020g-1z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:04:49 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danlam@g.hmc.edu>) id 1wfX14-0007tJ-NF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:04:48 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so285206a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 23:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783058685; cv=none;
 d=google.com; s=arc-20260327;
 b=XRDoU7imw8f+sxrn/WuEmy30fQqDC0Thq7Iy0GoZzmgPvzmSOweZ5LwM0SAhkjrHQc
 GT21Ixl29sKZUMVNk5MdUvrQHqpONzeqNNH2Ybq7B8E7wfYFnyQqN5DqKvFebx5fR27B
 u2RhsuHCydTBm95HRyN2L010EUWpupS2vt441goUOb29MvmNHE//HwkY6t16w6u8svLa
 e0k/grSaqiXKv1AmF7iWzoPrSt1vd6e7FBGHvcfmCyRHkws3OS48TF2OqRgc9cwfE9mk
 DfL9VI6fP5riMbVg0Nr98Nzs4Zd1nelfntKAZ/MJld/baXx1f1StLw4vj4Y9sMPokJB0
 SxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=C08T+uadq+qbzoYfgmxzhcjS37RlU5vx+ESq897iTPU=;
 fh=uNWL65ATogYzbDseIKH9YqPXO90giPkSXO0Rl5cHpOs=;
 b=IWBoj2RDbIwqbPk5DrzzHBukJJvUjk8kuolJblYi8g15TnaKeRmv6qC/cKUxIyMiXM
 JAGkf7PG1r0kUAQc6wDBUDJkGkCF/qhjpzyP3x5613/+oJDRuHI8DLPaWG4K7cY7EJyD
 uq7dbLIwZYMY+ltzuEpuCrdA4X4KgguJjWwpd5uhz1AmlMX7KBN5avvHG71kJTSKwPbp
 Rku0XUYAzgBsoM6VxZ76A3j0rE7akV+TZabnQQZDfPeigEkqA7kyf0FZhtrE4bh8ZAwB
 BRXudwHN1fcLF4MyT9WBfhs5v7zT7MO5b9wKWv+EK7RiSbw6Od+NTSzofLshnINcpmne
 hVPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=g.hmc.edu; s=google; t=1783058685; x=1783663485; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C08T+uadq+qbzoYfgmxzhcjS37RlU5vx+ESq897iTPU=;
 b=1eJBJCYcSyJeA5Nd3CBF2hT8e3Zvyb49rLn+131bJYCjzVqjmzl1e4JqXQzHUFOQa0
 lT7EcTRDw1MpqqXfxUqbLNIXzOgj4OaJq2Jp4xoCnKLj/eAT7NPZp2TfFOYRDYXl3G/N
 axLICq+2GzT2wD/RXOUX6lSXcxk/88GdTr/XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783058685; x=1783663485;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C08T+uadq+qbzoYfgmxzhcjS37RlU5vx+ESq897iTPU=;
 b=pFPjOb4yhxDQRW+0EPwwkzjBRJ7OlMUzqU4FRUMvsPBREdabkxhz85LfuQiAQtIX4g
 nxYMN7nRkUiBCjemdlev8nnJmIPR/xDlSj90mUOlkm6/n+CI8FMDBtqzVKgvlk1Oq8z7
 mrK7c6/DetIfD0EbV2tJSurIpGNIt8EdKo6Rs9jhfCfKkIzZLSEbF2dWiwOx5gTkzKQt
 QnnUYtEheBSYQ9jwIB1+4vUqC8XXYZDvmJw9cyPfOqNkHhCnLfIwJq0jaSq9YHjuNURu
 z8LTiZgsLuY1pIVPCpT+Ka4+pfxVZI/U3ckSsEkhUoQBilZ3oYeUBKw+0HsPgiqyEEop
 mx/g==
X-Gm-Message-State: AOJu0YzOs8L0kRb6YrTgDtAaKjziaKngQv0eOADer3jqtDY9v8Ui+C65
 ZUhjn87+YP30YUuJB5J6eI6H23NH7kygSO56tIEBCSx4gMuhozHlW+C+bqYNtRy53QsUkPTTCFW
 /Seaz9Jg3OutLLySNqaY0YWKsd4TBa2jpR28RLAbY8CFPtwVxJloNgNE=
X-Gm-Gg: AfdE7cnhcCxCUbgFpz5bEoNYjwxhplaxdm20Z64LhSgGHs6zQKy7k50zi0hWAik4T8K
 sFZsukYDTqa1g8wBYPbFKNdqrM7P2/1mOaWgWkNHwmAOOX2EjBZr4hJFdgHmsuf4i0UeAFATba8
 nWu9j2AM6dF4ZGtmSxG29ZTX+gnZgtdb3xcABqDNwE326ADH5vKzGNhNvcBtIIaGmEmvj+s6yPb
 0k9kHISFxUkoUOidk2//5ZdC571ljAI0PSxOAxOWzBCyOYAgbeEFNybUUlYohRilThviP3ZicSY
 H4/S9rxlKvro00A=
X-Received: by 2002:a05:6402:a294:20b0:698:bf45:cd45 with SMTP id
 4fb4d7f45d1cf-698bf45ce42mr950533a12.17.1783058684385; Thu, 02 Jul 2026
 23:04:44 -0700 (PDT)
MIME-Version: 1.0
From: Danielle Lam <danlam@g.hmc.edu>
Date: Fri, 3 Jul 2026 13:04:32 +0700
X-Gm-Features: AVVi8CdkziVE1w7O84ivvCdfRQLNBT_7ovo05dKc9LMwnoOhfxMLcnSat6rPLAM
Message-ID: <CABoArmZgZN+s6Mha7Y=8WPcWmwwj9f4Yq-tU3zwPJZGA1mq8eA@mail.gmail.com>
Subject: [PATCH] target/riscv: fix amocas with rd = x0 followed by beq
 involving x0 is not taken when it should be
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="0000000000007f2b180655aeb3fb"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=danlam@g.hmc.edu; helo=mail-ed1-x536.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,
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

--0000000000007f2b180655aeb3fb
Content-Type: text/plain; charset="UTF-8"

From 048ca4fcaa826f0ba025b5da5087534939dc74bd Mon Sep 17 00:00:00 2001
From: Danielle Lam <danlam@g.hmc.edu>
Date: Fri, 3 Jul 2026 03:34:29 +0100
Subject: [PATCH] target/riscv: fix amocas with rd = x0 followed by beq
 involving x0 is not taken when it should be

amocas.{w,d,q,b,h} implement compare and swap by reusing rd current value
as both comparator input and as the output that tcg_gen_atomic_cmpxchg_*
writes the old memory into. Before the fix, ret == cmpv and we name that
variable dest. When rd = x0, dest was ctx->zero. Then since ret == cmpv in
the first place, the atomic op overwrites ret with ctx->zero which is not
the same zero value. Any later instructions that refer back to ret for the
initial zero value which is now changed, resulting in 0xbaaaaaad00000000.

The fix is to use different variables for ret and cmpv and assign that to
atomic op to run.

**TESTING**
gen_cmpxchg
.d was tested and it passed. .w/.b/.h use the same logic so the fix was
similar.

gen_cmpxchg64
.d was not tested

trans_amocas_q
.q had its own custom test: test_amocasq.S

.section .text
.globl _start
_start:
    la      t0, scratch
    li      t1, 0x1111
    li      t2, 0x2222
    sd      t1, 0(t0)
    sd      t2, 8(t0)

    li      a0, 0x3333
    li      a1, 0x4444
    amocas.q x0, a0, (t0)

    addi    a2, x0, 0

spin:
    j       spin

.section .bss
.align 4
scratch:
    .space 16

Then searching the trace log:
grep -n "x12/a2" amocasq-test.trace.log

I found that all matches read zero.
10612696: x12/a2   0 x13/a3   0 x14/a4   0 x15/a5   0
...
10613892: x12/a2   0 x13/a3   0 x14/a4   0 x15/a5   0

Run against the unpatched code, a2 read back as 0x2222. This confirms the
test run as intended and the fix works.

Signed-off-by: Danielle Lam <danlam@g.hmc.edu>
---
 target/riscv/insn_trans/trans_rvzacas.c.inc | 13 ++++++++-----
 target/riscv/translate.c                    |  5 +++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc
b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 79bca1e957..867f5e5ade 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -72,13 +72,14 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic
*a, MemOp mop)
         return false;
     }

-    TCGv_i64 dest = get_gpr_pair(ctx, a->rd);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
+    TCGv_i64 cmpv = get_gpr_pair(ctx, a->rd);
+    TCGv_i64 dest = tcg_temp_new_i64();

     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_i64(dest, src1, cmpv, src2, ctx->mem_idx, mop);

     gen_set_gpr_pair(ctx, a->rd, dest);
     return true;
@@ -117,13 +118,15 @@ static bool trans_amocas_q(DisasContext *ctx,
arg_amocas_q *a)
     TCGv_i128 src2 = tcg_temp_new_i128();
     TCGv_i64 src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
-    TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
-    TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 cmpl = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv_i64 cmph = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 destl = tcg_temp_new_i64();
+    TCGv_i64 desth = tcg_temp_new_i64();
     MemOp memop = MO_ALIGN | MO_UO;

     memop |= ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
-    tcg_gen_concat_i64_i128(dest, destl, desth);
+    tcg_gen_concat_i64_i128(dest, cmpl, cmph);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
memop);

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9684dbe752..62a9af9b56 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1166,13 +1166,14 @@ static bool gen_amo(DisasContext *ctx, arg_atomic
*a,

 static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv cmpv = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv dest = dest_gpr(ctx, a->rd);

     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, cmpv, src2, ctx->mem_idx, mop);

     gen_set_gpr(ctx, a->rd, dest);
     return true;
-- 
2.47.3

--0000000000007f2b180655aeb3fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">From 048ca4fcaa826f0ba025b5da5087534939dc=
74bd Mon Sep 17 00:00:00 2001<br>From: Danielle Lam &lt;<a href=3D"mailto:d=
anlam@g.hmc.edu" target=3D"_blank">danlam@g.hmc.edu</a>&gt;<br>Date: Fri, 3=
 Jul 2026 03:34:29 +0100<br>Subject: [PATCH] target/riscv: fix amocas with =
rd =3D x0 followed by beq<br>=C2=A0involving x0 is not taken when it should=
 be<br><br>amocas.{w,d,q,b,h} implement compare and swap by reusing rd curr=
ent value as both comparator input and as the output that tcg_gen_atomic_cm=
pxchg_* writes the old memory into. Before the fix, ret =3D=3D cmpv and we =
name that variable dest. When rd =3D x0, dest was ctx-&gt;zero. Then since =
ret =3D=3D cmpv in the first place, the atomic op overwrites ret with ctx-&=
gt;zero which is not the same zero value. Any later instructions that refer=
 back to ret for the initial zero value which is now changed, resulting in =
0xbaaaaaad00000000.<br><br>The fix is to use different variables for ret an=
d cmpv and assign that to atomic op to run.<br><br>**TESTING**<br>gen_cmpxc=
hg<br>.d was tested and it passed. .w/.b/.h use the same logic so the fix w=
as similar.<br><br>gen_cmpxchg64<br>.d was not tested<br><br>trans_amocas_q=
<br>.q had its own custom test: test_amocasq.S<br><br>.section .text<br>.gl=
obl _start<br>_start:<br>=C2=A0 =C2=A0 la =C2=A0 =C2=A0 =C2=A0t0, scratch<b=
r>=C2=A0 =C2=A0 li =C2=A0 =C2=A0 =C2=A0t1, 0x1111<br>=C2=A0 =C2=A0 li =C2=
=A0 =C2=A0 =C2=A0t2, 0x2222<br>=C2=A0 =C2=A0 sd =C2=A0 =C2=A0 =C2=A0t1, 0(t=
0)<br>=C2=A0 =C2=A0 sd =C2=A0 =C2=A0 =C2=A0t2, 8(t0)<br><br>=C2=A0 =C2=A0 l=
i =C2=A0 =C2=A0 =C2=A0a0, 0x3333<br>=C2=A0 =C2=A0 li =C2=A0 =C2=A0 =C2=A0a1=
, 0x4444<br>=C2=A0 =C2=A0 amocas.q x0, a0, (t0)<br><br>=C2=A0 =C2=A0 addi =
=C2=A0 =C2=A0a2, x0, 0<br><br>spin:<br>=C2=A0 =C2=A0 j =C2=A0 =C2=A0 =C2=A0=
 spin<br><br>.section .bss<br>.align 4<br>scratch:<br>=C2=A0 =C2=A0 .space =
16<br><br>Then searching the trace log:<br>grep -n &quot;x12/a2&quot; amoca=
sq-test.trace.log<br><br>I found that all matches read zero.<br>10612696: x=
12/a2 =C2=A0 0 x13/a3 =C2=A0 0 x14/a4 =C2=A0 0 x15/a5 =C2=A0 0<br>...<br>10=
613892: x12/a2 =C2=A0 0 x13/a3 =C2=A0 0 x14/a4 =C2=A0 0 x15/a5 =C2=A0 0<br>=
<br>Run against the unpatched code, a2 read back as 0x2222. This confirms t=
he test run as intended and the fix works.<br><br>Signed-off-by: Danielle L=
am &lt;<a href=3D"mailto:danlam@g.hmc.edu" target=3D"_blank">danlam@g.hmc.e=
du</a>&gt;<br>---<br>=C2=A0target/riscv/insn_trans/trans_rvzacas.c.inc | 13=
 ++++++++-----<br>=C2=A0target/riscv/translate.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A05 +++--<br>=C2=A02 fil=
es changed, 11 insertions(+), 7 deletions(-)<br><br>diff --git a/target/ris=
cv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c=
.inc<br>index 79bca1e957..867f5e5ade 100644<br>--- a/target/riscv/insn_tran=
s/trans_rvzacas.c.inc<br>+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc<=
br>@@ -72,13 +72,14 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_ato=
mic *a, MemOp mop)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0TCGv_i64 dest =3D get_gpr=
_pair(ctx, a-&gt;rd);<br>=C2=A0 =C2=A0 =C2=A0TCGv src1 =3D get_address(ctx,=
 a-&gt;rs1, 0);<br>=C2=A0 =C2=A0 =C2=A0TCGv_i64 src2 =3D get_gpr_pair(ctx, =
a-&gt;rs2);<br>+ =C2=A0 =C2=A0TCGv_i64 cmpv =3D get_gpr_pair(ctx, a-&gt;rd)=
;<br>+ =C2=A0 =C2=A0TCGv_i64 dest =3D tcg_temp_new_i64();<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0mop |=3D ctx-&gt;mo_endianness;<br>=C2=A0 =C2=A0 =C2=A0dec=
ode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);<br>- =C2=A0 =C2=A0tcg_gen_at=
omic_cmpxchg_i64(dest, src1, dest, src2, ctx-&gt;mem_idx, mop);<br>+ =C2=A0=
 =C2=A0tcg_gen_atomic_cmpxchg_i64(dest, src1, cmpv, src2, ctx-&gt;mem_idx, =
mop);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0gen_set_gpr_pair(ctx, a-&gt;rd, dest=
);<br>=C2=A0 =C2=A0 =C2=A0return true;<br>@@ -117,13 +118,15 @@ static bool=
 trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)<br>=C2=A0 =C2=A0 =C2=A0=
TCGv_i128 src2 =3D tcg_temp_new_i128();<br>=C2=A0 =C2=A0 =C2=A0TCGv_i64 src=
2l =3D get_gpr(ctx, a-&gt;rs2, EXT_NONE);<br>=C2=A0 =C2=A0 =C2=A0TCGv_i64 s=
rc2h =3D get_gpr(ctx, a-&gt;rs2 =3D=3D 0 ? 0 : a-&gt;rs2 + 1, EXT_NONE);<br=
>- =C2=A0 =C2=A0TCGv_i64 destl =3D get_gpr(ctx, a-&gt;rd, EXT_NONE);<br>- =
=C2=A0 =C2=A0TCGv_i64 desth =3D get_gpr(ctx, a-&gt;rd =3D=3D 0 ? 0 : a-&gt;=
rd + 1, EXT_NONE);<br>+ =C2=A0 =C2=A0TCGv_i64 cmpl =3D get_gpr(ctx, a-&gt;r=
d, EXT_NONE);<br>+ =C2=A0 =C2=A0TCGv_i64 cmph =3D get_gpr(ctx, a-&gt;rd =3D=
=3D 0 ? 0 : a-&gt;rd + 1, EXT_NONE);<br>+ =C2=A0 =C2=A0TCGv_i64 destl =3D t=
cg_temp_new_i64();<br>+ =C2=A0 =C2=A0TCGv_i64 desth =3D tcg_temp_new_i64();=
<br>=C2=A0 =C2=A0 =C2=A0MemOp memop =3D MO_ALIGN | MO_UO;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0memop |=3D ctx-&gt;mo_endianness;<br>=C2=A0 =C2=A0 =C2=A0t=
cg_gen_concat_i64_i128(src2, src2l, src2h);<br>- =C2=A0 =C2=A0tcg_gen_conca=
t_i64_i128(dest, destl, desth);<br>+ =C2=A0 =C2=A0tcg_gen_concat_i64_i128(d=
est, cmpl, cmph);<br>=C2=A0 =C2=A0 =C2=A0decode_save_opc(ctx, RISCV_UW2_ALW=
AYS_STORE_AMO);<br>=C2=A0 =C2=A0 =C2=A0tcg_gen_atomic_cmpxchg_i128(dest, sr=
c1, dest, src2, ctx-&gt;mem_idx, memop);<br>=C2=A0<br>diff --git a/target/r=
iscv/translate.c b/target/riscv/translate.c<br>index 9684dbe752..62a9af9b56=
 100644<br>--- a/target/riscv/translate.c<br>+++ b/target/riscv/translate.c=
<br>@@ -1166,13 +1166,14 @@ static bool gen_amo(DisasContext *ctx, arg_atom=
ic *a,<br>=C2=A0<br>=C2=A0static bool gen_cmpxchg(DisasContext *ctx, arg_at=
omic *a, MemOp mop)<br>=C2=A0{<br>- =C2=A0 =C2=A0TCGv dest =3D get_gpr(ctx,=
 a-&gt;rd, EXT_NONE);<br>=C2=A0 =C2=A0 =C2=A0TCGv src1 =3D get_address(ctx,=
 a-&gt;rs1, 0);<br>=C2=A0 =C2=A0 =C2=A0TCGv src2 =3D get_gpr(ctx, a-&gt;rs2=
, EXT_NONE);<br>+ =C2=A0 =C2=A0TCGv cmpv =3D get_gpr(ctx, a-&gt;rd, EXT_NON=
E);<br>+ =C2=A0 =C2=A0TCGv dest =3D dest_gpr(ctx, a-&gt;rd);<br>=C2=A0<br>=
=C2=A0 =C2=A0 =C2=A0mop |=3D ctx-&gt;mo_endianness;<br>=C2=A0 =C2=A0 =C2=A0=
decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);<br>- =C2=A0 =C2=A0tcg_gen=
_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx-&gt;mem_idx, mop);<br>+ =C2=
=A0 =C2=A0tcg_gen_atomic_cmpxchg_tl(dest, src1, cmpv, src2, ctx-&gt;mem_idx=
, mop);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0gen_set_gpr(ctx, a-&gt;rd, dest);<=
br>=C2=A0 =C2=A0 =C2=A0return true;<br>-- <br>2.47.3<br><div><br></div></di=
v>
</div>

--0000000000007f2b180655aeb3fb--

