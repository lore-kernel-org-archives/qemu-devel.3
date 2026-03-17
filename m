Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD05EFEDA1C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSP-00046a-9i; Tue, 17 Mar 2026 15:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSN-00046D-RW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:52:00 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSM-0006Rg-CM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C03AB6132E;
 Tue, 17 Mar 2026 19:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65736C2BC86;
 Tue, 17 Mar 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777117;
 bh=FLrAsBWJ3Lntbh4BRVoONkkoJVDgEccjWA/1sJEobgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tPzpBPl+Qk1KRV/W3MRhz7nqgtpEoEkL5bMFOOmts4v9xC6Hm+lHuruD1eDF+1qsp
 0RUz+4XYHb3Kq3mYdrPwdnKXD74arTA4ZzJW0i2ETiU1tpeWgJq6ek1JRPK36so1ku
 BdP2hnXf5tdivghHU0rxp2PiK05K/YqYFj2d4Od3kDZa5K+zqJNFIwNLatyeTLbTYO
 GUDQgBLcZmtPMSYAUih4KCGLFiL38igA230Gue9FFyzvFeM+BjCHxFNHBlQIphwc0l
 fzL/hGF17LkjR7KnMuG6e6s3wZ7hhpb6R72YlLrw17V0au121XzGFNurAtnYsLo0sv
 oJxPIdIiTCEYg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 3/6] target/hppa: Always map 64-bit firmware at
 0xfffffff0f0000000
Date: Tue, 17 Mar 2026 20:51:46 +0100
Message-ID: <20260317195149.8386-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317195149.8386-1-deller@kernel.org>
References: <20260317195149.8386-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

I checked on a physical A500, C3700 and C8000 machine and all load their
64-bit PDC (Firmware) at 0xfffffff0f0000000, independed if the CPU uses
40 or 44 physical address bits.
For qemu we will do the same and load the 64-bit SeaBIOS-hppa at the
same address for our emulated machines.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/mem_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a4b382069d..ffbad8acfd 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -27,6 +27,7 @@
 #include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
+#include "hw/hppa/hppa_hardware.h"
 #include "trace.h"
 
 hwaddr hppa_abs_to_phys_pa1x(uint8_t phys_addr_bits, vaddr addr)
@@ -66,12 +67,13 @@ hwaddr hppa_abs_to_phys_pa2_w0(uint8_t phys_addr_bits, vaddr addr)
         /*
          * PDC address space:
          * Figures H-10 and H-11 of the parisc2.0 spec do not specify
-         * where to map into the 64-bit PDC address space.
-         * We map with an offset which equals the 32-bit address, which
-         * is what can be seen on physical machines too.
+         * where to map into the 64-bit PDC address space, but verification
+         * on physical A500, C3700 and C8000 machines show that PDC is always
+         * mapped at 0xfffffff0f0000000, independed if the CPU has 40 or 44
+         * physical bits.
          */
         addr = (uint32_t)addr;
-        addr |= -1ull << (phys_addr_bits - 4);
+        addr |= ((uint64_t) FIRMWARE_HIGH) << 32;
     }
     return addr;
 }
-- 
2.53.0


