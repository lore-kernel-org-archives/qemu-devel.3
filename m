Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835EC5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisP-0004C2-M2; Thu, 29 May 2025 15:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisH-00046N-2j
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisE-0000E9-MP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuZG009750;
 Thu, 29 May 2025 19:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=AHfRRIyR8YCML/A7SHtFAv/JqCdZ7sYkJ4qx4/ujCDk=; b=
 kYdXijv1xqkFqOdPlvloH3j8tkyPhYOMEno1dDcKRZ41sez8rtIJWAt0tD4jVdsq
 cDPUXmJiGABYB6caPH4BonueRKfhNGsMsQaEL33kTWHU3lEDEXtN0DM5FQeVQRvA
 I9PhyRgA8rsBw/vQa8FLDs7K80Ev3SOuHbPcKFCXnMGuOobhjsarF4TAh32aptCY
 jtaLqErpnNhlhtw1Oaiu1NtvZFyyNiEx3gFmlaem11eFYfq5SJJM3EtzGZMG9oUE
 +uTdPgTBekbn9YvT6v6wqvSsKBxhzjFXMGaFn9/eDJiUuztFUTeAnO4xJFHxNSU9
 EkofLBCpeWkRgl384wf+5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THg2av020361; Thu, 29 May 2025 19:24:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRH022158;
 Thu, 29 May 2025 19:24:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-16; Thu, 29 May 2025 19:24:53 +0000
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
Subject: [PATCH V4 15/43] pci: export msix_is_pending
Date: Thu, 29 May 2025 12:24:11 -0700
Message-Id: <1748546679-154091-16-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: lJKGOk92paCyST7ypwwEswbB391L70LJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX9O+mIGDHhK+q
 znPanX1AS5dXQqTaqD2O0Zesk2H9PFwS+7QAyPuSMAQ6wUoKU+aPPnVOQzyQGSgUpXlO1KNbYVp
 bEdy8Mkis9S9hrCfxo+yP36GVYkHdS3LE2JZhflIGRV1Yn7lHT64E3aKmk8BhmSBWqRh2g4h229
 Vw7z9R2qYwEOcgVZxodBmO9y65pZIFudBoCFfqtn2GMn4npEZIw9fFZAUZlHDSQK5+NtkRbjecD
 t7zKZF/2vDDPFavOnoLXzgGbqrdzsgQLI8zSy2dpBeafR5g+tSvzxtxxPrt+2pkOiYCJ3Pv5wOm
 pw+Mgt3QmZ8wMJk4R/mxlgWZDtt6IQ8HhMxeK8y7XJ9jZvTFJutDunELcfSITXGJIMDFsQXsAgL
 taF3t+nllkreqZI/A6d7UhwosxXjjDylfWJPzy5wN4GIHLdYeqhQqL+Bo40L1D05s74E0g0a
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b486 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=b0qJq_d53OdcEBA1QiMA:9
X-Proofpoint-ORIG-GUID: lJKGOk92paCyST7ypwwEswbB391L70LJ
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

Export msix_is_pending for use by cpr.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/msix.h | 1 +
 hw/pci/msix.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 0e6f257..11ef945 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -32,6 +32,7 @@ int msix_present(PCIDevice *dev);
 bool msix_is_masked(PCIDevice *dev, unsigned vector);
 void msix_set_pending(PCIDevice *dev, unsigned vector);
 void msix_clr_pending(PCIDevice *dev, int vector);
+int msix_is_pending(PCIDevice *dev, unsigned vector);
 
 void msix_vector_use(PCIDevice *dev, unsigned vector);
 void msix_vector_unuse(PCIDevice *dev, unsigned vector);
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 66f27b9..8c7f670 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -72,7 +72,7 @@ static uint8_t *msix_pending_byte(PCIDevice *dev, int vector)
     return dev->msix_pba + vector / 8;
 }
 
-static int msix_is_pending(PCIDevice *dev, int vector)
+int msix_is_pending(PCIDevice *dev, unsigned int vector)
 {
     return *msix_pending_byte(dev, vector) & msix_pending_mask(vector);
 }
-- 
1.8.3.1


