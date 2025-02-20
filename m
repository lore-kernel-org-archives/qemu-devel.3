Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCE1C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9UZ-0007zV-8V; Thu, 20 Feb 2025 11:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tl9UW-0007z3-Tu; Thu, 20 Feb 2025 11:33:36 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tl9UV-0003Jx-3R; Thu, 20 Feb 2025 11:33:36 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id 33541B41D24;
 Thu, 20 Feb 2025 19:33:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=MP/Ql4cMTAcOIblJqaaiOC3B/QKkzbLOphZ87OJWZfE=; b=
 YUI8AcWWAFDJ0qfB9M+Dp3BkvGygermVPUTEAcP1rEVDnec+JkyDGx7paZG4Th+E
 HV/7MBzv0TaJa9u3+Y66066SlzlgXblFBnuJxGwURg6CVX82MuRLkDDc7okLyNvo
 5coL6H/6BJvuF0muVqzDrzrPltIOJkyXZhyar3yS3Tcyv7RNdAjLerehyT+NX8h0
 +PllINPRowXfaAbwZcvV9i8NJTLDeIz5G9kjPSXfOZnP8mwqBacRdT/9x8os5dp/
 DwUoqZXidLBqyQM/V7VQx0dizxIpNmmkqHrlgYr+Uv9kmky4KIHaA1ZpC4yU+ak1
 KEOs48LwfRM4XBkJ3YLaMA==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id 16908B41C7A;
 Thu, 20 Feb 2025 19:33:23 +0300 (MSK)
Received: from visaev-hp.corp.yadro.com (10.178.157.106) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 19:31:54 +0300
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <mjc@sifive.com>, Vladimir Isaev
 <vladimir.isaev@syntacore.com>
Subject: [PATCH] target/riscv: fix C extension disabling on misa write
Date: Thu, 20 Feb 2025 19:31:14 +0300
Message-ID: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.178.157.106]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=vladimir.isaev@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to spec:
Writing misa may increase IALIGN, e.g., by disabling the "C" extension. If an instruction that would
write misa increases IALIGN, and the subsequent instruction’s address is not IALIGN-bit aligned, the
write to misa is suppressed, leaving misa unchanged.

So we should suppress disabling "C" if it is already enabled and
next instruction is not aligned to 4.

Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 target/riscv/csr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f0780..32f9b7b16f6f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2067,11 +2067,12 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     val &= env->misa_ext_mask;
 
     /*
-     * Suppress 'C' if next instruction is not aligned
+     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
+     * is not 32-bit aligned, write to misa is suppressed.
      * TODO: this should check next_pc
      */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
-        val &= ~RVC;
+    if (!(val & RVC) && (env->misa_ext & RVC) && (GETPC() & 0x3)) {
+        return RISCV_EXCP_NONE;
     }
 
     /* Disable RVG if any of its dependencies are disabled */
-- 
2.47.2



