Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD04C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Tx-0003Nd-Tn; Wed, 02 Jul 2025 17:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tw-0003N1-8j
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tu-0003ee-0j
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQpOL025631;
 Wed, 2 Jul 2025 21:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=AVtjDIA14eeONZ9qo+hiLIQDtb12zJ/Jppejqkd/J3k=; b=
 DGcOAMg4AMhMbeCPaafTtlsrxrtX3fBkwF5xS69KPDaCEWz2Ildq017T2ko3BAkW
 xMcUJwnAu46MiTcBu9C7ASwEpn4Lv1j8cMtjcPdb6VRLNcGU/P2eQ/G/Q83mPf8T
 yi56NAElw/6SGYqc1no5xQK3Gf/pN+Jq19oo+LEBAESocsE1t6aLBqfxCOyZdgKN
 qAvTU9pccXPS7YKzd8+AzkcAz0uI2zIJy2T002T+D/GhsSZpAso0rdNqhzDXHT6R
 MqC+rbtFBzk8+rxqKFv4HvpaMEaYBVvIX3wtGmlkOEcZfzOHy1YUBekm6KzTg4Lz
 ijwD6tCGrsx/jcYCs7t6vA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tffvg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LJTKs033674; Wed, 2 Jul 2025 21:59:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxg0020012;
 Wed, 2 Jul 2025 21:59:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-4; Wed, 02 Jul 2025 21:59:01 +0000
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
Subject: [PATCH V6 03/21] migration: close kvm after cpr
Date: Wed,  2 Jul 2025 14:58:40 -0700
Message-Id: <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6865aba7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=ve_3tq2zxeYcbLeBH3kA:9
X-Proofpoint-GUID: S-M3EofAUJ9mtyk-2CtiXGJ4h3LCcliJ
X-Proofpoint-ORIG-GUID: S-M3EofAUJ9mtyk-2CtiXGJ4h3LCcliJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX2Ktr3ln3l2Pu
 sYyeJf2g582yCcythwm8s9IJXWDZu0wO7Sc+oQl7ygX9V9dMwseA6FSm7LGWXfUvOV1OY5PFJwy
 YtLL9ODVOYMAqFFBJWQrIx2YX+fG2fGZJ4P53CFzIcn+q4ZO/kRC36b8DUo1HL+pAmvZxYaYvC3
 GsTgJCt3OCnCEVPXJYmO8Z69RvlLJXTkw6PESvpCLTZb7tQ2hvaZhSrnVGmmemD41maz5KMsInv
 RBLZHLT6VmBXRn/SpChIS0T3wN+jJGSP59L5/do1bVKI9Zt4GhfvldFp7uR9iKnKiu+XoBc0G0n
 95Iz/96kaTPig1bWOO8qP8n6oaBwhDGEx24ZeeADYmoncyHfGsdqXYJA2cMxA8fLGXWUdOHopBs
 xwa81Be1BOOQYnFRPZWT+PcFPKYlrG/N7BXErOO7d8bmymnClDu0m7X1m6U997xNxCAL01BQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/hw/vfio/vfio-cpr.h    |  2 ++
 include/hw/vfio/vfio-device.h |  2 ++
 include/system/kvm.h          |  1 +
 accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c          |  2 ++
 hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
 hw/vfio/helpers.c             | 11 +++++++++++
 7 files changed, 71 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 25e74ee..099d54f 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -62,4 +62,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 
+void vfio_cpr_add_kvm_notifier(void);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index c616652..f503837 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
+
+void vfio_kvm_device_close(void);
 #endif /* HW_VFIO_VFIO_COMMON_H */
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
index d095d1b..8141854 100644
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
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index a84c324..daa3523 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -177,6 +177,8 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
                                          MIG_MODE_CPR_TRANSFER, -1) == 0;
     }
 
+    vfio_cpr_add_kvm_notifier();
+
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
     /* During incoming CPR, divert calls to dma_map. */
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index f5555ca..0e903cd 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -190,3 +190,24 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static NotifierWithReturn kvm_close_notifier;
+
+static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
+                                       MigrationEvent *e,
+                                       Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        vfio_kvm_device_close();
+    }
+    return 0;
+}
+
+void vfio_cpr_add_kvm_notifier(void)
+{
+    if (!kvm_close_notifier.notify) {
+        migration_add_notifier_mode(&kvm_close_notifier,
+                                    vfio_cpr_kvm_close_notifier,
+                                    MIG_MODE_CPR_TRANSFER);
+    }
+}
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index d0dbab1..9a5f621 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -117,6 +117,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 int vfio_kvm_device_fd = -1;
 #endif
 
+void vfio_kvm_device_close(void)
+{
+#ifdef CONFIG_KVM
+    kvm_close();
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
-- 
1.8.3.1


