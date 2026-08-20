Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDC1C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1ON-0001hC-61; Thu, 20 Aug 2026 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wx1OL-0001gz-D5; Thu, 20 Aug 2026 07:57:05 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wx1OJ-0007Xx-49; Thu, 20 Aug 2026 07:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Rphan94
 oAsgX9gRemCin/nJkPsXczczbcYk6IXrSDnKOFp6b9QQMo0NbH5dCQ3ihL4q6oGlLkQzSG
 2F7hd9vRBChNDSj9xcFJdcthfJRIgtPnhEGF/TWP4l58pgDbOasRnejPhKeXY/ZJkLmetq
 kOqI75vkrwB0SA+7hN0NJ9KYU0rsbUhLC1Hstzk0qJied1tAWYGEFJ24LlYlmuxLShSwkb
 GLY2jjvjX7N9VLV4h20Ym6E68e6FPbFVFdbrlLB9DxZmCx0ylDs2Th8qxFtoepVlmillcv
 wDYjxTKNAvmXjtRIbVT0OvHE4RwFs1HDQasApArM31mScSOUtnNDkog==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=T
 PRvmg9k2mFdSha3OqaXrN7kMPZs7mbpPIiHmqFb6os=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=HXyYweBokZb28At6b7qPt4QmVBBcPe0eSFhPETbAGwlHpIr20j992yjXrDJTOAx/lCZy
 EYRctBKZ12RPf1S9UDoveHzEztSgvxQZBuid5WXyRsZTcm6DEycn5bbsjGEVKsH2QLphlD
 6TjnXvgAZPOCRWqnVl7rUtZW+7MqiDESb42pXHWPAnD+Il0erCqWF4R2BjKw3ZK5nOliME
 gzRlRIj9aeLznoOqJZrrdwT/QCEK2vCLcQms543NmMWQQY/orT7q4Gq9qL/kJ2ZzqiOf9z
 Nfe5cqhGtjwgHuHO8Ckaa6IXIiV+3Ft91nWe6lb7S0EId6hmdaLCnWQ5r3TBhjYg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=rxI8r/Mi; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=p3tB9NN0;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=TPRvmg9k
 2mFdSha3OqaXrN7kMPZs7mbpPIiHmqFb6os=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=rxI8r/Miu9qdxyre6qp+4KoJAtcly5
 l5se2Jo8hgkZgNhXrjvqZKOGSusz4pf4zqm9BDMc62rDNqA0pyM6BVwjQtepD7E+qJ5X85
 iS+mR96apCRN4bl6VNOajLXUitT+gAtFmzL5qoq3u8NP3b3ddM36B51HEMSeHfAb5uvod9
 Kv9QWGXwpj2S4ymgF2zF++XjlVI9RNvreHpgSnuJ9srBeLetuJ3XxLPadjKo8iQUsOcGko
 XhdOiu/HgpfQDMgg7Yg23Pkm9UyjCqJhcguzxhWr+0W1L6FKNR/BIxceEF+hBins3AoOJx
 bzGTnW89fy5tmWcxvPxUG/xqUSbVqVGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=TPRvmg9k2mFdSha3OqaXrN7kMPZs7mbpPIiHmqFb6os=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=p3tB9NN0QoiO+LhIHA
 EDOimjXP+60B7voRRx/z26BtowxUlQYH9Bn3GbXugFvM1NmkumPy6MREvhCpTSHX9kAQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id ffa29b2b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 20 Aug 2026 13:56:58 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id f4b88aa8;
 Thu, 20 Aug 2026 13:56:54 +0200 (CEST)
