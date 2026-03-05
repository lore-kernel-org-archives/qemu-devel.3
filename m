Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FF6F33A7C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyACQ-0000fa-BR; Thu, 05 Mar 2026 10:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>) id 1vy99v-000135-Pr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:54:35 -0500
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>) id 1vy99u-0006RD-5q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:54:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 24F5B2645F;
 Thu,  5 Mar 2026 14:54:31 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkTe_veWeVpA; Thu,  5 Mar 2026 14:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1772718870; bh=YEVah3PfDnV1JkjLPdl+KJvmOJxeqVGwhX8Mdb1eLUY=;
 h=From:To:Cc:Subject:Date;
 b=Cg+I6UYKULOvIW+kv5rdWI8ujeYz/GihA/aI+bp+wiIfpJNqsApcsRFzGEhZDl7Cm
 sPt0ISLcTWphJKfE0J1GvKrd5S10LcPRdRrvPCc28OEGyE9AoOCVZJ6oh6jJL4inNX
 K1qJYvdxC2Ub+dOVputVkKKA7lYOquaHDHg3Z7qmrjD4g4C1EGGvNY5LIovfmVxp+3
 F0gFmqRmSmYoFF9RwjvkT45V+R5NfHopVBElAay7DdLbOKU+clx35vUWFB4NSaqlIZ
 mEE147qMii7RbMbBooc0S72dwpPMKHlC1R63JIFlhDVZKzN1Z5B7PiNWQXmP4Irr9S
 QwwNuDb0xNyQA==
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	rail5 <andrew@rail5.org>
Subject: [PATCH 0/2] target/loongarch: Fix NX enforcement for PTW helpers
Date: Thu,  5 Mar 2026 21:53:59 +0800
Message-ID: <20260305135403.831693-1-andrew@rail5.org>
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
X-Mailman-Approved-At: Thu, 05 Mar 2026 10:00:44 -0500
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

The LoongArch ISA defines NX at bit 62 in the page table entry. Under TCG,
NX is checked during translation, but the software page-walk helpers (LDDIR /
LDPTE) were masking the whole PTE value with the PALEN mask. This clears
upper permission bits (including NX), allowing execution from NX mappings.

Fix this by masking only the PPN/address field and preserving permission bits.

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

rail5 (2):
  target/loongarch: Preserve PTE permission bits in LDDIR/LDPTE
  target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch

 target/loongarch/tcg/tcg_cpu.c    |  2 +-
 target/loongarch/tcg/tlb_helper.c | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.47.3


