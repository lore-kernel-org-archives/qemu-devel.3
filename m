Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A59C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbB-00013K-Tl; Wed, 12 Aug 2026 13:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000BH-3e; Wed, 12 Aug 2026 13:17:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000q1-Or; Wed, 12 Aug 2026 13:17:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1fwL2985504; Wed, 12 Aug 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fasaxa3s0cFJXhcLU
 oG/5b2B1eGESqNk+/nZhkxlW7o=; b=H6rMf7+rXGQDomK9YjBrWlFaiEIuQr42+
 Ww4NQM1K4BzZ0pfeKDudybk60dgFn1MgbZXvFO5j+JnzLB+APVkNN6Za55DMIFjh
 2KIhpAe2paVHLQ1NQozYvKkKEd2LDUg9EMrTXZ5tBxDt/xLXYXvB+ldRqW0SRqhU
 Do/L9Pfy01AYWzyhndH/AH9uVkWqZF7cIlr/vrwBq7WaWm33qjYt0QBwS4zac3Go
 /xKBrZ9pZVp1ZnYPlJ/Y9a508R8gLaYIc4Jq79RvOD55tgBDjuUtwa0V7QYsD3pI
 vMNCpcR94XsIbpBYH+OFWCNb2g43+8oCtrt1QqIzj2UZvq3/2/Wuw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23v81r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBIXF017315;
 Wed, 12 Aug 2026 17:17:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq79yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHGajH3211880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:16:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A375805A;
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E54858060;
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/15] s390x/ipl: validate num_comp against iplb length before
 iterating
Date: Wed, 12 Aug 2026 13:16:58 -0400
Message-ID: <20260812171707.1605637-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7caa9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=bjQa_1rzhB0BTgrvudgA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX7jj3XOGcy2eC
 dFumuqOTBnGeJKxdceF5+wFqGqWSlVwYsdQwzCNKtQ1jFfNv7E2dZJCy0IIPPFrh2011m1U+LPZ
 fYQy4RiA1lM9gjHxnZz9FiRVbvInIFMFMxglPq1KAGbkLeprH3nHoRIKMNjm8Igvgiom0/kvP07
 Alcb5DR7QMdd3veRntOccWQvNo6ZKr/h7UqT3WKMG4WFhQuAfFtzr31Yw3gWmN9VVw9EWeg9CBf
 E8D0N9mS7VdRJank/iG29yDDJteMgnwSq2n+2gSSFh2CeCvi5n1U+tOf8wVunOS1bobdc6f7XB1
 y4v4ktAKeVIQrFsXD+A9Dr+cxDIOwvNkvWYOX00zrtNklKM1Qd/CqSrPdCuVOqMxmiatRr1C7qw
 XQTGZDwEY8DX3q57jWzbR8RLbbAG6+7JvfujKNDH7IkivRed7Rk3UAsYdGVOE5l7YZt+uUxy/GC
 /4uUXSJ8F+Xyd5LUJTQ==
X-Proofpoint-ORIG-GUID: aBQAfGB5Eu86ePerIhCc0IFMfIN0x6oS
X-Proofpoint-GUID: aBQAfGB5Eu86ePerIhCc0IFMfIN0x6oS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX75UMcnHRmvNh
 xPCHG21T/o0gv9PqoLmcbytjb0VetePH7N0bPyLkohTzgOLCgdZj5a4+1t+DWFFgGq9qwErrtZo
 41ZEqLdfZpj4IRLjn05HvtwFruSRT6I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Joshua Daley <jdaley@linux.ibm.com>

In ipl_valid_pv_components(), the upper bound of the for loop,
ipib_pv->num_comp, is read from guest memory. Before iterating, verify
that its value will not cause a read beyond the end of the
IplParameterBlock.

Fixes: c3347ed0d2ee42a7 ("s390x: protvirt: Support unpack facility")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-3-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index fac30763df..ef9c063d90 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -124,6 +124,12 @@ static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
         return false;
     }
 
+    if (offsetof(IplParameterBlock, pv.components) +
+        ipib_pv->num_comp * sizeof(IPLBlockPVComp) >
+        be32_to_cpu(iplb->len)) {
+        return false;
+    }
+
     for (i = 0; i < ipib_pv->num_comp; i++) {
         /* Addr must be 4k aligned */
         if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
-- 
2.55.0


