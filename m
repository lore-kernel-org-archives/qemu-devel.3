Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB3FC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 20:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAb6H-0002Gb-7g; Fri, 24 May 2024 16:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb67-0002AO-VX; Fri, 24 May 2024 16:01:05 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb64-00051T-9q; Fri, 24 May 2024 16:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716580860; x=1748116860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pa1xGnNT8/923n1FNJFTnDx3aYnMbMwudAm7e6bIlhU=;
 b=QWgMKETEyPlt6hlTSHV5FmQb28ZO/xc1oZ1UdKpiijUBOc4PyyD4sH3n
 LzKp8FT5IIZ67Ehs3TS++FGUTGMuRlFSwBXnz17GPh6rOXU2igcujPjLz
 Wlvw6fiMbBtTKrjbOri3RUgJzOy8jiPCb8y1I8NKOVU0UJFGlyaMSeKEC
 lH7inDwM4niaFQHiy6rn7HQiJKra5EKkIgn+uK1ljJUJROEQRKi7B7iWp
 bod8Kve4G8MCuyQPeGKFysNn5vF3yVaXl+Oyqs5JJYAEn9aYK8A8SU0ex
 68Vl3kxMLoF5yr25gYQfNAV/1aZIX91a4TIJQ1th8gypMYuHW4ietq9wJ A==;
X-CSE-ConnectionGUID: frdOGVmgTeC88/hHEVFimw==
X-CSE-MsgGUID: xpMK7CPUTSieTd+DgWTEug==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="15918266"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="15918266"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:46 -0700
X-CSE-ConnectionGUID: R987icKQR22Acv/yRV1Dkg==
X-CSE-MsgGUID: 8ohV8JULSo+ZYahDIuu+ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="39108910"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:46 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org,
 Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
Date: Fri, 24 May 2024 13:00:16 -0700
Message-Id: <20240524200017.150339-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524200017.150339-1-zide.chen@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

cpu_exec_realizefn which calls the accel-specific realizefn may expand
features.  e.g., some accel-specific options may require extra features
to be enabled, and it's appropriate to expand these features in accel-
specific realizefn.

One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.

Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
that it won't expose features not supported by the host.

Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.c         | 24 ++++++++++++------------
 target/i386/kvm/kvm-cpu.c |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647fa..a1c1c785bd2f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    /*
+     * note: the call to the framework needs to happen after feature expansion,
+     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
+     * These may be set by the accel-specific code,
+     * and the results are subsequently checked / assumed in this function.
+     */
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
 
     if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
@@ -7625,18 +7637,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     x86_cpu_set_sgxlepubkeyhash(env);
 
-    /*
-     * note: the call to the framework needs to happen after feature expansion,
-     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
-     * These may be set by the accel-specific code,
-     * and the results are subsequently checked / assumed in this function.
-     */
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         g_autofree char *name = x86_cpu_class_get_model_name(xcc);
         error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index f76972e47e61..3adcedf0dbc3 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -50,7 +50,6 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * nothing else has been set by the user (or by accelerators) in
      * cpu->ucode_rev and cpu->phys_bits, and updates the CPUID results in
      * mwait.ecx.
-     * This accel realization code also assumes cpu features are already expanded.
      *
      * realize order:
      *
-- 
2.34.1


