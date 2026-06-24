Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297CECDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFra-0003q2-OQ; Wed, 24 Jun 2026 01:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFq8-0002gn-SV; Wed, 24 Jun 2026 01:07:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFq3-0005oW-J5; Wed, 24 Jun 2026 01:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=JBv4zpUjRuIacUcZc+qmKN642mR69WzuBoCa7wJyfBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bVbDjH594g0v2xq174uCo3PJPM1Z5249x1ju7/TbNT2ukKgu95bZse+zhXWZ4hWO6
 E1p1XGBIvHBM+kwIp64N/QE3Rtx72gO0/cgXj53JFk9B4e+i/q0egeyHtrj57OaDLj
 r3uXwjVbWPTpUbgNm+4GKkR6vrPr5lChs/Xo58e1iQtLt0RpdwGLbClicx+lwnB9yl
 UJ+glQiCZyPtEAsD876AVix6Ghkga3Zo3XrRLNyMOZCiuIP6MBkFPsS6fig2w4n3zu
 A59fqPLjsgfJHhI18Ma40RRDlG0vmwPvF/bHO149+X0V8uXv1G0FsmXpaBqMUT3fev
 PY+dxdHFTWXOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9BFC71BA664;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8601B3DDB01;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 70/95] amd_iommu: Reject non-decreasing NextLevel in
 fetch_pte()
Date: Wed, 24 Jun 2026 08:05:05 +0300
Message-ID: <20260624050541.395079-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The AMD-Vi specification requires that the NextLevel field for a page table
entry must not be greater or equal to the current page table entry level.
Enforce this to avoid infinite page walk loops on corrupted or buggy guest
page tables.

The initial implementation of fetch_pte() did not implement this check, but
was not vulnerable since the page walk code explicitly decremented the level
instead of retrieving it from the page table entry.

Cc: qemu-stable@nongnu.org
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260330212817.992673-3-alejandro.j.jimenez@oracle.com>
(cherry picked from commit 291aa70ad254b6c48012dbfd16a4af0978ea1b84)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 86dab42624..a7991b2790 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -771,6 +771,10 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
             break;
         }
 
+        /* Next level must always be less than current level */
+        if (pt_level <= next_pt_level) {
+            return -AMDVI_FR_PT_ENTRY_INV;
+        }
         pt_level = next_pt_level;
 
         /*
-- 
2.47.3


