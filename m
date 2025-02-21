Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FDC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMd3-0001RB-Rs; Fri, 21 Feb 2025 01:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd0-0001P6-PI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:14 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMcx-0003jz-Ja
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119711; x=1771655711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f+W7xHv1eRI0J7FNacCobhI1uc+xjuUjaE8S1N4URnY=;
 b=PoqTxgBP6ysEU7pPYN2TDQnMjT8Wr7H9/ElScgZhYHwGfjSH2IPDNIRM
 W9A12nusTdcNAxSHtbj1A94NgAwjJjA2yRRPpNqDqms2lLDpjH14TxuUw
 dhNRGe5BWYD7KwhNLJciR5DoXiQUkTWaUdDPJlGGg/TllZlKwqFHNEuyj
 2fSxpdGDFQnUSUBSnf3aTB6dNVAwrHfu0uKtLAZ5fJCrkSljStvOeAGHe
 wi70MFzANJaxTgYsu7rntNZ7bfrSH1N7+Scz5L7PXeJtjIkYumpbzgDlB
 sXTMoL02jcfQ8igtoEl70CXlc49J3RrRsfQm29ZmLDIP9YSdFDygfbPXe Q==;
X-CSE-ConnectionGUID: BaqAVsWIQ8+0yHxUv/m5KQ==
X-CSE-MsgGUID: zXdIBZYPRWO4U38i63W4eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="169689014"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="169689014"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:07 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E9705E8529
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A968DD5B26
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:04 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0B0C81A000B;
 Fri, 21 Feb 2025 14:35:04 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 2/8] migration/rdma: Remove redundant
 RAM_SAVE_CONTROL_NOT_SUPP check
Date: Fri, 21 Feb 2025 14:36:06 +0800
Message-ID: <20250221063612.695909-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu_rdma_save_page() no longer returns RAM_SAVE_CONTROL_NOT_SUPP
since commit a4832d299dd ("migration/rdma: Check sooner if we are in postcopy for save_page()")

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238..af8e6234a9f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3290,8 +3290,7 @@ int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
     int ret = qemu_rdma_save_page(f, block_offset, offset, size);
 
-    if (ret != RAM_SAVE_CONTROL_DELAYED &&
-        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+    if (ret != RAM_SAVE_CONTROL_DELAYED) {
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
-- 
2.44.0


