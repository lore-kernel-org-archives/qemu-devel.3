Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A0F41989
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCx1N-0001Yg-GV; Wed, 15 Apr 2026 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCx1H-0001Xv-D1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:58:53 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCx1E-0007Va-Pd
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776247129; x=1807783129;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8hatjBc+edWAbEN26Ul9Ih+6a76CtBZCWOyl3l0WcRE=;
 b=SW+CCoN5/QuXBlsj7dEvaWpwJNeUwBIo/yTmtkx0UbSqgAp6uNuutsr6
 mZ7ZtLKIEhrJyNJ5d1StYSKaryXXFkiaP5AbUPimbnYaZagO36rZCIL5E
 vBZrO6a8ZqpEXgNH3HA6AlkRIfPGjbE5qKSMgIwVjYmk8NHxZayAQHyLh
 H9AxrpDf8md/JZ6DPytfr1xphbmO9u3T7O8mOK8Ej7U9gCRmPWG9/2cE1
 JFBONnJkS8/ckMe5oWFcTTW++SgLA9fHSSaBr2EKFJChyKfGrMEAqjFOe
 A8zgxX1NK5RU0rarreYEWE65Fwc9e70fLnAfVriem4hsMnHZ8EC84cl6r g==;
X-CSE-ConnectionGUID: MQi7iuClRpeToajLjesSgA==
X-CSE-MsgGUID: 8nF++n5tRxiW/jVXRTy6cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77125582"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77125582"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 02:58:42 -0700
X-CSE-ConnectionGUID: dnfPAyV4Rh+xZNMF/HiMhQ==
X-CSE-MsgGUID: zCg73EVURqWAmUwJRnwgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="253596600"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 02:58:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, philmd@linaro.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>
Subject: [PATCH] intel_iommu: Re-expose VTD_ECAP_PT
Date: Wed, 15 Apr 2026 05:58:32 -0400
Message-ID: <20260415095832.9631-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit c7b2e22bd957 cleared VTD_ECAP_PT in ecap register and set PHMT bit
in cap register, makes vIOMMU passthrough unsupported, fix it.

Fixes: c7b2e22bd957 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..6b8f75a8b6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4998,8 +4998,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
-             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_CAP_MAMV |
+             VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (x86_iommu->dma_translation) {
             if (s->aw_bits >= VTD_HOST_AW_39BIT) {
@@ -5009,7 +5009,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
                     s->cap |= VTD_CAP_SAGAW_48bit;
             }
     }
-    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
+    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
-- 
2.47.3


