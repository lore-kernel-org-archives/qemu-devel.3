Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8678CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcTz-0003xG-4b; Mon, 08 Jun 2026 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcTp-0003wS-Ib
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:05:39 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcTl-0006cP-Fu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:05:36 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bec405a6ea5so652471966b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934730; cv=none;
 d=google.com; s=arc-20240605;
 b=EJ1bnWG6K9rUoMx3xG14hFAvPR/kgOHDpwL4nSuVHcsYMlx8G+wpNRgvE6cbLW3RHv
 Sw48NwlMye0DaBE6aFTtUBhKLZrINesPTy1vr5FZtFmTqUaFIZFqm9T/oArxJe2T03AP
 6yHqzCxVBb/Dw5DlPAv6dT8Br8DnsjG2JY+YCCCLzLsImudv56B34zqARLj0W5frdmA1
 QYwUKbJX76rqGYoBg5EmNLGmSeK3hbRz+qw+AMJ0yXaKS2elnDYECfj6VFcgllDzJvWf
 3HlrFnKYCVdi+DfYFU94Yzm+n20684xSdnFWWZ1oV+VwK7vMD+26SXebQ03tLZvFjK2R
 x0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BRgT605k8dfAx+YdtLK8ADrnknINr0SKeKiA4MiO6GQ=;
 fh=862SatUZa+S3PxnsjY378FtwpY16se653fzzPvFU7oA=;
 b=SKx2O5DeFP0/Ng5KnI+kV7Ip4S6dcB0zFTUwtYXrztj62eZC5wUP2a1KwvMiU/WE6k
 4qBJwUtiMfXwiHTvhnBtz7HloVxV9HJQnpaBL7ZmkHYTFcNF2dGo69uPfLiO+gt5tdCJ
 nj7oianjs9PukTKeMf6sNubUWVmlGZKDnu2sQcPvSzPE8gjfWU/kWQYkLXPZGhT4kx8E
 o0jhoY17HuYlEdHnO8QykYlETmtxp+56c4ILfg6O9SGI/OTnEa8eUoXIWEn9vbxUCO2o
 8dWNym65iZd738VnXGuDUkKc3B8HniSqHOjMxGxMcJcoGMtJsEmK9nkbS+Eo602F4ytJ
 bIww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780934730; x=1781539530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BRgT605k8dfAx+YdtLK8ADrnknINr0SKeKiA4MiO6GQ=;
 b=FQuipSsobjwTdcygJ4bBVRwW+4vnOhhK1XN6s5QR4TKZhvSePKfbHys07yqkaR6KAa
 PoEtkgCuNbhpeQ1oMxDaUCIgSUS21zOkc0IJzO8I2PJa9uF7giewU+FCKLyjoFZCZE/H
 goiRwBKbTKVwEUG8hXAajf0bofiUt0Ch9mLPoQVWiNGpx0j5jnOx50Vc3z/Q+g1ROPIa
 gGhw1qPoI1wV5cH4B+zf/hcp9umfKiucl350st7QhUUnSQLcGo0R3UVZ5q9QquzWUj9w
 TfT+oUg2uQM0xkT7qKfokw2QVB84xYKLeOr8repbU0/F/QrYFeh5ER7BvKHZa5NOpInu
 CMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934730; x=1781539530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRgT605k8dfAx+YdtLK8ADrnknINr0SKeKiA4MiO6GQ=;
 b=HDL4Bn3qXyMUZ8FxGVuBdHCaNgp+pgyp9XIi0fYhPLD9BjqZ1benhohLc8EqHVz8Y5
 Mb+sYlZmdiwbWLzhR+XHlrniDWtsmhhbJH00+5pCMMV1KCbZXVyXjPhj2us4QIt/62rt
 wE/qB3M4ety/v2EhBKVYvHc17BIgNBjYbcYsi+fnCiFd67yGl2mMQN6eGpH/SglEA+Cc
 DFeI0KVtDEzg+53Hf0m/UmEtC1IKtVMSLWrDZ9jvxbCNgG95LjRtouFiO1z+wBb1DpSr
 97SK7g6cxKRjao7ZLrsaAhAnqgRglU8P1a322pvO9GeJz3n2gUzR9QDznNkwaJCP5KwD
 DYDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Dnwg6qREKprSHDuKrYa0lMbeillwRhWpse1+O4cu6WYaqqiFuWqQvEPCYN66XJVmxg+y3PKEpIYhG@nongnu.org
X-Gm-Message-State: AOJu0YyUyOJFstDJMjXGRTiod/rLCAFPuW+acrjxxBg6yxsEgUJ7LABO
 D03DVJilQ1FCps33+qZDVuUPb6p4+Spw2t1gQlfZNmQsZPsE3h9zSNijH4mfX9fNzfn8pMfPVS4
 t80+kG5FZSTKJJm//YZ48m17/1PQF3sFQsDriEFpiKQ==
X-Gm-Gg: Acq92OE1K2HnqwmRj8RgCc9tdct7+x/KeHH8E45DZ+6hhBD9Alhw9G1/WS96IzrTmQ9
 5XTe6tq8n76SyCP6weDrRwFWzSYaltPvtl6jE7uFunB0frYNnztOxJ+oiE9ovUXiHKLuezPPr0+
 0Bwmi1mT8SOMMxf5iEz4m0L8IO1J+kwnMDp34QMxpCWYl2z28nufViRnS0Vqg3k0vFSfJiQUbyY
 uzmFjG7ClDh2TLGrDmqBDetcYVdwUz/4lQ3eDogXTG1ICHx4BH07laGgbuBScvX+69jbkvvcMzH
 5kcMO0R/bv+T+LpNOPDB8RKH66k726zUjWqjZO5vkkUWp2rfddnzI2b9K1h6ULx/5xdSj0OFfRq
 zxg==
