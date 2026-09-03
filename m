Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D65C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CI-0002ud-FK; Thu, 03 Sep 2026 08:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CF-0002t0-5g
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:35 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CD-0005JF-7H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=dP7nqBt
 A0cGC0E+yz0SCwQ460M0lkKu8MSO10A+alOEuHHm6yq2X8YtTEDPxSBb28TJKkVPPpKIIp
 dsLuDUXm3CS5lNu1NpV91+dXfXDXpgZ582lfA7HiyaV9wKW35/Ftubw4Ea2HHFuXgIc5Sj
 tYBmciYNrmeOG/9PB1MYMzrbbCweOuvTqpweB+8JF4C2fk01FWbuOW+m7UqOibljIw3hwN
 c4SgJe2A2NGmj0Ik1gx1McmhXCVJW4c2XCuiteOIbofqqXDJvLBSsppka0mg4G9Fpckm17
 huOCbvU8uTRkKb45KBXIGQqLOnyIEba1QAsypZRTolOs6fBxv9S2k3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=R
 hL2WKJct0UW7HSikSYL87UX23u1K8iS0O8O6sR/NpI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=GFQFFaluxP6KCut1eI1xjR4jo1zllDKRMjhqoblaOW6eOuvQRowohmI3ZOZBtnQOqpRk
 xODEaDUQ/Zito3/AWGOV0FK4BZw05VD8U7QYb7gr07R4urdUqAsodOsgk+RWhzq487VFjo
 ao2xjThvPM4ctkJppC6grq4DdJwSKksngjTMIRv+J5lKs0dfOh0kl4JcITQStVup8FX4yN
 ZX/sZ2+WsuyN7nzMHGF+OF31xbbJuwnWIKHXc5+g/6ngJGud3tZPBVAsErcGyefw7CTO1B
 UZJUjrjx82bHYSJ1dvoETmOIrdu/MR70kOC7R8SVDOqA7OjGjV7PzkuWLSLcnhCg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=J2uYES55; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=RM4X252P;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=RhL2WKJc
 t0UW7HSikSYL87UX23u1K8iS0O8O6sR/NpI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=J2uYES55TacZXJL0kXt1i7btpEezr22XEW2
 KbtGRF2+GnAQ4Q4qmRTO9DEpTn62xKFR9wmBJGjlOeSJBy9d3z/IOkBS5nRqayAtpwAr9K
 Lc+ppCQ7GP7ywRnTgCAc7kWdPqL+lJzE3kPjWgLeL3FyR4pwqziV169FBhZ0QM6s1zpqFx
 aNK2VxWDvg/JMOTPc/bDKxwiixFtOu00rb0fLPA82irT+in8gVasQ0el9GXZuawN5J72hU
 p+ladyY/p2o3pUANqSQI+E++ZqoC+crIXkno3BjmYFEWA4+ioDU+0mLHQijR9Saf5sPbM8
 uPRYhg2yWNnJicBOFdMGuCVyW4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=RhL2WKJct0UW7HSikSYL87UX23u1K8iS0O8O6sR/NpI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=RM4X252P7ceicLiFNo
 13Ms7prTkzV5v2FeHWfhY5OWk2nuZdVnTZ5d1/RaDQYVKd6YVv+RYldTXIgUq/jPrqCQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 83d4bc85
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:26 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id bc3d2505;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 10/25] hw/mips: add Octeon reset controller
Date: Thu,  3 Sep 2026 14:01:58 +0200
Message-ID: <20260903120510.34876-11-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Add the common resettable peripheral base and model the Octeon RST
state used to hold secondary cores in reset. Create and realize the
controller as part of the machine without exposing its CSR interface
yet.
---
 hw/mips/octeon.c          | 105 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   2 +
 2 files changed, 107 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 0e02d3693d..4fc5a71a90 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -29,6 +29,13 @@
 #define TYPE_OCTEON_MACHINE MACHINE_TYPE_NAME("octeon3")
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
 
