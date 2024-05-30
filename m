Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01922C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcaq-000342-3t; Thu, 30 May 2024 06:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcao-000322-Bo; Thu, 30 May 2024 06:01:06 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcac-0003Sx-LQ; Thu, 30 May 2024 06:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717063255; x=1748599255;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TkFL4JGvaBtqT8WMIo99wxT4H70mghAQsEG6xdgy1EE=;
 b=eEVbhQs4BY0SOScEijwhBgl0ecneoUsXYEeRAjv+TIFTHtd3TVtqLy1P
 bz2WRembx0y6qR2b3m/n6NsGLnIjvourQYEdEbgzxvkLj3wVGu7fJJyqU
 eYdta969WhRaSk+4w0ZCBwThP/odPPfyJ8im7T9FLBa8CdokwGkK/EmQG
 x/qX6qMLv66IVyeDqGhaRE9qMo4LKU5AsSyuypWTwmJEj2/LVaWec5HBd
 PMXvkycyG/oBmTmmuRPHRRNDR0+x8lsE+CMTrhOtknr/lvoVNvaGVkXNO
 f7y4+tfPIffMvW0zQxtwR3kTsNY2wzzUyXcTF3gM7zlkVLjMgury72hfn A==;
X-CSE-ConnectionGUID: m5BPRUrJTaOxmWtaSSkzqQ==
X-CSE-MsgGUID: eqa7g7l9Rg2c4pKMRV6rnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="31032562"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="31032562"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 03:00:52 -0700
X-CSE-ConnectionGUID: /YQgvYFURk+y03VbFGoVyw==
X-CSE-MsgGUID: DC+EoqJ5R4+XMosDINLHMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="35705107"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 30 May 2024 03:00:47 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 5/7] i386/cpu: Update cache topology with machine's
 configuration
Date: Thu, 30 May 2024 18:15:37 +0800
Message-Id: <20240530101539.768484-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530101539.768484-1-zhao1.liu@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

User will configure SMP cache topology via -smp.

For this case, update the x86 CPUs' cache topology with user's
configuration in MachineState.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3a2dadb4bce0..1bd1860ae625 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7764,6 +7764,27 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->smp_cache.l1d != CPU_TOPO_LEVEL_INVALID) {
+        env->cache_info_cpuid4.l1d_cache->share_level = ms->smp_cache.l1d;
+        env->cache_info_amd.l1d_cache->share_level = ms->smp_cache.l1d;
+    }
+
+    if (ms->smp_cache.l1i != CPU_TOPO_LEVEL_INVALID) {
+        env->cache_info_cpuid4.l1i_cache->share_level = ms->smp_cache.l1i;
+        env->cache_info_amd.l1i_cache->share_level = ms->smp_cache.l1i;
+    }
+
+    if (ms->smp_cache.l2 != CPU_TOPO_LEVEL_INVALID) {
+        env->cache_info_cpuid4.l2_cache->share_level = ms->smp_cache.l2;
+        env->cache_info_amd.l2_cache->share_level = ms->smp_cache.l2;
+    }
+
+    if (ms->smp_cache.l3 != CPU_TOPO_LEVEL_INVALID) {
+        env->cache_info_cpuid4.l3_cache->share_level = ms->smp_cache.l3;
+        env->cache_info_amd.l3_cache->share_level = ms->smp_cache.l3;
+    }
+
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-- 
2.34.1


