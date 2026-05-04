Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A331CD3439
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqL-0004zT-PE; Mon, 04 May 2026 10:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqF-0004tT-09
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqC-0002K0-Rm
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fdGw2268646; Mon, 4 May 2026 14:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=bGGjN
 cVKNnZzZs+y/txProzJd2cjYTgmMc+7C3kNu+c=; b=mxa1jZnHd+HiddriBESO8
 eIUNJLMvVB++SkzJY9SEhqypml8MvcqJP1WKpUbKgvSkZ0L1qJhh+JJ0tzGmhqL6
 s7/zUvZVzMSjAM/FNFQROjuJgvz530ByFpJjhkNn9TsIdGVvLcLLZaSvl1WdiJz5
 GXlSrDM2mGntqeHIPle4Ku2ngCl8i0RxNnC//mMJMlTjlv3wSgyE64QEH/bFMo8y
 RctjwYzCFjU+0/bXV/7xcABH/+tuwxkYny0sPe5ZR/+MWCmffjPKH5ogIyJ6qcV/
 cJ/IfNa9k6VFWKOFsVlw3Wnh57y4Ul5hiWS/OOq65atigk14cTdVaCgShNIDPp0e
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxjnea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuR9i013898; Mon, 4 May 2026 14:00:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk9cg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:05 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvok027094;
 Mon, 4 May 2026 14:00:04 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-5; Mon, 04 May 2026 14:00:04 +0000 (GMT)
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>
Subject: [PATCH 4/5] virtio-scsi: Make max_target parameter configurable
Date: Mon,  4 May 2026 13:59:43 +0000
Message-ID: <020004d5e274daf0370094d631d61a452db7d599.1777890280.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777890280.git.karolina.stolarek@oracle.com>
References: <cover.1777890280.git.karolina.stolarek@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040145
X-Proofpoint-ORIG-GUID: RAnXQVekqB-GRo-ko0Rdh5Huq3lpIy2o
X-Proofpoint-GUID: RAnXQVekqB-GRo-ko0Rdh5Huq3lpIy2o
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f8a665 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=Kyoq6vq9e98cMt6sh_8A:9 cc=ntf awl=host:12306
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfXx7O/C93D99t9
 a+TcgVt+Hvj32vzzMhl24RJyKEgxoYs7sQslEIX4AuMJbDquLnb0nVhtYB8CmX7WbgyngRi7hLj
 9mPLyI4eohz/KETYRpr7Ig2q1/9ha+QFos/7q4N9ONZij2fLPvoSESkKLmgQxVyokYkMEjkRQYM
 SXuZ0sd4KzquRZv+Q0sexoFrY6LIEgi1yVhiE+kX1unNs7KAxAKnMOEuvTJOcAsmrISwfcA7bzc
 uglLlfklqiK9UNa9FgQr+wGDsEii8MMj4CKy4hIiWTtEbkpwvXLyeSgVXuglOQxz68/k9YD9zqW
 vO+mN0ez7JnoExzxjXQyAGSRwEPuG3DSjpDg0ed4ZS4yyEG29Dbz+3+OEYs8pMSn8oFQzAY1CLd
 aEpxv7O+V1+vFKJMivF5W3iyPFxaxGYHbbfPJarJGAfbU9PgNPdHzJhIwfxXM19Z31l03mLb4U4
 2RntDE1YRMXc80i7JqdyZJPAz59kPhtrTY9ERgYg=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In virtscsi_probe(), virtio-scsi enumerates all possible
targets, up to VIRTIO_SCSI_MAX_TARGET, to see which of
them are available. During this scan, the initiator
queues up INQUIRY commands for targets that do not exist.

