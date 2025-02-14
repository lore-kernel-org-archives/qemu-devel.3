Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA3C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTL-0005eL-Nu; Fri, 14 Feb 2025 09:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTG-0005Sa-Td
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTE-0004hB-NN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:10 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtTNM006492;
 Fri, 14 Feb 2025 14:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=th0gfiJHDWrXElsacnCQOAe/RVbdzlgHDef6GLP3Cjg=; b=
 d6/YHZaRofeYVsK0aRhGhXhyaBAA6oTwaufSfyv6HNZLqwMm/D3xWfJ1kwMOgyie
 +xQMQ5SGGXKD1hdI+wBkpZhlmfz8cI6AoJybboVc4M0Ykh9LuyYvA7MxWcdKTUA1
 RfHIwN9ZZHW500GyvlSicdjm7zfbnEDTe7uPVMS6a3VGjQzAg+UaZEseGe+NMAOX
 bPKw8rJHdaaHoBmvwFOKEZPDqh48/ZbGsDxTsgsbcO0QdIt/HtSD45elWqwhiEyC
 bBpQM6KmPL3QfZxBWWgkxzIvwAziNEVnPtpEDRVm+C1MZiVElmxPpb+eNpYXWAen
 nFRzSIW40sJzRhzEtpmiyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaknwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECSkjT025168; Fri, 14 Feb 2025 14:15:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQ5006920;
 Fri, 14 Feb 2025 14:15:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-27; Fri, 14 Feb 2025 14:15:04 +0000
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
Subject: [PATCH V2 26/45] migration: close kvm after cpr
Date: Fri, 14 Feb 2025 06:14:08 -0800
Message-Id: <1739542467-226739-27-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: Quko-V2_qx4MsHBpNhh_UJ7V9hM6EYZW
X-Proofpoint-ORIG-GUID: Quko-V2_qx4MsHBpNhh_UJ7V9hM6EYZW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
 hw/vfio/common.c              |  8 ++++++++
 include/hw/vfio/vfio-common.h |  1 +
 include/migration/cpr.h       |  2 ++
 include/system/kvm.h          |  1 +
 migration/cpr-transfer.c      | 18 ++++++++++++++++++
 migration/cpr.c               |  8 ++++++++
 migration/migration.c         |  1 +
 8 files changed, 67 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790..cdbe91c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -507,16 +507,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
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
@@ -595,6 +602,27 @@ err:
     return ret;
 }
 
+void kvm_close(void)
+{
+    CPUState *cpu;
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
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 48663ad..c536698 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1501,6 +1501,14 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
     return 0;
 }
 
+void vfio_kvm_device_close(void)
+{
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+}
+
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
 {
     VFIOAddressSpace *space;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1563f3a..78e4f12 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -259,6 +259,7 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
+void vfio_kvm_device_close(void);
 
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 6ad04d4..c5c191d 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -32,7 +32,9 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_needed_for_reuse(void *opaque);
+void cpr_kvm_close(void);
 
+void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09..ad5c55e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
+void kvm_close(void);
 
 /**
  * kvm_arm_supports_user_irq
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
index 12c489b..351e12d 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,12 +7,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/vfio/vfio-common.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "trace.h"
 
@@ -266,3 +268,9 @@ bool cpr_needed_for_reuse(void *opaque)
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
index 3969285..bdc5255 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -296,6 +296,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_transfer_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
-- 
1.8.3.1


