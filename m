Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A68ACD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC73-0001Qw-Kx; Thu, 05 Sep 2024 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-00010l-Qt
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001jm-6t
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bbd0a40faso6783695e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541270; x=1726146070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D0tvKCCy0OvI0M0Fet5YgAPP444KsPJZWgtcRcxhpMM=;
 b=h/jMEudq1VzyePd7QKfcCfWqiKgFHQQmBXuINwQexyoHrYyNrWrbIlIilFbTzziTbZ
 mJ/uo6ZMwxRBCLAgYt+R4DcdByZNx/rSv0RlcDkBOtt4I/vIfnkfcR6Z60DISvdP/1DS
 0I6Xg4f6mY0RjBUm2yCbA4WKLgffVpAjO6XGm9IS81sGT+jkKfHFrvwUF09blwt+Gt/T
 OGV+pNEVCn7T6hV9vPpwHz1B9mR0KSCEtD/lFoxR/PBNSyqL4SBikVz8GREB/BqZJcmQ
 2B1Ab+zWhq0RwSwQKuDr+Nv3f5bzogNY5/ALRzkR1dNIg+cvualImUddp5i+64+Iu8Y3
 Qw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541270; x=1726146070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0tvKCCy0OvI0M0Fet5YgAPP444KsPJZWgtcRcxhpMM=;
 b=D2+zJOpc7twvurVraCDnLwWcXtziiVC1Hq/WUJj1yUZzAYiyk0IZPkEe6MJEXrXZv0
 xOqn+3JXJpzbHDPuJKBVGOe9yE0ZEurlUSb5q5OZjsij8Hut48PwTD9QqMa0a7K0jtdS
 FrFGI/45BQZNgACXKV54Pj4SbrbYbpZNGWmJY1HQwn5Ur0G1tP/MewBn5wR3xctCrHpT
 Nk0rPdj/ONJbmk+P/AQeLtwArkcF5RmIiBAh5XrXcMOhBo34ifbAIV467l6QgMCyLcWh
 M6EAe839ea2QkeAroxRWOYQVqjxqAOvasEoOZYhvR1k7bamWUgmh01Op142yO7F4eAmU
 xRdA==
X-Gm-Message-State: AOJu0YxoJypvm8aLFbPSJ5oUEr2fX61B4H82Myk6jv4i5wVxEEUmCk9J
 adY06XSKYoai5pNCSyOqNW/KS7UyKi15JAs+z9Kl8P/F4e1hWYuhVKhs5Y6IU5A22TLqtRRl2Co
 J
X-Google-Smtp-Source: AGHT+IFZnzAXEyGkdFa/H4fk3FeDR7GvH9X+SlqYRf2QchxYy8FEPn3IUddSa6q0DaxvlcUIxSAVTw==
X-Received: by 2002:a05:600c:5110:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-42c880ef921mr93333495e9.9.1725541270331; 
 Thu, 05 Sep 2024 06:01:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/25] hw: add compat machines for 9.2
Date: Thu,  5 Sep 2024 14:00:45 +0100
Message-Id: <20240905130100.298768-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add 9.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240816161350.3706332-2-peter.maydell@linaro.org
Message-id: 20240816103723.2325982-1-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              | 11 +++++++++--
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 15 ++++++++++++---
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             | 11 +++++++++--
 hw/ppc/spapr.c             | 17 ++++++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 48ff6d8b93f..9a492770cbb 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -732,6 +732,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_9_1[];
+extern const size_t hw_compat_9_1_len;
+
 extern GlobalProperty hw_compat_9_0[];
 extern const size_t hw_compat_9_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4e55d7ef6ea..14ee06287da 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -215,6 +215,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_9_1[];
+extern const size_t pc_compat_9_1_len;
+
 extern GlobalProperty pc_compat_9_0[];
 extern const size_t pc_compat_9_0_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 687fe0bb8bc..a5d3ad9bf9e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3301,10 +3301,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_machine_9_1_options(MachineClass *mc)
+static void virt_machine_9_2_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
+
+static void virt_machine_9_1_options(MachineClass *mc)
+{
+    virt_machine_9_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+}
+DEFINE_VIRT_MACHINE(9, 1)
 
 static void virt_machine_9_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 27dcda02483..adaba17ebac 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_9_1[] = {};
+const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
+
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     { "scsi-hd", "migrate-emulated-scsi-request", "false" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7779c88a91e..ba0ff511836 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_9_1[] = {};
+const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
+
 GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 347afa4c370..2bf6865d405 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -474,13 +474,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_machine_9_1_options(MachineClass *m)
+static void pc_i440fx_machine_9_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
+DEFINE_I440FX_MACHINE(9, 2);
+
+static void pc_i440fx_machine_9_1_options(MachineClass *m)
+{
+    pc_i440fx_machine_9_2_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
+}
+
 DEFINE_I440FX_MACHINE(9, 1);
 
 static void pc_i440fx_machine_9_0_options(MachineClass *m)
@@ -488,8 +499,6 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_machine_9_1_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     m->smbios_memory_device_size = 16 * GiB;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f2d8edfa846..8319b6d45ee 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -356,19 +356,28 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_9_1_options(MachineClass *m)
+static void pc_q35_machine_9_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(9, 2);
+
+static void pc_q35_machine_9_1_options(MachineClass *m)
+{
+    pc_q35_machine_9_2_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
+}
+
 DEFINE_Q35_MACHINE(9, 1);
 
 static void pc_q35_machine_9_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_9_1_options(m);
-    m->alias = NULL;
     m->smbios_memory_device_size = 16 * GiB;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index cda199af8fa..ea5c4a5a570 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -366,10 +366,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
-static void virt_machine_9_1_options(MachineClass *mc)
+static void virt_machine_9_2_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
+
+static void virt_machine_9_1_options(MachineClass *mc)
+{
+    virt_machine_9_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+}
+DEFINE_VIRT_MACHINE(9, 1)
 
 static void virt_machine_9_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 370d7c35d3a..8aa3ce7449b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4838,14 +4838,25 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor, _, tag)
 
 /*
- * pseries-9.1
+ * pseries-9.2
  */
-static void spapr_machine_9_1_class_options(MachineClass *mc)
+static void spapr_machine_9_2_class_options(MachineClass *mc)
 {
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(9, 1);
+DEFINE_SPAPR_MACHINE_AS_LATEST(9, 2);
+
+/*
+ * pseries-9.1
+ */
+static void spapr_machine_9_1_class_options(MachineClass *mc)
+{
+    spapr_machine_9_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+}
+
+DEFINE_SPAPR_MACHINE(9, 1);
 
 /*
  * pseries-9.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c483ff8064d..18240a0fd8b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -871,14 +871,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_9_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_9_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(9, 2);
+
 static void ccw_machine_9_1_instance_options(MachineState *machine)
 {
+    ccw_machine_9_2_instance_options(machine);
 }
 
 static void ccw_machine_9_1_class_options(MachineClass *mc)
 {
+    ccw_machine_9_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(9, 1);
+DEFINE_CCW_MACHINE(9, 1);
 
 static void ccw_machine_9_0_instance_options(MachineState *machine)
 {
-- 
2.34.1


