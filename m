Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C9C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27r-0003FP-Lg; Tue, 10 Jun 2025 12:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15q-0004Z9-2A
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15l-0006EY-O3
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXa4c030382;
 Tue, 10 Jun 2025 15:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=O3VLriqVbQ/sWk8NYf1yHHDv1F2bXl4godNFuET/p74=; b=
 EOcdwFzSsgsrjX2rPrm+QLXuZfSmCmmpSZvntRmtR+txPxurw/gS+iQR0Rb6e5Kf
 Sp6r59uhrI/FF0iucoEMWxR/ZTvMEhrLZSRpQaWH8kv0mEutlGQg80hjzUNAl3sH
 0c9wCxlt1fzZGy7pVzwQ1Yc+sOgEIW6w4LsPYpEKj43v3rJVHiTIHUgOcQbUUhxf
 VWvHczxxqitE9JInqcMIYImyJ3lDYiwQDstum6FIozjRUxZfana9ubuj3br0wLTF
 7BmLfby/qC+mjIwPhEZr1G2jgHNgw8vySou+yzhO8eoEogKSeL2HL6IT4QPmGhFz
 CFPqXKf2h48iCUiSdmRCFg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AE9RH5003273; Tue, 10 Jun 2025 15:40:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfx028825;
 Tue, 10 Jun 2025 15:40:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-27; Tue, 10 Jun 2025 15:40:35 +0000
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
Subject: [PATCH V5 26/38] vfio/iommufd: invariant device name
Date: Tue, 10 Jun 2025 08:39:39 -0700
Message-Id: <1749569991-25171-27-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: OdDPwMW2FjRl0aR5FjVX73O9JYDXWLr-
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851f5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=3QIz5wLK-XFPp17kOLYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX/GMIO7NbLjLy
 EQ0AhRNwFqxyItZ/djnM/Kywe7R8bXXo5NXfgK0KUfpDuli/SlwFArwFFtApyXQMZNr+39Tbywy
 JFRtR7AkzVI+UUvDSEFMeYFrMufCxV9N8V81IWTX99HJGUdcMwKPwaa0Xm3ndnsSPUJzTerIaX/
 Yoipqt9hwNXeo+0XrGaSizze2MIMGRkJXQvIxrRJUcLxkE2F6AvnnhP2JVAejh0/E2oebmlrsYz
 oUUxx8fQle28vJ2+j7KSKVyPi9WX44F1u/gSRJN33f1LJMUMeB+PxvIeUY1/C/IvGGZ5SQ9CKDA
 KP22jqonhzD11cVUSuolMJM0AsNceZwNCAtz0jXkKtt1zCzn3Q559RkJJb1t0dKfUz1OeSSpw7n
 bcPhJyo2CVhNGecNl09Vwrjz1xKkGEeHV8aAD0FSh7PL5PxDBi/rjqGpAEMUVBcUW8UermeP
X-Proofpoint-ORIG-GUID: OdDPwMW2FjRl0aR5FjVX73O9JYDXWLr-
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

cpr-transfer will use the device name as a key to find the value
of the device descriptor in new QEMU.  However, if the descriptor
number is specified by a command-line fd parameter, then
vfio_device_get_name creates a name that includes the fd number.
This causes a chicken-and-egg problem: new QEMU must know the fd
number to construct a name to find the fd number.

To fix, create an invariant name based on the id command-line parameter,
if id is defined.  The user will need to provide such an id to use CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


