Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18682D2CDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 00:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OpN-0004jR-Vo; Tue, 22 Oct 2024 20:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpK-0004hk-GL; Tue, 22 Oct 2024 20:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpH-0004QK-2A; Tue, 22 Oct 2024 20:02:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLoAxF029973;
 Wed, 23 Oct 2024 00:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DE9fEl2MbyBjyVKLI
 LKN31Xn9Ht7J9RVPieuaoHEzW8=; b=GYIEj75HiJt2DO1zLNbavefSruAxxUlQT
 uPQ52fgtcS/hfsSaZlXivXs5561x8CUFy2IyPd+qrVxOsQ4RXSSmjGBrvtpzRm4k
 Jv3QUh/TzbZZDoIqJss5bJ+Ts4jWswa9dNrdEtIhTTmshH0tetqWGA78JAUMZTXO
 GTLnv2l/uRsfQEEkkoOtRbtn4xMTdvLSb1rISvlZksnLzCmt1Ev8DK/lGb0u5ywR
 myebGPY5iWYXaMykdeI118ud1924BV9q6qyx6d5KGD0oVI2oHtCqFDpb2UGjL/9c
 shwjttxX36Lod3JdN4OIzOLjZBp2sWS3l32MrJIS2wCnvqiNnLY+Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafgcqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MM4mGU012603;
 Wed, 23 Oct 2024 00:01:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhf8bje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49N01pot54133056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 00:01:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3188F2004B;
 Wed, 23 Oct 2024 00:01:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2D3720040;
 Wed, 23 Oct 2024 00:01:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.26.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 00:01:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] target/s390x: Fix the floating-point multiply-and-add NaN
 rules
Date: Wed, 23 Oct 2024 01:59:18 +0200
Message-ID: <20241023000147.34035-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023000147.34035-1-iii@linux.ibm.com>
References: <20241023000147.34035-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w3SJlgp944AJTwX0UJ1o7nvO48_mO1nC
X-Proofpoint-GUID: w3SJlgp944AJTwX0UJ1o7nvO48_mO1nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410220154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Order the helper arguments to match the Principles of Operation.
Implement the "Results: MULTIPLY AND ADD" table in pickNaNMulAdd().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fpu/softfloat-specialize.c.inc    | 19 +++++++++++++++++++
 target/s390x/tcg/fpu_helper.c     |  8 ++++----
 target/s390x/tcg/vec_fpu_helper.c | 12 ++++++------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4e279b9bc40..62197373c93 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -635,6 +635,25 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         float_raise(float_flag_invalid | float_flag_invalid_imz, status);
     }
     return 3; /* default NaN */
+#elif defined(TARGET_S390X)
+    if (infzero) {
+        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
+        return 3;
+    }
+
+    if (is_snan(a_cls)) {
+        return 0;
+    } else if (is_snan(b_cls)) {
+        return 1;
+    } else if (is_snan(c_cls)) {
+        return 2;
+    } else if (is_qnan(a_cls)) {
+        return 0;
+    } else if (is_qnan(b_cls)) {
+        return 1;
+    } else {
+        return 2;
+    }
 #elif defined(TARGET_SPARC)
     /* For (inf,0,nan) return c. */
     if (infzero) {
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index d8bd5748faf..5041c139627 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -780,7 +780,7 @@ uint32_t HELPER(kxb)(CPUS390XState *env, Int128 a, Int128 b)
 uint64_t HELPER(maeb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
-    float32 ret = float32_muladd(f2, f3, f1, 0, &env->fpu_status);
+    float32 ret = float32_muladd(f3, f2, f1, 0, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
 }
@@ -789,7 +789,7 @@ uint64_t HELPER(maeb)(CPUS390XState *env, uint64_t f1,
 uint64_t HELPER(madb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
-    float64 ret = float64_muladd(f2, f3, f1, 0, &env->fpu_status);
+    float64 ret = float64_muladd(f3, f2, f1, 0, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
 }
@@ -798,7 +798,7 @@ uint64_t HELPER(madb)(CPUS390XState *env, uint64_t f1,
 uint64_t HELPER(mseb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
-    float32 ret = float32_muladd(f2, f3, f1, float_muladd_negate_c,
+    float32 ret = float32_muladd(f3, f2, f1, float_muladd_negate_c,
                                  &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
@@ -808,7 +808,7 @@ uint64_t HELPER(mseb)(CPUS390XState *env, uint64_t f1,
 uint64_t HELPER(msdb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
-    float64 ret = float64_muladd(f2, f3, f1, float_muladd_negate_c,
+    float64 ret = float64_muladd(f3, f2, f1, float_muladd_negate_c,
                                  &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
index 75cf605b9f4..1bbaa82fe8a 100644
--- a/target/s390x/tcg/vec_fpu_helper.c
+++ b/target/s390x/tcg/vec_fpu_helper.c
@@ -621,8 +621,8 @@ static void vfma32(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
     int i;
 
     for (i = 0; i < 4; i++) {
-        const float32 a = s390_vec_read_float32(v2, i);
-        const float32 b = s390_vec_read_float32(v3, i);
+        const float32 a = s390_vec_read_float32(v3, i);
+        const float32 b = s390_vec_read_float32(v2, i);
         const float32 c = s390_vec_read_float32(v4, i);
         float32 ret = float32_muladd(a, b, c, flags, &env->fpu_status);
 
@@ -645,8 +645,8 @@ static void vfma64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
     int i;
 
     for (i = 0; i < 2; i++) {
-        const float64 a = s390_vec_read_float64(v2, i);
-        const float64 b = s390_vec_read_float64(v3, i);
+        const float64 a = s390_vec_read_float64(v3, i);
+        const float64 b = s390_vec_read_float64(v2, i);
         const float64 c = s390_vec_read_float64(v4, i);
         const float64 ret = float64_muladd(a, b, c, flags, &env->fpu_status);
 
@@ -664,8 +664,8 @@ static void vfma128(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
                     const S390Vector *v4, CPUS390XState *env, bool s, int flags,
                     uintptr_t retaddr)
 {
-    const float128 a = s390_vec_read_float128(v2);
-    const float128 b = s390_vec_read_float128(v3);
+    const float128 a = s390_vec_read_float128(v3);
+    const float128 b = s390_vec_read_float128(v2);
     const float128 c = s390_vec_read_float128(v4);
     uint8_t vxc, vec_exc = 0;
     float128 ret;
-- 
2.47.0


