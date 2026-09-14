Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E303C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697d-0004FR-Q2; Mon, 14 Sep 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696j-0003FN-5T
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:39 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696f-0004eN-W3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:36 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so1232917f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401632; x=1790006432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kkXdxdxtkGFvjB+esa9le+MPJYdqX0voNJcK0mIKJXQ=;
 b=Y6sflanwI2dM9X9aBUOkpEjHjEdvhmPKEu4CfBgblQ61QVa1c69ciVvhHUxUXFqErt
 zhpzARdVTilxi0JpCuqIcSL6XqjDda/kom8Rby0BKyk7yTc5ElyMuyoee4+aT1VhObyo
 2+AaBOqDzEiIjFhEsgksd6EhE88fsipux3AEU0IUonFna4YKdf2pa56H+UfjhoBQ1QGL
 qx8fVtlqp4dzygeBS9X9TFW191QpVG0wSvke6Z/AIr2ha+OxaxVwPSom5MdhYaO1rzpx
 eJND8htcVn5PviohwrE+K9H8F9n9UG5DzxcEpnXStX0PM2RiWJO9sF2vYYUY+iCglrUe
 WM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401632; x=1790006432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kkXdxdxtkGFvjB+esa9le+MPJYdqX0voNJcK0mIKJXQ=;
 b=jDUKRRf64rG0+WmSGE0bhNbSLF1pvZ0FwppB5vfTJI6P4wN0xk+7D/+30E9tnJ1W8Z
 00KMg6ev2QQoqGDHvkJcRkPeWqAjS0KY2EptnyALI9ts3ptFxK08RZpvHMP0mJioMyAy
 LKmVN6xUjAx31ZzXJ+n9ltRE9gRUbDjY3LlLj9sKWjShEMUyfMMc/4Kx9sYodW6vduFZ
 7d8pXKF+LW5H6pwLqbjQRLBvuvFQOlrRqhXLZiGKJV9mp0QyMeZgkmfDn6YdGRxE7SHE
 kc9c7IQwObUS7okfQEKqX6O3whnfHaM+pp5kxb4EGOIs4qhS/W6uasQmcMEjBol/Eqww
 rgjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl/P9/El28uQHBhDHTRZCOc0Pl8EeZaRZshY/Ck2rJHoOi3ru0ntlYQLrv3Mzhnwqvpnqtjcu9Gkk4@nongnu.org
X-Gm-Message-State: AFuF++lqwkux30Sd0YKSzsR4NqHyLDAW/v5T0aR1sAqeNdp750zUXgWm
 pcXz00SsLABwpnw/yS4cqr3WNkgJZ6XXqpaVDO3C5JnCuhQ+3lpcLO8HFMCw8tCDNsOWnZpJ26E
 1uTfch04=
X-Gm-Gg: AYBFou3MFTbnUJqOIBhOiIo+GUNmsnISO9FnYrKzTyCeeHOr0HjK400ercFhooasQpS
 uHSKdR1qEpHrr3pLv/NnCwCruNbmp66VXxKWI4NGO+paxdx7gBLQYfRlpjaL/G5hxm+Nzy4TZjl
 lVkPgo4KeFwIv6xmQ/HcWTz+WZOvFlbIXRwbfCeW2WsSVoOB4HN5OCGUQJEsXczNhRIgOn9ztFV
 KsIg3vD2ChSuqKB1OmqFq6YwPJico3t1hpm/kbzLkq7ICoAOUHkFWxiqE8orqnPNF1jh0kxmHJy
 wDnzkmwsh0M8PATzJEQeeUYvEGAk4aG/aOK4u8/0ymlST0EQnYzb7vKdnfUx8oYHh1WXoxgvrus
 +V1iqP2CSwFFy3rJynQXc0lJ9epWPvSRTMBQ2TKs435GBVIAdDYCtPIuVHHn1egByK+5qO8TDdD
 q/AWS3v63dKFJjaoLCG/N/sfYtDhl4gejiodUAPBj0XzVHwu2GVo+lSEcHrUoaIEpWp5LDNxrok
 TaHlspPb6sRAikCKq6gyCTEqmWnfosTaUQ+Vi0L5Zlc5+GcIe3LiXgxU8xB7sXy0Pjr11pSmiHL
 nAf8
X-Received: by 2002:a05:6000:4811:b0:487:210:ce1a with SMTP id
 ffacd0b85a97d-48702a9a3f3mr3944754f8f.1.1789401628366; 
 Mon, 14 Sep 2026 09:00:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] hw/intc/arm_gicv5: Free memory in finalize
Date: Mon, 14 Sep 2026 17:00:16 +0100
Message-ID: <20260914160020.327787-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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
index c6914f7310c..6b72870439b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1970,6 +1970,17 @@ static void gicv5_init(Object *obj)
 
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


