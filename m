Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FBCFEA801
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Eu4-00060E-Bf; Tue, 24 Mar 2026 23:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Eu2-0005zK-0w
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:27:30 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Etz-0001AO-RR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:27:29 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9961e4f71bso148782966b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774409243; cv=none;
 d=google.com; s=arc-20240605;
 b=M0yH15XHp5TKNVG479JuUO0QZeoNFckJ/aH0yd1ClJPOu85UdJBnxqg6mr5WUKxVqb
 csCxj7/mjzu3ULJ0Fjz6boPNVvjsXhb8Zw8ROBz6bvvjICrntB1L1H4P/vU9F8Xr2cGp
 NJwRROHbd6dBSqVirrQ741cANaj8D5Sai7hsaBdd4qMNf5glnwlagU2qUKePU45/phVL
 NNY8BDgTwVr8Jsy8/KKmKFwnMVLRBDyEP9RZlpuGkXHAK6paJBEiTHiLpw0E5nOSP6t5
 G8V7wkl4xlWs0u1WH6oUda6Ea6bEObxAAcdM9Qy5nnHfQ2y9AZY9IDoWfLPcxjk2QZL1
 fTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cYibt3yxUWaDWkPSgzpjJ9kPHVISyjb9KbfdSTK6FFQ=;
 fh=6KBb8MLtqpUmmYrk1MsFq8sv/RnRZ+wAVQVPDA05dYc=;
 b=aj1tsDtjxka+4MQwlmkBP2Ggj9IPVyG/GjeOI1fZ2h04GT8KRPGH7RxR1vVIDpBYPA
 uiPT5bjXhyNPXxuw1SChi3VgqYOv3k9XLgFwjE59OrwyO11n66m857mAqUekrfPKrXTH
 to6fxw9csv9wf7Z57xOi4x0PbSv8brzczO2GfHjGiuqQFsS/3s8h9D7AJuGzzltc3QMZ
 R4Rf6rLQsR66s8uq68CiLKPEI4nmZHqYOLqW8PauiZXlBX4Wz3fMEbEKVAQDaSJR8Mnx
 JhZjS9qTd6PyigNiBlk0da/F3L7KAoHzcmh4ZF853Xv1xJ33LWZLzkkrWOOttjORHvj6
 cYmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774409243; x=1775014043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYibt3yxUWaDWkPSgzpjJ9kPHVISyjb9KbfdSTK6FFQ=;
 b=cZMCREUTVDpADY5OdliZyPDXwlGNf5D0nd2s1EPXx32YQsUvtcl/X+Vhn3KOqE87+1
 gO8wUwAus9o4IRQvXAtHIWCVqjYvws55BJNY4WHmDNNf7ssXAoUBpSplTQ1NnNWWDh7g
 IuST6tT/cYtPn3Rk3tLF2Y/QbGKX5Y9M19zhFnYeT3AolrMsWWAzfg78M/9aw3HLNMT1
 nxX8ieuHqlR1rfFvb7vFoSgDlGHqJxn9IUWFzKEXTr4/RW8O+8ZPmhzsFCU6LU2jgUOc
 qugdaB9PWH0dGnRGiu4ID4jVmXYDeS5mf9YM/cQ6KaUKiv/8aYC7R5Z8CJ14cd48E1q/
 sg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774409243; x=1775014043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cYibt3yxUWaDWkPSgzpjJ9kPHVISyjb9KbfdSTK6FFQ=;
 b=U+XxA/bswcoN8H3MuGaSL7STSgOCV/lwNE/Dy5hA03SJuqW0/G02WyrCAhAzcV9I84
 nkcM/MilKYIB5BY2EkytDrpZR64piYOskEkOGAvAzuS8KA2pK8chzne0YGK5JFeGyU92
 c4pkcWik1TVs/xVTsUf401bKoQxJ5H46wnquqRxJZ3mEyJRLSwJrrF4dc2vq3t9eKqEU
 /b/JqmTMumC1k8tcx19wM8gZxRvmy7/HvujNsG+2s1QdNYhIAEOvEHioxy/57iP6NBIk
 HjqoevWcBpMijdVKi1f44zggJgDHmb4S1z5zjPmulcxjwvVi9n36uglUwy9x5Ry3Zwm/
 sMqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhZBPq/u4lSdUEERbazysHeJ/xX/G6IG1mHn9JmjR2IDq0q+aNRN8hmQNNdHZ9BQn67JWJ6nSd9to/@nongnu.org
