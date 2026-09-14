Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8AAC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CKA-0002t4-QQ; Mon, 14 Sep 2026 15:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CK8-0002sV-Ew; Mon, 14 Sep 2026 15:26:40 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CK6-0002rm-HV; Mon, 14 Sep 2026 15:26:40 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hkFWc6YvhzBqZm;
 Mon, 14 Sep 2026 21:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789413996;
 bh=XxwgYaAYLA/mT9oSgpWMCLwsZdkMXri0oTbI+Pp7kD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OG1QoWwfFUBxNGT+JRtwnAlYWzmFwyA1TUe282FsuA4sqevDKq0sI0OnHp6HOk9ff
 0DMih01CM5ilGe5z+IXqc2VXpgzGQXqyLjCoVMNDhOsK7DtxvgRkRdzz93CsdelCDy
 1vh6VtCW8eiMRBybcqjGw8xjoAh+YTqmLgGGsp7YQr1NNNaSHjXwv8MQOpxHKUTxnh
 MGRLc/s6631XBSs43x+mU+lMooYARFex34gVcvQVZFvJNTGK1nzPLm0yE+4+fYMNE4
 LxpeKMmng7u/gwcYC0IL7BD0eYT1susBOJWHGEI1SCjNdoQMdOQDCN1qrVZLvIGH3s
 pxjak9mSSkZuQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hkFWc4vf3z6skd;
 Mon, 14 Sep 2026 21:26:36 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 3/6] target/arm: MPU - limit regs RBAR/RASR A1-A3 to
 Main Extension
Date: Mon, 14 Sep 2026 21:23:19 +0200
Message-ID: <20260914192323.29250-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The alias registers MPU_RBAR_A1-A3 and MPU_RASR_A1-A3 (v7M) or
MPU_RLAR_A1-A3 (v8M) exist only when the Main Extension is implemented
(ARM_FEATURE_M_MAIN). The current NVIC decoder groups the principal
register and its aliases in the same case fall-through, so once the
PMSAv7 path is enabled for v6-M (or the PMSAv8 path for v8-M Baseline)
the aliases become incorrectly accessible.

The fix reorders the case statements for the four locations (read and
write of RBAR and RASR/RLAR) in hw/intc/armv7m_nvic.c. Alias cases are
placed before the principal register case with a fall-through and are
guarded by a test of ARM_FEATURE_M_MAIN. If the Main Extension is absent
the code jumps to bad_offset, causing a read to log "NVIC: Bad read
offset" and return zero, and a write to log "NVIC: Bad write offset" and
be ignored. The principal MPU_RBAR and MPU_RASR/RLAR registers remain
functional for CPUs that implement the corresponding MPU.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/intc/armv7m_nvic.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index b1d27dfb32..51d3dba852 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1382,10 +1382,15 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         return cpu->env.v7m.mpu_ctrl[attrs.secure];
     case 0xd98: /* MPU_RNR */
         return cpu->env.pmsav7.rnr[attrs.secure];
-    case 0xd9c: /* MPU_RBAR */
     case 0xda4: /* MPU_RBAR_A1 */
     case 0xdac: /* MPU_RBAR_A2 */
     case 0xdb4: /* MPU_RBAR_A3 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            /* These aliases are not present for v6M or v8M without Main */
+            goto bad_offset;
+        }
+        /* fall through */
+    case 0xd9c: /* MPU_RBAR */
     {
         int region = cpu->env.pmsav7.rnr[attrs.secure];
 
@@ -1410,10 +1415,16 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
     }
-    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+
     case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            /* These aliases are not present for v6M or v8M without Main */
+            goto bad_offset;
+        }
+        /* fall through */
+    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
     {
         int region = cpu->env.pmsav7.rnr[attrs.secure];
 
@@ -1892,10 +1903,15 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             cpu->env.pmsav7.rnr[attrs.secure] = value;
         }
         break;
-    case 0xd9c: /* MPU_RBAR */
     case 0xda4: /* MPU_RBAR_A1 */
     case 0xdac: /* MPU_RBAR_A2 */
     case 0xdb4: /* MPU_RBAR_A3 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            /* These aliases are not present for v6M or v8M without Main */
+            goto bad_offset;
+        }
+        /* fall through */
+    case 0xd9c: /* MPU_RBAR */
     {
         int region;
 
@@ -1943,10 +1959,16 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         tlb_flush(CPU(cpu));
         break;
     }
-    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+
     case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            /* These aliases are not present for v6M or v8M without Main */
+            goto bad_offset;
+        }
+        /* fall through */
+    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
     {
         int region = cpu->env.pmsav7.rnr[attrs.secure];
 
-- 
2.55.0


