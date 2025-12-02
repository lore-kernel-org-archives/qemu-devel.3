Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE5BD11714
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTRA-0001Sd-Hj; Tue, 02 Dec 2025 11:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTR0-0001Ak-Ew
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:41:03 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQy-0002FS-9d
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693660; x=1796229660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UDxIzRjac8HAVpNVM7Gth/kx7qmxF7rXuv/fqinoc9M=;
 b=kldSoRgMFkZAp9eRcpyliIG7Hn6H75TU+/W1dkfxF/l5gbqDfTvcI3Sg
 Z3Nl5wGnMWhH7Uef/4wIbDw4ETg6Bo7JdJInDrevPCDbilfNoABM0yrIi
 fcJei6b0fWsemuX2d4SG1p9RrMak9qcmvsB/ifHWNa6r8m4KKV+x3pdpw
 tgxS7PjqRV/8VWRqdP2qHs8P0EVnQq8HiZCzKMMICB06Df+ex7BZ8X/dq
 FqMyR9vjY1O2XZ7nL683b1Y9DfaMOsvmSPgGyAGZmSSQ9d5WlkO2487Rv
 Jv5vDOR1dlRJ8iHFH24RdtxR8KzuDu+8mmySmMPyQqpIk37DEjt4F2yaJ w==;
X-CSE-ConnectionGUID: Lqgpphw+RquYERFWzOrpNg==
X-CSE-MsgGUID: sYwrfgPYTcWGThkqvdW8dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555403"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:58 -0800
X-CSE-ConnectionGUID: LB7quNABQlSgELC2e530Kg==
X-CSE-MsgGUID: +8Z4E16GSoqlahrS++earA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751422"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:55 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 09/10] target/i386: Deprecate cpuid-0xb property
Date: Wed,  3 Dec 2025 01:05:01 +0800
Message-Id: <20251202170502.3228625-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

"cpuid-0xb" was previously disabled only on PC-Q35-2.6 and
PC-I440FX-2.6 machines, but PC v2.6 machines have been removed.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 target/i386/cpu.c         |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c60924b4f313..741c1a71728b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -495,6 +495,16 @@ The ``fill-mtrr-mask=true`` fill the bits between 51..number-of-physical-address
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
index 1f0a8cb6cec1..ef1ffc4d3d4f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10009,7 +10009,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
-    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL_DEPRECATED("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
-- 
2.34.1


