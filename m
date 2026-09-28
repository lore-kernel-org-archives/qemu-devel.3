Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0987BCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHt4-0004tr-Fe; Mon, 28 Sep 2026 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsx-0004s3-Qr; Mon, 28 Sep 2026 16:23:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsv-0001JG-M0; Mon, 28 Sep 2026 16:23:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5Q8x588355; Mon, 28 Sep 2026 20:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5xCjmyC5sdHJCfJuk
 8gh+Ys62T5Cvut+FPwlSPjxar0=; b=RWtxY8MlIOsrM2uLdqysaetPvpD2WhP6s
 A3GvKIu3F7tjLKD7zr7Pwy4WSB9LH6xvEqVN7evtGjrSg5BiXUECgZ/2+eOA6tj/
 NTNoh39HV3+YvP8FGEKqhKhCLuxazG5ETDj8ZQqoOCPDb/Z23PkjxyxjML4nSXSo
 +95sGl9qUTYJEsPJcNGrfvZJmHhWYfZp8Pu+waRlOhjVCW1i8xFhYGx4Qn3oHRpn
 dhHkw7IMqotIn+HL9MG44i7UMJhMl6YZuGygL75qJTSxcIavI78lNjR3uu/hLiGA
 WyIazfhWOnWqc0h6nhUse+vBBZ37lgXefQumlpKF8rUhptoyXf7JA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe37g3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2ZJb3405193; Mon, 28 Sep 2026 20:23:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg6pdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SKMiHN5964454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 20:22:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD89358054;
 Mon, 28 Sep 2026 20:23:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CF545803F;
 Mon, 28 Sep 2026 20:23:27 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 20:23:27 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] s390x/pci: Fix frame stepping in rpcit_service_call()
Date: Mon, 28 Sep 2026 16:23:23 -0400
Message-ID: <20260928202325.309353-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928202325.309353-1-mjrosato@linux.ibm.com>
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abaccc3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=MMuBV-PD9cgeK7xIxbcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX3Er81Rys92ao
 sQboNMsZWz8oV9b37QhY0nb8MuYlKIgfDFUf7bHElFlC2pEepfVcxuExCo0U0YVhhneLK7F0DQm
 nypCXPQ2FFmNAFsY4pTQeEMH9Cy4Zig=
X-Proofpoint-ORIG-GUID: aefck-MBHKEE8r7RUY1tZqpso9L-CBJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfXxlI8ESFxgLli
 p9QdH+lgWF1E9VAVbfvecSKmVZ9uSJrHTqIpnvoxhTZQzpXd+grIJjzUODoVKgtD8+5TRELrdFW
 Mtwgmtfcf6Uz2IPYf7tYCnUxHHX+qiyzhuhzc+RRxpsKm9KumhgSGP0WdiPaIE4WtPTaq6N+6hu
 aNjC5H7ZQ8XUD5+8uEzh+mKGUJcZzA74HYydlYE2SVaD4mkiWneGkLVW4kLF0UVGq/KCkFiLdnB
 dSoY/GiCzJG80+7lIsnZweUwwOeEFqOi84p8G6sPG9X85wzn7p2fWUkVDinMTFZS0PkX+jYjaiL
 XMjY2y0spln2UQaH5Ie/L7+X1xfhZpgDmIlgpnP7251OrFM6DkNEbLVQN5zMWr6bZFqXogTpyCx
 eT5Vj+Aqm5wTBfNXppgQVguwx9jU436yH+9CgQBdMtG278e7EBCM3p4CP2ejoyIb9f5zctVaVxW
 3L0IObMP3EVFhFmyiYQ==
X-Proofpoint-GUID: aefck-MBHKEE8r7RUY1tZqpso9L-CBJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280080
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
index 652e1712ec..a51543df44 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce = 0;
         }
 
-        start += entry.len;
+        /* Advance to next frame boundary if start was not frame-aligned */
+        start = (start & ~(entry.len - 1)) + entry.len;
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
                 dma_avail = s390_pci_update_iotlb(iommu, &entry);
-- 
2.55.0


