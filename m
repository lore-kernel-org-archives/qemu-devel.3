Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65806C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 00:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tekhl-0002iD-7z; Sun, 02 Feb 2025 19:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tekhj-0002i4-NI
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 19:52:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tekhh-0002Ue-Tj
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 19:52:47 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51300nEd026153;
 Mon, 3 Feb 2025 00:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=FVOnFbyn86J07oR+EqLLtUbDgPJFp
 jMVmt43pubLEaQ=; b=MtguOyDS8NNpa1NrNCD1iiPI3tJWYSrXFcCsQm7tS+yNa
 v6JCT13PSOPrL9Z/ioKRngWRj8A57+Ed8kBr4/1fkC+3bGlSt7XVi4M2Bj/4SmoO
 B7j0r9osnQFbrFigqMnd/3pvo7v+HtuOXLKj48BqZ7UfKk0Jjq470OZdtmbKYpkp
 8YND9haPb24bU5VcSGfI0/zH4XoAYYxqJhTS4yzOkBTnZ6dkNgw5gaPdwNtHwcsW
 v3wzNcghlyKoxSpwNfyLfn4S17AVm8JJ5IyJljidhi6ZlOIwlsGz37hFDrECUdAs
 fcSNtjVnef0oLvPu2ryhb6/JSxikKa89a0X9JWv5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv1c5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 00:52:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5130KEI1037627; Mon, 3 Feb 2025 00:52:17 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44j8gf251h-1; Mon, 03 Feb 2025 00:52:17 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 1/1] vhost-scsi: support VIRTIO_SCSI_F_HOTPLUG
Date: Sun,  2 Feb 2025 16:52:15 -0800
Message-ID: <20250203005215.1502-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_11,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030005
X-Proofpoint-GUID: FlUdDIZXJeNQa6zI7cbtDBxOBiDnh-RP
X-Proofpoint-ORIG-GUID: FlUdDIZXJeNQa6zI7cbtDBxOBiDnh-RP
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

So far there isn't way to test host kernel vhost-scsi event queue path,
because VIRTIO_SCSI_F_HOTPLUG isn't supported by QEMU.

virtio-scsi.c and vhost-user-scsi.c already support VIRTIO_SCSI_F_HOTPLUG
as property "hotplug".

Add support to vhost-scsi.c to help evaluate and test event queue.

To test the feature:

1. Create vhost-scsi target with targetcli.

targetcli /backstores/fileio create name=storage file_or_dev=disk01.raw
targetcli /vhost create naa.1123451234512345
targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage

2. Create QEMU instance with vhost-scsi.

-device vhost-scsi-pci,wwpn=naa.1123451234512345,hotplug=true

3. Once guest bootup, hotplug a new LUN from host.

targetcli /backstores/fileio create name=storage02 file_or_dev=disk02.raw
targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage02

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/scsi/vhost-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 8039d13fd9..d3a260f6a7 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -359,6 +359,9 @@ static const Property vhost_scsi_properties[] = {
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
+    DEFINE_PROP_BIT64("hotplug", VHostSCSICommon, host_features,
+                                                  VIRTIO_SCSI_F_HOTPLUG,
+                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
     DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
                      conf.worker_per_virtqueue, false),
-- 
2.39.3


