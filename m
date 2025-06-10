Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D6C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27g-0002g0-Uy; Tue, 10 Jun 2025 12:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15G-0004OB-Ee
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15E-0006Ae-2u
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXbag030403;
 Tue, 10 Jun 2025 15:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GBUkMsgrfUrGFHda2ru83aAzWf3Wx149hsu/w4s+a0I=; b=
 Rup7lSs4SnKkW3qtukVOVhIrKNP5R9F3msUskMLEM0eTByTVojkqvTA1G2MzK8p7
 1QQPgSU2qhosVQq6YmW4jZppDt1gQzRtH0zAsumbcQO5Z5TA6wg5WVEJlssOja7U
 v3DYo3snoiuQgy387D4+5lQwCgSJY0B+IftFPcRMcU48Fvh03nxjHPmk0lPvWSEa
 kGslveeAzMEOVmh8wQKqoGJtU3VnzHHtJ6Q3Rkr8IhMJ2hQccKWt2vDpY+q3EQp+
 6CMKMv1B0d90W7JXvJ0JAn+xM/dXrEP6aea9GbGW8rd93mMlYXPxnY4Co/4YSQgU
 +9gBleJx6eG+qJdqLJ0AUQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEQr8n004067; Tue, 10 Jun 2025 15:40:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfV028825;
 Tue, 10 Jun 2025 15:40:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-13; Tue, 10 Jun 2025 15:40:10 +0000
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
Subject: [PATCH V5 12/38] vfio/pci: vfio_pci_vector_init
Date: Tue, 10 Jun 2025 08:39:25 -0700
Message-Id: <1749569991-25171-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: gisKOU4OfWn7FzX7hcF9mLtie4MX2IMD
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851dd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=PtZ4Ye-5RDd9JDMWK00A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX1dCyHQqpwt8D
 gCjUsOLY6Zw/GpKACwPtVA3LWS239bFbHoGoOEJUgFC5bpvQdt5prQJGGGmLbnXKcRiwZjghPiV
 qORo8F+CNG+6cimH9pFC+2p9Jtr+4JqIgM4PS2fWuCr4/rTiek/dRGgAAK96S8bE1hyqChWct2B
 j0K2XBWC1NwVw1ewb11c7kuAOtPntFZnikUNn+7xw/hqke3rI9OaEd0dzeJnyz1bXwuYLRUT1Hk
 XvBpSfFgEfk9CArBsB9uSY4YYHpp2erC+1z3ITy5lj/D+SaFfyLCK2ocfMjIRAWLkwlOhEGDboG
 2mdXb7v0rdXDX41+Pb5el0hIWrZEBvUYyRqdeSQgG56OOnC7ju1uzNfJVUyE9xT7QNy3+Eq9QGq
 bgBT8nfUm9xl0/WlbjZcEzNLbRB4UodhZDLcrXRI5CSUuXUerDL34PHdrT8kYp4/0KBzCnEP
X-Proofpoint-ORIG-GUID: gisKOU4OfWn7FzX7hcF9mLtie4MX2IMD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Extract a subroutine vfio_pci_vector_init.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 67edf80..03630bb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -531,6 +531,22 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
     }
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
@@ -544,13 +560,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
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


