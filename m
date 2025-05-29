Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9788C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisw-0004cl-Cr; Thu, 29 May 2025 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisW-0004FI-0D
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisT-0000Rn-Jw
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuul022092;
 Thu, 29 May 2025 19:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=RAS+UZC/WGBW5cnJMIdMxQqfQASxRnZ2idO9jx4/bnU=; b=
 SsVi6vc76FREQQYBCCAl240IYGq3AdxD/x/ln2qSaxUtSsrhFssL3ZnJvy9+sANB
 BSYBa+ZWD8ZKX4+6c+0yc+HSHDXeudxKfH7Fl5XaHpAxg5qGUm7vuBT4gA7F4bTD
 /bho1Q41KCBkuLphQXTeF0uA50GK5S6enLYnuDHTGst8DQY91HmAeRdXwKqBGTdR
 7GcRLHZXaH2LmQEfF5Nr0RJ4IilAQ3OsdPV3A7wWheWh9zqNzCdXZ/jPaU3Gp6wK
 hvX2bHxHIWYUSzCtoIMb/zxR016LYG7yFFQliAIKwHOO5ax5JdRn+ycQKcKM+/tx
 qGxxAwEJLsZoJbHg9JoBWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgPjx020337; Thu, 29 May 2025 19:25:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRp022158;
 Thu, 29 May 2025 19:25:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-33; Thu, 29 May 2025 19:25:06 +0000
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
Subject: [PATCH V4 32/43] vfio/iommufd: invariant device name
Date: Thu, 29 May 2025 12:24:28 -0700
Message-Id: <1748546679-154091-33-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: jkLymqR4VJId90nizxDALZIEQo08jTq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX/HTHR1zQQZCd
 u6vkim5jbZrTAtVmoPUuEk2MFOEsnkke0ckOMMdOZm+Vm5fnxAYiX00ORFZci+698dIOWsZkDqj
 lsdQqg5DwHTW5cJfHnB3R4uFicA6wP70+6OL9LKsWM3KE6EWfpuKSvH4PQXpL9bVg/aO2Ja/2/N
 0XgsxNojwXfe6/TQUzaT6mz4hEJXTLB//vdhi3euS773BH3fz3C5kdyR05ZhZkfpvRt82oBbfYC
 vewM8AuHn44FiECsDFWHMaKWTPRj2mjw8pJqhWIWucVW5XnBxgA+sklQXFayV3TDx8jpfsctCD3
 fC5lyAJk9krLRUaFDaZ/tVdIKqcX2t4dq0zhHWZMRssSjBqiuknipRMnIy9xowoD55/y1Nx5EyP
 wL2/aJJ4U+GvVg0Ro+9Ez9UQBidT4LrECkJVDbQ2lQHzVcXmXmDIpT+IwbWLJK4svPwauBAm
X-Proofpoint-ORIG-GUID: jkLymqR4VJId90nizxDALZIEQo08jTq9
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b494 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=3QIz5wLK-XFPp17kOLYA:9
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

cpr-transfer will use the device name as a key to find the value
of the device descriptor in new QEMU.  However, if the descriptor
number is specified by a command-line fd parameter, then
vfio_device_get_name creates a name that includes the fd number.
This causes a chicken-and-egg problem: new QEMU must know the fd
number to construct a name to find the fd number.

To fix, create an invariant name based on the id command-line parameter,
if id is defined.  The user will need to provide such an id to use CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/device.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7..71fa9f4 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -300,12 +300,17 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             error_setg(errp, "Use FD passing only with iommufd backend");
             return false;
         }
-        /*
-         * Give a name with fd so any function printing out vbasedev->name
-         * will not break.
-         */
         if (!vbasedev->name) {
-            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+
+            if (vbasedev->dev->id) {
+                vbasedev->name = g_strdup(vbasedev->dev->id);
+                return true;
+            } else {
+                /*
+                 * Assign a name so any function printing it will not break.
+                 */
+                vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+            }
         }
     }
 
-- 
1.8.3.1


