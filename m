Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE42D34082
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl8j-0002N9-VH; Tue, 27 Jan 2026 10:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8c-0002Au-Pf; Tue, 27 Jan 2026 10:37:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8X-00024U-6H; Tue, 27 Jan 2026 10:37:52 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5bx9f000644;
 Tue, 27 Jan 2026 15:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=08rm6b7U8D/hDyhz2
 uPWCZQwQYr73pd4NVu+8apMUUc=; b=DaWd4jiV0HRl4bb76UG+n9ft5jT0dSnyp
 xaeHgvt+oikdTJrZV8BGG/6QZgT5qf7NlEdpIf6kCD+P0thOkYmZVYJnyjIUaaGO
 BwZ2iZEVJH5lFrA7LT0L4Jp+CUgV9ZIJd1SNUuWToV6zeKPy+uVzPImUZb0x4Qkx
 kOEUB5fSADXFd8OSbxcgOmpL5UYAMaYSMGz9rkcYfEp+30uWrR/hl4b09rwyCxqo
 ahmglKaaTMU+wTuBtI6nkl5QL2LbGOHStO8AlwDXITlBJWdynj/LkNHEqD+UiZld
 RA5aPyTxJxVqxkuqV1x3NloHq5SgJuFxGl6Z1YKGoZW77YsD+sIHQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x8ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD5sgp031040;
 Tue, 27 Jan 2026 15:37:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsh9qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RFbcb030015996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 15:37:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A61BF20049;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AA0020040;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.80.246])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/4] target/s390x: Extract s390_get_bfp_rounding_mode()
Date: Tue, 27 Jan 2026 16:31:43 +0100
Message-ID: <20260127153736.62730-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127153736.62730-1-iii@linux.ibm.com>
References: <20260127153736.62730-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MPTOEqIM3t8vfyf2vasLAyA8y8fMs78y
X-Proofpoint-ORIG-GUID: MPTOEqIM3t8vfyf2vasLAyA8y8fMs78y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX388ftt5dnwNi
 R5OPP5mHSwipBQBnQn5kThT+Tg6YVZGwM3LKD71llMVg3OER9S4F12t23nftLYSPOkw+p6hzCZk
 gGoTBaDragflmY2JmDsF6vhB97jLQf1QVIFQbIm8VF25TxhaJFyO2kNRgWTNRKrG50Tl+2IXz2F
 d++EQShhwdci4rT++xNJ0nqmdL5r8TUd8tCePOq+BF3oCxZsdXPypM/pZF1ksHUdAsHTjqNnB94
 zC8FwA4DCCFEqnuE2xGuqjHXHoGMSM5NbP526uD9xVdJnGdr4Z9EZUeiNNJs319wxjTxf31WGjE
 WlMBHwWEcuVuSqwFmBdMQ7Sh07P3ahrXLX10z+sQ6EXIZGxJOtwlUBaOlbpU14Ntv7e2g/eFm5l
 wOJa95Uwfhd7J3J5zG0V1uiZsVGUHP1nXGzuwa0SM07ucpziNOb1gfbGWhjIJDtvAuF1aYvF9GE
 hZYx2I6VFD+Ogft4bWg==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978dbc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=rpvzK0fK5gZwkPUVIkQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


