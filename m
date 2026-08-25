Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780EAC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylHH-0002V1-VO; Tue, 25 Aug 2026 03:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHF-0002Q5-JL; Tue, 25 Aug 2026 03:08:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHD-0006Cw-SQ; Tue, 25 Aug 2026 03:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=LpkwcsbUxB2UQwBn83JTotHPX67MYqcRzzSRUZlAwi4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V9g6uFSSwPPmK/ZjDCKVrq3Xfraoem5os2JizYVRqNjg7CHIakUOvkmkTmsOhTAUf
 AQeG6LPJBEaYdKvoDfjprxqxBB9yl3clocEo8NDevbSEzNFs8qrVXlJpWvTeRsdu4M
 bQ49uN1znQmQI1EfCrLoQwmCFVLjvE+ZV8ASf0tZDZntMBre1zveFcAQLTWVyaULWE
 FoHhDVig1TorgJlXfIaxw/joO/5rj0K0pyJwQ2C2c7H7kMEkZu/TsL8jnDBl4qO6V2
 SIm8VsWACPOTbbIIhIa/Ou4oo0Q3NIgDVs1aE+0S4j0imqSb53rFAB5lV6OjJE0yJK
 JRGhE9UbquilA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56E1E1CE225;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1BAD8415FA0;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A36933242A; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 64/91] hw/i386: fw_cfg: do not set VMX feature
 control on WHPX
Date: Tue, 25 Aug 2026 10:05:36 +0300
Message-ID: <20260825070619.174584-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Hyper-V doesn't allow setting this bit on build 26100.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 32452bac6d991e9778dd7a9fb2b3eed3a2b23d71)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d422302c1c9..5903994a7cb 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -13,6 +13,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/mshv.h"
+#include "system/whpx.h"
 #include "system/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -182,8 +184,15 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     uint64_t *val;
 
     cpu_x86_cpuid(env, 1, 0, &unused, &unused, &ecx, &edx);
-    if (ecx & CPUID_EXT_VMX) {
-        feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+
+    /*
+     * Hyper-V in 26100 disallows this bit to be set.
+     * Otherwise a #GP gets raised.
+     */
+    if (!(whpx_enabled())) {
+        if (ecx & CPUID_EXT_VMX) {
+            feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+        }
     }
 
     if ((edx & (CPUID_EXT2_MCE | CPUID_EXT2_MCA)) ==
-- 
2.47.3


