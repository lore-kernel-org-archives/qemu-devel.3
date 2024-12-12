Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3109E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLemb-000790-Bs; Thu, 12 Dec 2024 03:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLemY-0006pr-UX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:50 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLemW-00085o-Tm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992969; x=1765528969;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SDUTGiFGVGH1fBy17sZ0Wts/rFM1FSVpI1pQTdJX7IU=;
 b=CJF0a6KbG+S93FMG1Gr1PqyQFsxQ5MESIWSrFl5zbYuRLMRxjc0Ublcs
 dHFbkFXjxrmlZRoNqeeqjHARt8A7OXeqqtKZLBVEh3oLAUSJ8LRwKr3g9
 gcpuAOerw0D0VeJ5WFZUbditUAbg1Njjo+INtjKWRpvNrovE46YxGarn+
 e+gde3f8nuIGwojCQGQQnAfARKZtgI+BLiv47G48tW7VlFyIfaSrUghvk
 wFuWOvTEEy9DnxPnLIfiakhKenRvauGHHhYSVFRYBbXC1cv4mXcj0XhPT
 H6Os+TayLZqNzqDS6Eyb3SvELPJ/Qq8Z6sww7YFZcDrbRa1lT8Y6T3++b A==;
X-CSE-ConnectionGUID: jwt/CWpfRbWJjyvee1/Mfw==
X-CSE-MsgGUID: QUkHtX6DRkaCO32J7bP8SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34125051"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34125051"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:37 -0800
X-CSE-ConnectionGUID: wfcsjMPjSeCNRuMEkDtukA==
X-CSE-MsgGUID: hs3Xeg2oQfu/OVsoMBI4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407249"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:33 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v6 19/20] intel_iommu: Introduce a property to control FS1GP
 cap bit setting
Date: Thu, 12 Dec 2024 16:37:56 +0800
Message-Id: <20241212083757.605022-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This gives user flexibility to turn off FS1GP for debug purpose.

It is also useful for future nesting feature. When host IOMMU doesn't
support FS1GP but vIOMMU does, nested page table on host side works
after turning FS1GP off in vIOMMU.

This property has no effect when vIOMMU is in legacy mode or x-flts=off
in scalable modme.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/i386/intel_iommu.h | 1 +
 hw/i386/intel_iommu.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 72428fefa4..9e92bffd5a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -307,6 +307,7 @@ struct IntelIOMMUState {
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
+    bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
     bool stale_tm;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e234b5c234..2247194341 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3834,6 +3834,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
+    DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4562,7 +4563,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->flts) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
-        s->cap |= VTD_CAP_FS1GP;
+        if (s->fs1gp) {
+            s->cap |= VTD_CAP_FS1GP;
+        }
     } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
-- 
2.34.1


