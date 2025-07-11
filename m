Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61521C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAwr-0000DN-19; Fri, 11 Jul 2025 06:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAw8-00089C-1r
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:25:01 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAw5-0003Ck-TG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752229498; x=1783765498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/dbJpXZ+WoEY+wWTUOHZZkTlAY66zw+zpoaPJAtvbjw=;
 b=KB5eJ/lhCbbZLWYhSzFGmHmepd5w3/URsTdPEWm47frT4PGpJCRhRMri
 CKLKY/Gj0Kpz0z8YboYBtOg0qCdn2WP+G44xCgGdFA1H81mVRj08W5MV1
 VqYFf7IkZr47nglcmFu3yWZwMwHR6AEKFdGSAVtbmnAGrUgz4nnvpuK0G
 Eo51FIksami26GHDs5woCkxHCdDVqJz/r4YmGTwGZNlAhqUyzm7zlKyuP
 LjOB7cGHV+EfscXLZNR4G+LMKba61ExyTJY4rzefrn5Ia+Cl9J/R85JW0
 4fdknKOasEqrh52u/Tq2ognp86zaZXAnCyradOKfVW1EuHH8dLjvP5jwE Q==;
X-CSE-ConnectionGUID: hugTJbURRXW2DrFtDmh99A==
X-CSE-MsgGUID: WIEyWdgJQQi8TSMz40YYXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65875719"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="65875719"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:24:57 -0700
X-CSE-ConnectionGUID: 09HYi2rTTCyvfFtcl4+bRQ==
X-CSE-MsgGUID: Igb0fkN8SVuowwA6URQ3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="156894398"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2025 03:24:54 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 5/9] i386/cpu: Add a "x-force-cpuid-0x1f" property
Date: Fri, 11 Jul 2025 18:45:59 +0800
Message-Id: <20250711104603.1634832-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711104603.1634832-1-zhao1.liu@intel.com>
References: <20250711104603.1634832-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Manish Mishra <manish.mishra@nutanix.com>

Add a "x-force-cpuid-0x1f" property so that CPU models can enable it and
have 0x1f CPUID leaf natually as the Host CPU.

The advantage is that when the CPU model's cache model is already
consistent with the Host CPU, for example, SRF defaults to l2 per
module & l3 per package, 0x1f can better help users identify the
topology in the VM.

Adding 0x1f for specific CPU models should not cause any trouble in
principle. This property is only enabled for CPU models that already
have 0x1f leaf on the Host, so software that originally runs normally on
the Host won't encounter issues in the Guest with corresponding CPU
model. Conversely, some software that relies on checking 0x1f might
have problems in the Guest due to the lack of 0x1f [*]. In
summary, adding 0x1f is also intended to further emulate the Host CPU
environment.

[*]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
Co-authored-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
[Integrated and rebased 2 previous patches (ordered by post time)]
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note:
  This patch integrates the idea from 2 previous posted patches (ordered
by post time)[1] [2], following the s-o-b policy of "Re-starting
abandoned work" in docs/devel/code-provenance.rst.

[1]: From Manish: https://lore.kernel.org/qemu-devel/20240722101859.47408-1-manish.mishra@nutanix.com/
[2]: From Xiaoyao: https://lore.kernel.org/qemu-devel/20240813033145.279307-1-xiaoyao.li@intel.com/
---
Changes since RFC:
 * Rebase and rename the property as "x-force-cpuid-0x1f". (Igor)
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5676e5526f40..d27eeb1cb718 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9940,6 +9940,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


