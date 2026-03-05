Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A14F33A7E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAC6-0000dM-Rk; Thu, 05 Mar 2026 10:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vy9A8-0001BK-M2; Thu, 05 Mar 2026 08:54:48 -0500
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vy9A5-0006SA-6E; Thu, 05 Mar 2026 08:54:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DB3F326725;
 Thu,  5 Mar 2026 14:54:42 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gh6nMdHzNRJU; Thu,  5 Mar 2026 14:54:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1772718882; bh=WwfOneAe8RDQufBkwItCP4ioTxf/nPiXhHa+gBL/Lv8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NeHFu4Unr4pug8E2RS1o9l0MmKVm52tMCB76esVPXWmhpzn5+IQQQnDkA3qNw9udG
 hpbgzhTj5i3J/fyz6G86Ax8/55IlhMKI6MvJgHEjJKZMfOwaKHX3O8MTpJkru2Pzoj
 9DNo+cchsLGcWg8wYA0XEc3nGH7T3CQsltjBorqTFbGPmAXiq0mNSR80pUe9RS4/Iy
 5EANCnBHWPjMh5HgrQPaXa6UevcfVJROnUsjI3+WYcvbBO6gi7o5CGhb6M9+IvOE3F
 diLy1ogp6p1Dk+8jbX4eeuQiROjo2r2/+9i6xq2pbaEs867l3MvUBwKTskwNzyn1P/
 O1T3c+6atlSww==
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	rail5 <andrew@rail5.org>,
	qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/loongarch: Avoid recursive PNX exception on
 CSR_BADI fetch
Date: Thu,  5 Mar 2026 21:54:01 +0800
Message-ID: <20260305135403.831693-3-andrew@rail5.org>
In-Reply-To: <20260305135403.831693-1-andrew@rail5.org>
References: <20260305135403.831693-1-andrew@rail5.org>
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
X-Mailman-Approved-At: Thu, 05 Mar 2026 10:00:48 -0500
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

loongarch_cpu_do_interrupt() updates CSR_BADI by fetching the faulting
instruction with cpu_ldl_code_mmu().

For a PNX exception (instruction fetch prohibited by NX), fetching the
instruction at env->pc will fault with PNX again. This can lead to an
infinite exception loop.

Treat PNX like other instruction-fetch exceptions (PIF/ADEF) and do not
update CSR_BADI for it.

Fixes: 410dfbf620a ("target/loongarch: Move TCG specified functions to tcg_cpu.c")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
---
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index af92277669..31d3db6e8e 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -109,6 +109,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
+    case EXCCODE_PNX:
     case EXCCODE_ADEF:
         cause = cs->exception_index;
         update_badinstr = 0;
@@ -129,7 +130,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
-    case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause = cs->exception_index;
         break;
-- 
2.47.3


