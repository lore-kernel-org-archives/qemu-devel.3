Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ADC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnePU-0003vI-JK; Thu, 27 Feb 2025 08:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1tneGy-0000Pz-9v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:49:56 -0500
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=smtp.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1tneGw-0006Pd-Ip
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:49:56 -0500
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 7510D401E4;
 Thu, 27 Feb 2025 13:49:48 +0000 (GMT)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
Subject: [PATCH v7 04/16] hw/i386: Add igvm-cfg object and processing for IGVM
 files
Date: Thu, 27 Feb 2025 13:49:20 +0000
Message-ID: <2d087903ec45e1568f205f41c08e754f0a72d446.1740663410.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=smtp.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Feb 2025 08:58:26 -0500
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

An IGVM file contains configuration of guest state that should be
applied during configuration of the guest, before the guest is started.

This patch allows the user to add an igvm-cfg object to an X86 machine
configuration that allows an IGVM file to be configured that will be
applied to the guest before it is started.

If an IGVM configuration is provided then the IGVM file is processed at
the end of the board initialization, before the state transition to
PHASE_MACHINE_INITIALIZED.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/i386/pc.c          | 12 ++++++++++++
 hw/i386/pc_piix.c     | 10 ++++++++++
 hw/i386/pc_q35.c      | 10 ++++++++++
 include/hw/i386/x86.h |  3 +++
 qemu-options.hx       | 28 ++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 22641e6ddc..028c1352e3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1852,6 +1852,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+
+#if defined(CONFIG_IGVM)
+    object_class_property_add_link(oc, "igvm-cfg",
+                                   TYPE_IGVM_CFG,
+                                   offsetof(X86MachineState, igvm),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "igvm-cfg",
+                                          "Set IGVM configuration");
+#endif
+
+
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adc..dcdd11b037 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -360,6 +360,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697..663d310e58 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -324,6 +324,16 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..a18473cf94 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -25,6 +25,7 @@
 #include "hw/intc/ioapic.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
+#include "system/igvm-cfg.h"
 
 struct X86MachineClass {
     /*< private >*/
@@ -97,6 +98,8 @@ struct X86MachineState {
      * which means no limitation on the guest's bus locks.
      */
     uint64_t bus_lock_ratelimit;
+
+    IgvmCfg *igvm;
 };
 
 #define X86_MACHINE_SMM              "smm"
diff --git a/qemu-options.hx b/qemu-options.hx
index 61270e3206..b861d49f09 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5964,6 +5964,34 @@ SRST
                  -machine ...,memory-encryption=sev0 \\
                  .....
 
+    ``-object igvm-cfg,file=file``
+        Create an IGVM configuration object that defines the initial state
+        of the guest using a file in that conforms to the Independent Guest
+        Virtual Machine (IGVM) file format.
+
+        This is currently only supported by ``-machine q35`` and
+        ``-machine pc``.
+
+        The ``file`` parameter is used to specify the IGVM file to load.
+        When provided, the IGVM file is used to populate the initial
+        memory of the virtual machine and, depending on the platform, can
+        define the initial processor state, memory map and parameters.
+
+        The IGVM file is expected to contain the firmware for the virtual
+        machine, therefore an ``igvm-cfg`` object cannot be provided along
+        with other ways of specifying firmware, such as the ``-bios``
+        parameter on x86 machines.
+
+        e.g to launch a machine providing the firmware in an IGVM file
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object igvm-cfg,id=igvm0,file=bios.igvm \\
+                 -machine ...,igvm-cfg=igvm0 \\
+                 .....
+
     ``-object authz-simple,id=id,identity=string``
         Create an authorization object that will control access to
         network services.
-- 
2.43.0


