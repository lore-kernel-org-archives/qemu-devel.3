Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90DFCA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUJ8-0005hc-Km; Thu, 14 Aug 2025 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umUJ0-0005fC-9S
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:31:30 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umUIw-0005cm-3J
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755163886; x=1786699886;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yzIv7cwvl1h1a/yjaMmqlXDHmUv8r3RwUYDOXEzx164=;
 b=PbltGF3RxdGIvk/DXp8lANEzstN403HnoS3N7ins1oNL6xoZmvYYFyQD
 iFSFcK83dCinc0tkiG9RZUcyUP1u+LTuEv5VDnUo9asiTi/ufiNi7jqol
 xyfBSrVGqIPivAxtSueIt5oiFtVREMSbFinxba6p1Hf6y/jFX4RZWJpjy
 pF6jQsRaISOKRK2vn1VX/CYazvEFSIo7JgOZXX2IDpVggJ+PwYt9JPQ3P
 zkGVbLoH1ljadcm4XQHXtmRnqPDvHbOeKE+KoIoxTTKZdXVL7mQPu2suc
 Zm9VmO/Mv7AORyqzGgTEsIVuhJlMNtsssh5jzRdWGtlIe6h7uhe/7/jnH w==;
X-CSE-ConnectionGUID: jcphP1XTQoWr4oWGnPfETQ==
X-CSE-MsgGUID: aHzDwDjXRs60xOLAEo6J4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="80051540"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="80051540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 02:31:22 -0700
X-CSE-ConnectionGUID: H7aSUVi4SKGbB820VqDinw==
X-CSE-MsgGUID: gCXg0xkQQNGCDxwP6Qw+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="167517411"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2025 02:30:50 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Vikrant Garg <vikrant1garg@gmail.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] x86/loader: Don't update kernel header for CoCo VMs
Date: Thu, 14 Aug 2025 17:21:11 +0800
Message-ID: <20250814092111.2353598-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.941, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Update the header makes it different from the original kernel that user
provides via "-kernel", which leads to a different hash and breaks the
attestation, e.g., for TDX.

We already skip it for SEV VMs. Instead of adding another check of
is_tdx_vm() to cover the TDX case, check machine->cgs to cover all the
confidential computing case for x86.

Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b1b5f11e7396..7512be64d67b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -952,7 +952,7 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel on the other side of the fw_cfg interface matches the hash of the
      * file the user passed in.
      */
-    if (!sev_enabled() && protocol > 0) {
+    if (!MACHINE(x86ms)->cgs && protocol > 0) {
         memcpy(setup, header, MIN(sizeof(header), setup_size));
     }
 
-- 
2.43.0


