Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C8AC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzmj-0007MU-5T; Thu, 06 Aug 2026 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmZ-00079m-HK; Thu, 06 Aug 2026 11:13:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmW-0007lU-3V; Thu, 06 Aug 2026 11:13:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676Enn402866975; Thu, 6 Aug 2026 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XoQLzm9w2aL8ZoxeT
 5BejukUZzlUI/7gM5zH8V0gTXc=; b=RFIQjgZSAIK3M7swcmXJVIMYUDFZXn5vL
 5DbtWe8gHqCHVMQTRaNONUInM182W+69U40n6jKbJdCjHFpa+Wi64tprnuQwqBNM
 EbVT+eH1HJRvjXCjzRUorY1xTIhV71JSl0z1nwoHBZclUSPsKGdFp0MRCjK6bj8Q
 OU+KoUXfhWu8RGKCMzGQfYsDA3R2Sc3GWjlCktKZUQVoqnF6EO6HfS3yDx7NnBIM
 EdB6epPW18Gmml2alXEnyZgQVsNW6B369b87ipkZoMgWUwV5ajcIwqd3fDHk2d7T
 JoJdt+zIJkM/k95DbdX1VxfEun6I57qY9k71q1F6kTM2r1kIHcvlw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ggdv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBUAM011136;
 Thu, 6 Aug 2026 15:13:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwbsky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 676FD3Mg52298056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2026 15:13:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 116FA20043;
 Thu,  6 Aug 2026 15:13:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B368C2004D;
 Thu,  6 Aug 2026 15:13:02 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.185])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2026 15:13:02 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v14 01/19] target/s390x: Fix missing privileged flag at PCKMO
 instruction
Date: Thu,  6 Aug 2026 17:12:43 +0200
Message-ID: <20260806151302.26846-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806151302.26846-1-freude@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXwkG2d70q9+4b
 hXliLjyPwLHLzhYuOjxHL5d5mGmmAsVXflx8INy15fGcsAu1Lt58cd+cKWasseGYh/AUFR8TZIp
 VBbHCjFPlYCp4ZVVTlv/beAicPK4r7jB8+rEpI+oRkUhHmgZ2OxhEU5Dj8RXoAEuWnNtWbB4pi6
 06aQs+nlSgvhbi9M/sbZMXT8TSm1VLZXlnbx7ddi9D/CLVMHaHDtZFlflm8fxpbObw35RaEyda8
 qpSFdX06ZmFWoksJT64U0RE2wwDEyZq2nw+pcudhluoP5lmyo3/v6nchoMsabCO+SU3Zc9330Dj
 my3erJc56H1GqYkbMOATeLZVdx8h+7y+LdZaV1oab+r7skE3uIJ2aKnvH+RyqJZjvkXzsVVimAb
 T2e+XcKLwmbHGusGpZBXi6/3PaNUtu2uyzPGPHFpAAYzQj7LZqbMralkjpMCCD+tJ07L4J9NF2o
 HitoW8dDaFioCAqQKhg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74a483 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=BWF4Q4OZ7yhN7GJCQkYA:9
X-Proofpoint-GUID: iDihek56ZA-GBfojDYULvYNwx8KI6YcM
X-Proofpoint-ORIG-GUID: iDihek56ZA-GBfojDYULvYNwx8KI6YcM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX1Tsr835GklQD
 pRgVW1mXWs7/P2FodQsSm2Ldsrd4Ne3hOWAypGo4eyrcwIssCB+qxs0cVOWGFUMiy0jhjY/Vt1g
 TjW1ZPDQscUe3dpVeJiMAUGHahyn0EQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
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

The CPACF instruction PCKMO is a privileged instruction. So set the
IF_PRIV flag in insn-data.h.inc to reflect this.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac5..7ba9d43e57 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1007,7 +1007,7 @@
 
 /* MSA Instructions */
     D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
-    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    E(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO, IF_PRIV)
     D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
     D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
     D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
-- 
2.43.0