X-Received: by 2002:a17:907:a49:b0:bed:19af:f8aa with SMTP id
 a640c23a62f3a-bf37057a9a2mr798173666b.13.1780934729535; Mon, 08 Jun 2026
 09:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
 <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
 <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
In-Reply-To: <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:05:14 +0100
X-Gm-Features: AVVi8CcssVn5ksc4UvVhWrtATM1q7vJrWv_84FJTdcJC5zLEdrISwTvHqaiwFWU
Message-ID: <CAFEAcA85HahxFXoDVW_xBZEtG2SUd_3PseYLrpUXE6P_Hb_5mA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
To: "Jason L. Wright'" <wrigjl@proton.me>
Cc: agraf@csgraf.de, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 zenghui.yu@linux.dev, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 8 Jun 2026 at 16:56, Jason L. Wright' <wrigjl@proton.me> wrote:
>
> On Mon, Jun 08, 2026 at 02:07:03PM +0100, Peter Maydell wrote:
> > On Sun, 7 Jun 2026 at 19:22, Jason Wright <wrigjl@proton.me> wrote:
> > >
> > > Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
> > > gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TRNDR
> > > at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulation
> > > path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
> > > register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silicon:
> > >
> > >   Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
> > >   function hvf_arch_init_vcpu, file hvf.c, line 1442.
> > >
> > > Reproduce with:
> > >
> > >   qemu-system-aarch64 -M virt,accel=hvf -cpu host \
> > >                       -nographic -display none -bios /dev/null
> > >
> > > Mirror the existing treatment of ID_AA64PFR0_EL1: move
> > > HV_SYS_REG_ID_AA64ISAR0_EL1 into the SYNC_NO_RAW_REGS block in
> > > sysreg.c.inc so the assert loop skips it, and push QEMU's view of the
> > > register to the vCPU at init time.  HVF does not expose EL3, so
> > > SCR_EL3.TRNDR is never set and the readfn is functionally static there.
> > >
> > > Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> > > Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
> > > Signed-off-by: Jason Wright <wrigjl@proton.me>
> > > ---
> > >  target/arm/hvf/hvf.c        | 4 ++++
> > >  target/arm/hvf/sysreg.c.inc | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > > index d88cbe7c82..afa1120c8a 100644
> > > --- a/target/arm/hvf/hvf.c
> > > +++ b/target/arm/hvf/hvf.c
> > > @@ -1485,6 +1485,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> > >      ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
> > >      assert_hvf_ok(ret);
> > >
> > > +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL1,
> > > +                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
> > > +    assert_hvf_ok(ret);
> > > +
> >
> > For ID_AA64PFR0_EL1, we do "read the value from hvf, update it,
> > write it back", and we do not either read or write the isar.idregs[]
> > entry for it.
> >
> > For ID_AA64MMFR0_EL1, we read the hvf value into the isar.idregs[]
> > array entry, update it there, and write it back to hvf.
> >
> > For ID_AA64ISAR0_EL1, we write whatever is in the isar.idregs[]
> > array entry into hvf.
> >
> > Why do we do three different things for these three registers ?
> >
> I think it's each call doing the minimum work required for that
> register.
>
> MIDR_EL1 / MPIDR_EL1 are QEMU-defined identity values; HVF has
> nothing useful to contribute, so we just write.

These don't have isar.idregs[] entries either, so it makes sense
that they're not quite the same.

> ID_AA64PFR0_EL1 needs HVF's value as the base (host feature set)
> and then ORs in the GIC sysreg-iface bit, which depends on
> env->gicv3state runtime overlay, hence the get/modify/set.

But why do we not update isar.idregs[] to match ?

> ID_AA64MMFR0_EL1 also needs HVF's value as the base, and the
> modification (clamping PARANGE to the configured IPA size)
> consults isar.idregs[], so we read into idregs[] before clamping
> and then write back.

But why does the modification consult isar.idregs[] rather than
taking a value that it's passed in as an argument ?

> ID_AA64ISAR0_EL1 in this patch has no runtime overlay on the HVF
> path: SCR_EL3.TRNDR is permanently 0 since HVF does not expose
> EL3, so the readfn is a constant equal to
> isar.idregs[ID_AA64ISAR0_EL1_IDX], which was already seeded from
> the host during realize.

But if the values in isar.idregs[] are seeded from HVF during
realize, why do we not trust the isar.idregs[] value when we're
handling ID_AA64PFR0_EL1?

> The three methods track different requirements, so I matched
> the closest existing pattern for ID_AA64ISAR0_EL1 and left
> the others alone.

It seems to me that you've added a third thing that's different
from either of the ways that we handle existing ID registers
with an isar.idregs[] field.

I think we need to figure out:

(1) can we trust that the isar.idregs[] values at this point
are the ones that hvf uses? If so we don't need to re-read
the hvf values. If we can't trust them we should consistently
read the hvf values.

(2) do we need to update the isar.idregs[] values when we
modify the values to write back to hvf? If so, we should
do it consistently for all these regs. If not, we should
not update any of them.

Currently ID_AA64PFR0_EL1 neither trusts isar.idregs[] nor
updates it; ID_AA64MMFR0_EL1 does not trust isar.idregs[]
but does update it; and ID_AA64ISAR0_EL1 trusts isar.idregs[]
and has no need to update it.

thanks
-- PMM

