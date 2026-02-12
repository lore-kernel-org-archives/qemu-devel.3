Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A3BEB48E8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSOo-0001hQ-O4; Thu, 12 Feb 2026 03:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOj-0001cm-4W
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOh-0001Nm-KE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1PMvhmU+0X5bb/vrd/ZtltYn0OOHbEDaP+XQQ2cnKo=;
 b=IIbTFJXX/1u+zP90lxUhLE5mis700cAbnCdGCzlVcsxwontZpfAzPfAHPr8LmF1HQkNoFC
 qbtpHcxQlwCdu+FrOuPfx9EsIZOoRr5L7r4V/iv3KyJ/HRDTIh3ps7k+pS1BvvmR82vA9n
 IjFEp5ZHVsFXTGdLYvMTqe2e3ZH7w9Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-UwHeZJTeNTinRg8HVn-2tA-1; Thu,
 12 Feb 2026 03:49:59 -0500
X-MC-Unique: UwHeZJTeNTinRg8HVn-2tA-1
X-Mimecast-MFC-AGG-ID: UwHeZJTeNTinRg8HVn-2tA_1770886198
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BA371956066; Thu, 12 Feb 2026 08:49:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3F7730001BB; Thu, 12 Feb 2026 08:49:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 08/14] target/s390x: Extract s390_get_bfp_rounding_mode()
Date: Thu, 12 Feb 2026 09:49:21 +0100
Message-ID: <20260212084927.258642-9-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

For DIVIDE TO INTEGER it will be helpful to pass final-quotient
rounding mode around explicitly rather than setting it in fpu_status
implicitly. To facilitate this, extract a function for converting the
mask to the rounding mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20260210214044.1174699-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.53.0


