Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C4C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:41:44 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf2f-0002y1-21; Fri, 07 Jun 2024 15:14:25 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf2c-0002dc-1m; Fri, 07 Jun 2024 15:14:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf2a-0001qC-FC; Fri, 07 Jun 2024 15:14:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 807F26E547;
 Fri,  7 Jun 2024 22:14:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ABCD3E2744;
 Fri,  7 Jun 2024 22:13:09 +0300 (MSK)
Received: (nullmailer pid 528722 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Huang Tao <eric.huang@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 31/45] target/riscv: Fix the element agnostic function
 problem
Date: Fri,  7 Jun 2024 22:12:50 +0300
Message-Id: <20240607191307.528622-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Huang Tao <eric.huang@linux.alibaba.com>

In RVV and vcrypto instructions, the masked and tail elements are set to 1s
using vext_set_elems_1s function if the vma/vta bit is set. It is the element
agnostic policy.

However, this function can't deal the big endian situation. This patch fixes
the problem by adding handling of such case.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 75115d880c6d396f8a2d56aab8c12236d85a90e0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 40faf3e65b..b077189579 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -29,6 +29,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
     if (tot - cnt == 0) {
         return ;
     }
+
+    if (HOST_BIG_ENDIAN) {
+        /*
+         * Deal the situation when the elements are insdie
+         * only one uint64 block including setting the
+         * masked-off element.
+         */
+        if (((tot - 1) ^ cnt) < 8) {
+            memset(base + H1(tot - 1), -1, tot - cnt);
+            return;
+        }
+        /*
+         * Otherwise, at least cross two uint64_t blocks.
+         * Set first unaligned block.
+         */
+        if (cnt % 8 != 0) {
+            uint32_t j = ROUND_UP(cnt, 8);
+            memset(base + H1(j - 1), -1, j - cnt);
+            cnt = j;
+        }
+        /* Set other 64bit aligend blocks */
+    }
     memset(base + cnt, -1, tot - cnt);
 }
 
-- 
2.39.2


