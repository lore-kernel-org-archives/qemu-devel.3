Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E1BCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDRC-0007E1-Gj; Thu, 21 May 2026 20:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOx-0003Sd-DP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOu-0004sD-1k
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ba4a1a0325so42797845ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408361; x=1780013161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewB7oe34ttDo/ekIA9n4ViclSINjIlgVsppzFfFe5RA=;
 b=E42JAlVg0b+2M9vMDFOkY3awQ93uI6DvXCPlpwPGbyj2b7FnvOCljWCePY9FgoZNSc
 t/bXPPbyp5mPk0sbjwnAsnRnUZkndo77BMqDArc/iI9VInvyFIglSkXNqegDgParddTc
 KtHa8p5NeIsYkND5bOLIW3iYapv/q/UrtV7/QOQBwMToWmjMeCbNT8witAA01XhLsjea
 HhNgMyrvyQSXiqzwRw6MhgbsXAMr9cEmuchbkqVw4lhSxbs1v0K2Sz9DpeGzjr1uSNQz
 AM87CtZJbkDyA0k6cbRpiIUZK7cLzvVwXSbSDseOzRDpAISxmQn+F3YQC90QQX/UkTwy
 C4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408361; x=1780013161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ewB7oe34ttDo/ekIA9n4ViclSINjIlgVsppzFfFe5RA=;
 b=MsQs2cw+vd0UUivB9f/9tk0cjona2n3alrX//yPFYFzm0JEkUnNjDYydhotWuncBw7
 6leJfVnrFs9qDD6wJbg82bUwQOSer6IaeXrGrROsz0jofy2Re8ct871LpMz6kaO0A4Hq
 M5WwuDLEhppb6F1vtzceqiie+NKxCfpN/KIrteQXWbvVewoAz9L5fJnu+SBda1+jkamZ
 OtKFBhvcoWOsnOCr7MXmn1pUJ04kw/6173Oi4sCF1WPRpA7RidUEYIPk/548B/aEYsmY
 IcISqWd92IvG9Zlr9ROOY7J0zCs+wPNCLTckiwOugr8pYm7L6PzHBi9uomudVgHwoRMY
 kubw==
X-Gm-Message-State: AOJu0Ywas/y31rxw9fJHzzRkU3XNp9PMQKiA6VEA16n/rQeriUIG/QaM
 7anlqkGeHdRuP/tJtcjCDfCvtdzKPpoQPxKkK+xOnq8Gfo1d3Zrh1PbIcdph3K9+
X-Gm-Gg: Acq92OEeAxmOYyr/rGEsC9hbD2Yq2Hhc0M3RH3QDGkfZpLxkHBnu2IM9FCvEnBUFiOu
 klcksusbNnKYL1s5zJPy4U8QKoKJFqPE/7QQsZ7ZfgIeVhZLiwW3sXu7dPJo2oj0hs/kd505jew
 0jvpfDoAWY8eAJ42jxFOnUnEAJXijL5SXl/zjLyxWNkd1c7cSwZB1BD73jhJDtPAbu8MLPYAPjx
 VMM3YHqugLNUqYBV+KsNlU08KnCyEnr9LMMbt0hz09eINcJEYC/0lYQPbyjAzWsIJa4Vo3C1D3O
 p6Nb9NyWHkQA+twRZiwh77kfTXvr9v6Dtrs++xIgvTbjS2QotY4AbaSkLctmYV0Mi2Xez6FvOGQ
 zer9FBNgqGHQ6Mn8SkTfl5RSAR6T//0zoeMfD+I87fbwCeOKUD8wZPiu74/N4wqPzFZ4+2VTKGr
 Xb3Ta4La/xMN+KR5kNxpPHEx5AygbMcHw34bFRFyrdCg==
X-Received: by 2002:a17:902:f70e:b0:2bc:8ebd:af76 with SMTP id
 d9443c01a7336-2beb03466afmr11280675ad.0.1779408361226; 
 Thu, 21 May 2026 17:06:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:06:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 "Fea.Wang" <fea.wang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/48] hw/intc: riscv_aplic: Add reset API to APLIC
Date: Fri, 22 May 2026 10:03:21 +1000
Message-ID: <20260522000324.23255-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

Clearing APLIC registers and qemu_irq in the reset function

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260428160103.3551125-3-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 45 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 791e0b01b9..a04e0e1a89 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -892,6 +892,44 @@ static const MemoryRegionOps riscv_aplic_ops = {
     }
 };
 
+static void riscv_aplic_reset_enter(Object *obj, ResetType type)
+{
+    RISCVAPLICState *aplic = RISCV_APLIC(obj);
+    int i;
+
+    aplic->domaincfg = 0;
+    memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
+    memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
+    if (!aplic->msimode) {
+        for (i = 0; i < aplic->num_irqs; i++) {
+            aplic->target[i] = 1;
+        }
+    }
+
+    for (i = 0; i < aplic->num_irqs ; i++) {
+        riscv_aplic_set_enabled_raw(aplic, i, false);
+    }
+
+    /* Need to unlock [ms]msicfgaddrh.L */
+    aplic->mmsicfgaddr = 0;
+    aplic->mmsicfgaddrH = 0;
+    aplic->smsicfgaddr = 0;
+    aplic->smsicfgaddrH = 0;
+
+    if (!aplic->msimode) {
+        /* Reset IDC registers only in non-MSI mode */
+        for (i = 0; i < aplic->num_harts; i++) {
+            aplic->idelivery[i] = 0;
+            aplic->iforce[i] = 0;
+            aplic->ithreshold[i] = 0;
+        }
+
+        for (i = 0; i < aplic->num_harts; i++) {
+            qemu_irq_lower(aplic->external_irqs[i]);
+        }
+    }
+}
+
 static void riscv_aplic_realize(DeviceState *dev, Error **errp)
 {
     uint32_t i;
@@ -925,11 +963,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
         aplic->target = g_new0(uint32_t, aplic->num_irqs);
-        if (!aplic->msimode) {
-            for (i = 0; i < aplic->num_irqs; i++) {
-                aplic->target[i] = 1;
-            }
-        }
         aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
         aplic->iforce = g_new0(uint32_t, aplic->num_harts);
         aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
@@ -1014,9 +1047,11 @@ static const VMStateDescription vmstate_riscv_aplic = {
 static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, riscv_aplic_properties);
     dc->realize = riscv_aplic_realize;
+    rc->phases.enter = riscv_aplic_reset_enter;
     dc->vmsd = &vmstate_riscv_aplic;
 }
 
-- 
2.53.0


