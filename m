Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87441E95393
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbiW-00033y-V2; Wed, 04 Feb 2026 07:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiU-0002xy-1h; Wed, 04 Feb 2026 07:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiS-0006RM-4D; Wed, 04 Feb 2026 07:10:41 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 613J7Q6T027389;
 Wed, 4 Feb 2026 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cwX9q7/To/imUVZCL
 OGfQq71t0LH6eYW7EMGrK+pwsg=; b=jEQ2c/ivjvuDNIn09MXQmp6czaf+zAkMW
 /WsVwitWIzWg5Oy5PFBqQAVyxRT6faV3I4WYGnHm6oO8DOfHA0vtLTX84aLWxeQs
 mugw9gry/Auk/YAs2nzAlPq9id+oYfbMKt/htQNOb68LRoAzCA54BLedNZaPfDdY
 cTUurTCaZf8NDcWpSkDqJg/nYfUVoerfnq0BG3HECJl68SOe/mRB0StGvujJzKP9
 CjN2uQ43FCvqF/hVseTz0Hwn4oUWXU06Sbz88QG/8GmzvXZxuymds4UT6R8XX6E0
 RxvEq3UGJ8wm8ucnotYPaGCxNxwIxCTSqYZeD5CGzhmoDaDdERqDw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mybvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6147Ucto025812;
 Wed, 4 Feb 2026 12:10:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2mw3tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 614CATUF46596472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Feb 2026 12:10:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0C920043;
 Wed,  4 Feb 2026 12:10:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02CED20040;
 Wed,  4 Feb 2026 12:10:29 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.140.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Feb 2026 12:10:28 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 2/5] target/s390x: Extract s390_get_bfp_rounding_mode()
Date: Wed,  4 Feb 2026 13:07:45 +0100
Message-ID: <20260204121026.645382-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204121026.645382-1-iii@linux.ibm.com>
References: <20260204121026.645382-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hwGlh2tN0R2MYjrZDY1FmjWJR67aERTZ
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=69833738 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=legnL2kWL1UyQeN_ircA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hwGlh2tN0R2MYjrZDY1FmjWJR67aERTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX3Yjm9lTXy8Fu
 AQtq+oI3eCVhCu4MF4sZO4hgDMYakXeyvCJeHF1PfuonTGC4qxynQErBruHa1IUmo9anrYi3fFf
 vCCo1H0hqQS+dlvdYZTlaOy9Ia55w9RnBkmZD322ickaTY8WzuvdJYJL9Pi7Qsm0IcU82o8C13K
 CqlimrZ9jJOb3+zAtJnLRjnyVYakH4HZPldJo4s/7napLqN6qkZE9gf4ckz9iYdsuT4o9NXoBHW
 tL3JLblgRpq43EdQZ+Vtjw2dtLmj5ipKWRQaswXklj6uhmR5z+qssiA1Yfvx6ljexNou1dLLKLH
 aak0ByTz0vf6EcWa6JTl1ngfcDjkpGsiD+rQu1upov/1AZWhgEOek2M8NoqTNYmeuirH1bMUdkl
 Fl10a4vSonIzbzQ8ogteNnuAcDQtPRCb9OGVzUd6e88EXk76ke199eFhP/6FRfYWa6HCU7cCEvy
 8KQdJOrtsOBmaWMRiSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602040090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

For DIVIDE TO INTEGER it will be helpful to pass final-quotient
rounding mode around explicitly rather than setting it in fpu_status
implicitly. To facilitate this, extract a function for converting the
mask to the rounding mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/fpu_helper.c | 62 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 1ba43715ac1..7a3ff501a46 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -56,6 +56,35 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
     return s390_exc;
 }
 
+static int s390_get_bfp_rounding_mode(CPUS390XState *env, int m3)
+{
+    switch (m3) {
+    case 0:
+        /* current mode */
+        return env->fpu_status.float_rounding_mode;
+    case 1:
+        /* round to nearest with ties away from 0 */
+        return float_round_ties_away;
+    case 3:
+        /* round to prepare for shorter precision */
+        return float_round_to_odd;
+    case 4:
+        /* round to nearest with ties to even */
+        return float_round_nearest_even;
+    case 5:
+        /* round to zero */
+        return float_round_to_zero;
+    case 6:
+        /* round to +inf */
+        return float_round_up;
+    case 7:
+        /* round to -inf */
+        return float_round_down;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Should be called after any operation that may raise IEEE exceptions.  */
 static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 {
@@ -416,37 +445,8 @@ int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
 {
     int ret = env->fpu_status.float_rounding_mode;
 
-    switch (m3) {
-    case 0:
-        /* current mode */
-        break;
-    case 1:
-        /* round to nearest with ties away from 0 */
-        set_float_rounding_mode(float_round_ties_away, &env->fpu_status);
-        break;
-    case 3:
-        /* round to prepare for shorter precision */
-        set_float_rounding_mode(float_round_to_odd, &env->fpu_status);
-        break;
-    case 4:
-        /* round to nearest with ties to even */
-        set_float_rounding_mode(float_round_nearest_even, &env->fpu_status);
-        break;
-    case 5:
-        /* round to zero */
-        set_float_rounding_mode(float_round_to_zero, &env->fpu_status);
-        break;
-    case 6:
-        /* round to +inf */
-        set_float_rounding_mode(float_round_up, &env->fpu_status);
-        break;
-    case 7:
-        /* round to -inf */
-        set_float_rounding_mode(float_round_down, &env->fpu_status);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    set_float_rounding_mode(s390_get_bfp_rounding_mode(env, m3),
+                            &env->fpu_status);
     return ret;
 }
 
-- 
2.52.0


