Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 09:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEPR-0001sC-CJ; Tue, 05 Aug 2025 05:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ujEPP-0001kB-Ql
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ujEPL-0006F3-V5
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754387795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bzq34FiWm0wfvCey6NYUjZn041sdnei4qrksad1k2KU=;
 b=HKPoyyHkwU0lgLc5eZZZICKobILVEcHI+0c/39OAZ1twMV85iQEWWmtX5mahnjyRlwfiMY
 dOJBV0Mad+8PVn8A3w4EwNA2fWZEYzHrn23V7h0ByDsKEwHNtxH+CXecq1QIls91VP51kv
 VYL2XXIVMJQ2tplo4kGmCi5S/VAcNgI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-PaA6FVlSOdWjb2HGtzq9qg-1; Tue,
 05 Aug 2025 05:56:30 -0400
X-MC-Unique: PaA6FVlSOdWjb2HGtzq9qg-1
X-Mimecast-MFC-AGG-ID: PaA6FVlSOdWjb2HGtzq9qg_1754387788
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C23E51800446; Tue,  5 Aug 2025 09:56:27 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-236.str.redhat.com
 [10.33.192.236])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B6E11800D82; Tue,  5 Aug 2025 09:56:20 +0000 (UTC)
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
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-10.2] hw: add compat machines for 10.2
Date: Tue,  5 Aug 2025 11:56:16 +0200
Message-ID: <20250805095616.1168905-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add 10.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.

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
index ef6be3660f5f..9326cfc895f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3455,10 +3455,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_10_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    virt_machine_10_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+DEFINE_VIRT_MACHINE(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bd47527479a7..38c949c4f2ce 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_10_1[] = {};
+const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
+
 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f58e73d3347..bc048a6d1374 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_10_1[] = {};
+const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
+
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c03324281bdb..d165ac72ed75 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -504,12 +504,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_10_1_options(MachineClass *m)
+static void pc_i440fx_machine_10_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(10, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(10, 2);
+
+static void pc_i440fx_machine_10_1_options(MachineClass *m)
+{
+    pc_i440fx_machine_10_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
+}
+
+DEFINE_I440FX_MACHINE(10, 1);
 
 static void pc_i440fx_machine_10_0_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b309b2b378db..e89951285e58 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -374,12 +374,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_10_1_options(MachineClass *m)
+static void pc_q35_machine_10_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(10, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
+
+static void pc_q35_machine_10_1_options(MachineClass *m)
+{
+    pc_q35_machine_10_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
+}
+
+DEFINE_Q35_MACHINE(10, 1);
 
 static void pc_q35_machine_10_0_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 875fd00ef8d2..98cfe43c73ae 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_10_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    virt_machine_10_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+DEFINE_VIRT_MACHINE(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1855a3cd8d03..eb22333404d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4761,15 +4761,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-10.2
+ */
+static void spapr_machine_10_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(10, 2);
+
 /*
  * pseries-10.1
  */
 static void spapr_machine_10_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_10_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(10, 1);
+DEFINE_SPAPR_MACHINE(10, 1);
 
 /*
  * pseries-10.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a79bd13275b9..d0c6e80cb050 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -911,14 +911,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_10_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_10_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(10, 2);
+
 static void ccw_machine_10_1_instance_options(MachineState *machine)
 {
+    ccw_machine_10_2_instance_options(machine);
 }
 
 static void ccw_machine_10_1_class_options(MachineClass *mc)
 {
+    ccw_machine_10_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(10, 1);
+DEFINE_CCW_MACHINE(10, 1);
 
 static void ccw_machine_10_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f94713e6e29a..665b6201214c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -779,6 +779,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_10_1[];
+extern const size_t hw_compat_10_1_len;
+
 extern GlobalProperty hw_compat_10_0[];
 extern const size_t hw_compat_10_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 79b72c54dd3f..e83157ab358f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -214,6 +214,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_10_1[];
+extern const size_t pc_compat_10_1_len;
+
 extern GlobalProperty pc_compat_10_0[];
 extern const size_t pc_compat_10_0_len;
 
-- 
2.50.1


