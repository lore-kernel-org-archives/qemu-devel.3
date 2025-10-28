Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AD7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDek6-0001Eh-RF; Tue, 28 Oct 2025 04:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeib-00009w-6j
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeiV-0001DV-AT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:06:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2lTms029705;
 Tue, 28 Oct 2025 08:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fgKnxY3+ROcW67MNh
 +burGNbiMtT4B4rTWDwLbIabB4=; b=kCXtRc1giF/qaqkIm4qKozIHdwvMbVJbL
 4ZYIWKOTOBbYUUz9bCeJCa5VANlIG7NQ8c1+0TUBgpNjR17eXJbNsbH46esBNn4V
 Y+ADgBTcq05D4Jn6k162NHGIXYt5vpQVvGvjWD663XD0JzqhdXJ0X0b4RovjkQXi
 iaBAPFGDs2b3Qimy05//KCaWUqxB+2PEhhVUhZ9e67IypDNTTiCa9CjXoD5zHaNV
 mAErqT7Ol0pwU/3HmDQwhKYafCuceP8WDprjGhqihI120PRQ9X65jtTDRaA6CLDW
 K5YXWBSJqhKHg1mDOpdwIAhTtW8nlP8z2mMHQr7JtI7FeaoVBCA9w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys2n8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 08:06:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3olrg030075;
 Tue, 28 Oct 2025 08:06:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmhpnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 08:06:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59S860fO61276668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 08:06:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6FFF2004D;
 Tue, 28 Oct 2025 08:05:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ACBF20040;
 Tue, 28 Oct 2025 08:05:58 +0000 (GMT)
Received: from shivang.com (unknown [9.39.28.67])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Oct 2025 08:05:58 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 shivangu@linux.ibm.com, sourabhjain@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
Date: Tue, 28 Oct 2025 13:35:50 +0530
Message-ID: <20251028080551.92722-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080551.92722-1-shivangu@linux.ibm.com>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nCYW-GcK9ZRxJtHX0FRc3Aml7JYUXV8h
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=6900796c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=ebZVwKzJ5QttRmoVdyAA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX4CLCb3ocmv2Y
 8dyxxRd+SAYlUtTm8D8qSll9yr/X7TeCl+Pq7K+GNJl63Ry0Xp/PzyYGDkCRjHkVagGQ5QhnDXe
 gjcNIkGe8H66BC7BNG6ByLMRDx9DPTmOCxK7/BIaepfXY2AEN8uSkfXRUBUMwvtYT5ExudWP+Ow
 mf14uO6akqB/zdmaEQkdqDaV5mR1TRb8X/N1t06/0SoDJAQ1GIrB5hEmTKGQGOX00Nr2VeQXYCB
 T/f7XYq6/T3p7IA8reTl59YN8uEYZO5C6uYBUAtuc1foGP0lYJMUZ5NJvqdhehDoMESEt7WgPi+
 hMcio/dWxquGnLv5HxTmumV1QzkVikQ9hM9lRnGFflW4bno4k7KWrSvlfsjYCAa1qwPJpPySs1s
 +CByvRYcsor7m792mbun0wWXcqkx5g==
X-Proofpoint-GUID: nCYW-GcK9ZRxJtHX0FRc3Aml7JYUXV8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Fixes coverity (CID 1642026)

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index fa3aeac94c..883a60cdcf 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
         qemu_log_mask(LOG_GUEST_ERROR,
             "FADump: Failed allocating memory (size: %zu) for copying"
             " reserved memory regions\n", FADUMP_CHUNK_SIZE);
+        return false;
     }
 
     num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
-- 
2.51.0


