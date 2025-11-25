Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B30D0E6C5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqoU-0006pz-AC; Tue, 25 Nov 2025 06:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqoR-0006p4-Jc
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqoO-0002Xh-Da
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:23 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AP9nBIB2432768; Tue, 25 Nov 2025 11:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=lIU7bVAVh2zwKOqV/8tckugqCU2PX
 FlIxOGtPHimQSU=; b=OseoEs5YvNyavcL0YJoQYoCa5lJ6MMIQ9qeTYSSCZYv6i
 e43dYB7OPWDVbGeUWCTGVsNpdA5gZqCTQiBuprHdipc+TQE+Gr8y7f/WhiT6fRmc
 0UQJOQxOEUOU7opbvo1IzUaklLa1UiFp6PBt30lY9iJHclAdUUMGajOH9W7Tve3Y
 rMJ4UU1UGvDPgjJpJiatvuhrXzRbSV44IODO2Ju09/w9yb94Hmk9tjadwv4rvhzb
 CH35vFXfOrSREFNaLvHNhows9LCf7duJTl1MISO9Iq3yHoe4cjEvCW3Q7eJkYbmd
 afJd6Iw/aNqqkV6qa0w5WnJvgdt/NLz8SxNyI+QeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yccf29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5APACM8t022625; Tue, 25 Nov 2025 11:02:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3mkbqhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5APB2C32034162;
 Tue, 25 Nov 2025 11:02:12 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ak3mkbqd7-1; Tue, 25 Nov 2025 11:02:12 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 0/2] virtio-scsi: Flexible max_target and max_lun params
Date: Tue, 25 Nov 2025 11:01:49 +0000
Message-ID: <cover.1763999544.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
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
X-Proofpoint-GUID: ryIjEZrPZvBHHnouHmxdR_zYESpEZVPO
X-Proofpoint-ORIG-GUID: ryIjEZrPZvBHHnouHmxdR_zYESpEZVPO
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=69258cb6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=l41FGJVa9rJyDwB8ZTwA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA5MCBTYWx0ZWRfX6VAo+oa+m15B
 mCxNEgVR7Kn94dhII1Q7uas8LtRaseDVyCuTlPRyV2u8xkAW0NEm60ARTXQ5BhW4OTXdYXz/dp3
 Nx3ThfzDcItdbfFdE88xlkuQFuypzrjtH7j2AVI99NNGtsD7fPgnYEXlLzic8mcVJaYxEt2TgMp
 j0ww2ulh6jD+U7o8aJ2rakxe1nai/D7Wk+Kxemgn9x2RaNBqLxFGdSRtduLiyvdl6bbGc7XHazd
 6YsSJOsKdXyTWjsHlyS9BHJ0SdJAIkTAsKPguu4NEKMkg4rpkyvde1Cja+sUhd+PlCxTlijdXpW
 YdHdeLAwiMQSEE19fyN1e53Ajayne/guY3Tk5ae4IV7R0JBvXqnUwJ1PhxeRIEXN5K9sJ889B/u
 g6PXYgyLOlgTuwhQcMjfkNF5rYvSeoDABV04spF376yl1eLA5QE=
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

Currently, the maximum number of targets is set and dictated
by virtio-scsi. On probe, the driver walks through all possible
targets to discover which of them are available. In the process,
it sends INQUIRY commands to request device information, also
querying devices that don't exist. This can be observed in
a guest with a single scsi-hd device and verbose SCSI logging
enabled:

scsi 0:0:0:0: scsi scan: REPORT LUN scan
scsi 0:0:0:0: scsi scan: device exists on 0:0:0:0
scsi 0:0:1:0: scsi scan: INQUIRY pass 1 length 36
scsi 0:0:1:0: scsi scan: INQUIRY failed with code 0x40000
(...)
scsi 0:0:255:0: scsi scan: INQUIRY pass 1 length 36
scsi 0:0:255:0: scsi scan: INQUIRY failed with code 0x40000

In the vhost-scsi backend, without the kernel patch [1], the issue
is far more noticeable. Each command queued up for a non-existing
target triggers vq_error(), registered by
vhost_virtqueue_error_notifier(), resulting in a flood of
"vhost vring error in virtqueue X" messages when booting up a VM.
Even with the [1] patch in place, we are still sending commands
to phantom targets with no way of limiting the scan. The first
patch in the series addresses this issue by introducing "max_target"
property for virtio-scsi and vhost-scsi devices. A user gets
an option to specify how many targets are used by the guest,
and to stop scanning before hitting VIRTIO_SCSI_MAX_TARGET.

A similar issue can be seen with Logical Units in the existing
devices. By default, the SCSI Host Adapter instance expects
8 LUNs, and some drivers assume this to be the actual number
of exposed LUNs. This results in executing SCSI commands that
refer to non-existing Logical Units. This can be easily observed
when using vhost-scsi backend, as such messages appear in
the host's dmesg when booting up a guest:

TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000001 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000002 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000003 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000004 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000005 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000006 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000007 from
naa.5001405277e02c68

The second patch provides a way to say how many LUNs are actually
there by setting "max_lun" property in virtio-scsi and vhost-scsi
devices. If neither property is defined, max_target and max_lun are
set to the default values, making these definitions optional.

----------------------------
[1] -
https://lore.kernel.org/virtualization/20250607171815.111030-1-michael.christie@oracle.com/T/#u

Karolina Stolarek (2):
  virtio-scsi: Make max_target value configurable
  virtio-scsi: Make max_lun value configurable

 hw/scsi/vhost-scsi.c            |  4 +++
 hw/scsi/virtio-scsi.c           | 46 +++++++++++++++++++--------------
 include/hw/virtio/virtio-scsi.h |  2 ++
 3 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.47.1


