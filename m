Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD6BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarEj-0001yk-CO; Mon, 05 Aug 2024 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEe-0001qy-WE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:26 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEc-00029G-42
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839422; x=1754375422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MsprqmxtgK1HuYvpPYAbr8ekbcHQ69W7VlCS7gqHGXM=;
 b=kPiN7yX3j9Lko/t/rkxacNp0WmUEZD2W8a4JVvwzohT/1unEuLlz7U0q
 v6kS39rt0mLdvVcgqNUHDk8K7JB25+Ts0saFIJb8IstYYH7gck1Yyg88y
 m1oWEQYR5viEOV1l4W2arsro1uhbM6Np5pkv7y3QUy/niPjfPPVzKQVW4
 MinkM1SSDdnBfV0sAYS2uyAHPVwzUIsssqpsA52+fnHojKiy7AcTmi0eu
 TgWCNfh7lVH2RLfsBYTJ6GOGRb38TAgfswpiggVLps81A5LJK3JxeskA1
 kUL9JrZb/BqznDC6zXzXHI2uUdTNk+uclowfwtmAhqNGogxSbrwWmLjMb w==;
X-CSE-ConnectionGUID: GwAGK9MqSdiQ+AzK0OX7AQ==
X-CSE-MsgGUID: cwXf4B0IRxeCeuWEtb/qmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282687"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282687"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:22 -0700
X-CSE-ConnectionGUID: tBna07eAT8u3JMg038EitQ==
X-CSE-MsgGUID: U4Mf0B7lRZWDyHloVLhExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786578"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:17 -0700
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
Subject: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for scalable
 modern mode
Date: Mon,  5 Aug 2024 14:27:13 +0800
Message-Id: <20240805062727.2307552-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

Add an new element scalable_mode in IntelIOMMUState to mark scalable
modern mode, this element will be exposed as an intel_iommu property
finally.

For now, it's only a placehholder and used for address width
compatibility check and block host device passthrough until nesting
is supported.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1eb05c29fc..788ed42477 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -262,6 +262,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
     dma_addr_t root;                /* Current root table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e3465fc27d..c1382a5651 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3872,7 +3872,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
-    return true;
+    if (!s->scalable_modern) {
+        /* All checks requested by VTD non-modern mode pass */
+        return true;
+    }
+
+    error_setg(errp, "host device is unsupported in scalable modern mode yet");
+    return false;
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4262,9 +4268,9 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-        (s->aw_bits != VTD_HOST_AW_48BIT)) {
+        (s->aw_bits != VTD_HOST_AW_48BIT) &&
+        !s->scalable_modern) {
         error_setg(errp, "Supported values for aw-bits are: %d, %d",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
-- 
2.34.1


