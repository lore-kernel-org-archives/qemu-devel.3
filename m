Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB4C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFz-0004K5-OJ; Wed, 23 Apr 2025 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFV-000416-1e
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:42 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFS-0002wd-OD
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407599; x=1776943599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ro6LZDTZ2hjHpKbMDlTvllYkUuuqO9mI3PXZKl+8Ub8=;
 b=PLSn5EgC5jaL5dDbPCnGMLtf8c8VZ8oKLmoZ5eogHIlWz2NwLkTpEv47
 6Ov1/ExQx9YkTHvrgfHzVnY1YMqiuyhWXwpJ81WFHR9vZ3dPS2AxnOnkT
 gEQ02dHfINnYxt7QwXa7Ng1dW5+igUCJ4mMyawEOB432jJl8cc5iuSLuZ
 3Lbn0Uu2+38RdSOe0nRMiDWMNluB3ZME+jt4ggIbZbEtQmNo2KMiHZTSa
 pP6cb7WPPjcR+fty6acsjhPRzVRu1hnuR/PkCu0yaK7pg8Yrr8nyNw95N
 toIcWT0UDNRWm6qtmiqDqumvSpgbx/UWSpDTiUUEWp2VRRaFW7QCFAUoS Q==;
X-CSE-ConnectionGUID: 6LNRi2mgRGWcVGoxNj7XOQ==
X-CSE-MsgGUID: 3cDEb3PYQgK9pCXuzjqeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825307"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825307"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:38 -0700
X-CSE-ConnectionGUID: 9A6bHYTjSUiobgHkXuiizw==
X-CSE-MsgGUID: bL+hEagfSoWySz+YUSAf0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150786"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:34 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 07/10] i386/cpu: Add a "cpuid-0x1f" property
Date: Wed, 23 Apr 2025 19:46:59 +0800
Message-Id: <20250423114702.1529340-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423114702.1529340-1-zhao1.liu@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a "cpuid-0x1f" property so that CPU models can enable it and have
0x1f CPUID leaf natually as the Host CPU.

The advantage is that when the CPU model's cache model is already
consistent with the Host CPU, for example, SRF defaults to l2 per
module & l3 per package, 0x1f can better help users identify the
topology in the VM.

Adding 0x1f for specific CPU models should not cause any trouble in
principle. This property is only enabled for CPU models that already
have 0x1f leaf on the Host, so software that originally runs normally on
the Host won't encounter issues in the Guest with corresponding CPU
model. Conversely, some software that relies on checking 0x1f might
experience problems in the Guest due to the lack of 0x1f [*]. In
summary, adding 0x1f is also intended to further emulate the Host CPU
environment. Therefore, the "x-" prefix is not added to this property.

[*]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/

Co-authored-by: Xiaoyao Li <xiaoyao.li@intel.com>
(Missing signed-off from Manish & Xiaoyao)
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note:
  This patch integrates the idea from 2 previous posted patches (ordered
by post time)[1] [2]. Although the target cases are not exactly the same
as this patch, add the authorship of previous authors.

[1]: From Manish: https://lore.kernel.org/qemu-devel/20240722101859.47408-1-manish.mishra@nutanix.com/
[2]: From Xiaoyao: https://lore.kernel.org/qemu-devel/20240813033145.279307-1-xiaoyao.li@intel.com/
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0716dbe5934..26dc5b6a6a8c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9195,6 +9195,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


