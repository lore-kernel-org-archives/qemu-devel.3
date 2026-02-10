Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E763E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyX-0008Vl-4y; Mon, 09 Feb 2026 21:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyK-00086v-Rs
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:31 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyJ-0004En-25
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692367; x=1802228367;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FzssT/Ir75O6xe5arR/QxgvvLYXw6aFHUgJgDoyi+Mw=;
 b=O2C/5h6L+J/xCyZbIKXZ7ScV78DmXuEBqnUullBNb8JiyJLS28G1geeN
 C0y3nwtsbrsrn/SCa1W7j3q7kfUNuznwA4lg5GkNajAWYkaNfhgT5mcF4
 IsAQFAlPXtkz8xcHT3LjsHJVqs25wxgt9rUU9hfsxSD/pvz/iQdznYJd6
 5WVlj+nVgAiXid/lvMmzAPj+UgItuyPNLJW+zRAzeTyjocgcQ/W06XfGQ
 3x7FXU/qD0rXts8CXoXOEdI9I9fPP0akGqg4s2KX9hIzSc0WnqV27ZGWz
 h++B0xiNnqTCfsbPuQ6J5XdJlJKuO7Gzxz0xsOy8D/878VkRopj2nv13k w==;
X-CSE-ConnectionGUID: WShSdb0fRPO/GcVe2YxasA==
X-CSE-MsgGUID: S8tzyPE+SDKdCRQl3iFlFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659961"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:24 -0800
X-CSE-ConnectionGUID: s6QsOcZURWusmf9pAMQlXA==
X-CSE-MsgGUID: mYGrl1f/SqmV4GCjCAv9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800711"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:21 -0800
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
Subject: [PATCH v2 15/21] target/i386: deprecate fill-mtrr-mask property
Date: Tue, 10 Feb 2026 11:23:42 +0800
Message-Id: <20260210032348.987549-16-zhao1.liu@intel.com>
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

"fill-mtee-mask" was previously disabled only on PC-Q35-2.6 and
PC-I440FX-2.6 machines, but PC v2.6 machines have been deprecated and
will be removed.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 target/i386/cpu.c         | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1d5c4f3707cb..0e8a25e37414 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -448,6 +448,14 @@ Backend ``memory`` (since 9.0)
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
index 94a9dcde1eb1..13ccb1702d32 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10510,7 +10510,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
-    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
+    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true,
+                     .flags = OBJ_PROP_FLAG_DEPRECATED),
     DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
                        UINT32_MAX),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
-- 
2.34.1


