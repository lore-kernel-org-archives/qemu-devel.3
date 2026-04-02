Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60905D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3C-0001MB-Sp; Thu, 02 Apr 2026 17:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2o-0000Lt-3S
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:42 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2l-0007Hz-Ho
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:41 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so207524266b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167057; x=1775771857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6mkiV7CLVebcyX6UefYuso6mVsuMOpfGW0RofMKUx8=;
 b=M34Fax9n9DAJvQgTwhFcpz6CXZ6Ij4HTI+h3dGjFCUi7zowmxjx18Wo9XpdCW0OVAG
 u4M9THcXZfFHywlQpaTBkTO2F8kyALzpFP6AhGaMWg0gh75t2TATd3oPqqNdFaTauGWA
 2PiNC/enjI/D9/6qa9GeZvoZEB98Ezf30FGYniLJGu0+/m8f1+CcExTgNDDlquODGanh
 MfH6PcUbYnt9K8UX8+7OQdE2r6rBHtd441Ej3RIpAcHUBAKDl252DuszSooxy1neV5RY
 SeKIY3zpwT0TznN+at+NJuGv8pWzbaHbY9Ohya3zQISBiZKywp78eRzRkX2dUmskS9Nq
 sV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167057; x=1775771857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n6mkiV7CLVebcyX6UefYuso6mVsuMOpfGW0RofMKUx8=;
 b=hZPKaCZTgt6DeQhTAjMEk0QTlLKgEWpq+lAUOpIMesdC+sR1HQ+LI/VB2cQ6lueXLI
 WX7OcOll7uA5qYhz9nrWg6PXyxjL2FL6YfXihgNHljrNiBkfeBeA+jstP/L+Ewj/3M7t
 mwceeRWeoasNOroTSdjipem20ckmkTR1NvHw9vgqg9lDlucvmtIr8o7w8Tv9a31X9RaN
 H0xKhaC63Ul3qNtRwFl31g/+g3HHC1XcEg+mqD7KghqJCWXA5DDpKC94h/ojfsBzcgNV
 1iwCVrH7Tj6KRmS2wifMWlshOHT4OsCyXSviQSefxgKzTwMV9IjYuSxJCEFveV0nC6rc
 ICUw==
X-Gm-Message-State: AOJu0Yyc5HDt/oLupmIOXtKAwVctrxNAKoZP/mT7tQe2LMeeWPLYcc9B
 5xi1fyjHctuRV8jNRwNaew2NBxar4ZeLWtipIHOug76AGV3se8qDz7sb7ECxAPx5
X-Gm-Gg: ATEYQzzv4bVWbR87eeXVzD0eKgj7FshpEc5IjxP9rri6nAj6rWjv4Qwi1cTqnsWnwbI
 HGuMoVTFfqF7IFuo69ITzSKEPjfocZ2HEUoJp4qnEqJNzcRQm5q04fE55iDrMeDBHnVVU46DLjL
 FZLPVoeuaA1uoBqPNcU1SVXpXk7F4jS/4QVYfw/bFw5iJ8B5NAnSEB0+NraLXG7Iv/Iyw6lg5CT
 /Kx/kMUO8ZyjBfxfII1QpA3x+AXedymOASo1a+CwC41c85inftRa76oZRnENsOMH+RTE7CXvKss
 pfiv2Knsfxu1i5d5B8zPyLXwwKsF727jUIp9v/TUzksIRKHgevKQOCMPdsohq2BIPN4k0xU6kOD
 2vh2Dm0e3LUesHwCjCm6t5WO3tSz5hF47KiuPjj77p6gSb6zwWCBAGplcDmBEEEFnXTjxRkQKQ3
 ZwqCpJfS+qpKwmJMVESEknSSHAXFF0b14MPY77sKoL9Gm/Jurt6xglRHqDpJ4d9/u40KRNNA==
X-Received: by 2002:a17:907:c988:b0:b98:32c1:249b with SMTP id
 a640c23a62f3a-b9c674465ebmr22620466b.8.1775167057079; 
 Thu, 02 Apr 2026 14:57:37 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:36 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 31/33] hw/core/fdt_generic_util: Add blockdev binding
 support
Date: Thu,  2 Apr 2026 23:56:16 +0200
Message-ID: <20260402215629.745866-32-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The path add possibility to bind to QEMU block backends
via the blockdev-node-name property.

This enables support for the modern -blockdev command line option.

