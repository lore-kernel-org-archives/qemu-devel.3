Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9108ECCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAf5-0003El-Vm; Wed, 12 Nov 2025 08:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vJATK-0002Wl-EB
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vJATB-000201-AK
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762952451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hPzScCMEM4pgb6wLiXeum4/lvcOdcOSc5N54ubQsy0g=;
 b=Z3XdXFWh0nKHKojOndMxf6mUEqRtu+tB7nEnENrdfd1A7AOJ5tEL6lQkhrAHm+UizJ/EB9
 0roVPDOsdCavmvKbQ5nlO2wJg/JzEnsgiFwBQi4/bwZe21JLjtzyAiQwD3KAuf/Zz9/BAJ
 ZcMZP7OcmaybMstAGo5Bjin4ruZIW7o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-doqC7Hb-OoWaX4UOUGIGjw-1; Wed,
 12 Nov 2025 08:00:47 -0500
X-MC-Unique: doqC7Hb-OoWaX4UOUGIGjw-1
X-Mimecast-MFC-AGG-ID: doqC7Hb-OoWaX4UOUGIGjw_1762952444
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D728A19560B5; Wed, 12 Nov 2025 13:00:43 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-224.str.redhat.com
 [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D402430044E8; Wed, 12 Nov 2025 13:00:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-11.0] hw: add compat machines for 11.0
Date: Wed, 12 Nov 2025 14:00:31 +0100
Message-ID: <20251112130031.2484181-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add 11.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 10 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab5680..6fcca24141e3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3533,10 +3533,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    virt_machine_11_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+DEFINE_VIRT_MACHINE(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179bb..0a33f6baf41a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
+GlobalProperty hw_compat_10_2[] = {};
+const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
+
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
     { TYPE_VIRTIO_NET, "host_tunnel", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8b919cb6c47..1cdc7e0361de 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_10_2[] = {};
+const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
+
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7b3611e973cd..1b25870ec52f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -438,12 +438,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_10_2_options(MachineClass *m)
+static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(10, 2);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 0);
+
+static void pc_i440fx_machine_10_2_options(MachineClass *m)
+{
+    pc_i440fx_machine_11_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_2, hw_compat_10_2_len);
+    compat_props_add(m->compat_props, pc_compat_10_2, pc_compat_10_2_len);
+}
+
+DEFINE_I440FX_MACHINE(10, 2);
 
 static void pc_i440fx_machine_10_1_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6015e639d7bc..a0440581f72c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -374,12 +374,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_10_2_options(MachineClass *m)
+static void pc_q35_machine_11_0_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 0);
+
+static void pc_q35_machine_10_2_options(MachineClass *m)
+{
+    pc_q35_machine_11_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_2, hw_compat_10_2_len);
+    compat_props_add(m->compat_props, pc_compat_10_2, pc_compat_10_2_len);
+}
+
+DEFINE_Q35_MACHINE(10, 2);
 
 static void pc_q35_machine_10_1_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 3f65d9155617..1426ac220e4c 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_11_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    virt_machine_11_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+DEFINE_VIRT_MACHINE(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 99b843ba2faf..b93341ef5af5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4750,15 +4750,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-11.0
+ */
+static void spapr_machine_11_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 0);
+
 /*
  * pseries-10.2
  */
 static void spapr_machine_10_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_11_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(10, 2);
+DEFINE_SPAPR_MACHINE(10, 2);
 
 /*
  * pseries-10.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 64b81345f1e2..8babb256da59 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -890,14 +890,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_11_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_11_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(11, 0);
+
 static void ccw_machine_10_2_instance_options(MachineState *machine)
 {
+    ccw_machine_11_0_instance_options(machine);
 }
 
 static void ccw_machine_10_2_class_options(MachineClass *mc)
 {
+    ccw_machine_11_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(10, 2);
+DEFINE_CCW_MACHINE(10, 2);
 
 static void ccw_machine_10_1_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a48ed4f86a35..cca291d7aee9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -798,6 +798,9 @@ struct MachineState {
         } \
     } while (0)
 
+extern GlobalProperty hw_compat_10_2[];
+extern const size_t hw_compat_10_2_len;
+
 extern GlobalProperty hw_compat_10_1[];
 extern const size_t hw_compat_10_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e83157ab358f..0f1c6d3e82e7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -214,6 +214,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_10_2[];
+extern const size_t pc_compat_10_2_len;
+
 extern GlobalProperty pc_compat_10_1[];
 extern const size_t pc_compat_10_1_len;
 
-- 
2.51.1


