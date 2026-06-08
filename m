Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4FCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcLM-0000KW-AP; Mon, 08 Jun 2026 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wWcLH-0000Jk-BP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:56:48 -0400
Received: from mail-244121.protonmail.ch ([109.224.244.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wWcLC-0003Wc-TB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1780934197; x=1781193397;
 bh=/fzFYTxhLa65FGZEIRJqGJx+k+b0C3Kk7yCSRp0qkz8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MjzAOKx8GO9GFnwoIFcG25h2lffG/RNsQjPUy7XUFnAmVcM3nQfg3buY9LPDyG0kd
 48pdI3Xi918ck24TZw7z+2PASnPw8RWOhiy2yxcz+vAGXTeapd1qONt13NqZCHbHwx
 uM+/qNvUyajxKv0NL5gEtPnVD8dSxRBvf6E/cM6R9DSQ9r3rQsN+X22TR4QNPZdDCm
 K/wY1d+PqLApCaMHNCgduwXByLcl7fdAcJDwkjMHI1kfxIsclM3wfBXhZXK/wQO50y
 06lWeGrCuHenP5xtr3qkWthsWhTVo89DcMgu5fknJ+jt4PYjQ8VjIW+vr9qIPBZhui
 aay/Ymx0JQGOA==
Date: Mon, 08 Jun 2026 15:56:30 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: "Jason L. Wright'" <wrigjl@proton.me>
Cc: agraf@csgraf.de, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 zenghui.yu@linux.dev, richard.henderson@linaro.org
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
Message-ID: <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
In-Reply-To: <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
 <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 6c6114d55710d5650da6f668fc1b48302fa077e2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.121; envelope-from=wrigjl@proton.me;
 helo=mail-244121.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 08, 2026 at 02:07:03PM +0100, Peter Maydell wrote:
> On Sun, 7 Jun 2026 at 19:22, Jason Wright <wrigjl@proton.me> wrote:
> >
> > Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS=
")
> > gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TR=
NDR
> > at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulatio=
n
> > path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
> > register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silico=
n:
> >
> >   Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
> >   function hvf_arch_init_vcpu, file hvf.c, line 1442.
> >
> > Reproduce with:
> >
> >   qemu-system-aarch64 -M virt,accel=3Dhvf -cpu host \
> >                       -nographic -display none -bios /dev/null
> >
> > Mirror the existing treatment of ID_AA64PFR0_EL1: move
> > HV_SYS_REG_ID_AA64ISAR0_EL1 into the SYNC_NO_RAW_REGS block in
> > sysreg.c.inc so the assert loop skips it, and push QEMU's view of the
> > register to the vCPU at init time.  HVF does not expose EL3, so
> > SCR_EL3.TRNDR is never set and the readfn is functionally static there.
> >
> > Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> > Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS=
")
> > Signed-off-by: Jason Wright <wrigjl@proton.me>
> > ---
> >  target/arm/hvf/hvf.c        | 4 ++++
> >  target/arm/hvf/sysreg.c.inc | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index d88cbe7c82..afa1120c8a 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -1485,6 +1485,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >      ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0=
_EL1, pfr);
> >      assert_hvf_ok(ret);
> >
> > +    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR=
0_EL1,
> > +                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0))=
;
> > +    assert_hvf_ok(ret);
> > +
>=20
> For ID_AA64PFR0_EL1, we do "read the value from hvf, update it,
> write it back", and we do not either read or write the isar.idregs[]
> entry for it.
>=20
> For ID_AA64MMFR0_EL1, we read the hvf value into the isar.idregs[]
> array entry, update it there, and write it back to hvf.
>=20
> For ID_AA64ISAR0_EL1, we write whatever is in the isar.idregs[]
> array entry into hvf.
>=20
> Why do we do three different things for these three registers ?
>=20
I think it's each call doing the minimum work required for that
register.

MIDR_EL1 / MPIDR_EL1 are QEMU-defined identity values; HVF has
nothing useful to contribute, so we just write.

ID_AA64PFR0_EL1 needs HVF's value as the base (host feature set)
and then ORs in the GIC sysreg-iface bit, which depends on
env->gicv3state runtime overlay, hence the get/modify/set.

ID_AA64MMFR0_EL1 also needs HVF's value as the base, and the
modification (clamping PARANGE to the configured IPA size)
consults isar.idregs[], so we read into idregs[] before clamping
and then write back.

ID_AA64ISAR0_EL1 in this patch has no runtime overlay on the HVF
path: SCR_EL3.TRNDR is permanently 0 since HVF does not expose
EL3, so the readfn is a constant equal to
isar.idregs[ID_AA64ISAR0_EL1_IDX], which was already seeded from
the host during realize.

The three methods track different requirements, so I matched
the closest existing pattern for ID_AA64ISAR0_EL1 and left
the others alone.


