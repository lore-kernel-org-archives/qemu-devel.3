Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D8606A338
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=D2DbMLP9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3MU-0001J1-4C; Mon, 16 Nov 2026 15:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3LZ-0000IX-MI; Mon, 16 Nov 2026 15:30:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3LJ-0001lm-9v; Mon, 16 Nov 2026 15:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=YJJdg60cVgO2nku5RohJMuai4q/eqt+rKkwNN3p2Ehc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D2DbMLP9KeIK0Xho75az7evtbZFmwGCOEQNy9lK66JxUomzNvccbtH6e8sM/ew1b0
 C6XsDZlPjwXyMUV2qOaUTBZQiTM1NUJys0Thnw9/UT0oxsXuwssKwRStp6pUnkZi1M
 S+s6crhBAUtbNun+diTxplfwe3bt+81ziUWE3yoU+v25fy8FoRRlqeL6UrB/GKCKyc
 wG0F0SRr2R0FaLCkRxdRDKzaAzWtIBVhRNg/xIKx/Zkh4GxfJeAk0d8kWEUCmwoRMQ
 vB3rdo1e7iDYwAeB38b695bZj4BN5BJG0icynbcxTWpm1q9ajrJKYvFrmlD6L1a5MX
 tTKwy24erhEHA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FC831E71C2;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B7F345FBEE;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4AF7FB8EA0; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 45/63] hw/intc/arm_gic: do not hardcode GICv2 minimum
 binary point
Date: Mon, 16 Nov 2026 23:25:24 +0300
Message-ID: <20261116202554.535325-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The number of priority bits is implementation defined, and indeed
machines such as a9mpcore and arm11mpcore define it in the
num-priority-bits property. However we still hardcoded GIC_MIN_BPR.

This commit replaces the GIC_MIN_BPR and GIC_MIN_ABPR defs with macros
that read the property.

The calculation is based on "Table 4-47 Active Priorities register
implementation" in the GICv2 spec (page 4-150 of ARM IHI 0048B.b
ID072613):

+---------------+---------------+---------------+
|               |               |    Maximum    |
| Minimum value | Minimum value |    number of  |
|   of Secure   | of Non-secure |     group     |
|   GICC_BPR    |   GICC_BPR    | priority bits |
+===============+===============+===============+
|             3 |             4 |             4 |
|             2 |             3 |             5 |
|             1 |             2 |             6 |
|             0 |             1 |             7 |
+---------------+---------------+---------------+

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4375
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-gic_read_bpr_from_property-v2-1-9f096cce4814@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 43523008040e39044a8fa91d020460f65705a6bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b60f1f630b0..0236f45c3d1 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -479,7 +479,7 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
      * and update the running priority.
      */
     int prio = gic_get_group_priority(s, cpu, irq);
-    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
     int preemption_level = prio >> (min_bpr + 1);
     int regno = preemption_level / 32;
     int bitno = preemption_level % 32;
@@ -521,7 +521,7 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
+        return (i * 32 + ctz32(apr)) << (gic_min_bpr(s) + 1);
     }
     return 0x100;
 }
@@ -1561,7 +1561,7 @@ static inline uint32_t gic_apr_ns_view(GICState *s, int cpu, int regno)
     /* Return the Nonsecure view of GICC_APR<regno>. This is the
      * second half of GICC_NSAPR.
      */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             return s->nsapr[regno + 2][cpu];
@@ -1592,7 +1592,7 @@ static inline void gic_apr_write_ns_view(GICState *s, int cpu, int regno,
                                          uint32_t value)
 {
     /* Write the Nonsecure view of GICC_APR<regno>. */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             s->nsapr[regno + 2][cpu] = value;
@@ -1731,10 +1731,10 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                 /* WI when CBPR is 1 */
                 return MEMTX_OK;
             } else {
-                s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+                s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
             }
         } else {
-            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
             s->bpr[cpu] = MAX(value & 0x7, min_bpr);
         }
         break;
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             /* unimplemented, or NS access: RAZ/WI */
             return MEMTX_OK;
         } else {
-            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+            s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
         }
         break;
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index a7c0763ab6a..fec5662d695 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -259,8 +259,8 @@ static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
         s->current_pending[i] = 1023;
         s->running_priority[i] = 0x100;
         s->cpu_ctlr[i] = 0;
-        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
-        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : GIC_MIN_ABPR;
+        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
+        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : gic_min_abpr(s);
 
         if (!gic_is_vcpu(i)) {
             for (j = 0; j < GIC_INTERNAL; j++) {
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index be923f7ed88..a1f4a2eebab 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -72,8 +72,6 @@
 
 /* Number of SGI target-list bits */
 #define GIC_TARGETLIST_BITS 8
-#define GIC_MAX_PRIORITY_BITS 8
-#define GIC_MIN_PRIORITY_BITS 4
 
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b169394e6ca..db7370a80ab 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -37,8 +37,8 @@
 #define MAX_NR_GROUP_PRIO 128
 #define GIC_NR_APRS (MAX_NR_GROUP_PRIO / 32)
 
-#define GIC_MIN_BPR 0
-#define GIC_MIN_ABPR (GIC_MIN_BPR + 1)
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 /* Architectural maximum number of list registers in the virtual interface */
 #define GIC_MAX_LR 64
@@ -151,6 +151,20 @@ struct GICState {
 };
 typedef struct GICState GICState;
 
+
+static inline uint32_t gic_min_bpr(GICState *s)
+{
+    uint32_t num_preemption_bits = s->n_prio_bits == 8 ? 7 : s->n_prio_bits;
+    assert(!(s->n_prio_bits > GIC_MAX_PRIORITY_BITS
+             || s->n_prio_bits < GIC_MIN_PRIORITY_BITS));
+    return 7 - num_preemption_bits;
+}
+
+static inline uint32_t gic_min_abpr(GICState *s)
+{
+    return gic_min_bpr(s) + 1;
+}
+
 #define TYPE_ARM_GIC_COMMON "arm_gic_common"
 typedef struct ARMGICCommonClass ARMGICCommonClass;
 DECLARE_OBJ_CHECKERS(GICState, ARMGICCommonClass,
-- 
2.47.3


