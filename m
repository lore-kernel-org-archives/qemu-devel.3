Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B278C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCxP-0005qR-9X; Sat, 18 Jul 2026 17:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCxK-0005gl-9B; Sat, 18 Jul 2026 17:52:22 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCxE-0003ya-Fb; Sat, 18 Jul 2026 17:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411536; x=1815947536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zdByMBkcpMZr9GoUkRYLLMcG2ley+YOXCuAbSTQQN+I=;
 b=iXWVqlQZAB1Ca3RNNXtX68/16E2Etosiag+58lf01/CJLaRpuZ0E9W2S
 9Xu+IV0ZIVEpGdT4AjauoNH6EDpiMCX4G3kkSQMckeJnssRRct2XWMIvO
 ysgRT/P0d2jaPazlAMDrUMRh6HXGbS//5efXveUY0CUDFWRHoOtJDSZsQ
 gn0FmUctis9VgVQQ/iiYjisXEQ2PkXcvgliqUvDgSEVilKf21KqiSeiTQ
 4HnlUJQvFIRCJG0dc++dEL1KdPHoJS73F1TSTm3zBXLsGz42uTwlL3nmi
 HNLxYE5qpAB1/aMdus+8V+doCve/DL00sAjw43CHiB/1J+/vfosAMAolj g==;
X-CSE-ConnectionGUID: yjupSh+UR8aU6+9EXpAt4g==
X-CSE-MsgGUID: 7NgJ+IdkT0+Mmapbd6WxVw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23927252"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:52:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:16946]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id f8ac7780-7698-482f-bb29-89404e36c165; Sat, 18 Jul 2026 21:52:11 +0000 (UTC)
X-Farcaster-Flow-ID: f8ac7780-7698-482f-bb29-89404e36c165
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:52:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:52:01 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 054/137] hw/i386: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:29 +0000
Message-ID: <20260718213652.37673-55-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert the *_orphan() device-creation calls in hw/i386 to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Six of the singletons in hw/i386/kvm/ (kvmclock, xen-evtchn,
xen-gnttab, xen-overlay, xen-xenstore, xen-primary-console) are
created via a public helper; those helpers gain an Object *parent
first argument and all callers are updated in this patch.

The pcspk device created in pc_machine_initfn() is left orphan for
now: it is created in instance_init and object_unref()ed in
instance_finalize when never realized.  Making it a child<> would
free it via object_property_del_all() before finalize runs, leaving
finalize with a dangling pointer.  This site needs a separate
refactor of pc_machine_finalize() first.

Per-site rationale (reviewers: dispute the modeling here):

