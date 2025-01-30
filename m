Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20D7C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 11:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSh9-0001ZA-4L; Thu, 30 Jan 2025 06:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSh7-0001Yh-Dj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSh5-0001kz-NX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so7699745e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738236406; x=1738841206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSaUbuyfnLvYbO/DID0qsOMcuNsSrGpZQtfLQrK9hjI=;
 b=GNjXzhqS6ZHMXEjVLrHGwoKsGY2QVYa5c+KZwACyCMuO+dLMkENBlEl0ts7HkkqneE
 JTaFA10JniLOGOBD3/0uuhE9h1ZTL+cIYgErh+3JQ9q/ybRh2lxlWoccZQDlQU6OCUBH
 H+gjRoIzi53a7Qy5UvYASVP+/K63faVu9IXTKWAxwKc5j/cz1kHUbaOsS07SPU1AoleH
 c4cvC6yUNQb+0HKf3KG9NJF7Ijhivxbp7a3V37FbU4/pY+NqDr6jYfFZuNRgDwIO49Dn
 f8GbxfEIIksa351W7ygTCTBKsuWfI9pvr6tqJZCEIvSLR1idZmfB4reFQSpH/6OpKvta
 10+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738236406; x=1738841206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSaUbuyfnLvYbO/DID0qsOMcuNsSrGpZQtfLQrK9hjI=;
 b=DQZNfOmz/GzY+ly1ig4r2Sk05aXlbNrZ8VCwt+DxLBx4FevAj2IihsKUKWASbU5ggW
 OUPKLB+oQGkZAkkGr1nEfHHv7VFVIuHPYiTPnIv0b1zt4dO/KRH6zX2yL78m9tuQsaO/
 gULM04E19F4/WokN70pVmh4y7Uc1M4juVlGaPM+iRX/TqsCoGHXUzsmYrHiCCO9rr4ZH
 PGjGVzxj1DRz6OFRI0d+3J8/gjD/Q0zt2oCedQAzsoNWtjD6HHuqozx4LKzCJQ46goMi
 L2ehRepze7Ym4nRykrI60qsHnzY0CVuZS/9Lfnyix9l+sCYy6tinwKDurH5wHh2zT0dI
 Sd+g==
X-Gm-Message-State: AOJu0Yx+bGQP3rCLdqjZ5lw4DDxERiU5NboMHSB9WDq7krT0EVnVq5gr
 hSeG328mYdVlwu8ZkobOPsA9xwpkvZLJ78CtwlQ56qJwi20DPSKj2OdLa5NfcrT53srw0Gq/sE3
 5Xxs=
X-Gm-Gg: ASbGncvendZYRg4SqW9zldjMjOeCCAyi7Lucpa2KeQlnpALJaobMtpc5BCk7wEpHTzf
 be2Pw5d3ZgZGjXrWW7V4NFrMGdDfIX3aupPDsg0GrZL+ejpcRivuCFq+3lTutZY4vVZBrJxTcV5
 67p9A9QJnZk5L3amqs15vIQOaHpuWETcnNZSinYV6QWSLjb6b/SS0Ma2HTR9UWQXNxJyu4IgA81
 h9sUvNRONZgbUvAoAitJ1m5PXAiNT+PRjriiGqzRPZWB5VlWDYza+Mjg967k98K6t0K8231l3+B
 yDqMRVyUOSgAq/5WgxmXGqGygzkw3ze907UEiENqTW/bcT0E/+gmW6l9uUglmnuX5w==
X-Google-Smtp-Source: AGHT+IFbkJG/aRJqepyrSa16zQltQVMlBfsdB1M9p398BkW2xX5cZUMVB75iY/70NYJrJbxJ8IRagw==
X-Received: by 2002:a05:6000:1788:b0:386:459f:67e0 with SMTP id
 ffacd0b85a97d-38c5194d438mr6926474f8f.21.1738236405652; 
 Thu, 30 Jan 2025 03:26:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b57c1sm1694529f8f.75.2025.01.30.03.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 03:26:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 6/6] hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES()
 macro
