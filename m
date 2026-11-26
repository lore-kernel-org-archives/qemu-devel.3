Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262F606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MkSC31Mr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJG-0006ZI-TY; Thu, 26 Nov 2026 02:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJE-0006VL-3m; Thu, 26 Nov 2026 02:54:24 -0500
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002Y3-Ff; Thu, 26 Nov 2026 02:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679639; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=6pNvz7x1u8pQoZrpE2TOiP6mSp9NgqA10X8VgRReMYY=;
 b=MkSC31MrSjNHZ+hd/eOJuouvQEuH9gd1nujDMjpn8hr4uXceVkEQXq5F4vUipRvqG3BOTz3u+DZ9Fm2exHAcWU433rYb3oKw/dsP6w9boLZd4ehrTwwdDoyvqCGqnb5mIYAu5XAk64CgAxlZ2WcHZQDaT+nNpjIsaInTjWMUWDA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGYV_1795679638; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGYV_1795679638 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:53:59 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/6] target/riscv: Preserve access faults while translating VS
 PTE reads
Date: Thu, 26 Nov 2026 15:53:45 +0800
Message-Id: <20261126075350.13022-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
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

With the H extension, the VS page-table walker calls G-stage translation
to obtain the physical address of each VS PTE. A physical access to a
G-stage PTE can fail because PMP rejects it or the memory access returns
a PMA error. The caller(get_physical_address) turns this failure into
TRANSLATE_G_STAGE_FAIL and records the VS PTE's guest-physical address.
This loses the physical access error. The original instruction fetch,
load or store then raises a guest-page fault, with misleading fault
address information, instead of its corresponding access fault.

Commit 8e090ecfa9e5 ("target/riscv/cpu_helper.c: add PMA access fault")
introduced TRANSLATE_PMA_FAIL for failed physical PTE reads. That PMA
failure result, like the existing PMP failure result, is still lost at
this call site.

Add is_physical_access_fault() to recognize both results. Return either
error unchanged from the recursive VS-PTE read translation before setting
fault_pte_addr. Reuse the helper in the existing TLB-fill classification.
The preserved result sets pmp_pma_violation, so the existing exception
code reports an access fault for the original access type. The guest
physical fault address remains zero. Other translation failures still
use TRANSLATE_G_STAGE_FAIL and retain their guest-page-fault behavior.

The next commit adds a regression for this read path. A/D update
translation and direct G-stage fault-address handling are addressed by
later commits, each with its own regression extension.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/tcg/cpu_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..90a3731214 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1069,6 +1069,11 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
     return !high_bit;
 }
 
+static bool is_physical_access_fault(int ret)
+{
+    return ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL;
+}
+
 /*
  * get_physical_address - get the physical address for this virtual address
  *
@@ -1257,6 +1262,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                                  is_debug, false);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
+                if (is_physical_access_fault(vbase_ret)) {
+                    return vbase_ret;
+                }
                 if (fault_pte_addr) {
                     *fault_pte_addr = (base + idx * ptesize) >> 2;
                 }
@@ -1875,7 +1883,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
+    if (is_physical_access_fault(ret)) {
         pmp_pma_violation = true;
     }
 
-- 
2.43.0


