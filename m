Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D8CC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27L-0001ym-3u; Tue, 10 Jun 2025 12:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP159-0004MA-Ij
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP158-00069x-2f
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXfHi007049;
 Tue, 10 Jun 2025 15:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=AHfRRIyR8YCML/A7SHtFAv/JqCdZ7sYkJ4qx4/ujCDk=; b=
 fBIgy8/kjhR4YJit9JQPDdm2efuZEi7nwnADf9VeISdQCeoIqTdIFM8rUcOBt/DI
 9sL9q1dWju+K/YVxWXldb3WfArMQrTSRsZizCVUVj6xCUaOTY8yaDJBK/aw1fqB3
 VI7g9+7eRkNTXTFZ8V98JxVLkBRVlDpHojLR4er169IJT/gCzucEcFTXOekaAJUW
 is++t+XUNLYdKjlJkaE+ip2/JfCpV2VmPekahdHMEJF/ZVU2xu+LPjlU24HefY7n
 bw/GR+h38a8gRyqgJvMHXMUj+4TCYJOfwhjKocfU9ZdVH/ECDXZtVVQhEqxFzibD
 Qdoq6ED8BPcMZ7X8jKQMSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vjq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF52Br003304; Tue, 10 Jun 2025 15:40:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wavv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfP028825;
 Tue, 10 Jun 2025 15:40:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-10; Tue, 10 Jun 2025 15:40:06 +0000
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
Subject: [PATCH V5 09/38] pci: export msix_is_pending
Date: Tue, 10 Jun 2025 08:39:22 -0700
Message-Id: <1749569991-25171-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684851d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=b0qJq_d53OdcEBA1QiMA:9
 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: _M6xzonvey-zl-LWdhTMctvtJD-2S7Jj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXxw6CuD1Oa5rm
 n//2fA82HyZVoU0w1l7bZWL+2je0Cc4ta3dybogFD4esFxv97G3nWrC6qFYDo1Nv7/ODfNbt67g
 xkIELX4jQfzwM3cWRoahARqWfpQf1/dfrzsVYWSYkalpY4tpuMFrTkWqyOjsMBXBvVWMUZe/Cn3
 VDlEaN/1ibVohlwYhm6EIfSlLEPj9+9VxJufBor/9clBO6Ee1QAnvJPOjBtd+Djk4OAJu95SFJO
 9UsdkZjnudujff7NKXgUSpHtX5NodJ58Xz0Hs3PsihDOii2VuXDt4SR9xgqTn9OE4Ukgwpiad0T
 qy7iW9qmeYtk8TeeNn/s/towZAYSSmL/f6uI7UMUc/MlIDJxkwtnNnUzczzQ2xMcH3dVxwYkPuz
 sosW8jnMv/JM6Rkq04bSz7XN0gGh50EJEsGswt4HFmv1j/9sN0c9Jpdui1aKiVO05PSS7CF6
X-Proofpoint-GUID: _M6xzonvey-zl-LWdhTMctvtJD-2S7Jj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


