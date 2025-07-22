Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE33C87FC5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKV-00032f-FS; Tue, 22 Jul 2025 08:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJV-0002Oy-9W
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJQ-0006LR-2t
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAZb002504;
 Tue, 22 Jul 2025 12:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=udCm3
 rQJ9v1mNX6dwFqc4R9vJOWnpGCGOSOWjfUFE1Q=; b=g2Uu8W9iEbUZ6NuYZASUv
 tIlWHoybJjY4+OgoU9UWRqGaJHeIG1UbhTUJEpitP7MdG8HZCubl708RqJhCnoPd
 uooB8/rweZNZKJdu89RYuz+7WoKsmOaWZXTshRP4cHxtisuk2KWQLHzJPBqsSqz8
 /u6l/quD6Hzrt4Zp/nMCvrBOFJ7q3FLpqIStb0ipVPEGF7mHK3SKCGef3q2hUpE1
 iBYSftPffDLeukI/GobyikQ2RGJEHck0heXjvR4e5vF7dXXDFGD3X3+hd9Uuct2u
 iLp8NCd6V8imUWDFxT7zcltwQIzRWxOHLKfW2M1jf3g9nmKqOygd9DFMIJ3RzOB3
 w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpd580-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MCHZTZ010356; Tue, 22 Jul 2025 12:41:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3x039536;
 Tue, 22 Jul 2025 12:41:35 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-6; Tue, 22 Jul 2025 12:41:35 +0000
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 5/6] virtio,
 virtio-net: skip consistency check in virtio_load for iterative
 migration
Date: Tue, 22 Jul 2025 12:41:26 +0000
Message-ID: <20250722124127.2497406-6-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: _COdjGfAkEcheAkQqFVhqtdxyTzAtyDj
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687f8701 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=ncbDbCRbhD_Ka3aqogoA:9
X-Proofpoint-GUID: _COdjGfAkEcheAkQqFVhqtdxyTzAtyDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfXxRrh7JVNjT/U
 GZDyMg5+GarRZduLMBrYMOb85rkDSwQbSlUyNCPAUdD9ktdEJjwZBg2SnO4UEQzwaPBYxw7mJ/c
 vgNkhNVQ8T8WTgYS7d8V6ac63IzzHOWGmiohp0PsMAEiH5b3WdWz1oV8prAFt8+3aWtrh9JG/TE
 a6/sCDNFka8qFwLow9lSkPEEXgFv9T2ooW2XBcqd9RzsrMe24zaX9+1pMhFDFMmdxcGYLNTODQY
 IACUa3VuRUoqrw45Hu/2yf5utCwMy3pdibUKCshS1Dp6HZT98WVDNgBCalk0oj/XHaytLXLLYJK
 QoKCfUowlzzxedsgVu6hJRW/Rj6y4re3Y1fUiMQUmo2CRiLiQLAgET19U9DjosqdtWUSjEwmbDn
 DPQI6xmfpYP0KNOg28dLfpDvqchF37/Ex2yQP3iSQu+MjvuRlAHcphNTG3S4eTbDCqxuarbV
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
Reply-to:  Jonah Palmer <jonah.palmer@oracle.com>
From:  Jonah Palmer via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Iterative live migration for virtio-net sends an initial
VMStateDescription while the source is still active. Because data
continues to flow for virtio-net, the guest's avail index continues to
increment after last_avail_idx had already been sent. This causes the
destination to often see something like this from virtio_error():

VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4

This patch suppresses this consistency check if we're loading the
initial VMStateDescriptions via iterative migration and unsuppresses
it for the stop-and-copy phase when the final VMStateDescriptions
(carrying the correct indices) are loaded.

A temporary VirtIODevMigration migration data structure is introduced here to
represent the iterative migration process for a VirtIODevice. For now it
just holds a flag to indicate whether or not the initial
VMStateDescription was sent during the iterative live migration process.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        | 13 +++++++++++++
 hw/virtio/virtio.c         | 32 ++++++++++++++++++++++++--------
 include/hw/virtio/virtio.h |  6 ++++++
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 86a6fe5b91..b7ac5e8278 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3843,12 +3843,19 @@ static void virtio_net_save_cleanup(void *opaque)
 
 static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    vdev->migration = g_new0(VirtIODevMigration, 1);
+    vdev->migration->iterative_vmstate_loaded = false;
+
     return 0;
 }
 
 static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    VirtIODevMigration *mig = vdev->migration;
     uint64_t flag;
 
     flag = qemu_get_be64(f);
@@ -3861,6 +3868,7 @@ static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
         case VNET_MIG_F_INIT_STATE:
         {
             vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
+            mig->iterative_vmstate_loaded = true;
             break;
         }
         default:
@@ -3875,6 +3883,11 @@ static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
 
 static int virtio_net_load_cleanup(void *opaque)
 {
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    g_free(vdev->migration);
+    vdev->migration = NULL;
+
     return 0;
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5534251e01..68957ee7d1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3222,6 +3222,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     int32_t config_len;
     uint32_t num;
     uint32_t features;
+    bool inconsistent_indices;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -3365,6 +3366,16 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
 
+           /*
+            * Ring indices will be inconsistent during iterative migration. The actual
+            * indices will be sent later during the stop-and-copy phase.
+            */
+            if (vdev->migration) {
+                inconsistent_indices = !vdev->migration->iterative_vmstate_loaded;
+            } else {
+                inconsistent_indices = false;
+            }
+
             /*
              * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
              * only the region cache needs to be set up.  Legacy devices need
@@ -3384,14 +3395,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
-            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
-            /* Check it isn't doing strange things with descriptor numbers. */
-            if (nheads > vdev->vq[i].vring.num) {
-                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
-                             "inconsistent with Host index 0x%x: delta 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vring_avail_idx(&vdev->vq[i]),
-                             vdev->vq[i].last_avail_idx, nheads);
+            if (!inconsistent_indices) {
+                nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
+                /* Check it isn't doing strange things with descriptor numbers. */
+                if (nheads > vdev->vq[i].vring.num) {
+                    virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
+                                 "inconsistent with Host index 0x%x: delta 0x%x",
+                                 i, vdev->vq[i].vring.num,
+                                 vring_avail_idx(&vdev->vq[i]),
+                                 vdev->vq[i].last_avail_idx, nheads);
+                    inconsistent_indices = true;
+                }
+            }
+            if (inconsistent_indices) {
                 vdev->vq[i].used_idx = 0;
                 vdev->vq[i].shadow_avail_idx = 0;
                 vdev->vq[i].inuse = 0;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 214d4a77e9..06b6e6ba65 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -98,6 +98,11 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+/* VirtIODevice iterative live migration data structure */
+typedef struct VirtIODevMigration {
+    bool iterative_vmstate_loaded;
+} VirtIODevMigration;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -151,6 +156,7 @@ struct VirtIODevice
     bool disable_legacy_check;
     bool vhost_started;
     VMChangeStateEntry *vmstate;
+    VirtIODevMigration *migration;
     char *bus_name;
     uint8_t device_endian;
     /**
-- 
2.47.1


