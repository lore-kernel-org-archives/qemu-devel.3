Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC9C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKV-00030A-7j; Tue, 22 Jul 2025 08:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJU-0002O6-3g
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJN-0006Kd-HH
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:41 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAKE024432;
 Tue, 22 Jul 2025 12:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=T7tNI
 Dru02PeriUSzz8aBkyb9Tz6kpEvzGllNy4b8Ow=; b=nEwUWOnvAD0HMvVxUF0Ut
 2qA6LO2CPSwbfk7VWbRhInMylUoUplIzaWoe2MWQRhoACry2Q/ce9BEiuvu0idUt
 KKCR21LtoDPylL/yLgQRogbz67YfvkLpxnNGYe3eO1pPyxb+LNnLsEUmoEadUD9w
 7EZE8JuiV0CnQrr8r0UbioB4KrIBuGRnendUOXCq7Qd3HDIQBGGzbY/dCdqxuKDL
 gHmFTWo9KDiLXT3lFwtFXJoqGYZQNd97Iemab08SI35hXBDSXRQcKiLhfgkBAF30
 9WXI1Xu6dsX4cuRIkQk913sSg077PpgD+lpgmcvff/6koY8sAQA1YjD8qSK+2kpX
 w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qw70u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MBU3m0010414; Tue, 22 Jul 2025 12:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3t039536;
 Tue, 22 Jul 2025 12:41:33 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-4; Tue, 22 Jul 2025 12:41:33 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 3/6] virtio-net: Add SaveVMHandlers for iterative migration
Date: Tue, 22 Jul 2025 12:41:24 +0000
Message-ID: <20250722124127.2497406-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722124127.2497406-1-jonah.palmer@oracle.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220104
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687f86fe cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=EcWnT0cij3RzOpli2RYA:9
X-Proofpoint-ORIG-GUID: eGsc5JN3OklBUXGlRewXEwdXWNmDAS1Q
X-Proofpoint-GUID: eGsc5JN3OklBUXGlRewXEwdXWNmDAS1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfX7JZIK4xHQpwi
 TuujY955QsZMMR0N6Hp27FqYfsAZ3+vqgv6WztiEj3a3s632tTAgKprmI70en6Ulw0trrzo2fBD
 4RQ0FMZyWANhdzDHId/X2RTGCo2m6RA6ua8Kk/I/mWTC3FLkXdZ3VplOZ00lE7RUhpX4ZuTq6CQ
 vmJIBMvYNxQznbHLHAyiGlc1tWsn+HIEozF9wjwkAMdil4dZ8WRJNgXEGECDi2wOhzaE9Y4G6fj
 Kzh39fZfQIkDuYpncSK1jYp7TE90fWNZ78VO/kCDXQLAY8TD5w/YIx1dLPXXPwM/cojta5PopF5
 of0UdeU1rvG2qix1fWPpx5CVZpPNjjdC5ioBklHYfM8apD9C2E6PjG41+QWhsjU1HXWzw0s3jOQ
 7m5LBvJMoSqiWyIjZKFiEyHMBOfKx5AvT3jx8aU0zyCdGg7bc0NiouINcFSgI4mbhG3lLkVf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add SaveVMHandlers struct for virtio-net iterative migration support.
The handlers are registered but only contain no-op implementations.

This provides the framework for iterative migration without changing any
actual migration behavior when the capability is disabled.

A BFD representation is used when registering a virtio-net device's
SaveVMHandlers hooks. This is to create unique IDs in the case of
multiple virtio-net devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 93029104b3..19aa5b5936 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
 #include "hw/virtio/virtio.h"
 #include "net/net.h"
 #include "net/checksum.h"
@@ -38,6 +39,9 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/register.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
 #include "system/replay.h"
@@ -3791,11 +3795,77 @@ static const VMStateDescription vmstate_virtio_net = {
     .dev_unplug_pending = dev_unplug_pending,
 };
 
+static bool virtio_net_iterative_migration_enabled(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->capabilities[MIGRATION_CAPABILITY_VIRTIO_ITERATIVE];
+}
+
+static bool virtio_net_is_active(void *opaque)
+{
+    return virtio_net_iterative_migration_enabled();
+}
+
+static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
+{
+    return 0;
+}
+
+static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
+{
+    return 1;
+}
+
+static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
+{
+    return 0;
+}
+
+static void virtio_net_save_cleanup(void *opaque)
+{
+
+}
+
+static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
+{
+    return 0;
+}
+
+static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    return 0;
+}
+
+static int virtio_net_load_cleanup(void *opaque)
+{
+    return 0;
+}
+
+static void virtio_net_state_pending_exact(void *opaque, uint64_t *must_precopy,
+                                           uint64_t *can_postcopy)
+{
+
+}
+
+static const SaveVMHandlers savevm_virtio_net_handlers = {
+    .is_active = virtio_net_is_active,
+    .save_setup = virtio_net_save_setup,
+    .save_live_iterate = virtio_net_save_live_iterate,
+    .save_live_complete_precopy = virtio_net_save_live_complete_precopy,
+    .save_cleanup = virtio_net_save_cleanup,
+    .load_setup = virtio_net_load_setup,
+    .load_state = virtio_net_load_state,
+    .load_cleanup = virtio_net_load_cleanup,
+    .state_pending_exact = virtio_net_state_pending_exact,
+};
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     NetClientState *nc;
+    g_autofree char *path = NULL;
+    char id[256] = "";
     int i;
 
     if (n->net_conf.mtu) {
@@ -3963,12 +4033,21 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
         virtio_net_load_ebpf(n, errp);
     }
+
+    /* Register handlers for iterative migration */
+    path = qdev_get_dev_path(DEVICE(&n->parent_obj));
+    path = g_strdup_printf("%s/virtio-net-iterative", path);
+    strpadcpy(id, sizeof(id), path, '\0');
+    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1,
+                         &savevm_virtio_net_handlers, n);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
+    g_autofree char *path = NULL;
+    char id[256] = "";
     int i, max_queue_pairs;
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
@@ -4007,6 +4086,12 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     g_free(n->rss_data.indirections_table);
     net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
+
+    /* Unregister migration handlers */
+    path = qdev_get_dev_path(DEVICE(&n->parent_obj));
+    path = g_strdup_printf("%s/virtio-net-iterative", path);
+    strpadcpy(id, sizeof(id), path, '\0');
+    unregister_savevm(VMSTATE_IF(dev), id, n);
 }
 
 static void virtio_net_reset(VirtIODevice *vdev)
-- 
2.47.1


