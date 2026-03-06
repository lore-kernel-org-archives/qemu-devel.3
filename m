Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31714F01801
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPi0-0007z0-MQ; Fri, 06 Mar 2026 02:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vyPhz-0007vg-1v; Fri, 06 Mar 2026 02:34:51 -0500
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vyPhw-0002QH-Ku; Fri, 06 Mar 2026 02:34:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3EAD526447;
 Fri,  6 Mar 2026 08:34:46 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6rO1hXGytYB; Fri,  6 Mar 2026 08:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1772782485; bh=XmZ7/154VFTzjLQ1DyxCJuA8xT/l7bvvRyaToNtGsko=;
 h=From:To:Cc:Subject:Date;
 b=harblPYrng9WP/Vpe4teDc4Qh08nIupRRASW5ONZy/yttR6dybyPlmsZObmvtbqaU
 Uic97VBBmMVGdr9WsxJ2e8WQJaOjIAXuu/PjYrJJSBgb+IZpqAgv4uOFjl2Etn6vfo
 JQIyYFo+BY2fmHbwDYUUCOwVYElQ4c3wj74wMyb8thvYF8TLAYLIFDu8/MIoqtzxqs
 cZilZpGiBJjn33JFSthEbFq6oxv9dYh3puQaKXL9Z0HxodWtoHhJdl6LS7LP/PaZTR
 7nUiaMb6Mw0mIV9bvEA9ELRmhWKurwa15Nu0Kw/dGQTwGjJ5ndEwEFVsDRB9TueviO
 3aPqWdz+oI0yw==
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, qemu-stable@nongnu.org,
 rail5 <andrew@rail5.org>
Subject: [PATCH v2 0/2] target/loongarch: Fix NX enforcement for PTW helpers
Date: Fri,  6 Mar 2026 15:33:35 +0800
Message-ID: <20260306073355.899858-1-andrew@rail5.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=andrew@rail5.org;
 helo=layka.disroot.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  "Andrew S. Rightenburg" <andrew@rail5.org>
From:  "Andrew S. Rightenburg" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: rail5 <andrew@rail5.org>

Thanks to Bibo Mao <maobibo@loongson.cn> for the quick review and feedback
on the original patch.

The LoongArch ISA defines NX at bit 62 in the page table entry. Under TCG,
NX is checked during translation, but the software page-walk helper (LDPTE)
was masking the whole PTE value with the PALEN mask. This clears upper
permission bits (including NX), allowing execution from NX mappings.

Fix this by masking only the PPN/address field and preserving permission bits,
while also clearing any non-architectural (software) bits via a hardware PTE
mask.

Once NX is enforced, instruction fetches from NX pages correctly raise PNX,
but taking PNX could end up looping because loongarch_cpu_do_interrupt() tried
to fetch the faulting instruction to populate CSR_BADI, which faults with PNX
again. Treat PNX like other instruction-fetch exceptions and skip the CSR_BADI
fetch.

Reported at: https://gitlab.com/qemu-project/qemu/-/issues/3319

Tested with a Linux guest by mapping a page RW, writing a single instruction,
mprotect(PROT_READ) (no exec) and then calling through a function pointer.
With this series applied the guest receives SIGSEGV instead of executing or
hanging.

Changes in v2:
- Patch 1: Touch only helper_ldpte() (leave LDDIR returning a PALEN-masked base addr)
- Patch 1: Drop hard-coded PPN width (use R_TLBENTRY_{32,64}_PPN_MASK)
- Patch 1: Clear software/non-architectural PTE bits via env->hw_pte_mask
- Patch 2: Carry Reviewed-by: Bibo Mao <maobibo@loongson.cn>

rail5 (2):
  target/loongarch: Preserve PTE permission bits in LDPTE
  target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch

 target/loongarch/cpu.c            | 11 +++++++++++
 target/loongarch/cpu.h            |  1 +
 target/loongarch/tcg/tcg_cpu.c    |  2 +-
 target/loongarch/tcg/tlb_helper.c | 25 ++++++++++++++++++++++---
 4 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.47.3


