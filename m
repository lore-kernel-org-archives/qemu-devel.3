Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEAFCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBiW-00079m-OF; Fri, 24 Oct 2025 02:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBiV-00079Y-Qy
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:56:03 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBiT-0006eI-KA
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761288962; x=1792824962;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W7ZaPgXUZ/IWG5Zgflot8zEURcD4R2zU18fM23RjKuc=;
 b=Nnwr58RZ1GhEkTWLFn4Nb22xIzZzvXP4R44Q8xd3eZfj6BEPrdDs/zO6
 jdwO+/+EJkW/z2ifq1t+rfVfXHxyq5sMPXly96Z1DZQyFSg0X/mpmhJyO
 knqqlLpzaCKpmi4uTMpwHsDX88vEO88mlh9FGYXOC2SKWwlDaOY9ZC6En
 wt7VXbpmaBvZeRmWVu3vxT7OGA8ePujzWRg75+vlQ8qH7iupMWW0w+Xqf
 wm5QJd6I1hv85apZcDcW/edgsnxDPazHa21QY+a5EWWZdGqRX/IrDkQsD
 VLM1yqU+lVCp8f/GLhyO6Yc9z98+xdla3F7PvcKRWUIPHmViI2B058295 Q==;
X-CSE-ConnectionGUID: 6sL63VHfQ0uAM46fcT457w==
X-CSE-MsgGUID: NngfjNCjT0iqFNepWDBULg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63369848"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63369848"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:55:59 -0700
X-CSE-ConnectionGUID: cBVe/XFERcORWfdSNGMJfw==
X-CSE-MsgGUID: 9+flY793TgqhbOopPdL9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="188747323"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 23 Oct 2025 23:55:58 -0700
Date: Fri, 24 Oct 2025 15:18:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] i386/cpu: Add an option in X86CPUDefinition to control CPUID
 0x1f
Message-ID: <aPsoLx2+2bpW6mWf@intel.com>
References: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
 <20250923021133.190725-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923021133.190725-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

Many Intel and Zhaoxin CPUs enable CPUID 0x1f by default to encode CPU
topology information.

Add the "cpuid_0x1f" option to X86CPUDefinition to allow named CPU
models to configure CPUID 0x1f from the start, thereby forcing 0x1f
to be present for guest.

With this option, there's no need to explicitly add v1 model to an
unversioned CPU model for explicitly enabling the x-force-cpuid-0x1f
property.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 175054fdb322..56c1030a8627 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2307,6 +2307,12 @@ typedef struct X86CPUDefinition {
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
@@ -8092,6 +8098,10 @@ static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
                                  &error_abort);
     }

+    if (def->cpuid_0x1f) {
+        object_property_set_bool(OBJECT(cpu), "x-force-cpuid-0x1f", def->cpuid_0x1f,
+                                 &error_abort);
+    }
     x86_cpu_apply_version_props(cpu, model);

     /*
--
2.34.1



