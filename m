Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00E2CFC51E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 10:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcqg-0005Th-Ev; Fri, 21 Nov 2025 20:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbiE-0006z0-6l; Fri, 21 Nov 2025 19:42:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbi2-0007B3-PJ; Fri, 21 Nov 2025 19:42:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4DF1516CA5C;
 Fri, 21 Nov 2025 21:44:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C19E321C98;
 Fri, 21 Nov 2025 21:44:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 33/81] target/microblaze: Handle signed division
 overflows
Date: Fri, 21 Nov 2025 21:43:32 +0300
Message-ID: <20251121184424.1137669-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Handle signed division overflows as specified in UG984:
https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit cfc1d54251d3b4c4cf21c4fa278c8aea2fe25a99)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e44ddd5307..8d92389c48 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -85,6 +85,7 @@ typedef struct CPUArchState CPUMBState;
 #define          ESR_ESS_FSL_OFFSET     5
 
 #define          ESR_ESS_MASK  (0x7f << 5)
+#define          ESR_ESS_DEC_OF  (1 << 11) /* DEC: 0=DBZ, 1=OF */
 
 #define          ESR_EC_FSL             0
 #define          ESR_EC_UNALIGNED_DATA  1
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 0e9b725c1b..bdaf0ca2f8 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -90,6 +90,21 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
+
+    /*
+     * Check for division overflows.
+     *
+     * Spec: https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv
+     * UG984, Chapter 5 MicroBlaze Instruction Set Architecture, idiv.
+     *
+     * If the U bit is clear, the value of rA is -1, and the value of rB is
+     * -2147483648 (divide overflow), the DZO bit in MSR will be set and
+     * the value in rD will be -2147483648, unless an exception is generated.
+     */
+    if ((int32_t)ra == -1 && (int32_t)rb == INT32_MIN) {
+        raise_divzero(env, ESR_EC_DIVZERO | ESR_ESS_DEC_OF, GETPC());
+        return INT32_MIN;
+    }
     return (int32_t)rb / (int32_t)ra;
 }
 
-- 
2.47.3


