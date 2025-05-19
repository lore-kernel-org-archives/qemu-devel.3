Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11770C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 21:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH8MJ-00047p-Mq; Mon, 19 May 2025 17:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uH8MG-00047T-3t
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:49:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uH8MD-0008Qy-T4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:49:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIpEIM014715;
 Mon, 19 May 2025 21:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=mSoAqC/fvSalQDAIL5PG96bg+RcOVrEVcQa2jGlzn
 eE=; b=VMhqqAFurgHqaZaJ0RMEqwk4UQ4B2X/4JmabKKP1t84GT4wOIYZcHNNWt
 sCmnaXRV5+sLsDfmWX/hfkvznjvRDNlbWlfi+0Euny1VK2xkZD4Je8v9lgRzronN
 EUTMXDVZSbrT1Fj8dry4tOak7mKH4hA2ZOaZhtUjzYY4uoqBdDBwUnQGnqy5EWLj
 +kzkrSTOKTW+K3Zs7TNEKv8jOv1+uhiSfufyVN9bE6bE/3+BdD+rNoCJS8quwVcn
 si81ryxaYgHW94foY7JbTRJrndZhO8ySIR8WmcQbIHSPFmlTXId8+uKL3HAOrOij
 smBe/YbD8+EFUzvAxa/AykVgF4qaA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ra99gp9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 21:49:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JLPfli029132;
 Mon, 19 May 2025 21:49:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yrv85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 21:49:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54JLn6fR20906360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 21:49:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16D672017C;
 Mon, 19 May 2025 21:49:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B4D62017A;
 Mon, 19 May 2025 21:49:05 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.59.242])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 May 2025 21:49:05 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tcg/perf: Placate clang-21's -Wdefault-const-init-field-unsafe
Date: Mon, 19 May 2025 22:48:48 +0100
Message-ID: <20250519214903.55284-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J/mq7BnS c=1 sm=1 tr=0 ts=682ba754 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=SdSonV3RvYEHpAskkPIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDIwMSBTYWx0ZWRfX+dsmwx+WBRyJ
 8mY9QtPcegR+f7kqSHivbQzCBZk5fsm7HEOnJSORdxPStBtWNEN0Cs7YZKHl0cJeOzPe9ZKPQpL
 xBRfWytd6kk0IO7/pS7rxTCz4G8mkFebPatcwsMiXvia7tCflLiG8tKHrqrxzhLD31nxAGApcrM
 p+aBFB3kCdGWUaIhT2CRUZ9qShEVEDiohUR8Iuj9TRh0emSbO5vsSpKtF4YiRdVU64jrlZkO5/2
 VeeXtTHTcUW2b2DlJMFV02xjZaPuDA1SQZKyHtLsecsIV84k1gleafwlEoXOUrJf5OMdXRo3c6x
 SZ7fT9KFHM9K6Ec1F4zz2UpHcRhsFMA3IFxPJRBG0FURt+85jVkKdUT2GdUTI0Btww6+h7rZ65Q
 GEbNMgqV8oWy2ejP4c5cU18+oO2rp+BxAt7EFL0SceFniKNcyyCch+Dn+iiZTxA7WEIwJr/8
X-Proofpoint-ORIG-GUID: 3upyuuQqHNHnbVqM6acTmS9zJXcKwQq9
X-Proofpoint-GUID: 3upyuuQqHNHnbVqM6acTmS9zJXcKwQq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190201
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

clang-21 complains about the const "name" field in struct debug_entry.
While this warning may be too aggressive, there is not too much value
in having const there, so just drop it.

Note: in addition to this fix, I had to turn off the following clang-21
warnings to make the build work:

* -Wno-parentheses-equality
* -Wno-unused-value
* -Wno-tautological-unsigned-enum-zero-compare
* -Wno-tautological-compare

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2970
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tcg/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/perf.c b/tcg/perf.c
index 4e8d2c1bee7..f30c5b489d1 100644
--- a/tcg/perf.c
+++ b/tcg/perf.c
@@ -154,7 +154,7 @@ struct debug_entry {
     uint64_t addr;
     int lineno;
     int discrim;
-    const char name[];
+    char name[];
 };
 
 struct jr_code_debug_info {
-- 
2.49.0


