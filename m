Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DABFC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fSi-000789-53; Wed, 22 May 2024 02:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRO-0005hx-0J
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:10 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRM-0006jy-8n
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359228; x=1747895228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jvy+iy1hOkE9h3oLFlev3YfseKo4APjCUCxIGJhkwOo=;
 b=Rwax7vnu2j6i4hqZfx6O9pJJlK7g8LxZ0gHKxsxmUU7v05TZ8n1QJEda
 ujrGLYKmzYhqG/qhJZa463Pgh/D/gsBUf6Jez8lfZfYM+By4qRbulhM++
 dl5Qtk7zR4A7MELUQuzwpQHc4yi23ohY6RORHp7YOLQqLx7faDesfVR2/
 SRPhZMFqus+XARA3y1liNnY0MX0AoOQJn/ab2dIchgEqU8stSxtdGco8g
 KmnXXP82WiOdtEi4hj6p8Lu09Lh+kdFeS8s0KjYA+525oBVhKpzAZwCVR
 acHsuQ5dxRNHJAFR8LUJDVLdzRSGGc1o9nBOfW4mNBOjQyDxRzo7zU5GY A==;
X-CSE-ConnectionGUID: 2aoXNAvURCeYjlFipdvLMw==
X-CSE-MsgGUID: xQndOPgcTrikIgY+2SAEPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972750"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972750"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:06 -0700
X-CSE-ConnectionGUID: 0UlVAaF3ThGmkBwwwqO5lg==
X-CSE-MsgGUID: XihXTWhITxeUlgtwRj7Vpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597978"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:01 -0700
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
Subject: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Date: Wed, 22 May 2024 14:23:11 +0800
Message-Id: <20240522062313.453317-16-zhenzhong.duan@intel.com>
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

According to VTD spec, stage-1 page table could support 4-level and
5-level paging.

However, 5-level paging translation emulation is unsupported yet.
That means the only supported value for aw_bits is 48.

So default aw_bits to 48 in scalable modern mode. In other cases,
it is still default to 39 for compatibility.

Add a check to ensure user specified value is 48 in modern mode
for now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e07daaba99..a4c241ea96 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3748,7 +3748,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
-                      VTD_HOST_ADDRESS_WIDTH),
+                      0xff),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
@@ -4663,6 +4663,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->aw_bits == 0xff) {
+        if (s->scalable_modern) {
+            s->aw_bits = VTD_HOST_AW_48BIT;
+        } else {
+            s->aw_bits = VTD_HOST_AW_39BIT;
+        }
+    }
+
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
         (s->aw_bits != VTD_HOST_AW_48BIT) &&
         !s->scalable_modern) {
@@ -4671,6 +4679,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if ((s->aw_bits != VTD_HOST_AW_48BIT) && s->scalable_modern) {
+        error_setg(errp, "Supported values for aw-bits are: %d",
+                   VTD_HOST_AW_48BIT);
+        return false;
+    }
+
     if (s->scalable_mode && !s->dma_drain) {
         error_setg(errp, "Need to set dma_drain for scalable mode");
         return false;
-- 
2.34.1


