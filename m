Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF7CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 08:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stk2h-0001zM-SD; Thu, 26 Sep 2024 04:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1stk2g-0001xr-DX; Thu, 26 Sep 2024 04:40:06 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1stk2e-0004OH-KH; Thu, 26 Sep 2024 04:40:06 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5DA12C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1727339997;
 bh=v06OyEokpOs4ZV+K6KA2XIy905nLsPkN/5l90UL+GZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=C05xnINnF7l/O7RNPha17uruJ1lciNC6Sp1KkdU7OJOawWoOSORpjN9G8EuRZ6adl
 zlc18LLDRfKOTGVbW1fm0HCbj5L22D1drw1D8er0Kbnu0HiDxHqC3jJkPSOAxwzBS1
 Sq/IssieXA7vazHoaF/44b7WM71AF67wEhb4Qe0R4MRry7RZGjlRRaRfh462XWIdgJ
 Gixrrb2HpLvYCBxyzpCzH9wyxuevOtiNTXFRl/NzFvGMiQQa4VLPuvRuNANwjTfkzr
 9tV9S8h8XBPQ+ih90yCE5kf8+fEpN+yeVxikxh89ffMdXcijkcgDW/8BfkLqK2UNyM
 1euIQ8FMNzeWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1727339997;
 bh=v06OyEokpOs4ZV+K6KA2XIy905nLsPkN/5l90UL+GZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HdgxGpGyX5TO6pAp5yK8TCXAwWldQeyHy4S3lc90q376Aa9Y3JW3/Z10I+iQtqUiK
 e3GJgfLPgx/GsIe1OWX1lU8IV5cW7Bk+mEjwSjr5e0bDXaQ74Z07Z5GpbV3R3u1mgy
 dXjGVEiE6pZJZ45ta3mjaly0z/xJWnlfqJTgf+ufF0h2N+9mLLTqJ7JwqyM1W7Rh9/
 IpnQi1lxCA5Z4hcbMT9SsLBGcj5eEuK8XC6MgvsL/bGNWWustszGvSprYQfxnZGtvc
 bm35O7cqBhSni3MpoBVkGgPFlWScU1XEX1fw3odVBoxlbGCSVV3ZrvS3skx82IFLo8
 2GJU6Tsqq/6Xw==
From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
To: <dbarboza@ventanamicro.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <evgenii.prokopiev@syntacore.com>, <liwei1518@gmail.com>,
 <palmer@dabbelt.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv/csr.c: Fix an access to VXSAT
Date: Thu, 26 Sep 2024 11:39:44 +0300
Message-ID: <20240926083944.15807-1-evgenii.prokopiev@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <70658cf5-4a72-4b83-8390-cb0a3506e6eb@ventanamicro.com>
References: <70658cf5-4a72-4b83-8390-cb0a3506e6eb@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=evgenii.prokopiev@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The register VXSAT should be RW only to the first bit.
The remaining bits should be 0.

The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture

The vxsat CSR has a single read-write least-significant bit (vxsat[0])
that indicates if a fixed-point instruction has had to saturate an output
value to fit into a destination format. Bits vxsat[XLEN-1:1]
should be written as zeros.

Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
Changes since v1: 
	- Added reviewed-by tag
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bd080f92b5..69c41212e9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 static RISCVException read_vxsat(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->vxsat;
+    *val = env->vxsat & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
@@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxsat = val;
+    env->vxsat = val & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.34.1


