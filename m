Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF6BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHhv-0004Kf-Ur; Wed, 27 Aug 2025 11:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhg-0003z5-5y; Wed, 27 Aug 2025 11:04:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhd-0004u7-TW; Wed, 27 Aug 2025 11:04:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9025414C53A;
 Wed, 27 Aug 2025 18:02:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F171269842;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 18/59] target/loongarch: Fix valid virtual address
 checking
Date: Wed, 27 Aug 2025 18:02:23 +0300
Message-ID: <20250827150323.2694101-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch64 system, the high 32 bit of 64 bit virtual address should be
0x00000[0-7]yyy or 0xffff8yyy. The bit from 47 to 63 should be all 0 or
all 1.

Function get_physical_address() only checks bit 48 to 63, there will be
problem with the following test case. On physical machine, there is bus
error report and program exits abnormally. However on qemu TCG system
emulation mode, the program runs normally. The virtual address
0xffff000000000000ULL + addr and addr are treated the same on TLB entry
checking. This patch fixes this issue.

void main()
{
        void *addr, *addr1;
        int val;

        addr = malloc(100);
        *(int *)addr = 1;
        addr1 = 0xffff000000000000ULL + addr;
        val = *(int *)addr1;
        printf("val %d \n", val);
}

Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250714015446.746163-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit caab7ac83507e3e9a5fe2f37be5cfa759e766ba2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 930466ca48..8c332d74a5 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -299,8 +299,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Check valid extension */
-    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
-    if (!(addr_high == 0 || addr_high == -1)) {
+    addr_high = (int64_t)address >> (TARGET_VIRT_ADDR_SPACE_BITS - 1);
+    if (!(addr_high == 0 || addr_high == -1ULL)) {
         return TLBRET_BADADDR;
     }
 
-- 
2.47.2


