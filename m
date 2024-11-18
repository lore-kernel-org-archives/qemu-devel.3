Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7439CD591AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gO-0008CS-9K; Mon, 18 Nov 2024 12:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gE-00086w-0w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gA-0004kq-VC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8ZF0tTQdZBir3IuexxqkPFkW2BBc2tfjP1VYb1K6jU=;
 b=JvIJO6TfnbIBWuyyLTGL8HWtgAgNe5UYtUOICEJkpgTLNDN0JjIHRG4o8mAJB/C4INFi0Y
 KkzRTjoXAOn+aGX/oXhkzUAX7fVs3un/yxuEL+eltO3wQ4uZn3l/iNQeskCrV83i8/b/Wg
 gJy1A4iDZdEWLkdFGDWLDulRygLrK0k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-iAStWBGjNlCsKg_7jD0_LQ-1; Mon,
 18 Nov 2024 12:36:45 -0500
X-MC-Unique: iAStWBGjNlCsKg_7jD0_LQ-1
X-Mimecast-MFC-AGG-ID: iAStWBGjNlCsKg_7jD0_LQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61ACC1955D4D; Mon, 18 Nov 2024 17:36:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9A69195DF81; Mon, 18 Nov 2024 17:36:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 02/12] target/s390x: Fix the floating-point multiply-and-add
 NaN rules
Date: Mon, 18 Nov 2024 18:36:24 +0100
Message-ID: <20241118173634.473532-3-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Order the helper arguments to match the Principles of Operation.
Implement the "Results: MULTIPLY AND ADD" table in pickNaNMulAdd().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241023000147.34035-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/fpu_helper.c     |  8 ++++----
 target/s390x/tcg/vec_fpu_helper.c | 12 ++++++------
 fpu/softfloat-specialize.c.inc    | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index d8bd5748fa..5041c13962 100644
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
index 75cf605b9f..1bbaa82fe8 100644
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
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b5a3208050..9bca03c4ae 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -597,6 +597,25 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
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
-- 
2.47.0


