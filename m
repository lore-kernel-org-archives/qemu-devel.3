Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD5EC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 20:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb46w-0000te-OL; Thu, 23 Jan 2025 15:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tb46o-0000sg-Bv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:47:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tb46h-0008H4-Kg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737665237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fAY/HBWac3Rurnx8j15SbXm0JN1HYIlBDfJQrhlElF4=;
 b=Z1rvnCOhtgLNd76Mk0vhRU/ojjvgvmHJYRvTbnogo0VGeYMLI+fNvsUvH2pfVcswtmy+qZ
 SNqtDWfr9VmvgaMtbnZyhiofAjg2VpYEBxcYPA1IxbESI2vfXo6aT/40LT89rJDLkwcb7D
 /QADXSSA547LRfj/kb8asSaIZi967AY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8HnTAyKtOg2uN5YJGshK1g-1; Thu,
 23 Jan 2025 15:47:16 -0500
X-MC-Unique: 8HnTAyKtOg2uN5YJGshK1g-1
X-Mimecast-MFC-AGG-ID: 8HnTAyKtOg2uN5YJGshK1g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F54A195606A; Thu, 23 Jan 2025 20:47:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.98])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39A33195608A; Thu, 23 Jan 2025 20:47:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-stable@nongnu.org
Subject: [PATCH RESEND] hw/i386/microvm: Fix crash that occurs when
 introspecting the microvm machine
Date: Thu, 23 Jan 2025 21:47:08 +0100
Message-ID: <20250123204708.1560305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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
---
 Sorry if you've got this twice - but it looks like the original version
 apparently did not make it to the mailing list due to an outage last
 Monday :-(

 hw/i386/microvm.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..d0a236c74f 100644
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
2.48.1


