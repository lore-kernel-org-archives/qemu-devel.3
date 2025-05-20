Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF64C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 08:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHIYc-0000JZ-GU; Tue, 20 May 2025 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uHIYa-0000JJ-5p
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:42:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uHIYX-0004v1-Tq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:42:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6PSp8013379;
 Tue, 20 May 2025 08:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iI1HMnsE52Vywybp4wBhidcKJ0aDmFd68Tvdtb6BQ
 cQ=; b=H4DHUM58f8i3TDyKG/84l0QKPSv3w6fJvo4P9zVVC+0SjuhV+yllT5iOD
 tQqlXCorx2ncPcqfX7t6u7p0whaUdZJCm7qMtMLnAEjBteHYHXWFX01SZkyAiLuH
 t5/aszlKKXknUgiv3vlC1emX5huPehPQLMbhZkJhZvoeJqm4P8ynpgs8m3//IwVA
 iT0aUAmybMOnfWDPFKbMu/1jjkns/6Ame/tlpY28ZfHJY8wYwvUieeB7fOQZH/Y/
 4mei4BT+1PFZE4ZjRQUbVvjyx9q6U4svHttpd6FyvJtJR8BdrzEYdV3z9g1o9oYO
 CGiw4SJTJFtS9H4jub8LUl0Tcud2A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rab72yp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:42:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6xU1u002518;
 Tue, 20 May 2025 08:42:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snty1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:42:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54K8gXA948890200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 08:42:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B3A20040;
 Tue, 20 May 2025 08:42:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C99020063;
 Tue, 20 May 2025 08:42:32 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.72.29])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 May 2025 08:42:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] tcg/perf: Placate clang-21's
 -Wdefault-const-init-field-unsafe
Date: Tue, 20 May 2025 09:41:18 +0100
Message-ID: <20250520084225.90079-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=682c407b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=wn-HBBV-NwleDO877OwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9JkXVSsyxkaNf81okA9oNJaIw_fKP2ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3MCBTYWx0ZWRfXxD+KwUUQaa6R
 ch+EzT0MNFXpyA085qE9qJcadO5rLmeTY2ytob9cS44BBw8hAI/5I8ly6q9J6AbgAz2vQ65Y9Z5
 SXn1VdgpUGkPmATBiiDoUpSa5KRSZheHUYZWqSJxphKTAZHnWhXyiaRJnxY+T3YBTnGTjSBsrEk
 qWqfRCVEv9f5XTUBL39pi6D+51U5QKa7MUFtUBOrp2I9wSXEXVpvJSunGJk7vaj34i4sTYewju/
 eBfhcMSZI6AFX+5X3UyURmu0leI1M1F6K89yfnPbPAAKfA1a1MgVQ0gg54zOAg3fptPHUh9QkWM
 91MKTljNjnlEvofNu99IW01lpxKveZHWCcXmZgrn20XJI4onGt6dUFQgxk6BG9jn6q9Oey87fqb
 FOH6qLO1rcPP9WjPhlf4CXelq69cx8FnIfgvv0/DAvuGY6+NWJIzMwk3wwWkttDcVgh/wjcY
X-Proofpoint-GUID: 9JkXVSsyxkaNf81okA9oNJaIw_fKP2ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The not-yet-released clang-21 complains about the const "name" field in
struct debug_entry. While this warning may be too aggressive, there is
not too much value in having const there, so just drop it.

Note: in addition to this fix, I had to turn off the following clang-21
warnings to make the build work:

* -Wno-parentheses-equality
* -Wno-unused-value
* -Wno-tautological-unsigned-enum-zero-compare
* -Wno-tautological-compare

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2970
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/qemu-devel/20250519214903.55284-1-iii@linux.ibm.com/
v1 -> v2: Mention in the commit message that clang-21 is not released
          yet. Add Peter's R-b.

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


