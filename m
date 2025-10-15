Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF7DCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91VP-0001cd-TB; Wed, 15 Oct 2025 09:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91VL-0001Zy-7L
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:24 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91VA-0003TR-3o
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=CTa9MZ7Z/2sl/oP8jm0yw+KnRuoGGljaWiacIdqpJ7E=; b=vPzA0BKPMlNCVIi
 kuFy+FRz8Kw9XEwYirQCuGiDRPLBfFahSVjatIJbEjkvR+p2eDper7+MdjhjXjXnFY33/YW8lDtVc
 58gOUolq8JWN8EPdHRnCm62kT1SECv/Q1mWGXauZrq5CwAXtYXjEaYrghKnRZRLyPDJJpuN2wwNDs
 Sc=;
Date: Wed, 15 Oct 2025 15:27:42 +0200
Subject: [PATCH 5/5] hw/riscv: Use runtime target_phys_addr_space_bits()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-feature-single-binary-hw-v1-v1-5-8b416eda42cf@rev.ng>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 450285a850..9ac37efc70 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2449,7 +2449,7 @@ static void riscv_iommu_instance_init(Object *obj)
 
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
+                       target_phys_addr_space_bits());
 
     /* TODO: method to report supported PID bits */
     s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */

-- 
2.51.0


