Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E2D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTR8-0001J4-Un; Tue, 02 Dec 2025 11:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQw-00013c-47
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:59 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQt-0002BI-IW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693655; x=1796229655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yma8Elypab7lSdreYaeRchfYeGC+2elRnGnxOQ2FVyQ=;
 b=imvZ0kak9g3p4jEpRvoTa0NL1CUqBvPyHCi2GlBUxgypCKCTlDRFmyP2
 2IaK72DbFhZx/2tTKBQ4nv2pN5vUypgbhbqQzL8LzsEGXEa8O6CjDMg35
 mxAEZzTyQ1dMsFBa111kTGA395tC1ELHziFMEnLtGue4sKkdltfzcGNx/
 qAv9ZX927kD3zOJ5q7LT1q8tIi88v/m4iLO/Tg4k0l4QcH38RFlr1f47Q
 3fiuyRG0qF0/P2lNq2oZv9SHiY4RwP12Dh1UNUiRuewQZTmH/xIk51aRC
 CzgPlYcAnTME6jG+DvJK3S6SM/9NBsSNYfVEltlOI2wOQuSWO1gJEXzw1 A==;
X-CSE-ConnectionGUID: zg62bnBVTauoSgw7PcAXew==
X-CSE-MsgGUID: +KjFaSGiQhO3KRmJiKAwFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555381"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555381"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:54 -0800
X-CSE-ConnectionGUID: oIiajSjiRLaglhAyNlQ1gw==
X-CSE-MsgGUID: NjD/+LT5Qy+0D3kUmtd12w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751372"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:51 -0800
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
Subject: [RFC 08/10] target/i386: Deprecate fill-mtrr-mask property
Date: Wed,  3 Dec 2025 01:05:00 +0800
Message-Id: <20251202170502.3228625-9-zhao1.liu@intel.com>
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

"fill-mtee-mask" was previously disabled only on PC-Q35-2.6 and
PC-I440FX-2.6 machines, but PC v2.6 machines have been removed.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 target/i386/cpu.c         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 9386cffba26d..c60924b4f313 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -487,6 +487,14 @@ Backend ``memory`` (since 9.0)
 CPU device properties
 '''''''''''''''''''''
 
+``fill-mtrr-mask`` on x86 (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``fill-mtrr-mask=true`` fill the bits between 51..number-of-physical-address
+-bits in the MTRR_PHYSMASKn variable range mtrr masks. It was previously set to
+false only on PC-Q35-2.6 and PC-I440FX-2.6 machines, but PC v2.6 machines have
+been removed. Deprecate this property to stop external use.
+
 ``pmu-num=n`` on RISC-V CPUs (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72c69ba81c1b..1f0a8cb6cec1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9997,7 +9997,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
-    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
+    DEFINE_PROP_BOOL_DEPRECATED("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
     DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
                        UINT32_MAX),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
-- 
2.34.1


