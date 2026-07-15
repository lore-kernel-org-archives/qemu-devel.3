Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDD0C4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzvA-0005dx-0D; Wed, 15 Jul 2026 09:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv4-0005Yp-Jv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:02 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv2-0007uM-Fm
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=oZPUNjb
 n7BKVINuYzJ2lWf/cowJIL9BsK9B2dHWq0jHf5VUOgx9V7s4BOogFpdOHlw/rfX2pBd9ct
 ecfKv5pHr90jdUN7aN5ompINPpQnWnzKIHAGPi1NybNVPCab0IAPcH0XpRsPPDyNcF908q
 pO/TSUDbnEvSrNvcttGf7Qzi9oqEIv88svqucxpV7Jo19xDHLBZJTP4kRGnpixxQ4a1icM
 JLrkW5146axjvmjH6mOapVktAjD/g2GOZWgesGoNPdcEnMWAX6zVB5sWt09pUdRH+llAqg
 YHsXEJjK76ChevHXzSBRGftyJyOj6UHUZeQ47RRWqDtmZoNLYzlbSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=1
 CN3i4bgmNiJi3qNNhW8S3FBGVql07O2JBNhqQFUEiA=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=yAMzDwFvsGG/UWICIPn/A43KwfDSm3FLejAtGIl4QLubQxpToTrHDCsUSRXgnZ8lukh3
 93e0NuDIj+7SDv290Nn3oRQvNd/dt+S7BceR8hTxfQ7sxeuV43BHYR+c2tlvQQP4fQsDLl
 kBGKPcOGWQreRv2zxh3VeO/ldPIybz6eefjvslX8MgSW6zrE+pV8sKrAHd+yu8nZ8YHQHJ
 cP/0s2qQcWlXFWhFnKV15hr/YN4rErOsHZh3ktRh3XhsCLbrc4WqIfP9HIMOaIUDOB5etl
 KLqrUKlMq0rHrvwan3UrSdVjjlg71WpQAi9Y1sqyNAfAIukw1Rgd5oYBK+bTS7Mw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=oe9lA1a/; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=hA9al6nO;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=1CN3i4bg
 mNiJi3qNNhW8S3FBGVql07O2JBNhqQFUEiA=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=oe9lA1a/twCkEX/MnMfMM8mc7UySPkAtoWm
 bLI4g8XYjpMQG1YWUhz5AnZ7LNeroJFGwMTU+6gikvKS6teQhVYT5jOh4alW1f+egVpNGJ
 rkHAsk/njokyUZtOEHiCF4ExI1sq3buOc0F4juA17fjhhMw3fuOqelAIESbTPrGm/A6lCy
 rxIAQcTSEMdTs8T7aZWQHByYbWu+kjklAC7jA4Dhw1CTT8vpXaY4vYkpCYgv0rK+DimHdP
 INFstpe0/0xjP2svyj704dtPlA6Jzac9oVLVF8ILvVhP6vTTguUbCOWIulP/dyH6e1G1nT
 I7s9UPugEaCK47Dvy7wF/PgcZJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=1CN3i4bgmNiJi3qNNhW8S3FBGVql07O2JBNhqQFUEiA=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=hA9al6nOVZ8Dt8U5CG
 nLk8NZHG/G14KSK3FgrxKyY9qMNyfQTFy1OptN3ZnBYtDGIRUoTm+JhOoigLUx6upnDA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 8fb73eee
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:52 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 7ba03e47;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 08/25] hw/mips: add empty Octeon III machine
Date: Wed, 15 Jul 2026 15:43:54 +0200
Message-ID: <20260715134447.56007-9-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Register an empty octeon3 machine for the Cavium/Marvell Octeon III
EBB7304 evaluation board. Define its CPU, RAM and clock defaults; later
commits add the board devices.

