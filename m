Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84AAC28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKsG-0004EE-Ua; Sat, 15 Mar 2025 02:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrQ-0003JP-Nb; Sat, 15 Mar 2025 02:19:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrN-0003Hg-AB; Sat, 15 Mar 2025 02:19:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93CFCFF9D8;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B2B31CAC41;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4804F558C7; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 12/51] hw/i386/microvm: Fix crash that occurs when
 introspecting the microvm machine
Date: Sat, 15 Mar 2025 09:17:18 +0300
Message-Id: <20250315061801.622606-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to inspect the properties of the
microvm machine:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
           { "typename": "microvm-machine"}}' | \
   ./qemu-system-x86_64 -qmp stdio
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1072-g60af367187-dirty"}, "capabilities": ["oob"]}}
 {"return": {}}
 qemu-system-x86_64: ../qemu/hw/i386/acpi-microvm.c:250:
  void acpi_setup_microvm(MicrovmMachineState *):
   Assertion `x86ms->fw_cfg' failed.
 Aborted (core dumped)

This happens because the microvm machine adds a machine_done (and a
powerdown_req) notifier in their instance_init function - however, the
instance_init of machines are not only called for machines that are
realized, but also for machines that are introspected, so in this case
the listener is added for a microvm machine that is never realized. And
since there is already a running machine, the listener function is
triggered immediately, causing a crash since it was not for the right
machine it was meant for.

Such listener functions must never be installed from an instance_init
function. Let's do it from microvm_machine_state_init() instead - this
function is the MachineClass->init() function instead, i.e. guaranteed
to be only called once in the lifetime of a QEMU process.

Since the microvm_machine_done() and microvm_powerdown_req() were
defined quite late in the microvm.c file, we have to move them now
also earlier, so that we can get their function pointers from
microvm_machine_state_init() without having to introduce a separate
prototype for those functions earlier.

Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250123204708.1560305-1-thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 38ef383073b8ee59d598643160f206a19a46237f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 86637afa0f..a024466ad8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -451,11 +451,44 @@ static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void microvm_machine_done(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            machine_done);
+    X86MachineState *x86ms = X86_MACHINE(mms);
+
+    acpi_setup_microvm(mms);
+    dt_setup_microvm(mms);
+    fw_cfg_add_e820(x86ms->fw_cfg);
+}
+
+static void microvm_powerdown_req(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            powerdown_req);
+    X86MachineState *x86ms = X86_MACHINE(mms);
+
+    if (x86ms->acpi_dev) {
+        Object *obj = OBJECT(x86ms->acpi_dev);
+        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
+        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
+                          ACPI_POWER_DOWN_STATUS);
+    }
+}
+
 static void microvm_machine_state_init(MachineState *machine)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
 
+    /* State */
+    mms->kernel_cmdline_fixed = false;
+
+    mms->machine_done.notify = microvm_machine_done;
+    qemu_add_machine_init_done_notifier(&mms->machine_done);
+    mms->powerdown_req.notify = microvm_powerdown_req;
+    qemu_register_powerdown_notifier(&mms->powerdown_req);
+
     microvm_memory_init(mms);
 
     x86_cpus_init(x86ms, CPU_VERSION_LATEST);
@@ -581,31 +614,6 @@ static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool value,
     mms->auto_kernel_cmdline = value;
 }
 
-static void microvm_machine_done(Notifier *notifier, void *data)
-{
-    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
-                                            machine_done);
-    X86MachineState *x86ms = X86_MACHINE(mms);
-
-    acpi_setup_microvm(mms);
-    dt_setup_microvm(mms);
-    fw_cfg_add_e820(x86ms->fw_cfg);
-}
-
-static void microvm_powerdown_req(Notifier *notifier, void *data)
-{
-    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
-                                            powerdown_req);
-    X86MachineState *x86ms = X86_MACHINE(mms);
-
-    if (x86ms->acpi_dev) {
-        Object *obj = OBJECT(x86ms->acpi_dev);
-        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
-        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
-                          ACPI_POWER_DOWN_STATUS);
-    }
-}
-
 static void microvm_machine_initfn(Object *obj)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
@@ -617,14 +625,6 @@ static void microvm_machine_initfn(Object *obj)
     mms->isa_serial = true;
     mms->option_roms = true;
     mms->auto_kernel_cmdline = true;
-
-    /* State */
-    mms->kernel_cmdline_fixed = false;
-
-    mms->machine_done.notify = microvm_machine_done;
-    qemu_add_machine_init_done_notifier(&mms->machine_done);
-    mms->powerdown_req.notify = microvm_powerdown_req;
-    qemu_register_powerdown_notifier(&mms->powerdown_req);
 }
 
 GlobalProperty microvm_properties[] = {
-- 
2.39.5


