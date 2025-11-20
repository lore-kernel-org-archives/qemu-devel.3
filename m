Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ECDCF8549
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTO-0005Ji-Uo; Thu, 20 Nov 2025 01:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT6-00058B-PG
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT3-0005r2-D7
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621313; x=1795157313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=574zbqZFLl0H5Q58F1V7zuPmhB+LkfNx4Ps2RZbvteM=;
 b=DVwFZPZt4O/ACeje/edf1kSKgPLPqN3GOE+y/CVdq5PA4IIgAwOTFvwE
 DS0J8FAFMPplYh03gdfo6KMk8S2E6cMDmI2RKGS9EB8+aZZZtWJLhHIXy
 qv6e7Be6lfJtqJOGeCDx4y88vsT3dzcXsTVOc5slUNE2jnmr8+qva1UHn
 LeKSdHLKEGcaQC6sXfY/cJEJPhNz1eUUpm2vACTGPMxO1mvZXRSq96g3J
 qwVlpKgsSaIEvPr890LgKmcr+P6iuTVUeKOrkO1euOA2zrfwDmUhZWbsi
 3uzqTUgnE8ZeCLEIrJJJqPoCWkHjQWLtufGhelIAiuP4xVKTwyOPbrktS Q==;
X-CSE-ConnectionGUID: mM5FIMXvTgCU9LBI54ZEwg==
X-CSE-MsgGUID: gpv9T+QCTnS5blIZH0mnRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572556"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572556"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:30 -0800
X-CSE-ConnectionGUID: YMm1LzpRTfuAUcq2JpCDbA==
X-CSE-MsgGUID: 1UYw/PgGSp6RtqBaDb2amg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296130"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:29 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/10] i386/cpu: Add an option in X86CPUDefinition to control
 CPUID 0x1f
Date: Thu, 20 Nov 2025 15:10:27 +0800
Message-Id: <20251120071030.961230-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
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

Many Intel CPUs enable CPUID 0x1f by default to encode CPU topology
information.

Add the "cpuid_0x1f" option to X86CPUDefinition to allow named CPU
models to configure CPUID 0x1f from the start, thereby forcing 0x1f
to be present for guest.

With this option, there's no need to explicitly add v1 model to an
unversioned CPU model for explicitly enabling the x-force-cpuid-0x1f
property.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note: this patch is also inclued in Zhaoxin's series:

https://lore.kernel.org/qemu-devel/20251027102139.270662-2-ewanhai-oc@zhaoxin.com/
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c5f1f5d18d07..143b3e9e0c21 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2313,6 +2313,12 @@ typedef struct X86CPUDefinition {
     int model;
     int stepping;
     uint8_t avx10_version;
+    /*
+     * Whether to present CPUID 0x1f by default.
+     * If true, encode CPU topology in 0x1f leaf even if there's no
+     * extended topology levels.
+     */
+    bool cpuid_0x1f;
     FeatureWordArray features;
     const char *model_id;
     const CPUCaches *const cache_info;
@@ -8014,6 +8020,10 @@ static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
                                  def->avx10_version, &error_abort);
     }
 
+    if (def->cpuid_0x1f) {
+        object_property_set_bool(OBJECT(cpu), "x-force-cpuid-0x1f",
+                                 def->cpuid_0x1f, &error_abort);
+    }
     x86_cpu_apply_version_props(cpu, model);
 
     /*
-- 
2.34.1


