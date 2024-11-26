Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14153D59D94
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 10:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFsqd-0002ZX-6g; Tue, 26 Nov 2024 05:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tFsqL-0002SJ-NW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tFsqI-0007mw-Ly
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732617048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24MQjD2ov8ibqklvMbqTPPkqgCUofFMsmaEtkvzM6kI=;
 b=LVIJtRgT7dZYHN84a3PRxGl4Arh5z3pykczLKxpIKLdtqBbigqhvJx/a1OZQgxBOl3cdov
 ovLR25y3C59YQn48MRKG+se7RizzOYfQY3uYTHZ6WJgUHiI5k60m7GwGtIquFjkAq+kPyR
 ZOtC6tUiUcpa7TJFimFllCiefAof6zw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-wj3l6WqrNHu0yu9atB2Sog-1; Tue,
 26 Nov 2024 05:30:43 -0500
X-MC-Unique: wj3l6WqrNHu0yu9atB2Sog-1
X-Mimecast-MFC-AGG-ID: wj3l6WqrNHu0yu9atB2Sog
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DE1A1955F34; Tue, 26 Nov 2024 10:30:35 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-244.str.redhat.com
 [10.33.192.244])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9B5E1955F40; Tue, 26 Nov 2024 10:30:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-10.0 2/2] hw: add compat machines for 10.0
Date: Tue, 26 Nov 2024 11:30:05 +0100
Message-ID: <20241126103005.3794748-3-cohuck@redhat.com>
In-Reply-To: <20241126103005.3794748-1-cohuck@redhat.com>
References: <20241126103005.3794748-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add 10.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.

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
index 1a381e9a2bd7..3bd9dd0f863c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3353,10 +3353,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_10_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)
+
 static void virt_machine_9_2_options(MachineClass *mc)
 {
+    virt_machine_10_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
+DEFINE_VIRT_MACHINE(9, 2)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a35c4a8faecb..6b8b0353ff0a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,6 +36,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_9_2[] = {};
+const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
+
 GlobalProperty hw_compat_9_1[] = {
     { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 317aaca25a06..99b9b105e26d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_9_2[] = {};
+const size_t pc_compat_9_2_len = G_N_ELEMENTS(pc_compat_9_2);
+
 GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 495367617009..e4365cbdb0a4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -477,12 +477,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_machine_9_2_options(MachineClass *m)
+static void pc_i440fx_machine_10_0_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(9, 2);
+DEFINE_I440FX_MACHINE_AS_LATEST(10, 0);
+
+static void pc_i440fx_machine_9_2_options(MachineClass *m)
+{
+    pc_i440fx_machine_10_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_9_2, hw_compat_9_2_len);
+    compat_props_add(m->compat_props, pc_compat_9_2, pc_compat_9_2_len);
+}
+
+DEFINE_I440FX_MACHINE(9, 2);
 
 static void pc_i440fx_machine_9_1_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 42bdedbaa403..bbbdacda8e4a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -359,12 +359,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_9_2_options(MachineClass *m)
+static void pc_q35_machine_10_0_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(9, 2);
+DEFINE_Q35_MACHINE_AS_LATEST(10, 0);
+
+static void pc_q35_machine_9_2_options(MachineClass *m)
+{
+    pc_q35_machine_10_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_9_2, hw_compat_9_2_len);
+    compat_props_add(m->compat_props, pc_compat_9_2, pc_compat_9_2_len);
+}
+
+DEFINE_Q35_MACHINE(9, 2);
 
 static void pc_q35_machine_9_1_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index ea5c4a5a570b..d0a7a6bfe241 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -366,10 +366,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_10_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)
+
 static void virt_machine_9_2_options(MachineClass *mc)
 {
+    virt_machine_10_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
+DEFINE_VIRT_MACHINE(9, 2)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c5644..167bbe6d1bef 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4732,15 +4732,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-10.0
+ */
+static void spapr_machine_10_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(10, 0);
+
 /*
  * pseries-9.2
  */
 static void spapr_machine_9_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_10_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(9, 2);
+DEFINE_SPAPR_MACHINE(9, 2);
 
 /*
  * pseries-9.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fe03f716f314..67ae34aead90 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -849,14 +849,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_10_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_10_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(10, 0);
+
 static void ccw_machine_9_2_instance_options(MachineState *machine)
 {
+    ccw_machine_10_0_instance_options(machine);
 }
 
 static void ccw_machine_9_2_class_options(MachineClass *mc)
 {
+    ccw_machine_10_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(9, 2);
+DEFINE_CCW_MACHINE(9, 2);
 
 static void ccw_machine_9_1_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36fbb9b59df8..7456889c37eb 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -756,6 +756,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_9_2[];
+extern const size_t hw_compat_9_2_len;
+
 extern GlobalProperty hw_compat_9_1[];
 extern const size_t hw_compat_9_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 890427c56ed2..1b26a417bd45 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -215,6 +215,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_9_2[];
+extern const size_t pc_compat_9_2_len;
+
 extern GlobalProperty pc_compat_9_1[];
 extern const size_t pc_compat_9_1_len;
 
-- 
2.47.0