Date: Thu, 20 Aug 2026 13:56:54 +0200
Message-ID: <87tsopqa2h.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, brad@comstyle.com
Subject: Re: [PATCH v4] powernv: boot OpenBSD on POWER9
In-Reply-To: <f6514bca-aae6-46ea-9e40-c111865f6b26@linux.ibm.com>
References: <20260719145559.94342-1-kirill@korins.ky>
 <f6514bca-aae6-46ea-9e40-c111865f6b26@linux.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: rathc@linux.ibm.com, shivangu@linux.ibm.com,
 adityag@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com,
 brad@comstyle.com, Kirill A. Korinsky <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Thu, 20 Aug 2026 12:49:36 +0200,
Chinmay Rath <rathc@linux.ibm.com> wrote:
> 
> 
> On 7/19/26 20:25, Kirill A. Korinsky wrote:
> > The POWER9 Processor User's Manual, section 4.9.4, specifies that POWER9
> > ignores PTCR[PATS] and only supports a 64 KiB partition table. Use an
> > effective PATS value of 4 on POWER9; other processors keep the existing
> > ISA v3.0 interpretation.
> > 
> > The PSI model now exposes POWER9 IRQ level and pending status registers,
> > and keeps both updated while delivering through the existing XIVE LSI
> > source. This lets guests that select the POWER9 PSI LSI IRQ method
> > continue to receive LPC interrupts.
> > 
> > The blast radius is probably minimal: the PTCR change is limited to
> > POWER9, while the PSI change only touches POWER9 PSI state and reuses
> > the existing delivery path.
> <Signed-off-by> is missing :)

Oops, shall I send a v5 version with:

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>

or it's ok?