X-Gm-Message-State: AOJu0YzN3aHO8aCcGMW7XloAIPE6ihyPwGDtBTmxHt2KsP9R+T8NLs1a
 NgKLN4LNr2osVcKVxto5qyRtAQfSZeoDUeLdHc+YuAcZXbCV6mU748nmq+q6jTcprBg/CPP45m4
 /w/Iqk8ur7tYvUNgGcWqSehC3Bz/BRW8=
X-Gm-Gg: ATEYQzyVcDQbvzCmQmPBRLKxX7hCD++Tq0QqqaF4zcXiKGKZ2ez4hvNVf9G1yZCSemS
 Z98LKonh/370ZFOUWjsa5vQHofZZxEbT08DtEcWtewk9jag8FiabU31RQVk2jA6c4JjAIALRWfk
 Rs4XofZfm81InaufeWw6wG0g8cwlYp9sPHgkWoVVuaVlAbttDzzm9n5xa4v5vnG4Jx3MFBcGsGF
 zLtMR0lIcDknQEUNP78xXaAvFhmnyoULmaF0eoTfQRVwUE+6GoCzdDIrogjTTXjNWEp+uSHQWgi
 XeE+GvP4iOxjpSXT/l0kPzV28knPn3plgiOKIg==
X-Received: by 2002:a17:907:d303:b0:b97:7616:3362 with SMTP id
 a640c23a62f3a-b9a542719b8mr105819866b.44.1774409243097; Tue, 24 Mar 2026
 20:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-2-npiggin@gmail.com>
 <acNQ3kVLEr92Kfjw@ZEVORN-PC.localdomain>
