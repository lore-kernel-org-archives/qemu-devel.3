Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B41CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwM-0000sv-RZ; Tue, 12 May 2026 04:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwJ-0000rq-Ja
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:07 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwI-0007RW-0A
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576286; x=1810112286;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GrJus0A4zvxhjKK+Vj0V4r2iRoInyrdrtEk8Go8i9cY=;
 b=O+3iNw2rXbvy1rh993A90daIEoEMQP/ovVHzvI9TVOtb38NnyTOz+4Ni
 aw/ZrQLX4yVzshSboAjYdqroVBQQ3h6UluXwO2ProZPdpZZbOsk62d3HP
 H1VUl53lYhIpUmQy5cA1QYqFlgzXvDUhL7k00r6yR/a7dik10nFw2dVW+
 Li1v8ScDBlxEFH8p5xHsHyl/pT6ulB2waj5YAMJH8sKkgIYxIm0h966Xi
 Rd8YrusqWbecrlrkHMMKvLNIy0J2yuWsgBc5Zhsm0BSBY1m0ITG1lWHrY
 Vt3A4acXP+ljb8w1kWO78I5AzFzyx1NZn4Sl8+7BKhHA+1eDp/Buz2uqr w==;
X-CSE-ConnectionGUID: EUyua/4DTQOur9jlbMfO8Q==
X-CSE-MsgGUID: c3aXfmYNSaSYWnLbnP0Z1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510929"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:05 -0700
X-CSE-ConnectionGUID: gATt+gYTS3ekOKS4y4UQvg==
X-CSE-MsgGUID: OLjcu8x7TtmIvrpCjVL4Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065539"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:58:03 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 3/5] qemu-options: Add confidential-guest-support to
 machine options
Date: Tue, 12 May 2026 16:44:56 +0800
Message-ID: <20260512084458.622465-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
References: <20260512084458.622465-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

"confidential-guest-support" is the recommended property to configure
machine with confidential computing technology instead of
"memory-encryption".

Add "confidential-guest-support" to machine options and call out
explicitly "memory-encryption" is the alias of it and not recommended.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 25ed486ff5d2..ea4ae26b8d72 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                memory-encryption=<id> memory encryption object to use (default=none)\n"
+    "                confidential-guest-support=<id> specifies confidential guest support object (default=none)\n"
+    "                memory-encryption=<id> (memory-encryption is the alias of confidential-guest-support, recommend to use confidential-guest-support)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
     "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
@@ -100,8 +101,12 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
+    ``confidential-guest-support=<id>``
+        confidential guest support object to use. The default is none.
+
     ``memory-encryption=<id>``
-        Memory encryption object to use. The default is none.
+        The alias of ``confidential-guest-support``. Recommend to use
+        confidential-guest-support.
 
     ``hmat=on|off``
         Enables or disables ACPI Heterogeneous Memory Attribute Table
-- 
2.43.0


