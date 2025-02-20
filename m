Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC598C021B4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JY-0007jk-3f; Thu, 20 Feb 2025 11:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JW-0007co-DN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JU-0008HB-5H
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43998deed24so11079855e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068530; x=1740673330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XeyENIoYMBBGcAHARtRQa72CYIFWglA3cPgz+RGqgdc=;
 b=TJ9MiQ1/xd6IHPl30K+cjDz+UbvWyuyfDSmOzFQZI7F4BIVonNfVAM1rh+DXLsZbpm
 BSybV5HCKOvyYpRdlCgWScRnByW08JdAmcp3i2L5nJc006vBwcksFOJzNfzV2YFhVOI5
 mmGwKlfxmzzLF7k5BabxV4YH5I3xKTYLFGyqd/c8Wdj34ai7bmTrkckrX/oayLAjudSF
 ClCjKHFv8U5usg0AWxwsuK6LinGf6Tn39WIe8e89gRoeniDVXrEx/XLUIsMtJsF3BKCX
 br2EVtSVLn6SCgujTghtZtmgC9pelBXPvdL4HYPMsQTRqJIAJkiEenQCOvM3Dr4enkbI
 szBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068530; x=1740673330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeyENIoYMBBGcAHARtRQa72CYIFWglA3cPgz+RGqgdc=;
 b=BmYEG+6M1AQ4Furs71lFfXwscjPRFqLK5nZGidIkr87YIUd++0uXjVRpaPgQasJrTs
 SYSxgMrQgc3sV1a9/OXdzIZ2fOHhsOsc/tanX3CJSZgF8xitDG74x3HBrMgox9druZ59
 wGeGwB9u2aEbpaG8xMxATjR/T/vJza5br2iA+d9AJ/E/OK3c9WFsHzHVGjE4Kn88AZdU
 VqhtpFG5GNbfjdXEmvO3nDykILWKzBuWBN/NQ4iMD9Ex+X2nuuALaWf3dd4kwT6GYOxh
 xt/ELl/I7i1y+0aOYMvitxYHhwO+cXJJbRww8GQsN1i6anHvus/tucPzu7UVhk6wgeMu
 QKRQ==
X-Gm-Message-State: AOJu0Yw2n94BsrDIWY4800pym4cJh3i6n0+lL2KnsHnzjNukSvk/FUEk
 yQD1/FmlBeOYri2Kh1syUJ0AtWHNyc5Q6NT5Sfc4+xeSs9832zcC9hkmDgeIHr13nNPWEjE7FEj
 /
X-Gm-Gg: ASbGncvZoAPURnZ51BbY6LbaSJnlG3yG1c/NAqp28lD+B8Y9XP0Ifj0TNky0Vnh8nAn
 /3VVkByTuaLDO9W4a6a+vjE36OMYw0CsarnX173FU3vMUmQIuOMKBLDYDo4x4YW94StmhcPjNBU
 Jey64nkecwdJJZ77wNxuj0iiDt1+vF931TuLOBSft1fBM0NhUUt+E1dlucbjPEu963QVwWJJi4h
 bfhbbS2UcPDvrrQ0ndpJKtZ1hQUBmuVGeLo2zRwZwYgvDn43sZom3tFYLP5ucQPviM5KrJtPYsN
 xZxUU5Zg+LZEzfaheGB0Rg==
X-Google-Smtp-Source: AGHT+IHh4bETitIRlO/6cztrhxqQnWNhc6VVzv5hKIZ1o5kTJeyah8t7OtSLe5A5RVbt3DbNWQVgCA==
X-Received: by 2002:a05:600c:3c9d:b0:439:5a37:815c with SMTP id
 5b1f17b1804b1-4396e74257cmr200160425e9.20.1740068529788; 
 Thu, 20 Feb 2025 08:22:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] hw/misc: Add nr_regs and cold_reset_values to NPCM CLK
Date: Thu, 20 Feb 2025 16:21:17 +0000
Message-ID: <20250220162123.626941-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
CLKs. So we add them to the class and assign different values
to them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-13-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/npcm_clk.h |  9 ++++++++-
 hw/misc/npcm_clk.c         | 18 ++++++++++++------
 hw/misc/npcm_gcr.c         |  2 ++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index db03b46a52b..f47614ac8da 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -175,8 +175,15 @@ struct NPCMCLKState {
     Clock *clkref;
 };
 
+typedef struct NPCMCLKClass {
+    SysBusDeviceClass parent;
+
+    size_t nr_regs;
+    const uint32_t *cold_reset_values;
+} NPCMCLKClass;
+
 #define TYPE_NPCM_CLK "npcm-clk"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCMCLKState, NPCM_CLK)
+OBJECT_DECLARE_TYPE(NPCMCLKState, NPCMCLKClass, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 
 #endif /* NPCM_CLK_H */
diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 0ecf0df3bbf..78144b14e37 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -81,7 +81,7 @@ enum NPCM7xxCLKRegisters {
  * All are loaded on power-up reset. CLKENx and SWRSTR should also be loaded on
  * core domain reset, but this reset type is not yet supported by QEMU.
  */
-static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
     [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
     [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
     [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
@@ -728,10 +728,11 @@ static uint64_t npcm_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     int64_t now_ns;
     uint32_t value = 0;
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -776,11 +777,12 @@ static void npcm_clk_write(void *opaque, hwaddr offset,
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     uint32_t value = v;
 
     trace_npcm_clk_write(offset, value);
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -870,10 +872,10 @@ static const struct MemoryRegionOps npcm_clk_ops = {
 static void npcm_clk_enter_reset(Object *obj, ResetType type)
 {
     NPCMCLKState *s = NPCM_CLK(obj);
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
+    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
     s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     npcm7xx_clk_update_all_clocks(s);
     /*
@@ -1045,11 +1047,14 @@ static void npcm_clk_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
 {
+    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
+    c->nr_regs = NPCM7XX_CLK_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm7xx_clk_pll_info = {
@@ -1081,6 +1086,7 @@ static const TypeInfo npcm_clk_info = {
     .parent             = TYPE_SYS_BUS_DEVICE,
     .instance_size      = sizeof(NPCMCLKState),
     .instance_init      = npcm_clk_init,
+    .class_size         = sizeof(NPCMCLKClass),
     .class_init         = npcm_clk_class_init,
     .abstract           = true,
 };
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index ec16ea620eb..4e8ce2cb89d 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -215,6 +215,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
         break;
 
     case 8:
+        g_assert(!(reg & 1));
         value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
         break;
 
@@ -270,6 +271,7 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
         break;
 
     case 8:
+        g_assert(!(reg & 1));
         s->regs[reg] = value;
         s->regs[reg + 1] = extract64(v, 32, 32);
         break;
-- 
2.43.0


