Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CBB109B46F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Zhr-0008Hp-Uj; Tue, 31 Mar 2026 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7Zhl-0008DQ-T3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7Zhj-00038q-Dk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774965864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cfmxl1TfHUDqDhNgICFFXmlWc+KtIbgnxWzssvtwMjw=;
 b=MqIV0n9EmsF6+cF+zvIj0WUE35YIZ80GnLdn6qKUs55QoXoOeD/1+ZJkEGQPwNszjxU2c6
 qbyFETw2HeXIhOX/R7lp3EyTrqJizlJKucvsNGo0GJeGApJqnC1NDm+R8X93whTXJCqPVR
 T7X/apXQdSnsGp9EXERwIs+Ft6Sf53o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-vqLBhffrPV-CvWz5qN6ufw-1; Tue,
 31 Mar 2026 10:04:19 -0400
X-MC-Unique: vqLBhffrPV-CvWz5qN6ufw-1
X-Mimecast-MFC-AGG-ID: vqLBhffrPV-CvWz5qN6ufw_1774965847
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1E0195609F; Tue, 31 Mar 2026 14:04:06 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.32.150])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D2F630001A1; Tue, 31 Mar 2026 14:03:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
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
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-11.1] hw: add compat machines for 11.1
Date: Tue, 31 Mar 2026 16:03:47 +0200
Message-ID: <20260331140347.653404-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.

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
 include/hw/core/boards.h   |  3 +++
 include/hw/i386/pc.h       |  3 +++
 10 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca40..d7e68d42ce02 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3719,10 +3719,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+
 static void virt_machine_11_0_options(MachineClass *mc)
 {
+    virt_machine_11_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+DEFINE_VIRT_MACHINE(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e956..1abc8ae73739 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
+GlobalProperty hw_compat_11_0[] = {};
+const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
+
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b53b5be4a96..2ecad3c503fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,6 +73,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_0[] = {};
+const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
+
 GlobalProperty pc_compat_10_2[] = {};
 const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4d71e0d51a28..82457bdb167a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_0_options(MachineClass *m)
+static void pc_i440fx_machine_11_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 0);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
+
+static void pc_i440fx_machine_11_0_options(MachineClass *m)
+{
+    pc_i440fx_machine_11_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 0);
 
 static void pc_i440fx_machine_10_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a44..972dd9275f68 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -364,12 +364,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_0_options(MachineClass *m)
+static void pc_q35_machine_11_1_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 0);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
+
+static void pc_q35_machine_11_0_options(MachineClass *m)
+{
+    pc_q35_machine_11_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+}
+
+DEFINE_Q35_MACHINE(11, 0);
 
 static void pc_q35_machine_10_2_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index ffe6e234155b..96c0fb73fea5 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_11_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+
 static void virt_machine_11_0_options(MachineClass *mc)
 {
+    virt_machine_11_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+DEFINE_VIRT_MACHINE(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ab39dfea6b8..428b491a7df1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4760,15 +4760,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-11.1
+ */
+static void spapr_machine_11_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
+
 /*
  * pseries-11.0
  */
 static void spapr_machine_11_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(11, 0);
+DEFINE_SPAPR_MACHINE(11, 0);
 
 /*
  * pseries-10.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3ef009463d11..cc768daeb04c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -907,14 +907,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_11_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_11_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
+
 static void ccw_machine_11_0_instance_options(MachineState *machine)
 {
+    ccw_machine_11_1_instance_options(machine);
 }
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    ccw_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(11, 0);
+DEFINE_CCW_MACHINE(11, 0);
 
 static void ccw_machine_10_2_instance_options(MachineState *machine)
 {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b8dad0a1074d..db83fe92922b 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -798,6 +798,9 @@ struct MachineState {
         } \
     } while (0)
 
+extern GlobalProperty hw_compat_11_0[];
+extern const size_t hw_compat_11_0_len;
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 22325324d094..85a74363b52e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -208,6 +208,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_0[];
+extern const size_t pc_compat_11_0_len;
+
 extern GlobalProperty pc_compat_10_2[];
 extern const size_t pc_compat_10_2_len;
 
-- 
2.53.0


