Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D43E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWG4R-0002EA-BX; Fri, 10 Jan 2025 09:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4P-0002DF-0B
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:05 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4N-0006dZ-7H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736519583; x=1768055583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4zIiyRBJx2uUEgy/m5M23r7WgU1QXI3Eb0MeZznc3Pk=;
 b=l+hwbVwgwVeDAZRER/MsM29GASjBVWgasWzJpYNgO3LhUq6CI1GpiNx9
 eATQOuj2+qCKyqwCbYFXOLrTXjfW3qQrUVzwJraiv6MVU4I67u2Y+8S/Z
 9yEdSc/p3U+BSX5s/Dn3PYo78I258q51y1qfNuuwARyjuuaXy5kpdO91o
 UyPJJTNzWvQZamCuaBGKoakwJMLnwcKwiD6Xj1T5ANtmY6XZQz4qW/Ryu
 ke0hjaWkaIASZHQ6XKFLtnKGKWxz5HnI/VgeZR1C3HWMN0TW8H6y9LlsD
 qIMEWNXZG5rh+pim3Lf6dHdXP/j7mguJ5vd4me+9WVYYPwFKY9hs/ldKN Q==;
X-CSE-ConnectionGUID: VYZNccc5TpCwiCi39rOrUg==
X-CSE-MsgGUID: 4N4UpR0yRHea0HckE3NOtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62185523"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="62185523"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 06:33:02 -0800
X-CSE-ConnectionGUID: 5uvsCvEhStiwdcSy6Bcagg==
X-CSE-MsgGUID: bNUJw0NfRi2Q7V2MmXdSoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="108790869"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Jan 2025 06:32:58 -0800
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
Subject: [PATCH v7 RESEND 3/5] i386/cpu: Update cache topology with machine's
 configuration
Date: Fri, 10 Jan 2025 22:51:13 +0800
Message-Id: <20250110145115.1574345-4-zhao1.liu@intel.com>
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

User will configure smp cache topology via -machine smp-cache.

For this case, update the x86 CPUs' cache topology with user's
configuration in MachineState.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v3:
 * Updated MachineState.smp_cache to consume "default" level and did a
   check to ensure topological hierarchical relationships are correct.
---
 target/i386/cpu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4728373fdf03..b6d6c4b96d49 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7758,6 +7758,64 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
     cpu->hyperv_limits[2] = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
+                                          Error **errp)
+{
+    CPUX86State *env = &cpu->env;
+    CpuTopologyLevel level;
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l1d_cache->share_level = level;
+        env->cache_info_amd.l1d_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
+            env->cache_info_cpuid4.l1d_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
+            env->cache_info_amd.l1d_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l1i_cache->share_level = level;
+        env->cache_info_amd.l1i_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
+            env->cache_info_cpuid4.l1i_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
+            env->cache_info_amd.l1i_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l2_cache->share_level = level;
+        env->cache_info_amd.l2_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
+            env->cache_info_cpuid4.l2_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
+            env->cache_info_amd.l2_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l3_cache->share_level = level;
+        env->cache_info_amd.l3_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
+            env->cache_info_cpuid4.l3_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
+            env->cache_info_amd.l3_cache->share_level);
+    }
+
+    if (!machine_check_smp_cache(ms, errp)) {
+        return false;
+    }
+    return true;
+}
+#endif
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -7982,6 +8040,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
+
+    /*
+     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless updates
+     * if user didn't set smp_cache.
+     */
+    if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
+        return;
+    }
+
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-- 
2.34.1


