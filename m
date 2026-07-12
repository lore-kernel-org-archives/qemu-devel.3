Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8248C44501
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilii-0006XS-D3; Sun, 12 Jul 2026 00:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wili7-00062B-W8; Sun, 12 Jul 2026 00:22:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wili6-0007Hk-4Y; Sun, 12 Jul 2026 00:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=y22mYGO/rUPwIWi0Va28U51rFgUaApaVa61QR2s7Eec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yuj30K+OIIjs29Hhhp7cSBl0QytQqWJJjQMrQqSycZGkYqrQ2zXGm//uq08hMFfaN
 /jVvfaqyJ3g9OvytwAqaHLIMYa+xbJrJ06HFVIPQ1P/FAIBUJxKXICD+SwHQlrhxwH
 bl7P9aSfprxPrpTzw6PHZx8h81/LwkOn99BJfF5ahAi3L/sN6WztNl/pZLRkfYOldb
 l6uZ8av4GwfG9KrnBnwWo5mLNxorwA9XyXKyPDxtgGhwf0Ve1V9W8XG0hzR99P1Ubz
 nlBVW3s2ujVMf9pLq9K8aaAL0zFfsY9n8wu6JO3KeWDhnDq3NwRdU+rSV8ygvT7DVp
 vgHe4mpIM6zWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 462A61C0C1C;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A7613EB97C;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AF7741343B; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 65/75] hw/riscv/riscv-iommu.c: check for misaligned
 IOHGATP_PPN
Date: Sun, 12 Jul 2026 07:15:23 +0300
Message-ID: <20260712041539.108341-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260702203616.1795588-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit bf274c54295c81aeda3835e2e0bc971f0bd57f47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 9ba7cfaea6f..b8120efc5ab 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -818,6 +818,21 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         return false;
     }
 
+    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        uint64_t iohgatp_ppn = get_field(ctx->gatp,
+                                         RISCV_IOMMU_DC_IOHGATP_PPN);
+
+        /*
+         * One of the conditions for a misconfigured DDT entry
+         * according to the riscv-spec: "DC.iohgatp.MODE is not
+         * Bare and the root page table (address) determined by
+         * DC.iohgatp.PPN is not aligned to a 16-KiB boundary."
+         */
+        if (PPN_PHYS(iohgatp_ppn) & ((1ULL << 14) - 1)) {
+            return false;
+        }
+    }
+
     fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
-- 
2.47.3


