Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4430CCD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 13:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqCYG-0007TN-10; Fri, 29 Mar 2024 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rqCYD-0007S6-IJ; Fri, 29 Mar 2024 09:45:46 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rqCYB-000448-PB; Fri, 29 Mar 2024 09:45:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 452CEC0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711719936;
 bh=24Hng9VXJ0njl4818EF1rbSl5XhF0Y9Qr9hcIhgmEZE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ggiSImtpsMv0wnuwXIVQQyDjNEaHaon9X/SYJC3fZewZEOVIj7RNxH0iI54nroJxC
 tCG3jbG+njJB3ZGbOzYGt9zjz2pdbTPvDoKuIoFXyKlOwC8k9106l1C3U0kob/f/NF
 gzV8IQ18D+yZwpvpywEtp3qrgihq7Ohj4qsVZE4AXtYCK4/gWU+9WuLNZnCCKtvCj2
 ghVPOdcPwqU0bPH2w9pT1T8q6n2xLN3FDCX5UfNpBxCjhMBrN0DF9aB5S1uIcTm+xq
 mX5WYKhDJADw+b3mNCE/ROObOgutmuMvqkQixVQa+eN/PLRNJVvOJ2biXsgwMi/ArX
 dqp6MNPTiojDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711719936;
 bh=24Hng9VXJ0njl4818EF1rbSl5XhF0Y9Qr9hcIhgmEZE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=CFPMXEJTBiEPkyY7aIIVxVgkeUAIFAWaHp96zfCmqNtEkErI4sXpuuKf7PIOxMOo9
 ZaXPpvmiSDcxigCiUnaZmN7TMeITrUVcatGxtp/G5Yaw+AWb1oDK6TzTPtAHonYpWx
 COvtN/aKW3y1sJc8u/Gk8M3bcvMJ81qgPA5UtV9snfAWl3ITTTUThxicFdazrWhmBP
 Ap0ZFhSuFw2dMlOZikmF0gXCEpbzJHWg22DUGwjko+YkKQJkYWpgLAC3eCFq2vdsUd
 rIKHezkhVtV1vgVFecXIDQnD47oJbMxo5GfKfypMBP+Ks9xrwzidy8mbcaeUBBrTP3
 uNAFj/SplxOmA==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
CC: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Alexei Filippov
 <alexei.filippov@syntacore.com>
Subject: [PATCH] target/riscv/cpu_helper.c: fix wrong exception raise
Date: Fri, 29 Mar 2024 16:45:27 +0300
Message-ID: <20240329134527.1570936-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Successed two stage translation, but failed pmp check can cause guest
page fault instead of regular page fault.

In case of execution ld instuction in VS mode we can
face situation when two stages of translation was passed successfully,
and if PMP check was failed first_stage_error variable going to be
setted to false and raise_mmu_exception will raise
RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT(scause == 21) instead of
RISCV_EXCP_LOAD_ACCESS_FAULT(scause == 5) and this is wrong, according
to RISCV privileged spec sect. 3.7: Attempting to execute a load or
load-reserved instruction which accesses a physical address within a
PMP region without read permissions raises a load access-fault
exception.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
---
 target/riscv/cpu_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bc70ab5abc..eaef1c2c62 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1408,9 +1408,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
-            }
-
-            if (ret != TRANSLATE_SUCCESS) {
+            } else {
                 /*
                  * Guest physical address translation failed, this is a HS
                  * level exception
-- 
2.34.1


