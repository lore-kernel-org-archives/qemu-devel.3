Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C050606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mfH72ltZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJC-0006TP-D3; Thu, 26 Nov 2026 02:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJA-0006Sp-PT; Thu, 26 Nov 2026 02:54:20 -0500
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ6-0002aD-IH; Thu, 26 Nov 2026 02:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679642; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Qn405w8Fk25gD85AWEa0clQi1Oxu/bxaWlWUiQBI7OE=;
 b=mfH72ltZ9clh4Oy0pNe8t/f/lrHKobY4szi4aDdW/6mQWVXrHZDP+XeK+mKK9xgS2Y8REavgdBBn2F8anLHJ6uSsJa2sxaAsDEYWxuI0KL18odJTw+0JGSWRhSEp+gcbm1+/wwMj33A0BqD6dM0z2iONt2gFxGEere3kxgP8zxw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGYt_1795679640; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGYt_1795679640 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:54:01 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 4/6] tests/tcg/riscv64: Check access faults during VS A/D
 updates
Date: Thu, 26 Nov 2026 15:53:48 +0800
Message-Id: <20261126075350.13022-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the nested-PTE-read test case to cover the recent A/D error propagation
fix. The initial read translation succeeds, and the failure must occur only when
VS A/D bit updating retries the G-stage translation with store access.

Implement the scenario in the following steps:

1. Setup PTEs
Clear A and D bits in the VS leaf PTE. For the G-stage PTE mapping that VS
leaf-table page, keep A set but D clear. This allows the initial G-stage load
to succeed without updating the G-stage PTE.

2. Configure PMP
Set a higher-priority PMP entry for G_L0 to Read-Only, while keeping other
physical memory accessible. Reading G-stage PTEs still works, but setting the
leaf PTE's D bit is denied.

3. Test Guest Load
Issue a guest load. Updating the VS PTE's A bit triggers a G-stage translation
retry with store access. This retry attempts to set the G-stage D bit and hits
the PMP denial. Verify that a Load Access Fault (cause 5) is raised, with mtval
holding the faulting address and mtval2 set to zero (failure code 9).

4. Test Guest Store
Repeat with a guest store. Expect a Store Access Fault (cause 7) with the same
address checks (failure code 10). This verifies that the fault cause reflects
the original guest operation, rather than the implicit PTE access.

5. Verify & Cleanup
Confirm that the G-stage leaf PTE's D bit remains clear (failure code 11).
Restore PMP permissions and both leaf PTEs to maintain valid translation
states for subsequent tests.

Without the preceding fix, the first new load reports a guest-page
fault and exits with code 9. This extension injects a PMP failure; it
does not add a separate PMA-injection case for the A/D path. All prior
read-path and genuine guest-page-fault checks remain in the test.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
AI-used-for: tests
---
 tests/tcg/riscv64/test-gstage-access-fault.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/tcg/riscv64/test-gstage-access-fault.S b/tests/tcg/riscv64/test-gstage-access-fault.S
index 61a0957270..e8ebb4b684 100644
--- a/tests/tcg/riscv64/test-gstage-access-fault.S
+++ b/tests/tcg/riscv64/test-gstage-access-fault.S
@@ -184,6 +184,24 @@ _start:
         TRY_FETCH 20, 8
         WRITE_PTE (G_L0 + 0x20), (((VS_ROOT >> 12) << 10) | 0xdf)
 
+        /*
+         * VS A/D updating re-runs G-stage with store semantics. Its leaf D
+         * update is rejected by PMP, after the initial read walk succeeded.
+         */
+        WRITE_PTE (VS_L0 + 0x20), 0x200f
+        WRITE_PTE (G_L0 + 0x30), (((VS_L0 >> 12) << 10) | 0x5f)
+        PMP_PAGE G_L0, 1
+        TRY_DATA 0, 5, 9
+        TRY_DATA 1, 7, 10
+        li t0, (G_L0 + 0x30)
+        ld t1, 0(t0)
+        andi t1, t1, 0x80
+        li a0, 11
+        bnez t1, fail
+        PMP_ALL
+        WRITE_PTE (VS_L0 + 0x20), 0x20cf
+        WRITE_PTE (G_L0 + 0x30), (((VS_L0 >> 12) << 10) | 0xdf)
+
         /* An unmapped physical G-stage root produces PMA access faults. */
         li t0, 0x8000000000090000
         csrw hgatp, t0
-- 
2.43.0


