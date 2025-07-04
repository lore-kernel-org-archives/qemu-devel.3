Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2C5C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc45-0008OS-9T; Fri, 04 Jul 2025 04:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc42-0008He-Ga
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc40-00011h-EX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRhhhtLxnfyFJaHIJ/rxc2exHfIyjH/GJ+Z3FynV/M4=;
 b=CLK0SmfPRsTOrHmlv+6Uq2yvEu9B952Dqng0L/MdTul1ANPK7XAPaeldxoEMJuCxS0APjQ
 hK3S1vHPJGnOap5ECNLn9Vg+6kdHFbigQmSJpIp4+CJ7ubfKNpCaBVdpVlY7SDnwbEwvNM
 RM77zTmjzzMvUWIW7BlbqQqMeVQVHNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-Fw-MNyEjMH22_U5UT51sYg-1; Fri,
 04 Jul 2025 04:46:28 -0400
X-MC-Unique: Fw-MNyEjMH22_U5UT51sYg-1
X-Mimecast-MFC-AGG-ID: Fw-MNyEjMH22_U5UT51sYg_1751618787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2522819560A2; Fri,  4 Jul 2025 08:46:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D691E19560A7; Fri,  4 Jul 2025 08:46:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/27] migration: vfio cpr state hook
Date: Fri,  4 Jul 2025 10:45:20 +0200
Message-ID: <20250704084528.1412959-20-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Define a list of vfio devices in CPR state, in a subsection so that
older QEMU can be live updated to this version.  However, new QEMU
will not be live updateable to old QEMU.  This is acceptable because
CPR is not yet commonly used, and updates to older versions are unusual.

The contents of each device object will be defined by the vfio subsystem
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-14-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 include/migration/cpr.h    | 12 ++++++++++++
 hw/vfio/cpr-iommufd.c      |  2 ++
 hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
 migration/cpr.c            | 15 ++++++---------
 hw/vfio/meson.build        |  1 +
 6 files changed, 40 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio/iommufd-stubs.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 87b4206d8189c1cacd7fac629da5e3823a28c7ae..286e3d4e9a7497b3ba279d990449e71db676ec39 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -75,6 +75,7 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                                int nr);
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
+extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 void vfio_cpr_add_kvm_notifier(void);
 
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index eb27a933017a09c480029a50cd6b1457e69cec8a..3fc19a74efdcf987f3b12f73b59d11e8734f85b2 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -9,11 +9,23 @@
 #define MIGRATION_CPR_H
 
 #include "qapi/qapi-types-migration.h"
+#include "qemu/queue.h"
 
 #define MIG_MODE_NONE           -1
 
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
+#define CPR_STATE "CprState"
+
+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
+typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
+
+typedef struct CprState {
+    CprFdList fds;
+    CprVFIODeviceList vfio_devices;
+} CprState;
+
+extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 2f58b43793c048188ed61b560dcae1965383f061..f95773b02c84f2ce8e27c49165b6ad68c4bc2328 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -14,6 +14,8 @@
 #include "system/iommufd.h"
 #include "vfio-iommufd.h"
 
+const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
+
 static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
 {
     if (!iommufd_change_process_capable(be)) {
diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
new file mode 100644
index 0000000000000000000000000000000000000000..0be5276175317327318283caaa50e329c4be4946
--- /dev/null
+++ b/hw/vfio/iommufd-stubs.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = CPR_STATE "/vfio devices",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]){
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/migration/cpr.c b/migration/cpr.c
index 535d587aee16d2411d20ee549f8e3cf5a4120a88..42ad0b0d500e5de57faf0c6517e216b2d1c0cacf 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
@@ -20,13 +21,7 @@
 /*************************************************************************/
 /* cpr state container for all information to be saved. */
 
-typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
-
-typedef struct CprState {
-    CprFdList fds;
-} CprState;
-
-static CprState cpr_state;
+CprState cpr_state;
 
 /****************************************************************************/
 
@@ -127,8 +122,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 }
 
 /*************************************************************************/
-#define CPR_STATE "CprState"
-
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
@@ -136,6 +129,10 @@ static const VMStateDescription vmstate_cpr_state = {
     .fields = (VMStateField[]) {
         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cpr_vfio_devices,
+        NULL
     }
 };
 /*************************************************************************/
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 7a881740a6d8d2d6f4f78024020060f2e11623eb..bfaf6be805483d46190232bd6805a7a042380a0d 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -33,6 +33,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
   'cpr-iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
-- 
2.50.0


