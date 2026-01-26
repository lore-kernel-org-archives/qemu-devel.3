Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37668D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQdF-0001kw-Fn; Mon, 26 Jan 2026 12:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcz-0001Ux-R1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcy-0000FP-3w
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso2489891f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449430; x=1770054230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1/ePB9LfA6lgNwZNwykzC9p7sr9jarFSpmO192awuI=;
 b=jWQkI0GPYRAnUm/wX26ExOhLeemRTG3LtltfO+gLJrGOkHLFmdqK8vzZSlkhsyEMOv
 3fNzBAdxXrROU2UB+jSy+maek7MTY6+xGaMBGgkagdpjJsh8SH2PPaPbTkEWAZSBPA5Z
 8eGBhvFweFaV6ICRxXO2pTEAAAIXWLgg8EBqEUlIQp3ixSLBhO3jf2v7z3VGp+oUgM7E
 G5HW/Tqv0XIIElJFfoglT/1JWuggHy2PTY+stHJgjfLGLZmE+lh/PSqm0nDScrbDbywp
 NA8+IQYU06pg/kGzIZmnisuU1ayljmIImyoIBgifQlRbm3CRKygysVWsLlhnu8ZPfpv1
 kGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449430; x=1770054230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y1/ePB9LfA6lgNwZNwykzC9p7sr9jarFSpmO192awuI=;
 b=dn3oxPKUJ6tVIe6r2eFsB5pGS9VlqDfkd81WtPSp+FC9eq2InOPmZC1gEvwPt/Ke4i
 aGildLu8zRheSqBfCPFthypDjhF4Irf0MrJ903fvF07lYyLCiw4gsiDGzMDuauazBeBC
 V0g+bEf2NtzWra6q9/IEU9w9o9hDxfKN8ABYTa2BEGDrdaoKSpAmWjXnC0VaZdwxy+up
 2Fwu/AXZxyb5PA7rC8xNLeb9fseCbofOcmymdBjlewLYc1nAwYbCsRxey8zEfq+GkRJZ
 LwXv2PZEpBHrMzMm4k2GBjpmv+pAJ9aQyk4sirzfbiG+Tlo7Hgm5vwOzl5klf9fQI1eJ
 nI0w==
X-Gm-Message-State: AOJu0YyepAFHjSZ8ymi4oFSuQztY8klvRTX3np7N5ytBTCi+fOSWV//j
 WdpJBCkYfUIZtuHEGJJW/3HEb7WBoDxA+JdK1u6l5dPwIFYxrE8FpKtLYZXHk1j9
X-Gm-Gg: AZuq6aJkuUPKPoV85UtYlIfmn4hgPlk2jo3D36tDfNOVZhhARZGJoDhL64pJa24rvmM
 mTYSX+ICKSENowIgoEoZ1j4B8LvaLGIDfMXxb+udXfjGsbmdCx5jFkL6lnk3+9MZCU3l39iy1yq
 Mk4iOKQULFOxch74SjLc26lYgEMKe339Zb8EFijq2nnUFuxBAqxYZVGLyug1Z4HoWtIPfXk0sq5
 ld5O2tCN9mDaV4OCpIusZxVnU226CVvQskL9+ofSkF4cMDvGLBp4/L6fN0NoVVjHtyT3vUtJgGP
 1l5IrO5vA3OBKEGJkdSkzWrs4QT5mvxuh11s5tefpHJGYU46ToHsFh/cHG9OK9YrtJBRAvv9iWI
 a5kG8EaZit0n1pC11TVtSmC6KKzfSbJ0tWlNlGtSGgWkypKEdiVYp06gIwPa3ctNnECMTdzL3Wq
 dyHgRGs4+NR6QjpsiT2EkjN3C/fNuI97lOjVqLbDvSg4l7uQKGFGg1931OnhKikp8T
X-Received: by 2002:a05:6000:4210:b0:435:9770:9eb6 with SMTP id
 ffacd0b85a97d-435ca39bf86mr9553465f8f.53.1769449430388; 
 Mon, 26 Jan 2026 09:43:50 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:50 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 26/27] hw/core/fdt_generic_util: initialize serial devices
Date: Mon, 26 Jan 2026 18:43:12 +0100
Message-ID: <20260126174313.1418150-27-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x429.google.com
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

The patch adds proper handling and registration
for serial devices instantiated via FDT.
In specific, device's 'chardev' FDT properties
are correctly set to their objects.

Also devices with 'chardev' properties are
connected to serial backends.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 83ce5b3466..d183a44433 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -36,6 +36,7 @@
 #include "system/system.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
@@ -68,6 +69,7 @@
 #include <stdlib.h>
 
 static int fdt_generic_num_cpus;
+static int fdt_serial_ports;
 
 static int simple_bus_fdt_init(char *bus_node_path, FDTMachineInfo *fdti);
 
@@ -175,6 +177,8 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 
     fdti->irq_base = cpu_irq;
 
+    fdt_serial_ports = 0;
+
     /* parse the device tree */
     if (!qemu_devtree_get_root_node(fdt, node_path)) {
         memory_region_transaction_begin();
@@ -1096,6 +1100,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     props = qemu_devtree_get_props(fdti->fdt, node_path);
     for (prop = props; prop->name; prop++) {
         const char *propname = trim_vendor(prop->name);
+        int len = prop->len;
+        void *val = prop->value;
         ObjectProperty *p = NULL;
 
         p = object_property_find(OBJECT(dev), propname);
@@ -1112,6 +1118,27 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
             continue;
         }
 
+        /* Special case for chardevs. It's an ordered list of strings.  */
+        if (!strcmp(propname, "chardev") && !strcmp(p->type, "str")) {
+            const char *chardev = val;
+            const char *chardevs_end = chardev + len;
+
+            assert(errp == NULL);
+            while (chardev < chardevs_end) {
+                object_property_set_str(OBJECT(dev), propname,
+                                        (const char *)chardev, &errp);
+                if (!errp) {
+                    fprintf(stderr, "set property %s to %s\n", propname,
+                                chardev);
+                    break;
+                }
+                chardev += strlen(chardev) + 1;
+                errp = NULL;
+            }
+            assert(errp == NULL);
+            continue;
+        }
+
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
@@ -1119,6 +1146,23 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         const char *short_name = qemu_devtree_get_node_name(fdti->fdt,
                                                             node_path);
 
+        /* Connect chardev if we can */
+        if (serial_hd(fdt_serial_ports)) {
+            Chardev *value = (Chardev *) serial_hd(fdt_serial_ports);
+            char *chardev;
+
+            /* Check if the device already has a chardev.  */
+            chardev = object_property_get_str(dev, "chardev", &errp);
+            if (!errp && !strcmp(chardev, "")) {
+                object_property_set_str(dev, "chardev", value->label, &errp);
+                if (!errp) {
+                    /* It worked, the device is a charecter device */
+                    fdt_serial_ports++;
+                }
+            }
+            errp = NULL;
+        }
+
         /* Regular TYPE_DEVICE houskeeping */
         DB_PRINT_NP(0, "Short naming node: %s\n", short_name);
         (DEVICE(dev))->id = g_strdup(short_name);
-- 
2.43.0


