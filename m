Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F732C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKg7-0005Gk-6b; Fri, 11 Jul 2025 16:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKeW-0003Yh-6p; Fri, 11 Jul 2025 16:47:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKeU-0003pW-0I; Fri, 11 Jul 2025 16:47:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3BC0135D0B;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C363A23FF45;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 12/15] target/arm: Fix sve_access_check for SME
Date: Fri, 11 Jul 2025 23:46:27 +0300
Message-ID: <20250711204632.1804872-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not assume SME implies SVE.  Ensure that the non-streaming
check is present along the SME path, since it is not implied
by sme_*_enabled_check.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b4b2e070f41dd8774a70c6186141678558d79a38)
(Mjt: compensate for target/arm/translate-a64.c => target/arm/tcg/
 files move by v7.2.0-1632-gf0984d4040c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 74237ef6f9..7210a9cc4d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1187,11 +1187,8 @@ static bool fp_access_check_only(DisasContext *s)
     return true;
 }
 
-static bool fp_access_check(DisasContext *s)
+static bool nonstreaming_check(DisasContext *s)
 {
-    if (!fp_access_check_only(s)) {
-        return false;
-    }
     if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
         gen_exception_insn(s, 0, EXCP_UDEF,
                            syn_smetrap(SME_ET_Streaming, false));
@@ -1200,6 +1197,11 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+static bool fp_access_check(DisasContext *s)
+{
+    return fp_access_check_only(s) && nonstreaming_check(s);
+}
+
 /*
  * Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
@@ -1207,14 +1209,24 @@ static bool fp_access_check(DisasContext *s)
  */
 bool sve_access_check(DisasContext *s)
 {
-    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+    if (dc_isar_feature(aa64_sme, s)) {
         bool ret;
 
-        assert(dc_isar_feature(aa64_sme, s));
-        ret = sme_sm_enabled_check(s);
+        if (s->pstate_sm) {
+            ret = sme_enabled_check(s);
+        } else if (dc_isar_feature(aa64_sve, s)) {
+            goto continue_sve;
+        } else {
+            ret = sme_sm_enabled_check(s);
+        }
+        if (ret) {
+            ret = nonstreaming_check(s);
+        }
         s->sve_access_checked = (ret ? 1 : -1);
         return ret;
     }
+
+ continue_sve:
     if (s->sve_excp_el) {
         /* Assert that we only raise one exception per instruction. */
         assert(!s->sve_access_checked);
-- 
2.47.2


