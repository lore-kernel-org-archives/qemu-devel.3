Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA8EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95ND-0007hC-8r; Tue, 22 Sep 2026 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mn-0007af-MM; Tue, 22 Sep 2026 14:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Ma-0005vr-QN; Tue, 22 Sep 2026 14:37:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7FZC1129627; Tue, 22 Sep 2026 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0m0WUDXe06nwq+OXo
 7togFOkqAO12zTw+7OtM+Ejk2g=; b=nE9+Qe8yn4qACWG9tP/iq9sugJHulO43F
 fmvb7h/5AtC1BWwfjIQFJYF+hi9WJF5dKIw8pHTgSksaGti/xyX5jvpYb3rgi/S1
 2XQou5CZ+VGUO03E9qtsxLwlJhjQGrR7JIjJc5sObJtX+3bEhNoyut6np2KJhbDW
 C8JfbaA757P9WyP/1DfYWRRgges+23e56kKntTD5JpsWvjwlWVk+cHJjxmzCVzR1
 7cZlojUyRA5WPcBkWo+8wSWtM6iIBp3vT4eHzEHnl1GqhB2fy+CAyaG8m0VXBv9T
 Vlt0vwe6boKHPXctKmQlIPnifRaaItugl86zPQ6Rf+n+Vdcg9uB2w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2fety-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHWi23239737; Tue, 22 Sep 2026 18:37:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gtxpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIaxUO49742230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:37:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D20EC58052;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D4C158067;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 13/16] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Tue, 22 Sep 2026 13:36:51 -0500
Message-Id: <20260922183654.798470-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vYkur0y8txIkAzXjzXJ8HV2Nkm_R1uWX
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2cace cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LipbnPdcSf65HfI7a3AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfXyoS/83L1anj7
 fYngH/8+pJM0G6HdmrsYePEtoNzK4b6kbdCMmrZaKdab1lQAhMsosRWn+0+H1n+ekBoeEDBtmNd
 6xghltJMbX8nZ+rY9fc9hsp9O58e5nRfn0liZQuNAPpJ/P16ZvoxQVEze9QCqdPCyE9E5RubOfg
 /U0PSVdCF/D8H0pKCCGoyiPgvKRdw+V86evUbJvZf8OEzx/1t7WcvRllT0zLaCQeMCy38hYP0mO
 kfinvp3Wxqsx8kAhB3oMLoGhkAJmy4nFPc5Vo7vU0s1SchF1B2rD6gWFeTfmzLpQts4PLXXD/I1
 nIm/1xhd0e3jE8AlNhgSHchlbDwplHxvaqqxjdDoTHYVPgfHHuFGsxKe/cW+lGdeFPJ84zIBaWn
 3gJxg2Sl3jyzPftkA/VdONrdzaOpAELgdvIynLs2zMyEvdbGAyyA03mYhRbSWf/pjNoRRQeAlfY
 H568xGj4RxM+3Vb6nOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX5MhIyR3zVaJ/
 oD2GvQLcWYe82sqF9BKgUvq4QmTV2aKPPcHV03Y6D9pYiG8hg+PplQJar0yoibIY3z9ugBM54xT
 pC2/9PpA5PFa13MLdpVDWM3qK0nUx0Y=
X-Proofpoint-GUID: vYkur0y8txIkAzXjzXJ8HV2Nkm_R1uWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220273
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that S390PCIIOMMU had been reduced to only the IOMMU container
information needed by the PCI layer for the associated slot, add a
comment explaining the purpose of the structure.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e3cbee2695..0a59be1fd0 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -271,6 +271,14 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the AddressSpace for a PCI device slot. It must be
+ * allocated before PCIDevice registration completes, specifically to satisfy
+ * the get_address_space IOMMU callback invoked by do_pci_register_device().
+ * The root MemoryRegion is otherwise empty; DMA translations only become
+ * functional once the guest configures the device, at which point
+ * s390_pci_iommu_enable() registers the zPCI translation subregions beneath it.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.34.1


