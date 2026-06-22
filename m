Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C4BCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhrt-0004aa-Q4; Mon, 22 Jun 2026 12:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>)
 id 1wbhQe-00064G-Vs; Mon, 22 Jun 2026 12:23:21 -0400
Received: from hades.hosts.managarm.org ([195.201.36.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>)
 id 1wbhQd-0005Zr-DP; Mon, 22 Jun 2026 12:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=managarm.org; s=2021;
 t=1782145395; bh=vb3PPKd8GLEVktpJWW33N1oTIWMJIZxE8aXOWrtXRAA=;
 h=From:To:Cc:Subject:Date:From;
 b=s6eV/1D6QzLga4kt6VT8elOrMvAAjXsshP/8/nYKq8k8uwiFjcbqE+wNDkIVPoy2g
 fDawpsVIApGaRCJjBKLfw7heV4U2FKeSe3NGtbfrbQ8WE9sPxujDcoAwcYDwPWG9V3
 61xJkmJ9sqByg4muzn9++lZTCbW/Sa8O8RTnQ4JaW8Ycf8GKFJolLtFdJBMm4ggRkO
 pfP8uRrDJbOoJTL+JfL/2vkqXJnHI4VT5jHALqMWXECYOmPUf53dVjPVbTl3RiCvV9
 dqsp/9wejb1KlbxKnjpxUvVfRtbsVrHM3t5Y6LyQu+E+DLoAojJoeozcuebXAtQ4jP
 l5409OAL3cZ8w==
Received: from white.localdomain (pd9f9de93.dip0.t-ipconnect.de
 [217.249.222.147])
 by hades.hosts.managarm.org (Postfix) with ESMTPSA id 6F9493EE10;
 Mon, 22 Jun 2026 16:23:15 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org, no92 <leo@managarm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Date: Mon, 22 Jun 2026 18:21:37 +0200
Message-ID: <20260622162138.1045170-1-leo@managarm.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.201.36.94; envelope-from=leo@managarm.org;
 helo=hades.hosts.managarm.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jun 2026 12:51:06 -0400
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
Reply-to:  no92 <leo@managarm.org>
From:  no92 via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With the changes in c7b2e22bd957, the `pt` bit was set in the (wrong)
capability register, instead of the (correct) extended capability
register.

Fixes: c7b2e22bd95710e404c393e9f563cfe7404220c1 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")
Signed-off-by: no92 <leo@managarm.org>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 744cdfd2e6..d1af7a3135 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4988,7 +4988,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (x86_iommu->dma_translation) {
@@ -4999,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
                     s->cap |= VTD_CAP_SAGAW_48bit;
             }
     }
-    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
+    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
-- 
2.54.0


