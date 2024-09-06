Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B715CCD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyZ-0003yS-1V; Fri, 06 Sep 2024 07:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxc-0008DY-9r; Fri, 06 Sep 2024 07:17:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxa-00087s-AN; Fri, 06 Sep 2024 07:17:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B42D8C497;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 283A3133701;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353670 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 39/69] tcg/ppc: Sync tcg_out_test and constraints
Date: Fri,  6 Sep 2024 14:12:48 +0300
Message-Id: <20240906111324.353230-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ensure the code structure is the same for matching constraints
and emitting code, lest we allow constants that cannot be
trivially tested.

Cc: qemu-stable@nongnu.org
Fixes: ad788aebbab ("tcg/ppc: Support TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2487
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <44328324-af73-4439-9d2b-d414e0e13dd7@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 682a05280504d2fab32e16096b58d7ea068435c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7f3829beeb..3553a47ba9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -325,9 +325,11 @@ static bool tcg_target_const_match(int64_t sval, int ct,
             if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
                 return 1;
             }
-            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
-                ? mask_operand(uval, &mb, &me)
-                : mask64_operand(uval << clz64(uval), &mb, &me)) {
+            if (uval == (uint32_t)uval && mask_operand(uval, &mb, &me)) {
+                return 1;
+            }
+            if (TCG_TARGET_REG_BITS == 64 &&
+                mask64_operand(uval << clz64(uval), &mb, &me)) {
                 return 1;
             }
             return 0;
@@ -1749,8 +1751,6 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
 
     if (type == TCG_TYPE_I32) {
         arg2 = (uint32_t)arg2;
-    } else if (arg2 == (uint32_t)arg2) {
-        type = TCG_TYPE_I32;
     }
 
     if ((arg2 & ~0xffff) == 0) {
@@ -1761,12 +1761,11 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
         tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
         return;
     }
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
-        if (mask_operand(arg2, &mb, &me)) {
-            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
-            return;
-        }
-    } else {
+    if (arg2 == (uint32_t)arg2 && mask_operand(arg2, &mb, &me)) {
+        tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 64) {
         int sh = clz64(arg2);
         if (mask64_operand(arg2 << sh, &mb, &me)) {
             tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
-- 
2.39.2


