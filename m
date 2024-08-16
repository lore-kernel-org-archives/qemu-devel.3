Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4FC531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezaR-0008La-TT; Fri, 16 Aug 2024 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaP-0008B2-9L
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaM-0007dU-0z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3719753d365so435341f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723824832; x=1724429632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBv9iR1AT6FebtlCaxkUn6qnNvMTch8Z6TJ0HRA2r3E=;
 b=IHKrwCqDvhJkgDXry4aHitIRxlVTNCqGHikq6DY07njQX5ZRT3PIH4CgDLHORrlKmv
 MBlRchVK4Mx3PIjje02f3hRUPlycTCPm/IZ2qaZGqiv6B6EggdMZLHqrc+/cGrI8ZULq
 XK0hSMVBzaMlsBFQFisjC1rva7UHNUZ6cRAFqdmmVQnDC8NB0Fe6ybwzt631KxNuR9S7
 SB5gctS6sIeKZIXzKuS3/wqeZB3ODelJBefievgNrxuYNRiOVZ/43FqIJAB5Se7N7FOc
 KZRcHf5VqYSXr1tJFKL0SkMFdcXDpjw9Rc/JaEIeSPciBO/MhNP+qHZ25K3k1S7TBcLy
 uXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824832; x=1724429632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBv9iR1AT6FebtlCaxkUn6qnNvMTch8Z6TJ0HRA2r3E=;
 b=AGzu4I59EFt8JPwUrxQ7G2htwLY1yBmI7te6UsOjhNsi6Y2xAR1mGp+pgJ7vKaE2L/
 TyqoSLPy5Fh6jMItOblFg2adhb0qKtPMFWt0D4/iq68fyxy7ZPPb8/bE8sgiglN4cw2l
 GjmDcpyaHh9So3x7w3NVb0vXAF8Z9O7sau7MlHNtlWQsz7CFCkoSrBd5pyUwySyOKf7v
 xtYheo8uJnAxRJD+dhu0b8f6eI9Bc33m0w0PuPDWNj+GzJFcqY18pk0n75y3IgA/N/ER
 tdPSiqxejn31U06dYiVCNmg/Lu1l9+vUomCbkybFT+zs2HTRBlYNCgmWB0u1OlGftsjB
 9wAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEd2o0aQ6DArcULuXplxx/ZzNVNrZ8xEp/H3T3+SfoYOybw0Sv7U2PQLKgGgyhnwOOJOyCS7Um91ByScu11x+3VmNkXQY=
X-Gm-Message-State: AOJu0YxjF3+uf5CfCkIAVJeGfoLx6UnFF7xiCHJOrcXL5acjTPWwv59Q
 mn6o7e995jfVAdJJ5nPDu0ByxIM46+cbxsT+Q/CKDeKgjaxUO2S5oJENNjPOIew=
X-Google-Smtp-Source: AGHT+IEzagNV28tdcqgmxb2jTFVS6ztaCg81wiINGIZFJ/IPddB7rJJvhx0yM/OwfRE8JM+JgSAUrg==
X-Received: by 2002:a5d:5a15:0:b0:36b:a3c7:b9fd with SMTP id
 ffacd0b85a97d-371946bd27emr3451930f8f.56.1723824832356; 
 Fri, 16 Aug 2024 09:13:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3912269f8f.115.2024.08.16.09.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 1/4] hw: add compat machines for 9.2
Date: Fri, 16 Aug 2024 17:13:47 +0100
Message-Id: <20240816161350.3706332-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816161350.3706332-1-peter.maydell@linaro.org>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index c74931d577a..0cf4cb0d9f2 100644
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
index d9e69243b4a..746bfe05d38 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -479,13 +479,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
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
@@ -493,8 +504,6 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_machine_9_1_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     m->smbios_memory_device_size = 16 * GiB;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9d108b194e4..67162ac8863 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -361,19 +361,28 @@ static void pc_q35_machine_options(MachineClass *m)
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


