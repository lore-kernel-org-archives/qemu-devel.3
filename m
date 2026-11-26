Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B4606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Npq3Ay/p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJE-0006WC-Hb; Thu, 26 Nov 2026 02:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJC-0006Tm-FS; Thu, 26 Nov 2026 02:54:22 -0500
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002aa-BU; Thu, 26 Nov 2026 02:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679642; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=vYCedF9JL7Fe+P0lctusPYrpB5YtEkyEfMNwiYrUvuc=;
 b=Npq3Ay/pB2UhDRGEf2EWd2atETk5WuitRJIg4utWVKCqQnkqrSgBnef7grWYqKPyiLK2k7f5JaFrR0IgKY/+jMLuOuYIu57l4oGh8+shZ9ga7BIIUIMygzLDv+K8APVnv3qtLSjABVyyRFoM3UjS49jIxcXIgCMefr+jQVuw3vE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGZF_1795679641; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGZF_1795679641 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:54:01 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 5/6] target/riscv: Keep the guest fault address zero for
 G-stage PMA errors
Date: Thu, 26 Nov 2026 15:53:49 +0800
Message-Id: <20261126075350.13022-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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

In the direct G-stage path, a failed physical PTE read returns
TRANSLATE_PMA_FAIL. TLB fill already classifies it as an access fault.
However, the code that fills guest_phys_fault_addr excludes only
TRANSLATE_PMP_FAIL. It therefore records a guest-physical address for
a PMA access fault. The trap receives the right cause but an incorrect
nonzero htval or mtval2, suggesting a guest-page-fault address.

Commit 8e090ecfa9e5 ("target/riscv/cpu_helper.c: add PMA access fault")
added the PMA result and access-fault classification. The direct
G-stage fault-address condition was not updated to match it.

Use is_physical_access_fault() in that condition so PMP and PMA errors
both skip the guest address assignment. TLB fill clears the field on
entry, so skipping the assignment leaves it zero through trap delivery.
Real G-stage translation failures still record their guest address.
The PMA detection rules and access-fault cause selection do not change.

The next commit tests this branch with VS-stage translation set to Bare
and an inaccessible G-stage root. This bypasses the recursive VS PTE
paths and isolates the fault-address problem from the earlier fixes.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/tcg/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 548879ee6a..0755582402 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1854,7 +1854,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                  * level exception
                  */
                 first_stage_error = false;
-                if (ret != TRANSLATE_PMP_FAIL) {
+                if (!is_physical_access_fault(ret)) {
                     env->guest_phys_fault_addr = (im_address |
                                                   (address &
                                                    (TARGET_PAGE_SIZE - 1))) >> 2;
-- 
2.43.0


