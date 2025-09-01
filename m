Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97575CA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut42D-0002VG-AA; Mon, 01 Sep 2025 08:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut42B-0002UL-2I
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut424-0004K3-Et
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:18 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7ace3baso152874066b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731190; x=1757335990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nE5XbQX1l3HPdpz27sy7iDEM+Ja0XPXUjoIOVCTCuVA=;
 b=r6jfRZLDcc0bS6s38oN3uo+KVYGDkuq1Q1L63NII0uZyOAQxWe9Mys7XRqk9hDe3nw
 NH6llzripUhOc9KNbUXnZcZTgom7J6ZzNQoN3MZ6yF/2shlXArdLHWCoZuog3NUBSDe0
 5pBb+jNlrX0gNjnSl8JdR9g+pgFX9u6O33L5O2WkxHM/yQMDiVdLxoJPRRuOaNK+UZOl
 juyzFUHc1gnht0rxr8o4pcAQhH6jpadmz+zCnOhqYJLb+YSZ9Wh00/zDEGoh5xrMtNzu
 D0oljdGMFZ/DenumAC+awyTmMtWf9Gss6c+ejfL26fhZVdpuoCamGjMYpLCNJMdPAZgt
 2Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731190; x=1757335990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nE5XbQX1l3HPdpz27sy7iDEM+Ja0XPXUjoIOVCTCuVA=;
 b=d/uWXJo9ETwFZxvMG1nZYKIvAJqQmBRdU4Di8G9fyhpFlMDtnW0qjFOqOeLMeu6tjT
 HcjOY6LhmTi316PipGLwjfJUiER+gAU3TAs9T8FoTrU5dlPz8akpNdO/Zk9oV0L2Vk7j
 +yEQc4MDIq7uud1jwP5xJwC7ud9iZuCj/Wy/sNzDN4O7u0lnR5e8E9/dTYzEATC5i874
 YV3rlZ1YwEyTFT0mDy//nr4a4VXtuBJtpaWaksJcxUrpQ6CWSmTId/QDTZ7aVGT8ucro
 27Hi69gmUGsERqaOjcPFLVcHuvNSeQkoj1aVx79oGI05XYgrkk/9Vz+AMt8Fllkyokfq
 HZCw==
X-Gm-Message-State: AOJu0Yy4lY83xuyFRBdXbdVS5QMTWtSh9PbtLFNw3ld3pnfPsgTxwTrP
 0h/ILKH5541uYkGus1njTZ5SL8nutjHu1GUyJ6TN5+4itQkiJOCVpFhYMnBNYlGzdzE=
X-Gm-Gg: ASbGncuwIBZIL3Mu37i0dXb4p8apRxHkpOZm/bQmvfdcJuKa2bW8hjTdNsZGbi90jLR
 Aul0hdfqx/KzSgN3W0ifHIdJrMAwFi6knY7p8xqrsNqqKhNME6LoRxUHsdie4CQZHy64SShc2an
 sDZInSFouenAkjoFSWhunV995E/4hHgQgJf6EBXqh5myS8JSh3iTNgzbqbhGghSjT8BJdWp1YZh
 4ihGoWaed8fFwwqh7Z/VtpOUx36yKPk3WDsOonproQcj7m8uH9ewxroGr5SPogBY1MFMeHdhXDe
 6ggqDZ/sDoKNIaL2EezmlJc7HP8x1WLKSVrZ8I0Ax5g4mMhm++mTsOfyeOlvsCcBY/Us/HGmIPC
 iLOSsiXlhKnDunEHWgDVx4jMtD8YNRbWwIA==
X-Google-Smtp-Source: AGHT+IH5wY9UM8wYVuQrP/tp8PUqQjdH1VZt++ZEjK7J7m6F+2Ab6Y5bondzq97wT8u9FfoGMIYpPQ==
X-Received: by 2002:a17:907:3da9:b0:ae3:f2a0:459f with SMTP id
 a640c23a62f3a-b01d9793bd1mr835706266b.54.1756731189820; 
 Mon, 01 Sep 2025 05:53:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0410138d0asm454389766b.53.2025.09.01.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:53:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CD745F8DC;
 Mon, 01 Sep 2025 13:53:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] hw/arm: expose Error * to arm_load_dtb
