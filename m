Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093ECCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q5u-0003y3-Ed; Thu, 25 Sep 2025 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5h-0003uJ-2K; Thu, 25 Sep 2025 13:49:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5X-0008Kg-1m; Thu, 25 Sep 2025 13:49:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PG4mXG030517;
 Thu, 25 Sep 2025 17:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=h5Oc3f7CeW37awS+w
 spcvNS2uIDgLPoWE84YDze3pxk=; b=KeRyoF1GWhdQsIDGro4abcQBK8fVwPXyI
 SEcjESbLFR6Pz6BOEzXDUwcOpQIUqEPqARl32p/1+2PCEem4CBI5ZE+6paW50M6m
 pgzxWa6A+uD51kWM2rWHbEb/J8UO0wm0yz28Rn8J3PmvST/qdUeEHB9W00oz8xi2
 91+CXqqchJWGt/fpJgAUEdXrOQNFXXQmD/H2k45Mr8/8ej2qaUU2NRYheabRCIGL
 Cjliby2xwMpqC+Y/xVPpm+Wi1jfvtrbGLBojqjl5sMCAA4HTMc9wFl3yuhWE5GjF
 vzewzTuTPbyVUqkxts9FFRVJUs+DUGfgEQ8F8+2r9GbbwgkzrYEgw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyxhjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHGQu2030370;
 Thu, 25 Sep 2025 17:48:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1f28g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmsio21758576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9C3158059;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA5F58055;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 1/5] [NOTFORMERGE] linux-headers: Update for zpci vfio
 device
Date: Thu, 25 Sep 2025 10:48:48 -0700
Message-ID: <20250925174852.1302-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925174852.1302-1-alifm@linux.ibm.com>
References: <20250925174852.1302-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d58088 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Ef7EkEwsYO5O5uvjYS4A:9
X-Proofpoint-GUID: Ps9FP8G_g1sbJHBvjpQX2JV8zfPvhMVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX9msAB8oYF4jK
 sPrLWG+I2P/02zb9uIQANLZ9c3KFhYCp6IdrityYDjysgh+pD/tOfnyzmZ5wiyjdTxQ9rQsMq/h
 pYQJcWF4GICL7zRhcp9qAp9vvy38sU89DWFa8/24iw4zM99TrbGqs23StyNkxtAIfLT0UTk6MH2
 5ZpDzceqt5PlLQ5RLwvHQvXve9V2Qv+nh3I0HdQJVP2K2ePujK+rFzNC8dp6XvUZ3fb7rtkQsrd
 b8kRCzvdWqyY3eke0WGM5JSqhd+wisfa3xHPX7lXE/b6zlNz2VzUkptAnknaac6lGw3w38iTw+b
 FgLEtnk9zusQPwfv+hJDj7j7UHgVaxkE6YeMGCG1mV6bN4iUa3rirg2KHkl3i96rs1TLG28QQib
 5Wn3Kc+r
X-Proofpoint-ORIG-GUID: Ps9FP8G_g1sbJHBvjpQX2JV8zfPvhMVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
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

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 79bf8c0cc5..2918080ad9 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1468,6 +1468,21 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
+ * platform firmware and notification to operating system is done by
+ * architecture specific mechanism.  Exposing this information to userspace
+ * allows userspace to take appropriate actions to handle an error on the
+ * device.
+ */
+struct vfio_device_feature_zpci_err {
+        __u16 pec;
+        __u8 pending_errors;
+        __u8 pad;
+};
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 11
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0


