Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E84FEA803
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5F6s-0000pT-9Y; Tue, 24 Mar 2026 23:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5F6q-0000ou-Dl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:40:44 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5F6o-0003GF-AJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:40:44 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1273349c56bso6110619c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774410040; x=1775014840; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Z/RmJ+Vahf6x/nbS7JkbihVAKglnpCri09zlzZEL24=;
 b=V3wF5iH187zY2Qb6rDaPNUUWorYug6rX4gNn1kAbCoujZtHwCHS2qO1b8iZz9YGcwd
 j0GtpzSDV01E7RL5Fj0RPBk30vphmQf459iKfVk/Coma7csQH84UdStjstsONSKhZ8zB
 JGcO6K1ys2kdfqsDWxPaUzlxLNFZK8YaBuv740CdbSd1k9ioUW3Em/EC1n2Ry5dtNPks
 NUg5kQG1h/GZSoIF1e7UVXr5JzZjpO723Y8faX7dYhSnqTbB1j0Dc0tdYFn5ipF6Zxcy
 JtaW1Fl5sU71jsFanOziRJ9Gca3bQ19OXDA+2Nat7m3ae3Gih6MmllIAazI81l0baoJu
 z1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410040; x=1775014840;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Z/RmJ+Vahf6x/nbS7JkbihVAKglnpCri09zlzZEL24=;
 b=OIlU4q2INc4eN9JHfCG+KIvugZs6kKotuOmUo9w7rkYxayXR3tX7E7/RK03WiAcNmM
 3NWJFPegn27xpGsUE3yN9JC74tPg7IeW3HhvFuiKYPrhYrMXgJu3JpPJ8dUkvRgQaTHG
 ZSPPI/4T1AlCqsDdt3YHUDuB6M8maJbpA26ENStzSbqfT7E8+Gk0Ww5m+KRqJkVyK+o+
 fj/PKmLCK/Sno7ZynB18cKv8MGvenwjF1pQ1I1he6F7udQflpPdjcbr9CdIN4nWYRDDl
 l5kcdDTsaHBPpnRwsbXx1wDH7t5Ss25r5/bM4iDfYmZwKzrO/jdAkwfFaeTovwMByM0S
 /kZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1t9Ojeq19pf92dlRaT4+GDZosuCHfNxzB/Dm8XOJ4kLf5W5Z+5elEAe5kyOzFbhGSkzaxp75yUoU/@nongnu.org
X-Gm-Message-State: AOJu0YxqYFJ2xcIHdM56/1FVdUQOnUcSRpZd8MQkb2LJ5gvlPTz0fKIl
 87L4jQXIBk1dF1CjU+R99PI34jOpx1DksAwh/hI6WLB81Spa6V1XXEiG
X-Gm-Gg: ATEYQzyfmNvozZ0TzpM6QCciQVN005ro4jXkOHRQiDcH175ODYOQtkFkrU740aqbb8q
 1mKRBCja9M+Tvl+y0auT80WffQPQ4VQaY7E8srgN7suIcLwMItzqkpvOm4SarFK2rUZZFk2weZF
 Y/l3NBzW2U0stz52jUaRwivRiILVNPGNOzJrzyJCPRqgppyvbm8Za3EFEbuawUr0ymBplQ/pdqy
 5LQwky7Le9Zy7nGuC2ISNVYzr3pR7vGomarROgRIqnYQ720hRJNZgRAvhYtap2ozH0vGHA3bLif
 6gyUKYl6Lg6Bf/Sbdi6N/+6sP3Nwq0Cpjd5zhxdx5EiLIiitZrSTYNS+SzXFlqv8c8o+iGvKoJT
 9KVKVEqMLRnOKP90Y/5prRX4dOWgYsY0K86D7r73wxa/XnVzq7Z7Yc2hN2CeX5T18agwgT/L3Xi
 UfbRJSIgOgamE2srE97Bxk+Ml00KQ04pVtOh55udaI7X79dWv1tcdjgNdGVUBJ5L2lTPrUi8ExR
 2bG7xaelELnMbg7R8YCAUUS6pD57Yk=
