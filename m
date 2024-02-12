Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1D3C48BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWoO-0006hq-Ju; Mon, 12 Feb 2024 08:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnz-0006Uz-UP
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnu-0007CE-7n
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDJ3vJ031397; Mon, 12 Feb 2024 13:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Z4wJsEWEuirpA39vjBbD+wxmAqgUzY7zQonrdlIZMp0=;
 b=D0LZcI4X5FwSrWHrFZGCkrY1Yq4aoh4lIqCJEGnniWiLlOJV4YkCJ/u/xcDi7RPZn7r3
 CEQni9re/bmsxDlqmJREYVuBcWRE+awuioFoFZiAWn6QRwBSZDB9Evnq+yXGYBSS6auk
 cnu9vPmcoILq5KgWaL8AX4C0C8XII38XeQqmwzKpjQ0vSc2XBvCXBkotw37PRfT4gN85
 pUMq/fRbIUX5sb/C9YPfIhnS3mZ8olK0op7ozOvgeNARO/hcJ8iM+fpV2HdK2EBuu88i
 7ce5udTF8HDP7m392NFqZ/fmI3Ia4c7TZb3g7lP8Wit/jH+h8nx4MUohzCMJ9TzanJ4p aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7m40g31j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:56 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CCI70P024614; Mon, 12 Feb 2024 13:56:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc20tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqi5026744;
 Mon, 12 Feb 2024 13:56:55 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-2; Mon, 12 Feb 2024 13:56:55 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Date: Mon, 12 Feb 2024 13:56:36 +0000
Message-Id: <20240212135643.5858-2-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=698 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: fOwN1-OCnkvPzw8JFyjK-UAepyoR-rAy
X-Proofpoint-ORIG-GUID: fOwN1-OCnkvPzw8JFyjK-UAepyoR-rAy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The new helper will fetch vendor agnostic IOMMU capabilities supported
both by hardware and software. Right now it is only iommu dirty
tracking.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 backends/iommufd.c       | 25 +++++++++++++++++++++++++
 include/sysemu/iommufd.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index d92791bba935..8486894f1b3f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -237,3 +237,28 @@ void iommufd_device_init(IOMMUFDDevice *idev)
     host_iommu_base_device_init(&idev->base, HID_IOMMUFD,
                                 sizeof(IOMMUFDDevice));
 }
+
+int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
+                                       Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .flags = 0,
+        .dev_id = idev->devid,
+        .data_len = 0,
+        .__reserved = 0,
+        .data_uptr = 0,
+        .out_capabilities = 0,
+    };
+    int ret;
+
+    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "Failed to get hardware info capabilities");
+    } else {
+        *caps = info.out_capabilities;
+    }
+
+    return ret;
+}
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index c3f346976039..4afe97307dbe 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -47,4 +47,6 @@ typedef struct IOMMUFDDevice {
 } IOMMUFDDevice;
 
 void iommufd_device_init(IOMMUFDDevice *idev);
+int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
+                                       Error **errp);
 #endif
-- 
2.39.3


