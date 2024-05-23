Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE00C3DA40
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXa-00078S-6S; Thu, 23 May 2024 19:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXX-00077a-Ls; Thu, 23 May 2024 19:08:03 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXV-0005cc-84; Thu, 23 May 2024 19:08:03 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3737b412ad6so1518155ab.2; 
 Thu, 23 May 2024 16:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505678; x=1717110478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zAb6RBluknRBVY2rNEMcQze/Vl8XVQNfTHmRXjnRii0=;
 b=HfajOEFzSu7VYqO0lhTeAeUyQobwoDSh0uwgRZxr+zRcwldaGnLo60awkVuNt6k+w+
 y6zy8LL5Vx9TO9e3XA3HznhgZPMWi9pNle0lcdZeRdBydzuv1vh7qToV+BFUWYNU4KWo
 fKvY0fCKRwuJWV1v/kfbZcY1Es96bSKKBGsK+wDD/Lgw7F7iq9Z2JeSD2/7N8nUV2p0q
 RxKbNBsAqjeaWlwtzfjSosEgeinZtf2iv40Vhted+MZNuNFAypNRpNM10k9s28eMwE/g
 MpZONMrmf0pm5IxDXlqS2tF3sIhkvpt4r/+ZaVBfdh9ETtePxDIUavIVICaTnfX4BJ8W
 vqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505678; x=1717110478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAb6RBluknRBVY2rNEMcQze/Vl8XVQNfTHmRXjnRii0=;
 b=Mz8MbELe8z9gojfA/Xk9JD7g0s/s9EByW+b8SRd3si3BPVpLoqDS5NaMVxiNOqe9j0
 q9/qMcDIFXeGcOISFMCl14NKK0GMqTHMnC3TvqXoLZVbrtr6hnmmd9ht16heXjg6EY2E
 wY+dKdoOGKvtA6HYfFzvVMo7ohyXOw0cnxPGj8UvoDd4jSSvNRrKzyatjn+TWKSPMTve
 niFq0bZ1G3xvAxrY3uEtmhDPLDtlpDCi+gvtDCYDyxp7xZptuxlZinzp2/rRjiRnGcqs
 7RIWqWAm7ICUMdMWmmKJXfp0vxFxAOl1xJmKjUkuWgNiChS1nPQaysbhgOtgH7kZBxAA
 qcXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRaYSVOdDpWDfyqXS4Cy1TAB6dquUjXrsqjHCvgLIjoltEeoWKOjhjjM6hjSPJNhAFQ0iTsXOdV6Ppluze5bxT5f3j
X-Gm-Message-State: AOJu0Yw8MjnVGHaBNWuXsorEvQGp+5i5DjCDFOTCBjyLvijk42HKYNO+
 BZBq3OGDM71Lr9PTyIBZHA7g6s30KS2ih+ARUNeS1eeXNqwcSyZFSM0Gkw==
X-Google-Smtp-Source: AGHT+IEpqFE0rjC5+k+n2hRe8b3E4DfEk+NoseFGEKKvo/2i3hXAAmPlolvr/xHQ+d20Jlfx4umvMQ==
X-Received: by 2002:a92:c26d:0:b0:36b:3b10:7419 with SMTP id
 e9e14a558f8ab-3737b302a5cmr7193945ab.32.1716505678067; 
 Thu, 23 May 2024 16:07:58 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:07:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 00/72] ppc-for-9.1-1 queue
Date: Fri, 24 May 2024 09:06:33 +1000
Message-ID: <20240523230747.45703-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:

  Merge tag 'pull-tcg-20240523' of https://gitlab.com/rth7680/qemu into staging (2024-05-23 09:47:40 -0700)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.1-1-20240524

for you to fetch changes up to 4e0e22a2de927ec827e3464f7aedd47ed22268d2:

  target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot() (2024-05-24 08:57:51 +1000)

----------------------------------------------------------------
* Fix an interesting TLB invalidate race
* Implement more instructions with decodetree
* Add the POWER8/9/10 BHRB facility
* Add missing instructions, registers, SMT support
* First round of a big MMU xlate cleanup

