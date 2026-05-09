Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7314CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcXY-0000uy-7K; Sat, 09 May 2026 03:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1wLcXR-0000uQ-4B; Sat, 09 May 2026 03:55:54 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1wLcXF-0003sL-VY; Sat, 09 May 2026 03:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778313330; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Zyu6d19rbXi0NodA8aF35knLoRYeO1uKV6FzevQ7IWQ=;
 b=rFiHCxkcnIdS2LXUjYQChhNf3y+n6fstqJlJPZJ1D1G8r61PtVIMYolH3p7RX+IJQsqQkQGBCksvuVriOTnrugWTp9xmYpHuVACv58xWfGuS7oYDGkN5YlbgaTRgatjGTNsEt8N0D1DH03nzvgVN/guIXJ5rF+uk730JX6s/JGs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=fangyu.yu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X2Zv8dP_1778313019; 
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com
 fp:SMTPD_---0X2Zv8dP_1778313019 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 09 May 2026 15:50:21 +0800
From: fangyu.yu@linux.alibaba.com
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, tjeznach@rivosinc.com
Cc: guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
Date: Sat,  9 May 2026 15:49:41 +0800
Message-Id: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=fangyu.yu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Fix IOCOUNTINH.CY toggle detection by comparing normalized CY bit
rather than XORing whole register with boolean.

Fixes: 2cf2a6c027ba ("hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 hw/riscv/riscv-iommu-hpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index e8d284ac8b..5bf80a8db9 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -245,7 +245,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
         s, RISCV_IOMMU_REG_IOCOUNTINH);
 
     /* We only need to process CY bit toggle. */
-    if (!(inhibit ^ prev_cy_inh)) {
+    bool cy_inh = !!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY);
+    if (cy_inh == prev_cy_inh) {
         return;
     }
 
-- 
2.50.1