X-Received: by 2002:a05:7022:ec1:b0:12a:85ef:1e28 with SMTP id
 a92af1059eb24-12a96f25bbfmr879787c88.40.1774410040307; 
 Tue, 24 Mar 2026 20:40:40 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b1a88e5sm21647015eec.13.2026.03.24.20.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:40:39 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:40:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>, 
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix IALIGN check in misa write
Message-ID: <acNYexbXVoMmUMPo@ZEVORN-PC.localdomain>
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-2-npiggin@gmail.com>
 <acNQ3kVLEr92Kfjw@ZEVORN-PC.localdomain>
 <CAKmqyKPCzgZec1v79FfdRz3yA4zdY7C_k_qdPS8oMkSuo644HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPCzgZec1v79FfdRz3yA4zdY7C_k_qdPS8oMkSuo644HQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 25, 2026 at 01:26:56PM +1000, Alistair Francis wrote:
> On Wed, Mar 25, 2026 at 1:09 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > On Sun, Mar 22, 2026 at 12:45:52AM +1000, Nicholas Piggin wrote:
> > > The instruction alignment check for the C extension was inverted.
> > > The new value should be checked for C bit clear (thus increasing
> > > IALIGN). If IALIGN is incompatible, then the write to misa should
> > > be suppressed, not just ignoring the update to the C bit.
> > >
> > > From the ISA:
> > >
> > >   Writing misa may increase IALIGN, e.g., by disabling the "C"
> > >   extension. If an instruction that would write misa increases IALIGN,
> > >   and the subsequent instruction’s address is not IALIGN-bit aligned,
> > >   the write to misa is suppressed, leaving misa unchanged.
> > >
> > > This was found with a verification test generator based on RiESCUE.
> > >
> > > Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> > > Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  target/riscv/csr.c                        | 16 ++++-
> > >  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
> > >  tests/tcg/riscv64/misa-ialign.S           | 88 +++++++++++++++++++++++
> > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > >  create mode 100644 tests/tcg/riscv64/misa-ialign.S
> > >
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index 5064483917..91421a2dd8 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -2129,9 +2129,19 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
> > >      /* Mask extensions that are not supported by this hart */
> > >      val &= env->misa_ext_mask;
> > >
> > > -    /* Suppress 'C' if next instruction is not aligned. */
> > > -    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
> > > -        val &= ~RVC;
> > > +    /*
> > > +     * misa writes that increase IALIGN beyond alignment of the next
> > > +     * instruction cause the write to misa to be suppressed. Clearing
> > > +     * "C" extension increases IALIGN.
> > > +     */
> > > +    if (!(val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
> > > +        /*
> > > +         * If the next instruction is unaligned mod 4 then "C" must be
> > > +         * set or this instruction could not be executing, so we know
> > > +         * this is is clearing "C" (and not just keeping it clear).
> > "this is is clearing" — double "is"
> >
> > > +         */
> > > +        g_assert(env->misa_ext & RVC);
> > > +        return RISCV_EXCP_NONE;
> > write_misa() is also reachable via riscv_csrrw_debug()
> > with ra=0, where get_next_pc() falls back to env->pc.
> 
> Ah good catch
> 
> > A debugger can set PC to a 2-byte-aligned address while C is
> > already disabled, then write misa keeping C=0. This hits
> > the condition and fires the g_assert.
> 
> I'm not convinced that that's necessarily bad, as that's an odd and
> invalid thing to be writing. But we probably shouldn't assert
> 
> >
> > The ISA spec language:
> >
> >     "if an instruction that would write misa..."
> >
> > does not cover debug writes, so the IALIGN suppression
> > arguably should not apply in that case at all.
> >
> > We can:
> >
> >     if (ra && !(val & RVC)
> >         && (get_next_pc(env, ra) & 3) != 0) {
> >         g_assert(env->misa_ext & RVC);
> >         return RISCV_EXCP_NONE;
> >     }
> 
> Maybe it's best to change the `g_assert()` to a log GUEST_ERROR
> instead. That way we flag that something fishy is going on, but don't
> exit QEMU
> 
Agreed!

Replacing the g_assert() with qemu_log_mask(LOG_GUEST_ERROR, ...)
sounds like the right balance — it still surfaces the anomaly for
anyone debugging, without taking down QEMU over what is ultimately
a debugger-induced corner case.

The IALIGN suppression logic itself is still correct for the normal
execution path, so there's no reason to skip it entirely; just don't
crash on the weird one.

Thanks,
Chao

> Alistair
> 
> >
> > Thanks,
> > Chao
> > >      }
> > >
> > >      /* Disable RVG if any of its dependencies are disabled */
> > > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> > > index eb1ce6504a..f176f87ed0 100644
> > > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > > @@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
> > >         $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
> > >         $(QEMU_OPTS)$<)
> > >
> > > +EXTRA_RUNS += run-misa-ialign
> > > +run-misa-ialign: QEMU_OPTS := -cpu rv64,c=true,v=true,x-misa-w=on $(QEMU_OPTS)
> > > +run-misa-ialign: misa-ialign
> > > +     $(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
> > > +
> > >  # We don't currently support the multiarch system tests
> > >  undefine MULTIARCH_TESTS
> > > diff --git a/tests/tcg/riscv64/misa-ialign.S b/tests/tcg/riscv64/misa-ialign.S
> > > new file mode 100644
> > > index 0000000000..7f1eb30023
> > > --- /dev/null
> > > +++ b/tests/tcg/riscv64/misa-ialign.S
> > > @@ -0,0 +1,88 @@
> > > +/*
> > > + * Test for MISA changing C and related IALIGN alignment cases
> > > + *
> > > + * This test verifies that the "C" extension can be cleared and set in MISA,
> > > + * that a branch to 2-byte aligned instructions can be executed when "C" is
> > > + * enabled, and that a write to MISA which would increase IALIGN and cause
> > > + * the next instruction to be unaligned is ignored.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#define RVC (1 << ('C'-'A'))
> > > +#define RVV (1 << ('V'-'A'))
> > > +
> > > +.option norvc
> > > +     .text
> > > +     .global _start
> > > +_start:
> > > +     lla     t0, trap
> > > +     csrw    mtvec, t0
> > > +
> > > +     csrr    t0, misa
> > > +     li      t1, RVC
> > > +     not     t1, t1
> > > +     and     t0, t0, t1
> > > +     csrw    misa, t0
> > > +     csrr    t1, misa
> > > +     li      a0, 2 # fail code
> > > +     bne     t0, t1, _exit # Could not clear RVC in MISA
> > > +
> > > +     li      t1, RVC
> > > +     or      t0, t0, t1
> > > +     csrw    misa, t0
> > > +     csrr    t1, misa
> > > +     li      a0, 3 # fail code
> > > +     bne     t0, t1, _exit # Could not set RVC in MISA
> > > +
> > > +     j       unalign
> > > +. = . + 2
> > > +unalign:
> > > +
> > > +     li      t1, RVC
> > > +     not     t1, t1
> > > +     and     t0, t0, t1
> > > +     csrw    misa, t0
> > > +     csrr    t1, misa
> > > +     li      a0, 4 # fail code
> > > +     beq     t0, t1, _exit # Was able to clear RVC in MISA
> > > +
> > > +     li      t0, (RVC|RVV)
> > > +     not     t0, t0
> > > +     and     t0, t0, t1
> > > +     csrw    misa, t0
> > > +     csrr    t0, misa
> > > +     li      a0, 5 # fail code
> > > +     bne     t0, t1, _exit # MISA write was not ignored (RVV was cleared)
> > > +
> > > +     j       realign
> > > +. = . + 2
> > > +realign:
> > > +
> > > +     # Success!
> > > +     li      a0, 0
> > > +     j       _exit
> > > +
> > > +trap:
> > > +     # Any trap is a fail code 1
> > > +     li      a0, 1
> > > +
> > > +# Exit code in a0
> > > +_exit:
> > > +     lla     a1, semiargs
> > > +     li      t0, 0x20026     # ADP_Stopped_ApplicationExit
> > > +     sd      t0, 0(a1)
> > > +     sd      a0, 8(a1)
> > > +     li      a0, 0x20        # TARGET_SYS_EXIT_EXTENDED
> > > +
> > > +     # Semihosting call sequence
> > > +     .balign 16
> > > +     slli    zero, zero, 0x1f
> > > +     ebreak
> > > +     srai    zero, zero, 0x7
> > > +     j       .
> > > +
> > > +     .data
> > > +     .balign 16
> > > +semiargs:
> > > +     .space  16
> > > --
> > > 2.51.0
> > >
> > >
> >

