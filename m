Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D95C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRuv-00038N-S0; Mon, 24 Aug 2026 06:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRue-00035H-M4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuc-0001qY-3F
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so30369305e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567295; x=1788172095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b+5usmdHTznNDEGIvxe7BfpQfxtTJ2JOpHQUhBK8vMo=;
 b=w3mvN03ARCLvrNmd23e/mOgJy/W2F6n+D2sCffkhDL7X3BZ+w065hHVsbQwKGOAHLT
 PV8mmU5Ycyo/QDEq2aGFSmSiy+WAaJUXLThQVvmU8aQNyIiSsc2aHXj0yck8YbbnwJ8a
 VQeinUCWjOnpWtzQCLd9BqiVdKHA5eHvVs294OM/RSxAovMcA+gUJxp8mNxdIqSLAcnr
 UQ/NPFVSNUyw/I6rHZ5lemBxEUI3ayDq7DljWh4zrnzkvgwBn0KtGb0weBxDS+WpThi+
 YuWCFS7s5P3qoqr9MLzIcfZ0llrZL1L9LdF8RY3t/29HhfNhxLwG8mdyw/YKUS+RirN4
 X49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567295; x=1788172095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b+5usmdHTznNDEGIvxe7BfpQfxtTJ2JOpHQUhBK8vMo=;
 b=WuhiFKG9wmjonoBtaHoV74rfdwnR3CTkzhm6P85l6lSc0PKkGc0togAEAMXGnpJDJ4
 K9jIbWBzuwnA1yH59+gmnXt22OrBzM7ui9TFhnkcRomRBZAL4QCbHLl96OLcC+9YNTc6
 LvB/fk7WBRuU1Cs7xVP8D9Mw/xkN9NherH1Kf+4+39otpgZWAkMc0/hcoKXccsp1lijs
 pv8pA+hvUdspXyJsx6avouNtYRtMvg8A1glGxDMzTdzn3KV4C+QN7G+6RWtTUq+jeNfC
 hsZNV9QAot9eB6DI3f/8WgcK/W5cfN0716dIgqdDcbX4Iog+3s9TFfOGIsfu3jc7dmGS
 Vr7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq68Q73FnsrcOBfd0SS2SnDt9Xj2aDPuiXxFraDm6S+wwDkRHH5+a4AGTfpJHk8DkuvMcglrFqG4gn6@nongnu.org
X-Gm-Message-State: AFuF++kpxp4QgyCfNKzeb1YeT5R2WL7oPvsIc9hhEFM5hrktaPXZKiCB
 yYKWEk2qlUXszpmkzOh5RmQY8TIRy4w4ss5PnhAJ7u37zU1oKizUG0GWW+asU7lgCXogbY0z8x4
 O/M9AllI=
X-Gm-Gg: AR+sD11AL3KXyhYB/DlTvoIaOcuExNmE+zNCI/x1giDPimh2V1Mu7JIlCwHlpEqw/MU
 bcmpaRaI0unJ1EaRXGm1W4jqJjCICOZTdxejt4XgisoUBvfxkV4Bu8iUsGQz2Uf2OMdUuHca1J0
 5SvPeTUTkIyXFcYdVlFGsp4MDs1ygMBL4/AN4hGRj71J2BxQqdtlIX7a1HOE9vjFHNKDXQOKu8n
 7GUJy4IMKrUuA3o+1xY2wXKmX6hRRtLMtPko5+uJoy8z6sTJm6xeI/09xXNc1KvVTB6fbv74/S9
 ysczsVX8x3X+0a38RPedapwyAdZEzgRlyM1O2ID6gAVEQ724C8BptclOMR9OskbXOo7SJC9BrJx
 IsvG88E7HRvOf6MP7sCsAf0xZ6j9gKHJS0GGslDLdA+WLTBG8Hq0N0jgda3xl0xD0e893TBaOK5
 iysW6OeOJh5MSVuYEfa8HO7MZq58O6WMwtb5rpJrJJ9U04y67/YXdiEptOva2wKM0iL2O5oX6zL
 x/bu/UkKKChjh+4paIGMArpd6Q79J+bP1OZmRn0VHAYZ5P+Fe2ooY8vT3y3G0d57MJfwQ==
X-Received: by 2002:a05:600c:1383:b0:499:84fe:ca8c with SMTP id
 5b1f17b1804b1-499b830dd98mr278303945e9.5.1787567295048; 
 Mon, 24 Aug 2026 03:28:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/intc/arm_gicv5: Free memory in finalize
Date: Mon, 24 Aug 2026 11:28:04 +0100
Message-ID: <20260824102805.639072-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102805.639072-1-peter.maydell@linaro.org>
References: <20260824102805.639072-1-peter.maydell@linaro.org>
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
index 8ffb2a49020..de0044df9c6 100644
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