----------------------------------------------------------------
BALATON Zoltan (33):
      target/ppc: Remove unused helper
      target/ppc/mmu_common.c: Move calculation of a value closer to its usage
      target/ppc/mmu_common.c: Remove unneeded local variable
      target/ppc/mmu_common.c: Simplify checking for real mode
      target/ppc/mmu_common.c: Drop cases for unimplemented MPC8xx MMU
      target/ppc/mmu_common.c: Introduce mmu6xx_get_physical_address()
      target/ppc/mmu_common.c: Move else branch to avoid large if block
      target/ppc/mmu_common.c: Move some debug logging
      target/ppc/mmu_common.c: Eliminate ret from mmu6xx_get_physical_address()
      target/ppc/mmu_common.c: Split out BookE cases before checking real mode
      target/ppc/mmu_common.c: Split off real mode cases in get_physical_address_wtlb()
      target/ppc/mmu_common.c: Inline and remove check_physical()
      target/ppc/mmu_common.c: Fix misindented qemu_log_mask() calls
      target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
      target/ppc/mmu_common.c: Replace hard coded constants in ppc_jumbo_xlate()
      target/ppc/mmu_common.c: Don't use mmu_ctx_t for mmu40x_get_physical_address()
      target/ppc/mmu_common.c: Don't use mmu_ctx_t in mmubooke_get_physical_address()
      target/ppc/mmu_common.c: Don't use mmu_ctx_t in mmubooke206_get_physical_address()
      target/ppc/mmu_common.c: Remove BookE from direct store handling
      target/ppc/mmu_common.c: Split off BookE handling from ppc_jumbo_xlate()
      target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part 1
      target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part 2
      target/ppc/mmu_common.c: Split off real mode handling from get_physical_address_wtlb()
      target/ppc/mmu_common.c: Split off 40x cases from ppc_jumbo_xlate()
      target/ppc/mmu_common.c: Transform ppc_jumbo_xlate() into ppc_6xx_xlate()
      target/ppc/mmu_common.c: Move mmu_ctx_t type to mmu_common.c
      target/ppc: Remove id_tlbs flag from CPU env
      target/ppc: Split off common embedded TLB init
      target/ppc/mmu-hash32.c: Drop a local variable
      target/ppc/mmu-radix64.c: Drop a local variable
      target/ppc: Add a function to check for page protection bit
      target/ppc: Move out BookE and related MMU functions from mmu_common.c
      target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot()

Chinmay Rath (13):
      target/ppc: Merge various fpu helpers
      target/ppc: Move floating-point arithmetic instructions to decodetree.
      target/ppc: Move mul{li, lw, lwo, hw, hwu} instructions to decodetree.
      target/ppc: Make divw[u] handler method decodetree compatible.
      target/ppc: Move divw[u, e, eu] instructions to decodetree.
      target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
      target/ppc: Move multiply fixed-point insns (64-bit operands) to decodetree.
      target/ppc: Move div/mod fixed-point insns (64 bits operands) to decodetree.
      target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel instructions to decodetree.
      target/ppc: Move logical fixed-point instructions to decodetree.
      target/ppc: Move VMX storage access instructions to decodetree
      target/ppc: Move VMX integer logical instructions to decodetree.
      target/ppc: Move VMX integer max/min instructions to decodetree.

Dr. David Alan Gilbert (1):
      target/ppc: Remove unused struct 'mmu_ctx_hash32'

Glenn Miles (4):
      This commit is preparatory to the addition of Branch History Rolling Buffer (BHRB) functionality, which is being provided today starting with the P8 processor.
      This commit continues adding support for the Branch History Rolling Buffer (BHRB) as is provided starting with the P8 processor and continuing with its successors.  This commit is limited to the recording and filtering of taken branches.
      Add support for the clrbhrb and mfbhrbe instructions.
      Adds migration support for Branch History Rolling Buffer (BHRB) internal state.

