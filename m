Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4E8E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWG4N-0002CB-LL; Fri, 10 Jan 2025 09:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4M-0002Bl-Cc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4I-0006dZ-0d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736519578; x=1768055578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XxcawsJjwt0uXtrUPQPiiDtVrQo5u15mRughzFtF3CA=;
 b=VUoMvHI4rNKdCw/dbHfbm4bsC/qErDcVUTl+FOK1W2pu47a8EABikNSH
 rTFawPyH0xLYhW5BYcG90fzaDAriJNxYQ9xBGVpAXl/8Oc+wCi2D+4c75
 NwRXxayXe3BF8zpQ+X8xqdfu+HTSP6pSuadXBiDob1cYbg0hR05+KVvwB
 MqiYQ35JhL6segUlgenyz8slOPAwp/lBjRWWTdAhSLQQoNP2MTAsDbm2R
 2lb9K/6h5fyB/nz7k/OaAlOLzsPu0gjSCgNhZX6W2xeMIlZXXG8ktMBDf
 4ZS/31LYHHE1wBXh6JXtKdN5XSlaZ5sAX+FiWgY4vDI9f839vMww4BLiY A==;
X-CSE-ConnectionGUID: tFN+LN9RQfqhROrT+H3UJw==
X-CSE-MsgGUID: NHl9b7N+S9uwEbcmDIBHRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62185496"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="62185496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 06:32:53 -0800
X-CSE-ConnectionGUID: PR4HNW4MTkajG7vPAYKR3A==
X-CSE-MsgGUID: /U+Vy3fNTjKRlYyQ4MXoEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="108790809"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Jan 2025 06:32:50 -0800
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
Subject: [PATCH v7 RESEND 1/5] hw/core/machine: Reject thread level cache
Date: Fri, 10 Jan 2025 22:51:11 +0800
Message-Id: <20250110145115.1574345-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110145115.1574345-1-zhao1.liu@intel.com>
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Currently, neither i386 nor ARM have real hardware support for per-
thread cache, and there is no clear demand for this specific cache
topology.

Additionally, since ARM even can't support this special cache topology
in device tree, it is unnecessary to support it at this moment, even
though per-thread cache might have potential scheduling benefits for
VMs without CPU affinity.

Therefore, disable thread-level cache topology in the general machine
part. At present, i386 has not enabled SMP cache, so disabling the
thread parameter does not pose compatibility issues.

In the future, if there is a clear demand for this feature, the correct
approach would be to add a new control field in MachineClass.smp_props
and enable it only for the machines that require it.

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


