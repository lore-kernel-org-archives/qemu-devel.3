Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BDDC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riddG-0000au-VQ; Fri, 08 Mar 2024 12:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridd8-0000YO-7v
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:34 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridd2-0000mT-RN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:32 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridd0-0006Gp-Ub; Fri, 08 Mar 2024 18:03:26 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] vmbus: Print a warning when enabled without the
 recommended set of features
Date: Fri,  8 Mar 2024 18:02:45 +0100
Message-ID: <6093637b4d32875f98cd59696ffc5f26884aa0b4.1709916836.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709916836.git.maciej.szmigiero@oracle.com>
References: <cover.1709916836.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Some Windows versions crash at boot or fail to enable the VMBus device if
they don't see the expected set of Hyper-V features (enlightenments).

Since this provides poor user experience let's warn user if the VMBus
device is enabled without the recommended set of Hyper-V features.

The recommended set is the minimum set of Hyper-V features required to make
the VMBus device work properly in Windows Server versions 2016, 2019 and
2022.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hyperv.c            | 12 ++++++++++++
 hw/hyperv/vmbus.c             |  6 ++++++
 include/hw/hyperv/hyperv.h    |  4 ++++
 target/i386/kvm/hyperv-stub.c |  4 ++++
 target/i386/kvm/hyperv.c      |  5 +++++
 target/i386/kvm/hyperv.h      |  2 ++
 target/i386/kvm/kvm.c         |  7 +++++++
 7 files changed, 40 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 6c4a18dd0e2a..3ea54ba818b2 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -951,3 +951,15 @@ uint64_t hyperv_syndbg_query_options(void)
 
     return msg.u.query_options.options;
 }
+
+static bool vmbus_recommended_features_enabled;
+
+bool hyperv_are_vmbus_recommended_features_enabled(void)
+{
+    return vmbus_recommended_features_enabled;
+}
+
+void hyperv_set_vmbus_recommended_features_enabled(void)
+{
+    vmbus_recommended_features_enabled = true;
+}
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 380239af2c7b..f33afeeea27d 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2631,6 +2631,12 @@ static void vmbus_bridge_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!hyperv_are_vmbus_recommended_features_enabled()) {
+        warn_report("VMBus enabled without the recommended set of Hyper-V features: "
+                    "hv-stimer, hv-vapic and hv-runtime. "
+                    "Some Windows versions might not boot or enable the VMBus device");
+    }
+
     bridge->bus = VMBUS(qbus_new(TYPE_VMBUS, dev, "vmbus"));
 }
 
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 015c3524b1c2..d717b4e13d40 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -139,4 +139,8 @@ typedef struct HvSynDbgMsg {
 } HvSynDbgMsg;
 typedef uint16_t (*HvSynDbgHandler)(void *context, HvSynDbgMsg *msg);
 void hyperv_set_syndbg_handler(HvSynDbgHandler handler, void *context);
+
+bool hyperv_are_vmbus_recommended_features_enabled(void);
+void hyperv_set_vmbus_recommended_features_enabled(void);
+
 #endif
diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 778ed782e6fc..3263dcf05d31 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -52,3 +52,7 @@ void hyperv_x86_synic_reset(X86CPU *cpu)
 void hyperv_x86_synic_update(X86CPU *cpu)
 {
 }
+
+void hyperv_x86_set_vmbus_recommended_features_enabled(void)
+{
+}
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 6825c89af374..f2a3fe650a18 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -149,3 +149,8 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         return -1;
     }
 }
+
+void hyperv_x86_set_vmbus_recommended_features_enabled(void)
+{
+    hyperv_set_vmbus_recommended_features_enabled();
+}
diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index 67543296c3a4..e3982c8f4dd1 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -26,4 +26,6 @@ int hyperv_x86_synic_add(X86CPU *cpu);
 void hyperv_x86_synic_reset(X86CPU *cpu);
 void hyperv_x86_synic_update(X86CPU *cpu);
 
+void hyperv_x86_set_vmbus_recommended_features_enabled(void);
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42970ab046fa..e68cbe929302 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1650,6 +1650,13 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
 
+    /* Skip SynIC and VP_INDEX since they are hard deps already */
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_STIMER) &&
+        hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC) &&
+        hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
+        hyperv_x86_set_vmbus_recommended_features_enabled();
+    }
+
     return 0;
 }
 

