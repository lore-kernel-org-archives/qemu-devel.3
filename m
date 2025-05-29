Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC18C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisn-0004Jl-69; Thu, 29 May 2025 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisR-0004Dj-CC
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisO-0000Q4-Vi
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:19 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfslZ031391;
 Thu, 29 May 2025 19:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=mUSwxjm1wr6KOfN6LH11R4WHLNQmJbyzCGl0KXX8NOA=; b=
 M7nl/lwTL53EG7KU5pQfsgST+/9VY8nd6WB1ZOc42O5AsUoDFribQMryQ+MAAn04
 jyj8di7+16zv12VkMD24qzbm2f4/bKYVB7UPxkSk0GnyyZ7D/yHKEYOh4GzU2KVJ
 JPm1AaMQlsNXEbVk85VhoiOmHoia3UUKnF45MnR0KDGS7WEoWYpko3Zn/oG0tdPO
 10shFRf3yjfqPhwS2aZUiKesQaIF6C2nKD+4eHXaaZtTu+ANKe7Fe7toWbVhEB6k
 FkCAbhcVBKwNiTJn25YjuD9XgUqd9Q1KFcNqUVIVfBrdYhnEZMdu6OO9nzet8SAX
 6CsM5Ifs8ovg4/vDnmmsCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0ycw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJKdNh020323; Thu, 29 May 2025 19:25:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRd022158;
 Thu, 29 May 2025 19:25:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-27; Thu, 29 May 2025 19:25:01 +0000
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
Subject: [PATCH V4 26/43] migration: close kvm after cpr
Date: Thu, 29 May 2025 12:24:22 -0700
Message-Id: <1748546679-154091-27-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX75hCycKI3EEY
 nz7rMyVe7O4y+fylKZC1BYuQYtNAbYnavt7f6/0lMaHbWvPb8aL9CqfYERIBNnWyn4DS4+YtM+f
 96oq9k6uWo0W/bBcQZVXDGt4OPhhP41dPCWAgZuT2+ofRg5F/v+VdSa8wdeKJ7OwSB8LtEPBEcr
 hIgXaAvVdNNGX8t4sjGguByyyXXLpizxrBmYA56nxcFvdas2tAi+g3tk8QB9iLOjd1nJTNqYlKi
 YQ5c85RwYVNQGDCOM86cERsVFa47D/VueivTIYQ8WGdB+KYSH8rQqD9IFtDE1xygARivacS9lhy
 VqY0FgCinx+Z6J3dWTQacrwK9Xhzc9H5Mfc1py8qdYiMQLg1wjblpKP0JUHiwvjbqhfUN5JaAcM
 F3A5CU8SLRw6+Bq9m4oAqDA4M9yIJSI8iwU0nPMtnMyA358L/Ltb2NiaXSY43pf+kbkgfpi7
X-Proofpoint-GUID: 15USkHBo_LbzUSXpDqA19hDPTXyP83wL
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b48e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=kfOKAURTLI36beqjriwA:9
X-Proofpoint-ORIG-GUID: 15USkHBo_LbzUSXpDqA19hDPTXyP83wL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c        |  5 +++++
 hw/vfio/helpers.c             | 10 ++++++++++
 hw/vfio/vfio-stubs.c          | 13 +++++++++++++
 migration/cpr-transfer.c      | 18 ++++++++++++++++++
 migration/cpr.c               |  8 ++++++++
 migration/migration.c         |  1 +
 hw/vfio/meson.build           |  2 ++
 11 files changed, 90 insertions(+)
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
index b690dda..cfaa94c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
+void kvm_close(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 278a506..d619448 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
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
@@ -600,6 +607,27 @@ err:
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
index 4697732..89e2026 100644
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