Since the generic FDT initialization traverses the device tree
inside  QEMU coroutines, realizing block devices immediately
causes conflict: QEMU's block subsystem and AIO (Asynchronous I/O)
are not compatible with being invoked from within these setup
coroutines. To resolve this block device initialization are
moved to the latest stage outside of co-routing context.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index ae54ada11d..7d074745b5 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -69,6 +69,8 @@ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
                                        char *intc_node_path,
                                        uint32_t *cells, uint32_t num_cells,
                                        uint32_t max, Error **errp);
+static bool fdt_attach_blockdev(FDTMachineInfo *fdti,
+                                const char *node_path, Object *dev);
 
 typedef struct QEMUIRQSharedState {
     qemu_irq sink;
@@ -173,6 +175,19 @@ static void fdt_init_deferred(FDTMachineInfo *fdti)
 {
     while (fdti->deferred) {
         FDTDeferredNode *dnode = fdti->deferred;
+        int length = 0;
+
+        int offset = fdt_path_offset(fdti->fdt, dnode->node_path);
+        if (offset < 0) {
+            error_report("%s Couldn't find node %s: %s", __func__,
+                         dnode->node_path, fdt_strerror(offset));
+        }
+        const char *blockdev = fdt_stringlist_get(fdti->fdt, offset,
+                                              "blockdev-node-name", 0, &length);
+
+        if (blockdev && object_property_find(OBJECT(dnode->dev), "drive")) {
+            fdt_attach_blockdev(fdti, dnode->node_path, OBJECT(dnode->dev));
+        }
 
         fdt_debug("FDT: Deferred realize node: %s\n",
                  dnode->node_path);
@@ -212,6 +227,8 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
     current_machine->smp.cpus = fdt_generic_num_cpus;
     current_machine->smp.max_cpus = fdt_generic_num_cpus;
 
+    bdrv_drain_all();
+
     fdt_debug("FDT: Device tree scan complete\n");
     return fdti;
 }
@@ -707,6 +724,47 @@ static void fdt_init_qdev_array_prop(Object *obj,
     fdt_debug_np("set property %s propname to <list>\n", propname);
 }
 
+/*
+ * Try to attach by matching drive created by '-blockdev node-name=LABEL'
+ * iff the FDT node contains property 'blockdev-node-name=LABEL'.
+ *
+ * Return false unless the given node_path has the property.
+ *
+ */
+static bool fdt_attach_blockdev(FDTMachineInfo *fdti,
+                                const char *node_path, Object *dev)
+{
+    static const char propname[] = "blockdev-node-name";
+    const char *label;
+
+    /* Inspect FDT node for blockdev-only binding */
+    label = qemu_fdt_getprop(fdti->fdt, node_path, propname,
+                             NULL, NULL);
+
+    /* Skip legacy node */
+    if (!label) {
+        return false;
+    }
+
+    /*
+     * Missing matching bdev is not an error: attachment is optional.
+     *
+     * error_setg() aborts, never returns: 'return false' is just sanity.
+     */
+    if (!label[0]) {
+        error_setg(&error_abort, "FDT-node '%s': property '%s' = <empty>",
+                   node_path, propname);
+        return false;
+    }
+
+    if (!bdrv_find_node(label)) {
+        return false;
+    }
+
+    object_property_set_str(OBJECT(dev), "drive", label, NULL);
+    return true;
+}
+
 static void fdt_init_qdev_properties(char *node_path, FDTMachineInfo *fdti,
                                      Object *dev)
 {
@@ -1048,6 +1106,7 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
     char *parent_node_path;
+    ObjectProperty *p;
 
     if (!compat) {
         return 1;
@@ -1086,12 +1145,30 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_init_qdev_properties(node_path, fdti, dev);
 
+    /*
+     * In case device need to be attached to block backend,
+     * defer realize to latest stage, outside of co-routines,
+     * which are not compatible with AIO used by block subsystem
+     */
+    p = object_property_find(dev, "drive");
+    if (p && !strcmp(p->type, "str")) {
+        FDTDeferredNode *dnode = g_new0(FDTDeferredNode, 1);
+        *dnode = (FDTDeferredNode) {
+                .dev = DEVICE(dev),
+                .node_path = g_strdup(node_path),
+                .next = fdti->deferred
+        };
+        fdti->deferred = dnode;
+        goto exit;
+    }
+
     fdt_init_device_realize(fdti, node_path, dev);
 
     fdt_parse_node_reg_prop(fdti, node_path, dev);
 
     fdt_parse_node_irq_prop(fdti, node_path, dev);
 
+exit:
     g_free(parent_node_path);
 
     return 0;
-- 
2.43.0


