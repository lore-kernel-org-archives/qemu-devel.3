Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D3E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MW-000764-6F; Thu, 19 Feb 2026 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MN-000743-Kg
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MH-00061X-T9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so7175135e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497247; x=1772102047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qaTErgK9yQxRPPio5zorlZ3+UnGgwNCT1aKJ9/71imk=;
 b=zefVcoWxTvopE/xboGqWrGUjCzpuoaXCjgBOGasRZjKYuLOvqwdXqETJdD4i7lgIGA
 y8k3cZt44+u3+iZ24Q9oONexstONoTA+YMiB9IBMhcuysghZiOXTf9dUSPMqqX8H5Fws
 naxh88A4iA/TIXBrn3xRLCz6PD6gF8ijVxsbkOiGyX6V+eO5kg8EJtGVAKKLeIjlJoRM
 bNRfBEu3u6622wzasWAssXA7RzrGWoFPKnzamMhiPjvc5c84xsGtTaS4znI44TF+58tz
 38SSVRkhPFFvp8FbBXNGhxwZw1FHRDbAMI5jkTxWKAmbJCPKFeRApJVKgsVZNWGYG5nm
 R3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497247; x=1772102047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qaTErgK9yQxRPPio5zorlZ3+UnGgwNCT1aKJ9/71imk=;
 b=GHsdGN8CuYyrbTJ8FrqM6kgzEKE/Hywv7sXEhFXeYqHCUkWJW6uQmeJ34EK2wflHax
 +uk1m5rze7Jq32xpmdetngdiZ2rWaq/a0+zQuMpbykchw+NF5983T51anuZhRlqKF8L+
 YGkXxB/IiihzHE2aAzUWJ+XV3RzEbf5emfleh6tBCo6y1wE1onco6qUdjDWwPv168ANw
 FbHT/u2ND24AlX3Yz//Wr6ReZ76KGUwbw0+oPWBrjbuVrspBFdaaiq23OZw3v2vcCog4
 ioMlGEPM1kK3CY400r1DO/LbNSzM7/VywTzuESLa9W0b28JZMAyKthKwoth7CI63RFh4
 BJyA==
X-Gm-Message-State: AOJu0YyACJJD3oBOMMDLLCu+boFVo4JBMU6ARpysSiJUkA7LQFjgQZW6
 uUeXAy9ETBQDXwT3pSz+ABqqeykci9CSYwAcRGjVvgnn8NO1apF91zQVUYsU7hXJPTJa6ASV0Jc
 2hbxy
X-Gm-Gg: AZuq6aIbsMpuFGckieKngFpEpK/lWqDGhvVE2/bXURyTAg+XEt+f9ar84UcqK4jl1in
 a/eQrzjh7vG/Y2GvPtzpOjTsrTXOe1OrFp8ZIGBY6E9qK4Nd+fXB9+S6X2fi39jG6isorLyOqpU
 Uk/SR1IVTdzI8xHESaB/wCWVgxDrQ/LjIDdGRHS4dI0dyF4Ps1L775cyrWvjSBM696y7pMX6q7b
 NSjZwTsLbzt+4Y/Qfl4Bo42Kj9KwpwKdd67Yjwq+skWefuVAuFp02wJ3XgEdDlLzpWKwyJ2jFfv
 0BDui/XjWKFsNtarCgxTMJw6bALguujsuP4WT/QHtpNKEymUWugXPOj6W2YtAPYI1YzKZxGTyx8
 e2qDAJqwgKz/QQHakk7EOZYEOqSNMPbdG/lj64pwQP/JBLkNfZsIFPDsriwxUzVfkp37922o+qV
 ao8nIMq0ZZ/wf8MiYzX9FnHhlfpU8yR0FPCVN29IjLjQmhQ6N0KXMXGidnT9H14VTJ9gFe/4MHW
 wWShDEmI+hLye2BLq38EYfcPH/V1D4=
X-Received: by 2002:a05:600c:190c:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-48373a59a74mr279840925e9.32.1771497247214; 
 Thu, 19 Feb 2026 02:34:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] target-arm queue