> > ---
> >   hw/ppc/pnv_psi.c                       | 11 ++++--
> >   target/ppc/mmu-book3s-v3.c             | 21 +++++++++--
> >   tests/functional/ppc64/meson.build     |  2 +
> >   tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++
> >   4 files changed, 79 insertions(+), 7 deletions(-)
> >   create mode 100755 tests/functional/ppc64/test_openbsd.py
> > 
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index e8701c6100..39ec448f3c 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -688,6 +688,8 @@ static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned size)
> >       case PSIHB9_ESB_CI_BASE:
> >       case PSIHB9_ESB_NOTIF_ADDR:
> >       case PSIHB9_IVT_OFFSET:
> > +    case PSIHB9_IRQ_LEVEL:
> > +    case PSIHB9_IRQ_STAT:
> >           val = psi->regs[reg];
> >           break;
> >       default:
> > @@ -818,17 +820,20 @@ static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
> >   {
> >       PnvPsi *psi = opaque;
> >       uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
> > +    uint64_t irq_bit = PPC_BIT(irq);
> >         if (irq_method & PSIHB9_IRQ_METHOD) {
> >           qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
> >           return;
> >       }
> >   -    /* Update LSI levels */
> > +    /* Update LSI levels and pending status */
> >       if (state) {
> > -        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= PPC_BIT(irq);
> > +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= irq_bit;
> > +        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] |= irq_bit;
> >       } else {
> > -        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~PPC_BIT(irq);
> > +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~irq_bit;
> > +        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] &= ~irq_bit;
> >       }
> >         qemu_set_irq(psi->qirqs[irq], state);
> > diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> > index 3865556310..f329a7a0f2 100644
> > --- a/target/ppc/mmu-book3s-v3.c
> > +++ b/target/ppc/mmu-book3s-v3.c
> > @@ -23,24 +23,37 @@
> >   #include "mmu-hash64.h"
> >   #include "mmu-book3s-v3.h"
> >   +#define PPC64_V3_PATE_SIZE 16 /* two 64-bit words */
> > +
> >   bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
> >   {
> >       uint64_t patb = cpu->env.spr[SPR_PTCR] & PTCR_PATB;
> >       uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> > +    uint64_t table_size;
> > +    uint64_t entries;
> > +
> > +    /*
> > +     * The POWER9 Processor User's Manual, section 4.9.4, specifies that
> > +     * POWER9 ignores PTCR[PATS] and only supports a 64 KiB partition table.
> > +     */
> > +    if (cpu->env.excp_model == POWERPC_EXCP_POWER9) {
> > +        pats = 4;
> > +    }
> > +    table_size = 1ULL << (pats + 12);
> >         /* Check if partition table is properly aligned */
> > -    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> > +    if (patb & (table_size - 1)) {
> >           return false;
> >       }
> >         /* Calculate number of entries */
> > -    pats = 1ull << (pats + 12 - 4);
> > -    if (pats <= lpid) {
> > +    entries = table_size / PPC64_V3_PATE_SIZE;
> > +    if (entries <= lpid) {
> >           return false;
> >       }
> >         /* Grab entry */
> > -    patb += 16 * lpid;
> > +    patb += PPC64_V3_PATE_SIZE * lpid;
> >       entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
> >       entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
> >       return true;
> > diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
> > index f0f8ab8f61..cb3c745624 100644
> > --- a/tests/functional/ppc64/meson.build
> > +++ b/tests/functional/ppc64/meson.build
> > @@ -4,6 +4,7 @@ test_ppc64_timeouts = {
> >     'fadump' : 480,
> >     'hv' : 1000,
> >     'mac99' : 120,
> > +  'openbsd' : 240,
> >     'powernv' : 480,
> >     'pseries' : 480,
> >     'replay' : 210,
> > @@ -20,6 +21,7 @@ tests_ppc64_system_thorough = [
> >     'fadump',
> >     'hv',
> >     'mac99',
> > +  'openbsd',
> >     'powernv',
> >     'pseries',
> >     'replay',
> > diff --git a/tests/functional/ppc64/test_openbsd.py b/tests/functional/ppc64/test_openbsd.py
> > new file mode 100755
> > index 0000000000..bdbef6bf82
> > --- /dev/null
> > +++ b/tests/functional/ppc64/test_openbsd.py
> > @@ -0,0 +1,52 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Test that OpenBSD boots on a ppc powernv machine and reaches the installer.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +from qemu_test import QemuSystemTest, Asset
> > +from qemu_test import wait_for_console_pattern
> > +
> > +
> > +class OpenBSDPowerNV(QemuSystemTest):
> > +
> > +    ASSET_MINIROOT = Asset(
> > +        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/miniroot79.img',
> > +        '7829e42b75d81cafd732038b9d63228b79c1f5828d8375872a4bb655e1d6b13c')
> > +
> > +    ASSET_BOOTKERNEL = Asset(
> > +        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/pnor.BOOTKERNEL',
> > +        '397ce43ce61910e1a2c4f13d301f957e61513a9ec5371bc3e87d3095411fae7b')
> > +
> > +    def test_powernv9_openbsd_installer(self):
> > +        self.set_machine('powernv9')
> > +        self.require_accelerator('tcg')
> > +
> > +        miniroot_path = self.ASSET_MINIROOT.fetch()
> > +        bootkernel_path = self.ASSET_BOOTKERNEL.fetch()
> > +
> > +        self.vm.set_console()
> > +        self.vm.add_args('-cpu', 'power9',
> > +                         '-accel', 'tcg,thread=single',
> > +                         '-smp', '1,cores=1,threads=1',
> > +                         '-m', '2g',
> > +                         '-kernel', bootkernel_path,
> > +                         '-device',
> > +                         'ich9-ahci,id=sata0,bus=pcie.0,addr=0x0',
> > +                         '-drive',
> > +                         f'file={miniroot_path},format=raw,if=none,'
> > +                         'id=bootdisk,snapshot=on',
> > +                         '-device',
> > +                         'ide-hd,bus=sata0.0,unit=0,drive=bootdisk,'
> > +                         'bootindex=1')
> > +        self.vm.launch()
> > +
> > +        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
> > +        wait_for_console_pattern(
> > +            self,
> > +            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
> > +            'panic:')
> > +
> > +
> > +if __name__ == '__main__':
> > +    QemuSystemTest.main()

-- 
wbr, Kirill

