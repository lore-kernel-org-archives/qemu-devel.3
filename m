Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F279C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rda4p-0002FP-0A; Fri, 23 Feb 2024 13:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rdZrI-0001G9-Nd
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:01:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rdZrD-0007cr-Qw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:01:16 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThHl648vyz6K5ly;
 Sat, 24 Feb 2024 01:56:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D80614153B;
 Sat, 24 Feb 2024 02:01:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:01:00 +0000
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries in
 MMIO during PTW.
Date: Fri, 23 Feb 2024 18:01:02 +0000
Message-ID: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Seen testing of CXL emulation on arm64 (currently out of tree).

CXL interleave occurs at subpage granularity so is emulated using an IO
Memory Region. The memory is general purpose and as such may contain page
tables. FEAT_HADFS using atomic accesses from the page table walkers to
update accessed and dirty bits.

Note that disabling kernel support this ARM 8.1 feature avoids this issue
as the PTW no longer does an atomic update of the page table entries, but
that is a nasty workaround beyond its use in root causing this issue.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

v3: Thanks Richard and Peter for reviewing.
Much simpler error handle + use of BQL_LOCK_GUARD() (Richard)
Dropped RFC and updated description as seems this is converging!
---
 target/arm/ptw.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..140afed451 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,35 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     void *host = ptw->out_host;
 
     if (unlikely(!host)) {
-        fi->type = ARMFault_UnsuppAtomicUpdate;
-        return 0;
+        /* Page table in MMIO Memory Region */
+        CPUState *cs = env_cpu(env);
+        MemTxAttrs attrs = {
+            .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
+        };
+        AddressSpace *as = arm_addressspace(cs, attrs);
+        MemTxResult result = MEMTX_OK;
+        BQL_LOCK_GUARD();
+
+        cur_val = (ptw->out_be
+                   ? address_space_ldq_be(as, ptw->out_phys, attrs, &result)
+                   : address_space_ldq_le(as, ptw->out_phys, attrs, &result));
+        if (result == MEMTX_OK && cur_val == old_val) {
+            if (ptw->out_be) {
+                address_space_stq_be(as, ptw->out_phys, new_val, attrs,
+                                     &result);
+            } else {
+                address_space_stq_le(as, ptw->out_phys, new_val, attrs,
+                                     &result);
+            }
+        }
+        if (unlikely(result != MEMTX_OK)) {
+            fi->type = ARMFault_SyncExternalOnWalk;
+            fi->ea = arm_extabort_type(result);
+            return old_val;
+        }
+
+        return cur_val;
     }
 
     /*
-- 
2.39.2


