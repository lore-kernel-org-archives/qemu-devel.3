Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53161C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr59X-0005ks-Ke; Mon, 03 Aug 2026 22:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59R-0005gm-IJ; Mon, 03 Aug 2026 22:45:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59N-0005IQ-FI; Mon, 03 Aug 2026 22:45:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741J2W23658654; Tue, 4 Aug 2026 02:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5f3Wdy9B9Dzi6NSEF
 LaG+qhWLl/BGAcf0nN/W8k+vFw=; b=ZpAoNlzyDGA8IgibrDgbKeTTYyPpeVLBD
 RxEKki/lKU2Ev/N12FEqRyiUgLZgtznyyt7UN+Y+fkeKGqTNOc2jJhSmuPq6gXTJ
 HKQjjx81XoOrg55UFsMYNN2zRSFh3e3adLX4GDWxAy4HsGm5PxrScEeEE34vQBR3
 JIhPPIH1EvItx/y8+3HyJsQQeuoqsGYlg2orlCxzd80p10PLatJZqPM+JJRZsSe7
 dWRotIRo+s1b9m+nfkswJffwBkK276WrLV4v/DlBbBPWO84mpaq+UMt9LbQPJb7Q
 Tg4o0w2NXt8vPlxecoVzIHPi6d90hz2swj/KA81W6qql0VbVefaqw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4urgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:45:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6742fHI7032294;
 Tue, 4 Aug 2026 02:44:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k03kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6742iwBj2884250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 02:44:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D82A58052;
 Tue,  4 Aug 2026 02:44:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8D1458045;
 Tue,  4 Aug 2026 02:44:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.58])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 02:44:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Mon,  3 Aug 2026 21:44:41 -0500
Message-Id: <20260804024443.56445-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804024443.56445-1-kshk@linux.ibm.com>
References: <20260804024443.56445-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfX8VrQP5fnu2tS
 EnjZr+ektjxF5LlM8ZcnPJYN5D0Jt7dpWNaBakoN+ZSK4nPA4fxn8HaXjqZZm50LeCTdBPIbFA3
 tryOYRRDvKenVYg18f1nV4ZErnvG7fE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfX+TLgmyrIuEI+
 k/y59kCtUcBIdy9LZLsUQUXAI6PG1L1c8xHdsA4kp6labrWTGjIrQm9THIFkuHY0DAFE5ypLMm5
 XRfktPiC20y1+pfQPQTqJldFvWN934k2esKf6t5ZQpWdkBZiZi6NjJCNlEudhgUbdrUz8Lc544P
 UWDoO8NT/GnY8FvVUBjmMhKbzTNAWORnoWO2PA10WzARKIOwiLabbX/rXKCm/585wj2htCDt4gT
 bBcd/TiQ4eSRk5xecS0zzzLhS1d2nvUg2bAB4JtHQoHUQ4NMKVbe7Kze6tKpbbxj4v1puuVGivv
 kklaWowgesF1tdctnagUPbacuFhsLLuQKWKMv2W9LVY2Ch4QmCQj9ebaoVpXiQoHAkKgs/vOTf4
 lI/OLQOJwUwOoaw9v3BoQAUqEuAK0yDA1bMFVutG0IBv45fzfk14/fpaUjc+LRWwnwXqGQrxLFs
 7YSfXVs8GHvLxo9vUfw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71522d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=c3lGbpyPv1M8-G6Y41EA:9
X-Proofpoint-ORIG-GUID: LM2oHT4CGO-L3q5zRKqg7Cfq4hM1O724
X-Proofpoint-GUID: LM2oHT4CGO-L3q5zRKqg7Cfq4hM1O724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