+#define TYPE_OCTEON_PERIPHERAL "octeon-peripheral"
+OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
+                    OCTEON_PERIPHERAL)
+
+#define TYPE_OCTEON_RST "octeon-rst"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
+
 /*
  * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
  * DDR follows the upstream EBB7304 U-Boot board default.
@@ -85,6 +92,22 @@ struct OcteonMachineState {
     uint64_t ddr_hz;
 };
 
+struct OcteonPeripheralState {
+    SysBusDevice parent_obj;
+    OcteonState *board;
+    unsigned int index;
+};
+
+struct OcteonPeripheralClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+struct OcteonRstState {
+    OcteonPeripheralState parent_obj;
+    uint64_t rst_pp_power;
+};
+
 static void octeon_validate_clocks(OcteonMachineState *oms)
 {
     if (!oms->cpu_hz || !oms->ref_hz || !oms->io_hz || !oms->ddr_hz) {
@@ -99,6 +122,16 @@ static void octeon_validate_clocks(OcteonMachineState *oms)
     }
 }
 
+static uint64_t octeon_present_cpu_mask(OcteonState *s)
+{
+    return (1ULL << s->cpu_count) - 1;
+}
+
+static uint64_t octeon_secondary_cpu_mask(OcteonState *s)
+{
+    return octeon_present_cpu_mask(s) & ~1ULL;
+}
+
 static void octeon_cpu_after_reset(OcteonCPUState *cs)
 {
     CPUMIPSState *env = &cs->cpu->env;
@@ -303,6 +336,62 @@ static void octeon_init_flash(OcteonState *s)
                                 &s->boot_flash_alias);
 }
 
+static void octeon_rst_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonRstState *rst = OCTEON_RST(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    rst->rst_pp_power = octeon_secondary_cpu_mask(rst->parent_obj.board);
+}
+
+static void octeon_peripheral_class_init(ObjectClass *klass,
+                                          const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->user_creatable = false;
+}
+
+static void octeon_rst_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_rst_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
+static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
+                                                     const char *type,
+                                                     unsigned int index)
+{
+    DeviceState *qdev = qdev_new(type);
+    OcteonPeripheralState *dev = OCTEON_PERIPHERAL(qdev);
+
+    dev->board = s;
+    dev->index = index;
+    return dev;
+}
+
+static void octeon_create_peripherals(OcteonState *s)
+{
+    s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
+}
+
+static void octeon_realize_peripheral(OcteonPeripheralState *dev)
+{
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+}
+
+static void octeon_realize_peripherals(OcteonState *s)
+{
+    octeon_realize_peripheral(&s->rst->parent_obj);
+}
+
 static void mips_octeon_init(MachineState *machine)
 {
     OcteonMachineState *oms = OCTEON_MACHINE(machine);
@@ -316,6 +405,7 @@ static void mips_octeon_init(MachineState *machine)
     s->ref_hz = oms->ref_hz;
     s->io_hz = oms->io_hz;
     s->ddr_hz = oms->ddr_hz;
+    octeon_create_peripherals(s);
 
     if (machine->kernel_filename) {
         error_report("-kernel is not implemented for octeon3; "
@@ -328,6 +418,7 @@ static void mips_octeon_init(MachineState *machine)
     octeon_load_firmware(s);
     octeon_create_cpus(s);
 
+    octeon_realize_peripherals(s);
 }
 
 static void octeon_machine_reset(MachineState *machine, ResetType type)
@@ -385,6 +476,20 @@ static void octeon_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo octeon_machine_types[] = {
+    {
+        .name = TYPE_OCTEON_PERIPHERAL,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(OcteonPeripheralState),
+        .class_size = sizeof(OcteonPeripheralClass),
+        .class_init = octeon_peripheral_class_init,
+        .abstract = true,
+    },
+    {
+        .name = TYPE_OCTEON_RST,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonRstState),
+        .class_init = octeon_rst_class_init,
+    },
     {
         .name = TYPE_OCTEON_MACHINE,
         .parent = TYPE_MACHINE,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 2e568c29ea..9c1baee292 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -15,6 +15,7 @@
 
 #define OCTEON_MAX_CPUS             16
 typedef struct OcteonState OcteonState;
+typedef struct OcteonRstState OcteonRstState;
 
 typedef struct OcteonCPUState {
     OcteonState *board;
@@ -39,6 +40,7 @@ struct OcteonState {
     MemoryRegion boot_flash;
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
+    OcteonRstState *rst;
 };
 
 #endif
-- 
2.55.0


