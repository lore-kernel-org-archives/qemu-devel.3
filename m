Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2571BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqN-00050b-58; Mon, 04 May 2026 10:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqF-0004tp-Eq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqD-0002L5-FS
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fU8a2267912; Mon, 4 May 2026 14:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=8+jP8
 70k2iuf257VhozDC93Ct0ogT9nFVT9nYM/jyV4=; b=OAO3BBBs+1n1iRrfc0VwH
 6ss4ERHGnNLvyyEeaDrT73foftMGDErSDwDVvAwfLG4gml89dn7gciukDcegr8CY
 YdBnBwQLfcKF/S1c/OletJGxp3js2rUpi3BzHCE9+SRKMp1/mefS80EGu6UBXjXv
 2ZRa8Vm8fX6xZ/kLHvgfYrQ9IqvuuyBeYaGi+TwskQJot9fFQXBT60CfSoL3J9gE
 FnrEikqjbOZ1Z4EwZNZha/pmGxX8zko1IUpHA8MFbo+TPAgymwYafEiJzd9a9wrz
 94t84OgVHKjI3rcSSXksIg0HfzsVcfnl8nOhShiDTdXyF+9xLCt82pF0zYwCZwH9
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxjneb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuSdi013921; Mon, 4 May 2026 14:00:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk9et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:06 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvom027094;
 Mon, 4 May 2026 14:00:05 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-6; Mon, 04 May 2026 14:00:05 +0000 (GMT)
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>
Subject: [PATCH 5/5] virtio-scsi: Make max_lun parameter configurable
Date: Mon,  4 May 2026 13:59:44 +0000
Message-ID: <9d555df8e0e8f84cc516ccce7506f6779fc3e600.1777890280.git.karolina.stolarek@oracle.com>
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
X-Proofpoint-ORIG-GUID: AizrmXuhkZLipDlpfgjyFerrkS60zHsr
X-Proofpoint-GUID: AizrmXuhkZLipDlpfgjyFerrkS60zHsr
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f8a666 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=D97SWcnLPx3_jtXOGE4A:9 cc=ntf awl=host:12306
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfX9lrLQsAJVQ6m
 PNDum5gQsrAbPH055ARbf2NrPlrRO2AY5nf689H8v0ENurXjOCBTQ3kDmrZgC2R3aLLzgQ3GyBg
 WwL5mqmTrD/J9RHvfp99BCgiKLOFi55jlSBhGEvlWz1UBaP5nPfcxbSQSvNw/Q7Eyvk0VocMMjQ
 RGpqpNt75eJOd9L5LShPbg+a1KwfPHqIuOLY8Q/nh/kquSWk7za1UOoMc9zmzllvndlJaP2Pk9C
 7uRzLuCa91n3/bloWVt5Lcy1RJCoIyfwfEw9l726skcDDUnDjwvbhtzlf/gE6ltxSPhB9AbFuh4
 z7LqZYWjN9/qc4PzdSn9IacH0J292zGUrmvqsUbXQjcr7tnCbFKgGqvMsLYG6VLkbib+lj3OQFU
 sH+Vz+Jxcjvxagmrsf0OzW2uFCsOp90shg8JJnK2O7tarKzzWFmP4X+e9vtedsILrRRGSH98fJB
 ZEB8iDZlAhaJ27hpdDl9MR1LfTBwh53UY2aaQ7Sk=
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

The virtio-scsi driver in the guest is able to retrieve
the correct number of LUNs by querying REPORT_LUNS. There
are some drivers, such as OVMF VirtioScsiDxe, that discover
LUNs by queuing INQUIRY commands up to an arbitrary limit.

This is an issue for vhost-scsi devices, as each inquiry
to a LUN in a target that exists causes "Detected
NON_EXISTENT_LUN Access" errors to flood the kernel logs
of the hypervisor during VM boot.

Add a "max_lun" option to virtio-scsi and vhost-scsi devices to
specify the maximum number of LUNs to prevent sending commands
to Logical Units that don't exist.

Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raphael Norwitz <rnorwitz@nvidia.com>
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/vhost-scsi.c            | 2 ++
 hw/scsi/vhost-user-scsi.c       | 2 ++
 hw/scsi/virtio-scsi.c           | 6 ++++--
 include/hw/virtio/virtio-scsi.h | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index b2e8240344..568ce02e36 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -354,6 +354,8 @@ static const Property vhost_scsi_properties[] = {
                       true),
     DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
                       VIRTIO_SCSI_MAX_TARGET),
+    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
+                       VIRTIO_SCSI_MAX_LUN),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 4e59f06ea2..f4c761bf18 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -354,6 +354,8 @@ static const Property vhost_user_scsi_properties[] = {
                        128),
     DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
                       VIRTIO_SCSI_MAX_TARGET),
+    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
+                       VIRTIO_SCSI_MAX_LUN),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4de06bad3d..3a10ef2118 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -976,7 +976,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
     virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
-    virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
+    virtio_stl_p(vdev, &scsiconf->max_lun, s->conf.max_lun);
 }
 
 static void virtio_scsi_set_config(VirtIODevice *vdev,
@@ -1324,7 +1324,7 @@ static void virtio_scsi_scsi_config_init(VirtIOSCSI *s)
     s->bus_config->tcq = true;
     s->bus_config->max_channel = VIRTIO_SCSI_MAX_CHANNEL;
     s->bus_config->max_target = s->parent_obj.conf.max_target;
-    s->bus_config->max_lun = VIRTIO_SCSI_MAX_LUN;
+    s->bus_config->max_lun = s->parent_obj.conf.max_lun;
 }
 
 static void virtio_scsi_scsi_bus_cleanup(VirtIOSCSI *s)
@@ -1404,6 +1404,8 @@ static const Property virtio_scsi_properties[] = {
                       parent_obj.conf.seg_max_adjust, true),
     DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
                       VIRTIO_SCSI_MAX_TARGET),
+    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
+                       VIRTIO_SCSI_MAX_LUN),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b4b796fc58..9d5b90c3bc 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -55,6 +55,7 @@ struct VirtIOSCSIConf {
     bool worker_per_virtqueue;
     bool seg_max_adjust;
     uint8_t max_target;
+    uint32_t max_lun;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
     char *vhostfd;
-- 
2.47.1


