Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A5CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoW-0002Y0-Tn; Tue, 12 May 2026 16:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoN-0002R5-5X
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoF-0002T9-BX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso54643215e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618068; x=1779222868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bsNeZkaC7GdaQ5kxXCko2bCs7QLvmjxtM37k/tk14/4=;
 b=XJl6deRlkw5pJaJQVm6uiuOGi0KKE+bsQh6O6p1gP0J0VOqbq+qhsbS2p3we5CtEpd
 3s90j8S1wUeAKUwaAaU33JapGuo6hXt7ikBMltefp/z1l5+WXA7KG3k4fwwppRKURgv0
 nBndViUV+eKm5og1UrO62PGoFYUAMAdDdau0k4nl5Q3SACQXcC5S/6zRvvoXhfnq7BTg
 OGDOpZL1XPvUCrD2lWWqrQEtgK4tb03eu+leu7pgXnUM79jNDtJQrvFDv3gusApbafG0
 dBinp/vYG3yGChtWhD1tKb87xJxmEbgm11+h1S6b4muevb3uJmYluLUiYVtOPkGL8Ll6
 FVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618068; x=1779222868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bsNeZkaC7GdaQ5kxXCko2bCs7QLvmjxtM37k/tk14/4=;
 b=NkGt24yNn0Vl2E1XflL8TZ9myTJjBtmCy8rNBIdUjCrtE4J4wlCBs6/lioU8eW1xac
 luMb1qKWVTyaIe8VBFLGgpu0EBmf6sccH9g+aT7+pncHoIptzGSZOyUTomFG7IPqgamq
 ohauop2bj7mHuGMEVPLLmmFhy4fgRyuW4hBMIdPJjgzcoRr1QQyEjGyyNaDGEKwI8SNX
 1U3nz6LGOKjumJm186MQQJzCbjcqmkMhnM4iWVL7SPj3xHqNXAlP1eguB7zI9jJ7Gtgj
 aifrTyLut16aDG9oN0WVoTsSxpYOfGY5EmKzieLpECZ35uM4Wzw1danD4gHQ7Cr5yYL2
 PJLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZL75POdZ7jOD3qChZWE5Q+pH+4aFYBexysR2liRVMb+Xte9niYn7zQ1vBigVwmCuUrnqPZq2I1WFK@nongnu.org
X-Gm-Message-State: AOJu0Yx3TjEUJMFigKkq5eNNMVm7vGbQIu9O+QO1IoXzEqp5+qr9OMfr
 i41WhtMgut/ACSYwVifIzpmJiqG1ShNMomLCGFr+7YMnA/O4QylkXjGoL97OSmcvuDM=
X-Gm-Gg: Acq92OF0hEGbO7RH5QZ1g12ahu9YMfytOMlMVj3ZeXVVVIUMviGWRVvvYYdZ2iRO4/r
 u23CQ+wWBfCCd6mOoE6ohb6a6v0EUNn26Vz5dfWxOpc5mIzaA6LNaejSOpQBrRY+NAYa2k/ZZjK
 4E/J2GeiGQxniulTT95BeMDyNIbNgIT2B4zkCcSmmGtR16TdnoYZWgqCaNBtsoYmeOHcANCtX55
 pnjOVJ5Fx8sCVt+HosOuiuYJzsyIMz4nqvjkb6QMjz7/6kQpdWqSypl08Dc3Z4X0cb+OQbVfbAj
 LC9ZDZp34CHvANrOtJAqumi5yYCGDADu5472YvmBULxLeMbA2bSrRUVGRbBvA5tolkoc3iNVQAz
 bplJZlG1sikSqhOUWrnZSGznOlxq1YBji4yQlscnZO3TrlMnUNY66WchPJAhB3tgtxIQzecSJ+y
 H482nTb1BHPo7JT6BQ87kTvhtGXayTyLWKX8vIVObrLM286+Xe9CrXs0v2lh8oQ3bMz2BcF47RT
 IN7fkiuSmICOOTHzbgR5DhEtDWlzGA=
X-Received: by 2002:a05:600c:c167:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48fc9a345b8mr5424605e9.16.1778618068095; 
 Tue, 12 May 2026 13:34:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/12] hw/dma/omap_dma: Remove 3.1 mapping handling
