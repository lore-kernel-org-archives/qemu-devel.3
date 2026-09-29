Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B76C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZmj-0005mH-Mm; Tue, 29 Sep 2026 11:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmh-0005kS-KL; Tue, 29 Sep 2026 11:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmf-0007w6-P0; Tue, 29 Sep 2026 11:30:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB65J02784022; Tue, 29 Sep 2026 15:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZaenF2XjXh5pLJOOD
 gpYO3+oXMdbOOnFH6E/qVZFipI=; b=jMbCiTiJvM6p/fLQPoeoKiF4+xSZbGiYq
 DerzraxlL3gQjPOCyh/1Rs4/hRfebbzYACxAt32q3twV16LBiTDvQ7Uxtj+qZKuo
 sNn7rlOpN8gaVB8pQZqqf81jmNvIo/rv+J979KI8UdljZxeP9RfxUodF89W7yQjt
 Nv+4JDtxbaqjO7jLr0QExBWKAFv1H7JV2SIFe70KD0P2FbqY+vT8pwtBE4qO0MIq
 SqhlLbIGzCHnqIxIstywJwR8J6lRB1FigSpNmGZpw0b1SEbGMvH5AxdBW7Qf8qoi
 wisu40ht3YWeDEMMVcj2/coxgNRRRCnt67RL8gRbq+YCpbAaZ1ZWg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe76ru-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF6cH61607727; Tue, 29 Sep 2026 15:30:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxscka9sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFUFRu32965178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:30:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C80A58043;
 Tue, 29 Sep 2026 15:30:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A105805E;
 Tue, 29 Sep 2026 15:30:14 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:30:14 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/3] s390x/pci: Fix frame stepping in rpcit_service_call()
Date: Tue, 29 Sep 2026 11:30:10 -0400
Message-ID: <20260929153012.774530-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929153012.774530-1-mjrosato@linux.ibm.com>
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abbd988 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=MMuBV-PD9cgeK7xIxbcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfXy2CYphHxftLE
 lKo80QIxdVmdFcHgqkQ4D7uKhIVYHSJeuwaW7OJZDQ2f0ONiKPmVCkm7gcBf9pnqdagY7Q6X5CW
 3nJu7ZCWIEW01zmBX5Ak2N048rkCG/k=
X-Proofpoint-ORIG-GUID: y44Si8K92s86wCYUYY27itH8zyOyVw2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX68iPl8fqV5Uq
 wEBZtamdwM5PxAwtu8YXRRXA3A04FadjTGMwjAxL92hqt5Q4OVTuaSuVwi9MMDhJCFxJnfKjD34
 q/y80ua5lCeJhtcDPuWmfGUts5dMYXifBo/Oq4avFTGvmpvo/GZnIzkHjdbmP9tEgd0gfcAnxw6
 rWYy6xWLLbqrJ5Hbsbqn+TalOj6G/NqkmqBJUk6e0j1JDfdEmgwYwCvtzfPyxQ84uQePpAabpmC
 FMiTlVsh7mE/PVTLneSi1QTpeh6ox+osKhWNYAusbJBWpxxZ3Pocooxwa73koJArQSrJ/hIQfM0
 VnIeYccAS78P4zs0RN8x/qiPrXRZiN0AUDxUkb8xbs087oTL1Lm7sd1AHQOUH167Tw1di0yQOUG
 5ryel+eUiIOWQi5zGEeHYTC0a0nmjCnp2sye/MNBucArrbFJn7jf20l/p0L0n76iLXVwe3F6UYA
 LtoHIf5Amgxqvy1140Q==
X-Proofpoint-GUID: y44Si8K92s86wCYUYY27itH8zyOyVw2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

When walking the guest IO address table, an invalid segment or region
entry causes table_translate() to return entry.len equal to the frame
size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
entry.len directly to start only advances to the correct next frame
boundary if start is already frame-aligned at that level -- which is
true for a well-behaved Linux guest but not a general requirement.

Add logic to advance start to the next frame boundary rather than
simply adding entry.len.  For a frame-aligned start (the typical,
well-behaved case) the result is identical.

Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 652e1712ec..bac813fb6a 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce = 0;
         }
 
-        start += entry.len;
+        /* Advance to next frame boundary if start was not frame-aligned */
+        start = QEMU_ALIGN_UP(start + 1, entry.len);
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
                 dma_avail = s390_pci_update_iotlb(iommu, &entry);
-- 
2.55.0


