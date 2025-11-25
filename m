Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CF4D0E6C5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqoV-0006qV-9V; Tue, 25 Nov 2025 06:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqoT-0006pV-4u
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqoR-0002Y3-2c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:24 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AP9d0Ij2343197; Tue, 25 Nov 2025 11:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=2IL7f
 WSkuGVtB209eIsl+i65aA2L0+KHjioP8RXDI0c=; b=PUuilfqo6kiFMQA8YL9XD
 Wl3OdxJGuhd7sT9PHxASU4pAZP16LRkgULc1ItMHcxrE9dYwjjyQh/0HWSZthPeV
 hfr6VsPEgCMu9xF4zIzCbzGJx5dqQVZwihhdApb9/7SyQ14eELaoaqpiNw98179S
 zuNVvPY0GIel5Df7XBsekimWibxGgUetOUWRheD7J/f4BzFD3EsXC9H0MwH3lUUB
 FGeeWj+pB8zViCW4ZmZHMcCnI04MmIcD9mQPnGsbsOdJfTZ5lagZ14kE3263mQmg
 SNs/fkxKPMqNV40SbXEUuCWUHfqd/8K54z97M9ziHUaUXAdNgyvFMLIAwdBb5cCS
 w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkceew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5APAYlmu022517; Tue, 25 Nov 2025 11:02:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3mkbqhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5APB2C34034162;
 Tue, 25 Nov 2025 11:02:13 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ak3mkbqd7-2; Tue, 25 Nov 2025 11:02:12 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/2] virtio-scsi: Make max_target value configurable
Date: Tue, 25 Nov 2025 11:01:50 +0000
Message-ID: <dcb4ca40497dd88f27b345c708402885abdad776.1763999544.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1763999544.git.karolina.stolarek@oracle.com>
References: <cover.1763999544.git.karolina.stolarek@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250090
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=69258cb6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SfbrKk1LSQ83uD6wbeEA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA5MCBTYWx0ZWRfX5nB+ETjlOUvz
 xlDE0xvs4Yj2rYawd3x8o0c0vtOy8kROjLc8WWIEpM5kRZbDQa+RCTxEbV8YuyWAPLUehrys4TI
 fJv7e1jK+3guXLQhOucWWd9ozi/OakcTjORyNzOfP9MS6XNFMLuzQqz5VmhtnyBuPl1s5DQD0o9
 iOgAIuLQ19+blwfS676+1kNhqWYmKDY4y18mLhR+n3SJo1g1+qISsRIzSkvVe3C3rGt+NrcCU7y
 5/+rkbIqhBUdAq9Pa/0n64mkqiYF4w7svAbZXtqGqoYn+VQkxZIJj5AC/N90CIf/lERKcbQ0Wk5
 sOO2rGe86nORsq4K1fh2Ap/mmaj/y5jdEXk6m/vmKjsEJL7QUtBTKK11MzpfbT3hIGLZTXuO3j2
 qSdQhA8TYV7Ut98I5Rrvo0zavZ7lL630G+zxzU+/22TqoJ1GRWg=
X-Proofpoint-ORIG-GUID: GQ2F9XQmeRkOQveiHHsyLXVYijOZiOyY
X-Proofpoint-GUID: GQ2F9XQmeRkOQveiHHsyLXVYijOZiOyY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0a-00069f02.pphosted.com
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

In virtiscsi_probe(), virtio-scsi enumerates all possible
targets, up to VIRTIO_SCSI_MAX_TARGET, to see which of them
are available. This means that during that scan, the initiator
queues up INQUIRY commands to the targets that do not exist.
Such inquires fail, returning a BAD_TARGET response.

Currently, there is no way to limit the number of possible
targets or to finish the scan earlier. Add "max_target"
option for virtio-scsi and vhost-scsi devices to provide
a hint on the number of targets available for scanning.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/virtio-scsi.c           | 42 +++++++++++++++++++--------------
 include/hw/virtio/virtio-scsi.h |  1 +
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cdf405b0f8..1a4860a72f 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -353,6 +353,8 @@ static const Property vhost_scsi_properties[] = {
                        128),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
                       true),
+    DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
+                        VIRTIO_SCSI_MAX_TARGET),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 93e87c459c..091f68090e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -971,7 +971,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stl_p(vdev, &scsiconf->sense_size, s->sense_size);
     virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
-    virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
+    virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
     virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
 }
 
@@ -1260,23 +1260,26 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
     }
 }
 
-static struct SCSIBusInfo virtio_scsi_scsi_info = {
-    .tcq = true,
-    .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
-    .max_target = VIRTIO_SCSI_MAX_TARGET,
-    .max_lun = VIRTIO_SCSI_MAX_LUN,
-
-    .complete = virtio_scsi_command_complete,
-    .fail = virtio_scsi_command_failed,
-    .cancel = virtio_scsi_request_cancelled,
-    .change = virtio_scsi_change,
-    .parse_cdb = virtio_scsi_parse_cdb,
-    .get_sg_list = virtio_scsi_get_sg_list,
-    .save_request = virtio_scsi_save_request,
-    .load_request = virtio_scsi_load_request,
-    .drained_begin = virtio_scsi_drained_begin,
-    .drained_end = virtio_scsi_drained_end,
-};
+static struct SCSIBusInfo virtio_scsi_scsi_info;
+
+static void virtio_scsi_init_scsi_info(struct VirtIOSCSIConf *conf)
+{
+    virtio_scsi_scsi_info.tcq = true;
+    virtio_scsi_scsi_info.max_channel = VIRTIO_SCSI_MAX_CHANNEL;
+    virtio_scsi_scsi_info.max_lun = VIRTIO_SCSI_MAX_LUN;
+    virtio_scsi_scsi_info.max_target = conf->max_target;
+
+    virtio_scsi_scsi_info.complete = virtio_scsi_command_complete;
+    virtio_scsi_scsi_info.fail = virtio_scsi_command_failed;
+    virtio_scsi_scsi_info.cancel = virtio_scsi_request_cancelled;
+    virtio_scsi_scsi_info.change = virtio_scsi_change;
+    virtio_scsi_scsi_info.parse_cdb = virtio_scsi_parse_cdb;
+    virtio_scsi_scsi_info.get_sg_list = virtio_scsi_get_sg_list;
+    virtio_scsi_scsi_info.save_request = virtio_scsi_save_request;
+    virtio_scsi_scsi_info.load_request = virtio_scsi_load_request;
+    virtio_scsi_scsi_info.drained_begin = virtio_scsi_drained_begin;
+    virtio_scsi_scsi_info.drained_end = virtio_scsi_drained_end;
+}
 
 void virtio_scsi_common_realize(DeviceState *dev,
                                 VirtIOHandleOutput ctrl,
@@ -1289,6 +1292,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
     int i;
 
     virtio_init(vdev, VIRTIO_ID_SCSI, sizeof(VirtIOSCSIConfig));
+    virtio_scsi_init_scsi_info(&s->conf);
 
     if (s->conf.num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
         s->conf.num_queues = 1;
@@ -1379,6 +1383,8 @@ static const Property virtio_scsi_properties[] = {
                                          parent_obj.conf.virtqueue_size, 256),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
                       parent_obj.conf.seg_max_adjust, true),
+    DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
+                        VIRTIO_SCSI_MAX_TARGET),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..3998b241f6 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -54,6 +54,7 @@ struct VirtIOSCSIConf {
     uint32_t virtqueue_size;
     bool worker_per_virtqueue;
     bool seg_max_adjust;
+    uint16_t max_target;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
     char *vhostfd;
-- 
2.47.1


