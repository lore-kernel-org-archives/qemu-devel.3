Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338ADC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO3a-0003eJ-Fk; Fri, 07 Aug 2026 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3X-0003Y1-JW; Fri, 07 Aug 2026 13:08:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3V-0000x1-Ph; Fri, 07 Aug 2026 13:08:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Glltp1937073; Fri, 7 Aug 2026 17:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5f3Wdy9B9Dzi6NSEF
 LaG+qhWLl/BGAcf0nN/W8k+vFw=; b=T+nkvQap3dy/DfvWFfMMsZqR1tlk1yBEJ
 ZIZN0K0683uqqpaxVqMr4YZw0YB+f2C1lH3lVBsF3lf0qfnzlERu9pupfNyX0R9c
 c8MBj25EGdCc4fyeB4j75mgNQTIx+6UF/zgdupkaCq0QgJrHzB0G8j2nV1EKRa4c
 P/404qlB+/K3eg2IyBLB/YXx24kl1hpq5ds5ct873JmmAeBKcLDzi48qhBpbp+Mg
 Iku8+VGa4PeENpYr9BhcKdiRL3+xP5vgNkqNe86YPA1vEVSenzMJNekWbtPPRvvU
 97K/Tt+reeT40NKT0tJhrOZRFFIiHR2AS2U0f72KH2m9gNMl3eL6g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy024u7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuG8u026632;
 Fri, 7 Aug 2026 17:08:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kgkvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677H8J3C29557380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 17:08:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD7D58056;
 Fri,  7 Aug 2026 17:08:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3471358060;
 Fri,  7 Aug 2026 17:08:19 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 17:08:19 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Fri,  7 Aug 2026 12:08:10 -0500
Message-Id: <20260807170812.658820-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807170812.658820-1-kshk@linux.ibm.com>
References: <20260807170812.658820-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NY4CpmJJfNGG7qzjfSJp6XnCTvG-3vHc
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a761105 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=c3lGbpyPv1M8-G6Y41EA:9
X-Proofpoint-GUID: NY4CpmJJfNGG7qzjfSJp6XnCTvG-3vHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX48CVDU6yL7Rp
 U/RgKT3vZXLoTg091OcozezQ+izPVVpcxwnYa8VoOkEMRj2+t5CrmHKJ704MQcYZNQ+3SQoKikU
 OBeZ3+GLGHAOnfTJnndA1rXyjL4BD4Ots3TdW2ERF0g2+QkbySJCsQloXj3de3qybdtVZ99o1/X
 cmd7UAOtadw0veweC2I2Zoo95iGRSuUeuV7uKC28n7Aqph91Sh0nUeoxYzOWUr4eJc65GAUWfd0
 hKtXDtquBZaMv7d+vcQKzHYiopjVU3LLid3vK71TPxNHEHb3wveZb0VzlBYA0JINRYYhHycBnx2
 e+OdXmDZeOsj4S7hyqRCunJG9Jn558XnfWDXvD1HtyctXMvlTC5PYLvS4a1xnjeS1rn3J3wV6f0
 ralgV+7c9pX4zXb/lltmVinVcG/pkxgCiUMFLtJ9c66rjFQk81fn6J4cNiCdhuYY7mvfqefI8m5
 30Q8aQXLNn2hAO8Newg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX/ttcozC42IHG
 cxCClepULpqR5TTVHQaIyYbtwOMSdZWrEC5LSuNAaYqbUbbIUoJnqKnb0xVYKcU8LIwk+P6YDMq
 gCwescfB0egejKAoUscqbLDkOwwbbMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131
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

Because S390PCIIOMMU has just been cleaned up of fields it didn't have to
carry, add a comment explaining why it exists in the first place and
discouraging adding more fields to it in the future.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e3cbee2695..17ecf3e0da 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -271,6 +271,17 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the PCI device AddressSpace that QEMU needs to link
+ * into its internal structures before the zPCI and PCI devices are fully
+ * initialized. QEMU wants to have this "root" AddressSpace before the PCI
+ * device is plugged in. It's only actually used for I/O while the PCI
+ * device is plugged in and configured by the guest, at which time it has
+ * additional memory subregions from zPCI device, that can do real work.
+ * In other words, S390PCIIOMMU holds fields that logically belong to
+ * S390PCIBusDevice but need to exist before S390PCIBusDevice exists.
+ * Therefore, no other kind of fields should be placed in S390PCIIOMMU.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.34.1


