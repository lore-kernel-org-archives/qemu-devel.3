Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF24C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisg-0004Hu-F5; Thu, 29 May 2025 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisS-0004ES-KJ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisR-0000Tz-3T
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfrWS020960;
 Thu, 29 May 2025 19:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=bEYut5yPtVsMFY5RaS6BuTYvgGXztHEx94DYD3YL//E=; b=
 SLIyvQ8pUEoIiULMQ+lEZ91TLFcoHh+S9y76g1LH+2l9kmIq5Cpe/TmhGPnbtes0
 ZV2vGSGsblFtTpzG5e2YCtrELR4woX8ByNrSo1wYiq31g+q7g90qrFTsYh1gSuyQ
 WBpIXhjbZnjAAaGyUrglFZxWTo9aH8OJ029u0PzVxA71NEN9mCWhc4yVwPsWCTnf
 CY9VK5Yzrk1XnW5/Ifw4WUvmHaVEgVNV1dvwQ6thwbOkrTihf8/Lr3XRPtJ3OZmZ
 kWoYFdclbdN+WJZ0oUc6fXxnl0z3KLCXjiZjNL6ZGZYdjPhG+OZwyefMRETm0CBf
 FOEsnqXAXD35hgCsqwvUPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcmwwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJ2Dhg020314; Thu, 29 May 2025 19:25:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4war-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeS9022158;
 Thu, 29 May 2025 19:25:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-42; Thu, 29 May 2025 19:25:14 +0000
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
Subject: [PATCH V4 41/43] vfio/iommufd: change process
Date: Thu, 29 May 2025 12:24:37 -0700
Message-Id: <1748546679-154091-42-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: GgomyTzIOLLmEVDRfKvL5-Klbh93kHGW
X-Proofpoint-ORIG-GUID: GgomyTzIOLLmEVDRfKvL5-Klbh93kHGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX1GCROi1cWjgC
 E+Lao+CsYc9yhSRSOajpAnxliM06GIlSG8ZWZ/Yg/bSnDx7AwxEuImv8UqUNjRMkwmrE2C4YEDd
 +2J2QrbMQsQugpQpb0ymfVEUlvFUWcJE6VVw9dw8aKwT8fNX5vmRCRkZQj23kefl9chsB/C78pr
 2A2DLjFpbgYQQq3VklFkWwSTqyGFT73Qk7RNbtcAcKtuERaUd6/sbwnxQkuJpbpUjlE7XZqpjia
 5QrQILPQDMT74xIZa3I1yphzCa05L3kGlgDGUTPvZ/78txlaK/PzL/Bxo/sJDIy78c5zvLp8LUv
 Eg7w5r1uhbvBb/VNL3ECna0vIeQkEAEfqy8rRg832Xqf/CkIzVfqeZXUQKTSUvOzlms+rrPfbzf
 h1MUf6ZIBO0P2fNfjWY0zrgjSLhc8LP/CBse95G32E3EHm/gteAWBhciefSH5T4JYk0GT2cE
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=6838b49c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=gWtQGTm9eWn5DmmnD7oA:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Finish CPR by change the owning process of the iommufd device in
post load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 152a661..a9e3f68 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -110,10 +110,40 @@ static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
     return true;
 }
 
+static int iommufd_cpr_pre_save(void *opaque)
+{
+    IOMMUFDBackend *be = opaque;
+    Error *local_err = NULL;
+
+    /*
+     * The process has not changed yet, but proactively call the ioctl,
+     * and it will fail if any DMA mappings are not supported.
+     */
+    if (!iommufd_change_process(be, &local_err)) {
+        error_report_err(local_err);
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


