Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3841C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fSn-0007IE-2I; Wed, 22 May 2024 02:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRU-0005ny-3t
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:19 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRR-0006jy-0I
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359233; x=1747895233;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1OS5SSIJv4L2XO7cycsnJ2tgbCdBTv0xT1j9iZpLEMo=;
 b=REWT5AgSbNWkpSqE9XXIYD+Yd2On6wrcKYilzU2zS4K9FMJ/AsZCwySB
 d5oDBh3W8OMvbSOVuJ0noGw/iilkE/W0IX3XrGydGF20Mb0CHmSSCK0hH
 ruB0mUhLD+v3UFz+XqTkFL30+xGCLcxI6qE83Y7s29qF0JCpZDzbIUjJN
 etsUJMtB+6T8bXvIb9y77nuMhOCnniiywCbX9+DvnxUo3tdA+8eQQg2OW
 t5As5PB490RvMd6c7lxCHSpQoeyWC4052jAEFMAMxsbW05CFXZykCyKjc
 gAGDVpSI/9Oknfif0kOUg7u/rK3I/b+QahI+y1F3lL7a1oHaJER6lIBh6 w==;
X-CSE-ConnectionGUID: L/qh0eKITgKLIFGTmyfJcQ==
X-CSE-MsgGUID: W2aaVkUfQLmoBeeHEVEVUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972792"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972792"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:12 -0700
X-CSE-ConnectionGUID: 2aH0temHQQ6JUe+wJnaXQA==
X-CSE-MsgGUID: fYR5G0UzSguTCIMgwNjZDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33598022"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 16/17] intel_iommu: Modify x-scalable-mode to be string
 option
Date: Wed, 22 May 2024 14:23:12 +0800
Message-Id: <20240522062313.453317-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.
While this vIOMMU implementation wants to simplify it for user by providing
typical combinations. User could config it by "x-scalable-mode" option. The
usage is as below:

"-device intel-iommu,x-scalable-mode=["legacy"|"modern"|"off"]"

 - "legacy": gives support for stage-2 page table
 - "modern": gives support for stage-1 page table
 - "off": no scalable mode support
 -  if not configured, means no scalable mode support, if not proper
    configured, will throw error

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index b0d5b5a5be..dd032b1081 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -264,6 +264,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    char *scalable_mode_str;        /* RO - admin's Scalable Mode config */
     bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a4c241ea96..1bd91fcf4c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3750,7 +3750,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       0xff),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
-    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode_str),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
@@ -4663,6 +4663,28 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->scalable_mode_str &&
+        (strcmp(s->scalable_mode_str, "off") &&
+         strcmp(s->scalable_mode_str, "modern") &&
+         strcmp(s->scalable_mode_str, "legacy"))) {
+        error_setg(errp, "Invalid x-scalable-mode config,"
+                         "Please use \"modern\", \"legacy\" or \"off\"");
+        return false;
+    }
+
+    if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "legacy")) {
+        s->scalable_mode = true;
+        s->scalable_modern = false;
+    } else if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "modern")) {
+        s->scalable_mode = true;
+        s->scalable_modern = true;
+    } else {
+        s->scalable_mode = false;
+        s->scalable_modern = false;
+    }
+
     if (s->aw_bits == 0xff) {
         if (s->scalable_modern) {
             s->aw_bits = VTD_HOST_AW_48BIT;
-- 
2.34.1


