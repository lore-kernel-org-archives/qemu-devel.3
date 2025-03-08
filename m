Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CA2C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3JX-0006Pc-E0; Sat, 08 Mar 2025 18:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JT-0006At-Py
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JQ-0001To-LX
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso1575455e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475431; x=1742080231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqJ8O34qNgm7bETvjKnBNqBiS0iJjz9k+q/OCgWJZ8A=;
 b=WqHo1vIHfSkmov+oBwrKtleKwtsA1oTL7gUL85Abp5pOQsyGjv5DPFMUDQAuHtwY/E
 d0dak797fPbl7I111olYR2ki6MmXif9i/ZWjbyKAH46Ov3iKkZ+3PHI0GxyXnoGoay/R
 S+V4pI7Yb/lAegqXVPPtmsNrwNBewdhRCxX4urmVmB488t0dEKr/+se7ZNTYrdSOkRN3
 SOM8P8S0gdx2Ux3ED1LJT/cKnGG7moxM1DG08z9Ud1NXbg0RnQLuwvh/baO00EZgrGgM
 zWq6ucaov9xpacY6hz0mk54zdeg3wY8CT1HirYg6P+2k3ThPFgCK//IW2atTxqr2SVWU
 wQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475431; x=1742080231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqJ8O34qNgm7bETvjKnBNqBiS0iJjz9k+q/OCgWJZ8A=;
 b=c39iEGua3xhF3S8zp0RSJyES0CHUTHJZgX7uqf+YjM/EBhsdiMgIAB+1rxmYW1hQjl
 qggvhhbemJ2fp5R2SnOWAAb0cuqFM7GjXI1TSGTB+4k6Aqi5fLfQqLBR2S1dxbqP3KSV
 Q8l7NC5sJmKYWvcjVZmHXK5yGOVBjmC1uScgN//OwsshgipanK9uWwmQHT1serjoAWPw
 ouZ0KzhejT7nNwxl5TG86q7RmuV/i17BJvmzWyHhHTLsvzhurdrg2Z8OyNwH0ir8mQM6
 42yWNMxqSnLFAb9i20U//Snfs1Qh4ORCKVCjUnITrv9B/tYKNhHLX4fw0SPu6/n2u0gh
 eiXg==
X-Gm-Message-State: AOJu0Yz/Y6KH8wL5q47UJ0oDjNOJdgIXi/XJNVmAZlnBPATlnShsmCMO
 5r2uuU5/P95DpQ6aRMSSrEgz3RUkjuev/kDdqfrV9D+cOEWfGORYswwYbSd/jq2BpaUVYxBKPGd
 xg8c=
X-Gm-Gg: ASbGncv3wmvzFuLgMJpVCK2UOHKOgtYl0LRW57zZ8vOwPb8XnN7dXiw2Z/OEUjSFStJ
 zNbOWHNvLUvCzp8J+ufKbku3r3CsDcsa49odJ3p1eh2Da6GWSBYhAYm80zJjpYeNxM1HD+b3N7z
 s1cbMnsFDaA3ipBKeX7ALA5jBNlYvKOL6r8F+9KI1u2KvKbqxN+S4RrkXTY3/Zl2I1K8YLadh5t
 q4iQqaKDaWVxFwtOTdd2pH3BamQ259EWL0G/I24QvnJUyqrgs50Os1C1DwIr+yvM3QJljMYMmSk
 KDYMYEucMMhJvpZNBIF+Lb3+6L32r5gSTDhb/HD2CnSStL+hqABhsO0E+hdYy80TApfBgZi1eTN
 kpNRe4b9C0jxwEqoe5IU=
X-Google-Smtp-Source: AGHT+IFLHFN9rxCqoijA4uedrenofflj7luyFp9CUDQXWNq5DjV8ZWge9xhKDm/5wVHFLL1LrIgcAA==
X-Received: by 2002:a05:600c:35ca:b0:43b:ca8c:fca1 with SMTP id
 5b1f17b1804b1-43c5a610dc3mr61655845e9.16.1741475430716; 
 Sat, 08 Mar 2025 15:10:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm10124731f8f.65.2025.03.08.15.10.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime using
 vfio_igd_builtin()
Date: Sun,  9 Mar 2025 00:09:08 +0100
Message-ID: <20250308230917.18907-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert the compile time check on the CONFIG_VFIO_IGD definition
by a runtime one by calling vfio_igd_builtin(), which check
whether VFIO_IGD is built in a qemu-system binary.

Add stubs to avoid when VFIO_IGD is not built in:

  /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_vfio_pci-quirks.c.o: in function `vfio_bar_quirk_setup':
  /usr/bin/ld: ../hw/vfio/pci-quirks.c:1216: undefined reference to `vfio_probe_igd_bar0_quirk'
  /usr/bin/ld: ../hw/vfio/pci-quirks.c:1217: undefined reference to `vfio_probe_igd_bar4_quirk'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci-quirks.h |  6 ++++++
 hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
 hw/vfio/pci-quirks.c |  9 ++++-----
 hw/vfio/meson.build  |  3 +++
 4 files changed, 33 insertions(+), 5 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index fdaa81f00aa..dcdb1962600 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -13,6 +13,7 @@
 #define HW_VFIO_VFIO_PCI_QUIRKS_H
 
 #include "qemu/osdep.h"
+#include "qom/object.h"
 #include "exec/memop.h"
 
 /*
@@ -71,4 +72,9 @@ extern const MemoryRegionOps vfio_generic_mirror_quirk;
 
 #define TYPE_VFIO_PCI_IGD_LPC_BRIDGE "vfio-pci-igd-lpc-bridge"
 
+static inline bool vfio_igd_builtin(void)
+{
+    return type_is_registered(TYPE_VFIO_PCI_IGD_LPC_BRIDGE);
+}
+
 #endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
new file mode 100644
index 00000000000..5d4e88aeb1b
--- /dev/null
+++ b/hw/vfio/igd-stubs.c
@@ -0,0 +1,20 @@
+/*
+ * IGD device quirk stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) Linaro, Ltd.
+ */
+
+#include "qemu/osdep.h"
+#include "pci.h"
+
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    g_assert_not_reached();
+}
+
+void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c53591fe2ba..22cb35af8cc 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES
 #include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
@@ -1213,10 +1212,10 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_nvidia_bar5_quirk(vdev, nr);
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
-#ifdef CONFIG_VFIO_IGD
-    vfio_probe_igd_bar0_quirk(vdev, nr);
-    vfio_probe_igd_bar4_quirk(vdev, nr);
-#endif
+    if (vfio_igd_builtin()) {
+        vfio_probe_igd_bar0_quirk(vdev, nr);
+        vfio_probe_igd_bar4_quirk(vdev, nr);
+    }
 }
 
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index a8939c83865..6ab711d0539 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -17,6 +17,9 @@ specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
+system_ss.add(when: 'CONFIG_VFIO_IGD', if_false: files(
+  'igd-stubs.c',
+))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'helpers.c',
   'container-base.c',
-- 
2.47.1


