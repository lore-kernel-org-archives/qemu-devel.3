Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A49BCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCkA-0004I7-ER; Mon, 30 Sep 2024 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjs-0002rC-Od
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjp-000759-Qd
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688642; x=1759224642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RrAQkRUYfObcpECM4cNq8g66930XyTTutz9CzXx+Jy4=;
 b=GTs/Wu06gd7PWN+qiKgb0Fh7b62mWKVgwUqXZP4q6vTD1khhR7mN5pBf
 ToPF8u2yY5t9pGh8+CIZ/8QAwor8tRC/yjtgzEZvtMbSDLjntP6gZn5IN
 O5JIiKYLWZj0kfvhqo1zvI12sdBFQfpGQv1UvonZkV8gLeIh/S/UvzDTC
 7ujlYw7/G2m+jVP0JYabcXuXxgO5rgDeh6YKemBqO2QvjaIPrqCiw5wr6
 QzYL3LO1P4oZD79C708pZCvjFqsxItLWvQweuv3Xg1j08Db+rycaBqhIq
 DJPMdnPalZAxqS/Ti+brsdN0rsWyL/sjPjkkJMJSfkoFLVCbeLrUWvNK8 A==;
X-CSE-ConnectionGUID: tWajr16RRNab8pBk49mQ8g==
X-CSE-MsgGUID: UrzHpd7GRT+4GfbleDBliA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721876"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721876"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:41 -0700
X-CSE-ConnectionGUID: OVE3Nl2HRqCEeTVEgutNMg==
X-CSE-MsgGUID: h4GFLtx3R8y/11sSXlbalQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749876"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:36 -0700
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
Subject: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in scalable
 modern mode
Date: Mon, 30 Sep 2024 17:26:28 +0800
Message-Id: <20240930092631.2997543-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to VTD spec, stage-1 page table could support 4-level and
5-level paging.

However, 5-level paging translation emulation is unsupported yet.
That means the only supported value for aw_bits is 48.

So default aw_bits to 48 in scalable modern mode. In other cases,
it is still default to 39 for backward compatibility.

Add a check to ensure user specified value is 48 in modern mode
for now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 include/hw/i386/intel_iommu.h |  2 +-
 hw/i386/intel_iommu.c         | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index b843d069cc..48134bda11 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define DMAR_REG_SIZE               0x230
 #define VTD_HOST_AW_39BIT           39
 #define VTD_HOST_AW_48BIT           48
-#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
+#define VTD_HOST_AW_AUTO            0xff
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 91d7b1abfa..068a08f522 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3776,7 +3776,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
-                      VTD_HOST_ADDRESS_WIDTH),
+                      VTD_HOST_AW_AUTO),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
@@ -4683,6 +4683,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->aw_bits == VTD_HOST_AW_AUTO) {
+        if (s->scalable_modern) {
+            s->aw_bits = VTD_HOST_AW_48BIT;
+        } else {
+            s->aw_bits = VTD_HOST_AW_39BIT;
+        }
+    }
+
     if (!s->scalable_modern && s->aw_bits != VTD_HOST_AW_39BIT &&
         s->aw_bits != VTD_HOST_AW_48BIT) {
         error_setg(errp, "%s mode: supported values for aw-bits are: %d, %d",
-- 
2.34.1


