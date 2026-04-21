Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7E0F8FA9A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE5L-0005La-Ki; Tue, 21 Apr 2026 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE47-0004gq-ET
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE40-0007OI-7y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN7usOvOD5JXKjKE5SLWxOEK8n3ue3orhToutZspIB8=;
 b=SMmeLHcB9oz77wkunKL1jdduRpqu3GzTlYMBjLxpCsnZ9jd/wwnR2jD0qBsxSftQUbt3So
 6xYHNGMG5LmRr9CRAETxRkwvpQyoB0XrHuvPPlvD4ZMN9vrhOiDxxfQ4/fRjq+J4i33G5f
 BAcC2hlwUx2nnjs3RsBDN5NAdZWCuUQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-Acl5_vHmM_KoYKEhIFPDCQ-1; Tue,
 21 Apr 2026 12:34:59 -0400
X-MC-Unique: Acl5_vHmM_KoYKEhIFPDCQ-1
X-Mimecast-MFC-AGG-ID: Acl5_vHmM_KoYKEhIFPDCQ_1776789298
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 203AC18003F6; Tue, 21 Apr 2026 16:34:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 350DB19560AB; Tue, 21 Apr 2026 16:34:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/14] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Date: Tue, 21 Apr 2026 18:34:31 +0200
Message-ID: <20260421163438.3447280-8-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Since this function needs kvm specific types, we need to extract in
another file and link it only for KVM builds.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-8-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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
index 0000000000000000000000000000000000000000..b1f68c686a7defbed94cc4c0d56b786bc436ed89
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
index 0000000000000000000000000000000000000000..ad71c5a85e273fbe8df9fda71ba21c7df171914d
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
index 5a489d1b7110a5564054398cc354bb806ac39334..78c51b9915559ba3c328cb3bcc0d9e2896269f9f 100644
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
index a9f093c357057eaa07378c77c86da096fe9f6297..42690e4323d20915c55591129d9fce0ae46b0cf3 100644
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
index 6c00a7f51bbe79d8e45d828a11d4deecf21512be..bab5f2b7f1555eed452e7a91b8a8984bb1f262c6 100644
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
2.53.0