Date: Thu, 19 Feb 2026 10:33:33 +0000
Message-ID: <20260219103405.3793357-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 314f2d7fe601b8dba2a88ac4870469e9f6bb8464:

  Merge tag 'qtest-20260217-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-02-17 16:46:05 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260219

for you to fetch changes up to 10059583c7bfea50c1596310b0639669e93ce1ee:

  include/tcg/tcg-op.h: eradicate TARGET_INSN_START_EXTRA_WORDS (2026-02-19 10:12:25 +0000)

----------------------------------------------------------------
target-arm queue:
 * Allow TCG to emulate CPUs with SME but not SVE
 * Refactorings for single-binary
 * whpx: minor fixes
 * hw/usb/hcd-ohci: Implement frame number overflow event

----------------------------------------------------------------
BALATON Zoltan (1):
      hw/usb/hcd-ohci: Implement frame number overflow event

Osama Abdelkader (2):
      whpx: remove duplicate include
      whpx: fix FP register loop

Peter Maydell (17):
      target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
      target/arm: Report correct vector width in gdbstub when SME present
      target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
      target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
      target/arm: Don't let 'sme=on' downgrade SME
      target/arm: Handle SME-only CPUs in sve_vqm1_for_el_sm()
      target/arm: Handle SME-without-SVE on change of EL
      target/arm: Add aa64_sme_or_sve, aa64_sme_or_sve2 features
      target/arm/tcg: Drop unnecessary aa64_sve check from do_trans_pmull()
      target/arm/tcg: Use "or SME" feature checks where needed
      target/arm/tcg: Correct SVE/SME I8MM checks
      target/arm/tcg: Correct SVE/SME BF16 checks
      target/arm: Don't squash all ID_AA64ZFR0_EL1 fields for non-SVE
      target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not present
      target/arm: Permit configurations with SME but not SVE
      target/arm: Move TCG-specific code out of debug_helper.c
      target/arm: Don't require helper prototypes in helper.c

