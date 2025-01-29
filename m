Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B89EC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IW-0000bO-Qu; Wed, 29 Jan 2025 09:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IL-0000Xz-Jt
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9II-0001ML-OY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:57 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEbCoe007551;
 Wed, 29 Jan 2025 14:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=h/Ab34Pt89kriniEFopqa39nyKpO4mIKhLodI6pY3y0=; b=
 TlYz2izvQJburp0PAjyVoEtmQu/zbNDgT9eK4ZZHof5rM7KrKI7miYcFDBskSzsu
 xbTkU4P43LBoZlmq0lz3bIPtLp3hL4CnNw9VX0vZut/jo9XlgskaIIo4hcvVY6k4
 Q54kKfzP4jRq700w0HwNSoVD0qhVF4iZxx/8EvIfk1Sw84N0D792jI3Ox+KgYdp7
 8Fb4J4MoR0oXDS4++lZ3cPblbKZoVIigmSTQWX3EVNAUPKn4qM5b5avmLgUWQvpS
 2Q4PFtBqPDBj/hBsiXGvIhogCku8Wq1kUMRibUV6ZqFyhF13u7/2sKDaa7V1S4GA
 T7Yq4ytICnMqngnMwfA9pA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e00qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDMnSS036674; Wed, 29 Jan 2025 14:43:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8g003307;
 Wed, 29 Jan 2025 14:43:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-15; Wed, 29 Jan 2025 14:43:50 +0000
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
Subject: [PATCH V1 14/26] migration: close kvm after cpr
Date: Wed, 29 Jan 2025 06:43:10 -0800
Message-Id: <1738161802-172631-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: ALVKtT6OAXD3SMh1poUrNAjNlhjiMBRJ
X-Proofpoint-GUID: ALVKtT6OAXD3SMh1poUrNAjNlhjiMBRJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
 accel/kvm/kvm-all.c           | 20 ++++++++++++++++++++
 hw/vfio/common.c              |  8 ++++++++
 include/hw/vfio/vfio-common.h |  1 +
 include/migration/cpr.h       |  2 ++
 include/system/kvm.h          |  1 +
 migration/cpr-transfer.c      | 18 ++++++++++++++++++
 migration/cpr.c               |  8 ++++++++
 migration/migration.c         |  1 +
 8 files changed, 59 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790..f4e341f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -595,6 +595,26 @@ err:
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
+}
+
 /*
  * dirty pages logging control
  */
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c8ee71a..db0498e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1511,6 +1511,14 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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
index 8a4a658..5a89aca 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -262,6 +262,7 @@ void vfio_detach_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
+void vfio_kvm_device_close(void);
 
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index faeb0cc..e8f4aba 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -29,7 +29,9 @@ void cpr_state_close(void);
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
index e3f27e9..86eb484 100644
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
 
@@ -243,3 +245,9 @@ bool cpr_needed_for_reuse(void *opaque)
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
index 88b0991..7a69782 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -288,6 +288,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_transfer_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
-- 
1.8.3.1


