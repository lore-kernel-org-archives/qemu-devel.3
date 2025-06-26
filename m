Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A747C7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhgZ-0002AS-D2; Thu, 26 Jun 2025 04:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgW-000287-BP
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:16 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgS-0006aX-7Y
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750925412; x=1782461412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TXrg2Ggm8g3BZvlmS1ahWoo2Bu1wFVEK5fneLW/jRdE=;
 b=eRFJ+I3xhpP8qpgKGC6QuKVPLgeCSoHjtHHW0wcGV2wd6aO521xJMSsi
 sdlQlBkIYbdvUmbi77vLnvJ5bF+n0X84tVy+wLg38FPIjY0MpWeuRhUNq
 tSurQwFBjGTiy+giXonSYajKd2hroijJ7o5+14mIthOPaLL8ljaWY9BwI
 BgSZlpQZU/sKND6O4qECiMUu4L8iNvRN6N3/GlMcynqE4Ubw8F1t62Br/
 gskkkL8L6XxjmDCEs5kGbsVPlRfriVgTY3gwTQOqz8/1H9BB4D80JoCtY
 MSaZovjF9BQ9zmVfrMWL1lQBL4CSPi16aWU3p6agpnP6IPVB81Q5ey5iF A==;
X-CSE-ConnectionGUID: 8XXNNsJwQPu6vdRgglaZpQ==
X-CSE-MsgGUID: SufeMoxES9mZdwDOt7TopQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63902106"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="63902106"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:10:11 -0700
X-CSE-ConnectionGUID: upNc2akQRKOqpSfeZZw8vw==
X-CSE-MsgGUID: mOuKrrQRSU+JVHvsh9tZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152949925"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 01:10:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
Date: Thu, 26 Jun 2025 16:31:02 +0800
Message-Id: <20250626083105.2581859-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626083105.2581859-1-zhao1.liu@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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
index 08c84ba90f52..ee36f7ee2ccc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9934,6 +9934,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