In-Reply-To: <acNQ3kVLEr92Kfjw@ZEVORN-PC.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:26:56 +1000
X-Gm-Features: AQROBzBRrvdFr3gkteZDa5CB4d4iUXVRa8pYTWr_GZNS_jUvCpYvIdVok7597gg
Message-ID: <CAKmqyKPCzgZec1v79FfdRz3yA4zdY7C_k_qdPS8oMkSuo644HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix IALIGN check in misa write
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 25, 2026 at 1:09=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> On Sun, Mar 22, 2026 at 12:45:52AM +1000, Nicholas Piggin wrote:
> > The instruction alignment check for the C extension was inverted.
> > The new value should be checked for C bit clear (thus increasing
> > IALIGN). If IALIGN is incompatible, then the write to misa should
> > be suppressed, not just ignoring the update to the C bit.
> >
> > From the ISA:
> >
> >   Writing misa may increase IALIGN, e.g., by disabling the "C"
> >   extension. If an instruction that would write misa increases IALIGN,
> >   and the subsequent instruction=E2=80=99s address is not IALIGN-bit al=
igned,
> >   the write to misa is suppressed, leaving misa unchanged.
> >
> > This was found with a verification test generator based on RiESCUE.
> >
> > Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> > Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  target/riscv/csr.c                        | 16 ++++-
> >  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
> >  tests/tcg/riscv64/misa-ialign.S           | 88 +++++++++++++++++++++++
> >  3 files changed, 106 insertions(+), 3 deletions(-)
> >  create mode 100644 tests/tcg/riscv64/misa-ialign.S
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 5064483917..91421a2dd8 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -2129,9 +2129,19 @@ static RISCVException write_misa(CPURISCVState *=
env, int csrno,
> >      /* Mask extensions that are not supported by this hart */
> >      val &=3D env->misa_ext_mask;
> >
> > -    /* Suppress 'C' if next instruction is not aligned. */
> > -    if ((val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0) {
> > -        val &=3D ~RVC;
> > +    /*
> > +     * misa writes that increase IALIGN beyond alignment of the next
> > +     * instruction cause the write to misa to be suppressed. Clearing
> > +     * "C" extension increases IALIGN.
> > +     */
> > +    if (!(val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0) {
> > +        /*
> > +         * If the next instruction is unaligned mod 4 then "C" must be
> > +         * set or this instruction could not be executing, so we know
> > +         * this is is clearing "C" (and not just keeping it clear).
> "this is is clearing" =E2=80=94 double "is"
>
> > +         */
> > +        g_assert(env->misa_ext & RVC);
> > +        return RISCV_EXCP_NONE;
> write_misa() is also reachable via riscv_csrrw_debug()
> with ra=3D0, where get_next_pc() falls back to env->pc.

Ah good catch

> A debugger can set PC to a 2-byte-aligned address while C is
> already disabled, then write misa keeping C=3D0. This hits
> the condition and fires the g_assert.

I'm not convinced that that's necessarily bad, as that's an odd and
invalid thing to be writing. But we probably shouldn't assert

>
> The ISA spec language:
>
>     "if an instruction that would write misa..."
>
> does not cover debug writes, so the IALIGN suppression
> arguably should not apply in that case at all.
>
> We can:
>
>     if (ra && !(val & RVC)
>         && (get_next_pc(env, ra) & 3) !=3D 0) {
>         g_assert(env->misa_ext & RVC);
>         return RISCV_EXCP_NONE;
>     }

Maybe it's best to change the `g_assert()` to a log GUEST_ERROR
instead. That way we flag that something fishy is going on, but don't
exit QEMU

Alistair

>
> Thanks,
> Chao
> >      }
> >
> >      /* Disable RVG if any of its dependencies are disabled */
> > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/risc=
v64/Makefile.softmmu-target
> > index eb1ce6504a..f176f87ed0 100644
> > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > @@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
> >         $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
> >         $(QEMU_OPTS)$<)
> >
> > +EXTRA_RUNS +=3D run-misa-ialign
> > +run-misa-ialign: QEMU_OPTS :=3D -cpu rv64,c=3Dtrue,v=3Dtrue,x-misa-w=
=3Don $(QEMU_OPTS)
> > +run-misa-ialign: misa-ialign
> > +     $(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
> > +
> >  # We don't currently support the multiarch system tests
> >  undefine MULTIARCH_TESTS
> > diff --git a/tests/tcg/riscv64/misa-ialign.S b/tests/tcg/riscv64/misa-i=
align.S
> > new file mode 100644
> > index 0000000000..7f1eb30023
> > --- /dev/null
> > +++ b/tests/tcg/riscv64/misa-ialign.S
> > @@ -0,0 +1,88 @@
> > +/*
> > + * Test for MISA changing C and related IALIGN alignment cases
> > + *
> > + * This test verifies that the "C" extension can be cleared and set in=
 MISA,
> > + * that a branch to 2-byte aligned instructions can be executed when "=
C" is
> > + * enabled, and that a write to MISA which would increase IALIGN and c=
ause
> > + * the next instruction to be unaligned is ignored.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#define RVC (1 << ('C'-'A'))
> > +#define RVV (1 << ('V'-'A'))
> > +
> > +.option norvc
> > +     .text
> > +     .global _start
> > +_start:
> > +     lla     t0, trap
> > +     csrw    mtvec, t0
> > +
> > +     csrr    t0, misa
> > +     li      t1, RVC
> > +     not     t1, t1
> > +     and     t0, t0, t1
> > +     csrw    misa, t0
> > +     csrr    t1, misa
> > +     li      a0, 2 # fail code
> > +     bne     t0, t1, _exit # Could not clear RVC in MISA
> > +
> > +     li      t1, RVC
> > +     or      t0, t0, t1
> > +     csrw    misa, t0
> > +     csrr    t1, misa
> > +     li      a0, 3 # fail code
> > +     bne     t0, t1, _exit # Could not set RVC in MISA
> > +
> > +     j       unalign
> > +. =3D . + 2
> > +unalign:
> > +
> > +     li      t1, RVC
> > +     not     t1, t1
> > +     and     t0, t0, t1
> > +     csrw    misa, t0
> > +     csrr    t1, misa
> > +     li      a0, 4 # fail code
> > +     beq     t0, t1, _exit # Was able to clear RVC in MISA
> > +
> > +     li      t0, (RVC|RVV)
> > +     not     t0, t0
> > +     and     t0, t0, t1
> > +     csrw    misa, t0
> > +     csrr    t0, misa
> > +     li      a0, 5 # fail code
> > +     bne     t0, t1, _exit # MISA write was not ignored (RVV was clear=
ed)
> > +
> > +     j       realign
> > +. =3D . + 2
> > +realign:
> > +
> > +     # Success!
> > +     li      a0, 0
> > +     j       _exit
> > +
> > +trap:
> > +     # Any trap is a fail code 1
> > +     li      a0, 1
> > +
> > +# Exit code in a0
> > +_exit:
> > +     lla     a1, semiargs
> > +     li      t0, 0x20026     # ADP_Stopped_ApplicationExit
> > +     sd      t0, 0(a1)
> > +     sd      a0, 8(a1)
> > +     li      a0, 0x20        # TARGET_SYS_EXIT_EXTENDED
> > +
> > +     # Semihosting call sequence
> > +     .balign 16
> > +     slli    zero, zero, 0x1f
> > +     ebreak
> > +     srai    zero, zero, 0x7
> > +     j       .
> > +
> > +     .data
> > +     .balign 16
> > +semiargs:
> > +     .space  16
> > --
> > 2.51.0
> >
> >
>

