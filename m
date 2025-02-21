Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01EAC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTYf-0006k3-Ch; Fri, 21 Feb 2025 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tlTYY-0006jo-CX; Fri, 21 Feb 2025 08:59:06 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tlTYW-00013O-NS; Fri, 21 Feb 2025 08:59:06 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id E97ADB41C42;
 Fri, 21 Feb 2025 16:59:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=4F4yut7amosbTMiXVBxXO8HTIfqIXZeWipAoczI8bec=; b=
 fv0yj5r3/oNI87sIQ1PiJd2N3kGiX8/OoPf69e/qM4wEo09FOfShmDGgV7VJ8qDl
 xPL57pWfpu9se1d9hNpWH2dN39Z2iRHzxZufpMQYD3JJ5W5p9rFC8JQVW20Dlo7W
 AWHP66yKgl7lsS7MiQFcRKPyRMVF99A+PX8Di03Gu4hmflMQIiemnhmqEe1kus8M
 ETIZ68v5gtdleRk/vp9p4G86obYp4RkQgbTwvBkpFTXDkgCCFOn+YQSm22IKvhk8
 OiWkbX5VIe2354msdlqJge2/sYnbfYEYoiapcTCx49iz14yabCojcB8i1IUQQgNj
 NWdiZc36zLNz+66uJ/YAyA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id D3189B41BEB;
 Fri, 21 Feb 2025 16:59:01 +0300 (MSK)
Received: from visaev-hp.corp.yadro.com (10.178.157.106) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 16:58:27 +0300
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PATCH v2] target/riscv: fix C extension disabling on misa write
Date: Fri, 21 Feb 2025 16:57:27 +0300
Message-ID: <20250221135735.85151-1-vladimir.isaev@syntacore.com>
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

So we should suppress write to misa without "C" if it is enabled
and the subsequent instruction is not aligned to 4.

Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
v2:
- use env->pc instead of GETPC() since GETPC() is a host pc;
- use !QEMU_IS_ALIGNED(env->pc, 4) instead of GETPC() & 3;

---
 target/riscv/csr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f0780..8aa77c53a0db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2067,11 +2067,13 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     val &= env->misa_ext_mask;
 
     /*
-     * Suppress 'C' if next instruction is not aligned
-     * TODO: this should check next_pc
+     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
+     * is not 32-bit aligned, write to misa is suppressed.
+     *
+     * All csr-related instructions are 4-byte, so we can check current pc alignment.
      */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
-        val &= ~RVC;
+    if (!(val & RVC) && (env->misa_ext & RVC) && !QEMU_IS_ALIGNED(env->pc, 4)) {
+        return RISCV_EXCP_NONE;
     }
 
     /* Disable RVG if any of its dependencies are disabled */
-- 
2.47.2



