Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27453CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qs-0005yj-9X; Tue, 07 Oct 2025 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qe-0005qV-3e
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QM-0002L2-CU
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so49131165e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846336; x=1760451136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dGmYbo2rVXtajcKm/g3Rndf5Lcf2+PivR+N0VoHyQDg=;
 b=hlCPBhd3Jb8DYyBv7q6VKXsbpOZT2Nfd/R3Be71KZXX9Y75AmYh1pV6bcD/LMQY7+O
 KI0nHfQNPk2LBMhlisGSmy0tWFGrf1wc6nLvBxuDy50aH6UcJzFP6O0r9xBDSPLVUvqY
 MFWwz12dUr3hoU6tjFKjySt/l4sYdQFB7KC3WpOYLJCYHsp1P8Sb1J8oJ5G2g6UYPbdV
 BkcRExKvoXWMr35hm/DEiyc0CdpKWNWLKTg399IoA2Kgj+h15wH2M1daQjuewpo2Yw9g
 I3jNOWo61pMhXmkdsAl+hLc3LfBBJW/0lpy3Aow70A6EbadKgB68uXlPrLjCG0Bp2nkk
 SUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846336; x=1760451136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGmYbo2rVXtajcKm/g3Rndf5Lcf2+PivR+N0VoHyQDg=;
 b=sNrwlr+Jkq+rAnKYKeivhX//CpIXhi0TOiSVkzHOxbA1TKAN03jFsrrkPdGKFkcmQx
 6yJN1+hqwnh2vZB1Y17o8yjSPoEB52xYADGm4U3c4VakXHgeyBQhG7rU/Bj6Q0Nlc7eT
 VivU7R/fp8BlEH0IByE2ScVPNRktz3AfTXJ53EyqwPSb+jk6Ytb51F7azy2putbS2riR
 6b75r24cC5Y94GP6Y6B0rQuPY9ZeTRsVEE9kHH5yeWcOZMz5D8Qg7WX/5XLJ7LCLrRMQ
 MYXGYpQtWFng5hACOk0B3xRChidFNJkKUjCvD8n7kw5CAtKHhe6uC1jmxR+Ryysr3ed9
 RijA==
X-Gm-Message-State: AOJu0Yyi3wiP7gAU+ni8J9MHAMNlEFmcdMRYMPRv7EI4AjXyjaiaIKjq
 GhOjPuFmkeEjBsqQOBbh5iVBwD2CBXB/i0QjxalKojrPl4oOJV/Bvy1hHj/61YyZTEwR9x98GYC
 0Dd5O
X-Gm-Gg: ASbGncvD3SUyjaG7A1Kuarq1ZbM86mXyZxemL8d7gT5wxHBZJCZDB5fh/a/FIX8JluL
 jQsii1AltqVMJTTzFpkWbCly3cI45UEmCE6Wgjl/CGIiJ0gPopBvzvoWaDa3tIjbzjJ1rYHTgZr
 wrZII0Xx6Nv3RDoOA2NKudcfqqbjjnxtjt+qJgGSsvyM72zjH0BTzybn3aq6BxCpBcmj7huw1AO
 DKN76Et7KoEPbaWc5W9DA99U7OnGNz5ONyMAAip9DduZLeYWUyJCTH3BhbNJsn5He485ru75A66
 qq6jMzmy0+oWDcaKjdOYBAwC0apU5h5SY/Eh2FyAsjprUn+X3ExDtDCv57iJkfeLxW73OMmgP8e
 2pr28m6ykYyi3K32GgQv/QPQlcu0WFAWeKANrSx/Ib6Jr9qIXjZA9605kTimSjrZzJds=
X-Google-Smtp-Source: AGHT+IETWbmWtYS7DhIY/Va5c8eDS1nYo/wVpcKr4/ymkDagAZbzDr9ZF5r7gLgG3Kp9NQkjwSFoVg==
X-Received: by 2002:a05:600c:a118:b0:46e:4784:cdf5 with SMTP id
 5b1f17b1804b1-46e7227f720mr85550685e9.15.1759846336243; 
 Tue, 07 Oct 2025 07:12:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/62] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Tue,  7 Oct 2025 15:11:07 +0100
Message-ID: <20251007141123.3239867-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

Add the Versal Gen 2 Virtual development machine embedding a
versal2 SoC. This machine follows the same principle than the
xlnx-versal-virt machine. It creates its own DTB and feeds it to the
software payload. This way only implemented devices are exposed to the
guest and the user does not need to provide a DTB.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-47-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 49 ++++++++++++++++++++++++----
 hw/arm/xlnx-versal-virt.c            | 37 +++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 5d7fa18592b..640cc07f808 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -1,14 +1,16 @@