hw/i386/isapc.c:115 | isa_new | OBJECT(machine) | "rtc" | board init pc_init_isa()
hw/i386/kvm/clock.c:380 | sysbus_create_simple | parent | "kvmclock" | thread Object *parent into kvmclock_create(); callers pass OBJECT(machine)/OBJECT(mms)
hw/i386/kvm/xen_evtchn.c:309 | sysbus_create_simple | parent | "xen-evtchn" | thread Object *parent into xen_evtchn_create(); caller pc_basic_device_init passes OBJECT(pcms)
hw/i386/kvm/xen_gnttab.c:155 | sysbus_create_simple | parent | "xen-gnttab" | thread Object *parent into xen_gnttab_create(); caller passes OBJECT(pcms)
hw/i386/kvm/xen_overlay.c:172 | sysbus_create_simple | parent | "xen-overlay" | thread Object *parent into xen_overlay_create(); caller passes OBJECT(pcms)
hw/i386/kvm/xen_primary_console.c:87 | sysbus_create_simple | parent | "xen-primary-console" | thread Object *parent into xen_primary_console_create(); callers: pc.c stub-guarded, xen_console_realize passes OBJECT(xendev)
hw/i386/kvm/xen_xenstore.c:279 | sysbus_create_simple | parent | "xen-xenstore" | thread Object *parent into xen_xenstore_create(); caller passes OBJECT(pcms)
hw/i386/microvm.c:111 | qdev_new | OBJECT(mms) | "gpex" | board helper create_gpex(MicrovmMachineState *mms)
hw/i386/microvm.c:200 | sysbus_create_simple | OBJECT(mms) | "virtio-mmio[*]" | board init loop
hw/i386/microvm.c:207 | qdev_new | OBJECT(mms) | "acpi-ged" | board init; already sysbus_realize (no unref), just parent
hw/i386/microvm.c:219 | qdev_new | OBJECT(mms) | "xhci" | board init; already sysbus_realize (no unref), just parent
hw/i386/nitro_enclave.c:49 | qdev_new | OBJECT(nems) | "vsock" | board helper receiving NitroEnclaveMachineState*
hw/i386/nitro_enclave.c:78 | qdev_new | OBJECT(nems) | "nsm" | board helper receiving NitroEnclaveMachineState*
hw/i386/pc.c:1001 | isa_new | parent | "fdc" | pc_superio_init already has Object *parent
hw/i386/pc.c:1017 | isa_create_simple | parent | "i8042" | pc_superio_init already has Object *parent
hw/i386/pc.c:1019 | isa_create_simple | parent | "vmport" | pc_superio_init already has Object *parent
hw/i386/pc.c:1020 | isa_try_new | parent | "vmmouse" | pc_superio_init already has Object *parent
hw/i386/pc.c:1029 | isa_create_simple | parent | "port92" | pc_superio_init already has Object *parent
hw/i386/pc.c:1068 | qdev_try_new | OBJECT(pcms) | "hpet" | pc_basic_device_init receives PCMachineState*
hw/i386/pc.c:1107 | pci_create_simple | OBJECT(pcms) | "xen-platform" | pc_basic_device_init receives PCMachineState*
hw/i386/pc.c:1642 | isa_new | ORPHAN-JUSTIFIED | - | instance_init + explicit unref in instance_finalize; parenting here would double-free via object_property_del_all before finalize; needs separate refactor of pc_machine_finalize
hw/i386/pc_piix.c:196 | qdev_new | OBJECT(machine) | "i440fx" | collapse existing object_property_add_child(machine,"i440fx")
hw/i386/pc_piix.c:239 | pci_new_multifunction | OBJECT(machine) | "south-bridge" | board init pc_init1()
hw/i386/pc_piix.c:387 | pci_create_simple | OBJECT(machine) | "xen-platform" | board init pc_xen_hvm_init()
hw/i386/pc_q35.c:117 | pci_new_multifunction | parent | "ehci[*]" | thread Object *parent into ehci_create_ich9_with_companions(); caller passes OBJECT(machine)
hw/i386/pc_q35.c:122 | pci_new_multifunction | parent | "uhci[*]" | thread Object *parent into ehci_create_ich9_with_companions()
hw/i386/pc_q35.c:202 | qdev_new | OBJECT(machine) | "q35" | collapse existing object_property_add_child(machine,"q35")
hw/i386/pc_q35.c:238 | pci_new_multifunction | OBJECT(machine) | "lpc" | board init pc_q35_init()
hw/i386/pc_q35.c:293 | pci_create_simple_multifunction | OBJECT(machine) | "sata" | board init pc_q35_init()
hw/i386/pc_q35.c:314 | pci_create_simple_multifunction | OBJECT(machine) | "smbus" | board init pc_q35_init()
hw/i386/pc_sysfw.c:82 | qdev_new | OBJECT(pcms) | name | collapse existing object_property_add_child(pcms,name); drop explicit object_unref
hw/i386/sgx.c:314 | qdev_new | OBJECT(pcms) | "sgx-epc[*]" | board helper receiving PCMachineState*
hw/i386/x86-common.c:508 | qdev_new | parent | "ioapic" | collapse existing object_property_add_child(parent,"ioapic")
hw/i386/x86-common.c:510 | qdev_new | parent | "ioapic" | collapse existing object_property_add_child(parent,"ioapic")
hw/i386/x86-common.c:528 | qdev_new | parent | "ioapic2" | thread Object *parent into ioapic_init_secondary(); caller passes OBJECT(mms)

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/char/xen_console.c             |  2 +-
 hw/i386/isapc.c                   |  6 +++---
 hw/i386/kvm/clock.c               |  4 ++--
 hw/i386/kvm/clock.h               |  2 +-
 hw/i386/kvm/xen-stubs.c           |  2 +-
 hw/i386/kvm/xen_evtchn.c          |  6 ++++--
 hw/i386/kvm/xen_evtchn.h          |  3 ++-
 hw/i386/kvm/xen_gnttab.c          |  6 ++++--
 hw/i386/kvm/xen_gnttab.h          |  2 +-
 hw/i386/kvm/xen_overlay.c         |  6 ++++--
 hw/i386/kvm/xen_overlay.h         |  2 +-
 hw/i386/kvm/xen_primary_console.c |  5 +++--
 hw/i386/kvm/xen_primary_console.h |  2 +-
 hw/i386/kvm/xen_xenstore.c        |  5 +++--
 hw/i386/kvm/xen_xenstore.h        |  2 +-
 hw/i386/microvm.c                 | 15 ++++++++-------
 hw/i386/nitro_enclave.c           |  9 +++++----
 hw/i386/pc.c                      | 29 ++++++++++++++--------------
 hw/i386/pc_piix.c                 | 15 ++++++++-------
 hw/i386/pc_q35.c                  | 32 +++++++++++++++++--------------
 hw/i386/pc_sysfw.c                | 10 ++--------
 hw/i386/sgx.c                     |  5 +++--
 hw/i386/x86-common.c              | 13 ++++++-------
 include/hw/i386/x86.h             |  2 +-
 24 files changed, 98 insertions(+), 87 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 57520192b9..cd440b82f4 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -440,7 +440,7 @@ static void xen_console_realize(XenDevice *xendev, Error **errp)
      */
     if (!con->dev) {
         if (xen_mode == XEN_EMULATE) {
-            xen_primary_console_create();
+            xen_primary_console_create(OBJECT(xendev));
         } else if (xen_device_frontend_scanf(xendev, "ring-ref", "%u", &u)
                    != 1 ||
                    xen_device_frontend_scanf(xendev, "port", "%u", &u) != 1) {
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index c2a3f23f2c..c5bba66967 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -90,7 +90,7 @@ static void pc_init_isa(MachineState *machine)
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
+        kvmclock_create(OBJECT(machine), pcmc->kvmclock_create_always);
     }
 
     /* allocate ram and load rom/bios */
@@ -112,9 +112,9 @@ static void pc_init_isa(MachineState *machine)
                           &error_abort);
     isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-    x86ms->rtc = isa_new_orphan(TYPE_MC146818_RTC);
