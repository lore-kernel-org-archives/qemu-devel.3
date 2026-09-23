Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC247C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nlq-00082w-QU; Wed, 23 Sep 2026 10:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9NlF-0007lE-HT; Wed, 23 Sep 2026 10:15:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nl6-0005xF-Qq; Wed, 23 Sep 2026 10:15:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZdYp2742247; Wed, 23 Sep 2026 14:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0m0WUDXe06nwq+OXo
 7togFOkqAO12zTw+7OtM+Ejk2g=; b=L+trrFvRoQ3yjGaQb/jVZyJGFwEJzxzhn
 lJP6MQzDo/KnAn9FIzSnUqYoBZlcxzXRW9tBgUXbof0cJ33Q/zQb4PVCwnkJQ/0U
 2YcORAk5QbXWUybOdPjyFe7x04YxNEwSlAXA655x9lp+VGryYN90vlK7w4aEyEHz
 9fYeG51EnH5lN1fkS6rBTHrUnV5hZUmgpWzxkqRIMhITng9nFYj7SVJjOQTdHbTl
 uDQg/ATlqpJ4LQn1NjLeZtdCWAQprdU/35pxlurzlmlbF1Ds55Fg5Tyfqiye14DH
 zAPJHoXszO03FAR18+DKdUT+nPcplXnbIWoyjZXHC5uofeSGBePOQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1kbwp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCtY1k005698; Wed, 23 Sep 2026 14:15:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8s78n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFWFH15336180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F50E5805D;
 Wed, 23 Sep 2026 14:15:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4B5B58058;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 13/16] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Wed, 23 Sep 2026 09:15:15 -0500
Message-Id: <20260923141518.960364-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YK7bQ-72wH56xRFWSbPQ8p12wMgFdYWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX2ZOL1ffcp5b4
 XqR1Gqu9yXCzZc+ar7XRfvbEyUgClEs65k2wtWeuO+ZfMG9KF9ozqbNwry/gjMp4Me/Y0AO5ACY
 gxy81VoBGDfe3ekBoc2ujyr7WfHJoXFhGcyPx8YEw3a2PxYdR9tNOBUnR8RdQpbKOd/fTNZgGxt
 ZXBrv91xrwTCNnqqkXN+bCwCAXVsmLSkiu/QZAs5mI+/OoHLLkTe80mzs0CustQp6bqLEJ12YwU
 YgXgmY+c/GMbiGNFbLmSJaBG7aGuQPKuEP6nKGrFKCXk8WtPKmEvL3MiNW1PtSfPcFHBcaCgk4O
 z8rI7pJrm38iDBimGG2x8YcY0aX0lwjFozPoEe7eUaW5F6Zzx1+lAlmj03ldmlwXQmg33YXvd8P
 LzMh6cdzt/vfjXG28C+NJzsT57wy7P4I+yvesk8+OTBerB929EFhDQz39XEbSR9tNZpaoqkSBf0
 pqR+k2EcgBlebf9t4gQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3df06 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LipbnPdcSf65HfI7a3AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX5yI/VCiVlD3P
 X2V2vL5vnUehtydxECyHFC0Fiufijg7kKCxS5WwNBAVfiwQ6lV1sHPQBDyurbDkcTl1CsDPDxQX
 pV8jpp93S1RIlTqfzOeXekj4paDU13M=
X-Proofpoint-GUID: YK7bQ-72wH56xRFWSbPQ8p12wMgFdYWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


