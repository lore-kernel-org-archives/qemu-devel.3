Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D631DC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Wda-0005Y3-S5; Tue, 15 Sep 2026 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdU-0005TM-7G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:00 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdS-0003Xp-5Y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:59 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so308105e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492077; x=1790096877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xjL05zRKIjgIZnaMYrtg7DzJZaQ9HoxCeRBWw/WDV5g=;
 b=txfYRSTdBYFnP8/u6oPOw236gVa2F8dHKarqNHxO5tPC4cJJzGVVbtPBAOpf87L/gs
 1WxiD4cr99fUaq5hWH5dm4qdPLFc2BGOucePlUxpXQCK6nx/aA00dqNPjTwgcwQ9xPAn
 H0rQNR39g6uCVqQbJyO3fwaf5/i+wEi7hEbdkCko5oqAhc2iOOYPdCRDJAmV2EuoWK0M
 WOexwyIODikjAKAIcFRTSNVdbkdyhYgYGbjPmGNNI780LSaaCO6+ZyyRKcHTHiRBn9ik
 TD9C2WfpyGeOCZhECvzCWaDgfo7uGlRzAW7qhRvjsrMdCzowfzPc/dhyGN4+f9giUMeo
 dhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492077; x=1790096877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xjL05zRKIjgIZnaMYrtg7DzJZaQ9HoxCeRBWw/WDV5g=;
 b=N51NLkCTSzOSnAiX1WLhiKbx/AFW+ebcHCSfTsIfvBLA9KKZvcFMbtZfeqIYI56BtR
 oZA349/zIaX3PokQkfxwes/I6OzKgzBDVLHqsGuogypI0Le2MXh+X5lwSF8oGSzwK4UU
 hGcohjK+Yxn+7x58ecO4Od+m047inq7zzqAeXyol9SC/BjDMyRhEm5qcnDjAr6prX7Yv
 +k09gdjqmT0qwLf/Yitiq4x7ABx0uAyNLhkGtPdbHM9Epu2KZODfV3S4kzFtMmH5VMvI
 mnFUcHi9rwSkzxjEBYhgrrb4ziyAmSwK1HnZjCPYPE22DKURQPk6jLC8zVmXflNh0pri
 JUVQ==
X-Gm-Message-State: AFuF++ktTp9tBMeuVZ8IJQnIcV6sr3vwVRinnz4/7v9PmQqYZuKXJ3JF
 voVFb1RLBy1oIORmL9hLk5i65xikXwqYSPEBhx8dhQ4H5KMwWZobjsI1IOGpQyOnamZGECUPCs4
 Lt5LkTnc=
X-Gm-Gg: AYBFou3BcDKFgMWDDLugqKFWyzmGh9e4trfbt4u+OOyXJiJ6m3XBFuilcsfXMYZIZPV
 eqZ68JRRNJccjLaJg7FzLk1BEQsPlzRX+c0E6kHb38zM1SfEdFFI/H+yOwiIgMYcJvOQZtQFAGY
 QnB5W2oZW4Iucx5trOXtsgZ3KvxWIvOJu7ppa6GSYQCm/fZGrkWJhVyRKo2h3Brc+sdh6GNbnj2
 oD8Gss/GqIifJ1BBt78rpc0BbZOqpTTO90slgzfm6lXiXuBtzraDkOoGM0VaxHYoTVBLVuvay/G
 0Z2JRdOeSHGRxgU8D47CO5Zspw34/l8hGjjt6cHRlMCEvcHsRRVhMYZEoRF4JNmvTwneeDDIIWT
 PMxY3HPMJW5OyxeUbdzInoG8dN43KviA/E8ntQf8FsjzT8regg5FPlwxeermYZapeUmVNQbWHul
 N3foEarKwXgIt0ws0cARoCfaRWF4R5QnOGn9zA32s5RfpYox1maH8xejlSvEXFcsHm4eJ0oZmHl
 36HJZMnA5cC6w0v0kR4UQzHKv4O9U70nTzj2TeM+20wMuKLvI3As62VCHVGGvG2gm2qoLooWDG9
 PdPc
X-Received: by 2002:a05:600c:3548:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49e822a8fccmr23207045e9.26.1789492076772; 
 Tue, 15 Sep 2026 10:07:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] target/arm: MPU - limit regs RBAR/RASR A1-A3 to Main
 Extension
Date: Tue, 15 Sep 2026 18:07:32 +0100
Message-ID: <20260915170735.425445-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index b1d27dfb32d..51d3dba8525 100644
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
2.43.0


