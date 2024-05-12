Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33419C25B74
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ibh-00016J-6L; Sun, 12 May 2024 19:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibd-00012z-GX; Sun, 12 May 2024 19:27:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6IbT-0000DE-Ds; Sun, 12 May 2024 19:27:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3A5834E6076;
 Mon, 13 May 2024 01:27:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WKYeFjOSKngb; Mon, 13 May 2024 01:27:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3CC6D4E600F; Mon, 13 May 2024 01:27:32 +0200 (CEST)
Message-Id: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 00/61] Misc PPC exception and BookE MMU clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:27:32 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series does some further clean up mostly around BookE MMU to
untangle it from other MMU models. It also contains some other changes
that I've come up with while working on this. The Simplify
ppc_booke_xlate() part 1 and part 2 patches could be squashed together
but left them separate for easier review. This could still be continued
which I might do in the future but this is long enough now to be merged.

v7:
- Added more clean ups

v6:
- Finish breaking up ppc_jumbo_xlate by MMU model as the TODO comment
said and remove it completely
- Add some more small clean ups

v5:
- drop sc patches from this series
- eliminate uninit warning work arounds and also get rid of
get_physical_address_wtlb() (one memset is still needed temporarily
but can be removed at the end)
- use function instead of macro

v4:
- Add a (probably redundant) check for MPC8xx case in ppc_xlate so we
don't have to care about it in lower levels
- Detangle BookE related functions from mmu_ctx_t to avoid some used
uninit work arounds and allow these to be moved out to mmu-booke.c
- Some other tweaks asked during review

v3:
- Address review comments from Nick
- Rebase on master
- Squashed some patches together
- Add some more patches I've done since last version

v2:
- Fix user mode issue in patch 1 by keeping old behaviour for user mode
- Add some more MMU clean up patches

Regards,
BALATON Zoltan


Dr. David Alan Gilbert (1):
  target/ppc: Remove unused struct 'mmu_ctx_hash32'

BALATON Zoltan (60):
  target/ppc: Remove unused helper
  target/ppc/mmu_common.c: Move calculation of a value closer to its
    usage
  target/ppc/mmu_common.c: Remove unneeded local variable
  target/ppc/mmu_common.c: Simplify checking for real mode
  target/ppc/mmu_common.c: Drop cases for unimplemented MPC8xx MMU
  target/ppc/mmu_common.c: Introduce mmu6xx_get_physical_address()
  target/ppc/mmu_common.c: Move else branch to avoid large if block
  target/ppc/mmu_common.c: Move some debug logging
  target/ppc/mmu_common.c: Eliminate ret from
    mmu6xx_get_physical_address()
  target/ppc/mmu_common.c: Split out BookE cases before checking real
    mode
  target/ppc/mmu_common.c: Split off real mode cases in
    get_physical_address_wtlb()
  target/ppc/mmu_common.c: Inline and remove check_physical()
  target/ppc/mmu_common.c: Fix misindented qemu_log_mask() calls
  target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Replace hard coded constants in
    ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Don't use mmu_ctx_t for
    mmu40x_get_physical_address()
  target/ppc/mmu_common.c: Don't use mmu_ctx_t in
    mmubooke_get_physical_address()
  target/ppc/mmu_common.c: Don't use mmu_ctx_t in
    mmubooke206_get_physical_address()
  target/ppc/mmu_common.c: Remove BookE from direct store handling
  target/ppc/mmu_common.c: Split off BookE handling from
    ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part 1
  target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part 2
  target/ppc/mmu_common.c: Split off real mode handling from
    get_physical_address_wtlb()
  target/ppc/mmu_common.c: Split off 40x cases from ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Transform ppc_jumbo_xlate() into
    ppc_6xx_xlate()
  target/ppc/mmu_common.c: Move mmu_ctx_t type to mmu_common.c
  target/ppc/mmu_common.c: Remove pte_update_flags()
  target/ppc: Remove id_tlbs flag from CPU env
  target/ppc: Split off common embedded TLB init
  target/ppc/mmu-hash32.c: Drop a local variable
  target/ppc/mmu-radix64.c: Drop a local variable
  target/ppc: Add a function to check for page protection bit
  target/ppc: Move out BookE and related MMU functions from mmu_common.c
  target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot()
  target/ppc/mmu_common.c: Remove local name for a constant
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Remove another single use local
  target/ppc/mmu_common.c: Remove yet another single use local
  target/ppc/mmu_common.c: Return directly in ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Simplify ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Remove unused field from mmu_ctx_t
  target/ppc/mmu_common.c: Remove hash field from mmu_ctx_t
  target/ppc/mmu_common.c: Remove nx field from mmu_ctx_t
  target/ppc/mmu_common.c: Convert local variable to bool
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Simplify a switch statement
  target/ppc/mmu_common.c: Inline and remove ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Remove ptem field from mmu_ctx_t
  target/ppc: Add function to get protection key for hash32 MMU
  target/ppc/mmu-hash32.c: Inline and remove ppc_hash32_pte_prot()
  target/ppc/mmu_common.c: Init variable in function that relies on it
  target/ppc/mmu_common.c: Remove key field from mmu_ctx_t
  target/ppc/mmu_common.c: Stop using ctx in ppc6xx_tlb_check()
  target/ppc/mmu_common.c: Rename function parameter
  targe/ppc/mmu_common.c: Use defines instead of numeric constants
  target/ppc: Remove bat_size_prot()
  target/ppc/mmu_common.c: Stop using ctx in get_bat_6xx_tlb()
  target/ppc/mmu_common.c: Remove mmu_ctx_t
  target/ppc/mmu_common.c: Remove a local variable

 hw/ppc/pegasos2.c        |    2 +-
 target/ppc/cpu.h         |    9 +-
 target/ppc/cpu_init.c    |   70 +-
 target/ppc/helper.h      |    2 -
 target/ppc/helper_regs.c |    1 -
 target/ppc/internal.h    |   40 +-
 target/ppc/meson.build   |    1 +
 target/ppc/mmu-booke.c   |  531 +++++++++++++++
 target/ppc/mmu-booke.h   |   17 +
 target/ppc/mmu-hash32.c  |  104 +--
 target/ppc/mmu-hash32.h  |   55 ++
 target/ppc/mmu-hash64.c  |    2 +-
 target/ppc/mmu-radix64.c |    5 +-
 target/ppc/mmu_common.c  | 1400 ++++++++++----------------------------
 target/ppc/mmu_helper.c  |   37 +-
 15 files changed, 1010 insertions(+), 1266 deletions(-)
 create mode 100644 target/ppc/mmu-booke.c
 create mode 100644 target/ppc/mmu-booke.h

-- 
2.30.9


