Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0BBC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 20:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK1M6-00084Q-30; Tue, 27 May 2025 16:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uK1M3-00083y-Gd
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:57:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uK1M1-0007qP-PC
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:56:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RKtqZ7001488;
 Tue, 27 May 2025 20:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=Ea+5EYi8
 Tx/9RZm/d1wDYlyZ2nDP47w8FHLAWrrkJ5w=; b=dLIVnP2ZURWJROVX36BVLGDO
 788HVM55ar+5DGXbIe9eMHh/MK+yLTFHtdgyx3SknwvRHhCTYWCvbI6Tx+k9+9Ob
 Ks5MV4FxXfPyxWzHu5pHMX73USxwZ1SBulo3MA+hbjBVZa+d5kDQBCZU7SupvDI9
 21hVY43QaGRJP+l1Szj+OfDo/EAE3enRdnmGthAUfvgga828l9FIYbnB/FHXigxB
 +jwuilp1Dv8DhhwYrYH7P6ejgk3CqxWi9gu4ppfs4in/04ApF55G2JFLi2l25QG/
 OoGmrOq1I4YZzYtynyTrjDyQjd1YvB+UwyulK0v2b/rxWBk0kVhHgBptouFdvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tvdc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 20:56:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RJdXd4024640; Tue, 27 May 2025 20:56:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j9sgun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 20:56:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54RKurI0003524;
 Tue, 27 May 2025 20:56:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4j9sgu0-1; Tue, 27 May 2025 20:56:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] vfio/pci: vfio_pci_put_device on failure
Date: Tue, 27 May 2025 13:56:52 -0700
Message-Id: <1748379412-150475-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270176
X-Proofpoint-GUID: 9PL77Kj5StpSrcGhiEODWiS_PoGFuez-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE3NiBTYWx0ZWRfXygLv1NzbkNiB
 Z1kbIz/Zc0F5wSGJuv/Twgq9Zvjh6+F3HkSYAHZhJjZM0sh6Qxmd5ZpyanCxF1xcOgdz9Fmx7+A
 vyi/xLpU0zucAfzed9XikS6p+SRJKEM5E1VSeqVeC1UKilHo+FvyNx+wWfYrNRA000iNsZE57Qc
 NqZbiuMqq+n7vq90G/OC7QS2DGtQ4A5TLl7iN6AnbGqo3A4pudIhiyGMpnlBO9IOHVuVbaUtuSL
 MnzGP/uJZotttoHWWzvxMTQt2ngA9I98vaw03w2pRNGXqCpf7CtEddo9s7uar5GjPZRgTQk4Nut
 cfE7WRh8SW0FTaS1n1zI8feo4INAz4rfS/xqv/loU/yafgoeI/huj3X+mEkQBV4ffTnFquNZbxX
 TavygCHWWFBi7vox6qa2dQhl55YVKVSnt68JFCUTEJK8gVqNCh8t4AGbw2r/ABBRuUZvfTJV
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68362717 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=eD10S8Hqz9QlufsINnwA:9 cc=ntf
 awl=host:13206
X-Proofpoint-ORIG-GUID: 9PL77Kj5StpSrcGhiEODWiS_PoGFuez-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If vfio_realize fails after vfio_device_attach, it should call
vfio_device_detach during error recovery.  If it fails after
vfio_device_get_name, it should free vbasedev->name.  If it fails
after vfio_pci_config_setup, it should free vdev->msix.

To fix all, call vfio_pci_put_device().

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe..7d3b9ff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3296,6 +3296,7 @@ out_teardown:
     vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_instance_finalize(Object *obj)
-- 
1.8.3.1


