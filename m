Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BEC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JP-0007EF-CD; Thu, 20 Feb 2025 11:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JO-0007Dc-0f
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JM-0008GF-3i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:05 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso840776f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068522; x=1740673322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uwz2abHOq6Tpc30WsDSvabqPG+HP9qCKD5byCw1dL3k=;
 b=pfA2CXJQdNMWCKd0ITi2jo2Y16dR45vTlo/C+y+gbsPnxJ+FHnChoUwaoeefK/h+cr
 cqks9i0l92dxqzbaiVB/PTfs5J30AQ9H74n6my/uckW883W0Wplty0Ma6nDjvls89hoZ
 1EJFMpq555ecc36oILmB6z8y3wpMGjFdvZp/OubTKd+3riyaoOzC69vWN4K54FQHPAt8
 enqH8C70rxuOdoQuPY3JM/bL1uTuJcwjGah7Qrq97c4QQmDZ95/7SuYeTwCSMTGIEsb/
 PCrRiLJ6t4UdGfYRthpc8b6x+KOqBGuoCJxr7arv3gMHKQ4x5FYjLamofiztHyqyNUsO
 3owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068522; x=1740673322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uwz2abHOq6Tpc30WsDSvabqPG+HP9qCKD5byCw1dL3k=;
 b=tPLlFVTd0GwnZlP1cRNagbLupcnjB3pP7wYRL7RGyQqoI2uuReK9rO2oBRiJR3EY3f
 XMFxuyvO8lErg3vumAmcr9R+23QhPt4BhRu5jMM7EGrm5TuBii7fumLyebwEqWwKQUUn
 +0NofHf1LZygQzlrhFbgbGMQH++1+bzMFYaO1LEmjoknRE4/Ag0l2v3Hm2l2W2srUltl
 deWvaiB/YHH7/K39ZFR/Fnt0bVkEkkWbwNiHXtH0SamTdATxgr2usrihxxfY4h0Vn4di
 vf42gPO4zNbsSQvaiTgihxQNQfJ8PhEQyXD3dW4qm7NjJghzq3eVC4PQt8RNgGf2Az41
 1LuQ==
X-Gm-Message-State: AOJu0YyogLvXIaRaVB3O1pgZJVPnCdAkTgLbvbKM9xGinLOCo8piVCJT
 Dge/SFvvKhtBRvT/wwF9s+gxmjsB1zPj7yeAF1b7mpvePNHndTsYPja4bM/bNNs9dSx2RVyNqQH
 x
X-Gm-Gg: ASbGnctesW6Dfdc32+5RldOBiNg5oZIFRh36SFdLTW4rJs/fAtPmKY37OeutNW8gdhQ
 YGjJY3OEkJx2HuFNa5wOC3aTQgFwJcVyIHohqWagZoBjSMHXG9s4X89K94RP2AwlXUNvAFbdft+
 WKgUgHq3jWD8bXAjzqlTUEfEyR/imnfQW3cv8bT602zaPTo9sJRW6ZEEW1UPk5NJs+qn1/+QGmk
 n4AG4UPZLPGI91AssbTCrvoEiDWFCYi/YGRuJHr/1lz2n91McQCljewmJBLbZsvX/yya2OvY6SV
 ei7fcKkfyGsLyARp7J0h6Q==
X-Google-Smtp-Source: AGHT+IFSn5CFSFT46Xacb7WWvFJPDqNkfjMbM7xcGIxzCduZzqcY6dueNHboXhctIm0+PICJWCefAw==
X-Received: by 2002:a5d:6d8c:0:b0:38f:394f:d81 with SMTP id
 ffacd0b85a97d-38f394f9c67mr17200658f8f.2.1740068522494; 
 Thu, 20 Feb 2025 08:22:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] hw/misc: Add nr_regs and cold_reset_values to NPCM GCR
Date: Thu, 20 Feb 2025 16:21:11 +0000
Message-ID: <20250220162123.626941-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

These 2 values are different between NPCM7XX and NPCM8XX
GCRs. So we add them to the class and assign different values
to them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-7-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/npcm_gcr.h | 13 +++++++++++--
 hw/misc/npcm_gcr.c         | 27 ++++++++++++++++-----------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 6d3d00d2602..9af24e5cdc8 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -18,6 +18,7 @@
 
 #include "exec/memory.h"
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 /*
  * NPCM7XX PWRON STRAP bit fields
@@ -53,6 +54,7 @@
  * Number of registers in our device state structure. Don't change this without
  * incrementing the version_id in the vmstate.
  */
+#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
 #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
 
 typedef struct NPCMGCRState {
@@ -60,15 +62,22 @@ typedef struct NPCMGCRState {
 
     MemoryRegion iomem;
 
-    uint32_t regs[NPCM7XX_GCR_NR_REGS];
+    uint32_t regs[NPCM_GCR_MAX_NR_REGS];
 
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
 } NPCMGCRState;
 
+typedef struct NPCMGCRClass {
+    SysBusDeviceClass parent;
+
+    size_t nr_regs;
+    const uint32_t *cold_reset_values;
+} NPCMGCRClass;
+
 #define TYPE_NPCM_GCR "npcm-gcr"
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
+OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
 
 #endif /* NPCM_GCR_H */
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 0959f2e5c4b..d89e8c2c3bf 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -66,10 +66,9 @@ enum NPCM7xxGCRRegisters {
     NPCM7XX_GCR_SCRPAD          = 0x013c / sizeof(uint32_t),
     NPCM7XX_GCR_USB1PHYCTL,
     NPCM7XX_GCR_USB2PHYCTL,
-    NPCM7XX_GCR_REGS_END,
 };
 
-static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
     [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
     [NPCM7XX_GCR_SPSWC]         = 0x00000003,
@@ -88,8 +87,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
 
-    if (reg >= NPCM7XX_GCR_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -106,11 +106,12 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
     uint32_t value = v;
 
-    trace_npcm_gcr_write(offset, value);
+    trace_npcm_gcr_write(offset, v);
 
-    if (reg >= NPCM7XX_GCR_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
 static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 {
     NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+    g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values));
+    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
     s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
     s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
@@ -224,7 +227,7 @@ static const VMStateDescription vmstate_npcm_gcr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -238,7 +241,6 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
     dc->realize = npcm_gcr_realize;
     dc->vmsd = &vmstate_npcm_gcr;
 
@@ -247,13 +249,15 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 {
+    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
     dc->desc = "NPCM7xx System Global Control Registers";
     rc->phases.enter = npcm7xx_gcr_enter_reset;
 
+    c->nr_regs = NPCM7XX_GCR_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
@@ -262,6 +266,7 @@ static const TypeInfo npcm_gcr_info[] = {
         .parent             = TYPE_SYS_BUS_DEVICE,
         .instance_size      = sizeof(NPCMGCRState),
         .instance_init      = npcm_gcr_init,
+        .class_size         = sizeof(NPCMGCRClass),
         .class_init         = npcm_gcr_class_init,
         .abstract           = true,
     },
-- 
2.43.0