Date: Mon,  1 Sep 2025 13:53:04 +0100
Message-ID: <20250901125304.1047624-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901125304.1047624-1-alex.bennee@linaro.org>
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Currently all calls to arm_load_dtb will result in an exit if we fail.
By passing Error * we can use &error_fatal and properly set the error
report.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/boot.h |  3 ++-
 hw/arm/boot.c         | 35 +++++++++++++++--------------------
 hw/arm/virt.c         |  6 +++---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index a2e22bda8a5..fdb99c0c1ee 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -164,6 +164,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * @addr_limit: upper limit of the available memory area at @addr
  * @as:         address space to load image to
  * @cpu:        ARM CPU object
+ * @errp:       Error object, often &error_fatal
  *
  * Load a device tree supplied by the machine or by the user  with the
  * '-dtb' command line option, and put it at offset @addr in target
@@ -181,7 +182,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  */
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
-                 ARMCPU *cpu);
+                 ARMCPU *cpu, Error **errp);
 
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index f9d0bc7011e..d28ae8b86ab 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -517,7 +517,7 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
 
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
-                 ARMCPU *cpu)
+                 ARMCPU *cpu, Error **errp)
 {
     g_autofree void *fdt = NULL;
     g_auto(GStrv) node_path = NULL;
@@ -525,25 +525,24 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     uint32_t acells, scells;
     unsigned int i;
     hwaddr mem_base, mem_len;
-    Error *err = NULL;
 
     if (binfo->dtb_filename) {
         g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_DTB,
                                                    binfo->dtb_filename);
         if (!filename) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
+            error_setg(errp, "Couldn't open dtb file %s", binfo->dtb_filename);
             return -1;
         }
 
         fdt = load_device_tree(filename, &size);
         if (!fdt) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", filename);
+            error_setg(errp, "Couldn't open dtb file %s", filename);
             return -1;
         }
     } else {
         fdt = binfo->get_dtb(binfo, &size);
         if (!fdt) {
-            fprintf(stderr, "Board was unable to create a dtb blob\n");
+            error_setg(errp, "Board was unable to create a dtb blob");
             return -1;
         }
     }
@@ -561,7 +560,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
     if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        error_setg(errp, "dtb file invalid (#address-cells or #size-cells 0)");
         return -1;
     }
 
@@ -569,15 +568,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         /* This is user error so deserves a friendlier error message
          * than the failure of setprop_sized_cells would provide
          */
-        fprintf(stderr, "qemu: dtb file not compatible with "
-                "RAM size > 4GB\n");
+        error_setg(errp, "qemu: dtb file not compatible with RAM size > 4GB");
         return -1;
     }
 
     /* nop all root nodes matching /memory or /memory@unit-address */
-    node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
-    if (err) {
-        error_report_err(err);
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", errp);
+    if (!node_path) {
         return -1;
     }
     while (node_path[n]) {
@@ -607,7 +604,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
             rc = fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
             if (rc < 0) {
-                fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
+                error_setg(errp, "couldn't add /memory@%"PRIx64" node",
                         mem_base);
                 return -1;
             }
@@ -618,7 +615,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
                                  scells, binfo->ram_size, -1);
         if (rc < 0) {
-            fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
+            error_setg(errp, "couldn't add /memory@%"PRIx64" node",
                     binfo->loader_start);
             return -1;
         }
@@ -633,7 +630,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                      ms->kernel_cmdline);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+            error_setg(errp, "couldn't set /chosen/bootargs");
             return -1;
         }
     }
@@ -642,7 +639,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-start",
                                           acells, binfo->initrd_start);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+            error_setg(errp, "couldn't set /chosen/linux,initrd-start");
             return -1;
         }
 
@@ -651,7 +648,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                           binfo->initrd_start +
                                           binfo->initrd_size);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+            error_setg(errp, "couldn't set /chosen/linux,initrd-end");
             return -1;
         }
     }
@@ -1321,10 +1318,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
      * decided whether to enable PSCI and set the psci-conduit CPU properties.
      */
     if (!info->skip_dtb_autoload && have_dtb(info)) {
-        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit,
-                         as, ms, cpu) < 0) {
-            exit(1);
-        }
+        arm_load_dtb(info->dtb_start, info, info->dtb_limit,
+                     as, ms, cpu, &error_fatal);
     }
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9326cfc895f..6061e0ddb50 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1803,9 +1803,9 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
-    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
-        exit(1);
-    }
+
+    arm_load_dtb(info->dtb_start, info, info->dtb_limit,
+                 as, ms, cpu, &error_fatal);
 
     pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
                                        &error_abort);
-- 
2.47.2


