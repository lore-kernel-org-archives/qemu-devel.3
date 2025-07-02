Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4FBC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U8-0003VF-BR; Wed, 02 Jul 2025 17:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U6-0003UQ-CZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U4-0003kf-Sm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQpkJ030396;
 Wed, 2 Jul 2025 21:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=6P62St4kUtpHTK1LDUqfZBxBpJJ9G4DXPijOVOPcApA=; b=
 Mn7Yvo+o3nUaAosJQ/rOrfpK7EMAPy2bgrjDM2BUSvHzexQ3zgrERjk1KBGpgiMj
 xN7nGW6PF9BQSGje5EizG02Zj9/ppIiIBjBHMQ5G0716V2ODtkczfgqlo6xjVBOx
 uP28zLAGTrawGrcmRsWew81bVLoYg2AQwxkBRReoi205xdA5ZBQIG/IVvyIIe6K4
 tHL4aFLQ6J5Aw8tLb45Rpf1/Wm7rZQsjqQWNtDq7IaIBXTskoZUqrmI9uOYTzeiL
 PefT/CUqaeH0MQTmB2XkKZadL9iI1J9k8RxTtf7RsoeIFTHTr3fD2Dswr8xvRWbk
 RTFpoHBKPvdwu3fDTskaQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766fyqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LUGuu033644; Wed, 2 Jul 2025 21:59:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgU020012;
 Wed, 2 Jul 2025 21:59:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-19; Wed, 02 Jul 2025 21:59:12 +0000
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
Subject: [PATCH V6 18/21] vfio/iommufd: change process
Date: Wed,  2 Jul 2025 14:58:55 -0700
Message-Id: <1751493538-202042-19-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: TTeHqp-kpreBcW3ddZ-F5GPcPqtwM_Pp
X-Proofpoint-ORIG-GUID: TTeHqp-kpreBcW3ddZ-F5GPcPqtwM_Pp
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6865abb2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=U4C3wQu2ZDXJwwbGjwsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MSBTYWx0ZWRfX0IVLn7oggevE
 y9zBCdaUViE9cagdz2lGBtda1uWJWe4W843lpEI/v8dRWwgu9BqIr/OxCGUIKjIIdifWQxuC0YH
 9jfPIDUlSsGoluCBhU45TUHFceAQqcXp6Babi8SEmw7AJEscgCD4Qq3y2UlftZTUsIH1FcDCgoB
 dAoOUdyUV24efWADWhefXek6lhJJkr1iRNX93rGsuOolEwq2Kw5xq06i2ogxnKUT7ml6W4lqgq6
 NyBPMlaS8wcd07QgvFchWXFhYYUGOCNsNJtZm7oY6IgsQlaUcEVg1UWriMiFZBjb14iXJaiNbZ1
 9V4viS8BSDiAnD+ilncK42lZgfOXhSZG2osJ375Ki7uA8lzpTzCJZSzBodXWKY7tSX83tHyYFPe
 fCrMhrGWZGDN0iUSxIhKsOh3oRxC3OgZ1GJxguCNkUCNS8vBxOQpXdDAoJDSpkvoJMGWijnQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Finish CPR by change the owning process of the iommufd device in
post load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index a72b68d..cbeab57 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -112,10 +112,40 @@ static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
     return true;
 }
 
+static int iommufd_cpr_pre_save(void *opaque)
+{
+    IOMMUFDBackend *be = opaque;
+
+    /*
+     * The process has not changed yet, but proactively try the ioctl,
+     * and it will fail if any DMA mappings are not supported.
+     */
+    if (!iommufd_change_process_capable(be)) {
+        error_report("some memory regions do not support "
+                     "IOMMU_IOAS_CHANGE_PROCESS");
+        return -1;
+    }
+    return 0;
+}
+
+static int iommufd_cpr_post_load(void *opaque, int version_id)
+{
+     IOMMUFDBackend *be = opaque;
+     Error *local_err = NULL;
+
+     if (!iommufd_change_process(be, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+     }
+     return 0;
+}
+
 static const VMStateDescription iommufd_cpr_vmstate = {
     .name = "iommufd",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = iommufd_cpr_pre_save,
+    .post_load = iommufd_cpr_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
-- 
1.8.3.1


