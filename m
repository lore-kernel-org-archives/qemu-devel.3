Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CE4CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilX-000664-H0; Fri, 19 Sep 2025 17:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilT-00065g-RA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilR-0002U6-BR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtwQb009131;
 Fri, 19 Sep 2025 21:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=bN/Um
 AjHvMOqVYN8kfk02DN8xVbQeXdeInW5dizuEoM=; b=UQkVlg5YsSeYWdcucnSrl
 e+1W8voPilje0oz+YMvt4F0Xr4Ww7P6Pv7HmJtMQHVf6eOnUmpn3qrLjSYtyX2zf
 RSrM2PPHtNLFPgIzUbrufvJ2aY3RpEr2mBTMq8s86ySi2pTbTEIjU7bFc//AxhLw
 FwChQF38uUYyh8C54bVfh7zlsn4wIAsCXnMF2OVBtnMwbnSKlHspjvKG8ALo1sSt
 T6Oylt6ywB1tNHzuTdFpFq/EbOHZV8iHqJYFAjZKLTnVIw/7KRoEMBAdjQxv6Yw2
 glr6rItrUawMFQCAJLSO/537nWR9nmxMHEApmlPqslmb4QXDaWHkoLFnJceUtFUz
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb6ce0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JKd1Sm033813; Fri, 19 Sep 2025 21:35:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUmxx004301;
 Fri, 19 Sep 2025 21:35:20 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-2; Fri, 19 Sep 2025 21:35:20 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 01/22] memory: Adjust event ranges to fit within notifier
 boundaries
Date: Fri, 19 Sep 2025 21:34:54 +0000
Message-ID: <20250919213515.917111-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzSaXDd+AQs8w
 +HpzP6mLA3UU12QWrUjgeZ29meTC4Op+kSFIKNkQoX+6SM66wtD1Aqc/jMq4BI0u+rZzXH79fly
 pS936MVWnIHNyeoVpAtNspGFC12tCqtAE5ftpOvMKCO2jeoNjfFH0AklpDeXVVfS6z64q22mgXm
 B4GknQ08EssxCjHUPEmLbqXsgmWOWsN9dT7+YIcPLvq91gEshobRfwlATH4gVrhlIBblvT+rdbk
 s0tdqYnX9wzwZbkUa01X94XJY7v9zx8+UvxRqlH8Ggc4AhIrA4g0LMoXm+rUNXV97p5fLixEKXE
 +Klq9YdKWd3dvcb7nFRRautu8ZBCfAtS9t2R9so8/q/ytuWgD0y24gyab9xTdDCOaBF965Ii/FY
 d/MVtX9Y
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cdcc9a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=JiNCCaSHPG-izbK7Su4A:9
X-Proofpoint-GUID: ZWOfO7rS3VZ88l7Fdct6YonFAnv9Wqdz
X-Proofpoint-ORIG-GUID: ZWOfO7rS3VZ88l7Fdct6YonFAnv9Wqdz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
valid and required operation by vIOMMU implementations. However, such
invalidations currently trigger an assertion unless they originate from
device IOTLB invalidations.

Although in recent Linux guests this case is not exercised by the VTD
implementation due to various optimizations, the assertion will be hit
by upcoming AMD vIOMMU changes to support DMA address translation. More
specifically, when running a Linux guest with VFIO passthrough device,
and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
Remove redundant domain flush from attach_device()").

Remove the assertion altogether and adjust the range to ensure it does
not cross notifier boundaries.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index cf8cad6961156..5c6ccc5c57412 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2044,13 +2044,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
         return;
     }
 
-    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
-        /* Crop (iova, addr_mask) to range */
-        tmp.iova = MAX(tmp.iova, notifier->start);
-        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
-    } else {
-        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
-    }
+    /* Crop (iova, addr_mask) to range */
+    tmp.iova = MAX(tmp.iova, notifier->start);
+    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
 
     if (event->type & notifier->notifier_flags) {
         notifier->notify(notifier, &tmp);
-- 
2.43.5


