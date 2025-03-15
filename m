Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BDAC35FF3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 09:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttNc4-0002uz-Kb; Sat, 15 Mar 2025 05:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbs-0002n4-Aa; Sat, 15 Mar 2025 05:15:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbo-0007xq-Ls; Sat, 15 Mar 2025 05:15:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA7A8FFBBC;
 Sat, 15 Mar 2025 12:13:45 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2EBC1CAD55;
 Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AD0E055A40; Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 11/27] amd_iommu: Use correct DTE field for interrupt
 passthrough
Date: Sat, 15 Mar 2025 12:14:22 +0300
Message-Id: <20250315091439.657371-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Interrupt passthrough is determine by the bits 191,190,187-184.
These bits are part of the 3rd quad word (i.e. index 2) in DTE. Hence
replace dte[3] by dte[2].

Fixes: b44159fe0 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250207045354.27329-2-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 63dc0b8647391b372f3bb38ff1066f6b4a5e6ea1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 02597db1e1..d94c0f9bfb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1279,15 +1279,15 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         ret = -AMDVI_IR_ERR;
         break;
     case AMDVI_IOAPIC_INT_TYPE_NMI:
-        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_NMI_PASS_MASK;
         trace_amdvi_ir_delivery_mode("nmi");
         break;
     case AMDVI_IOAPIC_INT_TYPE_INIT:
-        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_INT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("init");
         break;
     case AMDVI_IOAPIC_INT_TYPE_EINT:
-        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_EINT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("eint");
         break;
     default:
-- 
2.39.5