Early Octeon investigation used Amir Mehmood's original Octeon
host.patch as a behavioral reference; that work informed the basic
machine approach and several hardware model ideas. No code from that
patch remains in this implementation.
---
 hw/mips/Kconfig           |  5 +++
 hw/mips/meson.build       |  1 +
 hw/mips/octeon.c          | 89 +++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h | 16 +++++++
 4 files changed, 111 insertions(+)
 create mode 100644 hw/mips/octeon.c
 create mode 100644 hw/mips/octeon_internal.h

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index b59cb2f111..2e71e6dee6 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -67,6 +67,11 @@ config LOONGSON3V
     select FW_CFG_MIPS
     select UNIMP
 
+config MIPS_OCTEON
+    bool
+    default y
+    depends on MIPS64 && TARGET_BIG_ENDIAN
+
 config MIPS_CPS
     bool
     select MIPS_ITU if TCG
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 390f0fd7f9..f11dcdf794 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -10,6 +10,7 @@ if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
+mips_ss.add(when: 'CONFIG_MIPS_OCTEON', if_true: files('octeon.c'))
 endif
 
 hw_arch += {'mips': mips_ss}
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
new file mode 100644
index 0000000000..2ecc464579
--- /dev/null
+++ b/hw/mips/octeon.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU Cavium Octeon board model.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/octeon_internal.h"
+#include "target/mips/cpu.h"
+
+#define TYPE_OCTEON_MACHINE MACHINE_TYPE_NAME("octeon3")
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
+
+#define OCTEON_DEFAULT_CPU_HZ       1800000000
+#define OCTEON_DEFAULT_REF_HZ       50000000
+#define OCTEON_DEFAULT_IO_HZ        1000000000
+#define OCTEON_DEFAULT_DDR_HZ       800000000
+#define OCTEON_DEFAULT_RAM_SIZE     (1 * GiB)
+
+struct OcteonMachineState {
+    MachineState parent_obj;
+    uint64_t cpu_hz;
+    uint64_t ref_hz;
+    uint64_t io_hz;
+    uint64_t ddr_hz;
+};
+
+static void mips_octeon_init(MachineState *machine)
+{
+}
+
+static void octeon_machine_instance_init(Object *obj)
+{
+    OcteonMachineState *oms = OCTEON_MACHINE(obj);
+
+    oms->cpu_hz = OCTEON_DEFAULT_CPU_HZ;
+    oms->ref_hz = OCTEON_DEFAULT_REF_HZ;
+    oms->io_hz = OCTEON_DEFAULT_IO_HZ;
+    oms->ddr_hz = OCTEON_DEFAULT_DDR_HZ;
+
+    object_property_add_uint64_ptr(obj, "cpu-clock-hz", &oms->cpu_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "cpu-clock-hz",
+                                    "CPU clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "ref-clock-hz", &oms->ref_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "ref-clock-hz",
+                                    "Reference clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "io-clock-hz", &oms->io_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "io-clock-hz",
+                                    "IO clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "ddr-clock-hz", &oms->ddr_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "ddr-clock-hz",
+                                    "DDR clock frequency in Hz");
+}
+
+static void octeon_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Cavium Octeon III / EBB7304 EVK";
+    mc->init = mips_octeon_init;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("OcteonCN73XX");
+    mc->default_ram_size = OCTEON_DEFAULT_RAM_SIZE;
+    mc->default_ram_id = "octeon.ram";
+    mc->max_cpus = OCTEON_MAX_CPUS;
+}
+
+static const TypeInfo octeon_machine_types[] = {
+    {
+        .name = TYPE_OCTEON_MACHINE,
+        .parent = TYPE_MACHINE,
+        .instance_size = sizeof(OcteonMachineState),
+        .instance_init = octeon_machine_instance_init,
+        .class_init = octeon_machine_class_init,
+    }
+};
+
+DEFINE_TYPES(octeon_machine_types)
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
new file mode 100644
index 0000000000..7cab7790bd
--- /dev/null
+++ b/hw/mips/octeon_internal.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU Cavium Octeon board model internal declarations.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_OCTEON_INTERNAL_H
+#define HW_MIPS_OCTEON_INTERNAL_H
+
+#include "qemu/typedefs.h"
+
+#define OCTEON_MAX_CPUS             16
+
+#endif
-- 
2.54.0


