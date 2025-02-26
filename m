Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003DEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOWK-0006o3-9l; Wed, 26 Feb 2025 16:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOW7-0006h4-BQ; Wed, 26 Feb 2025 16:00:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOW1-0002xn-LJ; Wed, 26 Feb 2025 16:00:29 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFLe46006009;
 Wed, 26 Feb 2025 21:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NbqYr93Q3bXeFH0W4
 Wqbh4hTroGpIYdLzI4ILZyvL1Y=; b=nDiCbNrUBiZ8WViStHUOOuTuQBk4gcetK
 oPJpL4+G6/NUaE49UKCmZTIHAaJgnu4E5L0+TINpQ9Y/b2P9zTM1zDkCkINhd5T4
 AXO5rPkg9en2Mu2/w6GsKBFQfvHX6YrqZh/90QHsYA3woFVvm/Wp97MJ2RiyHHeK
 S6rSakI7fpuXgRaKmBvpomIncMcNjdcGmKzDD10CYS+/yRVY+r8anDnFDOYnOTny
 JN+YpqlWXlEg7QobedL3DIARQdb4IL+HwaIgAOdKQQOvOMdhNM9d/fhoVsykIcX1
 9d9ttphRMRkzK8ozDsylaIp8YhOOmxlDAWpjOdKogRtO9LmToxQeA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp3u5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:00:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJYPUb002588;
 Wed, 26 Feb 2025 21:00:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jvkh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:00:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51QL0G9o17236574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 21:00:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBA7758056;
 Wed, 26 Feb 2025 21:00:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05CB35803F;
 Wed, 26 Feb 2025 21:00:16 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.46.135]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2025 21:00:15 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 2/2] s390x/pci: indicate QEMU supports relaxed translation
 for passthrough
Date: Wed, 26 Feb 2025 16:00:13 -0500
Message-ID: <20250226210013.238349-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226210013.238349-1-mjrosato@linux.ibm.com>
References: <20250226210013.238349-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vpylv8mUySqpf2XzWIXGQxzTqW4E2nRH
X-Proofpoint-GUID: vpylv8mUySqpf2XzWIXGQxzTqW4E2nRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260163
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c        | 5 ++++-
 include/hw/s390x/s390-pci-clp.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 443e222912..6236ac7f1e 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -238,8 +238,11 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
         pbdev->pci_group = s390_group_create(pbdev->zpci_fn.pfgid, start_gid);
 
         resgrp = &pbdev->pci_group->zpci_group;
+        if (pbdev->rtr_avail) {
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
2.48.1


