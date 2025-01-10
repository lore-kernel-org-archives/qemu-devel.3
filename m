Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D27E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWG4U-0002Ey-Sx; Fri, 10 Jan 2025 09:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4T-0002Ed-Js
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:09 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4R-0006dZ-Nv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736519587; x=1768055587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GKO6Z3A/2gq1cK4JeQY1dLFLS2g//H2In2c4J8sWf4w=;
 b=EFVkm2O19ncdZrD/HQxjppW1FDy1YXXtOKS9Y1prlrnoyVayQJROB4R5
 PZ4EXTxUwd3dbbW2VB8jilkrkh2HibNLxF+Y0Cx86s/q8VNlJPAfXndf+
 ezhlNyRlCkc81EGgw1qMFear/DosPEm7XMAzIE+35uL4Cp3EPNzHJszKR
 cdGB75ViDyGKwuVx5SRm+AE+tD7cIf6MmfZs7O13CIadZiVlhLftjBBIs
 Mhz006l+8qQ+W/Dl8TEvC3pTxH1PFaAqNWaqjKJuok8eUWtOyhPjnePke
 TOp9NeUk3SoCjkQ1x40zzuUxPtKHKkmzl7rf604CE2ZsqOkK7pLdaTlaU Q==;
X-CSE-ConnectionGUID: c1+747RFS72sEoE2xSsT+g==
X-CSE-MsgGUID: AfmidpzqTv6yjuiFG6PnHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62185533"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="62185533"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 06:33:07 -0800
X-CSE-ConnectionGUID: Y1SdWWLcSFqJKrQcQ/dT4A==
X-CSE-MsgGUID: KaeEoiZoTgekpe3lth96xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="108790913"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Jan 2025 06:33:02 -0800
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v7 RESEND 4/5] i386/pc: Support cache topology in -machine for
 PC machine
Date: Fri, 10 Jan 2025 22:51:14 +0800
Message-Id: <20250110145115.1574345-5-zhao1.liu@intel.com>
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

Allow user to configure l1d, l1i, l2 and l3 cache topologies for PC
machine.

Additionally, add the document of "-machine smp-cache" in
qemu-options.hx.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v6:
 * Deleted the "thread" level from the allowed topology level parameters
   in the doc.

Changes since Patch v3:
 * Described the omitting cache will use "default" level and described
   the default cache topology model of i386 PC machine. (Daniel)
---
 hw/i386/pc.c    |  4 ++++
 qemu-options.hx | 30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 53a2f226d038..b9b83d1936ae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1797,6 +1797,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
diff --git a/qemu-options.hx b/qemu-options.hx
index cc694d3b890c..60894fe2b52b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -39,7 +39,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
-    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
+    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -159,6 +160,33 @@ SRST
         ::
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
+
+    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
+        Define cache properties for SMP system.
+
+        ``cache=cachename`` specifies the cache that the properties will be
+        applied on. This field is the combination of cache level and cache
+        type. It supports ``l1d`` (L1 data cache), ``l1i`` (L1 instruction
+        cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified cache).
+
+        ``topology=topologylevel`` sets the cache topology level. It accepts
+        CPU topology levels including ``core``, ``module``, ``cluster``, ``die``,
+        ``socket``, ``book``, ``drawer`` and a special value ``default``. If
+        ``default`` is set, then the cache topology will follow the architecture's
+        default cache topology model. If another topology level is set, the cache
+        will be shared at corresponding CPU topology level. For example,
+        ``topology=core`` makes the cache shared by all threads within a core.
+        The omitting cache will default to using the ``default`` level.
+
+        The default cache topology model for an i386 PC machine is as follows:
+        ``l1d``, ``l1i``, and ``l2`` caches are per ``core``, while the ``l3``
+        cache is per ``die``.
+
+        Example:
+
+        ::
+
+            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.34.1


