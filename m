Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D64CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJZz-0006Ga-1Y; Wed, 27 Aug 2025 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZx-0006DZ-5l; Wed, 27 Aug 2025 13:04:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZn-0007i1-Jg; Wed, 27 Aug 2025 13:04:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94BE614C72B;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A431A2698F1;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 09/18] target/arm/sme: Unify set_pstate() SM/ZA
 helpers as set_svcr()
Date: Wed, 27 Aug 2025 20:03:44 +0300
Message-ID: <20250827170356.2698446-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Unify the two helper_set_pstate_{sm,za} in this function.
Do not call helper_* functions from svcr_write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-8-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5c922ec5b136b452fe9d21e7581c99554ce650ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper-sme.h b/target/arm/helper-sme.h
index d33fbcd8fd..d22bf9d21b 100644
--- a/target/arm/helper-sme.h
+++ b/target/arm/helper-sme.h
@@ -17,8 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-DEF_HELPER_FLAGS_2(set_pstate_sm, TCG_CALL_NO_RWG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_pstate_za, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_3(set_svcr, TCG_CALL_NO_RWG, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_3(sme_zero, TCG_CALL_NO_RWG, void, env, i32, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4628b192f9..05e55aaeeb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6469,8 +6469,6 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
-    helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
     aarch64_set_svcr(env, value, -1);
 }
 
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index bbda651974..3b7c6cd317 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -29,14 +29,9 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
-void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
+void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
-    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-}
-
-void helper_set_pstate_za(CPUARMState *env, uint32_t i)
-{
-    aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
+    aarch64_set_svcr(env, val, mask);
 }
 
 void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fa568aa647..9830fe70cf 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1861,14 +1861,8 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
 
             if ((old ^ new) & msk) {
                 /* At least one bit changes. */
-                bool i = crm & 1;
-
-                if ((crm & 2) && i != s->pstate_sm) {
-                    gen_helper_set_pstate_sm(cpu_env, tcg_constant_i32(i));
-                }
-                if ((crm & 4) && i != s->pstate_za) {
-                    gen_helper_set_pstate_za(cpu_env, tcg_constant_i32(i));
-                }
+                gen_helper_set_svcr(cpu_env, tcg_constant_i32(new),
+                                    tcg_constant_i32(msk));
             } else {
                 s->base.is_jmp = DISAS_NEXT;
             }
-- 
2.47.2