-AMD Versal Virt (``amd-versal-virt``)
-=====================================
+AMD Versal Virt (``amd-versal-virt``, ``amd-versal2-virt``)
+===========================================================
 
 AMD Versal is a family of heterogeneous multi-core SoCs
 (System on Chip) that combine traditional hardened CPUs and I/O
 peripherals in a Processing System (PS) with runtime programmable
 FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
 
-QEMU implements the Versal Series variant of Versal SoCs, with the
-``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
-backward compatibility.
+QEMU implements the following Versal SoCs variants:
+
+- Versal (the ``amd-versal-virt`` machine, the alias ``xlnx-versal-virt`` is
+  kept for backward compatibility)
+- Versal Gen 2 (the ``amd-versal2-virt`` machine)
 
 More details here:
 https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
@@ -21,6 +23,8 @@ The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
+Versal
+""""""
 Implemented CPU cores:
 
 - 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
@@ -43,6 +47,28 @@ Implemented devices:
 - OSPI controller
 - TRNG controller
 
+Versal Gen 2
+""""""""""""
+Implemented CPU cores:
+
+- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
+- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
+
+Implemented devices:
+
+- 2 UARTs (ARM PL011)
+- An RTC (Versal built-in)
+- 3 GEMs (Cadence MACB Ethernet MACs)
+- 8 ADMA (Xilinx zDMA) channels
+- 2 SD Controllers
+- OCM (256KB of On Chip Memory)
+- DDR memory
+- BBRAM (36 bytes of Battery-backed RAM)
+- 2 CANFDs
+- 2 USB controllers
+- OSPI controller
+- TRNG controller
+
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
 Other differences between the hardware and the QEMU model:
@@ -51,8 +77,8 @@ Other differences between the hardware and the QEMU model:
   ``-m`` argument. If a DTB is provided on the command line then QEMU will
   edit it to include suitable entries describing the Versal DDR memory ranges.
 
-- QEMU provides 8 virtio-mmio virtio transports; these start at
-  address ``0xa0000000`` and have IRQs from 111 and upwards.
+- QEMU provides 8 virtio-mmio virtio transports. They use reserved memory
+  regions and IRQ pins to avoid conflicts with real SoC peripherals.
 
 Running
 """""""
@@ -214,6 +240,11 @@ To use a different index value, N, from default of 0, add:
 
 eFUSE File Backend
 """"""""""""""""""
+
+.. note::
+   The eFUSE device is not implemented in the Versal Gen 2 QEMU model
+   yet.
+
 eFUSE can have an optional file backend, which must be a seekable
 binary file with a size of 3072 bytes or larger. A file with all
 binary 0s is a 'blank'.
@@ -271,3 +302,7 @@ To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
 
     -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
     -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
+
+.. note::
+   Versal Gen 2 has 4 CAN controllers. ``canbus0`` to ``canbus3`` can
+   be specified on the command line.
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 14c2d5cc924..149b448546e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,5 +1,5 @@
 /*
- * AMD/Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal family Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
@@ -29,6 +29,7 @@
 OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
+#define TYPE_XLNX_VERSAL2_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal2-virt")
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
 
@@ -57,7 +58,9 @@ struct VersalVirtClass {
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
     const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
+    const char versal2_compat[] = "amd-versal2-virt";
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
@@ -71,8 +74,18 @@ static void fdt_create(VersalVirt *s)
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
-    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
-                     sizeof(versal_compat));
+
+    switch (vvc->version) {
+    case VERSAL_VER_VERSAL:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
+                         sizeof(versal_compat));
+        break;
+
+    case VERSAL_VER_VERSAL2:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal2_compat,
+                         sizeof(versal2_compat));
+        break;
+    }
 }
 
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
@@ -363,6 +376,17 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
     versal_virt_machine_class_init_common(oc);
 }
 
+static void versal2_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
+
+    mc->desc = "AMD Versal Gen 2 Virtual development board";
+    vvc->version = VERSAL_VER_VERSAL2;
+
+    versal_virt_machine_class_init_common(oc);
+}
+
 static const TypeInfo versal_virt_base_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .parent     = TYPE_MACHINE,
@@ -379,10 +403,17 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .class_init = versal_virt_machine_class_init,
 };
 
+static const TypeInfo versal2_virt_machine_init_typeinfo = {
+    .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
+    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
+    .class_init = versal2_virt_machine_class_init,
+};
+
 static void versal_virt_machine_init_register_types(void)
 {
     type_register_static(&versal_virt_base_machine_init_typeinfo);
     type_register_static(&versal_virt_machine_init_typeinfo);
+    type_register_static(&versal2_virt_machine_init_typeinfo);
 }
 
 type_init(versal_virt_machine_init_register_types)
-- 
2.43.0


