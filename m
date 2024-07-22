Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C7BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMn-00046d-K8; Mon, 22 Jul 2024 00:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMe-0003Rt-72
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:33 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMc-0001uo-IT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621370; x=1753157370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzS+8fbFrs/6a4tdNbLjGDjHpaHfpFFVeETZgZcEgFg=;
 b=R64l3glnXGC10kDcLcYvdkNndRevS2Mo1QOJXQmn16cClIknS8mK5zmb
 0P925Wy5Lbw1k4PFwusha65PKY16RrzQLh/D3ROFde149+Dqr4Jzo96V5
 11uPzCSfEweaUDWB9CAc0PrPZymUBc3M47ofRX2aUxiJXetTlpSDPq3hf
 +VGgHmxdceLsZ/k/RVzJFI1od2Wd7cRLWPgbkoVmBgKlPkWG96aldnYls
 enmoq9Rb3t0J6j7sWcYp7YRCxl0GoytkEi0h3tTCR9w7VTS8cEw8rowbT
 7bAhKsXgpvrQg+1edeg4LrzeQ/xzH5v6ai7vCJEl/cqQDIhK8DkzZmq9h Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="147100670"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="147100670"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:28 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 188F1E753A
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 67311D4C1C
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 004072007CAB2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7602D1A000C;
 Mon, 22 Jul 2024 12:09:24 +0800 (CST)
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 08/13] sparc/ldst_helper: make range overlap check more
 readable
Date: Mon, 22 Jul 2024 00:07:37 -0400
Message-ID: <20240722040742.11513-9-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10--2.279800-10.000000
X-TMASE-MatchedRID: iXIp5h8ckINrFdvBEmTnvE7nLUqYrlslFIuBIWrdOePfUZT83lbkEJCl
 VuR6WzhZ5hXzidezaCB8AX8i9OoygDcpdZ3fQiLdFEUknJ/kEl5lVdRvgpNpe/oLR4+zsDTtoub
 v1b7BWh2J22Yz0L2Is774ZOp8MSm1gMIpLIwKjjXB55t1PoDsghIJghcZKNkL4YG1k8zNzrK+Xv
 0nAhvdkI94LsuYe6JJrSGd+JHfa+iGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 target/sparc/ldst_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2d48e98bf468..d92c9f15934e 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/range.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
@@ -240,9 +241,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
             if (new_ctx == ctx) {
                 uint64_t vaddr = tlb[i].tag & ~0x1fffULL;
                 uint64_t size = 8192ULL << 3 * TTE_PGSIZE(tlb[i].tte);
-                if (new_vaddr == vaddr
-                    || (new_vaddr < vaddr + size
-                        && vaddr < new_vaddr + new_size)) {
+                if (ranges_overlap(new_vaddr, new_size, vaddr, size)) {
                     DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
                                 new_vaddr);
                     replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
-- 
2.41.0