Provide a "max_target" option for vhost-scsi and virtio-scsi
devices to change the upper limit of scanned targets. Move
away from a static virtio_scsi_scsi_config definition in
favor of a dynamically allocated SCSIBusConfig that is
stored by the VirtIOSCSI device.

Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raphael Norwitz <rnorwitz@nvidia.com>
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/vhost-user-scsi.c       |  2 ++
 hw/scsi/virtio-scsi.c           | 37 ++++++++++++++++++++++++---------
 include/hw/virtio/virtio-scsi.h |  3 +++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 699863cc10..b2e8240344 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -352,6 +352,8 @@ static const Property vhost_scsi_properties[] = {
                        128),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
                       true),
+    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
+                      VIRTIO_SCSI_MAX_TARGET),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 3612897d4b..4e59f06ea2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -352,6 +352,8 @@ static const Property vhost_user_scsi_properties[] = {
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
                        128),
+    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
+                      VIRTIO_SCSI_MAX_TARGET),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f9e4f6fc02..4de06bad3d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -975,7 +975,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stl_p(vdev, &scsiconf->sense_size, s->sense_size);
     virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
-    virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
+    virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
     virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
 }
 
@@ -1264,13 +1264,6 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
     }
 }
 
-static struct SCSIBusConfig virtio_scsi_scsi_config = {
-    .tcq = true,
-    .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
-    .max_target = VIRTIO_SCSI_MAX_TARGET,
-    .max_lun = VIRTIO_SCSI_MAX_LUN,
-};
-
 static const struct SCSIBusOps virtio_scsi_scsi_ops = {
     .complete = virtio_scsi_command_complete,
     .fail = virtio_scsi_command_failed,
@@ -1324,6 +1317,23 @@ void virtio_scsi_common_realize(DeviceState *dev,
     }
 }
 
+static void virtio_scsi_scsi_config_init(VirtIOSCSI *s)
+{
+    s->bus_config = g_malloc(sizeof(SCSIBusConfig));
+
+    s->bus_config->tcq = true;
+    s->bus_config->max_channel = VIRTIO_SCSI_MAX_CHANNEL;
+    s->bus_config->max_target = s->parent_obj.conf.max_target;
+    s->bus_config->max_lun = VIRTIO_SCSI_MAX_LUN;
+}
+
+static void virtio_scsi_scsi_bus_cleanup(VirtIOSCSI *s)
+{
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
+    g_free(s->bus_config);
+    s->bus.config = NULL;
+}
+
 static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1344,13 +1354,18 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    virtio_scsi_scsi_config_init(s);
     scsi_bus_init_named(&s->bus, sizeof(s->bus), dev,
-                        &virtio_scsi_scsi_ops, &virtio_scsi_scsi_config,
+                        &virtio_scsi_scsi_ops, s->bus_config,
                         vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
 
     virtio_scsi_dataplane_setup(s, errp);
+
+    if (*errp) {
+        virtio_scsi_scsi_bus_cleanup(s);
+    }
 }
 
 void virtio_scsi_common_unrealize(DeviceState *dev)
@@ -1374,7 +1389,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
     virtio_scsi_dataplane_cleanup(s);
-    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
+    virtio_scsi_scsi_bus_cleanup(s);
     virtio_scsi_common_unrealize(dev);
     qemu_mutex_destroy(&s->event_lock);
     qemu_mutex_destroy(&s->ctrl_lock);
@@ -1387,6 +1402,8 @@ static const Property virtio_scsi_properties[] = {
                                          parent_obj.conf.virtqueue_size, 256),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
                       parent_obj.conf.seg_max_adjust, true),
+    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
+                      VIRTIO_SCSI_MAX_TARGET),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..b4b796fc58 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -54,6 +54,7 @@ struct VirtIOSCSIConf {
     uint32_t virtqueue_size;
     bool worker_per_virtqueue;
     bool seg_max_adjust;
+    uint8_t max_target;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
     char *vhostfd;
@@ -83,6 +84,8 @@ struct VirtIOSCSI {
     VirtIOSCSICommon parent_obj;
 
     SCSIBus bus;
+    SCSIBusConfig *bus_config;
+
     int resetting; /* written from main loop thread, read from any thread */
 
     QemuMutex event_lock; /* protects event_vq and events_dropped */
-- 
2.47.1


