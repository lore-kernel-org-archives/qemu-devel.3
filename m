Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C89FCAC5B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q5z-00044P-Oy; Thu, 25 Sep 2025 13:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5g-0003uO-CP; Thu, 25 Sep 2025 13:49:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5W-0008Km-Ry; Thu, 25 Sep 2025 13:49:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGvuJj000866;
 Thu, 25 Sep 2025 17:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VB1I0L17tgvxsXN2M
 Mzwj2lFCLXpcy+ZiA+OwtiRdaI=; b=pA3oVE2zzkPK40yJCQTen9xRMV5PidjeQ
 Pn1UDVHrvdD84OskmmtlSRmuuYVMz1roJAzKxCtP0Pg2YXttNiQemB7CKkVvlizO
 1Ejhtqua18r6XlUX9VQwHBx9Hu8Ffn/0ELtLcGYvlN4bV/UzGDiF1BPOHu2m0TyX
 O/xbfoOjBktmEvipFUNGDymvQsBQFSLC0PyLtasiei0rOhY0YFAcA9rheHJW6AbB
 6H+l4LQzc8RXIaLxbvZenVz28SBMS7LoQvG0yb3pMYchFvE7IHofIQMwxGFTKJet
 Gz7BOGgMNnXV08+KZ2zui3OqPZO9tNiBbU82stlpnMTRZ0Cpgo80g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyxhju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGs9hu013333;
 Thu, 25 Sep 2025 17:48:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj34ed5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmtH110748494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 857B458059;
 Thu, 25 Sep 2025 17:48:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7D3E58055;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 2/5] vfio/pci: Add an error handler callback
Date: Thu, 25 Sep 2025 10:48:49 -0700
Message-ID: <20250925174852.1302-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925174852.1302-1-alifm@linux.ibm.com>
References: <20250925174852.1302-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d58089 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=2pRrx5hCKfqBIdAPaiEA:9
X-Proofpoint-GUID: pRQJT-KcmsXVtOXnWNWgmaR7iRo1eFDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX7hzdMsqmqKXb
 jYITMjw37g4O1dQodxVTvHv2Hza8SncogB2PbKzIeH5/trN67GyF158OmizAkZqFQYXX7IBs07O
 auXXgXZocmeda/AHJUXPlrKp4rof5R1ZM60BHF8lK+BBConv37evTuxdRTqt0nAAd1txPrVFcmr
 PzMwl8gvbxzSLZaehtITsod4frLz6Zh4bz35F6tqFtZ/PWyNESnoU0VkW0bPWgDjAGVu3wUeygd
 rzOcBlZ5ykCGhYoGU4Hl4nRXSLpsPvrEC+tUwl0R1fBFEGyIjOY47XEnI1Vv9kNxiyFuJRnP0Pw
 oijBdjYKpEU5uIIvyHR6QHJBHlY5Rv6fEhN3GCcxmzz4UM4nVd7nm5iJszBlt+fB/i8BZGVJe17
 ezLl27re
X-Proofpoint-ORIG-GUID: pRQJT-KcmsXVtOXnWNWgmaR7iRo1eFDU
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Provide a vfio error handling callback, that can be used by devices to
handle PCI errors for passthrough devices.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/vfio/pci.c | 8 ++++++++
 hw/vfio/pci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bc0b4c4d56..b02a974954 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 static void vfio_err_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    Error *err = NULL;
 
     if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
         return;
     }
 
+    if (vdev->err_handler) {
+        if (vdev->err_handler(vdev, &err)) {
+            return;
+        }
+        error_report_err(err);
+    }
+
     /*
      * TBD. Retrieve the error details and decide what action
      * needs to be taken. One of the actions could be to pass
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index e0aef82a89..faadce487c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -146,6 +146,7 @@ struct VFIOPCIDevice {
     EventNotifier err_notifier;
     EventNotifier req_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
+    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
     uint32_t vendor_id;
     uint32_t device_id;
     uint32_t sub_vendor_id;
-- 
2.43.0


