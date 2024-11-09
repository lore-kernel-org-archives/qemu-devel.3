Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65110D5E36A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kKy-0002vn-9c; Sat, 09 Nov 2024 07:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKY-0001T0-0I; Sat, 09 Nov 2024 07:12:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKW-0004bs-2H; Sat, 09 Nov 2024 07:12:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1E32EA160F;
 Sat,  9 Nov 2024 15:07:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D8B55167F9D;
 Sat,  9 Nov 2024 15:08:03 +0300 (MSK)
Received: (nullmailer pid 3295373 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 39/57] target/arm: Don't assert in regime_is_user() for
 E10 mmuidx values
Date: Sat,  9 Nov 2024 15:07:41 +0300
Message-Id: <20241109120801.3295120-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

In regime_is_user() we assert if we're passed an ARMMMUIdx_E10_*
mmuidx value. This used to make sense because we only used this
function in ptw.c and would never use it on this kind of stage 1+2
mmuidx, only for an individual stage 1 or stage 2 mmuidx.

However, when we implemented FEAT_E0PD we added a callsite in
aa64_va_parameters(), which means this can now be called for
stage 1+2 mmuidx values if the guest sets the TCG_ELX.{E0PD0,E0PD1}
bits to enable use of the feature. This will then result in
an assertion failure later, for instance on a TLBI operation:

#6  0x00007ffff6d0e70f in g_assertion_message_expr
    (domain=0x0, file=0x55555676eeba "../../target/arm/internals.h", line=978, func=0x555556771d48 <__func__.5> "regime_is_user", expr=<optimised out>)
    at ../../../glib/gtestutils.c:3279
#7  0x0000555555f286d2 in regime_is_user (env=0x555557f2fe00, mmu_idx=ARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
#8  0x0000555555f3e31c in aa64_va_parameters (env=0x555557f2fe00, va=18446744073709551615, mmu_idx=ARMMMUIdx_E10_0, data=true, el1_is_aa32=false)
    at ../../target/arm/helper.c:12048
#9  0x0000555555f3163b in tlbi_aa64_get_range (env=0x555557f2fe00, mmuidx=ARMMMUIdx_E10_0, value=106721347371041) at ../../target/arm/helper.c:5214
#10 0x0000555555f317e8 in do_rvae_write (env=0x555557f2fe00, value=106721347371041, idxmap=21, synced=true) at ../../target/arm/helper.c:5260
#11 0x0000555555f31925 in tlbi_aa64_rvae1is_write (env=0x555557f2fe00, ri=0x555557fbeae0, value=106721347371041) at ../../target/arm/helper.c:5302
#12 0x0000555556036f8f in helper_set_cp_reg64 (env=0x555557f2fe00, rip=0x555557fbeae0, value=106721347371041) at ../../target/arm/tcg/op_helper.c:965

Since we do know whether these mmuidx values are for usermode
or not, we can easily make regime_is_user() handle them:
ARMMMUIdx_E10_0 is user, and the other two are not.

Cc: qemu-stable@nongnu.org
Fixes: e4c93e44ab103f ("target/arm: Implement FEAT_E0PD")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20241017172331.822587-1-peter.maydell@linaro.org
(cherry picked from commit 1505b651fdbd9af59a4a90876a62ae7ea2d4cd39)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 315591ae79..389fbab3ed 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -927,6 +927,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
@@ -936,10 +937,6 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-        g_assert_not_reached();
     }
 }
 
-- 
2.39.5


