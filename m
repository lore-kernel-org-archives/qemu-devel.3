Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5FEC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuSp-0007aU-PC; Wed, 21 Feb 2024 16:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSn-0007QF-U3; Wed, 21 Feb 2024 16:49:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSl-0007YC-SV; Wed, 21 Feb 2024 16:49:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 64B414F871;
 Thu, 22 Feb 2024 00:47:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0DD58869F2;
 Thu, 22 Feb 2024 00:47:25 +0300 (MSK)
Received: (nullmailer pid 2339887 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 21/33] target/arm: Fix SVE/SME gross MTE suppression
 checks
Date: Thu, 22 Feb 2024 00:47:04 +0300
Message-Id: <20240221214723.2339742-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
MIME-Version: 1.0
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

The TBI and TCMA bits are located within mtedesc, not desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 855f94eca80c85a99f459e36684ea2f98f6a3243)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 8856773635..d592c78ec9 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -606,8 +606,8 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -783,8 +783,8 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 27838fb6e2..45a93755fe 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5803,8 +5803,8 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6159,8 +6159,8 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6413,8 +6413,8 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
-- 
2.39.2


