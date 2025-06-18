Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7948C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 10:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRq9H-0005GG-IN; Wed, 18 Jun 2025 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRq9G-0005G6-CL
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 06:36:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRq9E-0001JM-KX
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 06:36:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I95BPF004256;
 Wed, 18 Jun 2025 10:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=R3rDYszvxlWiTBfnSijGvFEIf2FE2S3DA8otQMWJp
 6w=; b=QVaRRVOjOARWxyrmpqYZp7rcTTNg+BeAHOB/yeMf7zwZZrjrI3G09jdA9
 M5+57AcRehmEqT8wtaZEGQeqmy+geqahhI9NDCogg6nV8wdq23KqicQKvC5QJOxW
 dNmmmh5ThahYLec0Fx/DF4GT5RmVRPKsCHbJydHS4jsuWYa96aFZlJEg3CSIAQOI
 cZLdKaGsCx61Pf5ckqjygkbVxNftcCpfFqJssISEMpSOnEE6q+qDxnH7Vz316o15
 FDEPVc3z5eQTYx4wFcUbp4rSshDf1mV1S9QX6964p2PmE4wk8Rj5EWZ998ZyDQ50
 rvMuUh78rJP3zl+Y1J7W2fA/o6gFA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygndy01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 10:36:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9THw1014278;
 Wed, 18 Jun 2025 10:36:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42g41t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 10:36:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55IAZuYp47907220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Jun 2025 10:35:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAEDE20040;
 Wed, 18 Jun 2025 10:35:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C8AC2004B;
 Wed, 18 Jun 2025 10:35:56 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.14.28])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Jun 2025 10:35:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tcg: Remove null pointer arithmetic in tcg_malloc()
Date: Wed, 18 Jun 2025 12:35:40 +0200
Message-ID: <20250618103555.2020-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4OCBTYWx0ZWRfX5PW+t6MDkhH6
 R+tBFjnG36UqJhda2StP26uU0/csWIvLY4s+fjj6XEt9lLCESE8bjz/spXvHbWyl8qsj8DGiaX1
 c61vDMIkEOUtlvT6+VSFzjsDdN14VIplppiOEkRx7aZkLvK1Nf5ek5xoYJi3ss9p3ncyGZTH3Wm
 CSVj3dvd/TBidRPmxB5POApeOH4goZNy2Enm3SR9UZdRP9A/qTTnmCWCxtvTUQ3lJ0g+V09zUPE
 VW+/gF2QRntgcXbGe5l48MjqG1iQ1QFpiAGVPa+9Ht01zXKLNrwD25oefWTmyNkhQvtuNQRECN5
 t7FI3H6psyOSwo9i5e1RwbA4sbZEmN07nVMUYgC+S0dFZSDbZUeaVv82jA2659TRUmr9RDrp0cQ
 td4OCzF3ufRjRqKYd18nobRBmAY64IJyej7Bj48tbw2aNq9DLn0ZyzuzCldEWfzz2Lfa9Ku/
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68529691 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=lYEB2wbCuentbSekCmQA:9
X-Proofpoint-ORIG-GUID: 9CSpFsO9ol13eA3wmkPdryH3mxam5CO7
X-Proofpoint-GUID: 9CSpFsO9ol13eA3wmkPdryH3mxam5CO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=946 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Clang 20.1.6 (Fedora 20.1.6-1.fc42)'s UBSAN complains:

    qemu/include/tcg/tcg.h:715:19: runtime error: applying non-zero offset 64 to null pointer

The code uses NULL as pool's initial start and end, with the intention
that `pool_cur + size > pool_end` should trigger the allocation.
Unfortunately C prohibits adding non-zero to NULL, even if the result
is not dereferenced.

Fix by using a dummy pool.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tcg/tcg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d714ae2889c..afcc7ec8849 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1358,13 +1358,14 @@ void *tcg_malloc_internal(TCGContext *s, int size)
 
 void tcg_pool_reset(TCGContext *s)
 {
+    static uint8_t dummy_pool;
     TCGPool *p, *t;
     for (p = s->pool_first_large; p; p = t) {
         t = p->next;
         g_free(p);
     }
     s->pool_first_large = NULL;
-    s->pool_cur = s->pool_end = NULL;
+    s->pool_cur = s->pool_end = &dummy_pool;
     s->pool_current = NULL;
 }
 
-- 
2.49.0


