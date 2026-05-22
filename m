Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD31CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDRB-00075H-Kw; Thu, 21 May 2026 20:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOx-0003Se-DW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOu-0004rb-1D
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:06 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so6175103a91.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408358; x=1780013158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dgac1OLNcr/FYIR3xDJ+0jIQEEekbcedMFC+8QFpLo=;
 b=IcV2ugn8SqmVwhUb0p/b71RpK9mHzOLRp0I06hHEeFZP2hj7B5l2EpdzWGWdKaTFrO
 KICNawnRQp1ghywLoxNgnBN2C2V79WFu0KtjuaNOH9XoJNbRswUrcv0p8ADXT7hCmlgU
 TzshRSxaNuL+qaUTToh2BaBTSWVjpFmw5UTSzYKebAWKlrFDY4BIp5CbFudCrhVeob4z
 8ayU5psbqY9HESXGdgqUG1d6TxOjP6TULoIf8dwrZNJQuSJEOH8H7df44nXIssTved1D
 q/1xz/TruKGAxESHG9p/ndITq3sGCfmu5lK3KPhKSzkWEokPzq7abrPCfxcBrqTJII3N
 KqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408358; x=1780013158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2dgac1OLNcr/FYIR3xDJ+0jIQEEekbcedMFC+8QFpLo=;
 b=XFqWxuU4opc3TCMUg81P/uoUQikN10XPKv8ONbpzeeg3li49FUwf9vIa1yrM8+zlko
 q9goEpdYG94CanmaN2wDuI0/nE5JrMDfLnV74GF30NgPZ5Z787yHmipRJepzYO81Pz9L
 eyd51puevwxBO6qhi/6euewpUJpQ9ZLVNUqhha0KTT5W2YGL2a2p3eunLcBWqrKsx/pk
 XxFNZAuhq2O3wyyHfhxjarpdE89ZVelH4H9ugruGpn6oX0MOI+BnuHxnhv6TIaRjZb4B
 QcZNVFc6NnyjWqTVDkfwkpD5nyHzgZzixwu+gX1Rheb3VgpVts8JnYfz5jekh786PARK
 piPw==
X-Gm-Message-State: AOJu0Yxk15DQMyBaJFND7+xm+p70XK/iYNff4GgOj/+8XSogu6oVW4VY
 WDRq2di6+WqmH+62RhZUb9YDEc9W76n+PlyXzT7WHxVrA4ufWpKFuhPReTVN+E6a
X-Gm-Gg: Acq92OEad5t/g+BGWc8UIbvd2u+ANyUHzy6hm2aZbIPuFvFjLhP9o++1zHd3Lb1FntU
 MbFPf4jy/AM9R4KrgNo3UwkiwLsC4dCQMsdpookfKB1tnZihUxbPdKoOAFCj8rhsepgwe8YONXQ
 kr4qXQ9MhcefzGGmHXxqVXR1a/LANnVZyGuqZYK4Ro7S6fkPgLdVoWCu8Ku+ImG8LRs8v0AijiK
 s3siHDBEx4z0qZBTli48c3hQwohDZiiDIBedRrynxoMsDwY/ro5hRglT+QAlRBe5pBUuKcustYM
 zNODXeRIuWTAMWLL4HyMFn6jBoy10E8w3d2PAvdslIce1VDwXe7MoADFRQgLtvaVS6L2+W6AYlY
 T4Du5sgT+G+n2yU93BWbE1WOIrBd0cD//JL98/H90dY/EdmXMqvPo2e8xETDRQLTEJUNBQFL/+e
 V25EOeSQ25JNA1Yt/2z4PuhxW7NPfgd+xiM+yj9dcNTw==
X-Received: by 2002:a17:903:390d:b0:2b9:8d39:5e87 with SMTP id
 d9443c01a7336-2beb0657112mr10298995ad.10.1779408357816; 
 Thu, 21 May 2026 17:05:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/48] hw/intc: riscv_aplic: Fix level trigger IRQ in direct
 delivery mode
Date: Fri, 22 May 2026 10:03:20 +1000
Message-ID: <20260522000324.23255-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

According to the AIA spec ch4.7 ("Precise effects on interrupt-pending
bits"), pending bit of APLIC should be set/cleared whenever the
rectified input value is high/low in the both level-trigger mode
and direct delivery mode.

Currently, QEMU APLIC only clears the pending bit when interrupt is
claimed in APLIC, but not clears it when the rectified input value is
low. (e.g. IRQ source signal is low in the LEVEL_HIGH/Level1 mode).
The software may receive an additional IRQ if the peripheral
triggers one after the software clears the APLIC IRQ but before it
clears the peripheral's IRQ.

Thus, we also clear the pending bit via the rectified input value in the
level-trigger mode.

This change doesn't affect MSI delivery mode. Calling
riscv_aplic_msi_irq_update() when IRQ pending is low will do nothing.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260428160103.3551125-2-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8f70043111..791e0b01b9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -591,14 +591,14 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
         }
         break;
     case APLIC_SOURCECFG_SM_LEVEL_HIGH:
-        if ((level > 0) && !(state & APLIC_ISTATE_PENDING)) {
-            riscv_aplic_set_pending_raw(aplic, irq, true);
+        if ((level > 0) != !!(state & APLIC_ISTATE_PENDING)) {
+            riscv_aplic_set_pending_raw(aplic, irq, level > 0);
             update = true;
         }
         break;
     case APLIC_SOURCECFG_SM_LEVEL_LOW:
-        if ((level <= 0) && !(state & APLIC_ISTATE_PENDING)) {
-            riscv_aplic_set_pending_raw(aplic, irq, true);
+        if ((level <= 0) != !!(state & APLIC_ISTATE_PENDING)) {
+            riscv_aplic_set_pending_raw(aplic, irq, level <= 0);
             update = true;
         }
         break;
-- 
2.53.0


