Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3ADD73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXOf-0003p9-27; Thu, 29 Jan 2026 14:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOP-0003Td-29; Thu, 29 Jan 2026 14:09:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOC-0003Ao-Mb; Thu, 29 Jan 2026 14:09:14 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TERdR6012527;
 Thu, 29 Jan 2026 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CCvIEN9tc8rLlHpmZ
 NoD8BroPXpZBWqr9pHFwWx1JtQ=; b=Q5ccV0geZfzGME8rSgeI/48EB5BFyYuU6
 uaByuNnMbREm7uBwNk9ac9DP/s48wt1cghruMHG/w0Rtj1Si5pR45PC4suCERaH+
 fyPTA7yRZJ6Wpcg2gl+/rbogmUKUDj/XDuhKin/3AgTHNDMMMNGrOH1mUEQo+SlC
 IKAD2tMJtrenGKAXW+mEzwYyxw+tDT5emwKIUZg69WkH9sZah5TUJEtDmExCVP3H
 XWdY9EAjy38a3cENGdBz9MNky/FqZShpatdfRU6Kbrcl9QHk02cpm1IeqUvedIMw
 XRFSFRoWFxqf9QSvZmfOU8TmevPXDDuZqxvgWwZbsIRg8EeVBPQeQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk7ajbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGSmG4023341;
 Thu, 29 Jan 2026 19:09:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk32xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TJ96LR30474544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 19:09:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A16D20043;
 Thu, 29 Jan 2026 19:09:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A517E20040;
 Thu, 29 Jan 2026 19:09:05 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.137.8])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 19:09:05 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 2/5] target/s390x: Extract s390_get_bfp_rounding_mode()
Date: Thu, 29 Jan 2026 19:57:22 +0100
Message-ID: <20260129190902.196262-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129190902.196262-1-iii@linux.ibm.com>
References: <20260129190902.196262-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w2J9ZWpIVvDxAe6UTLDe090jbz-Xn_Fs
X-Proofpoint-ORIG-GUID: w2J9ZWpIVvDxAe6UTLDe090jbz-Xn_Fs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX83d9BzWsBpVJ
 Mc2dy2Nz28j+SI1cR1Pd99LFcUZ0vhb0wZufaamI6sX9grlWyKU3FP2bMvhc8Nlqs31Jh/caOyo
 /sfxRIETaiKLUqoR0senxCJWMG2e5jPQdr/Jw131TTXpUJfaZdlyP/Hr/EIVA72K5Elye+yo+AD
 qWpK6n33EtgDyqWiWAMAqmRU97IfitE1qr/HhLtjxouU7U5WaT3BevmXrn/EYX8ywDWzi3IkWeN
 H1m/Y/v+raTVfAN2kBDytLLZOzYf9moBS7IczzZ8WQFVbMJMlcZ85zXiN+yAhjrjrQkd5oBKl4p
 9bQ7F8Q+iTLSrNNZdrseSF6CGxDDm8+SR6zKgzDzArf7d3o3D9omQoijAT2d+NjXmUPKQ3FcQzf
 1P924GAKYhjfqzbRrh2p4bmplmptRi1dmvy6W+8Neya/yYu5qpHqpRkPXeRTHei8SOrjnqCxNq7
 Ml3Tw0eJ9w8Il5kUXwg==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=697bb054 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=rpvzK0fK5gZwkPUVIkQA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290134
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

For DIVIDE TO INTEGER it will be helpful to pass final-quotient
rounding mode around explicitly rather than setting it in fpu_status
implicitly. To facilitate this, extract a function for converting the
mask to the rounding mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


