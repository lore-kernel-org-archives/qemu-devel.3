Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4FFC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisc-0004HV-KT; Thu, 29 May 2025 15:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisJ-00047y-Ce
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisH-0000EL-0q
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuuj022092;
 Thu, 29 May 2025 19:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=AlnXPvm/lUsAWx8Z/IXoqo8l8UtBVR3FTtkGwhwtQyc=; b=
 qNwcKAU58uns8ZtVr6/eDs4F5wGpDZZpyhycS2dZgCIAXU2eS8HvTnkYgh7CpjVo
 4SxVUmUfJKpiuBMcqzeoNbyoUpkzlynB9Cop9HLkq/xm5DOmKGEzpqoYZ6KH/DOW
 7EpyIto3gsIa4FUSiAvSnOqjqlUvqLplWHvA3QbZDayLvc5nixKvNW03RK9L8PqY
 5nRfBcdoBjyBKfQXK3gavrOQi+6UCD3/95xBhtfKrKbXf2crUpoDvjp32QycAhw7
 Bn2xJZ6dU0YpP8FGrs1EyerUxAy5KHt12ZLuJ1/oeue3TKMyLSMi/gjlCmzPZKdN
 OYw5i7AdAtgirzNBymRa/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJOd5q020578; Thu, 29 May 2025 19:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRN022158;
 Thu, 29 May 2025 19:24:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-19; Thu, 29 May 2025 19:24:55 +0000
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
Subject: [PATCH V4 18/43] vfio/pci: vfio_pci_vector_init
Date: Thu, 29 May 2025 12:24:14 -0700
Message-Id: <1748546679-154091-19-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: FS0QQtf8wpb3e80nbGtPoGIndiyMwBih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX3ytN6uJDgGhP
 ZclF5HdXZcO8ThNK8EPNwxmISvUJZ0K1aoCu7Mve07WWc6c3iuxxImpZ6v71DULNNxpo+fZJvQ7
 7PSdpySreJxC3EJ1FHjA8UEayJQ2eXXq5hJzMubQbqp9whFNDFj/wzUbqm7KhrZ3LBD6aaVCY5G
 e54SoGt7oSxnQV8ySJTtGKPZoHX3q1sb6w8SH2BkLUvuwVV4DNtONjfkh9N5YKwMDR7TdfIrNIi
 gjL72K9l4IqAZhJ/f3+Z68ltbcYM98h4AT3+wlsZ7rDPTNRIMj4EQoRLR/M+PvsHVEkkun7oE31
 cZTMY6DqIH1O1ZL6n5+P3yaLUHpLv2+uczBbLpkyRz2bTEbbDjXClAoPAWftZdYJPAECBi1cy5J
 fJyz0i79pr8ewTb/YmP4ACrhe9nbYyd1l+uBHCtA430AwNrQ7vcscy5IZ58zkGjyyewlkGOX
X-Proofpoint-ORIG-GUID: FS0QQtf8wpb3e80nbGtPoGIndiyMwBih
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b488 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Nwf4nMGaJ49SaRlp1S0A:9
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

Extract a subroutine vfio_pci_vector_init.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 840590c..2d6dc54 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -512,6 +512,22 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
+    PCIDevice *pdev = &vdev->pdev;
+
+    vector->vdev = vdev;
+    vector->virq = -1;
+    if (event_notifier_init(&vector->interrupt, 0)) {
+        error_report("vfio: Error: event_notifier_init failed");
+    }
+    vector->use = true;
+    if (vdev->interrupt == VFIO_INT_MSIX) {
+        msix_vector_use(pdev, nr);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
@@ -525,13 +541,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     vector = &vdev->msi_vectors[nr];
 
     if (!vector->use) {
-        vector->vdev = vdev;
-        vector->virq = -1;
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
-        }
-        vector->use = true;
-        msix_vector_use(pdev, nr);
+        vfio_pci_vector_init(vdev, nr);
     }
 
     qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
-- 
1.8.3.1


