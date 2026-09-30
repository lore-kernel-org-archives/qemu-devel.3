Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD5FCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvhv-0002mp-8Y; Wed, 30 Sep 2026 10:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgJ-00014Z-QB; Wed, 30 Sep 2026 10:53:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgH-0006fx-AQ; Wed, 30 Sep 2026 10:53:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5SgX1932757; Wed, 30 Sep 2026 14:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=o+rbt4pebVHAlETjT
 28S6rroC/VRPIeQdgwHcQ2aoXg=; b=NJsl8N3XK7tUPOt+5gjkP+0PQT2VwqrS4
 LeYbUu7XFIx3bdWaKJbaVjQ0x3p6wHczfp6wpHDa/MkqEd3uaJ9FFLxRkCFfYtqa
 qKETqKLaRGvrD0V0ZKTMPW5qL6aRxdToWRPyoVoeXVib+TaniasOx9x4eCoL/m0n
 da477+v7vQnd1b6zOeDF6WsLLUFfm04dqmQeTKERPXN3yRnXZrAnXCozdII0aViV
 rHsY3+QVMHLRAzVEc7bW+CO5rLSQZ42jRyHaNQKfpG+kEhdSIx7rOsY/JtOf15TP
 clMw5i7uPFkHZmsV7KT5iiSsq1iZ0omVF9zNYOKZCUBj9+lmGIC/A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecsnh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34CM3583567; Wed, 30 Sep 2026 14:53:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e4mcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEr64W20578950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:53:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8628B58063;
 Wed, 30 Sep 2026 14:53:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE2D358055;
 Wed, 30 Sep 2026 14:53:05 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:53:05 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v11 13/16] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Wed, 30 Sep 2026 09:52:52 -0500
Message-Id: <20260930145255.140164-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145255.140164-1-kshk@linux.ibm.com>
References: <20260930145255.140164-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd2254 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LipbnPdcSf65HfI7a3AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX2tVH3FKz+wgD
 YGYzXhlMbKYbO+pMp0HvXPwToCBApwHwaYFJK6KvgvUZxmSQJN+bfRyALGF4wXTtBcPNoSt+CXS
 ljH9P/0sSO0CWLDb4m+X7mTdkDLismA=
X-Proofpoint-ORIG-GUID: fH_QlSsB-mcqClenRw8vkBd3qJm9C1om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX2NmB4SNt6o4d
 jJZaXBABd5yNYS2O3VsDJJSIlRdVwIXBuAcRTCPHBhoauwvl2H5KvZA4OFdlvBb6eMfiPgnYpZm
 RG95vm7yM17scR/hc+D9k7Bz4CBiKdlnXvCdtioIn9NVG8TBQaUiTa+O3iXOmJAqmkZqu42RTY/
 hBUIy+rFbB3KXA0tknGmAIouA5DApFcCqlLg2FbVTxojrxX8/xt7D0c+cOfAWHYrKT1l54w18sP
 VkgZ55Oya7pKWnxPgoh9ePAUIZc/1bfpaSE7cuVMGLrGz/95nzUSa4Fo+vlhNM590Gs+gGcRUUf
 ls5qCfNtf+yU3UzHfcvGttpJaCwaBZm0JjFdrGuJV0crjkM9J2hHVa2sZhMQ2js7bxDWkST1mrY
 1lEOluAHtR0leCwrUYh5iTl/N8kC3+LERMfQ0j0c1knMz+yEIDc1NbaBptWQwySi0bvjY0gcEPR
 iCD0cU9xp2cu8UARSIQ==
X-Proofpoint-GUID: fH_QlSsB-mcqClenRw8vkBd3qJm9C1om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300058
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
index c7fa7b9514..5c2d07e38e 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -272,6 +272,14 @@ typedef struct S390PCIDMACount {
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