Date: Tue, 12 May 2026 21:34:12 +0100
Message-ID: <20260512203414.3633237-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Now we have no 3.2 DMA support, the omap_dma_enable_3_1_mapping()
function is called at reset, and there is no longer anywhere that
disables it.  Remove the function and the unused
omap_3_1_mapping_disabled struct field, and drop the indirection from
omap_dma_interrupts_update() through the intr_update function pointer
to omap_dma_interrupts_3_1_update(), instead inlining that last
function into omap_dma_interrupts_update().

The only other thing omap_dma_enable_3_1_mapping() was doing was
setting s->chans; since this is now never changed at runtime we can
move its setting into the init function rather than reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 52 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index fe43fec58d..b05e46724c 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -106,8 +106,6 @@ struct omap_dma_s {
     struct omap_mpu_state_s *mpu;
     omap_clk clk;
     qemu_irq irq[4];
-    void (*intr_update)(struct omap_dma_s *s);
-    int omap_3_1_mapping_disabled;
 
     uint32_t gcr;
     uint32_t ocp;
@@ -134,7 +132,27 @@ struct omap_dma_s {
 
 static inline void omap_dma_interrupts_update(struct omap_dma_s *s)
 {
-    s->intr_update(s);
+    struct omap_dma_channel_s *ch = s->ch;
+
+    /* First three interrupts are shared between two channels each. */
+    if (ch[0].status | ch[6].status) {
+        qemu_irq_raise(ch[0].irq);
+    }
+    if (ch[1].status | ch[7].status) {
+        qemu_irq_raise(ch[1].irq);
+    }
+    if (ch[2].status | ch[8].status) {
+        qemu_irq_raise(ch[2].irq);
+    }
+    if (ch[3].status) {
+        qemu_irq_raise(ch[3].irq);
+    }
+    if (ch[4].status) {
+        qemu_irq_raise(ch[4].irq);
+    }
+    if (ch[5].status) {
+        qemu_irq_raise(ch[5].irq);
+    }
 }
 
 static void omap_dma_channel_load(struct omap_dma_channel_s *ch)
@@ -294,32 +312,6 @@ static void omap_dma_channel_end_prog(struct omap_dma_s *s,
     }
 }
 
-static void omap_dma_interrupts_3_1_update(struct omap_dma_s *s)
-{
-    struct omap_dma_channel_s *ch = s->ch;
-
-    /* First three interrupts are shared between two channels each. */
-    if (ch[0].status | ch[6].status)
-        qemu_irq_raise(ch[0].irq);
-    if (ch[1].status | ch[7].status)
-        qemu_irq_raise(ch[1].irq);
-    if (ch[2].status | ch[8].status)
-        qemu_irq_raise(ch[2].irq);
-    if (ch[3].status)
-        qemu_irq_raise(ch[3].irq);
-    if (ch[4].status)
-        qemu_irq_raise(ch[4].irq);
-    if (ch[5].status)
-        qemu_irq_raise(ch[5].irq);
-}
-
-static void omap_dma_enable_3_1_mapping(struct omap_dma_s *s)
-{
-    s->omap_3_1_mapping_disabled = 0;
-    s->chans = 9;
-    s->intr_update = omap_dma_interrupts_3_1_update;
-}
-
 static void omap_dma_process_request(struct omap_dma_s *s, int request)
 {
     int channel;
@@ -660,7 +652,6 @@ void omap_dma_reset(struct soc_dma_s *dma)
     s->lcd_ch.condition = 0;
     s->lcd_ch.interrupts = 0;
     s->lcd_ch.dual = 0;
-    omap_dma_enable_3_1_mapping(s);
     for (i = 0; i < s->chans; i ++) {
         s->ch[i].suspend = 0;
         s->ch[i].prefetch = 0;
@@ -1193,6 +1184,7 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
     s->clk = clk;
     s->lcd_ch.irq = lcd_irq;
     s->lcd_ch.mpu = mpu;
+    s->chans = 9;
 
     s->dma = soc_dma_init(9);
     s->dma->freq = omap_clk_getrate(clk);
-- 
2.43.0


