Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA55C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9n-0006GG-PG; Sat, 03 Feb 2024 04:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9m-0006G6-6y
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:50 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9k-0001Wo-M4
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951869; x=1738487869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=868VAJN89eGkinOq4EOD+Tl9/QzBYeTq2J6+WiPTTIA=;
 b=bbJTLblXoKRA2p1Ni5UbMuuHn4RNuSpuX4hVlvingkJ8MNH/xFrj7HjR
 h5NnoS7pC63Zso/xt5nSCLosYBHOihdigmXpRWyUfzcOWuEIu7nwjCu8C
 G8JE8HuiLUtq0uqpAM76XX2UJn4i9jcqcd2bdyaDVBllMDI6LpcUf+NYb
 W0yjTXiWniN5gaZrS/4Ganx7g5bYePeGS1kCCx2/tOnU93zZnwJiKnHGZ
 e1Z5ZPfPQFkUtcyN4iODzhyHUNhLRIGPOWHtJBNondPnQmgh9GhA4Au/y
 lXWcoYgs48sT+Gr1EJKu24qke4zMP6ldsm2V5uwyvF24lwZXOXaqE9WNZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216390"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216390"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31379033"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:38 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 6/6] i386: Add a new property to set ITD related feature bits
 for Guest
Date: Sat,  3 Feb 2024 17:30:54 +0800
Message-Id: <20240203093054.412135-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
References: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
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

The property enable-itd will be used to set ITD related feature bits
for Guest, which includes PTS, HFI, ITD and HRESET.

Now PTS, HFI, ITD and HRESET are marked as no_autoenable_flags, since
PTS, HFI and ITD have additional restrictions on CPU topology, and
HRESET is only used in ITD case. If user wants to enable ITD for Guest,
he need to specify PTS, HFI, ITD and HRESET explicitly in the -cpu
command.

Thus it's necessary to introduce "-cpu enable-itd" to help set these
feature bits.

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 20 +++++++++++++++-----
 target/i386/cpu.h |  3 +++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b26b471b861..070f7ff43a1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7304,6 +7304,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     x86_cpu_hyperv_realize(cpu);
 
+    if (cpu->enable_itd) {
+        env->features[FEAT_6_EAX] |= CPUID_6_EAX_PTS | CPUID_6_EAX_HFI |
+                                     CPUID_6_EAX_ITD;
+        env->features[FEAT_7_1_EAX] |= CPUID_7_1_EAX_HRESET;
+    }
+
     x86_cpu_expand_features(cpu, &local_err);
     if (local_err) {
         goto out;
@@ -7494,22 +7500,25 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (env->features[FEAT_6_EAX] & CPUID_6_EAX_PTS && ms->smp.sockets > 1) {
         error_setg(errp,
-                   "PTS currently only supports 1 package, "
-                   "please set by \"-smp ...,sockets=1\"");
+                   "%s currently only supports 1 package, "
+                   "please set by \"-smp ...,sockets=1\"",
+                   cpu->enable_itd ? "enable-itd" : "PTS");
         return;
     }
 
     if (env->features[FEAT_6_EAX] & (CPUID_6_EAX_HFI | CPUID_6_EAX_ITD) &&
         (ms->smp.dies > 1 || ms->smp.sockets > 1)) {
         error_setg(errp,
-                   "HFI/ITD currently only supports die/package, "
-                   "please set by \"-smp ...,sockets=1,dies=1\"");
+                   "%s currently only supports 1 die/package, "
+                   "please set by \"-smp ...,sockets=1,dies=1\"",
+                   cpu->enable_itd ? "enable-itd" : "HFI/ITD");
         return;
     }
 
     if (env->features[FEAT_6_EAX] & (CPUID_6_EAX_PTS | CPUID_6_EAX_HFI) &&
         !(env->features[FEAT_6_EAX] & CPUID_6_EAX_ITD)) {
-        error_setg(errp,
+        error_setg(errp, "%s", cpu->enable_itd ?
+                   "Host doesn't support ITD" :
                    "In the absence of ITD, Guest does "
                    "not need PTS/HFI");
         return;
@@ -8003,6 +8012,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
+    DEFINE_PROP_BOOL("enable-itd", X86CPU, enable_itd, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a68c9d8a8660..009ec66dead0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2071,6 +2071,9 @@ struct ArchCPU {
     int32_t hv_max_vps;
 
     bool xen_vapic;
+
+    /* Set ITD and related feature bits (PTS, HFI and HRESET) for Guest. */
+    bool enable_itd;
 };
 
 typedef struct X86CPUModel X86CPUModel;
-- 
2.34.1


