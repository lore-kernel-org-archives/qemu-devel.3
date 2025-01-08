Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F4DE7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXHH-0001Km-El; Wed, 08 Jan 2025 09:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXHF-0001K7-9e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:43:21 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXHD-0008MI-EM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736347400; x=1767883400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=roMx6NLgvG1w2UZlck/tSjXRrw4hdWLyk6vWSzvqPQI=;
 b=F07taqnZcrR7tksO7D06M/OKwoU3csEiYj8EfaB4kbmiyJJi/dBz9Ul5
 rKQmGYOFY49zoM7g1G3Ti5bpW1SuTAEvC2MrNN4iJir2HwZQAsRoOAU1x
 fTTZCpYHYvURTfkMvrTvS6Exnxu5j4SpGt2LYUBwEFJgPA+2fxLNcuZ3t
 lk292MwpkSATekCKTA3dr5S6KxWTljTsspv47JeBFL03Syks9oUw+EZzS
 6kieNPfa2yleNN6NZ49jjLrRA/3bxJ+CIgljOCIro+XhBrDp8wotKs7Eo
 1wkuB9B0aLoimYvD2dB5S/EKH/VTQHSSgA7+8SL023m0+Yrqz6fXG3e3D w==;
X-CSE-ConnectionGUID: AO9UCz9hSdO1Lf3fGSdcUg==
X-CSE-MsgGUID: +wDxJLB3QA+El95FvktfLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36737350"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; d="scan'208";a="36737350"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 06:43:17 -0800
X-CSE-ConnectionGUID: 2i5G/sg9RIKwJW2uz0Nc0A==
X-CSE-MsgGUID: 59Xo8U8iTim5ohGRbQs+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="103969389"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 08 Jan 2025 06:43:13 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 1/5] hw/core/machine: Reject thread level cache
Date: Wed,  8 Jan 2025 23:01:46 +0800
Message-Id: <20250108150150.1258529-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108150150.1258529-1-zhao1.liu@intel.com>
References: <20250108150150.1258529-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Currently, neither i386 nor ARM have real hardware support for per-
thread cache, and there is no clear demand for this specific cache
topology.

Additionally, since supporting this special cache topology on ARM
requires extra effort [1], it is unnecessary to support it at this
moment, even though per-thread cache might have potential scheduling
benefits for VMs without CPU affinity.

Therefore, disable thread-level cache topology in the general machine
part. At present, i386 has not enabled SMP cache, so disabling the
thread parameter does not pose compatibility issues.

In the future, if there is a clear demand for this feature, the correct
approach would be to add a new control field in MachineClass.smp_props
and enable it only for the machines that require it.

[1]: https://lore.kernel.org/qemu-devel/Z3efFsigJ6SxhqMf@intel.com/#t

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since Patch v6:
 * New commit to reject "thread" parameter when parse smp-cache.
---
 hw/core/machine-smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index b954eb849027..4e020c358b66 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -321,6 +321,13 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
 
+        if (props->topology == CPU_TOPOLOGY_LEVEL_THREAD) {
+            error_setg(errp,
+                       "%s level cache not supported by this machine",
+                       CpuTopologyLevel_str(props->topology));
+            return false;
+        }
+
         if (!machine_check_topo_support(ms, props->topology, errp)) {
             return false;
         }
-- 
2.34.1


