Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C158AEE020B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFsn-0005jU-Rq; Wed, 11 Sep 2024 01:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsl-0005Ky-76
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:11 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsj-0004Mp-FO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032430; x=1757568430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tEoQH+orwDfVTt6SXkdIsJUa09Wi+h/1pLKCEvfBGUc=;
 b=X9AdQ4e9OTLh3KUbv8KpSaFuPj8xv8MOhAeuVPM8SzPIRnhnWGI507I8
 eP/n5g2fEI4zmZMSue4StsSLYHKEWRhZle9TrYm8UQBI6eRES6m/z8YDV
 4UzC+4FPSJGPFOkt3WNp3c6Xwktzo4JtvyXOsI4lW0c+4NK8/vSJc1zzD
 BovK1Z/azjowBBT9oVxYp7Bx4ntq0vp1BT662T19WXkeo0qOLOGaYjpvv
 icrhkA1RuAGh8YewNNxatMCg0XV9MyWnJIBM3JlUYFAWXdcvQ08TmhafO
 TWv3DWf8hIL8sw70QojqR601C2JhkiUPuaVZoGhktQFHO88XskDIdxPlz w==;
X-CSE-ConnectionGUID: zfz8evsjRoqlHZ5nitrWAQ==
X-CSE-MsgGUID: IZUzYWibTRqwuJHj0a7BMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403635"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403635"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:27:09 -0700
X-CSE-ConnectionGUID: mXTRuF4TQHW4W/rbYmIgPA==
X-CSE-MsgGUID: qECYOD+AQTuiMT3cgDB7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536561"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:27:04 -0700
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
Subject: [PATCH v3 16/17] intel_iommu: Introduce a property to control FS1GP
 cap bit setting
Date: Wed, 11 Sep 2024 13:22:54 +0800
Message-Id: <20240911052255.1294071-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
after turn FS1GP off in vIOMMU.

This property has no effect when vIOMMU isn't in scalable modern
mode.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 include/hw/i386/intel_iommu.h | 1 +
 hw/i386/intel_iommu.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 650641544c..f6d9b41b80 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -308,6 +308,7 @@ struct IntelIOMMUState {
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
+    bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /*
      * Protects IOMMU states in general.  Currently it protects the
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bb3ed48281..8b40aace8b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3779,6 +3779,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
+    DEFINE_PROP_BOOL("x-cap-fs1gp", IntelIOMMUState, fs1gp, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4507,7 +4508,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->scalable_modern) {
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


