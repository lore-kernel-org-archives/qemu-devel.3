Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT6T2-00007E-P6; Mon, 16 Nov 2026 18:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6T0-00006W-V6
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:30 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6Sy-0005Cj-U9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:30 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7C18948662;
 Tue, 17 Nov 2026 00:50:18 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH for-12.0 1/2] hw/i386/microvm: make the default CPU model
 version a class field
Date: Tue, 17 Nov 2026 00:30:13 +0100
Message-ID: <20261116235010.3622909-2-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
References: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794873015950
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

microvm resolves CPU model names without a version, like
"Cascadelake-Server", to the latest version known to the QEMU binary.
Store this choice in MicrovmMachineClass, like PCMachineClass does, in
preparation for versioned microvm machine types, which need a fixed
version for a stable guest CPU.

No functional change intended.

Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 hw/i386/microvm.c         | 4 +++-
 include/hw/i386/microvm.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 18983a363b..ae22bdf433 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -479,6 +479,7 @@ static void microvm_powerdown_req(Notifier *notifier, void *data)
 
 static void microvm_machine_state_init(MachineState *machine)
 {
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_GET_CLASS(machine);
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
 
@@ -492,7 +493,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init(x86ms, mmc->default_cpu_version);
 
     microvm_devices_init(mms);
 }
@@ -630,6 +631,7 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mmc->x86_load_linux = x86_load_linux;
+    mmc->default_cpu_version = CPU_VERSION_LATEST;
 
     mc->init = microvm_machine_state_init;
 
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 5d5eacd1c6..3903c27c3a 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -80,6 +80,9 @@ struct MicrovmMachineClass {
                                                   DeviceState *dev);
     void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
                            int acpi_data_size);
+
+    /* Default CPU model version. See x86_cpu_set_default_version(). */
+    int default_cpu_version;
 };
 
 struct MicrovmMachineState {
-- 
2.47.3