Pierrick Bouvier (12):
      target/arm: extract helper-mve.h from helper.h
      target/arm: extract helper-a64.h from helper.h
      target/arm: extract helper-sve.h from helper.h
      target/arm: extract helper-sme.h from helper.h
      tcg: move tcg_use_softmmu to tcg/tcg-internal.h
      target/arm: move exec/helper-* plumbery to helper.h
      target/arm/tcg/psci.c: make compilation unit common
      target/arm/tcg/cpu-v7m.c: make compilation unit common
      target/arm/tcg/vec_helper.c: make compilation unit common
      target/arm/tcg/translate.h: replace target_ulong with vaddr
      target/arm/tcg/translate.h: replace target_long with int64_t
      include/tcg/tcg-op.h: eradicate TARGET_INSN_START_EXTRA_WORDS

 docs/system/arm/cpu-features.rst                   |  20 +-
 hw/usb/hcd-ohci.c                                  |   4 +
 include/tcg/tcg-op-common.h                        |   8 +
 include/tcg/tcg-op.h                               |  29 -
 include/tcg/tcg.h                                  |   6 -
 target/alpha/cpu-param.h                           |   2 -
 target/alpha/translate.c                           |   4 +-
 target/arm/cpu-features.h                          |  27 +-
 target/arm/cpu-param.h                             |   7 -
 target/arm/cpu.c                                   |  10 -
 target/arm/cpu64.c                                 |  36 +-
 target/arm/debug_helper.c                          | 769 ------------------
 target/arm/gdbstub64.c                             |  12 +-
 target/arm/helper-a64.h                            |  14 +
 target/arm/helper-mve.h                            |  14 +
 target/arm/helper-sme.h                            |  14 +
 target/arm/helper-sve.h                            |  14 +
 target/arm/helper.c                                |  19 +-
 target/arm/helper.h                                |  17 +-
 target/arm/internals.h                             |   9 +
 target/arm/tcg/arith_helper.c                      |   4 +-
 target/arm/tcg/crypto_helper.c                     |   4 +-
 target/arm/tcg/debug.c                             | 780 ++++++++++++++++++
 target/arm/tcg/gengvec64.c                         |   3 +-
 target/arm/tcg/{helper-a64.h => helper-a64-defs.h} |   0
 target/arm/tcg/helper-a64.c                        |   6 +-
 target/arm/tcg/{helper.h => helper-defs.h}         |   0
 target/arm/tcg/{helper-mve.h => helper-mve-defs.h} |   0
 target/arm/tcg/{helper-sme.h => helper-sme-defs.h} |   0
 target/arm/tcg/{helper-sve.h => helper-sve-defs.h} |   0
 target/arm/tcg/hflags.c                            |   4 +-
 target/arm/tcg/m_helper.c                          |   2 +-
 target/arm/tcg/meson.build                         |  13 +-
 target/arm/tcg/mte_helper.c                        |   3 +-
 target/arm/tcg/mve_helper.c                        |   6 +-
 target/arm/tcg/neon_helper.c                       |   4 +-
 target/arm/tcg/op_helper.c                         |   2 +-
 target/arm/tcg/pauth_helper.c                      |   3 +-
 target/arm/tcg/psci.c                              |   4 +-
 target/arm/tcg/sme_helper.c                        |   5 +-
 target/arm/tcg/sve_helper.c                        |   6 +-
 target/arm/tcg/tlb_helper.c                        |   4 +-
 target/arm/tcg/translate-a32.h                     |   2 +-
 target/arm/tcg/translate-a64.c                     |   3 +
 target/arm/tcg/translate-mve.c                     |   1 +
 target/arm/tcg/translate-sme.c                     |   3 +
 target/arm/tcg/translate-sve.c                     | 894 +++++++++++----------
 target/arm/tcg/translate.c                         |  28 +-
 target/arm/tcg/translate.h                         |  22 +-
 target/arm/tcg/vec_helper.c                        | 224 +-----
 target/arm/tcg/vec_helper64.c                      | 142 ++++
 target/arm/tcg/vec_internal.h                      |  49 ++
 target/arm/tcg/vfp_helper.c                        |   4 +-
 target/arm/whpx/whpx-all.c                         |   5 +-
 target/avr/cpu-param.h                             |   2 -
 target/avr/translate.c                             |   2 +-
 target/hexagon/cpu-param.h                         |   2 -
 target/hexagon/translate.c                         |   2 +-
 target/hppa/cpu-param.h                            |   2 -
 target/i386/cpu-param.h                            |   2 -
 target/i386/tcg/translate.c                        |   2 +-
 target/loongarch/cpu-param.h                       |   2 -
 target/loongarch/tcg/translate.c                   |   2 +-
 target/m68k/cpu-param.h                            |   2 -
 target/m68k/translate.c                            |   2 +-
 target/microblaze/cpu-param.h                      |   2 -
 target/microblaze/translate.c                      |   2 +-
 target/mips/cpu-param.h                            |   2 -
 target/or1k/cpu-param.h                            |   2 -
 target/or1k/translate.c                            |   2 +-
 target/ppc/cpu-param.h                             |   2 -
 target/ppc/translate.c                             |   2 +-
 target/riscv/cpu-param.h                           |   7 -
 target/rx/cpu-param.h                              |   2 -
 target/rx/translate.c                              |   2 +-
 target/s390x/cpu-param.h                           |   2 -
 target/sh4/cpu-param.h                             |   2 -
 target/sh4/translate.c                             |   4 +-
 target/sparc/cpu-param.h                           |   2 -
 target/sparc/translate.c                           |   2 +-
 target/tricore/cpu-param.h                         |   2 -
 target/tricore/translate.c                         |   2 +-
 target/xtensa/cpu-param.h                          |   2 -
 target/xtensa/translate.c                          |   2 +-
 tcg/tcg-internal.h                                 |   6 +
 tcg/tcg.c                                          |   4 -
 86 files changed, 1722 insertions(+), 1620 deletions(-)
 create mode 100644 target/arm/helper-a64.h
 create mode 100644 target/arm/helper-mve.h
 create mode 100644 target/arm/helper-sme.h
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/tcg/debug.c
 rename target/arm/tcg/{helper-a64.h => helper-a64-defs.h} (100%)
 rename target/arm/tcg/{helper.h => helper-defs.h} (100%)
 rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)
 rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)
 rename target/arm/tcg/{helper-sve.h => helper-sve-defs.h} (100%)
 create mode 100644 target/arm/tcg/vec_helper64.c

