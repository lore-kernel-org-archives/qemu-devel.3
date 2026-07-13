Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C52C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBO5-0000vM-JC; Mon, 13 Jul 2026 03:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wjBO2-0000uP-3M; Mon, 13 Jul 2026 03:47:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wjBNv-0003tJ-4P; Mon, 13 Jul 2026 03:47:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6fl9M1731613; Mon, 13 Jul 2026 07:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iVSQ/Tn/JlRifT74A0xNyuQcZchtpH0rVbgcrD3PF
 Z0=; b=bt0Bj1lqEAp6T+0vb/s21Xn5055/mPrSpV2xOry54iRCJMm3i+wJPrG2J
 uukcRXQjOW1AAAvBLSlzdbvjulXM120qISIN7qcy51KTlEFHiedK1Ajh5zlWNQfO
 IrOPRalhoqhWtsH7jN4jedw/nHJHOzkMdSvugFARyoDh7MzXgwWHnpAhePsW6Lhu
 +tFdinWUvyOftbzlT7WwXOFJAU8U6f/54jwLV8gygkRcrD0NheuP8vRMhxs06T9J
 TX+6+Qb5xtzolhFqKgKO1SGYEt6X8uzFmBBCiEgg7Q2jjdW95B4cAcd5d4cGzaRw
 mRo6Cmymg40YrC34D/pCysc3neBXw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbf56t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 07:47:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D7Ye0Z004416;
 Mon, 13 Jul 2026 07:47:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxvbfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 07:47:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66D7lEkR23069248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2026 07:47:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2950C5805D;
 Mon, 13 Jul 2026 07:47:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21A2858061;
 Mon, 13 Jul 2026 07:47:12 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jul 2026 07:47:11 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH] s390x/css: firm up handling of chained TIC CCWs
Date: Mon, 13 Jul 2026 09:47:08 +0200
Message-ID: <20260713074708.884282-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a549804 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=HhwtMAblLGFdMxaO47IA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfXyNtF9NaQmb4K
 NJHlY+WBhiXXruSIRK6/G8+iP7EksAcOmZv4jfbPYjvYB6zdtE3GZrkXdRwYZqQQN68TBEOqNgy
 9TVIOJk/CsiFnnLRfEX3kNQ6LOuWL9WNt6oN7XEBOauah6VEZvw/Lgb4gpNDXVPjLuEnfEK3+lq
 FUVKjuHU2+v+DJ+IPFWeH85O2mROEntUYoooTkWD2kvCTsxofwGEtcg1lwU3vOAAN89ND6/tYcC
 E7Uo92RO9FbOU9PzIQudQUIK6DrwMPhkiIIbtU34dlhONgt1LsfmsXSGZ9TnMEJO1CglSeXASkX
 edRY3tZ3h47qmjMOmUixlaOB3Ccn9rMwEVC/iQxvokXlxgJlJvh3Dx8dzbY1Sn4aqfT30Y5wGhf
 mpEVM0EgJJu0IItWjehJKBDj8KGzMHlQtd1PeqhjExwQvGa01uw7PSmfFQSaTx+ORhckp+VMzll
 6xPn/Pgc2F24Egg9+0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX/xYvBF9xD6+l
 xSy5T2ehew9H1CuRBrNSZSQQLaJ7OE68FEqIcmOHwBEZbFmviHKP4yazYJKWRpQXsizihm7AViu
 ftSWuIJ5/V2tDAvdQNaOCDRa5Fl94rI=
X-Proofpoint-GUID: Loj5k4xVWAI_MRmMllJKsxYN2h0Utwm7
X-Proofpoint-ORIG-GUID: Loj5k4xVWAI_MRmMllJKsxYN2h0Utwm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Eric Farman <farman@linux.ibm.com>

The logic in css_interpret_ccw() correctly returns -EINVAL if a
Transfer-In-Channel (TIC) CCW is command chained to another TIC CCW.
The same routine also correctly returns -EINVAL if 256 CCWs do not
perform a data transfer as part of the I/O operation [0].

What is missing, however, is a combination of these two, where a loop
can be generated that will continue processing CCWs but without
providing an opportunity to catch a breath. Fix this by capping
the number of TIC CCWs in a channel program at the same limit as
the CCWs without data transfer.

[0] See "Invalid Sequence" in z/Architecture Principles of Operation
    (SA22-7832-14), p16-27

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/css.c         | 7 +++++++
 include/hw/s390x/css.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 29ba39f79e..3a67b67053 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1078,6 +1078,12 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
+        /* Limit the number of TICs in a given channel program */
+        if (sch->ccw_tic_cnt == 255) {
+            ret = -EINVAL;
+            break;
+        }
+        sch->ccw_tic_cnt++;
         sch->channel_prog = ccw.cda;
         ret = -EAGAIN;
         break;
@@ -1129,6 +1135,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
         sch->ccw_fmt_1 = !!(orb->ctrl0 & ORB_CTRL0_MASK_FMT);
         schib->scsw.flags |= (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : 0;
         sch->ccw_no_data_cnt = 0;
+        sch->ccw_tic_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
         /* Start Function resumed via rsch */
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d3326237c9..79b41f305e 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -132,6 +132,7 @@ struct SubchDev {
     bool ccw_fmt_1;
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
+    uint8_t ccw_tic_cnt;
     uint16_t migrated_schid; /* used for mismatch detection */
     CcwDataStream cds;
     /* transport-provided data: */
-- 
2.53.0


