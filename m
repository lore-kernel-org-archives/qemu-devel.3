Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A2C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKX-000367-C0; Tue, 22 Jul 2025 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJV-0002P2-Ap
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJQ-0006Lg-FU
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAYZ002494;
 Tue, 22 Jul 2025 12:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Rl49k
 rj7ViSaTPPGMRA6RmJFt6EEl+djuAVv29tgwhw=; b=oNz7sp0LQr+4lGlyZeGs3
 o+IF9y+RZ+vQL/6XLMgIr98ORCt7/l2TYEm6LbgU/ifgiMQw8M+I5/fzxPknlotM
 iVcZbrpvVxI8ptLG9kOfdGovCK7LNK7KN7HOshi/RXu8Q6txt6n6LlVzFsV9vFXe
 FmNdJlv14/HpwaGwMG2SP8/RXWQOSxTNMJj18W9adHpk8Eu+N00wZdz3Kx6OQ6YT
 Grwpta1lh4zABundQytBDpLa750cuZ/M8phb9fKIzW7JJVv7Lxgc6X/CHfI5iL5J
 ZZgn5axseqFKtJeQLsrO2DDyLqwLyQV+gPHmfWSUDXhsPd3xqk48vFXQZ9wRYM4u
 g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpd584-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MBf90b010337; Tue, 22 Jul 2025 12:41:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT41039536;
 Tue, 22 Jul 2025 12:41:37 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-7; Tue, 22 Jul 2025 12:41:37 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 6/6] virtio-net: skip vhost_started assertion during iterative
 migration
Date: Tue, 22 Jul 2025 12:41:27 +0000
Message-ID: <20250722124127.2497406-7-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: NMkobAYHwjzZ4RjayJK_EdtlBXcSPSJh
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687f8702 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=9V0WdlfnHfHVK-SkIusA:9
X-Proofpoint-GUID: NMkobAYHwjzZ4RjayJK_EdtlBXcSPSJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfX/6SVOmdGDsLQ
 QOBemMUWsXM5ZbIwT/F66I0UMZCLjSd6VY04i0gaij+rLJWmdAyPpdpgijEXnD8nzPj4o3XHcav
 9Q4fhuXfTmG2YphFYf1zn5vjRAd4fdf4EapRfP983viCM5yYw29judLhUGCRDoKTJI5dgsnWFDE
 u9X6ujA7JFSd52fK4x5ZEuBFozz7TiK9+CwWK/Ffde24Da00MP1k/MEBvzcJVpkJ/FHmNJL5H0y
 6GowUQN01hq7GH8mG8snlyp537V5QNTlSx7Kpfzia683tNY+g+PNvDCfRcAyqa8nEg1VHaCMjc2
 JIrcsqKoILc4Gj8x95XnWcP9GCjooS2zXVnOpJRrCEUtbQ7nGqNz74v4+Uyblq9/TbZADZFORdN
 DlurALeds5FPR/Mz80wa6xsQz0T6iIU/xUhZ9pefLF+zM3nyJLDVAj6ICnyXqriWAAKjLJIH
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

Initializes vhost-net support for iterative live migration by avoiding
the assertion that vhost needs to be stopped before proceeding with
sending the initial VMStateDescription for virtio-net.

This should be okay to do since we only care about the static device
state and not the dynamic ring states for the initial sending of the
device state.

After the iterative migration portion is finished and the source is
stopped, we still assert that vhost is also stopped.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        | 23 ++++++++++++++++++++++-
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b7ac5e8278..07941f991e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3753,6 +3753,19 @@ static bool failover_hide_primary_device(DeviceListener *listener,
 static int virtio_net_pre_save(void *opaque)
 {
     VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    /*
+     * During iterative migration, vhost will still be active. However,
+     * this shouldn't be an issue since we don't care about the dynamic
+     * ring states at this point.
+     *
+     * The final migration at the end will still occur with vhost stopped
+     * and any inconsistencies will be overwritten.
+     */
+    if (vdev->migration && !vdev->migration->iterative_vmstate_sent) {
+        return 0;
+    }
 
     /* At this point, backend must be stopped, otherwise
      * it might keep writing to memory. */
@@ -3809,11 +3822,16 @@ static bool virtio_net_is_active(void *opaque)
 static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    vdev->migration = g_new0(VirtIODevMigration, 1);
+    vdev->migration->iterative_vmstate_sent = false;
 
     qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
     vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
     qemu_put_be64(f, VNET_MIG_F_END_DATA);
 
+    vdev->migration->iterative_vmstate_sent = true;
+
     return 0;
 }
 
@@ -3838,7 +3856,10 @@ static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
 
 static void virtio_net_save_cleanup(void *opaque)
 {
-
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    g_free(vdev->migration);
+    vdev->migration = NULL;
 }
 
 static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 06b6e6ba65..aa3f60cb7b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -101,6 +101,7 @@ enum virtio_device_endian {
 /* VirtIODevice iterative live migration data structure */
 typedef struct VirtIODevMigration {
     bool iterative_vmstate_loaded;
+    bool iterative_vmstate_sent;
 } VirtIODevMigration;
 
 /**
-- 
2.47.1


