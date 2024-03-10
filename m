Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77653C54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 19:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjOi6-0006Bs-Sh; Sun, 10 Mar 2024 15:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOi4-0006BM-LZ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOhy-0001Qx-Bh
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tt8q93rztz4wyp;
 Mon, 11 Mar 2024 06:19:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tt8q76N41z4wcl;
 Mon, 11 Mar 2024 06:19:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/2] vfio: register container for cpr
Date: Sun, 10 Mar 2024 20:19:23 +0100
Message-ID: <20240310191924.201680-2-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310191924.201680-1-clg@redhat.com>
References: <20240310191924.201680-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Define entry points to perform per-container cpr-specific initialization
and teardown.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 +++
 hw/vfio/container.c           | 11 ++++++++++-
 hw/vfio/cpr.c                 | 19 +++++++++++++++++++
 hw/vfio/iommufd.c             |  6 ++++++
 hw/vfio/meson.build           |  1 +
 5 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/cpr.c

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4a6c262f778b9bf4bf5760ffd548b9b6ea5bad33..b9da6c08ef41174610eb92726c590309a53696a3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -205,6 +205,9 @@ void vfio_detach_device(VFIODevice *vbasedev);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
+int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
+void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9fbad2e717e63c2ab0e331186e5f63cef49..096d77eac3946a9c38fc2a98116b93353f71f06e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -621,10 +621,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
+    ret = vfio_cpr_register_container(bcontainer, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
+
     ret = vfio_ram_block_discard_disable(container, true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto free_container_exit;
+        goto unregister_container_exit;
     }
 
     assert(bcontainer->ops->setup);
@@ -667,6 +672,9 @@ listener_release_exit:
 enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
 free_container_exit:
     g_free(container);
 
@@ -710,6 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         vfio_container_destroy(bcontainer);
 
         trace_vfio_disconnect_container(container->fd);
+        vfio_cpr_unregister_container(bcontainer);
         close(container->fd);
         g_free(container);
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
new file mode 100644
index 0000000000000000000000000000000000000000..3bede5494804e4aa291663c1e7c01d5dc5d3a407
--- /dev/null
+++ b/hw/vfio/cpr.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-common.h"
+#include "qapi/error.h"
+
+int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
+{
+    return 0;
+}
+
+void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
+{
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9bfddc1360895413176a9f170e29e89027384a66..e1be2244947172367e2a1f85c59967c20bfcff77 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -411,6 +411,11 @@ found_container:
         goto err_listener_register;
     }
 
+    ret = vfio_cpr_register_container(bcontainer, errp);
+    if (ret) {
+        goto err_listener_register;
+    }
+
     /*
      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
      * for discarding incompatibility check as well?
@@ -461,6 +466,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
+    vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bb98493b53e858c53181e224f9cb46892838a8be..bba776f75cc718956b37f68cb542b378a509d77f 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,6 +5,7 @@ vfio_ss.add(files(
   'container-base.c',
   'container.c',
   'migration.c',
+  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
-- 
2.44.0


