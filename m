Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C76EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuZh-0008GQ-7m; Tue, 27 Feb 2024 05:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuZa-0007fa-Bi
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:20:30 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuZX-0003fW-Ni
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709029227; x=1740565227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=94A+0Dhq4Gd+PpH+iUdO1QmSMT3xAwKXuiEMwyR9pak=;
 b=LLxyB9J+msQSoGc4U4ogvCFlnPQxJAtqu/f5VEFwTrl1l5BCMdUyDfW6
 +mFPAV4e+OjaEYRt8UzWjKGITwWG6XgX59c5wo3Sv52qn3xeFFgHhPkMa
 U65g19HJU9hI4xmhL/ACD2pF5ih1q+YlOr4KRZbwjP92GBUa5ETIjdKU4
 gBgShKjbpo8f0rhy2QZYd9vFyL+wogz/u/mAiTlBD/4CjDfYgETqKsr8g
 Und+ZBTHERspYRqey0VEmP9SYgXBIGkVAczyLrKcU68Y+LxsCjIr10K03
 Eeo1QeWyV8YmUz+JJQgYZrAKnSO268yrC4eA10wxmiuEpGm1eEuoJ9358 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6310438"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6310438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 02:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6955125"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2024 02:20:07 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v9 16/21] i386/cpu: Introduce module-id to X86CPU
Date: Tue, 27 Feb 2024 18:32:26 +0800
Message-Id: <20240227103231.1556302-17-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Introduce module-id to be consistent with the module-id field in
CpuInstanceProperties.

Following the legacy smp check rules, also add the module_id validity
into x86_cpu_pre_plug().

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * Introduced module_id instead of cluster_id.
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v6:
 * Updated the comment when check cluster-id. Since there's no
   v8.2, the cluster-id support should at least start from v9.0.

Changes since v5:
 * Updated the comment when check cluster-id. Since current QEMU is
   v8.2, the cluster-id support should at least start from v8.3.

Changes since v3:
 * Used the imperative in the commit message. (Babu)
---
 hw/i386/x86.c     | 33 +++++++++++++++++++++++++--------
 target/i386/cpu.c |  2 ++
 target/i386/cpu.h |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 33063ce3888b..040cb51a60d7 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -343,6 +343,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
             cpu->die_id = 0;
         }
 
+        /*
+         * module-id was optional in QEMU 9.0 and older, so keep it optional
+         * if there's only one module per die.
+         */
+        if (cpu->module_id < 0 && ms->smp.modules == 1) {
+            cpu->module_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
@@ -359,6 +367,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                        cpu->die_id, ms->smp.dies - 1);
             return;
         }
+        if (cpu->module_id < 0) {
+            error_setg(errp, "CPU module-id is not set");
+            return;
+        } else if (cpu->module_id > ms->smp.modules - 1) {
+            error_setg(errp, "Invalid CPU module-id: %u must be in range 0:%u",
+                       cpu->module_id, ms->smp.modules - 1);
+            return;
+        }
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
             return;
@@ -378,16 +394,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
         topo_ids.pkg_id = cpu->socket_id;
         topo_ids.die_id = cpu->die_id;
+        topo_ids.module_id = cpu->module_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-
-        /*
-         * TODO: This is the temporary initialization for topo_ids.module_id to
-         * avoid "maybe-uninitialized" compilation errors. Will remove when
-         * X86CPU supports module_id.
-         */
-        topo_ids.module_id = 0;
-
         cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
@@ -432,6 +441,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->die_id = topo_ids.die_id;
 
+    if (cpu->module_id != -1 && cpu->module_id != topo_ids.module_id) {
+        error_setg(errp, "property module-id: %u doesn't match set apic-id:"
+            " 0x%x (module-id: %u)", cpu->module_id, cpu->apic_id,
+            topo_ids.module_id);
+        return;
+    }
+    cpu->module_id = topo_ids.module_id;
+
     if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
             " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f27249df5b52..363bd9a3bebc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7940,12 +7940,14 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, 0),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
 #else
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, -1),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f77b3dd66cb0..fc5859045e0c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2051,6 +2051,7 @@ struct ArchCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t die_id;
+    int32_t module_id;
     int32_t core_id;
     int32_t thread_id;
 
-- 
2.34.1


