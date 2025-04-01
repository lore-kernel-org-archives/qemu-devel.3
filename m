Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1642C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbz0-0006J7-1I; Tue, 01 Apr 2025 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuI-0000Yw-ST
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:06 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuE-0006Zf-8g
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515034; x=1775051034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xsvCG5PKYAl5zA9Q6TrXmGU62MgEcnF7Km+/JJfw55A=;
 b=lFXSDnHkiZDwdh3y8XHNa+JTiG1HsOJPnQkNcdXVuzieAAjil1Rh+bc2
 eRy5GoIHK3uGSksQtHc8cI7pAwiDnx1wVrWWo7++tczK5xjK7ocKWHSCq
 DZ7oMK4W5f9pc9KIw9zdgTqzAU7YaV5tq/9kfEyg5756Lb6F4gdwIqERu
 FdzlqjZJ9TEyyucVJ4Eg16+dNEw06VkySs3cFc92VXybMCpDCzC4OFoNI
 2C83ovm0eMNGtPhA/0ns84AlWZ0mYgNInWmBQm77RT1Pcv4WXVsHrbfHH
 dhnd7ZArMBmevVPPXxMwWq6+hpG+DbDIVqohYKuKuq0fjbDLYH5sj5Uhe Q==;
X-CSE-ConnectionGUID: gc/p/NPoQuac9f+AExTFhA==
X-CSE-MsgGUID: ltJPWSJiSd2v7h19yRnoeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433475"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433475"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:45 -0700
X-CSE-ConnectionGUID: sSLWwrCwRIa6OTLqXtIk9w==
X-CSE-MsgGUID: glcSvyNBQDqTQZA5/m9tew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640145"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:43 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 37/55] i386/tdx: Disable PIC for TDX VMs
Date: Tue,  1 Apr 2025 09:01:47 -0400
Message-Id: <20250401130205.2198253-38-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Legacy PIC (8259) cannot be supported for TDX VMs since TDX module
doesn't allow directly interrupt injection.  Using posted interrupts
for the PIC is not a viable option as the guest BIOS/kernel will not
do EOI for PIC IRQs, i.e. will leave the vIRR bit set.

Hence disable PIC for TDX VMs and error out if user wants PIC.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0eefd058f7a2..0d30506c2021 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -383,6 +383,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -EINVAL;
     }
 
+    if (x86ms->pic == ON_OFF_AUTO_AUTO) {
+        x86ms->pic = ON_OFF_AUTO_OFF;
+    } else if (x86ms->pic == ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM doesn't support PIC");
+        return -EINVAL;
+    }
+
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
         if (r) {
-- 
2.34.1