Nicholas Piggin (21):
      spapr: avoid overhead of finding vhyp class in critical operations
      ppc/spapr: Add ibm,pi-features
      target/ppc: Fix broadcast tlbie synchronisation
      tcg/cputlb: Remove non-synced variants of global TLB flushes
      tcg/cputlb: remove other-cpu capability from TLB flushing
      target/ppc: Move sync instructions to decodetree
      target/ppc: Fix embedded memory barriers
      target/ppc: Add ISA v3.1 variants of sync instruction
      target/ppc: larx/stcx generation need only apply DEF_MEMOP() once
      target/ppc: Remove redundant MEMOP_GET_SIZE macro
      target/ppc: Make checkstop actually stop the system
      target/ppc: improve checkstop logging
      target/ppc: Implement attn instruction on BookS 64-bit processors
      target/ppc: BookE DECAR SPR is 32-bit
      target/ppc: Add PPR32 SPR
      target/ppc: add helper to write per-LPAR SPRs
      target/ppc: Add SMT support to simple SPRs
      target/ppc: Add SMT support to PTCR SPR
      target/ppc: Implement LDBAR, TTR SPRs
      target/ppc: Implement SPRC/SPRD SPRs
      target/ppc: add SMT support to msgsnd broadcast

 accel/tcg/cputlb.c                             |  145 +--
 docs/devel/multi-thread-tcg.rst                |   13 +-
 hw/ppc/pegasos2.c                              |    3 +-
 hw/ppc/spapr.c                                 |   28 +
 include/exec/exec-all.h                        |   97 +-
 target/ppc/cpu.h                               |   64 +-
 target/ppc/cpu_init.c                          |  235 +++--
 target/ppc/excp_helper.c                       |  134 ++-
 target/ppc/fpu_helper.c                        |  235 ++---
 target/ppc/helper.h                            |   98 +-
 target/ppc/helper_regs.c                       |   40 +-
 target/ppc/insn32.decode                       |  204 ++++
 target/ppc/int_helper.c                        |   24 +-
 target/ppc/internal.h                          |   40 +-
 target/ppc/kvm.c                               |    4 +-
 target/ppc/machine.c                           |   23 +-
 target/ppc/mem_helper.c                        |   12 +-
 target/ppc/meson.build                         |    1 +
 target/ppc/misc_helper.c                       |  132 ++-
 target/ppc/mmu-book3s-v3.h                     |    4 +-
 target/ppc/mmu-booke.c                         |  531 +++++++++++
 target/ppc/mmu-booke.h                         |   17 +
 target/ppc/mmu-hash32.c                        |   60 +-
 target/ppc/mmu-hash32.h                        |   45 +
 target/ppc/mmu-hash64.c                        |   18 +-
 target/ppc/mmu-radix64.c                       |    9 +-
 target/ppc/mmu_common.c                        | 1197 ++++++------------------
 target/ppc/mmu_helper.c                        |   39 +-
 target/ppc/power8-pmu-regs.c.inc               |    5 +
 target/ppc/power8-pmu.c                        |   48 +-
 target/ppc/power8-pmu.h                        |   11 +-
 target/ppc/spr_common.h                        |    8 +
 target/ppc/translate.c                         | 1151 ++++-------------------
 target/ppc/translate/bhrb-impl.c.inc           |   43 +
 target/ppc/translate/branch-impl.c.inc         |    2 +-
 target/ppc/translate/fixedpoint-impl.c.inc     |  727 ++++++++++++++
 target/ppc/translate/fp-impl.c.inc             |  285 +++---
 target/ppc/translate/fp-ops.c.inc              |   31 -
 target/ppc/translate/misc-impl.c.inc           |  157 ++++
 target/ppc/translate/processor-ctrl-impl.c.inc |    2 +-
 target/ppc/translate/storage-ctrl-impl.c.inc   |    7 +
 target/ppc/translate/vmx-impl.c.inc            |  280 +++---
 target/ppc/translate/vmx-ops.c.inc             |   50 -
 43 files changed, 3267 insertions(+), 2992 deletions(-)
 create mode 100644 target/ppc/mmu-booke.c
 create mode 100644 target/ppc/mmu-booke.h
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc
 create mode 100644 target/ppc/translate/misc-impl.c.inc

