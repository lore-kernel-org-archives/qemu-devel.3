Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8BCCF2D3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0f-0005wU-EO; Sat, 17 Oct 2026 16:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0H-0005Hz-GO; Sat, 17 Oct 2026 16:27:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0F-0003vo-NK; Sat, 17 Oct 2026 16:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268835; bh=h0BWN6CVMO1GBm/Xer5ieqPEukNQ6yblUgmEV/ew2Ug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Tk64E4hLQt6qX1K5o3829B8JREAKy+9SJxrHIwHSX863hBpqeLvTDsKbRp1i+OC93
 YXoW1Uu85fDebIKwCLmXN0eJDqPmxpZkWmNQNDUR8Hh0nO1FdrdQP6RB4luaa+SXY2
 NhaJAFPt9R6JtaMGjlW3k2ztPQiWw/3eYVAdgu1J8Xsz30tDbEZre4Mw9s7Mk4e3Cr
 yQBfjf8oN40x11AixlnEQ8FcGq9GHkZEZm2rsBzHqRaogOE5hfWlpgYVP2tUSW6I0Y
 tKnb2rv/hTi2TWKUYSMH3pthBvRS7JhRlfGF08swFwpZe2Glzq0/4Qn29hITmKpaBf
 uL8gCW/3fnq8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6FD021DE747;
 Sat, 17 Oct 2026 23:27:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A82444341E;
 Sat, 17 Oct 2026 23:27:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 12/73] s390x/pci: Fix frame stepping in
 rpcit_service_call()
Date: Sat, 17 Oct 2026 23:25:30 +0300
Message-ID: <20261017202638.728621-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

When walking the guest IO address table, an invalid segment or region
entry causes table_translate() to return entry.len equal to the frame
size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
entry.len directly to start only advances to the correct next frame
boundary if start is already frame-aligned at that level -- which is
true for a well-behaved Linux guest but not a general requirement.

Add logic to advance start to the next frame boundary rather than
simply adding entry.len.  For a frame-aligned start (the typical,
well-behaved case) the result is identical.

Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-2-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit e57ad36701886404baaf5216bacfa9a21f98fd6e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 652e1712ec..bac813fb6a 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce = 0;
         }
 
-        start += entry.len;
+        /* Advance to next frame boundary if start was not frame-aligned */
+        start = QEMU_ALIGN_UP(start + 1, entry.len);
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
                 dma_avail = s390_pci_update_iotlb(iommu, &entry);
-- 
2.47.3


