Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5CFC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqQE-00042T-MQ; Wed, 24 Jan 2024 22:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQC-0003uq-Dn
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:28:56 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQ9-0001E0-AA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153333; x=1737689333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MDV1CK+CwY5NNGZELqNeBXtymIPsaa9CAufkhjBYBw4=;
 b=QOs7BaWN6fzfVLSmmv25FWMMuULQY2KCcCDNW+NDoJSh4jyfU01996Io
 y/BxlYSB4O3YX9e271wMLfRetElA/mq8Ur8W8uTUCGDEAZcJxgyfQhc0Z
 VMe1oEhLsy/Eyr3y91VKiTSYPDg+y8rmqyA+OUslna/lt+ifIKMTgb5hL
 e58UWvqS5Mpf7p8ZtT/AgJ1Fcka1PklkgobyTyC5bgCDAnO1hhJWxAlSf
 SNvnzn6fNUjvH5pjMw0+dD7F31Q6rSZHQ1xx4oB/VFlh8/PNoKCj6o05j
 1fnxg/FEPG44OuF7t9LYdTi3oGyel3SAjXlxP/qubViUHDRgfsIML9elA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9428469"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9428469"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:25:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2085263"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:25:11 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 18/66] i386/tdx: Make Intel-PT unsupported for TD guest
Date: Wed, 24 Jan 2024 22:22:40 -0500
Message-Id: <20240125032328.2522472-19-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Due to the fact that Intel-PT virtualization support has been broken in
QEMU since Sapphire Rapids generation[1], below warning is triggered when
luanching TD guest:

  warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]

Before Intel-pt is fixed in QEMU, just make Intel-PT unsupported for TD
guest, to avoid the confusing warning.

[1] https://lore.kernel.org/qemu-devel/20230531084311.3807277-1-xiaoyao.li@intel.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
 - newly added patch;
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a962f8a4ea60..2703e97f991d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -292,6 +292,11 @@ void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
     if (function == 1 && reg == R_ECX && !enable_cpu_pm) {
         *ret &= ~CPUID_EXT_MONITOR;
     }
+
+    /* QEMU Intel-pt support is broken, don't advertise Intel-PT */
+    if (function == 7 && reg == R_EBX) {
+        *ret &= ~CPUID_7_0_EBX_INTEL_PT;
+    }
 }
 
 enum tdx_ioctl_level{
-- 
2.34.1


