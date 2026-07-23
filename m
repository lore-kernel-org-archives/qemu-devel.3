Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C3EC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmwRU-0007SJ-EO; Thu, 23 Jul 2026 12:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wmwRM-0007Nq-87
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wmwRK-0004FK-4m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784824708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MBI+ubjMc44xefVxECHpDbphsZOIzrqz2ABmwHH2R+s=;
 b=AARIe1y1h6jCQaHWlC/aSm17z/jYJxUbFLz+/WzpcqrF7ex/F4A9LY5k2D33EMqrO5tMta
 iBYPQ3cBQdjI05n4j9VmvoKl9KRyb4sm9xUBWaf5JjfE7H9uj3L6NEpxxkeXWSYmDveG5U
 VpzZh0VsJVctQIhpgOEGtskDd4O8j+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-mC1JBLYSPRiT6kilUxggpw-1; Thu,
 23 Jul 2026 12:38:27 -0400
X-MC-Unique: mC1JBLYSPRiT6kilUxggpw-1
X-Mimecast-MFC-AGG-ID: mC1JBLYSPRiT6kilUxggpw_1784824704
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4229C18301F4; Thu, 23 Jul 2026 16:38:23 +0000 (UTC)
Received: from gondolin.fritz.box (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E46D195605A; Thu, 23 Jul 2026 16:38:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-11.2] hw: add compat machines for 11.2
Date: Thu, 23 Jul 2026 18:38:06 +0200
Message-ID: <20260723163806.368127-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add 11.2 machine types for arm/i440fx/loongarch/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/loongarch/virt.c        | 11 +++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/core/boards.h   |  3 +++
 include/hw/i386/pc.h       |  3 +++
 11 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 219597cabd0b..e7a56e37f731 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4441,10 +4441,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d57..354b93c62037 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,9 @@
 #include "qemu/audio.h"
 #include "hw/arm/smmuv3.h"
 
+GlobalProperty hw_compat_11_1[] = {};
+const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
+
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e32..e9e4fc262b83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_1[] = {};
+const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
+
 GlobalProperty pc_compat_11_0[] = {};
 const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb167a..223a19cc4bbc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_1_options(MachineClass *m)
+static void pc_i440fx_machine_11_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
+
+static void pc_i440fx_machine_11_1_options(MachineClass *m)
+{
+    pc_i440fx_machine_11_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 1);
 
 static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f1d..94cd71124b18 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -383,12 +383,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_1_options(MachineClass *m)
+static void pc_q35_machine_11_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
+
+static void pc_q35_machine_11_1_options(MachineClass *m)
+{
+    pc_q35_machine_11_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_Q35_MACHINE(11, 1);
 
 static void pc_q35_machine_11_0_options(MachineClass *m)
 {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6693dea647be..9cc79929a8ab 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1465,7 +1465,6 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "loongarch.ram";
     mc->desc = "QEMU LoongArch Virtual Machine";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
-    mc->is_default = 1;
     mc->default_kernel_irqchip_split = false;
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
@@ -1546,6 +1545,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
+            mc->is_default = true; \
         } \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
@@ -1600,7 +1600,14 @@ static void machvirt_machine_init(void)
 
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 51158ce1c08c..274970978ffb 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90c..7e284edd7d0b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4763,15 +4763,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-11.2
+ */
+static void spapr_machine_11_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 2);
+
 /*
  * pseries-11.1
  */
 static void spapr_machine_11_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_11_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
+DEFINE_SPAPR_MACHINE(11, 1);
 
 /*
  * pseries-11.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa495540..55131c1a4445 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -925,14 +925,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_11_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_11_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(11, 2);
+
 static void ccw_machine_11_1_instance_options(MachineState *machine)
 {
+    ccw_machine_11_2_instance_options(machine);
 }
 
 static void ccw_machine_11_1_class_options(MachineClass *mc)
 {
+    ccw_machine_11_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
+DEFINE_CCW_MACHINE(11, 1);
 
 static void ccw_machine_11_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 29c68931d8a7..a436d48c8e52 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
     }
 }
 
+extern GlobalProperty hw_compat_11_1[];
+extern const size_t hw_compat_11_1_len;
+
 extern GlobalProperty hw_compat_11_0[];
 extern const size_t hw_compat_11_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57fa..ac03da97b645 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_1[];
+extern const size_t pc_compat_11_1_len;
+
 extern GlobalProperty pc_compat_11_0[];
 extern const size_t pc_compat_11_0_len;
 
-- 
2.55.0


