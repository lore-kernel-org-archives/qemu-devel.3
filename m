Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349CC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrxI-0004ek-V2; Mon, 03 Aug 2026 08:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrxH-0004eL-EN; Mon, 03 Aug 2026 08:39:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrxB-00040X-7b; Mon, 03 Aug 2026 08:39:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673CHlAF1943463; Mon, 3 Aug 2026 12:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pEsmx3XfoIfSdT8oa
 iaTqbNchSNgXaw5dgtKXXN2Py4=; b=EZLqp4qvSx/t7DdWGJqRMSlFZdBz2gfGF
 G5YTT4rM44b5nXAMErtHCt14QuWPjDTQTiv5XioZWFi3yS8MOLdMgEyChbb0g3l2
 sRNy5oyUjmkdJP9hkUWbTb6yWh0jczw2yznyz+HiVTR8wKIaqg7uChdvm4kLHiEX
 cf8+/ovlHsDmwZK+bY50co2nBRn1V4cUpEIiunVo4rR2irho93Rql+QfANL/s+LS
 5FZN7By3UHyot2oXBbRThMLxuJWVI9ciJC/4tmJAQsrn+eZeYdzMC1JQqgnFdLqy
 HC+XQ5zdMqqAWHG3Y0URUlOrpyHn9wYoKVeeP8mgcXZwnghcgxWFA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0k1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:39:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQFEr009738;
 Mon, 3 Aug 2026 12:39:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh59n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:39:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673CdWiV47841774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:39:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ABB420043;
 Mon,  3 Aug 2026 12:39:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1791320040;
 Mon,  3 Aug 2026 12:39:32 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.49.55]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:39:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] tests/tcg/s390x: Test LOAD and STORE REVERSED
Date: Mon,  3 Aug 2026 14:38:34 +0200
Message-ID: <20260803123928.1875606-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXxrLhvJukT8hd
 5x+pEQid5uOt2kDa0peu6mGya0SCzIN1EJMDhVNPQmtqgR6C8y747QTrM+HjCH+qkHRvbygTjOa
 BeQSl2jR9DJGUZVIlJqAopG60ALTJu5vK1TKO17EjfWNCTK2redHJuvdi6WMYgclsFVenl/FW9q
 ntiMYkLeU1BgLJiROFz6ggb/3gJY3ojVo6VqlgNKyrz8sjwoBvLJZaFzZ/Af5Fd8701eU8S0RWs
 5kbsOh8hKUIKcMHZgfn0yefU3D7KAyrDpAtRAPyQk5F5PF+3I7pInR6s5KqjiY1uS++B8G0jVYU
 em6N6h0OTnoBbWG3nRmW9TnP19oa399mY2wZPjaRnFbc6UoKrAgCEfZEDlapm+axUlXuO8djwQN
 mtvdqjsfYWA6cDWb7cppfBRCD84lqyFGH5NHrjMNzFRRLlJjH9kv1e4e83zuVtNuBXUo66OT7Rq
 XE4FkVxUklA8LN/MX2w==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a708c07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=aV6vEkSo3a4riJS5YlcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: pOB9hwo4Swt20kqO2XVGtvBBQYIDCwR9
X-Proofpoint-ORIG-GUID: pOB9hwo4Swt20kqO2XVGtvBBQYIDCwR9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX1RfYn79Ykv7I
 Z5zlNNwEhXIgbVH4dF9r+OB5gshzPqfTXsNEb6U/XD0AiimNJIp3kEku6E2LpSc71jwmAcGL6s8
 Tfk4aeQUApfAdgQ8zsvG694qlX0e8ls=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1 -> v2: CC: qemu-devel@nongnu.org.
          Check that upper bytes are not modified.

 tests/tcg/s390x/Makefile.target       |  1 +
 tests/tcg/s390x/load-store-reversed.c | 46 +++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tests/tcg/s390x/load-store-reversed.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded01..fe1fba3de2f 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -50,6 +50,7 @@ TESTS+=cvb
 TESTS+=ts
 TESTS+=ex-smc
 TESTS+=divide-to-integer
+TESTS+=load-store-reversed
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/load-store-reversed.c b/tests/tcg/s390x/load-store-reversed.c
new file mode 100644
index 00000000000..bcc6b98dd3b
--- /dev/null
+++ b/tests/tcg/s390x/load-store-reversed.c
@@ -0,0 +1,46 @@
+/*
+ * Test the LOAD REVERSED and STORE REVERSED instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    long i = 0x123456789abcdefULL, o;
+
+    o = i;
+    asm("lrvr %0,%1" : "+r" (o) : "r" (i));
+    assert(o == 0x1234567efcdab89ULL);
+
+    o = i;
+    asm("lrvgr %0,%1" : "+r" (o) : "r" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    o = i;
+    asm("lrvh %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0x123456789ab2301ULL);
+
+    o = i;
+    asm("lrv %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0x123456767452301ULL);
+
+    o = i;
+    asm("lrvg %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    o = i;
+    asm("strvh %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcd456789abcdefULL);
+
+    o = i;
+    asm("strv %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcdab8989abcdefULL);
+
+    o = i;
+    asm("strvg %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    return EXIT_SUCCESS;
+}
-- 
2.55.0


