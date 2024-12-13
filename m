Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F57CE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 22:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMEYg-0001KT-8b; Fri, 13 Dec 2024 17:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEYd-0001J7-RX; Fri, 13 Dec 2024 17:54:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEYc-000185-48; Fri, 13 Dec 2024 17:54:51 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfIx2021364;
 Fri, 13 Dec 2024 22:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5uxWVIE9GkIiDnVbr
 J3GtQxqrJYxc8z5vl5RzUf6LA8=; b=HxHfLGq6TsDq8uxREfaRXL+uNhZkhE0r2
 GgzuTuVMxamEGE5eiXpxqAWY8022b5ugGpezaDz8LdGJlkANbEdMXq3+Wib62bRP
 8aUzYNFm37KEDN+g7Nzyo9j/o2VWUU6dryTVWtHARm4D1DVQFAByGTH1/nr+pBIg
 ZfF7vN7L7yKr9w9+adTIxOQZg2r2tafBYsiCTXnWlKy/T2jvix/sN27JH1qxgnE4
 FM+yEtQ0RFLuFNCoDGYlyGiz2kswyK7c7ogwv4e28DgZtW8+N9k3KtE1be9gwnRO
 19iyvkR21WycDL19rL2MHrURo1a784vB2F7p9XJ4NxrM6rsPw/r/A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmd0hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:54:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDIineN007793;
 Fri, 13 Dec 2024 22:54:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft121j3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:54:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BDMsiZm35455570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 22:54:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7054458056;
 Fri, 13 Dec 2024 22:54:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F4A65803F;
 Fri, 13 Dec 2024 22:54:43 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.107.222]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2024 22:54:43 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] s390x/pci: indicate QEMU supports relaxed translation
 for passthrough
Date: Fri, 13 Dec 2024 17:54:40 -0500
Message-ID: <20241213225440.571382-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213225440.571382-1-mjrosato@linux.ibm.com>
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bc53z4qIV4312Yvgz7LWswOPZSnArK7R
X-Proofpoint-GUID: bc53z4qIV4312Yvgz7LWswOPZSnArK7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 mlxlogscore=985 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Specifying this bit in the guest CLP response indicates that the guest
can optionally choose to skip translation and instead use
identity-mapped operations.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c        | 5 ++++-
 include/hw/s390x/s390-pci-clp.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7dbbc76823..96d43b067f 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -223,8 +223,11 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
         pbdev->pci_group = s390_group_create(pbdev->zpci_fn.pfgid, start_gid);
 
         resgrp = &pbdev->pci_group->zpci_group;
+        if (pbdev->rtr_allowed) {
+            resgrp->fr |= CLP_RSP_QPCIG_MASK_RTR;
+        }
         if (cap->flags & VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH) {
-            resgrp->fr = 1;
+            resgrp->fr |= CLP_RSP_QPCIG_MASK_REFRESH;
         }
         resgrp->dasm = cap->dasm;
         resgrp->msia = cap->msi_addr;
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/s390-pci-clp.h
index 03b7f9ba5f..6a635d693b 100644
--- a/include/hw/s390x/s390-pci-clp.h
+++ b/include/hw/s390x/s390-pci-clp.h
@@ -158,6 +158,7 @@ typedef struct ClpRspQueryPciGrp {
 #define CLP_RSP_QPCIG_MASK_NOI 0xfff
     uint16_t i;
     uint8_t version;
+#define CLP_RSP_QPCIG_MASK_RTR     0x20
 #define CLP_RSP_QPCIG_MASK_FRAME   0x2
 #define CLP_RSP_QPCIG_MASK_REFRESH 0x1
     uint8_t fr;
-- 
2.47.1


