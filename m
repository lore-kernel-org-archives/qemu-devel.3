Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD6EB271C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvTm-00062s-73; Tue, 10 Feb 2026 16:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTd-0005zQ-Nq; Tue, 10 Feb 2026 16:40:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTb-0000Pb-1F; Tue, 10 Feb 2026 16:40:57 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61ACPpeO528536; Tue, 10 Feb 2026 21:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=60wDWx5HkhKOznUxd
 1NlthZ99gDvlbwv0NAsJZd2cRw=; b=AbXXxRbAcsuwdk4aLZ2VhW97VSw/CWosf
 qqYJ8Sc0n/9xWIbAvDGg/piZw/vGxHpZDcAIeuIpaWoh8iJgbDLfd9cVfUMnDe9D
 at3lYi/UOdbWG72ygjrVmzWnZEDtPzcmqOyDD4Sag959YSei/vJnH7KF9le83dpI
 C1Da8XUX9xzt0VBoaePF8/mgKJdXujBj+j2Ku5mdWcheToRYkh4GtPET4T3UNc+Q
 xjfiAG048hHhPn92j5VS3pDYN5tDtnwj/q2p2SiNTvBJcEF+7R9a2u4hx73nyC65
 sapjE5iSOMKOJJtf6mhbSL9iRSwdJktBC9IvemM5X99Jqk/F28ejA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uefvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AHYIQY008883;
 Tue, 10 Feb 2026 21:40:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ybbp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ALelDr51708412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 21:40:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D18C20043;
 Tue, 10 Feb 2026 21:40:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E453020040;
 Tue, 10 Feb 2026 21:40:46 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.60.229])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 21:40:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 3/5] fpu: Restrict parts_round_to_int_normal to target
 precision
Date: Tue, 10 Feb 2026 22:39:02 +0100
Message-ID: <20260210214044.1174699-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210214044.1174699-1-iii@linux.ibm.com>
References: <20260210214044.1174699-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698ba5e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Y7_wFDRbBJZQL2pu5q4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NiBTYWx0ZWRfX3RZIXhKfsI9H
 r/Z7FcKt72cAXLmyxyNHzXDiWnW94eHis8XPheJ1+bKudk0w3VocFv56HLvAa6uBBBJJY7D410x
 u7aDnWSGRwVOnqLh2O++OmC6QTyh+cxUdhbxIS5kwvbQIdjf8xZ8fDTJVgYE1xnxdYbzPmvNN5o
 KaJhwJGQvs+s12tgnqBeW9AkV5rle01TFEU4zAvZEXTzd9UKGLkZENngTaqV02n6cHYI365thJi
 WQ094oOFweTmC27CZHl9RYts0BjWwWU5wGYVEB+Q1jcZ6rg9sBZyU4a8S34TuWFO1MlLJU+5iBa
 s9dIL1LKmbOUS2CGApTCB4iKb8fE0fiRtiXZdcH0UjKAnPMxL3nk1G/3cZxrKY2FYu/1JZD5imu
 Hhmg6FDrzKfeSiTYXqmXMZ+Ph2sjR++4PnjjLtjD7HQIwIk4wNQAohTtSA+SKQlVn+MLy1Z77S1
 IqIZeZ8cFNy/JQRP1FA==
X-Proofpoint-ORIG-GUID: a2IEHLiNczEqLfkjXAFk58VU71hHtqLr
X-Proofpoint-GUID: a2IEHLiNczEqLfkjXAFk58VU71hHtqLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently parts_round_to_int_normal() assumes that its input has just
been unpacked and therefore doesn't expect non-zero fraction bits past
target precision.

The upcoming DIVIDE TO INTEGER use cases needs it to support
calculations on intermediate values that utilize all fraction bits,
while at the same time restricting the result's precision to frac_size.

Delete the "All integral" check, because even though really large
values are always integer, their low fraction bits still need to be
truncated. For the same reason, make sure rnd_mask covers at least
fraction bits past target precision.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fpu/softfloat-parts.c.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b7..79b56014ab9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         return true;
     }
 
-    if (a->exp >= frac_size) {
-        /* All integral */
-        return false;
-    }
-
     if (N > 64 && a->exp < N - 64) {
         /*
          * Rounding is not in the low word -- shift lsb to bit 2,
@@ -1132,8 +1127,13 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         frac_shrjam(a, shift_adj);
         frac_lsb = 1 << 2;
     } else {
+        /*
+         * Rounding is in the low word -- compute the lsb offset for rounding
+         * and for clamping to the target precision, then map it to an offset
+         * within frac_lo.
+         */
         shift_adj = 0;
-        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
+        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (MIN(a->exp, frac_size) & 63);
     }
 
     frac_lsbm1 = frac_lsb >> 1;
-- 
2.52.0