+    x86ms->rtc = isa_new(OBJECT(machine), "rtc", TYPE_MC146818_RTC);
     qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    qdev_realize(DEVICE(x86ms->rtc), BUS(isa_bus), &error_fatal);
     irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
                                    &error_fatal);
     isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index de0df2c82a..34abba88f4 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -369,7 +369,7 @@ static const TypeInfo kvmclock_info = {
 };
 
 /* Note: Must be called after VCPU initialization. */
-void kvmclock_create(bool create_always)
+void kvmclock_create(Object *parent, bool create_always)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
@@ -377,7 +377,7 @@ void kvmclock_create(bool create_always)
     if (create_always ||
         cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
                                        CPUID_KVM_CLOCK2)) {
-        sysbus_create_simple_orphan(TYPE_KVM_CLOCK, -1, NULL);
+        sysbus_create_simple(parent, "kvmclock", TYPE_KVM_CLOCK, -1, NULL);
     }
 }
 
diff --git a/hw/i386/kvm/clock.h b/hw/i386/kvm/clock.h
index 401c7e445b..e86aa3aa88 100644
--- a/hw/i386/kvm/clock.h
+++ b/hw/i386/kvm/clock.h
@@ -13,6 +13,6 @@
 #ifndef HW_I386_KVM_CLOCK_H
 #define HW_I386_KVM_CLOCK_H
 
-void kvmclock_create(bool create_always);
+void kvmclock_create(Object *parent, bool create_always);
 
 #endif
diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index bf6ac28bef..afdceeeb2a 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -32,7 +32,7 @@ bool xen_evtchn_deliver_pirq_msi(uint64_t address, uint32_t data)
     return false;
 }
 
-void xen_primary_console_create(void)
+void xen_primary_console_create(Object *parent)
 {
 }
 
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 1a406fbc00..89e59b612a 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -304,9 +304,11 @@ static void gsi_assert_bh(void *opaque)
     }
 }
 
