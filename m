Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B516C10AB80A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5q1u-0000G6-Ux; Thu, 26 Mar 2026 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q1j-0000FP-J3; Thu, 26 Mar 2026 15:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q1f-0006rB-Ri; Thu, 26 Mar 2026 15:05:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF4H7L1516773; Thu, 26 Mar 2026 19:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KjGRoqCMbHnrP2gt0
 m8HYDFhtQnVbz7bSENElLJnbqo=; b=sBlPAM05dVtfSogmQq3LT3J/1RhkVzuLR
 l2N2JyFqQgajR1lANuwzEvmz+10yZTLSbYIwfxxCKHfy1NWf/NrEk5vvwsJQEWim
 XGsHZwL4h6c/tHY06xP1DGGo3VlvTknBqQuIQhmcvR6xGlHhvcpYkvtvbu5/lzAj
 hzL4Ym6ac/GKy99SGf5Sen2NG5kuAcd7stXUCDo24YGDOfSRPllkfvRZ6OFMWBtj
 qezk/JZHuhxjDM1OezDRukjpVQa3QkBd4Fc/n7dwHf+BhkPc4BHjeKB3/HoEgKed
 NyzmIP9Myz4ekXrNSb0EUItwNGOzLpBJmq96ZV5D/usfzqGtaYiyg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa6t6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:05:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QIlIvw006009;
 Thu, 26 Mar 2026 19:05:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yvexp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:05:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QJ5beB40436032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 19:05:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A564D2004B;
 Thu, 26 Mar 2026 19:05:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07F4720043;
 Thu, 26 Mar 2026 19:05:34 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.9]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 19:05:33 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/2] ppc/pnv_phb3: Error out on invalid config access
Date: Fri, 27 Mar 2026 00:34:37 +0530
Message-ID: <20260326190438.734239-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326190438.734239-1-adityag@linux.ibm.com>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pdhJ62bkmZ8g4ZycpfHrn-NLKcwYBDJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNSBTYWx0ZWRfX0XTT6+MrxmgW
 bo5DyPPJBLZMPS7RA0YQMrxSCU/i16IymnU0Ubp5GWcT9UvKl+0KtDeJ6DUuGanKwFD8QTTqNKK
 41zGn4ljDaR8h6gQ6XVUw4sR2Wr8sLqExaLOBC4s3AmzTYBRDl0hVUs6Dl49HOWPa/C9NCTLKQg
 /NUufeVDSpvNDBASkgW3bFbbsP/6wPjKCE6jr4Vb6XquyFR74+ck5TbWum9CS57QAvdnf4sNZ7z
 8jDL4sDF1gN2Q2sH7TkELNXYBRCre2lLux0SbLVz1R/h/LCmpVtwZ1pqQgpcQB/es+Y1Op/pAig
 NzzWb1VmuDW2xiTFIbH+19OFgxtkO4necucHI3kkY8KfMdYTvSqRUlNgOs81FhLQtmBdQcqp9zZ
 qjANs44tOiNlYtXiI29XJDoUEhgjiQNd+3L3D5lRG35jeaAwaYdFuBSVZsV1YH7unwVc8LKdAyg
 iy8Riyo98FbrK2rWKzQ==
X-Proofpoint-GUID: ii_VIQoQfjUuCBl2VYjjeNLVd4tO5ixJ
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c58387 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=x9OATstFSDA1Japifd4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260135
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

PHB in Power8 supports 8 byte registers, and hence the ops structure
allows accessing of 8 bytes in 'pnv_phb3_reg_ops'

Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.

This when called with size as 8, causes following assert failure in
'pci_host_config_read_common' & 'pci_host_config_write_common':

    assert(len <= 4);

Validate that size is <=4, before jumping to pci_host_config_{read,write}_common

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3334
Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Fixes: 9ae1329ee2fe ("ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index d6ab5153374f..4ffdb4ce31ae 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -475,6 +475,11 @@ void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
 
     /* Special case configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return;
+        }
         pnv_phb3_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -597,6 +602,11 @@ uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return ~0ull;
+        }
         return pnv_phb3_config_read(phb, off & 0x3, size);
     }
 
-- 
2.53.0


