Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F4C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 02:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucECW-0003fd-5V; Wed, 16 Jul 2025 22:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucECO-0003Yl-W1
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 22:18:20 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucECM-0004lK-2t
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 22:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752718694; x=1784254694;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uJR2/wouJJ8RqqxW6tAsCafKZhx6045fKFnShVBIPW4=;
 b=ZBd6IG14hzVZR/zZQmeUsJZoLkx+i9q3rHy/VgFDuwT4CniKgXadsgpY
 iiIfvKP/mh4mlQJ1nLQtcJl2lO1SxkJVmhUt9Ldd++r2F4n7h7W1XmMnn
 wmhUJhob39ebUPL1ovqacc9UypMje/3kBIjYLT+O9X6QzG4o0I8aMvj/m
 VMCZfO401tUS8djcEPOBAAUoxoRnoPkIMWjcGcot65Tb3Z4fYXbBlh1zD
 g/cqdms1XX2XW/SeKEjgGuzJLVbQFf8GV5SWkhAo6jdENhx1WI1EZoMze
 mysotDlktR1l5qdieyYfb/AHGQPtImZyiEeTGjvDB5RcF1uvtdBUMkmpo Q==;
X-CSE-ConnectionGUID: Hk56oc0mS2+j5N1ytbNPHg==
X-CSE-MsgGUID: bL7ssqAqTPmAUnzZ8df+ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80428163"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="80428163"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 19:18:11 -0700
X-CSE-ConnectionGUID: JFJSHF74TWqtd2BlJCN7kg==
X-CSE-MsgGUID: Cnb1fhfhRG2caE8WPZWWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="157061967"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 16 Jul 2025 19:18:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH for v10.1] i386/cpu: Move x86_ext_save_areas[] initialization
 to .instance_init
Date: Thu, 17 Jul 2025 10:39:33 +0800
Message-Id: <20250717023933.2502109-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

In x86_cpu_post_initfn(), the initialization of x86_ext_save_areas[]
marks the unsupported xsave areas based on Host support.

This step must be done before accel_cpu_instance_init(), otherwise,
KVM's assertion on host xsave support would fail:

qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.

(on AMD EPYC 7302 16-Core Processor)

Move x86_ext_save_areas[] initialization to .instance_init and place it
before accel_cpu_instance_init().

Fixes: commit 5f158abef44c ("target/i386: move accel_cpu_instance_init to .instance_init")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index da7d8dca633e..251d5760a0bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9619,6 +9619,16 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
 }
 
 static void x86_cpu_post_initfn(Object *obj)
+{
+#ifndef CONFIG_USER_ONLY
+    if (current_machine && current_machine->cgs) {
+        x86_confidential_guest_cpu_instance_init(
+            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
+    }
+#endif
+}
+
+static void x86_cpu_init_xsave(void)
 {
     static bool first = true;
     uint64_t supported_xcr0;
@@ -9639,13 +9649,6 @@ static void x86_cpu_post_initfn(Object *obj)
             }
         }
     }
-
-#ifndef CONFIG_USER_ONLY
-    if (current_machine && current_machine->cgs) {
-        x86_confidential_guest_cpu_instance_init(
-            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
-    }
-#endif
 }
 
 static void x86_cpu_init_default_topo(X86CPU *cpu)
@@ -9715,6 +9718,11 @@ static void x86_cpu_initfn(Object *obj)
         x86_cpu_load_model(cpu, xcc->model);
     }
 
+    /*
+     * accel's cpu_instance_init may have the xsave check,
+     * so x86_ext_save_areas[] must be initialized before this.
+     */
+    x86_cpu_init_xsave();
     accel_cpu_instance_init(CPU(obj));
 }
 
-- 
2.34.1


