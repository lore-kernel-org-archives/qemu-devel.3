Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC63CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q68-000482-Gg; Thu, 25 Sep 2025 13:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5i-0003ul-GW; Thu, 25 Sep 2025 13:49:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5b-0008LC-RX; Thu, 25 Sep 2025 13:49:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCoXwt022391;
 Thu, 25 Sep 2025 17:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ryref7
 Ncbl8bVn3DfXzxZQ1S2xWXXH4QYNNJXdkY7qs=; b=MfdTW6KyofYicNbmUUGtu5
 Blz9eBvYgjoSyyCO0rJDTn2XFblJJG8YCw2ujUe/OaoHCGOHpgf5mpL4Wyvb9Ah9
 NVHI0SJWSalsIcEx5fb7z9QEIyBB7XUMF3cQnxQad3WtaGHww2huywcPfXzS/w82
 t0vsgkr1cIvprfbppcHXEBPovs/vL4dekV7pmz34KfuHkL2D3+8Qq+54CnEaYlO3
 YogmzV0o0JazCw5SGxygfrveth4eO+hgV07azxy/c+ZxFH9jj2AJCeJnd+tuzXSd
 gOoK5fEjvt67GXfZN17hMVvT+AP7PMyoZu+HxKIqy9wXBL5Wosiclfv3b/Bs09sA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkpqxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHVCUo013704;
 Thu, 25 Sep 2025 17:48:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjq3as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmu2L31392462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4478858060;
 Thu, 25 Sep 2025 17:48:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6A1D58055;
 Thu, 25 Sep 2025 17:48:55 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:55 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 3/5] vfio: Introduce vfio_device_feature helper function
Date: Thu, 25 Sep 2025 10:48:50 -0700
Message-ID: <20250925174852.1302-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925174852.1302-1-alifm@linux.ibm.com>
References: <20250925174852.1302-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d5808a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=eXa9mqf8Gm2PLtKtlTcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfXwS5F2bqHX8+O
 C5/SCRHHKnGW5zUwvqlA9M8/tNwF3cu5AQurzwhRjDXpXEWYHW5dNdjT5tLvF98tFLs7I5h5XDg
 lnw/EHcrdBjJOOId0oA6jqcaiuqXYbL9Mk4bDvXlCHNkPuncVq/Vnj8RYvBkzDtp72dmoGwqywz
 8PG4ycsnsJeQxCZKXQswmVOXPToPnJCXS4N2Spxl9F8hPD6D9yQ8PkpyZv3FZAZcoczvqMaYFlf
 kP1FRhxIuW94gTXQs4/xglJEXKLIJvwkLL75zDenU2H33sxtUpbXBfKWDRhwTfgn5mJKK7pFddR
 Lavj9sZ5j4Mbh+AslQPogFyNVVKts1m/ThdotRA47q6ahRpW6Cl9wCs5G7gcVT5nOmmZbQLgTDc
 +vIl4SpZ
X-Proofpoint-ORIG-GUID: 5oAnZZ95uR9yWwQH2OWVunrVhdfev_FX
X-Proofpoint-GUID: 5oAnZZ95uR9yWwQH2OWVunrVhdfev_FX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a helper function to call internal VFIODeviceIOOps
device_feature().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/vfio/device.c              | 6 ++++++
 include/hw/vfio/vfio-device.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 08f12ac31f..2ea2af3f79 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -504,6 +504,12 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+int vfio_device_feature(VFIODevice *vbasedev,
+                        struct vfio_device_feature *feature)
+{
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index e7e6243e2d..a7f00d2a80 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -157,6 +157,8 @@ bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
                                       Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
+int vfio_device_feature(VFIODevice *vbasedev,
+                        struct vfio_device_feature *feat);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
-- 
2.43.0


