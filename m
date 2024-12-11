Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E090E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIaH-0005s7-PG; Wed, 11 Dec 2024 04:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa9-0005rG-It
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa7-0007pN-DT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9kzdIt2JbgsG+ooV0zwRrymUhBLnazHbdCjFy8Er1M=;
 b=R3CGeBXt3Bos6aNKFtRj4HJDIag6H53iQ9lymPOq27EQq00u7z4rdUQefRlf9T+11hmhAO
 J8Rad180SY8p6CmH3zZGzGqE85/EEJan04YwNgoI9TSvHrcuBMKdmCHuy6U/bpmFNz+xry
 DMSW9sgVc64RcT2TG/ri0tUulWPW1s4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-OpgY61oGMiuew3JZyb8PGg-1; Wed,
 11 Dec 2024 04:00:26 -0500
X-MC-Unique: OpgY61oGMiuew3JZyb8PGg-1
X-Mimecast-MFC-AGG-ID: OpgY61oGMiuew3JZyb8PGg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BD71195608A; Wed, 11 Dec 2024 09:00:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47A641956089; Wed, 11 Dec 2024 09:00:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 02/26] hw: add compat machines for 10.0
Date: Wed, 11 Dec 2024 09:59:46 +0100
Message-ID: <20241211090014.619351-3-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Add 10.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241126103005.3794748-3-cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36fbb9b59d..7456889c37 100644
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
index 890427c56e..1b26a417bd 100644
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
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..3bd9dd0f86 100644
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
index f29fe95964..e6900b43ef 100644
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
index 317aaca25a..99b9b105e2 100644
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
index 4953676170..e4365cbdb0 100644
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
index 42bdedbaa4..bbbdacda8e 100644
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
index ea5c4a5a57..d0a7a6bfe2 100644
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
index 0d4efaa0c0..7251eea521 100644
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
index fe03f716f3..67ae34aead 100644
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
-- 
2.47.1


