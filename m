Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E87C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis1-0003yh-HV; Thu, 29 May 2025 15:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0003xT-Au
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirw-0000Bw-Av
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuZB009750;
 Thu, 29 May 2025 19:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Ea+5EYi8Tx/9RZm/d1wDYlyZ2nDP47w8FHLAWrrkJ5w=; b=
 q6y2zFnJxARhM3h1ZaC1MgMKzsaTcyNwk/VfGlav61b7zvs/8kltqNlMeIuIQLMf
 c9xsM0P36fBoN6DCSNPhR4VZtctrY3Xc+7N1fJ0VNho2BFp4wdTRC51J8kppeAg9
 Sn7mxRbYVAjZv2xaSov7LTZL28SXmjv0tQsc1XAkqNHHjel6pc6k4Z/EJbfA46Pf
 CNvzx70qv4gQNHKTfOEQixujtEPYugBWIW0RRgw19YTX8BQ0sVTQUWdkM+QV+w0X
 lT3wEkNvxQ4kq6KKsRS1CY0jK+6gd8hwRUJkSfW5rEIiN4MVDdIKkaf4Jw9K1IXY
 0D1k1lPTG3o9CBw8HfVlfA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0ytt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgPjo020337; Thu, 29 May 2025 19:24:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQt022158;
 Thu, 29 May 2025 19:24:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-5; Thu, 29 May 2025 19:24:44 +0000
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
Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Date: Thu, 29 May 2025 12:24:00 -0700
Message-Id: <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 3dMEcp5MNlMgw9l3f-v9RKACLYHGWAeE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX9h4n0s4FTDRL
 P9kc5a1Z0kjbPSpIrxbGba/GYK1deqtXVcwKf5oGQxIuRdmveLVprQE3nMKbYE8shzXfsMCSa4V
 K5HKDXFhRCGj/7kTB/cs0Hx1jm8jBZoa0jhUTsJeJoWOAiRDuirXIEAVAnXrjMW8vvPGm8cfjKo
 rJUSqW8cFDFeN+R7QzaxhspvJwlW8XAPWuHYube0/pQmU4SSX7eYAwkWBdaiIEEISoTfX/EOWbG
 dLQlwiyzwoTLLZ6pfudWsbSDArEEP0mGU+ZYh1vqyJ/G/vjA8PRuCdusRbMBZVFF2pGAET7HIjG
 JwQ5dENTexFaiPwils1iEEtgZRk5Bsn7cM2ZqkoA/03qR4OwgucF2iFLuFGGNTXrF01x9kODrsj
 QWMs/zY+RD3Y6OZZLklEEqCaPhNRj8Rf2L1ZOnXNqfaFUH8fz/yc9wKI2GP0v3PTDFXZ0FER
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b47d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=eD10S8Hqz9QlufsINnwA:9
X-Proofpoint-ORIG-GUID: 3dMEcp5MNlMgw9l3f-v9RKACLYHGWAeE
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

If vfio_realize fails after vfio_device_attach, it should call
vfio_device_detach during error recovery.  If it fails after
vfio_device_get_name, it should free vbasedev->name.  If it fails
after vfio_pci_config_setup, it should free vdev->msix.

To fix all, call vfio_pci_put_device().

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe..7d3b9ff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3296,6 +3296,7 @@ out_teardown:
     vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_instance_finalize(Object *obj)
-- 
1.8.3.1


