Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5BFEDA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJj-0007Vc-6I; Tue, 17 Mar 2026 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJc-0007Qv-Th
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:58 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJY-0007JD-DW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:56 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso4249801a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776571; x=1774381371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=GinmQfeIsXe9qDBruawO38uA0elMcnJRyXHnM82sbbnm1BgLGbqT5l8QF3tZTC3d+a
 3ad0r7D+oXepSTxJtx9tS+vkErP2JxN/N909A19SGgibfoA2UuYs0bRTxbLnEKRVqp75
 3IaokV4lm39bF8PL84X/GA7jBsfc8Fmxpi1n9s8Dfqf9volK+gNIDjTn87EQPVjCcnJA
 /1mg6wEWI07TIIrrobWpC/XVMo8g4lH2CLuR+oEVNA/DcdnFOY5AEnUkF/1D/Xpe/UwF
 JpaezADl4UZoJJWkpRfCYJHFTsev6bdQqDFod703AlahWKKen8uQmDCMCrbzf80pz0Op
 DV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776571; x=1774381371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=omw1UW1YhjuCHgyL/5J/mfztAyLmY+DDdWO7QXqi3KCS334EGuuyMdZeGAucAn3Zbx
 6I5wW3L02ivmwemtwtZUYMeADI3dZwpCM2uHG4pvXhO43SVlFlnekYZnBHOhuJhRL7or
 4mVmVclnB1VPBqT/jMVUyZf+beiZ5+PfW1LY0bRWF3VI+UG5azxuuxHzqNAUtjzZuiKv
 jNxtU+RhevvqJ8ABn0GrpB86gCuasr/CSy3vEyViEbekTnleqgSzGN+Krycaod11B6ZA
 nf3tp6P/6LcCQAcImFahIaK1fzTDGxEJZgM0yyNBcZEndkvkOFDcxrXv1C8eglqigfMi
 3/ig==
X-Gm-Message-State: AOJu0YzqROZFlqC/PjrswJuxif7xOxBgJP2U9hV//PnEPBgkLam0AjRl
 Qtn08JHzwNo6wCJuQ8xB2VlEF7s8q0yC2nYb7Frk3fyBcttiuhAGqEY1O9ZNwfj3tKLYWAB72Lw
 Vs1G3bo8=
X-Gm-Gg: ATEYQzy/ZnyGbtkbxLSr4xcbVJIeQdElxy6SACnoI/EhWt2pYh2sQjHI6j1gUbCpQM3
 g3ruJ8ka85H3h2OL2x7GK/ZsQeHpkhYj3cKyH7xBOscesIjTzTMh7N2A0QoaeftWkyr0O12a29P
 zW/oy04hQsRGvSlbid4+Ajj1BU638sAfPzyIrn1lcSyjksrwTZ/p6rpZ58xXjzoFRSIMVNPpl+Q
 uDwd59gNlWYg3xb4NijdidNkX1ZMPiJbnXtyWjV62u24K5rNEZn/HXFFtyxy9G31t66T6MY8V4/
 rRfs6lySfTtgtO4JuWtuyImifY5huOH6XHZXxvi7+YamqG6etYe1tcQ+3RNRl1d5N4fUkl+IkmW
 5/dQeyTYjls6cPFDq49RqXni8bh0jcn6KWOzvBFT0k78gDTWNN09mdMo0rrakR06vfKutBboHnS
 YGq1sahwQSK1bAMVvksJojMauA0KQnE+Q4EmZ3xQkFubv3/8upNqWUfM/bPuEoojgwMN7onhkF2
 gOu
X-Received: by 2002:a17:90b:1c81:b0:35b:9682:51f7 with SMTP id
 98e67ed59e1d1-35bb9f2c418mr551353a91.24.1773776570872; 
 Tue, 17 Mar 2026 12:42:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Date: Tue, 17 Mar 2026 12:42:40 -0700
Message-ID: <20260317194241.869568-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since this function needs kvm specific types, we need to extract in
another file and link it only for KVM builds.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/kvm-spapr.h | 12 ++++++++++++
 hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-stubs.c |  8 ++++++++
 hw/vfio/spapr.c     | 30 ++++-------------------------
 hw/vfio/meson.build |  1 +
 5 files changed, 72 insertions(+), 26 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/kvm-spapr.c

diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
new file mode 100644
index 00000000000..b1f68c686a7
--- /dev/null
+++ b/hw/vfio/kvm-spapr.h
@@ -0,0 +1,12 @@
+/*
+ * VFIO sPAPR KVM specific functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/vfio/vfio-container.h"
+#include "qapi/error.h"
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp);
diff --git a/hw/vfio/kvm-spapr.c b/hw/vfio/kvm-spapr.c
new file mode 100644
index 00000000000..ad71c5a85e2
--- /dev/null
+++ b/hw/vfio/kvm-spapr.c
@@ -0,0 +1,47 @@
+/*
+ * VFIO sPAPR KVM specific functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include <linux/kvm.h>
+
+#include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/kvm-spapr.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "vfio-helpers.h"
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp)
+{
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOGroup *group;
+    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+    struct kvm_vfio_spapr_tce param;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+
+    if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
+                &param.tablefd)) {
+        QLIST_FOREACH(group, &container->group_list, container_next) {
+            param.groupfd = group->fd;
+            if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                error_setg_errno(errp, errno,
+                        "vfio: failed GROUP_SET_SPAPR_TCE for "
+                        "KVM VFIO device %d and group fd %d",
+                        param.tablefd, param.groupfd);
+                return false;
+            }
+            trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+        }
+    }
+    return true;
+}
diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
index 5a489d1b711..78c51b99155 100644
--- a/hw/vfio/kvm-stubs.c
+++ b/hw/vfio/kvm-stubs.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 
+#include "hw/vfio/kvm-spapr.h"
 #include "hw/vfio/vfio-device.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
@@ -24,3 +25,10 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
 {
     return 0;
 }
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index a9f093c3570..42690e4323d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,6 +16,7 @@
 #include "system/address-spaces.h"
 
 #include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/kvm-spapr.h"
 #include "hw/core/hw-error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -406,33 +407,10 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
     vfio_host_win_add(scontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
-#ifdef CONFIG_KVM
-    if (kvm_enabled()) {
-        VFIOGroup *group;
-        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-        struct kvm_vfio_spapr_tce param;
-        struct kvm_device_attr attr = {
-            .group = KVM_DEV_VFIO_GROUP,
-            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
-            .addr = (uint64_t)(unsigned long)&param,
-        };
-
-        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
-                                          &param.tablefd)) {
-            QLIST_FOREACH(group, &container->group_list, container_next) {
-                param.groupfd = group->fd;
-                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                    error_setg_errno(errp, errno,
-                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
-                                     "KVM VFIO device %d and group fd %d",
-                                     param.tablefd, param.groupfd);
-                    return false;
-                }
-                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-            }
-        }
+    if (kvm_enabled() && !vfio_spapr_kvm_attach_tce(bcontainer, section, errp)) {
+        return false;
     }
-#endif
+
     return true;
 }
 
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 6c00a7f51bb..bab5f2b7f15 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -10,6 +10,7 @@ vfio_ss.add(files(
 vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
 stub_ss.add(files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
+vfio_ss.add(when: ['CONFIG_KVM', 'CONFIG_PSERIES'], if_true: files('kvm-spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
   'pci.c',
-- 
2.47.3


