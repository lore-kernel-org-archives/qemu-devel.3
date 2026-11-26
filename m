Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Oyb6gVws
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJE-0006Wi-TC; Thu, 26 Nov 2026 02:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJD-0006U4-09; Thu, 26 Nov 2026 02:54:23 -0500
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002aC-O9; Thu, 26 Nov 2026 02:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679641; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YB7zpQZ5dthJk1KtAbItcRut6aFLG1DUMiC1rMDzGR8=;
 b=Oyb6gVwsDlYkVJ5dV2kI3WukLMDlurKxY0gTdIHB4tc06le/mYJvLLoUUHAeX5GkAdUdzxdo6WhwHy/nEcpzd0NGIQOLJrbbUI6x2Y+N37FxFLecMDmKpYrPCUfLJLzwToq+N6vkdfnTk0gLEBFBKmx2jqUM/h+GkYkKr9nipvM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGYj_1795679640; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGYj_1795679640 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:54:00 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 3/6] target/riscv: Preserve access faults during VS PTE A/D
 translation
Date: Thu, 26 Nov 2026 15:53:47 +0800
Message-Id: <20261126075350.13022-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Updating a VS PTE's A/D bits requires G-stage translation of that PTE's
guest-physical address with store access. This translation can itself
need to set a G-stage PTE's D bit. A PMP denial of that physical write
returns TRANSLATE_PMP_FAIL, but the VS walker replaces the result with
TRANSLATE_G_STAGE_FAIL and records the VS PTE guest-physical address.
The original access then reports a guest-page fault even though the
mapping is valid and a physical page-table access was rejected. A PMA
error returned by this recursive call is lost in the same way.

Apply the physical-access-fault helper to the A/D translation result.
Return PMP and PMA failures before setting fault_pte_addr, as in the
VS PTE read path. Keeping the result lets the existing exception code
select the access fault for the original operation. For example, a load
whose implicit A/D update fails must still raise a load access fault,
even though the recursive translation used store access. The guest
physical fault address stays zero for this physical access error.

Leave other G-stage failures on the existing guest-page-fault path.
This changes error propagation, not the conditions for updating A/D
bits or the atomic PTE write. The next commit extends the regression
with a PMP-denied G-stage D-bit update after a successful read walk.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/tcg/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 90a3731214..548879ee6a 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1549,6 +1549,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                                MMUIdx_U, false, true,
                                                is_debug, false);
             if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (is_physical_access_fault(gpa_ret)) {
+                    return gpa_ret;
+                }
                 if (fault_pte_addr) {
                     *fault_pte_addr = pte_gpa >> 2;
                 }
-- 
2.43.0


