Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22008C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U2-0003Rf-QN; Wed, 02 Jul 2025 17:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tz-0003Ow-Mw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tx-0003gR-Tm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdbG014107;
 Wed, 2 Jul 2025 21:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Hac2fHfTMFJZ/DbPpUpOTHGBjrYISCMsyUYaAR+bq/U=; b=
 CsWCxwcRySf+or1fi7rKXqHlPXvxx6EQ3pYG9DGDTr4F9TjURczOutON3uhT6mNT
 5ga3Z7Iri91N8d5EE7ja4ocHkpoAA2AItr/SL0hrA6uHwaVO879DmdMXmxD/8AWN
 Jz3ZM29UbuUuS8vizb7eiFX5RcSnMBuvvrU2xd8wfSIs7B5xK1TnFadxdUqCATwW
 mvyaQiYe/r/eY2iSRRCcyk9CrLf0pSVpcbU6qxAdPn8fmhNA/I1TUdEyUMQ5HRyp
 0zHaBtzW4PWHN6HtlUC8xE1KV5aND7c2brRgq0P7UuQVhNImwtOjlPnTAIDXgmqe
 gNojzf9m/asny8OlIPFC4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fxku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LbuVN033681; Wed, 2 Jul 2025 21:59:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgC020012;
 Wed, 2 Jul 2025 21:59:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-10; Wed, 02 Jul 2025 21:59:05 +0000
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
Subject: [PATCH V6 09/21] vfio/iommufd: invariant device name
Date: Wed,  2 Jul 2025 14:58:46 -0700
Message-Id: <1751493538-202042-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX5HY8jPVZrd14
 OT6RirHFkZ38YlWfIyBJeYgGjfDsBTmUVhwBT9QJbEsxWgoq8qAgRpVF7w2kxAZTEKMvDan1lYp
 SqbuLqfJxKtIzNol+9uQvhwW+JVvfmt26d1aRbBaEtM1Ilf+fLsvbshlZpBpKT/I2Ej5jI0kKAJ
 K5DjbtDSaGujNEMi6L8h/5zz+9W9t9Re2axW7dLhgzUcmA5lnn5RtvHGuF+GBkePJVsFvOP/96e
 TZkdergYMf41nWAVSE4vt/UcT3Unyb+o91LuMgttkcdNzQYCnaIiFvwfql8zkyltPgrhEhtdGpr
 ++LgT6OsywoyaMX+zGt/fvWia0NkREEA7nCdCF/8750F2iyfIk3gITyPcgTa220Si02gguIRQHa
 r+3CLaPviRO6mWJXjMqSDHu7HaN99ITlIlJrD1la7z1jhUU375u6WMoMiCnaENDG9NJrbQ+M
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865abab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=3QIz5wLK-XFPp17kOLYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: myfNl6H1WNc05v17TEF3qTpu_uZKS53B
X-Proofpoint-ORIG-GUID: myfNl6H1WNc05v17TEF3qTpu_uZKS53B
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/device.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d91c695..3cd365f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -316,12 +316,17 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
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