Date: Thu, 30 Jan 2025 12:26:15 +0100
Message-ID: <20250130112615.3219-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130112615.3219-1-philmd@linaro.org>
References: <20250130112615.3219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/cpu/a15mpcore.c       | 21 +++++++++------------
 hw/cpu/a9mpcore.c        | 21 +++++++++------------
 hw/cpu/arm11mpcore.c     | 21 +++++++++------------
 hw/cpu/realview_mpcore.c | 21 +++++++++------------
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 3b0897e54ee..d24ab0a6ab2 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -164,17 +164,14 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     /* We currently have no saveable state */
 }
 
-static const TypeInfo a15mp_priv_info = {
-    .name  = TYPE_A15MPCORE_PRIV,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(A15MPPrivState),
-    .instance_init = a15mp_priv_initfn,
-    .class_init = a15mp_priv_class_init,
+static const TypeInfo a15mp_types[] = {
+    {
+        .name           = TYPE_A15MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(A15MPPrivState),
+        .instance_init  = a15mp_priv_initfn,
+        .class_init     = a15mp_priv_class_init,
+    },
 };
 
-static void a15mp_register_types(void)
-{
-    type_register_static(&a15mp_priv_info);
-}
-
-type_init(a15mp_register_types)
+DEFINE_TYPES(a15mp_types)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9671585b5f9..25416c5032b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -177,17 +177,14 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a9mp_priv_properties);
 }
 
-static const TypeInfo a9mp_priv_info = {
-    .name          = TYPE_A9MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(A9MPPrivState),
-    .instance_init = a9mp_priv_initfn,
-    .class_init    = a9mp_priv_class_init,
+static const TypeInfo a9mp_types[] = {
+    {
+        .name           = TYPE_A9MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  =  sizeof(A9MPPrivState),
+        .instance_init  = a9mp_priv_initfn,
+        .class_init     = a9mp_priv_class_init,
+    },
 };
 
-static void a9mp_register_types(void)
-{
-    type_register_static(&a9mp_priv_info);
-}
-
-type_init(a9mp_register_types)
+DEFINE_TYPES(a9mp_types)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 94861a06d94..b56bee6d543 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -152,17 +152,14 @@ static void mpcore_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, mpcore_priv_properties);
 }
 
-static const TypeInfo mpcore_priv_info = {
-    .name          = TYPE_ARM11MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ARM11MPCorePriveState),
-    .instance_init = mpcore_priv_initfn,
-    .class_init    = mpcore_priv_class_init,
+static const TypeInfo arm11mp_types[] = {
+    {
+        .name           = TYPE_ARM11MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(ARM11MPCorePriveState),
+        .instance_init  = mpcore_priv_initfn,
+        .class_init     = mpcore_priv_class_init,
+    },
 };
 
-static void arm11mpcore_register_types(void)
-{
-    type_register_static(&mpcore_priv_info);
-}
-
-type_init(arm11mpcore_register_types)
+DEFINE_TYPES(arm11mp_types)
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 7480b38d1ab..b1408886184 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -114,17 +114,14 @@ static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
     dc->realize = realview_mpcore_realize;
 }
 
-static const TypeInfo mpcore_rirq_info = {
-    .name          = TYPE_REALVIEW_MPCORE_RIRQ,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mpcore_rirq_state),
-    .instance_init = mpcore_rirq_init,
-    .class_init    = mpcore_rirq_class_init,
+static const TypeInfo realview_mpcore_types[] = {
+    {
+        .name           = TYPE_REALVIEW_MPCORE_RIRQ,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(mpcore_rirq_state),
+        .instance_init  = mpcore_rirq_init,
+        .class_init     = mpcore_rirq_class_init,
+    },
 };
 
-static void realview_mpcore_register_types(void)
-{
-    type_register_static(&mpcore_rirq_info);
-}
-
-type_init(realview_mpcore_register_types)
+DEFINE_TYPES(realview_mpcore_types)
-- 
2.47.1