-void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
+void xen_evtchn_create(Object *parent, unsigned int nr_gsis,
+                       qemu_irq *system_gsis)
 {
-    XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple_orphan(TYPE_XEN_EVTCHN,
+    XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple(parent, "xen-evtchn",
+                                                        TYPE_XEN_EVTCHN,
                                                         -1, NULL));
     int i;
 
diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index 8d339db560..87e9d4bb9f 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -16,7 +16,8 @@
 
 typedef uint32_t evtchn_port_t;
 
-void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis);
+void xen_evtchn_create(Object *parent, unsigned int nr_gsis,
+                       qemu_irq *system_gsis);
 int xen_evtchn_soft_reset(void);
 int xen_evtchn_set_callback_param(uint64_t param);
 void xen_evtchn_set_callback_level(int level);
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index eb43e9f385..ea5a561b05 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -150,9 +150,11 @@ static const TypeInfo xen_gnttab_info = {
     .class_init    = xen_gnttab_class_init,
 };
 
-void xen_gnttab_create(void)
+void xen_gnttab_create(Object *parent)
 {
-    xen_gnttab_singleton = XEN_GNTTAB(sysbus_create_simple_orphan(TYPE_XEN_GNTTAB,
+    xen_gnttab_singleton = XEN_GNTTAB(sysbus_create_simple(parent,
+                                                           "xen-gnttab",
+                                                           TYPE_XEN_GNTTAB,
                                                            -1, NULL));
 }
 
diff --git a/hw/i386/kvm/xen_gnttab.h b/hw/i386/kvm/xen_gnttab.h
index ee215239b0..6e9c430476 100644
--- a/hw/i386/kvm/xen_gnttab.h
+++ b/hw/i386/kvm/xen_gnttab.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_XEN_GNTTAB_H
 #define QEMU_XEN_GNTTAB_H
 
-void xen_gnttab_create(void);
+void xen_gnttab_create(Object *parent);
 int xen_gnttab_reset(void);
 int xen_gnttab_map_page(uint64_t idx, uint64_t gfn);
 
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 1ef47539e4..bfa4807427 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -167,9 +167,11 @@ static const TypeInfo xen_overlay_info = {
     .class_init    = xen_overlay_class_init,
 };
 
-void xen_overlay_create(void)
+void xen_overlay_create(Object *parent)
 {
-    xen_overlay_singleton = XEN_OVERLAY(sysbus_create_simple_orphan(TYPE_XEN_OVERLAY,
+    xen_overlay_singleton = XEN_OVERLAY(sysbus_create_simple(parent,
+                                                             "xen-overlay",
+                                                             TYPE_XEN_OVERLAY,
                                                              -1, NULL));
 
     /* If xen_domid wasn't explicitly set, at least make sure it isn't zero. */
diff --git a/hw/i386/kvm/xen_overlay.h b/hw/i386/kvm/xen_overlay.h
index 75ecb6b359..37cd86f7ce 100644
--- a/hw/i386/kvm/xen_overlay.h
+++ b/hw/i386/kvm/xen_overlay.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_XEN_OVERLAY_H
 #define QEMU_XEN_OVERLAY_H
 
-void xen_overlay_create(void);
+void xen_overlay_create(Object *parent);
 
 int xen_overlay_map_shinfo_page(uint64_t gpa);
 void *xen_overlay_get_shinfo_ptr(void);
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index f22ce4b14b..323b0747a2 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -82,9 +82,10 @@ static const TypeInfo xen_primary_console_info = {
 };
 
 
-void xen_primary_console_create(void)
+void xen_primary_console_create(Object *parent)
 {
-    DeviceState *dev = sysbus_create_simple_orphan(TYPE_XEN_PRIMARY_CONSOLE, -1, NULL);
+    DeviceState *dev = sysbus_create_simple(parent, "xen-primary-console",
+                                            TYPE_XEN_PRIMARY_CONSOLE, -1, NULL);
 
     trace_xen_primary_console_create();
 
diff --git a/hw/i386/kvm/xen_primary_console.h b/hw/i386/kvm/xen_primary_console.h
index 7e2989ea0d..240c55f0b0 100644
--- a/hw/i386/kvm/xen_primary_console.h
+++ b/hw/i386/kvm/xen_primary_console.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_XEN_PRIMARY_CONSOLE_H
 #define QEMU_XEN_PRIMARY_CONSOLE_H
 
-void xen_primary_console_create(void);
+void xen_primary_console_create(Object *parent);
 int xen_primary_console_reset(void);
 
 uint16_t xen_primary_console_get_port(void);
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 92493bcb6d..1719eab20e 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -274,9 +274,10 @@ static const TypeInfo xen_xenstore_info = {
     .class_init    = xen_xenstore_class_init,
 };
 
-void xen_xenstore_create(void)
+void xen_xenstore_create(Object *parent)
 {
-    DeviceState *dev = sysbus_create_simple_orphan(TYPE_XEN_XENSTORE, -1, NULL);
+    DeviceState *dev = sysbus_create_simple(parent, "xen-xenstore",
+                                            TYPE_XEN_XENSTORE, -1, NULL);
 
     xen_xenstore_singleton = XEN_XENSTORE(dev);
 
diff --git a/hw/i386/kvm/xen_xenstore.h b/hw/i386/kvm/xen_xenstore.h
index 8c3768e075..a36626e4ff 100644
--- a/hw/i386/kvm/xen_xenstore.h
+++ b/hw/i386/kvm/xen_xenstore.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_XEN_XENSTORE_H
 #define QEMU_XEN_XENSTORE_H
 
-void xen_xenstore_create(void);
+void xen_xenstore_create(Object *parent);
 int xen_xenstore_reset(void);
 
 uint16_t xen_xenstore_get_port(void);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 8e52cdd0db..d701672c1a 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -108,8 +108,8 @@ static void create_gpex(MicrovmMachineState *mms)
     DeviceState *dev;
     int i;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(mms), "gpex", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -177,11 +177,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     ioapic_init_gsi(gsi_state, OBJECT(mms));
     if (ioapics > 1) {
-        x86ms->ioapic2 = ioapic_init_secondary(gsi_state);
+        x86ms->ioapic2 = ioapic_init_secondary(OBJECT(mms), gsi_state);
     }
 
     if (kvm_enabled()) {
-        kvmclock_create(true);
+        kvmclock_create(OBJECT(mms), true);
     }
 
     mms->virtio_irq_base = 5;
@@ -197,14 +197,15 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     for (i = 0; i < mms->virtio_num_transports; i++) {
-        sysbus_create_simple_orphan("virtio-mmio",
+        sysbus_create_simple(OBJECT(mms), "virtio-mmio[*]", "virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
                              x86ms->gsi[mms->virtio_irq_base + i]);
     }
 
     /* Optional and legacy devices */
     if (x86_machine_is_acpi_enabled(x86ms)) {
-        DeviceState *dev = qdev_new_orphan(TYPE_ACPI_GED);
+        DeviceState *dev = qdev_new(OBJECT(mms), "acpi-ged",
+                                    TYPE_ACPI_GED);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
@@ -216,7 +217,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (x86_machine_is_acpi_enabled(x86ms) && machine_usb(MACHINE(mms))) {
-        DeviceState *dev = qdev_new_orphan(TYPE_XHCI_SYSBUS);
+        DeviceState *dev = qdev_new(OBJECT(mms), "xhci", TYPE_XHCI_SYSBUS);
         qdev_prop_set_uint32(dev, "intrs", 1);
         qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
         qdev_prop_set_uint32(dev, "p2", 8);
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index fcad27bd9b..359d83dd49 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -46,7 +46,8 @@ static BusState *find_free_virtio_mmio_bus(void)
 
 static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_VHOST_USER_VSOCK);
+    DeviceState *dev = qdev_new(OBJECT(nems), "vsock",
+                                TYPE_VHOST_USER_VSOCK);
     VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
     BusState *bus;
 
@@ -70,12 +71,12 @@ static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
 
     vsock->conf.chardev.chr = chardev;
 
-    qdev_realize_and_unref(dev, bus, &error_fatal);
+    qdev_realize(dev, bus, &error_fatal);
 }
 
 static void virtio_nsm_init(NitroEnclaveMachineState *nems)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_VIRTIO_NSM);
+    DeviceState *dev = qdev_new(OBJECT(nems), "nsm", TYPE_VIRTIO_NSM);
     VirtIONSM *vnsm = VIRTIO_NSM(dev);
     BusState *bus = find_free_virtio_mmio_bus();
 
@@ -86,7 +87,7 @@ static void virtio_nsm_init(NitroEnclaveMachineState *nems)
 
     qdev_prop_set_string(dev, "module-id", nems->id);
 
-    qdev_realize_and_unref(dev, bus, &error_fatal);
+    qdev_realize(dev, bus, &error_fatal);
     nems->vnsm = vnsm;
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d405cb33c..1073888b42 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -998,9 +998,9 @@ static void pc_superio_init(Object *parent, ISABus *isa_bus, bool create_fdctrl,
     }
     if (create_fdctrl) {
 #ifdef CONFIG_FDC_ISA
-        ISADevice *fdc = isa_new_orphan(TYPE_ISA_FDC);
+        ISADevice *fdc = isa_new(parent, "fdc", TYPE_ISA_FDC);
         if (fdc) {
-            isa_realize_and_unref(fdc, isa_bus, &error_fatal);
+            qdev_realize(DEVICE(fdc), BUS(isa_bus), &error_fatal);
             isa_fdc_init_drives(fdc, fd);
         }
 #endif
@@ -1014,19 +1014,19 @@ static void pc_superio_init(Object *parent, ISABus *isa_bus, bool create_fdctrl,
         return;
     }
 
-    i8042 = isa_create_simple_orphan(isa_bus, TYPE_I8042);
+    i8042 = isa_create_simple(parent, "i8042[*]", isa_bus, TYPE_I8042);
     if (!no_vmport) {
-        isa_create_simple_orphan(isa_bus, TYPE_VMPORT);
-        vmmouse = isa_try_new_orphan("vmmouse");
+        isa_create_simple(parent, "vmport[*]", isa_bus, TYPE_VMPORT);
+        vmmouse = isa_try_new(parent, "vmmouse", "vmmouse");
     } else {
         vmmouse = NULL;
     }
     if (vmmouse) {
         object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i8042),
                                  &error_abort);
-        isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
+        qdev_realize(DEVICE(vmmouse), BUS(isa_bus), &error_fatal);
     }
-    port92 = isa_create_simple_orphan(isa_bus, TYPE_PORT92);
+    port92 = isa_create_simple(parent, "port92", isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     qdev_connect_gpio_out_named(DEVICE(i8042),
@@ -1065,7 +1065,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
 
-        hpet = qdev_try_new_orphan(TYPE_HPET);
+        hpet = qdev_try_new(OBJECT(pcms), "hpet[*]", TYPE_HPET);
         if (!hpet) {
             error_report("couldn't create HPET device");
             exit(1);
@@ -1080,7 +1080,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         if (!compat) {
             qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
         }
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(hpet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
 
         for (i = 0; i < IOAPIC_NUM_PINS; i++) {
@@ -1099,12 +1099,13 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
-        xen_overlay_create();
-        xen_evtchn_create(IOAPIC_NUM_PINS, gsi);
-        xen_gnttab_create();
-        xen_xenstore_create();
+        xen_overlay_create(OBJECT(pcms));
+        xen_evtchn_create(OBJECT(pcms), IOAPIC_NUM_PINS, gsi);
+        xen_gnttab_create(OBJECT(pcms));
+        xen_xenstore_create(OBJECT(pcms));
         if (pcms->pcibus) {
-            pci_create_simple_orphan(pcms->pcibus, -1, "xen-platform");
+            pci_create_simple(OBJECT(pcms), "xen-platform", pcms->pcibus,
+                              -1, "xen-platform");
         }
         xen_bus_init();
     }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 44ce592ea2..8ae2108e73 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -187,14 +187,13 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
+        kvmclock_create(OBJECT(machine), pcmc->kvmclock_create_always);
     }
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
 
-    phb = OBJECT(qdev_new_orphan(TYPE_I440FX_PCI_HOST_BRIDGE));
-    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    phb = OBJECT(qdev_new(OBJECT(machine), "i440fx", TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                              OBJECT(ram_memory), &error_fatal);
     object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
@@ -209,7 +208,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                              x86ms->above_4g_mem_size, &error_fatal);
     object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
                             &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(phb), &error_fatal);
 
     pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
     pci_bus_map_irqs(pcms->pcibus,
@@ -236,7 +235,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
-    pci_dev = pci_new_multifunction_orphan(-1, pcms->south_bridge);
+    pci_dev = pci_new_multifunction(OBJECT(machine), "south-bridge", -1,
+                                    pcms->south_bridge);
     object_property_set_bool(OBJECT(pci_dev), "has-usb",
                              machine_usb(machine), &error_abort);
     object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -254,7 +254,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     for (i = 0; i < ISA_NUM_IRQS; i++) {
         qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+    qdev_realize(DEVICE(pci_dev), BUS(pcms->pcibus), &error_fatal);
 
     if (xen_enabled()) {
         pci_device_set_intx_routing_notifier(
@@ -384,7 +384,8 @@ static void pc_xen_hvm_init(MachineState *machine)
                       : TYPE_I440FX_PCI_DEVICE);
 
     xen_igd_reserve_slot(pcms->pcibus);
-    pci_create_simple_orphan(pcms->pcibus, -1, "xen-platform");
+    pci_create_simple(OBJECT(machine), "xen-platform", pcms->pcibus, -1,
+                      "xen-platform");
 }
 #endif
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index bfea390825..1a65811fae 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -93,7 +93,8 @@ static const struct ehci_companions ich9_1a[] = {
     { .name = TYPE_ICH9_USB_UHCI(6), .func = 2, .port = 4 },
 };
 
-static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
+static int ehci_create_ich9_with_companions(Object *parent, PCIBus *bus,
+                                             int slot)
 {
     const struct ehci_companions *comp;
     PCIDevice *ehci, *uhci;
@@ -114,16 +115,17 @@ static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
         return -1;
     }
 
-    ehci = pci_new_multifunction_orphan(PCI_DEVFN(slot, 7), name);
-    pci_realize_and_unref(ehci, bus, &error_fatal);
+    ehci = pci_new_multifunction(parent, "ehci[*]", PCI_DEVFN(slot, 7), name);
+    qdev_realize(DEVICE(ehci), BUS(bus), &error_fatal);
     usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
 
     for (i = 0; i < 3; i++) {
-        uhci = pci_new_multifunction_orphan(PCI_DEVFN(slot, comp[i].func),
+        uhci = pci_new_multifunction(parent, "uhci[*]",
+                                     PCI_DEVFN(slot, comp[i].func),
                                      comp[i].name);
         qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
         qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
-        pci_realize_and_unref(uhci, bus, &error_fatal);
+        qdev_realize(DEVICE(uhci), BUS(bus), &error_fatal);
     }
     return 0;
 }
@@ -195,11 +197,11 @@ static void pc_q35_init(MachineState *machine)
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
+        kvmclock_create(OBJECT(machine), pcmc->kvmclock_create_always);
     }
 
     /* create pci host bus */
-    phb = OBJECT(qdev_new_orphan(TYPE_Q35_HOST_DEVICE));
+    phb = OBJECT(qdev_new(OBJECT(machine), "q35", TYPE_Q35_HOST_DEVICE));
 
     pci_hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
@@ -209,7 +211,6 @@ static void pc_q35_init(MachineState *machine)
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
     pc_memory_init(pcms, system_memory, pci_memory, pci_hole64_size);
 
-    object_property_add_child(OBJECT(machine), "q35", phb);
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
     object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
@@ -226,7 +227,7 @@ static void pc_q35_init(MachineState *machine)
                              pcms->default_bus_bypass_iommu, NULL);
     object_property_set_bool(phb, PCI_HOST_PROP_SMM_RANGES,
                              x86_machine_is_smm_enabled(x86ms), NULL);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
     pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
@@ -235,7 +236,8 @@ static void pc_q35_init(MachineState *machine)
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
     /* create ISA bus */
-    lpc = pci_new_multifunction_orphan(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
+    lpc = pci_new_multifunction(OBJECT(machine), "lpc",
+                                PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
@@ -243,7 +245,7 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
+    qdev_realize(DEVICE(lpc), BUS(pcms->pcibus), &error_fatal);
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
@@ -290,7 +292,8 @@ static void pc_q35_init(MachineState *machine)
         AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        pdev = pci_create_simple_multifunction_orphan(pcms->pcibus,
+        pdev = pci_create_simple_multifunction(OBJECT(machine), "sata[*]",
+                                               pcms->pcibus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
@@ -304,14 +307,15 @@ static void pc_q35_init(MachineState *machine)
 
     if (machine_usb(machine)) {
         /* Should we create 6 UHCI according to ich9 spec? */
-        ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
+        ehci_create_ich9_with_companions(OBJECT(machine), pcms->pcibus, 0x1d);
     }
 
     if (pcms->smbus_enabled) {
         PCIDevice *smb;
 
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction_orphan(pcms->pcibus,
+        smb = pci_create_simple_multifunction(OBJECT(machine), "smbus[*]",
+                                              pcms->pcibus,
                                               PCI_DEVFN(ICH9_SMB_DEV,
                                                         ICH9_SMB_FUNC),
                                               TYPE_ICH9_SMB_DEVICE);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index d351e3da77..02d75e2838 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -79,19 +79,13 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
                                      const char *name,
                                      const char *alias_prop_name)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(OBJECT(pcms), name, TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(pcms), alias_prop_name,
                               OBJECT(dev), "drive");
-    /*
-     * The returned reference is tied to the child property and
-     * will be removed with object_unparent.
-     */
-    object_unref(OBJECT(dev));
     return PFLASH_CFI01(dev);
 }
 
@@ -189,7 +183,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
         gpa = 0x100000000ULL - total_size; /* where the flash is mapped */
         qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
                              size / FLASH_SECTOR_SIZE);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(system_flash), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(system_flash), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0, gpa);
 
         if (i == 0) {
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index c326385456..c5a8febf29 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -311,7 +311,8 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
                                 &sgx_epc->mr);
 
     for (list = x86ms->sgx_epc_list; list; list = list->next) {
-        DeviceState *dev = qdev_new_orphan(TYPE_SGX_EPC);
+        DeviceState *dev = qdev_new(OBJECT(pcms), "sgx-epc[*]",
+                                    TYPE_SGX_EPC);
 
         /* set the memdev link with memory backend */
         object_property_parse(OBJECT(dev), SGX_EPC_MEMDEV_PROP,
@@ -319,7 +320,7 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
         /* set the numa node property for sgx epc object */
         object_property_set_uint(OBJECT(dev), SGX_EPC_NUMA_NODE_PROP,
                                  list->value->node, &error_fatal);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        qdev_realize(dev, NULL, &error_fatal);
     }
 
     if ((sgx_epc->base + sgx_epc->size) < sgx_epc->base) {
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b8e541e376..73a53fbf3f 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -505,13 +505,12 @@ void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
 
     assert(parent);
     if (kvm_ioapic_in_kernel()) {
-        dev = qdev_new_orphan(TYPE_KVM_IOAPIC);
+        dev = qdev_new(parent, "ioapic", TYPE_KVM_IOAPIC);
     } else {
-        dev = qdev_new_orphan(TYPE_IOAPIC);
+        dev = qdev_new(parent, "ioapic", TYPE_IOAPIC);
     }
-    object_property_add_child(parent, "ioapic", OBJECT(dev));
     d = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_realize(d, &error_fatal);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
 
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
@@ -519,15 +518,15 @@ void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
     }
 }
 
-DeviceState *ioapic_init_secondary(GSIState *gsi_state)
+DeviceState *ioapic_init_secondary(Object *parent, GSIState *gsi_state)
 {
     DeviceState *dev;
     SysBusDevice *d;
     unsigned int i;
 
-    dev = qdev_new_orphan(TYPE_IOAPIC);
+    dev = qdev_new(parent, "ioapic2[*]", TYPE_IOAPIC);
     d = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_realize(d, &error_fatal);
     sysbus_mmio_map(d, 0, IO_APIC_SECONDARY_ADDRESS);
 
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71fe6b5e12..61d6ec1755 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -147,7 +147,7 @@ typedef struct GSIState {
 qemu_irq x86_allocate_cpu_irq(void);
 void gsi_handler(void *opaque, int n, int level);
 void ioapic_init_gsi(GSIState *gsi_state, Object *parent);
-DeviceState *ioapic_init_secondary(GSIState *gsi_state);
+DeviceState *ioapic_init_secondary(Object *parent, GSIState *gsi_state);
 
 /* pc_sysfw.c */
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size);
-- 
2.47.1


