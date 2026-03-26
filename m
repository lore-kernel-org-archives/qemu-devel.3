Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B3D10AB80A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5q1y-0000Gx-7p; Thu, 26 Mar 2026 15:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q1s-0000G5-S4; Thu, 26 Mar 2026 15:06:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q1f-0006rT-Ss; Thu, 26 Mar 2026 15:05:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QAnh5a3792418; Thu, 26 Mar 2026 19:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TmM46Lo3kd1WIaZix
 fJwNiMON3swWRzxjwlFnBItCyY=; b=qnCt8KJzdNV/pXRSgdMyAMKthESb1yPqF
 AhVcKnSTeFTuVQb6HHzygD++viI3Tp0Ab8N+wQ7nKZWZwzgCM7xzR2K/Dr80Au/o
 P+4xwTp3bykoMbO8/gOeRDyPy4LbbPFm7BUJVQK27XJLQSmpYgt9aVdnyCpbGifn
 dCsdpuKl3KvCx7VL4oTjfYCkMDd3+4O8W6KQxAk+8wQ6Q15cNj32m7RcntjWzluA
 FBZOpNE+AmnnDnBBocMJ5WNjBgVHCxS0RNOnAiy6HT8zrgduWKSevhVEkbYI493t
 fC/A0adPVacOs5Skz8tAnLc35b6fQ5m/expnMPgaENxUsTyfBy4sw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqpukk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:05:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGoF2A004392;
 Thu, 26 Mar 2026 19:05:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2c368-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:05:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QJ5iUW50987452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 19:05:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 914FF2004D;
 Thu, 26 Mar 2026 19:05:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CA6A20043;
 Thu, 26 Mar 2026 19:05:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.9]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 19:05:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/2] hw/pci: Replace assert with bounds check and return
Date: Fri, 27 Mar 2026 00:34:38 +0530
Message-ID: <20260326190438.734239-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326190438.734239-1-adityag@linux.ibm.com>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9zjOGUx1S_KgRM9w4eHfVZTnLEhuAQqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNSBTYWx0ZWRfX13NfFT4ma9Jn
 VJPUIHHxgRMm1VZD5kGJ4KfOcvht/YSp/txrQtqv5461nXZNgceLtqz1L9d1LzUEIlv3sjYYZKO
 wZSgNgjQhowe3MH9NTOlaa1okWunHBKA5oxINt/gaQtC8SiBC8nm/xLREeAC49uQuoF/404QxwK
 OHFt2nv3ETWTlJ6KczYlWt2eJdqZqa+mL60xqp1peyavWhTaFPO1LMU2ODjKx6y7paPiw+BpYVg
 Fb5lr1xcgWiUvLipstSqN9mnXxxlf74xoKZcgR1ZOn7E2UQh2Sd5vjg/3q9U1ypP7F+/gDtimhh
 pinUI71wNFKLE3ySaZ7V2gT/QytT0MzXPoGODifo6CyJpqllCc3ljsX2hEdEC7Ht+OHq6vsDhdz
 bMr5ZoXtXLMqRQTsqhaHrw3gy6IWOs2kRhGP2tF3qasXJWMOtdT9PyoYGT+I3P6+pCESNjepluC
 s81BIaNNJS/0I0OmZEA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c5838d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=S5HtyE1eDOxyD5dW7SoA:9
X-Proofpoint-GUID: tlL83mH6BSkgNrdfH6sWHEJhWYI07bfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As reported in https://gitlab.com/qemu-project/qemu/-/work_items/3334,
callers of 'pci_host_config_{read,write}_common' can pass length as 8,
causing an assert failure

The original issue with pnv_phb3 triggering the assert was fixed in a
previous commit

Instead of asserting on invalid length, check if the length is valid
(<=4), otherwise return (with the failure error code in read)

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci/pci_host.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 91e3885c7f62..2a7fdfa5636e 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -81,7 +81,12 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
         return;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
@@ -106,7 +111,12 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
         return ~0x0;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return ~0x0;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
-- 
2.53.0


