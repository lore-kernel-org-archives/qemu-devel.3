Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DC1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8h7-0004n4-KM; Wed, 12 Aug 2026 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gn-0003tL-F8; Wed, 12 Aug 2026 09:08:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gl-0005RZ-36; Wed, 12 Aug 2026 09:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=y3PyXnMwdMancwokW+pXsfcz7ujpa53MhIOktWM5oOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pyBcZfrH+Lk3WnnTlrNWkZ9X/mfFf+mrKw8HRHsKfvySkiA410ikq+c9rEaUQErTD
 nlrhVRckXSjd1KuNTGvLngE0mEl+ni+11gWxfzugyaaZaR4B7+pQBPx2sxpetDMRhr
 MKFyxpipYcT4kXJy07MUpYx+j14bznhEJdTMqDMWxAx0HYK9s8l5RCG9xYQb0Nz+Wf
 TMTg/p+SzwE1zSdXlva4ORhBGh5PCjHblDP019hRmAAr7TXASb0ORGYHxgllKnPp3F
 7RbwAwtCpruk40eHmGesdHfT7Jl01BdSpkty7gKvG0+wcKpVgY5Ou+NcYU+2lHdDmf
 dPy1GDkt4Bp0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1A8F61CA4B6;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4F091409B99;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5A7D52F902; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 huntr bubble <bubblehuntr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 055/102] intel_iommu: Check address mask before using
 it in pasid-based iotlb invalidation
Date: Wed, 12 Aug 2026 16:01:30 +0300
Message-ID: <20260812130233.621965-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Prevent a buggy driver to execute malformed invalidation operations.

Add the same assert as in vtd_iotlb_page_invalidate.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
(cherry picked from commit 0691bb257a7cbfd62127208b49988705bfa2dfe8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a117a0b6b10..23b6cdef649 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2999,6 +2999,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
 {
     VTDIOTLBPageInvInfo info;
 
+    assert(am <= VTD_MAMV);
+
     info.domain_id = domain_id;
     info.pasid = pasid;
     info.addr = addr;
@@ -3037,6 +3039,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
 
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        if (am > VTD_MAMV) {
+            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
+                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%llu)",
+                              __func__, inv_desc->val[1], inv_desc->val[0],
+                              am, VTD_MAMV);
+            return false;
+        }
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
         vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
         break;
-- 
2.47.3


