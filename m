Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D183FE9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyY-0000FE-Hx; Mon, 09 Feb 2026 21:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyN-0008AK-Sn
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:35 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyM-0004En-7G
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692370; x=1802228370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LigRHQwWAD31PQTypxiGTImF+tjLtIXfRGIv8W1lHg8=;
 b=DwHXpFh0GhbX5HZ0hXff4LCTgLmPKJdtsQdN/wNrRRmxetfbCDvC6T9v
 G/MKu4Hdrcu8xGclRX2YpOgp4o3D+YXQTj7TDQwON+T9kURLSC59ldxOd
 OC8Zh0pWFYKN4FpUHCDb6tH1Iiboj/6HbsJjm8lHYMUfwlCFCCTBnIoC8
 +8gK5BT7jy/Xem8LJWytC3q1p7Zd2EfBcmz8nnsGFmuxOSSq3fDnGXN+u
 bBMdVl2/yLoDu/V+4tWat/RdEPMQE70lv/2I7rOFxKVvxMTb0BGKkdMN0
 gQlMrR2K8S7jhkia/QmNZ3CIzmonRHkC6Kp3OxZnWYpB/85Y3PWI06ixG Q==;
X-CSE-ConnectionGUID: VuSjy6bARjGi7ElDw2IqfQ==
X-CSE-MsgGUID: GkTlID+gQWqnR2q9eStaBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659971"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659971"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:29 -0800
X-CSE-ConnectionGUID: 5rPKbzLYRgSPUbhIJMODbg==
X-CSE-MsgGUID: 0StkaQtEQEq/BR7OB0dJ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800723"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 16/21] target/i386: deprecate cpuid-0xb property
Date: Tue, 10 Feb 2026 11:23:43 +0800
Message-Id: <20260210032348.987549-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

"cpuid-0xb" was previously disabled only on PC-Q35-2.6 and
PC-I440FX-2.6 machines, but PC v2.6 machines have been deprecated and
will be removed.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 target/i386/cpu.c         |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0e8a25e37414..fed939b7f042 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -456,6 +456,16 @@ The ``fill-mtrr-mask=true`` fill the bits between 51..number-of-physical-address
 false only on PC-Q35-2.6 and PC-I440FX-2.6 machines, but PC v2.6 machines have
 been removed. Deprecate this property to stop external use.
 
+``cpuid-0xb`` on x86 (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``cpuid-0xb`` is used to control whether to encode CPUID 0xB leaf or not.
+Only legacy x86 CPUs didn't have 0xB leaf, and the ```level``` property can
+control whether CPUID exposes the 0xB leaf and emulate legacy CPUs. This
+property was previously set to false only on PC-Q35-2.6 and PC-I440FX-2.6
+machines, but PC v2.6 machines have been removed. Deprecate this property to
+stop external use.
+
 ``pmu-num=n`` on RISC-V CPUs (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13ccb1702d32..3766d453157b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10523,7 +10523,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
-    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true,
+                     .flags = OBJ_PROP_FLAG_DEPRECATED),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
-- 
2.34.1


