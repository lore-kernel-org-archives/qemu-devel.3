Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1EFCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY35-0006qb-81; Tue, 13 Oct 2026 04:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY32-0006oo-Qm
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY31-0007Zl-7M
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so22009505e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880786; x=1792485586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CdqM6HYBiDR7dqKjxvWd0m8Z09BAdsUWKaoEl5skuzI=;
 b=kGH8ItLCqyxZgFSl6LC7SLiS0Dfr9SMYdt7TL3C2RNc1f9x7xJeD3pfNX454KSFa2t
 wsGtqW+Tzxd+ftFa3xN+0ZQuQEDix0hjk2eJiLIWSvLTXYnYf/1vJCIJLh293ush4k26
 kzILFDgtrhEimzP6rz1c23CecpIJzdGKPnwL3oZHLFSYLknkG/cKsmMSsfwXzJxeGRa9
 IwHFLwMvNMEbP+rwhy8X2vM9tDQPPC89oKztiFhCr6hWagLvKORErvNg0W53QNjJkxuJ
 iBhLJtnbV7MEsniehemJN1swRkvnfUu1u2C4GvuEyqAWUF51TOlJML058JFaiQd9NA5N
 WTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880786; x=1792485586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CdqM6HYBiDR7dqKjxvWd0m8Z09BAdsUWKaoEl5skuzI=;
 b=dLIgmNzHdjEam3LSlmlVUbhgGAMqK+mYmfCkqFbDa+KrirVblJhN2x1MA914Nm9ijL
 +Z1/YxiZQ7qhHiEl43qQsbG8zT+sGKCqbmawZDhEvTFJ2gERlfTQbeQHKGYrzVzkCJvr
 fbPo6VfuNPNw3VNFx69Owqc8BeJXPxWH6MocpvsqN7y/OmvjRePjLmxGMzd9+1B474Bb
 /oHv0kR4EjyzRKiLFgti9bwl6ZMn6ZvEzZ9w2PRImDuNTNASm0L0ryH6OmhTgdZeP8DT
 fBmHsz2osRV8YhC7YIzomUxqHGxQN0Wfgr2k1RXsB0cLLGI0Tg+IZqOyj4F8HuOn6AsY
 sFMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/QVvKvSykl6KVysTX0wnbZPSZ1Bi1xUK2mHSw5CFLH7dQsTJewQBdRWLwDHY+K3EKwx7ARI3Nhx3I@nongnu.org
X-Gm-Message-State: AFq9FYIA/GjYmiqu1JiY/LMiblJ4BX0FNufU8zIBfm+xLlneEaWYWCcp
 kQkbh8ZTZvf6hHHe3oDpqyUEDVpeCbdmlzl6X0vfz+Ei544Yb5MoUaEqFyu93JF5X7s=
X-Gm-Gg: AYBFou2Ii4u0PLGR79MJ38ZNYMzFWmZTnYp8Gh90RwDv455NvP6EnV8GXnjkdr3Sleo
 R1kXju6uW5wirKnbYW9Wd8WqmtDAv0or7F5HXluzF+56HMYQpDSY2hbjzwu4Kl/9lAYw/6tz/0A
 g+7opTy05lxhHTdKw0YVAovG70qkAqnqywoNW0W2G69B8k5GGR+tyr3lj1yCx1hmobjLgNc90bZ
 uQyogXVNuUlkn0zMCYDNU093yKUfpGTuTbyQtfsvNK+6NClLxg+19zKWqArnOmH60tWfbRrzkLH
 0Zy+ilSGZaVvbDdsAVsxr0W6PoKLbs9e2W/8ENG7UvypZ/gdAR2L4/Vm6Lf2XWlqJQjSv/DEnLT
 DpIK1A6lLvS3AsKD80xaNyxWY6799btZhXyYZoJ7MmLZACvEMs0O/jpn6ASdjWD0JcebL6OIVpm
 H34WsbBdvnZ9TH0T73rjRDjMS27qjk4QO2K2EJYcQgvSsSbYM7ESOeTi3jxWhvAUpRMGSVLmF+b
 2O8l4vC6CPlKWVwkXaGm18Jeh3+5fgFoF8o2G28anwV4ZXuCNg7Jrjzwl1NlKDIVCK50RwffgQL
 JbIS
X-Received: by 2002:a05:600c:4e89:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a18e4ac77amr257836635e9.30.1791880785675; 
 Tue, 13 Oct 2026 01:39:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/86] hw/intc/arm_gicv5: Free memory in finalize
Date: Tue, 13 Oct 2026 09:38:13 +0100
Message-ID: <20261013083933.1024405-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The GICv5 allocates memory and creates hashtables during realize and
as part of its operation.  Free those resources in finalize.

Since the GICv5 is created at QEMU startup and remains in existence
for the lifetime of the process, this isn't an in-practice leak,
only a theoretical one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c        | 11 +++++++++++
 hw/intc/arm_gicv5_common.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index ca5c3ca6e03..ecafb4838ab 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1971,6 +1971,17 @@ static void gicv5_init(Object *obj)
 
 static void gicv5_finalize(Object *obj)
 {
+    GICv5 *s = ARM_GICV5(obj);
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        GHashTable *ht = s->phys_lpi_config[i].lpi_cache;
+
+        if (ht) {
+            g_hash_table_destroy(ht);
+        }
+
+        g_free(s->hppi[i]);
+    }
 }
 
 static void gicv5_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b155486af65..cc67246686e 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -112,6 +112,9 @@ static void gicv5_common_init(Object *obj)
 
 static void gicv5_common_finalize(Object *obj)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
+
+    g_free(cs->spi);
 }
 
 static void gicv5_common_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


