Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0E3C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP279-0001wE-J6; Tue, 10 Jun 2025 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15S-0004V5-DB
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15P-0006DD-KF
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXbKr030408;
 Tue, 10 Jun 2025 15:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=nbCGoYZi8tKbNgKfk7AKsNsHROQ20UsyRKcH57BdbWM=; b=
 mVBSGBy2daY1cH/KRVI/8FPe5lJZkx65f1HY3xlLRmgT33VvmMqIZpPus3FX1OKI
 iFBNiNDuKGDuvQZBPA31SrF24LtPOgjvocN7i4h0FVxE4jVJ98VurcXaLFCRsJeA
 6FRp3H99NxFIWBql20kkr4FWN6DO3I9yQmdoSe1wqz17MaRE9BDRCwXZhchBcdKS
 77t7op7I/pFYqoyuE7LGvw9Qj2kAGM/ogrO7Dvm7MNJ1M/9qrkkAFSCZvukQ6z0E
 eTJP7qSE4oUlsanOTJ7aRenVwvnYvJdL9fiKfXGXvwaVqcvKuirDolFzarAQgW/E
 mJhH1YjGmZX7S4OhR/z4bw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEsfJN003188; Tue, 10 Jun 2025 15:40:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfl028825;
 Tue, 10 Jun 2025 15:40:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-21; Tue, 10 Jun 2025 15:40:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 20/38] migration: close kvm after cpr
Date: Tue, 10 Jun 2025 08:39:33 -0700
Message-Id: <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: ZC34UuXGJU9N8nLK3zsOT3jpEHm1yV2K
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851e8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=kfOKAURTLI36beqjriwA:9
 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX57VK3WlMu5Id
 9tXyFJI4Acmn8DbQRkObnjjNOk3K6xW6d7nLjz9oSt0mqPR53BXO0/uThNosjQtHr03vSnVtXYY
 dqIVWSq6Du9HkrzGRpe+gAMPfex41P+nRDxz5EQ4xTh14iCCrwEbcMShch0WwKM7pzASB4m3bud
 uhKcW16bN09l2yclg2P9zPYeq6BEuedvBkyUDRZLR3Viij/67S1jC8n+UITLOs/YiCyV48LUYri
 oRIn/UEVuf+OeSCV1fTzhF4DDBR+9432nay5EcEtfgJPqkh2p7W9bw4x8cDlNwtqbTsc2BKxtmB
 GsMpLshSGA5mvVTrU3zLF1Lz9lrhVeGTZ/+qhhoXzFU1xUw2NQc8Q8cp9tzTyisok+WroaPAk0B
 ot1ZbnAUv+CCP4T60hMReBGwwgH2p35Ag/f2Ep3dn3L9mQEuTyLuAP9YEvknNmPuwFvLJ0Oz
X-Proofpoint-ORIG-GUID: ZC34UuXGJU9N8nLK3zsOT3jpEHm1yV2K
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpr-transfer breaks vfio network connectivity to and from the guest, and
the host system log shows:
  irq bypass consumer (token 00000000a03c32e5) registration fails: -16
which is EBUSY.  This occurs because KVM descriptors are still open in
the old QEMU process.  Close them.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-device.h |  2 ++
 include/migration/cpr.h       |  2 ++
 include/system/kvm.h          |  1 +
 accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c        |  5 +++++
 hw/vfio/helpers.c             | 10 ++++++++++
 hw/vfio/vfio-stubs.c          | 13 +++++++++++++
 migration/cpr-transfer.c      | 18 ++++++++++++++++++
 migration/cpr.c               |  8 ++++++++
 migration/migration.c         |  1 +
 hw/vfio/meson.build           |  2 ++
 11 files changed, 94 insertions(+)
 create mode 100644 hw/vfio/vfio-stubs.c

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4e4d0b6..6eb6f21 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
+
+void vfio_kvm_device_close(void);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 07858e9..d09b657 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -32,7 +32,9 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
+void cpr_kvm_close(void);
 
+void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d2..4896a3c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
+void kvm_close(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a317783..3d3a557 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
 
+    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
+    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+        s->coalesced_mmio_ring = NULL;
+    }
+
     ret = munmap(cpu->kvm_run, mmap_size);
     if (ret < 0) {
         goto err;
     }
+    cpu->kvm_run = NULL;
 
     if (cpu->kvm_dirty_gfns) {
         ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
         if (ret < 0) {
             goto err;
         }
+        cpu->kvm_dirty_gfns = NULL;
     }
 
     kvm_park_vcpu(cpu);
@@ -608,6 +615,31 @@ err:
     return ret;
 }
 
+void kvm_close(void)
+{
+    CPUState *cpu;
+
+    if (!kvm_state || kvm_state->fd == -1) {
+        return;
+    }
+
+    CPU_FOREACH(cpu) {
+        cpu_remove_sync(cpu);
+        close(cpu->kvm_fd);
+        cpu->kvm_fd = -1;
+        close(cpu->kvm_vcpu_stats_fd);
+        cpu->kvm_vcpu_stats_fd = -1;
+    }
+
+    if (kvm_state && kvm_state->fd != -1) {
+        close(kvm_state->vmfd);
+        kvm_state->vmfd = -1;
+        close(kvm_state->fd);
+        kvm_state->fd = -1;
+    }
+    kvm_state = NULL;
+}
+
 /*
  * dirty pages logging control
  */
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd763..97dacb3 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -134,3 +134,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+void kvm_close(void)
+{
+    return;
+}
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index d0dbab1..af1db2f 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 int vfio_kvm_device_fd = -1;
 #endif
 
+void vfio_kvm_device_close(void)
+{
+#ifdef CONFIG_KVM
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+#endif
+}
+
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/vfio/vfio-stubs.c b/hw/vfio/vfio-stubs.c
new file mode 100644
index 0000000..a4c8b56
--- /dev/null
+++ b/hw/vfio/vfio-stubs.c
@@ -0,0 +1,13 @@
+/*
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-device.h"
+
+void vfio_kvm_device_close(void)
+{
+    return;
+}
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f1403..396558f 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -17,6 +17,24 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
+static int cpr_transfer_notifier(NotifierWithReturn *notifier,
+                                 MigrationEvent *e,
+                                 Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        cpr_kvm_close();
+    }
+    return 0;
+}
+
+void cpr_transfer_init(void)
+{
+    static NotifierWithReturn notifier;
+
+    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
+                                MIG_MODE_CPR_TRANSFER);
+}
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
 {
     MigrationAddress *addr = channel->addr;
diff --git a/migration/cpr.c b/migration/cpr.c
index a50a57e..49fb0a5 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,12 +7,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "trace.h"
 
@@ -264,3 +266,9 @@ bool cpr_incoming_needed(void *opaque)
     MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_TRANSFER;
 }
+
+void cpr_kvm_close(void)
+{
+    kvm_close();
+    vfio_kvm_device_close();
+}
diff --git a/migration/migration.c b/migration/migration.c
index 4098870..8f23cff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -337,6 +337,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_transfer_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 73d29f9..98134a7 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -17,6 +17,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
+system_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-stubs.c'))
+
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
-- 
1.8.3.1


