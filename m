Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L3vZ7szU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJE-0006Uo-0S; Thu, 26 Nov 2026 02:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJC-0006Tk-EQ; Thu, 26 Nov 2026 02:54:22 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002d0-FE; Thu, 26 Nov 2026 02:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679643; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=D2A8UaPCHWKKyi8URUDzAN7fmTLjtcYvtIq1z7D4N04=;
 b=L3vZ7szUv+1kC/jd8PXfc5MNpC7UDRp/N8Z3Y3SVgL13t3Q7H+Mtjcr1edT08+oNy16UKQ3SwBXPhClYnuU0Wu1kHshkM8Oae1bx+6Lk5L/UBrdJK4VyJ6q8XbAyxS7qsztYgttYZ6tYpQ68zdoZmoSD/2Pds02e0UN/9pyymss=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGZk_1795679642; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGZk_1795679642 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:54:02 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 6/6] tests/tcg/riscv64: Check PMA fault metadata with VS-stage
 Bare
Date: Thu, 26 Nov 2026 15:53:50 +0800
Message-Id: <20261126075350.13022-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

Extend the existing H-extension regression to cover the preceding
direct G-stage fault-address fix. The nested read tests already use an
unmapped physical G-stage root. Disabling VS translation while that
root remains selected reaches the direct G-stage error path without
first reading a VS PTE.

Implement the case in these steps:

1. Reuse the unmapped G-stage root at physical address 0x90000000 left
   by the preceding PMA read cases. Set vsatp to zero to select Bare.
   Keep the common trap handler and guest access helpers unchanged.
2. Load from virtual address 0x4000 with MPRV/MPV. The Bare first stage
   passes that address directly to G-stage. Reading its inaccessible
   root PTE returns a PMA failure.
3. Use CHECK to require load access fault 5, mtval equal to 0x4000 and
   mtval2 zero. Use failure code 15 for this case. Before the fix, the
   cause is already 5, but mtval2 is incorrectly 0x1000 (0x4000 >> 2),
   so the new case detects the metadata error specifically.
4. Restore VS Sv39 and the valid G-stage root. Confirm that the final
   normal load succeeds and return zero through semihosting. Retain all
   earlier nested-read, A/D-update and guest-page-fault checks.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
AI-used-for: tests
---
 tests/tcg/riscv64/test-gstage-access-fault.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/tcg/riscv64/test-gstage-access-fault.S b/tests/tcg/riscv64/test-gstage-access-fault.S
index e8ebb4b684..28d425808c 100644
--- a/tests/tcg/riscv64/test-gstage-access-fault.S
+++ b/tests/tcg/riscv64/test-gstage-access-fault.S
@@ -209,6 +209,10 @@ _start:
         TRY_DATA 1, 7, 13
         TRY_FETCH 1, 14
 
+        /* Also check PMA failure during the non-recursive G-stage path. */
+        csrw vsatp, zero
+        TRY_DATA 0, 5, 15
+
         li t0, 0x8000000000000004
         csrw vsatp, t0
         li t0, (0x8000000000000000 | (G_ROOT >> 12))
-- 
2.43.0


