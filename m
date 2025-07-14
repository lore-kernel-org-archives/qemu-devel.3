Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B943C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFjH-0002xk-0U; Mon, 14 Jul 2025 05:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTm-000137-Lx
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:19 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTk-0003EU-6H
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485288; x=1784021288;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BpfZqeedCcgSEGxeIlGdqTtbkaF5iKh1zX1XRjAMOIo=;
 b=QnUXVF3drP72gYkxRtBzEtEwVXT8hmICFOpB8jhg9DIDGCEYGO50Ycs0
 LGBmMvhnNIM8V89upWV/5DMIiOr0K0/cGxgMLQAsO4mWFJ9OoPX6ZvL5R
 1yohTKgA+n9xdL3y0N9EHC3dG5HRRSycA9hEaPQGHIZ1/xz3qwcf/0zv7
 T8YyGMqcOPp7qdmREBHhh1DNo/w63PRmN0Jofkj0/VAb6gSdysvDLgGp3
 zB/QTeknAvSm7m4GOaieHvItOAOjhezVYS4EBiKAXYNK0AsRxkHvx+asK
 /tm8c0Q/ux5xIgv1V3hVr7FQcGg3Hqv0SNIk3mjjeGbDKysqLVcvHyqUj w==;
X-CSE-ConnectionGUID: 75RA3QtPQD+ti5o5ERnn4g==
X-CSE-MsgGUID: JnbN6WOQRCe2QZbzbHLSog==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029296"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029296"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:06 -0700
X-CSE-ConnectionGUID: AFiNJOUJQ12h6p+tKzXmAw==
X-CSE-MsgGUID: LeXLREfPQJyVnUYjPleTsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882747"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:28:06 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 4/5] qemu-options: Add confidential-guest-support to machine
 options
Date: Mon, 14 Jul 2025 17:19:52 +0800
Message-ID: <20250714091953.448226-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

"confidential-guest-support" is the recommended property to configure
machine with confidential computing technology instead of
"memory-encryption".

Add "confidential-guest-support" to machine options and call out
explicitly "memory-encryption" is the alias of it and not recommended.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 27b7b79c6cad..5c400114c2e5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
+    "                confidential-guest-support='object-id' specifies confidential guest support object (default=none)\n"
+    "                memory-encryption='object-id' (memory-encryption is the alias of confidential-guest-support, recommend to use confidential-guest-support)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
 #ifdef CONFIG_POSIX
     "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
@@ -99,8 +100,12 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
+    ``confidential-guest-support=``
+        confidential guest support object to use. The default is none.
+
     ``memory-encryption=``
-        Memory encryption object to use. The default is none.
+        The alias of ``confidential-guest-support``. Recommend to use
+        confidential-guest-support.
 
     ``hmat=on|off``
         Enables or disables ACPI Heterogeneous Memory Attribute Table
-- 
2.43.0


