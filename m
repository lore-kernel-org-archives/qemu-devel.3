Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DEAC54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riawH-0007WQ-MP; Fri, 08 Mar 2024 09:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawF-0007Uj-9i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riaw9-0000YC-6H
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709907060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bKtB/YaN3PWPWXFJPdyJ5oWfRF1A7iAjFaT5FFBe6k=;
 b=fTEMrxSnhizFFcI+vPgczQJuuLnjNIUc9eVnlcIyKec8ULzqJWenXNGLVwF0aCr4nS1QVH
 AyuqzQlaRF0SqOHTq4ykPDuC+5vOdbxisG+YbIhC/M2GNEyLKYa31Xba/tofHlhqOv10jr
 NUr9/NsGG1TnBTwzVDCMqm7pw912CBc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-ChqcXAGfOniqWgjkSF2N6g-1; Fri,
 08 Mar 2024 09:10:57 -0500
X-MC-Unique: ChqcXAGfOniqWgjkSF2N6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C0E33801F4D;
 Fri,  8 Mar 2024 14:10:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6D8C492BD5;
 Fri,  8 Mar 2024 14:10:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 2/3] target/arm/tcg/m_helper.c: Include the full helpers
 only with CONFIG_ARM_V7M
Date: Fri,  8 Mar 2024 15:10:50 +0100
Message-ID: <20240308141051.536599-3-thuth@redhat.com>
In-Reply-To: <20240308141051.536599-1-thuth@redhat.com>
References: <20240308141051.536599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If CONFIG_ARM_V7M is not set, we don't want to include the full-fledged
helper functions that require additional functions for linking. Use some
stubs functions that call g_assert_not_reached() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/tcg/m_helper.c | 93 +++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 32 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index d1f1e02acc..d38becd975 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -22,8 +22,11 @@
 #endif
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
+#include CONFIG_DEVICES
 #endif
 
+#if defined(CONFIG_USER_ONLY) || defined(CONFIG_ARM_V7M)
+
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
 {
@@ -58,6 +61,8 @@ static uint32_t v7m_mrs_xpsr(CPUARMState *env, uint32_t reg, unsigned el)
     return xpsr_read(env) & mask;
 }
 
+#endif
+
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure)
 {
     uint32_t value = env->v7m.control[secure];
@@ -69,6 +74,40 @@ uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure)
     return value;
 }
 
+#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_ARM_V7M)
+
+void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
+void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
+void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
+#endif
+
 #ifdef CONFIG_USER_ONLY
 
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
@@ -101,37 +140,6 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return 0;
     }
 }
-
-void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
-{
-    /* translate.c should never generate calls here in user-only mode */
-    g_assert_not_reached();
-}
-
-void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
-{
-    /* translate.c should never generate calls here in user-only mode */
-    g_assert_not_reached();
-}
-
-void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
-{
-    /* translate.c should never generate calls here in user-only mode */
-    g_assert_not_reached();
-}
-
-void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
-{
-    /* translate.c should never generate calls here in user-only mode */
-    g_assert_not_reached();
-}
-
-void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
-{
-    /* translate.c should never generate calls here in user-only mode */
-    g_assert_not_reached();
-}
-
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /*
@@ -160,7 +168,28 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
     return ARMMMUIdx_MUser;
 }
 
-#else /* !CONFIG_USER_ONLY */
+#elif !defined(CONFIG_ARM_V7M)
+
+void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
+{
+    g_assert_not_reached();
+}
+
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+{
+     g_assert_not_reached();
+}
+
+#else
 
 static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
                                      bool secstate, bool priv, bool negpri)
-- 
2.44.0


